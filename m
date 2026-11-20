Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795176372;
	b=DXsWkXTD9sl0eDIOnlal4EB32jcmetwyCWAyIZWWTi8tS8HaDZFnzTS8YWRfvAjhnqvO
	 KxnVv3Coj+78RvXQP532uHllhzQtggZvewUhiUBjuElbhMUQ2jQhToGaInuEKKGkeUaMx
	 V1odNWUWgDPuz6O/IyVLWZA2O5uswzAdb938zKCI2QbY8EvaOj30blZiO/UCPj2oJ3J3I
	 9VmCYA5iBZC1qlIFbAGoqrFgaz8hzYRNXhdxhNFDxAHMucIOsFvqRF2MTaQU3LH4QPMei
	 44N3I0SMzkSQs/KfyevMAdL8+mYOJqEXzjduR2V/fnS7cSWb/Pq44wA+H8jc1oDYwHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795176372;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=VZcbeVDdlNi18JiKSg+eWjVY4TeiiYK+J+UD2JmK1rw=;
	b=YP0YvU+fvSVRIgd3Kng0Jb2/o6YAQhMBg2cTRaZNv8xxXFfD4SZXMH/s+EnhIfWhZyeg
	 YlFScnO82s4ZGLU38//rUeyY+Up3XYGHrznfczCsM1uWKggyeVLafD+SsdJqcW07F4QSs
	 B8/dayfiOr+ZUqYpBkEji0SsdWvCUJtN8NGV+EQdwzSwbbZDEMhjRE9NCXf7cLXm4tlgF
	 IWQCzuQhFwPp3CHwwFmmY833rV2OVGJShrbbCB9cEVell7Mq0clb/HbL/6dpQnoRqm1Lf
	 WMQtTuuOlQgAlW7cIZUdqhLTXJ5cUJ5e8MRMNTg0403/lrQhTyGWLBqEnVc1vj0AHXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dj1I9gbO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id A840A606A320;
	Fri, 20 Nov 2026 12:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dj1I9gbO
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id DCD781F000CF;
	Fri, 20 Nov 2026 12:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795176372;
	bh=VZcbeVDdlNi18JiKSg+eWjVY4TeiiYK+J+UD2JmK1rw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Dj1I9gbOcUktcP3XTHqIIzS3XhiqpnOQzQ99On8eXfO29UtqD1/i6OhMpILa4lUsz
	 MocLAdjEfLu3Z1wkHpw7TUSss/tbSfsQ0guF0N5eleAmotZ0sjsqkrVmb/bHq7ypVX
	 TJXr4AfoYpcPARr9+/8FiwQ34N09IiHj21frDV45NTD5w/ML30+FoOMqdUtY6sCk3j
	 QWtQKuKeMdQz8BteW0utOV1XjtvKOmti2nr42G+H6EdA1OKQJDCDBFmUxWz5vhEIAa
	 86bSXqGdAdp6jpamqwSvUO/eN7g/wUvfSK+2ha51T4AUur42lLDQNxz0GLsmNOL5YR
	 ndKZNASxyDy0Q==
Date: Fri, 20 Nov 2026 13:06:10 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: "Philip, Avinash" <avinashphilip@ti.com>, 
	Vaibhav Bedia <vaibhav.bedia@ti.com>, Thierry Reding <thierry.reding@avionic-design.de>, 
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 7/8] pwm: tiehrpwm: Enable runtime PM before registering
 PWM chip
Message-ID: <awA3Cfrm8lHE2uLH@monoceros>
References: <20261105143847.2559586-1-lee@kernel.org>
 <20261105143847.2559586-8-lee@kernel.org>
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
	protocol="application/pgp-signature"; boundary="52p67fuekkm3a7ph"
Content-Disposition: inline
In-Reply-To: <20261105143847.2559586-8-lee@kernel.org>


--52p67fuekkm3a7ph
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 7/8] pwm: tiehrpwm: Enable runtime PM before registering
 PWM chip
MIME-Version: 1.0

Hello,

On Thu, Nov 05, 2026 at 02:38:09PM +0000, Lee Jones wrote:
> ehrpwm_pwm_probe() calls pwmchip_add() before setting driver data and
> enabling runtime PM.  Because pwmchip_add() immediately exposes the PWM
> channels to consumers, a consumer can invoke ehrpwm_pwm_apply() before
> pm_runtime_enable() runs, causing registers to be accessed while the
> device remains runtime-suspended.

Is this correct? Until pm_runtime_enable() is called the device doesn't
go into suspend, does it?

> Set driver data and enable runtime PM before calling pwmchip_add(), and
> disable runtime PM on the error path.
>=20
> Fixes: 19891b20e7c2 ("pwm: pwm-tiehrpwm: PWM driver support for EHRPWM")
> Closes: https://sashiko.dev/#/bug/linux-28b36a80-e4a9-4bb6-97bc-7ca028955=
70a
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  drivers/pwm/pwm-tiehrpwm.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
> index e3407d0a1f7f..f9dd3b91c73a 100644
> --- a/drivers/pwm/pwm-tiehrpwm.c
> +++ b/drivers/pwm/pwm-tiehrpwm.c
> @@ -461,18 +461,19 @@ static int ehrpwm_pwm_probe(struct platform_device =
*pdev)
>  		return ret;
>  	}
> =20
> -	ret =3D pwmchip_add(chip);
> -	if (ret < 0) {
> -		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
> -		goto err_clk_unprepare;
> -	}
> -
>  	platform_set_drvdata(pdev, chip);
>  	pm_runtime_enable(&pdev->dev);
> =20
> +	ret =3D pwmchip_add(chip);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
> +		goto err_pm_disable;
> +	}
> +

If you switch the order here, it would be awesome to also switch in the
=2Eremove() callback to have the order match.

>  	return 0;
> =20
> -err_clk_unprepare:
> +err_pm_disable:
> +	pm_runtime_disable(&pdev->dev);
>  	clk_unprepare(pc->tbclk);
> =20
>  	return ret;
> Cc: "Philip, Avinash" <avinashphilip@ti.com>
> --=20
> 2.56.0.398.g882cbad275-goog
>=20

--52p67fuekkm3a7ph
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmsAN7AACgkQj4D7WH0S
/k6ZMAf/Sfja5kwJbbnFMEzKlPXRu5nvLwz6Cl5huAWiTMh8OUPEmcGsJjd88Ul5
0uJQwE4mFuzjJFtKScfdJWc+gwYlzZwhN4vel1E5Vu4FbjaFSrHqrhAEhvsfzJSj
upQzhfNcNa4u9Uz1Y+6p1QfHYHog533WUK/DCGypFDQ93LqHGu+hheXPJKmSQClf
0AuWmEUZuAG2pxaeaCw7a2JsTbuJ2gDcosrezGQjMWFNMLJuCNNOWtumR9EGXLHR
NDqbnhSZ/4X4z6MN0Yrr1XGkTNGRdkbQ4nry2ILMDRi6gFMgVyTcYtAzC3Jwh6w9
nhUwFMtmTLCvBWbD6kGiqLwj3swg8g==
=U410
-----END PGP SIGNATURE-----

--52p67fuekkm3a7ph--
