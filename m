Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1647D53977D
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 15:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791906824; cv=none; b=gHcZXl+TuMwdCBymRjLDgD9YVpSFx4i1Xt6UFy12d6NHyWyG4fWOE2ud+Nz1HmCyXAygg5RjXj+DeMTE2qBGOaYWM3fJtp4MTt3wR4KI+6E6uu8PPkKuOc4v17NGVK5ujgcoK4o3pKPkoGHtYGN2zUQM5P/XLAzzmI/rNLS+PpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791906824; c=relaxed/simple;
	bh=B+ljOHc9MowV7FQmRx/TPICRmr/qOAR29KNV5XWCKV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=klPh+NwWYBHEJUNehgfeAQesyM4DJxk4l7h5KAmOO8yWfFhypYULiHW9kIbG8b5n4tUL3ONnYEWkxrv35+cxCwrPDADFnmo9dt1xoPm2/phoyE0CttI5sorTjWCYL3qf0+xvZSbuH1Mc4oAFtoIsEPAIGlSrhvo494PTfqDsITU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lOU4JyIS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lOU4JyIS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD581F000FF;
	Tue, 13 Oct 2026 15:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791906822;
	bh=+GEkJS9u+6mJvk31QZ8YtEKff8mq+y1yGi23TVBjIl4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lOU4JyISU/6lW9Suu15uEnatWag2s8QzZhy4+L0jmRKj7GPH0IWFPhbuYw78DNeC9
	 ABCYOzTsWH2dTDD0xXK+WFHbJwejSQcKghO2Ryp5qLftwcDDv9Az/0FBRMn3v7yxxY
	 /SkAEK8PHgdamheW4j8tWI+IfLuXJpZxOfilDCnpRwG5pRfff2zQqOlbtdkxYuF6lS
	 CDyYmuDOp9wI3EZucOA9/CeVf8GuO2RcRka4+2UPQLddejy0dPJINZ8ae+k6W/2hWa
	 FdSEgNE6gws94dlR0sd4yx8CQ9mIUzHvlN8yZZ2/xg5j7U4AF+fTqs+AKmQJxROPUM
	 oBMzB4r57diEg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Alap Mohan <mohaalap@meta.com>,
	Joonwoo Park <joonwoo@meta.com>,
	Andrea Righi <arighi@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] sched_ext: Fix CPU hotplug hang when a dying CPU's tasks sit in the BPF scheduler
Date: Tue, 13 Oct 2026 11:53:40 -0400
Message-ID: <20261013155312.314110-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101226-devotion-reassure-71fa@gregkh>
References: <2026101226-devotion-reassure-71fa@gregkh>
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
[ sashal: Replaced guard(sched_change) with the existing sched_deq_and_put_task() and sched_enq_and_set_task() helper pair. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/ext.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 40dbdfed42c9a..93f6ed05f6952 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2102,8 +2102,8 @@ static void set_task_runnable(struct rq *rq, struct task_struct *p)
 	}
 
 	/*
-	 * list_add_tail() must be used. scx_ops_bypass() depends on tasks being
-	 * appened to the runnable_list.
+	 * list_add_tail() must be used. scx_ops_bypass() and rq_offline_scx()
+	 * depend on tasks being appended to the runnable_list.
 	 */
 	list_add_tail(&p->scx.runnable_node, &rq->scx.runnable_list);
 }
@@ -2812,7 +2812,14 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 	if (consume_global_dsq(rq))
 		goto has_tasks;
 
-	if (!SCX_HAS_OP(dispatch) || scx_rq_bypassing(rq) || !scx_rq_online(rq))
+	/*
+	 * scx_rq_online() can't be used. Its cpu_active() test goes false
+	 * before CPU hotplug waits for an RCU grace period, and
+	 * rq_offline_scx() moves this CPU's tasks to the local DSQ only after
+	 * the wait. The grace period can depend on those tasks running.
+	 */
+	if (!SCX_HAS_OP(dispatch) || scx_rq_bypassing(rq) ||
+	    !(rq->scx.flags & SCX_RQ_ONLINE))
 		goto no_tasks;
 
 	dspc->rq = rq;
@@ -3503,7 +3510,27 @@ static void rq_online_scx(struct rq *rq)
 
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
+		struct sched_enq_and_set_ctx ctx;
+
+		if (p->scx.dsq == &rq->scx.local_dsq)
+			continue;
+		sched_deq_and_put_task(p, DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK, &ctx);
+		sched_enq_and_set_task(&ctx);
+	}
 }
 
 #else	/* CONFIG_SMP */
-- 
2.53.0

