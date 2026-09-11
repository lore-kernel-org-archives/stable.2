Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2523A366057
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 14:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789138246; cv=none; b=LgcE0mwWU76t0ACNX8eq8/3TRm50DVA7PjNqIy3a33rf7YEUY76iuPjpazn//WekPwaXENc1/D68u1XfBxEqkFI+D0I4ZMV201oGI6+apglUSQ/N+W+aW+KCgscy1QdzTco7eNnv2McJvcFDoSqN1tPJ2yDyLiX0tZDYix+Gldc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789138246; c=relaxed/simple;
	bh=k0lMlhtY05HOelxC1M596RSQHVUz2UXFohYzlsiqEkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FG2LXlXl4Dt7XVInZKDfLUA2JFmRPPWhnScX0IeHPgOLZfG7j+mBjcv2XponrGh7PMw79W7VIASNJUttx1porVRl7+Yt78W1RhvxYUf+hnqivWATyuQdcOpXaR7Qde0yTPXRemZ0Q/u+mMWXsNIxad3MkXnyzxCU4OLOYt2fw6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k7clCENj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7clCENj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5379B1F0089A;
	Fri, 11 Sep 2026 14:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789138244;
	bh=bnyFwLGjP0kLegOWpNqo+q4EfZrTHDko07ob32Df/Vk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k7clCENjCTDbta/X+MK515VAZ2/9x+KgE1WjhKGl7RiBvahZaQX3dMONiDmww+hMY
	 M5sV6wyOCfJ19ky4K88aSoRrt4gm/KcpJHM0oRkNNybkKWGkuDrn4u2Oe6KYe5ejER
	 t13hiohvOdMx0J4t7OigTa7etfBy6OAiF/LaR7m/HtA4ybw0uumMYCOBGx5gCvRE70
	 YR7/kvpoKv/aqoMprwKYHakoIWUqBxPYrBdYHwbGqYAEyuuWavKQwg84kOwxKQDyAa
	 WKwprpzQkiQmlSKo9pOzp4DFMxF1kqVJo+x1hVGx8imiAhF02KZaPvp1zedZDop7BQ
	 xh9qV9hivZtbQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nilesh Javali <njavali@marvell.com>,
	Sashiko <sashiko-dev@google.com>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 2/2] scsi: qla2xxx: Fix use-after-free of qpair work on queue teardown
Date: Fri, 11 Sep 2026 10:50:41 -0400
Message-ID: <20260911145041.984099-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911145041.984099-1-sashal@kernel.org>
References: <2026090918-carpenter-handrail-b6ca@gregkh>
 <20260911145041.984099-1-sashal@kernel.org>
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
index 5b3e457b9e6bc..419aaac56f99b 100644
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

