Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D000471D01
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 15:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791905491; cv=none; b=jVrGNl4deNFA5sRs8MjfvWYWlhB9R0W9gsNWR+n7e5anbMLTOoq+72jeVNM1uEPAdoG95YwJ90E68+KUyvf97YWYJJFcvunvcIGP9JNZWEx1i7eBZreMhlutXGw9v0buWpp1VqFyvoKA58BF7M8VrjqWYsWeIm7WdH/vNSab0P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791905491; c=relaxed/simple;
	bh=3cF/2yphWy2OuyubQIJLs9JdgVYLX6ZzosOGqBvIT5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rjRb/4ahyrIcOsimQ+hPWUlAv4Kt6iYGvjzSwelDLe7w1dPTdjrZlVLQWaMVkXXYmq2yf+3aBIBD5gUvdPFZqhckjOgbKiIU+DvlvTnC0q5E45/HQ4+NdD5TC0GLLqr9iWwgU0ZZajm2OppkMyjtM+nZVa7Shfd89n+olqMJVgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VSg/sLQM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VSg/sLQM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C14D1F0089B;
	Tue, 13 Oct 2026 15:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791905490;
	bh=gw820KUZ8nWkTqDpCVHE5t9lUUNHSk0ZQrQcat+l3EY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VSg/sLQMyMwRqa9+GkVKH0t5Om89KhPL+LkKq9a/J5pcBHPq7Cf9F1FKTKE13l5Qi
	 u6QkRYezzhnngH0ZAhtWqzpNRPCXEtJwxpOtDmxISiXYfgBT3eGPW/5MdslQ4MiSPM
	 aXWzswF6KPjQQZQy5E5Nx7pfWy36ip7/O4VOUBR9/6k3W4fxFcjgacoUrFgSIGLsBX
	 usZU2Ura4qUWXva/TmU+aprvBLt1HB9o/shFzDxokcMq0I+LY4SvJNh/PnCsiSY9bJ
	 D/tikRkQS3ZybIBjaqoadeG299+jRkJBcPtcnCBxzOCMhuRwnFdQFx/Q3zDq3ptjCB
	 8A3Z4RVWthwSQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Stanley Jhu <stanleyjhu@google.com>,
	Peter Wang <peter.wang@mediatek.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 4/4] scsi: ufs: core: Avoid unsafe MMIO reads in ufshcd_mcq_compl_all_cqes_lock()
Date: Tue, 13 Oct 2026 11:31:26 -0400
Message-ID: <20261013153027.105962-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013153027.105962-1-sashal@kernel.org>
References: <2026101212-headpiece-alto-c398@gregkh>
 <20261013153027.105962-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stanley Jhu <stanleyjhu@google.com>

[ Upstream commit 375f3a5691dd46b5d05b90a8968872ec8b2248c5 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ufs/core/ufs-mcq.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index 51e3c65ba94b1..55a7647685b44 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -303,20 +303,24 @@ static int ufshcd_mcq_get_tag(struct ufs_hba *hba, struct cq_entry *cqe)
 	return div_u64(addr, ufshcd_get_ucd_size(hba));
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
@@ -324,7 +328,7 @@ static void ufshcd_mcq_process_cqe(struct ufs_hba *hba,
  * controller disabled (HCE = 0). Reading host controller registers, e.g. the
  * CQ tail pointer (CQTPy), may not be safe with the host controller disabled.
  * Hence, iterate over all completion queue entries. This won't result in
- * double completions because ufshcd_mcq_process_cqe() clears a CQE after it
+ * double completions because ufshcd_mcq_compl_cqe() clears a CQE after it
  * has been processed.
  */
 void ufshcd_mcq_compl_all_cqes_lock(struct ufs_hba *hba,
@@ -335,13 +339,13 @@ void ufshcd_mcq_compl_all_cqes_lock(struct ufs_hba *hba,
 
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
 
-- 
2.53.0

