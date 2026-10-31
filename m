Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793466345;
	b=cYfX8CrlBT3d4pJrviu/5UhJxmhy6r2PdfFVMV1fie6mzv3E2W9HFNtY1jLv42aapdQ6
	 KkEDXWylPUmyE6cXj7HibC6vpfz5rGvZyAMEuussPilxkgmLrRIah0Kez2nfg6jeVVmbM
	 09CPVfzHRg+FhZuIS1OyqedLEF+tUt+CqdvgPBLXHDzFamA41XQxXL2y1Xg+ZcK6ngQRm
	 HMpTKfbUHjnKuqG1zvYwW9c5mX5J3clqvmYmGMAyL0WK7FUcT59uzDSUv5sNW96t3c9l0
	 5zIyavmFaWnZReoyCRwLCWfLtrHqKz+G98oj0uOhf+vt9x4iqeg7eF6xj+GgOlzRDew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793466345;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KZkezgqqsO6rWHJD2on7GSZSEjUFYwthaJ0aosndxeY=;
	b=C7rlVXW6JJIdQFqP/pkf6TI3Bwk9OKU8Cn5Wd0NtyfeHf9ZytLzIy85n9iK4vEkGopA6
	 13j9v2kWqHEspgIdMYSmn+aq+jHyvQHC1cu32/xyr/YzjNV0FvAiwWdOlND+COPAH2dhI
	 Zl2fvWtF2u09+iGfkcDA9uPUwiDvkjwnTv7f25JfZLc8W001OoS4YfH628ICAFZuTJ1L4
	 FOnQ99xk5rforYwfMEWP4k+JAqNiS+EO9LhHR0M2NOFBXLQi95dFmSoDEo+5UEwxbB+yR
	 Hu9wRAxJ0ccC8wE2WseJbojLeq9DQAcUn2ai6krelc/dXvxKtD4LiTfbID3twmxJSbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MVECwXuw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4FE606A333;
	Sat, 31 Oct 2026 17:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MVECwXuw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6534F1F00919;
	Sat, 31 Oct 2026 17:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793466344;
	bh=KZkezgqqsO6rWHJD2on7GSZSEjUFYwthaJ0aosndxeY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MVECwXuwxWqB+qRdCN15cWSKJZLRnLmMImw2/yFyMjielzquiDe7klKhmeq3FU5x6
	 99wgKpcYo4vEqy7sgWYL8BQdlGWvImewWbfnnXfXLmOlgYeY4f+mxQzQU91uL9iT9i
	 lYQGRykmBFdd1JIj9NAqhyRCF+JZCPvwHwku/PZBDv7AYNK+Zjuzb8PVrGUoCOZ8bg
	 EqBJHLcWiOpprE/565djeKA40RXZFY4jd1UAUk1Xp4vBGY7+hmNYGymunvFh9G3KgF
	 zJelfUH0OdX4Kj6whKOwb0e7Ql1Zcxb97QnIeI5gXh3cubbWZtrRQ0A6pUstXmyr4w
	 cGIxW9fmy/xgg==
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
Subject: [PATCH 2/2] sched_ext: Fix ops.enqueue/dispatch() calls before ops.cpu_online()
Date: Sat, 31 Oct 2026 07:05:41 -1000
Message-ID: <20261031170541.710939-3-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261031170541.710939-1-tj@kernel.org>
References: <20261031170541.710939-1-tj@kernel.org>
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
---
 kernel/sched/ext/ext.c     | 60 +++++++++++++++++++++-----------------
 kernel/sched/ext/inlines.h |  2 +-
 kernel/sched/ext/sub.c     |  9 +++---
 kernel/sched/sched.h       | 15 +++++-----
 4 files changed, 48 insertions(+), 38 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index c75df42d8c6f..5a24f956cf72 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2233,11 +2233,11 @@ static void direct_dispatch(struct scx_sched *sch, struct task_struct *p,
 bool scx_rq_online(struct rq *rq)
 {
 	/*
-	 * Test both cpu_active() and %SCX_RQ_ONLINE. %SCX_RQ_ONLINE follows the
-	 * core's rq online state. cpu_active() test guarantees that, if this
-	 * function returns %true, %SCX_RQ_ONLINE will stay set until the
-	 * current scheduling operation is complete even if we aren't locking
-	 * @rq.
+	 * Test both cpu_active() and %SCX_RQ_ONLINE. %SCX_RQ_ONLINE is set
+	 * after the root's ops.cpu_online() and cleared when the cpu goes down.
+	 * cpu_active() test guarantees that, if this function returns %true,
+	 * %SCX_RQ_ONLINE will stay set until the current scheduling operation
+	 * is complete even if we aren't locking @rq.
 	 */
 	return likely((rq->scx.flags & SCX_RQ_ONLINE) && cpu_active(cpu_of(rq)));
 }
@@ -4328,6 +4328,13 @@ static void handle_hotplug(struct rq *rq, bool online)
 	s32 cpu = cpu_of(rq);
 	s32 cpu_or_cid = cpu;
 
+	if (!online) {
+		guard(rq_lock_irqsave)(rq);
+		update_rq_clock(rq);
+		rq->scx.flags &= ~SCX_RQ_ONLINE;
+		drain_offline_rq(rq);
+	}
+
 	atomic_long_inc(&scx_hotplug_seq);
 	scx_update_frozen_cpus(cpu, online);
 
@@ -4336,8 +4343,14 @@ static void handle_hotplug(struct rq *rq, bool online)
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
@@ -4388,8 +4401,22 @@ static void handle_hotplug(struct rq *rq, bool online)
 			 "cpu %d going %s, exiting scheduler", cpu,
 			 online ? "online" : "offline");
 
-	if (online)
+	if (online) {
+		/*
+		 * The cpu must not call ops.enqueue() or ops.dispatch() before
+		 * the root's ops.cpu_online(). The core's rq online state can't
+		 * gate them, as the sched domain rebuild in
+		 * sched_cpu_activate() can put @rq online before this function
+		 * runs. Set %SCX_RQ_ONLINE here.
+		 *
+		 * scx_online_ecaps() queues a reseed whose ecaps ops run in
+		 * dispatch context on the cpu and can insert into its local
+		 * DSQ. Set the flag first.
+		 */
+		scoped_guard (rq_lock_irqsave, rq)
+			rq->scx.flags |= SCX_RQ_ONLINE;
 		scx_online_ecaps(rq);
+	}
 }
 
 void scx_rq_activate(struct rq *rq)
@@ -4402,22 +4429,6 @@ void scx_rq_deactivate(struct rq *rq)
 	handle_hotplug(rq, false);
 }
 
-static void rq_online_scx(struct rq *rq)
-{
-	rq->scx.flags |= SCX_RQ_ONLINE;
-}
-
-static void rq_offline_scx(struct rq *rq)
-{
-	rq->scx.flags &= ~SCX_RQ_ONLINE;
-
-	/* sched domain rebuilds call rq_offline with the CPU staying alive */
-	if (cpu_active(cpu_of(rq)))
-		return;
-
-	drain_offline_rq(rq);
-}
-
 static bool check_rq_for_timeouts(struct rq *rq)
 {
 	struct scx_sched *sch;
@@ -5889,9 +5900,6 @@ DEFINE_SCHED_CLASS(ext) = {
 	.task_woken		= task_woken_scx,
 	.set_cpus_allowed	= set_cpus_allowed_scx,
 
-	.rq_online		= rq_online_scx,
-	.rq_offline		= rq_offline_scx,
-
 	.task_tick		= task_tick_scx,
 
 	.switching_to		= switching_to_scx,
diff --git a/kernel/sched/ext/inlines.h b/kernel/sched/ext/inlines.h
index 1e39d12678c4..ba66c40b1e18 100644
--- a/kernel/sched/ext/inlines.h
+++ b/kernel/sched/ext/inlines.h
@@ -82,7 +82,7 @@ scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
 	/*
 	 * scx_rq_online() can't be used. Its cpu_active() test goes false
 	 * before CPU hotplug waits for an RCU grace period, and
-	 * rq_offline_scx() moves this CPU's tasks to the local DSQ only after
+	 * handle_hotplug() moves this CPU's tasks to the local DSQ only after
 	 * the wait. The grace period can depend on those tasks running.
 	 */
 	if (unlikely(!SCX_HAS_OP(sch, dispatch)) || !(rq->scx.flags & SCX_RQ_ONLINE))
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 6bc6b93ca63a..d2a20114eaa2 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -918,10 +918,11 @@ struct scx_dispatch_q *__scx_resolve_local_dsq(struct scx_sched *sch, struct rq
 		return &rq->scx.local_dsq;
 
 	/*
-	 * The task must run on this CPU regardless of caps: the rq is draining
-	 * offline (BPF scheduler bypassed), the task is migration-disabled, or a
-	 * migration is pending. Admit despite the missing caps and count it.
-	 * Refuse preemptions.
+	 * The task must run on this CPU regardless of caps: ops.enqueue() is
+	 * skipped while the CPU is going down or before the root's
+	 * ops.cpu_online(), the task is migration-disabled, or a migration is
+	 * pending. Admit despite the missing caps and count it. Refuse
+	 * preemptions.
 	 */
 	if (unlikely(!scx_rq_online(rq) || is_migration_disabled(p) ||
 		     p->migration_pending)) {
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 2cc16c01b168..017ebb5308df 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -781,19 +781,20 @@ struct cfs_rq {
 /* scx_rq->flags, protected by the rq lock */
 enum scx_rq_flags {
 	/*
-	 * Set while the core has the rq online, see rq_online_scx() and
-	 * rq_offline_scx(). A hotplugged cpu starts scheduling before
-	 * rq_online_scx(). ops.enqueue() and ops.dispatch() are called for the
-	 * cpu only while it is set, see scx_rq_online() and
-	 * scx_dispatch_sched().
+	 * Set right after the root's ops.cpu_online() when a cpu comes up and
+	 * cleared when the cpu goes down, see handle_hotplug(). A hotplugged
+	 * cpu starts scheduling before %SCX_RQ_ONLINE is set. ops.enqueue() and
+	 * ops.dispatch() are called for the cpu only while the flag is set, see
+	 * scx_rq_online() and scx_dispatch_sched().
 	 */
 	SCX_RQ_ONLINE		= 1 << 0,
 	SCX_RQ_CAN_STOP_TICK	= 1 << 1,
 	/*
 	 * Set while the root considers the cpu online, from its
 	 * ops.cpu_online() until its ops.cpu_offline(). ecaps are delivered
-	 * only while it is set. %SCX_RQ_ONLINE follows the core's rq state
-	 * instead, which changes ahead of the root's view on both edges.
+	 * only while it is set. %SCX_RQ_ONLINE can't gate them, as a cpu going
+	 * down clears it before the ecaps loss is reported, see
+	 * scx_offline_ecaps().
 	 */
 	SCX_RQ_OPS_ONLINE	= 1 << 2,
 	SCX_RQ_CLK_VALID	= 1 << 5, /* RQ clock is fresh and valid */
-- 
2.56.0

