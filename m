Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795634385;
	b=p/6QWaTL5HgumLmPKpABid4d8D7PlHiuB3oYjpJHJ3gs9zUy65RcYvpE8rkjEPKNVRmD
	 5cMiQA+calKKmdFf0m5qCE1Ld74FsvYFgdVe54et+S5nHP0HtRKOfJMyyjuxCO0Vf04s7
	 i9+IMTU4KhEAfl0TDHL7pHZwPxd/iMwSnSvIFNUw0E3bx1WtsyDVuSR3d9zrJeZvcRnPW
	 1eS8Yh9COnROe2dc2gMBa6D7TQYEYjINK4Z6Qu52N8MCquKy90q8KA+6BRgaVm7o+D83s
	 K93/vfmC736sfVpjFijLbXknohHogOFNW6iQgrqQYwcrJSNjR0siBpffpB9wT43mIew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795634385;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Z9PsXlG7aeYM5t6hVfSAmYhLImdjrSPMIlMRWxoPPd4=;
	b=hVAMp1Q03TSATg4SzOlPJ8EGgHS7FqCupqQXO4MZFDnTpbsHkiYxnjItOcsplmFxuzXK
	 54GMSXb5J1HeqU02WMGXfm5yskxCbYlrU+40oyZwjtKmNIQiG270MIgqhfxq+8pzoAw4I
	 mDKgckr74/sKU9dLxiaMLI97l1LXGwCYEGTjgU8aYpvawbwJBWBnWJcPfnWXwxcuikVfT
	 9Fs+IjokSqWpYVYVg9fVfMNjTlryuPkdkMtAA694ijnQAH5oAUq3aTV1hBP1bpLDQNWbL
	 d+zstYO1htjGglfXl2+CItpVNRMCIRq33RIV/izWvs9G1uNPqUaB9cMx+PZxwFMfEjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SHIUhkQR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC1D606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 19:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SHIUhkQR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3F001F000E0;
	Wed, 25 Nov 2026 19:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795634384;
	bh=Z9PsXlG7aeYM5t6hVfSAmYhLImdjrSPMIlMRWxoPPd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SHIUhkQRnO+2/8h19wS3aqfOBplbc15fJdiVvKISBMglF4fPf/L8O6pkmFlxrJf7z
	 lDvCLLCOWnxRyLMkscyedHq40XnFmxaQE4GNZALJLxy5u6L/rSR1hJhYGC6ZVSSAOy
	 OPOnSArclLeBuFZYqJoZCx9Gmn2qsqOy4g66bqq4/eB59wRwGWORMuj0Dz8Z+RUcv5
	 H655qCJogyw8wm6ejldrSawi6hkCBG8VbTvaUnQCtmcUYGIJko3BfeK/onRo3Lu8JG
	 6TX67pYAeB7KgZZxkrwAkfXEvGPXBVlO7TZhetfgbmLb0AhvC4JdNkeBEStYCC5PTT
	 rb8NXR4oPn5DQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Andrea Righi <arighi@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y] sched_ext: Fix ops.enqueue/dispatch() calls before ops.cpu_online()
Date: Wed, 25 Nov 2026 14:19:42 -0500
Message-ID: <20261125191757.1176383-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112525-reprise-frostlike-4cea@gregkh>
References: <2026112525-reprise-frostlike-4cea@gregkh>
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
[ sashal: Moved the SCX_RQ_ONLINE set/clear into handle_hotplug() and placed the ecaps reseed after it, dropping context lines for helpers and a flag this tree lacks and using the older comment wording. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/ext/ext.c     | 65 ++++++++++++++++++++++----------------
 kernel/sched/ext/inlines.h |  2 +-
 kernel/sched/ext/sub.c     |  9 +++---
 kernel/sched/sched.h       |  8 +++--
 4 files changed, 48 insertions(+), 36 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 63f8a0564900e..46b1f250a5330 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2002,11 +2002,11 @@ static void direct_dispatch(struct scx_sched *sch, struct task_struct *p,
 bool scx_rq_online(struct rq *rq)
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
@@ -3830,6 +3830,13 @@ static void handle_hotplug(struct rq *rq, bool online)
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
 
 	/*
@@ -3837,15 +3844,19 @@ static void handle_hotplug(struct rq *rq, bool online)
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
 
-	if (online)
-		scx_online_ecaps(rq);
-	else
+	if (!online)
 		scx_offline_ecaps(rq);
 
 	/*
@@ -3885,6 +3896,23 @@ static void handle_hotplug(struct rq *rq, bool online)
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
+		 *
+		 * scx_online_ecaps() queues a reseed whose ecaps ops run in
+		 * dispatch context on the cpu and can insert into its local
+		 * DSQ. Set the flag first.
+		 */
+		scoped_guard (rq_lock_irqsave, rq)
+			rq->scx.flags |= SCX_RQ_ONLINE;
+		scx_online_ecaps(rq);
+	}
 }
 
 void scx_rq_activate(struct rq *rq)
@@ -3897,22 +3925,6 @@ void scx_rq_deactivate(struct rq *rq)
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
@@ -5287,9 +5299,6 @@ DEFINE_SCHED_CLASS(ext) = {
 	.task_woken		= task_woken_scx,
 	.set_cpus_allowed	= set_cpus_allowed_scx,
 
-	.rq_online		= rq_online_scx,
-	.rq_offline		= rq_offline_scx,
-
 	.task_tick		= task_tick_scx,
 
 	.switching_to		= switching_to_scx,
diff --git a/kernel/sched/ext/inlines.h b/kernel/sched/ext/inlines.h
index 5dce394e08134..8de281a5c9c6e 100644
--- a/kernel/sched/ext/inlines.h
+++ b/kernel/sched/ext/inlines.h
@@ -104,7 +104,7 @@ scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
 	/*
 	 * scx_rq_online() can't be used. Its cpu_active() test goes false
 	 * before CPU hotplug waits for an RCU grace period, and
-	 * rq_offline_scx() moves this CPU's tasks to the local DSQ only after
+	 * handle_hotplug() moves this CPU's tasks to the local DSQ only after
 	 * the wait. The grace period can depend on those tasks running.
 	 */
 	if (unlikely(!SCX_HAS_OP(sch, dispatch)) || !(rq->scx.flags & SCX_RQ_ONLINE))
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 4dc3bb12aca3a..c06017429890c 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -883,10 +883,11 @@ struct scx_dispatch_q *scx_resolve_local_dsq(struct scx_sched *sch, struct rq *r
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
index b345f62263b3e..ff8c3f6c164c3 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -781,9 +781,11 @@ struct cfs_rq {
 /* scx_rq->flags, protected by the rq lock */
 enum scx_rq_flags {
 	/*
-	 * A hotplugged CPU starts scheduling before rq_online_scx(). Track
-	 * ops.cpu_on/offline() state so that ops.enqueue/dispatch() are called
-	 * only while the BPF scheduler considers the CPU to be online.
+	 * Set right after the root's ops.cpu_online() when a cpu comes up and
+	 * cleared when the cpu goes down, see handle_hotplug(). A hotplugged
+	 * cpu starts scheduling before %SCX_RQ_ONLINE is set. ops.enqueue() and
+	 * ops.dispatch() are called for the cpu only while the flag is set, see
+	 * scx_rq_online() and scx_dispatch_sched().
 	 */
 	SCX_RQ_ONLINE		= 1 << 0,
 	SCX_RQ_CAN_STOP_TICK	= 1 << 1,
-- 
2.53.0

