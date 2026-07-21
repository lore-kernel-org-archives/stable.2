Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856133C73F6
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 09:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784625227; cv=none; b=tuNKCwgF5P9GfsJfxY9xxga2z8qLNxnmxF4gAeyemxHSiHvzU5NFWKE37IThWctAUfF94OY4PcuG7ax+CMeijaAnXQ15YDZPx5oojNMBLrr98TsHbMFDEu3J4ucyof5HfmSIbbnFKEq3mO+7IGE1NegpXzzg4105FqPwDpU3800=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784625227; c=relaxed/simple;
	bh=+ECJXtsPC/SBZp29Y9L0lDWEYHPH4X4Xk2aX+Y8iR8g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZmnFT5qf9ltkAD2dC5iTl1TsUfreSZEue4C5GStHakm4hEmB+Nkcx5bi4/jdmTa97Dt6+0dU9UCNmM/UNCvi6Y4j09rgD8ftfw63Dr2Za6FUol4hg7DhkEh32MsmUzeirckKNxXoV0U0QEPERciD4QuqP6c3ZcsKgef9zXCV14s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BMc/r1Ik; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BMc/r1Ik"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8EF1F000E9;
	Tue, 21 Jul 2026 09:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784625226;
	bh=TjOC7N/fyOtQEUl9ceDCRBUxbW8XlY+WblPvAg1B3Eo=;
	h=Subject:To:Cc:From:Date;
	b=BMc/r1Ik7rq4pH/SUkbN7sBoqUJIcwmnmGhQbvTsgiISS1Q5lQkHPItRIJiXoPOph
	 hzPYjaft3DGYTo7ReWj0kF7Ly27qVZtMT6/rZBfIomgqvNRSySkJibLGneXBpIbAcE
	 8U+jgwnQYskwP8O11y4Wjdj88J+KAzhOFY+mSjKg=
Subject: FAILED: patch "[PATCH] octeontx2-pf: fix SQB pointer leak on init failure" failed to apply to 5.15-stable tree
To: dawei.feng@seu.edu.cn,pabeni@redhat.com,rkannoth@marvell.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 21 Jul 2026 11:13:28 +0200
Message-ID: <2026072128-robotics-duplicate-a186@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 62e7df6d042aeebd5efb581074e28865c04477be
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072128-robotics-duplicate-a186@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 62e7df6d042aeebd5efb581074e28865c04477be Mon Sep 17 00:00:00 2001
From: Dawei Feng <dawei.feng@seu.edu.cn>
Date: Tue, 30 Jun 2026 15:16:25 +0800
Subject: [PATCH] octeontx2-pf: fix SQB pointer leak on init failure

otx2_init_hw_resources() initializes SQ aura and pool resources before
several later setup steps. On failure, err_free_sq_ptrs only frees SQB
pages, leaving the per-SQ sqb_ptrs arrays behind.

Use otx2_free_sq_res() for the SQ unwind path and let it free sqb_ptrs
even when sq->sqe has not been allocated yet.

The bug was first flagged by an experimental analysis tool we are
developing for kernel memory-management bugs while analyzing
v6.13-rc1. The tool is still under development and is not yet publicly
available. Manual inspection confirms that the bug is still
present in v7.1.1.

An x86_64 allyesconfig build showed no new warnings. As we do not have an
OcteonTX2 PF device and the corresponding AF mailbox setup to test with,
no runtime testing was able to be performed.

Fixes: caa2da34fd25 ("octeontx2-pf: Initialize and config queues")
Cc: stable@vger.kernel.org
Reviewed-by: Ratheesh Kannoth <rkannoth@marvell.com>
Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
Link: https://patch.msgid.link/20260630071625.349996-1-dawei.feng@seu.edu.cn
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index b63df5737ff2..88ac85354445 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1568,15 +1568,15 @@ static void otx2_free_sq_res(struct otx2_nic *pf)
 	otx2_sq_free_sqbs(pf);
 	for (qidx = 0; qidx < otx2_get_total_tx_queues(pf); qidx++) {
 		sq = &qset->sq[qidx];
-		/* Skip freeing Qos queues if they are not initialized */
-		if (!sq->sqe)
-			continue;
-		qmem_free(pf->dev, sq->sqe);
-		qmem_free(pf->dev, sq->sqe_ring);
-		qmem_free(pf->dev, sq->cpt_resp);
-		qmem_free(pf->dev, sq->tso_hdrs);
-		qmem_free(pf->dev, sq->timestamps);
-		kfree(sq->sg);
+		/* sq->sqe is not initialized for unused QoS queues */
+		if (sq->sqe) {
+			qmem_free(pf->dev, sq->sqe);
+			qmem_free(pf->dev, sq->sqe_ring);
+			qmem_free(pf->dev, sq->cpt_resp);
+			qmem_free(pf->dev, sq->tso_hdrs);
+			qmem_free(pf->dev, sq->timestamps);
+			kfree(sq->sg);
+		}
 		kfree(sq->sqb_ptrs);
 	}
 }
@@ -1711,13 +1711,12 @@ int otx2_init_hw_resources(struct otx2_nic *pf)
 	return err;
 
 err_free_nix_queues:
-	otx2_free_sq_res(pf);
 	otx2_free_cq_res(pf);
 	otx2_ctx_disable(mbox, NIX_AQ_CTYPE_RQ, false);
 err_free_txsch:
 	otx2_txschq_stop(pf);
 err_free_sq_ptrs:
-	otx2_sq_free_sqbs(pf);
+	otx2_free_sq_res(pf);
 err_free_rq_ptrs:
 	otx2_free_aura_ptr(pf, AURA_NIX_RQ);
 	otx2_ctx_disable(mbox, NPA_AQ_CTYPE_POOL, true);

