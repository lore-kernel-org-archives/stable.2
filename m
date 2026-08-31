Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B2E2DB7BF
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 12:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788178986; cv=none; b=KNBgYlSQmMPWsjYRG7uPKqWcbZMEW03qOJF+hvDq+SoZS/ZifoV/gcIaFCChK0rm6e9VKrfuvCtGnuzPV6FgWP+JGmLDzD97Ruk1FEuzBy8P6tISGFC0/GgU5E69ArTgKCBp6yaYjF3H/ZhMmEkPO/Lw15Zb5b4a9VqthIexkuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788178986; c=relaxed/simple;
	bh=O7Z/RQjeCn6BDPplwhcqO31oS6VxgpZQKPKP8XuBcdg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NwolpVyZjGaZhpkeewMp0UjTomSHVkw/wz/vHuKAiqQtoNquah58VmmDKGKPGZnwpjPlZmCxhXu3dyG9xxTRnok9bSoDX4H4rF3nqyuEGKRl1rqRKz0qyi5PlgSSvQLwCCye6SRjpztMquDA1DbUQgIFOZ2DxD5EdN/KpbHucdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zRUFGKeu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zRUFGKeu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 503D41F000E9;
	Mon, 31 Aug 2026 12:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788178984;
	bh=yDsMvQ1xtJBVooy/0Qmys4mSG6wizfpaWeAIbFVfi8s=;
	h=Subject:To:Cc:From:Date;
	b=zRUFGKeu5SZnlW+3DLc7rz3BHHtzjCjBEWoG375lvLEAAMT+XZKe9NGXMwxDBqgcN
	 r9yIHhtShXXVCTsQyiAFTCjRUEE2LBFTsmERfMDSx3KwyhHof3Gvfjp8gEHIOO91Be
	 bO1kyCFZqWG+4jHwA5GMwh9lsruz6Lwhp87j6y6U=
Subject: FAILED: patch "[PATCH] fuse: publish io-uring queues with release semantics" failed to apply to 6.18-stable tree
To: joannelkoong@gmail.com,bernd@bsbernd.com,mszeredi@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 31 Aug 2026 14:22:52 +0200
Message-ID: <2026083152-cucumber-unwieldy-2691@gregkh>
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
git cherry-pick -x 42df916e5a5f8fb4b60c8cefb54318d1ec02c580
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026083152-cucumber-unwieldy-2691@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 42df916e5a5f8fb4b60c8cefb54318d1ec02c580 Mon Sep 17 00:00:00 2001
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 16 Jul 2026 11:31:44 -0700
Subject: [PATCH] fuse: publish io-uring queues with release semantics

fuse_uring_create_queue() initializes a fuse_ring_queue and then
publishes the pointer into ring->queues[qid] with WRITE_ONCE() under the
fch->lock. There are several readers that may concurrently be fetching
that pointer locklessly and then deferencing it.

WRITE_ONCE() doesn't ensure ordering of the queue's field
initialization before the ring->queues[qid] pointer assignment. The
queue must be published with smp_store_release() so the field
initialization is guaranteed to happen before.

Readers in paths where the read may happen concurrently with the store
need to use READ_ONCE() because any race involving a plain access is
undefined.

Fixes: 24fe962c86f5 ("fuse: {io-uring} Handle SQEs - register commands")
Cc: stable@vger.kernel.org
Reviewed-by: Bernd Schubert <bernd@bsbernd.com>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 51f985154aa1..c8488ebc1d1f 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -204,7 +204,7 @@ void fuse_uring_destruct(struct fuse_chan *fch)
 		return;
 
 	for (qid = 0; qid < ring->nr_queues; qid++) {
-		struct fuse_ring_queue *queue = ring->queues[qid];
+		struct fuse_ring_queue *queue = READ_ONCE(ring->queues[qid]);
 		struct fuse_ring_ent *ent, *next;
 
 		if (!queue)
@@ -223,7 +223,7 @@ void fuse_uring_destruct(struct fuse_chan *fch)
 
 		kfree(queue->fpq.processing);
 		kfree(queue);
-		ring->queues[qid] = NULL;
+		WRITE_ONCE(ring->queues[qid], NULL);
 	}
 
 	kfree(ring->queues);
@@ -321,9 +321,11 @@ static struct fuse_ring_queue *fuse_uring_create_queue(struct fuse_ring *ring,
 	}
 
 	/*
-	 * write_once and lock as the caller mostly doesn't take the lock at all
+	 * fch->lock serializes concurrent creators for this qid.
+	 * smp_store_release() are for the lockless readers who must see a
+	 * fully initialized queue after &ring->queues[qid] is set
 	 */
-	WRITE_ONCE(ring->queues[qid], queue);
+	smp_store_release(&ring->queues[qid], queue);
 	spin_unlock(&fch->lock);
 
 	return queue;
@@ -434,7 +436,7 @@ static void fuse_uring_log_ent_state(struct fuse_ring *ring)
 	struct fuse_ring_ent *ent;
 
 	for (qid = 0; qid < ring->nr_queues; qid++) {
-		struct fuse_ring_queue *queue = ring->queues[qid];
+		struct fuse_ring_queue *queue = READ_ONCE(ring->queues[qid]);
 
 		if (!queue)
 			continue;
@@ -967,7 +969,7 @@ static int fuse_uring_commit_fetch(struct io_uring_cmd *cmd, int issue_flags,
 	if (qid >= ring->nr_queues)
 		return -EINVAL;
 
-	queue = ring->queues[qid];
+	queue = READ_ONCE(ring->queues[qid]);
 	if (!queue)
 		return err;
 	fpq = &queue->fpq;
@@ -1035,7 +1037,7 @@ static bool is_ring_ready(struct fuse_ring *ring, int current_qid)
 		if (current_qid == qid)
 			continue;
 
-		queue = ring->queues[qid];
+		queue = READ_ONCE(ring->queues[qid]);
 		if (!queue) {
 			ready = false;
 			break;
@@ -1191,7 +1193,7 @@ static int fuse_uring_register(struct io_uring_cmd *cmd,
 		return -EINVAL;
 	}
 
-	queue = ring->queues[qid];
+	queue = READ_ONCE(ring->queues[qid]);
 	if (!queue) {
 		queue = fuse_uring_create_queue(ring, qid);
 		if (!queue)
@@ -1332,7 +1334,7 @@ static struct fuse_ring_queue *fuse_uring_task_to_queue(struct fuse_ring *ring)
 		      ring->nr_queues))
 		qid = 0;
 
-	queue = ring->queues[qid];
+	queue = READ_ONCE(ring->queues[qid]);
 	WARN_ONCE(!queue, "Missing queue for qid %d\n", qid);
 
 	return queue;

