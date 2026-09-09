Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547505427ED
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953113; cv=none; b=I/4AtaQAqpybVcfGFe1fQCizRmrsxUA/WGPZ008dREyH6uCD5V5SYAOPfUhkCuTSYmorgTZu+jyRVlpVcInEEdvY89YvwATsENzltVu2tFmhb3JSsuv3FJjsY5/Ziazu9J6vfR9xZYPafdJ7z4V+b3C00e9h1yP8YcDmDDx6DRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953113; c=relaxed/simple;
	bh=Z5RYsSkmUN49j+2ErN19fdncNdegP5ucXECt8A6yels=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZBMFXyPGLSR79wGSewar94l/+k1TTAwCBMET8hi2EXSYk+1RtVAG6YGGCMZcz28PWXDCmHDgmKUy8P9WjWP9CMJXDAgC8pr2DHheqPH/NGcAsIUyRVB/Ja+FxG8rcvAq+8Y4kHgIi+/S5I0b7oqw7Xxf3O6bb1cVlqBb9/tsc/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xu/3vW76; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xu/3vW76"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADFD81F00A3E;
	Wed,  9 Sep 2026 11:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788953112;
	bh=71SMSvj+L8fv8Cb1sG5BBcaXZLTEnKX21UcE2pk3rXg=;
	h=Subject:To:Cc:From:Date;
	b=xu/3vW76pbXLyQyL4Wwli9jF1UP1OSbAmQEhy1+1NJm0kMk2PGTTsnOVbaaAhe5Ft
	 TzCPLDpN1U2f214Zcva4pI3R4vWYWx8+NkXKtGfbYFmGiMtD1EP9cMlErBa+1zu8Tq
	 B1ZYyabmjSrYRCP5U3KvfXY+3myuFhpvxZX3gj8Q=
Subject: FAILED: patch "[PATCH] scsi: qla2xxx: Fix use-after-free of qpair work on queue" failed to apply to 7.2-stable tree
To: njavali@marvell.com,mkp@kernel.org,sashiko-dev@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 13:17:18 +0200
Message-ID: <2026090918-carpenter-handrail-b6ca@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.2.y
git checkout FETCH_HEAD
git cherry-pick -x 19788a55cab61d78e33e0914a5a31d27843e8a4a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090918-carpenter-handrail-b6ca@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

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

