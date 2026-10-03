Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736D03B4EA1
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 23:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791070312; cv=none; b=MX64jqLmCx+DveRY1HovmjsccmVScoLcM4NrdVux25dQqFunwiQpTrFN6Q+QDsUWkfcsJFl5IMul3n38JF8PdVuZV7+Ky+vvt8ntqeQDJ34qyIhaKTYTrZK7Pif4IPVIKk1vt/WDxupMvY19vI8X3JMfvUQ9dn9Y6KpCpachEmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791070312; c=relaxed/simple;
	bh=8NEp9VNs1e1ZDssfHtJ14bIFKiP8C9QuAn+gLCIVMII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VvfcfCwZxSi/EnBWlxYnPP+ACKKbcoq21bAYGQOADJluM8JZugf65PtfQLiOTAB0AOBuP/P9cyIND/AGBh7tKSukIwTEWBkfowKzCTvybXaZD7isoKEwXCGZ7wfl/5H3t/WkEbUZQG5L0CW1hnaiK3jcV2I90ssg3zP3o3XcR+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bBDAi4KZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBDAi4KZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF0121F0089B;
	Sat,  3 Oct 2026 23:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791070310;
	bh=CsVZeO5KljrdSGH2DSwkj6dJRBabeO1R8ynrlKBd3ao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bBDAi4KZ9EDsXpKGKTWDLIoDdzQZoLyUC2i2WJkkPhdjzCQmeV/sR2/6RvJVdpsws
	 AtiWN2mzib/nEXfWMWYQlwLO6rESG5yXKFyQbwAqcKbrZsISD7rR3xcbGDJlh6Ybdn
	 51Beg7hofaDVPejrDorwcbvT3G/7+uJrTcMsmBNko/ds8kAszYMCS3QX8ztIWK1Y9K
	 Tu4BRzheG6/gKW5prD3ObWaNVskTdMFoQCTvy39W6JhmaS91F0N9dMOoEfPmyO5dP5
	 dLBJi13DkBDJ9zyykgSI8CkMsMXSBtzxU9rlWgVQgQxzR8StkDdWhI/wZObbgbnKRj
	 cYD6sZYGNsH+g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] io_uring: fix task_work add use-after-free with SQPOLL
Date: Sat,  3 Oct 2026 19:31:38 -0400
Message-ID: <20261003233007.714200-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100334-octagon-comfort-b900@gregkh>
References: <2026100334-octagon-comfort-b900@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jens Axboe <axboe@kernel.dk>

[ Upstream commit a92193c91e8839fe5fc209616ea95465ae4b919d ]

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
[ sashal: Adjusted hunk placement for the existing task-work implementation using llist_add() instead of mpscq_push(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/io_uring.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 03c6ab505d74a..1e7963cc30d3e 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -1219,6 +1219,9 @@ static void io_req_normal_work_add(struct io_kiocb *req)
 	struct io_uring_task *tctx = req->task->io_uring;
 	struct io_ring_ctx *ctx = req->ctx;
 
+	/* SQPOLL can retire the request on push, see io_ring_exit_work() */
+	guard(rcu)();
+
 	/* task_work already pending, we're done */
 	if (!llist_add(&req->io_task_work.node, &tctx->task_list))
 		return;
@@ -2962,8 +2965,8 @@ static __cold void io_ring_exit_work(struct work_struct *work)
 	spin_lock(&ctx->completion_lock);
 	spin_unlock(&ctx->completion_lock);
 
-	/* pairs with RCU read section in io_req_local_work_add() */
-	if (ctx->flags & IORING_SETUP_DEFER_TASKRUN)
+	/* pairs with the RCU read sections in the task_work add paths */
+	if (ctx->flags & (IORING_SETUP_DEFER_TASKRUN | IORING_SETUP_SQPOLL))
 		synchronize_rcu();
 
 	io_ring_ctx_free(ctx);
-- 
2.53.0

