Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795176619;
	b=h6IKJrnYkGogLV/NcI3hLnEVAycs+jfnlUvKjvSJfecXeFVAr7QLmPDVPMzZKNj7jPTZ
	 rxZ9Bmmtul25g1/Iv0TNWFL0U1scM4UkTABR7qQQMLy+crLnCB71i62XdeaS8+IkPNrzb
	 ZMn9Xftw0SxAF4eS4Gjr0FMrregUlwNe0mglkEv6548PqzG/PgcsKbM7nAhNZ7huKeBP/
	 PoGSfLfruZjOcj2idI91YT3F9QH2VxZ360oMa0x6OVE9Yxj8OYgJa6gn0NSekbEjevYak
	 LUnjywTwVNJyU/ZPRH0+LaX1I7Mv2KuX8VEO4deuJBiJ0wJhzd4o9JsTJH9rF9Ttdqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795176619;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=OZM/Uif+28MxtYuf2zI40DsRkEHT3FiizYascYVYBcE=;
	b=xeb+tABf5XiuLSjMSBmdSgPENmkq/FnuQUw7OtFRA0EzlJgV3jPZI8iD4AZL0Olib3b9
	 4pSl5yyaG6sFw2omB3llvk0CviF2tGm2fKydn2BXkaqLT4QWuX0ab7ewp+j7ejxf/0Mji
	 PUzsZqNYN1UzGdsMH51xLJio6S9jzyaWmeA1YafK9nT3ET1hTomkjbKYYQMJkzm64JSEL
	 gr0NUsnXGZgBV/qEumZIUPBm+vXtRaWojDBG7w3sLC62pHnISpqzoYBUH/v7vblKRcl7o
	 7CX4InbcAi01VdFGEKHuj7xXLslFRTkZAeJ+X6P/H8ZRsJyDR8zjcTvt96g+h+iXHmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GTvf18ns;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 43950606A326;
	Fri, 20 Nov 2026 12:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GTvf18ns
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 07B741F000D0;
	Fri, 20 Nov 2026 12:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795176618;
	bh=OZM/Uif+28MxtYuf2zI40DsRkEHT3FiizYascYVYBcE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GTvf18nsUMjgCO1qA0UvBcA0HvfshOO3/rbiWXPX9OAsm+9wqHZ9TbfmL26Z5Ge4X
	 QXT+Nzc5QfhZzMT3m+or2998ZgSBmdeAl2mV6P6pUafbiR3KyBRmcykSAbuVLM/jt7
	 hLGXekfTwviU6d/pdwj36JK3aSy99W3wNS+f6CPxmOjTr7EY64gG4Sx7ZLOtvWWYZ4
	 ADZTLIh9IcB444Nh2GAMgsimq4TDw7+JyYfrlMRU/rj7Df+0XCU98XFZ7BVVwy2l1h
	 uanpB6cHZmOvs12h8mLVkNYNYOeCsR2W2JTcwx/shB64dGKr77HaaPhS5AQacXlIuq
	 nVuZYnAiboEjg==
Date: Fri, 20 Nov 2026 13:10:16 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: Sai Masarapu <Sai.Masarapu@imgtec.com>, 
	Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, Naidu Tellapati <naidu.tellapati@gmail.com>, 
	Ezequiel Garcia <ezequiel.garcia@imgtec.com>, Thierry Reding <thierry.reding@gmail.com>, 
	Andrew Bresticker <abrestic@chromium.org>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 8/8] pwm: img: Unregister PWM chip before disabling
 runtime PM and clocks
Message-ID: <awA38Fw5qLMCTjHP@monoceros>
References: <20261105143847.2559586-1-lee@kernel.org>
 <20261105143847.2559586-9-lee@kernel.org>
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
	protocol="application/pgp-signature"; boundary="p2ptfglb6mcpggnw"
Content-Disposition: inline
In-Reply-To: <20261105143847.2559586-9-lee@kernel.org>


--p2ptfglb6mcpggnw
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 8/8] pwm: img: Unregister PWM chip before disabling
 runtime PM and clocks
MIME-Version: 1.0

On Thu, Nov 05, 2026 at 02:38:10PM +0000, Lee Jones wrote:
> img_pwm_remove() disables runtime PM and gates the peripheral clocks via
> img_pwm_runtime_suspend() before calling pwmchip_remove().  While the
> PWM chip is still registered, a consumer can call img_pwm_apply(), where
> pm_runtime_resume_and_get() returns -EACCES or succeeds without
> re-enabling clocks, leading to unclocked register access.
>=20
> Call pwmchip_remove() before disabling runtime PM and suspending the
> device.
>=20
> Fixes: 277bb6a29e00 ("pwm: Imagination Technologies PWM DAC driver")
> Closes: https://sashiko.dev/#/bug/linux-b06bab8d-dbf2-4ba2-9f5d-c5e141076=
abd
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  drivers/pwm/pwm-img.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-img.c b/drivers/pwm/pwm-img.c
> index 91e0b19f0c08..b6e090674c07 100644
> --- a/drivers/pwm/pwm-img.c
> +++ b/drivers/pwm/pwm-img.c
> @@ -338,11 +338,11 @@ static void img_pwm_remove(struct platform_device *=
pdev)
>  {
>  	struct pwm_chip *chip =3D platform_get_drvdata(pdev);
> =20
> -	pm_runtime_disable(&pdev->dev);
> -	if (!pm_runtime_status_suspended(&pdev->dev))
> -		img_pwm_runtime_suspend(&pdev->dev);
> -
>  	pwmchip_remove(chip);
> +
> +	pm_runtime_disable(&pdev->dev);
> +	if (!pm_runtime_status_suspended(&pdev->dev))
> +		img_pwm_runtime_suspend(&pdev->dev);

Calling pm_runtime_disable() might result in a call to
img_pwm_runtime_resume() (does it?). In img_pwm_runtime_resume() we
have:

	struct pwm_chip *chip =3D dev_get_drvdata(dev);
	struct img_pwm_chip *imgchip =3D to_img_pwm_chip(chip);
	...

which doesn't look like an operation that should be done after
pwmchip_remove()?

Best regards
Uwe

--p2ptfglb6mcpggnw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmsAOKUACgkQj4D7WH0S
/k7O3Qf/YFRqu52F1CnKflVo2wQfaJD5ERESo6SqxkftYjqm8xqYQJC7KwaJeXxt
7Ia6ab0oFQ9BACanMqtGXE825/ySEtPcjxtWKEWLsHNvGQPLep1kfQ48wrxa5V3R
UfGOhCWoykw8LZTUlatXCMC44Eq5zP7oCSMuLvbW/g1sTnLDLnHTqs4ADoeqn1xO
MYi8ZsDK3YkfYnf/mmJTDhe9uGAOgEg/QyfY5Lh5NvvDLod2d0Bc7nkjvpK1rzSo
yyWt4PwNpVpeeIRY9eOtQPrLnBSP61pLBv953zkhn0yUudGYsNQNnHL3sk5iBKKp
17tR80u2KnWOqWvGFp3fgLU+Jjd3lQ==
=5Ba5
-----END PGP SIGNATURE-----

--p2ptfglb6mcpggnw--
