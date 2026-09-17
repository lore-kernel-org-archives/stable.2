Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE95239085;
	Thu, 17 Sep 2026 00:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789604506; cv=none; b=EheXGjrm4kcua/3AGULB9sQD+dDuKDlAXBLnaGwEL3wVIYaQBWyYN0InqAJBbJsRVEvT8ZlOm6mrl8u7cpUG6Bjui16BO2uwQeJQ7FXFK0WSjYu7mukG8AFQo0OvIJDDgPbV5Y9IPFF8zgSXthru9wHAuskhOEOHZ4F22SX98d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789604506; c=relaxed/simple;
	bh=YloiCn4ypMPPayodEDAWG16BF7xUqwkd89DTyREGAtM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RGZtM4VRHRgg44Y+yJPineWSnHRC2icuYib3RBlXlqZj+1QtmuYMQGY2h7luF2iBwEzgiOIy3po2R6wdedASgkUxpbu0qxNuSP8rUlGP4eML6M0pZH5ljg3dG2FPTwFCaUXDt9k3ScCvWVDfnk3JWNRExwNNUQea5O/ggGWMEqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HS38t+cs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HS38t+cs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA9281F000FF;
	Thu, 17 Sep 2026 00:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789604505;
	bh=tlEtHxuLNtDmcT0WvCSCTJxD5ujiYtk1Oc04fzdPA1M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HS38t+csrHRlOIcAvt3OW9TxeSsFCR6du29tpDy0Wn9x9cgHAplVVSwpJP6jVPvoP
	 NB/Imdp0881eZoUpfI375oNAICG95UWUGKANi77r22r64/0Ybodtqce/ZwCgnEX+rS
	 Pz8oYr1yRqwlAOm8u3fjwT7yYY4x8NODNZJ9PJMUJYAGDhexICLXghZfDtpmnc9r1o
	 ceXNLkAHbK3oE1qlVFCr3veYE/hnN9tDQe7et3bCnf8vo/ApV1HTS7DlFg48jnivu5
	 Aw3tNa2G0Ayd515sCW5jRdrdg/w1cGu2fqC4nHvkS8jR+qN9XZ+XtgTDLM2my2Z0mq
	 jpg4/W2YI6oOw==
Date: Thu, 17 Sep 2026 01:21:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: andy@kernel.org, dan@dlrobertson.com, dlechner@baylibre.com,
 jagathjog1996@gmail.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, nuno.sa@analog.com, stable@vger.kernel.org
Subject: Re: [PATCH] iio: accel: bma400: Fix trigger reference leak in
 bma400_probe()
Message-ID: <20260917012143.1ee8ddc3@jic23-hlaptop>
In-Reply-To: <20260917011724.1b0f181a@jic23-hlaptop>
References: <20260916160825.2082355-1-vulab@iscas.ac.cn>
	<20260917011724.1b0f181a@jic23-hlaptop>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Sep 2026 01:17:24 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Wed, 16 Sep 2026 16:08:25 +0000
> Wentao Liang <vulab@iscas.ac.cn> wrote:
> 
> > Move indio_dev->trig = iio_trigger_get(data->trig) after the
> > devm_request_threaded_irq() and triggered buffer setup succeed. If
> > either fails before INDIO_BUFFER_TRIGGERED is set, the IIO core does
> > not put the trigger reference in iio_dev_release(), leaking it.
> > 
> > Fixes: ffe0ab6a9698 ("iio: accel: bma400: Add triggered buffer support")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>  
> See reply to bma220 similar patch.
> 
> Not the way to fix this.  A comprehensive fix is needed and that
> requires some fiddly changes in the IIO core.
> 
> Also, this doesn't even fix it...

Looking again, maybe it does but still not how we want to fix this long term.

> 
> > ---
> >  drivers/iio/accel/bma400_core.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
> > index 05f72707f830..a5889b67585e 100644
> > --- a/drivers/iio/accel/bma400_core.c
> > +++ b/drivers/iio/accel/bma400_core.c
> > @@ -1783,7 +1783,6 @@ int bma400_probe(struct device *dev, struct regmap *regmap, int irq,
> >  			return dev_err_probe(data->dev, ret,
> >  					     "iio trigger register fail\n");
> >  
> > -		indio_dev->trig = iio_trigger_get(data->trig);
> >  		ret = devm_request_threaded_irq(dev, irq, NULL,
> >  						&bma400_interrupt,
> >  						IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> > @@ -1799,6 +1798,9 @@ int bma400_probe(struct device *dev, struct regmap *regmap, int irq,
> >  		return dev_err_probe(data->dev, ret,
> >  				     "iio triggered buffer setup failed\n");
> >  
> > +	if (irq > 0)
> > +		indio_dev->trig = iio_trigger_get(data->trig);
> > +
> >  	return devm_iio_device_register(dev, indio_dev);  
> 
> What happens if this last call fails?  Still leaks the reference.
> 
> >  }
> >  EXPORT_SYMBOL_NS(bma400_probe, "IIO_BMA400");  
> 
> 

