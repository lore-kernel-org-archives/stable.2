Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E818628690;
	Sun, 11 Oct 2026 02:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791687290; cv=none; b=KwC11uHGoqODcmW+6xzU5anSkQecjUAiKpSo55H8+oFz1nEXg4v6B51YhHeGxQrzH3q35n8GPn/MUx1BhLLRerIMb+YNIfcPzcyUcVxGwVTVWNA6WII2t4qQcwBJfnyM85ku4v5ZQ1kuE0lY+JaEJIgg/X3GApDYL3k07NFihh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791687290; c=relaxed/simple;
	bh=hrAhgN+WxuZzsvJRuRPU3XKL8xQZzdQoWxjDGdqoFzY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HMhzXGhCLjGcKbnn+hInwfMUr0VR9vPmExpu22VLy1JUy8Z4lC5RZuVNxxE6CmlZzeCcTtMjnspB8hS1iCSUmmc2AeLCOCH/o+n14Sobzj+q/3TZQXGieM49pkYmqZ9W8KrGL2x4Z0f5xIaw1pVmYRIU368wvhWIYIZ551SeEzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=NgyAQ4Wi; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NgyAQ4Wi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=gT
	k4+pqBCprUe3qNcnVbCqhWfZmhAWbxb4XHLPlkfgM=; b=NgyAQ4WiIqmT284aZw
	Pu+Kys78gOEpIjrIxfkvnL8sv/+1qJP6i7iJ6xclNTMB6Ma5umPBnzoV/k9ViXuy
	r3rHP/XGliee58oo9n1tF8/44l1kd5aNHxX/KmExU2J6bdnWCHMBrCKL72dUAeIY
	J9I2ncudEg821/pRB5ePYBpA8=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wA3Q7oH+spqDdsmDw--.308S2;
	Sun, 11 Oct 2026 10:52:57 +0800 (CST)
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
	Hui Su <sh_def@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] sched_ext: idle: Respect task affinity in restricted CPU selection
Date: Sun, 11 Oct 2026 11:52:56 +0900
Message-ID: <20261011025256.4180374-1-sh_def@163.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA3Q7oH+spqDdsmDw--.308S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zw4rZF1ftryxury5WF17KFg_yoW8AF4UpF
	Wkt3y7KrsrJa10y3sxtaykKa45ur4kGw13KF1rWF4Syrs8Xr4FvrZ0q3Wagr90grsYvrWa
	kFnFqr4xtw4DtaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zi75r7UUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbCwQkObWrK+gmWEgAA38

The restricted select_cpu kfunc path handles single-CPU and
migration-disabled tasks without going through scx_select_cpu_dfl().

When a caller supplies @allowed, the path currently checks prev_cpu only
against that mask. It can therefore return an idle prev_cpu which isn't
in p->cpus_ptr.

Require prev_cpu to belong to both p->cpus_ptr and the caller-provided
mask before consuming its idle state.

Fixes: 683d2d0faba1 ("sched_ext: idle: Introduce scx_bpf_select_cpu_and()")
Cc: stable@vger.kernel.org
Signed-off-by: Hui Su <sh_def@163.com>
---
Testing:
- x86_64 KVM/QEMU.
- A private regression harness pinned the task to CPU 0 and called
  scx_bpf_select_cpu_and() with an idle CPU 1 outside the task affinity
  but inside the caller-provided mask.
- On the baseline kernel, the helper returned CPU 1.
- With this fix, the helper rejected the out-of-affinity CPU.
- The existing allowed_cpus selftest passed with the fix.

 kernel/sched/ext/idle.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext/idle.c b/kernel/sched/ext/idle.c
index aa9fb6de0ad6..20efa463cafa 100644
--- a/kernel/sched/ext/idle.c
+++ b/kernel/sched/ext/idle.c
@@ -999,7 +999,8 @@ static s32 select_cpu_from_kfunc(struct scx_sched *sch, struct task_struct *p,
 	 * used CPU is idle and within the allowed cpumask.
 	 */
 	if (p->nr_cpus_allowed == 1 || is_bpf_migration_disabled(p)) {
-		if (cpumask_test_cpu(prev_cpu, allowed ?: p->cpus_ptr) &&
+		if (cpumask_test_cpu(prev_cpu, p->cpus_ptr) &&
+		    (!allowed || cpumask_test_cpu(prev_cpu, allowed)) &&
 		    scx_idle_test_and_clear_cpu(prev_cpu))
 			cpu = prev_cpu;
 		else

base-commit: 7b63ef2d55f24519e7e9e5f4d15dbea03f126e40

