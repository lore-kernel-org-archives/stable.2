Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EB64C8FE6
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953128; cv=none; b=IPXZ8D8mSyfr4HhOCVNBgpCE85e9osLOZNgy7fCAA5zrvUhxL5R8Q1yqstsWl4hIX5ZIAK9iP2J08YVS/9Q87WGBWd29/q1V/96oc9BTvRjonkve929Xm/ZGBRzgMP8D+2LxuN4J6DVsT4G7L08y13KiykKy4ROMtDaLuPflltw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953128; c=relaxed/simple;
	bh=lnK8YrWlwc9l1DV1whaRQx/C5OzXifKBSBuOV4rh+LU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ApmQrc3H+3V4NUR8S7fyFsQHBk6b1QOZ2Bh7pv8/3SyxexirUXvXI5Y8Zgq9ZFFAfypZHKlEEy7u0voGCkff18gsf/ZTZ+MA1HGerQRvNS8zFsonYM/QG0cSrytx6/wWPByIPhs3vqjDcFi1f2YWP6QGxAkWGYXlJSLJEjlCvGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DGfplQZn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DGfplQZn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA321F00A3A;
	Wed,  9 Sep 2026 11:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788953126;
	bh=pSbPUv4T9RYFYEOQid00OebrB3hRWQF8cFs9Cdg6b7U=;
	h=Subject:To:Cc:From:Date;
	b=DGfplQZn74ipk3j4ihtWkuCa6o7XQQwnwpVzkJeiYmZclyzrTEFv4NJc9w+ehxrWJ
	 DZ6pdejf1HNA9PECNhIsdl0BUR5/KvLJr/WH0xYHMA4h7MX8Elr1iTJhpDFjCfhbD0
	 ea36eIoxmF6cMKaXE6FaPje1UFJ2f0HihL18gBRg=
Subject: FAILED: patch "[PATCH] scsi: qla2xxx: Fix use-after-free of qpair work on queue" failed to apply to 5.10-stable tree
To: njavali@marvell.com,mkp@kernel.org,sashiko-dev@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 13:17:21 +0200
Message-ID: <2026090921-foe-those-b6a7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 19788a55cab61d78e33e0914a5a31d27843e8a4a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090921-foe-those-b6a7@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

