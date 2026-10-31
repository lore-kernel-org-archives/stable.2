Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793464085;
	b=QDpElFZsrHIaYjVNcU1zcDZkYWXr65ieaAVtb7Xfhsxr9nklsCrDjUm+56ZkA1haDWnS
	 X5aHaHENuMfV2t+gKFNkUzyBFcgqtf4Euj0PnuTGnayV3PpLgK57PRqfDvjFKU0Uws6Ca
	 7rM4shFqcAoSHid5d/r/6LTx0Jru7CrSICxl3uleNRiOGhGwcvd+XlYnGYxRkE/nae2rE
	 zj3/jP00f/Wp1gPnDhsE06uCItWbnjvEd/fsA0yW/MAV9znQ4mNaQZYflhxAADebfyDRI
	 6VvowK6j3WuDt7+8Qo8zVK/bQ5rdyjuxLoC2Cgp4wqGA6jCDpfSr2GDuvSvYcpqOWeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793464085;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=+aSFrhS77OpQkAXxyRyCw3+whU1yrhy7PcBz3aVmZN4=;
	b=Dh7u566/d17z0zD/BVcLCsGlsSvgCKTkbG4oG1AiVihKc3fpIm1ziyCcE4op3CTdXymo
	 0jRmNvw4LOkMMdDMbJOr0/KDelLK/16xpugcvVfjRpoaskWEnuJa+rQab2zoBlaVKlO7V
	 txrHrH92rkMOpHHe7/w0kP9C80S+yjHyxLJT7XMTpTblPPW1udodOkCn+BIX/xJIxyCFt
	 qg5F8qHtEw5knUD27iIP7GhUenbgkn/Zzv9MGETbJ2FATPOFCsEQo7Sm7NyUfwzB/q3wk
	 2T7bdPar8c8SRHxGY9K+KCgvcpLnTU/EjRW8M5TTUpzxQ2/3HYL85BXdsV1e/mN4E4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Bw/1i9gd";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F91606A31A;
	Sat, 31 Oct 2026 16:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bw/1i9gd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E45B1F000C1;
	Sat, 31 Oct 2026 16:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793464084;
	bh=+aSFrhS77OpQkAXxyRyCw3+whU1yrhy7PcBz3aVmZN4=;
	h=From:To:Cc:Subject:Date;
	b=Bw/1i9gda32yp1ywc6B37CiIP6CDzcRqqDj9BN0v6dYRL4e3S9NrYPDW9HsEIL29y
	 s7+6IpH57kS9KNW2iVfAQZyBxtFjkA3OeBXUciT7G4ds5s8YNv/OrqZX7sK7iAnaaw
	 Xk4SYtxUyP9OBME2jFWtLfIM+7uB7WY+nLV/Qd7/kdXYAQ3TPPjj1AT3cUR2eKg+5Q
	 Iqf/CiBPL+a2g0gXHtYTQpNlug2p2KwDFZmSiJpiAsNOxeDM45fIvki9b4KGv/jK8X
	 oU4Epn38LPZaN7M2GhOrhVbQ0qFiwq6g55cXUSvP7HKyjoHIkKpriinOQcySb+bzeY
	 syHjwiqNGdGsw==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v4 sched_ext/for-7.4-fixes] sched_ext: Fix stale pick when the donor changes during dispatch
Date: Sat, 31 Oct 2026 06:28:03 -1000
Message-ID: <20261031162803.541236-1-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
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

Dispatch takes rq->donor as @prev and can drop the rq lock. With proxy
execution, @prev may not be the running task, and another CPU can reset the
donor to rq->curr meanwhile, through proxy_needs_return() on a wakeup or
sched_proxy_block_task() on a class or scheduler change. The wakeup case:

1. dispatch_one() drops the rq lock, e.g. to move a task from another CPU.
2. Another CPU wakes the donor, which proxy execution migrated to this CPU.
   proxy_needs_return() dequeues it and resets the donor to rq->curr, and
   the wakeup enqueues it, possibly on another CPU.
3. dispatch_one() sees @prev queued and returns SCX_DSP_PREV.
4. do_pick_task_scx() returns @prev, and this CPU runs a task that is queued
   on another rq.

Under core scheduling, the core pick runs dispatch for the sibling rqs with
each sibling's donor as @prev, and a sibling can switch @prev out while
dispatch has the lock dropped.

Whatever dispatch concluded, and whatever it does with @prev after the drop,
is about a task the rq no longer owns, whether it keeps @prev running or
hands it to ops.dispatch().

rq_modified_above() catches the change only when rq->curr is in a class
above ext, and the dl_server pick skips that check. dispatch_core_pick()
retries after a lock drop, but by then dispatch has used @prev.

Restart the pick when @prev is no longer the donor. dispatch_one() tests
after each step that can drop the lock, and scx_dispatch_sched() decides per
ops.dispatch() call whether to hand @prev over, which also covers a class or
scheduler change across a drop.

With proxy execution alone, the donor only ever changes to rq->curr during a
pick, so the retried pick can't go stale again. Under core scheduling, the
restart goes through the core pick, which already retries after any lock
drop.

7a3a6bfbd62a ("sched: Rework prev_balance() to avoid stale prev references")
closed the same window in prev_balance() by reading rq->donor instead of
taking @prev. That doesn't work here, as dispatch never evaluated the new
donor, which may not even be a sched_ext task.

Verified with synthetic reproducers for both cases.

v2: Also cover rq lock drops inside dispatch (sashiko).

v3: Don't keep a stale @prev after ops.dispatch() (sashiko).

v4: Also cover a sibling switching @prev out under core scheduling. Retitle.

Fixes: 7b0888b7cc19 ("sched_ext: Implement core-sched support")
Fixes: c6fe97c34a1a ("sched: Allow enabling proxy exec with sched_ext")
Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c     | 10 ++++++++++
 kernel/sched/ext/inlines.h | 37 +++++++++++++++++++++++++++++++++----
 2 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index cd923f9f1f2a..e533c1a5c56d 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -3407,6 +3407,12 @@ static enum scx_dsp_verdict dispatch_one(struct rq *rq, struct task_struct *prev
 		rq->scx.cpu_released = false;
 	}
 
+	/* the ecaps sync may have dropped the rq lock */
+	if (scx_dsp_prev_stale(rq, prev)) {
+		verdict = SCX_DSP_RETRY;
+		goto has_tasks;
+	}
+
 	if (prev->sched_class == &ext_sched_class) {
 		update_curr_scx(rq);
 
@@ -3449,6 +3455,10 @@ static enum scx_dsp_verdict dispatch_one(struct rq *rq, struct task_struct *prev
 	}
 
 	verdict = scx_dispatch_sched(root_sch, rq, prev, false);
+
+	/* scx_dispatch_sched() may have dropped the rq lock */
+	if (scx_dsp_prev_stale(rq, prev))
+		verdict = SCX_DSP_RETRY;
 	if (verdict != SCX_DSP_NONE)
 		goto has_tasks;
 
diff --git a/kernel/sched/ext/inlines.h b/kernel/sched/ext/inlines.h
index 1e39d12678c4..5dce394e0813 100644
--- a/kernel/sched/ext/inlines.h
+++ b/kernel/sched/ext/inlines.h
@@ -18,9 +18,32 @@ enum scx_dsp_verdict {
 	SCX_DSP_NONE,		/* nothing to run */
 	SCX_DSP_LOCAL,		/* local DSQ has tasks */
 	SCX_DSP_PREV,		/* keep running @prev */
-	SCX_DSP_RETRY,		/* pick helpers only: restart the pick */
+	SCX_DSP_RETRY,		/* restart the pick */
 };
 
+/**
+ * scx_dsp_prev_stale - Test whether dispatch's @prev went stale
+ * @rq: rq being dispatched for
+ * @prev: @rq's donor when dispatch started
+ *
+ * @prev can stop being @rq's donor while dispatch has the rq lock dropped. With
+ * proxy execution, @prev may not be the running task, and another CPU can reset
+ * the donor to rq->curr. With core scheduling, the core pick runs dispatch for
+ * the sibling rqs too, and a sibling can switch @prev out. Dispatch restarts
+ * the pick when that happened and doesn't hand the old donor to the BPF
+ * scheduler.
+ *
+ * With proxy execution alone, the donor only ever changes to rq->curr during a
+ * pick. Only __schedule() on this CPU sets a different donor, after the pick,
+ * so the restarted pick takes rq->curr as @prev and can't go stale again. Under
+ * core scheduling, the restart goes through the core pick, which already
+ * retries whenever dispatch dropped the lock.
+ */
+static inline bool scx_dsp_prev_stale(struct rq *rq, struct task_struct *prev)
+{
+	return (sched_proxy_exec() || sched_core_enabled(rq)) && unlikely(prev != rq->donor);
+}
+
 /*
  * One user of this function is scx_bpf_sub_dispatch() which can be called
  * recursively as sub-sched dispatches nest. Always inline to reduce stack usage
@@ -33,8 +56,7 @@ scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
 	struct scx_dsp_ctx *dspc = &this_cpu_ptr(sch->pcpu)->dsp_ctx;
 	int nr_loops = SCX_DSP_MAX_LOOPS;
 	s32 cpu = cpu_of(rq);
-	bool prev_on_sch = (prev->sched_class == &ext_sched_class) &&
-		scx_task_on_sched(sch, prev);
+	bool prev_on_sch;
 
 	if (scx_consume_global_dsq(sch, rq))
 		return SCX_DSP_LOCAL;
@@ -106,6 +128,11 @@ scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
 			rq->scx.sub_dispatch_prev = prev;
 #endif
 
+		/* the dispatch so far may have dropped the rq lock */
+		prev_on_sch = !scx_dsp_prev_stale(rq, prev) &&
+			      prev->sched_class == &ext_sched_class &&
+			      scx_task_on_sched(sch, prev);
+
 		SCX_CALL_OP(sch, dispatch, rq, scx_cpu_arg(cpu),
 			    prev_on_sch ? prev : NULL);
 
@@ -116,7 +143,9 @@ scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
 
 		scx_flush_dispatch_buf(sch, rq);
 
-		if ((prev->scx.flags & SCX_TASK_QUEUED) && prev->scx.slice)
+		/* ops.dispatch() and the flush may have dropped the rq lock */
+		if (!scx_dsp_prev_stale(rq, prev) &&
+		    (prev->scx.flags & SCX_TASK_QUEUED) && prev->scx.slice)
 			return SCX_DSP_PREV;
 		if (rq->scx.local_dsq.nr)
 			return SCX_DSP_LOCAL;
-- 
2.56.0

