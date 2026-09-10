Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84ADD4A0F0B
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 14:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789049188; cv=none; b=mGQy7rI+Zh6qcmyy9UEW8gaDtvPN6PC8865BpEWg1jptG3idls3XPM7kRdIoTWqWLcZdu5AMCzFP1j5lVhKGGqHegp8KUFjltf7g4Hr0xXBgT5l97xpJDfbPn7qwZHlP8k/y+F/11StJdLE24YRsbsmOElbLdCmanjizhaUECqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789049188; c=relaxed/simple;
	bh=wBIqwE+pvuE5/8o/mSEZKkSHFnwtMxKRDlVAeM2vLFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RA6hCCJbpZHgBWmxk1MmT0KqvW9iCf9mt5KBe4TewoplTVoZ3UMNRsKA72EvqCM9jksVKe0vuWu7wkXhg13cMuJlwQn2W5CXoWCwzV94zmHrVtHD+Zat6QsalX3urAQxt8GY4wUk3m8DvDoyIEpRgGiZ2JARTkB3yH5AZO2YzXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kVHRjitM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kVHRjitM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59EC91F008A1;
	Thu, 10 Sep 2026 14:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789049185;
	bh=tF0a6AkLWbFajPXJXqfT/n6z03Rm6zIDFT0XrY0p7EI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kVHRjitMPJRBB0ed4bLywcmi1Gu7FSvxtAGwymAQfzkyfVGdIaA9Xph+jQ3JAU+HE
	 j5gUx2boODTnYvcI5n3yW++WnKJghUO8sFyN2153nOeCeD20jfbfP3A4yZ2s1VI88m
	 EV1IiuMG+ZRIMn3IpcbBSwUveusn1Zq1BprFrC9lWCi6CK8FoygzjGjGqmqhiNr53V
	 tNvGYt3cOk2MUn+2mwJsD+ZSX8IkdEIwOv9lf470StDC7RTXSbNTt/5jhZDDSPSMbe
	 a6ae5uDhUjQkWixsENfNtBOT6J02ItROLuANvxrR70oqzrqBlqdyQQR92bdeZf8PcW
	 qxtCshF6MBzWQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Yao Kai <yaokai34@huawei.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/3] futex: Provide rt_mutex_.*_schedule() equivalents for futex scheduling
Date: Thu, 10 Sep 2026 10:06:22 -0400
Message-ID: <20260910140622.565169-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910140622.565169-1-sashal@kernel.org>
References: <2026090836-asparagus-jujitsu-9a6e@gregkh>
 <20260910140622.565169-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/sched/rt.h     |  2 ++
 kernel/futex/pi.c            | 16 +++-------------
 kernel/locking/rtmutex_api.c |  2 ++
 kernel/sched/core.c          | 16 ++++++++++++++++
 4 files changed, 23 insertions(+), 13 deletions(-)

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
index f1b4f3e3e805e..86f972c10fe8b 100644
--- a/kernel/futex/pi.c
+++ b/kernel/futex/pi.c
@@ -1064,17 +1064,11 @@ int futex_lock_pi(u32 __user *uaddr, unsigned int flags, ktime_t *time, int tryl
 		 * Caution; releasing @hb in-scope. The hb->lock is still locked
 		 * while the reference is dropped. The reference can not be dropped
 		 * after the unlock because if a user initiated resize is in progress
-		 * then we might need to wake him. This can not be done after the
-		 * rt_mutex_pre_schedule() invocation. The hb will remain valid because
-		 * the thread, performing resize, will block on hb->lock during
-		 * the requeue.
+		 * then we might need to wake him. The hb will remain valid
+		 * because the thread, performing resize, will block on
+		 * hb->lock during the requeue.
 		 */
 		futex_private_hash_put(no_free_ptr(hbr.fph));
-		/*
-		 * Must be done before we enqueue the waiter, here is unfortunately
-		 * under the hb lock, but that *should* work because it does nothing.
-		 */
-		rt_mutex_pre_schedule();
 
 		rt_mutex_init_waiter(&rt_waiter);
 
@@ -1140,10 +1134,6 @@ int futex_lock_pi(u32 __user *uaddr, unsigned int flags, ktime_t *time, int tryl
 		 * the
 		 */
 		futex_q_lockptr_lock(&q);
-		/*
-		 * Waiter is unqueued.
-		 */
-		rt_mutex_post_schedule();
 no_block:
 		/*
 		 * Fixup the pi_state owner and possibly acquire the lock if we
diff --git a/kernel/locking/rtmutex_api.c b/kernel/locking/rtmutex_api.c
index 73af81b99bf62..928860be7a4aa 100644
--- a/kernel/locking/rtmutex_api.c
+++ b/kernel/locking/rtmutex_api.c
@@ -398,6 +398,7 @@ int __sched rt_mutex_wait_proxy_lock(struct rt_mutex_base *lock,
 {
 	int ret;
 
+	rt_mutex_futex_pre_schedule();
 	raw_spin_lock_irq(&lock->wait_lock);
 	/* sleep on the mutex */
 	set_current_state(TASK_INTERRUPTIBLE);
@@ -408,6 +409,7 @@ int __sched rt_mutex_wait_proxy_lock(struct rt_mutex_base *lock,
 	 */
 	fixup_rt_mutex_waiters(lock, true);
 	raw_spin_unlock_irq(&lock->wait_lock);
+	rt_mutex_futex_post_schedule();
 
 	return ret;
 }
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b5b5897b595b4..6c7853bd00b5c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7312,6 +7312,17 @@ void rt_mutex_pre_schedule(void)
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
@@ -7324,6 +7335,11 @@ void rt_mutex_post_schedule(void)
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

