Received: from mail-lr2-f9.google.com (mail-lr2-f9.google.com [74.125.230.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640C7331EB1
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 19:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785352528; cv=none; b=pNP8w+L2kQqymutRITIXvAvCNfxREhMo6na7z1VJ976tP0xcB44EjGUguRWZw7BVRHkfOKBmxuaUz4oU3/A49p2rUmi7prmJkk1lT/VxGkDHyz+vBYsSbGMmWPRop9WO+FN6HssIINyvFku5F6Pe3aqi/nvXqyOedgyznPC8aec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785352528; c=relaxed/simple;
	bh=fnvIbLI+mDotLXrAJ95NrmX4EPCT7f5QwlhxJzgWAGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uR+R6kpE5/mYxl/CdlhbaNna+EvNBOBmGsZNVYxNxGeFcb7dl/LLzkPiTA6z8iRrGhvhLumXf0IixPa0SJvs/zGDaOLpASMfM055jxRXEOnJZyRwp6oBd0aw6E8QcynEX7FGQx4sNWPAZm4DeZA6DZeZPeNsc9nRbFMsYsE99mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TywLhioI; arc=none smtp.client-ip=74.125.230.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TywLhioI"
Received: by mail-lr2-f9.google.com with SMTP id 38308e7fff4ca-39c7d28f438so5194611fa.0
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 12:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785352524; x=1785957324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OQUV8ZV3o2nUwQP/LaIxa/DcGuYUVFEIYNUYOHxjO+Q=;
        b=TywLhioIZ4RAUgc15fHz7nrngY51rfbS/O/aHmUX0X1v1JCPxDWcJIWuqbfYXWO5rv
         8bvKUscqi0WCL2fURgNL076r52A/5EUmQJfDEhazwE2kGuWkROiZLQXDZf81AZrfRemO
         xDeNCwqNUzog+pMKg3UoNezTwk3OFnZxEudaTVdBt/ibs6Ake9sW1MdAGji8CVKCqPIn
         3/V5HPou1AY0Jqs+VMc85fyIL9wF1GAHZilxnN0y8wu0JsqDKXB7VPIYCpFe/VSEO+xj
         69/sv72BTgjm3ixuaYRNm69YY6/6g7J0nMBj0cumY1v2r3CxGZc1AUDhvlJ+seOelYsh
         HpZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785352524; x=1785957324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OQUV8ZV3o2nUwQP/LaIxa/DcGuYUVFEIYNUYOHxjO+Q=;
        b=PJENOt6asTgqLtgJ4gaPQUCUpWtC/1Is5tpGI2RvN4rp6NglV9NUiIzorZaONevZnx
         eDEH7LEcR/Rhu2QsfS6JRa5VQ1QtSUlLVOT0pCbNEdn6NDqIpYiaqw4m1SDfA+Iwa6FN
         0Hsv29SSZCVnbPIeYbJfkqbwTvZSd1INeRYRYbL0PPnw0m588EXUUyQMdCLYAtAzno3B
         i1XnnXcSLUXXg+/14//C/N/pGgRmhz9R45K97/g70OTzRyEjTpM14eqzMoWgWnOt6ArJ
         JzLU9kit2Vn0ndEGzrbgvRu9d1wjpqYiWy0NWPeh7sT7dwwzdr2NmH54TqrNS/h0En+o
         T8lA==
X-Gm-Message-State: AOJu0YzI1wscQtF3WqoPhNuXEUA348rop+73Nbi09j/LknWgHCPzTuTd
	2DSmTn8kuC9JztSATnDKsEYfIEJTYqqyAWOwmMJ5J63KRcFA/w7RrAV2Km98kTWjaiKpBw==
X-Gm-Gg: AR+sD107u0fVJ24w7kZDVlLA9cMj/exnQl+l8NkiA6rM8ohhPLOt9Kyev918+4cjwkk
	QBi+uB6IDIGV3PRQ9Sz1LLFf8lvMGI0XK3W4LtCxniFgFTZM/rCupPw7aGoY0/OgGIQsEUJ7U5A
	PpxTbdKh6COaMHD7pJJeaHfX4onNXwlcCLuO+BM+nKV7vGE/4bbwlAN4D0D9J52o6aDcXs4a7EU
	3VbO6LIKaCKDArit2THkMOIpNWE3ZixDjmC3yhY3M+3VjOLHiNUxyX6hznP1ZaAVb4IFUX5CkSG
	mc6rHgHVuyUI0RW6w+n89y6prHYJDgPFVjs16oUUDY3DLebRzzaH4nhfWVyj56PSvkZTtS8S/xX
	g/sKluAMLjAXcrtQkiap59q0nixmDAFWlm10GoX03CKN/utTvXxjUUHhut74oUvRCS/aZFQrFIM
	ie8RpXFUYz+BXQgl0fAe40MPtyvJ9Sd5ddTx6Irm29zcbKALGcrk3Ffw==
X-Received: by 2002:a05:6512:2306:b0:5b2:d7f2:90a4 with SMTP id 2adb3069b0e04-5b2da472888mr4244e87.5.1785352523871;
        Wed, 29 Jul 2026 12:15:23 -0700 (PDT)
Received: from ProxmoxVE.your-server.de ([2a01:4f9:4a:44ab::1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2d790eb5dsm556063e87.76.2026.07.29.12.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 12:15:23 -0700 (PDT)
From: Coia Prant <coiaprant@gmail.com>
To: stable@vger.kernel.org
Cc: Coia Prant <coiaprant@gmail.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.12.y] net: pcs: xpcs: fix SGMII state reading
Date: Thu, 30 Jul 2026 03:14:26 +0800
Message-ID: <20260729191425.3176146-2-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026072904-shallow-icing-2a9f@gregkh>
References: <2026072904-shallow-icing-2a9f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 2a22b7ae2fa3 ("net: pcs: xpcs: adapt Wangxun NICs for SGMII mode")
added a path in xpcs_get_state_c37_sgmii() that reads speed/duplex from
BMCR after AN completes. However, BMCR does not reflect the negotiated
result on the hardware where this has been tested:

- On RK3568 (MAC side SGMII), BMCR returns a fixed hardware reset value
- Wangxun engineer Jiawen Wu confirmed that on their side, "BMCR looks
  like it only wants to be return as 0" [0]

The correct information is available in CL37_ANSGM_STS, which contains
the actual link status and negotiated speed/duplex.

This bug was previously masked by phylink core, which overrides the PCS
link state with the PHY state when a PHY is present:

        /* If we have a phy, the "up" state is the union of both the
         * PHY and the MAC
         */
        if (phy)
                link_state.link &= pl->phy_state.link;

Thus, when the link is down, the PHY's link_down state is applied on top
of whatever the PCS reports, hiding the broken PCS state reading path.

Modify xpcs_get_state_c37_sgmii() to:
1. Read link state from CL37_ANSGM_STS
2. If link is up, report speed/duplex from CL37_ANSGM_STS
3. Remove the broken BMCR reading path entirely

Also properly set state->an_complete to reflect the AN completion status,
and clear CL37_ANCMPLT_INTR when link is down to avoid stale state.

[0] https://lore.kernel.org/all/000c01dd1593$2ac0b0f0$804212d0$@trustnetic.com/

Fixes: 2a22b7ae2fa3 ("net: pcs: xpcs: adapt Wangxun NICs for SGMII mode")
Cc: stable@vger.kernel.org
Tested-by: Jiawen Wu <jiawenwu@trustnetic.com>
Signed-off-by: Coia Prant <coiaprant@gmail.com>
Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Link: https://patch.msgid.link/20260717074324.3250043-2-coiaprant@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit def9a4745e105145133e442dd8a1c126caf0f553)
---
 drivers/net/pcs/pcs-xpcs.c | 32 +++++++-------------------------
 1 file changed, 7 insertions(+), 25 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 82463f9d50c8..0152f820c1bb 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -973,6 +973,7 @@ static int xpcs_get_state_c37_sgmii(struct dw_xpcs *xpcs,
 
 	/* Reset link_state */
 	state->link = false;
+	state->an_complete = false;
 	state->speed = SPEED_UNKNOWN;
 	state->duplex = DUPLEX_UNKNOWN;
 	state->pause = 0;
@@ -984,6 +985,8 @@ static int xpcs_get_state_c37_sgmii(struct dw_xpcs *xpcs,
 	if (ret < 0)
 		return ret;
 
+	state->an_complete = ret & DW_VR_MII_AN_STS_C37_ANCMPLT_INTR;
+
 	if (ret & DW_VR_MII_C37_ANSGM_SP_LNKSTS) {
 		int speed_value;
 
@@ -1002,34 +1005,13 @@ static int xpcs_get_state_c37_sgmii(struct dw_xpcs *xpcs,
 			state->duplex = DUPLEX_FULL;
 		else
 			state->duplex = DUPLEX_HALF;
-	} else if (ret == DW_VR_MII_AN_STS_C37_ANCMPLT_INTR) {
-		int speed, duplex;
-
-		state->link = true;
-
-		speed = xpcs_read(xpcs, MDIO_MMD_VEND2, MDIO_CTRL1);
-		if (speed < 0)
-			return speed;
-
-		speed &= SGMII_SPEED_SS13 | SGMII_SPEED_SS6;
-		if (speed == SGMII_SPEED_SS6)
-			state->speed = SPEED_1000;
-		else if (speed == SGMII_SPEED_SS13)
-			state->speed = SPEED_100;
-		else if (speed == 0)
-			state->speed = SPEED_10;
-
-		duplex = xpcs_read(xpcs, MDIO_MMD_VEND2, MII_ADVERTISE);
-		if (duplex < 0)
-			return duplex;
 
-		if (duplex & DW_FULL_DUPLEX)
-			state->duplex = DUPLEX_FULL;
-		else if (duplex & DW_HALF_DUPLEX)
-			state->duplex = DUPLEX_HALF;
+		return 0;
+	}
 
+	/* Clear AN complete status or interrupt */
+	if (state->an_complete)
 		xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_INTR_STS, 0);
-	}
 
 	return 0;
 }
-- 
2.47.3

