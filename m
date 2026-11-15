Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794716815;
	b=Le0RYA4XMVwh2NLxD4nyN+3INhzFuq3JSKFPrepQxUtZGmpCuQGzHowvgph4sv5hl3mA
	 opMXJiD6kNXbLCLczVZgAKdvR5y8JT2zPJbebAvYlzKCIAYa/YU/HdIxdMCNJ8apkvD1I
	 BpEnKu4wZGlkuui2rhfl9M5abYHcxpzVA9Z+9GTPmcM+mX2hrfDvRC0ROgSZD3Rj4ErKQ
	 kX8iNxopAheOSKSk+jyEvNDKla6+Rqg71+SpSNja22Q5PGfh2SCDS7jE5m9OdzhDvqWgI
	 k5d4wWtrBcePEBm3GnrtACH1kxMgPV51Rzf1K7s2Qc1poHlHVoUBMFYxpBbnrm3emig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794716815;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+rGTBLT3wwmPVYA4drxDvmKiLgmjfMAUnQ/eOQPgd24=;
	b=FGpV6dKkhTnFHwXtwYPKnrQ5yB9tS+gAZC3z/sZY7yIg4RJiOmaaT1qniOEFWf2F8gWK
	 59sEO9AzI893rJoNEMTD1XABS+VJw3rF90bVMawOI0XiO2EGLcI2T+1Amid6L+E87ItVS
	 Y2Wo+1mtTItr0UKw0qbh870JbMpMVWyd/3QEkfrunDJQkH4TeeU4oOtXCou/1az/gHW2d
	 /UcYTVja40a+u/S11dTDhdmbFWgoy2t8P2/a7VbN5f/U9+o5Joan6ykZyRj8MuH/isT4L
	 X7IjtwtIxmhlHXwqDySh28kt0zokX8r+IZD9fGQh/l+z6nBwxsoKT/IAEbbm9nxYHXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=M7JWE2Et;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847E7606A329;
	Sun, 15 Nov 2026 04:26:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 847E7606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=M7JWE2Et
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=M7JWE2EtO30y7rDPR1NaaLdApNOO6bgkG6OQ3Hx30ZLHuoDRZyUUBdkNXogBtjSSKatNJDFyI46dc
	 i0ueokU9D2SqyVpysvQNxVDvDJd22r1/odVkOAiPc3oCpx62WGUmjx6yG2gK8P2HGU590bcbF1pIdH
	 OMRDVAxwFeEiwyWs=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee56af9348ba8e-f228a;
	Sun, 15 Nov 2026 12:26:51 +0800 (CST)
X-RM-TRANSID:2ee56af9348ba8e-f228a
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[112.23.105.246])
	by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee46af9348a5dd-593e3;
	Sun, 15 Nov 2026 12:26:51 +0800 (CST)
X-RM-TRANSID:2ee46af9348a5dd-593e3
From: Xia Yan <yanxia@cmss.chinamobile.com>
To: vkoul@kernel.org,
	linux-phy@lists.infradead.org
Cc: neil.armstrong@linaro.org,
	mani@kernel.org,
	heiko@sntech.de,
	p.zabel@pengutronix.de,
	ayaka@soulik.info,
	kishon@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yana06070@163.com
Subject: [PATCH] phy: rockchip-usb: fix reset control leak
Date: Sun, 15 Nov 2026 12:26:40 +0800
Message-ID: <20261115042640.426517-1-yanxia@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
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

rockchip_usb_phy_init() acquires a reset control from each PHY child
node but never releases it on probe failure or driver detach.

The leaked exclusive control prevents a later probe from acquiring
the same reset. Since lookup errors are converted to NULL, subsequent
PHY reset calls silently skip the hardware reset.

Register a devres action after a successful lookup to release the
control on probe failure and detach. Keep the child-node lookup and
the existing handling of lookup errors.

Found during review of reset-control lifetimes.

Fixes: 0f74ab59ce87 ("phy: rockchip-usb: use rockchip_usb_phy_reset to reset phy during wakeup")
Cc: stable@vger.kernel.org
Signed-off-by: Xia Yan <yanxia@cmss.chinamobile.com>
---
 drivers/phy/rockchip/phy-rockchip-usb.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-usb.c b/drivers/phy/rockchip/phy-rockchip-usb.c
index c5a2853a63d3..79b3315b6590 100644
--- a/drivers/phy/rockchip/phy-rockchip-usb.c
+++ b/drivers/phy/rockchip/phy-rockchip-usb.c
@@ -183,6 +183,11 @@ static const struct phy_ops ops = {
 	.owner		= THIS_MODULE,
 };
 
+static void rockchip_usb_phy_reset_put(void *data)
+{
+	reset_control_put(data);
+}
+
 static void rockchip_usb_phy_action(void *data)
 {
 	struct rockchip_usb_phy *rk_phy = data;
@@ -219,8 +224,15 @@ static int rockchip_usb_phy_init(struct rockchip_usb_phy_base *base,
 	}
 
 	rk_phy->reset = of_reset_control_get(child, "phy-reset");
-	if (IS_ERR(rk_phy->reset))
+	if (IS_ERR(rk_phy->reset)) {
 		rk_phy->reset = NULL;
+	} else {
+		err = devm_add_action_or_reset(base->dev,
+					       rockchip_usb_phy_reset_put,
+					       rk_phy->reset);
+		if (err)
+			return err;
+	}
 
 	rk_phy->reg_offset = reg_offset;
 

base-commit: 9a0dd2a09484e5ba45eb8e6ab58c0effe18703a3


