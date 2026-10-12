Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAA949B5D5
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791818528; cv=none; b=nKW/yMkIcQzlYbgznNTh5FaVxwhvVDY4lH7x/PUuPZWnRoBlAFiWi15FXq+oVWgvp05CC6xLIx5jSiikone/o0BrH3CBBeeWXjXAgldF1l9Yemwkay93Y0p7hO48sepLW2k4WuHG/FDxBMYe29jhuvw0JGWC6SLtxGhQNoPhV/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791818528; c=relaxed/simple;
	bh=cY/gsy4u1QMUGwaDRwRAvNOJfyPXVByYus4KLYEB0Vg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=c5gnaUEt6/lM4s9Tb1eJc/OVzCqLKN3LGGUAXM7pPKRY/qDI4FncblE9cqOl1gi+leLZOsR+ARtICmTlUXzjZvvRuNUIMzCXSfalMVe3HBkD0ImBM+I4pfkzfphnDXJIZeS1RkbXjDRc2zxA7p0qzGimoPmIbPrdsRuyY7gFW0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2GWnGO26; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2GWnGO26"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D4D01F0089D;
	Mon, 12 Oct 2026 15:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791818527;
	bh=6CdGVYipYTCvSojdbrZNNbuXt/C9DzYrTMLXeKdbXQc=;
	h=Subject:To:Cc:From:Date;
	b=2GWnGO26sdyy38U5/FWsYo+Hpau1OIVRjHWFvW/Q8mlqNiMXu2iFkcKWpercq4jFD
	 tm3tC47UM9lJcLygZda4CUoJh1sCvpRwp/qgIiryFFK9YYcGmzcfZJM8ez0XinoSSt
	 5ESN2s6xbMZIY/1s84MXwKySgWaLk+FGUbzNMw5A=
Subject: FAILED: patch "[PATCH] scsi: ufs: core: Avoid unsafe MMIO reads in" failed to apply to 6.18-stable tree
To: stanleyjhu@google.com,bvanassche@acm.org,mkp@kernel.org,peter.wang@mediatek.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Oct 2026 17:22:12 +0200
Message-ID: <2026101212-headpiece-alto-c398@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 375f3a5691dd46b5d05b90a8968872ec8b2248c5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101212-headpiece-alto-c398@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 375f3a5691dd46b5d05b90a8968872ec8b2248c5 Mon Sep 17 00:00:00 2001
From: Stanley Jhu <stanleyjhu@google.com>
Date: Mon, 28 Sep 2026 11:58:15 +0800
Subject: [PATCH] scsi: ufs: core: Avoid unsafe MMIO reads in
 ufshcd_mcq_compl_all_cqes_lock()

During MCQ host reset, ufshcd_host_reset_and_restore() stops the host
controller via ufshcd_hba_stop() (HCE = 0) before calling
ufshcd_complete_requests(hba, true) ->
ufshcd_mcq_compl_pending_transfer(hba, true) ->
ufshcd_mcq_force_compl_one() -> ufshcd_mcq_compl_all_cqes_lock().  Because
ufshcd_mcq_force_compl_one() is its sole caller,
ufshcd_mcq_compl_all_cqes_lock() always runs with HCE = 0.

Despite the comment above ufshcd_mcq_compl_all_cqes_lock() stating that
reading CQTPy may not be safe with the controller disabled, the function
still calls ufshcd_mcq_update_cq_tail_slot() at the end of its sweep:

 1. Unsafe CQTPy MMIO read:
    Calling ufshcd_mcq_update_cq_tail_slot() at the end of the sweep reads
    CQTPy over MMIO while HCE = 0, directly contradicting the function's
    documented contract (commit 1373df88d535 ("scsi: ufs: core: Add a
    comment block above ufshcd_mcq_compl_all_cqes_lock()")) that reading
    CQTPy may not be safe with the controller disabled.

 2. Spurious error logs on empty slots:
    Sweeping all max_entries slots visits empty entries where
    command_desc_base_addr is 0, causing ufshcd_mcq_process_cqe() to log
    unguarded dev_err(hba->dev, "Abnormal CQ entry!\n") messages.

Fix both issues in ufshcd_mcq_compl_all_cqes_lock():

 - Remove the ufshcd_mcq_update_cq_tail_slot() call and the redundant
   hwq->cq_head_slot = hwq->cq_tail_slot assignment without replacement.
   The two indices are already equal after the sweep: they are equal when
   the sweep starts, since ufshcd_mcq_poll_cqe_lock() consumes entries
   until cq_head_slot reaches cq_tail_slot, and the sweep advances
   cq_head_slot by exactly one full ring. Both indices are also
   reinitialized before the queue is reused.

 - Extract ufshcd_mcq_compl_cqe() and invoke it only on non-empty slots
   during full-ring sweeps, keeping "Abnormal CQ entry!" logging strictly
   for unexpected empty entries in ufshcd_mcq_poll_cqe_lock().

Fixes: ab248643d3d6 ("scsi: ufs: core: Add error handling for MCQ mode")
Cc: stable@vger.kernel.org
Reviewed-by: Peter Wang <peter.wang@mediatek.com>
Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Link: https://patch.msgid.link/20260928035816.1294326-2-stanleyjhu@google.com
Signed-off-by: Martin K. Petersen (Oracle) <mkp@kernel.org>

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index 8106d55f4041..df293b66350d 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -312,20 +312,24 @@ static int ufshcd_mcq_get_tag(struct ufs_hba *hba, struct cq_entry *cqe)
 		UFSHCD_NUM_RESERVED;
 }
 
+static void ufshcd_mcq_compl_cqe(struct ufs_hba *hba, struct cq_entry *cqe)
+{
+	int tag = ufshcd_mcq_get_tag(hba, cqe);
+
+	ufshcd_compl_one_cqe(hba, tag, cqe);
+	/* After processing the CQE, mark it as an empty (invalid) entry. */
+	cqe->command_desc_base_addr = 0;
+}
+
 static void ufshcd_mcq_process_cqe(struct ufs_hba *hba,
 				   struct ufs_hw_queue *hwq)
 {
 	struct cq_entry *cqe = ufshcd_mcq_cur_cqe(hwq);
 
-	if (cqe->command_desc_base_addr) {
-		int tag = ufshcd_mcq_get_tag(hba, cqe);
-
-		ufshcd_compl_one_cqe(hba, tag, cqe);
-		/* After processed the cqe, mark it empty (invalid) entry */
-		cqe->command_desc_base_addr = 0;
-	} else {
+	if (cqe->command_desc_base_addr)
+		ufshcd_mcq_compl_cqe(hba, cqe);
+	else
 		dev_err(hba->dev, "Abnormal CQ entry!\n");
-	}
 }
 
 /*
@@ -333,7 +337,7 @@ static void ufshcd_mcq_process_cqe(struct ufs_hba *hba,
  * controller disabled (HCE = 0). Reading host controller registers, e.g. the
  * CQ tail pointer (CQTPy), may not be safe with the host controller disabled.
  * Hence, iterate over all completion queue entries. This won't result in
- * double completions because ufshcd_mcq_process_cqe() clears a CQE after it
+ * double completions because ufshcd_mcq_compl_cqe() clears a CQE after it
  * has been processed.
  */
 void ufshcd_mcq_compl_all_cqes_lock(struct ufs_hba *hba,
@@ -344,13 +348,13 @@ void ufshcd_mcq_compl_all_cqes_lock(struct ufs_hba *hba,
 
 	spin_lock_irqsave(&hwq->cq_lock, flags);
 	while (entries > 0) {
-		ufshcd_mcq_process_cqe(hba, hwq);
+		struct cq_entry *cqe = ufshcd_mcq_cur_cqe(hwq);
+
+		if (cqe->command_desc_base_addr)
+			ufshcd_mcq_compl_cqe(hba, cqe);
 		ufshcd_mcq_inc_cq_head_slot(hwq);
 		entries--;
 	}
-
-	ufshcd_mcq_update_cq_tail_slot(hwq);
-	hwq->cq_head_slot = hwq->cq_tail_slot;
 	spin_unlock_irqrestore(&hwq->cq_lock, flags);
 }
 

