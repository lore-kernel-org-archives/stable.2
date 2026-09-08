Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6913051E429
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 11:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788866376; cv=none; b=gxb0PshnEUnMfhI6uR0EVYjmMCqk9cLpibDEHJhpP1/D5hbFbk9gU4tcNmb9DlAJ2riCkm1r57dMswIZXI+9XO8U3zu22ablSV3CoFdw4Jhno3R0umlfeni1ohAyHxMWkfgGRt9tKB3F+XPkdDLCehKkYcVSTcawyJoA0N9N/C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788866376; c=relaxed/simple;
	bh=9O9kWGGQbODtRL5UAdOuaAinJL8bBPDsv7WUv1hTnnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=glDVf2oWXcWwV3Es3s4VBlTswaMMomPfLS2STOLS9MYME78oMZoLTSfzVdBgSJ4ofRGMRud+ekM1Fg7Mr+qgFZQfgk1m+WZuUW9SlyUIg7oas2pinP8gZ0fckzAnTv6n3Fr7Im846e+Z1wFd9UACisZARlz5vm2bD9hEoZOGxMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rxsm3lPX; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rxsm3lPX"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-499db1a5b5eso1086205e9.2
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 04:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788866369; x=1789471169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bMadN6VBiKEQvvZox4M1avk0HRML78KU4CFtSbLK3WM=;
        b=Rxsm3lPXjtOsq1hx/7RxBKcxjgKMvn30bD6YpJJ4fVzzU+dDl7uVNIMHh/T1gahU54
         S6P9oHrfld1hU2yw9l1mtSedUlysUtSzXGUFgZvnmNdjMSsQHmdr0CMLeIqVAweH40kR
         tj7LGOi2fhwAhR5baHueT7rHFTZ4S2fWtWtpD8R/4WpbGLQTAZtnXyc55l2cpgXLIG2B
         rJWK3VES0Y37wMkFMH8sHJL41Dbm38gcROwCDPdfJW7Wb3b8D0toJ3ewEt5zORQMY/la
         JghS6sv65UYICvQ5xmFVj8J5EBXt6CwUbnv0xncJbJsbVa+VwlOyB16DKAfs0V8tiaex
         WXyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788866369; x=1789471169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bMadN6VBiKEQvvZox4M1avk0HRML78KU4CFtSbLK3WM=;
        b=F9xm9ZyR+3fHdXYv293Qg1FiIzGeJPAmuYh4qKj3kpV6yTC5PC3SJeApRLWkrl8Vxr
         Pkk4wkvTPtrY1wHMGXOzun0YP1oDVtH1J+dcu/eKOu1q2I8eAmVF5MAlrEdUOlG1kleU
         Q+4L30O+hbKJj7Y2zbE5y0Xi7/ijk8xpiVemEFDCBk9UKgAqCW73dH84hczjr5ntIcXk
         XynwtT/0wyblkyxygml6e9J/o4ACIGING1GIVF2z5qt3vNAH1H0ol6jTMYN/SXRR0YhV
         i4SqGbtabDMOQbMlAgF2AUwDXcp8YOHGtCnXiEWWFOThuamyP4tIKHKdN7hprm7eATrY
         Eicg==
X-Forwarded-Encrypted: i=1; AKwUvBzRm1rFAMkQXZ2RXN9d3U+ETeZgG/40EhZi+WNLDeWubiZCWyyZtgr36nS5PfhhJy7rnGzjXDw=@vger.kernel.org
X-Gm-Message-State: AFuF++ndyBS/dA2hjvBjEPMak4ruFSXWdBtqBAuf65DCbX+kDItPz2t9
	GtiYJA1iQvRJbllw1Xb2FJX9ASoFkvGb/JIFr0XxEbdFpsZNFB6ftG60
X-Gm-Gg: AYBFou1TnNVjRisKK4fjBXLi6xMnNsrr7QX0GOgtFb0+M+9ES+kNfOVsbacHeuZpupa
	RsxNihDjH0Ih3ISyPIhRz9Vx8JiKpaxiiSsPxlEfnBzGmOEw/rX5YqThntqTSLi4VWjnEyv37U0
	Tl4TXaDVK3DWpYPo1tW0K7i4ocRNuFiva9yq9Veam/5ApwG1AWEHCYG1t31wTV+l6eP6+MUrAEk
	zoPS1XfKyXLTlyiavluKG5qJZskYrUW/AkgKWBfbM+2yjQb9W5xDKWdWg6LU3xfkst6ISQXEaYF
	l4MUdIkz8c0bXKKOxaeFnDZ5daK+pwUurrS85jG5s6zfwigsHXWQobcK/78bqifZ033qiAZKeoE
	RXwXagQ6PBxK2QGObE8UeAd1Ri0hetZ3p2LWs9evrzFy0+RbK26PyKigvY14trVNUiFHTK8r5U+
	1Y2SQsxOJtpSQdRuv9IyOgk08LxEKdqbvMb1G7VPe+d5rm+3eHTyKRGSq476s/tJvIReQd/cqqN
	Al8uYHb5Pv4No4zQsLm3G4uYT3kS91DyDjfx/8FH7NPr5gQaCZIl8wol7QLJ4wMMj/G
X-Received: by 2002:a05:600c:8b2e:b0:49c:cbf4:572b with SMTP id 5b1f17b1804b1-49d01dcc1fdmr173785985e9.2.1788866368697;
        Tue, 08 Sep 2026 04:19:28 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME (20014C4E1B825D009E74109367A274C5.dsl.pool.telekom.hu. [2001:4c4e:1b82:5d00:9e74:1093:67a2:74c5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce58da3acsm973747855e9.0.2026.09.08.04.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 04:19:28 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Ondrej Jirman <megi@xff.cz>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Igor Paunovic <royalnet026@gmail.com>
Subject: [PATCH v2] arm64: dts: rockchip: fix hym8563 interrupt pin on Orange Pi 5 Plus
Date: Tue,  8 Sep 2026 13:19:08 +0200
Message-ID: <20260908111908.19371-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The interrupt line of the hym8563 RTC on the Orange Pi 5 Plus is routed
to GPIO0_C6, not GPIO0_B0. The vendor device tree uses RK_PC6 for this
pin; the mainline board file uses RK_PB0, which does not carry the RTC
interrupt on this board.

As a result the alarm interrupt never reaches the SoC, so the RTC alarm
cannot be used as a wakeup source on this board.

This was verified on the board by enabling the alarm interrupt (AIE with
AF already set, so INT# is asserted) and sampling the EXT_PORT register
of all five GPIO banks: GPIO0_C6 is the only pad that follows AIE
(high with AIE=0, low with AIE=1, in two off/on cycles), while GPIO0_B0
stays high and its interrupt counter stays at zero.

Switch the interrupt and its pinctrl entry to GPIO0_C6. The board has an
external pull-up on this open-drain line, so no internal bias is needed.

With this change the alarm interrupt is delivered while the system is
running, and the RTC wakes the SoC out of s2idle.

Fixes: 236d225e1ee7 ("arm64: dts: rockchip: Add board device tree for rk3588-orangepi-5-plus")
Cc: stable@vger.kernel.org
Assisted-by: LLM checkpatch dtbs_check
Signed-off-by: Igor Paunovic <royalnet026@gmail.com>
Reviewed-by: Ondrej Jirman <megi@xff.cz>
---
Changes in v2:
- Drop the internal pull-up: the board schematic already has an external
  pull-up on this line (Ondrej Jirman). Only the pin number changes now.
- Reworded the effect paragraphs to state only what was measured; no
  functional change.
- Link to v1: https://lore.kernel.org/all/20260906181622.11991-1-royalnet026@gmail.com/

Notes for reviewers (not part of the commit message):

Measured on an Orange Pi 5 Plus. The input levels of all five GPIO banks were
read from their EXT_PORT registers via /dev/mem while toggling the alarm
interrupt enable through /sys/class/rtc/rtc0/wakealarm; GPIO0_C6 was the only
pad that followed it.

The s2idle wakeup was measured with the v1 form of this patch (same pin, but
with the internal pull-up still set): 'PM: Triggering wakeup from IRQ 52'.
With bias-disable, as posted here, I re-checked that the alarm interrupt still
increments the hym8563 interrupt count at the programmed alarm time, with no
spurious interrupts on the level-low line.

Note that on this board the resume itself can still stall later in the USB 2.0
host controllers (a separate issue reported in [1]); with those controllers
unbound the full s2idle cycle completes. It does not affect this fix.

[1] https://lore.kernel.org/all/20260907190000.s2idle-usb2-resume-royalnet026@gmail.com/

 arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
index 145986695720..3f2806284754 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
@@ -189,7 +189,7 @@ &hdptxphy1 {
 
 &hym8563 {
 	interrupt-parent = <&gpio0>;
-	interrupts = <RK_PB0 IRQ_TYPE_LEVEL_LOW>;
+	interrupts = <RK_PC6 IRQ_TYPE_LEVEL_LOW>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&hym8563_int>;
 };
@@ -298,7 +298,7 @@ hdmi1_tx_on_h: hdmi1-tx-on-h {
 
 	hym8563 {
 		hym8563_int: hym8563-int {
-			rockchip,pins = <0 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
+			rockchip,pins = <0 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
 

base-commit: 1fc5a74b108fc90951890ec513ac81869f5eaff1
-- 
2.43.0

