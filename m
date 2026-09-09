Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7EA57EDBA
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 16:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788971246; cv=none; b=Nz7ZUsh0AGkz1bS1FU37kcST2uvY8soids6BqCALtgqie8c3+F0dFTNg8sYmB7GWvSiGPlL+mcUgW18vXawNM6lw7EiJpePP74R5WteA1+eOzPFw/OGoVwb+QeL1gXHF7865MBPuhcLutC0eKzEKA4lzUcoETsAHYHRyOam3aaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788971246; c=relaxed/simple;
	bh=3R0gKA1hJm/8kj1BuOMl3dFglgQkYQL2L9cfw+SHrSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EapuDWVSnVUGozYb+GPywaJ4bQiptPvqGE7kCLzV6ra12IVvtahdcEcdpCLJpIneqorMwgI1CSfvyR/v9jypJWYmzp76Wjft4gKYp119UaPodWtJy3CDZnSIGCbn1MJ8C3QSmv0OKWE42rUJfDApcpaaYIZCuRPWAfwUApkz/qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/MTrOsp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/MTrOsp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 191D11F00893;
	Wed,  9 Sep 2026 16:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788971244;
	bh=6ds/3VCYF9AHEcpfV7SWjYAX5MSumEcepQMPB/U7w4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J/MTrOspKWEAukwbZnGCsKXs7SmZpBweOpg7ojcxPIc0AHYKXbi8lE4N/SSJX/vis
	 jC4oMpGIq+ktOlGF2xxzL9Ph2cJNxN+y/75zw9PKy/ZljCiW+3Pzgnr5MYqNeeccxP
	 B7eQ3ZhTttNktFhA5rnc3HK5rwb1LW37jT/RCt4bLN4aHydbYhE8pzatWTxtutRbav
	 k87UgmTVjaqUQcirxk1yq6y37OTXswlvmaaE7YLFw6tpHk1+Vk5NoXxu7OzeDg2bh7
	 yK+xOTc0sauqdAaDmq+5wMR5lXbe6emKs6TXWJcVBDO7/+9DXozlYekXkqF2w2L1ag
	 hRMV3qc98FiYg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] io_uring: add wrapper type for io_req_tw_func_t arg
Date: Wed,  9 Sep 2026 12:27:18 -0400
Message-ID: <20260909162719.2984896-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909162719.2984896-1-sashal@kernel.org>
References: <2026090345-dolly-jolliness-3485@gregkh>
 <20260909162719.2984896-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Caleb Sander Mateos <csander@purestorage.com>

[ Upstream commit c33e779aba6804778c1440192a8033a145ba588d ]

In preparation for uring_cmd implementations to implement functions
with the io_req_tw_func_t signature, introduce a wrapper struct
io_tw_req to hide the struct io_kiocb * argument. The intention is for
only the io_uring core to access the inner struct io_kiocb *. uring_cmd
implementations should instead call a helper from io_uring/cmd.h to
convert struct io_tw_req to struct io_uring_cmd *.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>

Stable adaptation for 6.12:

Keep the request-wrapper conversion and supply the missing by-value
io_tw_token_t interface. The existing io_tw_state is already empty and
io_tw_lock() only asserts that uring_lock is held, so no locking change
is required. Convert the stable-only token users as well, and include
io_uring_types.h in poll.h and rw.h for the new typedef.

Add the cancel member and initialize it from the existing
io_should_terminate_tw() in the fallback, per-task, and local task-work
executors. This supplies the interface required by target 14572de82e50
without importing the unrelated task-exit or callback cancellation
refactoring. Keep the stable futex cache and async-data cleanup paths.

No functions are added. The target waitid patch applies unchanged.

Stable-dep-of: 14572de82e50 ("io_uring/waitid: honor task_work cancellation")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/io_uring_types.h | 14 ++++++++++-
 io_uring/futex.c               | 20 +++++++++------
 io_uring/io_uring.c            | 46 +++++++++++++++++++---------------
 io_uring/io_uring.h            |  8 +++---
 io_uring/msg_ring.c            |  3 ++-
 io_uring/notif.c               |  5 ++--
 io_uring/poll.c                | 25 +++++++++---------
 io_uring/poll.h                |  4 ++-
 io_uring/rw.c                  |  5 ++--
 io_uring/rw.h                  |  3 ++-
 io_uring/timeout.c             | 20 +++++++++------
 io_uring/uring_cmd.c           |  3 ++-
 io_uring/waitid.c              |  9 ++++---
 13 files changed, 100 insertions(+), 65 deletions(-)

diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
index 6d47d0d3fde01..1d32c66a9a052 100644
--- a/include/linux/io_uring_types.h
+++ b/include/linux/io_uring_types.h
@@ -422,8 +422,16 @@ struct io_ring_ctx {
 	struct page			**sqe_pages;
 };
 
+/*
+ * Token indicating function is called in task work context:
+ * ctx->uring_lock is held and any completions generated will be flushed.
+ * ONLY core io_uring.c should instantiate this struct.
+ */
 struct io_tw_state {
+	bool cancel;
 };
+/* Alias to use in code that doesn't instantiate struct io_tw_state */
+typedef struct io_tw_state io_tw_token_t;
 
 enum {
 	REQ_F_FIXED_FILE_BIT	= IOSQE_FIXED_FILE_BIT,
@@ -549,7 +557,11 @@ enum {
 	REQ_F_BUF_MORE		= IO_REQ_FLAG(REQ_F_BUF_MORE_BIT),
 };
 
-typedef void (*io_req_tw_func_t)(struct io_kiocb *req, struct io_tw_state *ts);
+struct io_tw_req {
+	struct io_kiocb *req;
+};
+
+typedef void (*io_req_tw_func_t)(struct io_tw_req tw_req, io_tw_token_t tw);
 
 struct io_task_work {
 	struct llist_node		node;
diff --git a/io_uring/futex.c b/io_uring/futex.c
index a3d2b700b480c..cd125e4671d35 100644
--- a/io_uring/futex.c
+++ b/io_uring/futex.c
@@ -44,30 +44,34 @@ void io_futex_cache_free(struct io_ring_ctx *ctx)
 	io_alloc_cache_free(&ctx->futex_cache, kfree);
 }
 
-static void __io_futex_complete(struct io_kiocb *req, struct io_tw_state *ts)
+static void __io_futex_complete(struct io_tw_req tw_req, io_tw_token_t tw)
 {
+	struct io_kiocb *req = tw_req.req;
+
 	req->async_data = NULL;
 	hlist_del_init(&req->hash_node);
-	io_req_task_complete(req, ts);
+	io_req_task_complete(tw_req, tw);
 }
 
-static void io_futex_complete(struct io_kiocb *req, struct io_tw_state *ts)
+static void io_futex_complete(struct io_tw_req tw_req, io_tw_token_t tw)
 {
+	struct io_kiocb *req = tw_req.req;
 	struct io_futex_data *ifd = req->async_data;
 	struct io_ring_ctx *ctx = req->ctx;
 
-	io_tw_lock(ctx, ts);
+	io_tw_lock(ctx, tw);
 	if (!io_alloc_cache_put(&ctx->futex_cache, ifd))
 		kfree(ifd);
-	__io_futex_complete(req, ts);
+	__io_futex_complete(tw_req, tw);
 }
 
-static void io_futexv_complete(struct io_kiocb *req, struct io_tw_state *ts)
+static void io_futexv_complete(struct io_tw_req tw_req, io_tw_token_t tw)
 {
+	struct io_kiocb *req = tw_req.req;
 	struct io_futex *iof = io_kiocb_to_cmd(req, struct io_futex);
 	struct futex_vector *futexv = req->async_data;
 
-	io_tw_lock(req->ctx, ts);
+	io_tw_lock(req->ctx, tw);
 
 	if (!iof->futexv_unqueued) {
 		int res;
@@ -79,7 +83,7 @@ static void io_futexv_complete(struct io_kiocb *req, struct io_tw_state *ts)
 
 	kfree(req->async_data);
 	req->flags &= ~REQ_F_ASYNC_DATA;
-	__io_futex_complete(req, ts);
+	__io_futex_complete(tw_req, tw);
 }
 
 static bool io_futexv_claim(struct io_futex *iof)
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 03c6ab505d74a..c00768f616c3f 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -251,8 +251,9 @@ static __cold void io_fallback_req_func(struct work_struct *work)
 
 	percpu_ref_get(&ctx->refs);
 	mutex_lock(&ctx->uring_lock);
+	ts.cancel = io_should_terminate_tw(ctx);
 	llist_for_each_entry_safe(req, tmp, node, io_task_work.node)
-		req->io_task_work.func(req, &ts);
+		req->io_task_work.func((struct io_tw_req){req}, ts);
 	io_submit_flush_completions(ctx);
 	mutex_unlock(&ctx->uring_lock);
 	percpu_ref_put(&ctx->refs);
@@ -509,9 +510,9 @@ static void io_queue_iowq(struct io_kiocb *req)
 	io_wq_enqueue(tctx->io_wq, &req->work);
 }
 
-static void io_req_queue_iowq_tw(struct io_kiocb *req, struct io_tw_state *ts)
+static void io_req_queue_iowq_tw(struct io_tw_req tw_req, io_tw_token_t tw)
 {
-	io_queue_iowq(req);
+	io_queue_iowq(tw_req.req);
 }
 
 void io_req_queue_iowq(struct io_kiocb *req)
@@ -1012,7 +1013,7 @@ static inline struct io_kiocb *io_req_find_next(struct io_kiocb *req)
 	return nxt;
 }
 
-static void ctx_flush_and_put(struct io_ring_ctx *ctx, struct io_tw_state *ts)
+static void ctx_flush_and_put(struct io_ring_ctx *ctx, io_tw_token_t tw)
 {
 	if (!ctx)
 		return;
@@ -1042,24 +1043,25 @@ struct llist_node *io_handle_tw_list(struct llist_node *node,
 						    io_task_work.node);
 
 		if (req->ctx != ctx) {
-			ctx_flush_and_put(ctx, &ts);
+			ctx_flush_and_put(ctx, ts);
 			ctx = req->ctx;
 			mutex_lock(&ctx->uring_lock);
 			percpu_ref_get(&ctx->refs);
+			ts.cancel = io_should_terminate_tw(ctx);
 		}
 		INDIRECT_CALL_2(req->io_task_work.func,
 				io_poll_task_func, io_req_rw_complete,
-				req, &ts);
+				(struct io_tw_req){req}, ts);
 		node = next;
 		(*count)++;
 		if (unlikely(need_resched())) {
-			ctx_flush_and_put(ctx, &ts);
+			ctx_flush_and_put(ctx, ts);
 			ctx = NULL;
 			cond_resched();
 		}
 	} while (node && *count < max_entries);
 
-	ctx_flush_and_put(ctx, &ts);
+	ctx_flush_and_put(ctx, ts);
 	return node;
 }
 
@@ -1280,7 +1282,7 @@ static bool io_run_local_work_continue(struct io_ring_ctx *ctx, int events,
 	return false;
 }
 
-static int __io_run_local_work(struct io_ring_ctx *ctx, struct io_tw_state *ts,
+static int __io_run_local_work(struct io_ring_ctx *ctx, io_tw_token_t tw,
 			       int min_events)
 {
 	struct llist_node *node;
@@ -1292,6 +1294,7 @@ static int __io_run_local_work(struct io_ring_ctx *ctx, struct io_tw_state *ts,
 	if (ctx->flags & IORING_SETUP_TASKRUN_FLAG)
 		atomic_andnot(IORING_SQ_TASKRUN, &ctx->rings->sq_flags);
 again:
+	tw.cancel = io_should_terminate_tw(ctx);
 	/*
 	 * llists are in reverse order, flip it back the right way before
 	 * running the pending items.
@@ -1303,7 +1306,7 @@ static int __io_run_local_work(struct io_ring_ctx *ctx, struct io_tw_state *ts,
 						    io_task_work.node);
 		INDIRECT_CALL_2(req->io_task_work.func,
 				io_poll_task_func, io_req_rw_complete,
-				req, ts);
+				(struct io_tw_req){req}, tw);
 		ret++;
 		node = next;
 	}
@@ -1326,7 +1329,7 @@ static inline int io_run_local_work_locked(struct io_ring_ctx *ctx,
 
 	if (llist_empty(&ctx->work_llist))
 		return 0;
-	return __io_run_local_work(ctx, &ts, min_events);
+	return __io_run_local_work(ctx, ts, min_events);
 }
 
 static int io_run_local_work(struct io_ring_ctx *ctx, int min_events)
@@ -1335,22 +1338,25 @@ static int io_run_local_work(struct io_ring_ctx *ctx, int min_events)
 	int ret;
 
 	mutex_lock(&ctx->uring_lock);
-	ret = __io_run_local_work(ctx, &ts, min_events);
+	ret = __io_run_local_work(ctx, ts, min_events);
 	mutex_unlock(&ctx->uring_lock);
 	return ret;
 }
 
-static void io_req_task_cancel(struct io_kiocb *req, struct io_tw_state *ts)
+static void io_req_task_cancel(struct io_tw_req tw_req, io_tw_token_t tw)
 {
-	io_tw_lock(req->ctx, ts);
+	struct io_kiocb *req = tw_req.req;
+
+	io_tw_lock(req->ctx, tw);
 	io_req_defer_failed(req, req->cqe.res);
 }
 
-void io_req_task_submit(struct io_kiocb *req, struct io_tw_state *ts)
+void io_req_task_submit(struct io_tw_req tw_req, io_tw_token_t tw)
 {
+	struct io_kiocb *req = tw_req.req;
 	struct io_ring_ctx *ctx = req->ctx;
 
-	io_tw_lock(ctx, ts);
+	io_tw_lock(ctx, tw);
 	if (unlikely(io_should_terminate_tw(ctx)))
 		io_req_defer_failed(req, -EFAULT);
 	else if (req->flags & REQ_F_FORCE_ASYNC)
@@ -1557,9 +1563,9 @@ static int io_iopoll_check(struct io_ring_ctx *ctx, long min)
 	return 0;
 }
 
-void io_req_task_complete(struct io_kiocb *req, struct io_tw_state *ts)
+void io_req_task_complete(struct io_tw_req tw_req, io_tw_token_t tw)
 {
-	io_req_complete_defer(req);
+	io_req_complete_defer(tw_req.req);
 }
 
 /*
@@ -1760,9 +1766,9 @@ static int io_issue_sqe(struct io_kiocb *req, unsigned int issue_flags)
 	return ret;
 }
 
-int io_poll_issue(struct io_kiocb *req, struct io_tw_state *ts)
+int io_poll_issue(struct io_kiocb *req, io_tw_token_t tw)
 {
-	io_tw_lock(req->ctx, ts);
+	io_tw_lock(req->ctx, tw);
 	return io_issue_sqe(req, IO_URING_F_NONBLOCK|IO_URING_F_MULTISHOT|
 				 IO_URING_F_COMPLETE_DEFER);
 }
diff --git a/io_uring/io_uring.h b/io_uring/io_uring.h
index f1d3b49289977..8439deda9ca47 100644
--- a/io_uring/io_uring.h
+++ b/io_uring/io_uring.h
@@ -82,9 +82,9 @@ void io_req_task_work_add_remote(struct io_kiocb *req, struct io_ring_ctx *ctx,
 				 unsigned flags);
 bool io_alloc_async_data(struct io_kiocb *req);
 void io_req_task_queue(struct io_kiocb *req);
-void io_req_task_complete(struct io_kiocb *req, struct io_tw_state *ts);
+void io_req_task_complete(struct io_tw_req tw_req, io_tw_token_t tw);
 void io_req_task_queue_fail(struct io_kiocb *req, int ret);
-void io_req_task_submit(struct io_kiocb *req, struct io_tw_state *ts);
+void io_req_task_submit(struct io_tw_req tw_req, io_tw_token_t tw);
 struct llist_node *io_handle_tw_list(struct llist_node *node, unsigned int *count, unsigned int max_entries);
 struct llist_node *tctx_task_work_run(struct io_uring_task *tctx, unsigned int max_entries, unsigned int *count);
 void tctx_task_work(struct callback_head *cb);
@@ -96,7 +96,7 @@ int io_ring_add_registered_file(struct io_uring_task *tctx, struct file *file,
 				     int start, int end);
 void io_req_queue_iowq(struct io_kiocb *req);
 
-int io_poll_issue(struct io_kiocb *req, struct io_tw_state *ts);
+int io_poll_issue(struct io_kiocb *req, io_tw_token_t tw);
 int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr);
 int io_do_iopoll(struct io_ring_ctx *ctx, bool force_nonspin);
 void __io_submit_flush_completions(struct io_ring_ctx *ctx);
@@ -347,7 +347,7 @@ static inline bool io_task_work_pending(struct io_ring_ctx *ctx)
 	return task_work_pending(current) || !llist_empty(&ctx->work_llist);
 }
 
-static inline void io_tw_lock(struct io_ring_ctx *ctx, struct io_tw_state *ts)
+static inline void io_tw_lock(struct io_ring_ctx *ctx, io_tw_token_t tw)
 {
 	lockdep_assert_held(&ctx->uring_lock);
 }
diff --git a/io_uring/msg_ring.c b/io_uring/msg_ring.c
index 3cf59d8c58073..5c7d35f2f0b86 100644
--- a/io_uring/msg_ring.c
+++ b/io_uring/msg_ring.c
@@ -70,8 +70,9 @@ static inline bool io_msg_need_remote(struct io_ring_ctx *target_ctx)
 	return target_ctx->task_complete;
 }
 
-static void io_msg_tw_complete(struct io_kiocb *req, struct io_tw_state *ts)
+static void io_msg_tw_complete(struct io_tw_req tw_req, io_tw_token_t tw)
 {
+	struct io_kiocb *req = tw_req.req;
 	struct io_ring_ctx *ctx = req->ctx;
 
 	io_add_aux_cqe(ctx, req->cqe.user_data, req->cqe.res, req->cqe.flags);
diff --git a/io_uring/notif.c b/io_uring/notif.c
index f50964c7dab82..cc9fc345da327 100644
--- a/io_uring/notif.c
+++ b/io_uring/notif.c
@@ -11,8 +11,9 @@
 
 static const struct ubuf_info_ops io_ubuf_ops;
 
-static void io_notif_tw_complete(struct io_kiocb *notif, struct io_tw_state *ts)
+static void io_notif_tw_complete(struct io_tw_req tw_req, io_tw_token_t tw)
 {
+	struct io_kiocb *notif = tw_req.req;
 	struct io_notif_data *nd = io_notif_to_data(notif);
 	struct io_ring_ctx *ctx = notif->ctx;
 
@@ -34,7 +35,7 @@ static void io_notif_tw_complete(struct io_kiocb *notif, struct io_tw_state *ts)
 		}
 
 		nd = nd->next;
-		io_req_task_complete(notif, ts);
+		io_req_task_complete((struct io_tw_req){notif}, tw);
 	} while (nd);
 }
 
diff --git a/io_uring/poll.c b/io_uring/poll.c
index 002f1ae830b8a..39c7f47c1f5b5 100644
--- a/io_uring/poll.c
+++ b/io_uring/poll.c
@@ -150,7 +150,7 @@ static void io_poll_req_insert_locked(struct io_kiocb *req)
 	hlist_add_head(&req->hash_node, &table->hbs[index].list);
 }
 
-static void io_poll_tw_hash_eject(struct io_kiocb *req, struct io_tw_state *ts)
+static void io_poll_tw_hash_eject(struct io_kiocb *req, io_tw_token_t tw)
 {
 	struct io_ring_ctx *ctx = req->ctx;
 
@@ -161,7 +161,7 @@ static void io_poll_tw_hash_eject(struct io_kiocb *req, struct io_tw_state *ts)
 		 * already grabbed the mutex for us, but there is a chance it
 		 * failed.
 		 */
-		io_tw_lock(ctx, ts);
+		io_tw_lock(ctx, tw);
 		hash_del(&req->hash_node);
 		req->flags &= ~REQ_F_HASH_LOCKED;
 	} else {
@@ -261,7 +261,7 @@ static inline void io_poll_execute(struct io_kiocb *req, int res)
  * req->cqe.res. IOU_POLL_REMOVE_POLL_USE_RES indicates to remove multishot
  * poll and that the result is stored in req->cqe.
  */
-static int io_poll_check_events(struct io_kiocb *req, struct io_tw_state *ts)
+static int io_poll_check_events(struct io_kiocb *req, io_tw_token_t tw)
 {
 	int v;
 
@@ -333,7 +333,7 @@ static int io_poll_check_events(struct io_kiocb *req, struct io_tw_state *ts)
 			/* multiple refs and HUP, ensure we loop once more */
 			if ((req->cqe.res & (POLLHUP | POLLRDHUP)) && v != 1)
 				v--;
-			ret = io_poll_issue(req, ts);
+			ret = io_poll_issue(req, tw);
 			if (ret == IOU_STOP_MULTISHOT)
 				return IOU_POLL_REMOVE_POLL_USE_RES;
 			else if (ret == IOU_REQUEUE)
@@ -355,11 +355,12 @@ static int io_poll_check_events(struct io_kiocb *req, struct io_tw_state *ts)
 	return IOU_POLL_NO_ACTION;
 }
 
-void io_poll_task_func(struct io_kiocb *req, struct io_tw_state *ts)
+void io_poll_task_func(struct io_tw_req tw_req, io_tw_token_t tw)
 {
+	struct io_kiocb *req = tw_req.req;
 	int ret;
 
-	ret = io_poll_check_events(req, ts);
+	ret = io_poll_check_events(req, tw);
 	if (ret == IOU_POLL_NO_ACTION) {
 		return;
 	} else if (ret == IOU_POLL_REQUEUE) {
@@ -367,7 +368,7 @@ void io_poll_task_func(struct io_kiocb *req, struct io_tw_state *ts)
 		return;
 	}
 	io_poll_remove_entries(req);
-	io_poll_tw_hash_eject(req, ts);
+	io_poll_tw_hash_eject(req, tw);
 
 	if (req->opcode == IORING_OP_POLL_ADD) {
 		if (ret == IOU_POLL_DONE) {
@@ -376,7 +377,7 @@ void io_poll_task_func(struct io_kiocb *req, struct io_tw_state *ts)
 			poll = io_kiocb_to_cmd(req, struct io_poll);
 			req->cqe.res = mangle_poll(req->cqe.res & poll->events);
 		} else if (ret == IOU_POLL_REISSUE) {
-			io_req_task_submit(req, ts);
+			io_req_task_submit(tw_req, tw);
 			return;
 		} else if (ret != IOU_POLL_REMOVE_POLL_USE_RES) {
 			req->cqe.res = ret;
@@ -384,14 +385,14 @@ void io_poll_task_func(struct io_kiocb *req, struct io_tw_state *ts)
 		}
 
 		io_req_set_res(req, req->cqe.res, 0);
-		io_req_task_complete(req, ts);
+		io_req_task_complete(tw_req, tw);
 	} else {
-		io_tw_lock(req->ctx, ts);
+		io_tw_lock(req->ctx, tw);
 
 		if (ret == IOU_POLL_REMOVE_POLL_USE_RES)
-			io_req_task_complete(req, ts);
+			io_req_task_complete(tw_req, tw);
 		else if (ret == IOU_POLL_DONE || ret == IOU_POLL_REISSUE)
-			io_req_task_submit(req, ts);
+			io_req_task_submit(tw_req, tw);
 		else
 			io_req_defer_failed(req, ret);
 	}
diff --git a/io_uring/poll.h b/io_uring/poll.h
index b0e3745f5a29b..bf894dc6b9f86 100644
--- a/io_uring/poll.h
+++ b/io_uring/poll.h
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <linux/io_uring_types.h>
+
 #define IO_POLL_ALLOC_CACHE_MAX 32
 
 enum {
@@ -43,4 +45,4 @@ int io_arm_poll_handler(struct io_kiocb *req, unsigned issue_flags);
 bool io_poll_remove_all(struct io_ring_ctx *ctx, struct task_struct *tsk,
 			bool cancel_all);
 
-void io_poll_task_func(struct io_kiocb *req, struct io_tw_state *ts);
+void io_poll_task_func(struct io_tw_req tw_req, io_tw_token_t tw);
diff --git a/io_uring/rw.c b/io_uring/rw.c
index a74664c4a05ef..55e5bff818b10 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -508,8 +508,9 @@ static inline int io_fixup_rw_res(struct io_kiocb *req, long res)
 	return res;
 }
 
-void io_req_rw_complete(struct io_kiocb *req, struct io_tw_state *ts)
+void io_req_rw_complete(struct io_tw_req tw_req, io_tw_token_t tw)
 {
+	struct io_kiocb *req = tw_req.req;
 	struct io_rw *rw = io_kiocb_to_cmd(req, struct io_rw);
 	struct kiocb *kiocb = &rw->kiocb;
 
@@ -525,7 +526,7 @@ void io_req_rw_complete(struct io_kiocb *req, struct io_tw_state *ts)
 		req->cqe.flags |= io_put_kbuf(req, req->cqe.res, NULL);
 
 	io_req_rw_cleanup(req, 0);
-	io_req_task_complete(req, ts);
+	io_req_task_complete(tw_req, tw);
 }
 
 static void io_complete_rw(struct kiocb *kiocb, long res)
diff --git a/io_uring/rw.h b/io_uring/rw.h
index 3f432dc75441f..283beeeb05fbc 100644
--- a/io_uring/rw.h
+++ b/io_uring/rw.h
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <linux/io_uring_types.h>
 #include <linux/pagemap.h>
 
 struct io_async_rw {
@@ -22,7 +23,7 @@ int io_read(struct io_kiocb *req, unsigned int issue_flags);
 int io_write(struct io_kiocb *req, unsigned int issue_flags);
 void io_readv_writev_cleanup(struct io_kiocb *req);
 void io_rw_fail(struct io_kiocb *req);
-void io_req_rw_complete(struct io_kiocb *req, struct io_tw_state *ts);
+void io_req_rw_complete(struct io_tw_req tw_req, io_tw_token_t tw);
 int io_read_mshot_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe);
 int io_read_mshot(struct io_kiocb *req, unsigned int issue_flags);
 void io_rw_cache_free(const void *entry);
diff --git a/io_uring/timeout.c b/io_uring/timeout.c
index 9cc5776103feb..1f0c66b643e3c 100644
--- a/io_uring/timeout.c
+++ b/io_uring/timeout.c
@@ -65,8 +65,9 @@ static inline bool io_timeout_finish(struct io_timeout *timeout,
 
 static enum hrtimer_restart io_timeout_fn(struct hrtimer *timer);
 
-static void io_timeout_complete(struct io_kiocb *req, struct io_tw_state *ts)
+static void io_timeout_complete(struct io_tw_req tw_req, io_tw_token_t tw)
 {
+	struct io_kiocb *req = tw_req.req;
 	struct io_timeout *timeout = io_kiocb_to_cmd(req, struct io_timeout);
 	struct io_timeout_data *data = req->async_data;
 	struct io_ring_ctx *ctx = req->ctx;
@@ -83,7 +84,7 @@ static void io_timeout_complete(struct io_kiocb *req, struct io_tw_state *ts)
 		}
 	}
 
-	io_req_task_complete(req, ts);
+	io_req_task_complete(tw_req, tw);
 }
 
 static bool io_kill_timeout(struct io_kiocb *req, int status)
@@ -138,9 +139,11 @@ __cold void io_flush_timeouts(struct io_ring_ctx *ctx)
 	spin_unlock_irq(&ctx->timeout_lock);
 }
 
-static void io_req_tw_fail_links(struct io_kiocb *link, struct io_tw_state *ts)
+static void io_req_tw_fail_links(struct io_tw_req tw_req, io_tw_token_t tw)
 {
-	io_tw_lock(link->ctx, ts);
+	struct io_kiocb *link = tw_req.req;
+
+	io_tw_lock(link->ctx, tw);
 	while (link) {
 		struct io_kiocb *nxt = link->link;
 		long res = -ECANCELED;
@@ -149,7 +152,7 @@ static void io_req_tw_fail_links(struct io_kiocb *link, struct io_tw_state *ts)
 			res = link->cqe.res;
 		link->link = NULL;
 		io_req_set_res(link, res, 0);
-		io_req_task_complete(link, ts);
+		io_req_task_complete((struct io_tw_req){link}, tw);
 		link = nxt;
 	}
 }
@@ -296,8 +299,9 @@ int io_timeout_cancel(struct io_ring_ctx *ctx, struct io_cancel_data *cd)
 	return 0;
 }
 
-static void io_req_task_link_timeout(struct io_kiocb *req, struct io_tw_state *ts)
+static void io_req_task_link_timeout(struct io_tw_req tw_req, io_tw_token_t tw)
 {
+	struct io_kiocb *req = tw_req.req;
 	struct io_timeout *timeout = io_kiocb_to_cmd(req, struct io_timeout);
 	struct io_kiocb *prev = timeout->prev;
 	int ret = -ENOENT;
@@ -312,11 +316,11 @@ static void io_req_task_link_timeout(struct io_kiocb *req, struct io_tw_state *t
 			ret = io_try_cancel(req->task->io_uring, &cd, 0);
 		}
 		io_req_set_res(req, ret ?: -ETIME, 0);
-		io_req_task_complete(req, ts);
+		io_req_task_complete(tw_req, tw);
 		io_put_req(prev);
 	} else {
 		io_req_set_res(req, -ETIME, 0);
-		io_req_task_complete(req, ts);
+		io_req_task_complete(tw_req, tw);
 	}
 }
 
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index e5d0cc8a8a562..0dfd27963fc0d 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -113,8 +113,9 @@ void io_uring_cmd_mark_cancelable(struct io_uring_cmd *cmd,
 }
 EXPORT_SYMBOL_GPL(io_uring_cmd_mark_cancelable);
 
-static void io_uring_cmd_work(struct io_kiocb *req, struct io_tw_state *ts)
+static void io_uring_cmd_work(struct io_tw_req tw_req, io_tw_token_t tw)
 {
+	struct io_kiocb *req = tw_req.req;
 	struct io_uring_cmd *ioucmd = io_kiocb_to_cmd(req, struct io_uring_cmd);
 	unsigned int flags = IO_URING_F_COMPLETE_DEFER;
 
diff --git a/io_uring/waitid.c b/io_uring/waitid.c
index b67b6d5bc6830..f3222cb30cdea 100644
--- a/io_uring/waitid.c
+++ b/io_uring/waitid.c
@@ -16,7 +16,7 @@
 #include "waitid.h"
 #include "../kernel/exit.h"
 
-static void io_waitid_cb(struct io_kiocb *req, struct io_tw_state *ts);
+static void io_waitid_cb(struct io_tw_req tw_req, io_tw_token_t tw);
 
 #define IO_WAITID_CANCEL_FLAG	BIT(31)
 #define IO_WAITID_REF_MASK	GENMASK(30, 0)
@@ -236,13 +236,14 @@ static inline bool io_waitid_drop_issue_ref(struct io_kiocb *req)
 	return true;
 }
 
-static void io_waitid_cb(struct io_kiocb *req, struct io_tw_state *ts)
+static void io_waitid_cb(struct io_tw_req tw_req, io_tw_token_t tw)
 {
+	struct io_kiocb *req = tw_req.req;
 	struct io_waitid_async *iwa = req->async_data;
 	struct io_ring_ctx *ctx = req->ctx;
 	int ret;
 
-	io_tw_lock(ctx, ts);
+	io_tw_lock(ctx, tw);
 
 	ret = __do_wait(&iwa->wo);
 
@@ -271,7 +272,7 @@ static void io_waitid_cb(struct io_kiocb *req, struct io_tw_state *ts)
 	}
 
 	io_waitid_complete(req, ret);
-	io_req_task_complete(req, ts);
+	io_req_task_complete(tw_req, tw);
 }
 
 static int io_waitid_wait(struct wait_queue_entry *wait, unsigned mode,
-- 
2.53.0

