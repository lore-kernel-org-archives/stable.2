Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B61463B7E
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 12:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786711900; cv=none; b=pUv4cbwHU3TeIMVOBM85jn0H++DjEPIr3ApLSnGST76Fkc7F4tC4AgO3vaM7Ngv36+VhAnfcjbjHbm0PMxt1xHNp1Epn9I7IOzYrDIk6MgxxqAWe5fid2Mip7H8PyrUYeOXS5rq7gqNSORLUEzHt8iv0TpbcDSvBFoLGlxHJFyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786711900; c=relaxed/simple;
	bh=+cdB3jlbfOwPvLHC7qFXAtCDuK+tf5d2RCCwL4bvx5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a038XdXndk7tPco5qOd/e9+SjBipDv3g69zdNKhyr/kDJORlYKuVrs5Hvpi4TvMNCAkiTvrm2QB0Zax/fC3HFwMkiajyvajqxG6h9ftQ5X3PH/ViT5qZwSl/f/tqzYl2Fp5Z4GntNBWkDiQnXONekWFwpLKFJHRc1i5zCGZXoBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cX2wSaV6; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cX2wSaV6"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso14744305e9.0
        for <stable@vger.kernel.org>; Fri, 14 Aug 2026 05:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786711894; x=1787316694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jxmv/7o/NfVI89rAdTVtRInPWnXbZJb6x6oPXtKGqx4=;
        b=cX2wSaV6B2IcEy3kVNw/bSheHrVxlaAoZdKynyoUz3jg0oo+lhBYKap9dh7zHuaXPC
         JwXj7nVJwDTywIm61FURM33JKNdQe9Wep5Ml8eGwe0EVE26S2n8aBtedE4PNzAfh4azs
         P6p9PhmVkrnGSqg0We+Zfhgg7fmc2B5j40wQr4l48d72JGp772reLKme3z0sUoE/kH3O
         n4ohfiGZEthQhoPVbchm6SOQ9lhcqfXrt4P6UdYYBaFaEjFhnguADFqdsM799pRTmQHX
         wccvbMxR3rn3tl6BKRtVT9p+XyWR0Mi0aAVY1/poC976ahaM63yIzah/dmNwMBrwKf5c
         yaMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786711894; x=1787316694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jxmv/7o/NfVI89rAdTVtRInPWnXbZJb6x6oPXtKGqx4=;
        b=dyWtpjXC9o8/tZnzwP3P4auRxm3zKuCDzVKdvS28MKjtgIzgoIZoZht2Tz2toOY+7W
         kH1Xl3qW5r1nEeYAnsVqM+1aa/KOxp+hfjlRK1EvTSQ3K2JF75JTja6hVz0BgEgfA4Nr
         AwiFbqn6MPbOHaKh7CYmzn9U6zpDVq4qmXvvUvExRDX6pmUkVPYKNKt1Ao0EGJTIROeQ
         bkkr1yo/wNue34WEZKp9HMBQmJo7/wQu/9a1j69pD/HmZSDo8zMu9tqi8IH3SSngl9aw
         TO6CmKcDZs/c6q19L4lskeviUpcIIGdfbbzGOfhzFw6RxKeeK1a0o+pDpamRDM9dESf0
         HC1A==
X-Forwarded-Encrypted: i=1; AHgh+Rpl2+mq81Y5/XjeikUbI/c9d03fG92+yGObQkJVWuvTFtXRDAuEP3AAWkBG0+D6MHo7GASAVrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJclaDyCH9MozgAxi+dWeYSFPUaAVSf8lU3/rZ5XryXiRyzPB3
	wj8KqsFgmAargq3dIJWDv5MuU5R3K46JTKbrvburu6kTSRRx42wbX3w2
X-Gm-Gg: AR+sD12+LkcFZTIulhC1eSDn3AniFomp0a9PNG8aQvC+ZJgZ99NgK+VW+uLhfOJlCbI
	9n+aWlLdVBRnW7wsVTjbSbDWBjqVmLXrnwmQTNvOSHr6d431rnI2Teen4s2aGEsDh02+qHPpnod
	uN2DX9SUib1xCMGwv7o/xcITo+usAt8UNRA3zj94nFY9L1H25Cn5elYzLubrPeVedrWgMu46gKc
	NN4xkTzch4yiALht5Hmu1AJ69E25/w/0O42mxSM0gvMf9QnQgo0nLTYH4wZ3R5UO98P6nybvZKD
	kfD/CvGmAjtYMw25ftldZdaeg1dnvOfiNV1MeemBPC4t5Mf3N0E55TqeGgedp+vWQlpAs/kKy3W
	G9SDiBv1wM9KszK8NsZuFtTgXCs7XfEWPA3qgxXbCLa0xehgpdQ50vvYDPOVskOmWT5YUTjOzeS
	Rsf1pVk2zPxbb1VCzbOqgL7v1SzE4ukRrDwPw4ZAOqnuG6/tib612+RoNkBCn2Q32K0E/nCH/q7
	ytvwwz2LIFAHZaK9ko4qJnkU7cCVQfwlLNF/h6LzRMAM9+QxfmHoR60dBPwV6fqWA==
X-Received: by 2002:a05:600d:117:b0:499:5f80:83ac with SMTP id 5b1f17b1804b1-49987ab4e1bmr49051825e9.7.1786711894092;
        Fri, 14 Aug 2026 05:51:34 -0700 (PDT)
Received: from localhost.localdomain ([151.251.241.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49988ae8b62sm49727315e9.5.2026.08.14.05.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 05:51:33 -0700 (PDT)
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
Subject: [PATCH 3/3] wifi: mwifiex: add dt flag to ignore incorrect ROM regulatory hint
Date: Fri, 14 Aug 2026 15:50:25 +0300
Message-ID: <20260814125025.90522-3-gvalkov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814125025.90522-1-gvalkov@gmail.com>
References: <anoYr9H4KojJv-aZ@google.com>
 <20260814125025.90522-1-gvalkov@gmail.com>
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

Tested-on: WRT3200ACM, OpenWrt
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

