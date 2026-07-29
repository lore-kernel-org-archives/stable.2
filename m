Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5F823BCED
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 00:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785285058; cv=none; b=CDf4amMSQzfvKcuQ0HhU8f+tgV5HOIoFH3Y3711uHKB9CDeqWJWPjQ99dhoe+0AuX9GEVsjxXrJULvcT2szh9SZyEsD0RmldhwhF//7/7uIa8rXUkqIuZMyzAxrf5RH4NtvH2c/wPRcfvgHFloCY3UOOLevQEiTTK1uSwSS02tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785285058; c=relaxed/simple;
	bh=MxILQiYtH5G73HD6g/Njgwl1zLJjWOI9sUsxEDnxuzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PkG76NcXJR6SWWVIpAwsYQkQEQRj9Tw3u9+/wxGzI77w7ZV9FXp2ldUCitzuft2ORcn15nMDzWenHY9TfKTG9cOu81D7nMv3dRHKdXPhntCxIoSm5PXu5eVnNZCMk0EEFLqsYp8KBfuyNa+6DVXrs6xAWlBJX4MWqoUVKyNxi3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EG1SGpCJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EG1SGpCJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DC631F000E9;
	Wed, 29 Jul 2026 00:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785285056;
	bh=TcD6KL9fXe0yYw6XYpVRWNXWmVM4itposG0kzsSEZKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EG1SGpCJ+9+PqomyrH68Bb5wa7Nn8eAAQxH2XSQlnTybSAGjvGoin5eaMbE1ytywN
	 rkYu18jrskmGa8Qirps7xcWG0D0hgWJDXZe1EpnORfWNQ7PA7OdqzcJQ3ozoH4RBo3
	 py4BZlIiuBW8xTCobtkllHDOnJBUrWJcKZf0aVzLoG9AUeyvQU7kHZhK7b7AYhoiC6
	 yN+lfSL2g05EXBvwcGWpHWCvx83I+R1KdCLkxXhszUilTumF++/AtC3GSSBya8l0D+
	 b+w4xO1rGOgsXIzgEWjnwQ4+l4aX6VS02o8Ksd/YShdg23qKkSbmY2rGVho7xdT2pw
	 +G3FK60lxhOsg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dawei Feng <dawei.feng@seu.edu.cn>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] octeontx2-pf: fix SQB pointer leak on init failure
Date: Tue, 28 Jul 2026 20:30:53 -0400
Message-ID: <20260729003053.889460-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072127-glitch-eel-f400@gregkh>
References: <2026072127-glitch-eel-f400@gregkh>
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
index b0b0b4929e8ce2..b36da00bf13b2e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1439,13 +1439,13 @@ static void otx2_free_sq_res(struct otx2_nic *pf)
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
@@ -1571,13 +1571,12 @@ static int otx2_init_hw_resources(struct otx2_nic *pf)
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

