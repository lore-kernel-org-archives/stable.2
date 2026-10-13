Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36545208C2
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 15:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791905442; cv=none; b=VNMMStPSCV8z4KjK/Ld3GAbce0ZgTyGt8uABQen+2mqx08AXVZXUDj/gEk+acr1rWln6BQi1ZDjqyiPQJrwwvelBgG4+37qvEvz1VyLZ2MIc8JAKfw94pFDSFMEoAAGS0R0hpEXN76kJJo30Kc8Oc2/hIQI4K3LSjZSlGZEqgYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791905442; c=relaxed/simple;
	bh=vI1whC2UHr08PRNscHMjg9JWy5qJZ2+SmQizjamldDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ftw2vjVgFmeo7w04yOCqcaom0EoBD5kXtuYMhWaGDMHK/WeKQvRFNUY0mg7DG1D/1neVmNiPMn4KWpsx6vVeJt/f+o5DVpOt0kPZzmP70zgR3J8/tv8XTTe2YYn/SWDx0K5sbK4l5OmAX9aWO0Vf3lBF4OI1hh2bAeTNrDzTrkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayUOyNzh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayUOyNzh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E0261F000FF;
	Tue, 13 Oct 2026 15:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791905440;
	bh=H73THGAyHHVZIvksx970Dz9HsWhKYFU7fIHpG2gEznQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ayUOyNzhSJjpotvdOzXlwswPqYe6bQdfkzMBRVLb4seKAMHtKqNquSyp+tQ7LhAdi
	 cS57Ubz5UbAaFq/oTRFgGzn1Km47REjGHSvlEb6eE1YPdSO3xlPiCGIxPuaaQYELQS
	 BCBJm57kNpoghnOMa2iDvAu4Ix86vtd+UuR4VvtKplt7FLRqXbDPnWlsOd+Bl8VJ0p
	 9ujOCGmBn9VBrsx7Nt94iLmYPnz+WK1+u4ndhiPU/ePMl+quQWVE6o8kcPkAFdSUrI
	 MCeywA4/9+bnLEzWmKeLLbvzsWkwg9pu83PQRqhhsssGR6q81nf51abCV3ZrY3qrH/
	 iWHJsYNhKeTfA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Stanley Jhu <stanleyjhu@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Peter Wang <peter.wang@mediatek.com>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] scsi: ufs: core: Decouple CQ sweep from request iterator in MCQ
Date: Tue, 13 Oct 2026 11:30:38 -0400
Message-ID: <20261013153028.109176-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101228-dislike-clambake-14b0@gregkh>
References: <2026101228-dislike-clambake-14b0@gregkh>
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
index 8b011c26e9cbf..9ce72915657aa 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -5743,7 +5743,17 @@ static void ufshcd_mcq_compl_pending_transfer(struct ufs_hba *hba,
 	struct ufshcd_lrb *lrbp;
 	struct scsi_cmnd *cmd;
 	unsigned long flags;
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
@@ -5756,22 +5766,17 @@ static void ufshcd_mcq_compl_pending_transfer(struct ufs_hba *hba,
 		if (!hwq)
 			continue;
 
-		if (force_compl) {
-			ufshcd_mcq_compl_all_cqes_lock(hba, hwq);
-			/*
-			 * For those cmds of which the cqes are not present
-			 * in the cq, complete them explicitly.
-			 */
-			spin_lock_irqsave(&hwq->cq_lock, flags);
-			if (cmd && !test_bit(SCMD_STATE_COMPLETE, &cmd->state)) {
-				set_host_byte(cmd, DID_REQUEUE);
-				ufshcd_release_scsi_cmd(hba, lrbp);
-				scsi_done(cmd);
-			}
-			spin_unlock_irqrestore(&hwq->cq_lock, flags);
-		} else {
-			ufshcd_mcq_poll_cqe_lock(hba, hwq);
+		/*
+		 * For those cmds of which the cqes are not present
+		 * in the cq, complete them explicitly.
+		 */
+		spin_lock_irqsave(&hwq->cq_lock, flags);
+		if (cmd && !test_bit(SCMD_STATE_COMPLETE, &cmd->state)) {
+			set_host_byte(cmd, DID_REQUEUE);
+			ufshcd_release_scsi_cmd(hba, lrbp);
+			scsi_done(cmd);
 		}
+		spin_unlock_irqrestore(&hwq->cq_lock, flags);
 	}
 }
 
-- 
2.53.0

