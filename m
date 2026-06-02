Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651A43126C2;
	Tue,  2 Jun 2026 21:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780434508; cv=none; b=gcoukjYLzAA339oaUTu17IWLnhB5H9ty1OLhs4l7KPqUaIeb5O/iDsfeIvW7iZ8u7wV0/Okw03oxmLda8GIhorQtNQqtUjkuRmf+5bOsSa6JcJCqK5NAJ+0Lwl7E80oKZDdbI2qbehTAB0HzZmRMS7vPPwm8Is9zRW9SF2atSQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780434508; c=relaxed/simple;
	bh=u1uq3CFcKqR2Ws/rUTB63QvUhy2p+eqwSVC20BvZ3js=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uCCk1SNoARhoAUcqyr+5EeakEQUqrx4WEWrPICVwrtcZkpUER/ilRF9gIm8IAvQtvC/MwWjeTFTHIybkSZgOWHzNuTKW8OzjbJ+dUXnWgSoS/Fo1l93aTbD/Sfiad7bW035HDSj0SvYgm23TU8UbQiJJQrGOV2UsAeyoZ/GeCVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=ODppvQTZ; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="ODppvQTZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=CW9LOlJAtSZATcZIaY6uLfTJOIqnCg+SkeFpTOqsGbw=; b=ODppvQTZUOOtiSOWcFlUNW1uKK
	b9+m5bbK3ZQ4qMKyM4bsPZKmHRn7jvGmQvKT4GBYvXRMMzlbS7UcLMj+9j1Mrvtywx4BFNJhW/G4U
	1u9lxb7YMbrFCWAspW7Ewhi/cKm1iYtVZKNJMFX9QRfCMnz/WttwGdLDburXwPgxl+AS2Zqaof/jm
	AmGQ7xEXfcbCTr73Lt8ETxgVBEtQfdKK1q2sLTo3LzZKE4wvF2s042Z9wf1OONn1wl58A2mBs5nH/
	yWEDtdelYw5kgz7GXRBdL5FLeF4AOEKq+c8Q76bpTuT0q5DJ3XaP4tf2+mUOkovcjaI31NJtP/pmn
	uEE9Ikog==;
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>,
 Jakob Unterwurzacher <jakobunt@gmail.com>
Cc: stable@vger.kernel.org, Heiko Stuebner <heiko.stuebner@cherry.de>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH] arm64: dts: rockchip: fix emmc reset polarity on px30-cobra
Date: Tue, 02 Jun 2026 23:08:20 +0200
Message-ID: <3631825.d7IHhHJzqS@phil>
In-Reply-To: <20260512092225.34835-1-jakob.unterwurzacher@cherry.de>
References: <20260512092225.34835-1-jakob.unterwurzacher@cherry.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Dienstag, 12. Mai 2026, 11:22:09 Mitteleurop=C3=A4ische Sommerzeit schri=
eb Jakob Unterwurzacher:
> Technically, the reset signal is active low - it's called RST_n after all.
>=20
> But it is ignored completely unless RST_n_FUNCTION=3D1 (byte 162 in extcs=
d)
> is set in the emmc. It is 0 per default.
>=20
> For emmcs that have RST_n_FUNCTION=3D1 we failed like this:
>=20
> 	[    3.074480] mmc1: Failed to initialize a non-removable card
>=20
> With this change they work normally.
>=20
> Cc: stable@vger.kernel.org
> Fixes: bb510ddc9d3e ("arm64: dts: rockchip: add px30-cobra base dtsi and =
board variants")
> Signed-off-by: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>

as Quentin remarked, author (@gmail) and signed-off-by do not match.
While I'm generally open to fixing things, when it touches the DCO this
isn't the case.

So please resend this with the correct author.

In general "git send-email" will do the correct thing (that From: line),
when patch author and email-id do not match.


Thanks
Heiko

> ---
>  arch/arm64/boot/dts/rockchip/px30-cobra.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm64/boot/dts/rockchip/px30-cobra.dtsi b/arch/arm64/bo=
ot/dts/rockchip/px30-cobra.dtsi
> index b7e669d8ba4d..90751b04f95c 100644
> --- a/arch/arm64/boot/dts/rockchip/px30-cobra.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/px30-cobra.dtsi
> @@ -35,7 +35,7 @@ emmc_pwrseq: emmc-pwrseq {
>  		compatible =3D "mmc-pwrseq-emmc";
>  		pinctrl-0 =3D <&emmc_reset>;
>  		pinctrl-names =3D "default";
> -		reset-gpios =3D <&gpio1 RK_PB3 GPIO_ACTIVE_HIGH>;
> +		reset-gpios =3D <&gpio1 RK_PB3 GPIO_ACTIVE_LOW>;
>  	};
> =20
>  	gpio-leds {
>=20




