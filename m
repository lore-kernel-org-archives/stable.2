Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2014457CE;
	Fri,  7 Aug 2026 21:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786136547; cv=none; b=cumyFqGZ6A8vRMFDGHqbwtbG41jRVhd21moPyP0EW1Bo9xV6QBD9X1Rh1JUjmXhARnN8f/Od57NZmdhrSFCfKkWdIJuXoIbsX8MpMjqwCLwoSLZZu7nY/1iyWql/xpSqSJL+TMk0twQjHYmbjbi0qyWCceW0gKusuj7WM3yZpJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786136547; c=relaxed/simple;
	bh=JL8Rg9VqdsSh9GEpXVxCe/lZlOXG4xyPRSOWwas3SWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZWM5jr+NCH05IDbIa2iHvIQzVCRUH3SdFZJLb9r5UrJ2WLL5Y1ls9Gw8hq6JcE4Tss7vDgFMQkqzA+r9pI8hJyxKewOVE9pVryl/b0lvyOT/Dudv1dfHT/z88kqhcEmNgmUS6emj8jJ90OwBpeuLwBFvmWzeWuCmL2/huBXY9eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0ZeaSq8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0ZeaSq8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31B341F00A3D;
	Fri,  7 Aug 2026 21:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786136545;
	bh=qhQYmprBg6cDHGVKQJLVDI5eSrzWcunREMEQlJT2xmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J0ZeaSq8PhsvOlQXx5QfpLr06RqHKV7ro7vZm/+9SOU8tI1nKMiko7tUhnmL+bfRL
	 uNwfmgMj4xSRt70a47yKyiQAX1HqtmxYLurE5fLTaHD8zxGZQODOT4lds30Y/kH/M0
	 pJACuR+ivFiMfxUzBnRMz9h7dttYIqAch7coi5c2DFSRjAZF6ptlHQIsw8XsDiP92w
	 cmpa9JOA/vaHSySvC9iXN/ZQaYEPkusxVBYr/ZqJSs1TpEYmlGSHNB+M58ALxi/23e
	 5Cl09Ispnu/PmnciDSpizamQUfDW5ZcJxy2qsWkMlPPl2+g2feooQsfRkDTnptMkl6
	 j9n9hvxFwRljQ==
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
Subject: [PATCH 3/6] sched_ext: Replace SCX_RQ_BAL_KEEP with a dispatch verdict return
Date: Fri,  7 Aug 2026 11:02:18 -1000
Message-ID: <20260807210221.232543-4-tj@kernel.org>
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

SCX_RQ_BAL_KEEP tells the pick to keep running the previous task, a leftover
from when balancing and picking were separate operations. An rq-level flag
only works while dispatches and picks pair up one to one, which core
scheduling breaks: selections interleave through dispatch's lock drops and a
pick can consume a stale flag, keeping a task that has since been dequeued.
Fixing core scheduling support requires the decision to travel with the
dispatch that made it. Make scx_dispatch_sched() and balance_one() return an
explicit verdict instead.

Also factor the pick-side invocation, its follow-up queueing and the
post-dispatch checks out of do_pick_task_scx() into dispatch_pick(). No
functional changes intended.

Fixes: 4c95380701f5 ("sched/ext: Fold balance_scx() into pick_task_scx()")
Cc: stable@vger.kernel.org # v6.19+
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 124 ++++++++++++++++++++++++-----------------
 kernel/sched/sched.h   |   1 -
 2 files changed, 73 insertions(+), 52 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 18183062f751..ffbe4f7edc99 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2774,12 +2774,19 @@ static inline void maybe_queue_balance_callback(struct rq *rq)
 	rq->scx.flags &= ~SCX_RQ_BAL_CB_PENDING;
 }
 
+/* what dispatch concluded, consumed by the pick that follows */
+enum scx_dsp_verdict {
+	SCX_DSP_NONE,		/* nothing to run */
+	SCX_DSP_LOCAL,		/* local DSQ has tasks */
+	SCX_DSP_PREV,		/* keep running @prev */
+};
+
 /*
  * One user of this function is scx_bpf_dispatch() which can be called
  * recursively as sub-sched dispatches nest. Always inline to reduce stack usage
  * from the call frame.
  */
-static __always_inline bool
+static __always_inline enum scx_dsp_verdict
 scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
 		   struct task_struct *prev, bool nested)
 {
@@ -2790,12 +2797,15 @@ scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
 		scx_task_on_sched(sch, prev);
 
 	if (consume_global_dsq(sch, rq))
-		return true;
+		return SCX_DSP_LOCAL;
 
 	if (bypass_dsp_enabled(sch)) {
 		/* if @sch is bypassing, only the bypass DSQs are active */
-		if (scx_bypassing(sch, cpu))
-			return consume_dispatch_q(sch, rq, bypass_dsq(sch, cpu), 0);
+		if (scx_bypassing(sch, cpu)) {
+			if (consume_dispatch_q(sch, rq, bypass_dsq(sch, cpu), 0))
+				return SCX_DSP_LOCAL;
+			return SCX_DSP_NONE;
+		}
 
 #ifdef CONFIG_EXT_SUB_SCHED
 		/*
@@ -2815,13 +2825,13 @@ scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
 		if (!(pcpu->bypass_host_seq++ % SCX_BYPASS_HOST_NTH) &&
 		    consume_dispatch_q(sch, rq, bypass_dsq(sch, cpu), 0)) {
 			__scx_add_event(sch, SCX_EV_SUB_BYPASS_DISPATCH, 1);
-			return true;
+			return SCX_DSP_LOCAL;
 		}
 #endif	/* CONFIG_EXT_SUB_SCHED */
 	}
 
 	if (unlikely(!SCX_HAS_OP(sch, dispatch)) || !scx_rq_online(rq))
-		return false;
+		return SCX_DSP_NONE;
 
 	dspc->rq = rq;
 
@@ -2848,14 +2858,12 @@ scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
 
 		flush_dispatch_buf(sch, rq);
 
-		if ((prev->scx.flags & SCX_TASK_QUEUED) && prev->scx.slice) {
-			rq->scx.flags |= SCX_RQ_BAL_KEEP;
-			return true;
-		}
+		if ((prev->scx.flags & SCX_TASK_QUEUED) && prev->scx.slice)
+			return SCX_DSP_PREV;
 		if (rq->scx.local_dsq.nr)
-			return true;
+			return SCX_DSP_LOCAL;
 		if (consume_global_dsq(sch, rq))
-			return true;
+			return SCX_DSP_LOCAL;
 
 		/*
 		 * ops.dispatch() can trap us in this loop by repeatedly
@@ -2877,20 +2885,20 @@ scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
 	 * queued. Without this fallback, bypassed tasks could stall if the host
 	 * scheduler's ops.dispatch() doesn't yield any tasks.
 	 */
-	if (bypass_dsp_enabled(sch))
-		return consume_dispatch_q(sch, rq, bypass_dsq(sch, cpu), 0);
+	if (bypass_dsp_enabled(sch) && consume_dispatch_q(sch, rq, bypass_dsq(sch, cpu), 0))
+		return SCX_DSP_LOCAL;
 
-	return false;
+	return SCX_DSP_NONE;
 }
 
-static int balance_one(struct rq *rq, struct task_struct *prev)
+static enum scx_dsp_verdict balance_one(struct rq *rq, struct task_struct *prev)
 {
 	struct scx_sched *sch = scx_root;
+	enum scx_dsp_verdict verdict;
 	s32 cpu = cpu_of(rq);
 
 	lockdep_assert_rq_held(rq);
 	rq->scx.flags |= SCX_RQ_IN_BALANCE;
-	rq->scx.flags &= ~SCX_RQ_BAL_KEEP;
 
 	if ((sch->ops.flags & SCX_OPS_HAS_CPU_PREEMPT) &&
 	    unlikely(rq->scx.cpu_released)) {
@@ -2920,16 +2928,19 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 		 */
 		if ((prev->scx.flags & SCX_TASK_QUEUED) && prev->scx.slice &&
 		    !scx_bypassing(sch, cpu)) {
-			rq->scx.flags |= SCX_RQ_BAL_KEEP;
+			verdict = SCX_DSP_PREV;
 			goto has_tasks;
 		}
 	}
 
 	/* if there already are tasks to run, nothing to do */
-	if (rq->scx.local_dsq.nr)
+	if (rq->scx.local_dsq.nr) {
+		verdict = SCX_DSP_LOCAL;
 		goto has_tasks;
+	}
 
-	if (scx_dispatch_sched(sch, rq, prev, false))
+	verdict = scx_dispatch_sched(sch, rq, prev, false);
+	if (verdict != SCX_DSP_NONE)
 		goto has_tasks;
 
 	/*
@@ -2938,12 +2949,12 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 	 */
 	if ((prev->scx.flags & SCX_TASK_QUEUED) &&
 	    (!(sch->ops.flags & SCX_OPS_ENQ_LAST) || scx_bypassing(sch, cpu))) {
-		rq->scx.flags |= SCX_RQ_BAL_KEEP;
 		__scx_add_event(sch, SCX_EV_DISPATCH_KEEP_LAST, 1);
+		verdict = SCX_DSP_PREV;
 		goto has_tasks;
 	}
 	rq->scx.flags &= ~SCX_RQ_IN_BALANCE;
-	return false;
+	return SCX_DSP_NONE;
 
 has_tasks:
 	/*
@@ -2960,7 +2971,7 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 		schedule_reenq_local(rq, 0);
 
 	rq->scx.flags &= ~SCX_RQ_IN_BALANCE;
-	return true;
+	return verdict;
 }
 
 static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
@@ -3179,27 +3190,23 @@ static struct task_struct *first_local_task(struct rq *rq)
 					struct task_struct, scx.dsq_list.node);
 }
 
-static struct task_struct *
-do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bool force_scx)
+/*
+ * Run dispatch and queue the follow-up work for a pick.
+ */
+static enum scx_dsp_verdict dispatch_pick(struct rq *rq, struct rq_flags *rf,
+					  struct task_struct *prev)
 {
-	struct task_struct *prev = rq->curr;
-	bool keep_prev;
-	struct task_struct *p;
-
-	/* see kick_sync_wait_bal_cb() */
-	smp_store_release(&rq->scx.kick_sync, rq->scx.kick_sync + 1);
-
-	rq_modified_begin(rq, &ext_sched_class);
+	enum scx_dsp_verdict verdict;
 
 	rq_unpin_lock(rq, rf);
-	balance_one(rq, prev);
+	verdict = balance_one(rq, prev);
 	rq_repin_lock(rq, rf);
 	maybe_queue_balance_callback(rq);
 
 	/*
-	 * Defer to a balance callback which can drop rq lock and enable
-	 * IRQs. Waiting directly in the pick path would deadlock against
-	 * CPUs sending us IPIs (e.g. TLB flushes) while we wait for them.
+	 * Defer to a balance callback which can drop rq lock and enable IRQs.
+	 * Waiting directly in the pick path would deadlock against CPUs sending
+	 * us IPIs (e.g. TLB flushes) while we wait for them.
 	 */
 	if (unlikely(rq->scx.kick_sync_pending)) {
 		rq->scx.kick_sync_pending = false;
@@ -3207,10 +3214,32 @@ do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bool force_scx)
 				       kick_sync_wait_bal_cb);
 	}
 
+	if (unlikely(verdict == SCX_DSP_PREV && prev->sched_class != &ext_sched_class)) {
+		WARN_ON_ONCE(scx_enable_state() == SCX_ENABLED);
+		verdict = SCX_DSP_LOCAL;
+	}
+
+	return verdict;
+}
+
+static struct task_struct *
+do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bool force_scx)
+{
+	struct task_struct *prev = rq->curr;
+	enum scx_dsp_verdict verdict;
+	struct task_struct *p;
+
+	/* see kick_sync_wait_bal_cb() */
+	smp_store_release(&rq->scx.kick_sync, rq->scx.kick_sync + 1);
+
+	rq_modified_begin(rq, &ext_sched_class);
+
+	verdict = dispatch_pick(rq, rf, prev);
+
 	/*
-	 * If any higher-priority sched class enqueued a runnable task on
-	 * this rq during balance_one(), abort and return RETRY_TASK, so
-	 * that the scheduler loop can restart.
+	 * If any higher-priority sched class enqueued a runnable task on this
+	 * rq during balance_one(), abort and return RETRY_TASK, so that the
+	 * scheduler loop can restart.
 	 *
 	 * If @force_scx is true, always try to pick a SCHED_EXT task,
 	 * regardless of any higher-priority sched classes activity.
@@ -3218,19 +3247,12 @@ do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bool force_scx)
 	if (!force_scx && rq_modified_above(rq, &ext_sched_class))
 		return RETRY_TASK;
 
-	keep_prev = rq->scx.flags & SCX_RQ_BAL_KEEP;
-	if (unlikely(keep_prev &&
-		     prev->sched_class != &ext_sched_class)) {
-		WARN_ON_ONCE(scx_enable_state() == SCX_ENABLED);
-		keep_prev = false;
-	}
-
 	/*
 	 * If balance_one() is telling us to keep running @prev, replenish slice
 	 * if necessary and keep running @prev. Otherwise, pop the first one
 	 * from the local DSQ.
 	 */
-	if (keep_prev) {
+	if (verdict == SCX_DSP_PREV) {
 		p = prev;
 		if (!p->scx.slice)
 			refill_task_slice_dfl(scx_task_sched(p), p);
@@ -5573,7 +5595,7 @@ static void disable_bypass_dsp(struct scx_sched *sch)
  *
  * - ops.dispatch() is ignored.
  *
- * - balance_one() does not set %SCX_RQ_BAL_KEEP on non-zero slice as slice
+ * - balance_one() does not report %SCX_DSP_PREV on non-zero slice as slice
  *   can't be trusted. Whenever a tick triggers, the running task is rotated to
  *   the tail of the queue with core_sched_at touched.
  *
@@ -9201,8 +9223,8 @@ __bpf_kfunc bool scx_bpf_sub_dispatch(u64 cgroup_id, const struct bpf_prog_aux *
 		return false;
 	}
 
-	return scx_dispatch_sched(child, this_rq, this_rq->scx.sub_dispatch_prev,
-				  true);
+	return scx_dispatch_sched(child, this_rq, this_rq->scx.sub_dispatch_prev, true) !=
+		SCX_DSP_NONE;
 }
 #endif	/* CONFIG_EXT_SUB_SCHED */
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 450b6a04669f..14c2df6fd9af 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -784,7 +784,6 @@ enum scx_rq_flags {
 	 */
 	SCX_RQ_ONLINE		= 1 << 0,
 	SCX_RQ_CAN_STOP_TICK	= 1 << 1,
-	SCX_RQ_BAL_KEEP		= 1 << 3, /* balance decided to keep current */
 	SCX_RQ_CLK_VALID	= 1 << 5, /* RQ clock is fresh and valid */
 	SCX_RQ_BAL_CB_PENDING	= 1 << 6, /* must queue a cb after dispatching */
 
-- 
2.55.0

