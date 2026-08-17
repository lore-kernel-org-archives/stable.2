Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4D43C6A5C
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 21:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787003722; cv=none; b=ZzhYGqhQrRm4ZLoW/TClPS7bRgBWTAJ9lQuXng4nPs2Tjroap8+OzzxIexgErQUtBzRWqBwYD1nApmE3NQvxEG/wXieItH63rfZ46wDzmzmbJoxuxrVLN06Z4eTgcTtYq+JzgyF5o1csXKAOor8m4jAvjiyu/JxJuRzKLiUal4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787003722; c=relaxed/simple;
	bh=8EMlG6R/cw7SoID55yTqFGHDLwMbLeW2jwmeF10chJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EvXI7c6YBPTiLipMI3IJZGAIYWH6U5Q79bSGBG2Wjtr5hAYdx3W0+OlTtaSPgrNXkjlDsxuaCs11IYaMXLedmlXxBy1SufzRVDsJ14jX6mNT92lakJzylgNYM/b796ukF9swsHHmPHau4yXIygzICATsBozC5RBc1kCoZL+fX68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aT9ygKin; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aT9ygKin"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-498028b3d5eso50134025e9.1
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 14:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787003712; x=1787608512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kyG2XouO94IC0oaowF4bLz5IBlinDO6829l+v8pLt/w=;
        b=aT9ygKinfbupuOkba5NnnDu4BX//6ohQZvyC9xHRRn0tmb+i8x9xELPhiEmrIbrXGK
         tmGLskE7iqURrOEDT0FYpo5nS4zVzel108GdcAvpXiuajMEnmrOG02KKcMmdtPRyPCh8
         waG3abe+VKfwI+L10I+K9Ki5q8Yj5QsoYdIN6pzsSde5qWOt4ajOnaQlAyJhTFC1UTmc
         klJ+l6BxMPpai26FKYN2swj+4EOVPV8LhCOQGggGRGIjhTJtcwROOFWQ3jnWDWUbZjIY
         +en6OlRZpskdEBeMScmop3kP9fOHh/6bov9/rdPgRj1t2tJZ3rUDWecITELvJn9UzZQ7
         RpWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787003712; x=1787608512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kyG2XouO94IC0oaowF4bLz5IBlinDO6829l+v8pLt/w=;
        b=majZn4XbOW3YcJIJR2sH054aEFp6IhBCcBVBc+hFdqASl/ZY6FeN+1BkGoiH7+39Sl
         IUILFCW1Pqbwv0IsxFwfbxYgsNwgBNQAxbmfQSiC5J1SDCCnhtE8mYcz1Qt7fkBi03aD
         38tn2gIuDUayprUeDcyDTFGjQwb1e5v4WbkxCcA5x6TgBIjJ5lec7Y9nOAsovl5xGlH+
         4H6JOLJHCuBgCQYuq9yGKUtYrk3BdfneJP+K6/seBmazfTh9A5Sldhi3LglMZbNXHwLi
         qz7hEZZDvGCn0bnLncgR0RSmqnkywmdYU23EOkEqMa/tWLtjPNpoAUnv4/y2+GzPD2Li
         31SQ==
X-Forwarded-Encrypted: i=1; AHgh+RppAB642t7IFS1J7LTcTgRGvqHvS9yMMr0gft9vAvDo/mOxIsyGdp0oWyGUmNE0kdWIQFcCSg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YykV6vhkvUSqvRWBIe/ii9rXJCr0W94XTs5EleyhYiqcNjaUG8l
	yFwh7ILotUb3BqulNXplfOKHwplGBQZsvRSeXraP7kWnDujjeOTVu6KN
X-Gm-Gg: AR+sD10WoC5vPvhYjwPGr3ZH5mwKrfEkk9O5V5/A9rYOPyAl6ka1qBOuK8ysPcITDDl
	SWax7b7phdl/TGgtGFLToHa1LlH7JPsn4AiFmSX5oXT0G+0NFDItxGiI5wL8eyag/+dvCgHTSxe
	532BlC4cKJhUIJzynORQ0woZfpNTlh2iPN46YwtvztnCpEzIECSYNmExpu3bHJlSXucNvroap1T
	05i5LeGD5Js6GhCSarHeFGZeqM3CS+B+CJEAmB4ogO7dcRsFpxwIW52nwOjvSti+NyvepZxM5XU
	e8axVgMPF7AXcUW69KockTRWgu7K/nAgZDbVvyKUlWICxHlJ43PCedyo8jYvjU8+P6jIeNKoyDk
	TL+hPAgrsIenOro5L5YLSrWMf3tPuziSgi1clXPUJeq3Rcv4uZ/DZq7DlyOBXcLC9C9S84eXU+O
	DqOUyAjSCQoayljKoyroyT2B7ucGD74qg+0BxdSqmqTCvCC+rdCOed+FhDLGpX9NCWT5OioziKD
	5o3E6yr0voJazH1qGCYhowIKmFw3bC3D9EVcMF9u59th21Up8VWVsGc4c4i887bwqbTEAlEExU1
	IX5Kvl9lwQ==
X-Received: by 2002:a05:600c:b99:b0:496:c379:b2a1 with SMTP id 5b1f17b1804b1-49987929903mr398757195e9.2.1787003712299;
        Mon, 17 Aug 2026 14:55:12 -0700 (PDT)
Received: from localhost.localdomain (85-118-76-205.mtel.net. [85.118.76.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49987b2a176sm309622525e9.4.2026.08.17.14.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 14:55:11 -0700 (PDT)
From: Georgi Valkov <gvalkov@gmail.com>
To: briannorris@chromium.org,
	johannes@sipsolutions.net,
	andrew@lunn.ch,
	krzk+dt@kernel.org
Cc: francesco@dolcini.it,
	johannes.berg@intel.com,
	kees@kernel.org,
	miriam.rachel.korenblit@intel.com,
	wenst@chromium.org,
	rafael.beims@toradex.com,
	avraham.stern@intel.com,
	error27@gmail.com,
	s.kerkmann@pengutronix.de,
	gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com,
	robh@kernel.org,
	conor+dt@kernel.org,
	Frank.Li@nxp.com,
	chunfan.chen@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	stable@vger.kernel.org,
	gvalkov@gmail.com
Subject: [PATCH v5 1/3] dt-bindings: net: wireless: add flag marvell,ignore-regulatory-hint
Date: Tue, 18 Aug 2026 00:54:26 +0300
Message-ID: <20260817215428.84740-1-gvalkov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CADOrJmbTyrGGkq+9OJDXCgTa2HvNo8BWxoE6yjafcrOq7WNamw@mail.gmail.com>
References: <CADOrJmbTyrGGkq+9OJDXCgTa2HvNo8BWxoE6yjafcrOq7WNamw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

WRT3200ACM and WRT32x routers always report a fixed US regulatory domain
from the mwifiex ROM, which conflicts with the platform regulatory
configuration on units sold outside the US market. For example:
- phy0 mwlwifi 5 GHz, hard-coded region 98 EU mapped to FR
- phy1 mwlwifi 2.4 GHz, hard-coded region 98 EU mapped to FR
- phy2 mwifiex 2.4 and 5 GHz, hard-coded region US

When the system boots, it detects a conflict between the user selected
region and the radios, e.g. BG FR US, and applies extreme restrictions,
preventing use of 5 GHz and DFS channels. This also affects phy0.

Add a device-tree flag, which allows affected platforms to ignore
an incorrect regulatory hint from ROM, so userspace can set the
correct platform regulatory domain.

[1] https://github.com/kaloz/mwlwifi/issues/173#issuecomment-307879699
[2] https://github.com/openwrt/openwrt/issues/9956

Cc: stable@vger.kernel.org
Signed-off-by: Georgi Valkov <gvalkov@gmail.com>
---
v5:
1. description: remove tag Tested-on
2. add #address-cells = <1>, #size-cells = <0> to fix a warning:
arch/arm/boot/dts/marvell/armada-385-linksys-rango.dts:183.3-13:
Warning (reg_format): /soc/internal-regs/sdhci@d8000/wifi@1:reg:
property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)

3. description: add info about testing

v4:
1. Add binding documentation for flag marvell,ignore-regulatory-hint
2. Add dt for sd8897 and move the flag there, I used sample from docs
3. Use device_property_read_bool in the driver

v3:
I implemented and tested a better approach with no board specific code:
1. check for a device-tree flag in mwifiex_register_cfg80211in()
  !of_property_read_bool(of_root, "marvell,ignore-regulatory-hint")
2. add this flag to the root device tree of each affected board
Currently this affects only armada-385-linksys-rango.dts,
because Linux has no dts for venom. OpenWrt will take care of that.
This approach is more flexible and scalable, because the flag can
also be used in other drivers, e.g. mwlwifi (not part of Linux).

v2:
Replace the compatible device names, which are currently only available on
OpenWrt with board names which are available on both Linux and OpenWrt.

 .../devicetree/bindings/net/wireless/marvell,sd8787.yaml    | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/marvell,sd8787.yaml b/Documentation/devicetree/bindings/net/wireless/marvell,sd8787.yaml
index 930b700b73d0..5f235cb9f3e5 100644
--- a/Documentation/devicetree/bindings/net/wireless/marvell,sd8787.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/marvell,sd8787.yaml
@@ -59,6 +59,12 @@ properties:
     description: Calibration data for sub-band 3 in the 5GHz band.
     maxItems: 502
 
+  marvell,ignore-regulatory-hint:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Ignore an incorrect regulatory hint from ROM,
+      so userspace can set the correct regulatory domain.
+
   marvell,wakeup-pin:
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
-- 
2.55.0

