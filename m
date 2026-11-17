Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794932244;
	b=iC9Vg0krt1/4ddS86rO8Ue/qWOz1sZvydYxhLScmQN6950a5HAxIUqhD98XiKtGOgNRA
	 Q/R/mZPx05MYvStPnAv5xFaIF8SI857wAmuc2D4RXqfSo2Ygr0HJaG7vlAsmCvahwn/1y
	 nuXOfAuH3Y0dCtiuTYbxQ3pBFinoO8HibZh2ePb5G1XgL/fzLmGAihaATTH3qDgFE9GxQ
	 cMqNEY0DxErgNktmHW+gC0MolDHHl8hoioxv1KXj4XqaXfFkjuEeNRc/jLUEFlzSIiSgX
	 GyEdoK3qbvg8SM2W6tNJnqGRXsckY944/6tKOOLXv1usLbF0jAIaY3GGlhSIpHvVy8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794932244;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CfJVYl8d7qdtMu+pXKIuXS8SjsAEQjuLyjcfQyGXzHw=;
	b=mNOXQ5LeT3Xhu9Nt1dO3sQ7BJLb1QYIKV1eEZZtM9fl++yGnXaiOrkXt+PPGs34A+Adc
	 OeHrvxJg31jzI2dTHl2YoSZacALb/A2kkbkmlzgQI37KV/qSoE1fP///4+J0hBFLVOfjD
	 GovfoOclwLZ+4OEQBsBCW3TqOgtFA7ZfJtj0R3CeuoBpdBwT1vQ7ekFVbNcLCiGZTSDFX
	 6qF6mzlEFoUzZhmJ4q96kptvBt/u33XuTR5/ej/jwIvwz6/mzp+kE0MkjH2D8pvWlYm5N
	 4pFOV3lvGdk3nkZHd04ACgcJ+9iCOAG2J3pa1zXNpk98UbbXVW3FrlP0tufk7dMDdiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=xiRImFeZ;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD8C606A8A1;
	Tue, 17 Nov 2026 16:17:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDD8C606A8A1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=xiRImFeZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1794932242;
	bh=CfJVYl8d7qdtMu+pXKIuXS8SjsAEQjuLyjcfQyGXzHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xiRImFeZD6zn8N1cKU87FaBUXW7qWxpd/dReIsv3iWScG0aHGA4xQK5WpLP31IPoc
	 Jt4XIGjtMQDhfLqDah6YaGrdo+wLBdGQeWHbhOEtMZ4+D+mw+nevK64ZTokqSq2l+m
	 4ipl2N06TbQszjJIUby9epNaZGyv+mMNIH0UH1v+EQ22MfxoqDNK2wuacYmVG/iT7A
	 me2o7vftkFnkaWNymDLcw2v5voYFr7Oc0Cg2aol6KAf61KJUKnQEE6KMKjyW+7Hkj+
	 iS1VnK9R7SQQkrZR61d45CVN3Qa95WfzWtZJrcrB5L6hetad/33LusDTWf19xnNDbN
	 FMExrGjIxfsPg==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jTVHk39MCzRHW;
	Tue, 17 Nov 2026 11:17:22 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: tglx@kernel.org,
	peterz@infradead.org
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	mingo@redhat.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	paulmck@kernel.org,
	boqun@kernel.org,
	shuah@kernel.org,
	kees@kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	oleg@redhat.com,
	bestswngs@gmail.com,
	xmei5@asu.edu,
	xujiakai24@mails.ucas.ac.cn,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org,
	co+cab19e2ebe4d535a@bugs.sh
Subject: [PATCH 06/17] sched/mmcid: Synchronize MM teardown with affinity updates
Date: Tue, 17 Nov 2026 11:17:06 -0500
Message-Id: <cb90e1d7ec582b72eb5d3b15633a1fc149ec1a57.1794932121.git.mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1794932121.git.mathieu.desnoyers@efficios.com>
References: <cover.1794932121.git.mathieu.desnoyers@efficios.com>
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

From: Weiming Shi <bestswngs@gmail.com>

set_cpus_allowed_common() passes a remote task's p->mm to
mm_update_cpus_allowed() while holding p->pi_lock, but that lock did not
stabilize the pointer against MM replacement. A same-owner
sched_setaffinity() caller can therefore retain the old pointer while exec
replaces and frees it. On architectures which shoot down rather than
refcount lazy TLB MMs, exit_mm() and kthread_unuse_mm() have the same
lifetime gap.

  BUG: KASAN: slab-use-after-free in set_cpus_allowed_common
  Read of size 4 at addr ffff888123155e4c by task poc/5132
  Call Trace:
   set_cpus_allowed_common (kernel/sched/core.c:10835)
   set_cpus_allowed_fair (kernel/sched/fair.c:10046)
   __set_cpus_allowed_ptr_locked (kernel/sched/core.c:3224)
   __set_cpus_allowed_ptr (kernel/sched/core.c:3258)
   __sched_setaffinity (kernel/sched/syscalls.c:1161)
   sched_setaffinity (kernel/sched/syscalls.c:1239)
   __x64_sys_sched_setaffinity (kernel/sched/syscalls.c:1275)
   do_syscall_64 (arch/x86/entry/syscall_64.c:84)
   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)

  Freed by task 5127:
   kmem_cache_free (mm/slub.c:6757)
   __mmput (kernel/fork.c:1204)
   mmput (kernel/fork.c:1215)
   setup_new_exec (fs/exec.c:1395)
   load_elf_binary (fs/binfmt_elf.c:1024)
   bprm_execve (fs/exec.c:1865)
   do_execveat_common.isra.0 (fs/exec.c:1963)
   __x64_sys_execveat (fs/exec.c:2047)
   do_syscall_64 (arch/x86/entry/syscall_64.c:84)
   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)

  Kernel panic - not syncing: KASAN: panic_on_warn set ...

Affinity paths hold p->pi_lock across the p->mm load and its complete use.
After publishing a replacement or NULL p->mm, take and release that same
lock before dropping the old MM reference. For an updater that is already
using the old pointer, the ordering is:

  affinity updater                     MM teardown
  ----------------                     -----------
  raw_spin_lock(&p->pi_lock)
  mm = p->mm            /* old_mm */
                                       p->mm = new_mm or NULL
                                       raw_spin_lock(&p->pi_lock)
                                         /* waits */
  mm_update_cpus_allowed(mm, mask)
  raw_spin_unlock(&p->pi_lock) /* release */
                                         /* acquire succeeds */
                                       raw_spin_unlock(&p->pi_lock)
                                       ...
                                       mmput/mmdrop(old_mm)

The teardown-side acquire cannot complete until an updater ordered before
it has released p->pi_lock, so old_mm remains alive throughout that
updater's access. If teardown is ordered first instead, its unlock is a
release that orders the preceding p->mm store before a later updater's lock
acquire. The later updater therefore observes new_mm or NULL. An updater
that acquired the lock before the store but has not loaded p->mm yet is
still ordered before the teardown-side acquisition; it may observe either
pointer, but teardown waits for its complete use before dropping old_mm.

All runtime callers of set_cpus_allowed_common() hold p->pi_lock across
this access. The runqueue lock is not part of the p->mm lifetime ordering,
so the grace period only needs p->pi_lock. Place it after publication and
before the old reference drop in exec_mmap(), exit_mm(), and
kthread_unuse_mm(). The last two paths matter on architectures which shoot
down rather than refcount lazy TLB MMs.

This change was developed with assistance from an LLM.

Fixes: 7e019dcc470f ("sched: Improve cache locality of RSEQ concurrency IDs for intermittent workloads")
Cc: stable@vger.kernel.org
Reported-by: <co+cab19e2ebe4d535a@bugs.sh>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/all/20261110183809.3308868-1-bestswngs@gmail.com/
---
 fs/exec.c             | 1 +
 include/linux/sched.h | 2 ++
 kernel/exit.c         | 1 +
 kernel/kthread.c      | 1 +
 kernel/sched/core.c   | 9 +++++++++
 5 files changed, 14 insertions(+)

diff --git a/fs/exec.c b/fs/exec.c
index 8d2b14e1d455..3196421cb81d 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -905,6 +905,7 @@ static int exec_mmap(struct linux_binprm *bprm)
 		BUG_ON(active_mm != old_mm);
 		/* Defer teardown to setup_new_exec(), outside the exec locks. */
 		bprm->old_mm = old_mm;
+		sched_mm_cid_mm_barrier(tsk);
 	} else {
 		mmdrop_lazy_tlb(active_mm);
 	}
diff --git a/include/linux/sched.h b/include/linux/sched.h
index e4f6323d7855..8da4b88f434c 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2360,6 +2360,7 @@ static __always_inline void alloc_tag_restore(struct alloc_tag *tag, struct allo
 #ifdef CONFIG_SCHED_MM_CID
 void sched_mm_cid_before_execve(struct task_struct *t);
 void sched_mm_cid_after_execve(struct task_struct *t);
+void sched_mm_cid_mm_barrier(struct task_struct *t);
 void sched_mm_cid_exit(struct task_struct *t);
 static __always_inline int task_mm_cid(struct task_struct *t)
 {
@@ -2368,6 +2369,7 @@ static __always_inline int task_mm_cid(struct task_struct *t)
 #else
 static inline void sched_mm_cid_before_execve(struct task_struct *t) { }
 static inline void sched_mm_cid_after_execve(struct task_struct *t) { }
+static inline void sched_mm_cid_mm_barrier(struct task_struct *t) { }
 static inline void sched_mm_cid_exit(struct task_struct *t) { }
 static __always_inline int task_mm_cid(struct task_struct *t)
 {
diff --git a/kernel/exit.c b/kernel/exit.c
index d5e7bc2af804..5f9979d6216c 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -582,6 +582,7 @@ static void exit_mm(void)
 	local_irq_enable();
 	task_unlock(current);
 	mmap_read_unlock(mm);
+	sched_mm_cid_mm_barrier(current);
 	mm_update_next_owner(mm);
 	mmput(mm);
 	if (test_thread_flag(TIF_MEMDIE))
diff --git a/kernel/kthread.c b/kernel/kthread.c
index fdb8fb07f40b..e7b393cfdcee 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -1682,6 +1682,7 @@ void kthread_unuse_mm(struct mm_struct *mm)
 	enter_lazy_tlb(mm, tsk);
 	local_irq_enable();
 	task_unlock(tsk);
+	sched_mm_cid_mm_barrier(tsk);
 
 	mmdrop(mm);
 }
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 456b76e823b3..c4475344f6f2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -11229,6 +11229,15 @@ void sched_mm_cid_after_execve(struct task_struct *t)
 		sched_mm_cid_fork(t);
 }
 
+/*
+ * Pair with set_cpus_allowed_common()'s p->pi_lock critical section. Call
+ * after publishing p->mm and before dropping the old MM reference.
+ */
+void sched_mm_cid_mm_barrier(struct task_struct *t)
+{
+	guard(raw_spinlock_irq)(&t->pi_lock);
+}
+
 static void mm_cid_work_fn(struct work_struct *work)
 {
 	struct mm_struct *mm = container_of(work, struct mm_struct, mm_cid.work);
-- 
2.47.3

