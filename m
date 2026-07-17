Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D943264D1;
	Fri, 17 Jul 2026 05:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784266174; cv=none; b=uCIOWmiv30Y6tOlcjgVP2UibHiuhgruzSKqERDfnguxVow9Bkbb+e7ndiDl1R4WxW2u6UAnQub+3u9Cjch0NJEJDksIJCIPC26+cs3wMqXmnqu49CTWSZFx+cPusxxrH2wTbj69pky5yepaztGMxsTFMrzTHCt1iXKXpi6J6H5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784266174; c=relaxed/simple;
	bh=avMCZV4Ra+Fo2JV4wScbZKbb3IsntCrwy/ytBNBHNGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uw8SyR0f1twtRikK/hWrdQ5FFt2XXsg+YPnxN9uNkGcF2Xoz2IrIbGdnxbocgKm4jwn7/kpI2hNLX/P1ZKa5k7x3Wn3UW9SZ3TOcJ+8O/iPIvL0vH4aeJ+9KU395BuPgzkAwd66E8DZ4UPvNMdDQxKxE7PofVX/iox6U27GMR+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=itDqfH/l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="itDqfH/l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C521F000E9;
	Fri, 17 Jul 2026 05:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784266173;
	bh=+uYDOHm1X9jhXzTi8AHfVmPLyE+IUY6UUahEDxuLJw0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=itDqfH/lLaNqT4PbjqlvIPROQmS8rk9oYSBR2FKJjtvSYGW5P6AA7JaltrZ+dPrrU
	 VLSJGqTw8rIyGxjiuU97UKjN1mF8Ay4mEW0QPEo1fUZnaB2g+A6NuYW9SO2gQAujz8
	 HNr0FchqY6azEdO5dY3YQJbg7Dk64sj4mx2mlwHWgnBH4VMO7WLMMCLFHDUUcXjrnP
	 jCgVf0k0hhPFQzvU3Q/LAlu+dIWMHz9YyYsDQsf/+nHTJBk9KHeqj9tAhbeHC9H9uq
	 JPwwrR65gxsQQKF60qMNhsBZiKltfQdfaXoi8cQI2zfHR65WhswVDt9lUAqA5C/Dtj
	 y1UlwvVrYkv3A==
Message-ID: <058e077d-acdb-4b86-8499-82b824759f08@kernel.org>
Date: Fri, 17 Jul 2026 08:29:29 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/10] media: microchip-isc: fix WB offset and gain
 register field masking
To: Balakrishnan Sambath <balakrishnan.s@microchip.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Hans Verkuil <hverkuil@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260629-balki-isc-prefix-fixes-v1-v2-0-3b120cc3742f@microchip.com>
 <20260629-balki-isc-prefix-fixes-v1-v2-10-3b120cc3742f@microchip.com>
From: Eugen Hristev <ehristev@kernel.org>
Content-Language: en-US
In-Reply-To: <20260629-balki-isc-prefix-fixes-v1-v2-10-3b120cc3742f@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/29/26 14:09, Balakrishnan Sambath wrote:
> ISC_WB_O_* and ISC_WB_G_* pack two 13-bit fields per register. Sign
> extension from negative offsets corrupts the upper field. Mask both
> fields to 13 bits before packing.
> 
> Fixes: 91b4e487b0c6 ("media: microchip: add ISC driver as Microchip ISC")
> Cc: stable@vger.kernel.org
> Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
> ---
>  .../media/platform/microchip/microchip-isc-base.c  | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/media/platform/microchip/microchip-isc-base.c b/drivers/media/platform/microchip/microchip-isc-base.c
> index 1a9b97edfa32..79a58efb6333 100644
> --- a/drivers/media/platform/microchip/microchip-isc-base.c
> +++ b/drivers/media/platform/microchip/microchip-isc-base.c
> @@ -62,18 +62,24 @@ static inline void isc_update_awb_ctrls(struct isc_device *isc)
>  
>  	/* In here we set our actual hw pipeline config */
>  
> +	/*
> +	 * Offsets are 13-bit signed fields [12:0] and [28:16]. Cast to
> +	 * u32 and mask to 13 bits so sign extension of a negative value
> +	 * cannot corrupt the adjacent field.
> +	 */
>  	regmap_write(isc->regmap, ISC_WB_O_RGR,
> -		     ((ctrls->offset[ISC_HIS_CFG_MODE_R])) |
> -		     ((ctrls->offset[ISC_HIS_CFG_MODE_GR]) << 16));
> +		     ((u32)ctrls->offset[ISC_HIS_CFG_MODE_R] & GENMASK(12, 0)) |
> +		     (((u32)ctrls->offset[ISC_HIS_CFG_MODE_GR] & GENMASK(12, 0)) << 16));
>  	regmap_write(isc->regmap, ISC_WB_O_BGB,
> -		     ((ctrls->offset[ISC_HIS_CFG_MODE_B])) |
> -		     ((ctrls->offset[ISC_HIS_CFG_MODE_GB]) << 16));
> +		     ((u32)ctrls->offset[ISC_HIS_CFG_MODE_B] & GENMASK(12, 0)) |
> +		     (((u32)ctrls->offset[ISC_HIS_CFG_MODE_GB] & GENMASK(12, 0)) << 16));
> +	/* Gains are 13-bit unsigned fields [12:0] and [28:16] */
>  	regmap_write(isc->regmap, ISC_WB_G_RGR,
> -		     ctrls->gain[ISC_HIS_CFG_MODE_R] |
> -		     (ctrls->gain[ISC_HIS_CFG_MODE_GR] << 16));
> +		     (ctrls->gain[ISC_HIS_CFG_MODE_R] & GENMASK(12, 0)) |
> +		     ((ctrls->gain[ISC_HIS_CFG_MODE_GR] & GENMASK(12, 0)) << 16));
>  	regmap_write(isc->regmap, ISC_WB_G_BGB,
> -		     ctrls->gain[ISC_HIS_CFG_MODE_B] |
> -		     (ctrls->gain[ISC_HIS_CFG_MODE_GB] << 16));
> +		     (ctrls->gain[ISC_HIS_CFG_MODE_B] & GENMASK(12, 0)) |
> +		     ((ctrls->gain[ISC_HIS_CFG_MODE_GB] & GENMASK(12, 0)) << 16));
>  }
>  

Do you think you can rewrite these using FIELD_PREP ? It's getting a
little complicated to understand what is being written here.


>  static inline void isc_reset_awb_ctrls(struct isc_device *isc)
> 

