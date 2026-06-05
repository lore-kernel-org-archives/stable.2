Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CE5202963
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 12:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780661741; cv=none; b=a9y1DWa6fblKQGVhoO0KQZyj3GjlF4PivDg/TbnCCMOAfseBfRyytDWcS677JBl6V6GrXZyHj5VfVU8CyUMJFCFqxs9si1Ak42Ixg22Q8tOuAJfPsnCQG37vA4c/uQPr5tWgG1o+qyvCysr9UZCcxo8/7yJP2lmqHZqW07E43mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780661741; c=relaxed/simple;
	bh=fXx6yGbTzyV9r4+8RIi/cY1NomiwKfkeqLs2lx+MlLs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ibL7L4hJgWuXan5YPxJM6KyBFJ9IU2aPVx/knFve04XbOXu2HFnvJ+Ca2biGhuKG/aTPOKHP1YodT/avUYqCuW/OB0jiB8K3mHw72nWZmTcIRcnNbXsgrz6d7HZBqXc+OrZlTI25VCF5XmEkhRP1AC3Mn184ylxckWmp2//KNWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bXK6rN+R; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXK6rN+R"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8424b6792efso654954b3a.3
        for <stable@vger.kernel.org>; Fri, 05 Jun 2026 05:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780661740; x=1781266540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8BtuG0pULy2ESLzHtqYqpkGxYxsqgbLcJ3DpU7JXoV0=;
        b=bXK6rN+Rs93Wf3M7m2aZnpktP/eYSnZ+x14FkP20cby09Hw98X2uS79PFC7zua+wDl
         V6iADps1Zh6joUs504JZlEADmSWtOWqWvg78kkDSNYwnTh/52VnMAzbDn0GlkRCuXHBB
         DANnHbAvvH1xPzebasbiadrz5wA/d72o7pKBLtQGgMy5B8fWd8VAIUNS6IzyE9sOa+/t
         QvL/dVE4qOLsGsP4mZVLcSuqIIVY7+FXsJ0SuslfwrMWiOMqfbWRykvuVLk8jzRtRl5o
         Gn9IAMjGIzZGLmEzKaDxnmFr3dTu4+8P/jpPbZjTTXtutVrZctrJIka8xnhgbP0QhMen
         KJTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780661740; x=1781266540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8BtuG0pULy2ESLzHtqYqpkGxYxsqgbLcJ3DpU7JXoV0=;
        b=oaJb87kpoBZtzU723FZiqLdGJA7zDHc5IB1SIZ1j4U771mRKRpWBmhebq1Lyln2SQE
         43ctQXK5k4+hT3oIRiHYOnsc8mzehjl+JRbfmEMWUhze17VFcofts1nvs9W+AxEB0EHm
         8rDUvpNYf/3s2EcI51Lf3CgNSVdb/OaQUgaWVAdEDCVYbN6yybiwOCLcV12SpqnD9k7G
         Z0JacsPO6/RfeSUJFstPPuiXnUg9kAMWj0yVQDi3+MAqyWHdMeSgfuW8TgbJbtGfdYBh
         voUChjWFesPvjnMhI0bcoN4YT+J01eoIXBGYSeyIeKP16bmkM15bAanEaKqiTmLwHCk3
         pT2A==
X-Gm-Message-State: AOJu0YzftkK7ncwvKTmJebDyVhv+/ndPiub114E8yNyAGerx6cQLrh7M
	sI7kb3PM3YztQub9IQTsZ2unU5M4BcYK+iwW22AZo5ZKGPp7hKXj0kyKRJ6WQtdK
X-Gm-Gg: Acq92OFWWZ51q6xcdP7yauCm9lNEou0iyqNoLpX0Lwnd4TUH/t6Ejo45o0FUM+15q/T
	8CAsSzTIwVMHk6269GV+i/Ia0ZA5JCw/L0l+/QDiTdOXT0mYyMg2gCG1J/IeOw3LXCVw6Jf9POf
	D6tLlqht9ns6V38bTvOPfiE16UV8CbY2RzO2R5ddnOjTE5fOtKPg2QGW0V3MFtmC+PPRNT7vFMR
	vZHin5LLAHDWZSr6qdBsp38k0qN7/xVm1y31nrvEjRF8l/f7r8kA/tHH1admrXfA44JL/BG3/aX
	KD3J0PVl11xAYTTc2dwYSOyv7t4HKfbl9TB1QcJk7oUi3mAadkztBmnIxhp6SynGozAbuGfX78h
	9jQkRoGhSEz4ZkjAKSQpM5dTzj2kSh4xjmyz+Ca1Jgae8rX+KYqS9sPcVbDvCUzIhISEnkS3wkZ
	1C3RGdcPzSDc5lobaoFXa7fhEhf85EDaEvOg==
X-Received: by 2002:a05:6a00:1d91:b0:842:2ddb:e305 with SMTP id d2e1a72fcca58-842b0fc0c71mr3240988b3a.43.1780661739544;
        Fri, 05 Jun 2026 05:15:39 -0700 (PDT)
Received: from ltu.. ([171.245.6.72])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282374300sm11241583b3a.20.2026.06.05.05.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 05:15:39 -0700 (PDT)
From: Nguyen Minh Tien <zizuzacker@gmail.com>
To: stable@vger.kernel.org
Cc: Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org
Subject: [PATCH 6.6.y] net: usb: lan78xx: program MAC_CR for LAN7801 fixed-PHY link
Date: Fri,  5 Jun 2026 19:15:35 +0700
Message-Id: <20260605121535.51414-1-zizuzacker@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While bringing up a LAN7801 wired over RGMII to an MDIO-less switch, I
hit a link that the fixed PHY reported as "up" but that could not pass a
single packet: every frame came out corrupted at the switch and no ARP
reply ever made it back.

It turned out the MAC_CR speed/duplex bits are never set on this path.
lan7801_phy_init() registers a fixed PHY at SPEED_1000/DUPLEX_FULL, but
nothing programs the MAC to match: there is no PHY state machine for a
fixed link, and lan78xx_reset() only sets the auto speed/duplex bits for
the 7800.  So the 7801 comes up at 10M/half, clocks RGMII TXC at 2.5 MHz
instead of 125 MHz, and mangles everything it transmits.

Fix it by programming MAC_CR to 1G/full in the fixed-PHY branch, to match
fphy_status.  Only that branch is touched, so boards with a real external
PHY (and the 7800/7850) are unaffected.

Mainline fixes this differently via the phylink conversion in v6.16,
commit e110bc825897 ("net: usb: lan78xx: Convert to PHYLINK for improved
PHY and MAC management"), which is far too large to backport, so this is
a small fix for stable only.

Please apply to 6.1.y, 6.6.y and 6.12.y, the pre-phylink branches that
still carry this bug.  Built and tested on 6.6.y; the touched code is
identical on 6.1.y and 6.12.y.

Fixes: 89b36fb5e532 ("lan78xx: Lan7801 Support for Fixed PHY")
Cc: stable@vger.kernel.org
Signed-off-by: Nguyen Minh Tien <zizuzacker@gmail.com>
---
 drivers/net/usb/lan78xx.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index f5bcf150fd9e..6b94f6026472 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2325,6 +2325,22 @@ static struct phy_device *lan7801_phy_init(struct lan78xx_net *dev)
 		buf |= HW_CFG_CLK125_EN_;
 		buf |= HW_CFG_REFCLK25_EN_;
 		ret = lan78xx_write_reg(dev, HW_CFG, buf);
+
+		/* Nothing programs MAC_CR for the fixed link: reset() only
+		 * sets speed/duplex for the 7800, so the 7801 is left at
+		 * 10M/half and mangles every frame it sends.  Force it to
+		 * match the 1G/full fphy_status above.
+		 */
+		ret = lan78xx_read_reg(dev, MAC_CR, &buf);
+		if (ret < 0)
+			return NULL;
+		buf &= ~(MAC_CR_AUTO_DUPLEX_ | MAC_CR_AUTO_SPEED_ |
+			 MAC_CR_ADP_ | MAC_CR_GMII_EN_ |
+			 MAC_CR_SPEED_MASK_);
+		buf |= MAC_CR_SPEED_1000_ | MAC_CR_FULL_DUPLEX_;
+		ret = lan78xx_write_reg(dev, MAC_CR, buf);
+		if (ret < 0)
+			return NULL;
 	} else {
 		if (!phydev->drv) {
 			netdev_err(dev->net, "no PHY driver found\n");
-- 
2.34.1

