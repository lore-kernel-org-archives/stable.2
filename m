Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393033314AC
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 03:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785297203; cv=none; b=Afu2mVVNEbyI+0flpFwVF8jx3ywDrBfMnQSnhBXaUYtvFQA6bz2yRg1PUsY9We807eQRDFv4TDz2gyaFNKgFqVPnBOKBpDD7tV+TJmIr9hpRqgbPkkOeCWaf2iIC3JEnoVAboGUaXj7mKWqp6hdLmS09bH+n+PQDDVx9+FIPUbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785297203; c=relaxed/simple;
	bh=5ASng0orAge6sDQmPl7M22BJdl9FWWAW9FnTFwG9Ogc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EodEK3+r8SW/AQBUBPkRK6RyGFqbLSAJ1501Z+0U0AqiWPpzQdGuLzqnjU9xmLJMs7WOze5xQKajyfrtTiFD2LJOdtrpvDkvyd9Um5YZ8u9mtLMOLsH0Ey5FzEToXY/LKmjBz6F1XNIA+jizRV5iNOgWuL/NFMiLqZ/GZuW0YJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUDc8s7j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUDc8s7j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B74E1F000E9;
	Wed, 29 Jul 2026 03:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785297202;
	bh=bNQ5jfRILQb/S9vKjXnANufX/zQMjZVJMH8Pg4h+Vo0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZUDc8s7j73vZiFodtiecUUoDbDDND+yBbmO3qaEK3i2jckS79gQPQ/8mBMrgDqb3W
	 hoyhJR1ram9ZHk247HW/8xDrJIBhxywyqMJYyYjO+6eFH+khRbwmrhYOMST7SsOtkq
	 PUwz27mGCvSCYBfFjXdmW96FFqfQRl/8c4wpifthHeOD4pDHTLgvJXJlWVNgp2sr0h
	 1AOf3dCw2RZTEuRf/hYHgt4IhCooNtFQc3AdBAN9OWoZuhhzCiGf9DIOaZEwOMO/YE
	 FTxWM4Y32elDi2pgUp8p0qEqzPnY085pbgGLT1ODiBJ4CXhUNBzBJfRG0wFsapt/iA
	 Qac2RoT/A+x6w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dawei Feng <dawei.feng@seu.edu.cn>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] octeontx2-pf: fix SQB pointer leak on init failure
Date: Tue, 28 Jul 2026 23:53:20 -0400
Message-ID: <20260729035320.1379417-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072128-crispness-skyrocket-cba6@gregkh>
References: <2026072128-crispness-skyrocket-cba6@gregkh>
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
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 49f21c7f5c1fd1..8cea8b252ce612 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1554,13 +1554,12 @@ static int otx2_init_hw_resources(struct otx2_nic *pf)
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

