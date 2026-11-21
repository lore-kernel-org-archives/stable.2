Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795303204;
	b=x9kJLbvLOuZ9+BJ8mnP+3mCJP7znNkJoPBCDwSEH39rJ0VhBFjuy0QlYWKb6Myz+WZBq
	 7p58w0CO3J1Y//O61DONngL4+Yaw3o0cq8tosZekVMXeg8qAfbRXycb3RqU8iR3Vs8RRQ
	 bCBqTKZUmPpFWpAJVATYXLDTaeB9p+QOUclpv+fijsFOTznW0yr080CzDUNdEse6BpDZ1
	 nDlg+KVlaxZVfRHvLdV8E38M8NkQEQMIOP5az8Jx1tSGOG/Ue5wechYBGeXo6SiLEdk9E
	 gw1lCKqs7EiWiBaHijp7QY+KxQHWEVVaXQ7nW2db4+VgCi8tBvyN9t/GxmCwZnyZjvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795303204;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=330Sn7QYb5+iw1QeSwXWz7hbHma/2WpF8jFAFVC9GC8=;
	b=04vkap/2n9sNEA7VCrt3glWj0R6GiJ5kR5bkNFj7sr1PEEUjJ9BtMhrMfE2UDA48P10E
	 wRn8aFOO5qERhcLO+LoCcmyfPQ3BVPo5IYCsL6hsf85j7bEPEFsex8pXQxK9DFI7R8zL8
	 MV1E0XnTk+3eQt12OTxidlY7KN2dmrNF3VZqNRM3Y/KAZqp+AopgRu/Y9WhcUPPyF8zEw
	 9VAOMfKO//sMxr5Gk/CUam/pDAbwbE9kpRUEj+hmIfZ9G15sljM/fPK4CK4IxNq3XOel7
	 f97AXh6Rsx3hOMOqLTc9UuktheMGHi7dubRauuO/58/AOj/L+3EOXxhtk8q3URZIQrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WFwXUMTp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0FE606A320;
	Sat, 21 Nov 2026 23:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WFwXUMTp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC2E61F000CA;
	Sat, 21 Nov 2026 23:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795303204;
	bh=330Sn7QYb5+iw1QeSwXWz7hbHma/2WpF8jFAFVC9GC8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WFwXUMTpo8BTiq8Qb5pp8fLKHREyIrhkG5oI9CPIZzZjTbgEYEA79HujUipCJQv+E
	 Cs4lwQWoaU6uCZm3DrihGs3Cpt4cSQmW2+xPGl/jYixcT/yI6y8LzM2nlKtkrB++s7
	 WJcE7EVpA6pEjqMLSqIxiKFNH97M2MPOaQ7dflvG2e25VFQo/CmL6qMALMCdLvM4IH
	 n+FUQ72JNZk/xQ/T59Is/+URfVwHCOPa3jkjsJEUnig4Mk37mlSHsFVrFdgz2aEwdr
	 1B1GD06b3Ho5q68sJyzfdaXqLEylu9mcWZ2d9DUUQKYdY1+fwKtABKY7f5rK7ElISw
	 0oZBK/kzFcZKQ==
Date: Sat, 21 Nov 2026 23:20:02 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>, lee@kernel.org, maz@kernel.org,
 andy@kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
 mfd@lists.linux.dev, linux-iio@vger.kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, crofts@kernel.org,
 devicetree@vger.kernel.org, imx@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v5 2/4] iio: adc: mxs-lradc: Fix trigger use-after-free
 on removal
Message-ID: <20261121232002.24cd9970@jic23-hlaptop>
In-Reply-To: <av8e5Arl0INpsv8T@SMW015318>
References: <20261119134041.16611-1-festevam@gmail.com>
	<20261119134041.16611-2-festevam@gmail.com>
	<av8e5Arl0INpsv8T@SMW015318>
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

On Thu, 19 Nov 2026 10:08:04 -0600
Frank Li <Frank.li@oss.nxp.com> wrote:

> On Thu, Nov 19, 2026 at 10:40:39AM -0300, Fabio Estevam wrote:
> > The LRADC trigger is devm-allocated against the IIO device, but it is
> > manually unregistered after iio_device_unregister(). The latter deletes
> > the IIO device and releases its managed resources, freeing the trigger
> > before mxs_lradc_adc_trigger_remove() accesses it.
> >
> > Since commit 699fb50d9903 ("drivers: base: Free devm resources when
> > unregistering a device"), device_del() releases managed resources.
> > Consequently, iio_device_unregister() drops the trigger's allocation
> > reference before the driver unregisters it.
> >
> > On an i.MX28 EVK with KASAN enabled, unbinding the LRADC parent with:
> >
> >   echo 80050000.lradc > /sys/bus/platform/drivers/mxs-lradc/unbind
> >
> > reports a slab-use-after-free in device_release_driver_internal().
> >
> > Allocate the managed trigger against the platform device instead. This
> > matches the trigger device's parent and keeps the allocation alive until
> > the platform driver's remove callback has unregistered the trigger.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 699fb50d9903 ("drivers: base: Free devm resources when unregistering a device")
> > Signed-off-by: Fabio Estevam <festevam@gmail.com>
> > Reviewed-by: Joshua Crofts <crofts@kernel.org>  
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
Applied 1 and 2 to the fixes-togreg branch of iio.git.

I guess I need to find time to do a sweep for any more of these
hiding.

Thanks,

Jonathan

> > ---
> > Changes since v4:
> > - None. Only collected Joshua's tag.
> >
> >  drivers/iio/adc/mxs-lradc-adc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/adc/mxs-lradc-adc.c b/drivers/iio/adc/mxs-lradc-adc.c
> > index dda5182a5076..64dd3a9995ff 100644
> > --- a/drivers/iio/adc/mxs-lradc-adc.c
> > +++ b/drivers/iio/adc/mxs-lradc-adc.c
> > @@ -454,7 +454,7 @@ static int mxs_lradc_adc_trigger_init(struct iio_dev *iio)
> >  	struct iio_trigger *trig;
> >  	struct mxs_lradc_adc *adc = iio_priv(iio);
> >
> > -	trig = devm_iio_trigger_alloc(&iio->dev, "%s-dev%i", iio->name,
> > +	trig = devm_iio_trigger_alloc(adc->dev, "%s-dev%i", iio->name,
> >  				      iio_device_id(iio));
> >  	if (!trig)
> >  		return -ENOMEM;
> > --
> > 2.43.0
> >
> >  

