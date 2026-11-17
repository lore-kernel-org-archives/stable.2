Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794932245;
	b=ZTycRNKpq2iuV7u5hhv1CqYxVC42BK6Rp+14tH4iovINLNZs3WpRY71KkNtfzpBTsU75
	 5n9VPlzJi2F6A12/8uiUMJVP9HzPoUZsuUwGoZKqFiqKJGQxHThRmrMAubZfP9xsDKqv6
	 l1t0rsSX4Zyelj2m+o2revcpTQrOoBOElqzpYYiY5q0sadwAKyu/yqjv2XfoVwWGFNkTT
	 iTFCU2FHtFXyI7YEgezfQBnpeXeHMp0IJVl15SaICaZwZ06zLmAih6E+fhjjlTPvERlLD
	 kTfnLGqop8p4jeynME36QXNho+/kVhabe0dRKaffusRLioYYAf6r5TkLTcGxHqYBOVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794932245;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zFMHS3iTvPTL4lMx2nmha2rZYOE4qD7+sjyLqjHBK9M=;
	b=nPhLxKkrmFAarw+CGhem+HpAa3006hf9Qmg+ENL54lUxPF0b3hCB8ey56M2IPPnnWlwr
	 PJlx27ZHAMGKlsmOZQTBZGUPfeaWcSMB18xiXw+gjeJnny+hwM9TchuCTRMlwrYU9wqLc
	 nX2yabCo1gQELgLE0MkJxvUyzcwMVjr/ddRjYr1WmrR3XW5mINDgeDD15mzxMVIC28vxz
	 HEc5yWlJBalwK+5N0nflZk975lM4Sd/RKQfys2Zi/puPVmJmigEnKWcyw7rgexw8mJc0K
	 CpgpC7Ib6X0XO87ZEi7jJ1FSs5VIODfU41DDqESDWquG8a8xnWmOWGR/AfE7cpJ2KmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=cBfVwpF8;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3309606A8A4;
	Tue, 17 Nov 2026 16:17:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3309606A8A4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=cBfVwpF8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1794932242;
	bh=zFMHS3iTvPTL4lMx2nmha2rZYOE4qD7+sjyLqjHBK9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cBfVwpF8LlRC3OTMgX6+oDFqBNpDY8KWRQ6HBfMaygd0svmS1ia7iA6eVvdLQU9ii
	 pCs/Hgyas869jQa4aA6jCkyTzVpRL3Cn54vlo5giTk0VlLxkf2rHqmC9L+SoOUEF8W
	 yt1V6N3MYEamoPkacy07uGkb24mooxD5PuLm4oPrM8yBkt3xQTtnVC/61u2hrJW5TZ
	 3+BzMdkL3zk3FKmbdaUGCerP9xkMg6wToKsdHrJjQpqMF8l03JU3ay0osVecUWjLvS
	 WMZcPbcVWj0S9JJEHVQa9ZGvPPvDuBtUsRLzDXr4lx4MX8VJ4Jbs1zXaIJ3snvhX5q
	 oGrXNuUxNoGdA==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jTVHk1ppWzRcG;
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
	stable@vger.kernel.org
Subject: [PATCH 05/17] sched/mmcid: Take the allowed CPUs of the first user when it joins
Date: Tue, 17 Nov 2026 11:17:05 -0500
Message-Id: <df251e85248861597f9e35ec0e3edbe188993c6a.1794932121.git.mathieu.desnoyers@efficios.com>
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

The CIDs of an mm are sized from the CPUs its threads are allowed on.
mm_init_cid() copies the allowed CPUs of the task into a new mm. Later
changes reach the mm through mm_update_cpus_allowed(). It uses the mm
the task points to, and ignores an mm with no user.

An affinity change between mm_init_cid() and the join of the first user
is lost. In this example, P is a task allowed on one CPU, and H is
another task:

  P                                     H

  execve()
    exec_mmap()
      mm_init_cid()
        copies the allowed CPUs of P
                                        sched_setaffinity(P, all CPUs)
                                          mm_update_cpus_allowed()
                                            the new mm has no user:
                                            ignored
    sched_mm_cid_after_execve()
      P joins the new mm, which
      counts one allowed CPU

From reading the code, a fork() child has the same window between
dup_mm() and sched_mm_cid_fork().

The new mm then stays sized for the CPUs allowed at that time. A
process that starts on one CPU and is widened to 64 CPUs during its
execve() switches to per CPU mode with its second thread. In testing,
two threads of such a process read mm_cid 0 and 63. The IDs stay below
the number of possible CPUs. They are no longer compact.

Fix this by adding the allowed CPUs of the first user to the mm when it
joins. Hold t->pi_lock for that, as an affinity change holds it. A
concurrent change is then in t->cpus_mask already, or it finds the user
and updates the mm itself.

Fixes: b0c3d51b54f8 ("sched/mmcid: Provide precomputed maximal value")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: stable@vger.kernel.org
---
 kernel/sched/core.c | 65 +++++++++++++++++++++++++++++++--------------
 1 file changed, 45 insertions(+), 20 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 510cd775723b..456b76e823b3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10833,24 +10833,17 @@ static bool mm_update_max_cids(struct mm_struct *mm)
 	return true;
 }
 
-static inline void mm_update_cpus_allowed(struct mm_struct *mm, const struct cpumask *affmsk)
+static void __mm_update_cpus_allowed(struct mm_struct *mm, const struct cpumask *affmsk)
 {
+	struct mm_mm_cid *mc = &mm->mm_cid;
 	struct cpumask *mm_allowed;
-	struct mm_mm_cid *mc;
 	unsigned int weight;
 
-	if (!mm || !READ_ONCE(mm->mm_cid.users))
-		return;
+	lockdep_assert_held(&mc->lock);
 	/*
 	 * mm::mm_cid::mm_cpus_allowed is the superset of each threads
 	 * allowed CPUs mask which means it can only grow.
 	 */
-	mc = &mm->mm_cid;
-	guard(raw_spinlock)(&mc->lock);
-	/* Might have raced with exit() */
-	if (!mm->mm_cid.users)
-		return;
-
 	mm_allowed = mm_cpus_allowed(mm);
 	weight = cpumask_weighted_or(mm_allowed, mm_allowed, affmsk);
 	if (weight == mc->nr_cpus_allowed)
@@ -10876,6 +10869,20 @@ static inline void mm_update_cpus_allowed(struct mm_struct *mm, const struct cpu
 	irq_work_queue(&mc->irq_work);
 }
 
+static inline void mm_update_cpus_allowed(struct mm_struct *mm, const struct cpumask *affmsk)
+{
+	/* The first user takes the allowed CPUs of its task when it joins */
+	if (!mm || !READ_ONCE(mm->mm_cid.users))
+		return;
+
+	guard(raw_spinlock)(&mm->mm_cid.lock);
+	/* Might have raced with exit() */
+	if (!mm->mm_cid.users)
+		return;
+
+	__mm_update_cpus_allowed(mm, affmsk);
+}
+
 static inline void mm_cid_complete_transit(struct mm_struct *mm, unsigned int mode)
 {
 	/*
@@ -11017,6 +11024,28 @@ static void sched_mm_cid_cleanup_execve(struct task_struct *t, struct mm_struct
 	cpumask_copy(mm_cpus_allowed(mm), &t->cpus_mask);
 }
 
+/*
+ * Make @t the first user of the CIDs of its mm.
+ *
+ * mm_init_cid() copied the allowed CPUs of @t before @t was a user. An
+ * affinity change since then did not reach the mm. Add the allowed CPUs
+ * of @t again. Hold t->pi_lock, which every affinity change takes. A
+ * concurrent change is then in t->cpus_mask already, or it finds the
+ * user.
+ */
+static void sched_mm_cid_add_first_user(struct task_struct *t, struct mm_struct *mm)
+{
+	guard(raw_spinlock_irq)(&t->pi_lock);
+	guard(raw_spinlock)(&mm->mm_cid.lock);
+
+	sched_mm_cid_cleanup_execve(t, mm);
+	sched_mm_cid_add_user(t, mm);
+	__mm_update_cpus_allowed(mm, &t->cpus_mask);
+	t->mm_cid.cid = mm_get_cid(mm);
+	/* Required for execve() */
+	__this_cpu_write(mm->mm_cid.pcpu->cid, t->mm_cid.cid);
+}
+
 /*
  * Make @t a user of the CIDs of its mm. Called on fork(2) and on
  * execve(2). A failed execve(2) rejoins the mm it left.
@@ -11041,19 +11070,15 @@ static void sched_mm_cid_fork(struct task_struct *t)
 	WARN_ON_ONCE(t->mm_cid.cid != MM_CID_UNSET);
 
 	guard(mutex)(&mm->mm_cid.mutex);
+	/* The mutex keeps other users from joining or leaving */
+	if (!mm->mm_cid.users) {
+		sched_mm_cid_add_first_user(t, mm);
+		return;
+	}
+
 	scoped_guard(raw_spinlock_irq, &mm->mm_cid.lock) {
 		struct mm_cid_pcpu *pcp = this_cpu_ptr(mm->mm_cid.pcpu);
 
-		/* First user ? */
-		if (!mm->mm_cid.users) {
-			sched_mm_cid_cleanup_execve(t, mm);
-			sched_mm_cid_add_user(t, mm);
-			t->mm_cid.cid = mm_get_cid(mm);
-			/* Required for execve() */
-			pcp->cid = t->mm_cid.cid;
-			return;
-		}
-
 		flip = sched_mm_cid_add_user(t, mm);
 		/*
 		 * A running joiner takes no CID at a schedule in before the
-- 
2.47.3

