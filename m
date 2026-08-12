Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C39265623;
	Wed, 12 Aug 2026 05:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786510845; cv=none; b=COO0THXhwHAf9bMQUYe8MQXvbUUPkU/tjzgoNxiR4zyc4vltenJ8F45ssmwLEJqSofgjjrNH931VjDOjUF+zzW3lAFnedWyCy9UB48xqvzYpgQ630OMz4xCKJdkYNETE0lFl6brJfmsnAXX9gr7Uyw7K3WiLGE29dZiADtTiwR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786510845; c=relaxed/simple;
	bh=1ALYIeZYp26IUBomS+i+rF7XlJSYKRffj3LyWCn9Kjc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KgjJdndIIiIFy36xoOn0gs7m5NWkSM2URiG/puhuOwJ11IXBTv/2J8n9xA6RRrcQmtg7DgWfkcN6GaTDWaOE4nbfULTRI/XpOu51CXgbulR+r2heMPUkbHl2pTlc6vwUpHiqpt0fwyN9ihIvuNdeMs21hbJxLvH7RxOpzQ0Do2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9lk4AUD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9lk4AUD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 289B21F000E9;
	Wed, 12 Aug 2026 05:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786510844;
	bh=TrrxMiK/sGyrOZXbJg2N7shVq5btACSQaQAGPERKgkc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=C9lk4AUDS54Muleln/BbEaQs7cJQx2L3ReNM0i9BIZwxz2ffdGIRqM66y/lbIVGd0
	 Nb3TvHFh8lUoc+AuYxDEvrxvOfI22n/vJ5kDaIPuP+ES27GAeGSdri7nmlBhgjnvw4
	 /ZEUfjJ0Fmlo+p6Gd3hxXOZ2q3gcP4AUNeyphVbHkN1pCft7lJpAa2iMqXsDFLkCsY
	 z9/0F2g0Mq21iZj3LDzTmlzicUt+KAyFk7fOpIx9EzmMb+Q+aow3Vz72KGdeOQQGZK
	 +ItbPY9KzQsBs//M4a/5udNWM+EuYOy4XLoaEvZe5dfUeRl3PHLlWbkh7ivLanmDO2
	 4IZvRwTl8IMNA==
Date: Wed, 12 Aug 2026 06:00:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Shengzhuo Wei" <me@cherr.cc>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, "Michael Hennerich"
 <Michael.Hennerich@analog.com>, "Ramona Gradinariu"
 <ramona.gradinariu@analog.com>, "Antoniu Miclaus"
 <antoniu.miclaus@analog.com>, "David Lechner" <dlechner@baylibre.com>,
 "Andy Shevchenko" <andy@kernel.org>, <linux@analog.com>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH] iio: accel: adxl380: clamp FIFO sample count
Message-ID: <20260812060029.7dc3d25b@jic23-huawei>
In-Reply-To: <anlcOa5tkTUN9EQr@nobug>
References: <20260809-adxl380-fifo-clamp-v1-1-780d86ef25eb@cherr.cc>
	<20260810002808.76ffd95a@jic23-huawei>
	<anlcOa5tkTUN9EQr@nobug>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 10 Aug 2026 13:06:01 +0800
"Shengzhuo Wei" <me@cherr.cc> wrote:

> =E5=9C=A8 2026-08-10 00:28=EF=BC=8CJonathan Cameron =E5=86=99=E9=81=93=EF=
=BC=9A
> > > Fixes: df36de13677a ("iio: accel: add ADXL380 driver") =20
> >=20
> > In my opinion at least, these are not fixes. In general we don't expect
> > drivers to be hardened against broken hardware returning out of spec
> > values.  I don't mind taking simple cases though that don't complicate
> > the code much and if anything make it a little easier to follow,
> > but I don't currently see any reason to mark them as a fix.
> >=20
> > So drop that tag for v2.
> >  =20
>=20
> Hi Jonathan,
>=20
> Thanks. Understood =E2=80=94 I'll drop the Fixes tag and stop clamping.=20
>=20
> > This is papering over what we think is a hardware failure. Unless I am
> > missing something the device is returning garbage, otherwise we are in
> > range and this has no affect. We have no idea how much data there is
> > if we get a value outside the expected range.=20
> >=20
> > As such I'd expect an error print and probably no attempt to carry
> > on reading as we have no idea what happened. =20
>=20
> For v2 I'll treat an out-of-range count as a hardware error,=20
> log it, and skip the read rather than carrying on:
>=20
>     ret =3D adxl380_get_fifo_entries(st, &fifo_entries);
>     if (ret)
>             return IRQ_HANDLED;
>=20
>     if (fifo_entries > ADXL380_FIFO_SAMPLES) {
>             dev_err_ratelimited(st->dev,
>                                 "invalid FIFO entry count %u (max %lu)\n",
>                                 fifo_entries, ADXL380_FIFO_SAMPLES);
>             return IRQ_HANDLED;
>     }
>=20
>     fifo_entries =3D rounddown(fifo_entries, st->fifo_set_size);
>     ret =3D regmap_noinc_read(st->regmap, ADXL380_FIFO_DATA, &st->fifo_bu=
f,
>                             sizeof(*st->fifo_buf) * fifo_entries);
>=20
> Same for adxl367 (push_fifo_data: dev_err_ratelimited and return true
> without reading the FIFO).
>=20
> I'll send the two as a single series with a cover letter, no Fixes tags.
>=20
> Let me know if this looks OK to you, or if you'd change anything, and
> I'll send the v2 series.
>
Looks good to me. The rate limit is interesting but perhaps does make
sense here given we are kind of assuming the hardware is stuck in
a bad condition.  On the other hand, it's complexity for a path we
never expect to take in practice. Definitely make sure to add a
brief description of why that is used in the patch description.

Thanks

Jonathan

> Best regards,
> Shengzhuo Wei
>=20

