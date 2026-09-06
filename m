Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715773C09E2
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 18:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788718630; cv=none; b=iWfpL5iiWNnLtqgNlsGRSmAqqssLcYw/PLVi/4QALJLnwNjiuArGmpfyOD+G3vSH57z8y30Z+0d6xx+zopzsaseWbsTx2hHiPvhNoeaVwTeg3/zDj19eomt1PZ+JmBVbq6wTKmoXtTxGRjWvxRB6yB+j2nBGh0SA7echxlh7pT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788718630; c=relaxed/simple;
	bh=zE/2hqn4I9P57cCKdIKN6nY4HEnzOsNL+Lxb4BdK5Vk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=plEC5ZZ0yqBDhii1W6Ct6nTEp0D+6uMfwLCYiKKNxBQoyulEM5g7qpdQzdYl40133iS1T1GYVHqOb5o7CDmtEJxR8zd6PmMs7nt5YijgdECknzH1QQW7AYeQTyhZhdard/d7tBiYtDhWW+hCkSVPrr3QJ52PZYrR2K6FIBpTm00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K+o5tDm+; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+o5tDm+"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-499db1a5b5eso375495e9.2
        for <stable@vger.kernel.org>; Sun, 06 Sep 2026 11:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788718625; x=1789323425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=R/mSQMe/ffg+AP+VO4769NtESa1TU8r20BVXKonSb5k=;
        b=K+o5tDm+s9drKsg+ic/JvPkVIPEltlhZlGhLNY3dXQumcoqVAeOn6hL4zwTjQivGro
         Dcdk9YEf6K2yA2iF1kb615YITnEuzz43ghFR/x+dKWPRcaoGAhka+nE1M6ynpaCR1Tyg
         E0O25V7Iklcg03P+D2VjvO0tHN9CBZSdVr8dVR+JwCCq/+b6szLM4FqizQkm2hhKZRxW
         8SW3eh8Tvdo6xA72XqGhDzZfshvENnuUuJLncC+0MECM2fF5d+PL1JZA9Aly5WlN8QJ8
         NcCZu/UEMET+PHJKtAgyMX3OPtKf96LvCJ2aiYCgFzMFZVWQDKtjQ9vlo/3/t1bujd/A
         Oi4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788718625; x=1789323425;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R/mSQMe/ffg+AP+VO4769NtESa1TU8r20BVXKonSb5k=;
        b=i38C6aum6OlMDVoNgexZIcRK8FGmlsfcL7PkHIkcE8uRTzxQtz/BEZ3ylAWlY/6JlE
         PxQ4S13t9C/JzUMbXrSzhN4X/sMKn8lcJuQI75HZHGXALHeKHoWG7Cmes+K6qCUp9OiT
         vRg50i0qOSVEVJKNjYObT8Xm6mNvOiIeK3sdw1TQzDqsIy5KcWR9YdDvlXRXWncYC7S+
         PhLYUFA/2+mtO0XBWZ+y2HfUpsSGL6iSU290ckCm3S71TzSXalX7yjA3DA9oBeGk89al
         y8I3dyuk2VsvSBmK7zbz5axgVLFmkgs/mSIBd0KMysE5dZMGW2tIUUTryM1KXHG28QTT
         nA5A==
X-Forwarded-Encrypted: i=1; AKwUvBxP2s1XK/lIv5vG/sqUsXyXTXYvddqqM664I7EemIHwfu/G0H1FVELRAAGCyuvT3b4ystPRfCA=@vger.kernel.org
X-Gm-Message-State: AFuF++nNTf5VoqtiKdnPK84+zMBR3o4H+MRm0zBDaQ+89/EsLXHECN85
	IrEr2DNAc9QFMzLM3RMwCYOXILsGW8dIBLrBjQf6PfdNhe4zxNlCF31O
X-Gm-Gg: AYBFou1WukwDO8vJuHlNlZM4+r2tGGdf0KCaXIE2WS4njTdBhRwBBcc4BSd8g1pcNt3
	it2AU0HxIXyqvqd4WfWb4MEeTNQ04v/6ie2/NlW9iy6OJgl7RMkZE2OOUIAURm3KDPMIUz1VaVR
	qaZ4x45cTn2tCbM15r6fCG2s4ChfdXOKOXlyVVs/fx+nBkfyBoBVOz7xEGy/6YGWon6EJkNjWtm
	MxZll7eTIBe0XxP5e9ymHlxvDqitIcPKf8VVCWRXk/gaBY+5w24hXAzIl8EyHVUP0dj/rUwITsv
	YB0k58oPyfwQ7Tpaky7uxGYDBQ7dSmplhhE4xkULKjcge54i3e/7fWOGg6rIFVmtNe8dYQWIX7n
	RgRXiAdfEgz0JbMfmsfcJqtwL4DbNCS/+zDfAIfnjeN/MdLrlwK04O9fI1EOV/5DWkI8PDQehOi
	gXuOFrD4uR7aLxXa7yLd6qoH2H1FA99nzDuzMiJ1sr83M+RBclc5z9eo+jQCO3XOj9gIx1+Rcis
	nz3f0GVQQixEZb4RDpZvjSh95vQVq265pZIgV72IAzmy52+IPJT5b0OsSfVXLgGSvQ4s0jvq63m
	J7c=
X-Received: by 2002:a05:600c:c494:b0:49b:916a:e553 with SMTP id 5b1f17b1804b1-49d010c2a57mr100932445e9.0.1788718625331;
        Sun, 06 Sep 2026 11:17:05 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME (20014C4E1B886400ACFAF9D8E9019935.dsl.pool.telekom.hu. [2001:4c4e:1b88:6400:acfa:f9d8:e901:9935])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf75ce49esm433916725e9.1.2026.09.06.11.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 11:17:04 -0700 (PDT)
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
Subject: [PATCH] arm64: dts: rockchip: fix hym8563 interrupt pin on Orange Pi 5 Plus
Date: Sun,  6 Sep 2026 20:16:22 +0200
Message-ID: <20260906181622.11991-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The interrupt line of the hym8563 RTC on the Orange Pi 5 Plus is routed
to GPIO0_C6, not GPIO0_B0. The vendor device tree uses RK_PC6 with a
pull-up for this pin; the mainline board file uses RK_PB0, which is not
connected to the RTC.

As a result the alarm interrupt never reaches the SoC, so the RTC alarm
cannot wake the board: rtcwake enters s2idle and the board never
returns, which looks like a hang.

This was verified on the board by enabling the alarm interrupt (AIE with
AF already set, so INT# is asserted) and sampling the EXT_PORT register
of all five GPIO banks: GPIO0_C6 is the only pad that follows AIE
(high with AIE=0, low with AIE=1, across repeated cycles), while GPIO0_B0
stays high and its interrupt counter stays at zero.

Switch the interrupt and its pinctrl entry to GPIO0_C6 and use a pull-up,
as the vendor tree does for this open-drain line.

With this change the alarm interrupt fires while the system is running
and the RTC wakes the board from s2idle ('PM: Triggering wakeup from
IRQ 52'); before it, rtcwake never returned.

Fixes: 236d225e1ee7 ("arm64: dts: rockchip: Add board device tree for rk3588-orangepi-5-plus")
Cc: stable@vger.kernel.org
Assisted-by: LLM checkpatch dtbs_check
Signed-off-by: Igor Paunovic <royalnet026@gmail.com>
---
Notes for reviewers (not part of the commit message):

Measured on an Orange Pi 5 Plus with the vendor-style method described above
(GPIO0 EXT_PORT sampled while toggling the alarm interrupt enable); the vendor
device tree for this board uses RK_PC6 with a pull-up. With the fix the alarm
IRQ fires at runtime and the RTC wakes the SoC from s2idle. Note that on this
board the resume itself can still stall later in the USB 2.0 host controllers
(a separate, unrelated issue being looked at); it does not affect this fix.

 arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
index 145986695720..572b892e4066 100644
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
+			rockchip,pins = <0 RK_PC6 RK_FUNC_GPIO &pcfg_pull_up>;
 		};
 	};
 

base-commit: 1fc5a74b108fc90951890ec513ac81869f5eaff1
-- 
2.43.0

