Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA0F414A34;
	Fri,  4 Sep 2026 06:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788502553; cv=none; b=k5uLYGFEKpZcCTvraxV2XBEt2m+doMo8sFcr66XXqJ7DMyltdf6isJHDcdGRk8VYV1AVzRivFBqXlI1Wi0Kerjmucs3zDnwHZRcn18YKYysMBSO18VhVlVrWNhS6MyXJ7mDvvyGtzNXg6/N0Fe3GFljYhwMLy9To4YIZ2xj6eLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788502553; c=relaxed/simple;
	bh=2GEmX+siaE/2gYc1uoZWnHbHoc0fZVxRSO0UAukmHKE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RmjpPduAUP+AODrcQS8Q0kJTPcf19ur06EIle/rsWGIVi5RJRD2NZoc5iri5iK5jcgw6XjZW3fBs5x9pMxgccUStVuOpzv2qCFjLhF4fhGvCyKBdTXTvLGK6kclYmPG7YhFgPhKmd6jmRlULNIF2NK0wt+YhucNUfWsSOwmJbLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Qt4n/ayR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o5+2bmZ6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Qt4n/ayR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o5+2bmZ6"
Date: Fri, 04 Sep 2026 06:15:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788502550;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7x6F2ORGUs0Nsr/MEi1ZQohQO+goTDjg+7r0QRYCHfE=;
	b=Qt4n/ayRFjD7EbHDDYA905uunWj4TA56hfMlClJLJ7lq6s2f7m+VEuxDWgHzGVDcXnFJUP
	DkwW4jzQhIPnELzyMR55HJ8asPKMzQ10nOtxvHW3vIAn1i7mPIo8PPMSW9LRwwuRjVSYeV
	4tEG94Q9YT/hSe3SLGD3V/o5YEVgSfiwT5NapcC4X6wiRlwc8TXTQbYKEOVotNuLYJutL+
	6cIISaPBGKNLKpSfOFQr+XyDeJ2ptuRzn5W8wkLcjL+3ZzIZDTZ3fmrqpUBPlkdTtrARfB
	0lul1r1975tthgX+ieP0rBG9z0ZGPdTfoRpQJBDLmeFl4SS1l0VSBfLV6dTFyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788502550;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7x6F2ORGUs0Nsr/MEi1ZQohQO+goTDjg+7r0QRYCHfE=;
	b=o5+2bmZ6XASmhqwtgJj/XRjkNNXdDm7aAM1lFlQXGkNTGb+a+wfiQL5pSTGhS4x54dxfku
	z0Mk6rS7xmS8EfCQ==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] futex: Provide rt_mutex_.*_schedule()
 equivalents for futex scheduling
Cc: Yao Kai <yaokai34@huawei.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@kernel.org>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260901135453.3121948-2-bigeasy@linutronix.de>
References: <20260901135453.3121948-2-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178850254865.3717435.17561363745894875547.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     912edebe8501a36c6bedcef03bd238ab90a7e060
Gitweb:        https://git.kernel.org/tip/912edebe8501a36c6bedcef03bd238ab90a=
7e060
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Tue, 01 Sep 2026 15:54:51 +02:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Fri, 04 Sep 2026 08:14:15 +02:00

futex: Provide rt_mutex_.*_schedule() equivalents for futex scheduling

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

Fixes: d14f9e930b90 ("locking/rtmutex: Use rt_mutex specific scheduler helper=
s")
Reported-by: Yao Kai <yaokai34@huawei.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260901135453.3121948-2-bigeasy@linutronix.de
Closes: https://lore.kernel.org/all/20260717084922.4153317-2-yaokai34@huawei.=
com
---
 include/linux/sched/rt.h     |  2 ++
 kernel/futex/pi.c            | 16 +++-------------
 kernel/locking/rtmutex_api.c |  2 ++
 kernel/sched/core.c          | 16 ++++++++++++++++
 4 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/include/linux/sched/rt.h b/include/linux/sched/rt.h
index 4e33381..922935c 100644
--- a/include/linux/sched/rt.h
+++ b/include/linux/sched/rt.h
@@ -52,8 +52,10 @@ static inline bool rt_or_dl_task_policy(struct task_struct=
 *tsk)
=20
 #ifdef CONFIG_RT_MUTEXES
 extern void rt_mutex_pre_schedule(void);
+extern void rt_mutex_futex_pre_schedule(void);
 extern void rt_mutex_schedule(void);
 extern void rt_mutex_post_schedule(void);
+extern void rt_mutex_futex_post_schedule(void);
=20
 /*
  * Must hold either p->pi_lock or task_rq(p)->lock.
diff --git a/kernel/futex/pi.c b/kernel/futex/pi.c
index 88788e5..98f1b96 100644
--- a/kernel/futex/pi.c
+++ b/kernel/futex/pi.c
@@ -1070,17 +1070,11 @@ retry_private:
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
=20
 		rt_mutex_init_waiter(&rt_waiter);
=20
@@ -1146,10 +1140,6 @@ cleanup:
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
index 5d48d64..eb18b09 100644
--- a/kernel/locking/rtmutex_api.c
+++ b/kernel/locking/rtmutex_api.c
@@ -423,6 +423,7 @@ int __sched rt_mutex_wait_proxy_lock(struct rt_mutex_base=
 *lock,
 {
 	int ret;
=20
+	rt_mutex_futex_pre_schedule();
 	raw_spin_lock_irq(&lock->wait_lock);
 	/* sleep on the mutex */
 	set_current_state(TASK_INTERRUPTIBLE);
@@ -433,6 +434,7 @@ int __sched rt_mutex_wait_proxy_lock(struct rt_mutex_base=
 *lock,
 	 */
 	fixup_rt_mutex_waiters(lock, true);
 	raw_spin_unlock_irq(&lock->wait_lock);
+	rt_mutex_futex_post_schedule();
=20
 	return ret;
 }
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f782751..449ccd8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7637,6 +7637,17 @@ void rt_mutex_pre_schedule(void)
 	sched_submit_work(current);
 }
=20
+/*
+ * Used within the futex syscall context, skips sched_submit_work() because =
none
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
@@ -7649,6 +7660,11 @@ void rt_mutex_post_schedule(void)
 	lockdep_assert(fetch_and_set(current->sched_rt_mutex, 0));
 }
=20
+void rt_mutex_futex_post_schedule(void)
+{
+	lockdep_assert(fetch_and_set(current->sched_rt_mutex, 0));
+}
+
 /*
  * rt_mutex_setprio - set the current priority of a task
  * @p: task to boost
