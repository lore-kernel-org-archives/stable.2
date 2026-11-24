Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795510046;
	b=dDLXt6uCJt424PTbA3o6kM90mXyg3uhrlqBlUefqi+8SSeANmgeV8kxucs83rSW6TwaL
	 o66g4SqvClsCCuPAA0h04xEHC42DwXZme0p4y2maXLPFqlt9AoIrTYz/hcYj4ODLQUKgn
	 0LkzYlb3PoVzJzQDDpD7uD1+cqcwucIh6d7krNXF+PRNsDt0cDdN5wIFBsGMXPND8phb9
	 4G8uyiVx6g7e8MkePU76kvbC1JIR1LGN5gyGOi5hwxvjBANa51GwVVnP9hWIXexy8G5oA
	 FFugC5xF3+UyDFxqjrPjZswxneHqW4ELgsbcSKZN+zR5/mreatS8J9hFAUCw4tAtUsg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795510046;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=DYPXkbyVo7I6I6nELw212corw/FRZ2v9BlNSxZlJef8=;
	b=2dWK+mAwONPgFCwFnnD2Fz5KT1PJ0ea6l5DZnOJXW7YS49IsyhZFjfG4klCn2+sJmFVR
	 4TbQGHyCZgmhIXE0rzyTK1vH6J34RfWMquFHYMPIFtZzT9jyzO56s1oAYCwlBLToLhfut
	 y1QJd1wmkESUuQh3b2rY8/da5S/Dy2wsnCGejJz97RDoZPjb7vjnAj13kjBwRo6PhQJgn
	 90+KU3Jl2v6s4FdEMeYvqHapY/3/hwfAiP7l4uH9+eMWJAZvWv9zJm4uH38gpKeOTRQE+
	 OcsOu+gR27HA2GqrDe4/GxcRbniDNxFavz3DMnHoiXUe86wxDTl9V8bdDtEIKLZIMWw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=I8ghgZjH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CD3606A322;
	Tue, 24 Nov 2026 08:47:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02CD3606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=I8ghgZjH
Received: from pengutronix.de (ptz.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::77])
	(Authenticated sender: mkl@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 0200520041D;
	Tue, 24 Nov 2026 09:47:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795510037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DYPXkbyVo7I6I6nELw212corw/FRZ2v9BlNSxZlJef8=;
	b=I8ghgZjHda3I6UwJei9788PmS1iSVMuvOyyTXaDO3XqhMMmxX470AyrvozCVqyyf0Bu0Po
	37piT1VWL4/TNqZbfz/EXJ30txwturdGcCL2iBOiim4gaKXdkQmcWRvdq5znUCQor2OZ1r
	NvYegUHaU/Fp8YoYm110YMNfOb4O3oe6kmuLjQuRf+BexFV0gXQlbWEKQL8UchP4Z2Rje+
	JR22hO0WRgAc7yyQN0bvA775wUvTnMKJ4HCoIUhYvARCPSg7VlZ2stwucC2TlHReZCrJHA
	QlF1QWzLM4HY5FVXYw7LTnKGjNq8VcKpJfqUlRARGSDOXez0fekJw3ugWWeDkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795510037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DYPXkbyVo7I6I6nELw212corw/FRZ2v9BlNSxZlJef8=;
	b=IASNyQ6ykbuBzpTURWdZL+P9Ed8cVn48Y3qmTqU/KaOHa0XhuPEAq6SskO+AyB1onSHPVu
	gKu1fkWgrs37sWtszMeL41EDN2edrO18vrOMOyDwOKVfCFf1Mk5Y5k5s/Kf9N0KLZVzXMo
	QUzDaxzRSRgSrt9tPlrlI/yzkCSL8zmpH66BGIBYu+65b7ZuUk1rLno64ghLUqx6aE6GBD
	mvwaYwdMtMBwY2JeO11X5zjTZbyVLz/mkOSK990z8ZXVfMvYO+nbjuLh9C2SBg/fieIfTB
	z6dpVOH+ijREZRMhDf7+laSt6cIb6KetW1Hdip+JKuCfxgVoOCX+0BWL59syJg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=mkl@pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795510037; a=rsa-sha256;
	cv=none;
	b=WujyuN0c+YiPfodubhSl4OlPlxsNW5As5HBWCSRj0TLc4sviDInRXRwWBxf4QZ42RNWNHk
	zQorX5b02SelyIzxq814nKugDMQCu4KHKV2T9+GryYGfsXcTTcTN4sGua1EdVPANSOKI0D
	TaHyMX7oh8ySbawQe3+t+NvM3uySSpbc09PcBr3OHVRCGSWxgi1quN9v+Nvu8Rg8osGLM/
	c7Dq0guwkqmKl3rIc203Bh89TmQ3L7+bM55IR0Fg4aJco4/hLLpvzjtO1t1zECqWANsAyX
	9LfONUA+21Y0VZaZbQaRXJpV4MOcOJP/8XX4aXkCFc0v1wW5+yanpRfEtGlxrw==
Date: Tue, 24 Nov 2026 09:47:16 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
	Joakim Zhang <qiangqing.zhang@nxp.com>, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] can: flexcan: fix runtime PM reference imbalance on
 probe failure
Message-ID: <20261124-purring-kraken-from-uranus-549346-mkl@pengutronix.de>
References: <20260915170327.2503156-1-lgs201920130244@gmail.com>
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
	protocol="application/pgp-signature"; boundary="36gkf2k7v4wktzl6"
Content-Disposition: inline
In-Reply-To: <20260915170327.2503156-1-lgs201920130244@gmail.com>


--36gkf2k7v4wktzl6
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: flexcan: fix runtime PM reference imbalance on
 probe failure
MIME-Version: 1.0

On 16.09.2026 01:03:27, Guangshuo Li wrote:
> flexcan_probe() increments the runtime PM usage counter with
> pm_runtime_get_noresume() before registering the CAN device.
>
> On successful registration, register_flexcandev() drops this reference
> with pm_runtime_put(). However, if flexcan_setup_stop_mode() subsequently
> fails, the error path unregisters the CAN device and falls through to
> failed_register, where pm_runtime_put_noidle() drops the same reference
> again.
>
> This results in an unbalanced runtime PM usage counter on the stop mode
> setup failure path.
>
> Skip pm_runtime_put_noidle() after a successful register_flexcandev()
> and only disable runtime PM before freeing the CAN device.
>
> This issue was found by manual code inspection.
>
> Fixes: 812f0116c66a ("can: flexcan: add CAN wakeup function for i.MX8QM")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/net/can/flexcan/flexcan-core.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/fle=
xcan/flexcan-core.c
> index f5d22c61503f..7d675696797f 100644
> --- a/drivers/net/can/flexcan/flexcan-core.c
> +++ b/drivers/net/can/flexcan/flexcan-core.c
> @@ -2266,8 +2266,10 @@ static int flexcan_probe(struct platform_device *p=
dev)
>
>   failed_setup_stop_mode:
>  	unregister_flexcandev(dev);
> +	goto failed_pm_runtime_disable;
>   failed_register:
>  	pm_runtime_put_noidle(&pdev->dev);
> +failed_pm_runtime_disable:
>  	pm_runtime_disable(&pdev->dev);
>   failed_platform_get_irq:
>  	free_candev(dev);

Better fix the underlying problem: Call flexcan_setup_stop_mode() and
of_can_transceiver() before register_flexcandev(). Also see this sashiko
finding:

| https://sashiko.dev/#/patchset/20260618140147.142489-2-u.kleine-koenig@ba=
ylibre.com

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--36gkf2k7v4wktzl6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCawVPEgAKCRDMOmT6rpmt
0oNNAP9B98Fql06W1PzsSOR3rDyhuytNMi7v3e0UXGo0qd2b8gEA1trf3KlVnmKL
896WuKbMzWVd6ylyKjg88dNRSjHhIQg=
=eMdo
-----END PGP SIGNATURE-----

--36gkf2k7v4wktzl6--
