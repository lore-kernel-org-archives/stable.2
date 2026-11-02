Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793639957;
	b=WqgE71GfW5GPEmhj/Avst/xuLaaEmyzetaHuneFcbmsHy7VqzCZzNiS99dpv2/aN0qDb
	 eTU07NbonjEmE/6xY82P1Z2N+NUr8c7w+xVCL+Dnw8xutdHvKQMjoeU5BSS8m16y+34HT
	 EnGkB3ox6fhM2+aXwPC38bTiypaW9oGjGtrDsBuC5vDkwyVL2mucAY8Y1sgsd2e/PcIih
	 CekjJK/rPGfAmp9Xma7pBdMi0EeVXIg29zCSMtISyvKzd52mMMBnADYRDy7dvrZ0V3o5B
	 +t4Khrru6djPf6OGHG0eBn/dtAwb8AcUMrTs+SlR6IsJ7AF3xZbt4HkM/t//svA34FQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793639957;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=8UsCKoNbKnaX6mGeBQ8/pSx+fuQaOrU6twLBEIFwNZU=;
	b=iQQkiIpWJuuIHkru86EG2/Ja3+clf8NZXuFUE6rsJT58ukYIIgU1WZkLqOSx7AdQcDe6
	 +I1xDluuaHM2gZldSfvz+yRONcZHDUev7Dma15S4CyifUV+/k9zoZtT7t0+4UxQ9cxgL9
	 r2QOO9VeIZHa3/iBT0mVwlPkEbVURENF3ZYIM+NVNR5DozbnZ9hUR0a9d3+4tWSZPbB6r
	 0Qr+Xz/xTKJsn/YoTxHn14+k1cqfwPq3h61yCBuwGyTE2TysqiaZL+9HGoBbAhVsjux8O
	 ANfLUSOKUOIA6cr26KRBB0pVzyNqOYwfnluAF0xy5Ppu3lb72GPkP+/1XY91Zk5oIsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="df/dOuei";
	arc=none smtp.remote-ip=74.125.229.7
Received: from mail-dy2-f7.google.com (mail-dy2-f7.google.com [74.125.229.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877636087623
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 17:19:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 877636087623
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=df/dOuei
Received: by mail-dy2-f7.google.com with SMTP id 5a478bee46e88-33e5ae86ff2so1974509eec.0
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 09:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793639957; x=1794244757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8UsCKoNbKnaX6mGeBQ8/pSx+fuQaOrU6twLBEIFwNZU=;
        b=df/dOuei8USjYH6md+Amf5NygtNA0arfOmQ7OMpPOsPVzqPNPTpCnZ3ml9/6iYbyz3
         JimNLgdSgLDTchTLwIHQqEfLV0oQhY3QgEssncjnflo37qZsvjjg0af97Z+v9ztRtkYI
         L6x+9NJzqYo2BDpO1FBgxqvlE57rP2K1dwUkdhiMPOhJ2/Js17D/GjP2PtPAWSNqFwqp
         ccWMb0h57kH2xzTi0bDzglIDdjtGsHJ1Y+wMcXDTBxJGyWlJ4sxXY/9EEHojINm6bvcM
         bd5vGoGfGIFmfz9Xltfgk0zhPxHoF7zXmY5KcucDVIN7lvkN7H2JAi/bv9EDA8W9DY/H
         RxOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793639957; x=1794244757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8UsCKoNbKnaX6mGeBQ8/pSx+fuQaOrU6twLBEIFwNZU=;
        b=NRhVoYS1bLJi9GILIln3CWOE/HoEcrjMY+2KPNVOrWyHHAn9CXMtVnOLH9PgPx8NmM
         F5Vnkn0QI96eKiObqshQ5EJxhucrLUrLHtodU7+7RaPswXC7uWqb+QBgb0Hcfz9yrRX9
         JyMUw74WCEDt2i3GSU/Yf9mtxgy+C3ZST++HvcpYjqAvDlLAL4ary/jfbFUNxhG9yojh
         7d31LLZJ0xAzRwv5czv8tutLZkK3Y5ppfnA3BJMUdh8X5xbtu+EOlcIK2swC7ho9jNqW
         pH3kVJMp17JbVaxy8m6zES9YbI4KJXx+ThRRZqMQ+LfPqlc92GE8ZU6IsVxNyBo17XeO
         xnzA==
X-Forwarded-Encrypted: i=1; AKwUvByJ1CAPxqwuLx/nzCzoP0st1RxFAuFooypbrViCCZkhUxmlrtiWB1CUyYKmdqilbWZsodi4BDI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/7wq6J18lh76BjgPvqUFPIOTV3gYJGPHA1WiQYHjeYDLBOYvEY
	gKz23D/vxAb4o7ZtFSQe62M/2li4nMqjDi1za7Qs22SG6XgLYeFZRWSd
X-Gm-Gg: AYBFou0XbSZmqz79eEWrQBPTSJiQlc3gozy4HvdEioS4dckBXDb1D4ZJSD7Pw0fqdoj
	7KpA8X6BRiP72JYVDO0muV+j0bkEYmADPJo5ldEFmEyg1nyjeLN10a+T/ELUAaLdoF38sk3h+ca
	k9zN2TSQjxlmyv6PGHaUiSYfbSJXNyQKy3kxoXYVzLbvpoixSlZRMySzeB29i/H8bQVkBUFqc5y
	D+qvahQDVWcoMylUJAOBCRuA/PoMPvqaW1n3/BBm/Zbt+nHuE8edeDxLTH9BYSh/DE+p2Bl6ubt
	6yvjvWyQpwolLUnW+esIt77U+FXn059BWpyxlleujzT4SlSwvHJUBhG5NPjlTiwX1RRwfcDcitB
	opW86JgmTuSYepQzbJfnLM1IEOHWHs5oNNGb5gDm2rZIazrheAu/4qJYevxVHbVZGXYaIVUkZ4E
	NYn9jyBmSst2bL995CCF71dQwFe1axXtcg7dmmaZl8gk/4Fk5SyalO8NkVfDzyRZzoLLf8SWprP
	DCSFGZrTN/4tsNMLNJ301FyAPERNFNFiIlscMj8tePoCY/P6Z50I+/ammoAl7y//SMMrsgFMX3T
	BV/t6GNB2j8r2uND9Rp6hzid2CQ=
X-Received: by 2002:a05:7300:c00c:20b0:351:7e5d:2de9 with SMTP id 5a478bee46e88-36a422039cdmr18657739eec.1.1793639956509;
        Mon, 02 Nov 2026 09:19:16 -0800 (PST)
Received: from server.lan ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a429467cdsm36978047eec.19.2026.11.02.09.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 09:19:15 -0800 (PST)
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
Subject: [PATCH v2 5/6] arm64: dts: rockchip: fix USB OTG power on Photonicat in battery mode
Date: Tue,  3 Nov 2026 01:18:37 +0800
Message-ID: <20261102171838.2958552-6-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261102171838.2958552-1-coiaprant@gmail.com>
References: <20261102171838.2958552-1-coiaprant@gmail.com>
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
connected, the same port works fine.

Per the schematic, the 5V_OUT rail that feeds the USB load switch (U12,
enabled by USB_HOST_PWREN_H) is the OR-ed combination of two sources:
- VCCIN_5V (external DC input), OR-ed via D16.
- 5V_BOOST from the VBAT boost converter (U16, enabled by BOOST_EN /
  GPIO4_D2), OR-ed via D5002.

The 5V_OUT rail has no enable pin of its own. Since the regulator
framework can only model a single power supply dependency per
fixed-regulator, add a v5v_boost node for the VBAT boost converter, and
a v5v_out node to represent the OR-ed 5V_OUT rail. Bind the vin-supply
of v5v_out to v5v_boost to ensure VBAT is boosted when the system runs
on battery. When VCCIN_5V is present, D16 takes over.

The USB load switch (vcc5v0_usb30_otg0) is then supplied by v5v_out.
This restores USB host functionality on battery power, matching the
vendor firmware behaviour.

Link: https://github.com/immortalwrt/immortalwrt/issues/1534
Link: https://github.com/photonicat/photonicat-hardware/blob/main/Photonicat_rk3568_sch_20221116.pdf (Page 15,18)
Fixes: ba124e06ce7b ("arm64: dts: rockchip: add dts for Ariaboard Photonicat RK3568")
Cc: stable@vger.kernel.org
Signed-off-by: Coia Prant <coiaprant@gmail.com>
---
 .../boot/dts/rockchip/rk3568-photonicat.dts   | 49 ++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-photonicat.dts b/arch/arm64/boot/dts/rockchip/rk3568-photonicat.dts
index 7e0a2ab829209..11ac78acca3be 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-photonicat.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-photonicat.dts
@@ -59,6 +59,47 @@ hdmi_con_in: endpoint {
 		};
 	};
 
+	regulator_5v_boost: regulator-5v-boost {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio4 RK_PD2 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&boost_en>;
+		regulator-name = "5v_boost";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vbat>;
+	};
+
+	/*
+	 * 5V_OUT is the OR-ed combination of the VBAT boost (via D5002)
+	 * and VCCIN_5V (via D16).
+	 * It has no enable pin of its own.
+	 * Model it as a fixed regulator depending on the boost converter,
+	 * so that VBAT is boosted when running on battery.
+	 *
+	 * 5V_OUT supplies:
+	 * - VCC5V0_USB30_OTG0 (USB VBUS via U12 load switch)
+	 * - VCC5V_HDMI (HDMI 5V via D5000)
+	 * - J53 expansion header (Pin 1)
+	 */
+	regulator_5v_out: regulator-5v-out {
+		compatible = "regulator-fixed";
+		regulator-name = "5v_out";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&regulator_5v_boost>;
+	};
+
+	vbat: regulator-vbat {
+		compatible = "regulator-fixed";
+		regulator-name = "vbat";
+		regulator-min-microvolt = <3400000>;
+		regulator-max-microvolt = <4200000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
 	vcc_1v8: regulator-vcc-1v8 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_1v8";
@@ -148,7 +189,7 @@ vcc5v0_usb30_otg0: regulator-vcc5v0-usb30-otg0 {
 		regulator-name = "vcc5v0_usb30_otg0";
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
-		vin-supply = <&vccin_5v>;
+		vin-supply = <&regulator_5v_boost>;
 	};
 
 	vccin_5v: regulator-vccin-5v {
@@ -446,6 +487,12 @@ pcie_pwren_h: pcie-pwren-h {
 		};
 	};
 
+	power {
+		boost_en: boost-en {
+			rockchip,pins = <4 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	sdmmc0 {
 		sdmmc0_pwren: sdmmc0-pwren {
 			rockchip,pins = <0 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
-- 
2.47.3

