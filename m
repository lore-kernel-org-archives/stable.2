Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF3E46D566;
	Sun, 18 Oct 2026 19:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792350323; cv=none; b=EUttZi0qnZnjbfRmpDU0mtx/4NnS3ndMqJiTygXxlAQq8pFR0YAO3hpA67aX4pzaTDUv0Em8P4Io1+EUtrCpF1kK5yRxOvAX/L48uNhV8yYVngnVKg9K4nICmI16L68fyR0ovuvxq8lBfnSGJp0DOmcQdjdjXX7p1itFzktRW5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792350323; c=relaxed/simple;
	bh=AE4SalZYqhH3Xwk8wr4yj5xQmGA5rFspyXhmNDptFQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQVkQdeISjGR0Jf5dwN50ZqbsNd4zzOXowLDc64ZZccs+KPrQMKKiFNjhzZV6sIG4CQtpOGCupbUWTZsE/ovTXByw0QyrDaqMOAchL+XY/Ei70+r1AiCnMr5XUmorV+go6u42sUuml4L8C1L5af++Rz+/lEoK9OPDB2J325ZEFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qp2z8ENq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qp2z8ENq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53D851F000C4;
	Sun, 18 Oct 2026 19:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792350320;
	bh=d6EGb2ugrbt7//+Eojbe2jEyLxPgQ0l7cnMhVIpHK1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Qp2z8ENqhXHUJx4/KuHRL8eb5l6cKZdJPn9YFJB7400ICo4nwiRcdR5hV5OKrUIKo
	 QUg8xoma1OKOjpRUp9jNBx3ZkoMvGk7YGr+KD0Ujml/MWDC0WhXBn9c06gLZx1Nivy
	 lxg40xVVbrZH7PWnj62PTUCSCOuGDA74vGDcatHUsF2EPM0F1yW7DBWuauxc9dW2tE
	 gTS0jMDB/MYQ73O7FcTJmjQIek6Ubc2t9f1raUm4IW8Hzsb+1zAQCEg0ei2MYyyv87
	 2H5B3jDG2F+wC0NSez8fpKdE8c/E8IQbmcj62dEoG1oyxSATcddyTj7+BOJU9nV9E9
	 Qdj/inDcBWTYA==
Date: Sun, 18 Oct 2026 20:05:16 +0100
From: Conor Dooley <conor@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: Frank.Li@nxp.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: nvmem: imx-iim: Allow syscon fallback
 on i.MX5
Message-ID: <20261018-suspend-uphill-7fab7a4dd8b2@spud>
References: <20261016232800.536654-1-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sFPwHorryreAelGg"
Content-Disposition: inline
In-Reply-To: <20261016232800.536654-1-festevam@gmail.com>

--sFPwHorryreAelGg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 08:27:59PM -0300, Fabio Estevam wrote:
> The i.MX51 and i.MX53 SoC device code reads the unique ID through
> syscon_regmap_lookup_by_compatible(). Their IIM nodes therefore need the
> syscon fallback so the syscon core can instantiate a regmap.
>=20
> Allow the two-item compatible sequence for these SoCs. This prepares for
> restoring the fallback removed while making the IIM nodes conform to the
> binding.

Making it a syscon is only the right thing to do if it genuinely is a
syscon. If it's not, then don't. The nvmem driver doesn't treat this as
a syscon, so the inbuilt regmap locking doesn't actually do anything
here.
Surely the right thing to do is for the soc driver to access the efuse
through the nvmem subsystem somehow?

>=20
> Cc: stable@vger.kernel.org
> Fixes: d5b55c35e033 ("ARM: dts: imx: Fix the iim compatible string")

A binding should not have a fixes tag pointing to a devicetree.

> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
>  .../devicetree/bindings/nvmem/imx-iim.yaml    | 20 +++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/nvmem/imx-iim.yaml b/Docum=
entation/devicetree/bindings/nvmem/imx-iim.yaml
> index bb37d72c9eaa..ebfd947e6800 100644
> --- a/Documentation/devicetree/bindings/nvmem/imx-iim.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/imx-iim.yaml
> @@ -20,13 +20,17 @@ allOf:
> =20
>  properties:
>    compatible:
> -    enum:
> -      - fsl,imx25-iim
> -      - fsl,imx27-iim
> -      - fsl,imx31-iim
> -      - fsl,imx35-iim
> -      - fsl,imx51-iim
> -      - fsl,imx53-iim
> +    oneOf:
> +      - enum:
> +          - fsl,imx25-iim
> +          - fsl,imx27-iim
> +          - fsl,imx31-iim
> +          - fsl,imx35-iim
> +      - items:
> +          - enum:
> +              - fsl,imx51-iim
> +              - fsl,imx53-iim
> +          - const: syscon
> =20
>    reg:
>      maxItems: 1
> @@ -50,7 +54,7 @@ examples:
>      #include <dt-bindings/clock/imx5-clock.h>
> =20
>      iim: efuse@63f98000 {
> -        compatible =3D "fsl,imx53-iim";
> +        compatible =3D "fsl,imx53-iim", "syscon";
>          reg =3D <0x63f98000 0x4000>;
>          interrupts =3D <69>;
>          clocks =3D <&clks IMX5_CLK_IIM_GATE>;
> --=20
> 2.43.0
>=20

--sFPwHorryreAelGg
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCatUYbAAKCRB4tDGHoIJi
0hGqAP9cN5ysdapdPoSFATbC17Mn3qlNsgq8HEDLk97mv8+bsgEAg9wSDBftuEge
7S0vKI81Zp2CRYt1yIBEbxvF8zAs4gM=
=gzqd
-----END PGP SIGNATURE-----

--sFPwHorryreAelGg--
