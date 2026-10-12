Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEEA492E3F
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791818731; cv=none; b=L+BuvRjHKJXYjxCBYOW92n00z7IM5cIzEejKzToBQHUpn5Ap2a/HFxIxmgsLWwu6L+e0ZrbBFwkaxsB7bB6FTGoskRClWxCP8JYnDj3JSI5UFUvaje0SlAE0yPRy6FZC3NDvewf9b+O2G94rMRGZhiHr+5zEf3Wpixw7FAZGKWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791818731; c=relaxed/simple;
	bh=uCVeqeWGpIKFkb1yB7X5XfB9BSGG3wiLiyiBdQdwZ+A=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GO0iIx3hiAZ/oeBXUNmmwhhNfuc4MnF0O4NoGT75fDOSt7QM4eWqDISIpFGtvr6Tsp6i2U1Tzv4nKL905avVxrYkurJGlsPRDvGteF8VvEtQvROSGl469c+7+hz8VgKsapkzQvKKctSwBtsBwCWY8KgNv5zMrhBSwRIq3Z1qBDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ef5Z9+wK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ef5Z9+wK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70E041F0089C;
	Mon, 12 Oct 2026 15:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791818728;
	bh=rYLyNx8CkHuJEdK6fc2CJZEnSawV4RjNhI7zvZxDYGA=;
	h=Subject:To:Cc:From:Date;
	b=Ef5Z9+wKrnOZQ/Oh7Q8ojE8ysLtfXMlAVXHddxxgQPhPBgFA7v9S7cxjy5jpBtrW1
	 cQHEX0RhTVLSdlyOj+oAG6C5Q70DROVXlCV0vJUo/c7YbMuxfWSgY/L1CSBlJoF3+5
	 8L5YPuhbkMO5IegWVWoFh2rI1twRihUB16rTHh4k=
Subject: FAILED: patch "[PATCH] sched_ext: Fix CPU hotplug hang when a dying CPU's tasks sit" failed to apply to 6.18-stable tree
To: tj@kernel.org,arighi@nvidia.com,joonwoo@meta.com,mohaalap@meta.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Oct 2026 17:25:25 +0200
Message-ID: <2026101225-creatable-valuables-8145@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x d35a535d3e3e71f92a051d94e415f43612c4edfc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101225-creatable-valuables-8145@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d35a535d3e3e71f92a051d94e415f43612c4edfc Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Wed, 23 Sep 2026 12:39:20 -1000
Subject: [PATCH] sched_ext: Fix CPU hotplug hang when a dying CPU's tasks sit
 in the BPF scheduler

A CPU going down has to empty its own rq. Its hotplug thread waits in
sched_cpu_wait_empty() until nothing else is left, and the only thing that
wakes it is balance_push(), which runs from __schedule() on the dying CPU
and pushes off the migratable tasks the CPU picks.

sched_ext breaks this. A task sitting on a user DSQ or held by the BPF
scheduler is still counted on its rq, but an inactive CPU no longer calls
ops.dispatch() and can't pull the task back. The dying CPU goes idle with
the task still counted, and one of two things happens:

- Another CPU consumes the task. The rq empties without a __schedule() on
  the dying CPU, so the hotplug thread is never woken and cpu_down() hangs
  holding cpu_hotplug_lock.
- The task is affine only to the dying CPU. Nothing can move it, and the
  offline stalls until the watchdog ejects the BPF scheduler.

When the rq goes offline, re-enqueue every task on it that isn't already on
the local DSQ. An enqueue on an offline rq lands on the local DSQ, so the
dying CPU itself picks the tasks and balance_push() pushes them off, the
same as for the other sched classes. From then on no sched_ext path on
another CPU can pull a task off the rq.

ops.dispatch() currently stops as soon as the CPU goes inactive, and CPU
hotplug then waits for an RCU grace period before taking the rq offline. A
BPF-held task affine only to the dying CPU and preempted inside an RCU
read-side critical section would block that grace period, and the rq would
never go offline. Test SCX_RQ_ONLINE directly so that ops.dispatch() keeps
running until the rq goes offline. Only the dying CPU's own hotplug thread
clears the flag during teardown, and task_can_run_on_remote_rq() still keeps
other rqs' tasks off the CPU.

Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class")
Fixes: 991ef53a4832 ("sched_ext: Make scx_rq_online() also test cpu_active() in addition to SCX_RQ_ONLINE")
Cc: stable@vger.kernel.org # v6.12+
Reported-by: Alap Mohan <mohaalap@meta.com>
Reported-by: Joonwoo Park <joonwoo@meta.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Andrea Righi <arighi@nvidia.com>

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index ad391a8cbd05..493b7aac7087 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2123,8 +2123,8 @@ static void set_task_runnable(struct rq *rq, struct task_struct *p)
 	}
 
 	/*
-	 * list_add_tail() must be used. scx_bypass() depends on tasks being
-	 * appended to the runnable_list.
+	 * list_add_tail() must be used. scx_bypass() and rq_offline_scx()
+	 * depend on tasks being appended to the runnable_list.
 	 */
 	list_add_tail(&p->scx.runnable_node, &rq->scx.runnable_list);
 
@@ -3731,8 +3731,26 @@ static void rq_online_scx(struct rq *rq)
 
 static void rq_offline_scx(struct rq *rq)
 {
+	struct task_struct *p, *n;
+
 	rq->scx.flags &= ~SCX_RQ_ONLINE;
+
+	/* sched domain rebuilds call rq_offline with the CPU staying alive */
+	if (cpu_active(cpu_of(rq)))
+		return;
+
 	scx_rescue_flush(rq);
+
+	/*
+	 * An offline CPU no longer calls ops.dispatch(). Re-enqueue its tasks
+	 * onto the local DSQ so that they run here and balance_push() moves
+	 * them off.
+	 */
+	list_for_each_entry_safe_reverse(p, n, &rq->scx.runnable_list, scx.runnable_node) {
+		if (p->scx.dsq == &rq->scx.local_dsq)
+			continue;
+		guard(sched_change)(p, DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK);
+	}
 }
 
 static bool check_rq_for_timeouts(struct rq *rq)
diff --git a/kernel/sched/ext/inlines.h b/kernel/sched/ext/inlines.h
index 2ff5479334cb..8de9d8fb4b25 100644
--- a/kernel/sched/ext/inlines.h
+++ b/kernel/sched/ext/inlines.h
@@ -70,7 +70,13 @@ scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
 #endif	/* CONFIG_EXT_SUB_SCHED */
 	}
 
-	if (unlikely(!SCX_HAS_OP(sch, dispatch)) || !scx_rq_online(rq))
+	/*
+	 * scx_rq_online() can't be used. Its cpu_active() test goes false
+	 * before CPU hotplug waits for an RCU grace period, and
+	 * rq_offline_scx() moves this CPU's tasks to the local DSQ only after
+	 * the wait. The grace period can depend on those tasks running.
+	 */
+	if (unlikely(!SCX_HAS_OP(sch, dispatch)) || !(rq->scx.flags & SCX_RQ_ONLINE))
 		return SCX_DSP_NONE;
 
 	dspc->rq = rq;
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 3036190b0662..c9b44ab3bd0a 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -585,10 +585,6 @@ void scx_rescue_flush(struct rq *rq)
 
 	lockdep_assert_rq_held(rq);
 
-	/* sched domain rebuilds call rq_offline with the CPU staying alive */
-	if (cpu_active(cpu_of(rq)))
-		return;
-
 	/* end the current rescue */
 	if (rq->scx.rescue.curr)
 		scx_task_slice_ended(rq, rq->scx.rescue.curr);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 7701a5a60972..742cce9da4e9 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -4205,8 +4205,9 @@ extern void balance_callbacks(struct rq *rq, struct balance_callback *head);
  * after which it is enqueued again.
  *
  * Typically this must be called while holding task_rq_lock, since most/all
- * properties are serialized under those locks. There is currently one
- * exception to this rule in sched/ext which only holds rq->lock.
+ * properties are serialized under those locks. There are currently two
+ * exceptions to this rule in sched/ext which only hold rq->lock: scx_bypass()
+ * and rq_offline_scx().
  */
 
 /*

