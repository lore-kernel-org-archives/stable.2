Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459474A8A03
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 17:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789146981; cv=none; b=ToZBDzr3rsYhpeMe3qk1BtOnyN2NgQGoSo4RjywgqT8UAbdVn4OHktzk7wB4ZFVRFsqjBohh7F06XlOnC/cVGkuvtSVOjrIsZL2VCBq/35UNnY60NfYnjnIlhaoFMMfWh2soreLdQmv7uK+dHBEBP3TjiiRCuXRNP4HhONZp9Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789146981; c=relaxed/simple;
	bh=Og2FCt+UDC6SHYqFADAABfokv4e4Pm+mzRXTcIVHCCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X0Kr6Z6RO1i6s3ICSdUQyN/NOJpfaBNP5ZNlhAZCyRHtfQ5TtGluMQf+up/crPOm/O4XhMi9Al5c3ReJPQu4HCXn8CqqeAV3qfe0URlQqZGiMeHe4uAv7fie6woSpH3hVTdqyobvkz0wchGE5c5i4E9mUw/Sq9EqNsiaWxnypN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMlaudVq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMlaudVq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C0B1F00898;
	Fri, 11 Sep 2026 17:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789146976;
	bh=qu9MMMzVkOxAsOFnrPzRkO+9bnbi0Z7kDee6jWGRPf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nMlaudVqhaggwjnEXUIP6i1CW7JX+UgzobplS7TKjzRw6kz64vMV3JGXZt4M9nwHD
	 FRJWcM/a6n3CzL0sGd+N00pv3zLPOrbrTMikgBQI6XorbdAboa3Y1tH9vWqkR8Qf9e
	 2Ugwn14TaqjuNhuo2mOZGQC8ui0sEAFptIJvUpB5e1yqrGrX7jobqtQIEfMcu1b6F5
	 OwUJl+gV5O0ZFTivQ8DkvQeINJYIYLRsZMg6/Rd4m/8ussYLCU6Y5Re3PbwwkCFTxP
	 TyNuV3GWnzGF0B0Y8pM3vsfyqo/QNGTlXSp8l4TOXH73nQayGDoTJ9+1BLLvxnJ3t5
	 eJqAC+/INy8Tg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nilesh Javali <njavali@marvell.com>,
	Sashiko <sashiko-dev@google.com>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] scsi: qla2xxx: Fix use-after-free of qpair work on queue teardown
Date: Fri, 11 Sep 2026 13:16:13 -0400
Message-ID: <20260911171613.1215725-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911171613.1215725-1-sashal@kernel.org>
References: <2026090921-foe-those-b6a7@gregkh>
 <20260911171613.1215725-1-sashal@kernel.org>
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
index 4e2d6e0cfb9b0..bb44db0a66756 100644
--- a/drivers/scsi/qla2xxx/qla_mid.c
+++ b/drivers/scsi/qla2xxx/qla_mid.c
@@ -599,6 +599,10 @@ qla25xx_free_rsp_que(struct scsi_qla_host *vha, struct rsp_que *rsp)
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

