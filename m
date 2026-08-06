Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C173B4EB6;
	Thu,  6 Aug 2026 02:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785982379; cv=none; b=TMeAtdivZMYpIO/3dmStRZqbPsNGYa1YN039xeoPWARRcsd3nDe7SLrnrNUDxjcq3sc0ipWDOEluf3gAkQpSA1kvRfEoluQAjsbHBYxc7lbWrJE5vj/5x0mvAkwOisal2bhwY1OvEm8VWol3qUTL0OxM9UmfPXBqHRXl0Mmh9BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785982379; c=relaxed/simple;
	bh=iOb2zI1KWnJNpVTeM+vMRf9/hmqt+jS1X7qPeQ3v868=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IMLHhAv/vq/gzttSERO6BrJjEVUnWRs58EKveThYpOPUS8OIVADQ7UVoWfkB72YUE3abCgU+Hp6b3Pmu+9AKZSMzjombspGtiIJ0Lb0vsBPwrb4sx2dwjNu/8lsWMJg16PHgwkTNRY6xYR6CHA1+fI5MBhD88s+C9ra2+VjvzuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 52a05772913c11f1aa26b74ffac11d73-20260806
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:24db2f76-e2b8-4d5c-8812-154772a9980c,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:e7bac3a,CLOUDID:b98f0a07d7686603e28e600726bbf0a4,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 52a05772913c11f1aa26b74ffac11d73-20260806
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1006690362; Thu, 06 Aug 2026 10:12:49 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: kurt.schwemmer@microsemi.com,
	logang@deltatee.com,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] PCI: switchtec: Fix use-after-free in switchtec_pci_remove due to race condition
Date: Thu,  6 Aug 2026 10:12:46 +0800
Message-Id: <1f52d931ec7a7f5b36837cabf07b36e0463bf182.1785982054.git.xiaopei01@kylinos.cn>
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
Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
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
index 5711aaa5df11..235ca1877b6c 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -1318,6 +1318,13 @@ static void stdev_kill(struct switchtec_dev *stdev)
 
 	pci_clear_master(stdev->pdev);
 
+	if (stdev->event_irq >= 0)
+		devm_free_irq(&stdev->pdev->dev, stdev->event_irq, stdev);
+	if (stdev->dma_mrpc_irq >= 0)
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
+	stdev->event_irq = -1;
+	stdev->dma_mrpc_irq = -1;
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

