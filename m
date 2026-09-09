Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A89530E1C
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953210; cv=none; b=ED489zfLXCSeJSTsh1reMg2MfsdtWQ52vX+kDsokBJy+eCFhcBAdbY2Szgi3Vy//TOqTb20LeckPN9ZUvw2R4NicXFk8Tt4gpuBgzPgyd69n7txQSWAHtcnCV98vBk0MpErT3MPP0R+u4BLRsXiQQ/6F6Vbn72TdBfoFI7eYl1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953210; c=relaxed/simple;
	bh=bQhMs/X7qklQuE2aPL1uTAn7bo8sgoe04GnhWOtfdFw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=K27AYtMtTPL15wLIlpGluYqof/ckLz+XJIw2P/9h+mbl5BStcTRWDu0HZy4soSFaMSabQKBvzhfPNv5+s0QbmSPeCxbifw5GtSpw7rNl1tGLx9IcdP8BNQ5xuJti7bI+T/VX0ritXyVEDLWfbl7vEWmgyxG9PLQ88V9bdgGMbNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v/NUGOYi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v/NUGOYi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35EE01F00A3A;
	Wed,  9 Sep 2026 11:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788953208;
	bh=sYANMZa05yCcQECwj8JfjMZQ2gqUVEvNZ3cZH9XQ0pY=;
	h=Subject:To:Cc:From:Date;
	b=v/NUGOYilvO2QqWWxXP3TRgUIhB6+N1SP5qkO5FCo9POlCURj/Nr59/2eRu4pqfD7
	 Vs7hOALowg591IgYcGDm3M+S9fW1bPV9NYkGRV0RuOgoXrkhRSrYJ6CIOKPpa5tsN7
	 C0RjFg3KiWISWdEHZN5s8P5ZYOLBwruuyT+PG14Q=
Subject: FAILED: patch "[PATCH] scsi: qla2xxx: Quiesce response IRQ before freeing request" failed to apply to 5.15-stable tree
To: njavali@marvell.com,mkp@kernel.org,sashiko-dev@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 13:19:25 +0200
Message-ID: <2026090925-anointer-haggler-c959@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 505753ec2594c6af09a601f0dd60be7d840c1d2d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090925-anointer-haggler-c959@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 505753ec2594c6af09a601f0dd60be7d840c1d2d Mon Sep 17 00:00:00 2001
From: Nilesh Javali <njavali@marvell.com>
Date: Thu, 30 Jul 2026 21:28:22 +0530
Subject: [PATCH] scsi: qla2xxx: Quiesce response IRQ before freeing request
 queue

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

diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index fed6dbc3b6ae..e6b499245794 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -10695,11 +10695,28 @@ int qla2xxx_delete_qpair(struct scsi_qla_host *vha, struct qla_qpair *qpair)
 {
 	int ret = QLA_FUNCTION_FAILED;
 	struct qla_hw_data *ha = qpair->hw;
+	struct rsp_que *rsp = qpair->rsp;
 
 	qpair->delete_in_progress = 1;
 
 	qla_free_buf_pool(qpair);
 
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

