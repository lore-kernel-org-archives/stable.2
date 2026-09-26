Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86E1547040;
	Sat, 26 Sep 2026 01:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790385508; cv=none; b=V3SPtPMC/YWzoVMWFqgtcawznUWVXdGTwnEBNWB0hwHgOBwag9vHkuQVvzXFM/QkeLol7NOzgX+FmifE3O5MQCFynRZjyo/Orc4+2c5uF9ew6SWaoViUh9gjlr9R/VTqbgLozyBC5xFaEqNu05jsTkIKs0+f76IMi4+Czf1Hquw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790385508; c=relaxed/simple;
	bh=v+5fpcyJSGXngo2MNoVp6lbViDgMCPoACmRIH/2vClQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R9HkIkIRDxd+W4RAkarHEqg3b4J5SB7R38cPpWGYyLpjZt4csbBthtjLtCiToSAkk/5k2va3DuVRW9hWJsB4ZX9/Lyn+ut99bl/HK9ig5wn1S4NOkGkuo3j1JQFV66gBvenVbz6HjSpM9RDPpQyB4/MedCjo5q724KbdYtm7MkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=atM0tqvu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="atM0tqvu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24DA41F000FF;
	Sat, 26 Sep 2026 01:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790385507;
	bh=BytMDVNhiPSsnAucAw8lOh4p8z3HFZcW8cgFKNrI9rY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=atM0tqvue+tvbOtWF3uvS8qlwN5uB3ZtAK/hJ5AKeiGFhCe/h+rNlWwBaZph3/dN0
	 KRTsuFWrfvvJbOYK4AYg8tesCNxlgPktyYY36aBeTKQouAsZJb/8vOzkYatl1C6Lvj
	 hF8/4Js+Be8CTIzvI3Dotnp4cCuem4U9vfE/UsQ+nEgog5+sW85YuewjKBzCObn3Vo
	 2XsrEykgFHPHYSJ5FvkQ/pX1sHdUonbdBXJTKaQTz+zO7NuSjTS2vJXciH686cux2v
	 afyrJaKKtmMJ1KnmdBI6BbRZjYGc2Eo0niZLww1Of+eIajhFPDQtX2avonSqHqbUMl
	 TPdI5ZfAaK1xQ==
Date: Sat, 26 Sep 2026 02:18:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jiale Yao <yaojiale02@163.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 6/9] iio: adc: ti-adc128s052: validate SPI match data
Message-ID: <20260926021823.6493dbe2@jic23-hlaptop>
In-Reply-To: <20260926021506.361a62c1@jic23-hlaptop>
References: <20260925125754.2162337-1-yaojiale02@163.com>
	<20260925125754.2162337-7-yaojiale02@163.com>
	<20260926021506.361a62c1@jic23-hlaptop>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 26 Sep 2026 02:15:06 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 25 Sep 2026 20:57:44 +0800
> Jiale Yao <yaojiale02@163.com> wrote:
> 
> > SPI driver_override allows a device to bind to this driver without
> > matching either the firmware tables or SPI device ID table. In that
> > case, spi_get_device_match_data() returns NULL.
> > 
> > adc128_probe() also obtains the IIO device name by dereferencing the
> > result of spi_get_device_id(), which is NULL on the same override path.
> > The probe can therefore crash before it reaches the match data access.
> > 
> > Commit 572a00852635 ("iio: dac: ad5686: missing NULL check on match
> > data") fixed the same driver_override issue in another SPI driver.
> > Reject devices without match data and use the always available SPI
> > modalias for the IIO device name.  
> 
> Why this change?  The name is clearly encoded in a place that makes
> it readily available and verifiably the right thing in a way that
> spi->modalias does not.
> There isn't any reason the IIO name would always match that even it
> happens to do so here.

Actually - ignore that, I misread this and assumed the code
was different from what was actually there.

Drivers shouldn't be using spi_get_device_id(spi)->name but
I'm not sure modalias is any better.

I'm out of time for now, so will revisit this in a day or so.

> 
> 
> > 
> > Fixes: d5f0da0c6972 ("iio: adc: ti-adc128s052: Switch to use spi_get_device_match_data()")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jiale Yao <yaojiale02@163.com>
> > ---
> >  drivers/iio/adc/ti-adc128s052.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
> > index 1899813c1aee..f9a995ff403e 100644
> > --- a/drivers/iio/adc/ti-adc128s052.c
> > +++ b/drivers/iio/adc/ti-adc128s052.c
> > @@ -195,12 +195,14 @@ static int adc128_probe(struct spi_device *spi)
> >  	adc = iio_priv(indio_dev);
> >  	adc->spi = spi;
> >  
> > -	indio_dev->name = spi_get_device_id(spi)->name;
> > +	config = spi_get_device_match_data(spi);
> > +	if (!config)
> > +		return -ENODATA;
> > +
> > +	indio_dev->name = spi->modalias;
> >  	indio_dev->modes = INDIO_DIRECT_MODE;
> >  	indio_dev->info = &adc128_info;
> >  
> > -	config = spi_get_device_match_data(spi);
> > -
> >  	indio_dev->channels = config->channels;
> >  	indio_dev->num_channels = config->num_channels;
> >    
> 
> 

