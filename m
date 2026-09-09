Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DC058E2DD;
	Wed,  9 Sep 2026 20:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788986638; cv=none; b=ji7wrzMiMXZlD5ZIV7n2tYibZpnXlxT4/F9uq+dg2OeBt7JPi58Z+rRWwsa2sdgCKLntbJqoJGMrMXJWBunug1MSfPJ7PdYn3Mvy+5tN8xbLawHTu3vt1+Ih9PLXVU1UBIGLLprzVNIBLd5zLV6/IEAJ5I8ljLs/TDLWLcs1QQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788986638; c=relaxed/simple;
	bh=uyGGb+CW6Vc9jO5EmaXZvSIoVm9BKWZ//WtO5OFHTNM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GYq04hGJpeayHfG7GJ/QV1rSbDaewrYS166MgqO7epmIoh39A8QikcQzlVzRnHu2UL+7jCB7UIHgvO/CbPN503nA1yHDGnKBKe9XL2cGPEVFHD96rjK6/O4KvI6l/cTuDeU2V6KW9Y0SBrgcBMcDmE8SEBfERzhZhOkC/cVN3C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z9iStpS3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9iStpS3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 700421F000FF;
	Wed,  9 Sep 2026 20:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788986620;
	bh=V8zoX1fp9KQk1O4dFnKt0cxxd93mdpBMrCbK4Z2nq88=;
	h=From:To:Cc:Subject:Date;
	b=Z9iStpS3l3CkcN0i85mKN3Q2OWqRk2JRhVo6QZ6RlX2guGhqUnNbHG9t6NnZbGdvu
	 GaAPg1Uaq4un0mviQk3r/r0kaVM0rvwV1GFitRVWiKlzuSRORT10/67K7XIOdjJjeV
	 gdZnBL5RpzwlVpZyVsH8+ghvtPG/u2+Q6Pf5sXKekndMIK6Iiwbj4UCCAs++oVfDGB
	 EbjThKyFgJ+djTEkyU3j/MXckQtnuiblwFN6WR+JRQ/j9kk4Unsp49ynu9iEuwwDrG
	 paK7mldggO7YGS/qxEb2Mo8WwAkRrH7KSy0LHwIBp/3AuXpGmfDseeWgvM/9L2BxBP
	 RSMLETYvB2JNw==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Brian Norris <computersforpeace@gmail.com>,
	Jeff Garzik <jgarzik@redhat.com>
Cc: stable@vger.kernel.org,
	linux-ide@vger.kernel.org
Subject: [PATCH v2] ata: libata: Do not leave ata_host_stop() registered when activation fails
Date: Wed,  9 Sep 2026 22:43:17 +0200
Message-ID: <20260909204317.5750-2-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8950; i=cassel@kernel.org; h=from:subject; bh=uyGGb+CW6Vc9jO5EmaXZvSIoVm9BKWZ//WtO5OFHTNM=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLIWHnnqIh+SNzN/h2HYdqbk1usWaQtrfTxl7T/bFS+a/ 4zToep9RykLgxgXg6yYIovvD5f9xd3uU44r3rGBmcPKBDKEgYtTACain8TI8Frk06MN7ZwNxguK qiIOvPT5GT5rVU/wloUbzoj/zzprfJHhn9rXSw2WvJfyuq5YrxKfzC63Zbu/4qRbEn6lWoWxgTE neQE=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

ata_host_start() registers ata_host_stop() as a devres action as soon as
it has succeeded, which hands the release of the host resources over to
devres: ->port_stop() and ->host_stop() are then called by the driver
core when probe() fails.

ata_host_activate(), ahci_host_activate_multi_irqs() and
ata_pci_sff_activate_host() can all fail after ata_host_start() has
succeeded, e.g. if devm_request_irq() or ata_host_register() fails, and
they return the error with the devres action still registered. A driver
which releases the host resources in its probe() error path therefore
releases them twice: once itself and once through ->host_stop().

All ahci-platform drivers are in that situation, e.g. ahci_probe() calls
ahci_platform_disable_resources() while ahci_host_stop() does the same
through devres. This gives refcount underflow warnings from the clk,
regulator and phy cores and, for shared resources, can disable resources
which are still in use by other devices.

Add ata_host_undo_start(), which stops the ports and drops the devres
action without calling ->host_stop(), and call it from the three
activation helpers when they fail. Releasing the host resources on
failure is then always left to the caller, which is what all callers
having a probe() error path already assume.

This changes the semantics for the drivers which implement ->host_stop()
while also completely lacking error handling for the activate host call.
Add activate host error handling for sata_qstor, sata_nv and sata_fsl.

Fixes: 1896b15eddb4 ("ahci_platform: perform platform exit in host_stop() hook")
Cc: stable@vger.kernel.org
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
Changes since v1:
-Add explicit call to ->host_stop() for those drivers that did not have
 proper error handling in probe().

 drivers/ata/libahci.c     | 13 ++++++--
 drivers/ata/libata-core.c | 69 +++++++++++++++++++++++++++++++++++----
 drivers/ata/libata-sff.c  |  6 ++--
 drivers/ata/sata_fsl.c    |  8 +++--
 drivers/ata/sata_nv.c     |  6 +++-
 drivers/ata/sata_qstor.c  |  8 +++--
 include/linux/libata.h    |  1 +
 7 files changed, 96 insertions(+), 15 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 6d72eb017b49..7ac1fcdd6d0d 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -2723,11 +2723,20 @@ static int ahci_host_activate_multi_irqs(struct ata_host *host,
 				0, pp->irq_desc, host->ports[i]);
 
 		if (rc)
-			return rc;
+			goto undo_start;
 		ata_port_desc_misc(host->ports[i], irq);
 	}
 
-	return ata_host_register(host, sht);
+	rc = ata_host_register(host, sht);
+	if (rc)
+		goto undo_start;
+
+	return 0;
+
+undo_start:
+	ata_host_undo_start(host);
+
+	return rc;
 }
 
 /**
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index f482c0a6d7e9..4e54cc8fd82a 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6127,6 +6127,46 @@ int ata_host_start(struct ata_host *host)
 }
 EXPORT_SYMBOL_GPL(ata_host_start);
 
+/**
+ *	ata_host_undo_start - undo ata_host_start()
+ *	@host: ATA host to undo_start
+ *
+ *	Stop the ports of @host and drop the devres action registered by
+ *	ata_host_start(), without calling ->host_stop().  Nothing is done if
+ *	@host has not been started.
+ *
+ *	This gives the release of the host resources back to the caller, which
+ *	is what a driver whose probe() error path releases those resources
+ *	itself needs when starting or activating the host fails.
+ *
+ *	LOCKING:
+ *	Inherited from calling layer (may sleep).
+ */
+void ata_host_undo_start(struct ata_host *host)
+{
+	int i;
+
+	if (!(host->flags & ATA_HOST_STARTED))
+		return;
+
+	for (i = 0; i < host->n_ports; i++) {
+		struct ata_port *ap = host->ports[i];
+
+		if (ap->ops->port_stop)
+			ap->ops->port_stop(ap);
+	}
+
+	/*
+	 * Drop the action added by ata_host_start() without calling it.
+	 * It does not exist if neither ->port_stop() nor ->host_stop() is
+	 * implemented, in which case there is nothing to drop.
+	 */
+	devres_destroy(host->dev, ata_host_stop, NULL, NULL);
+
+	host->flags &= ~ATA_HOST_STARTED;
+}
+EXPORT_SYMBOL_GPL(ata_host_undo_start);
+
 /**
  *	ata_host_init - Initialize a host struct for sas (ipr, libsas)
  *	@host:	host to initialize
@@ -6294,6 +6334,10 @@ EXPORT_SYMBOL_GPL(ata_host_register);
  *	have set polling mode on the port. In this case, @irq_handler
  *	should be NULL.
  *
+ *	On failure, the ports are stopped again and the devres action
+ *	registered by ata_host_start() is dropped without calling
+ *	->host_stop(), so releasing the host resources is left to the caller.
+ *
  *	LOCKING:
  *	Inherited from calling layer (may sleep).
  *
@@ -6314,27 +6358,40 @@ int ata_host_activate(struct ata_host *host, int irq,
 	/* Special case for polling mode */
 	if (!irq) {
 		WARN_ON(irq_handler);
-		return ata_host_register(host, sht);
+		rc = ata_host_register(host, sht);
+		if (rc)
+			goto undo_start;
+
+		return 0;
 	}
 
 	irq_desc = devm_kasprintf(host->dev, GFP_KERNEL, "%s[%s]",
 				  dev_driver_string(host->dev),
 				  dev_name(host->dev));
-	if (!irq_desc)
-		return -ENOMEM;
+	if (!irq_desc) {
+		rc = -ENOMEM;
+		goto undo_start;
+	}
 
 	rc = devm_request_irq(host->dev, irq, irq_handler, irq_flags,
 			      irq_desc, host);
 	if (rc)
-		return rc;
+		goto undo_start;
 
 	for (i = 0; i < host->n_ports; i++)
 		ata_port_desc_misc(host->ports[i], irq);
 
 	rc = ata_host_register(host, sht);
-	/* if failed, just free the IRQ and leave ports alone */
-	if (rc)
+	if (rc) {
+		/* if failed, just free the IRQ and leave ports alone */
 		devm_free_irq(host->dev, irq, host);
+		goto undo_start;
+	}
+
+	return 0;
+
+undo_start:
+	ata_host_undo_start(host);
 
 	return rc;
 }
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 976e4e160494..02a43b5368ef 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -2348,10 +2348,12 @@ int ata_pci_sff_activate_host(struct ata_host *host,
 
 	rc = ata_host_register(host, sht);
 out:
-	if (rc == 0)
+	if (rc == 0) {
 		devres_remove_group(dev, NULL);
-	else
+	} else {
 		devres_release_group(dev, NULL);
+		ata_host_undo_start(host);
+	}
 
 	return rc;
 }
diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index 70b210afd291..299b2c886cbe 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -1490,8 +1490,12 @@ static int sata_fsl_probe(struct platform_device *ofdev)
 	 * device discovery process, invoking our port_start() handler &
 	 * error_handler() to execute a dummy Softreset EH session
 	 */
-	ata_host_activate(host, irq, sata_fsl_interrupt, SATA_FSL_IRQ_FLAG,
-			  &sata_fsl_sht);
+	retval = ata_host_activate(host, irq, sata_fsl_interrupt,
+				   SATA_FSL_IRQ_FLAG, &sata_fsl_sht);
+	if (retval) {
+		sata_fsl_host_stop(host);
+		return retval;
+	}
 
 	host_priv->intr_coalescing.show = fsl_sata_intr_coalescing_show;
 	host_priv->intr_coalescing.store = fsl_sata_intr_coalescing_store;
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index 8624cd4e88cc..29ec216e7803 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -2415,7 +2415,11 @@ static int nv_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 
 	pci_set_master(pdev);
-	return ata_pci_sff_activate_host(host, ipriv->irq_handler, ipriv->sht);
+	rc = ata_pci_sff_activate_host(host, ipriv->irq_handler, ipriv->sht);
+	if (rc && host->ops->host_stop)
+		host->ops->host_stop(host);
+
+	return rc;
 }
 
 #ifdef CONFIG_PM_SLEEP
diff --git a/drivers/ata/sata_qstor.c b/drivers/ata/sata_qstor.c
index 4e7f5b2ff3f6..f38310b84f51 100644
--- a/drivers/ata/sata_qstor.c
+++ b/drivers/ata/sata_qstor.c
@@ -584,8 +584,12 @@ static int qs_ata_init_one(struct pci_dev *pdev,
 	qs_host_init(host, board_idx);
 
 	pci_set_master(pdev);
-	return ata_host_activate(host, pdev->irq, qs_intr, IRQF_SHARED,
-				 &qs_ata_sht);
+	rc = ata_host_activate(host, pdev->irq, qs_intr, IRQF_SHARED,
+			       &qs_ata_sht);
+	if (rc)
+		qs_host_stop(host);
+
+	return rc;
 }
 
 module_pci_driver(qs_ata_pci_driver);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 313e96173b19..b1debcef4947 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1147,6 +1147,7 @@ extern struct ata_host *ata_host_alloc_pinfo(struct device *dev,
 extern void ata_host_get(struct ata_host *host);
 extern void ata_host_put(struct ata_host *host);
 extern int ata_host_start(struct ata_host *host);
+extern void ata_host_undo_start(struct ata_host *host);
 extern int ata_host_register(struct ata_host *host,
 			     const struct scsi_host_template *sht);
 extern int ata_host_activate(struct ata_host *host, int irq,
-- 
2.55.0

