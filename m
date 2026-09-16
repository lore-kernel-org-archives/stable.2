Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DD7432305
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 19:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789587268; cv=none; b=KfRmyvs/G4MvZQVXkkKRqtdkbR4LjEcFOH0utzy3lmbdEnccXudujo7aQY/I9LThxubvRMD2MqmS2MAViKF+S9sczgmLbtltLwmOeXYNmINDBPJ0tLzc0MZw3KuVBohFPyjpeLwIEISh9OUym9uhg0tAVRo4w4bMO3bzpqS9Mr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789587268; c=relaxed/simple;
	bh=/ZlaejZYMCl/rw589md+HcXqg5MmL552JngVcxkCPrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sQyhCTMWkXpWaUXsehbCrC3PH7m/9FTaVugW7hJYVUdLBKjLxtq22xri040akb5kgqDkya3H38Lzcq83TZyK9CuVqPPkjN96ijVgEbeZhGfb2/xPUTlDo2fl+5iHqrIWNjvZgMEwMK3QkjZ7c8F4QRaCEV4cR193ulDOilIaZuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3RXTfmo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3RXTfmo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8A6B1F00893;
	Wed, 16 Sep 2026 19:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789587262;
	bh=g2wu7jsA1Wo0RIltbfAAWxiqjs5i99963xu4VqrX6eE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m3RXTfmoxIF5+iVW/1JM/dET7UDA7wB5NRtkXTo9KEIFQfBoNePiE76cpRUHJytcV
	 ah2mI4+dEGrC61WD8qgpe63ZYtRUbhJRiY5s+AzB4o03gOoOGhKuFS4hwP5PD/QQyU
	 9cIzxNXk8jgj2ZjTqvZuIHFJG1JEr3rv+kI+H8KGcoMpl+ahQNZvRo84xlY2xThh/L
	 CY+06dlRcoqcrLgETHZLcjuOXAVYBORVvkr5ninIUqlzzk5+0+pi3cVRL6etl2MCbC
	 BCS6zhAPNBKM9P2OwEZ8YuF1bHjLZpSF41fWEnLUe8MqmffMF9H3ZOjfSzK+Zy73av
	 BidchrcK7Y9wA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dinh Nguyen <dinguyen@kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] EDAC/altera: Use parent device for devres in altr_portb_setup()
Date: Wed, 16 Sep 2026 15:34:19 -0400
Message-ID: <20260916193419.2305184-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916193419.2305184-1-sashal@kernel.org>
References: <2026091618-scruffy-brownnose-a686@gregkh>
 <20260916193419.2305184-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dinh Nguyen <dinguyen@kernel.org>

[ Upstream commit 9868f5c077dfe0b606331f2e782484f91a5789a5 ]

Anchor the devres group and the devm-managed IRQ requests in altr_portb_setup()
to the actual parent device (device->edac->dev) instead of the embedded struct
device inside the copied per-port altr_edac_device_dev.

This keeps devres_open_group(), devm_request_irq(), devres_remove_group() and
devres_release_group() all referring to the same long-lived device so the
group and the resources allocated inside it are torn down together.

Fixes: 911049845d70 ("EDAC, altera: Add Arria10 SD-MMC EDAC support")
Closes: https://sashiko.dev/#/patchset/20260503212558.2811480-1-dbgh9129%40gmail.com
Assisted-by: LLM
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260617164303.585555-1-dinguyen@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/edac/altera_edac.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 24bdf7f5bac63..a6e8e76c8abd5 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -1534,7 +1534,7 @@ static int altr_portb_setup(struct altr_edac_device_dev *device)
 	altdev = dci->pvt_info;
 	*altdev = *device;
 
-	if (!devres_open_group(&altdev->ddev, altr_portb_setup, GFP_KERNEL))
+	if (!devres_open_group(device->edac->dev, altr_portb_setup, GFP_KERNEL))
 		return -ENOMEM;
 
 	/* Update PortB specific values */
@@ -1562,7 +1562,7 @@ static int altr_portb_setup(struct altr_edac_device_dev *device)
 		rc = -ENODEV;
 		goto err_release_group_1;
 	}
-	rc = devm_request_irq(&altdev->ddev, altdev->sb_irq,
+	rc = devm_request_irq(device->edac->dev, altdev->sb_irq,
 			      prv->ecc_irq_handler, IRQF_TRIGGER_HIGH,
 			      ecc_name, altdev);
 	if (rc) {
@@ -1584,7 +1584,7 @@ static int altr_portb_setup(struct altr_edac_device_dev *device)
 			rc = -ENODEV;
 			goto err_release_group_1;
 		}
-		rc = devm_request_irq(&altdev->ddev, altdev->db_irq,
+		rc = devm_request_irq(device->edac->dev, altdev->db_irq,
 				      prv->ecc_irq_handler, IRQF_TRIGGER_HIGH,
 				      ecc_name, altdev);
 		if (rc) {
@@ -1604,13 +1604,13 @@ static int altr_portb_setup(struct altr_edac_device_dev *device)
 
 	list_add(&altdev->next, &altdev->edac->a10_ecc_devices);
 
-	devres_remove_group(&altdev->ddev, altr_portb_setup);
+	devres_remove_group(device->edac->dev, altr_portb_setup);
 
 	return 0;
 
 err_release_group_1:
 	edac_device_free_ctl_info(dci);
-	devres_release_group(&altdev->ddev, altr_portb_setup);
+	devres_release_group(device->edac->dev, altr_portb_setup);
 	edac_printk(KERN_ERR, EDAC_DEVICE,
 		    "%s:Error setting up EDAC device: %d\n", ecc_name, rc);
 	return rc;
-- 
2.53.0

