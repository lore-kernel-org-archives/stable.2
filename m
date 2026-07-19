Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E92E291C10;
	Sun, 19 Jul 2026 10:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784456462; cv=none; b=gyFfMOJoJVg1CIqUwmZ02gQbvldEsKOZQYwcR4WgdrfHUsLrEci8yqqSxeXL5X4/GmHAhFEYgDKGBFTqPf1tGyrTr0QbOh4lIaZNVTmgRzeaYLYNcNiT66ndXMPBqLEEGYj3j1csDGmYlRdaDDYm3OGiMTbin/lxhEn19b8KQNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784456462; c=relaxed/simple;
	bh=YWNPSNHXhUMQZugFK/yG01ivnCUCqLg/UiD4aCM9rig=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LDnhbKnugPVne1f28PLtlBPy5FLa6Nw4UJgQVkXUT/S/931rubax14KF3HUuouWC5Djl5qHirCG6cGIxl35kx8IOTJaCDV/BxMtFk8fR1iQcEhAVt1zxLuP3NPANuAIWm9IMib7yETMtZKg5V5BpcwF17TCLFIfNvMTDVmkpW2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y8vwOk14; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y8vwOk14"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784456460; x=1815992460;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=YWNPSNHXhUMQZugFK/yG01ivnCUCqLg/UiD4aCM9rig=;
  b=Y8vwOk14n6skjEEe/pBWQjfath/Kez5pm6l77+vj5CdzSlH95Frl5rVM
   8/Ip1h8cubUBSoUg6GkWqzIP4ia3uJ02EHISRdKF3IQc+yKRjqf7IiqSN
   HqESB2m8uA4ZM4fgSjscw5YsDLWTk6NwN30swJVNMCSVmoq3clHfxQUqk
   vdSYm1jvfyGV/74EHOJG4C5zYdKV0dctZ6W8YQtgzRCpv5S/iRIb22FnP
   vBxoXwoems7xpIwjuI6FklCiLzPwDx4k1+6XS1KVWJpeeLvjVKTGdXvZk
   qXSqIN72Myq8T28KjXVc4iNcspEUH/Hg+M/F63o1rDkbd7TXWZSgOcGNG
   Q==;
X-CSE-ConnectionGUID: fec5N1BJTtWDBmHoGO35cw==
X-CSE-MsgGUID: iS0+1YJSS36/3RbluoQzqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11850"; a="84048444"
X-IronPort-AV: E=Sophos;i="6.25,172,1779174000"; 
   d="scan'208";a="84048444"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2026 03:20:59 -0700
X-CSE-ConnectionGUID: lwnsNq9wTgKc6rnz4TW7fw==
X-CSE-MsgGUID: i1O1v9PqTPygTM4MBmRGRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,172,1779174000"; 
   d="scan'208";a="252818198"
Received: from sannilnx-dsk.jer.intel.com (HELO [127.0.1.1]) ([10.12.231.107])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2026 03:20:56 -0700
From: Alexander Usyskin <alexander.usyskin@intel.com>
Date: Sun, 19 Jul 2026 12:57:55 +0300
Subject: [PATCH char-misc] mei: pull kvfree out of spinlock
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260719-kvfree_out_of_spinlock-v1-1-e07d6333bea7@intel.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqDMBBA0avIrBswLlL0KqWEOJnoYJvIjEpBv
 HvTLt/i/xOUhElhaE4QOli55Ap7awDnkCcyHKuhazvX3m1vliMJkS/75kvyunJ+FVxMGtEGjNE
 F56DGq1Diz3/8+J3EvFkRntf1BbRZiWZzAAAA
X-Change-ID: 20260719-kvfree_out_of_spinlock-fbc1acdd6a66
To: Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Tomas Winkler <tomasw@gmail.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Menachem Adin <menachem.adin@intel.com>, 
 Alexander Usyskin <alexander.usyskin@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784455091; l=3228;
 i=alexander.usyskin@intel.com; s=20260315; h=from:subject:message-id;
 bh=YWNPSNHXhUMQZugFK/yG01ivnCUCqLg/UiD4aCM9rig=;
 b=skAZhVLV2E4YBgbVTqlrKFjgeOIpFC6zP1QdOK1nBqDlhJUXDerbKKiO9EKbFXEuuzppSKCIO
 XtY/D89JFYXAxDUeIfHL0f3Kw+7g1kcX5+XAOzPaSfIPDwl90zMRSA9
X-Developer-Key: i=alexander.usyskin@intel.com; a=ed25519;
 pk=X+qoF/nFCdDOV04IForWSxnkyoCAbUE10egZi6PSfcU=

The read buffer allocation was changed from kmalloc() to kvmalloc().

This buffer is part of mei_cl_cb structure that can be queued in
rd_complete queue protected by spinlock.
Releasing the structure leads to errors like below when freeing buffer
that allocated non-contiguous:

BUG: sleeping function called from invalid context at mm/vmalloc.c:3448

Separate mei_cl_cb structure dequeue and release to
perform only dequeue under spinlock and push release out of spinlock.

Cc: stable@vger.kernel.org
Fixes: 4adf613e01bf ("mei: use kvmalloc for read buffer")
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/16359
Reviewed-by: Menachem Adin <menachem.adin@intel.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/misc/mei/client.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
index 643b0039cc72..26d2b2742d50 100644
--- a/drivers/misc/mei/client.c
+++ b/drivers/misc/mei/client.c
@@ -425,18 +425,24 @@ static void mei_io_tx_list_free_cl(struct list_head *head,
 }
 
 /**
- * mei_io_list_free_fp - free cb from a list that matches file pointer
+ * mei_io_rd_list_free_fp - free cb from a rd_completed list that matches file pointer
  *
- * @head: io list
+ * @cl: host client
  * @fp: file pointer (matching cb file object), may be NULL
  */
-static void mei_io_list_free_fp(struct list_head *head, const struct file *fp)
+static void mei_io_rd_list_free_fp(struct mei_cl *cl, const struct file *fp)
 {
 	struct mei_cl_cb *cb, *next;
+	LIST_HEAD(cmpl_list);
 
-	list_for_each_entry_safe(cb, next, head, list)
+	spin_lock(&cl->rd_completed_lock);
+	list_for_each_entry_safe(cb, next, &cl->rd_completed, list)
 		if (!fp || fp == cb->fp)
-			mei_io_cb_free(cb);
+			list_move(&cb->list, &cmpl_list);
+	spin_unlock(&cl->rd_completed_lock);
+
+	list_for_each_entry_safe(cb, next, &cmpl_list, list)
+		mei_io_cb_free(cb);
 }
 
 /**
@@ -565,9 +571,7 @@ int mei_cl_flush_queues(struct mei_cl *cl, const struct file *fp)
 		mei_io_list_flush_cl(&cl->dev->ctrl_rd_list, cl);
 		mei_cl_free_pending(cl);
 	}
-	spin_lock(&cl->rd_completed_lock);
-	mei_io_list_free_fp(&cl->rd_completed, fp);
-	spin_unlock(&cl->rd_completed_lock);
+	mei_io_rd_list_free_fp(cl, fp);
 
 	return 0;
 }
@@ -1401,7 +1405,7 @@ void mei_cl_add_rd_completed(struct mei_cl *cl, struct mei_cl_cb *cb)
 }
 
 /**
- * mei_cl_del_rd_completed - free read completed callback with lock
+ * mei_cl_del_rd_completed - unlink read completed callback with lock and free it
  *
  * @cl: host client
  * @cb: callback block
@@ -1410,8 +1414,9 @@ void mei_cl_add_rd_completed(struct mei_cl *cl, struct mei_cl_cb *cb)
 void mei_cl_del_rd_completed(struct mei_cl *cl, struct mei_cl_cb *cb)
 {
 	spin_lock(&cl->rd_completed_lock);
-	mei_io_cb_free(cb);
+	list_del_init(&cb->list);
 	spin_unlock(&cl->rd_completed_lock);
+	mei_io_cb_free(cb);
 }
 
 /**

---
base-commit: 775553d19b163446c38c5ff24dd0a01065376932
change-id: 20260719-kvfree_out_of_spinlock-fbc1acdd6a66

Best regards,
-- 
Alexander Usyskin <alexander.usyskin@intel.com>

