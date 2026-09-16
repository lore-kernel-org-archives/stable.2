Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AE543D4E0
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 19:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789588463; cv=none; b=HGasZ4flWP0h7VtlGZEuJD/T0S96YVs4RXGWT1amHhFXLj5oslFx/oECTwtElhyoZQt34qKcEc9ig21YkUiyScTYb1PSdPzLYT8Vvxe01pnDLlff9yWM6UImtWHIVwU408EEf58m8B+tCOvfAs0Xwx5KOOHtg4mDkA0AFAuu984=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789588463; c=relaxed/simple;
	bh=PdGECkHXiSq4G6lDId2VFtkw9Kb/gmM2kxD/z1YhTbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nFklaPDCdODeIZUZK7Vo9k6eZvs2FXgDuajpGIqXysvaaRlpOtMxr17atsdamXFGz6W08DzAUcDQPeS6nIbF2q7q8uXgj05Ha7O2NnXABBipHo7XA2JLyB7dizXCLZSXHoN57sc7OSvwKUS23agnyAo/DQP3myUwN7ScqnhHXgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6xLD0WB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6xLD0WB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2330E1F00899;
	Wed, 16 Sep 2026 19:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789588451;
	bh=GiliyydNWVjFq6EKr4vXHTtCsDL1uHaqxOIVAcAfzDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K6xLD0WBe7Bk4xQsn/KBJK1TVX+FhTNYUb7R7bIpadvjBfEmq1VYubXAasopCHKbn
	 jQqbvGLn2yHgbivj9KUby54IJ8f2vHRvtuzpQxNZWF4HL+MiItfPIF6XN/+GnXuvCp
	 6JDeGqpFO8P6pkOrVU5khATLKhZL+h8TIEOQsBD6dvBMcRINd4wTnOaEKLv8wJZ7h4
	 JxoLABgEXQcgrxrVb0AJWkZLJooBA7WpdQ0nxQBL2Jdksq2VKimyHp3QQI0EOIpKfA
	 PLuEFRexFe7zbU/sVIMLO0tDkhY9+Ows3ybgN6SXPQCRCj5fzAKmTWP5iejgdIMUOD
	 bft3dpnPE6FIw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dinh Nguyen <dinguyen@kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] EDAC/altera: Use parent device for devres in altr_portb_setup()
Date: Wed, 16 Sep 2026 15:54:08 -0400
Message-ID: <20260916195408.2446251-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916195408.2446251-1-sashal@kernel.org>
References: <2026091623-undoing-ruckus-ed73@gregkh>
 <20260916195408.2446251-1-sashal@kernel.org>
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
index ca20da2a52e65..af964be00a5d6 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -1506,7 +1506,7 @@ static int altr_portb_setup(struct altr_edac_device_dev *device)
 	altdev = dci->pvt_info;
 	*altdev = *device;
 
-	if (!devres_open_group(&altdev->ddev, altr_portb_setup, GFP_KERNEL))
+	if (!devres_open_group(device->edac->dev, altr_portb_setup, GFP_KERNEL))
 		return -ENOMEM;
 
 	/* Update PortB specific values */
@@ -1534,7 +1534,7 @@ static int altr_portb_setup(struct altr_edac_device_dev *device)
 		rc = -ENODEV;
 		goto err_release_group_1;
 	}
-	rc = devm_request_irq(&altdev->ddev, altdev->sb_irq,
+	rc = devm_request_irq(device->edac->dev, altdev->sb_irq,
 			      prv->ecc_irq_handler, IRQF_TRIGGER_HIGH,
 			      ecc_name, altdev);
 	if (rc) {
@@ -1556,7 +1556,7 @@ static int altr_portb_setup(struct altr_edac_device_dev *device)
 			rc = -ENODEV;
 			goto err_release_group_1;
 		}
-		rc = devm_request_irq(&altdev->ddev, altdev->db_irq,
+		rc = devm_request_irq(device->edac->dev, altdev->db_irq,
 				      prv->ecc_irq_handler, IRQF_TRIGGER_HIGH,
 				      ecc_name, altdev);
 		if (rc) {
@@ -1576,13 +1576,13 @@ static int altr_portb_setup(struct altr_edac_device_dev *device)
 
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

