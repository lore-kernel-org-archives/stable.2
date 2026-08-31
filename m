Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4552EBB8D
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 12:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788178965; cv=none; b=drqLIl4RLnEFDNWLaKjSxGP3Qjr1gy5n2KgmOX5OuBqiDOEiL8hBS1Qx6EFGmdgTgHLVxUpIMjK3IKjg8QHh04ks4v88it9MoZ7tedRai1LjI28VAeAIGODQ2VoWK0S+eXSXnMrdrt042zYkfwJyJQfMKLxgNH1EDBfxmeMktN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788178965; c=relaxed/simple;
	bh=442T1xF/PGB2yafs6qcKMQLREncdkx1ZYFgdNVKASUA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=n38Vd9ht/OqvS09WPFJNI6J3s8Qr/uVf0UWJc4vf6iNR+AXv6G+6IX6IyAnu8WSvpaCGQiUWMOI4Bpr+Ki0j1rI6Be+NvQp2aeC70LyaW3OOQFWw3yxhIsPBbhcQxMhM+8ze44EhjxHI73Al4VdJz5gpjLquBBKU6wZCpJcNENc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L2uSHis9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L2uSHis9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1AA61F000E9;
	Mon, 31 Aug 2026 12:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788178964;
	bh=NC7g0gKE+DxJ5jhm6FiKgD3TzShkuVIcVmNjkkjZUBM=;
	h=Subject:To:Cc:From:Date;
	b=L2uSHis9irFmu5+A/i3JjoCx8418FWMbhlO8z10XJ/Ie8dv1VWH6uIWDj4N9Ire1u
	 yI+Bmdb8cylUCXQ3G4KAK2v0o1f2coPABk37TiFZoU7FfLRmIS/dvWdeK1lpUCxjXy
	 CdbFItr1XnWuDrj4wId10AdhbZ0wH50IFGEW4alM=
Subject: FAILED: patch "[PATCH] fuse: fix race between interrupt and resend" failed to apply to 6.18-stable tree
To: mszeredi@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 31 Aug 2026 14:22:32 +0200
Message-ID: <2026083132-jaybird-willed-acf3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x ed9c881f3b498383f73c42712b359419da42a7b0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026083132-jaybird-willed-acf3@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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

