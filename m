Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF62151CF64
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 15:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791905754; cv=none; b=forok6xGnwc4rplTk37YTy8G/CJVdfJBokBxyTqzmK21883CQcJ/j4goLr+P3NZjRM+Jx46feR4Vho/mKpUUI9ei9CVO0P5ssAGa3UUweW91wIFiMkcotpLX2e/XIfDkdiIdjreDhJnpwAIYswEThxJknLkVx9SputIFDUjCgS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791905754; c=relaxed/simple;
	bh=fFYoYYBevsvltgEPak0rKwBMnnZ5F8+H3EmVi0ycwiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cBSUOGGMw3X+w0sukmCeGN9De+phn1nPkjQXCX4RljR89c4+hH6os8Uca/OhBXgfa+Wcz6hrUFQpF7ts0IysYgjTjTh6AFBeKe31ev7EXEzztVaxfx/L1H1RsyMko2CNSUXa56KftlMNKQoC+fHnuvlmow44W60XCVhjpoY1YoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=col99qqM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="col99qqM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A108B1F000FF;
	Tue, 13 Oct 2026 15:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791905753;
	bh=5oEqYtftSczgbg3VsHAshO2oEFKQu1NbUqw8Eeik1Ek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=col99qqMHRh93hbEd0VYB35BiYajq3hO1/EFY3YtmHw5/kyCutvTmjRjeYuo2coUE
	 RdUEigtZ866t1GNM0pROuwrAHzDTuMQlbJKG+MiIZ8RUiEbsru1KGl0g90fTxV3L21
	 0h+GGm/Fd5IIZachlSTijqTFkoXIbaZpNxsukWcaIIwirQtP+SAXoAVEjCyC1sgAMt
	 SDd//0xoWAlMVFfE8WnoTG3RkjpOh4bHYlxLNnKicTb7kin198v9I7c5Qj4gz3CoDl
	 84e2a0CdORW+syOmXEu8oYTh04OgvK6+Q6p5B/szY/kNZ/VDfGG3JgO8YBEzP0Qys4
	 maxyNgqIXEMsQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Alap Mohan <mohaalap@meta.com>,
	Joonwoo Park <joonwoo@meta.com>,
	Andrea Righi <arighi@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] sched_ext: Fix CPU hotplug hang when a dying CPU's tasks sit in the BPF scheduler
Date: Tue, 13 Oct 2026 11:35:51 -0400
Message-ID: <20261013153529.244183-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101225-creatable-valuables-8145@gregkh>
References: <2026101225-creatable-valuables-8145@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tejun Heo <tj@kernel.org>

[ Upstream commit d35a535d3e3e71f92a051d94e415f43612c4edfc ]

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
[ sashal: adapted scx_dispatch_sched() changes to balance_one() in the unsplit sched_ext implementation. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/ext.c   | 29 ++++++++++++++++++++++++++---
 kernel/sched/sched.h |  5 +++--
 2 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 059675018c718..8dfacec6c7b30 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1363,8 +1363,8 @@ static void set_task_runnable(struct rq *rq, struct task_struct *p)
 	}
 
 	/*
-	 * list_add_tail() must be used. scx_bypass() depends on tasks being
-	 * appended to the runnable_list.
+	 * list_add_tail() must be used. scx_bypass() and rq_offline_scx()
+	 * depend on tasks being appended to the runnable_list.
 	 */
 	list_add_tail(&p->scx.runnable_node, &rq->scx.runnable_list);
 }
@@ -2141,8 +2141,14 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 	if (consume_global_dsq(sch, rq))
 		goto has_tasks;
 
+	/*
+	 * scx_rq_online() can't be used. Its cpu_active() test goes false
+	 * before CPU hotplug waits for an RCU grace period, and
+	 * rq_offline_scx() moves this CPU's tasks to the local DSQ only after
+	 * the wait. The grace period can depend on those tasks running.
+	 */
 	if (unlikely(!SCX_HAS_OP(sch, dispatch)) ||
-	    scx_rq_bypassing(rq) || !scx_rq_online(rq))
+	    scx_rq_bypassing(rq) || !(rq->scx.flags & SCX_RQ_ONLINE))
 		goto no_tasks;
 
 	dspc->rq = rq;
@@ -2671,7 +2677,24 @@ static void rq_online_scx(struct rq *rq)
 
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
 
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 97dddc148d711..5f3c85c672ac8 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3906,8 +3906,9 @@ extern void balance_callbacks(struct rq *rq, struct balance_callback *head);
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
-- 
2.53.0

