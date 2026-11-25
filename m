Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795633723;
	b=B6oDb/PiOfRZSbsrfukbXnz01m9970L+ovHGg2F2dGTJYduVAqNMlfhxSVJnaM6y6vi2
	 Yz1zGn/fSFusINRAMpo5bTa/y/49mTSkcXScNyj6OUESE0OwIE42JqJbWDMbBMJ2IUy6i
	 kI3RoUyq+U4IoWdlw5rBK4+IWGiATnwikBRaswdVgP4yVw3mYg21NaAqxL+jB2etEf9Ty
	 wobnIw16Ko6btMSWeJuEuwzgHqma2BtGFiWWcuFh5VOSeNw/85xZ22Zj3PscGNMnCXsmb
	 n3wmheXb/3Bp6kzPerfnlqojbWG1q2XnqJAw1ChXWXMv5DwutOI1or6NeWtApTfLHvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795633723;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=WOq0577gJ6/VKeh5ZO/jxDvq0I8MDUO56ei5HVcF46k=;
	b=tnzIZzYJ50u24Waf7pFQw4FyFOqjnpkkeuYIUcYIqTLNcEd9KCdQ/pmuryPWE1JSOwEr
	 mvAlYoouoy/C8a/Eboem+X1Beh3Gh8NE3XKaG7Tj9AzEYM7P+dkqHNnEWcw0fcTzcrMeg
	 Bt6YXc6wA79PkSOOcXUYu8rN46rl2TjCTpVB2QCbVdcM9YwvlgWHkNBWHiylBsIkoem30
	 XfhEb/K15OKzcCnkeb9e4S5P3A26dHumSaiMAMb1icAcr4wp14TxpFOLYZV36DqlGfC6q
	 laA3GHZWPRlo1Bq7Q0FA+Bi5cXAoC1cMQKgIgAWaMh0al1iAAeUe4h5dxWQQLz+Yt4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JSgaHCmq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA05C606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 19:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JSgaHCmq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CADE1F000D0;
	Wed, 25 Nov 2026 19:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795633722;
	bh=WOq0577gJ6/VKeh5ZO/jxDvq0I8MDUO56ei5HVcF46k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JSgaHCmqqjyTlMTbe0MRlrKIQ+GAeHtt7t3x2b5DKNefLW+kiin56C0iEWkHqAOEL
	 CMcPlTtz1vASeV4hFwLInZgBmght6SsbhMP5dFb4oeO4leytpz8q7cl0tudVnxgSXV
	 wrCXW2OggDISav9BixwERPPj9BF5XpeOItgWOe0CAp+Qn0pNWc6I/4vtmCX90ATpty
	 itOTGaKKpegqqpkxmgrgGJCPCFAiu5gySclvoayrqn/q+n2/0VaMVSo1Myv8b2gMAW
	 8kyQt3//nV3xU06Rt4LIQVc+VMsvfd2kGU1i+9pPkog9qo1zKaFMzKsstXG19U7Z/Y
	 0x3VgXyounHWQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Seiji Nishikawa <snishika@redhat.com>,
	syzbot+681e729b2cf0d4860042@syzkaller.appspotmail.com,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] sched/core: Do not touch SMT siblings that have not joined the core yet
Date: Wed, 25 Nov 2026 14:08:40 -0500
Message-ID: <20261125190823.1174441-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112540-defiant-seventy-e466@gregkh>
References: <2026112540-defiant-seventy-e466@gregkh>
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
[ sashal: Dropped the local smt_mask and converted the loops to the new iterators, keeping this tree's existing max initialization and need_sync assignment because it lacks the restart label and annotation. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/core.c       |  8 +++-----
 kernel/sched/core_sched.c |  3 +--
 kernel/sched/sched.h      | 19 +++++++++++++++++++
 3 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3b51a93ba609c..d11274908ffc2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6044,7 +6044,6 @@ static struct task_struct *
 pick_next_task(struct rq *rq, struct rq_flags *rf)
 {
 	struct task_struct *next, *p, *max = NULL;
-	const struct cpumask *smt_mask;
 	bool fi_before = false;
 	bool core_clock_updated = (rq == rq->core);
 	unsigned long cookie;
@@ -6094,7 +6093,6 @@ pick_next_task(struct rq *rq, struct rq_flags *rf)
 
 	prev_balance(rq, rf);
 
-	smt_mask = cpu_smt_mask(cpu);
 	need_sync = !!rq->core->core_cookie;
 
 	/* reset state */
@@ -6150,7 +6148,7 @@ pick_next_task(struct rq *rq, struct rq_flags *rf)
 	 *
 	 * Tie-break prio towards the current CPU
 	 */
-	for_each_cpu_wrap(i, smt_mask, cpu) {
+	for_each_core_cpu_wrap(i, rq) {
 		rq_i = cpu_rq(i);
 
 		/*
@@ -6174,7 +6172,7 @@ pick_next_task(struct rq *rq, struct rq_flags *rf)
 	 * For each thread: try and find a runnable task that matches @max or
 	 * force idle.
 	 */
-	for_each_cpu(i, smt_mask) {
+	for_each_core_cpu(i, rq) {
 		rq_i = cpu_rq(i);
 		p = rq_i->core_pick;
 
@@ -6220,7 +6218,7 @@ pick_next_task(struct rq *rq, struct rq_flags *rf)
 	 * their task. This ensures there is no inter-sibling overlap between
 	 * non-matching user state.
 	 */
-	for_each_cpu(i, smt_mask) {
+	for_each_core_cpu(i, rq) {
 		rq_i = cpu_rq(i);
 
 		/*
diff --git a/kernel/sched/core_sched.c b/kernel/sched/core_sched.c
index 9ede71ecba7f8..fb64cf180d1f6 100644
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
index ad7b72317f0f2..ea470cc608d51 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1430,6 +1430,25 @@ static inline raw_spinlock_t *__rq_lockp(struct rq *rq)
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

