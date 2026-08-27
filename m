Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B514963DB
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 17:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787851195; cv=none; b=NE76Fj1T/EHnqo0kFpUPcdevt4VXffHmKAg6TLILsrWFTjJ5zNkB7rpjMV4/BO0lxEkwwa0mS+FkUVL8ieoVMZ6/+pBzl/gkAlUMkQufIxW4IbCnAL6H9N/+gwidyiOAHm0LT2y9dRk/qnPBK10q3YvugiifVAZwB+Cjdzzsd/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787851195; c=relaxed/simple;
	bh=vQQ1JnsJulU0igW0FVrOEjyJXmT5ZAzjD0E0C16Fd6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aHKxrzptuYid+otnayKstOg4ErAyxBPfRiJYm0UZSX4gZLoujatIxn36k/TK2pcXwFv5plUa/8VGA2U3X+I6z2r8jT0Bz4nVfNeYFKBBh1bWGpbyrXxXGiA93/WUWSzk7BVbzeV65izCGN/eoDepdBTUBNzITG3okywMEIzazwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rc5P9d4w; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rc5P9d4w"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4953de5be0aso11475e9.0
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 10:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787851191; x=1788455991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3toHgNm1X+G4rSZPEb0QgIDLq/CBLmilUIyHXoikIUk=;
        b=Rc5P9d4w1goaCsSA4seFhk/EHmyAbKR/+t1XDQr8cYSX0EezH0/jiS5SlT9wawGjab
         JjidL6vl2liM7vB6Ec1emHroqNm+7z4M/RupTC1tb7T0vQ1laBo2uQckz5FAMTOd7hmJ
         FHT/P0FQ9C0XzOS5yF1/IBmdRPnTGlNy1EfRJMkwJwz765zoop9pTl43PLJykp1SBCFN
         dknhxtkoa7LZafCraELRyfVONGFD20iFBmblH+UMAn4TTB8c/tDSXQcU0T82AacPsQVx
         7kLCAwYCRRyN0NbbCtlx4f64ifuLvtgnjrqE8qzGdImqTOoWUZTHC/PORWQcHp6XLx+h
         Qyfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787851191; x=1788455991;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3toHgNm1X+G4rSZPEb0QgIDLq/CBLmilUIyHXoikIUk=;
        b=MyrH5EpsXnjYd99q2HNirhRFkQC8sIp9n95Qbqnf46keLCZgr0ZBOM7RJKhYPgx9W5
         UFcvqpVX4aDwhGy927BSPlFy2aLH5EwZnA4TNMglS38lOqixcDigIWnE2lVohoL4VEyv
         0QS9RJ0qmGo+ka4ruDp1AFP/dsnTnwGnU9GNirfxyHyX0Nm1Fm53kQJV3UzZIJ8m4Ca0
         36ROPvTl7cxxhtKcPyIpLApK24KGiJuwrWt5wU7CXm+ZDsH1b8HtAfSsQENMetzfSkjH
         jOACejRri2b9IPAOG9Cfin4KVt6my/ulj1wXLXna+0Bv2LT2hJQHTtNoqKF2kzKGh+74
         HSWg==
X-Forwarded-Encrypted: i=1; AHgh+Rr8bvX2VKAfe5yYM3Fvol9ZGChZso5CWzkHm2R69WIGDlGYCBES8f7YFKCxfTXqDozauROA6+M=@vger.kernel.org
X-Gm-Message-State: AFuF++mldlSybA7i/z8S6TAdjLC7XvfnvbYcSUs/cZpUcLfcjsL03svT
	eL+EWSkDWLOV1y6qTpg8Bj6iUp+gVxJqsRx9xuiABZfSmi1dbM7J74Rt
X-Gm-Gg: AR+sD117Etgx5CJPYd8+5fWaahg3OqasDRAdMCtXwOxlY0aaAcFvDhAELGtQJDvT5E8
	3QWiUGh0OAGY4imvQhQupR52bj6Jh8CUMBWA1WjjHP5Ep3m2qHH/BFU1nIqTsMZg0bFUk1woVeW
	KIIHl1pGCSaeLyUMXQ1Akxe7L12xeFWlevnQJBuIZIH5Jr5RkCp/Uk6IRFb7SECBSj8QX2i+6LH
	gjqmcLej62j6Vc7cZo5cjJwm1r6cUSRt403vwW0u2zqRJkIJg7HokkVm/ryIIdBTT16EE8Dn3q5
	xlLbwlQ/xB0ATifLpaosP0ou4mLVYl2jbJZ9wTzM7PMDrGDD1vOwVQbGj0gsYtAU9GkiESyg28N
	8cYqJkECqIirrlIhSJwgii+9Xeui2zAdTUHdWPQOkcPPLApwBlaO3u4KNaBsl1XI8XdjM8rNZHK
	zBlnpQT37cDLQOoPMgjDelqqNd5DNkeQEitBrm1py+gIi1++iRErSVw9cxtxr7LO46bOmoPgU5m
	UYMGEkIZozOSAOAfWhLuIAQtJB38RaDYbTgTTZ9mmPXnrV6g3PakLkW92ztVRsk
X-Received: by 2002:a05:600c:1d15:b0:499:d366:f572 with SMTP id 5b1f17b1804b1-49b91c4338cmr5523315e9.10.1787851190868;
        Thu, 27 Aug 2026 10:19:50 -0700 (PDT)
Received: from localhost.localdomain ([85.118.83.238])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b4ad16262sm54259995e9.11.2026.08.27.10.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 10:19:50 -0700 (PDT)
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
Subject: [PATCH v8 1/3] dt-bindings: net: wireless: add flag marvell,invalid-reg-hint-in-rom
Date: Thu, 27 Aug 2026 20:19:35 +0300
Message-ID: <20260827171937.28878-1-gvalkov@gmail.com>
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
v8:
1. no change
2. drop invalid tag Tested-on, replace it with description of the fix
3. no change

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

