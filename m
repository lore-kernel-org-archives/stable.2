Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090FE478859
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 09:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790070166; cv=none; b=FPn0tpx0bYR46m7xl+wQy52K0CUATvQ88WAxcBC39/2YuymiEdm3xkqFZqHxYFVXvjPljNNLJwVFG6KmPr48Ynnt9+oMM/GCBS+KXJJUuj37L4f61m2hXxfysu6fq1LzR7Tw/QelEa7L5/tlEbXrDJ50goTwmlzq+fH8vt2V0+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790070166; c=relaxed/simple;
	bh=dCNYBv9PWcjBkDVT/JhWfnOSTNtMZYSAbeXHx909a70=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GSARtqm7REeHcugEQjKEHTTiAPfCthploRWTjY3lGMK16XH5+aXniSmISYd4i+l8QpuqUbdMXWl3Or2XxlW8D5wxPfMYqV3MnaNR2V5zaXyHuFCDDYphtNSsnzAEMQXe7nPxbClx/WP3vGhn6lMT2c9IKnlD8vsNDPm3ql1+zoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XquvYE3G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XquvYE3G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C76E11F000FF;
	Tue, 22 Sep 2026 09:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790070164;
	bh=IMtwk7DZmiQSJM+uZxJ8rrOZpdbd4Rgq5hE1s+vL1tg=;
	h=Subject:To:Cc:From:Date;
	b=XquvYE3GnHTZSo39EaQQ3vISJkdcF73WSxGuqf/1SobAXl8L1btgBVqvshOhScOIV
	 H1rPanDnVYCcrBVam9OdWdZzNMdeKdGb2qCIgLZTwT+AmuFlHh8EFLfodXl9yr/HeB
	 crubOj43cw2hunuJK1j/hJcpReI74ZTD+mW5oq8M=
Subject: FAILED: patch "[PATCH] scsi: fnic: Fix missed link-up when critical IRQ targets" failed to apply to 6.12-stable tree
To: aeasi@cisco.com,arulponn@cisco.com,gcboffa@cisco.com,kartilak@cisco.com,loberman@redhat.com,mkp@kernel.org,sebaddel@cisco.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Sep 2026 11:34:50 +0200
Message-ID: <2026092250-economy-trend-aee5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 0cb1fd924126f1f581621a5e804df98a02be9dff
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092250-economy-trend-aee5@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0cb1fd924126f1f581621a5e804df98a02be9dff Mon Sep 17 00:00:00 2001
From: Arun Easi <aeasi@cisco.com>
Date: Thu, 3 Sep 2026 10:55:47 -0700
Subject: [PATCH] scsi: fnic: Fix missed link-up when critical IRQ targets
 offline CPU

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

diff --git a/drivers/scsi/fnic/fnic.h b/drivers/scsi/fnic/fnic.h
index c576a7f5083e..3ba1592940ca 100644
--- a/drivers/scsi/fnic/fnic.h
+++ b/drivers/scsi/fnic/fnic.h
@@ -31,7 +31,7 @@
 
 #define DRV_NAME		"fnic"
 #define DRV_DESCRIPTION		"Cisco FCoE HBA Driver"
-#define DRV_VERSION		"1.9.0.0"
+#define DRV_VERSION		"1.9.0.1"
 #define PFX			DRV_NAME ": "
 #define DFX                     DRV_NAME "%d: "
 
diff --git a/drivers/scsi/fnic/fnic_isr.c b/drivers/scsi/fnic/fnic_isr.c
index 02856745580f..43149d8312ec 100644
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
index 9b3025007075..f13c381a66d7 100644
--- a/drivers/scsi/fnic/fnic_main.c
+++ b/drivers/scsi/fnic/fnic_main.c
@@ -744,8 +744,19 @@ static int fnic_nvme_drv_init(struct fnic *fnic)
 	return ret;
 }
 
+static void fnic_mq_init_queue_map(struct fnic *fnic,
+		struct blk_mq_queue_map *qmap)
+{
+	unsigned int cpu;
+
+	for_each_possible_cpu(cpu)
+		qmap->mq_map[cpu] = 0;
+}
+
 void fnic_mq_map_queues_cpus(struct Scsi_Host *host)
 {
+	const struct cpumask *mask;
+	unsigned int queue, cpu;
 	struct fnic *fnic = *((struct fnic **) shost_priv(host));
 	struct pci_dev *l_pdev = fnic->pdev;
 	int intr_mode = fnic->config.intr_mode;
@@ -766,7 +777,35 @@ void fnic_mq_map_queues_cpus(struct Scsi_Host *host)
 		return;
 	}
 
-	blk_mq_map_hw_queues(qmap, &l_pdev->dev, FNIC_PCI_OFFSET);
+	fnic_mq_init_queue_map(fnic, qmap);
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

