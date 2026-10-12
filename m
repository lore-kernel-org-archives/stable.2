Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E32E49B5A6
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791818550; cv=none; b=mGZClkwb+QjHyZ6apdYqjsoy0mN/IqGhyElnu7uD2XKDewdEf+yhFWat747ckzu4XMqzrz28d+ecH9V59Ep91yonEt1VwZ6DimHqjGeiaes4Sw4gKY9Tku7XeV0J2Jfzql+sQ+3V4CshWI99Wqurhi/CHjRf6YB1ISwXRYfjh3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791818550; c=relaxed/simple;
	bh=RpMy76BFwUnsbWk1zBJE2486zFFFeV/Kkfds9x0x0Ms=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Df6ZkH5c3fOqt396rEhpuVX/zDEG607RRbCB9q6dLhGXN43lqgh/fef3hwZvB/5H71PI7L4X5eVQ0SJoFBbbdkl3H4wo5ux1rZwsxvxgDGshx+eebKYm8efGybbv5vNrB4wHnRN/MmhkZpw32nIxBJcmukGMp4lm5/pHB2fz8D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f6yh11Dl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f6yh11Dl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 682721F0089B;
	Mon, 12 Oct 2026 15:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791818548;
	bh=ivFop1z0yxBy3ey6SiMBqxmxnNYNmtC4JCHDUZUHa1M=;
	h=Subject:To:Cc:From:Date;
	b=f6yh11DlBwNa2CW5mn2QbQUytBrevyVxYnHNC+qyAFncFRTIgQwdePyZgwwHcFJ4f
	 3lEwQdeFgfJcMfkOzZYAj6CUu2D5Dvkkkr//gbt8dApH4BnjeYfPKKmNM0Q9uCVSyn
	 b7wDormcXWk0+JG442Y+JGz2dYlCzTa2A0FDs3cI=
Subject: FAILED: patch "[PATCH] scsi: ufs: core: Decouple CQ sweep from request iterator in" failed to apply to 6.6-stable tree
To: stanleyjhu@google.com,bvanassche@acm.org,mkp@kernel.org,peter.wang@mediatek.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Oct 2026 17:22:31 +0200
Message-ID: <2026101231-tying-copartner-f09f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 469fa055664bfd8717b087a80d59c03055789c17
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101231-tying-copartner-f09f@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 469fa055664bfd8717b087a80d59c03055789c17 Mon Sep 17 00:00:00 2001
From: Stanley Jhu <stanleyjhu@google.com>
Date: Mon, 28 Sep 2026 11:58:16 +0800
Subject: [PATCH] scsi: ufs: core: Decouple CQ sweep from request iterator in
 MCQ

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

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 79b6a2d9b522..ca8329052cbc 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -6044,8 +6044,6 @@ static bool ufshcd_mcq_force_compl_one(struct request *rq, void *priv)
 	if (blk_mq_is_reserved_rq(rq) || !hwq)
 		return true;
 
-	ufshcd_mcq_compl_all_cqes_lock(hba, hwq);
-
 	/*
 	 * For those cmds of which the cqes are not present in the cq, complete
 	 * them explicitly.
@@ -6061,19 +6059,6 @@ static bool ufshcd_mcq_force_compl_one(struct request *rq, void *priv)
 	return true;
 }
 
-static bool ufshcd_mcq_compl_one(struct request *rq, void *priv)
-{
-	struct scsi_device *sdev = rq->q->queuedata;
-	struct Scsi_Host *shost = sdev->host;
-	struct ufs_hba *hba = shost_priv(shost);
-	struct ufs_hw_queue *hwq = ufshcd_mcq_req_to_hwq(hba, rq);
-
-	if (!blk_mq_is_reserved_rq(rq) && hwq)
-		ufshcd_mcq_poll_cqe_lock(hba, hwq);
-
-	return true;
-}
-
 /**
  * ufshcd_mcq_compl_pending_transfer - MCQ mode function. It is
  * invoked from the error handler context or ufshcd_host_reset_and_restore()
@@ -6088,10 +6073,18 @@ static bool ufshcd_mcq_compl_one(struct request *rq, void *priv)
 static void ufshcd_mcq_compl_pending_transfer(struct ufs_hba *hba,
 					      bool force_compl)
 {
-	blk_mq_tagset_busy_iter(&hba->host->tag_set,
-				force_compl ? ufshcd_mcq_force_compl_one :
-					      ufshcd_mcq_compl_one,
-				NULL);
+	int i;
+
+	for (i = 0; i < hba->nr_hw_queues; i++) {
+		if (force_compl)
+			ufshcd_mcq_compl_all_cqes_lock(hba, &hba->uhq[i]);
+		else
+			ufshcd_mcq_poll_cqe_lock(hba, &hba->uhq[i]);
+	}
+
+	if (force_compl)
+		blk_mq_tagset_busy_iter(&hba->host->tag_set,
+					ufshcd_mcq_force_compl_one, NULL);
 }
 
 /**

