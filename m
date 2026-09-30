Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E664BE434
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 15:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790780993; cv=none; b=AjZ6KqE64rHGANugM3d+lZIcBGTGNEbA0LzPfU4iwdpVvhtH8p90aQxR10Kql7fCPGwhpQBQmA3aa6Upc5y3orezwYjOOr28+Xb3DFRrnAt0hBgRumXFJ5xlUS61eFkXPHAuFiJCKCaxEl8FAc1gxBSU5EvY13134K7gwagBhvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790780993; c=relaxed/simple;
	bh=TFgpZN8lcCa1b9F4rajDACrHNtC16kUZD0clcTlog0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mz0kL+pyqRBx+AUEVdl8hqSlQdg9mqFT6Gpdg+6C9rRj71BNGtOWe7yaql6RXQKSgEj/WVf42RcdVq7sDyG5WzaN2xDsM9sGh2fheB7r/kHHCBh1pEK5LRLV759dpvtWWOcio5nvUli8T0SscxAnAMAf7bZ9+GbSqr1rejxJyCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DUA6ddBM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DUA6ddBM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 252AC1F00893;
	Wed, 30 Sep 2026 15:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790780983;
	bh=rXDOaiNGLxUphCrcZft9w9mNkywmLa05NH/NsXu7sLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DUA6ddBMBZQY7NCxOHpQK+Ob5YFGoyf0JeomBYptaQ+OCAYzWJWS4hyeYs0ypy6OZ
	 0VOVwvSihqsxblI38uB5dWyPhd2IvfyqowHfEPRkx2WBlx8wRJXgl1rjBxNo1dD5RF
	 ZBMj+GuQiq0zmag4EIpXRCnbao21pBrbSpfCmDWgTx66fRHxc2ZOwGphz5r7HB7z4D
	 W0Rw9wZEyT4jJSTd90njKYM26faU35SbL/gXP/NviZi/Cfn+prOi5t6dMlnFgdIWgs
	 kbLaasACxdTtjXaObirGPzaBUuNzMXQsvcesrokIjZiPPROOsGRiD8fzdA7VvXBnCz
	 LMMCMIx9/i6Sg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Andrea Righi <arighi@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 1/2] sched_ext: Generalize local-DSQ handling to rq-owned DSQs
Date: Wed, 30 Sep 2026 11:09:40 -0400
Message-ID: <20260930150941.2349228-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092920-protector-confused-2f3e@gregkh>
References: <2026092920-protector-confused-2f3e@gregkh>
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
Stable-dep-of: 7de9a6fb44ea ("sched_ext: Wait for SCX_OPSS_DISPATCHING before reenqueueing a task")
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

