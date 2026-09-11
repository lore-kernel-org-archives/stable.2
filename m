Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183684AD7C7
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 17:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789149502; cv=none; b=B/tSyZTM1vh5VpE04Bco5SJ98A7ctD2bVaZkG+Ow3QoYoNTjdWJ9nB5AiRU47wGp6dnYbebR9uwM46wZiL/vehS4PhsutHVz2I0FUcYclZgcVCqAG3Y6DmFRHMYqMLdTgo76XmwVp+erkaUwIjq95xNj2LcPho4JwnVJs5rtR+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789149502; c=relaxed/simple;
	bh=K0QN+3vFsh2bCPMjakdSvE7O0MKuvRPJmkC+F5hJrwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tC5ut+zAuru8soqD2cW+rrHYcFk7H7kgKu89gYkh9m2smj+Iouj/Cnd69vHstoW+DHSmjrOjcdGtJ8nJP5IVL1d+19f/RcHghHnLfh3Rp6SpDY/0HHv+Hqip/td43/w220bfL7wu3b7nMAK/BIWCX+EjSrh6LU5aFAEtav3vcPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mTVjHEzs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mTVjHEzs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F2A1F00899;
	Fri, 11 Sep 2026 17:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789149500;
	bh=OnEYW0cOMmDrQDYHOJKgvZ/nQoTZJ8hNcg/x1VD71iM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mTVjHEzsMrH5/k1SCvuU1nvtRze9/vTwqojc23K5OruBuTjDYpI1T6kcVDZQ9t/2k
	 FH7XFb9wGvL5/VQBI8vWFLvO4/ycZHxWpbAMIEFDmQN3w8v3r7JAmMN+2bsJ9qv1MI
	 8jjZsQSXqBKcIoPP1cjPk6V6ZhsfDerSqT/60HB1zdtjix+RQitGfJlbb2Y/swquMX
	 mvDibLZi0MebXbrqdXwfh+oMWSPelTGw6lXmZFkkWiODnHtFluerdSFztU0AFH0UhF
	 ddPL/8LrSiqkPCEgOf0Puci9XfW+26sd5xHHrnWVwnvqiY3GO+2jfzaFCAzMfvD1jY
	 P1HsZAGPaNOsg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nilesh Javali <njavali@marvell.com>,
	Sashiko <sashiko-dev@google.com>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] scsi: qla2xxx: Quiesce response IRQ before freeing request queue
Date: Fri, 11 Sep 2026 13:58:18 -0400
Message-ID: <20260911175818.1283206-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090926-runny-splicing-02b9@gregkh>
References: <2026090926-runny-splicing-02b9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nilesh Javali <njavali@marvell.com>

[ Upstream commit 505753ec2594c6af09a601f0dd60be7d840c1d2d ]

qla2xxx_delete_qpair() deletes the request queue before the response
queue. qla25xx_delete_req_que() frees the request queue memory
(kfree(req) in qla25xx_free_req_que()), but the response-queue MSI-X is
only released later, in qla25xx_free_rsp_que(). In that window the
response interrupt can still fire, qla2xxx_msix_rsp_q() queues
qpair->q_work, and qla_do_work() -> qla24xx_process_response_queue()
dereferences the now-freed rsp->req (LOGINOUT/CT/ELS entries and the
status path), a use-after-free.

The cancel_work_sync() added for the qpair teardown lives in the
response free path, which runs after the request queue is already freed,
so it does not protect rsp->req.

Release the response-queue interrupt and flush qpair->q_work before
deleting the request queue, so no late completion can reach the freed
request queue. Clearing have_irq makes the subsequent
qla25xx_free_rsp_que() skip its free_irq(), and the firmware
queue-delete order (request then response) is preserved; the
request-delete mailbox completes on the default vector and is unaffected
by dropping the qpair response interrupt early.

Fixes: d74595278f4a ("scsi: qla2xxx: Add multiple queue pair functionality.")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-dev@google.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Link: https://patch.msgid.link/20260730155838.2119230-18-njavali@marvell.com
Signed-off-by: Martin K. Petersen (Oracle) <mkp@kernel.org>
[ adjusted context due to missing qla_free_buf_pool() call ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_init.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 4a057748ba175..7531e1df1e280 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -9327,9 +9327,26 @@ int qla2xxx_delete_qpair(struct scsi_qla_host *vha, struct qla_qpair *qpair)
 {
 	int ret = QLA_FUNCTION_FAILED;
 	struct qla_hw_data *ha = qpair->hw;
+	struct rsp_que *rsp = qpair->rsp;
 
 	qpair->delete_in_progress = 1;
 
+	/*
+	 * The response-queue interrupt schedules qla_do_work(), which
+	 * dereferences qpair->rsp->req.  Release the interrupt and flush
+	 * any pending work before the request queue is freed below so a
+	 * late completion cannot touch the freed request queue.  The
+	 * firmware queue-delete order (request then response) is kept.
+	 */
+	if (rsp && rsp->msix && rsp->msix->have_irq) {
+		free_irq(rsp->msix->vector, rsp->msix->handle);
+		rsp->msix->have_irq = 0;
+		rsp->msix->in_use = 0;
+		rsp->msix->handle = NULL;
+	}
+	if (rsp && ha->wq)
+		cancel_work_sync(&qpair->q_work);
+
 	ret = qla25xx_delete_req_que(vha, qpair->req);
 	if (ret != QLA_SUCCESS)
 		goto fail;
-- 
2.53.0

