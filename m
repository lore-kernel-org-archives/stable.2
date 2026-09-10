Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4FA4FB9C9;
	Thu, 10 Sep 2026 17:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789060520; cv=none; b=ho1ZP9Q2evzDRIR1skz6HGMWIsD7mhVqvqlPBkBn2IE89rcQaOHpvGx9jimuCv2r2Ms8aItlaiZcD2+66VEXZLq3k/CGcfk+3w2ckt+8SOAO3+U7w6U6dWXSgXO65+CibvRVWpQu5ZzaX1OOg9p2NIZsvuBPqhvJYeNteCDogik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789060520; c=relaxed/simple;
	bh=bWVX+HOCLX0kUspc51L/gZEHeXThNjom5TIK/2K4YvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cxF5pUTB+WytG+Z/assz+QwpVQY9uraxdgKzgfomdKQRo3ryTpxrgjPXMwgF4f7UKLlQEEqisONGc2lGeNJEviLLb8tkt1Any2l6j/JV7SyGwEgWyxmoJgF7Z7DPXi8YLVD57UC3zeZDu092vMPqkFeppf2qx2gbpDLONRo0VHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AlWuIsuy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AlWuIsuy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CEF61F0089B;
	Thu, 10 Sep 2026 17:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789060497;
	bh=uRV8T6Hbl0gquIWNG17DAOPAJ6+RNRXwwTBX8PaDtmw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AlWuIsuyDb7hE3G3y6kXyJU5c5QD1r0AoqkvKBdsGZ8LWUc42HutN1EdlznQp0zZt
	 fww/QZ9C/vcYSXy31A7naIK13eO+p6uhvUJOSO8n815fNI9aYPTdIAPEPAEvco3yBl
	 mnRj4kRitgkpRVsGMiG/xwSD+p+f1PZHrOQsC7bkl9wvIK9cpVCUCtf9GyNZCtKUXe
	 XjplOat8d2ghYkE01i2gA2Ni+nZ8ChCAcyCqAH/C/Fg25kOxDMXB/s9O1NGRVOCwBL
	 fEC+KXYLNekvcuA1hO7OQSsNTL4FtjE82mWQgGQ+Y/UaZsxbG8PqMx4Y2lhQKKQE06
	 onT8s+BGuR9tg==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	Jeff Garzik <jgarzik@redhat.com>,
	Brian Norris <computersforpeace@gmail.com>
Cc: stable@vger.kernel.org,
	linux-ide@vger.kernel.org
Subject: [PATCH v4 4/5] ata: libata: Do not leave ata_host_stop() registered when activation fails
Date: Thu, 10 Sep 2026 19:14:10 +0200
Message-ID: <20260910171406.131211-11-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910171406.131211-7-cassel@kernel.org>
References: <20260910171406.131211-7-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9479; i=cassel@kernel.org; h=from:subject; bh=bWVX+HOCLX0kUspc51L/gZEHeXThNjom5TIK/2K4YvQ=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLIWPc0SWNPaGvMpZd4Mc6UFX4sM85h2O9ayzpW/MP/rH KXu0g++HaUsDGJcDLJiiiy+P1z2F3e7TzmueMcGZg4rE8gQBi5OAZjInsWMDF1fH4hOZpri0NmS XbykPfb3tS2fcv/WMgR4vz6ykP8kazIjw63Klz+mWWVpfVpis2qy6eq1V0Pl5I+/UVW+v2Nircj yMywA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

ata_host_start() registers ata_host_stop() as a devres action as soon as
it has succeeded, which hands the release of the host resources over to
devres: ->port_stop() and ->host_stop() are then called by the driver
core when probe() fails.

ata_host_activate() and ahci_host_activate_multi_irqs() can both fail
after ata_host_start() has succeeded, e.g. if devm_request_irq() or
ata_host_register() fails, and they return the error with the devres
action still registered. A driver which releases the host resources in
its probe() error path therefore releases them twice: once itself and
once through ->host_stop().

All ahci-platform drivers are in that situation, e.g. ahci_probe() calls
ahci_platform_disable_resources() while ahci_host_stop() does the same
through devres. This gives refcount underflow warnings from the clk,
regulator and phy cores and, for shared resources, can disable resources
which are still in use by other devices.

Add ata_host_undo_start(), which stops the ports and drops the devres
action without calling ->host_stop(), and call it from both activation
helpers when they fail. Releasing the host resources on failure is then
always left to the caller, which is what all callers having a probe()
error path already assume.

This changes the semantics for the drivers which implement ->host_stop()
while also completely lacking error handling for the activate host call.
Add activate host error handling for sata_qstor and sata_fsl.

Note that ata_pci_sff_activate_host() is deliberately left as is: none of
its callers releases the host resources in its probe() error path, they
all rely on ->host_stop() being called by devres, including
ata_pci_init_one(), which releases the devres group of the host itself.

Fixes: 1896b15eddb4 ("ahci_platform: perform platform exit in host_stop() hook")
Cc: stable@vger.kernel.org
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libahci.c          |  2 +
 drivers/ata/libahci_platform.c |  4 ++
 drivers/ata/libata-core.c      | 75 +++++++++++++++++++++++++++++++---
 drivers/ata/libata-sff.c       |  5 +++
 drivers/ata/sata_fsl.c         |  2 +-
 drivers/ata/sata_qstor.c       |  8 +++-
 include/linux/libata.h         |  1 +
 7 files changed, 88 insertions(+), 9 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 9f479daa89b0..27d1b2197868 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -2749,6 +2749,8 @@ static int ahci_host_activate_multi_irqs(struct ata_host *host,
 			      host->ports[i]);
 	}
 
+	ata_host_undo_start(host);
+
 	return rc;
 }
 
diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index 6e072d681341..b44c0db4a86e 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -689,6 +689,10 @@ EXPORT_SYMBOL_GPL(ahci_platform_get_resources);
  * ahci-platform host, note any necessary resources (ie clks, phys, etc.)
  * must be initialized / enabled before calling this.
  *
+ * On failure, ->host_stop() is not called, so the caller has to release the
+ * resources it enabled (clocks, regulators, resets, PHYs) in its probe()
+ * error path.
+ *
  * RETURNS:
  * 0 on success otherwise a negative error code
  */
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index f482c0a6d7e9..197f5d6e93ce 100644
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
@@ -6201,6 +6241,12 @@ static void async_port_probe(void *data, async_cookie_t cookie)
  *	starts ports, registers @host with ATA and SCSI layers and
  *	probe registered devices.
  *
+ *	On failure, the host remains started, i.e. the devres action
+ *	registered by ata_host_start() is kept, so ->host_stop() is called by
+ *	the driver core when probe() fails.  A caller which releases the host
+ *	resources in its own probe() error path must therefore call
+ *	ata_host_undo_start().
+ *
  *	LOCKING:
  *	Inherited from calling layer (may sleep).
  *
@@ -6294,6 +6340,10 @@ EXPORT_SYMBOL_GPL(ata_host_register);
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
@@ -6314,27 +6364,40 @@ int ata_host_activate(struct ata_host *host, int irq,
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
+		/* Free the IRQ, so that the handler can no longer run */
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
index 976e4e160494..d5ef0338735c 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -2267,6 +2267,11 @@ EXPORT_SYMBOL_GPL(ata_pci_sff_prepare_host);
  *	hosts.  This separate helper is necessary because SFF hosts
  *	use two separate interrupts in legacy mode.
  *
+ *	Note that, unlike ata_host_activate(), the devres action registered
+ *	by ata_host_start() is kept on failure, i.e. ->host_stop() is called
+ *	by the driver core when probe() fails.  All callers of this function
+ *	rely on that, none of them releases the host resources itself.
+ *
  *	LOCKING:
  *	Inherited from calling layer (may sleep).
  *
diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index 2123da66dc3c..2141a2189b5e 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -1493,7 +1493,7 @@ static int sata_fsl_probe(struct platform_device *ofdev)
 	retval = ata_host_activate(host, irq, sata_fsl_interrupt,
 				   SATA_FSL_IRQ_FLAG, &sata_fsl_sht);
 	if (retval)
-		return retval;
+		goto error_exit_with_cleanup;
 
 	host_priv->intr_coalescing.show = fsl_sata_intr_coalescing_show;
 	host_priv->intr_coalescing.store = fsl_sata_intr_coalescing_store;
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

