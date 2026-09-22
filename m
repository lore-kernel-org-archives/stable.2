Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C0D3EB0FF
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 15:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790090601; cv=none; b=qJXNAqZXNQfRu7FwlktihI+oOG2caX/a21AiiDB7IGg/LIBtw2zkdH0DwPPXu3JYaG+xAl/M8v0CWbP6sgm2yHuSLIMk11LvqJmUSPXQq1UXVVapKKvyE9bhYnSnctCYm5lNeCynbrr3ttDlwOH7kENL4627hOsX+COtjWVxajE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790090601; c=relaxed/simple;
	bh=2Jn1dksgcz+7m0YkeAt0QaweqMirtW8JcZjllOYsr60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uqswsf5IlIW6UZxWVqiYZ4ZiPmWhZ0F9uGjxITHnDfbu0si9udUOgI4UZFobvjFQgGI/7B/ytIUA/ZLPdpw8e7/HZwBfG8W4Mx50YkIcUm4O1Nt5/X+ovJFg6fpEXO0MQ4fUxIEWrI+UV+RFQ4JgrbKLrbAE6hjhoZ6B4NBFfMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kgkrKG5y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kgkrKG5y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83AE31F00899;
	Tue, 22 Sep 2026 15:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790090597;
	bh=0r20VxRiJq33htQPyNGDQTzovfF1DcWX029TOfFSv20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kgkrKG5yymSJtzxHrE24vxkJsYvRSjd1t70rJKBwArvb/yvFzDVkZpSg+J6h7GelN
	 dAHml7xR2+0fnqPHubJHIHPGygr7T9zNhfLj6m7otB5EdgzlKFRCMJwwCbgq+0xQwc
	 54R9hQXIKjOGszDI6IiAUAaXZTluN9+QTGYtcP4Ys9qlF3M3a5/kQZiL9f6dQrHJJI
	 OpXDodFkxM8rlPAsLGqzjlyEWRirmikftlaeSEeW+mbAM7XH4XE7KXTEy8RF/q5upI
	 gXJpn13CtkPCuA9uvahQq86wN0ZrZTS2xqkTNW533s33BNKD0pNn82e0D+OMcirV/e
	 ITor5iweTIE/w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Arun Easi <aeasi@cisco.com>,
	Sesidhar Baddela <sebaddel@cisco.com>,
	Arulprabhu Ponnusamy <arulponn@cisco.com>,
	Gian Carlo Boffa <gcboffa@cisco.com>,
	Karan Tilak Kumar <kartilak@cisco.com>,
	Laurence Oberman <loberman@redhat.com>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 3/3] scsi: fnic: Fix missed link-up when critical IRQ targets offline CPU
Date: Tue, 22 Sep 2026 11:23:12 -0400
Message-ID: <20260922152312.2801183-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922152312.2801183-1-sashal@kernel.org>
References: <2026092249-reminder-deed-f10e@gregkh>
 <20260922152312.2801183-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arun Easi <aeasi@cisco.com>

[ Upstream commit 0cb1fd924126f1f581621a5e804df98a02be9dff ]

When CPU Hyper Threading is disabled, sibling CPUs remain present but
are reported offline. Managed MSI-X IRQs can still receive affinity
masks that include those offline CPUs. If a driver-critical vector is
managed, it can be parked on an offline CPU and the driver may miss
critical events such as link-up.

Keep driver-critical vectors unmanaged so they can be migrated by the
IRQ core when their target CPU is offlined.

Since HWQ-0 is unmanaged now, in some queue combinations there can be no
mappings to it in mq_map. So without the blk-mq fix mentioned below,
system may crash during cpu offline/online tests.

Fixes: 8a8449ca5e33 ("scsi: fnic: Modify ISRs to support multiqueue (MQ)")
Cc: stable@vger.kernel.org
Depends-on: commit 10845a105bbc ("blk-mq: skip CPU offline notify on unmapped hctx")
Reviewed-by: Sesidhar Baddela <sebaddel@cisco.com>
Reviewed-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
Reviewed-by: Gian Carlo Boffa <gcboffa@cisco.com>
Reviewed-by: Karan Tilak Kumar <kartilak@cisco.com>
Signed-off-by: Arun Easi <aeasi@cisco.com>
Reviewed-by: Laurence Oberman <loberman@redhat.com>
Link: https://patch.msgid.link/20260903175547.57971-1-aeasi@cisco.com
Signed-off-by: Martin K. Petersen (Oracle) <mkp@kernel.org>
[ Inlined fnic_mq_init_queue_map() into fnic_mq_map_queues_cpus() using the existing cpu variable. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/fnic/fnic.h      |  2 +-
 drivers/scsi/fnic/fnic_isr.c  | 13 ++++++++++---
 drivers/scsi/fnic/fnic_main.c | 33 ++++++++++++++++++++++++++++++++-
 3 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/fnic/fnic.h b/drivers/scsi/fnic/fnic.h
index b401c8afeb5e3..7c685abd5a5aa 100644
--- a/drivers/scsi/fnic/fnic.h
+++ b/drivers/scsi/fnic/fnic.h
@@ -30,7 +30,7 @@
 
 #define DRV_NAME		"fnic"
 #define DRV_DESCRIPTION		"Cisco FCoE HBA Driver"
-#define DRV_VERSION		"1.9.0.0"
+#define DRV_VERSION		"1.9.0.1"
 #define PFX			DRV_NAME ": "
 #define DFX                     DRV_NAME "%d: "
 
diff --git a/drivers/scsi/fnic/fnic_isr.c b/drivers/scsi/fnic/fnic_isr.c
index 02856745580f5..43149d8312ec6 100644
--- a/drivers/scsi/fnic/fnic_isr.c
+++ b/drivers/scsi/fnic/fnic_isr.c
@@ -245,7 +245,14 @@ int fnic_set_intr_mode_msix(struct fnic *fnic)
 	unsigned int m = ARRAY_SIZE(fnic->wq);
 	unsigned int o = ARRAY_SIZE(fnic->hw_copy_wq);
 	unsigned int min_irqs = n + m + 1 + 1; /*rq, raw wq, wq, err*/
-
+	/*
+	 * Make driver critical vectors unmanaged, or else it can get tied
+	 * to an offline CPU. This can happen when hyper-threading is off.
+	 */
+	struct irq_affinity affd = {
+		.pre_vectors = n + m + 1, /* rq, raw wq, 1 ioq */
+		.post_vectors = 1, /* err */
+	};
 	/*
 	 * We need n RQs, m WQs, o Copy WQs, n+m+o CQs, and n+m+o+1 INTRs
 	 * (last INTR is used for WQ/RQ errors and notification area)
@@ -263,8 +270,8 @@ int fnic_set_intr_mode_msix(struct fnic *fnic)
 		int vec_count = 0;
 		int vecs = fnic->rq_count + fnic->raw_wq_count + fnic->wq_copy_count + 1;
 
-		vec_count = pci_alloc_irq_vectors(fnic->pdev, min_irqs, vecs,
-					PCI_IRQ_MSIX | PCI_IRQ_AFFINITY);
+		vec_count = pci_alloc_irq_vectors_affinity(fnic->pdev, min_irqs,
+			    vecs, PCI_IRQ_MSIX|PCI_IRQ_AFFINITY, &affd);
 		FNIC_ISR_DBG(KERN_INFO, fnic,
 					"allocated %d MSI-X vectors\n",
 					vec_count);
diff --git a/drivers/scsi/fnic/fnic_main.c b/drivers/scsi/fnic/fnic_main.c
index 7c7f9ea5267b9..de88786a3bb9b 100644
--- a/drivers/scsi/fnic/fnic_main.c
+++ b/drivers/scsi/fnic/fnic_main.c
@@ -680,6 +680,8 @@ static int fnic_scsi_drv_init(struct fnic *fnic)
 
 void fnic_mq_map_queues_cpus(struct Scsi_Host *host)
 {
+	const struct cpumask *mask;
+	unsigned int queue, cpu;
 	struct fnic *fnic = *((struct fnic **) shost_priv(host));
 	struct pci_dev *l_pdev = fnic->pdev;
 	int intr_mode = fnic->config.intr_mode;
@@ -700,7 +702,36 @@ void fnic_mq_map_queues_cpus(struct Scsi_Host *host)
 		return;
 	}
 
-	blk_mq_map_hw_queues(qmap, &l_pdev->dev, FNIC_PCI_OFFSET);
+	for_each_possible_cpu(cpu)
+		qmap->mq_map[cpu] = 0;
+
+	/*
+	 * Setup CPU to Queue mapping for all managed MSI-X IRQs.
+	 * Q0 is driver critical and non-managed, hence start from Q1.
+	 */
+	for (queue = 1; queue < qmap->nr_queues; queue++) {
+		int irq_num = pci_irq_vector(fnic->pdev,
+					     queue + FNIC_PCI_OFFSET);
+
+		if (irq_num < 0)
+			continue;
+
+		mask = pci_irq_get_affinity(fnic->pdev,
+					    queue + FNIC_PCI_OFFSET);
+		if (!mask) {
+			shost_printk(KERN_ERR, host,
+				"failed to get irq_affinity map for queue:%d\n", irq_num);
+			continue;
+		}
+		FNIC_MAIN_DBG(KERN_INFO, fnic,
+				"got irq_affinity map for %d:\n", irq_num);
+		for_each_cpu(cpu, mask) {
+			qmap->mq_map[cpu] = qmap->queue_offset + queue;
+			FNIC_MAIN_DBG(KERN_INFO, fnic,
+				      "[Q%d] cpu:%d <=> irq:%d\n",
+				      queue, cpu, irq_num);
+		}
+	}
 }
 
 static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
-- 
2.53.0

