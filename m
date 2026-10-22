Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792679450;
	b=5bmAXoE+T9OaCPOzhBZriEZFnQnVb1+gPYp2WhSWlAvBYuQN7fQGD2H/nfR8ixuFYo9u
	 Dl6JkdFtUkRsrxY5bLLxWXgtrfNdWssCTyLIgi+F4H/GOPl2q+7f7i9Rxai90yHF6UV0q
	 InD0p4MIAwVCi8hpPLGxp5lWBzSDAtt5PqGgQUwOLD8A1wYhWWSwM06Tv/HQQ7vco52t6
	 e+8WiOzmbZYvQcuSf9i1KGYRjg4LIBK4GJuhWnI3GTLY8Fx4crG8/FZa/VxMMe5/NH1UV
	 p2zZrNCXPVgHDFy8gmN6gGlLlzL5XulHV/4caf9CDpld8IiWJ113QowXsGSSf64L85Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792679450;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=VbtQOdqgrmOiNcSYPTDoxWvopQSXH46ksXdTtYRDLyw=;
	b=CyDLGMpdntDQNnc47yKu02lJ8H6k9gpBNX8nD2yL2LzkV9Kq7K6g/aGWPPXTi0ei6vrk
	 qqWEwLgS1CKmTnyyGejLTNVMhHwFoSn6yXnQkrg79ABHUhvSPenRE0EmiL3S8Qb3aBnBu
	 C4wUSNCD8w2CRWLKzp7GzunH6yC6MYNVJLqpduAsI8xpPVoabQcSFOTx5DxU0Eisqle5Q
	 K9HTU0p87bXPnM3RuRYGPmbVDL2suX+toHJ3OQn6tWu7f6ilMZGi5TlpFsIlId0JtzYAQ
	 hbiLynpIATthcmfU/YiEh2kjT6t4jX3YjsnLy/2vez+rbbekLz5NUtHpD/62Rvv4/kQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jyqv5JBd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C2B606A31A
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 14:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jyqv5JBd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 194F11F000C1;
	Thu, 22 Oct 2026 14:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792679449;
	bh=VbtQOdqgrmOiNcSYPTDoxWvopQSXH46ksXdTtYRDLyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jyqv5JBd84URkKne2QYEbgc2vyOHLw5+xsXPwly24ECiNh2+qy0MKyPbc+EvTP2hg
	 Pf4HRcbIrPJ3Nub0bkVnf0oRJX7M3iXQgiWYcJeZofnuFAsv3C7NerQ7oLQaYNIllB
	 AhkHB6jIo6ULbNnOU32m9A/pxaHHNE7AEGU69RJoOANzH7qPM11m1XVfc+EH3KDQsP
	 ssoyEFMshcJ1b8bBzy4xcEKVT/vyLcQXXJBC/jOo5tNT/VF/8zp5lTXou3rj+TB/QF
	 cunLvzVQjX71FpP1WQndVhD/9TI0Pahj+Ou89CpY97fszj8b2qSsK6d6Gw1n4JTcZl
	 b/6zWvOL2Az/g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/4] io_uring/cancel: move cancelation code from io_uring.c to cancel.c
Date: Thu, 22 Oct 2026 10:30:45 -0400
Message-ID: <20261022143039.1598352-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261022143039.1598352-1-sashal@kernel.org>
References: <2026102127-pettiness-citation-cb83@gregkh>
 <20261022143039.1598352-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jens Axboe <axboe@kernel.dk>

[ Upstream commit ffce324364318220acf83e576eac06549cbf9911 ]

There's a bunch of code strictly dealing with cancelations, and that
code really belongs in cancel.c rather than in the core io_uring.c file.
Move the code there. Mostly mechanical, only real oddity here is that
struct io_defer_entry now needs to be visible across both io_uring.c
and cancel.c.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: fddcf4c5321b ("io_uring/cancel: don't spin on local work the task can't run")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/cancel.c   | 226 ++++++++++++++++++++++++++++++++++++++++
 io_uring/cancel.h   |   6 +-
 io_uring/io_uring.c | 244 +-------------------------------------------
 io_uring/io_uring.h |  10 +-
 io_uring/sqpoll.c   |   1 +
 5 files changed, 245 insertions(+), 242 deletions(-)

diff --git a/io_uring/cancel.c b/io_uring/cancel.c
index 3ba82a1bfe804..ca12ac10c0ae9 100644
--- a/io_uring/cancel.c
+++ b/io_uring/cancel.c
@@ -14,6 +14,8 @@
 #include "filetable.h"
 #include "io_uring.h"
 #include "tctx.h"
+#include "sqpoll.h"
+#include "uring_cmd.h"
 #include "poll.h"
 #include "timeout.h"
 #include "waitid.h"
@@ -428,3 +430,227 @@ void __io_uring_cancel(bool cancel_all)
 	io_uring_unreg_ringfd();
 	io_uring_cancel_generic(cancel_all, NULL);
 }
+
+struct io_task_cancel {
+	struct io_uring_task *tctx;
+	bool all;
+};
+
+static bool io_cancel_task_cb(struct io_wq_work *work, void *data)
+{
+	struct io_kiocb *req = container_of(work, struct io_kiocb, work);
+	struct io_task_cancel *cancel = data;
+
+	return io_match_task_safe(req, cancel->tctx, cancel->all);
+}
+
+static __cold bool io_cancel_defer_files(struct io_ring_ctx *ctx,
+					 struct io_uring_task *tctx,
+					 bool cancel_all)
+{
+	struct io_defer_entry *de;
+	LIST_HEAD(list);
+
+	list_for_each_entry_reverse(de, &ctx->defer_list, list) {
+		if (io_match_task_safe(de->req, tctx, cancel_all)) {
+			list_cut_position(&list, &ctx->defer_list, &de->list);
+			break;
+		}
+	}
+	if (list_empty(&list))
+		return false;
+
+	while (!list_empty(&list)) {
+		de = list_first_entry(&list, struct io_defer_entry, list);
+		list_del_init(&de->list);
+		ctx->nr_drained -= io_linked_nr(de->req);
+		io_req_task_queue_fail(de->req, -ECANCELED);
+		kfree(de);
+	}
+	return true;
+}
+
+__cold bool io_cancel_ctx_cb(struct io_wq_work *work, void *data)
+{
+	struct io_kiocb *req = container_of(work, struct io_kiocb, work);
+
+	return req->ctx == data;
+}
+
+static __cold bool io_uring_try_cancel_iowq(struct io_ring_ctx *ctx)
+{
+	struct io_tctx_node *node;
+	enum io_wq_cancel cret;
+	bool ret = false;
+
+	mutex_lock(&ctx->uring_lock);
+	list_for_each_entry(node, &ctx->tctx_list, ctx_node) {
+		struct io_uring_task *tctx = node->task->io_uring;
+
+		/*
+		 * io_wq will stay alive while we hold uring_lock, because it's
+		 * killed after ctx nodes, which requires to take the lock.
+		 */
+		if (!tctx || !tctx->io_wq)
+			continue;
+		cret = io_wq_cancel_cb(tctx->io_wq, io_cancel_ctx_cb, ctx, true);
+		ret |= (cret != IO_WQ_CANCEL_NOTFOUND);
+	}
+	mutex_unlock(&ctx->uring_lock);
+
+	return ret;
+}
+
+__cold bool io_uring_try_cancel_requests(struct io_ring_ctx *ctx,
+					 struct io_uring_task *tctx,
+					 bool cancel_all, bool is_sqpoll_thread)
+{
+	struct io_task_cancel cancel = { .tctx = tctx, .all = cancel_all, };
+	enum io_wq_cancel cret;
+	bool ret = false;
+
+	/* set it so io_req_local_work_add() would wake us up */
+	if (ctx->flags & IORING_SETUP_DEFER_TASKRUN) {
+		atomic_set(&ctx->cq_wait_nr, 1);
+		smp_mb();
+	}
+
+	/* failed during ring init, it couldn't have issued any requests */
+	if (!ctx->rings)
+		return false;
+
+	if (!tctx) {
+		ret |= io_uring_try_cancel_iowq(ctx);
+	} else if (tctx->io_wq) {
+		/*
+		 * Cancels requests of all rings, not only @ctx, but
+		 * it's fine as the task is in exit/exec.
+		 */
+		cret = io_wq_cancel_cb(tctx->io_wq, io_cancel_task_cb,
+				       &cancel, true);
+		ret |= (cret != IO_WQ_CANCEL_NOTFOUND);
+	}
+
+	/* SQPOLL thread does its own polling */
+	if ((!(ctx->flags & IORING_SETUP_SQPOLL) && cancel_all) ||
+	    is_sqpoll_thread) {
+		while (!wq_list_empty(&ctx->iopoll_list)) {
+			io_iopoll_try_reap_events(ctx);
+			ret = true;
+			cond_resched();
+		}
+	}
+
+	if ((ctx->flags & IORING_SETUP_DEFER_TASKRUN) &&
+	    io_allowed_defer_tw_run(ctx))
+		ret |= io_run_local_work(ctx, INT_MAX, INT_MAX) > 0;
+	mutex_lock(&ctx->uring_lock);
+	ret |= io_cancel_defer_files(ctx, tctx, cancel_all);
+	ret |= io_poll_remove_all(ctx, tctx, cancel_all);
+	ret |= io_waitid_remove_all(ctx, tctx, cancel_all);
+	ret |= io_futex_remove_all(ctx, tctx, cancel_all);
+	ret |= io_uring_try_cancel_uring_cmd(ctx, tctx, cancel_all);
+	mutex_unlock(&ctx->uring_lock);
+	ret |= io_kill_timeouts(ctx, tctx, cancel_all);
+	if (tctx)
+		ret |= io_run_task_work() > 0;
+	else
+		ret |= flush_delayed_work(&ctx->fallback_work);
+	return ret;
+}
+
+static s64 tctx_inflight(struct io_uring_task *tctx, bool tracked)
+{
+	if (tracked)
+		return atomic_read(&tctx->inflight_tracked);
+	return percpu_counter_sum(&tctx->inflight);
+}
+
+/*
+ * Find any io_uring ctx that this task has registered or done IO on, and cancel
+ * requests. @sqd should be not-null IFF it's an SQPOLL thread cancellation.
+ */
+__cold void io_uring_cancel_generic(bool cancel_all, struct io_sq_data *sqd)
+{
+	struct io_uring_task *tctx = current->io_uring;
+	struct io_ring_ctx *ctx;
+	struct io_tctx_node *node;
+	unsigned long index;
+	s64 inflight;
+	DEFINE_WAIT(wait);
+
+	WARN_ON_ONCE(sqd && sqpoll_task_locked(sqd) != current);
+
+	if (!current->io_uring)
+		return;
+	if (tctx->io_wq)
+		io_wq_exit_start(tctx->io_wq);
+
+	atomic_inc(&tctx->in_cancel);
+	do {
+		bool loop = false;
+
+		io_uring_drop_tctx_refs(current);
+		if (!tctx_inflight(tctx, !cancel_all))
+			break;
+
+		/* read completions before cancelations */
+		inflight = tctx_inflight(tctx, false);
+		if (!inflight)
+			break;
+
+		if (!sqd) {
+			xa_for_each(&tctx->xa, index, node) {
+				/* sqpoll task will cancel all its requests */
+				if (node->ctx->sq_data)
+					continue;
+				loop |= io_uring_try_cancel_requests(node->ctx,
+							current->io_uring,
+							cancel_all,
+							false);
+			}
+		} else {
+			list_for_each_entry(ctx, &sqd->ctx_list, sqd_list)
+				loop |= io_uring_try_cancel_requests(ctx,
+								     current->io_uring,
+								     cancel_all,
+								     true);
+		}
+
+		if (loop) {
+			cond_resched();
+			continue;
+		}
+
+		prepare_to_wait(&tctx->wait, &wait, TASK_INTERRUPTIBLE);
+		io_run_task_work();
+		io_uring_drop_tctx_refs(current);
+		xa_for_each(&tctx->xa, index, node) {
+			if (io_local_work_pending(node->ctx)) {
+				WARN_ON_ONCE(node->ctx->submitter_task &&
+					     node->ctx->submitter_task != current);
+				goto end_wait;
+			}
+		}
+		/*
+		 * If we've seen completions, retry without waiting. This
+		 * avoids a race where a completion comes in before we did
+		 * prepare_to_wait().
+		 */
+		if (inflight == tctx_inflight(tctx, !cancel_all))
+			schedule();
+end_wait:
+		finish_wait(&tctx->wait, &wait);
+	} while (1);
+
+	io_uring_clean_tctx(tctx);
+	if (cancel_all) {
+		/*
+		 * We shouldn't run task_works after cancel, so just leave
+		 * ->in_cancel set for normal exit.
+		 */
+		atomic_dec(&tctx->in_cancel);
+		/* for exec all current's requests should be gone, kill tctx */
+		__io_uring_free(current);
+	}
+}
diff --git a/io_uring/cancel.h b/io_uring/cancel.h
index 88054aa048736..1b201a0943030 100644
--- a/io_uring/cancel.h
+++ b/io_uring/cancel.h
@@ -27,10 +27,14 @@ bool io_match_task_safe(struct io_kiocb *head, struct io_uring_task *tctx,
 bool io_cancel_remove_all(struct io_ring_ctx *ctx, struct io_uring_task *tctx,
 			  struct hlist_head *list, bool cancel_all,
 			  bool (*cancel)(struct io_kiocb *));
-
 int io_cancel_remove(struct io_ring_ctx *ctx, struct io_cancel_data *cd,
 		     unsigned int issue_flags, struct hlist_head *list,
 		     bool (*cancel)(struct io_kiocb *));
+__cold bool io_uring_try_cancel_requests(struct io_ring_ctx *ctx,
+					 struct io_uring_task *tctx,
+					 bool cancel_all, bool is_sqpoll_thread);
+__cold void io_uring_cancel_generic(bool cancel_all, struct io_sq_data *sqd);
+__cold bool io_cancel_ctx_cb(struct io_wq_work *work, void *data);
 
 static inline bool io_cancel_match_sequence(struct io_kiocb *req, int sequence)
 {
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index b2abff1290b51..668662b74d73d 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -124,11 +124,6 @@
 #define IO_REQ_ALLOC_BATCH		8
 #define IO_LOCAL_TW_DEFAULT_MAX		20
 
-struct io_defer_entry {
-	struct list_head	list;
-	struct io_kiocb		*req;
-};
-
 /* requests with any of those set should undergo io_disarm_next() */
 #define IO_DISARM_MASK (REQ_F_ARM_LTIMEOUT | REQ_F_LINK_TIMEOUT | REQ_F_FAIL)
 
@@ -140,11 +135,6 @@ struct io_defer_entry {
 /* Forced wake up if there is a waiter regardless of ->cq_wait_nr */
 #define IO_CQ_WAKE_FORCE	(IO_CQ_WAKE_INIT >> 1)
 
-static bool io_uring_try_cancel_requests(struct io_ring_ctx *ctx,
-					 struct io_uring_task *tctx,
-					 bool cancel_all,
-					 bool is_sqpoll_thread);
-
 static void io_queue_sqe(struct io_kiocb *req, unsigned int extra_flags);
 static void __io_req_caches_free(struct io_ring_ctx *ctx);
 
@@ -515,7 +505,7 @@ void io_req_queue_iowq(struct io_kiocb *req)
 	io_req_task_work_add(req);
 }
 
-static unsigned io_linked_nr(struct io_kiocb *req)
+unsigned io_linked_nr(struct io_kiocb *req)
 {
 	struct io_kiocb *tmp;
 	unsigned nr = 0;
@@ -686,7 +676,7 @@ void io_task_refs_refill(struct io_uring_task *tctx)
 	tctx->cached_refs += refill;
 }
 
-static __cold void io_uring_drop_tctx_refs(struct task_struct *task)
+__cold void io_uring_drop_tctx_refs(struct task_struct *task)
 {
 	struct io_uring_task *tctx = task->io_uring;
 	unsigned int refs = tctx->cached_refs;
@@ -1445,8 +1435,7 @@ static inline int io_run_local_work_locked(struct io_ring_ctx *ctx,
 					max(IO_LOCAL_TW_DEFAULT_MAX, min_events));
 }
 
-static int io_run_local_work(struct io_ring_ctx *ctx, int min_events,
-			     int max_events)
+int io_run_local_work(struct io_ring_ctx *ctx, int min_events, int max_events)
 {
 	struct io_tw_state ts = {};
 	int ret;
@@ -1600,7 +1589,7 @@ static unsigned io_cqring_events(struct io_ring_ctx *ctx)
  * We can't just wait for polled events to come to us, we have to actively
  * find and complete them.
  */
-static __cold void io_iopoll_try_reap_events(struct io_ring_ctx *ctx)
+__cold void io_iopoll_try_reap_events(struct io_ring_ctx *ctx)
 {
 	if (!(ctx->flags & IORING_SETUP_IOPOLL))
 		return;
@@ -3011,13 +3000,6 @@ static __cold void io_tctx_exit_cb(struct callback_head *cb)
 	complete(&work->completion);
 }
 
-static __cold bool io_cancel_ctx_cb(struct io_wq_work *work, void *data)
-{
-	struct io_kiocb *req = container_of(work, struct io_kiocb, work);
-
-	return req->ctx == data;
-}
-
 static __cold void io_ring_exit_work(struct work_struct *work)
 {
 	struct io_ring_ctx *ctx = container_of(work, struct io_ring_ctx, exit_work);
@@ -3151,224 +3133,6 @@ static int io_uring_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-struct io_task_cancel {
-	struct io_uring_task *tctx;
-	bool all;
-};
-
-static bool io_cancel_task_cb(struct io_wq_work *work, void *data)
-{
-	struct io_kiocb *req = container_of(work, struct io_kiocb, work);
-	struct io_task_cancel *cancel = data;
-
-	return io_match_task_safe(req, cancel->tctx, cancel->all);
-}
-
-static __cold bool io_cancel_defer_files(struct io_ring_ctx *ctx,
-					 struct io_uring_task *tctx,
-					 bool cancel_all)
-{
-	struct io_defer_entry *de;
-	LIST_HEAD(list);
-
-	list_for_each_entry_reverse(de, &ctx->defer_list, list) {
-		if (io_match_task_safe(de->req, tctx, cancel_all)) {
-			list_cut_position(&list, &ctx->defer_list, &de->list);
-			break;
-		}
-	}
-	if (list_empty(&list))
-		return false;
-
-	while (!list_empty(&list)) {
-		de = list_first_entry(&list, struct io_defer_entry, list);
-		list_del_init(&de->list);
-		ctx->nr_drained -= io_linked_nr(de->req);
-		io_req_task_queue_fail(de->req, -ECANCELED);
-		kfree(de);
-	}
-	return true;
-}
-
-static __cold bool io_uring_try_cancel_iowq(struct io_ring_ctx *ctx)
-{
-	struct io_tctx_node *node;
-	enum io_wq_cancel cret;
-	bool ret = false;
-
-	mutex_lock(&ctx->uring_lock);
-	list_for_each_entry(node, &ctx->tctx_list, ctx_node) {
-		struct io_uring_task *tctx = node->task->io_uring;
-
-		/*
-		 * io_wq will stay alive while we hold uring_lock, because it's
-		 * killed after ctx nodes, which requires to take the lock.
-		 */
-		if (!tctx || !tctx->io_wq)
-			continue;
-		cret = io_wq_cancel_cb(tctx->io_wq, io_cancel_ctx_cb, ctx, true);
-		ret |= (cret != IO_WQ_CANCEL_NOTFOUND);
-	}
-	mutex_unlock(&ctx->uring_lock);
-
-	return ret;
-}
-
-static __cold bool io_uring_try_cancel_requests(struct io_ring_ctx *ctx,
-						struct io_uring_task *tctx,
-						bool cancel_all,
-						bool is_sqpoll_thread)
-{
-	struct io_task_cancel cancel = { .tctx = tctx, .all = cancel_all, };
-	enum io_wq_cancel cret;
-	bool ret = false;
-
-	/* set it so io_req_local_work_add() would wake us up */
-	if (ctx->flags & IORING_SETUP_DEFER_TASKRUN) {
-		atomic_set(&ctx->cq_wait_nr, 1);
-		smp_mb();
-	}
-
-	/* failed during ring init, it couldn't have issued any requests */
-	if (!ctx->rings)
-		return false;
-
-	if (!tctx) {
-		ret |= io_uring_try_cancel_iowq(ctx);
-	} else if (tctx->io_wq) {
-		/*
-		 * Cancels requests of all rings, not only @ctx, but
-		 * it's fine as the task is in exit/exec.
-		 */
-		cret = io_wq_cancel_cb(tctx->io_wq, io_cancel_task_cb,
-				       &cancel, true);
-		ret |= (cret != IO_WQ_CANCEL_NOTFOUND);
-	}
-
-	/* SQPOLL thread does its own polling */
-	if ((!(ctx->flags & IORING_SETUP_SQPOLL) && cancel_all) ||
-	    is_sqpoll_thread) {
-		while (!wq_list_empty(&ctx->iopoll_list)) {
-			io_iopoll_try_reap_events(ctx);
-			ret = true;
-			cond_resched();
-		}
-	}
-
-	if ((ctx->flags & IORING_SETUP_DEFER_TASKRUN) &&
-	    io_allowed_defer_tw_run(ctx))
-		ret |= io_run_local_work(ctx, INT_MAX, INT_MAX) > 0;
-	mutex_lock(&ctx->uring_lock);
-	ret |= io_cancel_defer_files(ctx, tctx, cancel_all);
-	ret |= io_poll_remove_all(ctx, tctx, cancel_all);
-	ret |= io_waitid_remove_all(ctx, tctx, cancel_all);
-	ret |= io_futex_remove_all(ctx, tctx, cancel_all);
-	ret |= io_uring_try_cancel_uring_cmd(ctx, tctx, cancel_all);
-	mutex_unlock(&ctx->uring_lock);
-	ret |= io_kill_timeouts(ctx, tctx, cancel_all);
-	if (tctx)
-		ret |= io_run_task_work() > 0;
-	else
-		ret |= flush_delayed_work(&ctx->fallback_work);
-	return ret;
-}
-
-static s64 tctx_inflight(struct io_uring_task *tctx, bool tracked)
-{
-	if (tracked)
-		return atomic_read(&tctx->inflight_tracked);
-	return percpu_counter_sum(&tctx->inflight);
-}
-
-/*
- * Find any io_uring ctx that this task has registered or done IO on, and cancel
- * requests. @sqd should be not-null IFF it's an SQPOLL thread cancellation.
- */
-__cold void io_uring_cancel_generic(bool cancel_all, struct io_sq_data *sqd)
-{
-	struct io_uring_task *tctx = current->io_uring;
-	struct io_ring_ctx *ctx;
-	struct io_tctx_node *node;
-	unsigned long index;
-	s64 inflight;
-	DEFINE_WAIT(wait);
-
-	WARN_ON_ONCE(sqd && sqpoll_task_locked(sqd) != current);
-
-	if (!current->io_uring)
-		return;
-	if (tctx->io_wq)
-		io_wq_exit_start(tctx->io_wq);
-
-	atomic_inc(&tctx->in_cancel);
-	do {
-		bool loop = false;
-
-		io_uring_drop_tctx_refs(current);
-		if (!tctx_inflight(tctx, !cancel_all))
-			break;
-
-		/* read completions before cancelations */
-		inflight = tctx_inflight(tctx, false);
-		if (!inflight)
-			break;
-
-		if (!sqd) {
-			xa_for_each(&tctx->xa, index, node) {
-				/* sqpoll task will cancel all its requests */
-				if (node->ctx->sq_data)
-					continue;
-				loop |= io_uring_try_cancel_requests(node->ctx,
-							current->io_uring,
-							cancel_all,
-							false);
-			}
-		} else {
-			list_for_each_entry(ctx, &sqd->ctx_list, sqd_list)
-				loop |= io_uring_try_cancel_requests(ctx,
-								     current->io_uring,
-								     cancel_all,
-								     true);
-		}
-
-		if (loop) {
-			cond_resched();
-			continue;
-		}
-
-		prepare_to_wait(&tctx->wait, &wait, TASK_INTERRUPTIBLE);
-		io_run_task_work();
-		io_uring_drop_tctx_refs(current);
-		xa_for_each(&tctx->xa, index, node) {
-			if (io_local_work_pending(node->ctx)) {
-				WARN_ON_ONCE(node->ctx->submitter_task &&
-					     node->ctx->submitter_task != current);
-				goto end_wait;
-			}
-		}
-		/*
-		 * If we've seen completions, retry without waiting. This
-		 * avoids a race where a completion comes in before we did
-		 * prepare_to_wait().
-		 */
-		if (inflight == tctx_inflight(tctx, !cancel_all))
-			schedule();
-end_wait:
-		finish_wait(&tctx->wait, &wait);
-	} while (1);
-
-	io_uring_clean_tctx(tctx);
-	if (cancel_all) {
-		/*
-		 * We shouldn't run task_works after cancel, so just leave
-		 * ->in_cancel set for normal exit.
-		 */
-		atomic_dec(&tctx->in_cancel);
-		/* for exec all current's requests should be gone, kill tctx */
-		__io_uring_free(current);
-	}
-}
-
 static struct io_uring_reg_wait *io_get_ext_arg_reg(struct io_ring_ctx *ctx,
 			const struct io_uring_getevents_arg __user *uarg)
 {
diff --git a/io_uring/io_uring.h b/io_uring/io_uring.h
index f70423539e479..36918faff5afb 100644
--- a/io_uring/io_uring.h
+++ b/io_uring/io_uring.h
@@ -95,6 +95,11 @@ enum {
 	IOU_REQUEUE		= -3072,
 };
 
+struct io_defer_entry {
+	struct list_head	list;
+	struct io_kiocb		*req;
+};
+
 struct io_wait_queue {
 	struct wait_queue_entry wq;
 	struct io_ring_ctx *ctx;
@@ -145,6 +150,7 @@ unsigned long rings_size(unsigned int flags, unsigned int sq_entries,
 int io_uring_fill_params(unsigned entries, struct io_uring_params *p);
 bool io_cqe_cache_refill(struct io_ring_ctx *ctx, bool overflow, bool cqe32);
 int io_run_task_work_sig(struct io_ring_ctx *ctx);
+int io_run_local_work(struct io_ring_ctx *ctx, int min_events, int max_events);
 void io_req_defer_failed(struct io_kiocb *req, s32 res);
 bool io_post_aux_cqe(struct io_ring_ctx *ctx, u64 user_data, s32 res, u32 cflags);
 void io_add_aux_cqe(struct io_ring_ctx *ctx, u64 user_data, s32 res, u32 cflags);
@@ -152,6 +158,7 @@ bool io_req_post_cqe(struct io_kiocb *req, s32 res, u32 cflags);
 bool io_req_post_cqe32(struct io_kiocb *req, struct io_uring_cqe src_cqe[2]);
 void __io_commit_cqring_flush(struct io_ring_ctx *ctx);
 
+unsigned io_linked_nr(struct io_kiocb *req);
 void io_req_track_inflight(struct io_kiocb *req);
 struct file *io_file_get_normal(struct io_kiocb *req, int fd);
 struct file *io_file_get_fixed(struct io_kiocb *req, int fd,
@@ -166,7 +173,7 @@ void io_req_task_submit(struct io_tw_req tw_req, io_tw_token_t tw);
 struct llist_node *io_handle_tw_list(struct llist_node *node, unsigned int *count, unsigned int max_entries);
 struct llist_node *tctx_task_work_run(struct io_uring_task *tctx, unsigned int max_entries, unsigned int *count);
 void tctx_task_work(struct callback_head *cb);
-__cold void io_uring_cancel_generic(bool cancel_all, struct io_sq_data *sqd);
+__cold void io_uring_drop_tctx_refs(struct task_struct *task);
 
 int io_ring_add_registered_file(struct io_uring_task *tctx, struct file *file,
 				     int start, int end);
@@ -175,6 +182,7 @@ void io_req_queue_iowq(struct io_kiocb *req);
 int io_poll_issue(struct io_kiocb *req, io_tw_token_t tw);
 int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr);
 int io_do_iopoll(struct io_ring_ctx *ctx, bool force_nonspin);
+__cold void io_iopoll_try_reap_events(struct io_ring_ctx *ctx);
 void __io_submit_flush_completions(struct io_ring_ctx *ctx);
 
 struct io_wq_work *io_wq_free_work(struct io_wq_work *work);
diff --git a/io_uring/sqpoll.c b/io_uring/sqpoll.c
index e22f072c7d5f8..74c1a130cd874 100644
--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -19,6 +19,7 @@
 #include "io_uring.h"
 #include "tctx.h"
 #include "napi.h"
+#include "cancel.h"
 #include "sqpoll.h"
 
 #define IORING_SQPOLL_CAP_ENTRIES_VALUE 8
-- 
2.53.0

