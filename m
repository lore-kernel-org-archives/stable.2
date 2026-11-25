Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795594320;
	b=u4126Ch5N/2P8AzjyrBa2jeZLEUumw0bOIsOpBScEWJ2putl+hd3IizL+iODmOs4UMh7
	 3lftynA8wqDePp0Y+fwMPwBYcMYEnqO6XHB8ryG5tZhUrqihGLdIr9DsPWE61tWQfblsZ
	 OVtTr9N630db85jpd+nLsGyrJ93uRLn/iwzCqC8LSG4zMJsa/kRl2kd6UzHKeB+ojQnmD
	 SJUyeVlEUnokfJhpN15RCJQiUqYIvEuaOhNDDach7R0k07UlhM0+VtYlW3H8lPB7JBTn5
	 QQDlkOvWKdaJpon1CcG0O9l281EVIBatOEGpBbiUcD9sGSJDGYITNWJrf68N6O7h7Rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795594320;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=60qPSuL02yf4E8cV0OFKfMQ2IwLGtFiY03C+ToXioh4=;
	b=GK1Dr3TmgfUEcJ+vg+kzDC1wV7q0LaO+Tho1BaN9IKGEbPzVNRtzd9mptNa2OcvyFOFC
	 zt8o8qu7t7sgo1tG0WSgEgc0xaWtiWOw4uz5y+7TzaXjEKKhB+4Xbs+8aNZ0JeOIWAbbt
	 pPflYeN4VZrWSDitnm0j0BZXLmwQSk6FebWLkWoX6lQDRuMEyz0E7BSHt0vzFeBE79Pbw
	 PoJ5wBmjeMQcFG5pOjh+spz6cQX6J+gwYpb90305xBq1i5oCeMRBZd/XGiO2Y9PL7yBR+
	 /4P8OuXJqOTwhbUnHjMkyqjurJ1jsLdYx5ehRXrPEs/vijTiMTpzi2eCdSN7Fh9v3JA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DHHMqsvV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D777E606A323;
	Wed, 25 Nov 2026 08:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DHHMqsvV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC5E1F000D1;
	Wed, 25 Nov 2026 08:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795594320;
	bh=60qPSuL02yf4E8cV0OFKfMQ2IwLGtFiY03C+ToXioh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DHHMqsvVzThMCz+StJjIJHdtI1IthlXZywrIf+n/gm1K+FQVthJamxxVxkkG01UU0
	 r2LvKrj0cxj729fHoKBqif5Ai6zRuF6Rnku6m/kIjTHBVjfj5oMk0txiDHga9wpsPi
	 Z0IiIvtZAdSrWvE9ptIN5ElABw0gVuAn+nNdjeqXXT5IPxR3BTkmAQJxF9oMovdSFo
	 qHHnaxbzqrAnROpJK2JSAKvDYhn1IfDKCnWhdjdX5bgWvnolCvw/C707dsl5KDjkTg
	 ahHthuJoG+ToChVe5FQhz/CjLnNkK2NEh0ae2S5TZkiU/mSsiPwPlm6h+KgNrVfrIU
	 uJNHzMsXfY2Yw==
Date: Wed, 25 Nov 2026 09:11:57 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: phil.williams@advisoft.co.nz
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Mario Tesi <martepisa@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: imu: st_lsm6dsx: set ts_sensitivity on parts
 without freq_fine
Message-ID: <awaYTa63V-LnP-T-@lore-desk>
References: <20261125-st-lsm6dsx-ts-fallback-v2-1-ea0ea2512070@advisoft.co.nz>
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
	protocol="application/pgp-signature"; boundary="GTDYvITx/AJlzXec"
Content-Disposition: inline
In-Reply-To: <20261125-st-lsm6dsx-ts-fallback-v2-1-ea0ea2512070@advisoft.co.nz>

--GTDYvITx/AJlzXec
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

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
> Set ts_sensitivity to the previous fixed scale of 25000 ns/tick on
> those entries. They have no freq_fine register, so ts_trim_coeff is
> left unset and no trim is applied.
>=20
> Fixes: 8abbf45fcda0 ("iio: st_lsm6dsx: Fixed calibrated timestamp calcula=
tion")
> Cc: stable@vger.kernel.org

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> Suggested-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Phil Williams <phil.williams@advisoft.co.nz>
> ---
> Resending inline. The first copy went out as an attachment.
> No code changes.
> ---
> Changes in v2:
> - Drop the ts_gain fallback in st_lsm6dsx_init_hw_timer() and set
>   .ts_sensitivity =3D 25000 in the LSM6DS3, LSM6DS3H and LSM6DSL settings
>   entries instead (Lorenzo, Jonathan).
> - Leave .ts_trim_coeff unset on those entries since they have no
>   freq_fine register (Francesco).
> - Link to v1: https://lore.kernel.org/r/20261116-st-lsm6dsx-ts-fallback-v=
1-1-8ace30afbfb5@advisoft.co.nz
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/i=
mu/st_lsm6dsx/st_lsm6dsx_core.c
> index 823f8ac66..dffaf76b5 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -434,6 +434,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_se=
nsor_settings[] =3D {
>  				.addr =3D 0x09,
>  				.mask =3D GENMASK(5, 3),
>  			},
> +			.ts_sensitivity =3D 25000,
>  		},
>  		.event_settings =3D {
>  			.sources =3D {
> @@ -601,6 +602,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_se=
nsor_settings[] =3D {
>  				.addr =3D 0x09,
>  				.mask =3D GENMASK(5, 3),
>  			},
> +			.ts_sensitivity =3D 25000,
>  		},
>  		.event_settings =3D {
>  			.sources =3D {
> @@ -802,6 +804,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_se=
nsor_settings[] =3D {
>  				.addr =3D 0x09,
>  				.mask =3D GENMASK(5, 3),
>  			},
> +			.ts_sensitivity =3D 25000,
>  		},
>  		.shub_settings =3D {
>  			.page_mux =3D {
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

--GTDYvITx/AJlzXec
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCawaYTQAKCRA6cBh0uS2t
rNj6AP0ZLLu+r9WFBN6TAHJvfaI+XaWS6Iox74yGJGLRxbjbkgEA0MVKYd/uZCGS
T6tY+qZXRIX+NwszYmhuddioXSuVNAI=
=EB38
-----END PGP SIGNATURE-----

--GTDYvITx/AJlzXec--
