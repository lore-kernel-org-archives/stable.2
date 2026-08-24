Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2C1412BE7
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 12:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787573935; cv=none; b=mzMC+5peqQHGP5mgA/4g2EugRarX4Y03JpcTqBvnAvwwRij0Vv+GFN8BXlg0pp32o9IpAb0mfbrgdLe5XgttTcTke70MXwjbTqK4pUYBZX0MhSffwGdAIuj3DOomBz1lesOi4u0Wa3mMlkuelJQ7Js1MUfBFOnIzpllUZeR4rlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787573935; c=relaxed/simple;
	bh=nsMErFGLWjxKHCMFFMvZPdH1YoY68OdRMR6Vjo21//E=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=aDIW7J3XffAjK/JPmjLhT9H08ljr/Xycd/R7UbP9H9aG68tzdkYIiZau0jZrniq1ukUFA2Fl2+H9Bs/jhMDl/WB6TsCcfE1RHM6Helri64VyPDQIz8grvMNvHH7lN3JINbtKlhjAZkKhdENau5tXx5YDKRJlZs8khfABRgTI4xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ekMzLlKN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ekMzLlKN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D877E1F000E9;
	Mon, 24 Aug 2026 12:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787573933;
	bh=C687+X+HPWZjLMPo7phIqJR8/2oLcc/7PhEMjWU6+fI=;
	h=Subject:To:Cc:From:Date;
	b=ekMzLlKNQfP6IgdUEPExRtN5Y6ic63SS+rn+Qsc8onWcjUbVh7nOgV82jCn29D8vA
	 ideg8FyRA8suf70tQQcUfLpWzn2v1mRTk9bzl0xzOROxMNw50oSpQ0S0Ni3gcuPYV5
	 Z2U9W0HmaJFerUrdAB6cmDlz6mxhsvhDvDYxKXr4=
Subject: FAILED: patch "[PATCH] io_uring: defer eventfd signaling when queued from a wakeup" failed to apply to 6.18-stable tree
To: axboe@kernel.dk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Aug 2026 14:18:49 +0200
Message-ID: <2026082449-reapply-disdain-0fc8@gregkh>
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
git cherry-pick -x cd305ee3633a45fcf5f3a5d83f99f3cb77d87b6e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082449-reapply-disdain-0fc8@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cd305ee3633a45fcf5f3a5d83f99f3cb77d87b6e Mon Sep 17 00:00:00 2001
From: Jens Axboe <axboe@kernel.dk>
Date: Fri, 14 Aug 2026 06:58:43 -0600
Subject: [PATCH] io_uring: defer eventfd signaling when queued from a wakeup
 handler

io_req_local_work_add() signals the CQ ring eventfd inline when it is the
one to push the first entry onto ->work_list. For DEFER_TASKRUN rings that
add is frequently done from a waitqueue wakeup handler, where an
arbitrary waitqueue lock is held.

eventfd_signal_mask() only refuses to recurse when current->in_eventfd
is set, but that bit is set by eventfd_signal_mask() itself. If the wake
chain starts somewhere else, signal goes out inline and can feed back
into epoll.

Add IOU_F_TWQ_IN_WAKE, set it on the task_work add done from the three
waitqueue callbacks, and use it to force io_eventfd_signal() down the
existing call_rcu_hurry() deferral instead of signaling inline.

Fixes: 21a091b970cd ("io_uring: signal registered eventfd to process deferred task work")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20260813133843.2933127-1-4ncienth@gmail.com/
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
index a2c623a67a25..f6e90cc64a1f 100644
--- a/include/linux/io_uring_types.h
+++ b/include/linux/io_uring_types.h
@@ -20,6 +20,14 @@ enum {
 	 * It's also ignored unless IORING_SETUP_DEFER_TASKRUN is set.
 	 */
 	IOU_F_TWQ_LAZY_WAKE			= 1,
+
+	/*
+	 * Set when task_work is queued from a waitqueue wakeup handler, where
+	 * an arbitrary provider waitqueue lock is held. Signaling the CQ ring
+	 * eventfd inline from there can recurse back into that lock through
+	 * epoll, so the eventfd signal must be deferred.
+	 */
+	IOU_F_TWQ_IN_WAKE			= 2,
 };
 
 enum io_uring_cmd_flags {
diff --git a/io_uring/eventfd.c b/io_uring/eventfd.c
index d656cc2a0b9b..63fe6e5d79ba 100644
--- a/io_uring/eventfd.c
+++ b/io_uring/eventfd.c
@@ -51,9 +51,9 @@ static void io_eventfd_do_signal(struct rcu_head *rcu)
 /*
  * Returns true if the caller should put the ev_fd reference, false if not.
  */
-static bool __io_eventfd_signal(struct io_ev_fd *ev_fd)
+static bool __io_eventfd_signal(struct io_ev_fd *ev_fd, bool defer)
 {
-	if (eventfd_signal_allowed()) {
+	if (!defer && eventfd_signal_allowed()) {
 		eventfd_signal_mask(ev_fd->cq_ev_fd, EPOLL_URING_WAKE);
 		return true;
 	}
@@ -73,7 +73,7 @@ static bool io_eventfd_trigger(struct io_ev_fd *ev_fd)
 	return !ev_fd->eventfd_async || io_wq_current_is_worker();
 }
 
-void io_eventfd_signal(struct io_ring_ctx *ctx, bool cqe_event)
+void io_eventfd_signal(struct io_ring_ctx *ctx, bool cqe_event, bool defer)
 {
 	bool skip = false;
 	struct io_ev_fd *ev_fd;
@@ -113,7 +113,7 @@ void io_eventfd_signal(struct io_ring_ctx *ctx, bool cqe_event)
 		spin_unlock(&ctx->completion_lock);
 	}
 
-	if (skip || __io_eventfd_signal(ev_fd))
+	if (skip || __io_eventfd_signal(ev_fd, defer))
 		io_eventfd_put(ev_fd);
 }
 
diff --git a/io_uring/eventfd.h b/io_uring/eventfd.h
index 400eda4a4165..e965d80d9fdc 100644
--- a/io_uring/eventfd.h
+++ b/io_uring/eventfd.h
@@ -5,4 +5,4 @@ int io_eventfd_register(struct io_ring_ctx *ctx, void __user *arg,
 			unsigned int eventfd_async);
 int io_eventfd_unregister(struct io_ring_ctx *ctx);
 
-void io_eventfd_signal(struct io_ring_ctx *ctx, bool cqe_event);
+void io_eventfd_signal(struct io_ring_ctx *ctx, bool cqe_event, bool defer);
diff --git a/io_uring/futex.c b/io_uring/futex.c
index f0d80a444f45..eaee14242a3a 100644
--- a/io_uring/futex.c
+++ b/io_uring/futex.c
@@ -181,7 +181,7 @@ static void io_futex_wakev_fn(struct wake_q_head *wake_q, struct futex_q *q)
 
 	io_req_set_res(req, 0, 0);
 	req->io_task_work.func = io_futexv_complete;
-	io_req_task_work_add(req);
+	__io_req_task_work_add(req, IOU_F_TWQ_IN_WAKE);
 }
 
 int io_futexv_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
@@ -237,7 +237,7 @@ static void io_futex_wake_fn(struct wake_q_head *wake_q, struct futex_q *q)
 
 	io_req_set_res(req, 0, 0);
 	req->io_task_work.func = io_futex_complete;
-	io_req_task_work_add(req);
+	__io_req_task_work_add(req, IOU_F_TWQ_IN_WAKE);
 }
 
 int io_futexv_wait(struct io_kiocb *req, unsigned int issue_flags)
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 4c83a94b4bdc..76f049e29aa2 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -475,7 +475,7 @@ void __io_commit_cqring_flush(struct io_ring_ctx *ctx)
 	if (ctx->int_flags & IO_RING_F_OFF_TIMEOUT_USED)
 		io_flush_timeouts(ctx);
 	if (ctx->int_flags & IO_RING_F_HAS_EVFD)
-		io_eventfd_signal(ctx, true);
+		io_eventfd_signal(ctx, true, false);
 }
 
 static inline void __io_cq_lock(struct io_ring_ctx *ctx)
diff --git a/io_uring/poll.c b/io_uring/poll.c
index 0204affdc308..5447a7c24dce 100644
--- a/io_uring/poll.c
+++ b/io_uring/poll.c
@@ -208,9 +208,9 @@ enum {
 	IOU_POLL_REQUEUE = 4,
 };
 
-static void __io_poll_execute(struct io_kiocb *req, int mask)
+static void __io_poll_execute(struct io_kiocb *req, int mask, unsigned tw_flags)
 {
-	unsigned flags = 0;
+	unsigned flags = tw_flags;
 
 	io_req_set_res(req, mask, 0);
 	req->io_task_work.func = io_poll_task_func;
@@ -218,14 +218,15 @@ static void __io_poll_execute(struct io_kiocb *req, int mask)
 	trace_io_uring_task_add(req, mask);
 
 	if (!(req->flags & REQ_F_POLL_NO_LAZY))
-		flags = IOU_F_TWQ_LAZY_WAKE;
+		flags |= IOU_F_TWQ_LAZY_WAKE;
 	__io_req_task_work_add(req, flags);
 }
 
-static inline void io_poll_execute(struct io_kiocb *req, int res)
+static inline void io_poll_execute(struct io_kiocb *req, int res,
+				   unsigned tw_flags)
 {
 	if (io_poll_get_ownership(req))
-		__io_poll_execute(req, res);
+		__io_poll_execute(req, res, tw_flags);
 }
 
 /*
@@ -344,7 +345,7 @@ void io_poll_task_func(struct io_tw_req tw_req, io_tw_token_t tw)
 	if (ret == IOU_POLL_NO_ACTION) {
 		return;
 	} else if (ret == IOU_POLL_REQUEUE) {
-		__io_poll_execute(req, 0);
+		__io_poll_execute(req, 0, 0);
 		return;
 	}
 	io_poll_remove_entries(req);
@@ -383,7 +384,7 @@ static void io_poll_cancel_req(struct io_kiocb *req)
 {
 	io_poll_mark_cancelled(req);
 	/* kick tw, which should complete the request */
-	io_poll_execute(req, 0);
+	io_poll_execute(req, 0, 0);
 }
 
 #define IO_ASYNC_POLL_COMMON	(EPOLLONESHOT | EPOLLPRI)
@@ -392,7 +393,7 @@ static __cold int io_pollfree_wake(struct io_kiocb *req, struct io_poll *poll)
 {
 	io_poll_mark_cancelled(req);
 	/* we have to kick tw in case it's not already */
-	io_poll_execute(req, 0);
+	io_poll_execute(req, 0, IOU_F_TWQ_IN_WAKE);
 	io_poll_remove_waitq(poll);
 	return 1;
 }
@@ -430,7 +431,7 @@ static int io_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
 			else
 				req->flags &= ~REQ_F_SINGLE_POLL;
 		}
-		__io_poll_execute(req, mask);
+		__io_poll_execute(req, mask, IOU_F_TWQ_IN_WAKE);
 	}
 	return 1;
 }
@@ -618,7 +619,7 @@ static int __io_arm_poll_handler(struct io_kiocb *req,
 
 	if (mask && (poll->events & EPOLLET) &&
 	    io_poll_can_finish_inline(req, ipt)) {
-		__io_poll_execute(req, mask);
+		__io_poll_execute(req, mask, 0);
 		return 0;
 	}
 	io_napi_add(req);
@@ -629,7 +630,7 @@ static int __io_arm_poll_handler(struct io_kiocb *req,
 		 * poll was waken up, queue up a tw, it'll deal with it.
 		 */
 		if (atomic_cmpxchg(&req->poll_refs, 1, 0) != 1)
-			__io_poll_execute(req, 0);
+			__io_poll_execute(req, 0, 0);
 	}
 	return 0;
 }
diff --git a/io_uring/tw.c b/io_uring/tw.c
index a4c872870d81..bf4e5aa5c2e7 100644
--- a/io_uring/tw.c
+++ b/io_uring/tw.c
@@ -170,7 +170,7 @@ void io_req_local_work_add(struct io_kiocb *req, unsigned flags)
 	if (mpscq_push(&ctx->work_list, &req->io_task_work.node)) {
 		io_ctx_mark_taskrun(ctx);
 		if (data_race(ctx->int_flags) & IO_RING_F_HAS_EVFD)
-			io_eventfd_signal(ctx, false);
+			io_eventfd_signal(ctx, false, flags & IOU_F_TWQ_IN_WAKE);
 	}
 
 	/*
diff --git a/io_uring/waitid.c b/io_uring/waitid.c
index 32f68fd7fcdd..76af129ba8ca 100644
--- a/io_uring/waitid.c
+++ b/io_uring/waitid.c
@@ -253,7 +253,7 @@ static int io_waitid_wait(struct wait_queue_entry *wait, unsigned mode,
 		return 1;
 
 	req->io_task_work.func = io_waitid_cb;
-	io_req_task_work_add(req);
+	__io_req_task_work_add(req, IOU_F_TWQ_IN_WAKE);
 	return 1;
 }
 

