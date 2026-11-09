Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794216539;
	b=KlHYVTXgRubaXC6wlVdTCG7lMTCyCyEgm1USKH0IGqlK1J3yoNi0xDo6Jl+QG/yj+mI2
	 6znumWWkwkp3Ja9ncpDXusnq7ZngWymgVqiJJ6Af1GMU8Y28vKlOIgIuM1XVC5D/1z6AR
	 z0KkbwV1X6jTmq16t7H/mv+X8yixEniLlxi2cxwQzdTJf+giEcpnsjeGQBCh01kHKN75m
	 GOBMr8HuPG6orhF55HN2TQbEF6xgpdv+I8RxNIf467SDzYwkWY7ffGU6cXmS/oVyk05d0
	 c/g79GVUPRP9IVhgHDc1pMiErPQLXBD+BG/rveKTzjcsTRveHzAZG3xEyI8dgozLL4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794216539;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=yF7EPiLMZ5jURhQk42nDr9Yy00mh/KKMVMtk+ygdvy4=;
	b=e7HIoU7JhUIrxH+HS9mJyDXaVYWjh3zooZsPbIVObtqgyZ0brpvKeiyT+mUnrtnNW06F
	 Vcj28+FCscVwTG1Do1pigUVRrC0o5rCyt6Ckq0trOKwbuo9+qOseFvec7Mskr2Qnv9Q3e
	 iExvz6mMCLG/IXClJpI1Tu3yrR673ur+r/tYu6NOO/zm2v+d/dXjQ9qA0JrMYATeL+seZ
	 hRhsLMsRxf+oC1IX8e8Bi5BNBBPDNXKDU9O1P2EjYSHH5deXBbBvRdXc2BvwoD5Do3G33
	 UQswFssc7i/HyLygNxCXw2clBb3xK/PoqEoRLxjYAwSOEXaCn+JPQj4VaixnKj9Df3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=kJWqAive;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b="KOOe/25O";
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531AE60A260A;
	Mon,  9 Nov 2026 09:28:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 531AE60A260A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=kJWqAive;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=KOOe/25O
Date: Mon, 09 Nov 2026 09:28:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794216537;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yF7EPiLMZ5jURhQk42nDr9Yy00mh/KKMVMtk+ygdvy4=;
	b=kJWqAiveqCpwPc/fHfnXJ+44Wyx9gSiD9a0bWcEiOTHz5jrQw1UnUnJ7lE5FKtS4+K+5Xm
	79pknSRIiqq1NBml7YqVVWBC2mLAsJAb6Aaj0FSZqrD5Rd6jn/+JkeKDBFJyy58E2UHINV
	IuhMDFcdbYobdMpSFAaT1k1HBRuOd+f/eIkkUp51orhlgRO/iMfgjXH5DJWHadEFfpHmxM
	F9hsS4ekEPjeOZezmvbLfzf2E81IyrdmMMlfx8U2dN3I53+drisPwS0fPJfWe+DgNLyOQ6
	DYgE2Cp+6VmI6+LK4O+VvMrVhwPFcOcIEAsFEkFrx/4MMw8VhhkjxxZNvCL70g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794216537;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yF7EPiLMZ5jURhQk42nDr9Yy00mh/KKMVMtk+ygdvy4=;
	b=KOOe/25OGjj7JGRaFlyJyESj0zWJ/zq6rSOtYPwZ3UliWoXQAbnl5EBWsKJONXVzQvwtE7
	seIcRbhnCKmlKJBQ==
From: "tip-bot2 for Seiji Nishikawa" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Do not touch SMT siblings that have not
 joined the core yet
Cc: syzbot+681e729b2cf0d4860042@syzkaller.appspotmail.com,
 Seiji Nishikawa <snishika@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20261104022004.3810619-1-snishika@redhat.com>
References: <20261104022004.3810619-1-snishika@redhat.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179421653532.2093942.15683822727431804681.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     ec6f6731538e0d45872eb279fdeb477bed152d6f
Gitweb:        https://git.kernel.org/tip/ec6f6731538e0d45872eb279fdeb477bed1=
52d6f
Author:        Seiji Nishikawa <snishika@redhat.com>
AuthorDate:    Wed, 04 Nov 2026 11:20:04 +09:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 09 Nov 2026 10:09:45 +01:00

sched/core: Do not touch SMT siblings that have not joined the core yet

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

  debug_locks && !(lock_is_held(&(__rq_lockp(rq))->dep_map) !=3D 0)
  WARNING: kernel/sched/sched.h:1666 at update_rq_clock+0x40a/0xd20 kernel/sc=
hed/core.c:875, CPU#0: syz-executor251/5712
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
SMT siblings (-smp 2,sockets=3D1,cores=3D1,threads=3D2). Without this patch,
the warning came after about 100 seconds. Just before the warning, a
debug print showed that the loop on CPU 0 saw CPU 1 with rq->core
pointing to CPU 1 itself, and cpu_online() was false for CPU 1. With
this patch, the same state still happened, but there was no warning
in more than 2 hours.

Fixes: 3c474b3239f1 ("sched: Fix Core-wide rq->lock for uninitialized CPUs")
Closes: https://syzkaller.appspot.com/bug?extid=3D681e729b2cf0d4860042
Reported-by: syzbot+681e729b2cf0d4860042@syzkaller.appspotmail.com
Signed-off-by: Seiji Nishikawa <snishika@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261104022004.3810619-1-snishika@redhat.com
---
 kernel/sched/core.c       |  9 +++------
 kernel/sched/core_sched.c |  3 +--
 kernel/sched/sched.h      | 19 +++++++++++++++++++
 3 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1a088d4..5ed660f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6297,7 +6297,6 @@ pick_next_task(struct rq *rq, struct rq_flags *rf)
 	__must_hold(__rq_lockp(rq))
 {
 	struct task_struct *next, *p, *max;
-	const struct cpumask *smt_mask;
 	bool fi_before =3D false;
 	bool core_clock_updated =3D (rq =3D=3D rq->core);
 	unsigned long cookie;
@@ -6344,8 +6343,6 @@ pick_next_task(struct rq *rq, struct rq_flags *rf)
=20
 	prev_balance(rq, rf);
=20
-	smt_mask =3D cpu_smt_mask(cpu);
-
 restart:
 	need_sync |=3D !!rq->core->core_cookie;
=20
@@ -6413,7 +6410,7 @@ restart:
 	 * Tie-break prio towards the current CPU
 	 */
 	max =3D NULL;
-	for_each_cpu_wrap(i, smt_mask, cpu) {
+	for_each_core_cpu_wrap(i, rq) {
 		rq_i =3D cpu_rq(i);
=20
 		/*
@@ -6446,7 +6443,7 @@ restart:
 	 * For each thread: try and find a runnable task that matches @max or
 	 * force idle.
 	 */
-	for_each_cpu(i, smt_mask) {
+	for_each_core_cpu(i, rq) {
 		rq_i =3D cpu_rq(i);
 		p =3D rq_i->core_pick;
=20
@@ -6491,7 +6488,7 @@ restart:
 	 * their task. This ensures there is no inter-sibling overlap between
 	 * non-matching user state.
 	 */
-	for_each_cpu(i, smt_mask) {
+	for_each_core_cpu(i, rq) {
 		rq_i =3D cpu_rq(i);
=20
 		/*
diff --git a/kernel/sched/core_sched.c b/kernel/sched/core_sched.c
index 43e0bde..d56be1c 100644
--- a/kernel/sched/core_sched.c
+++ b/kernel/sched/core_sched.c
@@ -241,7 +241,6 @@ out:
 /* REQUIRES: rq->core's clock recently updated. */
 void __sched_core_account_forceidle(struct rq *rq)
 {
-	const struct cpumask *smt_mask =3D cpu_smt_mask(cpu_of(rq));
 	u64 delta, now =3D rq_clock(rq->core);
 	struct rq *rq_i;
 	struct task_struct *p;
@@ -273,7 +272,7 @@ void __sched_core_account_forceidle(struct rq *rq)
 		delta =3D div_u64(delta, rq->core->core_forceidle_occupation);
 	}
=20
-	for_each_cpu(i, smt_mask) {
+	for_each_core_cpu(i, rq) {
 		rq_i =3D cpu_rq(i);
 		p =3D rq_i->core_pick ?: rq_i->curr;
=20
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1d76950..92134ce 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1534,6 +1534,25 @@ static inline raw_spinlock_t *__rq_lockp(struct rq *rq)
 	return &rq->__lock;
 }
=20
+/*
+ * A CPU coming online is set in cpu_smt_mask() before
+ * sched_core_cpu_starting() links its rq->core to the core leader.
+ * Until then it does not share the core-wide lock, so it must not be
+ * touched as part of the core.
+ */
+static inline bool sched_core_sibling(struct rq *rq, struct rq *rq_i)
+{
+	return rq_i->core =3D=3D rq->core;
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
 cfs_prio_less(const struct task_struct *a, const struct task_struct *b, bool=
 fi);
=20
