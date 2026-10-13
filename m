Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B08509F11
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 16:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791909664; cv=none; b=kpCPfY+XtHo58omIY/mX/qwcBLjoid5iCUmefei4Ms5+2iLCAIgPAB9wIjRcQZyv3XaXAKXcihEC8OucBR61A7j/xN1/pjdxxdNNtRkap7AMtY22XLeS61A03qxAA38MTW3ezMpxgkg6Kv/zOH++if6jqe+20UIyIvurfXQNuY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791909664; c=relaxed/simple;
	bh=++mN1x0dGo3yE7pJT/kcQAiNg77cfvHxrfwVi/rCYYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YOjiuS8RO62jGp/wc335SwmpIpYEUTFSH9dP4xcl7nhZyjRdzAZMDIwqwcUY+GXzEIUx4kFSz3FUtJTM64nY8eEo94wnPDz3c/cSOERFgakyYe9o3tGo/ANWcMl0lf1fSZ/pEfZWEvjRAIwpC+Ou9OofO0X9JCEcs3oalLlifnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZtwjFR9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZtwjFR9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B02D1F000FF;
	Tue, 13 Oct 2026 16:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791909663;
	bh=MKIQ3n4zU92c/adj/P4BYo3W/gAfEQeUBqevETfGvvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LZtwjFR9I+Hmh6Gk6S0ZyhlNYvkGIwEKOMPy5NVUTn7o4d31geuHMGy5DFl8EuSe7
	 JC0jHXxZwRVcA0fGwagtNNPQyyGNok1O+3LO3flWKq2Vc4T6FYp3++cneo4c0jk6LO
	 cLBcRGM4iXx9ZAac3EAcRN1Tc7S37m8Yj3Ozuq8+Uv7cAZ89YYyblNdMnC3jV/+Fpf
	 aDLzmFFDYYWjPnGhI6u1thTy1lt3WJ1uC8cdbWta9fmH6+ROAfRS/AWudWkclE1pAy
	 n9FxtonCZuLwWQ9/INguziUgTHp3MFMUwPg8Nor7DtRXpO5rt/clhn4d8CIqPOsj50
	 d+xHqGcqdTrkg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Stanley Jhu <stanleyjhu@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Peter Wang <peter.wang@mediatek.com>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] scsi: ufs: core: Decouple CQ sweep from request iterator in MCQ
Date: Tue, 13 Oct 2026 12:41:01 -0400
Message-ID: <20261013164053.383937-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101231-tying-copartner-f09f@gregkh>
References: <2026101231-tying-copartner-f09f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stanley Jhu <stanleyjhu@google.com>

[ Upstream commit 469fa055664bfd8717b087a80d59c03055789c17 ]

In MCQ mode, ufshcd_mcq_compl_pending_transfer() uses
blk_mq_tagset_busy_iter() to iterate over busy requests during error
recovery and host reset. However, both iterator callbacks perform
whole-queue operations redundantly for each visited request:

 - force_compl == true: ufshcd_mcq_force_compl_one() calls
   ufshcd_mcq_compl_all_cqes_lock() on every busy request, sweeping the
   entire completion ring (hwq->max_entries slots) once per active request
   under spin_lock_irqsave even though the first sweep already cleared all
   completion entries.

 - force_compl == false: ufshcd_mcq_compl_one() acquires cq_lock and polls
   CQTPy over MMIO via ufshcd_mcq_poll_cqe_lock() for every busy request
   without doing any per-request work.

Sweep or poll each hardware queue (hba->uhq[i]) once at the start of
ufshcd_mcq_compl_pending_transfer(). When force_compl is true, run
blk_mq_tagset_busy_iter() afterward to complete residual in-flight
requests with DID_REQUEUE, and remove the now-unused
ufshcd_mcq_compl_one() callback.

Fixes: ab248643d3d6 ("scsi: ufs: core: Add error handling for MCQ mode")
Cc: stable@vger.kernel.org
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
Reviewed-by: Peter Wang <peter.wang@mediatek.com>
Link: https://patch.msgid.link/20260928035816.1294326-3-stanleyjhu@google.com
Signed-off-by: Martin K. Petersen (Oracle) <mkp@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ufs/core/ufshcd.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 368459dd8b3ff..5e42772095ce1 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -5639,7 +5639,17 @@ static void ufshcd_mcq_compl_pending_transfer(struct ufs_hba *hba,
 	struct scsi_cmnd *cmd;
 	unsigned long flags;
 	u32 hwq_num, utag;
-	int tag;
+	int tag, i;
+
+	for (i = 0; i < hba->nr_hw_queues; i++) {
+		if (force_compl)
+			ufshcd_mcq_compl_all_cqes_lock(hba, &hba->uhq[i]);
+		else
+			ufshcd_mcq_poll_cqe_lock(hba, &hba->uhq[i]);
+	}
+
+	if (!force_compl)
+		return;
 
 	for (tag = 0; tag < hba->nutrs; tag++) {
 		lrbp = &hba->lrb[tag];
@@ -5652,21 +5662,16 @@ static void ufshcd_mcq_compl_pending_transfer(struct ufs_hba *hba,
 		hwq_num = blk_mq_unique_tag_to_hwq(utag);
 		hwq = &hba->uhq[hwq_num];
 
-		if (force_compl) {
-			ufshcd_mcq_compl_all_cqes_lock(hba, hwq);
-			/*
-			 * For those cmds of which the cqes are not present
-			 * in the cq, complete them explicitly.
-			 */
-			if (cmd && !test_bit(SCMD_STATE_COMPLETE, &cmd->state)) {
-				spin_lock_irqsave(&hwq->cq_lock, flags);
-				set_host_byte(cmd, DID_REQUEUE);
-				ufshcd_release_scsi_cmd(hba, lrbp);
-				scsi_done(cmd);
-				spin_unlock_irqrestore(&hwq->cq_lock, flags);
-			}
-		} else {
-			ufshcd_mcq_poll_cqe_lock(hba, hwq);
+		/*
+		 * For those cmds of which the cqes are not present
+		 * in the cq, complete them explicitly.
+		 */
+		if (cmd && !test_bit(SCMD_STATE_COMPLETE, &cmd->state)) {
+			spin_lock_irqsave(&hwq->cq_lock, flags);
+			set_host_byte(cmd, DID_REQUEUE);
+			ufshcd_release_scsi_cmd(hba, lrbp);
+			scsi_done(cmd);
+			spin_unlock_irqrestore(&hwq->cq_lock, flags);
 		}
 	}
 }
-- 
2.53.0

