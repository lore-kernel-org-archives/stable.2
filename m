Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FDB3B0584
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 15:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785340318; cv=none; b=joylpG2N4kZ6ofgYwtWQ2Ir/FqbM/yr9eXTnFyILrSnlqV55Glb3gnT5Jc6fQHfHYdfOXkcgUqrdAjP1uE7u6zO0RfyH1qZCgIraSrx2X2qGluxr93IwwR2qSSHKvCr+RNP13wTdKmqt0QgivRBT1Nw2elsiMlMuzoGLfi7Cwek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785340318; c=relaxed/simple;
	bh=z9a8dpXnxK6LM7X5xtcCBgiMSgE9slgNHhA+s4UpFLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r6fH3Ci4WA68ckgo6hZ/f/yhPmb8Qd6NYQIv7x61YzgYN8oKWXHXuYKgSihtqzImVK5AsgRhliqXs6q7BrJvfV1mbNLAWYvSYrDykBhShhzYHkqGXCZKSbBhC41KVKx41Yk/ow8c9jujlHsJg6207U4WOLF5N8DzFlKQNkEgO9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NRwhjLXq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRwhjLXq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B1501F000E9;
	Wed, 29 Jul 2026 15:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785340317;
	bh=0kvOojuw2LB8/Q9sOFgzscP40mBHyjtDz8eUiv+MUi4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NRwhjLXqG2NDFm5SvYlbVyPVBfLJnKI3XcEwOp0p0wIi3wCxeTRN3WwxhmEM2ontZ
	 P9TgGAUVkOSzilLyxQhK6XYPc+vcy7cKMjcCXBO51FOiuxiaxJubF2pRSOuKTEQm4t
	 a5ENZT8vJGQt4/Kh5mS5BaaUohOgjE48Eso60jp336OCLYM9QR+O7qguA2T2omgwxr
	 JXXkxcsppPM9R1TeOYBIAAyWciqnsBu3KwI6KRV8IoBkVjaZStAMIJPBhuVvXZwL86
	 hY13JR5iXNDGsjgqP6ylQEjks1Dbui9rqtdsxsXfPuZ9j1PYUvxvA7UQLAx+Ghxp6i
	 8HnZ5x/cXDOFA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dawei Feng <dawei.feng@seu.edu.cn>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] octeontx2-pf: fix SQB pointer leak on init failure
Date: Wed, 29 Jul 2026 11:51:53 -0400
Message-ID: <20260729155153.3488733-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072128-robotics-duplicate-a186@gregkh>
References: <2026072128-robotics-duplicate-a186@gregkh>
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
index 9d39b9fc2f6a8d..674e9aa1b19cd9 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1485,14 +1485,13 @@ static int otx2_init_hw_resources(struct otx2_nic *pf)
 	return err;
 
 err_free_nix_queues:
-	otx2_free_sq_res(pf);
 	otx2_free_cq_res(pf);
 	otx2_ctx_disable(mbox, NIX_AQ_CTYPE_RQ, false);
 err_free_txsch:
 	if (otx2_txschq_stop(pf))
 		dev_err(pf->dev, "%s failed to stop TX schedulers\n", __func__);
 err_free_sq_ptrs:
-	otx2_sq_free_sqbs(pf);
+	otx2_free_sq_res(pf);
 err_free_rq_ptrs:
 	otx2_free_aura_ptr(pf, AURA_NIX_RQ);
 	otx2_ctx_disable(mbox, NPA_AQ_CTYPE_POOL, true);
-- 
2.53.0

