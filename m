Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0853338DC69
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 15:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789139135; cv=none; b=CGBPwQmFanAvsL3Vam/fpFAHhe1QPW4Vo9a2zUMIENKZHeilT9F29nkJ1/N0L7I2ac02mXiieMfhP0zWfOU8e9fpVXPJiV1dWK3hq9Fsvulyz1Hg1tPiFQJ8tTmHBiw4MhBwCBVOw1D7VANCLAWSgRemtC9yLOaXb9Za3zqbPS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789139135; c=relaxed/simple;
	bh=wsQDLzoz9+HDdtaMrf0p1RT9zZX93U2QialCRq1f+2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UDLms6ayLRMkiLsZwU8tPBNyZ0hJKSNdriN7CIl8OqJzWdOorgmnK+H+6K6g9m7wlMySsBA3LbuKwvU80tqHBnLr9whDsgzQoTxrDzgixgEpbGd/hlkkBDeVWVswxhA+mBrM9xkguu+XyFHnYWbLSDiuysl1R55XUDY62MPCFtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YX0L7Ekt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YX0L7Ekt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40ACF1F00893;
	Fri, 11 Sep 2026 15:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789139133;
	bh=vwm7KwaWYmr+etdoWrY77ZB8jE39aMHYrvhFgAr++F8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YX0L7EktK4BD9bdS2WvufQtXfqQzymPDOzn/zygFItAAHGAv6vq1pbLsnN0buLTZ1
	 nSxoAlNENRqPgi9XIujdOs7QFxnGKbf9yKs8wraHsgX8MGCGefshAkZ8/cAsyD5D1w
	 OZF50yJKOc5TX3yz17CFiC/tcQeJoo4TK7YVzRHB6ryQvg+KG2Wc62wAImItyaQ6sG
	 iRZBIbPk3INGivNGvo5n4cPUBhFPFndgkHdyw9cTxyeyRhrEq3Scb4KR6ONmPOMcWX
	 X741CtT4dOi33EolFbkDpoMiZ5F6eIK7KXuPI3M/5cr7qlGBMxEk3A7cMwH69KYJPx
	 VlVEUXGZW4W1w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nilesh Javali <njavali@marvell.com>,
	Sashiko <sashiko-dev@google.com>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] scsi: qla2xxx: Fix use-after-free of qpair work on queue teardown
Date: Fri, 11 Sep 2026 11:05:30 -0400
Message-ID: <20260911150530.1032073-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911150530.1032073-1-sashal@kernel.org>
References: <2026090919-divided-onion-9b49@gregkh>
 <20260911150530.1032073-1-sashal@kernel.org>
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
index 61570f032a8ac..44dd9373bfb12 100644
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

