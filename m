Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B794A8A32
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 17:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789146984; cv=none; b=LXFgnyv8LOZvot7BHGQ4ClqE2ywHJXzG58GuEskipSK+rtCulDu0NVCEDZ2kosnwBFUgT3Tqd9vug+TKvUrMc8M7qp1Can0a1ymbkN4v7gux50phjwdQJvZeWpgMjWuQpwzNRetSJ8J4TLYYzq6CBK1/4K1lakM/yncjChu9Co4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789146984; c=relaxed/simple;
	bh=xPS/F8s4ZKvL6Z0JUQzYQ2/pgZ6U61nJs3ij3badl48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nZ3e/Io8wwpT9CGfumis7bkTS4I09iapZL8YdeKWwTEwg/ibi+eePyO98LPyrDYjBsOKxJAYAZ5Ty2dOhxxKWM6xMxBZhl6m0SHlPfLH6uYeLzK8Db4XyA/QIuvr65TdvNeumagok6f8SPkWUNVhImOq1sEd+IO6uLwuApA+KiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SvhM4ys4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SvhM4ys4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6099B1F000FF;
	Fri, 11 Sep 2026 17:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789146979;
	bh=Tikc7OglYzL53sgyda4EO8LRbhwZ66Y023qtt3ueTjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SvhM4ys4nR8k71gllUIAVsbv+vx/4HaVzBidNz6lseZqwG7FSco5QXlL6qXRJ7V2m
	 LejJXojOacE6ChKmOjdhN88J8VwbA7JlI3Y3khDKlyTISA2LQhhhFDUPM2+PcFGbDK
	 TfvaWQZJ7vyTFwsrs0PzZN6Zb5Yg6Jrau/CFXqeKc5v6F8O0cMUaGyptLUNkAEEBmZ
	 3r0G4Pj59fDWPEoQXdMLEHmcUGFUzEr00nrH7gaDLNOumK+PW4P6S3eLnLptv8DGgL
	 qFQYP0hmwn/Bnv9Yr2zmfO045NXvL1ziuhHSnotXiiAH2edMqw5APF5QOu8i1hmoMv
	 pM5AmwavhzJ7A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nilesh Javali <njavali@marvell.com>,
	Sashiko <sashiko-dev@google.com>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] scsi: qla2xxx: Quiesce response IRQ before freeing request queue
Date: Fri, 11 Sep 2026 13:16:17 -0400
Message-ID: <20260911171617.1216878-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090925-imperfect-pamphlet-362f@gregkh>
References: <2026090925-imperfect-pamphlet-362f@gregkh>
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
index d4f9857cbd449..3ea33c40e5eba 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -9874,9 +9874,26 @@ int qla2xxx_delete_qpair(struct scsi_qla_host *vha, struct qla_qpair *qpair)
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

