Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795603000;
	b=gMTndmebwg6t9nykk4B4IHn6e3hlFYvj20oRW8ygdxBasgZhpXU33103E3VO57eIxMYm
	 FHBLV//UEKryU/PNBMvqUbfTXlXQWBriAO4D0FjhoO3M4K15TjEoEdTEuchyM4b7l9Izn
	 +MhBZEK2xQ206v0XebGJFiLwHpfvJoK2NkcNNUxatYZpwrG4jR7QxZo9qIKL4qGOyQy/D
	 wAPcA9vtdO07OIVuhRpTJwAlAa3yJFtgFtrpuvnz2+8I37y2F9qZyXNMjodOn4tAMcVZO
	 IIf2U1WZIUyaM+ytWZOsEcpTPwfUT80AdDlGnmFQ2kTaVaaSxRI+qawWsYVqal5X5Qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795603000;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=AhUYPjo6m+xlNvUwJq2fCj5GtrHREWHCf7Z7x4GOhNo=;
	b=b4p20d4ZLvk30rIUKm4RNYBUlUWk6g/FMO7MBqhTnezdpUznpZ8nOg0jrGw5UYlzCSvq
	 s0AJg9B6QgeFoXj6CFTnku//TR51rimRypHX5Gjfx9o7ko05QEAdyaEStnuLtkQlVZtyN
	 Rs0ZXYoWpbK7SRlf4NsqIPTLH2ooR712AIEZLUBAGaIXRfiWxBQFmmknfvFOGUUxqjk2b
	 PwQN+PmZp24OIXuchHHz7mTirMCwpEkS7Y6hjyGUC01HNHIpDrrvLRsWLhGA2XL9gplhx
	 nw2Olcw7C2lslIXW8Catfn2Aum0YASu8jrdkkOI82qEZuNMfKOIznv20/9C0CmCcDRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=b+DmmDu+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A741A606A337
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=b+DmmDu+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 028E21F00A19;
	Wed, 25 Nov 2026 10:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795603000;
	bh=AhUYPjo6m+xlNvUwJq2fCj5GtrHREWHCf7Z7x4GOhNo=;
	h=Subject:To:Cc:From:Date;
	b=b+DmmDu+Jd/TdSpUchJ8K0GVNSVQA5XdGKYXSCMejwWcBoEiO5jev2F/JC4xOxpWA
	 DDEAL0RTRFyARE5QIuuOE/0/jlJZWCB9BWoE/rSWWI4NhoneUgr48tRoUzlLxuHn/v
	 HRus4TGnI2cFKZYORR4+FfGn+k5aGlJC6Omn7abU=
Subject: FAILED: patch "[PATCH] sched/core: Do not touch SMT siblings that have not joined" failed to apply to 6.12-stable tree
To: snishika@redhat.com,mingo@kernel.org,peterz@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:21:41 +0100
Message-ID: <2026112541-sloping-debtless-3dc0@gregkh>
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


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x ec6f6731538e0d45872eb279fdeb477bed152d6f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112541-sloping-debtless-3dc0@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ec6f6731538e0d45872eb279fdeb477bed152d6f Mon Sep 17 00:00:00 2001
From: Seiji Nishikawa <snishika@redhat.com>
Date: Wed, 4 Nov 2026 11:20:04 +0900
Subject: [PATCH] sched/core: Do not touch SMT siblings that have not joined
 the core yet

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

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1a088d4576f5..5ed660f099a5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6297,7 +6297,6 @@ pick_next_task(struct rq *rq, struct rq_flags *rf)
 	__must_hold(__rq_lockp(rq))
 {
 	struct task_struct *next, *p, *max;
-	const struct cpumask *smt_mask;
 	bool fi_before = false;
 	bool core_clock_updated = (rq == rq->core);
 	unsigned long cookie;
@@ -6344,8 +6343,6 @@ pick_next_task(struct rq *rq, struct rq_flags *rf)
 
 	prev_balance(rq, rf);
 
-	smt_mask = cpu_smt_mask(cpu);
-
 restart:
 	need_sync |= !!rq->core->core_cookie;
 
@@ -6413,7 +6410,7 @@ pick_next_task(struct rq *rq, struct rq_flags *rf)
 	 * Tie-break prio towards the current CPU
 	 */
 	max = NULL;
-	for_each_cpu_wrap(i, smt_mask, cpu) {
+	for_each_core_cpu_wrap(i, rq) {
 		rq_i = cpu_rq(i);
 
 		/*
@@ -6446,7 +6443,7 @@ pick_next_task(struct rq *rq, struct rq_flags *rf)
 	 * For each thread: try and find a runnable task that matches @max or
 	 * force idle.
 	 */
-	for_each_cpu(i, smt_mask) {
+	for_each_core_cpu(i, rq) {
 		rq_i = cpu_rq(i);
 		p = rq_i->core_pick;
 
@@ -6491,7 +6488,7 @@ pick_next_task(struct rq *rq, struct rq_flags *rf)
 	 * their task. This ensures there is no inter-sibling overlap between
 	 * non-matching user state.
 	 */
-	for_each_cpu(i, smt_mask) {
+	for_each_core_cpu(i, rq) {
 		rq_i = cpu_rq(i);
 
 		/*
diff --git a/kernel/sched/core_sched.c b/kernel/sched/core_sched.c
index 43e0bde3038e..d56be1c31435 100644
--- a/kernel/sched/core_sched.c
+++ b/kernel/sched/core_sched.c
@@ -241,7 +241,6 @@ int sched_core_share_pid(unsigned int cmd, pid_t pid, enum pid_type type,
 /* REQUIRES: rq->core's clock recently updated. */
 void __sched_core_account_forceidle(struct rq *rq)
 {
-	const struct cpumask *smt_mask = cpu_smt_mask(cpu_of(rq));
 	u64 delta, now = rq_clock(rq->core);
 	struct rq *rq_i;
 	struct task_struct *p;
@@ -273,7 +272,7 @@ void __sched_core_account_forceidle(struct rq *rq)
 		delta = div_u64(delta, rq->core->core_forceidle_occupation);
 	}
 
-	for_each_cpu(i, smt_mask) {
+	for_each_core_cpu(i, rq) {
 		rq_i = cpu_rq(i);
 		p = rq_i->core_pick ?: rq_i->curr;
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1d76950dbb0a..92134ce326a4 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1534,6 +1534,25 @@ static inline raw_spinlock_t *__rq_lockp(struct rq *rq)
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
 

