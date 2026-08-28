Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DB2377AA2;
	Fri, 28 Aug 2026 16:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787933445; cv=none; b=umaeOZwRai3RUDlxJ/XXV+mWaAHpWxCH0amy6rW3oVWinjbT0zv8Si0l7kGlL7ZqIqKJk5SuVe/8SnQAFW4C7OB6bW0G3K4XIykb0f7DltCuAM47XAH7n7SbLVpGAZm34YPCEWkQQ4KU+godO8nU8C3Ym9EdY4ZxxaZSnkiNgpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787933445; c=relaxed/simple;
	bh=hZASkD01ARriCg6zFtXG0Fn1zGv8l7hHUFpbKwIkbgg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mHvIXAquJIb/LHH4QvhrTBNU8xdSLlfsUA/cqNuTct0rYvxT6mloauMZGnGFFgnc2tHvD0sQ1bh7sqoFDdgaX2LODTktz0Gn3fKy65Wk0nvUC4efb52AdfiLILJJW5GsNE2n5QS4bZV60e7KDpwb497ITkbUb2pKvcGgSw0Gryo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fBomY1Zy; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fBomY1Zy"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF1231476;
	Fri, 28 Aug 2026 09:10:37 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.5.212])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B2BED3F66F;
	Fri, 28 Aug 2026 09:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787933441; bh=hZASkD01ARriCg6zFtXG0Fn1zGv8l7hHUFpbKwIkbgg=;
	h=From:To:Cc:Subject:Date:From;
	b=fBomY1ZyF6kjBJGXIkhUoIjy1Rf+9QTrWyMi9e2OrPV4EzLEp0/lq8Zv/UPZvzNaJ
	 CKZRHwo1zcAuBp8VU16X+cAS8o233cVmh+xfOhoYFoPGS/kRGBq4xUjVM4gpPUnek8
	 NKFE8mPrxFSf8zXmnBUkGWzG9+8ez/b6wxI4huLg=
From: Christian Loehle <christian.loehle@arm.com>
To: Sudeep Holla <sudeep.holla@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH] mailbox: pcc: Synchronize channel IRQ before unmapping shared memory
Date: Fri, 28 Aug 2026 17:10:33 +0100
Message-Id: <20260828161033.3783599-1-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcc_mbox_free_channel() unmaps the PCC shared-memory region before
mbox_free_channel() invokes the controller shutdown callback. For
interrupt-capable extended subspaces, an in-flight handler may
consequently access the mapping after it has been invalidated.

Release the mailbox channel first so its IRQ is disabled and synchronized
before unmapping the shared-memory region. Serialize PCC channel
acquisition and release across this sequence: once mbox_free_channel()
makes the channel available, another client must not replace the
shared-memory mapping until the old one has been unmapped.

Fixes: 7f9e19f207be ("mailbox: pcc: Check before sending MCTP PCC response ACK")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/mailbox/pcc.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 9888dab64639..4654b028df9f 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -47,12 +47,14 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/list.h>
 #include <linux/log2.h>
+#include <linux/mutex.h>
 #include <linux/platform_device.h>
 #include <linux/mailbox_controller.h>
 #include <linux/mailbox_client.h>
@@ -113,6 +115,8 @@ struct pcc_chan_info {
 #define to_pcc_chan_info(c) container_of(c, struct pcc_chan_info, chan)
 static struct pcc_chan_info *chan_info;
 static int pcc_chan_count;
+/* Serializes PCC channel ownership changes with shared-memory teardown. */
+static DEFINE_MUTEX(pcc_mbox_lock);
 
 /*
  * PCC can be used with perf critical drivers such as CPPC
@@ -392,18 +396,23 @@ pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
 	if (subspace_id < 0 || subspace_id >= pcc_chan_count)
 		return ERR_PTR(-ENOENT);
 
+	mutex_lock(&pcc_mbox_lock);
+
 	pchan = chan_info + subspace_id;
 	chan = pchan->chan.mchan;
 	if (IS_ERR(chan) || chan->cl) {
 		pr_err("Channel not found for idx: %d\n", subspace_id);
-		return ERR_PTR(-EBUSY);
+		rc = -EBUSY;
+		goto err_unlock;
 	}
 
 	pcc_mchan = &pchan->chan;
 	pcc_mchan->shmem = acpi_os_ioremap(pcc_mchan->shmem_base_addr,
 					   pcc_mchan->shmem_size);
-	if (!pcc_mchan->shmem)
-		return ERR_PTR(-ENXIO);
+	if (!pcc_mchan->shmem) {
+		rc = -ENXIO;
+		goto err_unlock;
+	}
 
 	rc = pcc_mbox_validate_signature(pcc_mchan, subspace_id);
 	if (rc)
@@ -413,11 +422,14 @@ pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
 	if (rc)
 		goto err_unmap_shmem;
 
+	mutex_unlock(&pcc_mbox_lock);
 	return pcc_mchan;
 
 err_unmap_shmem:
 	iounmap(pcc_mchan->shmem);
 	pcc_mchan->shmem = NULL;
+err_unlock:
+	mutex_unlock(&pcc_mbox_lock);
 	return ERR_PTR(rc);
 }
 EXPORT_SYMBOL_GPL(pcc_mbox_request_channel);
@@ -436,14 +448,18 @@ void pcc_mbox_free_channel(struct pcc_mbox_chan *pchan)
 
 	if (!chan || !chan->cl)
 		return;
+	guard(mutex)(&pcc_mbox_lock);
+
 	pchan_info = chan->con_priv;
 	pcc_mbox_chan = &pchan_info->chan;
+
+	/* Disable and synchronize the channel IRQ before unmapping its data. */
+	mbox_free_channel(chan);
+
 	if (pcc_mbox_chan->shmem) {
 		iounmap(pcc_mbox_chan->shmem);
 		pcc_mbox_chan->shmem = NULL;
 	}
-
-	mbox_free_channel(chan);
 }
 EXPORT_SYMBOL_GPL(pcc_mbox_free_channel);
 
-- 
2.34.1

