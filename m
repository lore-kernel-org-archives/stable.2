Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3385146D564;
	Wed,  5 Aug 2026 12:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785931996; cv=none; b=XDusrQbQt6+g+94xRzQ7ZfwS7nDfR1hyXAYLRAk+xjw0iqqBYOUsydPTLmzx39VlCiEm8jtll1CjS9mi4CUWipMIUr4JTh7U1koCA/KK3k+ndsAOrFBgNFfNqE3gmWtyYMS26ZvrOkpEzoeCiQ6Qr4YiBV463OykGP5dEzk9WQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785931996; c=relaxed/simple;
	bh=PspmvCkilmllWs+rB76lptSQjzPJmcGkMkA+NEOqnaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MJsLhGVZGxgnT9lhwammsgdpz7O8N7aFCk7vztqtK5TjoO/ZdxvE4GXuy6UgJXYRWB0EKlTPSqxznuWTGKv+jsJ4o5jy9zX37AcwwG8m59D0SiCnXDm/28iH8xVVOvQXI6Dtgu/7QB1WT0c7nxJpauYyGLriKHxp1hQldK7+S94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGGkVtuH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGGkVtuH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 765811F00A3A;
	Wed,  5 Aug 2026 12:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785931995;
	bh=C+lFjplQUImCFc3yxBvZxiknpiJ+7Q6rhfLRxBfmbEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AGGkVtuHzgL2hdh8PJ1tGbhQo+wMTEV2VX1SswjVSEgXVGaOrYCzXuSbsYnZZkjZ/
	 +Q9c6pJntK9p6CL/6zWzvG7BQM5a0dgnzSgQTrbPf9WqMXHwblkL2wUSOpc5oAN2zo
	 ISlNEoPn91aae39J9Z85aicmxgZU4LlR6fIXLC56DwRAr/0b/hSCGcfQoI766JD2Cy
	 gHd1rAElSRn37q4yaySBthFUOyHX/9hxawdpCn4WR6Qerf73LmC+T68MY8tnoRMRuC
	 pSo8ws5bODPsEja6yQ3A9FV72Lr3fjJ2DKbJEwpcMQhqDmkWssS2J3y+wPrQl5DQlu
	 9qFXYX4SPt3WQ==
Date: Wed, 5 Aug 2026 14:13:12 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] pinctrl: airoha: fix wrong value for PCIe reset pin
Message-ID: <anMo2J5vNucxUQ7X@lore-desk>
References: <20260805084143.3901-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cALPqJiXqOVi57wI"
Content-Disposition: inline
In-Reply-To: <20260805084143.3901-1-ansuelsmth@gmail.com>

--cALPqJiXqOVi57wI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> The PCIe reset pin actually require the bit to be set as 0 to work as PCIe
> reset pin. When the bit is set as 1, then the PCIe reset pin act as a GPIO
> for GPIO44, GPIO45 and GPIO46.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 1c8ace2d0725 ("pinctrl: airoha: Add support for EN7581 SoC")
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  drivers/pinctrl/airoha/pinctrl-airoha.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/pinctrl/airoha/pinctrl-airoha.c b/drivers/pinctrl/ai=
roha/pinctrl-airoha.c
> index 04b4424c688b..6409572c0a4b 100644
> --- a/drivers/pinctrl/airoha/pinctrl-airoha.c
> +++ b/drivers/pinctrl/airoha/pinctrl-airoha.c
> @@ -1412,7 +1412,7 @@ static const struct airoha_pinctrl_func_group pcie_=
reset_func_group[] =3D {
>  			AIROHA_FUNC_MUX,
>  			REG_GPIO_PON_MODE,
>  			GPIO_PCIE_RESET0_MASK,
> -			GPIO_PCIE_RESET0_MASK
> +			0
>  		},
>  		.regmap_size =3D 1,
>  	}, {
> @@ -1421,7 +1421,7 @@ static const struct airoha_pinctrl_func_group pcie_=
reset_func_group[] =3D {
>  			AIROHA_FUNC_MUX,
>  			REG_GPIO_PON_MODE,
>  			GPIO_PCIE_RESET1_MASK,
> -			GPIO_PCIE_RESET1_MASK
> +			0
>  		},
>  		.regmap_size =3D 1,
>  	}, {
> @@ -1430,7 +1430,7 @@ static const struct airoha_pinctrl_func_group pcie_=
reset_func_group[] =3D {
>  			AIROHA_FUNC_MUX,
>  			REG_GPIO_PON_MODE,
>  			GPIO_PCIE_RESET2_MASK,
> -			GPIO_PCIE_RESET2_MASK
> +			0
>  		},
>  		.regmap_size =3D 1,
>  	},
> --=20
> 2.53.0
>=20

--cALPqJiXqOVi57wI
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCanMo2AAKCRA6cBh0uS2t
rBdvAP4nq6dzH7iLyJf2CZPFcV/zjU6EL+Hp7Uvjl04IAZKvIAEA/4h2d+AyfD+z
lFKjbycUQMhImimRpwNHPASCGbQO2Qo=
=lvz5
-----END PGP SIGNATURE-----

--cALPqJiXqOVi57wI--
