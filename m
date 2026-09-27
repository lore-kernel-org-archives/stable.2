Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7751737F727;
	Sun, 27 Sep 2026 19:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790536152; cv=none; b=YXhzDVpyXSxcS8rlF3LQrsVC8kSWQK1DmNzG4CR53FgDJYHNwJoLcR1xt8nZGyjdOv40ucmlkzOd3NQP3KgH5UFN99EyMkdOH1CeMDF+u1ABQj8VTZzIc69EeTSEHvSsfa2XMRUMPGtWXKTg5sPjGoB0QiGe0xDx/8lvu0LVc9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790536152; c=relaxed/simple;
	bh=ItZujjTeA728okR6dKC5Osjt2t1l8+dt1J4wA05YTY4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fsKFZoAzeKqbFwDW8OQP87Ynrxc3TeDXgqq+qj5sCxy0WnDUlWdvyJgWIDs/cIglApSHJSRZQbsNWrSdcfY9+ZNRpH6uLfw3t1jhcj+ujKGW1OrNZtZ0o7AOb06d39iR+6udJ/DUq3FKmpCL8I2+Ts68A59FUDbqxrwgkxZ3peY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DHpoMYpK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DHpoMYpK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C86B1F000FF;
	Sun, 27 Sep 2026 19:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790536149;
	bh=KMa9tBdZVLWsNziVeV70/J2p5vkOfGneyxSXxXGmYm4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DHpoMYpKilyRFauno66aCwPvTbj8xnytT5fgsskzWT+2v3C3dwL+QdKnfaWBjk7W6
	 yMjGkYt7w+lJA2YP+oc+2XPKh51SP2T8eadfi+Ev0FZqroQdqOGGBgoKi4e83+zNWo
	 UowSSR1LjuuW7wh/VrGR02YXxHDQi4aZDqm/AkflDlCvXNuJZeFk/XCcn3kyDLhMme
	 MFr/ZKEIrkNvWbX4zM7GRCk2+YA3/OIA563abuOHnI2g6VPkJgQMhjkZQhJqsVZiA0
	 K9HzwCMX6fZTBZ58Z1fr0vtkbTYjyYyO6pLOmb4RJVQSyrZ8jCZISV9KENPQr2UIcZ
	 STr6Fk1lCMiMQ==
Date: Sun, 27 Sep 2026 20:09:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc: Fan Wu <fanwu01@zju.edu.cn>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Song Li
 <songl@zju.edu.cn>
Subject: Re: [PATCH] iio: adc: ad_sigma_delta: fix use-after-free on unbind
Message-ID: <20260927200905.1cebc335@jic23-hlaptop>
In-Reply-To: <arTioh-Dax9Ogizj@nsa>
References: <20260923094807.503690-1-fanwu01@zju.edu.cn>
	<arTioh-Dax9Ogizj@nsa>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 24 Sep 2026 09:45:07 +0100
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> On Wed, Sep 23, 2026 at 09:48:07AM +0000, Fan Wu wrote:
> > ad_sd_buffer_postenable() allocates sigma_delta->samples_buf with
> > devm_krealloc() at runtime, so its devres entry sits after all
> > probe-time entries of the driver. devm resources are released in
> > reverse allocation order, which means unbind frees samples_buf before
> > iio_device_unregister() disables the buffers and detaches the trigger
> > pollfunc. The data ready IRQ is still enabled at that point, so
> > ad_sd_trigger_handler() can still run and memcpy() incoming samples
> > into the freed samples_buf.
> >=20
> > Fix this by preallocating the buffer in
> > devm_ad_sd_setup_buffer_and_trigger(), before the triggered buffer and
> > the IRQ are set up, so it is freed only after iio_device_unregister()
> > has drained the trigger handler via free_irq(). Size it for the worst
> > case of all sequencer slots being active; ad_sd_validate_scan_mask()
> > already caps the number of active channels at num_slots.
> >=20
> > This issue was found by an in-house static analysis tool.
> >=20
> > Fixes: 8bea9af887de ("iio: adc: ad_sigma_delta: Add sequencer support")
> > Cc: stable@vger.kernel.org
> > Co-developed-by: Song Li <songl@zju.edu.cn>
> > Signed-off-by: Song Li <songl@zju.edu.cn>
> > Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
> > --- =20
>=20
> Makes sense to me! One minor nit Jonathan might be ale to tweak when
> applying. With that:
Applied to the fixes-togreg branch of iio.git and tweaked as suggested.

Thanks,

Jonathan


>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
>=20
> >  drivers/iio/adc/ad_sigma_delta.c | 32 +++++++++++++++++++-------------
> >  1 file changed, 19 insertions(+), 13 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigm=
a_delta.c
> > index 1b41029..4f982c6 100644
> > --- a/drivers/iio/adc/ad_sigma_delta.c
> > +++ b/drivers/iio/adc/ad_sigma_delta.c
> > @@ -498,7 +498,6 @@ static int ad_sd_buffer_postenable(struct iio_dev *=
indio_dev)
> >  	const struct iio_scan_type *scan_type =3D &indio_dev->channels[0].sca=
n_type;
> >  	struct spi_transfer *xfer =3D sigma_delta->sample_xfer;
> >  	unsigned int i, slot, channel;
> > -	u8 *samples_buf;
> >  	int ret;
> > =20
> >  	if (sigma_delta->num_slots =3D=3D 1) {
> > @@ -530,7 +529,7 @@ static int ad_sd_buffer_postenable(struct iio_dev *=
indio_dev)
> >  		xfer[1].bits_per_word =3D scan_type->realbits;
> >  		xfer[1].len =3D spi_bpw_to_bytes(scan_type->realbits);
> >  	} else {
> > -		unsigned int samples_buf_size, scan_size;
> > +		unsigned int scan_size;
> > =20
> >  		if (sigma_delta->active_slots > 1) {
> >  			ret =3D ad_sigma_delta_append_status(sigma_delta, true);
> > @@ -538,17 +537,6 @@ static int ad_sd_buffer_postenable(struct iio_dev =
*indio_dev)
> >  				return ret;
> >  		}
> > =20
> > -		samples_buf_size =3D
> > -			ALIGN(slot * BITS_TO_BYTES(scan_type->storagebits),
> > -			      sizeof(s64));
> > -		samples_buf_size +=3D sizeof(s64);
> > -		samples_buf =3D devm_krealloc(&sigma_delta->spi->dev,
> > -					    sigma_delta->samples_buf,
> > -					    samples_buf_size, GFP_KERNEL);
> > -		if (!samples_buf)
> > -			return -ENOMEM;
> > -
> > -		sigma_delta->samples_buf =3D samples_buf;
> >  		scan_size =3D BITS_TO_BYTES(scan_type->realbits + scan_type->shift);
> >  		/* For 24-bit data, there is an extra byte of padding. */
> >  		xfer[1].rx_buf =3D &sigma_delta->rx_buf[scan_size =3D=3D 3 ? 1 : 0];
> > @@ -855,6 +843,24 @@ int devm_ad_sd_setup_buffer_and_trigger(struct dev=
ice *dev, struct iio_dev *indi
> > =20
> >  		indio_dev->setup_ops =3D &ad_sd_buffer_setup_ops;
> >  	} else {
> > +		const struct iio_scan_type *scan_type =3D
> > +			&indio_dev->channels[0].scan_type;
> > +		unsigned int samples_buf_size;
> > +
> > +		/*
> > +		 * Worst-case size: all sequencer slots can be active, capped
> > +		 * at num_slots by ad_sd_validate_scan_mask().
> > +		 */
> > +		samples_buf_size =3D
> > +			ALIGN(sigma_delta->num_slots *
> > +			      BITS_TO_BYTES(scan_type->storagebits),
> > +			      sizeof(s64));
> > +		samples_buf_size +=3D sizeof(s64);
> > +		sigma_delta->samples_buf =3D
> > +			devm_kzalloc(dev, samples_buf_size, GFP_KERNEL); =20
>=20
> Why the line break for devm_kzalloc(). Keep it in the same line please.
> Tbh same for for the ALIGN() call but at least that one is coherent with
> the original code.
>=20
> - Nuno S=C3=A1
>=20
> > +		if (!sigma_delta->samples_buf)
> > +			return -ENOMEM;
> > +
> >  		ret =3D devm_iio_triggered_buffer_setup(dev, indio_dev,
> >  						      &iio_pollfunc_store_time,
> >  						      &ad_sd_trigger_handler,
> >  =20

