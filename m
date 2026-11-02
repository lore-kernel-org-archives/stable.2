Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793624303;
	b=Gqf7DRqxIwQz+sEtpJiPvtJD9QtLpmaxBJUKh1j4ddcklBaYOTv+5O9MhB+QKwt8xGCm
	 a7tmC7XZGDE6D+caHDV4/1BWZ8ssMKlX85dCSykWebDVz2x09WY8PdcPZTLbySXKu6fLj
	 lclSJOSf8MiiDSom+xzXxJ+d6qD/qfCA5j6AVWRaNXLHmaCWN8xBJeXhqJfnH8ruGgnDA
	 iTf7YIIkGXHE/Qj8JUBP9K1IBbRWLnQaIo+7KeRx+u5e14zdj6vj4LgWitqesJd7dFKBw
	 TJYfnaurJkZ1vBUzhF/KnHr5DovqpbYT2MCXYSARKcyVZdj9kDbI9NoqI0Y6igjy38A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793624303;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-CMS-MailID:X-Msg-Generator:Content-Type:
	 X-RootMTR:X-EPHeader:X-CMS-RootMailID:References;
	bh=i3Eq0UzhBUrozYwhFxDujSvYgE1qs5i/5z/JE8WaraY=;
	b=E+ZmsfDmZKEcTMmOOc4bZTciVnZLBNf5dIItXd2Ah/cwf5OcSSjQqy6xjP3PUVxiD5Og
	 9irubCBSf5i/7oShi9KdZk7A+gZLwmf9quRAR7o5xchGONBlFYqN1RA4tZyz228vCNNqi
	 l2xvxg20fqDUqAKD1tk/nSu9DBvrrXySQN9+5LxBF0O1DmYoodDwYE+AQ+st362nhyD4i
	 dQgVEOHgKwFT8dDMywjZBb8NSA3K7PvP58hm7V0OTbW9FmZf3aOPMh/DQT4tzoJawJui3
	 C3NeT9QHFWBrc7KEsDJC8M4ESD2Dr90FQ7hDnNwQrljOmW0CEVG8HSMZCGeLsIQWkcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=bh9tb340;
	arc=none smtp.remote-ip=210.118.77.11
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402EE606A327
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 12:58:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 402EE606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=bh9tb340
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20261102125819euoutp01932a4a529be523ccbbca861094a80373~kO8wkiNAz1966719667euoutp01b
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 12:58:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20261102125819euoutp01932a4a529be523ccbbca861094a80373~kO8wkiNAz1966719667euoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1793624299;
	bh=i3Eq0UzhBUrozYwhFxDujSvYgE1qs5i/5z/JE8WaraY=;
	h=From:To:Cc:Subject:Date:References:From;
	b=bh9tb340G52E7aYD8ixj+tL8jri/TsAzWbwF4MaJkBOY2skgb2M/4vZVAEq2fX0h7
	 nTs2yKSaSC5AsKnNk0G/3wM4DqkwaTMxDXttozmqYjPozyWVOlOVYVuiIhKqNzvTcN
	 oudwoNZyhp5AnZhPmTf2jvLlc5jwxchVW0Cjac5U=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261102125819eucas1p1cdd9308cc954788d200e219f43d5ec4e~kO8wWMaxq2336423364eucas1p18;
	Mon,  2 Nov 2026 12:58:19 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261102125818eusmtip2d465bc14a4c1f00eb3c0f7f72a013ca3~kO8wCUDww2434124341eusmtip2f;
	Mon,  2 Nov 2026 12:58:18 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: linux-samsung-soc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, Alim Akhtar
	<alim.akhtar@samsung.com>, stable@vger.kernel.org
Subject: [PATCH v2] ARM: dts: samsung: exynos4210-trats: fix BCM4330
 Bluetooth GPIOs
Date: Mon,  2 Nov 2026 13:58:10 +0100
Message-ID: <20261102125811.3111427-1-m.szyprowski@samsung.com>
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
X-CMS-MailID: 20261102125819eucas1p1cdd9308cc954788d200e219f43d5ec4e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261102125819eucas1p1cdd9308cc954788d200e219f43d5ec4e
X-EPHeader: CA
X-CMS-RootMailID: 20261102125819eucas1p1cdd9308cc954788d200e219f43d5ec4e
References: <CGME20261102125819eucas1p1cdd9308cc954788d200e219f43d5ec4e@eucas1p1.samsung.com>

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

Fixes: 132e900a47b8 ("ARM: dts: exynos: Enable Bluetooth support for Trats board")
Cc: stable@vger.kernel.org
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
This patch was developed with LLM assistance and have been tested on the
real Trats board.

Best regards
Marek Szyprowski, PhD
Samsung R&D Institute Poland
---
v2:
- corrected SHA in Fixes tag
v1: https://lore.kernel.org/all/20261026103555.968273-1-m.szyprowski@samsung.com/
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

