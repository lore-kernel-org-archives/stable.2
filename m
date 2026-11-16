Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794819346;
	b=0aPMQLmU8/vG8eRu89kMARenn3tXXFTyVJYCSrCPWfhK4KwCkAwdkcz7RpKemxwWyFGI
	 Axv0z1mJJ7q144MSFI5qV3lbKtijHE/IJZ/Pcf3w0q1VOpQ7LYbM70LBRx0orRZY0BIyi
	 oJcEif8Qn3Iwle43cDIELQmOKRjYZv2pTA0bs6mK6IjJjMD4nqIyJVRT3JdF4WvFjC0lB
	 W0U/ZPfUaWWb18rJb9Ju1F8w5CX4KpabBfyCMZBA8Kz9keEKya/pVAhwAUn0P0/p8/6eX
	 zO2x8pXCd4WLO+wCHRNwdvWErG8iF6o3YsRnsrNs4bGJPamDyAOOh21oTEWELNCL6nQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794819346;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=M2Cd/fzl3O9NVYskbVZ05Fvon5yO4+XmeF/4IQ6BoUg=;
	b=i5PLu/2xCiEFu6bnXVdBTVZbdLcc7xl7daEswXIl5s93KDHYrjzFfWXtQN9eKxIiS4HX
	 ku6utO938y4HJb08eT/M+CeqLVMPmHV5N47sMuOhrhNWvmcXRTBPGwwCjwhgffQj4rAnx
	 p3flys3JJX8uyOJpsouJCOjNY07XJTAp9ldr/8AThIMdcSSPVil2x3RPlJ8TXmTYUPEH7
	 NjuslkBDk64AqCahK0yXe1LSjHEdXDpx0qSJAlQZoJEIp5QrWK308UcPzhFa/ePxxXnXn
	 Dy6i0dDl6pKJryaFNYTdg10JNkxaq9FpSXbqsktKWcFxgjnlXgZCBS8niB9JRzfKI4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ftMKqDkF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B69606A31C;
	Mon, 16 Nov 2026 08:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ftMKqDkF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DE7E1F000C5;
	Mon, 16 Nov 2026 08:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794819345;
	bh=M2Cd/fzl3O9NVYskbVZ05Fvon5yO4+XmeF/4IQ6BoUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ftMKqDkFwUM2mdn2SAzqG+kDZWGH5IN4dtt4m3yP7OAoaTSzn21ZQvwFrixoe40cS
	 4D0CPxZSx0+rATBqa+/YLp7E9xkxW/w6ABTblYcHhqyFAH1lYh2jNT9AN4aqDxzgGK
	 Xyyf/SqR91FkRxKpbCsoDoCNA4KHSmLrAw2D1oUNN2ggFNG90DvspbnLbxIqsHZlOT
	 YOvteIiXkTc/Yu+ZC1o2cT20vjSuL7Nf4Ky1OlJpG9Z4o5uEKXyoHz87NeaJPkuFgm
	 LNhbe+Amzq77BAXrLTcUfMKRtNujxfYI40C7imNZja6xUkzlzxSbnuTv3kuuTX6PlI
	 iXVVihYhYEpGA==
Date: Mon, 16 Nov 2026 09:55:43 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: phil.williams@advisoft.co.nz
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Mario Tesi <martepisa@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: fall back to 25 us/tick without a
 trim
Message-ID: <avrFD8e4UlKOB4NB@lore-desk>
References: <20261116-st-lsm6dsx-ts-fallback-v1-1-8ace30afbfb5@advisoft.co.nz>
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
	protocol="application/pgp-signature"; boundary="q4mxlm3H+1foX6aA"
Content-Disposition: inline
In-Reply-To: <20261116-st-lsm6dsx-ts-fallback-v1-1-8ace30afbfb5@advisoft.co.nz>

--q4mxlm3H+1foX6aA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Nov 16, Phil Williams via B4 Relay wrote:
> From: Phil Williams <phil.williams@advisoft.co.nz>
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
> ---
> Resending inline. The first copy went out as an attachment.
> No code changes.
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/i=
mu/st_lsm6dsx/st_lsm6dsx_core.c
> index 823f8ac66..98db90a30 100644
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

I guess the patch is fine but it seems a bit weird to set .ts_sensitivity to
25000 for ST_LSM6DSR_* family in st_lsm6dsx_sensor_settings array and keep =
this
chek here. Is it better to just add the missing info in
st_lsm6dsx_sensor_settings? (I do not have a strong opinion about it).

Regards,
Lorenzo

>  	if (ts_settings->freq_fine) {
>  		err =3D regmap_read(hw->regmap, ts_settings->freq_fine, &val);
>  		if (err < 0)
>=20
> ---
> base-commit: fa2933aac170dd19c6a7f0d7b81a8f537e40915c
> change-id: 20261116-st-lsm6dsx-ts-fallback-cd21f1d1e30e
>=20
> Best regards,
> -- =20
> Phil Williams <phil.williams@advisoft.co.nz>
>=20
>=20

--q4mxlm3H+1foX6aA
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCavrFDwAKCRA6cBh0uS2t
rI/sAQCiCsNX173ffA9ITmOLAEYruHgF5MDT7ls3JNqzH5PuyAEA1eASHMyl7Ic0
IVauaQku25XmnOGI5KyZdSXYeHjNUAM=
=d7zS
-----END PGP SIGNATURE-----

--q4mxlm3H+1foX6aA--
