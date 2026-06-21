Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0005E4C6D;
	Sun, 21 Jun 2026 13:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782048204; cv=none; b=lWBt7h6tLDkWMjk1b1RTeHtWEfTpWMvH3fpHb20qdEB0ARPzcQVvQmdUM80qosaNzVZ4q/pSTLyjmvRpQIavHWo94o/AonBLPw4pfYxJbRZvOWqc62Khr4on9VcFlP1eTR4VEmIJw3367H1Lh17+wLXrMJkQPMJnSPIS+M19Ycg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782048204; c=relaxed/simple;
	bh=kAwJ6DKEdnzoA7kZnXRzifN5TMZTP6bnM1YivJnDrac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fhSknTs6a4y4TRH3GN2wFRcObF1B9kl3i4i1dUtHoX2Xfx1/EB0i8epbZBsWNjzXFdlF4s/C4jDyluPTI84BXUWW1MWd7rqt5FlGyZYMesZyZ2/+DgivgriaDLMu24bx8JoReYYzMdjSMcQlQNCzswPfzUJuFiNW7qXgoXqvSZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NACtc2+9; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NACtc2+9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782048202; x=1813584202;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kAwJ6DKEdnzoA7kZnXRzifN5TMZTP6bnM1YivJnDrac=;
  b=NACtc2+9i31+7Dtkzg9uvg8zQZ1YfLAuVGmRb9Rpc+QYrxwRx1aALLh+
   OcBUkPCAlNwHg64qb6oXy/vDVY+e1TcQ6cRFEJsvAZhfqoiOMivwMep+9
   fC34P03UnCmLdOzzw/Uz6P8F+/TSTYljIdvQFt5OHOIjmOxkmiyeuiFRo
   Wk04nFXp5gpfdf/05iVkVQiU+oTAQP4qlp0h3dRSMvSvP7Oc9713qPDK4
   fs+3Sl0oeBvBzdu1S8YG3mDd4TSw5gYMSnPSd8tahufaTjj6ZtPKPjC8N
   9aiXN0mV0rVwYy5OahU+BoQ5lm49aGN0k8DaICWspwyp2EPOvweYBHeYu
   w==;
X-CSE-ConnectionGUID: jgLDUdHhThiNWwrTOJLJeA==
X-CSE-MsgGUID: zPoJ7QpWRX+Api2xJdVTmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11824"; a="82809816"
X-IronPort-AV: E=Sophos;i="6.24,217,1774335600"; 
   d="scan'208";a="82809816"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2026 06:23:21 -0700
X-CSE-ConnectionGUID: O2cKxBHrTrWhRBRryrkrXw==
X-CSE-MsgGUID: 8zcIcqfYQsmfkmLIl7NGFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,217,1774335600"; 
   d="scan'208";a="254090004"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2026 06:23:20 -0700
From: Alexander Usyskin <alexander.usyskin@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Menachem Adin <menachem.adin@intel.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [char-misc] mei: replace spinlock with mutex for kvfree
Date: Sun, 21 Jun 2026 16:00:07 +0300
Message-ID: <20260621130007.1314562-1-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The read buffer allocation that protected by spinlock was
changed from kmalloc() to kvmalloc().
This buffer is part of structure protected by spinlock.
That leads to errors like below when freeing buffer
that allocated non-contiguous:

BUG: sleeping function called from invalid context at mm/vmalloc.c:3448

Replace spinlock with mutex to allow non-contiguous free that can wait.

Cc: stable@vger.kernel.org
Fixes: 4adf613e01bf ("mei: use kvmalloc for read buffer")
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/16359
Reviewed-by: Menachem Adin <menachem.adin@intel.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/misc/mei/client.c  | 37 ++++++++++++++++---------------------
 drivers/misc/mei/mei_dev.h |  7 ++++---
 2 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
index 643b0039cc72..1da4fc8d028e 100644
--- a/drivers/misc/mei/client.c
+++ b/drivers/misc/mei/client.c
@@ -4,14 +4,15 @@
  * Intel Management Engine Interface (Intel MEI) Linux driver
  */
 
-#include <linux/sched/signal.h>
-#include <linux/wait.h>
+#include <linux/cleanup.h>
+#include <linux/mei.h>
+#include <linux/mutex.h>
+#include <linux/dma-mapping.h>
 #include <linux/delay.h>
-#include <linux/slab.h>
 #include <linux/pm_runtime.h>
-#include <linux/dma-mapping.h>
-
-#include <linux/mei.h>
+#include <linux/slab.h>
+#include <linux/sched/signal.h>
+#include <linux/wait.h>
 
 #include "mei_dev.h"
 #include "hbm.h"
@@ -527,16 +528,12 @@ struct mei_cl_cb *mei_cl_enqueue_ctrl_wr_cb(struct mei_cl *cl, size_t length,
 struct mei_cl_cb *mei_cl_read_cb(struct mei_cl *cl, const struct file *fp)
 {
 	struct mei_cl_cb *cb;
-	struct mei_cl_cb *ret_cb = NULL;
 
-	spin_lock(&cl->rd_completed_lock);
+	guard(mutex)(&cl->rd_completed_lock);
 	list_for_each_entry(cb, &cl->rd_completed, list)
-		if (!fp || fp == cb->fp) {
-			ret_cb = cb;
-			break;
-		}
-	spin_unlock(&cl->rd_completed_lock);
-	return ret_cb;
+		if (!fp || fp == cb->fp)
+			return cb;
+	return NULL;
 }
 
 /**
@@ -565,9 +562,9 @@ int mei_cl_flush_queues(struct mei_cl *cl, const struct file *fp)
 		mei_io_list_flush_cl(&cl->dev->ctrl_rd_list, cl);
 		mei_cl_free_pending(cl);
 	}
-	spin_lock(&cl->rd_completed_lock);
+
+	guard(mutex)(&cl->rd_completed_lock);
 	mei_io_list_free_fp(&cl->rd_completed, fp);
-	spin_unlock(&cl->rd_completed_lock);
 
 	return 0;
 }
@@ -586,7 +583,7 @@ static void mei_cl_init(struct mei_cl *cl, struct mei_device *dev)
 	init_waitqueue_head(&cl->tx_wait);
 	init_waitqueue_head(&cl->ev_wait);
 	INIT_LIST_HEAD(&cl->vtag_map);
-	spin_lock_init(&cl->rd_completed_lock);
+	mutex_init(&cl->rd_completed_lock);
 	INIT_LIST_HEAD(&cl->rd_completed);
 	INIT_LIST_HEAD(&cl->rd_pending);
 	INIT_LIST_HEAD(&cl->link);
@@ -1395,9 +1392,8 @@ void mei_cl_add_rd_completed(struct mei_cl *cl, struct mei_cl_cb *cb)
 		mei_cl_read_vtag_add_fc(cl);
 	}
 
-	spin_lock(&cl->rd_completed_lock);
+	guard(mutex)(&cl->rd_completed_lock);
 	list_add_tail(&cb->list, &cl->rd_completed);
-	spin_unlock(&cl->rd_completed_lock);
 }
 
 /**
@@ -1409,9 +1405,8 @@ void mei_cl_add_rd_completed(struct mei_cl *cl, struct mei_cl_cb *cb)
  */
 void mei_cl_del_rd_completed(struct mei_cl *cl, struct mei_cl_cb *cb)
 {
-	spin_lock(&cl->rd_completed_lock);
+	guard(mutex)(&cl->rd_completed_lock);
 	mei_io_cb_free(cb);
-	spin_unlock(&cl->rd_completed_lock);
 }
 
 /**
diff --git a/drivers/misc/mei/mei_dev.h b/drivers/misc/mei/mei_dev.h
index d8634a726990..ca19b4e45ac9 100644
--- a/drivers/misc/mei/mei_dev.h
+++ b/drivers/misc/mei/mei_dev.h
@@ -7,11 +7,12 @@
 #ifndef _MEI_DEV_H_
 #define _MEI_DEV_H_
 
-#include <linux/types.h>
 #include <linux/cdev.h>
-#include <linux/poll.h>
 #include <linux/mei.h>
 #include <linux/mei_cl_bus.h>
+#include <linux/mutex.h>
+#include <linux/poll.h>
+#include <linux/types.h>
 
 static inline int uuid_le_cmp(const uuid_le u1, const uuid_le u2)
 {
@@ -314,7 +315,7 @@ struct mei_cl {
 	u8 tx_cb_queued;
 	enum mei_file_transaction_states writing_state;
 	struct list_head rd_pending;
-	spinlock_t rd_completed_lock; /* protects rd_completed queue */
+	struct mutex rd_completed_lock; /* protects rd_completed queue */
 	struct list_head rd_completed;
 	struct mei_dma_data dma;
 	u8 dma_mapped;
-- 
2.53.0

