Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E4E31AA92;
	Sat, 26 Sep 2026 01:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790385310; cv=none; b=iahnSvOENu7dvVfzSqfZpj5QqrhqVyhcN7enQCTx7MfR+N7wQ8E/07kFVM6YY1ZJS4YLYmB3GDQyTEk4vzNSapRLMg8IngvexZ3+cr4Ublbh+a+III4OTifF/4AISZFLFAlGlc3v4YI54HEd2ognX4XqkB6sgjeA4XHv0wuWuR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790385310; c=relaxed/simple;
	bh=ybSaYc0SOiD1JL1Bogi0Ug54ajmalnEMBvrXLM3NA1c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=guYjNLzGWpc9XC5AZnOradr/lNEw2YE/z4IruV++ZCkzVVU1TFFfjy6+AROWmUksNiEhmJC7uuegn1XJ0sLHTBh/Tv0QozxdU/ymGlODBlKkDv1XumcuZPFjQp1hC0YZlENGYkjyry8P6U3bkW5jlR4seLhkItf/4su/YhRK75g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pl46f839; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pl46f839"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E4D1F000FF;
	Sat, 26 Sep 2026 01:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790385309;
	bh=shQkV+N7FsgXVv9bnot5gmC3/3JitoaKr1HWoPhG6/8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Pl46f839VDGD0LYv2clhZaOJk+CYI8Ofgvl7yIs6+6Kn3TFvdpvsfRMELQJE5VBwj
	 v/ZzY13F3Xd4S7hYkMDVbgy3GssDUD8W+3lGCExdzF9MPbpWDA4CpE3HoWNX9UudfX
	 xi7pB5jH/v6aB2u41rGxrSZqBALnmI8iIKi3XD/mUKQ2oUHaux07/m8R/UEmT7yIi7
	 QSGanehMZLD3cmZUr0kM8pUNWfOMLvtmUrloR4V07ugEGdOhKCO/Il/qpMCaiXNouR
	 GK3Uc8LCI27XWLhBxlHr+ud7Sef60SzmBXbO3/mBki6lx+/whouPa0OGFPzcLSdqlw
	 UYA+lthK5+b0Q==
Date: Sat, 26 Sep 2026 02:15:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jiale Yao <yaojiale02@163.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 6/9] iio: adc: ti-adc128s052: validate SPI match data
Message-ID: <20260926021506.361a62c1@jic23-hlaptop>
In-Reply-To: <20260925125754.2162337-7-yaojiale02@163.com>
References: <20260925125754.2162337-1-yaojiale02@163.com>
	<20260925125754.2162337-7-yaojiale02@163.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Sep 2026 20:57:44 +0800
Jiale Yao <yaojiale02@163.com> wrote:

> SPI driver_override allows a device to bind to this driver without
> matching either the firmware tables or SPI device ID table. In that
> case, spi_get_device_match_data() returns NULL.
> 
> adc128_probe() also obtains the IIO device name by dereferencing the
> result of spi_get_device_id(), which is NULL on the same override path.
> The probe can therefore crash before it reaches the match data access.
> 
> Commit 572a00852635 ("iio: dac: ad5686: missing NULL check on match
> data") fixed the same driver_override issue in another SPI driver.
> Reject devices without match data and use the always available SPI
> modalias for the IIO device name.

Why this change?  The name is clearly encoded in a place that makes
it readily available and verifiably the right thing in a way that
spi->modalias does not.
There isn't any reason the IIO name would always match that even it
happens to do so here.


> 
> Fixes: d5f0da0c6972 ("iio: adc: ti-adc128s052: Switch to use spi_get_device_match_data()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiale Yao <yaojiale02@163.com>
> ---
>  drivers/iio/adc/ti-adc128s052.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
> index 1899813c1aee..f9a995ff403e 100644
> --- a/drivers/iio/adc/ti-adc128s052.c
> +++ b/drivers/iio/adc/ti-adc128s052.c
> @@ -195,12 +195,14 @@ static int adc128_probe(struct spi_device *spi)
>  	adc = iio_priv(indio_dev);
>  	adc->spi = spi;
>  
> -	indio_dev->name = spi_get_device_id(spi)->name;
> +	config = spi_get_device_match_data(spi);
> +	if (!config)
> +		return -ENODATA;
> +
> +	indio_dev->name = spi->modalias;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->info = &adc128_info;
>  
> -	config = spi_get_device_match_data(spi);
> -
>  	indio_dev->channels = config->channels;
>  	indio_dev->num_channels = config->num_channels;
>  

