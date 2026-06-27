Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E18F38D;
	Sat, 27 Jun 2026 06:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782540554; cv=none; b=s+BXuEz3CQyT0Oi7sQ/kdi8OjloT795SunAG5UZuUAaSwsq6ol7zr+LpHOp8aYXpLDCj6N28Whp6YHbWvXXsQFtdQ0RIeG4v/2wcV82E4ocg9CJO1KB2KSP2NK3hFSVcqam0U/EIocZkPAw6ZNE25YAaZt3kMMGu/HbcIr2Evx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782540554; c=relaxed/simple;
	bh=AYihhBPrL0XoG8KCDlIIajredVZEYI5qL8w3Wwm21pc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QrmTbN+znKA66jxaUH7JZbVFU+2yonQ25UqGa9Qb+mVjB2L6RpP/ZyZaqfj4EZnAp81sOE1sPUtK0YmXIiy5ckAjN5VXa+J6fMXcQkNc9F2C41WfZi4D5+9RHIcQa/hwxHwVVTdujqY9Eo1mKtQFyKtMYrAryNidlTlnmA29pVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=iNBLrK9I; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="iNBLrK9I"
Received: from DESKTOP-SUEFNF9.taila7e912.ts.net (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 43fb57366;
	Sat, 27 Jun 2026 14:03:52 +0800 (GMT+08:00)
From: Dawei Feng <dawei.feng@seu.edu.cn>
To: sgoutham@marvell.com
Cc: gakula@marvell.com,
	sbhatta@marvell.com,
	hkelam@marvell.com,
	bbhushan2@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jbrandeb@kernel.org,
	richardcochran@gmail.com,
	amakarov@marvell.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	zilin@seu.edu.cn,
	Dawei Feng <dawei.feng@seu.edu.cn>
Subject: [PATCH net] octeontx2-pf: fix SQ resource leaks on init failure
Date: Sat, 27 Jun 2026 14:03:50 +0800
Message-Id: <20260627060350.2544241-1-dawei.feng@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9f07ad657d03a2kunm948e381aec012
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZHR0eVk5KSUpOQ0waGRpPHlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktISk
	9ITFVKS0tVSkJLS1kG
DKIM-Signature: a=rsa-sha256;
	b=iNBLrK9IdYKGg+jmUYxW/DwjeeAbypKlIANigz6yR8cCnOLOVGpNmnoUcqqbr8BDOIQQrMm1vcVylSSgHim4v6ZSdWy3p+q63AmTLPmWrhjGMe9ygA0OWYtw55968TFWkMHWmgvkp5VlpMk7o7HxyPHKGHukjmSVVWGMiBM/eOc=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=TGdQCFxvjEVVGPSadzxYNU8w92CyeUjRWOKitEo2+38=;
	h=date:mime-version:subject:message-id:from;

otx2_init_hw_resources() initializes SQ aura and pool resources
before several later setup steps. On failure, err_free_sq_ptrs only
frees SQB pages, leaving the per-SQ sqb_ptrs arrays behind. If
otx2_config_nix_queues() has initialized some SQs before failing, their
qmem-backed resources can be left behind too.

Use otx2_free_sq_res() for the SQ unwind path and let it free sqb_ptrs
even when sq->sqe has not been allocated yet. Also free the PTP
timestamp qmem from the same helper.

The bug was first flagged by an experimental analysis tool we are
developing for kernel memory-management bugs while analyzing
v6.13-rc1. The tool is still under development and is not yet publicly
available. Manual inspection confirms that the bug is still
present in v7.1.1.

An x86_64 allyesconfig build showed no new warnings. As we do not have an
OcteonTX2 PF device and the corresponding AF mailbox setup to test with,
no runtime testing was able to be performed.

Fixes: caa2da34fd25 ("octeontx2-pf: Initialize and config queues")
Fixes: c9c12d339d93 ("octeontx2-pf: Add support for PTP clock")
Cc: stable@vger.kernel.org
Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
---
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 41a0ebdf201e..88ac85354445 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1568,14 +1568,15 @@ static void otx2_free_sq_res(struct otx2_nic *pf)
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
@@ -1710,13 +1711,12 @@ int otx2_init_hw_resources(struct otx2_nic *pf)
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
2.34.1

