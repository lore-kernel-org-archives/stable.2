Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619F5446072;
	Fri,  7 Aug 2026 21:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786136549; cv=none; b=P+nPjtiAMb+SqBDg1rZCIEdEG9k29/2XA34F30xyH9ROyqFNgXeHUMF6qzPkzIDZM30EMj2dOgjXU90pdUfufOmzGOTKOOsIw8t9Fr1Bclvbf33RNjjcvUnmEJoQYrov5lv7qUTxAAoDQrfDdS082BTAKj4BW/kU71xnWicy7Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786136549; c=relaxed/simple;
	bh=wbNfJqhrEmJg8ob0ZbA8fhLFNQPDe4xy/9vNaLykJJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L4/QS+9chSg6ul/EC1HqRvW95/B8xEVyb3F3I+R83oFCM90BXPaNZgo/MNRMx8TPQoDUKD5xduiqS/tehAKrEYePzbh0xAsU+2/NXKH+m0xXLRQ5Y2v7OXnU+XAffD0/ZRVQj0qKIA2pXq6XDsDJliiCkFhfYj4EZsJe/81pVUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bb1ZxVma; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bb1ZxVma"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2062A1F000E9;
	Fri,  7 Aug 2026 21:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786136547;
	bh=qZoxePgmExDjMC3i8NgvPc01WU/ymB6jgrZoa1clzWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Bb1ZxVmalsXPtjNDr6FXaBiOCk3fedZtfaJOHVC9+4MUIcpSGs9T+j0SWlwPWuGJn
	 FXx4l+YhrwtmVC4OSP0Q+mBS4KqkXgUchoChX1Dwb7Unm/CyOEodbIM9nQ6cW2HpJ4
	 ZgDRXl7QlIVded2TZtuBq85ggF1SX2EjuvWGjjh4TvCD+6PHevQOHCqY2QBzbet0dk
	 ch02jNXoLWrsZ5y+bQRP7xfPmZEASre6XSA4l8vvkal2mmtxujKayIwkQ/uhCpTFgN
	 OuYLH8wvlsPmD0BqP6xIeVuoyqN04SdqfcIoWsvREVYrcPx1nk9/cUVAZA7HxeTgvk
	 cFGNaXjz4L1+g==
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
Subject: [PATCH 5/6] sched_ext: Count rq lock releases in rq->scx.lock_drop_seq
Date: Fri,  7 Aug 2026 11:02:20 -1000
Message-ID: <20260807210221.232543-6-tj@kernel.org>
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

Under core scheduling, pick_next_task() selects for all SMT siblings under
one continuous hold of the shared core-wide rq lock, and sched_ext's
dispatch can release that lock from inside the pick. In preparation for
making the core-sched pick detect the releases and retry, add
rq->scx.lock_drop_seq and bump it at every site that can release an rq lock
while a dispatch may be in flight. The counter is only maintained while core
scheduling is enabled. No functional changes.

Fixes: 4c95380701f5 ("sched/ext: Fold balance_scx() into pick_task_scx()")
Cc: stable@vger.kernel.org # v6.19+
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 38 ++++++++++++++++++++++++++++++++++++--
 kernel/sched/sched.h   |  3 +++
 2 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 84ec71d28b61..ebe40953acf0 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -479,12 +479,27 @@ static bool rq_is_open(struct rq *rq, u64 enq_flags)
  */
 DEFINE_PER_CPU(struct rq *, scx_locked_rq_state);
 
+/*
+ * Under core scheduling, a pick that releases the rq lock invalidates the
+ * core-wide selection it is part of. Count the releases so that the core-sched
+ * pick can tell whether one happened across dispatch.
+ */
+static void scx_rq_lock_drop(struct rq *rq)
+{
+	lockdep_assert_rq_held(rq);
+#ifdef CONFIG_SCHED_CORE
+	if (sched_core_enabled(rq))
+		rq->scx.lock_drop_seq++;
+#endif
+}
+
 static void switch_rq_lock(struct rq *from, struct rq *to)
 {
 	bool tracked = scx_locked_rq() == from;
 
 	if (tracked)
 		update_locked_rq(NULL);
+	scx_rq_lock_drop(from);
 	raw_spin_rq_unlock(from);
 	raw_spin_rq_lock(to);
 	if (tracked)
@@ -1133,6 +1148,7 @@ static void deferred_irq_workfn(struct irq_work *irq_work)
 
 	raw_spin_rq_lock(rq);
 	run_deferred(rq);
+	scx_rq_lock_drop(rq);
 	raw_spin_rq_unlock(rq);
 }
 
@@ -2430,12 +2446,14 @@ static bool consume_remote_task(struct rq *this_rq,
 				struct task_struct *p, u64 enq_flags,
 				struct scx_dispatch_q *dsq, struct rq *src_rq)
 {
+	scx_rq_lock_drop(this_rq);
 	raw_spin_rq_unlock(this_rq);
 
 	if (unlink_dsq_and_lock_src_rq(p, dsq, src_rq)) {
 		move_remote_task_to_local_dsq(p, enq_flags, src_rq, this_rq);
 		return true;
 	} else {
+		scx_rq_lock_drop(src_rq);
 		raw_spin_rq_unlock(src_rq);
 		raw_spin_rq_lock(this_rq);
 		return false;
@@ -3171,6 +3189,7 @@ static void kick_sync_wait_bal_cb(struct rq *rq)
 			continue;
 		}
 
+		scx_rq_lock_drop(rq);
 		raw_spin_rq_unlock_irq(rq);
 		while (READ_ONCE(cpu_rq(cpu)->scx.kick_sync) == ksyncs[cpu]) {
 			smp_store_release(&rq->scx.kick_sync, rq->scx.kick_sync + 1);
@@ -4280,8 +4299,10 @@ static void reenq_user(struct rq *rq, struct scx_dispatch_q *dsq, u64 reenq_flag
 		task_rq = task_rq(p);
 
 		if (locked_rq != task_rq) {
-			if (locked_rq)
+			if (locked_rq) {
+				scx_rq_lock_drop(locked_rq);
 				raw_spin_rq_unlock(locked_rq);
+			}
 			if (unlikely(!raw_spin_rq_trylock(task_rq))) {
 				raw_spin_unlock(&dsq->lock);
 				raw_spin_rq_lock(task_rq);
@@ -4307,6 +4328,7 @@ static void reenq_user(struct rq *rq, struct scx_dispatch_q *dsq, u64 reenq_flag
 		p->scx.flags &= ~SCX_TASK_REENQ_REASON_MASK;
 
 		if (!(++nr_enqueued % SCX_TASK_ITER_BATCH)) {
+			scx_rq_lock_drop(locked_rq);
 			raw_spin_rq_unlock(locked_rq);
 			locked_rq = NULL;
 			cpu_relax();
@@ -4319,8 +4341,10 @@ static void reenq_user(struct rq *rq, struct scx_dispatch_q *dsq, u64 reenq_flag
 	raw_spin_unlock(&dsq->lock);
 
 	if (locked_rq != rq) {
-		if (locked_rq)
+		if (locked_rq) {
+			scx_rq_lock_drop(locked_rq);
 			raw_spin_rq_unlock(locked_rq);
+		}
 		raw_spin_rq_lock(rq);
 	}
 }
@@ -5372,6 +5396,7 @@ static u32 bypass_lb_cpu(struct scx_sched *sch, s32 donor,
 		if (!(nr_balanced % SCX_BYPASS_LB_BATCH) && n) {
 			list_move_tail(&cursor.node, &n->scx.dsq_list.node);
 			raw_spin_unlock(&donor_dsq->lock);
+			scx_rq_lock_drop(donor_rq);
 			raw_spin_rq_unlock_irq(donor_rq);
 			cpu_relax();
 			raw_spin_rq_lock_irq(donor_rq);
@@ -5382,6 +5407,7 @@ static u32 bypass_lb_cpu(struct scx_sched *sch, s32 donor,
 
 	list_del_init(&cursor.node);
 	raw_spin_unlock(&donor_dsq->lock);
+	scx_rq_lock_drop(donor_rq);
 	raw_spin_rq_unlock_irq(donor_rq);
 
 	return nr_balanced;
@@ -5672,6 +5698,7 @@ static void scx_bypass(struct scx_sched *sch, bool bypass)
 		 * sees scx_bypassing() before moving tasks to SCX.
 		 */
 		if (!scx_enabled()) {
+			scx_rq_lock_drop(rq);
 			raw_spin_rq_unlock(rq);
 			continue;
 		}
@@ -5698,6 +5725,7 @@ static void scx_bypass(struct scx_sched *sch, bool bypass)
 		if (cpu_online(cpu) || cpu == smp_processor_id())
 			resched_curr(rq);
 
+		scx_rq_lock_drop(rq);
 		raw_spin_rq_unlock(rq);
 	}
 
@@ -8425,6 +8453,7 @@ static bool kick_one_cpu(s32 cpu, struct rq *this_rq, unsigned long *ksyncs)
 		cpumask_clear_cpu(cpu, this_scx->cpus_to_wait);
 	}
 
+	scx_rq_lock_drop(rq);
 	raw_spin_rq_unlock_irqrestore(rq, flags);
 
 	return should_wait;
@@ -8441,6 +8470,7 @@ static void kick_one_cpu_if_idle(s32 cpu, struct rq *this_rq)
 	    (cpu_online(cpu) || cpu == cpu_of(this_rq)))
 		resched_curr(rq);
 
+	scx_rq_lock_drop(rq);
 	raw_spin_rq_unlock_irqrestore(rq, flags);
 }
 
@@ -8478,6 +8508,7 @@ static void kick_cpus_irq_workfn(struct irq_work *irq_work)
 		raw_spin_rq_lock(this_rq);
 		this_scx->kick_sync_pending = true;
 		resched_curr(this_rq);
+		scx_rq_lock_drop(this_rq);
 		raw_spin_rq_unlock(this_rq);
 	}
 }
@@ -8969,6 +9000,7 @@ static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
 		if (locked_rq != p_rq)
 			switch_rq_lock(p_rq, locked_rq);
 	} else {
+		scx_rq_lock_drop(p_rq);
 		raw_spin_rq_unlock_irqrestore(p_rq, flags);
 	}
 
@@ -9448,9 +9480,11 @@ static void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags)
 
 		if (raw_spin_rq_trylock(target_rq)) {
 			if (can_skip_idle_kick(target_rq)) {
+				scx_rq_lock_drop(target_rq);
 				raw_spin_rq_unlock(target_rq);
 				goto out;
 			}
+			scx_rq_lock_drop(target_rq);
 			raw_spin_rq_unlock(target_rq);
 		}
 		cpumask_set_cpu(cpu, this_rq->scx.cpus_to_kick_if_idle);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 14c2df6fd9af..f76e6f7f4a01 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -803,6 +803,9 @@ struct scx_rq {
 	bool			cpu_released;
 	u32			flags;
 	u32			nr_immed;		/* ENQ_IMMED tasks on local_dsq */
+#ifdef CONFIG_SCHED_CORE
+	u32			lock_drop_seq;	/* nr dispatch lock releases */
+#endif
 	u64			clock;			/* current per-rq clock -- see scx_bpf_now() */
 	cpumask_var_t		cpus_to_kick;
 	cpumask_var_t		cpus_to_kick_if_idle;
-- 
2.55.0

