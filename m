Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290DE43CE6F
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 16:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785342262; cv=none; b=Wk389+T0Oib+jVAkZ9LJGKV+KJYPE2vN7wZIQCIuB6JtLTGEnzU9LfHRagzxNReRaEQePCyWLEQIY5EJ68Ku9D4P6yYwoDBUz6SY6Jn3d/e4CFN3w0x27pokxMb62hl5JSHSMLLrURvbc27XxJb24JaVoQN4QqlFcGHHtJdxuCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785342262; c=relaxed/simple;
	bh=YwutemxgZQ4k7Hh93OCHndjF1ngRzjPzGG+/HMA511M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S5c6xKnQy1AWnAR1vwrjReidoH9dfSKg4bOkkMc1xsQHxiPQ7fw5DZYERylJKot0Dd7LHIYl/KEGm4QhkkROQloEdVbjMly6sNupqEUj2nRgU0iuE2h6rvz/aQ2CoescRayiAQW62fz8oQmqhbFyYqJMJJd0qIZ8H/SV7VXj4nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=guGgqlq0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="guGgqlq0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A1B51F000E9;
	Wed, 29 Jul 2026 16:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785342260;
	bh=RHPwBOBg6eikyAsNP27bkDW8083Zs+wVvjzQSkFDLh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=guGgqlq0tMI7/5gm+1YknvgM2e+gka4Q+v/wL+myh2cmWRw6ZN0TrL9Ohd5KwhZOC
	 NGVxR+lDIRkjszMWfA7Q3Z85Y61S8AUCX3M4M6VFHkn9BIt1ox9xwf2PkohYXDbGtR
	 A2v5ybhlvJlYTmuqfHZCXsC13OwmmAL39HWlkE6MycDZL2oy5rrLuAb6h0GF/ByM4A
	 uO+eQZwml8oFwAEAqtkQMYychw843fr/trPUmM0pBp+igByuV4fuCBTr5zPKUOePMi
	 qN7yPTmgaURmbSOmWT6aO59b13H0eYsa8CGpOcolq8VLmhvsyFNUczCI2mCYyFTWo6
	 wLF1l1iQD2SPw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dawei Feng <dawei.feng@seu.edu.cn>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] octeontx2-pf: fix SQB pointer leak on init failure
Date: Wed, 29 Jul 2026 12:24:18 -0400
Message-ID: <20260729162418.3521009-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072129-glaucoma-armrest-3235@gregkh>
References: <2026072129-glaucoma-armrest-3235@gregkh>
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
index 50a36639e0ced6..4d7f84513c48bb 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1357,14 +1357,13 @@ static int otx2_init_hw_resources(struct otx2_nic *pf)
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

