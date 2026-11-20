Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795176148;
	b=jcUfgJHfb4vLNHCf0Ooobt+v8jLR4BCxg9NJ0E8MyQ62fHzAqR1Mnu1G34hARqGr9kDp
	 i9blVnEkJ5ORWbhfcaVmZN4SP545jMVJpuIraZiMA8u//04Nozc2Z5CTLYakD6gyWHkdg
	 oFlwq79yP3gXXEjHaAX45MU/pE7Kyffh96gE2u1M4YH/2SdfH6g5T8jE81TIB1o9LvExM
	 JCVFY8qJjjMNehcXo0cZ6iIuLaWk4daqC/pyHmOAcv9uWSOQ3rjUDDzwlz0ejADDlSuXt
	 UbB+cpTyrUR30xplHLt3roLPxFcvWm1woHyN5LAsToCbNOvsIKCKQB7hJj7wRQwJ1OA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795176148;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=13zlqOS3b0U2kguoYE8OSQ7Fm1GjIlugayn5h12WyHM=;
	b=QzUC5o/eO8MQXh7Yc5i8vYlrJagjje8GiN7wzd9ko97VZXfEkBbq5w8CToY5g1kV71lM
	 OIH8yQanqMrOjg92kUjCsA1uVTvkJeysveGkFbVamdtMPdE/T/yVX1BLFPRSJX0clh1rf
	 aBXbzOBArZ3YCW7VRg5nomO5cRyiPYpPu689/IYqR+1W7tf8qItnKGVkVEr7nS7YcR1p2
	 q7UojoXoPMs6w1F+cvkgowCMXoScjljFEYacJPMWz6bA9t9lpnT2So99NO76TLqe5e7Zt
	 sQLL79mxxEseKQ4a8LEuZnZlPQeRS7IHyRyZmuAA738UGmSoY69fpelfX6KEEx5Y8TQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZcpMLcME;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id D5823606A325;
	Fri, 20 Nov 2026 12:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZcpMLcME
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 5D45A1F000C0;
	Fri, 20 Nov 2026 12:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795176147;
	bh=13zlqOS3b0U2kguoYE8OSQ7Fm1GjIlugayn5h12WyHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZcpMLcMEbAY+S3wXb99cEd/F7U+V9nu9cy1Zlrznz49Aw4M31a35sL+uGnzl/ODh7
	 /2NJ0A9XJZX1p6tExNppfCGcBtoZ8A7tvDEJfZydxJK8I8PeHKyyeHbj00ITc9ahC7
	 izw7Ar4TqtOAWu0GYcE0D7Tf+pQQeqvDRLaKJGdrUjNW8za0yJ4IdaGDqeB3/4V0Sx
	 e9xonZxCPakI2ivw7l8Llejrd0Po5eRzoSAVUiVbSJIirC/clLmys0Evw8Fcm8ZwZV
	 CI9PmGAZqAHERtVBTfozqxJkQK7xYp4jtHBM17gA3ftJo+ouBhfNi7s4Zi0TwPHQRK
	 SVGpbw7t3HKEA==
Date: Fri, 20 Nov 2026 13:02:25 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: Xiubo Li <Li.Xiubo@freescale.com>, 
	"shenwei.wang@nxp.com" <shenwei.wang@nxp.com>, Thierry Reding <thierry.reding@gmail.com>, 
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 5/8] pwm: fsl-ftm: Enable ipg_clk around regcache_sync()
 during resume
Message-ID: <awA2gqJ2c8QlsmRu@monoceros>
References: <20261105143847.2559586-1-lee@kernel.org>
 <20261105143847.2559586-6-lee@kernel.org>
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
	protocol="application/pgp-signature"; boundary="h2wqbny5kqhqb4am"
Content-Disposition: inline
In-Reply-To: <20261105143847.2559586-6-lee@kernel.org>


--h2wqbny5kqhqb4am
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 5/8] pwm: fsl-ftm: Enable ipg_clk around regcache_sync()
 during resume
MIME-Version: 1.0

Hello Lee,

On Thu, Nov 05, 2026 at 02:38:07PM +0000, Lee Jones wrote:
> On SoCs with a dedicated IP interface clock (ipg_clk), register accesses
> require ipg_clk to be enabled in addition to the ftm_sys clock managed
> by regmap_mmio.  In fsl_pwm_resume(), ipg_clk is only enabled inside the
> channel loop for channels with PWMF_REQUESTED set, so if no channels are
> currently requested, regcache_sync() writes to the hardware registers
> while ipg_clk is disabled.
>=20
> Enable ipg_clk across fsl_pwm_resume() around regcache_sync(), matching
> fsl_pwm_init().
>=20
> Fixes: 82a9c55a2bb0 ("pwm: fsl-ftm: Added a dedicated IP interface clock")
> Closes: https://sashiko.dev/#/bug/linux-858851cf-55a9-4776-883c-69c05f396=
1f2
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  drivers/pwm/pwm-fsl-ftm.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
> index 35406b2e1925..9e5470e2efe6 100644
> --- a/drivers/pwm/pwm-fsl-ftm.c
> +++ b/drivers/pwm/pwm-fsl-ftm.c
> @@ -501,8 +501,13 @@ static int fsl_pwm_resume(struct device *dev)
>  {
>  	struct pwm_chip *chip =3D dev_get_drvdata(dev);
>  	struct fsl_pwm_chip *fpc =3D to_fsl_chip(chip);
> +	int ret;
>  	int i;
> =20
> +	ret =3D clk_prepare_enable(fpc->ipg_clk);
> +	if (ret)
> +		return ret;
> +
>  	for (i =3D 0; i < chip->npwm; i++) {
>  		struct pwm_device *pwm =3D &chip->pwms[i];
> =20
> @@ -522,6 +527,8 @@ static int fsl_pwm_resume(struct device *dev)
>  	regcache_cache_only(fpc->regmap, false);
>  	regcache_sync(fpc->regmap);
> =20
> +	clk_disable_unprepare(fpc->ipg_clk);
> +
>  	return 0;

Just from looking at the code (i.e. without the commit log available)
it's not obvious why the clk_enable is needed. Can you add a comment and
maybe move the enable call to after the loop?

Best regards
Uwe

--h2wqbny5kqhqb4am
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmsANs8ACgkQj4D7WH0S
/k6iTAf+Ja3v9gvzY8CSfu/joNMKMZnM0i5O9+uXbyzIpQ3FhR+TrCYeGB1RgHB8
ZXezlHq23Zw3javd12ByZmkRGpYPFwAB8wT7vE+11E3Zp0Xp3dO67PExVDHBNaZF
kgg3d61cbdcmMwLRNRErYy0eR9sUowm8/+tBtOMvMVKkLBN6QJYCSY0OVOLi9hMM
gkQlV9JUW1i1p5/YZpgi7oZqv0U/9N9SwcwTCkrxk9jfK5Ts26aimzrGGfyFaNy3
PQBHhp3BeE+hK+MmRjBqkeS9WwFdWmkICFRxFW9R+GxVJbHHfv0xRLUuw7OCA8et
x95md7hPWCLZB6WtPkSOB3IiNVp4Iw==
=Mcy/
-----END PGP SIGNATURE-----

--h2wqbny5kqhqb4am--
