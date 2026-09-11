Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB8C3E3D86
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 15:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789140811; cv=none; b=G5vOrfOG6QOt/ngaU+LynKo/t2yPPG92eQAYpjtMnLEdR6tDpQC/IuIeB8YGGx1Cx0h+WVnD7PcBh4X2BaOQXM/bJAND8a7Qg3MRpSsS7m8JC2XPyA2RIvoApq6yUDZI0s9OAOCchcQE7edHu2Hgmc0gzqsou3uvBZD8hfbLWbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789140811; c=relaxed/simple;
	bh=CMmRGBDWt6AyeUq2AKCPFaSCi9nFHwDPyW7H811yUFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ak/Z08/iz5LkSXK/CV5D7rBqiLfQElChhq9CzWzRgNL20HQZVl6RkhU07qdYkNSOOX0bW0PzutVsZF/YpVqNI5t/gqP2Kl5GyF8IGCx0WQfovp3/8AeyX66EhD7nFdBLAQgTZ66g2VBzefZxLgXGM2IRpiGPxS6oy01j7m8Jy7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfAQd68o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfAQd68o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E18FD1F00893;
	Fri, 11 Sep 2026 15:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789140810;
	bh=SAnzXDFwPnbKdUndWH7BHJ5d796O22AS2F6Nij83pjw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cfAQd68oJQuYWVS0PLkfZfDCxFkU7mNNNMFbfyXyxe88aOI62roahhqEbH1/UJCog
	 nGO7OuahUtYZ203gm/RIRgOwmJaBi1yqSkvLDkhkUt17EwQw7k0UuU0SmnS5R7e5EW
	 PTNlEWvlXPDAJq5hYSgNVhp6nPzmx7p4+2S08ndAyymS9POe2yDtrBRzVMV4raHVWt
	 i+0NKhSKng/JonQKvTUXJ6gvHHnmvIckYkRdApz3kkN8BKum45Mi8CEEiX4zT4inZg
	 fQEue7uqehRDSIHHm5fzPptgJM58vcd2rzu+9FSVV1pFSM2GtACbudwg6vSPdqJtea
	 xTUvFvS1tn3mA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nilesh Javali <njavali@marvell.com>,
	Sashiko <sashiko-dev@google.com>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] scsi: qla2xxx: Fix use-after-free of qpair work on queue teardown
Date: Fri, 11 Sep 2026 11:33:27 -0400
Message-ID: <20260911153327.1096541-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911153327.1096541-1-sashal@kernel.org>
References: <2026090920-clear-immobile-5728@gregkh>
 <20260911153327.1096541-1-sashal@kernel.org>
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
index 4d2ce7a3de03d..68b1e5129d6c8 100644
--- a/drivers/scsi/qla2xxx/qla_mid.c
+++ b/drivers/scsi/qla2xxx/qla_mid.c
@@ -616,6 +616,10 @@ qla25xx_free_rsp_que(struct scsi_qla_host *vha, struct rsp_que *rsp)
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

