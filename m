Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047364;
	b=OhZKmxIdvKRjlxcvJe+trhYAqAEI/PGChiP82YZrawRdIyzsndLlFuQgeYev/h6gIhNU
	 1YTEyWYFDAQbRRJqrlmH4m7eGd05Gb4jd/Ub4SuWVVbJ3czX7sm+GbRN5XnWMcibPiS0E
	 Xx4H+1wXG0kpB+Y6MclpkQ1zb+ng50jXwGl2dAWho0cPbzWRDV/VjBlrO16TfYtg6tXSI
	 Ng1LP/91h06ksv2P8NVz7LFoIo49KRls6ycFoevmFpa+PnPusPzogLbzuuSTMViSOWmI4
	 lGWAAsC7wYvzeeSPRV4IQn9kDvKhA6d+IRs5nPoRugABoCth2NM1UdN2Mu2HZFaQJdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047364;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=YhxKflUl/glyqwUxp/zEuMojG5edCYQ49nkTKrmL1Tw=;
	b=EAW4AuTQSoVfXz28XHxqJBjpkCYBW+AsoInFxBuFXHtXgyQKQ8ZHVaqJCoFfIHxxw9je
	 wIOAZ0yZJuXdh3VQzmDWgtbsY018ndrMehnTythbL7F0ZCWAaazGMJHtcpmOVqIlw2zg2
	 qJOYvYLZ5Vfd3qLRSzRNhniFys8pK7M2u78fz+zElUp7DpTZ8f5Z/GOgYLO938UUpTX4O
	 Mco73RttFx+LqLAuaDb12g5nms3cyihNWPQhZBMmsJ1oFU1IpcTqbRUQVnb92XAwQ7f+G
	 i+vOxKqoKAUYojmT/Cz/7yp41hMrGGsYgUKRK6/MGJZ9C+EZmAzIpL1owK7vqCoc11w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fDJpkvUw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA122606A32F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fDJpkvUw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 038371F0089F;
	Sat,  7 Nov 2026 10:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047363;
	bh=YhxKflUl/glyqwUxp/zEuMojG5edCYQ49nkTKrmL1Tw=;
	h=From:To:Cc:Subject:Date;
	b=fDJpkvUwXkkUfGlUCUWbza6VRRXmfUJ/HT+LQoN1FK1Wx9dsSSSjonIzYjeZus8Q3
	 CkzxemABnrubYpjMjWnIjAIPNwyfrX1TD44IPRQT4ugUT1uiyihQa4k8IF+Z6T8v5C
	 qoZIUCvjsre4nl5LJdszVP8sHcScxTJ6WN/y+t/AoIyL19SzMB35sjZzx8Ag22Pxcw
	 lGiCM2nTLMe0IeFp8IXSRRbr2MLANmT+VqKPFxj20NKVysDxfKZ5c/hys7+bG+IdHL
	 jFRjbWcgWpn0M9kFg+QA72Ymya/+Hh6JQZyLokqxL+mmRS5Te5XF2/t1DXi4X59kDa
	 yo6VNcJ4724zw==
From: Sasha Levin <sashal@kernel.org>
To: cassel@kernel.org,
	dlemoal@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ata: libata: Do not leave ata_host_stop() registered when activation fails" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:29:21 -0500
Message-ID: <20261107052921-failed-6.6-d2f977008cbb@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x d2f977008cbbae195df678ee1e70e5802f9bd0b8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052921-failed-6.6-d2f977008cbb@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From d2f977008cbbae195df678ee1e70e5802f9bd0b8 Mon Sep 17 00:00:00 2001
From: Niklas Cassel <cassel@kernel.org>
Date: Tue, 15 Sep 2026 10:41:31 +0200
Subject: [PATCH] ata: libata: Do not leave ata_host_stop() registered when
 activation fails

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
---
 drivers/ata/libahci.c          |  2 +
 drivers/ata/libahci_platform.c |  4 ++
 drivers/ata/libata-core.c      | 75 +++++++++++++++++++++++++++++++---
 drivers/ata/libata-sff.c       |  5 +++
 drivers/ata/sata_fsl.c         |  6 ++-
 drivers/ata/sata_qstor.c       |  8 +++-
 include/linux/libata.h         |  1 +
 7 files changed, 91 insertions(+), 10 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 1290dd5401011..95e4a18fd4598 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -2750,6 +2750,8 @@ static int ahci_host_activate_multi_irqs(struct ata_host *host,
 			      host->ports[i]);
 	}
 
+	ata_host_undo_start(host);
+
 	return rc;
 }
 
diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index 6e072d681341a..b44c0db4a86e6 100644
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
index f482c0a6d7e98..197f5d6e93ce0 100644
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
index 976e4e160494d..d5ef0338735c3 100644
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
index c6df55886fe1b..987d8acf1486c 100644
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
index 4e7f5b2ff3f69..f38310b84f51c 100644
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
index 313e96173b192..4625b2eea294a 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1147,6 +1147,7 @@ extern struct ata_host *ata_host_alloc_pinfo(struct device *dev,
 extern void ata_host_get(struct ata_host *host);
 extern void ata_host_put(struct ata_host *host);
 extern int ata_host_start(struct ata_host *host);
+void ata_host_undo_start(struct ata_host *host);
 extern int ata_host_register(struct ata_host *host,
 			     const struct scsi_host_template *sht);
 extern int ata_host_activate(struct ata_host *host, int irq,
-- 
2.53.0




