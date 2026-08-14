Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E226145A28E
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 12:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786711882; cv=none; b=cwkSd2rkDk/q7W8CQ3P0AEJkq38T7QnCMMk6SV6Ry0HzL1/Uf8LTL0B6gZEA4LoY6ZeNS+/dSlrmlep76ucZ7APCM/Z4wOrQHgPbr48pPVmfkqf80SuIq0jvtFLywJ/G7wjyhgk9sWsKCEGR+x3o8JycANcMqExzqZ8tR8m5dm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786711882; c=relaxed/simple;
	bh=6nWgVQ6K1iD5+9XLXAkupXMvKGBCS3eLIaZ7Es8WIT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FMd39ZlXnM4ga5W/xx4dWA65Kvan9kLH/rRjNe3OKyM8VnueyjyWpLmetYxU1XJcePvex8SqhDPXAnjP3RjTNZhtJaXJOON1VQeL3SrUd2JYb8rkHjyrGgSH/QfmthxoraaPCDN/CFLwIe9W7vA3NV3F8VboSj/are7lVuQPeY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NcUyIm0G; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcUyIm0G"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so8425065e9.0
        for <stable@vger.kernel.org>; Fri, 14 Aug 2026 05:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786711875; x=1787316675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d7kfFCn+GNg9NumksCvYfbd5lgR/VvSMlydTU1rt7oM=;
        b=NcUyIm0GyPHgJzCrTbVC2k1UJgPukP3L1ARr2hrksAqbC9D5Yl8IPIqAh8A8OuTK0B
         t7QIMBOCD2n3qJXWpw6peT6Q/U0I6imD/By9kspLeMW8ekQPT9NsUTdi1MvXkF0wKDFl
         xBCY3xt8f+lsjsgWj2TLmmPn0Rbk2mUcUqHvjr6tw5fazcyyXiUy8EYfBaqY8LrxQgLy
         w0ZQz/LGniq+kh1dR5JA8pM+kEb180UxJGLQ/6r79i3p/v/LDJuQMKUFTvhz9pIqpnLF
         hMFJNGIcjJIWLelMbY2NsZbW7XbjDQt/vdp1kolXo28nqNc+Rche1xpe8wLTSJpjUtGp
         lI3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786711875; x=1787316675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=d7kfFCn+GNg9NumksCvYfbd5lgR/VvSMlydTU1rt7oM=;
        b=i7aX1xdKLcYq6yrimIJpZpNwCLjgfX04Zvs+NgxmWTg28f8Ji8Up0hQhGnMKOd9B+L
         vFiiL1lpOkrSmdPGXC0VS4KVrWkWJdkadVU0wbHzgEqF2ntYgI1Ql4Znl/6jFmuVrlez
         YE1ZzDl89A0u+mAyTjUnE1TfbxM+/+xhR3IWuNbGuOunuSpIhZfT0lcNKAByr+M+cxh8
         kiCcBuI/ymkh+mlh+N7SZ3JGymC+hMLyb/gcvEtwTIZtnCQpvhS3HFdYxlXPkzp5wwN+
         ZIShDS0nb9KLHc8hpvfR5u/1scfAuigjogJeemUu5CrK43RccrgAtusz/nGyB8evyKmT
         NOlw==
X-Forwarded-Encrypted: i=1; AHgh+RpnllgOLC0Xm/euiot59grTf8wN2bMMdZZdd8ACuQcjjgq7IaAGaJCYDAydBkeW9d8+KH77pcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfTU6JCgaY2zysc1Tg+ke/19faEeQ+fC34lslccErCEsOLr0CX
	8ZfpNNZze7ese1GEKO0hs9+6cEYOOgzNF+FmqQHGud6QJ0EgC266KVG3
X-Gm-Gg: AR+sD12II+fpxgZMVOKGsoMqXGK6IlywqSEOoV2HF31EFmdL7roiRCY+dRY4Ojaf4d8
	av+AjzRlCqCc0rjyVQqkUG0EGysuOjfQRMzCI3sM+rfmkAuo2nnw2Jaw/Xr+ATC1TQuJVxg451v
	VODEWyzM8TUMvJz7YpJAhEbG6vhUA2ezBb/BSLOugD4wKermi+7Aw+wR9nnmdOobW6MG0DG+RvJ
	AFOx3tzGE3dflcqaXMVfFKhiriiN/uBSDFU10E2Nsen2WfHGwFU56gsLt5CmYee8XhEGK0KlIRk
	shMzZkPRMsBhYZCpxRwAjaYfTtvw1CDtejXG4ZVGMXHgMtvdei99KEKRuA9FijkpfZgqx4HA3KE
	f70ofIa260nOyz1wKiAF1xKUylAr0Mimv41rUsOz4bamFuwA0A9ed2Uz03EljW786jR7BNrvd0I
	yB5c9f8z7kB1/YF3uVeVSg3Hz8nwLtP8c2Kjytd6l/yhyFMudtql3EUIQWva8Jnu+mEo3pm+/Mw
	/7HaV1Fyu5/3+GvX6eTi/S81lJgr1R/7bv2ScPK83VHGwx1KfcBZgB+76vRHJCKbQ==
X-Received: by 2002:a05:600c:6986:b0:499:79ba:ed92 with SMTP id 5b1f17b1804b1-49988c5efe7mr59441285e9.13.1786711875179;
        Fri, 14 Aug 2026 05:51:15 -0700 (PDT)
Received: from localhost.localdomain ([151.251.241.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49988ae8b62sm49727315e9.5.2026.08.14.05.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 05:51:14 -0700 (PDT)
From: Georgi Valkov <gvalkov@gmail.com>
To: briannorris@chromium.org,
	johannes@sipsolutions.net,
	andrew@lunn.ch
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
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Frank.Li@nxp.com,
	chunfan.chen@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	stable@vger.kernel.org,
	gvalkov@gmail.com
Subject: [PATCH 1/3] dt-bindings: net: wireless: add flag marvell,ignore-regulatory-hint
Date: Fri, 14 Aug 2026 15:50:23 +0300
Message-ID: <20260814125025.90522-1-gvalkov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <anoYr9H4KojJv-aZ@google.com>
References: <anoYr9H4KojJv-aZ@google.com>
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

Tested-on: WRT3200ACM, OpenWrt
Cc: stable@vger.kernel.org
Signed-off-by: Georgi Valkov <gvalkov@gmail.com>
---
Thank you Brian and Johannes!

> Just because you found it difficult doesn't mean we should accept the
> wrong approach.

I agree. Guidance and careful inspection helps reach a good solution.

> IIUC, you're using a PCIe-based WiFi card, and that's enabled in
> arch/arm/boot/dts/marvell/armada-385-linksys.dtsi:
>
> &pcie1 {
>         /* Marvell 88W8864, 5GHz-only */
>         status = "okay";
> };
>
> &pcie2 {
>         /* Marvell 88W8864, 2GHz-only */
>         status = "okay";
> };

No, you are referring to the main radios, which are not part of these
patch series. Would you allow me to also add the flag to them? Their
driver is not part of Linux so only dt bindings need to be added.

The changes here target the third radio:
- phy2: Marvell 88W8887 802.11ac/b/g/n 2.4 / 5 GHz, region US
- compatible = marvell,sd8897 works

I cannot confirm if any other devices from the family need the fix
or not, so I intentionally target the board dts, and not the include:
armada-385-linksys.dtsi

> Side question: did you consider Jeff's suggestion from v2, to try the
> 'reg_alpha2' module param? It might already do what you need, and it
> only requires you configure your OpenWrt builds properly, I think.

A universal solution is better than targeting OpenWrt only.
And unfortunately I have no idea how to implement this.

> I'm not sure what you're saying here

In v3 I wanted to reuse a flag for both drivers. Using a root flag was
objected, so in v4 I added a flag for mwifiex, and I would like to add
the same flag to mwlwifi later.

- driver
dev_name(adapter->dev) = mmc0:0001:1
dev_fwnode(adapter->dev) = wifi@1
marvell,ignore-regulatory-hint = 1

- procfs
/proc/device-tree/soc/internal-regs/sdhci@d8000/wifi@1
compatible = marvell,sd8897
marvell,ignore-regulatory-hint
name = wifi
reg

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

