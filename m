Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793010964;
	b=oP/xhMNMg5kJoSv7I8XuT9HYgnQs+5PmqkwAblDCnNznXHaxlKNEq5IGzFQqmJxWJGYe
	 k70nqssjpIdo8PfcQixD5ZFRl0tObEUCy3WZv+SjfNHpJmcN2QamUDDnw4jde9pT5YIG2
	 n4gwOpIjZio1jKYJnu81p0U+vtp9nxRPdcYfSCjDZ25RsCPuCCw1n/YjvNepNWt3hCX0O
	 MH4kCSL+LrZjxTbHx6o5djGjVJ8xlbE1fRivcxtHaS3L1eJ8zbUv32/UFPUUvn0lWVB5a
	 iBijQKqa1UlA211T2uR8b+IkpICxgHD3J0D+6oMKYYyXgDWUU6ob0B+NSyXvRy3xolw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793010964;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-CMS-MailID:X-Msg-Generator:Content-Type:
	 X-RootMTR:X-EPHeader:X-CMS-RootMailID:References;
	bh=yuAB/deLPXynHruH14/7mxT9f9jjmnpIupiIf/NNTgw=;
	b=ZZcYfWpXeupiSFDdL0yxHIGlwBEKqAvcwwZnKKcaWF9uY6kRUDQadyOkCPwvV70TmIwz
	 +TqYmJekLhiUvHGlFGE03MSmUySNBshubbThYBxlw9VlET1yU1Kc+SUsnoL2RCK57Errb
	 LpRxfGKJeVESHgIlqw9pIbtzXpyN6D9P6UifRGh5917WBat0waF4/v6wKRf5F7QpMx4rD
	 AoYZPPKRoTUycVi4KS93Vy1ZCKQ9b+UGhOQaliuzoro8FlL+VK4wkIsKqVGil7j2CJ05+
	 a7grzSs6R42VXHaWU+SwF+WMTbziqgUIgYjlsb+uRM8+TO2VH5Udm8+qASAoA4/XMqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=kMSJOFtC;
	arc=none smtp.remote-ip=210.118.77.11
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888F3606A31B
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 10:36:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 888F3606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=kMSJOFtC
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20261026103600euoutp013c4329fa9ebb017c4902d7ba48d2ff36~iDfgJWRql1544015440euoutp01R
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 10:36:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20261026103600euoutp013c4329fa9ebb017c4902d7ba48d2ff36~iDfgJWRql1544015440euoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1793010960;
	bh=yuAB/deLPXynHruH14/7mxT9f9jjmnpIupiIf/NNTgw=;
	h=From:To:Cc:Subject:Date:References:From;
	b=kMSJOFtC/E74vVG9nXYgrbw6A4/l2uFgRJ0WqHOl7hJx9OoG4BCc8mAINbKDeEafb
	 Cg7L+ViNmvClnSemtYH89ozlqVmJIlhm3n0ANiDGgHDChsFa2BMSgWHxFwBXXHBDyE
	 TpyB53DSzCHmue+ha5Bz3F5Tr2TCdp4LcK8Z2eAM=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20261026103600eucas1p25b6792a9a244d71a5f2ca8d06c9e79f8~iDff5y4bV1189411894eucas1p2x;
	Mon, 26 Oct 2026 10:36:00 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261026103600eusmtip1f69c04b3b398dde0d951caa6266c4330~iDfflnRJX1548415484eusmtip1e;
	Mon, 26 Oct 2026 10:35:59 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: linux-samsung-soc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, Alim Akhtar
	<alim.akhtar@samsung.com>, stable@vger.kernel.org
Subject: [PATCH] ARM: dts: samsung: exynos4210-trats: fix BCM4330 Bluetooth
 GPIOs
Date: Mon, 26 Oct 2026 11:35:53 +0100
Message-ID: <20261026103555.968273-1-m.szyprowski@samsung.com>
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
X-CMS-MailID: 20261026103600eucas1p25b6792a9a244d71a5f2ca8d06c9e79f8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261026103600eucas1p25b6792a9a244d71a5f2ca8d06c9e79f8
X-EPHeader: CA
X-CMS-RootMailID: 20261026103600eucas1p25b6792a9a244d71a5f2ca8d06c9e79f8
References: <CGME20261026103600eucas1p25b6792a9a244d71a5f2ca8d06c9e79f8@eucas1p2.samsung.com>

According to the board schematic, BT_REG_ON (BT_EN) line of the BCM4330
WLAN/BT combo chip is connected to GPL0[4], while GPL1[0] is connected
to BT_RST (BT_nRST). The Bluetooth node however used GPL1[0] as
shutdown-gpios and left the real BT_REG_ON line undriven, so it was kept
low by the default SoC pull-down.

This worked only by accident: the internal regulators of the BCM4330 are
enabled when either WL_REG_ON or BT_REG_ON is high, so the Bluetooth core
was powered via WL_REG_ON driven by the SDIO WLAN power sequence, while
toggling GPL1[0] only released it from reset. Once 'cap-power-off-card'
was added to the SDIO node, the MMC core started to power off the WLAN
part (asserting WL_REG_ON low) whenever it was idle, what cut off the
Bluetooth power as well and resulted in HCI command timeouts:

  Bluetooth: hci0: Opcode 0x0c03 failed: -110

Fix this by using GPL0[4] as shutdown-gpios and describing GPL1[0] as
active-low reset-gpios, together with the respective pin configuration.

Fixes: 2fd18f0a8de6 ("ARM: dts: exynos: add bluetooth support for midas & trats boards")
Cc: stable@vger.kernel.org
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
This patch was developed with LLM assistance and have been tested on the
real Trats board.

Best regards
Marek Szyprowski, PhD
Samsung R&D Institute Poland
---
 arch/arm/boot/dts/samsung/exynos4210-trats.dts | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/samsung/exynos4210-trats.dts b/arch/arm/boot/dts/samsung/exynos4210-trats.dts
index 20fe148387fc..ae4327770799 100644
--- a/arch/arm/boot/dts/samsung/exynos4210-trats.dts
+++ b/arch/arm/boot/dts/samsung/exynos4210-trats.dts
@@ -469,6 +469,12 @@ EN32KHZ_CP {
 
 &pinctrl_1 {
 	bt_shutdown: bt-shutdown-pins {
+		samsung,pins = "gpl0-4";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
+	bt_reset: bt-reset-pins {
 		samsung,pins = "gpl1-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
@@ -548,9 +554,10 @@ bluetooth {
 
 		max-speed = <3000000>;
 
-		pinctrl-0 = <&bt_shutdown &bt_device_wakeup &bt_host_wakeup>;
+		pinctrl-0 = <&bt_shutdown &bt_reset &bt_device_wakeup &bt_host_wakeup>;
 		pinctrl-names = "default";
-		shutdown-gpios = <&gpl1 0 GPIO_ACTIVE_HIGH>;
+		shutdown-gpios = <&gpl0 4 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpl1 0 GPIO_ACTIVE_LOW>;
 		device-wakeup-gpios = <&gpx3 1 GPIO_ACTIVE_HIGH>;
 		host-wakeup-gpios = <&gpx2 6 GPIO_ACTIVE_HIGH>;
 	};
-- 
2.43.0

