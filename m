Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795636025;
	b=PiqNZL6fqprHBslNAFGz3dwkmKD/mBn1JbuygjN/kYZXQBMpnFC+f67AxA16RtKHdm7P
	 p70yVs5Qv3gnM9zYcEtKyDSIj5iZbtRTOpTYBcxiLLtE1T2wSR7MX1fBQQBQWPnyEVfCx
	 Pih3VYf8H+IKHuwW2j74lgwlkokSkZYnQCJR0kvQGjFmOO1Z7iGWn4eSw7aHPKr0zujSQ
	 c0FoxJ6s8rSBuGbRa/drcd4uT9UxqA+MHzgvnT8qAeSbhA5ULtwWu36L+SXfk+AmyBIXU
	 9WdVlV+bCxEkvPkNtSWWGI5+hd2kLyPXGF2hq3xdziGq9DtU3KGTHuVngVfk3pusPHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795636025;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=kqAKDv/8K1e5Yc1gDXxHPwdQrFNAd8oErwKtUE5FYVY=;
	b=EZqQvTHVpN49w91lRs5UkVvW3NpaBC1Egwvj5zj7prDWzhc9jxMBHcp58tYZ3bIsew5F
	 IuLPC6HZ6KZ2jUe/BYyV57+Ty3LAi3YSavUweyLHIdP29yNvYGTrQ531AVR7DFkSXi4af
	 U5ZhiwvoVkTHrP71h+flsQq9dOxleE4+BKrwwSjb7+d1LN6vhbMuDf0+qprozvujBiu6b
	 6JQbfUehFCua9hy/lywl/+PAD230q26xdNl/ymjtTxcHRl0CHoNdcdpHmSyBp3qFez3ml
	 wlWM70J+feNRUI96R0qkfwgpICrUhZa/1MD8zdS3NswrCggtPKEtA3vAiKYcCd43OSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="H3w/pQeh";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1E9606A326
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 19:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H3w/pQeh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3FBC1F000D1;
	Wed, 25 Nov 2026 19:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795636025;
	bh=kqAKDv/8K1e5Yc1gDXxHPwdQrFNAd8oErwKtUE5FYVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H3w/pQehjzivzMHyPwO6uAg9Gdv6DZm5T3Q8nOt0sOoJyGEJu1ZoTatcpnMYrPDuY
	 m1WNRCeMXgtV2wqx0BvC2gRo4xrkea2LGmuapWhTIwHauYWt2dzqhHZ7IwEuG6iza7
	 TOzdqUb8wUaSAkXgEC3S0DUnTaGa6A2KmYKfgOFIDOyzS+bEXcZaq3K8cjKhzeqi3R
	 yStkW4KlNoGwo6rrrLkQIThsl6/o+DZVIZllJaJPk68ripB1d/qsAKbnhxZABSkpX8
	 nTRCAd+hJEe26tNgrtM+9eAvhBgybWWBDQbkzowCr5zStJdBe3hKDsqIqn5IOOb0n3
	 WGeYR0WDEUB9g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Andrea Righi <arighi@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] sched_ext: Fix ops.enqueue/dispatch() calls before ops.cpu_online()
Date: Wed, 25 Nov 2026 14:47:03 -0500
Message-ID: <20261125194630.1239202-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112526-mobster-foe-f1b5@gregkh>
References: <2026112526-mobster-foe-f1b5@gregkh>
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

From: Tejun Heo <tj@kernel.org>

[ Upstream commit 2227a34ff7bfcf6112931039e3554f4b70b65ab9 ]

ops.cpu_online() documents that the cpu doesn't call ops.enqueue() or
ops.dispatch() before that op. Both are gated on SCX_RQ_ONLINE, which
follows the core's rq online state through the ext class's rq_online and
rq_offline hooks. On a runtime cpu up, sched_cpu_activate() runs:

1. set_cpu_active() marks the cpu active.
2. cpuset_cpu_active() rebuilds the sched domains synchronously, and
   rq_attach_root() puts the rq online as the cpu is active now. The
   rq_online hook sets SCX_RQ_ONLINE.
3. scx_rq_activate() calls the root's ops.cpu_online().

Between 2 and 3, ops.enqueue() can be called for tasks woken or migrated
onto the cpu, and ops.dispatch() can run on it.

The hooks can't call the ops. They run under the rq lock with IRQs off while
the ops can be sleepable BPF programs, and handle_hotplug() needs the
rebuilt sched domains for its idle topology update.

Track SCX_RQ_ONLINE in handle_hotplug() alone. Set it right after the root's
ops.cpu_online(). Clear it and move the cpu's tasks to its local DSQ when
the cpu goes down. Sched domain rebuilds, which take a live cpu's rq offline
and online again, no longer touch the flag, so a remote dispatch can't see
it cleared by a rebuild and bounce to the global DSQ.

Between 2 and 3, tasks that land on the cpu now go to its local DSQ without
ops.enqueue(), and with sub-schedulers a task whose scheduler lacks caps on
the cpu is admitted anyway and counted in SCX_EV_SUB_FORCED_ADMIT. Both
already happen between 1 and 2.

Fixes: 60c27fb59f6c ("sched_ext: Implement sched_ext_ops.cpu_online/offline()")
Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
[ sashal: Inlined the drain loop into handle_hotplug() since drain_offline_rq() doesn't exist here, and dropped the sub-scheduler, ecaps and rescue-flush parts and the path split into ext/ files. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/ext.c   | 84 ++++++++++++++++++++++++--------------------
 kernel/sched/sched.h |  9 ++---
 2 files changed, 50 insertions(+), 43 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index b3a6d60709403..5fe3f4aaa16c7 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1244,11 +1244,11 @@ static void direct_dispatch(struct scx_sched *sch, struct task_struct *p,
 static bool scx_rq_online(struct rq *rq)
 {
 	/*
-	 * Test both cpu_active() and %SCX_RQ_ONLINE. %SCX_RQ_ONLINE indicates
-	 * the online state as seen from the BPF scheduler. cpu_active() test
-	 * guarantees that, if this function returns %true, %SCX_RQ_ONLINE will
-	 * stay set until the current scheduling operation is complete even if
-	 * we aren't locking @rq.
+	 * Test both cpu_active() and %SCX_RQ_ONLINE. %SCX_RQ_ONLINE is set
+	 * after the root's ops.cpu_online() and cleared when the cpu goes down.
+	 * cpu_active() test guarantees that, if this function returns %true,
+	 * %SCX_RQ_ONLINE will stay set until the current scheduling operation
+	 * is complete even if we aren't locking @rq.
 	 */
 	return likely((rq->scx.flags & SCX_RQ_ONLINE) && cpu_active(cpu_of(rq)));
 }
@@ -1369,7 +1369,7 @@ static void set_task_runnable(struct rq *rq, struct task_struct *p)
 	}
 
 	/*
-	 * list_add_tail() must be used. scx_bypass() and rq_offline_scx()
+	 * list_add_tail() must be used. scx_bypass() and handle_hotplug()
 	 * depend on tasks being appended to the runnable_list.
 	 */
 	list_add_tail(&p->scx.runnable_node, &rq->scx.runnable_list);
@@ -2154,7 +2154,7 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 	/*
 	 * scx_rq_online() can't be used. Its cpu_active() test goes false
 	 * before CPU hotplug waits for an RCU grace period, and
-	 * rq_offline_scx() moves this CPU's tasks to the local DSQ only after
+	 * handle_hotplug() moves this CPU's tasks to the local DSQ only after
 	 * the wait. The grace period can depend on those tasks running.
 	 */
 	if (unlikely(!SCX_HAS_OP(sch, dispatch)) ||
@@ -2655,6 +2655,25 @@ static void handle_hotplug(struct rq *rq, bool online)
 	struct scx_sched *sch = scx_root;
 	int cpu = cpu_of(rq);
 
+	if (!online) {
+		struct task_struct *p, *n;
+
+		guard(rq_lock_irqsave)(rq);
+		update_rq_clock(rq);
+		rq->scx.flags &= ~SCX_RQ_ONLINE;
+
+		/*
+		 * An offline CPU no longer calls ops.dispatch(). Re-enqueue its
+		 * tasks onto the local DSQ so that they run here and
+		 * balance_push() moves them off.
+		 */
+		list_for_each_entry_safe_reverse(p, n, &rq->scx.runnable_list, scx.runnable_node) {
+			if (p->scx.dsq == &rq->scx.local_dsq)
+				continue;
+			guard(sched_change)(p, DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK);
+		}
+	}
+
 	atomic_long_inc(&scx_hotplug_seq);
 
 	/*
@@ -2662,8 +2681,14 @@ static void handle_hotplug(struct rq *rq, bool online)
 	 * stable here. Note that we can't depend on scx_enabled() test as the
 	 * hotplug ops need to be enabled before __scx_enabled is set.
 	 */
-	if (unlikely(!sch))
+	if (unlikely(!sch)) {
+		/* no root to notify, set %SCX_RQ_ONLINE right away */
+		if (online) {
+			guard(rq_lock_irqsave)(rq);
+			rq->scx.flags |= SCX_RQ_ONLINE;
+		}
 		return;
+	}
 
 	if (scx_enabled())
 		scx_idle_update_selcpu_topology(&sch->ops);
@@ -2677,6 +2702,18 @@ static void handle_hotplug(struct rq *rq, bool online)
 			 SCX_ECODE_ACT_RESTART | SCX_ECODE_RSN_HOTPLUG,
 			 "cpu %d going %s, exiting scheduler", cpu,
 			 online ? "online" : "offline");
+
+	if (online) {
+		/*
+		 * The cpu must not call ops.enqueue() or ops.dispatch() before
+		 * the root's ops.cpu_online(). The core's rq online state can't
+		 * gate them, as the sched domain rebuild in
+		 * sched_cpu_activate() can put @rq online before this function
+		 * runs. Set %SCX_RQ_ONLINE here.
+		 */
+		guard(rq_lock_irqsave)(rq);
+		rq->scx.flags |= SCX_RQ_ONLINE;
+	}
 }
 
 void scx_rq_activate(struct rq *rq)
@@ -2689,34 +2726,6 @@ void scx_rq_deactivate(struct rq *rq)
 	handle_hotplug(rq, false);
 }
 
-static void rq_online_scx(struct rq *rq)
-{
-	rq->scx.flags |= SCX_RQ_ONLINE;
-}
-
-static void rq_offline_scx(struct rq *rq)
-{
-	struct task_struct *p, *n;
-
-	rq->scx.flags &= ~SCX_RQ_ONLINE;
-
-	/* sched domain rebuilds call rq_offline with the CPU staying alive */
-	if (cpu_active(cpu_of(rq)))
-		return;
-
-	/*
-	 * An offline CPU no longer calls ops.dispatch(). Re-enqueue its tasks
-	 * onto the local DSQ so that they run here and balance_push() moves
-	 * them off.
-	 */
-	list_for_each_entry_safe_reverse(p, n, &rq->scx.runnable_list, scx.runnable_node) {
-		if (p->scx.dsq == &rq->scx.local_dsq)
-			continue;
-		guard(sched_change)(p, DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK);
-	}
-}
-
-
 static bool check_rq_for_timeouts(struct rq *rq)
 {
 	struct scx_sched *sch;
@@ -3438,9 +3447,6 @@ DEFINE_SCHED_CLASS(ext) = {
 	.task_woken		= task_woken_scx,
 	.set_cpus_allowed	= set_cpus_allowed_scx,
 
-	.rq_online		= rq_online_scx,
-	.rq_offline		= rq_offline_scx,
-
 	.task_tick		= task_tick_scx,
 
 	.switching_to		= switching_to_scx,
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ad7b72317f0f2..8036105f57c09 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -773,9 +773,10 @@ struct cfs_rq {
 /* scx_rq->flags, protected by the rq lock */
 enum scx_rq_flags {
 	/*
-	 * A hotplugged CPU starts scheduling before rq_online_scx(). Track
-	 * ops.cpu_on/offline() state so that ops.enqueue/dispatch() are called
-	 * only while the BPF scheduler considers the CPU to be online.
+	 * Set right after the root's ops.cpu_online() when a CPU comes up and
+	 * cleared when the CPU goes down, see handle_hotplug(). A hotplugged
+	 * CPU starts scheduling before %SCX_RQ_ONLINE is set. ops.enqueue() and
+	 * ops.dispatch() are called for the CPU only while the flag is set.
 	 */
 	SCX_RQ_ONLINE		= 1 << 0,
 	SCX_RQ_CAN_STOP_TICK	= 1 << 1,
@@ -3925,7 +3926,7 @@ extern void balance_callbacks(struct rq *rq, struct balance_callback *head);
  * Typically this must be called while holding task_rq_lock, since most/all
  * properties are serialized under those locks. There are currently two
  * exceptions to this rule in sched/ext which only hold rq->lock: scx_bypass()
- * and rq_offline_scx().
+ * and handle_hotplug().
  */
 
 /*
-- 
2.53.0

