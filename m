Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A25A3AF66C
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 12:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788178968; cv=none; b=KCmgp++PxRNPp/XSv7mdVzULweEqYYSIJmsa91ChTv8kkhR8xX+jpIvu8ZsKwnrsLXBw1YYmAlYMCMd4hS5vz2yF0QV7xTXSTiZ047Allam2VrsadgKxgYPqi0BsQPGpS07yKDssJzTrO5kmyAS229OUSwR3Oj4mHRcuW1PYynA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788178968; c=relaxed/simple;
	bh=G+Kxmsy4Z80ZGPqgy3oGDtKgTHRkQnbC/UyL0z7/8IQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bWllRHXn4ufiSqW5hK0hZKJHzuLCTKIvo9yScej1k+mbbqh+6y0c856flK7ZZKGomsiaNe+nBiZEibmYVSIYGgZAl5rZPYZsXYBBy9nCA9pH33sDFeKGWByumz81CeqHB18di4hQ6v2x+YcjWHzEAEh5mur9dXbOpHlb4TV9xQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NMu/FZzx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NMu/FZzx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 711771F000E9;
	Mon, 31 Aug 2026 12:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788178967;
	bh=qchz8TI69G0u6/Q1S0ViEIjLwKlwAFk3eP0Kyz2m2AY=;
	h=Subject:To:Cc:From:Date;
	b=NMu/FZzxfCsfWiVb15Wf95F8nrasiwEsLGyJvJFDgGtNFuyXDZqfwChtn4DWr9zMO
	 +KZzhTKW6muugPn1p2E0Kax2h9SGL7J6hAezEI2cBfsEmdWeP+FSJozRm3JPfvbYP5
	 z9sCXAYqEshOyL4omcjOuWt1JpXtMJxB0GVQBjYo=
Subject: FAILED: patch "[PATCH] fuse: fix race between interrupt and resend" failed to apply to 6.12-stable tree
To: mszeredi@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 31 Aug 2026 14:22:32 +0200
Message-ID: <2026083132-jaundice-glutinous-0a68@gregkh>
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
git cherry-pick -x ed9c881f3b498383f73c42712b359419da42a7b0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026083132-jaundice-glutinous-0a68@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ed9c881f3b498383f73c42712b359419da42a7b0 Mon Sep 17 00:00:00 2001
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Thu, 9 Jul 2026 08:37:05 +0200
Subject: [PATCH] fuse: fix race between interrupt and resend

After commit f8fce75fedf7 ("fuse: clear intr_entry in fuse_resend and
fuse_remove_pending_req") the WARN_ON(!list_empty(&req->intr_entry)) in
fuse_request_free() still triggers due to the following race:

In request_wait_answer()
  if (test_bit(FR_SENT, &req->flags)) -> returns true

In fuse_chan_resend()
  clear_bit(FR_SENT, &req->flags)

In request_wait_answer()
  queue_interrupt(req)

Fix by:

 - move clearing FR_SENT inside fpq->lock

 - move setting FR_PENDING inside fiq->lock

 - recheck FR_SENT after acquiring fiq->lock in fuse_dev_queue_interrupt()

Reported-by: zdi-disclosures@trendmicro.com
Fixes: f8fce75fedf7 ("fuse: clear intr_entry in fuse_resend and fuse_remove_pending_req")
Cc: stable@vger.kernel.org # 6.9
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 5763a7cd3b37..7e81dea4f1c7 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -240,7 +240,8 @@ void fuse_dev_queue_forget(struct fuse_iqueue *fiq,
 void fuse_dev_queue_interrupt(struct fuse_iqueue *fiq, struct fuse_req *req)
 {
 	spin_lock(&fiq->lock);
-	if (list_empty(&req->intr_entry)) {
+	/* Repeat FR_SENT test after obtaining the lock to prevent race with fuse_resend() */
+	if (list_empty(&req->intr_entry) && test_bit(FR_SENT, &req->flags)) {
 		list_add_tail(&req->intr_entry, &fiq->interrupts);
 		/*
 		 * Pairs with smp_mb() implied by test_and_set_bit()
@@ -1760,7 +1761,7 @@ static ssize_t fuse_dev_splice_read(struct file *in, loff_t *ppos,
 void fuse_chan_resend(struct fuse_chan *fch)
 {
 	struct fuse_dev *fud;
-	struct fuse_req *req, *next;
+	struct fuse_req *req;
 	struct fuse_iqueue *fiq = &fch->iq;
 	LIST_HEAD(to_queue);
 	unsigned int i;
@@ -1775,24 +1776,20 @@ void fuse_chan_resend(struct fuse_chan *fch)
 		struct fuse_pqueue *fpq = &fud->pq;
 
 		spin_lock(&fpq->lock);
-		for (i = 0; i < FUSE_PQ_HASH_SIZE; i++)
-			list_splice_tail_init(&fpq->processing[i], &to_queue);
+		for (i = 0; i < FUSE_PQ_HASH_SIZE; i++) {
+			struct list_head *this_queue = &fpq->processing[i];
+
+			list_for_each_entry(req, this_queue, list)
+				clear_bit(FR_SENT, &req->flags);
+			list_splice_tail_init(this_queue, &to_queue);
+		}
 		spin_unlock(&fpq->lock);
 	}
 	spin_unlock(&fch->lock);
 
-	list_for_each_entry_safe(req, next, &to_queue, list) {
-		set_bit(FR_PENDING, &req->flags);
-		clear_bit(FR_SENT, &req->flags);
-		/* mark the request as resend request */
-		req->in.h.unique |= FUSE_UNIQUE_RESEND;
-	}
-
 	spin_lock(&fiq->lock);
 	if (!fiq->connected) {
 		spin_unlock(&fiq->lock);
-		list_for_each_entry(req, &to_queue, list)
-			clear_bit(FR_PENDING, &req->flags);
 		fuse_dev_end_requests(&to_queue);
 		return;
 	}
@@ -1801,6 +1798,10 @@ void fuse_chan_resend(struct fuse_chan *fch)
 	 * intr_entry on fiq->interrupts after the request is re-queued.
 	 */
 	list_for_each_entry(req, &to_queue, list) {
+		set_bit(FR_PENDING, &req->flags);
+		/* mark the request as resend request */
+		req->in.h.unique |= FUSE_UNIQUE_RESEND;
+
 		if (test_bit(FR_INTERRUPTED, &req->flags))
 			list_del_init(&req->intr_entry);
 	}

