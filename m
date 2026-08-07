Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FAA4446F6;
	Fri,  7 Aug 2026 21:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786136553; cv=none; b=i0tDmqhdRNAjrgcfzR0IaFEeaFdpmkUW5zcToZOWjuhIvxHwgVwVeM1fON4jdYGBVa7TiZtG23ySKHGxKlWvZ0o3szILmcFOJ9FGYInmvStehar0jr0vVuTfFRLrIh35JCcU7Ka3Sx0ZsTANfwoSiFdJn2lIhJCew5i6Ls8IuUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786136553; c=relaxed/simple;
	bh=dXpRDPPkZ7FXk/if8Zksu1au2E5kN/Xx+PsUMqEtGLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L9JDhvDJwD1Bdnj+Pn1cV4rLkqY5A8XaGqc2JTpVS9HPFagr6Vyz1qPOdGQPr/WQmEGwdNFhvJABquSI5jMNci++lt8JFYplhdQ6oj54dPk020Lcu2+BnBDaAuuBhjrXODDBj/wkPYLO77O/W5hFC/HimnUtBd7kzo1/Tz/jmtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JdDNi+qi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JdDNi+qi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BABB1F00A3E;
	Fri,  7 Aug 2026 21:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786136548;
	bh=od1zWNBwoQfHu7v8WDhmT1GKRF4GP5l9oYthNA0KAM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JdDNi+qi6+lQzjIsMlU4Su+msVuW29SUfurOsByk7jMBdo6tEuGb0ynMWT5dWRIhI
	 t0WcWLdjqWj06A/iwemyl3rWAIyPwSNlVUX8oQXoIOBjjzSr2zfKuChNfjwgyNYsSa
	 Q2ZOZlgfvoboyaBTCSDEeGU5cwPseDJkOPzKNBUnOPteFD71WwLZpDgS33Mdkk/YMp
	 cMhbfSRmA3EiiNJNC4Hm4nUwgUXy9m1tt1Ek5f+eqSvGMkrtGfMcAlFSnDzr/Lvtks
	 JxHGvyR3c4dm/BrKE/w8KcSQj6f3X3M5iBcJYm9larG/V0rYScAmrwNcRehd6crIuy
	 PyMNGkwz+hIVA==
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
Subject: [PATCH 6/6] sched_ext: Fix rq->core_pick corruption under core scheduling
Date: Fri,  7 Aug 2026 11:02:21 -1000
Message-ID: <20260807210221.232543-7-tj@kernel.org>
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

Core scheduling's pick_next_task() picks what to run on every SMT sibling of
the core in a single pass under the shared core-wide rq lock. The selection
state is consistent only while the lock is held continuously, so
->pick_task() originally could not release it. However, since 4c95380701f5
("sched/ext: Fold balance_scx() into pick_task_scx()"), sched_ext runs
dispatch from inside the pick and dispatching can drop the rq lock. To
support this, pick_next_task() has been updated to restart the whole
selection when a pick returns RETRY_TASK after releasing the lock.

When selections on the same core interleave through the dropped lock, they
corrupt each other's state: one clears the other's rq->core_pick leading to
a NULL deref, or invalidates its keep-the-previous-task decision leaving a
dequeued task running, which deadlocks the next wakeup and matches the
reported hard hangs. A cookied ping-pong load on an SMT machine makes the
interleavings frequent and kills the kernel within seconds.

Fix it by making the pick return RETRY_TASK whenever dispatch released the
rq lock, so that a selection only ever commits picks made under a
continuously held lock. The previous patch's rq->scx.lock_drop_seq counts
the releases. A dispatch that touched nothing never releases the lock and
its verdict, including "nothing to run", stands: retries are bounded, each
following a dispatch that actually did something, and an idle CPU does not
loop.

If another dispatch is already in flight on the rq, skip dispatching and
pick from what is already queued locally - the in-flight dispatch has
released the lock, so its own selection will retry and re-pick this rq,
while returning RETRY_TASK here would only spin on the lock that dispatch
needs to finish.

Balance callbacks must run in the context that queued them, so they can only
be queued on the CPU's own rq. When dispatching for another rq, run the
deferred work directly instead - that rq may consume all its picks through
the core-sched fast path and never queue the callback itself.

The put_prev_task_scx() warning about a runnable task being left behind
assumed that dispatch ran as part of the very pick that is switching away.
That now only holds on the non-core path, so gate it and drop the
cookie-match test, which is always true without core scheduling, from its
condition.

Fixes: 4c95380701f5 ("sched/ext: Fold balance_scx() into pick_task_scx()")
Cc: stable@vger.kernel.org # v6.19+
Reported-by: ElXreno <elxreno@gmail.com>
Link: https://github.com/sched-ext/scx/issues/3715
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 86 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 78 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index ebe40953acf0..c70458885487 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2797,6 +2797,7 @@ enum scx_dsp_verdict {
 	SCX_DSP_NONE,		/* nothing to run */
 	SCX_DSP_LOCAL,		/* local DSQ has tasks */
 	SCX_DSP_PREV,		/* keep running @prev */
+	SCX_DSP_RETRY,		/* pick helpers only: restart the pick */
 };
 
 /*
@@ -3142,12 +3143,12 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 		 * ops.enqueue() that @p is the only one available for this cpu,
 		 * which should trigger an explicit follow-up scheduling event.
 		 *
-		 * Core scheduling can force this CPU idle while @p stays
-		 * runnable. @p's cookie then won't match the core's, so skip
-		 * the warning in that case.
+		 * Under core scheduling, a pick dispatches only when nothing is
+		 * locally runnable and can legitimately go idle with @p still
+		 * runnable (see do_pick_task_scx()).
 		 */
 		if (next && sched_class_above(&ext_sched_class, next->sched_class)) {
-			WARN_ON_ONCE(sched_cpu_cookie_match(rq, p) &&
+			WARN_ON_ONCE(!sched_core_enabled(rq) &&
 				     !(sch->ops.flags & SCX_OPS_ENQ_LAST));
 			do_enqueue_task(rq, p, SCX_ENQ_LAST, -1);
 		} else {
@@ -3241,6 +3242,70 @@ static enum scx_dsp_verdict dispatch_pick(struct rq *rq, struct rq_flags *rf,
 	return verdict;
 }
 
+#ifdef CONFIG_SCHED_CORE
+/*
+ * Dispatch for a pick when core scheduling is enabled. The selection picks for
+ * all SMT siblings and the rq_i->core_pick state it builds must stay atomic
+ * throughout. If the dispatch released the rq lock, anything can have happened
+ * in between - return %SCX_DSP_RETRY to restart the selection against current
+ * state.
+ */
+static enum scx_dsp_verdict dispatch_core_pick(struct rq *rq, struct rq_flags *rf,
+					       struct task_struct *prev)
+{
+	enum scx_dsp_verdict verdict;
+	u32 seq = rq->scx.lock_drop_seq;
+
+	/* another dispatch is in flight on @rq, let that handle it */
+	if (rq->scx.flags & SCX_RQ_IN_BALANCE)
+		return SCX_DSP_NONE;
+
+	rq_unpin_lock(rq, rf);
+
+	verdict = balance_one(rq, prev);
+
+	if (cpu_of(rq) == smp_processor_id()) {
+		maybe_queue_balance_callback(rq);
+
+		/* see dispatch_pick() */
+		if (unlikely(rq->scx.kick_sync_pending)) {
+			rq->scx.kick_sync_pending = false;
+			queue_balance_callback(rq, &rq->scx.kick_sync_bal_cb,
+					       kick_sync_wait_bal_cb);
+		}
+	} else if (unlikely(rq->scx.flags & SCX_RQ_BAL_CB_PENDING)) {
+		/*
+		 * Balance callbacks must run in the context that queued them,
+		 * so they can't be queued on another CPU's rq. Run the deferred
+		 * work directly instead.
+		 */
+		rq->scx.flags &= ~SCX_RQ_BAL_CB_PENDING;
+		run_deferred(rq);
+	}
+
+	rq_repin_lock(rq, rf);
+
+	/* if balance_one() released the rq lock, restart the selection */
+	if (rq->scx.lock_drop_seq != seq)
+		return SCX_DSP_RETRY;
+
+	/* see dispatch_pick() */
+	if (unlikely(verdict == SCX_DSP_PREV &&
+		     prev->sched_class != &ext_sched_class)) {
+		WARN_ON_ONCE(scx_enable_state() == SCX_ENABLED);
+		verdict = SCX_DSP_LOCAL;
+	}
+
+	return verdict;
+}
+#else	/* CONFIG_SCHED_CORE */
+static enum scx_dsp_verdict dispatch_core_pick(struct rq *rq, struct rq_flags *rf,
+					       struct task_struct *prev)
+{
+	return SCX_DSP_NONE;
+}
+#endif	/* CONFIG_SCHED_CORE */
+
 static struct task_struct *
 do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bool force_scx)
 {
@@ -3253,7 +3318,13 @@ do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bool force_scx)
 
 	rq_modified_begin(rq, &ext_sched_class);
 
-	verdict = dispatch_pick(rq, rf, prev);
+	if (sched_core_enabled(rq))
+		verdict = dispatch_core_pick(rq, rf, prev);
+	else
+		verdict = dispatch_pick(rq, rf, prev);
+
+	if (verdict == SCX_DSP_RETRY)
+		return RETRY_TASK;
 
 	/*
 	 * If any higher-priority sched class enqueued a runnable task on this
@@ -3267,9 +3338,8 @@ do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bool force_scx)
 		return RETRY_TASK;
 
 	/*
-	 * If balance_one() is telling us to keep running @prev, replenish slice
-	 * if necessary and keep running @prev. Otherwise, pop the first one
-	 * from the local DSQ.
+	 * If we're keeping @prev, replenish slice if necessary and keep running
+	 * @prev. Otherwise, pop the first one from the local DSQ.
 	 */
 	if (verdict == SCX_DSP_PREV) {
 		p = prev;
-- 
2.55.0

