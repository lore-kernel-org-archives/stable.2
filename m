Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794774411;
	b=aoAN1Bew6sDZJg7NMDvBDQq5A+/zTrvjSvXWwKB7+3Q7FnTFvtgQ/2hzofCdrdp6bgfb
	 u7Q4RTuoikI3oCGD3Su4hfyYYqTFRowaGDULa1KrrrjvEJbojz9CkAoQxr7Plrw66SSOJ
	 4PgwrETNnIVJqInJfjnqzfe0zG3sWEGELkdJsiPhabufMHHoxXLPUus5DjF7l6QbrfEb5
	 oCLgAq8t6B9Sjieh/TRVBdYLPt1KuSTafiQH/ve7ogs8LV425nWkipINJW3RMrZ71mxDR
	 K3k5FoXdIh6McEkx45nilEwL6lhwCd2nZWPK+TMp98QCe7fwrthoTWoLR0pdLALDC1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794774411;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=UmMsUg7qirony2MmNujjL3JvYsvcL7dA/KIOCNvrkw4=;
	b=NL7MC41hkh3zZmsJXPQTZgu/kwdIz5u3M3wwdn5jlSAOgD3Kn2dloKsRaATfnDHpKdkP
	 7fekngK6OX0r0FmFX1dobCmRt9En6s8RPmWn0byrbtXwo7WhR9hLoh5lnf+EG0y/FSXuo
	 ii5gn47Qa6Ot0lQu7Ag1l23TWzQISOmIbwA94VbWB7VULWzOXcARVW4VYwCUTfXK5XTyz
	 JqoNA9H4qTMK0YUfiLteVCvcpLuW1Rts4BPcRuTm+fPO2egQDOdGF3KyJ5nG8JLoOJt6r
	 NSIxOK1RI7LT9h9qtZf4GeZkAoQPiK8hsifjAIHnTzguFejeFsBYBZGtExM0QuQH3Sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="WZdl/8Mr";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3A1606A33D;
	Sun, 15 Nov 2026 20:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WZdl/8Mr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 851E71F000C4;
	Sun, 15 Nov 2026 20:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794774411;
	bh=UmMsUg7qirony2MmNujjL3JvYsvcL7dA/KIOCNvrkw4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WZdl/8MrB9ghZMYD+hcoPGJxQqRu+TG39F741KS2zxOWGaJiKdoRz4CHOk67GaD2C
	 Df0Zc+sKN1owyxq+C1mPKXSXb5Kroo99rt51j6hDlOVi7iijX5IMIDJE6fa9uojWuZ
	 JjhbVEzwdtRvf6Hp05NvLFOq6TyQ7/9hDLFq3UtAjrCd9ZqY1iLt4XIuk5MX5CACzP
	 M6iccznMsIbwwqjpmzU2J+4LApjFY9Qya5GQGopsZsbC+Ps2anE+U0iAuyweuoxI4p
	 Alpy3v+jpt8G24UyD76E/hrH64Dh92NUtdBSYSLcNO+fgHcjhu0WHgJEsKep35wHfE
	 f+QZ0mKeLOQBA==
Date: Sun, 15 Nov 2026 20:26:43 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Phil Williams <phil.williams@advisoft.co.nz>, Francesco Lavra
 <flavra@baylibre.com>, linux-iio@vger.kernel.org, mario.tesi@st.com,
 stable@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: fall back to 25 us/tick without a
 trim
Message-ID: <20261115202643.49ae2247@jic23-hlaptop>
In-Reply-To: <avlyw4qzdFUnM1DC@lore-desk>
References: <a3a00c75-c830-4d1a-9a89-dd55641a422f@advisoft.co.nz>
	<20261115000940.24215eb0@jic23-hlaptop>
	<2cc30a3e725639667085f3f82d453a7dfc9f853c.camel@baylibre.com>
	<6a9cbbcc-bdfb-4af1-a678-4f6f4b8a5f0e@advisoft.co.nz>
	<avlyw4qzdFUnM1DC@lore-desk>
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

On Sun, 15 Nov 2026 09:52:19 +0100
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> > Hi all,
> >=20
> > Patch attached. It is the fallback in st_lsm6dsx_init_hw_timer() as
> > discussed.
> >=20
> > On Toradex Linux 6.6.142, an ISM330DLC on SPI (whoami 0x6a) on a Verdin
> > i.MX8M Plus published every FIFO sample with one timestamp until the sc=
ale
> > was 25000 ns/tick again. After that the timestamp bytes advanced and pi=
tch
> > updated. I have not booted this patch on mainline. It applies cleanly on
> > mainline 23c62304dde2.
> >=20
> > This is my first kernel patch, please let me know if there is anything =
else
> > I need to do.
Take a look a the documentation for submitting patches.  It needs
to be sent as an inline patch rather than an attachment.

That may be easiest done via the b4 tool and gateway depending on your
email set up.

Thanks,

Jonathan

> >=20
> > Thanks,
> > Phil
> >=20
> > On 15/11/2026 8:11 pm, Francesco Lavra wrote: =20
> > > On Sun, 2026-11-15 at 00:09 +0000, Jonathan Cameron wrote: =20
> > > > On Tue, 10 Nov 2026 02:38:14 +1300
> > > > Phil Williams <phil.williams@advisoft.co.nz> wrote:
> > > >  =20
> > > > > Hey Guys,
> > > > >=20
> > > > > I ran into an issue where every FIFO sample from an ISM330DLC cam=
e out
> > > > > with the same timestamp, so our attitude math froze the pitch. The
> > > > > accelerometer and gyroscope values were fine. I've patched it loc=
ally,
> > > > > so this is just an FYI.
> > > > >=20
> > > > > Make what you want of it, but here is an AI generated description=
 of
> > > > > the
> > > > > issue:
> > > > >=20
> > > > > Commit 8abbf45fcda0 ("iio: st_lsm6dsx: Fixed calibrated timestamp
> > > > > calculation") drops the timestamp scale for the older parts in th=
is
> > > > > driver. Stable backport 981f3da383ce is what we hit, in 6.6.142.
> > > > >=20
> > > > > st_lsm6dsx_init_hw_timer() used to do:
> > > > >=20
> > > > >  =C2=A0=C2=A0 =C2=A0 hw->ts_gain =3D ST_LSM6DSX_TS_SENSITIVITY; /=
* 25000 ns/tick */
> > > > >=20
> > > > > That commit deletes the constant and reads the gain from the per-=
chip
> > > > > table:
> > > > >=20
> > > > >  =C2=A0=C2=A0 =C2=A0 hw->ts_gain =3D ts_settings->ts_sensitivity;
> > > > >=20
> > > > > ts_sensitivity is only filled in on the entries that already had
> > > > > freq_fine (LSM6DSO / LSM6DSR / LSM6DSV and that generation). The
> > > > > untagged-FIFO entries have no freq_fine register, so they were le=
ft at
> > > > > 0:
> > > > >=20
> > > > >  =C2=A0=C2=A0 =C2=A0 LSM6DS3
> > > > >  =C2=A0=C2=A0 =C2=A0 LSM6DS3H
> > > > >  =C2=A0=C2=A0 =C2=A0 LSM6DSL, LSM6DSM, ISM330DLC, LSM6DS3TR-C
> > > > >=20
> > > > > st_lsm6dsx_read_fifo() still does:
> > > > >=20
> > > > >  =C2=A0=C2=A0 =C2=A0 ts =3D data[1] << 16 | data[0] << 8 | data[3=
];
> > > > >  =C2=A0=C2=A0 =C2=A0 ts *=3D hw->ts_gain;
> > > > >  =C2=A0=C2=A0 =C2=A0 iio_push_to_buffers_with_timestamp(..., sens=
or->ts_ref + ts);
> > > > >=20
> > > > > With ts_gain =3D=3D 0 every sample is published as ts_ref, the
> > > > > CLOCK_REALTIME value taken when the buffer was enabled. The accel=
 and
> > > > > gyro values are fine. Only the timestamp is stuck. The raw count =
is
> > > > > still checked against 0xff0000 before the multiply, so ts_ref is
> > > > > refreshed when the counter gets there. At 25 =C2=B5s/tick that is=
 about 7
> > > > > minutes. The driver comment says 1.638 s, which is 2^16 ticks, bu=
t the
> > > > > test is 0xff0000.
> > > > >=20
> > > > > How we found it: an ISM330DLC on SPI (whoami 0x6a), on a Toradex =
Verdin
> > > > > i.MX8M Plus, after moving onto 6.6.142. Userspace integrates atti=
tude
> > > > > from the delta of the IIO buffer timestamp and treats a non-incre=
asing
> > > > > timestamp as dt =3D 0, so pitch, roll and yaw froze at the first =
sample.
> > > > > A
> > > > > strace of the process reading /dev/iio:deviceX showed the xyz int=
16s
> > > > > changing and the 8 timestamp bytes identical across samples. The =
same
> > > > > binary against the previous kernel, which still used the 25000
> > > > > constant,
> > > > > did not do this.
> > > > >=20
> > > > > Setting the old scale on those three entries fixes it. freq_fine =
stays
> > > > > unset, so the trim register is not read and the gain stays exactly
> > > > > 25000, which is what those parts had before:
> > > > >=20
> > > > >  =C2=A0=C2=A0 =C2=A0 .ts_sensitivity =3D 25000,
> > > > >  =C2=A0=C2=A0 =C2=A0 .ts_trim_coeff =3D 37500,
> > > > >=20
> > > > > After booting that kernel the timestamp bytes increment and pitch
> > > > > tracks
> > > > > the unit again. The entries that already had ts_sensitivity (2500=
0, or
> > > > > 21701 on the freq_fine 0x4f part) were left alone.
> > > > >=20
> > > > > Fixes: 8abbf45fcda0 ("iio: st_lsm6dsx: Fixed calibrated timestamp
> > > > > calculation") =20
> > > This analysis looks correct to me too.
> > > But I wouldn't set .ts_trim_coeff for the parts where .freq_fine is 0=
: for
> > > those, there is no trimming to be done.
> > > So either set .ts_sensitivity =3D 25000 for all parts that currently =
don't
> > > have it set, or maybe better use 25000 in st_lsm6dsx_init_hw_timer() =
as a
> > > fallback value when .ts_sensitivity is not set. =20
>=20
> > From 141aa31454bd87ed20b185544456bf28692c4c2d Mon Sep 17 00:00:00 2001
> > From: Phil Williams <phil.williams@advisoft.co.nz>
> > Date: Sun, 15 Nov 2026 21:04:06 +1300
> > Subject: [PATCH] iio: imu: st_lsm6dsx: fall back to 25 us/tick without =
a trim
> >=20
> > Commit 8abbf45fcda0 ("iio: st_lsm6dsx: Fixed calibrated timestamp
> > calculation") takes the FIFO timestamp scale from ts_sensitivity.
> > That field is only filled in for parts that have freq_fine. The
> > untagged-FIFO parts are left at zero:
> >=20
> >   LSM6DS3
> >   LSM6DS3H
> >   LSM6DSL, LSM6DSM, ISM330DLC and LSM6DS3TR-C
> >=20
> > st_lsm6dsx_read_fifo() multiplies the raw counter by hw->ts_gain, so
> > every sample is published with the timestamp taken when the buffer
> > was enabled. The accelerometer and gyroscope values still update.
> > Userspace that integrates attitude from the timestamp delta treats a
> > stuck timestamp as dt =3D 0.
> >=20
> > These parts have no freq_fine register, so there is no trim to apply.
> > Use the previous fixed scale of 25000 ns/tick when ts_sensitivity is
> > unset. Entries that already set it are left alone.
> >=20
> > Fixes: 8abbf45fcda0 ("iio: st_lsm6dsx: Fixed calibrated timestamp calcu=
lation")
> > Cc: stable@vger.kernel.org
> > Suggested-by: Jonathan Cameron <jic23@kernel.org>
> > Signed-off-by: Phil Williams <phil.williams@advisoft.co.nz> =20
>=20
> Hi Phil,
>=20
> just a nit inline Fixing it:
>=20
> Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> > ---
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio=
/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > index 823f8ac..98db90a 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > @@ -2525,8 +2525,14 @@ static int st_lsm6dsx_init_hw_timer(struct st_ls=
m6dsx_hw *hw)
> >  			return err;
> >  	}
> > =20
> > -	/* calibrate timestamp sensitivity */
> > +	/*
> > +	 * Parts with no freq_fine register have no trim and leave
> > +	 * ts_sensitivity unset. Those parts used a fixed 25 us/tick.
> > +	 * A zero gain publishes every FIFO sample with one timestamp.
> > +	 */
> >  	hw->ts_gain =3D ts_settings->ts_sensitivity;
> > +	if (!hw->ts_gain)
> > +		hw->ts_gain =3D 25000; =20
>=20
> What about re-adding the macro here?
>=20
> #define ST_LSM6DSX_TS_SENSITIVITY	25000UL /* 25us */
>=20
> Regards,
> Lorenzo
>=20
> >  	if (ts_settings->freq_fine) {
> >  		err =3D regmap_read(hw->regmap, ts_settings->freq_fine, &val);
> >  		if (err < 0)
> > --=20
> > 2.53.0
> >  =20
>=20

