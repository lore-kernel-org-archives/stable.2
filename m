Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4AA2765ED;
	Sun, 27 Sep 2026 17:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790531127; cv=none; b=fvCp6Xf2MGpMSxSSocHYLxfhGrkKTww3rfn3mqemcbQCRs/gBMiL9xZK/ofiRZh4OV2rW/XNxE/mkIANMM6pSzWdiNg9CORjPb1TDGYTeFn9qwjQ9GAGqe/IXdbM10ZmBazubjdanKsUW9XQo/0ZKEaHQQLKkNWfgeIHdI4zS8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790531127; c=relaxed/simple;
	bh=cR3vz3frva+A53vWFF8Ow0W02iWNyo5Zklm97jmWdVE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A8HIOdKgle4tMF7L7+TBGw08DBKLLXXgNUQD37HkgzLrCpPZPTTpZvq3HHpP1U3qqgWtGBjbcj00Rx5kjsOhC/dINxwRyOfYpZkvqBPVqIuR71ZtuI4BUJAlETCYE/PFY1SgNvPmaP+bwa+d751K5kZfM5bWSVUZ4mpJicxroZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dVpVXy1j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVpVXy1j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A4B1F000FF;
	Sun, 27 Sep 2026 17:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790531125;
	bh=3hEemW1CQPbavWnA4xtTCd8PwbJwsC2IK7Xzx6SzOdk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dVpVXy1jjCGXOzLsP/P3HbcBXWRSuCSfCa81hED2Z7zmkGCyW94DLkhdfYSu9kKgv
	 8G7bL6lTTEN8Sn3Nv2ZvQvg8aZdYhqEKdAfFd63tMYbE+tZ8QAteJ2XxSVghcnSHx6
	 I1LeiDtq6u9RddkjF8iHTQkQGE4Og8Nk/UyWO6P2d7iSR3EK9KLlMr79rJyESnrIiD
	 jfGJ+IPi6YdhCE/RR3gHn8JcyAsN6kDHQih7PmSiB2u8M8oPqO43BpWxBRDuxzyVcs
	 sUIXKL1AmIyw8DaTIX8869tc1OEta+Fd0GXz6xQpk/nqaN7qGwFBtbagwT0Mf1lCPV
	 7Et3Q3PhaB0Yw==
Date: Sun, 27 Sep 2026 18:45:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jiale Yao <yaojiale02@163.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 6/9] iio: adc: ti-adc128s052: validate SPI match data
Message-ID: <20260927184521.022ccf49@jic23-hlaptop>
In-Reply-To: <20260926021823.6493dbe2@jic23-hlaptop>
References: <20260925125754.2162337-1-yaojiale02@163.com>
	<20260925125754.2162337-7-yaojiale02@163.com>
	<20260926021506.361a62c1@jic23-hlaptop>
	<20260926021823.6493dbe2@jic23-hlaptop>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 26 Sep 2026 02:18:23 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sat, 26 Sep 2026 02:15:06 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Fri, 25 Sep 2026 20:57:44 +0800
> > Jiale Yao <yaojiale02@163.com> wrote:
> >   
> > > SPI driver_override allows a device to bind to this driver without
> > > matching either the firmware tables or SPI device ID table. In that
> > > case, spi_get_device_match_data() returns NULL.
> > > 
> > > adc128_probe() also obtains the IIO device name by dereferencing the
> > > result of spi_get_device_id(), which is NULL on the same override path.
> > > The probe can therefore crash before it reaches the match data access.
> > > 
> > > Commit 572a00852635 ("iio: dac: ad5686: missing NULL check on match
> > > data") fixed the same driver_override issue in another SPI driver.
> > > Reject devices without match data and use the always available SPI
> > > modalias for the IIO device name.    
> > 
> > Why this change?  The name is clearly encoded in a place that makes
> > it readily available and verifiably the right thing in a way that
> > spi->modalias does not.
> > There isn't any reason the IIO name would always match that even it
> > happens to do so here.  
> 
> Actually - ignore that, I misread this and assumed the code
> was different from what was actually there.
> 
> Drivers shouldn't be using spi_get_device_id(spi)->name but
> I'm not sure modalias is any better.
> 
> I'm out of time for now, so will revisit this in a day or so.
> 

I did a bit of LLM assisted digging and it does seem that some
of the previous issues around these names and ACPI PRP0001 have
been resolved these days so as far as I can tell this ends
up the with the correct answer.

> > 
> >   
> > > 
> > > Fixes: d5f0da0c6972 ("iio: adc: ti-adc128s052: Switch to use spi_get_device_match_data()")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Jiale Yao <yaojiale02@163.com>
> > > ---
> > >  drivers/iio/adc/ti-adc128s052.c | 8 +++++---
> > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
> > > index 1899813c1aee..f9a995ff403e 100644
> > > --- a/drivers/iio/adc/ti-adc128s052.c
> > > +++ b/drivers/iio/adc/ti-adc128s052.c
> > > @@ -195,12 +195,14 @@ static int adc128_probe(struct spi_device *spi)
> > >  	adc = iio_priv(indio_dev);
> > >  	adc->spi = spi;
> > >  
> > > -	indio_dev->name = spi_get_device_id(spi)->name;
> > > +	config = spi_get_device_match_data(spi);
> > > +	if (!config)
> > > +		return -ENODATA;
> > > +
> > > +	indio_dev->name = spi->modalias;
> > >  	indio_dev->modes = INDIO_DIRECT_MODE;
> > >  	indio_dev->info = &adc128_info;
> > >  
> > > -	config = spi_get_device_match_data(spi);
> > > -
> > >  	indio_dev->channels = config->channels;
> > >  	indio_dev->num_channels = config->num_channels;
> > >      
> > 
> >   
> 
> 

