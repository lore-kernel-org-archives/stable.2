Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE29E448D11;
	Sun, 11 Oct 2026 13:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791724727; cv=none; b=VHD4SAQc2UdI16V7olS3U5LOAf6TNRr9OXGym1KxYzxgcBgBomA0MPzYAdUtmpfrn61yZAK3+eRDrx9i6DVE7aIdMC0s20jUVG58/kFj98jzwSE62+f1nDDbZhrvMfzxxxF038ZCM6UyeBa8AYqrcQjmAsLb406rjKg7/2eguCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791724727; c=relaxed/simple;
	bh=t8UuEKhu5JXkAPu45ZUXWAfV2UasjGtxjZbqYUHs9Cg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r6RlQ8rpP1hKdgn85AyfiDr1QpF0AGSegI+mMoxMHrXscOYw/YdZSbBO9o5Um0G8ZKdfn67AWAZM3h76itI+7oPife8kao31q2h+esMkd2Jdkf3B30d+oHNmU+JRGZLpvYyprHM9UWqu8ztRVT5d8BOBK3Bk/XVWGkI/WPCUNdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ZYwbKmR4; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZYwbKmR4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=iL
	r+wm+n5REuBuunKDSCeG4oSd1yJjxQBNlTObmFnkA=; b=ZYwbKmR45xEhWvACcX
	zVGKRD3AAmfB2g/ifcv6YvCSlUbJLvx/jDuWc/ER+Qv9Jku2+I+8QLfdId4KbLNT
	Ph6WDU1yuNQm3VuK0nUqcuspgreM/bjZaWfbL/ri+9QcTk+Br1aM1jHJDXPwMUPI
	Jn3jbbOvbgB4YF2Z76Bh5zi48=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wDXV6tLjMtqB6qpDw--.58841S2;
	Sun, 11 Oct 2026 21:17:01 +0800 (CST)
From: Hui Su <sh_def@163.com>
To: tj@kernel.org
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	sh_def@163.com,
	stable@vger.kernel.org
Subject: [PATCH v2] sched_ext: idle: Respect task affinity in restricted CPU selection
Date: Sun, 11 Oct 2026 22:17:00 +0900
Message-ID: <20261011131700.1351541-1-sh_def@163.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXV6tLjMtqB6qpDw--.58841S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWrWUtF45Ww4UCr17WFyrCrg_yoWrGryrpr
	ykKw42gwsrJa10y3W3Aw4kJF15Zrs7C3yftrWfGr4SyFZ0gw109rWvq3W3XF95Kr4kAF42
	vF4qqr1fKa1qy37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zi75r7UUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbCwQ7DI2rLjE5erQAA3-

The restricted select_cpu kfunc path handles single-CPU and
migration-disabled tasks without going through scx_select_cpu_dfl().

It currently uses prev_cpu as the candidate. However, prev_cpu is only a
hint and may no longer be usable after an affinity change. When the caller
supplies @allowed, the restricted path can also claim and return an idle
CPU which isn't in p->cpus_ptr.

Derive the candidate from task state instead. Use the sole CPU in
p->cpus_ptr for single-CPU tasks and task_cpu(p) for migration-disabled
tasks. Validate the candidate against the task's effective affinity and
the caller-provided mask before claiming its idle state.

The validation must happen before scx_idle_test_and_clear_cpu(), as a
successful call consumes the CPU's idle bit. A later placement validation
therefore cannot undo the idle-state side effect.

Single-CPU and migration-disabled tasks skip ops.select_cpu(), so this
path can instead be reached when the CPU-selection kfunc is called from
other contexts such as ops.enqueue(). The normal ops.select_cpu() path is
unchanged.

Fixes: 683d2d0faba1 ("sched_ext: idle: Introduce scx_bpf_select_cpu_and()")
Cc: stable@vger.kernel.org
Signed-off-by: Hui Su <sh_def@163.com>
---
Testing:
- x86_64 KVM/QEMU private BPF test-run harness:
  - The baseline returned CPU1 outside the task affinity; v2 returned
    -EBUSY.
  - With a stale prev_cpu, the baseline returned -EBUSY; v2 selected the
    task's idle CPU0.
  - A caller mask excluding the task's candidate CPU returned -EBUSY with v2.
- The stock sched_ext allowed_cpus selftest passed.
- Built vmlinux and bzImage with CONFIG_PREEMPT_RCU=y.
- Built kernel/sched/build_policy.o with CONFIG_PREEMPT_RCU=n and CONFIG_SMP=n.

Changes in v2:
- Derive the restricted-path candidate from task state instead of prev_cpu.
- Document the idle-bit side effect and the ops.enqueue() reachability.

v1: https://lore.kernel.org/lkml/20261011025256.4180374-1-sh_def@163.com/
---
 kernel/sched/ext/idle.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/ext/idle.c b/kernel/sched/ext/idle.c
index aa9fb6de0ad6..1ccea60e9012 100644
--- a/kernel/sched/ext/idle.c
+++ b/kernel/sched/ext/idle.c
@@ -958,6 +958,7 @@ static s32 select_cpu_from_kfunc(struct scx_sched *sch, struct task_struct *p,
 {
 	unsigned long irq_flags;
 	bool we_locked = false;
+	bool migration_disabled;
 	s32 cpu;
 
 	if (!scx_cpu_valid(sch, prev_cpu, NULL))
@@ -995,14 +996,21 @@ static s32 select_cpu_from_kfunc(struct scx_sched *sch, struct task_struct *p,
 	/*
 	 * This may also be called from ops.enqueue(), so we need to handle
 	 * per-CPU tasks as well. For these tasks, we can skip all idle CPU
-	 * selection optimizations and simply check whether the previously
-	 * used CPU is idle and within the allowed cpumask.
+	 * selection optimizations and simply check whether the task's only
+	 * usable CPU is idle and within the allowed cpumask.
 	 */
-	if (p->nr_cpus_allowed == 1 || is_bpf_migration_disabled(p)) {
-		if (cpumask_test_cpu(prev_cpu, allowed ?: p->cpus_ptr) &&
-		    scx_idle_test_and_clear_cpu(prev_cpu))
-			cpu = prev_cpu;
+	migration_disabled = is_bpf_migration_disabled(p);
+
+	if (p->nr_cpus_allowed == 1 || migration_disabled) {
+		if (migration_disabled)
+			cpu = task_cpu(p);
 		else
+			cpu = cpumask_first(p->cpus_ptr);
+
+		if ((migration_disabled &&
+		     !cpumask_test_cpu(cpu, p->cpus_ptr)) ||
+		    (allowed && !cpumask_test_cpu(cpu, allowed)) ||
+		    !scx_idle_test_and_clear_cpu(cpu))
 			cpu = -EBUSY;
 	} else {
 		cpu = scx_select_cpu_dfl(p, prev_cpu, wake_flags,

base-commit: 7b63ef2d55f24519e7e9e5f4d15dbea03f126e40
-- 
2.55.0

