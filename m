Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E20331EB2
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 03:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787887779; cv=none; b=sKMble6lF1RlyTaBBje5XR0Z4GO2t4US38hor2P9fCriFtn8m54x0c8c98Y0JmR93I8a3vA7Dp9Aawd2OS8ZrKVcRLGhqf5wJNqJXo28LD9wzgADaxSM4p5gCVgAezmiSgOZHYpnriV02PwLHA9X/iRCk/as6Ih+zBFyIK61jF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787887779; c=relaxed/simple;
	bh=jPjlin0tmMCDRTUW+snF3PCNw9aRjkrQLg8rejx6Ly4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bJjfZJfspEeWhFzC0JjJG9yYwQNGRtBRzfN0azPwBgtas52mUWpewPHSzp1wuCbzaqoNA0ltnN9EthlC6HV6131hMMrnXz/TUl30moxzgnX/YhAPQuywQDv+Ogudtd9nm6WZvp+U0nXfeYVimshke/OQLRPezhimQOIleC+JEgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQZGM383; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQZGM383"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84fa3b14ee1so610779b3a.0
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 20:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787887777; x=1788492577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Nm+oSzw2CJimOwrmR4fmonPKPbwcboKbls/SrfJtGuk=;
        b=ZQZGM383K2s1zkYeHdJcoSVFaHA33CHT89DmYEYIU/ylCJmPbAibUdK2EHIWXFeiZx
         /Vxd+Fwop1tgVMKhpcu8b4SYswRqcH+CcaMsS75+BF1ft6hist5CHui2eF/HrSjmeRFY
         9fDvRwiht1K1b6VRVBskyFS1IYBwzKMdHsKnctvQN78nIY6yBMB9rxUmQO8uyy99e0kL
         8NnmthT4C/vDWRNPc4w4jPy245ICoqprQHkj3dq7Quev+rf2g62ZsySiK4O+1ilwKr1A
         /59neHNjS3Gn8uqdahUPhODiFG9kg0Ryv/n97JsvQaNIhkNJ2G3UGOnfUwPPNgeOmTPl
         cIUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787887777; x=1788492577;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nm+oSzw2CJimOwrmR4fmonPKPbwcboKbls/SrfJtGuk=;
        b=IId+wS7k4KO8FkyGEgZhxdWbB9I1YX9mlyALFgD15DAnXurHwgCKRe5dPWZ0xlLw3Z
         XiTQBuSKA+kXTZkFN3VrfkH+oVegBOTNrwkvVgSD+v3XxrnleEYUqGf9VdNg4wPf9wV4
         Xj7Hq/+4K6fDk1fVj/OMOMnQoREdJqYT0bSoSNSLrOjJO+1mO+e27TAiZO7pof8pOG+t
         U0JuqqcU2UUmDWW5LIBd813W8Tv8vEDWA8mNBBfazP+sIv1FbaLXpxfG8AVsVDAArtMJ
         BPpITrLpFSiIyRJMSo6dRPFTcTHLwz5XLlQl9cmYcUNi3nklex38/CJ7LYsvpz7TAtNW
         CO9A==
X-Forwarded-Encrypted: i=1; AHgh+RpsjmhESwgbJm5PJlSqMPLsE11vrmqkkFxRdXXaj3ZoFt48q8j3szrXMcoVQfTCqxc64e756Zo=@vger.kernel.org
X-Gm-Message-State: AFuF++nv9V3i1x+Ovgz+j9ogkk/9xZ75OqvGNXbJC0FV1cIWQketHQel
	abxmv5lfGp3xftQ4CC8bCr+asx0oKu9I/eMU0Hopm4fTmhPRlfGgyDsJno2HOfqe/R+mTKI0
X-Gm-Gg: AR+sD13Ro8rLQO8EvlCeoZs0dGJODsVpEG6IwLoPD6U3JyAKvDzCiasow6ocHyGLQ8E
	xZvn9yg0x3aJdrDXdWG2sd/YYmweqJEpz4f3e2uCN0l9Yb9rM+X4Nc4x22HarRkfghIuqfUzW0l
	dAnPiia06Yv2Qr1CzeM/33b2PuvbhWkO2NmviMTAK+kTjffD0sRe9prfvF/EryK4DjnCs8bhWGR
	a5lS7LO7irCaJaU5cQfz4MFqNENDLwexGXmNftdX4eDJFhdezMNhYzhHkCd2dxuwl7mb/Ck8MLL
	6535CLMLSFegnR2KvBZQhaGg6LJfChnetLcqPqTyeIsRPihlmoiQFZ36WTFihc8YkWM+VNXtDWw
	jt0iiUlmBBAAT77MMZbv4XV3uJ1NepqNrnuZmvaZVFnnmUM4bvkMqdv/97P8vWFo/pRDgDOw/wP
	7NzJai1NSMzDbj3TO/9xp4ZOylQWdmHWtiXLsia1/0OT6UoA6vRSncuvCeattxosoJ
X-Received: by 2002:a05:6a00:13a0:b0:855:a211:6679 with SMTP id d2e1a72fcca58-85628b7d138mr6941183b3a.5.1787887776957;
        Thu, 27 Aug 2026 20:29:36 -0700 (PDT)
Received: from DESKTOPHOME.lan ([240e:3a3:9304:9820:f4a6:931b:cf31:308])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-856a3d6c845sm135770b3a.59.2026.08.27.20.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 20:29:36 -0700 (PDT)
From: Ziyou Xu <xuziyougm@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@mork.no,
	ericwouds@gmail.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2] net: phy: air_en8811h: restore AN8811HB LED GPIO after MCU restart
Date: Fri, 28 Aug 2026 11:29:22 +0800
Message-ID: <20260828032922.469449-1-xuziyougm@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 03b4702fc5e3 ("net: phy: air_en8811h: move LED GPIO
configuration to config_init") moved the EN8811H LED GPIO setup from
probe to config_init because an MD32 restart clears the output-enable
bits.

AN8811HB follows the same initialization sequence: an8811hb_probe()
enables GPIO3/4/5, and later config_init() calls restart MD32.

Move the AN8811HB GPIO setup to the end of an8811hb_config_init(),
matching the current EN8811H path.

Fixes: 5afda1d734ed ("net: phy: air_en8811h: add Airoha AN8811HB support")
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Ziyou Xu <xuziyougm@gmail.com>
---
Changes in v2:
- Drop the EN8811H change, merged independently as commit 03b4702fc5e3
  ("net: phy: air_en8811h: move LED GPIO configuration to config_init").
- Apply the same fix to AN8811HB per Jakub's review.
- Rebase onto netdev/main.

Not tested on AN8811HB hardware.

v1: https://lore.kernel.org/netdev/20260820141034.1400439-1-xuziyougm@gmail.com/

---
 drivers/net/phy/air_en8811h.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
index 0eeb7b9a4..6ee5df63c 100644
--- a/drivers/net/phy/air_en8811h.c
+++ b/drivers/net/phy/air_en8811h.c
@@ -1125,13 +1125,6 @@ static int an8811hb_probe(struct phy_device *phydev)
 	if (ret)
 		goto err_dev_create;
 
-	/* Configure led gpio pins as output */
-	ret = air_phy_buckpbus_reg_modify(phydev, AN8811HB_GPIO_OUTPUT,
-					  AN8811HB_GPIO_OUTPUT_345,
-					  AN8811HB_GPIO_OUTPUT_345);
-	if (ret < 0)
-		goto err_dev_create;
-
 	return 0;
 
 err_dev_create:
@@ -1265,10 +1258,19 @@ static int an8811hb_config_init(struct phy_device *phydev)
 
 	ret = air_leds_init(phydev, EN8811H_LED_COUNT, AIR_PHY_LED_DUR,
 			    AIR_LED_MODE_USER_DEFINE);
-	if (ret < 0)
+	if (ret < 0) {
 		phydev_err(phydev, "Failed to initialize leds: %d\n", ret);
+		return ret;
+	}
 
-	return ret;
+	/* Restore LED GPIO output enables after MCU initialization. */
+	ret = air_phy_buckpbus_reg_modify(phydev, AN8811HB_GPIO_OUTPUT,
+					  AN8811HB_GPIO_OUTPUT_345,
+					  AN8811HB_GPIO_OUTPUT_345);
+	if (ret < 0)
+		return ret;
+
+	return 0;
 }
 
 static int en8811h_config_init(struct phy_device *phydev)

base-commit: 1b78070aaef63512688aebfbc82365ef9d6660f1
-- 
2.43.0
