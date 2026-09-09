Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0CB49AA54
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953212; cv=none; b=ldWIFT+Kx4+eHiO0zA5jSWF+jM8oY6UOa4/ZABwLpsEbyxE+ckniDaXJ8oTSNhvtdRTh33e4hibXM6cTAOxqtP5/55zvCnHYonInBWrHom+kiRaW399E6a4Pc9CgZ68HkLnQQB3jVyhI28+dtXOKNOA9YqbnRGyJG90udZunzbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953212; c=relaxed/simple;
	bh=GyhNVCwl9qNdSRRztUQvhvtbs+XKCcxjzvJ50dvli+Y=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=h97ZP+MwoJG/bmCEThaEsZWEdQbtuAyrxIdNEQs6v5BwtGzwHOUFF0Vo2ChsbmG+6EUEoeIxVJWesTlr3nhrBn5ZeQkv5NkrS1p734/YUCDvbqPZNbBk8v97QGr8kBsCPga3frDAkzzIfTj7zuGGf6hap13M1TmxeiR/k0TDKAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ynZ1GLNS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ynZ1GLNS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 053B41F00A3A;
	Wed,  9 Sep 2026 11:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788953211;
	bh=I3wLiqlSEdjnNJy2KhiTy2Trwxlt4gCUEqIoGlOTUqY=;
	h=Subject:To:Cc:From:Date;
	b=ynZ1GLNS9T9qLojC1zqX+Akpi9hQP/2kNK9fmP3ZkYrlqNnm7HCasm4qu8q5CTYuw
	 odId7XeLdRebNwTsjwJylOj2PyWlNnweVaL9zuwQvMjIuq0yRMjP23z0hU3sO6jf3d
	 Yi2bLE0Vl0FpS9Xi5A1t1O1LhK9GJdUNFx0oFW1A=
Subject: FAILED: patch "[PATCH] scsi: qla2xxx: Quiesce response IRQ before freeing request" failed to apply to 6.1-stable tree
To: njavali@marvell.com,mkp@kernel.org,sashiko-dev@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 13:19:25 +0200
Message-ID: <2026090925-imperfect-pamphlet-362f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 505753ec2594c6af09a601f0dd60be7d840c1d2d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090925-imperfect-pamphlet-362f@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

