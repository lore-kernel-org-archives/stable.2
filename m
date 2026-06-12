Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [45.157.188.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D969B31F998
	for <stable@vger.kernel.org>; Fri, 12 Jun 2026 16:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781282874; cv=none; b=opof+Y4jyKhPdOptO+cw7RsgaQ9dRsSpEmYWLsP/xvFVBBluuKK/8cgVQKUASis8k6nOOy2c89YCd0gxK9xwBGwUEXFkvghX2N89r6X4ibwCcHhEj2mE/A31QkyNPCFSQeyq8EP4icXY3SpYBeP11qSD3eQmKr63MTotjKAYnYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781282874; c=relaxed/simple;
	bh=b6LkmofaeLoDrLoLRQDPlxiKyuxPQ2/MzrhFvNrbgB8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=i/eIc25lmrmbgmrpPlBmTk5403jEVQiOkIFlgnLaR5adSb//ppESR+w0ZK96foL8cWIqxrvAJdDpceAkiowbGGCujzSC1ZXGnBbsx+MQZ0j2Ke8MPl+ru0le7xWjsGr2o6lt33G0Gt5chztB1Nx6/0VbtuF/F3GjdSC0R+dLPKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=0leil.net; spf=pass smtp.mailfrom=0leil.net; dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.b=XYXTpnAd; arc=none smtp.client-ip=45.157.188.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0leil.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.b="XYXTpnAd"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gcQRh0QGvzRHq;
	Fri, 12 Jun 2026 18:47:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
	s=20231125; t=1781282863;
	bh=KlkjIw4bcij3LG7og0awnfmQnaK8D+NfJs+ZdxoZ9/E=;
	h=From:Date:Subject:To:Cc:From;
	b=XYXTpnAdoYDQ4BIdWgGbSu88PkILVJiWZD2BaXXkBHB9i0y5jLAPt3r8FpvawhVAR
	 habuO6wlTnX4v1o/o6mHsYajQTF9Qlh+MyJZZEeNAx0shUtMdxXtf0KK9AOCoz4yOi
	 au0aUm+R5dgv/mEOsu/6GzHKfskPOHHMcOnyJiAYGPzy6neKK+Nv/B5wntxWuLVHgl
	 gRrn9yE8fWMogFwYUNeos6JwG+resk74nav2SIXlSpJG/oYL0o0MUNaXcuRTaG89Cf
	 BWqN7FMPrmDGJ101s8YvY1QvXuQsFYA91MOKfpCmYgFfXe0o4h5P05Wza6GlTXnlmg
	 elmr1beE+6X6A==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4gcQRf5dcSzrnk;
	Fri, 12 Jun 2026 18:47:42 +0200 (CEST)
From: Quentin Schulz <foss+kernel@0leil.net>
Date: Fri, 12 Jun 2026 18:47:34 +0200
Subject: [PATCH] arm64: dts: rockchip: fix eMMC reset polarity on PP-1516
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-pp1516-emmc-polarity-v1-1-4816c1c909f7@cherry.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQqDMBBA4avIrB1wQhPRq4iLJI7tFH9CYkuLe
 PdGu/wW7+2QOAonaIsdIr8lybpkUFmAf9jlzihDNqhKmcqQwhBIk0GeZ49hnWyU7Yva1qPTt8E
 1VENOQ+RRPte26/9OL/dkv50vOI4fc4OQ4XgAAAA=
X-Change-ID: 20260612-pp1516-emmc-polarity-5a7fb54db917
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Heiko Stuebner <heiko.stuebner@cherry.de>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Quentin Schulz <quentin.schulz@cherry.de>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha

From: Quentin Schulz <quentin.schulz@cherry.de>

According to the Jedec 5.1 specification, the device is held in reset
when RST_n is low, therefore the polarity of the line must be that, as
specified in the Device Tree binding (mmc/mmc-pwrseq-emmc.yaml).

Due to the wrong polarity, eMMC devices with RST_n_FUNCTION[162]
bitfield [1:0] set to 0x1 (the default is 0x0) will be held in reset
forever.

Cc: stable@vger.kernel.org
Fixes: 56198acdbf0d ("arm64: dts: rockchip: add px30-pp1516 base dtsi and board variants")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
PP-1516 is affected by the same issue that Cobra has and for which a
patch[1] has already been sent.

[1] https://lore.kernel.org/linux-rockchip/20260609081728.30616-2-jakobunt@gmail.com/
---
 arch/arm64/boot/dts/rockchip/px30-pp1516.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/px30-pp1516.dtsi b/arch/arm64/boot/dts/rockchip/px30-pp1516.dtsi
index 192791993f059..02200de695d31 100644
--- a/arch/arm64/boot/dts/rockchip/px30-pp1516.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30-pp1516.dtsi
@@ -33,7 +33,7 @@ emmc_pwrseq: emmc-pwrseq {
 		compatible = "mmc-pwrseq-emmc";
 		pinctrl-0 = <&emmc_reset>;
 		pinctrl-names = "default";
-		reset-gpios = <&gpio1 RK_PB3 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpio1 RK_PB3 GPIO_ACTIVE_LOW>;
 	};
 
 	gpio-leds {

---
base-commit: 2b414a95b8f7307d42173ba9e580d6d3e2bcbfce
change-id: 20260612-pp1516-emmc-polarity-5a7fb54db917

Best regards,
--  
Quentin Schulz <quentin.schulz@cherry.de>

