Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792679448;
	b=sHy09g6UEpguhh/v+y830kP/NY4mxZ5dmHqgJtmwkM5m088x3Q9yskjioSwOVRVsdbvf
	 QpXtepGQCDbUjRfXCDq9xNhENiaXkR3YPlg2+L9EDsGwbR+r9TTNGevfoXaPU4wr6LcPx
	 vETa9PV2MZ7WsUZsK122pBliHF7KQMKn298Vlow3fzdj/7RkSUEAPrCmJmFtmI0H4BIr8
	 TfqWnPBzqkXwcmnqvlyrXg6yw0aWvpQQSrJqGPkE0PP8GYsNLX2m5eWKvroOIlQi9YkKK
	 OdlvM4awg9pbMoQ2EYgdk8Z/usYZ3hAR3hqRMjzfGLLp8vjIcRfsEksAcuJ+5Siezpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792679448;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=phsyiiYftDpLPcWYGIQVdQF2640V/13pZn7gbZ+aOV8=;
	b=TWMNeQ69W4yo45vduDxxIbaLYJrvFa0qoF23K6Gd46iOhgmqEOXTbqOMtK0Xnb4wWc/d
	 l7uLsiUr/SNLaqibSuDephhtrvCuAcA+u93lhxEEhqo2LOmCnbsqodpiwquxj3oSHvbx9
	 ifc11dAvtTgQ4XOJwV/dmXTliaSe2qrq2UJ0wm8hKCAu6SK90vZbAQonK9aD31oQ2FTq4
	 kohpkosAr6jacz09iuicpOCVlS2VGUjBVMXgc9oZyTMvx1T3SnfFPKJbLWtSuJXfzBGOj
	 +EB3HF0BKmxk3ULo7XIZRSJxPxdfN9fiQ9rXneQvr2r6QDTJLz3rs4OfaYOkVDvz0/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mFBmA++k;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9798A606A31A
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 14:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mFBmA++k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B70671F000C1;
	Thu, 22 Oct 2026 14:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792679448;
	bh=phsyiiYftDpLPcWYGIQVdQF2640V/13pZn7gbZ+aOV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mFBmA++kILyTK3Agm+DxF3BCrYbSRzjLXRDrEvmoFKYrwUshxNRIhcwTgrf1oCYfK
	 h9eWZRIQBmCgjMpxdKH5hh2b+T34pu/PxCn3GfYf3QGSr89GP6wl7xyYHpNfmOoBJH
	 HLU/AvOg6g1Gu5S4y6mpOCj6Eh3997pg4HEvWvX2y0F35YS0GvbdEqLcQlf52hUquM
	 gISXOMELVJmh29e+C02qAIYPsJPRMnlwEvU72FoRF3h6EVa/8jG6EulrKHDRWlyBDt
	 Xpl+kOA+8r+FYAcma4ELkNLzpOXxoSuhlEXgsCdIacxaGSqQ0kBBY5J+ObXTMF+Ph9
	 CQfR01ojXZNRA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/4] io_uring/cancel: move request/task cancelation logic into cancel.c
Date: Thu, 22 Oct 2026 10:30:43 -0400
Message-ID: <20261022143039.1598352-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102127-pettiness-citation-cb83@gregkh>
References: <2026102127-pettiness-citation-cb83@gregkh>
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

[ Upstream commit 0d677936d67774f1b4ebfb3b26f207320f0fe3c6 ]

Move io_match_task_safe() and helpers into cancel.c, where it belongs.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: fddcf4c5321b ("io_uring/cancel: don't spin on local work the task can't run")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/cancel.c   | 38 ++++++++++++++++++++++++++++++++++++++
 io_uring/cancel.h   |  2 ++
 io_uring/io_uring.c | 38 --------------------------------------
 io_uring/io_uring.h |  3 ---
 4 files changed, 40 insertions(+), 41 deletions(-)

diff --git a/io_uring/cancel.c b/io_uring/cancel.c
index 64b51e82baa24..2754ea80e2882 100644
--- a/io_uring/cancel.c
+++ b/io_uring/cancel.c
@@ -384,3 +384,41 @@ int io_cancel_remove(struct io_ring_ctx *ctx, struct io_cancel_data *cd,
 	io_ring_submit_unlock(ctx, issue_flags);
 	return nr ?: -ENOENT;
 }
+
+static bool io_match_linked(struct io_kiocb *head)
+{
+	struct io_kiocb *req;
+
+	io_for_each_link(req, head) {
+		if (req->flags & REQ_F_INFLIGHT)
+			return true;
+	}
+	return false;
+}
+
+/*
+ * As io_match_task() but protected against racing with linked timeouts.
+ * User must not hold timeout_lock.
+ */
+bool io_match_task_safe(struct io_kiocb *head, struct io_uring_task *tctx,
+			bool cancel_all)
+{
+	bool matched;
+
+	if (tctx && head->tctx != tctx)
+		return false;
+	if (cancel_all)
+		return true;
+
+	if (head->flags & REQ_F_LINK_TIMEOUT) {
+		struct io_ring_ctx *ctx = head->ctx;
+
+		/* protect against races with linked timeouts */
+		raw_spin_lock_irq(&ctx->timeout_lock);
+		matched = io_match_linked(head);
+		raw_spin_unlock_irq(&ctx->timeout_lock);
+	} else {
+		matched = io_match_linked(head);
+	}
+	return matched;
+}
diff --git a/io_uring/cancel.h b/io_uring/cancel.h
index eaa4069e258c9..88054aa048736 100644
--- a/io_uring/cancel.h
+++ b/io_uring/cancel.h
@@ -21,6 +21,8 @@ int io_try_cancel(struct io_uring_task *tctx, struct io_cancel_data *cd,
 
 int io_sync_cancel(struct io_ring_ctx *ctx, void __user *arg);
 bool io_cancel_req_match(struct io_kiocb *req, struct io_cancel_data *cd);
+bool io_match_task_safe(struct io_kiocb *head, struct io_uring_task *tctx,
+			bool cancel_all);
 
 bool io_cancel_remove_all(struct io_ring_ctx *ctx, struct io_uring_task *tctx,
 			  struct hlist_head *list, bool cancel_all,
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index ad5e203e0d5ff..3d7d88df4d88a 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -210,44 +210,6 @@ static inline unsigned int __io_cqring_events_user(struct io_ring_ctx *ctx)
 	return READ_ONCE(rings->cq.tail) - READ_ONCE(rings->cq.head);
 }
 
-static bool io_match_linked(struct io_kiocb *head)
-{
-	struct io_kiocb *req;
-
-	io_for_each_link(req, head) {
-		if (req->flags & REQ_F_INFLIGHT)
-			return true;
-	}
-	return false;
-}
-
-/*
- * As io_match_task() but protected against racing with linked timeouts.
- * User must not hold timeout_lock.
- */
-bool io_match_task_safe(struct io_kiocb *head, struct io_uring_task *tctx,
-			bool cancel_all)
-{
-	bool matched;
-
-	if (tctx && head->tctx != tctx)
-		return false;
-	if (cancel_all)
-		return true;
-
-	if (head->flags & REQ_F_LINK_TIMEOUT) {
-		struct io_ring_ctx *ctx = head->ctx;
-
-		/* protect against races with linked timeouts */
-		raw_spin_lock_irq(&ctx->timeout_lock);
-		matched = io_match_linked(head);
-		raw_spin_unlock_irq(&ctx->timeout_lock);
-	} else {
-		matched = io_match_linked(head);
-	}
-	return matched;
-}
-
 static inline void req_fail_link_node(struct io_kiocb *req, int res)
 {
 	req_set_fail(req);
diff --git a/io_uring/io_uring.h b/io_uring/io_uring.h
index 042bdd766571b..f70423539e479 100644
--- a/io_uring/io_uring.h
+++ b/io_uring/io_uring.h
@@ -185,9 +185,6 @@ void io_queue_next(struct io_kiocb *req);
 void io_task_refs_refill(struct io_uring_task *tctx);
 bool __io_alloc_req_refill(struct io_ring_ctx *ctx);
 
-bool io_match_task_safe(struct io_kiocb *head, struct io_uring_task *tctx,
-			bool cancel_all);
-
 void io_activate_pollwq(struct io_ring_ctx *ctx);
 
 static inline void io_lockdep_assert_cq_locked(struct io_ring_ctx *ctx)
-- 
2.53.0

