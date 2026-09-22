Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8582F244687
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 17:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790096423; cv=none; b=R49jajKqe1veLckQFR6XJyulwczSHfWcTtWxP0wb+g3oQL3ct91+Jp3VBiFGt/Bq0tP4p8z2yw6Gi/EU/nCVseusOKB6YKPGCKe6FcLq7wOlpVoWk/muJW93wM/ncYnVkNDQNfbWBizbsXDsRqgNgDf+GTcnH4YVsXPLZxrH3bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790096423; c=relaxed/simple;
	bh=7EXs/TLxHGKqgDPfWeuwHTq6p4hi+P7Ftb7y9I8cnNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tts+fCQsTynVZ9n1KSU0SYDi1L6kYmNjqJExqC1aOqldqontTJ+8COQu/Nf+sh4KZJxqaNc2cQsJ7m6eGew3HuuXsEKxbYpJygC+i11Yl0zaNz8sECYpJFitSuhizFChW3WO6q7MOBIN/lCystVUt+sZVY7LHPMrNSXKNXQRwiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H7UuSPyD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H7UuSPyD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C9A91F000FF;
	Tue, 22 Sep 2026 17:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790096422;
	bh=5oAeTUaWeDpjRo3QMFR0xnME+CpLOXW5RqTRpntKgGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H7UuSPyD+rz9gIo0c2c+YFTQKn2AFNiFdTGVNansyQTuhEhMVTpmgpim8aVlm5OR9
	 xWOAq+rLQG+sQ1DGToZiO2jClIjd28sEihp9MIz+ocoE0Ubtg/PI2+YcY//eOCwZQ3
	 cb7pcNWVk3+MA+IDn4PvNpffSX8NS02LsmUU0XqmVux+/e6IeTFwzXrKxZW24/tKkz
	 RtQq7+GCLLv8g7a7sZq2JVfSvu6G2oaNI/iFtZT2sAodHGMI2l1By4K2Nfgjo5rk3P
	 qdDg95SPysieIWpG4cAPfubjOjLUO7kPuujmhSlJWJ4rwg2THzhm0tAIt5/YNKZnz7
	 xftPlZ0mLl+nQ==
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
Subject: [PATCH 6.12.y] scsi: fnic: Fix missed link-up when critical IRQ targets offline CPU
Date: Tue, 22 Sep 2026 13:00:19 -0400
Message-ID: <20260922170019.3181276-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092250-economy-trend-aee5@gregkh>
References: <2026092250-economy-trend-aee5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
[ inlined upstream’s queue-mapping initialization helper into the existing fnic mapping function. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/fnic/fnic.h      |  2 +-
 drivers/scsi/fnic/fnic_isr.c  | 13 ++++++++++---
 drivers/scsi/fnic/fnic_main.c | 33 ++++++++++++++++++++++++++++++++-
 3 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/fnic/fnic.h b/drivers/scsi/fnic/fnic.h
index ce73f08ee889f..3ae611625c7f6 100644
--- a/drivers/scsi/fnic/fnic.h
+++ b/drivers/scsi/fnic/fnic.h
@@ -27,7 +27,7 @@
 
 #define DRV_NAME		"fnic"
 #define DRV_DESCRIPTION		"Cisco FCoE HBA Driver"
-#define DRV_VERSION		"1.7.0.0"
+#define DRV_VERSION		"1.7.0.1"
 #define PFX			DRV_NAME ": "
 #define DFX                     DRV_NAME "%d: "
 
diff --git a/drivers/scsi/fnic/fnic_isr.c b/drivers/scsi/fnic/fnic_isr.c
index ff85441c6cea2..44c58c4aa1cae 100644
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
 		FNIC_ISR_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
 					"allocated %d MSI-X vectors\n",
 					vec_count);
diff --git a/drivers/scsi/fnic/fnic_main.c b/drivers/scsi/fnic/fnic_main.c
index 1cb517f731f4a..02a5c6f4580e3 100644
--- a/drivers/scsi/fnic/fnic_main.c
+++ b/drivers/scsi/fnic/fnic_main.c
@@ -579,6 +579,8 @@ static int fnic_scsi_drv_init(struct fnic *fnic)
 
 void fnic_mq_map_queues_cpus(struct Scsi_Host *host)
 {
+	const struct cpumask *mask;
+	unsigned int queue, cpu;
 	struct fc_lport *lp = shost_priv(host);
 	struct fnic *fnic = lport_priv(lp);
 	struct pci_dev *l_pdev = fnic->pdev;
@@ -600,7 +602,36 @@ void fnic_mq_map_queues_cpus(struct Scsi_Host *host)
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
+		FNIC_MAIN_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				"got irq_affinity map for %d:\n", irq_num);
+		for_each_cpu(cpu, mask) {
+			qmap->mq_map[cpu] = qmap->queue_offset + queue;
+			FNIC_MAIN_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				      "[Q%d] cpu:%d <=> irq:%d\n",
+				      queue, cpu, irq_num);
+		}
+	}
 }
 
 static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
-- 
2.53.0

