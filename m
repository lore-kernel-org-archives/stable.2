Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794620050;
	b=BnhBxQrqtxpHC3vHCaLAVI+QEOUfoGFNO5BIECExGrurZXyLH5Pypt474RZyQzyQaapV
	 ex/D1QhDMlGLf6mLGfWQ824fxARHLD7/O3IJEJcADiet2AN+00GdOsCc9bXGucOH45nt/
	 rfbyimZ/kzHcZ0nY7+Dq2dFhaGHPqQTQxvuD/7kvV3qpJKjvGITVr/uvr33IwisxwLQyE
	 0NDMZyMfCWHcdZh12oxmsk0B4AfinfM2dPePHpgKBV14n6DQokUPD7VUhMbpb6wXK5cew
	 bVGD4gw6LhQGc4m+9x4snuw2n3tPmDFLJ7tEvZgvSZMWL2S3MAiDRU9YgJFwA1AAHAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794620050;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=bLdKj4Zz7frhcJ06N0O4vdbmfIkxkbW+xGhvFYBA9oY=;
	b=bkvXXwErtDWO9Tj4VrRU0bf66gWBmUu+BB7RKnMhYGGsdY4/V8oswccu2XUVlPl4X6hC
	 /I50jGs3eHNhlm0OvmU6jBtzSTAQBDACdZx+3uubp4qVOG/W+TuBIEnaK+iFY1LYY/eeN
	 HfCns/pESUpaL8pt6xUr7wvYQqIMx9kMcOrkfsONNXcKfBnSiTY3WT7OgfoFkkCs0hOTz
	 jAcSeYGYJdAMWLdofFvBqSuJJE96sxwcTmi28IdaKlsIdgsrRJ6jzZJzEEzHD8rnDjmdZ
	 cr+0yf5puyRc1bLN6XFCjnoe6XZ2fMgBctYjPYfqbH8MibKbFrMerj4Q/GK4Jzo/0kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BuRtsGlO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1858606A327;
	Sat, 14 Nov 2026 01:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BuRtsGlO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E9F11F000C4;
	Sat, 14 Nov 2026 01:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794620049;
	bh=bLdKj4Zz7frhcJ06N0O4vdbmfIkxkbW+xGhvFYBA9oY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BuRtsGlOrGvLQgxWh0G7sr7ptJN+eMotPIgQH6Qy4ZQurfEgovgCBuEpwqh+Vmn3M
	 YCJp8n0AsM/JAojh8ihDBsAFXPE14vcVTOi7LjD54pPql4TyuuVpXUxUXQdDXbgQTW
	 eQqlk/f0GnfpSHU1oR80UAlGOQGSI2CdVCEDlSJMlqB/JBQR0bx4yNEMuLyZ1qsWTI
	 g/Z6UrcAq95vO4t+tYZNAiPIletZrHvNNHpgpemkqRq2mn0DnSBWq2V5OpQsEzd8D2
	 Fo/Cng04QXFwlRIaJCkf1g5CFaz5AOTe50IwqXEgvOEBwVrTDbqu/S+wml2tKdLMOR
	 /WEtuMzGq0Ejw==
Date: Sat, 14 Nov 2026 01:34:01 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Parthiban
 Nallathambi <parthiban@linumiz.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: light: vcnl4035: Fix swapped raw channel
 readings
Message-ID: <20261114013353.58ed6382@jic23-hlaptop>
In-Reply-To: <20261113222609.97564-1-dennylin0707@gmail.com>
References: <20261113222609.97564-1-dennylin0707@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Nov 2026 22:26:09 +0000
Hungyu Lin <dennylin0707@gmail.com> wrote:

> The IIO_LIGHT channel has channel number 0 and the IIO_INTENSITY
> channel has channel number 1. vcnl4035_read_info_raw() selects the ALS
> register for a nonzero channel number, so in_illuminance_raw returns
> the white-channel sample and in_intensity_both_raw returns the ALS
> sample. This also causes the illuminance scale to be applied to a
> white-channel sample.
> 
> Table 13 of the VCNL4035X01 datasheet [1] lists 0x0b as the ALS
> data register and 0x0c as the white data register.
> 
> Select the ALS data register for IIO_LIGHT and the white data register
> for the intensity channel.
> 
> Fixes: 55707294c4eb ("iio: light: Add support for vishay vcnl4035")
> Link: https://www.vishay.com/docs/84251/vcnl4035x01.pdf [1]
> Cc: stable@vger.kernel.org
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>

Addressed Andy's comments and indeed even without looking the datasheet
the code is clearly backwards, so applied to the fixes-togreg branch of iio.git.
> ---
> Changes in v2:
> - Reference the datasheet's register table in the commit message.
> 
> v1: https://lore.kernel.org/r/20261113110123.96084-1-dennylin0707@gmail.com/
> 
>  drivers/iio/light/vcnl4035.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
> index f1cc75245001..4bbb3b458eb5 100644
> --- a/drivers/iio/light/vcnl4035.c
> +++ b/drivers/iio/light/vcnl4035.c
> @@ -156,7 +156,7 @@ static int vcnl4035_read_info_raw(struct iio_dev *indio_dev,
>  	if (!iio_device_claim_direct(indio_dev))
>  		return -EBUSY;
>  
> -	if (chan->channel)
> +	if (chan->type == IIO_LIGHT)
>  		reg = VCNL4035_ALS_DATA;
>  	else
>  		reg = VCNL4035_WHITE_DATA;
> 
> base-commit: 9752760146e642f3e4a2ec860f8767fa72030d2c

