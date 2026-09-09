Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B22379C46;
	Wed,  9 Sep 2026 18:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788979851; cv=none; b=NNKAYsLyL+Puj/irq6DU6HvXDnzOic8zhHY4HIAvs7nklSJxide6nxK6F1SbGKbNmt4qFWUjU4mfN1Icnl0eTLDAoyHfExcsTUONVQARr6XhxPGo+eGFVD2urDohZaRFpMbSovApaEzflE46PdhYXsnUg45DQalRev+DakOpwNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788979851; c=relaxed/simple;
	bh=UQal1XMZbdeRU2TmUbSUDihawiiJRs4QNyL8xYjZoYs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y8QW3bcCpIkWERI2rYbX67j7KTXLfW5F6B/rLwMGa+a5nYgeUCv4cuggZoIcSGismx4BnbR4IRUgYTd5mX6LEVXTuI4U8KgPMv3hqiLEcQzprtjxm4vp66dx549/T+VPpalGqWflDj6HyFP8uHLAXs9kaf+DctfLSkHOJkfHjh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mF/ENkhZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mF/ENkhZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B331D1F00893;
	Wed,  9 Sep 2026 18:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788979850;
	bh=9PtH7sEUj98wVO5dFuQv6FrKQdw3Z7T6QFamk70MIBA=;
	h=From:To:Cc:Subject:Date;
	b=mF/ENkhZ6cTf7lIo/Q5XKvDd5M3hxapva9FmWkeB+iov4zQ/RK+QnqTPK+H0p8tp6
	 3B6XcNpC2WSt4N5CBwDRzZdrUUEkk8hxgw4NhW7g8UR+DlOo6qjMPOjQXOPWQyWEqd
	 XXcg4uCQBRKi3YeyPBUsqMzoajmkLbIFTglu2r+F/e6et3ss2YmumatpwBRC6mDjhU
	 B5Kvi7WkRxUXbBi3CmQqCc1onI518eg7eOBvOs8ue4OosNUYHc831Ig2FV1KYDqP8H
	 g0rKwzWc3K+32TgMvY4uKFmXYk7BmqscXmtaSj4K5kgnwWCQm01LUiecZO91z7k5vn
	 o7vrj/JfhBmig==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Brian Norris <computersforpeace@gmail.com>,
	Jeff Garzik <jgarzik@redhat.com>
Cc: stable@vger.kernel.org,
	linux-ide@vger.kernel.org
Subject: [PATCH] ata: libata: Do not leave ata_host_stop() registered when activation fails
Date: Wed,  9 Sep 2026 20:50:36 +0200
Message-ID: <20260909185035.3130774-2-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6550; i=cassel@kernel.org; h=from:subject; bh=UQal1XMZbdeRU2TmUbSUDihawiiJRs4QNyL8xYjZoYs=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLIWrqpOYX2Yb+/gYXR82rRjme7dGc8tTJ/c2u9rP3OWX tORC1Z7OkpZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjCRI+GMDLujilwM18dq1FvI 96w+Ucy6oaKea9LJ1cs9rCWe/7r94wUjw7lfjcbT8x3ClvLYPbhQN0n39tTXm7z/Pco7uc7Y/ht DFBcA
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

Fixes: 1896b15eddb4 ("ahci_platform: perform platform exit in host_stop() hook")
Cc: stable@vger.kernel.org
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libahci.c     | 13 ++++++--
 drivers/ata/libata-core.c | 69 +++++++++++++++++++++++++++++++++++----
 drivers/ata/libata-sff.c  |  6 ++--
 include/linux/libata.h    |  1 +
 4 files changed, 79 insertions(+), 10 deletions(-)

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

