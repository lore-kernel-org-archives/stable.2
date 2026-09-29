Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634254FD289
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 11:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790682207; cv=none; b=qGvbLAuzN1fKJITQ1JBzmsoJRiRthQ70p66j/WKbKNlfPGsI666iuyKc0ITL0eEMziPTmBpZCtCUeXd+dEgcwFxiO5RAiowBXKNt4ffOzcKB3Bal6G5UGqcpb0mA3hY96V8W8iCSt104F5KHaofrIIilEkuo00VACaEqZ8g5+wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790682207; c=relaxed/simple;
	bh=jGy6BphkkbdDND6SRd11s0o/Q2KIR28PLH2Sqrmv7+o=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dQsjqWb3ZSRfYG41Uw7bJwI99VzkfacxTErOBeq5xLfkOy6JiDFqQta1Nn4nLWq41gafpmqIffyrgvNfZFcSJ+P60at8Vd9KtuQ9H3iU6gO11t+3yZYmhnXTIjLXvQ9GGRlO7CTK1kxHMwEIR4TwWiykXGF7BdPbH63jklpl7ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hbfXG61r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hbfXG61r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 853A21F000FF;
	Tue, 29 Sep 2026 11:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790682206;
	bh=aT5RQB1pq3ZqDT0kML1sDpCgIRo7PlVQeKuImR8Wopw=;
	h=Subject:To:Cc:From:Date;
	b=hbfXG61rkSFHdl+/0MXgsCOeyAGY/KOYHD69bY7FM489qu4WureThoYkdbQDE4ZoC
	 txhVrXPdRLhpeuRkCKECCj3YfCu4hlEGoNOw1kz7eYu/bgTbQJjQpmoH6EF2h3hZmY
	 IO4bLY26SIGjprqqalY2ijC/LlEHmWcv5EfAEUcs=
Subject: FAILED: patch "[PATCH] sched_ext: Don't run ops.dequeue() with a DSQ lock held" failed to apply to 7.2-stable tree
To: fangqiurong@kylinos.cn,arighi@nvidia.com,tj@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 13:43:17 +0200
Message-ID: <2026092917-xerox-existing-569f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.2.y
git checkout FETCH_HEAD
git cherry-pick -x cb86607ada73185f321baa7f9d94a08a3a40bbf5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092917-xerox-existing-569f@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cb86607ada73185f321baa7f9d94a08a3a40bbf5 Mon Sep 17 00:00:00 2001
From: fangqiurong <fangqiurong@kylinos.cn>
Date: Thu, 17 Sep 2026 15:52:41 +0800
Subject: [PATCH] sched_ext: Don't run ops.dequeue() with a DSQ lock held

ops.dequeue() is invoked with the source user DSQ's lock still held on
the consume and move paths (scx_consume_dispatch_q(),
move_task_between_dsqs()). A BPF scheduler which locks the source user
DSQ from ops.dequeue() - e.g. by iterating it with bpf_iter_scx_dsq -
self-deadlocks.

ops.dequeue() can only call the "any" kfuncs and none of them can lock a
builtin DSQ, so the global and bypass paths can't deadlock; however,
all DSQ locks share one lockdep class, so iterating any user DSQ from
ops.dequeue() on those paths trips the recursion check.

Move the invocation after the DSQ unlock on all three paths.
SCX_TASK_IN_CUSTODY is cleared under the lock serializing the transfer
so that the callback is invoked exactly once.

Fixes: ebf1ccff79c4 ("sched_ext: Fix ops.dequeue() semantics")
Cc: stable@vger.kernel.org # v7.1+
Acked-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: fangqiurong <fangqiurong@kylinos.cn>
Signed-off-by: Tejun Heo <tj@kernel.org>

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index e207ccd17164..f568fd9973f6 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -1499,27 +1499,22 @@ static inline bool task_scx_migrating(struct task_struct *p)
 	return p->scx.sticky_cpu >= 0;
 }
 
-/*
- * Call ops.dequeue() if the task is in BPF custody and not migrating.
- * Clears %SCX_TASK_IN_CUSTODY when the callback is invoked.
- */
-static void call_task_dequeue(struct scx_sched *sch, struct rq *rq,
-			      struct task_struct *p, u64 deq_flags)
+/* Must be called under the lock serializing @p's custody transfers. */
+static bool task_leave_custody(struct task_struct *p)
 {
 	if (!(p->scx.flags & SCX_TASK_IN_CUSTODY) || task_scx_migrating(p))
-		return;
-
-	if (SCX_HAS_OP(sch, dequeue))
-		SCX_CALL_OP_TASK(sch, dequeue, rq, p, deq_flags);
+		return false;
 
 	p->scx.flags &= ~SCX_TASK_IN_CUSTODY;
+	return true;
 }
 
 static void rq_owned_post_enq(struct scx_sched *sch, struct rq *rq,
 			      struct scx_dispatch_q *dsq, struct task_struct *p,
 			      u64 enq_flags)
 {
-	call_task_dequeue(sch, rq, p, 0);
+	if (task_leave_custody(p) && SCX_HAS_OP(sch, dequeue))
+		SCX_CALL_OP_TASK(sch, dequeue, rq, p, 0);
 
 	/*
 	 * Only local inserts get the wakeup treatment below. Rejects kick the
@@ -1705,20 +1700,28 @@ static void scx_dispatch_enqueue(struct scx_sched *sch, struct rq *rq,
 	if (is_rq_owned) {
 		rq_owned_post_enq(sch, rq, dsq, p, enq_flags);
 	} else {
+		bool call_dequeue = false;
+
 		/*
 		 * Global and bypass DSQs are terminal - the task leaves the
-		 * scheduler's custody, so ops.dequeue() fires here. It can run
+		 * scheduler's custody, so ops.dequeue() fires. It can run
 		 * without @p's rq lock (finish_dispatch() passes the dispatch
 		 * rq); that's safe because dequeue_task_scx() waits on
 		 * SCX_OPSS_DISPATCHING (see the ops_state note above) and so
 		 * can't race it. A non-terminal DSQ keeps the task in custody.
+		 * The custody transfer happens under @dsq->lock so that later
+		 * consumers see the flag clear; the callback runs after
+		 * @dsq->lock is dropped because it may lock a DSQ itself.
 		 */
 		if (dsq->id == SCX_DSQ_GLOBAL || dsq->id == SCX_DSQ_BYPASS)
-			call_task_dequeue(sch, rq, p, 0);
+			call_dequeue = task_leave_custody(p);
 		else
 			p->scx.flags |= SCX_TASK_IN_CUSTODY;
 
 		raw_spin_unlock(&dsq->lock);
+
+		if (call_dequeue && SCX_HAS_OP(sch, dequeue))
+			SCX_CALL_OP_TASK(sch, dequeue, rq, p, 0);
 	}
 
 	/*
@@ -2215,7 +2218,7 @@ retry:
 		/*
 		 * A queued task must always be in BPF scheduler's custody. If
 		 * SCX_TASK_IN_CUSTODY is clear, finish_dispatch() on another
-		 * CPU has already passed call_task_dequeue() (which clears the
+		 * CPU has already passed task_leave_custody() (which clears the
 		 * flag), but has not yet written SCX_OPSS_NONE. That final
 		 * store does not require this rq's lock, so retrying with
 		 * cpu_relax() is bounded: we will observe NONE (or DISPATCHING,
@@ -2263,7 +2266,8 @@ retry:
 	 * NONE but the task may still have %SCX_TASK_IN_CUSTODY set until
 	 * it is enqueued on the destination.
 	 */
-	call_task_dequeue(sch, rq, p, deq_flags);
+	if (task_leave_custody(p) && SCX_HAS_OP(sch, dequeue))
+		SCX_CALL_OP_TASK(sch, dequeue, rq, p, deq_flags);
 }
 
 static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int core_deq_flags)
@@ -2379,14 +2383,10 @@ static void wakeup_preempt_scx(struct rq *rq, struct task_struct *p, int wake_fl
 }
 
 void scx_move_local_task_to_local_dsq(struct scx_sched *sch, struct task_struct *p,
-				      u64 enq_flags, struct scx_dispatch_q *src_dsq,
-				      struct rq *dst_rq)
+				      u64 enq_flags, struct rq *dst_rq)
 {
 	struct scx_dispatch_q *dst_dsq = scx_resolve_local_dsq(sch, dst_rq, p, &enq_flags);
 
-	/* @p is on @dst_rq, an rq-owned @src_dsq is covered by the rq lock */
-	if (!dsq_is_rq_owned(src_dsq))
-		lockdep_assert_held(&src_dsq->lock);
 	lockdep_assert_rq_held(dst_rq);
 
 	WARN_ON_ONCE(p->scx.holding_cpu >= 0);
@@ -2634,8 +2634,8 @@ static struct rq *move_task_between_dsqs(struct scx_sched *sch,
 		/* @p is going from a non-local DSQ to a local DSQ */
 		if (src_rq == dst_rq) {
 			scx_task_unlink_from_dsq(p, src_dsq);
-			scx_move_local_task_to_local_dsq(sch, p, enq_flags, src_dsq, dst_rq);
 			raw_spin_unlock(&src_dsq->lock);
+			scx_move_local_task_to_local_dsq(sch, p, enq_flags, dst_rq);
 		} else {
 			raw_spin_unlock(&src_dsq->lock);
 			move_remote_task_to_local_dsq(sch, p, enq_flags, src_rq, dst_rq);
@@ -2685,8 +2685,8 @@ retry:
 
 		if (rq == task_rq) {
 			scx_task_unlink_from_dsq(p, dsq);
-			scx_move_local_task_to_local_dsq(sch, p, enq_flags, dsq, rq);
 			raw_spin_unlock(&dsq->lock);
+			scx_move_local_task_to_local_dsq(sch, p, enq_flags, rq);
 			return true;
 		}
 
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 115c96fbf932..d150de10a5c9 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -2065,8 +2065,7 @@ void scx_dispatch_dequeue(struct rq *rq, struct task_struct *p);
 void scx_do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 			 int sticky_cpu);
 void scx_move_local_task_to_local_dsq(struct scx_sched *sch, struct task_struct *p,
-				      u64 enq_flags, struct scx_dispatch_q *src_dsq,
-				      struct rq *dst_rq);
+				      u64 enq_flags, struct rq *dst_rq);
 bool scx_consume_dispatch_q(struct scx_sched *sch, struct rq *rq,
 			    struct scx_dispatch_q *dsq, u64 enq_flags);
 bool scx_consume_global_dsq(struct scx_sched *sch, struct rq *rq);
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index a30c965b175d..3036190b0662 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -555,8 +555,8 @@ static void scx_rescue_timerfn(struct timer_list *timer)
 				     scx.dsq_list.node);
 		scx_task_unlink_from_dsq(p, &rq->scx.rescue.dsq);
 		scx_rescue_admit(rq, p, slice);
-		scx_move_local_task_to_local_dsq(scx_task_sched(p), p, SCX_ENQ_IGNORE_CAPS,
-						 &rq->scx.rescue.dsq, rq);
+		scx_move_local_task_to_local_dsq(scx_task_sched(p), p,
+						 SCX_ENQ_IGNORE_CAPS, rq);
 		if (sched_class_above(&ext_sched_class, rq->curr->sched_class))
 			resched_curr(rq);
 	} else if (p->scx.dsq && rq->scx.rescue.budget > 2 * scx_rescue_quantum_ns) {
@@ -572,7 +572,7 @@ static void scx_rescue_timerfn(struct timer_list *timer)
 		scx_task_unlink_from_dsq(p, &rq->scx.local_dsq);
 		scx_move_local_task_to_local_dsq(scx_task_sched(p), p,
 					SCX_ENQ_HEAD | SCX_ENQ_PREEMPT | SCX_ENQ_IGNORE_CAPS,
-					&rq->scx.local_dsq, rq);
+					rq);
 	}
 out_arm:
 	scx_rescue_timer_arm(rq);
@@ -596,8 +596,8 @@ void scx_rescue_flush(struct rq *rq)
 	/* and flush out all pending ones */
 	list_for_each_entry_safe(p, n, &rq->scx.rescue.dsq.list, scx.dsq_list.node) {
 		scx_task_unlink_from_dsq(p, &rq->scx.rescue.dsq);
-		scx_move_local_task_to_local_dsq(scx_task_sched(p), p, SCX_ENQ_IGNORE_CAPS,
-						 &rq->scx.rescue.dsq, rq);
+		scx_move_local_task_to_local_dsq(scx_task_sched(p), p,
+						 SCX_ENQ_IGNORE_CAPS, rq);
 	}
 
 	timer_delete(&rq->scx.rescue.timer);

