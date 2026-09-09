Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2F55437F5
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953119; cv=none; b=nmN9o9noh9wT+ecKdOUplTGOoJ+fS7Gvjx8R8RoGO+2aSMMTSapbdNqf5Igpes7S5TiWFkeroiB25Bg8uMeHRORS7EUfyrrCKqFZl3DuAYHMjaucF5Jyx6zcXfNQ1g5iubqHQ0bv3brGUxCdx/PgLlZHoxedP5gwZwor5KOrBak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953119; c=relaxed/simple;
	bh=G63iXa9YfKYh0fxylq+Jfo8qoL1wvizrT8wNB+QhXss=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=JItrv5pSyD2QUdbWHdqjetIanTvZhkl14t0jsZTtRlKZZNQyOj00hA5HtXCq2xqYXFRw++Z/PrRI59MZIIjVDYeo2klJs7OyRXg6z9vidPVFPXNNJMIVIvAf4IOGrYZe6kX+qYOBMec3UhNX9ImEzRGcANcecQ3Es0ocnhEBhIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eVNnU4iT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eVNnU4iT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 594D71F00A3A;
	Wed,  9 Sep 2026 11:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788953117;
	bh=dMerEFXOxVi0HexUAV1Pj0kSuVE6quW+fSTlnAXNkCA=;
	h=Subject:To:Cc:From:Date;
	b=eVNnU4iT8fQ9r+w94bRlUJoHngP7TXUp6g89kXnPV+Gs9p/Gb/PVR30wsqVXetVNn
	 zp7izS2rPCTj/AsLl5xLhIAkukjY29g4xGULfTlHWgKN3zbcAMZGeMA18j6stsYhvh
	 24DtCtzTXd9/8ylSzu3oBKMY/FClPpZwZd5+6uz0=
Subject: FAILED: patch "[PATCH] scsi: qla2xxx: Fix use-after-free of qpair work on queue" failed to apply to 6.12-stable tree
To: njavali@marvell.com,mkp@kernel.org,sashiko-dev@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 13:17:19 +0200
Message-ID: <2026090919-divided-onion-9b49@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 19788a55cab61d78e33e0914a5a31d27843e8a4a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090919-divided-onion-9b49@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 19788a55cab61d78e33e0914a5a31d27843e8a4a Mon Sep 17 00:00:00 2001
From: Nilesh Javali <njavali@marvell.com>
Date: Thu, 30 Jul 2026 21:28:09 +0530
Subject: [PATCH] scsi: qla2xxx: Fix use-after-free of qpair work on queue
 teardown

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

diff --git a/drivers/scsi/qla2xxx/qla_mid.c b/drivers/scsi/qla2xxx/qla_mid.c
index b7d9c1a53f3c..33bfc61d8165 100644
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

