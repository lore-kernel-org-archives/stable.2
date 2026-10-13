Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8D14FE2F1
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 15:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791904828; cv=none; b=hpI12vElUHmzGB2n/lBRqARlqN3ZHmFwzOcsUoc2v66uutCttDrDh03xF4hKZBhoRYtuYPVSf33t1pIpAZimeRxai5PGzyLC79y94Mx9T+A1D+8jVDfXPPmcsan4zTQsb5wjHsdECEEh58XqURJ3eWhYKnR2JP0b/o3oek7FP70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791904828; c=relaxed/simple;
	bh=+T8rFbXfa6KiN6iZXTSR1+oqUWoJn3/gG2djQDa7JJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fd1DXlpWVv1XMllZEX+G9LaPkkJmvSQgbgtK0KPNFT7ocPANyE3URgkm3UOyTpdveTGGXoC3dTyVCQkQ7tt5VgYt5Ik/u+u8bN0Lx5hhhYFQ+mChkGAPzCAGmwZkbhnUOBPr7etkrFT/WynC+5VSGcRO9rBuqyWR4DJd2+AyyrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RIjl+1nz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RIjl+1nz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A915C1F0089E;
	Tue, 13 Oct 2026 15:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791904826;
	bh=nAMHyf2WN4/3+yEYcHNrUlW/z8RlewmwboNeN4vNcr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RIjl+1nz9BzZzv6Eb8Y+nEnk9l6P5KmCKr0zEoke70mTGP9mxk99gz0ABcvdts0bl
	 6idKysdWPyvxf8FuMXdBlO8JYuhon+cFYEhSm4crZ9w9E8Maf+BdzXpdQFe5q2BJLd
	 G/YWP3U9+NWVHeqTD5hM25HQDKeC2k509iJSBHJtpU0WBUSyAdHmvHQDtLstFuDm/1
	 OWrLDvK8oYs/80/1aTTV3qq2cfRm+HLYr6Nzj1b00U2QmiTeeMFIRivLtO19CoFOcr
	 En85ahsIPRa+J+Ibyf8iCLEToPBr+JRpZUkd8sGZPPgBWB1XdNqOSgLoy+4/Ui28Vn
	 ok4rIoz3Xr32A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Alap Mohan <mohaalap@meta.com>,
	Joonwoo Park <joonwoo@meta.com>,
	Andrea Righi <arighi@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y] sched_ext: Fix CPU hotplug hang when a dying CPU's tasks sit in the BPF scheduler
Date: Tue, 13 Oct 2026 11:20:24 -0400
Message-ID: <20261013152005.130065-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101224-counting-undrafted-69cb@gregkh>
References: <2026101224-counting-undrafted-69cb@gregkh>
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
[ sashal: Omitted rescue-related changes because the rescue machinery is absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/ext/ext.c | 29 ++++++++++++++++++++++++++---
 kernel/sched/sched.h   |  5 +++--
 2 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index a9f33e2b17ace..8d4992e7e0120 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2031,8 +2031,8 @@ static void set_task_runnable(struct rq *rq, struct task_struct *p)
 	}
 
 	/*
-	 * list_add_tail() must be used. scx_bypass() depends on tasks being
-	 * appended to the runnable_list.
+	 * list_add_tail() must be used. scx_bypass() and rq_offline_scx()
+	 * depend on tasks being appended to the runnable_list.
 	 */
 	list_add_tail(&p->scx.runnable_node, &rq->scx.runnable_list);
 }
@@ -2868,7 +2868,13 @@ scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
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
@@ -3608,7 +3614,24 @@ static void rq_online_scx(struct rq *rq)
 
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
 
 static bool check_rq_for_timeouts(struct rq *rq)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a6c6f8165eecc..d25defb116caa 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -4185,8 +4185,9 @@ extern void balance_callbacks(struct rq *rq, struct balance_callback *head);
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

