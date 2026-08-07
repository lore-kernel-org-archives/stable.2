Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9546F44470C;
	Fri,  7 Aug 2026 21:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786136548; cv=none; b=uF/XLmWsd8UB2VMtiBhJdPs6Yl4ocuKnqxQ+p52MZrizSrmEgHiSYoZd/Lbs+us9E5oUXbtRmmr6xcUlBu730dH1Az+eIZNt9SR1870kGubGYHaQxz/CYXO2jltp+Hff1UuUHWdGMRcH4G2xniWY9DcTahhxF4cB3Moejp+LiwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786136548; c=relaxed/simple;
	bh=8bzleXVoElEB80Urtr1buOOlt/wVXC6fs2rYR3dOEXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g415MTBrLxZYckHl+wVYYa/B3TG86cgfkqhImDdzodQmbioJu5B78tB0AnCUbO3J476YGGfjdJcRism+XeJGwVuVVOMcJFp0h1DXjcAbFbYtvW+yZSL3hHQr0KucjwbHF8UdhRTEN1/F+A5zAzJ3UbuMEUTBuTBfFowgtWPAx3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3YCQMeG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3YCQMeG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C091F00A3A;
	Fri,  7 Aug 2026 21:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786136546;
	bh=5SSwLEP362C2XHIyYmt182W2S7IG8MPTSZQTn8/mu/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A3YCQMeGk7Erq3Hi0jgrG3f+5t0Tpnm+qIqNrYf9k2FYp0jt6NMxPNAHL3YeQtwzp
	 N+9qd/qA+XzQv2L5cDA6LKJG9fegkauTgOMLCH74PQyiGcjaduHN/jzzSxeAq6QmQT
	 tWfW9fym0jE/7LTgIrIq498w97cjFRMXpc01oeH2/eXlHo1mjEyysY9Xih1e0VaMeZ
	 mMOAkenucLcrLI1ooJLLnKEo814Tz2r8yqTpyd6KXZNPUJ45b4N4OKAxhnAJB9zDcC
	 kB9jNNibRxKgtf4fdgZRr4/pufulLlu7luaJJ0nYBH6doz1/UK8FLU7kOpE4x5x12V
	 QOb7xp60YX96Q==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	Peter Zijlstra <peterz@infradead.org>,
	ElXreno <elxreno@gmail.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 4/6] sched_ext: Fix this_rq() assumptions in dispatch kfuncs
Date: Fri,  7 Aug 2026 11:02:19 -1000
Message-ID: <20260807210221.232543-5-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807210221.232543-1-tj@kernel.org>
References: <20260807210221.232543-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Under core scheduling, dispatch runs from within the core-wide pick and can
target a sibling rq, so ops.dispatch() may execute on a CPU different from
the dispatched rq's. Several kfunc paths assumed the two always coincide:

- scx_dsq_move() decided whether an rq lock is held by testing this_rq()'s
  rq flags and lock-danced accordingly. A dispatch for a sibling took the
  unlocked-context branch and acquired the source rq lock on top of the
  already held dispatched rq lock which could deadlock.

- scx_bpf_sub_dispatch() dispatched this_rq() with its stashed
  sub_dispatch_prev, which is NULL when dispatching for a sibling.

- finish_dispatch(), scx_bpf_dsq_reenq() and scx_bpf_dsq_nr_queued()
  resolved SCX_DSQ_LOCAL to this CPU's local DSQ rather than the dispatched
  rq's. The latter two are callable from other rq-locked operations too,
  where SCX_DSQ_LOCAL now likewise resolves to the op's rq. This changes
  behavior also without core scheduling, e.g. for ops.enqueue() running a
  remote wakeup on the waking CPU, and is intended: which CPU happens to
  execute an operation is incidental, the op's rq is what it is operating
  on, and the resolution now matches the insert side where SCX_DSQ_LOCAL
  dispatches land on the task's rq.

Use the rq tracked by scx_locked_rq(), which is set to the dispatched rq
around ops invocations and NULL in unlocked contexts.

Fixes: 4c95380701f5 ("sched/ext: Fold balance_scx() into pick_task_scx()")
Cc: stable@vger.kernel.org # v6.19+
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 58 +++++++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 23 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index ffbe4f7edc99..84ec71d28b61 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2737,7 +2737,7 @@ static void finish_dispatch(struct scx_sched *sch, struct rq *rq,
 
 	BUG_ON(!(p->scx.flags & SCX_TASK_QUEUED));
 
-	dsq = find_dsq_for_dispatch(sch, this_rq(), dsq_id, task_cpu(p));
+	dsq = find_dsq_for_dispatch(sch, rq, dsq_id, task_cpu(p));
 
 	if (dsq->id == SCX_DSQ_LOCAL)
 		dispatch_to_local_dsq(sch, rq, dsq, p, enq_flags);
@@ -8887,9 +8887,8 @@ static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
 {
 	struct scx_dispatch_q *src_dsq = kit->dsq, *dst_dsq;
 	struct scx_sched *sch;
-	struct rq *this_rq, *src_rq, *locked_rq;
+	struct rq *p_rq, *src_rq, *locked_rq;
 	bool dispatched = false;
-	bool in_balance;
 	unsigned long flags;
 
 	/*
@@ -8919,24 +8918,28 @@ static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
 	}
 
 	/*
-	 * Can be called from either ops.dispatch() locking this_rq() or any
-	 * context where no rq lock is held. If latter, lock @p's task_rq which
-	 * we'll likely need anyway.
+	 * Can be called from either ops.dispatch() holding the dispatched rq's
+	 * lock or any context where no rq lock is held. If latter, lock @p's
+	 * task_rq which we'll likely need anyway.
 	 */
 	src_rq = task_rq(p);
 
 	local_irq_save(flags);
-	this_rq = this_rq();
-	in_balance = this_rq->scx.flags & SCX_RQ_IN_BALANCE;
 
-	if (in_balance) {
-		if (this_rq != src_rq)
-			switch_rq_lock(this_rq, src_rq);
+	/*
+	 * Under core scheduling, dispatch can run for a sibling rq, so the
+	 * locked rq is not necessarily this CPU's.
+	 */
+	locked_rq = scx_locked_rq();
+
+	if (locked_rq) {
+		if (locked_rq != src_rq)
+			switch_rq_lock(locked_rq, src_rq);
 	} else {
 		raw_spin_rq_lock(src_rq);
 	}
 
-	locked_rq = src_rq;
+	p_rq = src_rq;
 	raw_spin_lock(&src_dsq->lock);
 
 	/* did someone else get to it while we dropped the locks? */
@@ -8946,7 +8949,7 @@ static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
 	}
 
 	/* @p is still on $src_dsq and stable, determine the destination */
-	dst_dsq = find_dsq_for_dispatch(sch, this_rq, dsq_id, task_cpu(p));
+	dst_dsq = find_dsq_for_dispatch(sch, locked_rq ?: this_rq(), dsq_id, task_cpu(p));
 
 	/*
 	 * Apply vtime and slice updates before moving so that the new time is
@@ -8959,14 +8962,14 @@ static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
 		p->scx.slice = kit->slice;
 
 	/* execute move */
-	locked_rq = move_task_between_dsqs(sch, p, enq_flags, src_dsq, dst_dsq);
+	p_rq = move_task_between_dsqs(sch, p, enq_flags, src_dsq, dst_dsq);
 	dispatched = true;
 out:
-	if (in_balance) {
-		if (this_rq != locked_rq)
-			switch_rq_lock(locked_rq, this_rq);
+	if (locked_rq) {
+		if (locked_rq != p_rq)
+			switch_rq_lock(p_rq, locked_rq);
 	} else {
-		raw_spin_rq_unlock_irqrestore(locked_rq, flags);
+		raw_spin_rq_unlock_irqrestore(p_rq, flags);
 	}
 
 	kit->cursor.flags &= ~(__SCX_DSQ_ITER_HAS_SLICE |
@@ -9204,7 +9207,7 @@ __bpf_kfunc bool scx_bpf_dsq_move_vtime(struct bpf_iter_scx_dsq *it__iter,
  */
 __bpf_kfunc bool scx_bpf_sub_dispatch(u64 cgroup_id, const struct bpf_prog_aux *aux)
 {
-	struct rq *this_rq = this_rq();
+	struct rq *rq = scx_locked_rq();
 	struct scx_sched *parent, *child;
 
 	guard(rcu)();
@@ -9223,7 +9226,7 @@ __bpf_kfunc bool scx_bpf_sub_dispatch(u64 cgroup_id, const struct bpf_prog_aux *
 		return false;
 	}
 
-	return scx_dispatch_sched(child, this_rq, this_rq->scx.sub_dispatch_prev, true) !=
+	return scx_dispatch_sched(child, rq, rq->scx.sub_dispatch_prev, true) !=
 		SCX_DSP_NONE;
 }
 #endif	/* CONFIG_EXT_SUB_SCHED */
@@ -9518,6 +9521,10 @@ __bpf_kfunc s32 scx_bpf_kick_cid(s32 cid, u64 flags, const struct bpf_prog_aux *
  *
  * Return the number of tasks in the DSQ matching @dsq_id. If not found,
  * -%ENOENT is returned.
+ *
+ * %SCX_DSQ_LOCAL resolves to the local DSQ of the rq the current scheduler
+ * operation is locked to - e.g. the rq being dispatched for in ops.dispatch() -
+ * or the calling CPU's when no rq is locked.
  */
 __bpf_kfunc s32 scx_bpf_dsq_nr_queued(u64 dsq_id, const struct bpf_prog_aux *aux)
 {
@@ -9534,7 +9541,7 @@ __bpf_kfunc s32 scx_bpf_dsq_nr_queued(u64 dsq_id, const struct bpf_prog_aux *aux
 	}
 
 	if (dsq_id == SCX_DSQ_LOCAL) {
-		ret = READ_ONCE(this_rq()->scx.local_dsq.nr);
+		ret = READ_ONCE((scx_locked_rq() ?: this_rq())->scx.local_dsq.nr);
 		goto out;
 	} else if ((dsq_id & SCX_DSQ_LOCAL_ON) == SCX_DSQ_LOCAL_ON) {
 		s32 cpu = scx_cpu_ret(sch, dsq_id & SCX_DSQ_LOCAL_CPU_MASK);
@@ -9713,10 +9720,15 @@ __bpf_kfunc struct task_struct *scx_bpf_dsq_peek(u64 dsq_id,
  * - User DSQs
  *
  * Re-enqueues are performed asynchronously. Can be called from anywhere.
+ *
+ * %SCX_DSQ_LOCAL resolves to the local DSQ of the rq the current scheduler
+ * operation is locked to - e.g. the rq being dispatched for in ops.dispatch() -
+ * or the calling CPU's when no rq is locked.
  */
 __bpf_kfunc void scx_bpf_dsq_reenq(u64 dsq_id, u64 reenq_flags,
 				   const struct bpf_prog_aux *aux)
 {
+	struct rq *locked_rq = scx_locked_rq();
 	struct scx_sched *sch;
 	struct scx_dispatch_q *dsq;
 
@@ -9735,8 +9747,8 @@ __bpf_kfunc void scx_bpf_dsq_reenq(u64 dsq_id, u64 reenq_flags,
 	if (!(reenq_flags & __SCX_REENQ_FILTER_MASK))
 		reenq_flags |= SCX_REENQ_ANY;
 
-	dsq = find_dsq_for_dispatch(sch, this_rq(), dsq_id, smp_processor_id());
-	schedule_dsq_reenq(sch, dsq, reenq_flags, scx_locked_rq());
+	dsq = find_dsq_for_dispatch(sch, locked_rq ?: this_rq(), dsq_id, smp_processor_id());
+	schedule_dsq_reenq(sch, dsq, reenq_flags, locked_rq);
 }
 
 /**
-- 
2.55.0

