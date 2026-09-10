Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2456C492E30
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 15:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789055566; cv=none; b=DCcdcgfNDmVfc5fIKoZMWnWySHC4V3yWyM6LvmCA+021GOhJpBbAmHJBInKQkTdCAzDqCnHjz4tbja4jS/VsLp/0q2xM3ijmC8l37SO+a6XrM5GRk5vIxnZZ/LHMUdtuK5+7FkzXVPdq8PupyydWGrDWYLYxR8hV7IsztetQsx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789055566; c=relaxed/simple;
	bh=GEPqv91D2zt/P1o2mNkcpnWuADJHq0vR6hGWfAxAoF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZPNhSqtKaFGMuAAwQPDEqndpHPP5IcRhslQrbIkrGP8HjB2PmENSsP6OOw38WKhHaKimDYVKHkRWMA8HlBxl0Ux8N+7GnpUQOJM7Byh4GmFAOkaIjsgg8dkV+MP2S2fOBmcrViStc56lA4rySrDicDsMBKIee1KRv6ZjRZD2g4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJh7hF/x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJh7hF/x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D2AF1F00898;
	Thu, 10 Sep 2026 15:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789055564;
	bh=M/8xyqbjLZP/OVmsGKeXZsu3yRzciDw/814sz5sNnfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NJh7hF/xTF8I7mqnUx8iPoirXypVwCQKh5V2HzGzLI8BHFqFY8FqUIlyt87HRYMiL
	 YVBNOsYD3FvyEnYj+XSzqVtH/UEFj1cwHLeF7iojdLR6WIdOQMIC1h1MmR+Q08Hr6D
	 f2RmLdt8lINMOFpmJfPLm4HBaX1AezrCUfh8nJccATkjbSP8oQOykLtQRs7lOSXvw5
	 P0+rHRS4/8S/WstdGRVxoENHMGnRhl/wByNjVtZNwysGyFnI0EGsjFTPqWP71ej7Qw
	 5TOLxMIJWZl67bQQ4l8UjE4vTy03kwZPG5CD2eJ450rdyK/90iUe793WMnz8Dy2nWx
	 +VdGd87b3dRXQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Yao Kai <yaokai34@huawei.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] futex: Provide rt_mutex_.*_schedule() equivalents for futex scheduling
Date: Thu, 10 Sep 2026 11:52:41 -0400
Message-ID: <20260910155241.1081251-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910155241.1081251-1-sashal@kernel.org>
References: <2026090837-colonist-magnify-011d@gregkh>
 <20260910155241.1081251-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 912edebe8501a36c6bedcef03bd238ab90a7e060 ]

There is rt_mutex_{pre|post}_schedule() around
rt_mutex_wait_proxy_lock() to ensure that sched_submit_work()/
sched_update_worker() is invoked before we schedule out and block on
rt_mutex while waiting for it become available.

The reason is that blocking on rt_mutex assigns a pi_waiter for the PI
chain and sched_submit_work() will also assign a pi_waiter if it blocks
on lock but a this point we already have a waiter assigned.
We can't skip sched_submit_work() entirely because I/O relies on the
fact that I/O queue is flushed while it blocks on a sleeping lock.
Therefore sched_submit_work() is moved before we block on the lock.

Sleeping lock in this context means mutex or rw_semaphore not spinlock_t
on PREEMPT_RT. Because the mutex abstraction on PREEMPT_RT uses the same
abstraction as the futex proxy lock, the futex code ended up using
rt_mutex_{pre|post}_schedule(), too.
Using it is/ was just to keep the task_struct::sched_rt_mutex assertion
happy. Futex proxy lock is used only in the syscall context of a task.
At this point it never got any I/O that needs to be flushed and it can't
be a workqueue that needs to notify that it will be scheduled out.
Therefore sched_submit_work() does nothing here.

By mistake futex_wait_requeue_pi() -> rt_mutex_wait_proxy_lock() did not
get the rt_mutex_{pre|post}_schedule() annotation. This was not noticed
because in this callchain the lock is (usually) not contended and so
rt_mutex_slowlock_block() does not schedule, triggering the assert.

Adding rt_mutex_pre_schedule() here looks wrong (as noted by PeterZ)
because at this point there is a pi_waiter recorded and invoking
sched_submit_work() with a possible lock contention would be wrong.

Add rt_mutex_futex_{pre|post}_schedule() which toggles the
sched_rt_mutex assert and does not involve sched_submit_work(). Add
asserts here to ensure that sched_submit_work() would do nothing. Use it
only in futex proxy lock case which is rt_mutex_wait_proxy_lock().
Remove it from futex_lock_pi().

Fixes: d14f9e930b90 ("locking/rtmutex: Use rt_mutex specific scheduler helpers")
Reported-by: Yao Kai <yaokai34@huawei.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260901135453.3121948-2-bigeasy@linutronix.de
Closes: https://lore.kernel.org/all/20260717084922.4153317-2-yaokai34@huawei.com
[ adjusted futex context for older locking code lacking private-hash handling and futex_q_lockptr_lock(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/sched/rt.h     |  2 ++
 kernel/futex/pi.c            | 10 ----------
 kernel/locking/rtmutex_api.c |  2 ++
 kernel/sched/core.c          | 16 ++++++++++++++++
 4 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/include/linux/sched/rt.h b/include/linux/sched/rt.h
index 4e3338103654c..922935cc33833 100644
--- a/include/linux/sched/rt.h
+++ b/include/linux/sched/rt.h
@@ -52,8 +52,10 @@ static inline bool rt_or_dl_task_policy(struct task_struct *tsk)
 
 #ifdef CONFIG_RT_MUTEXES
 extern void rt_mutex_pre_schedule(void);
+extern void rt_mutex_futex_pre_schedule(void);
 extern void rt_mutex_schedule(void);
 extern void rt_mutex_post_schedule(void);
+extern void rt_mutex_futex_post_schedule(void);
 
 /*
  * Must hold either p->pi_lock or task_rq(p)->lock.
diff --git a/kernel/futex/pi.c b/kernel/futex/pi.c
index ccd5d19dea68a..258faa26e6f9d 100644
--- a/kernel/futex/pi.c
+++ b/kernel/futex/pi.c
@@ -992,12 +992,6 @@ int futex_lock_pi(u32 __user *uaddr, unsigned int flags, ktime_t *time, int tryl
 		goto no_block;
 	}
 
-	/*
-	 * Must be done before we enqueue the waiter, here is unfortunately
-	 * under the hb lock, but that *should* work because it does nothing.
-	 */
-	rt_mutex_pre_schedule();
-
 	rt_mutex_init_waiter(&rt_waiter);
 
 	/*
@@ -1065,10 +1059,6 @@ int futex_lock_pi(u32 __user *uaddr, unsigned int flags, ktime_t *time, int tryl
 	 * the
 	 */
 	spin_lock(q.lock_ptr);
-	/*
-	 * Waiter is unqueued.
-	 */
-	rt_mutex_post_schedule();
 no_block:
 	/*
 	 * Fixup the pi_state owner and possibly acquire the lock if we
diff --git a/kernel/locking/rtmutex_api.c b/kernel/locking/rtmutex_api.c
index 5b438aa71f872..51622ce539e48 100644
--- a/kernel/locking/rtmutex_api.c
+++ b/kernel/locking/rtmutex_api.c
@@ -380,6 +380,7 @@ int __sched rt_mutex_wait_proxy_lock(struct rt_mutex_base *lock,
 {
 	int ret;
 
+	rt_mutex_futex_pre_schedule();
 	raw_spin_lock_irq(&lock->wait_lock);
 	/* sleep on the mutex */
 	set_current_state(TASK_INTERRUPTIBLE);
@@ -390,6 +391,7 @@ int __sched rt_mutex_wait_proxy_lock(struct rt_mutex_base *lock,
 	 */
 	fixup_rt_mutex_waiters(lock, true);
 	raw_spin_unlock_irq(&lock->wait_lock);
+	rt_mutex_futex_post_schedule();
 
 	return ret;
 }
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ea106403abd86..41ab7cfed2fd6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7097,6 +7097,17 @@ void rt_mutex_pre_schedule(void)
 	sched_submit_work(current);
 }
 
+/*
+ * Used within the futex syscall context, skips sched_submit_work() because none
+ * its work will be done. Asserts ensure that it is indeed the case.
+ */
+void rt_mutex_futex_pre_schedule(void)
+{
+	lockdep_assert(!(current->flags & (PF_WQ_WORKER | PF_IO_WORKER)));
+	lockdep_assert(!current->plug);
+	lockdep_assert(!fetch_and_set(current->sched_rt_mutex, 1));
+}
+
 void rt_mutex_schedule(void)
 {
 	lockdep_assert(current->sched_rt_mutex);
@@ -7109,6 +7120,11 @@ void rt_mutex_post_schedule(void)
 	lockdep_assert(fetch_and_set(current->sched_rt_mutex, 0));
 }
 
+void rt_mutex_futex_post_schedule(void)
+{
+	lockdep_assert(fetch_and_set(current->sched_rt_mutex, 0));
+}
+
 /*
  * rt_mutex_setprio - set the current priority of a task
  * @p: task to boost
-- 
2.53.0

