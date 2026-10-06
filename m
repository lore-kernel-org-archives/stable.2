Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC4B2E737E
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 06:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791267259; cv=none; b=la3gdB7N6Wu6GI3EVjsmX3keDhpXLfcKvnMomLDI3CN7kHYtwp64aQSUJdOY0RbN9y1lpmDLjALupU6cfoxd+qndwkY29jOg/RTl2tJEta1YPjzJlbYd5KbHJC7TijTWivZE8P0q5+GQVVHQZfrboqIm7Xpcr8aQGoL6oLn1yII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791267259; c=relaxed/simple;
	bh=fcY4p8z17weLxzT7Fs10+fGcXH/D8wfaxpDRZCQ03Cg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QRazE3nM33PyHD0m1AkoV0iLaSUDi78D2hfVIBeOq5zhiyzh929F7eRQxhqZKBrQ1mNC4Ufp8K3dbRv7PouXLFQxEa0FoBk0QRiqwoekdlvK7J/bBkhlWzCCCCl/vQ6jTgiWMc75CrQ6V4jEHtqZQ2wsoS9JWRh8SkS0rP43r5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EhOFm7ia; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EhOFm7ia"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791267256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9zZ5aL4QpTxtgEj8CNjX/E/lt1NREauZr/P3nTFrvSY=;
	b=EhOFm7iaVsqybaTqKAmlqlbV2AU4ewFvoiRYAjDrH7L7Kydf1Hh/tygiBcKZtbSjbkjFH9
	ElZQT5atzFwlkKBrOU7354ya6+wAJJNVCnSXwexZD7u5ukjXlfHs2mRKhko4rKtpR/Y9I8
	GoX5Dwthy8y2LpUPGgVdTALYS4I6SFI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-602-DLcV-1JwMMStanwR-8B0eQ-1; Tue,
 06 Oct 2026 02:14:13 -0400
X-MC-Unique: DLcV-1JwMMStanwR-8B0eQ-1
X-Mimecast-MFC-AGG-ID: DLcV-1JwMMStanwR-8B0eQ_1791267249
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6E72D1869BB4;
	Tue,  6 Oct 2026 06:14:08 +0000 (UTC)
Received: from snishika-thinkpadp16vgen1.tokyo.csb (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 75A6F1800473;
	Tue,  6 Oct 2026 06:13:59 +0000 (UTC)
From: Seiji Nishikawa <snishika@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Josh Don <joshdon@google.com>,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+681e729b2cf0d4860042@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	Seiji Nishikawa <snishika@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH] sched/core: Do not touch SMT siblings that have not joined the core yet
Date: Tue,  6 Oct 2026 15:12:53 +0900
Message-ID: <20261006061253.1199941-1-snishika@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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
Reported-by: syzbot+681e729b2cf0d4860042@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=681e729b2cf0d4860042
Cc: stable@vger.kernel.org
Signed-off-by: Seiji Nishikawa <snishika@redhat.com>
---
 kernel/sched/core.c       |  7 +++++++
 kernel/sched/core_sched.c |  3 +++
 kernel/sched/sched.h      | 11 +++++++++++
 3 files changed, 21 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1fe40de6ebe3..7f9330e2ef8e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6365,6 +6365,8 @@ pick_next_task(struct rq *rq, struct rq_flags *rf)
 	max = NULL;
 	for_each_cpu_wrap(i, smt_mask, cpu) {
 		rq_i = cpu_rq(i);
+		if (!sched_core_sibling(rq, rq_i))
+			continue;
 
 		/*
 		 * Current cpu always has its clock updated on entrance to
@@ -6398,6 +6400,9 @@ pick_next_task(struct rq *rq, struct rq_flags *rf)
 	 */
 	for_each_cpu(i, smt_mask) {
 		rq_i = cpu_rq(i);
+		if (!sched_core_sibling(rq, rq_i))
+			continue;
+
 		p = rq_i->core_pick;
 
 		if (!cookie_equals(p, cookie)) {
@@ -6444,6 +6449,8 @@ pick_next_task(struct rq *rq, struct rq_flags *rf)
 	 */
 	for_each_cpu(i, smt_mask) {
 		rq_i = cpu_rq(i);
+		if (!sched_core_sibling(rq, rq_i))
+			continue;
 
 		/*
 		 * An online sibling might have gone offline before a task
diff --git a/kernel/sched/core_sched.c b/kernel/sched/core_sched.c
index 43e0bde3038e..b21eade02c23 100644
--- a/kernel/sched/core_sched.c
+++ b/kernel/sched/core_sched.c
@@ -275,6 +275,9 @@ void __sched_core_account_forceidle(struct rq *rq)
 
 	for_each_cpu(i, smt_mask) {
 		rq_i = cpu_rq(i);
+		if (!sched_core_sibling(rq, rq_i))
+			continue;
+
 		p = rq_i->core_pick ?: rq_i->curr;
 
 		if (p == rq_i->idle)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e656c7059bf8..c65d9cb8ad2e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1513,6 +1513,17 @@ static inline raw_spinlock_t *__rq_lockp(struct rq *rq)
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
 extern bool
 cfs_prio_less(const struct task_struct *a, const struct task_struct *b, bool fi);
 
-- 
2.55.0

