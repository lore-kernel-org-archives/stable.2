Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795603033;
	b=iWYPIHXIk2GTRylovfl8PE4p4qJgB8erQtwK6wvnrBYh7xveQkdHG5aljdHbqkr16rXc
	 e5/lbUE9Zn3nkaOH8jRyxS73PVVpA9e1GPGUreqt+zNqA9CRwagRFeK+wRWE+6Xv6vYC4
	 RcatlCXqC7wDikQjceDxJYXKnf231QLKpka7RUjKRFmfHfFW2NOMRSClXxPtACTKliALS
	 95froILFrpbQT863UbkvfQSUSlPKOcOZWQaXXQ/fe9ExyShbRRgbjAwnvJX3Yp3Djpge3
	 BaeQ5LYhbE3a3WiGhJzfd/LQy4xEiRfFG/e+Hje6c48kH7kM61O1+fsTRhlHWuRkCTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795603033;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=UiPmukhZq3ejo6dCWSp2kdaYjd7D27byZcCUrV3XU2k=;
	b=b4JuVXXOA/O/MdS5XPUXHtIG9J1bF0Hubvw5EavzhS12s1h0xeh+IQ0PcedseUXhrcBv
	 xRdPOgaD9fN64yYUnL1C3l+4Vx9p1a1ucdsmL69l72CpkjrqNWuzBtSLOYnUTPF9Sw0on
	 rJLyPMWynjRWrjKYSUSbaspSf20pC9sRNnMtk2M94UeqRDqxlSfRl9OpIwdaXSLdIVaai
	 ZHeLjXwzy3c57srqDVeNfh+jxjnyd2HpHw1uSZqqqQX3Mp/Gq5VWvmmbbSm1v8jleLsAO
	 eqnprdFYIQaoDwHWAk5+sgRDwXhBVOEGnSLsdc7KUXelHCU9ocCjQesEGw1bYzssF8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=v7RpfLXa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A790606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=v7RpfLXa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B181F000C4;
	Wed, 25 Nov 2026 10:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795603032;
	bh=UiPmukhZq3ejo6dCWSp2kdaYjd7D27byZcCUrV3XU2k=;
	h=Subject:To:Cc:From:Date;
	b=v7RpfLXaBToOlrimDpT5d4OehzYpRE4Og9hP9TPwypneYqRe5SUjN9bCo8rAfXZAe
	 c43tRxAvA5kdJ8knn02oC1CbcNlbWdOYWCg/Gl9DA/W3MVK7afJY2sPx3+ZiGbGW+H
	 +s8STuXk57pf7t+Pt1AhOD5ZZLkVzxFBrpA+IniQ=
Subject: FAILED: patch "[PATCH] sched_ext: Fix ops.enqueue/dispatch() calls before" failed to apply to 6.18-stable tree
To: tj@kernel.org,arighi@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:22:26 +0100
Message-ID: <2026112526-mobster-foe-f1b5@gregkh>
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
git cherry-pick -x 2227a34ff7bfcf6112931039e3554f4b70b65ab9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112526-mobster-foe-f1b5@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2227a34ff7bfcf6112931039e3554f4b70b65ab9 Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Sat, 31 Oct 2026 07:05:41 -1000
Subject: [PATCH] sched_ext: Fix ops.enqueue/dispatch() calls before
 ops.cpu_online()

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

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 0d64253569e8..72c5fbb1dc29 100644
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
@@ -4338,6 +4338,13 @@ static void handle_hotplug(struct rq *rq, bool online)
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
 
@@ -4346,8 +4353,14 @@ static void handle_hotplug(struct rq *rq, bool online)
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
@@ -4398,8 +4411,22 @@ static void handle_hotplug(struct rq *rq, bool online)
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
@@ -4412,22 +4439,6 @@ void scx_rq_deactivate(struct rq *rq)
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
@@ -5899,9 +5910,6 @@ DEFINE_SCHED_CLASS(ext) = {
 	.task_woken		= task_woken_scx,
 	.set_cpus_allowed	= set_cpus_allowed_scx,
 
-	.rq_online		= rq_online_scx,
-	.rq_offline		= rq_offline_scx,
-
 	.task_tick		= task_tick_scx,
 
 	.switching_to		= switching_to_scx,
diff --git a/kernel/sched/ext/inlines.h b/kernel/sched/ext/inlines.h
index 5dce394e0813..8de281a5c9c6 100644
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

