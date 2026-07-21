Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3077E3537F6;
	Tue, 21 Jul 2026 13:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784639981; cv=none; b=u4vciT4tkrX6A4U1tXlloUBCEUExC4NYqWmKS8fvwc/Jgcs0pBVQewEKgXG4Oafra/KJ62sMdJLPnNH31hFVHZWj9/EklbovpcSPOlIna56qLx3eyZ/LTVJibkr0YT2rUB2tAHD64YolKIrFtplvenHzOqOf8roxJRfXVgN/b28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784639981; c=relaxed/simple;
	bh=dsXm5eirf+eY+E7+5iK1h70Vl+JqSrMHEvh/ODikdkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PylQoEZdOeArJeUNAl53p3hqtxBeJMbiVACLsvuJwjirO7H0hOhsYVld2hO30k/bt6GQHqG3rej35SEYxPXnS574/6YvqIPfaIf8lXpyTYdqTf6DgmLiApVfPb8iBU6eiXq76xFDxeRyp4OSenoHSdfL46CydwJpfeUlXmhVvt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c0TQRnqO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c0TQRnqO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DCAE1F000E9;
	Tue, 21 Jul 2026 13:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784639979;
	bh=cLgo61KLEnEVMRlvXSUOK7tZb9iZCFDc6BX9DWhvtrM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=c0TQRnqO9d92ri2RPGFiRccw/T2HLL7Ebk7lPucbUBAp2H3rWd60DvCLANwb8wxdc
	 8BRFvI4zSoShUycv3ouYd1kNn5qRf4B8Nl7qNaSoyHYzQ+rhrKEvFrPa3Q5jJLe+JM
	 c9Wl6HiTSTSDJNzOJPEi4K02guW86Fo24RTFo5EgWcG5a4+U8vedp1pjINsXwOKqup
	 UX9F2AJOs6ivzV2SqAAlr1Xg0ENQqOaLpQnAF/6Qj57CEyB6xHL6lmA6rB94anGodK
	 gZOzt3s6cu9w7k/WDH+P7FBgnCznX1tHi2XSO3CgM/VZIMe/4Lg1xCppJTPONez3C2
	 zCFRwjPzY66SQ==
Message-ID: <a1720828-f0cc-41fb-9060-b8f937eaded2@kernel.org>
Date: Tue, 21 Jul 2026 16:19:36 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/10] media: microchip-isc: fix WB offset and gain
 register field masking
To: Balakrishnan Sambath <balakrishnan.s@microchip.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Hans Verkuil <hverkuil@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260721-balki-isc-prefix-fixes-v1-v3-0-ffe10640a2d9@microchip.com>
 <20260721-balki-isc-prefix-fixes-v1-v3-10-ffe10640a2d9@microchip.com>
Content-Language: en-US
From: Eugen Hristev <ehristev@kernel.org>
In-Reply-To: <20260721-balki-isc-prefix-fixes-v1-v3-10-ffe10640a2d9@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/21/26 13:29, Balakrishnan Sambath wrote:
> ISC_WB_O_* and ISC_WB_G_* each pack two 13-bit fields. A negative offset
> sign-extends and corrupts the adjacent field. Add masks for the two
> fields and write them with FIELD_PREP(), which masks each value into its
> field, so sign extension can no longer bleed across.
> 
> Fixes: 91b4e487b0c6 ("media: microchip: add ISC driver as Microchip ISC")
> Cc: stable@vger.kernel.org
> Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
> ---
>  .../media/platform/microchip/microchip-isc-base.c   | 21 +++++++++++++--------
>  .../media/platform/microchip/microchip-isc-regs.h   |  6 ++++++
>  2 files changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/media/platform/microchip/microchip-isc-base.c b/drivers/media/platform/microchip/microchip-isc-base.c
> index 1a9b97edfa32..3d25d7d28652 100644
> --- a/drivers/media/platform/microchip/microchip-isc-base.c
> +++ b/drivers/media/platform/microchip/microchip-isc-base.c
> @@ -62,18 +62,23 @@ static inline void isc_update_awb_ctrls(struct isc_device *isc)
>  
>  	/* In here we set our actual hw pipeline config */
>  
> +	/*
> +	 * Each register packs two 13-bit fields. FIELD_PREP() masks every
> +	 * value into its field, so sign extension of a negative offset can
> +	 * no longer bleed into the adjacent field.
> +	 */

I guess this comment does not make sense. It refers to a bad situation
in the past that is no longer valid. In time, it will be forgotten and
it does not make sense to mention it here.
At least my opinion on it.


>  	regmap_write(isc->regmap, ISC_WB_O_RGR,
> -		     ((ctrls->offset[ISC_HIS_CFG_MODE_R])) |
> -		     ((ctrls->offset[ISC_HIS_CFG_MODE_GR]) << 16));
> +		     FIELD_PREP(ISC_WB_O_LO, ctrls->offset[ISC_HIS_CFG_MODE_R]) |
> +		     FIELD_PREP(ISC_WB_O_HI, ctrls->offset[ISC_HIS_CFG_MODE_GR]));
>  	regmap_write(isc->regmap, ISC_WB_O_BGB,
> -		     ((ctrls->offset[ISC_HIS_CFG_MODE_B])) |
> -		     ((ctrls->offset[ISC_HIS_CFG_MODE_GB]) << 16));
> +		     FIELD_PREP(ISC_WB_O_LO, ctrls->offset[ISC_HIS_CFG_MODE_B]) |
> +		     FIELD_PREP(ISC_WB_O_HI, ctrls->offset[ISC_HIS_CFG_MODE_GB]));
>  	regmap_write(isc->regmap, ISC_WB_G_RGR,
> -		     ctrls->gain[ISC_HIS_CFG_MODE_R] |
> -		     (ctrls->gain[ISC_HIS_CFG_MODE_GR] << 16));
> +		     FIELD_PREP(ISC_WB_G_LO, ctrls->gain[ISC_HIS_CFG_MODE_R]) |
> +		     FIELD_PREP(ISC_WB_G_HI, ctrls->gain[ISC_HIS_CFG_MODE_GR]));
>  	regmap_write(isc->regmap, ISC_WB_G_BGB,
> -		     ctrls->gain[ISC_HIS_CFG_MODE_B] |
> -		     (ctrls->gain[ISC_HIS_CFG_MODE_GB] << 16));
> +		     FIELD_PREP(ISC_WB_G_LO, ctrls->gain[ISC_HIS_CFG_MODE_B]) |
> +		     FIELD_PREP(ISC_WB_G_HI, ctrls->gain[ISC_HIS_CFG_MODE_GB]));
>  }
>  
>  static inline void isc_reset_awb_ctrls(struct isc_device *isc)
> diff --git a/drivers/media/platform/microchip/microchip-isc-regs.h b/drivers/media/platform/microchip/microchip-isc-regs.h
> index 9ddbbb6dd68b..fe145b142b82 100644
> --- a/drivers/media/platform/microchip/microchip-isc-regs.h
> +++ b/drivers/media/platform/microchip/microchip-isc-regs.h
> @@ -149,6 +149,12 @@
>  /* ISC White Balance Gain for B, GB Register */
>  #define ISC_WB_G_BGB	0x0000006c
>  
> +/* Each WB offset/gain register packs two 13-bit fields, low and high */
> +#define ISC_WB_O_LO	GENMASK(12, 0)	/* R or B  offset [12:0]  */
> +#define ISC_WB_O_HI	GENMASK(28, 16)	/* GR or GB offset [28:16] */
> +#define ISC_WB_G_LO	GENMASK(12, 0)	/* R or B  gain [12:0]  */
> +#define ISC_WB_G_HI	GENMASK(28, 16)	/* GR or GB gain [28:16] */
> +
>  /* ISC Color Filter Array Control Register */
>  #define ISC_CFA_CTRL    0x00000070
>  
> 

