Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794732742;
	b=Pg1m7Job+c9gOHlLB2NKvtp+Ze6hEaaaQ7C+PIBnRbus7q77pBCpfZ2J+uCqAWH06AO5
	 K17LJZpJgB1GCIJe5MA0cjTSsdvn/p7Yi3uK/a/kYmrndG+3l1zH8qpyNoAwP8HfqnidW
	 wfwVsvGz5kNkOGaiKyY3yhAniT2bXyyUoD7TnEV8ol7ZI/jdi6OrHo1MmvBRA6XjPkXVk
	 faLE9OXeNE+w6oZReZ5kximnZ0pxz+5sCZdFrTA0eVCpf2MOgFz8UXsEGzIPnLFR8M8Pn
	 xXcETBBHwpA4Fz3XxZUXwjPvbp3JJc8skzHxL8PRHC2JZBh7mFABNSN850xqE9nJ8gA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794732742;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=X7R2ObYq1Fhv6av8RxsP4ymD1EUZRl057ikwLLDbUE0=;
	b=uOWAI3IOADonH2dkdiLj3emqcmGfo2AOP+K//eOxpInET/GsHXMFHikmAWV7YCrva8cu
	 HyPfRK3tpio588L/g39Dg9d8g2oMc+/2yTOvIEEtO8CVFQVOLyr2yWCx8CuD28C9InX5Q
	 ec1xaiyF3YRklcRgZ3R61t4+QhKsrTzylVxKJ5LM+sWgACZE7IKQAjcO/Mxf5XPL9mJzB
	 obOeLC/eOZ6pMAqZPfCnbIwgoiJZKFDRY5O5kb9i8JBUQmZs7gxJuOmYbm0p+ftSZ7hUL
	 32IiwRlrcdo+9nOyxAZTES/qTMUrkEuBZHwClVmnPYfq52JdLW3z7MqHUMbi/DjIcZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SPFyQqxp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B141E606A31A;
	Sun, 15 Nov 2026 08:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SPFyQqxp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4DA01F000C4;
	Sun, 15 Nov 2026 08:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794732742;
	bh=X7R2ObYq1Fhv6av8RxsP4ymD1EUZRl057ikwLLDbUE0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SPFyQqxp364A5+UCdbNct6E/GefvCzxlwuzQ4YGVWiJbvq08+SYDi8ktpdhsiaXHK
	 cJ/Q0gncnh7YSjg0NouoqRHyJ5DN7Y+cK8sI4F8QDQUjUNrb6E4fBYHkZf5rT8fiBf
	 xixklkpC3g4NwsHnjx1berYoq9xsGF9pEG1iEyjukrOqynRwQDPo08q9eMFwL/WeLa
	 3ZCnmFuTbzgbQAyuC6O1vI4wW68IvbW/xFtJEfHe98I/ju/WhUrqwPXG3oVo86hIR4
	 OaYtZ4RpnAfRhnj+BmUM8hd1TjHK6kJQBumDtVBkcSjxlcEZMCGLdR4EkTzBWIFqFS
	 jX8fGe9h8dPng==
Date: Sun, 15 Nov 2026 09:52:19 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Phil Williams <phil.williams@advisoft.co.nz>
Cc: Francesco Lavra <flavra@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	mario.tesi@st.com, stable@vger.kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: fall back to 25 us/tick without a
 trim
Message-ID: <avlyw4qzdFUnM1DC@lore-desk>
References: <a3a00c75-c830-4d1a-9a89-dd55641a422f@advisoft.co.nz>
 <20261115000940.24215eb0@jic23-hlaptop>
 <2cc30a3e725639667085f3f82d453a7dfc9f853c.camel@baylibre.com>
 <6a9cbbcc-bdfb-4af1-a678-4f6f4b8a5f0e@advisoft.co.nz>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BSc6zn2TSPAs0pUK"
Content-Disposition: inline
In-Reply-To: <6a9cbbcc-bdfb-4af1-a678-4f6f4b8a5f0e@advisoft.co.nz>

--BSc6zn2TSPAs0pUK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi all,
>=20
> Patch attached. It is the fallback in st_lsm6dsx_init_hw_timer() as
> discussed.
>=20
> On Toradex Linux 6.6.142, an ISM330DLC on SPI (whoami 0x6a) on a Verdin
> i.MX8M Plus published every FIFO sample with one timestamp until the scale
> was 25000 ns/tick again. After that the timestamp bytes advanced and pitch
> updated. I have not booted this patch on mainline. It applies cleanly on
> mainline 23c62304dde2.
>=20
> This is my first kernel patch, please let me know if there is anything el=
se
> I need to do.
>=20
> Thanks,
> Phil
>=20
> On 15/11/2026 8:11 pm, Francesco Lavra wrote:
> > On Sun, 2026-11-15 at 00:09 +0000, Jonathan Cameron wrote:
> > > On Tue, 10 Nov 2026 02:38:14 +1300
> > > Phil Williams <phil.williams@advisoft.co.nz> wrote:
> > >=20
> > > > Hey Guys,
> > > >=20
> > > > I ran into an issue where every FIFO sample from an ISM330DLC came =
out
> > > > with the same timestamp, so our attitude math froze the pitch. The
> > > > accelerometer and gyroscope values were fine. I've patched it local=
ly,
> > > > so this is just an FYI.
> > > >=20
> > > > Make what you want of it, but here is an AI generated description of
> > > > the
> > > > issue:
> > > >=20
> > > > Commit 8abbf45fcda0 ("iio: st_lsm6dsx: Fixed calibrated timestamp
> > > > calculation") drops the timestamp scale for the older parts in this
> > > > driver. Stable backport 981f3da383ce is what we hit, in 6.6.142.
> > > >=20
> > > > st_lsm6dsx_init_hw_timer() used to do:
> > > >=20
> > > >  =A0=A0 =A0 hw->ts_gain =3D ST_LSM6DSX_TS_SENSITIVITY; /* 25000 ns/=
tick */
> > > >=20
> > > > That commit deletes the constant and reads the gain from the per-ch=
ip
> > > > table:
> > > >=20
> > > >  =A0=A0 =A0 hw->ts_gain =3D ts_settings->ts_sensitivity;
> > > >=20
> > > > ts_sensitivity is only filled in on the entries that already had
> > > > freq_fine (LSM6DSO / LSM6DSR / LSM6DSV and that generation). The
> > > > untagged-FIFO entries have no freq_fine register, so they were left=
 at
> > > > 0:
> > > >=20
> > > >  =A0=A0 =A0 LSM6DS3
> > > >  =A0=A0 =A0 LSM6DS3H
> > > >  =A0=A0 =A0 LSM6DSL, LSM6DSM, ISM330DLC, LSM6DS3TR-C
> > > >=20
> > > > st_lsm6dsx_read_fifo() still does:
> > > >=20
> > > >  =A0=A0 =A0 ts =3D data[1] << 16 | data[0] << 8 | data[3];
> > > >  =A0=A0 =A0 ts *=3D hw->ts_gain;
> > > >  =A0=A0 =A0 iio_push_to_buffers_with_timestamp(..., sensor->ts_ref =
+ ts);
> > > >=20
> > > > With ts_gain =3D=3D 0 every sample is published as ts_ref, the
> > > > CLOCK_REALTIME value taken when the buffer was enabled. The accel a=
nd
> > > > gyro values are fine. Only the timestamp is stuck. The raw count is
> > > > still checked against 0xff0000 before the multiply, so ts_ref is
> > > > refreshed when the counter gets there. At 25 =B5s/tick that is abou=
t 7
> > > > minutes. The driver comment says 1.638 s, which is 2^16 ticks, but =
the
> > > > test is 0xff0000.
> > > >=20
> > > > How we found it: an ISM330DLC on SPI (whoami 0x6a), on a Toradex Ve=
rdin
> > > > i.MX8M Plus, after moving onto 6.6.142. Userspace integrates attitu=
de
> > > > from the delta of the IIO buffer timestamp and treats a non-increas=
ing
> > > > timestamp as dt =3D 0, so pitch, roll and yaw froze at the first sa=
mple.
> > > > A
> > > > strace of the process reading /dev/iio:deviceX showed the xyz int16s
> > > > changing and the 8 timestamp bytes identical across samples. The sa=
me
> > > > binary against the previous kernel, which still used the 25000
> > > > constant,
> > > > did not do this.
> > > >=20
> > > > Setting the old scale on those three entries fixes it. freq_fine st=
ays
> > > > unset, so the trim register is not read and the gain stays exactly
> > > > 25000, which is what those parts had before:
> > > >=20
> > > >  =A0=A0 =A0 .ts_sensitivity =3D 25000,
> > > >  =A0=A0 =A0 .ts_trim_coeff =3D 37500,
> > > >=20
> > > > After booting that kernel the timestamp bytes increment and pitch
> > > > tracks
> > > > the unit again. The entries that already had ts_sensitivity (25000,=
 or
> > > > 21701 on the freq_fine 0x4f part) were left alone.
> > > >=20
> > > > Fixes: 8abbf45fcda0 ("iio: st_lsm6dsx: Fixed calibrated timestamp
> > > > calculation")
> > This analysis looks correct to me too.
> > But I wouldn't set .ts_trim_coeff for the parts where .freq_fine is 0: =
for
> > those, there is no trimming to be done.
> > So either set .ts_sensitivity =3D 25000 for all parts that currently do=
n't
> > have it set, or maybe better use 25000 in st_lsm6dsx_init_hw_timer() as=
 a
> > fallback value when .ts_sensitivity is not set.

> From 141aa31454bd87ed20b185544456bf28692c4c2d Mon Sep 17 00:00:00 2001
> From: Phil Williams <phil.williams@advisoft.co.nz>
> Date: Sun, 15 Nov 2026 21:04:06 +1300
> Subject: [PATCH] iio: imu: st_lsm6dsx: fall back to 25 us/tick without a =
trim
>=20
> Commit 8abbf45fcda0 ("iio: st_lsm6dsx: Fixed calibrated timestamp
> calculation") takes the FIFO timestamp scale from ts_sensitivity.
> That field is only filled in for parts that have freq_fine. The
> untagged-FIFO parts are left at zero:
>=20
>   LSM6DS3
>   LSM6DS3H
>   LSM6DSL, LSM6DSM, ISM330DLC and LSM6DS3TR-C
>=20
> st_lsm6dsx_read_fifo() multiplies the raw counter by hw->ts_gain, so
> every sample is published with the timestamp taken when the buffer
> was enabled. The accelerometer and gyroscope values still update.
> Userspace that integrates attitude from the timestamp delta treats a
> stuck timestamp as dt =3D 0.
>=20
> These parts have no freq_fine register, so there is no trim to apply.
> Use the previous fixed scale of 25000 ns/tick when ts_sensitivity is
> unset. Entries that already set it are left alone.
>=20
> Fixes: 8abbf45fcda0 ("iio: st_lsm6dsx: Fixed calibrated timestamp calcula=
tion")
> Cc: stable@vger.kernel.org
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Phil Williams <phil.williams@advisoft.co.nz>

Hi Phil,

just a nit inline Fixing it:

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/i=
mu/st_lsm6dsx/st_lsm6dsx_core.c
> index 823f8ac..98db90a 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -2525,8 +2525,14 @@ static int st_lsm6dsx_init_hw_timer(struct st_lsm6=
dsx_hw *hw)
>  			return err;
>  	}
> =20
> -	/* calibrate timestamp sensitivity */
> +	/*
> +	 * Parts with no freq_fine register have no trim and leave
> +	 * ts_sensitivity unset. Those parts used a fixed 25 us/tick.
> +	 * A zero gain publishes every FIFO sample with one timestamp.
> +	 */
>  	hw->ts_gain =3D ts_settings->ts_sensitivity;
> +	if (!hw->ts_gain)
> +		hw->ts_gain =3D 25000;

What about re-adding the macro here?

#define ST_LSM6DSX_TS_SENSITIVITY	25000UL /* 25us */

Regards,
Lorenzo

>  	if (ts_settings->freq_fine) {
>  		err =3D regmap_read(hw->regmap, ts_settings->freq_fine, &val);
>  		if (err < 0)
> --=20
> 2.53.0
>=20


--BSc6zn2TSPAs0pUK
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCavlywwAKCRA6cBh0uS2t
rIT0AP9cHXc0QioukxwlysOLwcCCE8JC7e3JG7/3Pg3nzlq3hQEAxTHXd8kiKpeW
WmEbP8jRFB7HpItvglwQokuMjO7RDwY=
=IkzA
-----END PGP SIGNATURE-----

--BSc6zn2TSPAs0pUK--
