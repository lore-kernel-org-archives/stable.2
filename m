Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B057430F80C;
	Fri,  3 Jul 2026 19:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783105503; cv=none; b=C5+TzyB28w8nNpO3Ok1wpB5pZoAwMBKeiAGZLrryrcOZ5HKi3Xg6V5vF1Fu9NWyBOJc9slrHBVU9mrBibiIlES/By8We8onsrnctZRFBdboHU4r/LwACs0+j6XIv+hcEVTxKbZXNosbzmbubUlYN6yXrWKSOuYbfFSyypup+En0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783105503; c=relaxed/simple;
	bh=7twx5GnIruCtOq14gQ9XoLiOuBGIflLtuUYqgxRH6GQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mB3dZB1flygMwk9GXTQGgg3hiQXmX0Doo583lIkyE/aLluDR1ZR4Zn2Xw0Vj2+TtGSgjD7kj38kmzgq0HW5kibYQoZ6XtZOwKUqGwnaAici0iTN/sTQXRRkeUEX2sXPTlixFBRJq4dn9M6O9ymdNgWdxvh4M5HwFD2HSXjepBIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGzu9UFH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGzu9UFH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 612411F00A3A;
	Fri,  3 Jul 2026 19:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783105501;
	bh=tLn50O0ACpxWx0Mjp6z6nIDcdbb6EFg2LUTDS6ZMezE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BGzu9UFH+1Mg2pqTC6hI5Y3anFW890Tt5iPs4W2msLfdLO/+FPUu78Siiv5E7Rd45
	 LQzWP54jFzSXyQpUDBvXNr7I1zxVTfYwkWMurZeRKjtKvpC6PekhGt87jAzil+cryi
	 CiJsOcMu/VbNfcYayKw06MvJJ/1d0D+p771gNHVzzLatSIoBvS9h5fenREXQyHItZS
	 7fuVD8PN0AfhtcN8QKGGHo2AnsAEYntB8stDikPW5DAE9itbb54Vr96IqFcYv6kpQs
	 aAU/uL4t0Sb3122Yw49n4m8CRTf1jmpTYLF5EUB0MqJqsqU168ELgi19Aux3B/1y0R
	 uS+mHRYtC1mGg==
Date: Fri, 3 Jul 2026 20:04:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol via B4 Relay
 <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Cc: jean-baptiste.maneyrol@tdk.com, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: imu: inv_icm42600: fix timestamping by limiting
 FIFO reading
Message-ID: <20260703200455.5fa70e5b@jic23-huawei>
In-Reply-To: <20260629-inv-icm42600-fix-watermark-fifo-reading-v2-1-967e375db7b3@tdk.com>
References: <20260629-inv-icm42600-fix-watermark-fifo-reading-v2-1-967e375db7b3@tdk.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 29 Jun 2026 21:51:55 +0200
Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com=
@kernel.org> wrote:

> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
>=20
> Timestamps are made by measuring the chip clock using the watermark
> interrupts. If we read more than watermark samples as done today, we
> are reducing the period between interrupts and distort the time
> measurement. Fix that by reading only watermark samples in the
> interrupt case.
>=20
> Fixes: 7f85e42a6c54 ("iio: imu: inv_icm42600: add buffer support in iio d=
evices")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
> ---
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

That's not confusing at all :)

I've applied with the invensense one only - shout if you want something els=
e.

Thanks,

Jonathan



> ---
> Changes in v2:
> - Delete watermark computation rework, keep only FIFO read fix.
> - Link to v1: https://patch.msgid.link/20260623-inv-icm42600-fix-watermar=
k-fifo-reading-v1-1-f3f5694a818a@tdk.com
>=20
> To: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> To: Jonathan Cameron <jic23@kernel.org>
> To: David Lechner <dlechner@baylibre.com>
> To: Nuno S=C3=A1 <nuno.sa@analog.com>
> To: Andy Shevchenko <andy@kernel.org>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
> Cc: linux-iio@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c | 9 +++++----
>  drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h | 1 +
>  2 files changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers=
/iio/imu/inv_icm42600/inv_icm42600_buffer.c
> index 68a395758031..5c3840acf085 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
> @@ -248,6 +248,7 @@ int inv_icm42600_buffer_update_watermark(struct inv_i=
cm42600_state *st)
> =20
>  	/* compute watermark value in bytes */
>  	wm_size =3D watermark * packet_size;
> +	st->fifo.watermark.value =3D watermark;
> =20
>  	/* changing FIFO watermark requires to turn off watermark interrupt */
>  	ret =3D regmap_update_bits_check(st->map, INV_ICM42600_REG_INT_SOURCE0,
> @@ -454,11 +455,10 @@ int inv_icm42600_buffer_fifo_read(struct inv_icm426=
00_state *st,
>  	st->fifo.nb.accel =3D 0;
>  	st->fifo.nb.total =3D 0;
> =20
> -	/* compute maximum FIFO read size */
> +	/* compute maximum FIFO read size (watermark for max =3D 0 interrupt ca=
se) */
>  	if (max =3D=3D 0)
> -		max_count =3D sizeof(st->fifo.data);
> -	else
> -		max_count =3D max * inv_icm42600_get_packet_size(st->fifo.en);
> +		max =3D st->fifo.watermark.value;
> +	max_count =3D max * inv_icm42600_get_packet_size(st->fifo.en);
> =20
>  	/* read FIFO count value */
>  	raw_fifo_count =3D (__be16 *)st->buffer;
> @@ -574,6 +574,7 @@ int inv_icm42600_buffer_init(struct inv_icm42600_stat=
e *st)
> =20
>  	st->fifo.watermark.eff_gyro =3D 1;
>  	st->fifo.watermark.eff_accel =3D 1;
> +	st->fifo.watermark.value =3D 1;
> =20
>  	/*
>  	 * Default FIFO configuration (bits 7 to 5)
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h b/drivers=
/iio/imu/inv_icm42600/inv_icm42600_buffer.h
> index ffca4da1e249..88b8b9f780af 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h
> @@ -34,6 +34,7 @@ struct inv_icm42600_fifo {
>  		unsigned int accel;
>  		unsigned int eff_gyro;
>  		unsigned int eff_accel;
> +		unsigned int value;
>  	} watermark;
>  	size_t count;
>  	struct {
>=20
> ---
> base-commit: cc746297b23e89bd5df9f91f3a0ca209e8991763
> change-id: 20260623-inv-icm42600-fix-watermark-fifo-reading-624caf080754
>=20
> Best regards,
> -- =20
> Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
>=20
>=20
>=20

