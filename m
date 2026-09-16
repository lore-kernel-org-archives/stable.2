Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BCF3EC827
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 19:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789587276; cv=none; b=L6XOToP2jYN0K+aBIefA4TRga8tTZIKjjKzUj4YeV425nJkqk+LQ+/dvSb9c9psSgvpY3qeGlBIS6vL9KBGtg/DFFL0hpCfAKfZHorJ/ZK9sDCEFo7l9sOJvPpK2xBe2wIId8JrjzkLvm/BhMwX22ES7T7AQJ6x3mjvEOEXdN9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789587276; c=relaxed/simple;
	bh=y539q5HhUctmuI5oWcvsyIlGGQso7Vrl9fQ8VzOxbSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pXhgkdykgeNE22HMl50KYJNa27r5FIwQXQggYbzrnTPdWF0PQgjWjIcaGxvujo+wGYycrDknZGk7cxIJnat2cwpnpR8jiyReEbbT6TVw8YwXpptVTJn+djOWc97c1TX/oLfRnV+31hvGL9KlfPBMZAp/OUy8k35hbzqMY5ZKZPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWsViqur; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWsViqur"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E79131F000FF;
	Wed, 16 Sep 2026 19:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789587261;
	bh=2lDqUAO50raiPpmwiXj3FaYCru7WeeBV15k9z2fHfFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GWsViqurn53KR0EGwQCeBiyx3Kf5Mj/+ljFC+YKIlrjCNoBkK9u9CErLP7uPMp6+7
	 tIs2iOI92dklmOphiL1qrNmEd6bjssw3m3JjHa3rAbX9V+OS7ByIkcyuBH7sKbYK76
	 0eTnqs03qZU3ZVtqs30W9pCKYBqF1rj+RLIxK9/Sb9GdQaDgCQT7rVOPZ+wS0sWnrO
	 nxYBNZc2Sgj593vhcEcaIWMNYe5868ZWWUSseYg50/NF4IQZM8ILGQYo8KEvU2k+WT
	 WiEgZGMN7/5zIDWgsvRpNUmywpbU1QhawGmgKwpqxHdkz7pHQiOaS+lSbFXfkDm3OG
	 mvduWtkWtT7aw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Rounak Das <rounakdas2025@gmail.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] EDAC/altera: Use ECC manager compatible to select A10/S10 IRQ layout
Date: Wed, 16 Sep 2026 15:34:18 -0400
Message-ID: <20260916193419.2305184-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091618-scruffy-brownnose-a686@gregkh>
References: <2026091618-scruffy-brownnose-a686@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rounak Das <rounakdas2025@gmail.com>

[ Upstream commit d4486fc3098e176cb4a29fee037216484761f9ca ]

The SDMMC ECC IRQ layout selection uses CONFIG_64BIT to distinguish between
Arria10 and Stratix10 paths.

Detect the SoC once at probe via the device match table (.data) store it in
struct altr_arria10_edac, and use it instead of CONFIG_64BIT.

This keeps the decision correct for every ECC child device (OCRAM, SD/MMC,
etc.) and avoids any runtime compatible lookup.

Signed-off-by: Rounak Das <rounakdas2025@gmail.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Dinh Nguyen <dinguyen@kernel.org>
Link: https://patch.msgid.link/20260708091135.94114-2-rounakdas2025@gmail.com
Stable-dep-of: 9868f5c077df ("EDAC/altera: Use parent device for devres in altr_portb_setup()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/edac/altera_edac.c | 107 +++++++++++++++++++------------------
 drivers/edac/altera_edac.h |   1 +
 2 files changed, 55 insertions(+), 53 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 4edd2088c2db6..24bdf7f5bac63 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -1507,6 +1507,7 @@ static int altr_portb_setup(struct altr_edac_device_dev *device)
 	int edac_idx, rc;
 	struct device_node *np;
 	const struct edac_device_prv_data *prv = &a10_sdmmceccb_data;
+	bool is_s10 = device->edac->is_s10;
 
 	rc = altr_check_ecc_deps(device);
 	if (rc)
@@ -1548,15 +1549,14 @@ static int altr_portb_setup(struct altr_edac_device_dev *device)
 
 	/*
 	 * Update the PortB IRQs - A10 has 4, S10 has 2, Index accordingly
-	 *
-	 * FIXME: Instead of ifdefs with different architectures the driver
-	 *        should properly use compatibles.
 	 */
-#ifdef CONFIG_64BIT
-	altdev->sb_irq = irq_of_parse_and_map(np, 1);
-#else
-	altdev->sb_irq = irq_of_parse_and_map(np, 2);
-#endif
+
+	/* Using compatibles to determine the IRQ Index */
+	if (is_s10)
+		altdev->sb_irq = irq_of_parse_and_map(np, 1);
+	else
+		altdev->sb_irq = irq_of_parse_and_map(np, 2);
+
 	if (!altdev->sb_irq) {
 		edac_printk(KERN_ERR, EDAC_DEVICE, "Error PortB SBIRQ alloc\n");
 		rc = -ENODEV;
@@ -1570,29 +1570,28 @@ static int altr_portb_setup(struct altr_edac_device_dev *device)
 		goto err_release_group_1;
 	}
 
-#ifdef CONFIG_64BIT
-	/* Use IRQ to determine SError origin instead of assigning IRQ */
-	rc = of_property_read_u32_index(np, "interrupts", 1, &altdev->db_irq);
-	if (rc) {
-		edac_printk(KERN_ERR, EDAC_DEVICE,
-			    "Error PortB DBIRQ alloc\n");
-		goto err_release_group_1;
-	}
-#else
-	altdev->db_irq = irq_of_parse_and_map(np, 3);
-	if (!altdev->db_irq) {
-		edac_printk(KERN_ERR, EDAC_DEVICE, "Error PortB DBIRQ alloc\n");
-		rc = -ENODEV;
-		goto err_release_group_1;
-	}
-	rc = devm_request_irq(&altdev->ddev, altdev->db_irq,
-			      prv->ecc_irq_handler, IRQF_TRIGGER_HIGH,
-			      ecc_name, altdev);
-	if (rc) {
-		edac_printk(KERN_ERR, EDAC_DEVICE, "PortB DBERR IRQ error\n");
-		goto err_release_group_1;
+	if (is_s10) {
+		/* Use IRQ to determine SError origin instead of assigning IRQ */
+		rc = of_property_read_u32_index(np, "interrupts", 1, &altdev->db_irq);
+		if (rc) {
+			edac_printk(KERN_ERR, EDAC_DEVICE, "Error PortB DBIRQ alloc\n");
+			goto err_release_group_1;
+		}
+	} else {
+		altdev->db_irq = irq_of_parse_and_map(np, 3);
+		if (!altdev->db_irq) {
+			edac_printk(KERN_ERR, EDAC_DEVICE, "Error PortB DBIRQ alloc\n");
+			rc = -ENODEV;
+			goto err_release_group_1;
+		}
+		rc = devm_request_irq(&altdev->ddev, altdev->db_irq,
+				      prv->ecc_irq_handler, IRQF_TRIGGER_HIGH,
+				      ecc_name, altdev);
+		if (rc) {
+			edac_printk(KERN_ERR, EDAC_DEVICE, "PortB DBERR IRQ error\n");
+			goto err_release_group_1;
+		}
 	}
-#endif
 
 	rc = edac_device_add_device(dci);
 	if (rc) {
@@ -1974,29 +1973,29 @@ static int altr_edac_a10_device_add(struct altr_arria10_edac *edac,
 		goto err_release_group1;
 	}
 
-#ifdef CONFIG_64BIT
-	/* Use IRQ to determine SError origin instead of assigning IRQ */
-	rc = of_property_read_u32_index(np, "interrupts", 0, &altdev->db_irq);
-	if (rc) {
-		edac_printk(KERN_ERR, EDAC_DEVICE,
-			    "Unable to parse DB IRQ index\n");
-		goto err_release_group1;
-	}
-#else
-	altdev->db_irq = irq_of_parse_and_map(np, 1);
-	if (!altdev->db_irq) {
-		edac_printk(KERN_ERR, EDAC_DEVICE, "Error allocating DBIRQ\n");
-		rc = -ENODEV;
-		goto err_release_group1;
-	}
-	rc = devm_request_irq(edac->dev, altdev->db_irq, prv->ecc_irq_handler,
-			      IRQF_TRIGGER_HIGH,
-			      ecc_name, altdev);
-	if (rc) {
-		edac_printk(KERN_ERR, EDAC_DEVICE, "No DBERR IRQ resource\n");
-		goto err_release_group1;
+	if (edac->is_s10) {
+		/* Use IRQ to determine SError origin instead of assigning IRQ */
+		rc = of_property_read_u32_index(np, "interrupts", 0, &altdev->db_irq);
+		if (rc) {
+			edac_printk(KERN_ERR, EDAC_DEVICE,
+				    "Unable to parse DB IRQ index\n");
+			goto err_release_group1;
+		}
+	} else {
+		altdev->db_irq = irq_of_parse_and_map(np, 1);
+		if (!altdev->db_irq) {
+			edac_printk(KERN_ERR, EDAC_DEVICE, "Error allocating DBIRQ\n");
+			rc = -ENODEV;
+			goto err_release_group1;
+		}
+		rc = devm_request_irq(edac->dev, altdev->db_irq, prv->ecc_irq_handler,
+				      IRQF_TRIGGER_HIGH,
+				      ecc_name, altdev);
+		if (rc) {
+			edac_printk(KERN_ERR, EDAC_DEVICE, "No DBERR IRQ resource\n");
+			goto err_release_group1;
+		}
 	}
-#endif
 
 	rc = edac_device_add_device(dci);
 	if (rc) {
@@ -2122,6 +2121,8 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, edac);
 	INIT_LIST_HEAD(&edac->a10_ecc_devices);
 
+	edac->is_s10 = !!device_get_match_data(&pdev->dev);
+
 	edac->ecc_mgr_map =
 		altr_sysmgr_regmap_lookup_by_phandle(pdev->dev.of_node,
 						     "altr,sysmgr-syscon");
@@ -2207,7 +2208,7 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
 
 static const struct of_device_id altr_edac_a10_of_match[] = {
 	{ .compatible = "altr,socfpga-a10-ecc-manager" },
-	{ .compatible = "altr,socfpga-s10-ecc-manager" },
+	{ .compatible = "altr,socfpga-s10-ecc-manager", .data = (void *)1 },
 	{},
 };
 MODULE_DEVICE_TABLE(of, altr_edac_a10_of_match);
diff --git a/drivers/edac/altera_edac.h b/drivers/edac/altera_edac.h
index 7248d24c4908d..5b26ef0cfe600 100644
--- a/drivers/edac/altera_edac.h
+++ b/drivers/edac/altera_edac.h
@@ -395,6 +395,7 @@ struct altr_arria10_edac {
 	struct irq_chip		irq_chip;
 	struct list_head	a10_ecc_devices;
 	struct notifier_block	panic_notifier;
+	bool is_s10;
 };
 
 #endif	/* #ifndef _ALTERA_EDAC_H */
-- 
2.53.0

