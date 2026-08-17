Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B713D391E58;
	Mon, 17 Aug 2026 05:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786945214; cv=none; b=QcmA5SlJ3HRv/QjCvSSccYGsGw0HwnN3DfnKlKjj6bznHSmyHtpHrAkpWIAPMr2qps7zmbmv9eDWgaIOJmCN7wT3aiv4XwJTLJDAS84CvQjd2tWx1bY/e2vj+cl1wBIEdSxAhwUnokRwmSwcgMgkn4wUbFQuo7qFlPgKKlQb50A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786945214; c=relaxed/simple;
	bh=6KVHI/lzUbGxN9zJMPm76j83d1uatU1uoR2cibkYbmQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A2TWepHetGR0N8rNOVmU3my247Lo72iMKASUQOJXPieyf3GfwwdtNNx2mfS+nFjBEd7VboR7sn8zD7Ov8+YMYHHc/H0hLeWriS8XKYoa1evkXR7ZZwfNbaCl1XK2mzPztoOr+kJow7TA346x55hs4V2vxIDYF8Bp8kXgy1UxdOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1a2760aa99fe11f19a56ed5b684f684d-20260817
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:7cf79eff-9933-4ebe-a9e1-4e0cf569fb25,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:7db8b62,CLOUDID:f2b5b29fc0ea2857f066895fc2e36321,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50,EDM:5,IP:ni
	l,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1a2760aa99fe11f19a56ed5b684f684d-20260817
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1910437523; Mon, 17 Aug 2026 13:40:06 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: logang@deltatee.com,
	kurt.schwemmer@microsemi.com,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v3] PCI: switchtec: Fix use-after-free in switchtec_pci_remove due to race condition
Date: Mon, 17 Aug 2026 13:40:03 +0800
Message-Id: <4cebfe41ee3985bc4f38beb42d44147a34637971.1786944920.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In stdev_create, &stdev->mrpc_work is bound with mrpc_event_work, and
&stdev->link_event_work is bound with link_event_work. The IRQ handlers
switchtec_event_isr and switchtec_dma_mrpc_isr can schedule these works
on system_wq (via schedule_work() in the ISRs and via
check_link_state_events()).

If we remove the device, switchtec_pci_remove makes cleanup and the
memory allocated for stdev is released by put_device() ->
stdev_release() -> kfree(stdev), while the works mentioned above may
still be pending or running. The sequence of operations that may lead
to a UAF bug is as follows:

CPU0                                      CPU1

                                          | switchtec_event_isr
                                          | schedule_work(&stdev->mrpc_work)
switchtec_pci_remove                      |
cdev_device_del(&stdev->cdev,             |
                &stdev->dev)              |
stdev_kill(stdev)                         |
switchtec_exit_pci(stdev)                 |
pci_dev_put(stdev->pdev)                  |
put_device(&stdev->dev)                   |
// stdev_release -> kfree(stdev)          |
                                          | mrpc_event_work
                                          | // use stdev (use-after-free)

Fix it by quiescing the interrupt sources before canceling the works:
stdev_kill() first clears PCI bus mastering, then explicitly frees both
IRQs, so no handler can be running and scheduling new work while the works
are canceled.

Fixes: 080b47def5e5 ("MicroSemi Switchtec management interface driver")
Fixes: 48c302dc8f3a ("NTB: switchtec: Add link event notifier callback")
Cc: stable@vger.kernel.org
Assisted-by: Codex:deepseek-v4-flash
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
changes in v3:
1.Add Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
2.event_irq and dma_mrpc_irq explictily initialized to zero and check for non-zero in the tests
v2 Links: https://lore.kernel.org/lkml/5ce42824-488e-4040-8531-0acc8b01b13a@deltatee.com/#t  

changes in v2:
1.Add explicitly devm_free_irq
2.cacel mrpc_work and link_event_work move to before mrpc_timeout
3.Add event_irq and dma_mrpc_irq in struct stdev
4.Add Cc: stable@vger.kernel.org
---
 drivers/pci/switch/switchtec.c | 16 +++++++++++++++-
 include/linux/switchtec.h      |  2 ++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 5711aaa5df11..9eded14a37b1 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -1318,6 +1318,13 @@ static void stdev_kill(struct switchtec_dev *stdev)
 
 	pci_clear_master(stdev->pdev);
 
+	if (stdev->event_irq)
+		devm_free_irq(&stdev->pdev->dev, stdev->event_irq, stdev);
+	if (stdev->dma_mrpc_irq)
+		devm_free_irq(&stdev->pdev->dev, stdev->dma_mrpc_irq, stdev);
+
+	cancel_work_sync(&stdev->mrpc_work);
+	cancel_work_sync(&stdev->link_event_work);
 	cancel_delayed_work_sync(&stdev->mrpc_timeout);
 
 	/* Mark the hardware as unavailable and complete all completions */
@@ -1356,6 +1363,8 @@ static struct switchtec_dev *stdev_create(struct pci_dev *pdev)
 	INIT_LIST_HEAD(&stdev->mrpc_queue);
 	mutex_init(&stdev->mrpc_mutex);
 	stdev->mrpc_busy = 0;
+	stdev->event_irq = 0;
+	stdev->dma_mrpc_irq = 0;
 	INIT_WORK(&stdev->mrpc_work, mrpc_event_work);
 	INIT_DELAYED_WORK(&stdev->mrpc_timeout, mrpc_timeout_work);
 	INIT_WORK(&stdev->link_event_work, link_event_work);
@@ -1513,6 +1522,7 @@ static int switchtec_init_isr(struct switchtec_dev *stdev)
 
 	if (rc)
 		return rc;
+	stdev->event_irq = event_irq;
 
 	if (!stdev->dma_mrpc)
 		return rc;
@@ -1529,7 +1539,11 @@ static int switchtec_init_isr(struct switchtec_dev *stdev)
 				switchtec_dma_mrpc_isr, 0,
 				KBUILD_MODNAME, stdev);
 
-	return rc;
+	if (rc)
+		return rc;
+	stdev->dma_mrpc_irq = dma_mrpc_irq;
+
+	return 0;
 }
 
 static void init_pff(struct switchtec_dev *stdev)
diff --git a/include/linux/switchtec.h b/include/linux/switchtec.h
index 724da6c08bf7..fd38d3e7f3b6 100644
--- a/include/linux/switchtec.h
+++ b/include/linux/switchtec.h
@@ -500,6 +500,8 @@ struct switchtec_dev {
 	struct mutex mrpc_mutex;
 	struct list_head mrpc_queue;
 	int mrpc_busy;
+	int event_irq;
+	int dma_mrpc_irq;
 	struct work_struct mrpc_work;
 	struct delayed_work mrpc_timeout;
 	bool alive;
-- 
2.25.1

