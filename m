Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023252D8DDF
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 13:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791033279; cv=none; b=mDjO6zb+xIRVq6e0gM9Sk2PJL90ajlgXeoHBoAWw6oE+1XZ0ainqf0B+8upih773dRoyEHfiJQJiE/5AWpRMfWgdvcj7zstYQ9lDVVfLy1OT/1BNEYanjCwCQ2FqmchgfdNQhDuCvE98HjQMDQiX0UpE5f0jjcyEadiqHvDb4Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791033279; c=relaxed/simple;
	bh=vjnXTnWDpKpA+vHjFNpN66iVt5behjY7z8NBpbUO2mk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YhDFlqmzl+rgX8+VSbJKnYClIZHTlVDUQFa4ZZltiaHdQyhQV7m254jwd1/CDVNd2g0cJBy/2FJhSpJgqI0UOgk7ZJekr4uFM6vspyyif69yMss4GVVDyCrEy9wsJiQw6xWjBmaO+pRvATnbxicC4hiySgP6LJwpWXAIorNSWPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MAfMSgMz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MAfMSgMz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 061ED1F0089B;
	Sat,  3 Oct 2026 13:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791033276;
	bh=vKMFKBsZMHRHdnAY1pXBZW97AFN7KJ4ibaYnbr8QKFo=;
	h=Subject:To:Cc:From:Date;
	b=MAfMSgMz3G2Fk1weFDShymzeYzMGXFYH8K0tv8Jwfsm8RsfEVEV5OJLbI1XyIK2UI
	 x99tmcBTzycWuNXFRsEfbD8UqO36j5UtS3kv5ut2cUyymjnL9qTXzHhx4ddgNrKGHV
	 LAMqtop3ifE+6Wrkp4WlDopInEs292ckQ7lzk+bA=
Subject: FAILED: patch "[PATCH] io_uring: fix task_work add use-after-free with SQPOLL" failed to apply to 6.18-stable tree
To: axboe@kernel.dk,Jeremy.Jean@oss.cyber.gouv.fr
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 03 Oct 2026 15:14:33 +0200
Message-ID: <2026100333-unpicked-popsicle-044c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x a92193c91e8839fe5fc209616ea95465ae4b919d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100333-unpicked-popsicle-044c@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a92193c91e8839fe5fc209616ea95465ae4b919d Mon Sep 17 00:00:00 2001
From: Jens Axboe <axboe@kernel.dk>
Date: Tue, 29 Sep 2026 06:52:17 -0600
Subject: [PATCH] io_uring: fix task_work add use-after-free with SQPOLL
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

For SQPOLL, the sqpoll thread runs task_work off its own list and
doesn't need to be told about it, so it can pop and complete a request
as soon as mpscq_push() has published it. If that was the last request
holding the ring alive, io_ring_exit_work() then frees the ctx, stops
the thread, and with it the tctx, while io_req_normal_work_add() is
still looking at both after the push:

  BUG: KASAN: slab-use-after-free in io_req_normal_work_add+0x439/0x510
  Read of size 4 at addr ff11000000ca0000 by task repro/55
  (...)
  BUG: KASAN: slab-use-after-free in queue_work_on+0x25/0x70
  Write of size 8 at addr ff11000000c3bd00 by task repro/55

Hold an RCU read lock across the add, like io_req_local_work_add() already
does, and have io_ring_exit_work() wait for a grace period for SQPOLL rings
as well before freeing the ctx.

Reported-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Link: https://lore.kernel.org/io-uring/20260924205056.3759980-2-Jeremy.Jean@oss.cyber.gouv.fr/
Fixes: af5d68f8892f ("io_uring/sqpoll: manage task_work privately")
Cc: stable@vger.kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 2cb9b58d04dd..c2ce83c7c1f1 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2405,8 +2405,8 @@ static __cold void io_ring_exit_work(struct work_struct *work)
 	spin_lock(&ctx->completion_lock);
 	spin_unlock(&ctx->completion_lock);
 
-	/* pairs with RCU read section in io_req_local_work_add() */
-	if (ctx->flags & IORING_SETUP_DEFER_TASKRUN)
+	/* pairs with the RCU read sections in the task_work add paths */
+	if (ctx->flags & (IORING_SETUP_DEFER_TASKRUN | IORING_SETUP_SQPOLL))
 		synchronize_rcu();
 
 	io_ring_ctx_free(ctx);
diff --git a/io_uring/tw.c b/io_uring/tw.c
index f573bcc3af6a..f9affd68dd26 100644
--- a/io_uring/tw.c
+++ b/io_uring/tw.c
@@ -210,6 +210,9 @@ void io_req_normal_work_add(struct io_kiocb *req)
 	struct io_uring_task *tctx = req->tctx;
 	struct io_ring_ctx *ctx = req->ctx;
 
+	/* SQPOLL can retire the request on push, see io_ring_exit_work() */
+	guard(rcu)();
+
 	/* tw run already pending, nothing else to do */
 	if (!mpscq_push(&tctx->task_list, &req->io_task_work.node))
 		return;

