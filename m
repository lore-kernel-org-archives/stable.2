Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB74499F06
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 17:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787851200; cv=none; b=H5rGdPXsli1Ujm5V1CpOGR78t38zcu99Yf6hw6Q//AoFybsUKDDXvp7NRzWbZkq/5yhJthxEE4I3TqrxYKmeN4nDHAKAdfrYZIEdNXEgD9eC14qjIC0koaKRnBJZdUQ9eGRb60lT60Gq6msOMY2XgPfp6GDRUw1070sjUg2gaYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787851200; c=relaxed/simple;
	bh=Ps1FBD8oCCdztHPPWLN090lnS6KRUI6aLV+WAZWyKec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PinRCQ48M6m7jFsnGC/z5vvrh+usUkE/MWiD6j1X3bmoB23KHX1QeRJtLoxsbyS2Occ8URJP8Yj6kAVTcRkuioVy29Wv0B8JTR8nJl4GcbmZ7qE2Z11D+t91mNVbHfKvRyzrVB8yLQ3u27YRH/D8gmDgoo9YBZp93wKolyzL57U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VkDQU2r4; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VkDQU2r4"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49800c6a846so22370235e9.3
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 10:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787851195; x=1788455995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GAIY2PGMFfnt3WY5m1saKTe9r2TNIGK2InPmdbG9HB4=;
        b=VkDQU2r4GPhLwryHrlldeCIzIjSZcMpMuSHSEtMl8PoHUcRQYFuOVFZbl/3wegK1zd
         E7dJ6XHF/cQle1MaxQsP3WESsoAZn6rnPwtR5kSLi2iGTX5pyuNdddzwLJF2wtDWUOHw
         iSIWyH9mzYZ24Ch+7/5h44Kc3BrJZFy6afNCliu7lS92TiD+6eQz2wuFSvu8kYtrs4w+
         1+L/FnaeF0HjsgreQTgU39pQTasz4O4FerQ2NZqNL+UugdGzjE/8U19fEZhO2W/pkauq
         VmwQXtzbO4s6FPGTzntqlcNZ0hdeqjgMLEprOSTe+iTXckYrlKC18BL8cs5dZ4r7EQ+K
         w4Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787851195; x=1788455995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GAIY2PGMFfnt3WY5m1saKTe9r2TNIGK2InPmdbG9HB4=;
        b=C5/wheErsZaT5G0+mkpEKBDCYhM5LdKnOHCB4YTAUf0oYpzSKWDoVkgUd0X27ecYlU
         xP7Ll4DcwM2TXEI5q1RFVf5Fc0qL2GEic/q4ssXDnz+1jKPWwySR71IijfGjsEAGIwVP
         pUq5x5o69Oa5de9zLsBE/Tj0kej0nFJt6MeKifj91RdEq0/NxniDkPjmj8DkRyZVhjlJ
         0Fk9rlc4iVG5LVZXIK45GlZSnwteT59s6IF93tWEY+qyQNetZBWy6MFgC2lhZ8XJDXFP
         HBwamlql+4TX9TthOdeaIrH/l5VmYOTdh13NmBGXCjH81TCC0MI8B1g5j+I042X2u6at
         rqaQ==
X-Forwarded-Encrypted: i=1; AHgh+RrnKhYhjCuLaQDZdWr/d7zyRh3GMM2p6fIiwnbcNlJLZpXwBHbOoT1DmyI1b6xG4ZH13dk3AEg=@vger.kernel.org
X-Gm-Message-State: AFuF++keYV42plkx5EN5Bz+e9dL4hoNzD9JNtMQXYbIFKaXZ38rExvfj
	4V/F5iHNyFbcAPjxvGVL4rNLgFAztIMCDeYahX14ykP2AJlIgrLhtVgT
X-Gm-Gg: AR+sD13ffCDRUBYZLfyFPVcx0TeikvQzzqd51fCot6bUHsTFeZWkGDCxMMvgEeHtx8+
	BVLUqfoSInT4TpIOTBvydIerJU33Yibw2PjW0Dt7QlDKQvQP65WS7JXZ25NaegSmLvXzYECIu1I
	+1HdrjOOqAVmJ9+z+X5FnD9D8TbQ80iMqIO0VlcH0c2Y6j8pBtOhL/WircoQA2fzhMX/L6908Hm
	Me6/MX68i1GMkUsmQ43U6jfztPUh6+VPGbRn0SQU3lYP6n52SxF0T6LRm6qs8tjl8HpGbXo3O+7
	HiNHSbtPGLCqxvACP7TccvwhxROx39xcTsdY2AHqzTxJNSZcRYIKV3zEGXIhmRxVPbcxKjvEuPw
	qYsrIQzCEhvD6vIIg66nNe7kSxqgJqpZHudx+tdIhpaBDRoLMAatpCJVjb8H9gO/r0ovrznTheQ
	XMBCyO61pnByi6JhlxzKF16VBLcSO7BwKJRyPYjtyEhCwNHjU8EtzZ4PnrinRU2d8UUXWzIiSDg
	DOY4MFpxg3md2PYqkBgp/mpgge+XvopKndMDzfpxG3DucFfFQXEunlzWXhtLYXr
X-Received: by 2002:a05:600c:8b86:b0:499:8ff5:8ecc with SMTP id 5b1f17b1804b1-49b91c5446emr7604325e9.15.1787851194667;
        Thu, 27 Aug 2026 10:19:54 -0700 (PDT)
Received: from localhost.localdomain ([85.118.83.238])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b4ad16262sm54259995e9.11.2026.08.27.10.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 10:19:54 -0700 (PDT)
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
	gvalkov@gmail.com
Subject: [PATCH v8 2/3] wifi: mwifiex: add dt flag to avoid conflict with platform reg domain
Date: Thu, 27 Aug 2026 20:19:36 +0300
Message-ID: <20260827171937.28878-2-gvalkov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827171937.28878-1-gvalkov@gmail.com>
References: <20260827171937.28878-1-gvalkov@gmail.com>
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

The change affects only platforms which explicitly define this flag, and
helps overcome the incorrect behaviour of proprietary radio firmware.

The change has been tested on OpenWrt and fixes the issue where
phy0 does not start on WRT3200ACM-EU when a DFS channel is used

[1] https://github.com/kaloz/mwlwifi/issues/173#issuecomment-307879699
[2] https://github.com/openwrt/openwrt/issues/9956

Cc: stable@vger.kernel.org
Signed-off-by: Georgi Valkov <gvalkov@gmail.com>
---
 drivers/net/wireless/marvell/mwifiex/cfg80211.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index 7a1ba32f1fb3..293876397b67 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -4897,7 +4897,14 @@ int mwifiex_register_cfg80211(struct mwifiex_adapter *adapter)
 				country_code =
 					mwifiex_11d_code_2_region(
 						adapter->region_code);
+
+				/* If the reg hint in ROM conflicts with platform
+				 * configuration, it should be ignored, so the
+				 * platform regulatory domain can be used.
+				 */
 				if (country_code &&
+				    !device_property_read_bool(adapter->dev,
+							       "marvell,invalid-reg-hint-in-rom") &&
 				    regulatory_hint(wiphy, country_code))
 					mwifiex_dbg(priv->adapter, ERROR,
 						    "regulatory_hint() failed\n");
-- 
2.55.0

