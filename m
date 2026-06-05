Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0A7199E89
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 00:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780619700; cv=none; b=FjyUdDctrPY9GhSCBnisSs7eAB15Wa1DqtHqJUzmXNp2RL/ai2Tj/+XttiZD4ukVRFz6ncZDX+T8zwxWeLXj3TCbsz9y+uHgvvhsN3FwIi+jRfliq9p5EmohhyW/RMt/LwPnXQPmQcrgQPP5eAW92uVFXDdadNU4WUuktQo0PC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780619700; c=relaxed/simple;
	bh=GE9IIx8uS7AW1tKID2+LZKxFQhfMFM8iAXvdHfrLEB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cGvP9mYYYuxvDLVg1BKfDax21eqM4IUdyCABszq5Yv/Xo+S0ndKl8xv5xzqIVGGBVBomTl5J1GEdZDGnyfrrT/7132P/1Ki93ZOKzyqWm7IyL1hFxc0FkueiOzpvqWcnnG9KixxA5fM+sz5nBdsvqrY+gHNgxdFEtsQ6XsLSwMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U46/B2JY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U46/B2JY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D88B71F00893;
	Fri,  5 Jun 2026 00:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780619698;
	bh=a69Yp+zgxPyXSycjnPbfBKl+52UZ/8dJTqqGgUSGcgc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U46/B2JYXmRPDYLZyl5m6eDx0da5VdcQmro6NCL8KcghqK6l61Lz5e3dmwbEkvFPz
	 J/HZj23nkuCOS18A8o3Kh7JUsUE1XETb3Mp/rFubt9hJfd4IdZlTRJNoPLhPOhsMWf
	 6sJdHUKQ3QErvTxQz+2H1OMQs9M8dH7k3sj0mRQXvoeq7o6tQbel9faDszBBblZlug
	 jCDhVAWwj2FXx2fFl2tJMa2uVj6mMS/i8MEwtm/SWSow7Y+3VdzhCl81WDrQbx4hBe
	 eUc+rExpSFrIb2ir2Nme4YL88fjN4yuo/V98U2MWQNy2/jKwVge179QMIv6dze3ALe
	 5MKsvAVLnuAKQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Chen <peter.chen@cixtech.com>,
	stable <stable@kernel.org>,
	sashiko-bot <sashiko-bot@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] usb: cdns3: plat: fix leaked usb2_phy initialization on usb3_phy acquisition failure
Date: Thu,  4 Jun 2026 20:34:56 -0400
Message-ID: <20260605003456.2707466-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060428-repaying-swept-0b59@gregkh>
References: <2026060428-repaying-swept-0b59@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Chen <peter.chen@cixtech.com>

[ Upstream commit e6970cda63fd4b4546aeed9d0e2f53a7c95cd09c ]

Move usb2_phy initialization after usb3_phy acquisition.

Fixes: f738957277ba ("usb: cdns3: Split core.c into cdns3-plat and core.c file")
Cc: stable <stable@kernel.org>
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/linux-devicetree/agKaEePSFknhDBg2@nchen-desktop/T/#m21e1d9c1574eb127ce03c0c2a1a49002ce435b52
Signed-off-by: Peter Chen <peter.chen@cixtech.com>
Link: https://patch.msgid.link/20260513085310.2217547-2-peter.chen@cixtech.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/cdns3/cdns3-plat.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/cdns3/cdns3-plat.c b/drivers/usb/cdns3/cdns3-plat.c
index 726b2e4f67e4da..0869b75e9a4aed 100644
--- a/drivers/usb/cdns3/cdns3-plat.c
+++ b/drivers/usb/cdns3/cdns3-plat.c
@@ -120,14 +120,14 @@ static int cdns3_plat_probe(struct platform_device *pdev)
 	if (IS_ERR(cdns->usb2_phy))
 		return PTR_ERR(cdns->usb2_phy);
 
-	ret = phy_init(cdns->usb2_phy);
-	if (ret)
-		return ret;
-
 	cdns->usb3_phy = devm_phy_optional_get(dev, "cdns3,usb3-phy");
 	if (IS_ERR(cdns->usb3_phy))
 		return PTR_ERR(cdns->usb3_phy);
 
+	ret = phy_init(cdns->usb2_phy);
+	if (ret)
+		return ret;
+
 	ret = phy_init(cdns->usb3_phy);
 	if (ret)
 		goto err_phy3_init;
-- 
2.53.0

