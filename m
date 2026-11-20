Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795176782;
	b=mNljtiu51mmKhF9jmWNZobaYbT9mqUjHAmVibC4X8E1SwnzZYvIrHU/zNKOn/4768PVu
	 5lSdi0qhE5lU6JI04FU/ke6rtymSzEPyWmmcwWpwziVV3y0ckpcQIvyq1cZXOns0f0SIO
	 FuI9suZSh40pM7I2O4HYPWjT3oMNPzg4GzdXEWCJlwJ3aWo39vVSSfqsfsnV8mRnti2Qm
	 z6lwPEujCQW86t3etXsFs2brZOer7cY1wJ+DAtNMrre+MC5W2FJOYq4qmr9Pl7j3b1zJ5
	 JS0pRknhCZi09SS8mr16gn61BOIpp+ClytPMbhk0n6vyKnWrR0SENvSFzZIaWU9XZuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795176782;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ha/HIPyjbyejWB583GRHAkEiDBBqMXyy2GBchphEkzY=;
	b=TVJs1Qp5txfDFQN5GgfUd6gL+aTiXdeHspzAXVvFdWNmMoI7uI79z6SpKkbXapJCEglI
	 NQ6lY4c3TxZq+g7UiWFAEdnYIpC1iIx9YjwifkRIyyhDdDlBQ2hcDpIv1+WD8va9cPG/V
	 So0REIqnC1Rb+90/aEjdvhWGY3uzB+/Agq3C7SHuLNqNifpP0mUjpL+NiuFPgVPddurAF
	 wwq5yV0Z/pjXUzavIQrGaXzV/Pq9XyY6sv5Z1rPhxqpagIliSQh2ENhf9npgjfcr6xBQz
	 /PYaDIklN2XuXYE2nfbmFqj0EJfSJgtd3m7S/8TBHY0I/8tZJ2paNZATr+2Sa+FXVfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WuOst7cw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id C1AAC606A333;
	Fri, 20 Nov 2026 12:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WuOst7cw
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 6874E1F000C0;
	Fri, 20 Nov 2026 12:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795176782;
	bh=ha/HIPyjbyejWB583GRHAkEiDBBqMXyy2GBchphEkzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WuOst7cwpMEZCvVFgd4xC3oos6k09EFCLdlRuwAsf7ou9tU38PrBXsXgYNCSVmwiz
	 z0aCrAtouh502CZk5InG2i3uIL+wkz76+rSRIFurwERFfDYWseOLx6kyys7A6gSuvx
	 H96IKQsGTwlOujGK+2+yyMpj7xiAA8ALO2nnc2Of+tVTqHPGI/gHWfbTvYF2M7RnYX
	 VdVh62lDbI4wvV/oK6Pdk3HunEMKjGCKxE/uRfywdu99hRTCT4fbsq88saLyEU4BLF
	 6AR+IHgLKVS3gVd6L7y/oIRaERQFnKT6ZrdrYoB+3cqeWwxwfSdbSPavTAif8xnb06
	 EzsApg8vfLIig==
Date: Fri, 20 Nov 2026 13:12:59 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Shawn Guo <shawn.guo@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-pwm@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/8] pwm: mxs: Return early when disabling and fix
 error-path clock leak
Message-ID: <awA401UihKFTbVaK@monoceros>
References: <20261105143847.2559586-1-lee@kernel.org>
 <20261105143847.2559586-3-lee@kernel.org>
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
	protocol="application/pgp-signature"; boundary="4wybzqijlhfywcig"
Content-Disposition: inline
In-Reply-To: <20261105143847.2559586-3-lee@kernel.org>


--4wybzqijlhfywcig
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/8] pwm: mxs: Return early when disabling and fix
 error-path clock leak
MIME-Version: 1.0

On Thu, Nov 05, 2026 at 02:38:04PM +0000, Lee Jones wrote:
> When disabling a PWM channel (!state->enabled), the PWM core permits
> state->period to be zero.  mxs_pwm_apply() currently falls through into
> the period and duty-cycle calculations even when !state->enabled,
> causing do_div(c, state->period) to divide by zero when state->period is
> zero.  In addition, if the requested period exceeds the maximum divider
> (div >=3D PERIOD_CDIV_MAX) while the PWM channel is currently disabled,
> mxs_pwm_apply() returns -EINVAL without disabling and unpreparing
> mxs->clk.
>=20
> Handle the !state->enabled path upfront and return early, and balance
> clk_prepare_enable() on the -EINVAL error path.
>=20
> Fixes: bf29c2ff82fd ("pwm: mxs: Implement ->apply()")
> Closes: https://sashiko.dev/#/bug/linux-710f863f-6964-4e4f-990a-e5043dbc1=
a87
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  drivers/pwm/pwm-mxs.c | 32 ++++++++++++++++++--------------
>  1 file changed, 18 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-mxs.c b/drivers/pwm/pwm-mxs.c
> index e1a3df6549fc..16233764fd3c 100644
> --- a/drivers/pwm/pwm-mxs.c
> +++ b/drivers/pwm/pwm-mxs.c
> @@ -56,6 +56,14 @@ static int mxs_pwm_apply(struct pwm_chip *chip, struct=
 pwm_device *pwm,
>  	unsigned long long c;
>  	unsigned int pol_bits;
> =20
> +	if (!state->enabled) {
> +		if (pwm_is_enabled(pwm)) {

Please don't call pwm consumer functions from the lowlevel driver.
Currently there is no locking in pwm_is_enabled() (as it only checks the
last state that was applied and not the actual hardware state), but this
calls for trouble. So either check pwm->state or even better the actual
hardware bit.

> +			writel(1 << pwm->hwpwm, mxs->base + PWM_CTRL + CLR);
> +			clk_disable_unprepare(mxs->clk);
> +		}
> +		return 0;
> +	}
> +
>  	/*
>  	 * If the PWM channel is disabled, make sure to turn on the
>  	 * clock before calling clk_get_rate() and writing to the
> @@ -67,9 +75,6 @@ static int mxs_pwm_apply(struct pwm_chip *chip, struct =
pwm_device *pwm,
>  			return ret;
>  	}
> =20
> -	if (!state->enabled && pwm_is_enabled(pwm))

Oh, calling pwm_is_enabled() is prior art :-\

> -		writel(1 << pwm->hwpwm, mxs->base + PWM_CTRL + CLR);
> -
>  	rate =3D clk_get_rate(mxs->clk);
>  	while (1) {
>  		c =3D rate >> cdiv_shift[div];

Best regards
Uwe

--4wybzqijlhfywcig
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmsAOUgACgkQj4D7WH0S
/k6CCwf/aI0uzeINZBznaAblpm51Dl7ZmWJqaoBuK5nyAOqbeRcXQ/pifFm41Miw
kGHTvXE8i4WorWu7o80RBB9hSvAv5Kag19OBLf3gqrRaZpUmQr58X+BVd0hlv9dW
CsYxvC4j450cZjy4H2ny2p0YybbnVGfYXvRXBwgV9lnUFfwrOSyJdBvBY1lmN3JY
vUnVyBILFhi2C72B3jLmF+tz2B2WgPPnN/AvQO4dW9yMOgKRT9NAPJtHl89XJIys
HdriNW6JgHsg6jUmO1ba4mFdaSFg41n//W+PbBXV4t9W4G9LcFRjDUDR33Of1n3i
BIewAhysMOSCzawWN7YXA7j+CIVmBg==
=vMBo
-----END PGP SIGNATURE-----

--4wybzqijlhfywcig--
