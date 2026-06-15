Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DED237F731
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 22:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781563833; cv=none; b=BCIzcb4wa34WFv64EAtXtVYMCiOnmBjQYtYg3lbvWNkphIU6ucL0Q7kdexYc4tSmw15bVSeoUxOnU+Ok1oWjQW7qGOjZ/7vacyN9Sr+dqpOqJ6Bi2E0Varkslk0Pmelvo1wLLGDnZHtXNAh8u4w18hT4hEL9HLCdxqbKuWU/2ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781563833; c=relaxed/simple;
	bh=ZwxtX8vlpId8QMj7A7z/8r5GynOM1gv3V1E0mgepv7E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YhETS7BiQie0CwEbk2OR2+xKdfjxgJCzdZUAaDH0j9kynh4uTfuQHtJ+reuqhLRRnJYNgs05R3X1iSt/DOmFv+BHXXA16e3vXowtFb+P728bfQ+ITsKLr9wJjtCGJxpOOoveHyl+I8esicQCkRrPNP51Y9NSFdNf6q92rW5Yw7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pqWKyfyJ; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pqWKyfyJ"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-9159f631656so470560685a.1
        for <stable@vger.kernel.org>; Mon, 15 Jun 2026 15:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781563831; x=1782168631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VVS9U0UK2IIxJF55elsvQ+90uQ+p090ADnS+1Vo5OFY=;
        b=pqWKyfyJZRvtJm5y3EUH7AbY3tutBR7ZpkQKu6/GRd5uyFdcEQTSKmBrW6R/qJ33ja
         GmABCf5KW1yhC8dGjVoZtlPE+BcaHEoPnBrufXPJzh6r/W1V/pU7PIqaRkPmv+6+omlr
         YPygfPMa14zP5QS20ZABhYfeeR4CRuse7xTE+Vlsny/XX/JfDrGcHjXjv+HpCI/GdkRD
         aSsJlBvu0AgYPrvsm07er8t3sevbfi9WPiVzNvYEW0SPr9mDD5SaGqN/1W+Q99WhkE4O
         0po2smcRnXv/0svjWUAHDPUtWmhLntraonJtucFhPBY1N4qh+o44s/iMN3CmRVzq7oCt
         Twng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781563831; x=1782168631;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VVS9U0UK2IIxJF55elsvQ+90uQ+p090ADnS+1Vo5OFY=;
        b=LalTRgMvaqUlpRHPtMKwhc8hsQJh6KeWm0rMkCUAjfJi6Qo7rG5eSs+wOzufjy6oHO
         kPYiGUfnV81vsCltl9mqq3ta8gTycEPbZhIhCuZDOosTjvdq5uzCVjHcgz+34yi0bXT/
         SWx0H8lBc0OA72fmmIniN1tySFscsIGRi8BXBQKViKChyfAemUC17H2znlIeSr6VckhQ
         M3Zk86sGp3uOlD5oH/ZTwUQDFNzX/qV+L58f9RgFy+Am5nWyKpesv97z6bMPzeuV1cUk
         +mAsLpf+0l5Jm36yENRyRYELwP83BUEgDvXl/+7/JfnatswxqBTZ4axt8wu9GrqCwuFN
         9O9Q==
X-Forwarded-Encrypted: i=1; AFNElJ+9BjSMCPwDE0lC4zIMBjqopIQQ+HSh8t49xJ9FBc3QVSA2FiaOYdw1xT7LzDfIZbvXQf1sT4M=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz7FNbago5UXmIqdsmaJzTLnMMQeXTudHL0Wk5J51uUFrPn7o/
	dSRYqG1xjuYysAyvTK9IZ7o1Dam2Q+a/NbdvzUgUBdD5f/g3gPVS4pgl
X-Gm-Gg: Acq92OEKNImk7fEiGVQn5ZLmRhEPPGcy3X5PMjM+Z1SOXEHd9j+yF1mDXb+lly4u62h
	kefe3ifJONS6nA+mqjfx2s1yMCTq4il7fKHCZsjcV0u5jUUliPT0P+Htd0GQhxwQ+Dwb299w7nb
	ViJmL/aaniYWMu5oLNfK1KqHlgtGcrkDSSCWPNTktEumMC3cQ5R0+9hBn+vSGMIHSjsHIcNo4Lf
	bawCMtT5l3k9qX6nTHN42Xkv1WciVBnXETopwFZ95/I690/46c6hqOQkuZB5KfdklUUhR6RPE57
	T7JxiFRVzfrNJdgMMSknNehrYf/67xHSmPlFU86uRPOYGcE2Hh0hI86/tsw7dZbDcqm6uK67x0T
	ssEWrnp+1U17eygcDUGvnMKWvH7S/bK7MMM0ifmL/xmh4qUnYvbkFary9pUBDWApuGHBu9RSf21
	KBoCda3kiug80+/ASKeLsnsMLSxwachALF2IysEAXUvXE+ctK30YfNlQ1Ky28nHlkJdOUzb0pOH
	/MdtiWiXzc4
X-Received: by 2002:a05:620a:4626:b0:915:422c:a0 with SMTP id af79cd13be357-91c2e9077admr216456585a.22.1781563830584;
        Mon, 15 Jun 2026 15:50:30 -0700 (PDT)
Received: from oklopfer.hsd1.ma.comcast.net (c-73-167-46-184.hsd1.ma.comcast.net. [73.167.46.184])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9161a069389sm1273568785a.45.2026.06.15.15.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 15:50:29 -0700 (PDT)
From: Oren Klopfer <oklopfer37@gmail.com>
To: oklopfer37@gmail.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Heiko Stuebner <heiko@sntech.de>,
	Peter Robinson <pbrobinson@gmail.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	stable@vger.kernel.org
Subject: [PATCH] Revert "arm64: dts: rockchip: Further describe the WiFi for the Pinephone Pro"
Date: Mon, 15 Jun 2026 18:50:13 -0400
Message-ID: <20260615225014.219115-1-oklopfer37@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 096bd8c679185f898cae9933c6a68650fa26ea4f.

Just as with the Pinebook Pro, there are multiple chipset variants for the Pinephone Pro, and multiple firmware binaries for different distributions. The change causes issues with some of these combinations, and reverting it resolves the issues. See the Closes below for the full report.

Similarly with the Pinebook Pro adjustment, the original commit only indicates "further description" and not indicative of fixing any existing issues, so reverting should not kick any back up.

Fixes: 096bd8c67918 ("arm64: dts: rockchip: Further describe the WiFi for the Pinephone Pro")
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Peter Robinson <pbrobinson@gmail.com>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: stable@vger.kernel.org
Closes: https://lore.kernel.org/r/20260607225901.64019-1-oklopfer37@gmail.com/
Signed-off-by: Oren Klopfer <oklopfer37@gmail.com>
---
 .../boot/dts/rockchip/rk3399-pinephone-pro.dts | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
index 8d26bd9b7500..d46cdfe3f784 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
@@ -734,12 +734,6 @@ light_int_l: light-int-l {
         };
     };
 
-    wifi {
-        wifi_host_wake_l: wifi-host-wake-l {
-            rockchip,pins = <4 RK_PD0 RK_FUNC_GPIO &pcfg_pull_none>;
-        };
-    };
-
     wireless-bluetooth {
         bt_wake_pin: bt-wake-pin {
             rockchip,pins = <2 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
@@ -766,19 +760,7 @@ &sdio0 {
     pinctrl-names = "default";
     pinctrl-0 = <&sdio0_bus4 &sdio0_cmd &sdio0_clk>;
     sd-uhs-sdr104;
-    #address-cells = <1>;
-    #size-cells = <0>;
     status = "okay";
-
-    brcmf: wifi@1 {
-        compatible = "brcm,bcm4329-fmac";
-        reg = <1>;
-        interrupt-parent = <&gpio4>;
-        interrupts = <RK_PD0 IRQ_TYPE_LEVEL_HIGH>;
-        interrupt-names = "host-wake";
-        pinctrl-names = "default";
-        pinctrl-0 = <&wifi_host_wake_l>;
-    };
 };
 
 &pwm0 {
-- 
2.53.0
