Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B727D52759D
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 15:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791906180; cv=none; b=ifeONMJvFhq2torce50mPrkXtMUqXUB4TfLlds+19HfmHqXKIJyvd/StB0qDGWP7dog4bvobkCPGflo05dZGItENEnl75Kvi7xdv66zSwTZ+SMvtFUYfsd3yEE0xR5VxQihkGtOblqZDxG2aumAE0Uch56NWJwCxNhRMgNpZv3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791906180; c=relaxed/simple;
	bh=XNTmAYzv0aEtmGk0sRAYRE8OClQF+UKueC5gG8zQ9/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZiccH9UPA0VIzChjOJdjIKksYrCudYARSYKq+xSFU2ms8F5nyjkb5cclzbFY+cInUPhguh3r9dVWf3KSpKzmay1GNAsiVSoNFqlek9zZSNzFyeSno2xyE9+TdLpewTSs0ZsSkdmkuKrZ7/feuvWAUz35AFlUa/kPzC/gGuG1Dx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmK26N22; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmK26N22"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 124381F00893;
	Tue, 13 Oct 2026 15:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791906179;
	bh=nlLIuQGHbclmSuWMeP1hdWNePPyHnbgItCZYgtomxdw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dmK26N227g9CGQtuoBsX68kRmbyScyGkde3/nCtRaLBTHC5PC4eUVsZIMBo0YqzEA
	 DJkpxPgwhv3lltiSiKhdJvwadzX9i6ZT8iAEjVJ3wtZtwi7gi1NGIC077ZgsGENnmG
	 kl51gB4Y1mN74wTDlrARuAe4dLQqz+F5hKEI8EdOfr0UDioUXqsRuLAknlm1jLFSu2
	 wowI8oVK9/Wgh1VgfcAx9Qmc5xxw98Br4pXF5jMbQa7XpaHrjfEU18f8JYkNXpz2xI
	 elz/XMjlbVefSx03c4VbVU7ipAZ+QYtnNcDA7Dgw0Nb/IV3K5ySgxMcFjpEreaAkaF
	 wc6h0ajvjE49A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>,
	Peter Wang <peter.wang@mediatek.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/4] scsi: ufs: core: Add a comment block above ufshcd_mcq_compl_all_cqes_lock()
Date: Tue, 13 Oct 2026 11:42:55 -0400
Message-ID: <20261013154206.300388-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013154206.300388-1-sashal@kernel.org>
References: <2026101214-tactful-snowfield-df40@gregkh>
 <20261013154206.300388-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bart Van Assche <bvanassche@acm.org>

[ Upstream commit 1373df88d53594a32534fd8960c51d1d09be8ecb ]

Document the aspects of ufshcd_mcq_compl_all_cqes_lock() that are
nontrivial in a comment block above this function.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Peter Wang <peter.wang@mediatek.com>
Link: https://patch.msgid.link/20260401202506.1445324-2-bvanassche@acm.org
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Stable-dep-of: 375f3a5691dd ("scsi: ufs: core: Avoid unsafe MMIO reads in ufshcd_mcq_compl_all_cqes_lock()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ufs/core/ufs-mcq.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index d4129ceaede6c..09c40308789a6 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -315,6 +315,14 @@ static void ufshcd_mcq_process_cqe(struct ufs_hba *hba,
 	}
 }
 
+/*
+ * This function is called from the UFS error handler with the UFS host
+ * controller disabled (HCE = 0). Reading host controller registers, e.g. the
+ * CQ tail pointer (CQTPy), may not be safe with the host controller disabled.
+ * Hence, iterate over all completion queue entries. This won't result in
+ * double completions because ufshcd_mcq_process_cqe() clears a CQE after it
+ * has been processed.
+ */
 void ufshcd_mcq_compl_all_cqes_lock(struct ufs_hba *hba,
 				    struct ufs_hw_queue *hwq)
 {
-- 
2.53.0

