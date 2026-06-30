Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C234937C0F3
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 16:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782837829; cv=none; b=XVQx8nOmva80Ip4oKgdDlIkrqxqvS7/WEPU3g+K3qXPiTmUFiPKwizsB4OnwowWk3gbs7s6x2zElql4MZrvMR0ejt3cF0+oabW/gIOxPXjeeGXew5wxLJkIkAMwTo/tSvThVBjPoxyagSWNNujsYyRoFXjr0WdKmUmDiNqRvtVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782837829; c=relaxed/simple;
	bh=p2PeC0nQIU8XGKa3S/8y6V/3/TZusI1x27XJWhQGfSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mL6rjetlV3bVKmUSoilsomxWKKFYmSBzqVmMA+jtAo5Dgcib93UmNAKpioG+U8DEqd38ms03Ylr1Qpq572GzMYsCh1LjzwDGEkVwGGMnk6uwm5C/eE4DI7Quk9AGRTTX8K9rPv4Lwe/BmaQhdvgko14Bk3ZIBXDTqw0r6KDlW/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=EQ0HU7Vf; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="EQ0HU7Vf"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-493be1b9564so1457725e9.2
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 09:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782837826; x=1783442626; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uGD+GAgzuwfHMyCvb0nP+s7ICmE38JS3rDHMHE5/jc0=;
        b=EQ0HU7Vfu2P0a4q0Xlu2Yl4zBmffwyGvvYkhZ5fRBTokS52WI1kaCFeNc3WoyZkN4y
         yh0Bqp6yvIXYu9zF0mkI5wzXMlhUYUWuTdaQs3UYBHa8LK84Iz7UslbUsmgoQGpK1b08
         H/3X9X9544cClBvnbs1Au//xr0SFKqG18a05whZUHBIvv47C0qYbzSYMH6X8Fiv9aoEM
         90WvKezdE0Deu6joBjQpbhfhrzXHnaw+biA7OcP8BDThVRQbABVU8SnmqySGzOvolwG0
         JZk1UkKH7rxI3IMXkhVPAS1q7QMDOEchT7R5+4BejVBuhwiPZKKpBTmIEQi1e9aho50T
         cRNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782837826; x=1783442626;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uGD+GAgzuwfHMyCvb0nP+s7ICmE38JS3rDHMHE5/jc0=;
        b=YLfL9ffMgcPfNviKBvEtmLWpGvusK07qqjTxVWFH3a8n8EsaCk74jiFcY5JqYMa+5o
         9szUyvz2EB3aXHdXrcrN71JwZ/b43l0TaUNQff5wjJyUH21CGiLiprJgQzOQrEQpvdIF
         9u1zPdRYAo+Gf1Z2p1z2cyZENfVxDIHChvGz5oUNgJl/zGgoQjZ/Jv12AbC4EEytkn6J
         EGR6E1kpy7pPn5QKPcVFMdxOaecvtHLhAYuAsSbJwHvDWqUCfjEhUGrQqSUi9ZoTpE3R
         58Oz7/8zv3PjaoTuwKglbOzL0U2IOSuXe7EVUlQr2ihq5PddgA+aC7L93IoI9nFqDUHo
         HStQ==
X-Forwarded-Encrypted: i=1; AFNElJ+OL7miCdYvG+YzIfg35Yn9GvXGGep4Blqn+DGCYytZhafNHFEZpk/EQScZcAWrZCQdYtlmWyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YytJWzkX39r65gzJ4+3roZr9B5NxdunEDzaeRIx/jkXP2cduiEg
	rOszziqPiNLL1JDDSxKHwVTKRNXxWUZG5VjHH45t4DJdhb5Hju2ZjwM4LKtxO+L9JoAOgvRmOa3
	NoZUI
X-Gm-Gg: AfdE7cl4Xvn7I1AJyHPd1qoFG0xEG5M5Z+kQDEAtG9J6wU3GCgsFi5CCZvl+ak4apjG
	QVy8bVKK3pWH1V75kVFJk6m/GPYoEB5jAMOksd5jgozVKNQ8CANCPa5VifVFMAxFeKWDAG86X2k
	SBI+vdhmIDUqs1yheEWZjJC5+I8RqEs6Cff86EGxFSlv4SanD0FE4RG73aEW25PWXyiGh8ka9+a
	41/rVOt8MYlOaDfALeObm+Ly3or1FSYGrrchfpLDTdIqLtr3vDu7e3d1rtCt3qFFVl/lRNSk1Lc
	VfFLATtoZ0FKDttMzqQtN5joO7WW6tmj7QqyrA3uf8yjOr/jVbYFthAm68fSKW9wdQ1XzH1468z
	b7i0EGEWCDn1gLpMolcAmMfKJJNc0EEYrPQ3oSegpBa67fZqXMMmAsdD+i8vDBV+M1TKCeCZved
	Z80SnbLMuUQi6Wqxioh6NxTsRYZh5MM1l0tNlKV84jKSOaPKC+3SuLb8pPxDRMdU1ENgzLC/EdX
	3mAhr8yXlzYPmM=
X-Received: by 2002:a05:600c:3acf:b0:493:be37:df11 with SMTP id 5b1f17b1804b1-493be37e0bamr9516005e9.16.1782837826181;
        Tue, 30 Jun 2026 09:43:46 -0700 (PDT)
Received: from localhost (p200300f65f47db042a9b551def0a6b94.dip0.t-ipconnect.de. [2003:f6:5f47:db04:2a9b:551d:ef0a:6b94])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-493be4c8080sm9026455e9.1.2026.06.30.09.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 09:43:45 -0700 (PDT)
Date: Tue, 30 Jun 2026 18:43:43 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] can: c_can: Use platform id data when OF data is
 absent
Message-ID: <akPwf-nq2vTAlITA@monoceros>
References: <20260624054927.22851-1-pengpeng@iscas.ac.cn>
 <20260625054152.68413-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6qvnggh7oh747mz6"
Content-Disposition: inline
In-Reply-To: <20260625054152.68413-1-pengpeng@iscas.ac.cn>


--6qvnggh7oh747mz6
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] can: c_can: Use platform id data when OF data is
 absent
MIME-Version: 1.0

Hello,

On Thu, Jun 25, 2026 at 01:41:52PM +0800, Pengpeng Hou wrote:
> The platform driver keeps controller metadata in both the OF match table
> and the platform id table. Probe reads the metadata with
> device_get_match_data(), which does not fall back to platform id-table
> driver_data.
>=20
> When the device is matched through the platform id table, drvdata can
> therefore be NULL before it is dereferenced for msg_obj_num and the
> controller type. Fall back to platform_get_device_id() when firmware
> match data is not available.
>=20
> Fixes: 5e6c3454b405 ("net: can: Use device_get_match_data()")
> Cc: stable@vger.kernel.org
> Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
> Changes in v2:
> - Add the Fixes tag requested by Vincent.
> - Scope the platform id variable inside the fallback block.
> - Carry Vincent's Reviewed-by for the requested v2 shape.
>=20
>  drivers/net/can/c_can/c_can_platform.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_c=
an/c_can_platform.c
> index 19c86b94a40e..8a0c88839d24 100644
> --- a/drivers/net/can/c_can/c_can_platform.c
> +++ b/drivers/net/can/c_can/c_can_platform.c
> @@ -267,6 +267,14 @@ static int c_can_plat_probe(struct platform_device *=
pdev)
>  	struct device_node *np =3D pdev->dev.of_node;
> =20
>  	drvdata =3D device_get_match_data(&pdev->dev);
> +	if (!drvdata) {
> +		const struct platform_device_id *id;
> +
> +		id =3D platform_get_device_id(pdev);
> +		if (!id)
> +			return -ENODEV;
> +		drvdata =3D (const struct c_can_driver_data *)id->driver_data;
> +	}

Given that there are no devices probed via the platform_driver's
id_table (or my grep misses it:

	$ git grep -E '"(c_can_platform|c_can|d_can)"'
	drivers/net/can/c_can/c_can_platform.c:         .name =3D "c_can",
	drivers/net/can/c_can/c_can_platform.c:         .name =3D "d_can",
)

just do:

	if (!drvdata)
		return -ENODEV;

and drop c_can_id_table[].

An error message would be nice, but the other error exits don't have one
either.

Unless I missed something a backport to stable isn't needed then,
either.

Best regards
Uwe

--6qvnggh7oh747mz6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpD8jsACgkQj4D7WH0S
/k6YJgf+PebwvZJFAFdp9ZHI6Q+yYUJRHUrdUo3ouDB/rABWQQhmiHzuIcHqqFYU
cKvY/0eH+Fjp0C7wlSGYvbItKyefUNEXT7w+FvkBQVZR4saZw1v2AS8un3YBWq1c
dtkYlQkOizhIHNXtHW/CdBsfjggE66fwWlIL4kLmf/yNdqMNwnVYlWII008iDxFW
lr7ytQPRaoo7DU3pmQcEq86dzTbW4SBZaZocVRznSgl3JI8WWQkDlyYzzIpP+lYp
hVvA4Szln0XbvaHwsX0Ln//Ni9nioUhJby97P74yCkQX7ioGjp6MK1OUsIqQD+ve
rs49kviGKJ/3AGJSjPoajmGNct3/lQ==
=68X8
-----END PGP SIGNATURE-----

--6qvnggh7oh747mz6--
