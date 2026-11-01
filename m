Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793561395;
	b=MZqWWFUvZgyMJQ1d+PfLMXntApL7ZEyHBrxcZwLVSObdDrbGT5q16sYOUE1C9jXdNKSK
	 MuxrC9I7ZpXDdColDDrJbPv8/I4M+MadnPK1mY2fmbD5kXFPiUUclGxuc2y6zxA31Zxgk
	 ZEtgAXLFTRKrgo56xi4Ra5nsdPg8vz/vjdqtrUXyJ2B1/7DKmWZWDUsHVK9WISLWhGO+C
	 c0jJwxB7ktrbTa48tXnQQKTn6tqaysJGKXObeochaPwLohPKJxnGQcaXo7OxJa9APUetP
	 X+UAnkbeFkrCShltFVPEFsuQs5joc9UrM0nR6of/zOIAa2ASCDe7FsR0UTBAlItBGng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793561395;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=AmWM5i5bcYLOfgd6JgqgudQuIbo9gKLsDd/ijE1n9kA=;
	b=OmrqPqbqSLrTxPrwwKDovmPj6RWMSYs6I7Kj+k1f7lmpayEc6o+kXjuL21YgywcnuVLA
	 NudlSaJJNPbW29LE675owBvTLQn59GboUCD/KdNXpz7TOMo/e9RWq01gcXiB3kmyKGj7i
	 fiyHUwepZxNhQlPKMFZFhw0tDFrWvf4+ed9aXPDv2lwwnmuh9adPh6z75xqCPNADPUqrW
	 9x5mhbDpM0okfdS0Du8H8iCx+Xpd0kDzItrmRZeGpX5hgRCr6RhWke/LURNMfaFxEAbjs
	 TJsCW6bwrIh5vnot8uuM89T6NGcr6IkItt0da4BmHj7PoW/bJFuOTDYo4gI74nNh/VQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DXExrATK;
	arc=none smtp.remote-ip=74.125.229.7
Received: from mail-dy2-f7.google.com (mail-dy2-f7.google.com [74.125.229.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2513B606A33A
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 19:29:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2513B606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DXExrATK
Received: by mail-dy2-f7.google.com with SMTP id 5a478bee46e88-369f126a526so3125861eec.0
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 11:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793561394; x=1794166194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AmWM5i5bcYLOfgd6JgqgudQuIbo9gKLsDd/ijE1n9kA=;
        b=DXExrATKhuv2WetJguNn6T+WIyLaHJQ0dzD4VYgImnZt3ZlQUYnYIQSPTA/j5JbPMw
         9kJfqbPAujFTCGQ4RM7W3G3MwPztfRW/t00V0E+Jy7wU7rDRaAY6rJaY1jgZ2ypTgu3A
         5eBTeZlT13S3IHbV3RU/p7KjD47jw6mRGiDBhvioib3fPSPl4q5Tbyoz/EPVHII2yYG9
         w7haRqtHVQvihwGlXhv8sB4IFMfR50bUeNxYAXk3kf4SXTkW45GDup9xMcGcSgDLbpp5
         QCMY4gDVkUiWm8N4aGC9N90dgJIKpSnU0h6CgvuUelmg9xtw1Feab32eSKvJQoTo/bIi
         byeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793561394; x=1794166194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AmWM5i5bcYLOfgd6JgqgudQuIbo9gKLsDd/ijE1n9kA=;
        b=0kefNX8a8iFAmOKrni1zXBaFHe6H02DSz/+U72ZaE3sNPbV0RXdu5XN0CK96+Agn45
         AcKrTylKlbUU/Tl2VG+vOx1/wrOUcdKGnXnL0GZhlWpbwPZaWyLcTJBteRu61jSBBJhM
         XMIr52o9Vgbb/OGYZ1KbqYDhTVshf7bfwChMt6jvsDZcYJNaKfkYcubUQg9sityxz8hn
         3x+5jmE1zYemTS0UCgU2F0xXk3R6u77O2WfcbLREmh6nNaAFrwgTL6O/FRMLGDEo8O8U
         I8b+4nf+yntItiLug1oyzpfHmQElfr7EUhYG3f1gdg3DXamVbLvvrZJ/pmNedV2IBvI2
         8lZw==
X-Forwarded-Encrypted: i=1; AKwUvBxws1qxvVk9yZzSjjHjq+r3x5OxsU10kE0dvngd6mVNveMDyj3WHKLZs+sL0gkrP7Jz+apaPmY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9RPTYhz8WCQqBxKhvIvO4qaoYjU/rPojsABuKcjAJjqFeTkUWG
	Fdd1a491lrdtaZHLrYbhzweG+mvNs5bxPg53EvrC4Yvo7EzNhWRva0gX
X-Gm-Gg: AYBFou1Jk0V8cK0wOaAcoy7zO30rZq8ZKKMRAz2QjPEF55Rw4JR5ko5W9IsF/Y4uwvM
	axUvQfIAblPR3AK3/Vo3oGBTaXWRR0Zt6ki79soKP8zvtmlqGT4oKP71y9icU4gD7xLYH11qQ6Z
	egwRWg9bMNQbxS5TIkG7tDb3Ed04tW0ZYlpSkF3QXrfrsIVrf/q/v5JqwoeFMqiKKs3qfvubClG
	JJtgKQpFkPj50Bgnp/pbvICmw9s5Wigbh00I6h0IqCUbIeM0asF7yoky/lJApHdAhK+PQHEoZw2
	1qVuYOFLErkgwbEqUUlY/Ul1giEPUyAnJxAALpbwFJ1MzCZmArF/LSoUt/XhaO1ZKsekPnvZWJM
	VAGa7Rr334kjxUPnmV+nVc1V2B+5FPIiO2rLt9aJp2SYGY2J4UXH/ngjb8up3lllMZiuO/zXtpe
	OlekSv7i9eZ/4h1Jda7en3p6oV9LcAzUYo8OumNBw1lZsvDy8nLuotbHgDWCxYtmXxM+WXYSSZU
	ZEA9vxbJZ8/8MH8jmIKtQ0cndrOCB1d6YDP5q9kyBqFU0RgWszWamXF3a52E60n4kLgVot2sRBb
	SzrWv/oVy6qp4VpyArndaT2BuoU=
X-Received: by 2002:a05:7301:710f:b0:359:2edc:e1d8 with SMTP id 5a478bee46e88-36a422039fbmr11538413eec.5.1793561393990;
        Sun, 01 Nov 2026 11:29:53 -0800 (PST)
Received: from server.lan ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428af1dfsm31471861eec.7.2026.11.01.11.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:29:53 -0800 (PST)
From: Coia Prant <coiaprant@gmail.com>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Frank Wunderlich <frank-w@public-files.de>,
	Peter Geis <pgwipeout@gmail.com>,
	Junhao Xie <bigfoot@classfun.cn>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Coia Prant <coiaprant@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 5/5] arm64: dts: rockchip: fix USB OTG power on Photonicat in battery mode
Date: Mon,  2 Nov 2026 03:28:07 +0800
Message-ID: <20261101192807.897562-6-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261101192807.897562-1-coiaprant@gmail.com>
References: <20261101192807.897562-1-coiaprant@gmail.com>
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

When the Ariaboard Photonicat runs on battery, the USB port has no power
output and attached devices are not detected. With the external supply
connected, the same port works fine. The root cause is that the
regulator feeding usb2phy0_otg (vcc5v0_usb30_otg0) is only available
from the external DC input, and there is no 5V rail for the USB PHY
when the board is powered from the battery.

Add a vcc5v0_usb30_otg0_boost regulator, gated by vcc5v0_usb30_otg0,
and switch usb2phy0_otg to use it as its phy-supply. The boost converter
is enabled through GPIO4_D2 and generates the 5V USB VBUS from the
vccin_5v rail. Note that vccin_5v is the actual energy source, while
vcc5v0_usb30_otg0 gates the path; vin-supply is modelled on the gate so
the regulator core enables it before the boost.

This restores USB host functionality on battery power, matching the
vendor firmware behaviour.

Link: https://github.com/immortalwrt/immortalwrt/issues/1534
Fixes: ba124e06ce7b ("arm64: dts: rockchip: add dts for Ariaboard Photonicat RK3568")
Cc: stable@vger.kernel.org
Signed-off-by: Coia Prant <coiaprant@gmail.com>
---
 .../boot/dts/rockchip/rk3568-photonicat.dts   | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-photonicat.dts b/arch/arm64/boot/dts/rockchip/rk3568-photonicat.dts
index 7e0a2ab829209..bcdfe76000c46 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-photonicat.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-photonicat.dts
@@ -151,6 +151,19 @@ vcc5v0_usb30_otg0: regulator-vcc5v0-usb30-otg0 {
 		vin-supply = <&vccin_5v>;
 	};
 
+	/* actually fed by vccin_5v, dependent on vcc5v0_usb30_otg0 */
+	vcc5v0_usb30_otg0_boost: regulator-vcc5v0-boost {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio4 RK_PD2 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vcc5v0_boost_en>;
+		regulator-name = "vcc5v0_boost";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc5v0_usb30_otg0>;
+	};
+
 	vccin_5v: regulator-vccin-5v {
 		compatible = "regulator-fixed";
 		regulator-name = "vccin_5v";
@@ -460,6 +473,10 @@ rf_pwr_en: rf-pwr-en {
 		usb_host_pwren_h: usb-host-pwren-h {
 			rockchip,pins = <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
+
+		vcc5v0_boost_en: vcc5v0-boost-en {
+			rockchip,pins = <4 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
 	};
 
 	wifi {
@@ -617,7 +634,7 @@ &usb2phy0_host {
 };
 
 &usb2phy0_otg {
-	phy-supply = <&vcc5v0_usb30_otg0>;
+	phy-supply = <&vcc5v0_usb30_otg0_boost>;
 	status = "okay";
 };
 
-- 
2.47.3

