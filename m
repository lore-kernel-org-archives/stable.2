Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FF0373BEB
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 08:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780562966; cv=none; b=bzQah1czICjFsrD0W/PkWpPYKHzN5YJDG5YTHgVdg/Lc6lzrmPeHoOQVNx9B7c5/WfeAeSHpesiriKnMEfgA5PC68XlEYMeyEUwH7MKdXMQe+YMj9NZfjb9IOxC0CRH83UshUdXEkHLAWKy0rsZghu242PVLvvgkgj+fxR/8GjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780562966; c=relaxed/simple;
	bh=QB/DPSBq8wk65RKrXtiY3LN0xYiy+EKii9iHTn1Y0Vk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hQG9JxtCglwMIqI0Ji8axQy2piBe24Yh1VLPKPvHZ3bepDnCqdPS/ELKKV7X0+dd2JPDCjoE5wIri2+Je1j8kn7+XU7YnJw5abLCY8l83QM6bW+2VlGRJmzW4sTpteNGCaNDOp4r1znYp38Qmj/QQF0QCiyYf9+UKzTz0jJYxv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sLxgD9fY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sLxgD9fY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD6CB1F00893;
	Thu,  4 Jun 2026 08:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780562965;
	bh=hOPQSny3GLB1Z+XoG9yFWRh84H+pwLK8CzDcNP02Hug=;
	h=Subject:To:Cc:From:Date;
	b=sLxgD9fY/kN6yN9df0Emab1GBcg14CK2PB1JSA5/sFu45hAmAvO3nIuApweRImEyz
	 Duw5h9n6oIS8b0bTQdcWS5VQUA/HofmZvSnCpAtIVecZWhy8GwawS83qcbBOl5a78D
	 UJi7pAFqx2fxc1LZs2BDhbBP6j6p389ge1SsJ23c=
Subject: FAILED: patch "[PATCH] usb: cdns3: plat: fix leaked usb2_phy initialization on" failed to apply to 6.6-stable tree
To: peter.chen@cixtech.com,gregkh@linuxfoundation.org,sashiko-bot@kernel.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 04 Jun 2026 10:48:28 +0200
Message-ID: <2026060428-tackle-screen-6157@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x e6970cda63fd4b4546aeed9d0e2f53a7c95cd09c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026060428-tackle-screen-6157@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e6970cda63fd4b4546aeed9d0e2f53a7c95cd09c Mon Sep 17 00:00:00 2001
From: Peter Chen <peter.chen@cixtech.com>
Date: Wed, 13 May 2026 16:53:09 +0800
Subject: [PATCH] usb: cdns3: plat: fix leaked usb2_phy initialization on
 usb3_phy acquisition failure

Move usb2_phy initialization after usb3_phy acquisition.

Fixes: f738957277ba ("usb: cdns3: Split core.c into cdns3-plat and core.c file")
Cc: stable <stable@kernel.org>
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/linux-devicetree/agKaEePSFknhDBg2@nchen-desktop/T/#m21e1d9c1574eb127ce03c0c2a1a49002ce435b52
Signed-off-by: Peter Chen <peter.chen@cixtech.com>
Link: https://patch.msgid.link/20260513085310.2217547-2-peter.chen@cixtech.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/cdns3/cdns3-plat.c b/drivers/usb/cdns3/cdns3-plat.c
index 735df88774e4..d2e8d1e9007b 100644
--- a/drivers/usb/cdns3/cdns3-plat.c
+++ b/drivers/usb/cdns3/cdns3-plat.c
@@ -126,15 +126,15 @@ static int cdns3_plat_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(cdns->usb2_phy),
 				     "Failed to get cdn3,usb2-phy\n");
 
-	ret = phy_init(cdns->usb2_phy);
-	if (ret)
-		return ret;
-
 	cdns->usb3_phy = devm_phy_optional_get(dev, "cdns3,usb3-phy");
 	if (IS_ERR(cdns->usb3_phy))
 		return dev_err_probe(dev, PTR_ERR(cdns->usb3_phy),
 				     "Failed to get cdn3,usb3-phy\n");
 
+	ret = phy_init(cdns->usb2_phy);
+	if (ret)
+		return ret;
+
 	ret = phy_init(cdns->usb3_phy);
 	if (ret)
 		goto err_phy3_init;

