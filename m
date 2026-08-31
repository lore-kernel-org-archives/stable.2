Received: from mx.bauer-kirch.com (mx.bauer-kirch.com [217.11.56.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E926938239E;
	Mon, 31 Aug 2026 12:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.11.56.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788180287; cv=none; b=BLV0/ww9ukaOf4T0u9rk2gac6tpc2L1UBetlr3yZXTxCUZTggaifRcdY/iBvT/QMROc/1hSfg3cZcQd4AHJxQ82tpqNZS7G3tWH8Fv1cS+b1uV3aGjufzCVUdVYJ7+yafOnxVW1zyFk1+bogBWzWoLQxZYjWH8cnNZq7mQrLDYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788180287; c=relaxed/simple;
	bh=4YMqLEY/02rlxcwK4XS/MbUoJEdwhJKjJRK02XpYQww=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rXOGgwVKhNE2DOSh12IEPJINpCTMP0GxOOZr/DtiHda5czrXSRz+QaIKZMNzu/FbvMdoCS3VMrYGjtG9O96+8l1FUBDN0xeoBvs7xRBHkUaUFUsQt6Y7B25/TOm0EJSp7HNBcN8Jnet5hk6ot/pu8iMKkSqfnHhc7v96zZa82v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=noerenberg.de; spf=pass smtp.mailfrom=noerenberg.de; dkim=pass (2048-bit key) header.d=noerenberg.de header.i=@noerenberg.de header.b=S5kIyLPx; arc=none smtp.client-ip=217.11.56.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=noerenberg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=noerenberg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=noerenberg.de header.i=@noerenberg.de header.b="S5kIyLPx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=noerenberg.de; s=bauerkirch; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MJ0i4E3zi2QieHzwj19yLMfwI8aGXPJyv1POOjDril4=; b=S5kIyLPxQv5SAL9cCXfqQGu/m5
	wprd6IQjnSPgnVVTjxuOZrjtprRz5KwDc04rBBFShLsaG6IOfb2QPSguW10pLKDFA6CV8p1Tg2YIY
	HXok0st9SEoljX1gSndtUkPS/ntNpr6h+levpV502v61egkarxiTA4NchG2NNI7rpVFkTQpZOhAkk
	IA15kEMoud7sDlc1tDgrLz57KalYEW1KrSwvGE17VE/iZbMUmL+JFXsfTNp0DaGi8quoJNyF+is16
	UMvTVZF7aYj1c+jXmrFIC8ktlUbIyLNTt4KCS1C6EcH16Cn5DdAGtfWDjrNfmQjImtfv82yADYnm3
	Mv3+hntw==;
Received: from xdsl-89-1-135-213.nc.de ([89.1.135.213] helo=flux.rw17.noerenberg.de)
	by mail.bauer-kirch.de with ESMTPSA id 1x11NG-000000055Ae-3oxC
	authenticated id <420001312>
	(TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256);
	Mon, 31 Aug 2026 14:44:30 +0200
From: Hajo Noerenberg <hajo-linux-ide@noerenberg.de>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-ide@vger.kernel.org
Cc: Pali Rohar <pali@kernel.org>,
	stable@vger.kernel.org,
	risc4all@yahoo.com,
	linux-kernel@vger.kernel.org,
	Hajo Noerenberg <hajo-linux-ide@noerenberg.de>
Subject: [PATCH v3] ata: ahci: work around lost interrupts on Marvell 88SE61xx
Date: Mon, 31 Aug 2026 14:43:03 +0200
Message-Id: <20260831124303.920391-1-hajo-linux-ide@noerenberg.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ahci_single_level_irq_intr() services the ports first and clears the
global HOST_IRQ_STAT afterwards, as recommended by AHCI 1.1 section
10.6.2.  The Marvell 88SE6111/6121/6145 family stops reporting interrupts
for a port when HOST_IRQ_STAT is cleared while PxIS still holds bits:
PxIS keeps its content, HOST_IRQ_STAT reads back as 0, the port is never
looked at again, and the command in flight only ends in a timeout.

Measured on a Seagate Blackarmor NAS440 (Marvell 88F6281 Kirkwood,
88SE6121 rev B2 behind PCIe) by polling the AHCI registers from userspace
while an IDENTIFY was outstanding:

  t=303.046  irqs 127  PxIS 0x00000000  PxCI 0x00000001
             IDENTIFY issued
  t=303.057  irqs 128  PxIS 0x00000020  PxCI 0x00000000
             CI cleared, DPS set, one interrupt taken
             ... PxIS stays 0x00000020, HOST_IRQ_STAT stays 0 ...
  t~308.05   qc timeout after 5000 msecs

The command had completed - PxCI was clear and PxIS had DPS set - so
ahci_qc_complete() would have completed it.  It never got the chance
because the handler read HOST_IRQ_STAT as 0 and returned IRQ_NONE.

Marvell's own driver for these chips clears the two registers in the
opposite order and says so ("clear global before channel"), and
ahci_xgene handles its broken edge latch the same way.  Since the
reordering costs at most one spurious interrupt per valid one on
conforming controllers, do it in a private interrupt handler selected for
board_ahci_mv instead of changing libahci for everyone.

With this applied, SATA-2 and SATA-3 disks work at 3.0 Gbps on the
88SE6121 without the drive-side 1.5 Gbps jumper that was needed before.
Time from link up to a successful IDENTIFY:

  WDC WD5000AADS-00S9B0  port 0    7 ms  (never identified before)
  WDC WD3202ABYS-01B7A0  port 1   28 ms
  WDC WD30EFRX-68EUZN0   port 1  200 ms  (3 TB, HPA detection ok)

Only the 88SE6121 was tested; board_ahci_mv also covers the 88SE6145,
which Marvell's driver treats identically.

Fixes: cd70c26617f4 ("[libata] AHCI: Add support for Marvell AHCI-like chips (initially 6145)")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/linux-ide/db6b48b7-d69a-564b-24f0-75fbd6a9e543@noerenberg.de/
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216094
Signed-off-by: Hajo Noerenberg <hajo-linux-ide@noerenberg.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Acked-by: Pali Rohar <pali@kernel.org>

---
Niklas, sorry for the wasted round trip.  Kernel patches are not my daily
business and I had not realised how far the tree I was working against had
drifted - v2 was generated against 6.10-rc6.  Rebased on v7.3-rc1 now, and
the base commit is recorded at the bottom so this cannot happen unnoticed
again.  Thank you for taking the time to look at it anyway.

v3:
 - rebase onto v7.3-rc1; v2 did not apply
 - add Fixes: and Cc: stable@vger.kernel.org, as requested
 - collect Reviewed-by from Damien and Acked-by from Pali
 - no code change

v2:
 - retitle "clear HOST_IRQ_STAT before the ports" -> "work around lost
   interrupts", per review

 drivers/ata/ahci.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -2614,6 +2614,51 @@
 }
 #endif
 
+/*
+ * The Marvell 88SE6111/6121/6145 ("Thor") family stops reporting interrupts
+ * for a port when HOST_IRQ_STAT is cleared while PxIS still holds bits: PxIS
+ * keeps its content, HOST_IRQ_STAT reads back as 0, the port is never looked
+ * at again and the command in flight only ends in a timeout.  On a 88SE6121
+ * this makes every SATA-2 or SATA-3 disk fail to IDENTIFY, while SATA-1 disks
+ * happen to win the race often enough to work.
+ *
+ * Clearing the host status before servicing the ports avoids it.  Marvell's
+ * own driver for these chips does the same and says so ("clear global before
+ * channel"), and ahci_xgene handles its broken edge latch the same way.  The
+ * price is at most one spurious interrupt per valid one, which is why this is
+ * not the generic behaviour - see AHCI 1.1 section 10.6.2.
+ *
+ * Link: https://bugzilla.kernel.org/show_bug.cgi?id=216094
+ */
+static irqreturn_t ahci_mv_irq_handler(int irq, void *dev_instance)
+{
+	struct ata_host *host = dev_instance;
+	struct ahci_host_priv *hpriv = host->private_data;
+	void __iomem *mmio = hpriv->mmio;
+	unsigned int rc;
+	u32 irq_stat, irq_masked;
+
+	irq_stat = readl(mmio + HOST_IRQ_STAT);
+	if (!irq_stat)
+		return IRQ_NONE;
+
+	irq_masked = irq_stat & hpriv->port_map;
+
+	spin_lock(&host->lock);
+
+	/*
+	 * Use the unmasked value to clear the interrupt, as a spurious pending
+	 * event on a dummy port might cause a screaming IRQ.
+	 */
+	writel(irq_stat, mmio + HOST_IRQ_STAT);
+
+	rc = ahci_handle_port_intr(host, irq_masked);
+
+	spin_unlock(&host->lock);
+
+	return IRQ_RETVAL(rc);
+}
+
 static void ahci_remap_check(struct pci_dev *pdev, int bar,
 		struct ahci_host_priv *hpriv)
 {
@@ -2917,6 +2962,10 @@
 		return -ENOMEM;
 	hpriv->flags |= (unsigned long)pi.private_data;
 
+	/* the Marvell "Thor" family needs HOST_IRQ_STAT cleared first */
+	if (board_id == board_ahci_mv)
+		hpriv->irq_handler = ahci_mv_irq_handler;
+
 	/* MCP65 revision A1 and A2 can't do MSI */
 	if (board_id == board_ahci_mcp65 &&
 	    (pdev->revision == 0xa1 || pdev->revision == 0xa2))

base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
