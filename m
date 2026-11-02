Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793641526;
	b=tI8076HvYmehnqXGIZXxtsYH+46rtTWMA3ZRDoc8hikFYJoaxYYOjGejsTFws0t/aIET
	 H+Lcg4gmTvXMyrFff+0VDfkVsXwKdr0Q5ECGGe6FibOv73c26VGU+Hpr2KgF1b8IKFRqS
	 a7ViSavfuM9rR+RoMOTHZfvWvKrVT345xYs7ThJfY9Yuyx2Xz8ndpstWm11HUT1rk6c9s
	 RoKMiqhSLQ6IH+BFEQAwCu4x4l4AnZkHaCfJE1bbBnKhhIwiia1uKEfm66Ip/IhZ3cRkb
	 glhFRK5/wTnGo7pFriyUM09eA8oJHqA8Cu/uPzihO7hs1PlIxcAtjS4wY6ugK/A1a3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793641526;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=druvbJvBN6ko55G4pQr8mGOqphalakbTk9dYFbwjgLM=;
	b=Xcif2HcyT9rQpOj37rqaJECgJU7uia/NZL2ZzN4KdkKZVY9ByT1Qbw9dh8CyheGaL2dL
	 89f55vV7HRSm51LXWFw7Ugmg6xcyon2A3JtPk/75MoNT9RiJEgKpdWtIRfTIKQtCP0OmS
	 CTbUDGOsRaf5Xlp8ru3UfW2TDp3G4koWeSggqQVMqnBh4TaOfMmbRKYO+pJ7SA/2yk9YV
	 h8w2M+z4ajnUL8NCyBGWdmkR+0sh8geRJ4m5e7rdyb2gHliBHWzRenGvF4sWOoVFIaK2+
	 wgRCn22ldksXt5QsVQiwu+OAMUWX11XUJl6PqD8cU+8yylCs1FAMG77KhoJtXQeQZhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yd6lo9yE;
	arc=none smtp.remote-ip=74.125.229.9
Received: from mail-dy2-f9.google.com (mail-dy2-f9.google.com [74.125.229.9])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2210060850A4
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 17:45:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2210060850A4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yd6lo9yE
Received: by mail-dy2-f9.google.com with SMTP id 5a478bee46e88-35eaf84cc66so3201702eec.0
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 09:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793641520; x=1794246320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=druvbJvBN6ko55G4pQr8mGOqphalakbTk9dYFbwjgLM=;
        b=yd6lo9yEWuJUMl/+aP8HN/dtgpx5uQ8WW6Bc1IV4WBj+cefC1XxQftpQqCPoWVqBDz
         N40TxHXTAY62ONZLRupG5OGeYB7sO/8Qq3f9wLtCjEvtG3zxXfn9tp2mbxlhCvFOTMmH
         AB+9B4D0Np9BS9YcpbJRVHjoxQYEowFcXJq0iwKxynkx+wxRvDMcEFTptyrCgQi93mVO
         2ZvLeoJN8VVVlIektlJfwSKxSimSqLRmcqO3FFDxX2BthAmXUMTXB84JSStR+RDRVInd
         TdLhPiGDPK9zH/bTfgb8W2f0IpIyrrFUVygHAf7hETB+4t+d2bt1R4kM/ZTGJuFvvXB6
         kFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793641520; x=1794246320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=druvbJvBN6ko55G4pQr8mGOqphalakbTk9dYFbwjgLM=;
        b=bBTPnw8OpH3PqdkdXyXEyCGzMT/xVr+yB8G7f7HOIpvlXxrl1HclzyEeAvfgEKDpg4
         IFybxgtMo76sKWioptgybaPGh9I2ww/hiiurWISj21KfOtXtSN/5j6rdAka0KNePEmzk
         VflNYwmo83mfZXFHp+Y3Db1YNlbiqwpEqdPYJhKWqf2xaiZ6VBU1gPK2SS26scS796pP
         J30yJzYF+yRNwyYiCMNpFVdlK5OFQZGR4jpQMVWa8J9qdgwsfzlfxZCiTA8/vUBbE+ie
         lAz1ZY8Si+2R8fm/sVNBGeST2GJws8Hyp/kFVdG5NeUJ3CMsqYcHuedkkzDL5Xhz9Vap
         hmhg==
X-Forwarded-Encrypted: i=1; AKwUvBws4LT96DHF2JSjOb6Eq5TFYDrEnytVAI7Zg5YeOTXjdGkqzRxXagmAdsQSqvh/k29ym6q/asA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJT9OC7RxXNYpzEVDN9YvDePWTUKKxlnpgxVjPmfcOc6fDdSO/F
	bxO9hPR1L53MGY5xNVLfQhQHQ1uiGWr0PEWB48MHnbMc+yVdSFf3mOzv
X-Gm-Gg: AYBFou1oA8JWdiJwle7E/2wn5XCxYiMmuNe25+dTmryxDfoV87rqzo4TJQUlQyRxx02
	mji99MF9f0DugdBasuoZQKw8droClJETqOwC8eo9XX7EPpo0I/LtAQ4G8NCbQ1XvW8dDM+dOjwK
	smQcetGiOnO9Z9fI6WWm/vAiujg7CIkEQ1N8HwFwwmHWz7+kLu8NIOiVEIs+ebJvYAHsCEzmD5V
	2M5PYittiUafW7vQQs01EwvpnRw33Wl6EW36BadefWUbS71Sh+MPHS4MiFOvjSzk+QVzjnhkKLl
	MZ/MoTBv0HVCp+0kc+g3ooXWradgV/uK7j6URKNBw6qYHjQxE6NiyeP0OH6Y8wyKPGbD+xJp2zz
	da3mQMN8meUTmsZMcB68lxkMjCB6ifDphDmJz6w4md3ENPXKgRpfXcxRbRfeKjUzo1ilrvT4nH8
	nXS8rOIJQxLnY0ClxZtrBnrupIo+NXk2+a0l2jYyJFBzw4hYrFl0bIw9OAzvi5AuDrEMLgiklyv
	7shhYwy1SDfKt0BxP1VmY7B0ZvsgfSyDSGtFNyN2yXtYui3hhEE944A/72JXxquRolxyhObBrRJ
	y/49nxOSs7ABYbA5EXtZwhDWjE4=
X-Received: by 2002:a05:693c:6316:b0:36a:7bb7:4609 with SMTP id 5a478bee46e88-36a7bb74690mr123492eec.34.1793641520162;
        Mon, 02 Nov 2026 09:45:20 -0800 (PST)
Received: from server.lan ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42935b4asm53290803eec.16.2026.11.02.09.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 09:45:19 -0800 (PST)
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
Subject: [PATCH v3 5/6] arm64: dts: rockchip: fix USB OTG power on Photonicat in battery mode
Date: Tue,  3 Nov 2026 01:44:49 +0800
Message-ID: <20261102174450.3000397-6-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261102174450.3000397-1-coiaprant@gmail.com>
References: <20261102174450.3000397-1-coiaprant@gmail.com>
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
fixed-regulator, add a regulator_5v_boost node for the VBAT boost
converter, and a regulator_5v_out node to represent the OR-ed 5V_OUT
rail. Bind the vin-supply of regulator_5v_out to regulator_5v_boost to
ensure VBAT is boosted when the system runs on battery. When VCCIN_5V
is present, D16 takes over.

The USB load switch (vcc5v0_usb30_otg0) is then supplied by
regulator_5v_out. This restores USB host functionality on battery
power, matching the vendor firmware behaviour.

Link: https://github.com/immortalwrt/immortalwrt/issues/1534
Link: https://github.com/photonicat/photonicat-hardware/blob/main/Photonicat_rk3568_sch_20221116.pdf (Page 15,18)
Fixes: ba124e06ce7b ("arm64: dts: rockchip: add dts for Ariaboard Photonicat RK3568")
Cc: stable@vger.kernel.org
Signed-off-by: Coia Prant <coiaprant@gmail.com>
---
 .../boot/dts/rockchip/rk3568-photonicat.dts   | 49 ++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-photonicat.dts b/arch/arm64/boot/dts/rockchip/rk3568-photonicat.dts
index 7e0a2ab829209..290e3ee97c709 100644
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
+		regulator-min-microvolt = <3700000>;
+		regulator-max-microvolt = <3700000>;
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
+		vin-supply = <&regulator_5v_out>;
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

