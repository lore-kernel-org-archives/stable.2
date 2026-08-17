Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC213D9DC0
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 21:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787003731; cv=none; b=sUodSAgYlyB1eJQhCfW45yiA9VEBr0+dVoZLKD+1uRWIJN/HQO9izk86Npx3QRnKKguQX0s7TzaOGXxmnixNaIVEWbjcoXglKh0VM10QT6lszmMDFgM3id5IIe7pTIwFngqbJWuea2cEOsonL3rbdnYNgP9UPanqkU9qZdrhARc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787003731; c=relaxed/simple;
	bh=TJY3hex+l5/Tl/ivjiuYNGr3PPDEzX3hWulbnq7k2rs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QpBbG4nJw/ElpLx+3o+BYqQHxc44tBmceTnfwhQA3aPbsaLBbxAIBuQMrPKxI8aNCtLymA5nyaNNuGdhIo0kN5Ft1qSI6wqvjjvIm4FLEfFxT1ACDYWpG+ieuifjmYLFop51Pf1FIpxg+jxd8St6+68INbA8pCHwK2GEUlSfEt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ieU7D1gJ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ieU7D1gJ"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493b966dd74so26233435e9.3
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 14:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787003724; x=1787608524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aDO6GjJPOwWJ3cCExfgafVeJUpNRoE4Oa0/Ds8leCk8=;
        b=ieU7D1gJHgWghdtS1WlsXGjaAOqxQ5SQ2/hN+drKbAQtYkxtV66KiOgghg8ALCAyDU
         TVghmz4mpuA0qRktYeRjHsaoMG3bxd83ixQI0AF9FaCrkltuTIvGXqfBaJka4ouFWZGE
         f1DDptgZHEvkFdTjKFDhQkRAZXrNnyxqW0DCiwJ/B/sS/DVJBYKHBbGOFGDnJLx9R5Yf
         iaf+OJAD2oD4U08PBBP+hBrv4SxwIId1sKnuwsjYM6zHNxT/CgvowSPXlX7q7Yim/mct
         ofKe2P75b2lHOI82F7SRifwhILmiTQiuNUok4y07HTdh3XHPf1FDGpeois31hBe7bkCE
         zd0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787003724; x=1787608524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aDO6GjJPOwWJ3cCExfgafVeJUpNRoE4Oa0/Ds8leCk8=;
        b=aGe1ZRhG2HOUlXNohjbt9BJG2pPJnhU9qpMc0xXPKtmNY8Vqt8TJXO2InzgEUWTDJU
         5nmtuQ94LG++bUpKFltQalPRRr9fGU1ZKOO0foIrxK6m38ElGNMvzuHu9LoS6m42E7QA
         M3jLfliti7I78hqPpbDjBkQfrwiExFdEXVFrdbrkDRp0vv4qkxoFeLa4Y9q+rJcdmMzu
         JEMQvE+N3S8g7tGEdTE4eQksOXV+nTzRDnzdsaH1UqCRwS4xgjf/DSt+gsBlRbqg5kp9
         OYOWTSIddv2CX93Nb0ru0hCFusVlVuTyeAaMc2AYId3Ax7C875KWQERgGpUtz2xixZ9X
         YOvw==
X-Forwarded-Encrypted: i=1; AHgh+Ro6xeG6/bCX0zU88hkc++NYNIvKdfapta3aHqRdeAoWZolE12Bi6avUrpuzHgV3z25M8sZg0r8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwvup0yWUiBFgHt7fx/kmlz9uduS9BiKhAKZtMSmhcRsSkhbEn
	9QG/IG8fOqM8BPbk+PWP+/v2nkJgzoaK0vIrvv5r9QYsZEu4IELy9K4f
X-Gm-Gg: AR+sD11T9c99IdMg+mHFgUdreNwRPlYPT2tClJ5yy3d9vfgQTKQfg8Pg/Z2z2Swlhy9
	Vk/fY+iXK96nlYT4CgYTyTW0FsqzOOKeuLKxa7Niq0y+/dmKkL/3hFM/9yJeiqN89cp3eUlregy
	1vLGgGr77I18bXIrLsveN4SwOTJ7T2AUoFINhyhTQd9cj32lcfe2vrOgE9jdyDT6tlPuOuQ0YAb
	/gieNrLZTZ6aegc51QZPTCNL3EL43GlDN3k0j/gcHRI21YtGC5OIhfQWr86uESpiHhrbHcmC/u1
	4nvreiZO2IQf+zMaJ3Lf7i53lDVmJmH4ucIPT206Ef9KS8ItytQJP81yJfwZqX02JeKY5Vu1S62
	17OvArFhaLx3Amq/En968Ag61Gw6juFumRiv4lLhfwz0AQnpO+p5xFJAYHYkg+Kf6jCjYIm/UJR
	higJmDXfsZRvv6BHOfawgp0CuXZdnBTENnMJ9LB2dWf7HX2LTVap11lEAHCqgnqlo2deee1FUGh
	/pvulN3lv4jTNU4xlrkDGOLqlMGRSfRJ3tDmvOqbkkHZoehUXofmNOaA+cLmEbrVl7TAhH0QQH+
	qk6sKlFUtQ==
X-Received: by 2002:a05:600c:3485:b0:499:8758:8cb4 with SMTP id 5b1f17b1804b1-49987935eecmr451205815e9.5.1787003723726;
        Mon, 17 Aug 2026 14:55:23 -0700 (PDT)
Received: from localhost.localdomain (85-118-76-205.mtel.net. [85.118.76.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49987b2a176sm309622525e9.4.2026.08.17.14.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 14:55:23 -0700 (PDT)
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
Subject: [PATCH v5 3/3] wifi: mwifiex: add dt flag to ignore incorrect ROM regulatory hint
Date: Tue, 18 Aug 2026 00:54:28 +0300
Message-ID: <20260817215428.84740-3-gvalkov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260817215428.84740-1-gvalkov@gmail.com>
References: <CADOrJmbTyrGGkq+9OJDXCgTa2HvNo8BWxoE6yjafcrOq7WNamw@mail.gmail.com>
 <20260817215428.84740-1-gvalkov@gmail.com>
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

Implement a device-tree flag, which allows affected platforms to ignore
an incorrect regulatory hint from ROM, so userspace can set the correct
platform regulatory domain. This avoids the region conflict and allows
the 5 GHz radios to be used.

The change affects only platforms which explicitly define this flag, and
helps overcome the incorrect behaviour of proprietary radio firmware.

[1] https://github.com/kaloz/mwlwifi/issues/173#issuecomment-307879699
[2] https://github.com/openwrt/openwrt/issues/9956

Tested-on WRT3200ACM, OpenWrt
iw reg get: no longer reports region for phy2

Cc: stable@vger.kernel.org
Signed-off-by: Georgi Valkov <gvalkov@gmail.com>
---
 drivers/net/wireless/marvell/mwifiex/cfg80211.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index abc703441c5d..26978158a0ad 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -4899,7 +4899,14 @@ int mwifiex_register_cfg80211(struct mwifiex_adapter *adapter)
 				country_code =
 					mwifiex_11d_code_2_region(
 						adapter->region_code);
+
+				/* Allow platforms to ignore an incorrect
+				 * regulatory hint from ROM, so userspace
+				 * can set the correct regulatory domain.
+				 */
 				if (country_code &&
+				    !device_property_read_bool(adapter->dev,
+							       "marvell,ignore-regulatory-hint") &&
 				    regulatory_hint(wiphy, country_code))
 					mwifiex_dbg(priv->adapter, ERROR,
 						    "regulatory_hint() failed\n");
-- 
2.55.0

