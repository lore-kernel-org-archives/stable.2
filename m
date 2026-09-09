Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11B530D3F1
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 15:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788966589; cv=none; b=tf2p0Ltfcdslh1ENuB9Fw4OvBF1ZevtUCk64P339nelP5jpPCmM+ao+4HFD5DVCev+BkzjAJ2aWE+qN+TUIvOGVc4JRW8oHUldkQAgQ9XHKs6Q0HOuuhN8mwaB7rmMNll+J5cZyHOF2Ytr1RkTO6cV3X4jAR42VR2WrohcTucsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788966589; c=relaxed/simple;
	bh=bhZvMEVSYSIb/wxGwFpItLo16tzDp2/QesnOe/3VkPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cf05pZKEvVdnmcHAkD90qIKpT5SBxggTmrvZ4UGyUJgJ+5KqPv2nTVeuMPQwpm+6v95Uf4cC5KXJU4EGveOZdh+OLmu/eNzIvzAHnfJQfWGqPMtx0YGExN/B44EP2aorO6DE/7sxp+HSHHUEoh0ymPPSZPDxfWP5XrwKrV60BvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TM04ylp7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TM04ylp7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB6D1F00A3A;
	Wed,  9 Sep 2026 15:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788966587;
	bh=BbLjcH+U4sxLjczRqhy2RTVfQuTmDyTqBSXKXVXUd/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TM04ylp73HSlCEPPwq0R//igxMbvazR90Jtbh7eame4wZb0u+f7nbC4nk/UJhhyZC
	 X1fUXLH+ppEhE3lPxn7MWEq+EGp9xIoc13yH8+oE3Xm4pUzsSUOHn08rw86kmyW3Wa
	 XEkJDBFzG08sXYmNwktNBtBz9jnkZqxU25atO/RCZ06hOg87n/6VpVFxW8ikd+WjxP
	 zWfnayWho2ATjfkbQeIBCetnytgZFQtW1EKFFMfsEIc19f1n7hZak1xraZZmHN9bHE
	 8WvahFt1WDgN2TB55UWE0klth86v9dnjDXNBjms+J8eYW1sFizFYcvWk7wMeaP5L51
	 pHDuAruNmJpVg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/6] io_uring: unify task_work cancelation checks
Date: Wed,  9 Sep 2026 11:09:40 -0400
Message-ID: <20260909150945.2815896-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090354-alabaster-robbing-fd51@gregkh>
References: <2026090354-alabaster-robbing-fd51@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jens Axboe <axboe@kernel.dk>

[ Upstream commit 7be20254a743be4f02414b9d56cc3fe5f84e6500 ]

Rather than do per-tw checking, which needs to dip into the task_struct
for checking flags, do it upfront before running task_work. This places
a 'cancel' member in io_tw_token_t, which is assigned before running
task_work for that given ctx.

This is both more efficient in doing it upfront rather than for every
task_work, and it means that io_should_terminate_tw() can be made
private in io_uring.c rather than need to be called by various
callbacks of task_work.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: 2cf20c4e0f72 ("io_uring/waitid: avoid siginfo copy during ring teardown")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/io_uring_types.h |  1 +
 io_uring/io_uring.c            | 27 ++++++++++++++++++++-------
 io_uring/io_uring.h            | 13 -------------
 io_uring/poll.c                |  2 +-
 io_uring/timeout.c             |  2 +-
 io_uring/uring_cmd.c           |  2 +-
 6 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
index d73556f10733c..e9609c433120e 100644
--- a/include/linux/io_uring_types.h
+++ b/include/linux/io_uring_types.h
@@ -482,6 +482,7 @@ struct io_ring_ctx {
  * ONLY core io_uring.c should instantiate this struct.
  */
 struct io_tw_state {
+	bool cancel;
 };
 /* Alias to use in code that doesn't instantiate struct io_tw_state */
 typedef struct io_tw_state io_tw_token_t;
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 9784463fb718d..d59a750e5e89c 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -268,6 +268,20 @@ static __cold void io_ring_ctx_ref_free(struct percpu_ref *ref)
 	complete(&ctx->ref_comp);
 }
 
+/*
+ * Terminate the request if either of these conditions are true:
+ *
+ * 1) It's being executed by the original task, but that task is marked
+ *    with PF_EXITING as it's exiting.
+ * 2) PF_KTHREAD is set, in which case the invoker of the task_work is
+ *    our fallback task_work.
+ * 3) The ring has been closed and is going away.
+ */
+static inline bool io_should_terminate_tw(struct io_ring_ctx *ctx)
+{
+	return (current->flags & (PF_EXITING | PF_KTHREAD)) || percpu_ref_is_dying(&ctx->refs);
+}
+
 static __cold void io_fallback_req_func(struct work_struct *work)
 {
 	struct io_ring_ctx *ctx = container_of(work, struct io_ring_ctx,
@@ -278,8 +292,10 @@ static __cold void io_fallback_req_func(struct work_struct *work)
 
 	percpu_ref_get(&ctx->refs);
 	mutex_lock(&ctx->uring_lock);
-	llist_for_each_entry_safe(req, tmp, node, io_task_work.node)
+	llist_for_each_entry_safe(req, tmp, node, io_task_work.node) {
+		ts.cancel = io_should_terminate_tw(req->ctx);
 		req->io_task_work.func(req, ts);
+	}
 	io_submit_flush_completions(ctx);
 	mutex_unlock(&ctx->uring_lock);
 	percpu_ref_put(&ctx->refs);
@@ -1152,6 +1168,7 @@ struct llist_node *io_handle_tw_list(struct llist_node *node,
 			ctx = req->ctx;
 			mutex_lock(&ctx->uring_lock);
 			percpu_ref_get(&ctx->refs);
+			ts.cancel = io_should_terminate_tw(ctx);
 		}
 		INDIRECT_CALL_2(req->io_task_work.func,
 				io_poll_task_func, io_req_rw_complete,
@@ -1210,11 +1227,6 @@ struct llist_node *tctx_task_work_run(struct io_uring_task *tctx,
 {
 	struct llist_node *node;
 
-	if (unlikely(current->flags & PF_EXITING)) {
-		io_fallback_tw(tctx, true);
-		return NULL;
-	}
-
 	node = llist_del_all(&tctx->task_list);
 	if (node) {
 		node = llist_reverse_order(node);
@@ -1432,6 +1444,7 @@ static int __io_run_local_work(struct io_ring_ctx *ctx, io_tw_token_t tw,
 	if (ctx->flags & IORING_SETUP_TASKRUN_FLAG)
 		atomic_andnot(IORING_SQ_TASKRUN, &ctx->rings->sq_flags);
 again:
+	tw.cancel = io_should_terminate_tw(ctx);
 	min_events -= ret;
 	ret = __io_run_local_work_loop(&ctx->retry_llist.first, tw, max_events);
 	if (ctx->retry_llist.first)
@@ -1491,7 +1504,7 @@ void io_req_task_submit(struct io_kiocb *req, io_tw_token_t tw)
 	struct io_ring_ctx *ctx = req->ctx;
 
 	io_tw_lock(ctx, tw);
-	if (unlikely(io_should_terminate_tw(ctx)))
+	if (unlikely(tw.cancel))
 		io_req_defer_failed(req, -EFAULT);
 	else if (req->flags & REQ_F_FORCE_ASYNC)
 		io_queue_iowq(req);
diff --git a/io_uring/io_uring.h b/io_uring/io_uring.h
index 05702288465b7..39fc7609f24f3 100644
--- a/io_uring/io_uring.h
+++ b/io_uring/io_uring.h
@@ -582,19 +582,6 @@ static inline bool io_allowed_run_tw(struct io_ring_ctx *ctx)
 		      ctx->submitter_task == current);
 }
 
-/*
- * Terminate the request if either of these conditions are true:
- *
- * 1) It's being executed by the original task, but that task is marked
- *    with PF_EXITING as it's exiting.
- * 2) PF_KTHREAD is set, in which case the invoker of the task_work is
- *    our fallback task_work.
- */
-static inline bool io_should_terminate_tw(struct io_ring_ctx *ctx)
-{
-	return (current->flags & (PF_KTHREAD | PF_EXITING)) || percpu_ref_is_dying(&ctx->refs);
-}
-
 static inline void io_req_queue_tw_complete(struct io_kiocb *req, s32 res)
 {
 	io_req_set_res(req, res, 0);
diff --git a/io_uring/poll.c b/io_uring/poll.c
index 6745bbc963286..264f8584789fa 100644
--- a/io_uring/poll.c
+++ b/io_uring/poll.c
@@ -225,7 +225,7 @@ static int io_poll_check_events(struct io_kiocb *req, io_tw_token_t tw)
 {
 	int v;
 
-	if (unlikely(io_should_terminate_tw(req->ctx)))
+	if (unlikely(tw.cancel))
 		return -ECANCELED;
 
 	do {
diff --git a/io_uring/timeout.c b/io_uring/timeout.c
index dec1d13ca4207..8a3844de9ceb4 100644
--- a/io_uring/timeout.c
+++ b/io_uring/timeout.c
@@ -324,7 +324,7 @@ static void io_req_task_link_timeout(struct io_kiocb *req, io_tw_token_t tw)
 	int ret;
 
 	if (prev) {
-		if (!io_should_terminate_tw(req->ctx)) {
+		if (!tw.cancel) {
 			struct io_cancel_data cd = {
 				.ctx		= req->ctx,
 				.data		= prev->cqe.user_data,
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index df521ce10b0a4..26044357d649b 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -120,7 +120,7 @@ static void io_uring_cmd_work(struct io_kiocb *req, io_tw_token_t tw)
 	struct io_uring_cmd *ioucmd = io_kiocb_to_cmd(req, struct io_uring_cmd);
 	unsigned int flags = IO_URING_F_COMPLETE_DEFER;
 
-	if (io_should_terminate_tw(req->ctx))
+	if (unlikely(tw.cancel))
 		flags |= IO_URING_F_TASK_DEAD;
 
 	/* task_work executor checks the deffered list completion */
-- 
2.53.0

