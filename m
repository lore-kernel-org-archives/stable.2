Received: from ms.puri.sm (ms.puri.sm [135.181.196.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4569442E8DD;
	Mon,  3 Aug 2026 18:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.181.196.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785781228; cv=none; b=FDelybAPjf4k89jm+/R1kQMT4U+j9BW8Kz46rQZkY2FcelpFurjecrcjIW98f1XkxcpMNHL+7ZfNmzyqpIwDT9xGxgSkewZslveqJsokBUZGr0+qnGopKM9SvxhK1a7hJSvjKaN3g2XkB1Az/vsDz8qkFYkxLAkrzMO/doAFp+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785781228; c=relaxed/simple;
	bh=HNTPaYDGutREzLTVPWESt82E01iFz+jQ39UPafEurv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FoVjUwjyGf9CAmYvdy0bsEx1c8ytu2E7Ck3z0FxFlmVxRbTRULlVW3RBjOUI7crqSgXdiT5dUHA2EA8R4Zh1fOx4zPHM2kUGB5pBpAf0Nq5xvwlwe4cEeH6qPeu4oUD1ojBYiV3oE/wVxguuf/Ht2mvK8qkDqxtWQRjAFfxt4FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=puri.sm; spf=pass smtp.mailfrom=puri.sm; dkim=pass (2048-bit key) header.d=puri.sm header.i=@puri.sm header.b=J4qIa0M3; arc=none smtp.client-ip=135.181.196.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=puri.sm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=puri.sm
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=puri.sm header.i=@puri.sm header.b="J4qIa0M3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=smtp2;
	t=1785780772; bh=HNTPaYDGutREzLTVPWESt82E01iFz+jQ39UPafEurv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J4qIa0M3q9Mja66JJpMWCm3Si2k+eQxKBPYsxWlsjhzfhFhyNWkHOce9T4N2rqDaA
	 kEmxNLjWJMeQEHDhJ5UGXkpeibsTQ5FNwkQR0x7UnO77zXdxXGMA00/OFQkd/fCgSc
	 6gZulAcTEPaP0/4e+WFabqGthdJvYdZUuaEdjBfYKwQQ3V4pyKcPDqIGq8SVIBvdNT
	 XG4o2BAoNJclC5KD2v8WfgpNg7zAq0p3jURjCMHKPQ58y8ibkwVhykQHlXlncggeTq
	 mDrVCDZBH3C/DsnWTYfXBbi4VpA/j86hwwBXQPHp1E0qCCB5XIeh536HehZjTFh+3v
	 36zRINnOxbN2Q==
Received: from pliszka.localnet (79.184.66.106.ipv4.supernova.orange.pl [79.184.66.106])
	by ms.puri.sm (Postfix) with ESMTPSA id A9F351F617;
	Mon, 03 Aug 2026 11:12:47 -0700 (PDT)
From: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
To: Sakari Ailus <sakari.ailus@linux.intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Ondrej Jirman <megi@xff.cz>,
 Olivier Benjamin <olivier.benjamin@bootlin.com>,
 Manuel Traut <manut@mecka.net>,
 Alexander Warnecke <awarnecke002@hotmail.com>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Martin Kepplinger <martin.kepplinger@puri.sm>,
 Shawn Guo <shawnguo@kernel.org>, david@ixit.cz
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 phone-devel@vger.kernel.org, imx@lists.linux.dev,
 David Heidelberg <david@ixit.cz>, stable@vger.kernel.org
Subject:
 Re: [PATCH 4/4] arm64: dts: imx8mq-librem5: Dongwoon DW9714 coil requires
 higher voltage
Date: Mon, 03 Aug 2026 20:12:44 +0200
Message-ID: <yJywMSNTQGGZm3rbxd56Yw@puri.sm>
In-Reply-To: <20260801-pp-pro-camera-v1-4-7b4d90788f9f@ixit.cz>
References:
 <20260801-pp-pro-camera-v1-0-7b4d90788f9f@ixit.cz>
 <20260801-pp-pro-camera-v1-4-7b4d90788f9f@ixit.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On sobota, 1 sierpnia 2026 02:35:23 czas =C5=9Brodkowoeuropejski letni Davi=
d=20
Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
>=20
> By datasheet the VDD (in-kernel named vcc) range is between 2.3 to 4.3 V.
> Usually it's around 2.8 V. Here it matches the reg_vcam_2v8.

It doesn't - VCAM_2V8 isn't connected to DW9714 (and neither is CSI_1V8);=20
VCAM_AFVDD is.

> 1.8 V here is likely used for i2c level shifter.

I'm not sure where you've got an I2C level shifter from, there's none invol=
ved=20
there. CSI_1V8 is passed to the rear camera module as DOVDD and is consumed=
 by=20
S5K3L6 as VDDIO, and both S5K3L6 and DW9714 are connected to I2C4_SDA/
I2C4_SCL, operating at the 1.8V level, only though an EMI filter (F7 in the=
=20
schematic).

>=20
> Fixes: f00df2bdb512 ("arm64: dts: imx8mq-librem5: describe the voice coil
> motor for focus control") Cc: stable@vger.kernel.org
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
> b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi index
> f5d529c5baf3e..583cba2d3bebf 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
> @@ -1167,17 +1167,17 @@ &i2c4 {
>  	pinctrl-1 =3D <&pinctrl_i2c4_gpio>;
>  	scl-gpios =3D <&gpio5 20 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>  	sda-gpios =3D <&gpio5 21 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>  	status =3D "okay";
>=20
>  	vcm@c {
>  		compatible =3D "dongwoon,dw9714";
>  		reg =3D <0x0c>;
> -		vcc-supply =3D <&reg_csi_1v8>;
> +		vcc-supply =3D <&reg_vcam_2v8>;
>  	};
>=20
>  	bat: fuel-gauge@36 {
>  		compatible =3D "maxim,max17055";
>  		reg =3D <0x36>;
>  		interrupt-parent =3D <&gpio3>;
>  		interrupts =3D <20 IRQ_TYPE_LEVEL_LOW>;
>  		pinctrl-names =3D "default";




