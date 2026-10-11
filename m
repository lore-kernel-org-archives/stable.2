Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064AE362149;
	Sun, 11 Oct 2026 17:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791739976; cv=none; b=ZK6xPVEuI9U8ylllvsiiho8K05Ogr1KU5z+1jy7u5IW33uO/QLRIxgc7PbwceR6Ztjqd0JjeuZz3ydbbHDbfZjQfbWvlcA/nwhA78B0tsrMy6fbn1bo9O/Ss0JiwQzkQuXt45vg8Avdvf3Krkxd6RA6zyzx9TifYek3wkHm2Bzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791739976; c=relaxed/simple;
	bh=uxkiMGeKj2/KNZ5mRlfBZkMbBLhC+o62WN6eC7D3UUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jl0RY27LqdvdZE1KujOVdhKcFUrFNcJc+vOLmfV1lps4mu093hs30GCOrnBqE2i4ex4hO54g++Ho9AstBduT84duPpmA6/jUpIYO1GbHEP+4uDjmm0NvqqgL0BjamiJkUdoUhrTocn/zgVzCjOF0wLT4kofu1R+cDoQHqV99e04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=P9QclTJ9; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="P9QclTJ9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=WJ
	Ib1jyh78r4I8mWZyE1xujU9RHwd3wnfLdlk+WKTxY=; b=P9QclTJ9fdmCIfOjk3
	lZv7Oc11Xo8QYuEHeW9ZUQoxVKqc3hxu/Zn78jCOJwc9ZDCm4cArUCwFWnwuxIm8
	yzYSHaV0JEv1n7XJ2reL4TLgd94EwlgS63epaKVYlj53hZTEe2IOpTy/LvuiYPTo
	n9iQ3n+NcTpD5Pl/Y47Z1Zsps=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3B8jTx8tq95gFEA--.10939S2;
	Mon, 12 Oct 2026 01:31:00 +0800 (CST)
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
Subject: [PATCH v3] sched_ext: idle: Respect task affinity in restricted CPU selection
Date: Mon, 12 Oct 2026 02:31:00 +0900
Message-ID: <20261011173100.2090211-1-sh_def@163.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3B8jTx8tq95gFEA--.10939S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxury5Ar4fWry7Gw4DKr45Jrb_yoWrWFWxpr
	97K3yagw4UXa1Iqa13AaykJw15ur1kA3yfKrWfWF4SyFsxGryF9r9Yq3ZrXF93Grn5ZF12
	9FnrtF4fKF4jywUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zi7GYPUUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbCwhW0FGrLx9U83gAA3m

The restricted select_cpu kfunc path handles single-CPU and
migration-disabled tasks without going through scx_select_cpu_dfl().

It currently uses prev_cpu as the candidate, even though prev_cpu is only a
hint and may no longer be usable after an affinity change. With a
caller-provided @allowed mask, this can also return an idle CPU outside
p->cpus_ptr.

Derive the candidate from task state instead: use the sole CPU in
p->cpus_ptr for single-CPU tasks and task_cpu(p) for migration-disabled
tasks. Validate it against p->cpus_ptr and @allowed before claiming its
idle state.

Since the derived candidate may be on a different NUMA node from
prev_cpu, also preserve SCX_PICK_IDLE_IN_NODE by rejecting cross-node
candidates.

Perform all checks before scx_idle_test_and_clear_cpu(), as a successful
call consumes the CPU's idle bit.

Fixes: 683d2d0faba1 ("sched_ext: idle: Introduce scx_bpf_select_cpu_and()")
Cc: stable@vger.kernel.org
Signed-off-by: Hui Su <sh_def@163.com>
---
Tested on x86_64 KVM/QEMU:
- Private BPF harness passed affinity, stale-prev_cpu, caller-mask, and
  cross-NUMA SCX_PICK_IDLE_IN_NODE cases; v2 returned CPU2 across nodes,
  while v3 returned -EBUSY.
- Build coverage passed with CONFIG_PREEMPT_RCU=y/n and CONFIG_SMP=n.

Changes in v3:
- Factor restricted selection into select_cpu_restricted().
- Preserve SCX_PICK_IDLE_IN_NODE and add cross-NUMA validation.

v2: https://lore.kernel.org/lkml/20261011131700.1351541-1-sh_def@163.com/

 kernel/sched/ext/idle.c | 50 ++++++++++++++++++++++++++++++++---------
 1 file changed, 39 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/ext/idle.c b/kernel/sched/ext/idle.c
index aa9fb6de0ad6..28ed9e327085 100644
--- a/kernel/sched/ext/idle.c
+++ b/kernel/sched/ext/idle.c
@@ -952,12 +952,43 @@ static bool is_bpf_migration_disabled(const struct task_struct *p)
 	return p->migration_disabled;
 }
 
+static s32 select_cpu_restricted(struct task_struct *p, s32 prev_cpu,
+				 const struct cpumask *allowed, u64 flags,
+				 bool migration_disabled)
+{
+	s32 cpu;
+
+	if (migration_disabled)
+		cpu = task_cpu(p);
+	else
+		cpu = cpumask_first(p->cpus_ptr);
+
+	if (!cpumask_test_cpu(cpu, p->cpus_ptr))
+		return -EBUSY;
+
+	if (allowed && !cpumask_test_cpu(cpu, allowed))
+		return -EBUSY;
+
+	if (flags & SCX_PICK_IDLE_IN_NODE) {
+		int node = scx_cpu_node_if_enabled(prev_cpu);
+
+		if (scx_cpu_node_if_enabled(cpu) != node)
+			return -EBUSY;
+	}
+
+	if (!scx_idle_test_and_clear_cpu(cpu))
+		return -EBUSY;
+
+	return cpu;
+}
+
 static s32 select_cpu_from_kfunc(struct scx_sched *sch, struct task_struct *p,
 				 s32 prev_cpu, u64 wake_flags,
 				 const struct cpumask *allowed, u64 flags)
 {
 	unsigned long irq_flags;
 	bool we_locked = false;
+	bool migration_disabled;
 	s32 cpu;
 
 	if (!scx_cpu_valid(sch, prev_cpu, NULL))
@@ -994,20 +1025,17 @@ static s32 select_cpu_from_kfunc(struct scx_sched *sch, struct task_struct *p,
 
 	/*
 	 * This may also be called from ops.enqueue(), so we need to handle
-	 * per-CPU tasks as well. For these tasks, we can skip all idle CPU
-	 * selection optimizations and simply check whether the previously
-	 * used CPU is idle and within the allowed cpumask.
+	 * per-CPU tasks as well. For these tasks, skip general idle CPU
+	 * selection and validate the task's only usable CPU directly.
 	 */
-	if (p->nr_cpus_allowed == 1 || is_bpf_migration_disabled(p)) {
-		if (cpumask_test_cpu(prev_cpu, allowed ?: p->cpus_ptr) &&
-		    scx_idle_test_and_clear_cpu(prev_cpu))
-			cpu = prev_cpu;
-		else
-			cpu = -EBUSY;
-	} else {
+	migration_disabled = is_bpf_migration_disabled(p);
+
+	if (p->nr_cpus_allowed == 1 || migration_disabled)
+		cpu = select_cpu_restricted(p, prev_cpu, allowed, flags,
+					    migration_disabled);
+	else
 		cpu = scx_select_cpu_dfl(p, prev_cpu, wake_flags,
 					 allowed ?: p->cpus_ptr, flags);
-	}
 
 	if (we_locked)
 		raw_spin_unlock_irqrestore(&p->pi_lock, irq_flags);

base-commit: 7b63ef2d55f24519e7e9e5f4d15dbea03f126e40

