Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B563C7691
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 09:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784625224; cv=none; b=dc3TaGGysxNyjBQ+dfhI7pUMoAIV8KgP1kkR39J6LmSRaDhADyLgEWcGacSOgpoGDyytYVpNyp4bZ3HsMXdEfvAJU+NHZgi8G8ZEA0Sv6M1+PUeDQpMc8G7YRu7qCJofOzYXkcV3xYs2Muma6PQkjt3W921KIhmdBE5e6eKWtrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784625224; c=relaxed/simple;
	bh=5cbaS9ARsdPzY/bwMrJY1npxZKxBTyGlXNGdFPe9xNg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=o/OTQaq5O7PXpGB7jTzukSMexfJVt4C20Tyab8vtut+G2LYaDrn6FEDW8tlZ+Swzs65K9jj1eqKeFkPMTBjSnldNROj/VRVyUUV7pZ+6nC1pLvLlflGShkj8cR/WyUWvplaQ8JL+jpnal9rAzTr/MhoegTmwGaxQ5Xtfdnar2mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FV7L+MuN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FV7L+MuN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 276D51F000E9;
	Tue, 21 Jul 2026 09:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784625223;
	bh=R/fyWDrpvYZEJn4eLpuxX6ncbya5UYaGwnzQuD1ra2Y=;
	h=Subject:To:Cc:From:Date;
	b=FV7L+MuNeVlGeM0MkBKZoHuXTIQ/JlAEGLS4f9N7g3UGtpnVUxa9ORbOd5yIJi2Bl
	 1ZBQdBygJNP+hMEAa1Jeg4Kj5sazITQXcTw9RZZ0OauMbONTWZvy2xIKm+7AwSc2w6
	 YjwNzpbzoQCPvJYumNTwDFMpFcjT9F/pN5Mo1aeo=
Subject: FAILED: patch "[PATCH] octeontx2-pf: fix SQB pointer leak on init failure" failed to apply to 6.12-stable tree
To: dawei.feng@seu.edu.cn,pabeni@redhat.com,rkannoth@marvell.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 21 Jul 2026 11:13:27 +0200
Message-ID: <2026072127-glitch-eel-f400@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 62e7df6d042aeebd5efb581074e28865c04477be
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072127-glitch-eel-f400@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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

