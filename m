Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFFF468C33
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 13:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787835846; cv=none; b=hGAjBFAclq/mou4mil1J5PdBu26x5j2IiX7NRjqMWK9Mi18MwvOGWq6sXHNLmexmNI4c9g4wATbEPgvTMvxxQHrkwTe9T05a8A5pmQCFkh1Ab1sVQq+s2UWP55ChiJEG4Yz53FKGhGja/lES/P/TbvywBQKbKQOmY+NLJGcrDQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787835846; c=relaxed/simple;
	bh=+DL9LZKznnwk8GOx61vpD1OEMGHGZYiiUREj1sCBmQs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HdhY0FTEpL200fErAehi+YUmIoDBjeP8VybfHVLHP5Ph/Xd/S5SSFyJyEt079BxWVt9XkCFI+T+MjZrLUZRL/s1fptgB8L8M4HMEGZrBvPJfkNwxBFKeQ/QloNghiEUSRFortDQBeRDWNVqWGhFZgA2gD/zD3cP7PtP+tmuSDeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZoWULO8; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZoWULO8"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47de0093c42so1713070f8f.3
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 06:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787835831; x=1788440631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fnPxGtE/YvJh9NvWxjMwiLTzPApsKlz9gccpke1iOiI=;
        b=IZoWULO87LXUq5fNPvgS+PlWfh/e1Jdk0JYWAAby+pMlCiFfMAskWrnQAybYZ4hizY
         i5jGYBNY7SLby4uLrGEEh5FEK20hHwq0gj2XP0eiOiJ80ruCR6iayHMvbgSmxwbxtSuh
         +EtfelgzAdVvZaj9np1ZFzkUJEbJz8Af2fnXaixgpa0W0n3QBDDXfT7JRTP/dtcdxfwY
         GBC4OBRQq0B4vQW1d5bT4CDUSt8N/C3d9j3VXfaIzCgeTCrpZrEQdzVznoYg4NmpfXhY
         UwUws/OlRlJmptNfglQ11NbKtrNPUMzjDbQKZL6mhMAg+epL7oqeBdXMcJCoIAlWBZSu
         F0Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787835831; x=1788440631;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fnPxGtE/YvJh9NvWxjMwiLTzPApsKlz9gccpke1iOiI=;
        b=jEyVZZhw5EzRN4fpcKo/igQHONuMgU+c5oETKIac0Y1AA6+hcSJPUQoG07MwHdcVKr
         2/D08oCw5zGVTzS0XaqlsQIfeACfZkNHi/rrUnL8j0jGzSpS7Ju9BowV3TWN1dV1PCL3
         fgx03kpE2W8xnk3/1hJMaJIGfIHbkfZIQCbZTLdUNSoKAtE0w1UM/6uks0CA1W2DOTb3
         xVY4rQgXtVr1B0YjZFrbB0vWzeVQ3hxnv5IoXbz2corXFBfSEX21C3/OC2ry9Wb9AQu8
         PB9CgfbVO+HWWgnZNUUQ9wgnR8fRP3AwB2XZk0sDmjQkPM/XThBE33hXTvs6lCB/Pgpe
         uumw==
X-Forwarded-Encrypted: i=1; AHgh+Rp4T5fRqz4GkQ8zTUXSzYAWup2dd85yDSFzFLQO8JNULnTt2m5apM/66S2/9Mi0RaeZfnmAI5I=@vger.kernel.org
X-Gm-Message-State: AFuF++lse11kSJ/0fnIcc6DIMiLqNMC5GnHy/V0ISw85vSkcgZeC2LxB
	zdfy/oQGjX3OVM9eiJGdGYPrj6d3DTklYhsiIEQyDC7pxXno+nI8cB3v
X-Gm-Gg: AR+sD10WOYImLNGncAUePoRCOqOJE1NpV5zcGdntYp7QBJ+RPOEgWS2yULWjujiZNzG
	fkOtTBxhtxveyd5K56/cVC/WvK4H3kP4K0v6QjPK9xBl87LMOZH2yszGgsfAmkAf8f5kIBvspD/
	dTAi6QQqWKbysY3tRuaAI2Ad9W/bDmij+Afg/w7I29F8ymT5YiuaxzhOO1TkNbsg5zl8b2gvLrB
	ZSAunZ8NmM3k4sWDyzqvGyjcyLBQNCY92pwWfXELYkdLZoXkmCK+lykI5EXpJfJTXIQfFFRWAjL
	jOKgzXomIKIei0dlnLq63zl7oUiCgcVUEYOBitzGacQdjHX2J50gMmIX25dDHowtXU5b+o0K+Sx
	8isyKypda0hqSLqUHqxvy+xpbCw6SQYX/NlS8XDFkTAM9gAHwejl7y8jNkGs3CfCVOW7GiNSnIP
	u5SHKabQMPSH3EG/O30zBZqhf6JK9yzfBfq6BqfM+la6jOC3BQRY0t36G2XVpUtUriQQblgsutI
	dzIGdY+Og1Ng2bhj155CSB0/EYsqEkwUyb8gxn/jPpZ4eAt6/8CPNUb1qjM1Akx/Na9XYFN9SI=
X-Received: by 2002:a05:600c:4592:b0:499:b402:6c0 with SMTP id 5b1f17b1804b1-499dc6eac3bmr172187105e9.3.1787835830323;
        Thu, 27 Aug 2026 06:03:50 -0700 (PDT)
Received: from localhost.localdomain ([2a01:5a8:737:d4a7:e53b:30a6:3c0f:1dad])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b49610170sm116081285e9.6.2026.08.27.06.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 06:03:49 -0700 (PDT)
From: Georgi Valkov <gvalkov@gmail.com>
To: briannorris@chromium.org,
	johannes@sipsolutions.net,
	andrew@lunn.ch,
	krzk+dt@kernel.org
Cc: francesco@dolcini.it,
	johannes.berg@intel.com,
	kees@kernel.org,
	miriam.rachel.korenblit@intel.com,
	rongqianfeng@vivo.com,
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
	arend.vanspriel@broadcom.com,
	peddolla.reddy@oss.qualcomm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	stable@vger.kernel.org,
	gvalkov@gmail.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v7 1/3] dt-bindings: net: wireless: add flag marvell,invalid-reg-hint-in-rom
Date: Thu, 27 Aug 2026 16:03:33 +0300
Message-ID: <20260827130335.6606-1-gvalkov@gmail.com>
X-Mailer: git-send-email 2.55.0
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
preventing phy0 from starting on any DFS channel. phy2 works.

Add a device-tree flag, which allows affected devices, where the radio
conflicts with the platform to ignore the incorrect regulatory hint in
the ROM of the radio, so the platform regulatory domain can be used.
This does not allow the user to change the regulatory configuration of
any radio. It only allows phy0 to start and operate according to its
certified configuration.

[1] https://github.com/kaloz/mwlwifi/issues/173#issuecomment-307879699
[2] https://github.com/openwrt/openwrt/issues/9956

Signed-off-by: Georgi Valkov <gvalkov@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
v7:
1. drop Cc: stable, the first patch only documents a binding
2. restore colon after Tested-on as requested by openwrt-ai
3. mention the added wifi@1 node

v6:
Rename flag:
marvell,ignore-regulatory-hint -> marvell,invalid-reg-hint-in-rom

Clarify commit description:
The patch series allows affected devices, where the radio conflicts with
the platform to ignore the incorrect regulatory hint in the ROM of the
radio, so the platform regulatory domain can be used.

This does not allow the user to change the regulatory configuration of
any radio. It only allows phy0 to start and operate according to its
certified configuration.

The change affects only platforms which explicitly define this flag, and
helps overcome the incorrect behaviour of proprietary radio firmware.

Rearrange patches so that the flag is implemented in the driver, before
being added to the board for WRT3200ACM.

Link:
https://lore.kernel.org/linux-wireless/20260728103536.25012-1-gvalkov@gmail.com/T/#u

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
index 930b700b73d0..9f905ef5c2c0 100644
--- a/Documentation/devicetree/bindings/net/wireless/marvell,sd8787.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/marvell,sd8787.yaml
@@ -59,6 +59,12 @@ properties:
     description: Calibration data for sub-band 3 in the 5GHz band.
     maxItems: 502
 
+  marvell,invalid-reg-hint-in-rom:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      The regulatory hint in ROM conflicts with platform configuration.
+      It should be ignored, so the platform regulatory domain can be used.
+
   marvell,wakeup-pin:
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
-- 
2.55.0

