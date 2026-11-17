Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794932243;
	b=cV6jkT3pvn+EavCRbci0APCyyCqD5VzzOOEi5PjstP8Jkyv4wij4dB9l/bbrSoN2VI7R
	 6PoY93Sd1/5eTdgLs+QAQH0VZxs6CELDvaIFbj1t2T5kmGtDvN/5Io5x14UZ/B6Pqj+sj
	 ujAUtUJ/Y+DZLfdX8ze8yPq47HE4Z0MeNI0nG5Y6r9X75nu4EmI3ZBGISmcvq8WdYq7q3
	 Eebz8XPyGyoXKrrtgnMymJSWFQxYpv/ijZVyGvhbgjsbyqamcZUJzeRTyosG4Lk/KZv5z
	 uWcAOwXZC+hQ+XUyyWzVcCyNuLmHL315AT3n2KAtIbEO7kXduZQf0pbpbxq4662WFMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794932243;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CbT445wpUVOQuseHxKqXDJcQzACyRBO0wZvsiVSVyj4=;
	b=qJB+UKvwPfNb1/J6DhTQofWGBFEekm7jVE+giqx/a6Wn9/XyNTkjsmnijXYzl2zRFKZz
	 y82I7eTie+Dc+dJWzmUWUINmFPI6s5oRjhTD4GFX5Dk4VZwsIsHZO/o0RVgLtN+mno3Gs
	 9sBGKIGCd8DuUPP6vbOVSPN97Dqkl2zgBcHJQY2MF7amQtJ0tHSXlhbHssLby75cqPC0p
	 /M9RkbIYtRLRlzVUlTxnEMS371O//9DzAlXa/Wl4KrPuVTXbT8hfHgQlqwhmUmoiA2aSd
	 5lvTLdCf0rlaijsyh8XB6QAJqnEgA2ozRgnx9JCfbqqh/cQSUY/+Xyuj8OJyeUIO8Jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=LlQ6HgCA;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDC1606A330;
	Tue, 17 Nov 2026 16:17:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDDC1606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=LlQ6HgCA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1794932241;
	bh=CbT445wpUVOQuseHxKqXDJcQzACyRBO0wZvsiVSVyj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LlQ6HgCAK6mDmXs48rJgePPsA4NTN42mq46a2a6S9K7N5+GeGljnBH4ekWusIuvFf
	 tElsGuHI7TXi6LQ3A+m3NEFihfKS2HiZuI5PIS+tbP0om86ajW2QSlKWH/rFWaYj1A
	 dvDa0uxxZpraqHiUJKc9GJ4uw999OTBtJo3qcskN6n5PXIRwwMepb2NPHKFiPP9q2G
	 j8N+1xdk9GuAfC4S55xy60GfaTU6FGAYRieMJPN//2a3ryOM3/w/OPE0d3VsT1BRoT
	 XOQAKD9C5tsVgciZ8ejhelPXvTlxu6xfPAEFOwMrsMHFHcDn6rHuTBM/ltCmAQCZbV
	 uRMLYARiPJqtg==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jTVHj6MbDzRKX;
	Tue, 17 Nov 2026 11:17:21 -0500 (EST)
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
	stable@vger.kernel.org
Subject: [PATCH 03/17] sched/mmcid: Reset stale state when the first user joins an mm
Date: Tue, 17 Nov 2026 11:17:03 -0500
Message-Id: <b03714bdaf30f1b552d46caf22f4e1e77ca9e6ff.1794932121.git.mathieu.desnoyers@efficios.com>
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

sched_mm_cid_exit() ignores the mode change when the last user of an mm
leaves. Its comment says there is nothing to do. That holds for an exit:
the mm goes away. It holds for a successful execve() too, which joins a
new mm.

A failed execve() is missed. It leaves the mm in
sched_mm_cid_before_execve() and rejoins the same mm in
sched_mm_cid_after_execve(). If the last user left in per CPU mode,
MM_CID_TRANSIT stays set and the other CPUs still own their CIDs.

In the diagram below, the machine has two CPUs. T is the main thread
of a process. The four threads it creates only wait. H is another
process. It stays on CPU 1.

  CPU 0                                     CPU 1

  T: creates four threads
     the mm switches to per CPU mode
                                            T: runs on CPU 1
                                               CPU 1 owns a CID
  T: runs on CPU 0 again
     CPU 0 owns a CID
  T: joins the four threads
     T is the only user left
  T: execve()
     sched_mm_cid_before_execve()
       T leaves as the last user
       drops the CID of CPU 0
       MM_CID_TRANSIT is set
       CPU 1 still owns its CID
                                            H: sched_setaffinity(T, CPU 1)
                                            T: migrates to CPU 1
                                               execve() fails
                                               sched_mm_cid_after_execve()
                                                 sched_mm_cid_fork(T)
                                                   T is the first user
                                                   mm_get_cid() succeeds
                                                   writes that CID to the
                                                   storage of CPU 1
                                                   the CID CPU 1 owned keeps
                                                   its bit, with no owner

The mm has one CID fewer from then on. Once every remaining CID is
taken, mm_get_cid() loops forever with interrupts disabled. On a guest
with two CPUs, the next pthread_create() of T does not return:

  rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
  RIP: 0010:sched_mm_cid_fork+0x1dd/0x660
   copy_process+0x2339/0x2ca0
   kernel_clone+0xc3/0x3c0
   __do_sys_clone3+0xe2/0x130

Per CPU mode lasts down to one user when mm_cid_calc_pcpu_thrs() returns
1. It does with two or three possible CPUs. It also does on any machine
when the mm is allowed a single CPU. The lockup was reproduced in the
first case only.

Fix this in sched_mm_cid_fork(), when the first user joins an mm whose
mode is not 0. Clear the mode, the CID of every CPU and the CID bitmap,
and take the allowed CPUs of the task. A new mm has mode 0, so this
does nothing for it.

sched_mm_cid_exit() stays as it is. The last user of an mm that goes
away runs no fixup.

Also check the user count again under the lock in
mm_update_cpus_allowed(). An affinity change can race with the last
user leaving. It would change the allowed CPUs of an mm with no user.

With this patch, in the same test, T keeps CID 0 after the failed
execve() and its next pthread_create() returns.

[ mathieu: wrote the changelog from the thread; the code is Thomas's
  draft, placed on the current sched_mm_cid_fork() ]

Fixes: 653fda7ae73d ("sched/mmcid: Switch over to the new mechanism")
Originally-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/87mrs8bhp4.ffs@fw13/
---
 kernel/sched/core.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7e213e88ac28..ab68e8605eed 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10847,6 +10847,10 @@ static inline void mm_update_cpus_allowed(struct mm_struct *mm, const struct cpu
 	 */
 	mc = &mm->mm_cid;
 	guard(raw_spinlock)(&mc->lock);
+	/* Might have raced with exit() */
+	if (!mm->mm_cid.users)
+		return;
+
 	mm_allowed = mm_cpus_allowed(mm);
 	weight = cpumask_weighted_or(mm_allowed, mm_allowed, affmsk);
 	if (weight == mc->nr_cpus_allowed)
@@ -10986,6 +10990,33 @@ static bool sched_mm_cid_add_user(struct task_struct *t, struct mm_struct *mm)
 	return mm_update_max_cids(mm);
 }
 
+/*
+ * sched_mm_cid_exit() does not handle the mode switch for the last user
+ * because for normal exit() that's a pointless exercise. But if the
+ * process which issued execve() was multithreaded and the last exiting
+ * thread switched back from per CPU mode then this leaves stale state
+ * around. The indicator for that is mm_cid::mode having MM_CID_TRANSIT
+ * set.
+ */
+static void sched_mm_cid_cleanup_execve(struct task_struct *t, struct mm_struct *mm)
+{
+	if (likely(!mm->mm_cid.mode))
+		return;
+
+	WARN_ON_ONCE(mm->mm_cid.mode & MM_CID_ONCPU);
+	mm->mm_cid.mode = 0;
+
+	unsigned int cpu;
+
+	for_each_possible_cpu(cpu)
+		per_cpu(mm->mm_cid.pcpu->cid, cpu) = 0;
+
+	bitmap_zero(mm_cidmask(mm), num_possible_cpus());
+
+	mm->mm_cid.nr_cpus_allowed = t->nr_cpus_allowed;
+	cpumask_copy(mm_cpus_allowed(mm), &t->cpus_mask);
+}
+
 /*
  * Make @t a user of the CIDs of its mm. Called on fork(2) and on
  * execve(2). A failed execve(2) rejoins the mm it left.
@@ -11015,6 +11046,7 @@ static void sched_mm_cid_fork(struct task_struct *t)
 
 		/* First user ? */
 		if (!mm->mm_cid.users) {
+			sched_mm_cid_cleanup_execve(t, mm);
 			sched_mm_cid_add_user(t, mm);
 			t->mm_cid.cid = mm_get_cid(mm);
 			/* Required for execve() */
-- 
2.47.3

