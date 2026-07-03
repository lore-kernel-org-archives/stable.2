Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB92632C92A
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 20:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783109433; cv=none; b=RgKHTNd7F61c+k9s39vIGrsnDRy86TdW9pLLyq449sW0QmmsnUB9ELuElm5yV9Tlah0cy3w5MmaFbwRVbHy6Tjxai0KXZnUdxMgoOP2SljKWEDa/15OCZz9trdK4jYvv0c6B0KmOz2NyQbTZ/zlojNboPUVtkT27mRoq/LUe3a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783109433; c=relaxed/simple;
	bh=He9wd9IbrQP2KSQwF5K2+zJwvvEyQHC5+Yuz+010GQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hCqI2yb8ipS/Amf+27aWnCSZJbxlTz/9B1hJGNVBA2Gn9t/UjpBkbZS3Iw3vs7aQhFIjrsm5ORGv9fR0CLrW6DkdTlyRuewzFNJxCN6z+FG9b566dYa4vW4h7DY/AeebZ/ZmpY5Qni64J1izMgJn+CgJ6l9MahfdyUN3c861lkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YXiXe231; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXiXe231"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51bfad59921so6257301cf.0
        for <stable@vger.kernel.org>; Fri, 03 Jul 2026 13:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783109431; x=1783714231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VqnVxuePfzGralo5ejKJTMgkZosmeyctDuCT0QENgCw=;
        b=YXiXe2318KrU/NSWoyLfZvFitIe/ZWYd7E1zkHni8xxK44fOYVg8KGhysyb04D6Dbd
         WsOYugRunDHb5YWgSbxkWqnrh5sapynSUB3p2UiyaY8Mvb+Lu02JcflYIk2BYumEpP9a
         uzUgW0acVwRKLi7pSJEiq08nH0D6T6tI1t+dYkkEcfGmIQGKemTxFBq5rk0qu5ec0nH+
         5aN5ScSVnNe5JrMlLqSDSOFpk78Wvl0t8j0zg+mVr12aNe3BroS0Z+CAywv6amoPqtvL
         TSWr9jzqQ1kJfKCsMAdi1qzFQb8dp/qjQ3zmpkMcv6ipbyLwcKIEsmSZ0uYlafng9MWP
         5qdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783109431; x=1783714231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VqnVxuePfzGralo5ejKJTMgkZosmeyctDuCT0QENgCw=;
        b=eGFk+nJNl4DBO1gzLU7Qa6VnFRRfgLhY6nuqTG9eLEV++6yKMSkQwqzs6HTsW+WqJm
         kpZQGcJWIZUBInJcmiDvlyecHHoiijwKbx3UjitKtgxUX4AIb1OOxIbrrXpcdjyolnBp
         W1Bn/lkwI6yh1VX0oftcTVM89YcfDNMjRdFJH/HCBFyYYcDLRmnvQXIztKcCpIMZul6c
         pr0XkORsoJpfZdKNUXnld3cMIBKnKFtOW9Xj9UCm/lgUOxBHR64vVqrOll303zUm0yax
         F3gMXryP30Osnmb5zcTKJZZl9uIz0K4aTqDRHZzrb0Wof3tMWp/WzhY7QmSMM5Tf7F7w
         XS7A==
X-Forwarded-Encrypted: i=1; AFNElJ8R41b7+9SWI8lcD1zqfkrKOFI9Bd7933vPQnGBqf2nsFxpcxp2c2uOh/unSMPy8XswJAXYKnM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXg/Ad1R43eT3zCCvMXp8VwbHpRyUeGkixR6V3retVuxhRA8eZ
	en+2i+7/+qJ0eH0UxXcWXXfDhdY+izoyOuqLISVTfuKW8CqGB/lx/i8k
X-Gm-Gg: AfdE7cm8TXuC/kpdhLQhWCa/fd6EAPYHisDdUK6BUapTwx2rMyUvdh6HsdLFL5k7onO
	eBercJDKya+r23fGpXEPv9kBONA1qsAUlw0wUUragabY+9sZMFt+jfFmpeQtTcJzqwvCUgkeR9Q
	vHUXmJN/4PQeEkIKHbghcQ/1+yoH5ZiVz7DQdPkT4Jm+KSq3EnC3QDCopeId1DePIxCV2FehjQj
	r+lKculY2WY2IPnJsDPAOHz+LEAAsRcOnc0gvVOrQ/YJytnM1K9HVJcIs2tDHO98091bcc6O14/
	O9OUSsxFA1P8kDDv6uOgCdSSYxyK9DuM5clAY8Ys/x7DZNG+/AW7w41Ve5qMnYP4qY8/4BKF9EN
	fv7Otf8VnLFfq0+UHimuGLjqLgd+jaBRRDAHS0FBSr1jQXYiX14d9iMVwHtlM76HiQrt0RaRCWU
	613tYFgZPOt2MoLEU1vHlldUk5g5L0uFZ1omYvSg609MnkUTPWnLZxhhKP+GX+aFSctFSePc0KU
	Q==
X-Received: by 2002:a05:622a:85:b0:51b:ecca:f2e0 with SMTP id d75a77b69052e-51c4c1e6500mr15034181cf.5.1783109430605;
        Fri, 03 Jul 2026 13:10:30 -0700 (PDT)
Received: from oklopfer.hsd1.ma.comcast.net (c-73-167-46-184.hsd1.ma.comcast.net. [73.167.46.184])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c41df52a6sm22259141cf.27.2026.07.03.13.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 13:10:29 -0700 (PDT)
From: Oren Klopfer <oklopfer37@gmail.com>
To: oklopfer37@gmail.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Heiko Stuebner <heiko@sntech.de>,
	Peter Robinson <pbrobinson@gmail.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	stable@vger.kernel.org
Subject: [PATCH v2] Revert "arm64: dts: rockchip: Further describe the WiFi for the Pinephone Pro"
Date: Fri,  3 Jul 2026 16:10:10 -0400
Message-ID: <20260703201010.67311-1-oklopfer37@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260615225014.219115-1-oklopfer37@gmail.com>
References: <20260615225014.219115-1-oklopfer37@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 096bd8c679185f898cae9933c6a68650fa26ea4f.

Just as with the Pinebook Pro, there are multiple chipset variants for
the Pinephone Pro, and multiple firmware binaries for different
distributions. The change causes issues with some of these combinations,
and reverting it resolves the issues. See the Closes below for the full
report.

Similarly with the Pinebook Pro adjustment, the original commit only
indicates "further description" and not indicative of fixing any
existing issues, so reverting should not kick any back up.

Fixes: 096bd8c67918 ("arm64: dts: rockchip: Further describe the WiFi for the Pinephone Pro")
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Peter Robinson <pbrobinson@gmail.com>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: stable@vger.kernel.org
Closes: https://lore.kernel.org/r/20260607225901.64019-1-oklopfer37@gmail.com/
Signed-off-by: Oren Klopfer <oklopfer37@gmail.com>
---

v2:
- Repair malformed whitespace

 .../boot/dts/rockchip/rk3399-pinephone-pro.dts | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
index 8d26bd9b7500..d46cdfe3f784 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
@@ -734,12 +734,6 @@ light_int_l: light-int-l {
 		};
 	};
 
-	wifi {
-		wifi_host_wake_l: wifi-host-wake-l {
-			rockchip,pins = <4 RK_PD0 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-
 	wireless-bluetooth {
 		bt_wake_pin: bt-wake-pin {
 			rockchip,pins = <2 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
@@ -766,19 +760,7 @@ &sdio0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&sdio0_bus4 &sdio0_cmd &sdio0_clk>;
 	sd-uhs-sdr104;
-	#address-cells = <1>;
-	#size-cells = <0>;
 	status = "okay";
-
-	brcmf: wifi@1 {
-		compatible = "brcm,bcm4329-fmac";
-		reg = <1>;
-		interrupt-parent = <&gpio4>;
-		interrupts = <RK_PD0 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "host-wake";
-		pinctrl-names = "default";
-		pinctrl-0 = <&wifi_host_wake_l>;
-	};
 };
 
 &pwm0 {
-- 
2.53.0
