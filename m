Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C61366057
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 15:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789138942; cv=none; b=BEXy0C9u6+T66GL+gZG4ndjO+KhyOTa5sm+tmej3zcK8GEQ/ZvjoS3lA4CkqeznYspj/yLKpS8OINM2gGMLYXQLsn3flGBqe8KBibiOEjVhaHkoAll6J7ivW4Kc6I9iOA6L762Os1EqdESaxF71eAEUZEu+73y6HnjsEaQFjO7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789138942; c=relaxed/simple;
	bh=RP5kb9VG7MmzM4DPEdB7/i7nHPMgnx+rYmQJyJgyAuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lSrGGKjFIj7vTCfi0VbGWdqSOXQGu8p3D+NLRP805eV2layom5i7MymbFn59oRBtWSJtVjN3ZesdqmZUjOzwiYRRaiqNpznrMeoSmIyQ0Ap1ThaeB+OpBqxwh7p3tB5a7LD0UhuWXPy7I39Y6ICk/TC8aBdXQzMs9KDkzX3RvLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCaGHAjZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCaGHAjZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB6F1F00893;
	Fri, 11 Sep 2026 15:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789138941;
	bh=CUGoMMcft4shzNt4BVcBg5VnTiFaeF88s7Iiznb5oWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nCaGHAjZmLqFasQFm4xh1eVP9KxJEE/Drr8rCrj0SdemyxiVNaHc1UXRu0AGS5S1b
	 +LyW+PbxuQqsqk54FrJItCbSHWKnzq4Y55wrPVP+GdTzrlBrz12af3ypOhx3uP0d6y
	 wMSFZPXa1ExJFuU+MXyfzgU6G/n1MZz3851sQN0feZnOmsJHWn3NtnkHlV4ZLUkrmv
	 ZXBtEK/9vaJWZbvf39clrgdr0+NnwZfzyO8rCd9+BuzIITIlxx8qB2WIoGEqOzlF2e
	 sjxNFMGMKnEFViYxCTF9JwR3AI1Us587KtgnDFzGn0yl9igya5PdptcGMOuj2MfPu8
	 giE8QvIiv0j2A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nilesh Javali <njavali@marvell.com>,
	Sashiko <sashiko-dev@google.com>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] scsi: qla2xxx: Fix use-after-free of qpair work on queue teardown
Date: Fri, 11 Sep 2026 11:02:18 -0400
Message-ID: <20260911150218.1017969-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911150218.1017969-1-sashal@kernel.org>
References: <2026090918-basket-habitual-e78a@gregkh>
 <20260911150218.1017969-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nilesh Javali <njavali@marvell.com>

[ Upstream commit 19788a55cab61d78e33e0914a5a31d27843e8a4a ]

The response queue MSI-X handler qla2xxx_msix_rsp_q() schedules
qla_do_work() via queue_work(ha->wq, &qpair->q_work). qla_do_work()
dereferences the qpair (vha, rsp) and takes qpair->qp_lock.

During teardown, qla2xxx_delete_qpair() deletes the response queue, which
calls free_irq() in qla25xx_free_rsp_que(), and then frees the queue and
the qpair. free_irq() waits for running hardirq handlers but does not
cancel work already placed on ha->wq. A still-pending q_work then runs
qla_do_work() against the freed qpair and response queue, causing a
use-after-free. This is especially likely during full adapter teardown,
where destroy_workqueue(ha->wq) forces pending work to run after the queue
pairs have been freed.

Flush the work item with cancel_work_sync() in qla25xx_free_rsp_que()
after free_irq() has released the interrupt (so no new work can be
queued) and before the response queue and qpair memory are freed (so the
flushed handler still sees valid memory). Guard on rsp->qpair and ha->wq
to match the INIT_WORK() condition and avoid operating on an
uninitialized work_struct.

Fixes: 68ca949cdb04 ("[SCSI] qla2xxx: Add CPU affinity support.")
Reported-by: Sashiko <sashiko-dev@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Link: https://patch.msgid.link/20260730155838.2119230-5-njavali@marvell.com
Signed-off-by: Martin K. Petersen (Oracle) <mkp@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_mid.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/scsi/qla2xxx/qla_mid.c b/drivers/scsi/qla2xxx/qla_mid.c
index 4a0550e5c2e0a..2604a704f51c9 100644
--- a/drivers/scsi/qla2xxx/qla_mid.c
+++ b/drivers/scsi/qla2xxx/qla_mid.c
@@ -606,6 +606,10 @@ qla25xx_free_rsp_que(struct scsi_qla_host *vha, struct rsp_que *rsp)
 		rsp->msix->handle = NULL;
 	}
 
+	/* Flush any queued response work before freeing the queue/qpair. */
+	if (rsp->qpair && ha->wq)
+		cancel_work_sync(&rsp->qpair->q_work);
+
 	if (rsp->ring)
 		dma_free_coherent(&ha->pdev->dev,
 				  (rsp->length + 1) * rsp_entry_size,
-- 
2.53.0

