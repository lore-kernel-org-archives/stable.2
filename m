Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F822AE68;
	Tue,  8 Sep 2026 00:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788826281; cv=none; b=TTCeCzsqY0BfGK2jVnjM6hsX7cdyl0VOVYeAGHbWC9h7F1etYqUTrjlkMVkge2ORv/hvpsjms0bW5n3BrJoaUj6OwSZvArNAwNLZsgOWnxS6pu5CP4SUzOjeDy+DCQOz8SzfTq9w4rCc85jUmGglUihndHhGqT/FKsKIsC5iEJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788826281; c=relaxed/simple;
	bh=AL638/hQUvxZ7ksKQGtecEARfPp3dotRpjQaGrQQF3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ocOAneqm8bdYopnRfYdWNud9tAyaXKnIYIUgCLb14XI0mdxrHag0SOuzPWFa6VFGQw70FX1bWX4v1Gu22C/YyNf18l3+kkh/U2HQcrGlgeVYjawtvhtEHyOuW8HuFcMsn0Lk55wmzmSWoi9AJ0BqA/rRMuGRWvRBYllRhBVHJdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=LLJ3/45b; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="LLJ3/45b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1788825744; bh=AL638/hQUvxZ7ksKQGtecEARfPp3dotRpjQaGrQQF3M=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=LLJ3/45b9JMUxcH9Gv9bEbtvgzTehRkBk1PVr7b1A0gcFD/djeAiJOIq0Gp0WkL5O
	 MTSM5hW4iVuKVzowUXDFTw2xZssxkEDQBHlKncvwi3mgM7YZekFFNmCfUoUqkwd5+i
	 /kniqUrNVz9nFw6MPZi5+YazHlaOZ7mQ7Eyep+XU=
Date: Tue, 8 Sep 2026 02:02:24 +0200
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: Igor Paunovic <royalnet026@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: fix hym8563 interrupt pin on
 Orange Pi 5 Plus
Message-ID: <pzcclrj5h32i5sfjhv75ntyrcmlqf224pzgk7zmea64jsxcriw@ezb2fpcpw5zt>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	Igor Paunovic <royalnet026@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20260906181622.11991-1-royalnet026@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260906181622.11991-1-royalnet026@gmail.com>

Hello,

On Sun, Sep 06, 2026 at 08:16:22PM +0200, Igor Paunovic wrote:
> The interrupt line of the hym8563 RTC on the Orange Pi 5 Plus is routed
> to GPIO0_C6, not GPIO0_B0. The vendor device tree uses RK_PC6 with a
> pull-up for this pin; the mainline board file uses RK_PB0, which is not
> connected to the RTC.
> 
> As a result the alarm interrupt never reaches the SoC, so the RTC alarm
> cannot wake the board: rtcwake enters s2idle and the board never
> returns, which looks like a hang.
> 
> This was verified on the board by enabling the alarm interrupt (AIE with
> AF already set, so INT# is asserted) and sampling the EXT_PORT register
> of all five GPIO banks: GPIO0_C6 is the only pad that follows AIE
> (high with AIE=0, low with AIE=1, across repeated cycles), while GPIO0_B0
> stays high and its interrupt counter stays at zero.
> 
> Switch the interrupt and its pinctrl entry to GPIO0_C6 and use a pull-up,
> as the vendor tree does for this open-drain line.
> 
> With this change the alarm interrupt fires while the system is running
> and the RTC wakes the board from s2idle ('PM: Triggering wakeup from
> IRQ 52'); before it, rtcwake never returned.
> 
> Fixes: 236d225e1ee7 ("arm64: dts: rockchip: Add board device tree for rk3588-orangepi-5-plus")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM checkpatch dtbs_check
> Signed-off-by: Igor Paunovic <royalnet026@gmail.com>
> ---
> Notes for reviewers (not part of the commit message):
> 
> Measured on an Orange Pi 5 Plus with the vendor-style method described above
> (GPIO0 EXT_PORT sampled while toggling the alarm interrupt enable); the vendor
> device tree for this board uses RK_PC6 with a pull-up. With the fix the alarm
> IRQ fires at runtime and the RTC wakes the SoC from s2idle. Note that on this
> board the resume itself can still stall later in the USB 2.0 host controllers
> (a separate, unrelated issue being looked at); it does not affect this fix.
> 
>  arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
> index 145986695720..572b892e4066 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
> @@ -189,7 +189,7 @@ &hdptxphy1 {
>  
>  &hym8563 {
>  	interrupt-parent = <&gpio0>;
> -	interrupts = <RK_PB0 IRQ_TYPE_LEVEL_LOW>;
> +	interrupts = <RK_PC6 IRQ_TYPE_LEVEL_LOW>;
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&hym8563_int>;
>  };
> @@ -298,7 +298,7 @@ hdmi1_tx_on_h: hdmi1-tx-on-h {
>  
>  	hym8563 {
>  		hym8563_int: hym8563-int {
> -			rockchip,pins = <0 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
> +			rockchip,pins = <0 RK_PC6 RK_FUNC_GPIO &pcfg_pull_up>;

Schematic already shows a pullup, so this should not be needed:

  https://xff.cz/dl/tmp/2995ddec50ce4597.png

Other than that,

Reviewed-by: Ondrej Jirman <megi@xff.cz>

Thank you,
	o.

>  		};
>  	};
>  
> 
> base-commit: 1fc5a74b108fc90951890ec513ac81869f5eaff1
> -- 
> 2.43.0
> 
