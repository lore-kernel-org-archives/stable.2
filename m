Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794144422;
	b=Z4vZPmkflQV76/hItRLeafxFRVtJ2cunTJst4UCLZtWHyE5ihsZ8BIy5CAQaYw5k+Vnb
	 7XZJvmrQe2W+qNGwliquuIJ+6024s5xnK0UGRHjLH9+qNU/MNdNcLlrgxjpJ7i2ov1QtD
	 dedjsJoaD8rUU/LqGfQjOIQPaVajmjj+fHM1qG/Pofs4XUXtaVLE+kjcVTa51IqIA1DLz
	 WE/rL41oJpfiUX28IQSk97hkpIeaxChRAv4Ya3IVLNEYfanZ4ck/FHWfZ5dTQvLTmJ1MJ
	 qxyQhDP8dAjaFLai0Wyw8V8ekSt8+SwNgwh/UYUgyktgAA4eKi43qtpiYo36bmmoEYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794144422;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=skj1A/Qk1B90HdOqj6Z23qjSvuBRIrG5eMGulfPCes0=;
	b=xVU8OdqEJQyZDbvCL1Egn1SCLVYyJ5EzlhZohdBl9fXbQWZ7ir1XjwCHJP4+7Omz3zNr
	 RIh1pHeUyZTWWv5Lrrjp93++fAx4AFrABeq1ZoFOKcPfQDJRz5DlhxZYS+xHMZ981Mc6+
	 /TaULUUNX3tr62hTF5btv0137e3fWsT00qlkOxPmz60Gv8acQJ3K+VEbo2oAFJCM2nIMr
	 RR9gGELtjSIlzs0vc5mDvky6VBWbVFzQ85vSCXRLYf4ruKlDBdSIBUpueYj06DkDuTKgC
	 6XD03WA5i26KZ8ePfTEl9omSNJSitrDRocer9yyuOrvEgk9jI3yD2PvZiP6buqPKeKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E7MKaulz;
	arc=none smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5CC606A31C
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 13:27:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C5CC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E7MKaulz
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cdb628232d2so35356a12.0
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 05:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794144421; x=1794749221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=skj1A/Qk1B90HdOqj6Z23qjSvuBRIrG5eMGulfPCes0=;
        b=E7MKaulzaMalTGg+PABbRJMLYHs38eQH5gXJz/xfONQdMIKFOV0nxM6OoBdXqViY56
         arItdpCg2K3VpCoRtuGnUpfoQiU4Dn9esofa/umovc4rZ6rxY6vzWOzxbEOC5jpfw7rJ
         7i15aAX9+sg95iQl2Uk8uRKIJ457ot3MmSsrO8A0jpW6oDSDnlbVmS9HcVhgjHlJCtFb
         P+2um1si5NJeDz0D4/YrO1DqFyEGNy23OodBjYzbuubLJaluD+6BcPwnimihqwNwVp2k
         diTmN50QCnOzHRj8WQf1EAkhCRBqdfKNx1mGLaAWais//UjKdGTsiX4i/optpMD0ip+Q
         IahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794144421; x=1794749221;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=skj1A/Qk1B90HdOqj6Z23qjSvuBRIrG5eMGulfPCes0=;
        b=s0OzJTrP2tz4qhiStjvdyXnbjBOzXyxB6aF1BQYCQ2YFD4aqcPKf87OqDRWCQ7x98p
         OmPrl33hrbwH33eUwN3h5P3vOZ4b6ZrtnB4trmScyliiOdjD0KlHkiUM5V3cWpGB8AEE
         WRhUk/7HID3VqaPZh9usxRQkA+FwfH99/y+dWS98iPdq99M7nucdw6yFu5ART0s+ViD8
         XCzpOC8I0M8yuVY+aSsNlwxWfWJq7WuI79FSkhCVeNTDlHAkzCxZkQepNy+3hiShYPFJ
         Mzv86XRtJxXBDiwtXUXNZF8+DYqIQt+4RqCm08WGOd9UKWtNaxOegVXo21E3LwBAOnZh
         qlOQ==
X-Forwarded-Encrypted: i=1; AL+hErEGkJSqGh9/749eeDVzY8i3lwZQWnElJQneIb4mCo8DfMxmq2vV/lirBMiY93QrXYpl3g9P7L8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9TEQk8PaqHXCwTWNL1OP8uW5OX1AvfdEw0PgjYvignZMA1zg/w
	yi85PqjSIy3qA01OQ9e+D+41OqIrf0ZmKCUU/hUndiIFssSTATfcIKeE
X-Gm-Gg: AYBFou2Ejy4UIBu0Vd1sNX0AKjupxwyEbzsk3Zmq2cW5EP2CLTi8ZGzfq+UQHj+iAZN
	cmzmkF2hKghDkfn6esKJkJTqsXK3Plbpg1rtzvr/VfvHo9yhP4Zrg5OBpNE8D38PCaFZslvxOJC
	J5PqXQNvo+qq9X9UMybFGXkJgyk9Omg31NpxXd1coNemz6Z3WNr7vGFruOXGn4kpRAzHUD0nA27
	hdKboKqrOSHr3FRHDHkv/tvURYeUpAdY3rzVYJqD4XXGsXJgJBWJehmsuUYt7QTiG0GY22OmkLt
	8XR6dBHkhvG0SOq6k8P/tsyYJl4hCmH63sfDiNDnYcOYB1enJdYgFzNE8krxwWLkQCXSl7IVvRm
	ISG5tcK9gLBjpnhqN/aUpzqqRiev+4f6tHjsJxVazI7+AEMWej90SMOD/EDA0XwxeW302TnqP3W
	0BPfYiHJHX6ngvEaKEHXXbUoVET4+Jj8T6Hp7NdzKZcb0JBNrui/np88i3cWH+Sl9V6YCFvWtwQ
	hbF5egZIP00sH0MFXFlb+rKuwAWv+Nbl/CK8FpfF8yJOIvLIzcYUuCUqgyk/whKlIdB0P0ceD22
	SHPFuXYXQpg4LOfKDRX1H6PH+qZMUtjLdFsDeQFiRfRsIOO4sS0Tl8QoQX7av/U8FB1O+hWvMd9
	41w==
X-Received: by 2002:a17:90b:5404:b0:3ad:a462:f07f with SMTP id 98e67ed59e1d1-3b12d508413mr1204359a91.45.1794144421361;
        Sun, 08 Nov 2026 05:27:01 -0800 (PST)
Received: from Terra.tail0ac356.ts.net ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1278918f4sm2949795a91.6.2026.11.08.05.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 05:27:00 -0800 (PST)
From: Weiming Shi <bestswngs@gmail.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Cc: linux-kernel@vger.kernel.org,
	Marco Elver <elver@google.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	co+cab19e2ebe4d535a@bugs.sh,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] sched/mmcid: Synchronize exec MM teardown with affinity updates
Date: Sun,  8 Nov 2026 05:26:35 -0800
Message-ID: <20261108132634.2650642-2-bestswngs@gmail.com>
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
mm_update_cpus_allowed(), but the scheduler locks do not stabilize that
pointer against exec. A same-owner sched_setaffinity() can race the target
replacing and freeing its old mm. Current kernels are only incidentally
serialized by futex_exec_done() taking p->pi_lock when CONFIG_FUTEX=y;
valid CONFIG_FUTEX=n builds remain vulnerable.

  BUG: KASAN: slab-use-after-free in set_cpus_allowed_common (kernel/sched/core.c:10835 kernel/sched/core.c:2829)
  Read of size 4 at addr ffff88810991b04c by task poc/5127
  Call Trace:
   set_cpus_allowed_common (kernel/sched/core.c:10835 kernel/sched/core.c:2829)
   set_cpus_allowed_fair (kernel/sched/fair.c:10046)
   __set_cpus_allowed_ptr_locked (kernel/sched/core.c:2842 kernel/sched/core.c:3224)
   __set_cpus_allowed_ptr (kernel/sched/core.c:3258)
   __sched_setaffinity (kernel/sched/syscalls.c:1161)
   sched_setaffinity (kernel/sched/syscalls.c:1239)
   __x64_sys_sched_setaffinity (kernel/sched/syscalls.c:1275)
   do_syscall_64 (arch/x86/entry/syscall_64.c:84)
   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)

  Freed by task 5128:
   kmem_cache_free (mm/slub.c:6757)
   __mmput (kernel/fork.c:1204)
   mmput (kernel/fork.c:1215)
   setup_new_exec (fs/exec.c:1395)
   load_elf_binary (fs/binfmt_elf.c:1024)
   bprm_execve (fs/exec.c:1865)
   do_execveat_common.isra.0 (fs/exec.c:1963)
   __x64_sys_execve (fs/exec.c:2036)
   do_syscall_64 (arch/x86/entry/syscall_64.c:84)
   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)

After exec publishes the new p->mm, acquire and release the task's runqueue
lock before the old mm can be dropped. Affinity updates already hold that
lock across set_cpus_allowed_common(), so the barrier waits for any update
that loaded the old mm. Updates that start afterwards observe the new mm.

This keeps allowed-mask updates synchronous, including transient affinity
expansions, without changing the MM-CID fork, exit, or scheduling paths.

This change was developed with assistance from an LLM.

Fixes: 7e019dcc470f ("sched: Improve cache locality of RSEQ concurrency IDs for intermittent workloads")
Cc: stable@vger.kernel.org
Reported-by: <co+cab19e2ebe4d535a@bugs.sh>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
Changes in v2:
- Replace the schedule-in deferral with an exec-side runqueue-lock barrier.
- Keep affinity expansions synchronous, including expansions narrowed before
  the next schedule-in.
- Avoid changes to the MM-CID fork, exit, and scheduling state machine.

 fs/exec.c             | 1 +
 include/linux/sched.h | 2 ++
 kernel/sched/core.c   | 6 ++++++
 3 files changed, 9 insertions(+)

diff --git a/fs/exec.c b/fs/exec.c
index 8d2b14e1d455..2e1cac6a3de7 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -905,6 +905,7 @@ static int exec_mmap(struct linux_binprm *bprm)
 		BUG_ON(active_mm != old_mm);
 		/* Defer teardown to setup_new_exec(), outside the exec locks. */
 		bprm->old_mm = old_mm;
+		sched_mm_cid_exec_mmap(tsk);
 	} else {
 		mmdrop_lazy_tlb(active_mm);
 	}
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 1c93da75226e..9b3d4d609273 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2358,6 +2358,7 @@ static __always_inline void alloc_tag_restore(struct alloc_tag *tag, struct allo
 #ifdef CONFIG_SCHED_MM_CID
 void sched_mm_cid_before_execve(struct task_struct *t);
 void sched_mm_cid_after_execve(struct task_struct *t);
+void sched_mm_cid_exec_mmap(struct task_struct *t);
 void sched_mm_cid_exit(struct task_struct *t);
 static __always_inline int task_mm_cid(struct task_struct *t)
 {
@@ -2366,6 +2367,7 @@ static __always_inline int task_mm_cid(struct task_struct *t)
 #else
 static inline void sched_mm_cid_before_execve(struct task_struct *t) { }
 static inline void sched_mm_cid_after_execve(struct task_struct *t) { }
+static inline void sched_mm_cid_exec_mmap(struct task_struct *t) { }
 static inline void sched_mm_cid_exit(struct task_struct *t) { }
 static __always_inline int task_mm_cid(struct task_struct *t)
 {
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 04b62c16fa8c..c9fc8c1cd46f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -11128,6 +11128,12 @@ void sched_mm_cid_after_execve(struct task_struct *t)
 		sched_mm_cid_fork(t);
 }
 
+/* Wait for affinity updates that may still be using the old MM. */
+void sched_mm_cid_exec_mmap(struct task_struct *t)
+{
+	guard(task_rq_lock)(t);
+}
+
 static void mm_cid_work_fn(struct work_struct *work)
 {
 	struct mm_struct *mm = container_of(work, struct mm_struct, mm_cid.work);
-- 
2.56.0

