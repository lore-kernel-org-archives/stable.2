Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE49E40A940;
	Thu,  6 Aug 2026 11:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786017342; cv=none; b=B5CmEo6UubjXG0/+JSlOkhwKx0+TiTOJG0GwsYZQFeAQpQOI5DdDFfJ8MLkIMaViSg6bJCqSigq7O1GpLhQJB1sw8FsZraXi9YDLL8HEkpzgfmyh1/OdUvOINuuvJtksLK/2upxshirDUNMeM7UmKu2o2TmoLl4KI2g4+mFJ0C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786017342; c=relaxed/simple;
	bh=sn5SctyIWt3TzEj5r+5jGggD7KpR/8VuXniZytl8jAs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XQ/Jm9q4k0+1Sm1mLDO71PZw3d1VaQgIg/FWmmBe7shdk9fmNHz+fhLop4OsHNcdqdJ7rwcdZa4LdRyw7wIgkVqK7Y4Jr1/2HVBq056k7z/pm0QduvTteWut9H864XPIN84vsxgHynDTLq7Zhvgj/euE8ArbhUOi6qCP2W4KNGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b809d93e918d11f1aa26b74ffac11d73-20260806
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:955ff151-eba8-4eeb-9e10-6fb55fa94ef3,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:e7bac3a,CLOUDID:94819910687ec1624e8fd0c5189023ca,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b809d93e918d11f1aa26b74ffac11d73-20260806
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1345253287; Thu, 06 Aug 2026 19:55:28 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: kurt.schwemmer@microsemi.com,
	logang@deltatee.com,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] PCI: switchtec: Fix use-after-free in mrpc_timeout_work
Date: Thu,  6 Aug 2026 19:55:15 +0800
Message-Id: <e640c79072065c1a347ed25f7ce0fe1ba565f4fe.1786017236.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

stdev_kill() cancels the works before clearing stdev->alive under
mrpc_mutex. Every path that arms mrpc_timeout holds that mutex, so a
write that already passed the alive check can still schedule
mrpc_timeout after cancel_delayed_work_sync() returns:

CPU0                                      CPU1

                                          | switchtec_dev_write()
                                          | lock_mutex_and_test_alive()
cancel_delayed_work_sync(mrpc_timeout)    |
                                          | mrpc_cmd_submit()
                                          | schedule_delayed_work(mrpc_timeout)
                                          | mutex_unlock(&stdev->mrpc_mutex)
scoped_guard(mutex) { alive = false }     |
put_device() -> kfree(stdev)              |
                                          | mrpc_timeout_work

Fix it by clearing alive under mrpc_mutex before canceling the works, so no
new mrpc_timeout can be armed once alive is cleared.

Fixes: 080b47def5e5 ("MicroSemi Switchtec management interface driver")
Cc: stable@vger.kernel.org
Assisted-by: Codex:deepseek-v4-flash
Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
 drivers/pci/switch/switchtec.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 235ca1877b6c..9127841b2bf8 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -1323,10 +1323,6 @@ static void stdev_kill(struct switchtec_dev *stdev)
 	if (stdev->dma_mrpc_irq >= 0)
 		devm_free_irq(&stdev->pdev->dev, stdev->dma_mrpc_irq, stdev);
 
-	cancel_work_sync(&stdev->mrpc_work);
-	cancel_work_sync(&stdev->link_event_work);
-	cancel_delayed_work_sync(&stdev->mrpc_timeout);
-
 	/* Mark the hardware as unavailable and complete all completions */
 	scoped_guard (mutex, &stdev->mrpc_mutex) {
 		stdev->alive = false;
@@ -1341,6 +1337,10 @@ static void stdev_kill(struct switchtec_dev *stdev)
 
 	}
 
+	cancel_work_sync(&stdev->mrpc_work);
+	cancel_work_sync(&stdev->link_event_work);
+	cancel_delayed_work_sync(&stdev->mrpc_timeout);
+
 	/* Wake up any users waiting on event_wq */
 	wake_up_interruptible(&stdev->event_wq);
 }
-- 
2.25.1

