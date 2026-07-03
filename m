Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D3B175A97
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 02:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783047424; cv=none; b=e9CXZqvYppaMhwkhP+lW0Q068ozVKTOuLLfwzAJIHcuhHU6emvROi59J5FDZ9C3lGAp+szOrjnbmx1yUg2mdm72QQBr+OrfRYrBA0LJTMQtd+xwPXlyU7+5wT/MxWnH8X1XhJYIOW+HMJIx7OWOH8+3i25dha65796trQ8rGvgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783047424; c=relaxed/simple;
	bh=IsERjZASmoVoV1lYOdhQ8tqxvr21ky0zobJZ277IM2A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E9BpqDtiaR5fmdQhCBvmBeRb3lWqm4Y5HdGcHbhblSgTI40z9y2+Vqvt3Vudgwal+ID8uhltgQ1+sj7jyPrrg4tz68aJP62WJPoDuazTzr3YfeRDvlewpjFsesnCfhs0ptbMLtA4+6QvYZicJ3TRlMAIBSm/DhBiisXiL5dGzro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RBS5G8Ci; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBS5G8Ci"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c9ef3e1337fso61213a12.2
        for <stable@vger.kernel.org>; Thu, 02 Jul 2026 19:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783047423; x=1783652223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JlV3zJ5RwhKne2jUh8CcjrZlF2RdUTEpohrGS1TCb5w=;
        b=RBS5G8CillKqu/Cpoawv+Lt+EExiFWvpLQqd9w7AkzDXUcYPw2ON4uBj1+Gw4QTv+D
         FYkSWTJoncNVo1EQupI2P47mEdk03XpiHX5aOWpmRJbsVMImOD11l7j5VGmPoR2fc3/+
         ShfdlpYm46TruxBMoaDQJr1MYmyZErKcXdte7L7VObvNo0n9PcNPBR2TR+oSAsqn+bOq
         xGnmtYR7p2RdPoaaRLOik7Liyog3mysD50uO5lsj8PdWf/QDh42fWPDhgYhMW7oTGhJx
         HYTJB1GqgBF5rcvA/5JtQdEgBRjrH3G26brkNRSucceDN/Gs6RCK64ys5mbPyr/nO4yl
         JpxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783047423; x=1783652223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JlV3zJ5RwhKne2jUh8CcjrZlF2RdUTEpohrGS1TCb5w=;
        b=cAcJizvEM+uv16Ww0iiz3dk3bCp1hVFGfPmX0ocfCw3tFNOU+5dbF5FVwpQk53HcuV
         dlFAPZQfkzpwqwXT9Afn75GGd3lQ1hhMaSXng9lZh5s9uuyCfWEC8eROh25P32KeO/88
         fnfTPo1b1TlL0Iga/T1fybAAzLabkUgmrGrMJgdT/ggPxdTTcWkfhV4QPfcO4TshveOQ
         phuTTgHfCewkZcDq9/87F7pt78W+Flphw/BL/S332NlP7lM1IjoiTB8MZvOxLWXpFP4g
         Maovfx2BgKeT9PK0BQbcMhkLXpQ7INqnOusVAwDZx76kRjRe3EL0PqdROEhD+k/KzbbM
         tojQ==
X-Forwarded-Encrypted: i=1; AFNElJ9QfNHMylQNT06Hr1NITlGtTabQR1+/hq70XgH+n6AK4H5iTOrz+BlTTZg+Rn3lWw+4GRsxw6I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2TvTIU09AKjiC3TDGUSryDqNgWtnuzY2K5jai8YCdJCxoink1
	tU37+heISNv6jcNoB/TmTOEEZgxuC9E47KyKkj7FuyAhQl/9WrSS1HUu
X-Gm-Gg: AfdE7clZSR+pDY40gfzf184jiSUh/Jiql32aAtMe/w1exuZZwvpqwzUuc9E+hX0z6aP
	MpKoYZuXxiWQpHhzyQMDzGr35g3v8U7AdErdELuWTGFjbmkW4B2XGYYYuh9fM7R0t9w4xbGdknx
	A+IfgXjAGgNF/gjH9Cjw/tgNZFt2tOcrGz6vuL/h2a5PhvJFncwEc6/pv4C41wN2n08p+afUP7w
	CYbAxEZ1dd2LHTdmzHlSpLP2HU4i8ziPWsyl27qSIXI+3gvjgrEUNS2AZtHlJVoLTzl2hBtniif
	GxNJd6ZN/0gfEqcIPkRjeUr+wcPr73JOHOMi9DfGiugc/SUA3Fo8Aiw6i93edVvrFQWo9Etwu47
	WgSHk1AHYW4uN/qHP5B7L2/fjLiW3VzbuIB8QOZaZS90Bdq60xEk2GIWOv/qtE2ay55OslivV8X
	9UDCDDO1t60W7IcZ37UIpsIMAetP4gkfCYUn8sY7h+lkCNI7NAWEQI8/ZlVnA=
X-Received: by 2002:a05:6a21:4516:b0:398:9379:d04d with SMTP id adf61e73a8af0-3bfed22ecacmr9856159637.24.1783047422829;
        Thu, 02 Jul 2026 19:57:02 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:1b3:a800:5116:5334:8739:4661:fde2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c7fa65asm14645620c88.6.2026.07.02.19.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 19:57:02 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: heiko@sntech.de
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Fabio Estevam <festevam@nabladev.com>,
	stable@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: Fix rk3588s-roc-pc audio description
Date: Thu,  2 Jul 2026 23:56:48 -0300
Message-ID: <20260703025648.180135-1-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@nabladev.com>

The rk3588s-roc-pc ES8388 codec is connected to the i2s0_8ch audio
interface.  Use the matching I2S0 MCLK output for the codec clock
instead of I2S1.

Using the I2S1 MCLK can leave the ALSA PCM running while the codec has
no usable master clock for the active audio path, resulting in silent
headphone output.

Also make the CPU DAI provide bitclock and frame clock.  This matches
the active Rockchip I2S controller side and avoids relying on the codec
to drive the bus clocks.

Route the headphone output to LOUT2 and ROUT2, matching the old 5.10
BSP device tree.  LOUT1 and ROUT1 are used for the speaker route there,
so using them for the headphone widget can leave the headphone jack
silent even while the ALSA path is active.

The old BSP also used hp-con-gpio on GPIO1_A4.  Model that GPIO as a
simple audio amplifier so DAPM enables the headphone connection when the
headphone path is active.

Cc: stable@vger.kernel.org
Fixes: 7f9509791507 ("arm64: dts: rockchip: add DTs for Firefly ROC-RK3588S-PC")
Signed-off-by: Fabio Estevam <festevam@nabladev.com>
---
 .../boot/dts/rockchip/rk3588s-roc-pc.dts      | 23 +++++++++++++------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-roc-pc.dts b/arch/arm64/boot/dts/rockchip/rk3588s-roc-pc.dts
index d534d662c40f..99853880aaac 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-roc-pc.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-roc-pc.dts
@@ -23,16 +23,19 @@ analog-sound {
 		compatible = "simple-audio-card";
 		pinctrl-names = "default";
 		pinctrl-0 = <&hp_detect>;
+		simple-audio-card,aux-devs = <&headphones_amp>;
 		simple-audio-card,name = "rockchip,es8388";
-		simple-audio-card,bitclock-master = <&masterdai>;
+		simple-audio-card,bitclock-master = <&cpudai>;
 		simple-audio-card,format = "i2s";
-		simple-audio-card,frame-master = <&masterdai>;
+		simple-audio-card,frame-master = <&cpudai>;
 		simple-audio-card,hp-det-gpios = <&gpio1 RK_PA6 GPIO_ACTIVE_LOW>;
 		simple-audio-card,mclk-fs = <256>;
 		simple-audio-card,pin-switches = "Headphones";
 		simple-audio-card,routing =
-			"Headphones", "LOUT1",
-			"Headphones", "ROUT1",
+			"Headphones", "Headphone Amp OUTL",
+			"Headphones", "Headphone Amp OUTR",
+			"Headphone Amp INL", "LOUT2",
+			"Headphone Amp INR", "ROUT2",
 			"LINPUT1", "Microphone Jack",
 			"RINPUT1", "Microphone Jack",
 			"LINPUT2", "Onboard Microphone",
@@ -47,11 +50,17 @@ masterdai: simple-audio-card,codec {
 			system-clock-frequency = <12288000>;
 		};
 
-		simple-audio-card,cpu {
+		cpudai: simple-audio-card,cpu {
 			sound-dai = <&i2s0_8ch>;
 		};
 	};
 
+	headphones_amp: audio-amplifier-headphones {
+		compatible = "simple-audio-amplifier";
+		enable-gpios = <&gpio1 RK_PA4 GPIO_ACTIVE_HIGH>;
+		sound-name-prefix = "Headphone Amp";
+	};
+
 	chosen {
 		stdout-path = "serial2:1500000n8";
 	};
@@ -327,12 +336,12 @@ &i2c3 {
 	es8388: audio-codec@11 {
 		compatible = "everest,es8388", "everest,es8328";
 		reg = <0x11>;
-		clocks = <&cru I2S1_8CH_MCLKOUT>;
+		clocks = <&cru I2S0_8CH_MCLKOUT>;
 		AVDD-supply = <&vcc_3v3_s0>;
 		DVDD-supply = <&vcc_1v8_s0>;
 		HPVDD-supply = <&vcc_3v3_s0>;
 		PVDD-supply = <&vcc_3v3_s0>;
-		assigned-clocks = <&cru I2S1_8CH_MCLKOUT>;
+		assigned-clocks = <&cru I2S0_8CH_MCLKOUT>;
 		assigned-clock-rates = <12288000>;
 		#sound-dai-cells = <0>;
 	};
-- 
2.43.0

