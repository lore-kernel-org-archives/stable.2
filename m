Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795634002;
	b=luCwYygRoO20FJ61P3P4nvO49o5Auz1XXDkQgGg1+PrPTWml5No1sE60GSWRc3ApwF/A
	 8xYnPYe1IaaWvvRye2fv3em+WsDfx+/Beem80APXFRb7J0pg7oVfG1QLq4uqd6pCy/+Yj
	 E68Y3ncXPyGzqj4S3A2/4CfYbhNruYAn55MCdoYHEDFayR1zpUFonqoxQOljXSh5gmPWz
	 BacNO+cI79cCEtTsYBXiboNJSUdRFaYww/0ii5FaZ1EKWcg3/r+VU3P97OWUka7ePWsk5
	 +9rcPj+vgFUFQZwHeUflxJ0Sjhsuf5qyywhakxmOOVEKphf+alO6/KqSzebOls597tA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795634002;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=d624iT0QFBfMin1qi7DY1hpZDwu7RUlilM/P/VzQWYw=;
	b=g38hWmDOdqwFEY6OyvLCFnPfqUdijE+614jOErMoHPU5+TYneMdXwli5/4640oopA80p
	 d0D5bANUPh4p8x3D9ErYnscHqRU0Xktcrni3Ic1hB7ChRwnwoV6FEqlxyD0vePxRazboo
	 5yt7BU9s2ZizYU3EV7oKZYQEDtLfp3mKkNkwRlxkHQCSf0nkE6P40611Y259uLMMcI9Y/
	 el2YPBTPRzofXwMAku3J/6nvKLOm/0rSC5isXAb0whqC/PQeyxwbQSAjwimUSjw6b2U8M
	 2zHVIn/GoyafQ/L2L6RAgEccQopdPAQj7xgzY2DJTTNsC4V8KIohPjJzS6R3HRJUB/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jCQkLwPD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C25606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 19:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jCQkLwPD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AF031F000C4;
	Wed, 25 Nov 2026 19:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795634002;
	bh=d624iT0QFBfMin1qi7DY1hpZDwu7RUlilM/P/VzQWYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jCQkLwPDDfccQ5j+DXWIMUZ+MsWBZNZbqGsqKxQH7+7HDe11y3vu1WGREX/MxhvtY
	 t5s6o5OVDEx8lpmyMBzGm2k/Y2ywj1J7NBEQIyA3WCaJmlYSpRrv+pwcG8k7m0WqOV
	 LcPR+qhFILnl9373vkAJJiMwdQIvUkazed5+sk4o/4CVHrh4stdjA1sa+CESyf4oXL
	 mJ6e6z2CYj7i+xV+LbLkqFplYLW/7i+/NPd4C1kcDM8yzIGWXDt/AhsYdABDyL4TfF
	 BDDjWO1Zwh3Q22O3pgs6QHu+na2IrEqgbmaQ3ZBiHf5QO7nhydgzXpnkqMs952fV68
	 /I7p1yAy69Ngw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Seiji Nishikawa <snishika@redhat.com>,
	syzbot+681e729b2cf0d4860042@syzkaller.appspotmail.com,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] sched/core: Do not touch SMT siblings that have not joined the core yet
Date: Wed, 25 Nov 2026 14:13:19 -0500
Message-ID: <20261125191301.1207010-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112541-sloping-debtless-3dc0@gregkh>
References: <2026112541-sloping-debtless-3dc0@gregkh>
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

From: Seiji Nishikawa <snishika@redhat.com>

[ Upstream commit ec6f6731538e0d45872eb279fdeb477bed152d6f ]

When a CPU comes online, it is added to cpu_smt_mask() of its siblings
before sched_core_cpu_starting() sets its rq->core to the core leader.
For example, on x86, ap_starting() calls set_cpu_sibling_map() first,
and calls notify_cpu_starting() after that. This order is intended.

Before sched_core_cpu_starting() runs, rq->core of the new CPU still
points to its own rq. But rq->core_enabled of the new CPU is already
set. __sched_core_flip() sets it for all possible CPUs, also for
offline CPUs, and CPU offline does not clear it. So __rq_lockp() of the
new CPU returns its own rq->__lock. It does not return the core wide
lock.

If a sibling CPU runs pick_next_task() for SCHED_CORE at this time, it
checks all CPUs in cpu_smt_mask(). It calls update_rq_clock() and
pick_task() for the rq of the new CPU. But it holds only its own core
lock, not the lock of the new CPU. Then lockdep shows this warning in
update_rq_clock().

  debug_locks && !(lock_is_held(&(__rq_lockp(rq))->dep_map) != 0)
  WARNING: kernel/sched/sched.h:1666 at update_rq_clock+0x40a/0xd20 kernel/sched/core.c:875, CPU#0: syz-executor251/5712
  Call Trace:
   <TASK>
   pick_next_task kernel/sched/core.c:6375 [inline]
   __schedule+0x1c69/0x6920 kernel/sched/core.c:7199
   preempt_schedule_irq+0x4e/0x90 kernel/sched/core.c:7606

The next loops in pick_next_task() also change rq_i->core_pick of this
rq, and can call resched_curr() for it, without its lock.
resched_curr() has the same lockdep_assert_rq_held() check.
__sched_core_account_forceidle() also checks all CPUs in the same mask.

CPU offline does not have this problem. remove_siblinginfo() and
sched_core_cpu_dying() both run in take_cpu_down() under stop_machine.
So no sibling CPU can be in pick_next_task() at that time.

Fix this. In these loops, skip a sibling CPU if its rq->core is
different from our rq->core. At run time, rq->core of a CPU is changed
by sched_core_cpu_starting(), sched_core_cpu_deactivate() and
sched_core_cpu_dying(). The first two hold sched_core_lock(), and
sched_core_lock() takes the rq locks of all CPUs in the SMT mask. The
last one runs under stop_machine, as written above. So while we hold
our core lock, the result of this check does not change. A CPU that is
not in the core yet will pick its own tasks. The comment in the
reschedule loop of pick_next_task() already expects this case.

I tested this with the syzbot C reproducer in QEMU. The two vCPUs were
SMT siblings (-smp 2,sockets=1,cores=1,threads=2). Without this patch,
the warning came after about 100 seconds. Just before the warning, a
debug print showed that the loop on CPU 0 saw CPU 1 with rq->core
pointing to CPU 1 itself, and cpu_online() was false for CPU 1. With
this patch, the same state still happened, but there was no warning
in more than 2 hours.

Fixes: 3c474b3239f1 ("sched: Fix Core-wide rq->lock for uninitialized CPUs")
Closes: https://syzkaller.appspot.com/bug?extid=681e729b2cf0d4860042
Reported-by: syzbot+681e729b2cf0d4860042@syzkaller.appspotmail.com
Signed-off-by: Seiji Nishikawa <snishika@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261104022004.3810619-1-snishika@redhat.com
[ sashal: adapted to the older pick_next_task() signature (no __must_hold), and context differs: max = NULL initialized at declaration, need_sync assigned with = and no restart label. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/core.c       |  8 +++-----
 kernel/sched/core_sched.c |  3 +--
 kernel/sched/sched.h      | 19 +++++++++++++++++++
 3 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 719186283bf91..a1d0b22e46b7a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6078,7 +6078,6 @@ static struct task_struct *
 pick_next_task(struct rq *rq, struct rq_flags *rf)
 {
 	struct task_struct *next, *p, *max = NULL;
-	const struct cpumask *smt_mask;
 	bool fi_before = false;
 	bool core_clock_updated = (rq == rq->core);
 	unsigned long cookie;
@@ -6128,7 +6127,6 @@ pick_next_task(struct rq *rq, struct rq_flags *rf)
 
 	prev_balance(rq, rf);
 
-	smt_mask = cpu_smt_mask(cpu);
 	need_sync = !!rq->core->core_cookie;
 
 	/* reset state */
@@ -6184,7 +6182,7 @@ pick_next_task(struct rq *rq, struct rq_flags *rf)
 	 *
 	 * Tie-break prio towards the current CPU
 	 */
-	for_each_cpu_wrap(i, smt_mask, cpu) {
+	for_each_core_cpu_wrap(i, rq) {
 		rq_i = cpu_rq(i);
 
 		/*
@@ -6208,7 +6206,7 @@ pick_next_task(struct rq *rq, struct rq_flags *rf)
 	 * For each thread: try and find a runnable task that matches @max or
 	 * force idle.
 	 */
-	for_each_cpu(i, smt_mask) {
+	for_each_core_cpu(i, rq) {
 		rq_i = cpu_rq(i);
 		p = rq_i->core_pick;
 
@@ -6254,7 +6252,7 @@ pick_next_task(struct rq *rq, struct rq_flags *rf)
 	 * their task. This ensures there is no inter-sibling overlap between
 	 * non-matching user state.
 	 */
-	for_each_cpu(i, smt_mask) {
+	for_each_core_cpu(i, rq) {
 		rq_i = cpu_rq(i);
 
 		/*
diff --git a/kernel/sched/core_sched.c b/kernel/sched/core_sched.c
index 1ef98a93eb1df..8d7d60c970662 100644
--- a/kernel/sched/core_sched.c
+++ b/kernel/sched/core_sched.c
@@ -239,7 +239,6 @@ int sched_core_share_pid(unsigned int cmd, pid_t pid, enum pid_type type,
 /* REQUIRES: rq->core's clock recently updated. */
 void __sched_core_account_forceidle(struct rq *rq)
 {
-	const struct cpumask *smt_mask = cpu_smt_mask(cpu_of(rq));
 	u64 delta, now = rq_clock(rq->core);
 	struct rq *rq_i;
 	struct task_struct *p;
@@ -271,7 +270,7 @@ void __sched_core_account_forceidle(struct rq *rq)
 		delta = div_u64(delta, rq->core->core_forceidle_occupation);
 	}
 
-	for_each_cpu(i, smt_mask) {
+	for_each_core_cpu(i, rq) {
 		rq_i = cpu_rq(i);
 		p = rq_i->core_pick ?: rq_i->curr;
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 27de9290235e7..855b7e39ae89d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1453,6 +1453,25 @@ static inline raw_spinlock_t *__rq_lockp(struct rq *rq)
 	return &rq->__lock;
 }
 
+/*
+ * A CPU coming online is set in cpu_smt_mask() before
+ * sched_core_cpu_starting() links its rq->core to the core leader.
+ * Until then it does not share the core-wide lock, so it must not be
+ * touched as part of the core.
+ */
+static inline bool sched_core_sibling(struct rq *rq, struct rq *rq_i)
+{
+	return rq_i->core == rq->core;
+}
+
+#define for_each_core_cpu(i, rq) \
+	for_each_cpu(i, cpu_smt_mask(rq->cpu)) \
+		if (sched_core_sibling(rq, cpu_rq(i)))
+
+#define for_each_core_cpu_wrap(i, rq) \
+	for_each_cpu_wrap(i, cpu_smt_mask(rq->cpu), rq->cpu) \
+		if (sched_core_sibling(rq, cpu_rq(i)))
+
 extern bool
 cfs_prio_less(const struct task_struct *a, const struct task_struct *b, bool fi);
 
-- 
2.53.0

