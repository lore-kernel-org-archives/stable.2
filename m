Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A214EF153
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 13:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790775819; cv=none; b=ILgHU8px4R/q2zWleUl1y5mI7gZDiDeZB5GTWqoHr7CjANuF7135f7AohuIovn/EUr/lRW0EBoYcAlN4X343zDehadAbusj+6MWGvNlE0QR/PWniGFgl71v3kodZauEqt4ZJc75OFRV5uA0Qknkc51bh2/FBQaXlNmGLHh6Qv5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790775819; c=relaxed/simple;
	bh=SSIon3cWvhLqE6nI4Esb11p7HSj3kKZ1wstbAmLjU4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uLCBIcGzU1Rz5zMH5QJwpK9uZ8IeuFuUGmbtbgm4F7orDpiNrnBGfoXLstqCqY6gBitmAV+/EZrY1I7xEykXMb486z3YSKwntj129hZiQO3nOTaxqMwAQ3i67c7w5NBxtyjtW1RWWKzI65XerAAIZI5tWraobrWykMpLIKXuaac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UK85AWHk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UK85AWHk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E76A91F00893;
	Wed, 30 Sep 2026 13:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790775808;
	bh=NIauBsE0RVK0klBrYJ3nXuta26ouRgavO9EiLAEQaYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UK85AWHkV2eyl5+8D5fx21TUj8CTQP1tjBRhgc+9FZCvF4A4fh5QG0WkcbfvcXtvq
	 yskiZnOhD0yGcACZuiBy2XSk7GaavtxeQ+FGUYLI11FeVP2hyPsvC9v4hBGj77gw8f
	 Ja6h1/YcKQg7IAeSc4eiXOokopHUu+FrohZzVEK6J58Phe9cH+n7OH5sZbwtg3Gl+H
	 Qp7Eo//Wu8onW+G9PSKCgDw6R1UVnnZ9PWf/c3FzZPLie7Z3h3swinvXmHZyBx02m7
	 t0JX/EWmehGHbj6BmNs7vqMNrsAp/KZs2LMe9tRtOfQRncwEtSlQ4I5JwBmFy3bWvg
	 5NJkbWeTx+JpQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Andrea Righi <arighi@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 1/3] sched_ext: Generalize local-DSQ handling to rq-owned DSQs
Date: Wed, 30 Sep 2026 09:43:24 -0400
Message-ID: <20260930134326.1793774-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092914-daughter-crudeness-399c@gregkh>
References: <2026092914-daughter-crudeness-399c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tejun Heo <tj@kernel.org>

[ Upstream commit bf6cf1886a56eaf929d8193a3f4b30be59a778e2 ]

The local DSQ is synchronized by the containing rq lock rather than its own
dsq->lock. A later patch adds a second such DSQ. In preparation, factor the
"rq owns the lock" test into dsq_is_rq_owned() and rename
local_dsq_post_enq() to rq_owned_post_enq(), taking @rq explicitly.

No behavior change.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Stable-dep-of: 94480606a677 ("sched_ext: Add a size argument to scx_bpf_cid_topo() so struct scx_cid_topo can grow")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/ext/ext.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 906e4f08967f8..665825f1d1ff4 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -95,6 +95,17 @@ static atomic_long_t scx_hotplug_seq = ATOMIC_LONG_INIT(0);
 /* Global cursor for the per-CPU tid allocator. Starts at 1; tid 0 is reserved. */
 static atomic64_t scx_tid_cursor = ATOMIC64_INIT(1);
 
+/* is @dsq synchronized by the containing rq lock instead of dsq->lock? */
+static bool dsq_is_rq_owned(struct scx_dispatch_q *dsq)
+{
+	switch (dsq->id) {
+	case SCX_DSQ_LOCAL:
+		return true;
+	default:
+		return false;
+	}
+}
+
 #ifdef CONFIG_EXT_SUB_SCHED
 /*
  * The sub sched being enabled. Used by scx_disable_and_exit_task() to exit
@@ -1466,11 +1477,10 @@ static void call_task_dequeue(struct scx_sched *sch, struct rq *rq,
 	p->scx.flags &= ~SCX_TASK_IN_CUSTODY;
 }
 
-static void local_dsq_post_enq(struct scx_sched *sch, struct scx_dispatch_q *dsq,
-			       struct task_struct *p, u64 enq_flags)
+static void rq_owned_post_enq(struct scx_sched *sch, struct rq *rq,
+			      struct scx_dispatch_q *dsq, struct task_struct *p,
+			      u64 enq_flags)
 {
-	struct rq *rq = container_of(dsq, struct rq, scx.local_dsq);
-
 	call_task_dequeue(sch, rq, p, 0);
 
 	/*
@@ -1530,13 +1540,13 @@ static void dispatch_enqueue(struct scx_sched *sch, struct rq *rq,
 			     struct scx_dispatch_q *dsq, struct task_struct *p,
 			     u64 enq_flags)
 {
-	bool is_local = dsq->id == SCX_DSQ_LOCAL;
+	bool is_rq_owned = dsq_is_rq_owned(dsq);
 
 	WARN_ON_ONCE(p->scx.dsq || !list_empty(&p->scx.dsq_list.node));
 	WARN_ON_ONCE((p->scx.dsq_flags & SCX_TASK_DSQ_ON_PRIQ) ||
 		     !RB_EMPTY_NODE(&p->scx.dsq_priq));
 
-	if (!is_local) {
+	if (!is_rq_owned) {
 		raw_spin_lock_nested(&dsq->lock,
 			(enq_flags & SCX_ENQ_NESTED) ? SINGLE_DEPTH_NESTING : 0);
 
@@ -1631,8 +1641,8 @@ static void dispatch_enqueue(struct scx_sched *sch, struct rq *rq,
 	 * ops_state first, both sides would modify p->scx.flags
 	 * concurrently in a non-atomic way.
 	 */
-	if (is_local) {
-		local_dsq_post_enq(sch, dsq, p, enq_flags);
+	if (is_rq_owned) {
+		rq_owned_post_enq(sch, rq, dsq, p, enq_flags);
 	} else {
 		/*
 		 * Task on global/bypass DSQ: leave custody, task on
@@ -1679,7 +1689,7 @@ static void task_unlink_from_dsq(struct task_struct *p,
 static void dispatch_dequeue(struct rq *rq, struct task_struct *p)
 {
 	struct scx_dispatch_q *dsq = p->scx.dsq;
-	bool is_local = dsq == &rq->scx.local_dsq;
+	bool is_rq_owned = dsq && dsq_is_rq_owned(dsq);
 
 	lockdep_assert_rq_held(rq);
 
@@ -1703,7 +1713,7 @@ static void dispatch_dequeue(struct rq *rq, struct task_struct *p)
 		return;
 	}
 
-	if (!is_local)
+	if (!is_rq_owned)
 		raw_spin_lock(&dsq->lock);
 
 	/*
@@ -1725,7 +1735,7 @@ static void dispatch_dequeue(struct rq *rq, struct task_struct *p)
 	}
 	p->scx.dsq = NULL;
 
-	if (!is_local)
+	if (!is_rq_owned)
 		raw_spin_unlock(&dsq->lock);
 }
 
@@ -2277,7 +2287,7 @@ static void move_local_task_to_local_dsq(struct scx_sched *sch,
 	dsq_inc_nr(dst_dsq, p, enq_flags);
 	p->scx.dsq = dst_dsq;
 
-	local_dsq_post_enq(sch, dst_dsq, p, enq_flags);
+	rq_owned_post_enq(sch, dst_rq, dst_dsq, p, enq_flags);
 }
 
 /**
-- 
2.53.0

