Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795603017;
	b=h3ucW8uPnATBoh/x2uLAdwy7m1uEfDwGEw6bTyJvZk/r/HgfAAWcfAXwKw1av84KVffN
	 dDheBGLHR8a0dSs+6/bUGqW8Ctn0a3CNwRebgh6wRuK8L/B5g/mgLd6JiKXgni6angtSo
	 tZ9tmCRuMl03ffoDMUJGyE8d4a+OPVmPtBvbT8gKOxf+pEUpZjhgT3y0qmQZhXOj1HoJl
	 WEBZM6aVF9Z8FKezVHP0u6LCl603IpbVU8cOGJwPAEswz3WB4vMpa2TLPRiToW+IjQ9EA
	 MeEeuwrbu/J+QbNhhBSYmUcTtg2A36dFaEUs1JEdlrg8Au7s3hSLLk3/wHIvSrgBHmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795603017;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=1eIq8aP/XFr9R0NPH7w6dUkMS82px5YQJtUJ+JolQvI=;
	b=UPntSnwdWLUaGiPDzvGurDucompPvlAzOLxlFI8hdCzfN4g3zNbUleGh3nUKSfcf9o7i
	 hHoL3f59f1O4tVjrh4y7dVd7AvTASFDLtQBRhzzahgXyDwBCiSgbFSJikj6rnPBXgVZHa
	 bMUIEIgdqonh3+DPwgsoS2AhHgabTEB4yX+MatpaZUBon7j7uNiWO2URZtoSMfdRmcxv7
	 e2EVJCcmZWBm+3n/yra710S/U1igCtIMgNNDcKDIM66izfzibS4ESDYVKiSws4GQN8H5u
	 2iPn0p7OlA9MZrGGevS4xM5NjPziyXJV8cIMdTKPUYZwzel+6Mua3rFUSe6157tXGQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=LYe1QFkP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A72606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=LYe1QFkP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24E051F000D2;
	Wed, 25 Nov 2026 10:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795603016;
	bh=1eIq8aP/XFr9R0NPH7w6dUkMS82px5YQJtUJ+JolQvI=;
	h=Subject:To:Cc:From:Date;
	b=LYe1QFkPwyfQ4j7NUJBEyaqpC5HgqWPeynd51f+G4rQN11OzYmZP/0dtBb0RwGVWb
	 VhTSLxjr88Sk34pwwaU3MPuoc962o2IN+nljBPZu2GPtLKTaH+8XfKuDKuWanDVpr9
	 okiq9rDLsa9ZgA1D3EoKEkayN0PdLQLFv6QHyO2E=
Subject: FAILED: patch "[PATCH] sched_ext: Fix stale pick when the donor changes during" failed to apply to 6.18-stable tree
To: tj@kernel.org,arighi@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:22:02 +0100
Message-ID: <2026112502-outboard-reload-fa22@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 9ce6fca02867911ba79bc3664219effe8c7be8f4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112502-outboard-reload-fa22@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9ce6fca02867911ba79bc3664219effe8c7be8f4 Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Sat, 31 Oct 2026 06:28:03 -1000
Subject: [PATCH] sched_ext: Fix stale pick when the donor changes during
 dispatch

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
Reviewed-by: Andrea Righi <arighi@nvidia.com>

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

