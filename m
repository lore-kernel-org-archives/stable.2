Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795026305;
	b=XrX4kxvdZz2E3yeg4j9Mnx9hc04YesTNx11fwYSV5K+IVkbfeWqOW3boTQEXwewYaTuo
	 DO56yn08wXRe4Vmrzi1JijjqWhnp/9ZHlrxGtGCGHkESbrAo8LdlesFKrUomK8Nng6Hyt
	 +tTKNgyIQmYEKT1TTYmZ1pd+IWHDt50pYSgOEll2HM1y2q4vTsP+rab7OvYS6Xe6nZbwa
	 biyddJMOJS/9RQfnzMr93cGIxvBNu0oLm6z1OKGO75HScjDeKcZ9bcWHMX2k/T6ZAUv7Q
	 uoFRymbH+NA6J54coB080FqfbaHEA/dfyuxG+WwohLhQpdsHnP5b5H84kwWASBm13lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795026305;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aPm8bMtN0XCic6a8OKv6xXRC+l+0XGJs8lRtJHx2mLw=;
	b=vU4CXY16Dwu2DnykRHEo10JfLOX2y6Na94nZAri1pHNJCNeFtcLIbE5pRhPtCjcLTOsb
	 Qhz+AQebbFdWdJYGvyKvfUeqq2RJQQJGUsmK5VFk+Roi3CE6WAYbp4x4GTUbvLuTOIq21
	 jhguN/1sZNlkD45WaiJ0flFpFKtu0vSkBQ+zGGeSmgeNxHhtCqtxSMLJS8TWo8ItcBNXx
	 eAV7wOVV57G3SAjGXYDJ/ObHhxUXYQ1O+ye1e3V97WPVu9hbdWcFk25RZmCaudn2n+gxb
	 qi+bkJ+a3s79EfnTGMcQUG3YIu7YSYgOBA3ne5iSLtOkuJbZV7m2mcOeURpNMaobYwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aDukXne6;
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D957606A32A
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 18:25:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D957606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aDukXne6
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8b5a6f2f27fso692190b3a.3
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 10:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795026304; x=1795631104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aPm8bMtN0XCic6a8OKv6xXRC+l+0XGJs8lRtJHx2mLw=;
        b=aDukXne6qZLB4OGhduaO1ZScJ6sh787QT/POYB0Kof2Bza+lT4qRtqvmYVraMMR82f
         2ullkMEbpOLOz4Ut2lnHlnuFATEz3nLbHMsG7enezp0W/zkZANczH+MT5CArnBUBCZ0J
         gHA6SXt3R81BrFARYotuK8H7q40DRrajh/ILSQB5IwVhOl4lqFt5y3lukw2i0AXM5fgz
         mVXGSFOQ9sxcSy3d2sIovYHGx2BvyXKIC1YUZ2iLIG1UweT21F2f+72VI9cu0yig8WO5
         WSiE6SoKBgcYBWY9EoNclQz+Fp6pTHbsJPn5fVWjQjglPoxx01PtK0V58rKf+FGPh76+
         LO6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795026304; x=1795631104;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aPm8bMtN0XCic6a8OKv6xXRC+l+0XGJs8lRtJHx2mLw=;
        b=PE6tTYIWJvdHKeQUtnQWHmK9MfsA+EXy8gkkAviUPAVOdZaW1mKUWSDoDD2pTVObPA
         hoHIbkwSqFgfWvdNKtOnzQ612zYyctKAMn6Mw9u5Ia20BEiXuKVs5kO9w3M0bDwCcwAY
         0SMvwyHO8rTjV8oY367zpIisc/jlFKKrUJhVJ5Ipow4DuIxRyhS6UQUvVwo1Hjg+tiVF
         2nQTldx/NC8ffqNm/3WNC5W5wttaNOlszwSyCazMjbxJQ4NWxrGoDrFrTEqtT9nwyXpN
         g6ENK/xmnVfVZW1N+I/QPNRXlWIY7aIciiV5TT/3ZEmwEEzHau9eD0pCdNmvvPY9mCuf
         lDFA==
X-Forwarded-Encrypted: i=1; AL+hErFqpAZHGkZuvmCP5js0m43Wy/tZfrKWyooHdt5Jla+X5RoBl6BoEpx1zmzHNVcmigFN98oaES0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9GYKP1lY0/aS15St4zoFEPmzekfc34CFRe4/bONFLyQ/Nbb1Qs
	U0za19ogm/jUZxgEnBO79ZKGeWxmuyAsYxTKVJidKo69KmjjWn38KPO3
X-Gm-Gg: AYBFou1qj03BOMrTa2q/NbGbv5ra2PrYgq2MyIYgFUA02VGVTaKe3Mvipg3KnCDYaXs
	lIg92+K7N1ULp2Uc6YmEOKD707+0IeFuNNCIUhyGquH4ViBKWlG0jdrj+YKru9GGlJSgljhK6t2
	85xwQzSKw+bgoJ86LJZbGhCYkVLnWMsZl3ptCksbhgPNHgX+2CdE/XAOqRJxHuQBWWIx8s05ul1
	6NCSQBz1osz9mZbBSkdtG1jfaobXHVVYXdk3HmEllZ9Aivm5uQVabH1YrJXUYRnw/C8vyK/oNNj
	M73HVpbXu734gY+zcihkcBpaZHCT9s3XtJ0Vst0w4I7N4GX03KwihVFgsfaUuJcMjVvE7annhl1
	Zt+3S4bEo8KQsdd7nsVav/z+0a+OZLZg23CKEGVpPLZz7Ws2N5/lywCE0p25oNvDmNeYBiPfleL
	ZSjdBFQll0UWaZosJ5ms//IEDVBWtkhagxrbWmz7A5LSCGTdZEZPe/5qbjpYWT99zJB2W3RhxHF
	K1GsG7bz75kTsU6c80kmD8W3ib2gtuuvOIGf0/F5clUcAfSWFgGz+l+750KQsS4u3dwsTvRwT4z
	Mmtp+Zce1IyHZNvTwJBJIQTxO662FxHqV99BF7L3I1627ZpcyuzOJ1plVM0mcOGAbcFLcxBmw9V
	1rbK8
X-Received: by 2002:a05:6a00:230c:b0:8ba:f51a:1bc1 with SMTP id d2e1a72fcca58-8c5d3639dadmr3086650b3a.24.1795026303092;
        Wed, 18 Nov 2026 10:25:03 -0800 (PST)
Received: from G7XWH7K1F3 ([2408:8256:2e80:7371:2c16:ada8:2d24:d03])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c5cac8ffe6sm1669954b3a.23.2026.11.18.10.24.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Nov 2026 10:25:02 -0800 (PST)
From: Zhao Li <enderaoelyther@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Eric Woudstra <ericwouds@gmail.com>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	"Lucien . Jheng" <lucienzx159@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Zhao Li <enderaoelyther@gmail.com>
Subject: [PATCH net] net: phy: air_en8811h: check PBUS register read errors
Date: Thu, 19 Nov 2026 02:24:36 +0800
Message-ID: <20261118182436.32455-1-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

an8811hb_check_crc() ignores the return value of its PBUS reads. When
the status read fails, the loop tests a stale or uninitialized
pbus_value and can stop waiting before the check has finished. When the
result read fails, the PASS or FAIL message tests the status value.

en8811h_print_fw_version() also ignores a failed read, which leaves
priv->firmware_version at 0 on the first firmware load.
en8811h_read_status() then handles it as firmware older than 24011202
and guesses the link partner's 2.5GBASE-T ability from the link speed.

Return the error from each of these reads. A failed version read now
fails the firmware load or the probe, as the other PBUS errors there
do.

Found by an AI code review agent; not triggered. Compile-tested with W=1.

Fixes: 71e79430117d ("net: phy: air_en8811h: Add the Airoha EN8811H PHY driver")
Fixes: 5afda1d734ed ("net: phy: air_en8811h: add Airoha AN8811HB support")
Cc: stable@vger.kernel.org # needs adjustments for <= 7.1
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
No new W=1, sparse or smatch warnings.

 drivers/net/phy/air_en8811h.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
index 81aa9df08dee..da9a5deccdac 100644
--- a/drivers/net/phy/air_en8811h.c
+++ b/drivers/net/phy/air_en8811h.c
@@ -378,18 +378,25 @@ static int an8811hb_check_crc(struct phy_device *phydev, u32 set1,
 					  AN8811HB_CRC_RD_EN);
 	if (ret < 0)
 		return ret;
-	air_phy_buckpbus_reg_read(phydev, set1, &pbus_value);
+	ret = air_phy_buckpbus_reg_read(phydev, set1, &pbus_value);
+	if (ret < 0)
+		return ret;
 
 	do {
 		msleep(300);
-		air_phy_buckpbus_reg_read(phydev, mon2, &pbus_value);
+		ret = air_phy_buckpbus_reg_read(phydev, mon2, &pbus_value);
+		if (ret < 0)
+			return ret;
 
 		/* We do not know what errors this check is supposed
 		 * catch or what to do about a failure. So print the
 		 * result and continue like the vendor driver does.
 		 */
 		if (pbus_value & AN8811HB_CRC_ST) {
-			air_phy_buckpbus_reg_read(phydev, mon3, &pbus_value);
+			ret = air_phy_buckpbus_reg_read(phydev, mon3,
+							&pbus_value);
+			if (ret < 0)
+				return ret;
 			phydev_dbg(phydev, "CRC Check %s!\n",
 				   pbus_value & AN8811HB_CRC_CHECK_PASS ?
 					"PASS" : "FAIL");
@@ -403,14 +410,20 @@ static int an8811hb_check_crc(struct phy_device *phydev, u32 set1,
 	return -ENODEV;
 }
 
-static void en8811h_print_fw_version(struct phy_device *phydev)
+static int en8811h_print_fw_version(struct phy_device *phydev)
 {
 	struct en8811h_priv *priv = phydev->priv;
+	int ret;
+
+	ret = air_phy_buckpbus_reg_read(phydev, EN8811H_FW_VERSION,
+					&priv->firmware_version);
+	if (ret < 0)
+		return ret;
 
-	air_phy_buckpbus_reg_read(phydev, EN8811H_FW_VERSION,
-				  &priv->firmware_version);
 	phydev_info(phydev, "MD32 firmware version: %08x\n",
 		    priv->firmware_version);
+
+	return 0;
 }
 
 static int an8811hb_load_file(struct phy_device *phydev, const char *name,
@@ -560,7 +573,7 @@ static int en8811h_load_firmware(struct phy_device *phydev)
 	if (ret < 0)
 		goto en8811h_load_firmware_out;
 
-	en8811h_print_fw_version(phydev);
+	ret = en8811h_print_fw_version(phydev);
 
 en8811h_load_firmware_out:
 	release_firmware(fw2);
@@ -1164,7 +1177,9 @@ static int an8811hb_probe(struct phy_device *phydev)
 		goto err_dev_create;
 	}
 
-	en8811h_print_fw_version(phydev);
+	ret = en8811h_print_fw_version(phydev);
+	if (ret < 0)
+		goto err_dev_create;
 
 	/* mcu has just restarted after firmware load */
 	priv->mcu_needs_restart = false;

base-commit: 2a324a58a084c5cfd7e5a2f55e0786bee170a4a5
-- 
2.56.1

