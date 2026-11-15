Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794702955;
	b=w/ocf3nJZSD2qSLlyJhUENy9dSwXP8zKyHjVeJnvriBXBIfuSHzUymM4KcJXlAthLMax
	 E+hZr1NGy+Z0pTlwuvNs0bM8dQW7nI2syysYIH8jpwkOQIqva83IIsvhjmt8BXdYjvGB5
	 NRsUSamapdcA0LdHim6aNVHbgyHqeKPKEY9j0iQaOnHdbDFiJ3v67e6oYoLu477nfm1ag
	 510OH7Y/Y7tKs2qipXI6BDkkhwcsLNJOPqIdqC7DF2nePpT4P6Rynultzj1/2aASC0Qjr
	 br/v/DWeae/y1U1wLV9Rp2O8sBe0RC+UGszAnL5EVmYjOR6lLGKB75NaQPDMED1FKWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794702955;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=e3MfqHquW57agENVyo61jLWN54bIUlKoXXtI7ZKC2tE=;
	b=hIZ7a3JkvU/8+QmYEG8najP3XAhXVw/gRqr2+49oC1f9hKdWL5elV4I9dRwPtZIiCl0B
	 R3SpntYooLExJjaSwkZ9xJT3m8L9MlInc0WENNHY9ANB5xhU0xf2NUHRjw2EEJmfsEUzz
	 Zahm+X3arC6qmfeFipz7uQ4aANB6gkOI5BHsUHqUMj7cq142057LYbB8W7Sfq2CYWCqLO
	 Y10DQLxSX00zL3CpJXXzbgNEBWH8lw+fNM91eFc38uqb+KFjoLthyGyj4W4nzRj6tFNUr
	 fNY6Pl8jOK/3qJMGHIF6WJPdsIN6rqP4BshUucyOTAlXAzh3/i86UG3UG6KP7BYzzUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L77OMpLE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429F6606A323;
	Sun, 15 Nov 2026 00:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L77OMpLE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 583691F000C4;
	Sun, 15 Nov 2026 00:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794702955;
	bh=e3MfqHquW57agENVyo61jLWN54bIUlKoXXtI7ZKC2tE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=L77OMpLE135ql1G5rbtBmgAipklAnNyYspuNo5yeAWBG/4ZKThbsWPLXJRQUqOo6w
	 Egt70+4bFjEdhMUUs4i4ROZbrUyhq2lOBnr8wDFEusqm8BBT0FDSHv6DUgQ0HhOUYg
	 AsLWZXdDjd2NyPQ9GKdv/vIJJAoTc4AQeW61bEepRI9rgCkakAwPArpPsaT2MI6mFV
	 52KUQMjRw8eS1Q181jwqwP3v1GtCO6Jga80N+lSK4LbRRcg8rq/7JXcNAOdrKX9Y+U
	 +4cFRUfqDW/u0Q6+6ZN5G8PVdlCveIA0YQvejhFMIpdTQdSKn3rAIADA3EY9cyQVvV
	 l8scnJo6DGIiQ==
Date: Sun, 15 Nov 2026 00:35:47 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Liu Yufei <lyf98405@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Alex Lanzano <lanzano.alex@gmail.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Gustavo Silva
 <gustavograzs@gmail.com>
Subject: Re: [PATCH v2] iio: imu: bmi270: fix zero timestamp in triggered
 buffer
Message-ID: <20261115003547.7ee3045d@jic23-hlaptop>
In-Reply-To: <20261106-bmi270-fix-timestamp-v2-1-8a2547e1290b@gmail.com>
References: <20261106-bmi270-fix-timestamp-v2-1-8a2547e1290b@gmail.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 06 Nov 2026 10:54:17 +0800
Liu Yufei <lyf98405@gmail.com> wrote:

> The BMI270's own trigger uses iio_trigger_poll_nested() from
> the threaded IRQ handler, bypassing the pollfunc top half.
> This leaves the buffer timestamp at zero or a stale value.
>=20
> Capture the timestamp in the hard IRQ handler for the device's
> own trigger. Preserve the pollfunc timestamp for ordinary
> external triggers, and use the current IIO clock when a nested
> external trigger has no timestamp. Clear the pollfunc timestamp
> after processing.
>=20
> Testing on Orange Pi Zero 2W reproduced 256 zero timestamps
> with the original own trigger and 256 repeated stale timestamps
> after switching from an ordinary to a nested external trigger.
> With v2, 1280 samples across the tested trigger and restart
> paths had no zero or non-increasing timestamps.
>=20
> Fixes: a1854d55f54b ("iio: imu: bmi270: add support for data ready interr=
upt trigger")
> Cc: stable@vger.kernel.org
> Signed-off-by: Liu Yufei <lyf98405@gmail.com>
> ---
> Fix invalid BMI270 IIO buffer timestamps when the device's own
> trigger uses iio_trigger_poll_nested(). This bypasses the
> pollfunc top half, so its timestamp can remain zero or retain
> an old value.
>=20
> Capture the timestamp in the hard IRQ handler for the device's
> own trigger. Keep pollfunc timestamps for ordinary external
> triggers, and use the current IIO clock when a nested external
> trigger has no timestamp. Clear the pollfunc timestamp after use.
>=20
> Tested on Orange Pi Zero 2W (arm64, Linux 7.3.0), with a
> physical BMI270 connected over I2C, using INT1 at 100 Hz.
> The baseline produced 256/256 zero timestamps using its own
> trigger, and 256/256 stale timestamps after switching an
> external trigger from ordinary to nested polling.
>=20
> With v2, 1,280 samples across own hardware triggering,
> ordinary and nested external triggering, and stop/restart
> tests had no zero, repeated, or decreasing timestamps.
> External triggers were generated by a temporary test module;
> sensor data was read from the physical BMI270.
> ---
> Changes in v2:
> - Capture the timestamp in the hard IRQ handler.
> - Use the IRQ timestamp for the device's own trigger.
> - Fall back to the current time when no pollfunc timestamp exists.
> - Clear the pollfunc timestamp after processing.
> - Link to v1: https://patch.msgid.link/20261028-bmi270-fix-timestamp-v1-1=
-99c0e5fe7d0c@gmail.com
>=20
> To: Alex Lanzano <lanzano.alex@gmail.com>
> To: Jonathan Cameron <jic23@kernel.org>
> To: David Lechner <dlechner@baylibre.com>
> To: Nuno S=C3=A1 <nuno.sa@analog.com>
> To: Andy Shevchenko <andy@kernel.org>
> To: Gustavo Silva <gustavograzs@gmail.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: linux-iio@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/iio/imu/bmi270/bmi270_core.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi27=
0/bmi270_core.c
> index fbcf6bb87acc..6b11e91eabff 100644
> --- a/drivers/iio/imu/bmi270/bmi270_core.c
> +++ b/drivers/iio/imu/bmi270/bmi270_core.c
> @@ -157,6 +157,7 @@ struct bmi270_data {
>  	const struct bmi270_chip_info *chip_info;
>  	enum bmi270_irq_pin irq_pin;
>  	struct iio_trigger *trig;
> +	s64 irq_timestamp;
>  	 /* Protect device's private data from concurrent access */
>  	struct mutex mutex;
>  	bool steps_enabled;
> @@ -755,6 +756,16 @@ static int bmi270_get_odr(struct bmi270_data *data, =
int chan_type, int *odr,
>  	return -EINVAL;
>  }
> =20
> +static irqreturn_t bmi270_irq_handler(int irq, void *private)
> +{
> +	struct iio_dev *indio_dev =3D private;
> +	struct bmi270_data *data =3D iio_priv(indio_dev);
> +
> +	data->irq_timestamp =3D iio_get_time_ns(indio_dev);
> +
> +	return IRQ_WAKE_THREAD;
> +}
> +
>  static irqreturn_t bmi270_irq_thread_handler(int irq, void *private)
>  {
>  	struct iio_dev *indio_dev =3D private;
> @@ -842,6 +853,13 @@ static irqreturn_t bmi270_trigger_handler(int irq, v=
oid *p)
>  	struct bmi270_data *data =3D iio_priv(indio_dev);
>  	int ret;
> =20
> +	if (iio_trigger_using_own(indio_dev)) {
> +		pf->timestamp =3D data->irq_timestamp;
> +		data->irq_timestamp =3D 0;
> +	} else if (!pf->timestamp) {

Using 0 timestamp as a flag is not a good pattern. It may more
may not be valid, we simply don't know.

If it's not our trigger though then whatever timestamp was there
probably isn't a close to the data capture timestamp, so under
those circumstances it is fine to unconditionally set the
timestamp here.

> +		pf->timestamp =3D iio_get_time_ns(indio_dev);
> +	}
> +
>  	guard(mutex)(&data->mutex);
> =20
>  	ret =3D regmap_bulk_read(data->regmap, BMI270_ACCEL_X_REG,
> @@ -854,6 +872,7 @@ static irqreturn_t bmi270_trigger_handler(int irq, vo=
id *p)
>  	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
>  					   pf->timestamp);
>  done:
> +	pf->timestamp =3D 0;
>  	iio_trigger_notify_done(indio_dev->trig);
>  	return IRQ_HANDLED;
>  }
> @@ -1430,7 +1449,7 @@ static int bmi270_trigger_probe(struct bmi270_data =
*data,
>  	data->trig->ops =3D &bmi270_trigger_ops;
>  	iio_trigger_set_drvdata(data->trig, data);
> =20
> -	ret =3D devm_request_threaded_irq(data->dev, irq, NULL,
> +	ret =3D devm_request_threaded_irq(data->dev, irq, bmi270_irq_handler,
>  					bmi270_irq_thread_handler,
>  					IRQF_ONESHOT, "bmi270-int", indio_dev);
>  	if (ret)
>=20
> ---
> base-commit: 09f742b49cb2728086d78be2b0b35e4d1d71fc85
> change-id: 20261028-bmi270-fix-timestamp-48a194b69db1
>=20
> Best regards,
> -- =20
> Liu Yufei <lyf98405@gmail.com>
>=20

