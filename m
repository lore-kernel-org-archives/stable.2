Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794371896;
	b=x2q9iygL6LXdmqrOHuniTiGdpsV+/ha0ICZ3TQwn5VSb1OEzY9WEIcswBTki2WGeNC2g
	 a5pzIPWdaE1QiJ4a7vQ2NHQXSpePfDMU2ptokX6Egdt0SLhe1g3sGd0ztF+O1xi1z0j7U
	 vF1oLqI6BEDC+0eTCC2coVdwO17Fo92Pqhr/v3YUedKICchQ0zvZToV0xA51vP9gB6vPd
	 /rA4VwaiQCWU6YdI9KK1PWMs7eNsKr/psQ+4vjZMjW5cNl+OCSSKkgcRfy/unCaIrMxSP
	 4VFBXh3/cLeLwqy4jo9NViUkVUNrB7j3iEBIfS3uKOrqU/AesLCj75lrMUUYuapnfKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794371896;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=AvwRTrnwLFU3ZuF54BCv85wjliF2BDyugZPV2QkcqrU=;
	b=YZvfqRtnOg044Phw06u4ees/ljsgO4BJDNyvt24qfKa5gLwyjgYQHI1bfHtTY90elUf1
	 9ww+mUctVv4+Xy9Cfwc/m+IO0D2qk9/dH0WzZWyV32KTQgXACnKd4EgpLHNvlRQXsfDIk
	 NncZSQ4ZLL3gmUIoQ2/G7bYv8ylfHguvu8WaZfoRwyMC9d6zU9vXFov3ofbWuaijuSCBF
	 03pRnOAg2wpw70KWvmm4cHmBq/OHxQ5sa8tEaxeMR4NYYgpL+ja5IZBdw13mALjD9wS6Q
	 HKEatf+ioW6hoIqhgfyeyVYQF/Ob/O6PRyhtvdsXwZwl8qBYRTNGu6G0O0Wi4mSFN4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BSZKwrN+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AA7606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 04:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BSZKwrN+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC9D41F0089F;
	Wed, 11 Nov 2026 04:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794371896;
	bh=AvwRTrnwLFU3ZuF54BCv85wjliF2BDyugZPV2QkcqrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BSZKwrN+Zu+uhW3EQRjM6ARp6TvOxyvyyMuD/ekOqrqo+2ybcaIHcft4Prn3awaRj
	 iS8PY2vSdgaFLun2RBZ5esZp34kRqe+rELlR6DVKDGggW0+R4ckI/UmTUsKa9PHIEd
	 hFHYQ6e+TpYM9nU7zAMYyaM//7D5UXXDFD9onaX5ewuuaDCeTAIdyRhp9kdp3nVVxF
	 ovfNATMM+0ELezi8Y6jp0R1EGRS3ZIeiL33LH56h3HeQTiQSH9z3Ia3R1OVJ448TBa
	 BWS/qON9wFcDQ0wxyf2qlmub6gRJ3ya5GrnhDS4FP94n1zpRmFkIzceuh1gP5zKhTu
	 wpFnRXV6L5T0A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ata: libata: Do not leave ata_host_stop() registered when activation fails
Date: Tue, 10 Nov 2026 23:38:14 -0500
Message-ID: <20261111042439.1025886-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054207-failed-6.1-d2f977008cbb@kernel.org>
References: <20261107054207-failed-6.1-d2f977008cbb@kernel.org>
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

From: Niklas Cassel <cassel@kernel.org>

[ Upstream commit d2f977008cbbae195df678ee1e70e5802f9bd0b8 ]

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
Add activate host error handling for sata_qstor and sata_fsl. For
sata_fsl this also means that hcr_base and host_priv are now released
when activating the host fails, which ->host_stop() did not do when
ata_host_start() itself failed.

Note that ata_pci_sff_activate_host() is deliberately left as is: none of
its callers releases the host resources in its probe() error path, they
all rely on ->host_stop() being called by devres, including
ata_pci_init_one(), which releases the devres group of the host itself.

Fixes: 1896b15eddb4 ("ahci_platform: perform platform exit in host_stop() hook")
Cc: stable@vger.kernel.org
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Link: https://lore.kernel.org/r/20260915084127.692494-13-cassel@kernel.org
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
Depends on <20261110142342.1878224-1-sashal@kernel.org>

 drivers/ata/libahci.c          |  2 +
 drivers/ata/libahci_platform.c |  4 ++
 drivers/ata/libata-core.c      | 75 +++++++++++++++++++++++++++++++---
 drivers/ata/libata-sff.c       |  5 +++
 drivers/ata/sata_fsl.c         |  6 ++-
 drivers/ata/sata_qstor.c       |  8 +++-
 include/linux/libata.h         |  1 +
 7 files changed, 91 insertions(+), 10 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 2bfd82f3fee18..54b7b2283ed5e 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -2662,6 +2662,8 @@ static int ahci_host_activate_multi_irqs(struct ata_host *host,
 			      host->ports[i]);
 	}
 
+	ata_host_undo_start(host);
+
 	return rc;
 }
 
diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index 6ed700a02df43..b5cf2108518fc 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -691,6 +691,10 @@ EXPORT_SYMBOL_GPL(ahci_platform_get_resources);
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
index b80113ebb3fc9..fd602ffbc5f7d 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5841,6 +5841,46 @@ int ata_host_start(struct ata_host *host)
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
@@ -5925,6 +5965,12 @@ static void async_port_probe(void *data, async_cookie_t cookie)
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
@@ -6031,6 +6077,10 @@ EXPORT_SYMBOL_GPL(ata_host_register);
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
@@ -6051,27 +6101,40 @@ int ata_host_activate(struct ata_host *host, int irq,
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
index f51697e203404..3c4a7a7f27b2c 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -2335,6 +2335,11 @@ EXPORT_SYMBOL_GPL(ata_pci_sff_prepare_host);
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
index 6bfa9f0542b67..f38c2089d55a5 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -1490,8 +1490,10 @@ static int sata_fsl_probe(struct platform_device *ofdev)
 	 * device discovery process, invoking our port_start() handler &
 	 * error_handler() to execute a dummy Softreset EH session
 	 */
-	ata_host_activate(host, irq, sata_fsl_interrupt, SATA_FSL_IRQ_FLAG,
-			  &sata_fsl_sht);
+	retval = ata_host_activate(host, irq, sata_fsl_interrupt,
+				   SATA_FSL_IRQ_FLAG, &sata_fsl_sht);
+	if (retval)
+		goto error_exit_with_cleanup;
 
 	host_priv->intr_coalescing.show = fsl_sata_intr_coalescing_show;
 	host_priv->intr_coalescing.store = fsl_sata_intr_coalescing_store;
diff --git a/drivers/ata/sata_qstor.c b/drivers/ata/sata_qstor.c
index 8ca0810aad26c..fb4d69b598a1f 100644
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
index 52b73315dae33..8df3d85a4cdff 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1069,6 +1069,7 @@ extern struct ata_host *ata_host_alloc_pinfo(struct device *dev,
 extern void ata_host_get(struct ata_host *host);
 extern void ata_host_put(struct ata_host *host);
 extern int ata_host_start(struct ata_host *host);
+void ata_host_undo_start(struct ata_host *host);
 extern int ata_host_register(struct ata_host *host,
 			     struct scsi_host_template *sht);
 extern int ata_host_activate(struct ata_host *host, int irq,
-- 
2.53.0

