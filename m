Received: from mail-lr2-f9.google.com (mail-lr2-f9.google.com [74.125.230.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBA2468C06
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 19:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785352321; cv=none; b=EM3E1NDzdn6OF/7VqD23xBuEn4p62at/rt2AqAei/a49dnKtGD+/g6WpuLulWuux4xcWYTojz1dhrI+w/CRSxE9NDCBLbUano2VPlBa+ZhZcq8mVMU0PpnGPr28KORXmadJt/bhagspyi7gHi0obPkiHtw3jQl27bykLfXlQZ34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785352321; c=relaxed/simple;
	bh=VMBvRtLljs3sSYgVTfNys9iQWs652wyK28sIr71vZpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cbb17IwR3DFbDWsSgisScU7O6JizfHtZU9wR7MO60gKQLbgszsXqQJP0XhNxTJHIrKQL3PiBo2ZPYQcmHtcA/7EB2wysQAV2YALjWixLCnfeAHmmi9/De5Gp0l4HiyyFeJVR2/dFuN3s+Kok7wGINI2mNONERULqToHsM4ydhEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EjAGOEzJ; arc=none smtp.client-ip=74.125.230.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EjAGOEzJ"
Received: by mail-lr2-f9.google.com with SMTP id 38308e7fff4ca-39f1ba4e5caso5532501fa.1
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 12:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785352318; x=1785957118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nz6fB83VTpo9I8pDSDFATeVvdBMEfR3DsZekyQ+WLVI=;
        b=EjAGOEzJwLyo1AlgNIKQF6P6/DwvJniDtCcVjN7qDiDZ+U4g7zbMwD9G3oU8rvSYhp
         MWmm03PFYyrcFstyslsLHjr/xGA7pUxKvbV0NnuuNjrib76W9X+S4SCszcvTvR58uOaW
         ke49n8CwXXs3pHgU3lWkQl1agp1mUvvc5PLRWHkgbTOjS2cc+gAYgRWlzS0GnULIv1UW
         PzFkSGB11ZdTg0N0KiHGY+2rICbQ5uSRFKM6V7sFLYNiw4zFon9s0D40rmW3saHWY+Kc
         2edvtm77SsVk+4aqhuVjUEPq+Z+ilfyIrLpiA82ut6pKAocX5WMS7Z4JVXXeeO80LJJ3
         UCJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785352318; x=1785957118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Nz6fB83VTpo9I8pDSDFATeVvdBMEfR3DsZekyQ+WLVI=;
        b=TO7keqhqUeUfPbHXY5/Q55n0y4gGbcKSzy0Rdp/g6B7nQMsf5ymrmCTZc0pD/gwTBv
         taMxjRIYsApXCw5WiEsu34R3yf0ADerZE/9hGZuGzRJRF0/yK8t3KrA8CibbwRpg78it
         rPq49xoF2awJWB8rnPiiP/W++6rlLQeTcOMeZ71ZJOb0kHRGJi3rklu+tlc388kjJB2D
         BOlGHnMM3wExiB5gfAViWmOKx+ic9yvGUBW3rnxJlmFaW+4mpr+XveAQrwldZtXNtKyF
         JLi5/zIX1BNaJnTSzBvZGpO1CxTx1TazJWTDx8j6pWCJ9ewaA17tM4uk32X3oL2kJVly
         Y5wQ==
X-Gm-Message-State: AOJu0YxsQg9Nd7+j/v/cut6zhQWHViH2MQebnC0TUbJq5FsQ+1a094CC
	1b6RPNp9bcu6pvS42kOpVqIe+aNWozUdLAcz8BMaYz+Kp2bZG/LCjzkn0z8bu3+2GKZSmQ==
X-Gm-Gg: AR+sD13MoaHpK7hScB3WwkOtixBvfUbx4BjuTK1htXC5EJmScY9LqJC5qtziRfS1Aq3
	HwhJ6UT+B2mkXxxUneqJWAcN7RGSJ9UfKUSu8awOEfDynkYSK3e2YpSvtdKXqkVFlF3mcUOaeAG
	UWR3kBJfZwUVW4dULZX7UDdsn0FuySWvOSyndaEx7scxZkdm0NWlF8PB/xgWAIWjW9dA+8HcVz1
	qePiy+MoRGm9ddNxKO16eFkjM3EvhF/LE21nf0vnmJWpddKLGLc4Zw/XqJ5wF+dyzIC9bYQQRNa
	Gsw8mDZaPW5fKbJWG2/k1P37pd50bO0KR3Q4XPWUDnqX+mXJPtzXnWV7B2w5ZlkjtVVtq7VNnvR
	IA2yIwhOz9LYtheXoHMROdxP9hzw0a7gTDh2jZPmbgMYPSF0r50YLXS7Ne61I9exPBfkE5PV/fA
	OhhHxC1dzHKxrEZxFQnnIs5KVgqOSU2AZFtRrl2yQwnaT3LBDM0/ZVHA==
X-Received: by 2002:a05:6512:3d14:b0:5b2:9b13:2cd9 with SMTP id 2adb3069b0e04-5b2d0257905mr1789178e87.44.1785352317770;
        Wed, 29 Jul 2026 12:11:57 -0700 (PDT)
Received: from ProxmoxVE.your-server.de ([2a01:4f9:4a:44ab::1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2d791072asm550217e87.78.2026.07.29.12.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 12:11:57 -0700 (PDT)
From: Coia Prant <coiaprant@gmail.com>
To: stable@vger.kernel.org
Cc: Coia Prant <coiaprant@gmail.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6.y] net: pcs: xpcs: fix SGMII state reading
Date: Thu, 30 Jul 2026 03:11:08 +0800
Message-ID: <20260729191107.3171986-2-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026072905-mashed-sedan-7f29@gregkh>
References: <2026072905-mashed-sedan-7f29@gregkh>
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
index f0f41e86a4fb..680e2b261086 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -994,6 +994,7 @@ static int xpcs_get_state_c37_sgmii(struct dw_xpcs *xpcs,
 
 	/* Reset link_state */
 	state->link = false;
+	state->an_complete = false;
 	state->speed = SPEED_UNKNOWN;
 	state->duplex = DUPLEX_UNKNOWN;
 	state->pause = 0;
@@ -1005,6 +1006,8 @@ static int xpcs_get_state_c37_sgmii(struct dw_xpcs *xpcs,
 	if (ret < 0)
 		return ret;
 
+	state->an_complete = ret & DW_VR_MII_AN_STS_C37_ANCMPLT_INTR;
+
 	if (ret & DW_VR_MII_C37_ANSGM_SP_LNKSTS) {
 		int speed_value;
 
@@ -1023,34 +1026,13 @@ static int xpcs_get_state_c37_sgmii(struct dw_xpcs *xpcs,
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

