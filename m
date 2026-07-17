Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077253B7749
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 07:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784274253; cv=none; b=tgwJdXfxoOdhqfvKIz6lfkpYhKTxta8FIhMxEhe5BZTw4/rW1RCHB2ViAjJZcxY04S8iF35GdemwqBr/1hnB5T1WiP2D0qNXmqaJNQ3nwUEjSB7Vz/d+qAaqyHoZLN8u1A7oP9Sw5vmGbnfuKfWvU/6CGRRt/gPqHk+gqOrlH6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784274253; c=relaxed/simple;
	bh=pD/Fr7j7LC+S7XDE6hgjwu9ZKftutKyPHkQZ8/uVhes=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ciS4Vb890gZbbfIc2f1j7j93Xk7a9v/fDyqiXEefpttlpvHIFLuGqni68k4gICmpC9b5YPzena/Al61xWIMC3HHPswBwlxOcCXi0lAzwhiigDT4iLcq9L1/209fHhj8od9L5biRq9iNBbM6ZWdPle3CMy16eLt9aMS/0wZsuCg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aAXgLN8H; arc=none smtp.client-ip=74.125.227.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aAXgLN8H"
Received: by mail-pj2-f11.google.com with SMTP id d9443c01a7336-2cf02ecb572so22176985ad.1
        for <stable@vger.kernel.org>; Fri, 17 Jul 2026 00:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784274251; x=1784879051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FUjQiBhhn7qizDAcVRjlQTGe1kqerqqbLUUA/pK1im4=;
        b=aAXgLN8HovhLg7LogaFQgoJpgeUgBYsQFO201v4vXHRAvmTLPK2h+bJaItvaNW6ILJ
         PDXVJhE4KNrq33TktRA+K7wotXEX7OxnY2RWsZGbJBkYDfZTIaDKR4LQR07tD/k1KLb4
         2bV5SxHBAOeX/hZAqZJ6S8nkRzb25F3i4pXqhdk14cynVz8QRh1TTyXsZQvQ3SfVELG/
         aU6yxMumMeNyPVKgFEumaHKKKbZycVUEOeGeYXw1KKTsFRjQFJqMwAcoQisn94jcxTCI
         gnCTMckPJUnD9cDi1in4IhcYE57MgYrew+MP1p4JMGRkuczeoeVKxXX6efgVICipeFtY
         nscw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784274251; x=1784879051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FUjQiBhhn7qizDAcVRjlQTGe1kqerqqbLUUA/pK1im4=;
        b=JcpnZC/ov8KdGUoSTz7UCWAUxD4fvBrjM5q4xeG0dp05VixumNqD5KoRgEf4McmDRn
         lRq9CmnYB51gAT5sMtrFwJLWGwn+sMehcw48FoNq/J26WFkZulIanY0OYXnnzwFjM1jH
         z0uAFlp1yHEpexvBuCJ3rlYcCHtfeaX19vdrD/ljrfQIT+iZQCAY6QwimZy0kcAhRWKN
         Kz9EWYmNtMLdTxp9y0o6UTvoFBa0t1xlqvyFfY1p582/lYvwEbiUZzsIpFZNmt3uPM0K
         VCCtbJ1Rf72PUJXeGA081+NNm+vCOZ5B4iT59HBJIsg+fx2KyBTrDth1aEHdgq9c59VO
         CQDw==
X-Forwarded-Encrypted: i=1; AHgh+Rr1k+h81a2WLbnRbSaPSFf6NXoVbEyYqWS5oPHNMW/JB9mWcaKOIBhOC4zxd3MBOQi3dTcrQnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkSqwd0lMPK5w8Fk0M5PpA3HgZeYsvO5JdabfaU4/4QZa8KtJ4
	IN1TZ7hW5az6CV0mGMDNwRBw8q427XTsXEg31ty9GT8htJMnk0bnsu9U
X-Gm-Gg: AfdE7cmJTlZA4qNNM1LqyCS19LQxhiimiW3ISrp6Ucpkbz1q1swUKsYmw1UihdQd+5n
	UeU+F0zgG0hkZk7HL4WIuIJYPsQrAgAh54aPOtDFbaICI4Kg1ugfJXSudWOouAaeGrdjTlKHd7V
	VZj+v2AScO3HT1dp/hxRoQRTC4iLZoafrCCmVxlm1olbVb5lJyai88iF3UEMy2O0dPQoa6HNdTo
	L63s2fzy4k60zmGnIFUwC043cb8Gb6BFp4mu2iKUhhj8iJ/f3DdtJY1yzao7FSpptQSA2AP2ti3
	of//OqBTrrqrC/Phjg+Yrj9CPWcgeuoxoqP+t/DqelKX3zScrmFZF/dm9ZlWIfDwBqZtISgS8FM
	r5HeA9WpFD8ahMI+G92wyCCaUh4eLdarV9BfLl5emunkxWwPv2VjCcOnIVoTDqBucMnGxZpR91V
	na
X-Received: by 2002:a17:902:ce0d:b0:2cc:9a86:9c42 with SMTP id d9443c01a7336-2cf349eb316mr15543705ad.45.1784274251165;
        Fri, 17 Jul 2026 00:44:11 -0700 (PDT)
Received: from server.lan ([150.230.217.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3448fba7sm6062165ad.6.2026.07.17.00.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 00:44:10 -0700 (PDT)
From: Coia Prant <coiaprant@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Jiawen Wu <jiawenwu@trustnetic.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Coia Prant <coiaprant@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net: pcs: xpcs: fix SGMII state reading
Date: Fri, 17 Jul 2026 15:43:25 +0800
Message-ID: <20260717074324.3250043-2-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
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
---
 drivers/net/pcs/pcs-xpcs.c | 32 +++++++-------------------------
 1 file changed, 7 insertions(+), 25 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index e69fa2f0a0e8d..0337e2bcc0125 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -1058,6 +1058,7 @@ static int xpcs_get_state_c37_sgmii(struct dw_xpcs *xpcs,
 
 	/* Reset link_state */
 	state->link = false;
+	state->an_complete = false;
 	state->speed = SPEED_UNKNOWN;
 	state->duplex = DUPLEX_UNKNOWN;
 	state->pause = 0;
@@ -1069,6 +1070,8 @@ static int xpcs_get_state_c37_sgmii(struct dw_xpcs *xpcs,
 	if (ret < 0)
 		return ret;
 
+	state->an_complete = ret & DW_VR_MII_AN_STS_C37_ANCMPLT_INTR;
+
 	if (ret & DW_VR_MII_C37_ANSGM_SP_LNKSTS) {
 		int speed_value;
 
@@ -1086,34 +1089,13 @@ static int xpcs_get_state_c37_sgmii(struct dw_xpcs *xpcs,
 			state->duplex = DUPLEX_FULL;
 		else
 			state->duplex = DUPLEX_HALF;
-	} else if (ret == DW_VR_MII_AN_STS_C37_ANCMPLT_INTR) {
-		int speed, duplex;
-
-		state->link = true;
-
-		speed = xpcs_read(xpcs, MDIO_MMD_VEND2, MII_BMCR);
-		if (speed < 0)
-			return speed;
-
-		speed &= BMCR_SPEED100 | BMCR_SPEED1000;
-		if (speed == BMCR_SPEED1000)
-			state->speed = SPEED_1000;
-		else if (speed == BMCR_SPEED100)
-			state->speed = SPEED_100;
-		else if (speed == 0)
-			state->speed = SPEED_10;
-
-		duplex = xpcs_read(xpcs, MDIO_MMD_VEND2, MII_ADVERTISE);
-		if (duplex < 0)
-			return duplex;
 
-		if (duplex & ADVERTISE_1000XFULL)
-			state->duplex = DUPLEX_FULL;
-		else if (duplex & ADVERTISE_1000XHALF)
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

