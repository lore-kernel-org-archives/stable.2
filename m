Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794335914;
	b=Ls7vq66St81rY5D3UuV98R2GflRpJGXTdOEgu6tnqkjD95sbc8e8I3jkm+eDfUtKfZ5m
	 wDJ0YURC4fXILUUiaM0xGbmCICNhLPgAR02r93HRwUu7ikmdARSJHpKPi0JMXmTlzQ5iK
	 FozDHvHw0ofwJC9eghGGhxKm408Y1UVgdpWjFnyNKi+A3qAnD0lm89PNxjaTPVMPSCp9T
	 vr8WwfbzJwIg0ULol6VtAwK5i0ilVf/4ooxt2ORv3KtaBX1oSN2bgMZDZJHYPVW/NMX05
	 Sm3FLSm5+61ppenxOMp+f+1z+lPPXbYfuJr5sHUQMU9ObH5C1Wfqb1/TCxBSobuVs+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794335914;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Z5AvJ6uZvQp8gnIz/IJVqXh+TtL12nMC9fd5jn1sHhE=;
	b=etFE8Kf4/ydneHIUfVdE0GnHOYJd/yrCF3Y7yVz6FmafBvaGE2I2zMDJfcl7kMEDw5So
	 ENNlUwe+8ePNiOgKh386f/JDLLZuLxSDET6jl6cLq063zVOOg6oDqNp4JI28nHOUkEfBZ
	 bs2quHuMT5q7DFZIvomW1pP/+ktoYmKCLta4kD5K5WJekAyXs/i2PvBNfgAsxmMln0MeP
	 x6KRTURfWe3A1ZTFBG9HDY5UPvlrWPD27teo6ZRf2fA6b2c/+Jz11FLn1zqf5rHHlWNST
	 fxEG/MEpw6sh+P2t8sJyetqVm4759OyG4uLTgxeco73TJvSMy1hl36HDGbKcas6nb7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Pzf5V2M1;
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E299606A326
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:38:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E299606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Pzf5V2M1
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8b600fae14dso963631b3a.2
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 10:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794335913; x=1794940713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z5AvJ6uZvQp8gnIz/IJVqXh+TtL12nMC9fd5jn1sHhE=;
        b=Pzf5V2M1N+cyzs/l8rtwogl5Pm8dH2/nyX/0zzuXAw2q7JjEhR4cgAs8WAaYMHU9Tp
         BoYnxTo/jDg+mL0JlBmUsqjI63QEtDVSOK6GwQQChIali19YT9YoW0i7PQIwiDsu+L/O
         WoQoYcSnNmcFzFV2zXc4F4ZJmUftu0wlxBx+wmrs4efQfvvk0IUooQSrPOfD0lhR1U0F
         Z4/7WToP6Zv3HyFOwm7CX6PdJCs4CUeczqFS+9I8jgomvgCKVHYrJkY6fgk/4vNtyiN6
         eFQZ8k1GZd6Y6yAdwzEPJIH+4YyBPv41/6CWesEeDID+Ow9Pxd0+UfnpERAQtkoqgOAx
         IQQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794335913; x=1794940713;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z5AvJ6uZvQp8gnIz/IJVqXh+TtL12nMC9fd5jn1sHhE=;
        b=mO5hy5vpTQzYYDPYQhsSa5TA8LP/MkglLkEUuu3GI+C+xO88nSxg6pskMb5pBPuh43
         BTWPdx4esbOmF6dBzQmWbGOjJu/qCADUdOQ6tr5OW1f4UKlUXAtRSDTDvVMtKOs6ey2p
         AmIBITgV5xyMGwe44KjXD0Bq3h4SZxqNhq5aedoxUmTb65v1W1WpFe+VSYJF6+hkQ2eq
         xzdul7UWyYHlhEH2XxcWTJiSM0uqlFCDOOmVykEz7zrDJ+cbaq62lCqSOAmRJGPy1sgH
         RHjUFzut5ekCQHYjgh+U6v3cbMscYjEZU5qGPb85/SEymWnI/o1ahNUkWnY43oVMeELl
         FlDw==
X-Forwarded-Encrypted: i=1; AL+hErFiUNBwTMQ/gdNHBibh+qBwKeQTy+PO2HSDuHEUVURQ6emP5rF4mInGMw4fMxcuSgRioTt1qxE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9dQg3mq17ZcN277QPbyRPNkQRtISXcQ63Yn/I0KJq4D8ZOyORD
	To8nC8a5It0mO5V9HQcykptuqVwWp2zqH/AI9ZTMvvxugiO2x6+BfSA8
X-Gm-Gg: AYBFou03X1iohDX2+5Mt0bCGuQUxGZixg8/d7a3WmRyDSNXYTGXL7rQKKH84kB6YSXP
	GtTuHuBdnIRFRbX18f0M17koYnjgSloKOdsc4VK2UVLdG+zGhJOTieO6A7KoCklzOZtxMtoaxpp
	wEXZT32MC8LtgOjpFg8C1kCtoyaf16aJjcq0UW9zLm+A7T3NuMN4k3KG5DDtQVT//WZw/TgWiVH
	CDwmYwuhtcFTbWlWzCK7fMif0X7Evq04mirz/8+9HmXxGdxd0P4Fxi3jAMFZyzdry83MPR7ZmIg
	vckxC0syQtxis+osQ/2TY2Yrak4GxwuBnElHP/xgRuXeDH70jy/K5AC/Z1EVnEgcNSI1CbjTAcv
	7COYBshHThVbFB35QEnj/vVvXnSYhkECOfOHm5aeLEIaEMvTjyf/eDlyGGlbRUJcaXabCUOhufF
	aMBRkllQQ8Ii9pihXYkwSowxaH6Em7MLW8KfMIJledqnPcsBzmfJ5sa5wfpSpf9CmeWqeVqjR8y
	x93LK+iANsZNzmbPQSNIbp1NYHn93KSOqBR0etAbAXhLCvOe/MKTlnpNU7R3zMXRBNk4cpXQiJ7
	WnxVrWYRjS8D8whTHHh0sMjs/ZsFH56zLnFQPsPuKMFX7/EJjV8yrbGmWGHJm5k4kB+T4ro3ydr
	Wqg==
X-Received: by 2002:a05:6a00:4097:b0:8a0:3ed7:939e with SMTP id d2e1a72fcca58-8ba8764538fmr3337017b3a.60.1794335912831;
        Tue, 10 Nov 2026 10:38:32 -0800 (PST)
Received: from Terra.tail0ac356.ts.net ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baaa963bd1sm1257490b3a.29.2026.11.10.10.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 10:38:32 -0800 (PST)
From: Weiming Shi <bestswngs@gmail.com>
To: Kees Cook <kees@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org,
	co+cab19e2ebe4d535a@bugs.sh
Subject: [PATCH v3] sched/mmcid: Synchronize MM teardown with affinity updates
Date: Tue, 10 Nov 2026 10:38:08 -0800
Message-ID: <20261110183809.3308868-1-bestswngs@gmail.com>
X-Mailer: git-send-email 2.56.0
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
---
Changes in v3:
- Document the p->pi_lock grace period and acquire/release ordering.
- Use p->pi_lock directly and cover exit_mm() and kthread_unuse_mm().
- Refresh the KASAN trace and provide a standalone reproducer in reply.

Changes in v2:
- Replace the schedule-in deferral with an exec-side runqueue-lock barrier.
- Keep affinity expansions synchronous, including expansions narrowed before
  the next schedule-in.
- Avoid changes to the MM-CID fork, exit, and scheduling state machine.

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
index 1c93da75226e..f88ab0445be3 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2358,6 +2358,7 @@ static __always_inline void alloc_tag_restore(struct alloc_tag *tag, struct allo
 #ifdef CONFIG_SCHED_MM_CID
 void sched_mm_cid_before_execve(struct task_struct *t);
 void sched_mm_cid_after_execve(struct task_struct *t);
+void sched_mm_cid_mm_barrier(struct task_struct *t);
 void sched_mm_cid_exit(struct task_struct *t);
 static __always_inline int task_mm_cid(struct task_struct *t)
 {
@@ -2366,6 +2367,7 @@ static __always_inline int task_mm_cid(struct task_struct *t)
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
index 04b62c16fa8c..d78a174b5405 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -11128,6 +11128,15 @@ void sched_mm_cid_after_execve(struct task_struct *t)
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
2.56.0

