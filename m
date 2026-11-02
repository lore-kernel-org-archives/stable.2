Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793624314;
	b=leCRMAv1TEJodiSXjqgi6lQnHT9Zo7jt66NBpDJkWvynix/7RCvjKkhOlE5SRQ5+11gb
	 nRPB0+KvB7JP+XtM3c7b56CTpKOLPsTKWOdUyIIbNIwa5+x7Rye6t69PldV61tfqBF1G7
	 PYr4SKaUUAZyPXMAt06OyrpTNJNuYr5wgF5Gkd0pyPxtLlYdOnkd5L7uOpwE6HXQv14WP
	 QAgfZAZgSbtlHBBIRL541fX5bNbKPY1Sz7R1GuhPdXjkv3LXCCj9I4YMNcLu8CntKIsWW
	 dBQzC70UILY7Vpvg7R5jGX9X/AlEX7WwlifIk2zAj4VWvUsDAQb5Kn2p16CT/Zd+6Lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793624314;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-CMS-MailID:X-Msg-Generator:Content-Type:
	 X-RootMTR:X-EPHeader:X-CMS-RootMailID:References;
	bh=0MGdbERm7cTtk9fV1wVHDrdglUUMqrm1H8xnWIQ7tBg=;
	b=wPguTsRl0eqTJ3tkSJT1hGhIuJO9tMe2rmMQAJoHACdBQnHLo/V5V7mfbNlizoDkvDrU
	 t4r0e8I6OYuiEWqwVjqWxpQRQ3oqpzRKczNoDJu4QBnSzBZJi2/szPAPNPOrcAwnRik1s
	 sw59BwaNn/sg8Z+BQhtlGgJvNY/iYnEz6Q3R/doX06wyLjn8+sGmRzF+lgSvZSIjLCcWY
	 WnycUt8haezeMhX4vPN4B1x5Msz+onqOutDsjo1GjjH2cUH+nDEOmFXZH1JQ3Wc0/czMv
	 dR8ULimq87B7TM/A2RZkRK3uPg/k7h0SS+4Xl+UsfVjfeR/Oe81tEdFKQwdRMoiheZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=UdIr3d3o;
	arc=none smtp.remote-ip=210.118.77.12
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D5D606A326
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 12:58:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99D5D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=UdIr3d3o
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20261102125831euoutp0288e42d6a2d374e802724121bfe6ce774~kO88EoHCh2314623146euoutp029
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 12:58:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20261102125831euoutp0288e42d6a2d374e802724121bfe6ce774~kO88EoHCh2314623146euoutp029
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1793624311;
	bh=0MGdbERm7cTtk9fV1wVHDrdglUUMqrm1H8xnWIQ7tBg=;
	h=From:To:Cc:Subject:Date:References:From;
	b=UdIr3d3o0mfglIKvVHaAQnqL7IX1n84m0B+/+admuGN7g9Li+CeDntULeLvw06ehs
	 d+y8+AHS4FpbzkmJSz+j0pRorgx0Bg5aL0jPwBo71g4dAuoL/ttsFqo2TXTfP3AfiF
	 NJ1AUGD7KWEXv37qzGY+mbKJEx1MPHSgSjyNjZwU=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261102125831eucas1p13e2e22a309ab8938bc7a87ffbcfbfd4a~kO87aZRaQ2214122141eucas1p1l;
	Mon,  2 Nov 2026 12:58:31 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261102125830eusmtip2cd22f9ff34b53d0d637ef1568dbf3c0a~kO87Gm6J43260232602eusmtip2n;
	Mon,  2 Nov 2026 12:58:30 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: linux-samsung-soc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, Alim Akhtar
	<alim.akhtar@samsung.com>, stable@vger.kernel.org
Subject: [PATCH v2] ARM: dts: samsung: exynos4210-universal_c210: fix
 BCM4330 Bluetooth GPIOs
Date: Mon,  2 Nov 2026 13:58:25 +0100
Message-ID: <20261102125826.3111447-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261102125831eucas1p13e2e22a309ab8938bc7a87ffbcfbfd4a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261102125831eucas1p13e2e22a309ab8938bc7a87ffbcfbfd4a
X-EPHeader: CA
X-CMS-RootMailID: 20261102125831eucas1p13e2e22a309ab8938bc7a87ffbcfbfd4a
References: <CGME20261102125831eucas1p13e2e22a309ab8938bc7a87ffbcfbfd4a@eucas1p1.samsung.com>

BT_REG_ON (BT_EN) line of the BCM4330 WLAN/BT combo chip is connected to
the XMMC1CMD pad (GPK1[1]), while the XMDMADDR_4 pad (GPE1[4]) is
connected to BT_RST (BT_nRST). The Bluetooth node however used GPE1[4]
as shutdown-gpios and left the real BT_REG_ON line undriven, so it was
kept low by the default SoC pull-down.

This worked only by accident: the internal regulators of the BCM4330 are
enabled when either WL_REG_ON or BT_REG_ON is high, so the Bluetooth core
was powered via WL_REG_ON driven by the SDIO WLAN power sequence, while
toggling GPE1[4] only released it from reset. Once 'cap-power-off-card'
was added to the SDIO node, the MMC core started to power off the WLAN
part (asserting WL_REG_ON low) whenever it was idle, what cut off the
Bluetooth power as well and resulted in HCI command timeouts.

Fix this by using GPK1[1] as shutdown-gpios and describing GPE1[4] as
active-low reset-gpios. While touching this, move the GPE1[4] pin
configuration to the pinctrl_0 node, as GPE1 bank belongs to that pin
controller, what fixes the following error:

  samsung-pinctrl 11000000.pinctrl: does not have pin group gpe1-4

Fixes: 4e7787929854 ("ARM: dts: exynos: Enable Bluetooth support for Universal C210 board")
Cc: stable@vger.kernel.org
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
This patch was developed with LLM assistance and have been tested on the
real UniversalC210 board.

Best regards
Marek Szyprowski, PhD
Samsung R&D Institute Poland
---
v2:
- corrected SHA in Fixes tag
v1:
https://lore.kernel.org/all/20261026103607.968295-1-m.szyprowski@samsung.com/
---
 .../boot/dts/samsung/exynos4210-universal_c210.dts  | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/samsung/exynos4210-universal_c210.dts b/arch/arm/boot/dts/samsung/exynos4210-universal_c210.dts
index 744039068e8f..79c0c27d9377 100644
--- a/arch/arm/boot/dts/samsung/exynos4210-universal_c210.dts
+++ b/arch/arm/boot/dts/samsung/exynos4210-universal_c210.dts
@@ -537,7 +537,7 @@ &ohci {
 
 &pinctrl_1 {
 	bt_shutdown: bt-shutdown-pins {
-		samsung,pins = "gpe1-4";
+		samsung,pins = "gpk1-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 	};
@@ -572,6 +572,12 @@ i2c_ddc_bus: i2c-ddc-bus-pins {
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
 		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
+
+	bt_reset: bt-reset-pins {
+		samsung,pins = "gpe1-4";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
 };
 
 &pwm {
@@ -641,9 +647,10 @@ bluetooth {
 
 		max-speed = <3000000>;
 
-		pinctrl-0 = <&bt_shutdown &bt_device_wakeup &bt_host_wakeup>;
+		pinctrl-0 = <&bt_shutdown &bt_reset &bt_device_wakeup &bt_host_wakeup>;
 		pinctrl-names = "default";
-		shutdown-gpios = <&gpe1 4 GPIO_ACTIVE_HIGH>;
+		shutdown-gpios = <&gpk1 1 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpe1 4 GPIO_ACTIVE_LOW>;
 		device-wakeup-gpios = <&gpx3 1 GPIO_ACTIVE_HIGH>;
 		host-wakeup-gpios = <&gpx2 6 GPIO_ACTIVE_HIGH>;
 	};
-- 
2.43.0

