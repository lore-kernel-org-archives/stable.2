Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7514A8434
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 18:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789582343; cv=none; b=A9wmBoriwjJeYCb96cQ/4koeNi1EPM/Z9aglclXNnNhiQK6LfhuBZcWFnAIXGj0MHFFq+Ar73A/dK1AMblR+MgCLeTaRw2wj/qtWbldW9U7p1R9oVT107rkzjj1fYpvpdb22+5fODlcFNzCL7t/6b1NqeSct67Kfl3q7RLR50d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789582343; c=relaxed/simple;
	bh=v0HdpNCc97OvhSMMlxV7VXbk4n6QD5roDa6rFzlDSDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uNYRv5CRjUVAP24+0l8M4oKlqMHLH9j3JzidZdFt42gOooapbosNnqTdC/3eo4bz3M+8WbX20wcsPRbniQqtgOSfdv/YZv/ru3Ytle+3puK2Uul74FSijrLaRlgT76LSOcukMV2xuKawxcpvRavAjV1LsgjXCGaKX1pUf462RsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PqKN7v96; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PqKN7v96"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 444B21F000FF;
	Wed, 16 Sep 2026 18:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789582328;
	bh=Po6NCmgBi+d6s1BLp4aP7lX8HuzjG0PgUflLmfdWJ7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PqKN7v96OjB05cIw5pr+fgFQynSMl5mMqXCDWkqzK6Gq2TBmmQzsFkL4GQTok+H1Y
	 dKRZdbJaWTMURmEwxMuCWaQCEqr4CrsheFk5KAag+vkMO3+RzFiOiMQFleMTNm6u/H
	 3JQ3JCGyp3QWVuZ9Hwa7Ri4rt+Q+8YMl1+8IKkHfAIRnKamvoDPLpUECfQtcaHmmHb
	 kwOW3mXoOu4fx1RCRuDcgnT6RRrVyx7Lugs9JxBhv2luqQKWy3ptMfNeaFKfhTN9rp
	 tRL2/ah6tnmm2RjyiWbNRup71vUpdT4SBhS9aqVA5f/HWjhEes7NTsSWOgZIB3QL1Z
	 dXXwgqw1aKP7g==
From: Dinh Nguyen <dinguyen@kernel.org>
To: stable@vger.kernel.org
Cc: Dinh Nguyen <dinguyen@kernel.org>,
	Borislav Petkov <bp@alien8.de>
Subject: [PATCH 7.2.y] EDAC/altera: Use parent device for devres in altr_portb_setup()
Date: Wed, 16 Sep 2026 13:11:56 -0500
Message-ID: <20260916181156.365125-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.42.0.411.g813d9a9188
In-Reply-To: <2026091617-provoke-cupcake-11e7@gregkh>
References: <2026091617-provoke-cupcake-11e7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Anchor the devres group and the devm-managed IRQ requests in altr_portb_setup()
to the actual parent device (device->edac->dev) instead of the embedded struct
device inside the copied per-port altr_edac_device_dev.

This keeps devres_open_group(), devm_request_irq(), devres_remove_group() and
devres_release_group() all referring to the same long-lived device so the
group and the resources allocated inside it are torn down together.

Fixes: 911049845d70 ("EDAC, altera: Add Arria10 SD-MMC EDAC support")
Closes: https://sashiko.dev/#/patchset/20260503212558.2811480-1-dbgh9129%40gmail.com
Assisted-by: LLM
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260617164303.585555-1-dinguyen@kernel.org
(cherry picked from commit 9868f5c077dfe0b606331f2e782484f91a5789a5)
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 drivers/edac/altera_edac.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 4edd2088c2db6..5914b2fd94d9c 100644
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

