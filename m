Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1FE2D7BF
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 02:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785292231; cv=none; b=cO4HX6HOQ9bdolE3dpicRdZUHo4UbLeY/AvonftyK6cC4d+mdEBdf8z5/d/aJapFjM65VEczvZinq75olbLbCMplAlv77k10LfILvB7BYzz/uht/B+ypJ6fqeGuHYRBfpsxgL6ZZ83IM+OlvSpxee+To7NyekLIaXVo255iePX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785292231; c=relaxed/simple;
	bh=+4LQUHgvF1zMBDv67Ixm2ggF5AWY6XEpR73LfEjtx4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B0RfQk9ULDZKMvzRVGuVtQE5IdryAfixH49HJwu+pLg/vP52LNFAFmM/iddo03DEw2NgCozBI1tiW/6zFwVx1QOGuOpNHhNihCTCY+lDpBWAcEfiBQQEhjLcNa+tJKaD0cbDtY+QlleqE1A+dTr20ft7cocx4fxz/AQbVLo/xm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9qc9qEl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9qc9qEl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED9F1F000E9;
	Wed, 29 Jul 2026 02:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785292230;
	bh=BOsZPSkIDg90LMCvBUyMQZxWML46v/aVhqWZjU2eRio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q9qc9qEls59Y2yQbyF/eVpQDe8zIp5X05YE6VgpW3+mh1P+Gie12Ie96CXp6kj183
	 MbyIzr71GoCAu/1m7mNL2Y+yoMSGiRSJkv/KHRjfp3SAfHOo7CQYYm7yr0RRv7QLGI
	 9gjweUKqniWntxNBEV4XqHXujUzBU1YweWgKHBfiyPOrP8xzvmWrbMJghS+nCdQRV1
	 gZ6er3vXN1aO1t5JCJLOp8MAaqMhX42hn4QEHOWfjxLsQE/ECW5f+pth7ZLrv3AhDO
	 MGW5LLkG8SA3hpUWw7PtDxuRhrRY7MOly3o0g3WVqEHX9485qNf2KioUsMva/wNjaI
	 oQHD3FSjGq83w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dawei Feng <dawei.feng@seu.edu.cn>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] octeontx2-pf: fix SQB pointer leak on init failure
Date: Tue, 28 Jul 2026 22:30:28 -0400
Message-ID: <20260729023028.1114866-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072127-dwelling-chop-ba5d@gregkh>
References: <2026072127-dwelling-chop-ba5d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dawei Feng <dawei.feng@seu.edu.cn>

[ Upstream commit 62e7df6d042aeebd5efb581074e28865c04477be ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c    | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index c4f5635284ef6f..2e508e277f5167 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1443,13 +1443,13 @@ static void otx2_free_sq_res(struct otx2_nic *pf)
 	otx2_sq_free_sqbs(pf);
 	for (qidx = 0; qidx < otx2_get_total_tx_queues(pf); qidx++) {
 		sq = &qset->sq[qidx];
-		/* Skip freeing Qos queues if they are not initialized */
-		if (!sq->sqe)
-			continue;
-		qmem_free(pf->dev, sq->sqe);
-		qmem_free(pf->dev, sq->tso_hdrs);
-		qmem_free(pf->dev, sq->timestamps);
-		kfree(sq->sg);
+		/* sq->sqe is not initialized for unused QoS queues */
+		if (sq->sqe) {
+			qmem_free(pf->dev, sq->sqe);
+			qmem_free(pf->dev, sq->tso_hdrs);
+			qmem_free(pf->dev, sq->timestamps);
+			kfree(sq->sg);
+		}
 		kfree(sq->sqb_ptrs);
 	}
 }
@@ -1575,13 +1575,12 @@ static int otx2_init_hw_resources(struct otx2_nic *pf)
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
-- 
2.53.0

