Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2088444CADF;
	Wed, 17 Jun 2026 16:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781714605; cv=none; b=TIVTZqP5xJZpUg6gWQnZAr1BePR0EJNQysf79BeUFnc4N2/e697oOc3itcCWUxMjFYWTy1W6zK9GiEgtuIajmm65q/5rmakeBRMblAtmgfb72vjKXNxDkzFhCUy0Jp6pM+8ft7/4EETk8voB3AvuDv74SW452KUzCX/fnZsUGn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781714605; c=relaxed/simple;
	bh=XutTQBdwrTCAX8gC7dBmWVDXGhZkom9HxGluN1rN/Rs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LoC3HfsfOJY7d8j+H7lAiFJMOI68DXsE0BFHu/nPqapFE7wfiODvcn98seob5X229JiMfboAwzH5+Rotr8FeBH9hmM5SIAKGcLpqj59em9tqOOjAIwxWM85u/iQyIE6EF8mpjOQyw/lAn0c1OVJnf9625RZXg1kzep/bJYu9EXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cbIzmMFb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cbIzmMFb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01E581F00A3A;
	Wed, 17 Jun 2026 16:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781714603;
	bh=KNmSwsg0gZTKvDNis5tgxyQ5iNCbMv/g9fJ24kqEAco=;
	h=From:To:Cc:Subject:Date;
	b=cbIzmMFbOfJsgrMm5Zwfw2IrFIBtOo6RfvjaMYiZOEZb0mGGIlFq5oJrljinqyM3Q
	 oD4knC1D3USr5PrjhwKDE4ALrOmvV+coR2YsjMRfCD6HnoZG05aRvau8KUbzRyvjw0
	 XOhSelBmYGthZ1RYMsgpEdoibmCPg4AGsxxhIBlS1ve64p+wlhOdlOyc5k63qTbM9y
	 P0aTpFwQdGUKuCWUWF/eDPhzBl9BT9FTo0ECXspwe02R815QiCdxACaXe2sqhq/pYj
	 /SiHK2Tkw/6Vak7xO4QuyGn76mBMoTXOoiHZB4ZZbauux5Q7SuGFkpAbxR2FClQZW/
	 tWXvFiPH+K5YQ==
From: Dinh Nguyen <dinguyen@kernel.org>
To: bp@alien8.de,
	tony.luck@intel.com
Cc: dinguyen@kernel.org,
	dbgh9129@gmail.com,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] EDAC/altera: Use parent device for devres in altr_portb_setup()
Date: Wed, 17 Jun 2026 11:43:03 -0500
Message-ID: <20260617164303.585555-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.42.0.411.g813d9a9188
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Anchor the devres group and the devm-managed IRQ requests in
altr_portb_setup() to the actual parent device (device->edac->dev)
instead of the embedded struct device inside the copied per-port
altr_edac_device_dev. This keeps devres_open_group(),
devm_request_irq(), devres_remove_group() and devres_release_group()
all referring to the same long-lived device so the group and the
resources allocated inside it are torn down together.

Fixes: 911049845d70 ("EDAC, altera: Add Arria10 SD-MMC EDAC support")
Cc: stable@vger.kernel.org
Closes: https://sashiko.dev/#/patchset/20260503212558.2811480-1-dbgh9129%40gmail.com
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 drivers/edac/altera_edac.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 4edd2088c2db..5914b2fd94d9 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -1533,7 +1533,7 @@ static int altr_portb_setup(struct altr_edac_device_dev *device)
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
@@ -1585,7 +1585,7 @@ static int altr_portb_setup(struct altr_edac_device_dev *device)
 		rc = -ENODEV;
 		goto err_release_group_1;
 	}
-	rc = devm_request_irq(&altdev->ddev, altdev->db_irq,
+	rc = devm_request_irq(device->edac->dev, altdev->db_irq,
 			      prv->ecc_irq_handler, IRQF_TRIGGER_HIGH,
 			      ecc_name, altdev);
 	if (rc) {
@@ -1605,13 +1605,13 @@ static int altr_portb_setup(struct altr_edac_device_dev *device)
 
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
2.42.0.411.g813d9a9188

