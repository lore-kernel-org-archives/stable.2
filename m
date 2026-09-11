Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E19390613
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 15:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789140511; cv=none; b=LAR53tSSlut9v7y5G4gV2rRA1H7QxdliTVlZhM1znqE/fyOfLgBhQNZ91uiQqf8NJWdISH2RjdnYyWMYWm050QcjIjFAshVHAHjwV/YEd01crs2Yw/gLRBpgHnQVxnhQ0mUzRWr3RoKJbrF+vXSFJqm2OuKlm0sPaDXYMJYR9r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789140511; c=relaxed/simple;
	bh=dUGb//eIJloB1Gp/jO8PstmGt4L78h4CTyAL+bKK3K0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SisYK5O9+xinm5/SCBbAPxHlN2jly44WQrIqRUNwKH5S766HRf7eH89kHIURJI4EAADNWmWAtGDT7tb84k0QpOAm5G++OrQ7RvN9C9BlMOCxCuHdjBZ1y+1NTRcwVCn1TtMkm9dccq1J/C8EOE9zOSYwbkXjpz6McczLyde0YYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oN3fjoHJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oN3fjoHJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94C6A1F0089A;
	Fri, 11 Sep 2026 15:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789140510;
	bh=PzCkChfw+oxkpFOjBQcUyis4kxYtquBd08NQiFkT3CA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oN3fjoHJt59ghq7KzTa6fAoHihrJCUi5eLSsV73ihzclqPddFKt0/NSaM1dskyW8F
	 zmwqSLPBeYd4vHOqFK31cOzSaAY9ZUfzYl57COqFPSTgzqHTRvNnlWguv8rJCSbgTQ
	 RfKVfeUQ2oSozS5lwLiLpHLRevUs0BuZFgy4tqMqYIZMb4u8iAnTbSq4a7ZXguT5Bk
	 DEqlyrBtyRG75E+np9NdGQCAw0qnFXraQzb7xYG73oC9ofNjxkstp/YODON9675rxj
	 EtNZQY6JXpn21bOaNUHBfWRuJDwqiik/9xit9COHS2ViWNlRrxqkgleHZIzgDh7d1b
	 89xmsH6dTbRYQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nilesh Javali <njavali@marvell.com>,
	Sashiko <sashiko-dev@google.com>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] scsi: qla2xxx: Fix use-after-free of qpair work on queue teardown
Date: Fri, 11 Sep 2026 11:28:26 -0400
Message-ID: <20260911152827.1077875-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911152827.1077875-1-sashal@kernel.org>
References: <2026090920-tricking-plus-ce0f@gregkh>
 <20260911152827.1077875-1-sashal@kernel.org>
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
index b25439db6867d..11434b695b037 100644
--- a/drivers/scsi/qla2xxx/qla_mid.c
+++ b/drivers/scsi/qla2xxx/qla_mid.c
@@ -615,6 +615,10 @@ qla25xx_free_rsp_que(struct scsi_qla_host *vha, struct rsp_que *rsp)
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

