Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B67D248F7C
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 09:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785143420; cv=none; b=aNepOf0cP1k8KALHgoLPlWZM0Xorbqfv6qu53+DdvuDjBg+FYwJp0uLdqfC++0C3Am8rqSStFKQxHixDlW//OCZIDf1E33NZ9swyrpj7LGedYrSwKkRZLNN5UyGXqyGOQjQf7j5cAvO/nSKLVgp3Ie1FMDhKi8k1wJdTtmBm0iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785143420; c=relaxed/simple;
	bh=ohBMJFwqwqKObYL1PpoyaztOWJ2rzruHNxjp4rcV8gk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lunQxVvHh7KGdFNtw1lk5Wzi+hs+3QQw7K4dtPnVzao/1sj+IKXSfFZ0rJZty6v+0GDGP+43YpTks2tG3ej1PYSegP++xIcmykOqUyj+9z9ZwYdPZITAcLrjAQx/4k2CvpjNT31UqWePrp/EbD6g+3843g18r3uiqkE8TY6IH5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=by62Krt/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="by62Krt/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 550BE1F000E9;
	Mon, 27 Jul 2026 09:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785143418;
	bh=NhpgzwKlxgQtSrSgP70n+xJ7hKQ1XIOfgceweqMfKvo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=by62Krt/uFV65f4m1Bu6IBs1E7vLddZlyrkRfEj6CtcMao7Q8KkQk/+IzDrpzfIVp
	 ua8gwcvP8qNScYooi1GZ8YxD82h5WCs1ChkprvbvDod79dU8zig91x+LxsC5fgkAdO
	 hIhTdtNEDlbk4ByiA/eSX0z/lVkXgpCTUdyYK51wrCLmnAEdXLWuF8kroFW+kVmBZz
	 8yYpMgLlN6LRCHQRMqcsUc5/QQP02ionO7/UYSSXYkp9gPw7P2rvaPMstdj04iaZAm
	 69ba65B53ygjIWrOfT1XVUC+W5hwlhtwma2e7M6DU4JO1bijhtT2l0u0CayEgebPAd
	 BqNK26N/b8B/Q==
From: Thomas Gleixner <tglx@kernel.org>
To: Sasha Levin <sashal@kernel.org>, gregkh@linuxfoundation.org,
 jwlee2217@gmail.com, oleg@redhat.com, qw3rtyp0@gmail.com
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Subject: [PATCH V2 5.15.y, 6.1.y, 6.6.y] posix-cpu-timers: Prevent UAF
 caused by non-leader exec()
In-Reply-To: <87wluhie86.ffs@fw13>
References: <87ecgqkf54.ffs@fw13> <20260726195203.stable-0004@kernel.org>
 <87wluhie86.ffs@fw13>
Date: Mon, 27 Jul 2026 11:10:14 +0200
Message-ID: <87tspkiyrt.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

From: Thomas Gleixner <tglx@kernel.org>

commit 920f893f735e92ba3a1cd9256899a186b161928d upstream.

Wongi and Jungwoo decoded and reported a non-leader exec() related race
which can result in an UAF:

 sys_timer_delete()			exec()
   posix_cpu_timer_del()
   // Observes old leader
   p = pid_task(pid, pid_type);		de_thread()
   					  switch_leader();
					  release_task(old_leader)
					    __exit_signal(old_leader)
					      sighand = lock(old_leader, sighand);
					      posix_cpu_timers*_exit();
   sighand = lock_task_sighand(p)	      unhash_task(old_leader);
     sh = lock(p, sighand)	    	      old_leader->sighand = NULL;
					      unlock(sighand);
     (p->sighand == NULL)
	unlock(sh)
	return NULL;

   // Returns without action
   if(!sighand)
      return 0;
   free_posix_timer();

This is "harmless" unless the deleted timer was armed and enqueued in
p->signal because on exec() a TGID targeted timer is inherited.

As sys_timer_delete() freed the underlying posix timer object
run_posix_cpu_timers() or any timerqueue related add/delete operations on
other timers will access the freed object's timerqueue node, which results
in an UAF.

There is a similar problem vs. posix_cpu_timer_set(). For regular posix
timers it just transiently returns -ESRCH to user space, but for the use
case in do_cpu_nanosleep() it's the same UAF just that the k_itimer is
allocated on the stack.

Also posix_cpu_timer_rearm() fails to rearm the timer, which means it stops
to expire.

While debating solutions Frederic pointed out another problem:

   posix_cpu_timer_del(tmr)
					__exit_signal(p)
					  posix_cpu_timers*_exit(p);
					  unhash_task(p);
					  p->sighand = NULL;
     sh = lock_task_sighand(p)
        sighand = p->sighand;
	if (!sighand)
	    return NULL;
	lock(sighand);

     if (!sh)
	WARN_ON_ONCE(timer_queued(tmr));

On weakly ordered architectures it is not guaranteed that
posix_cpu_timer_del() will observe the stores in posix_cpu_timers*_exit()
when p->sighand is observed as NULL, which means the WARN() can be a false
positive.

Solve these issues by:

  1) Changing the store in __exit_signal() to smp_store_release().

  2) Adding a smp_acquire__after_ctrl_dep() into the !sighand path
     of lock_task_sighand().

  3) Creating a helper function for looking up the task and locking sighand
     which does not return when sighand == NULL. Instead it retries the
     task lookup and only if that fails it gives up.

  4) Using that helper in the three affected functions.

#1/#2 ensures that the reader side which observes sighand == NULL also
observes all preceeding stores, i.e. the stores in posix_cpu_timers*_exit()
and the ones in unhash_task().

#3 ensures that the above described non-leader exec() situation is handled
gracefully. When the task lookup returns the old leader, but sighand ==
NULL then it retries. In the non-leader exec() case the subsequent task
lookup will observe the new leader due to #1/#2. In normal exit() scenarios
the subsequent lookup fails.

When the task lookup fails, the function also checks whether the timer is
still enqueued and issues a warning if that's the case. Unfortunately there
is nothing which can be done about it, but as the task is already not
longer visible the timer should not be accessed anymore. This check also
requires memory ordering, which is not provided when the first lookup
fails. To achieve that the check is preceeded by a smp_rmb() which pairs
with the smp_wmb() in write_seqlock() in __exit_signal(). That ensures that
the stores in posix_cpu_timers*_exit() are visible.

The history of the non-leader exec() issue goes back to the early days of
posix CPU timers, which stored a pointer to the group leader task in the
timer. That obviously fails when a non-leader exec() switches the leader.
commit e0a70217107e ("posix-cpu-timers: workaround to suppress the problems
with mt exec") added a temporary workaround for that in 2010 which survived
about 10 years. The fix for the workaround changed the task pointer to a
pid pointer, but failed to see the subtle race described above. So the
Fixes tag picks that commit, which seems to be halfways accurate.

Thanks to Frederic Weissbecker, Oleg Nesterov and Peter Zijlstra for
review, feedback and suggestions and to Wongi and Jungwoo for the excellent
bug report and analysis!

Fixes: 55e8c8eb2c7b ("posix-cpu-timers: Store a reference to a pid not a task")
Reported-by: Wongi Lee <qw3rtyp0@gmail.com>
Reported-by: Jungwoo Lee <jwlee2217@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Cc: stable@vger.kernel.org
---
V2: Fixed the old->interval fallout - Sasha
---
 kernel/exit.c                  |    8 +
 kernel/signal.c                |   10 +
 kernel/time/posix-cpu-timers.c |  212 ++++++++++++++++++++++++-----------------
 3 files changed, 143 insertions(+), 87 deletions(-)
---
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -204,7 +204,13 @@ static void __exit_signal(struct task_st
 	 * doing sigqueue_free() if we have SIGQUEUE_PREALLOC signals.
 	 */
 	flush_sigqueue(&tsk->pending);
-	tsk->sighand = NULL;
+
+	/*
+	 * Ensure that all preceeding state is visible. Pairs with
+	 * the smp_acquire__after_ctrl_dep() in the sighand == NULL
+	 * path of lock_task_sighand().
+	 */
+	smp_store_release(&tsk->sighand, NULL);
 	spin_unlock(&sighand->siglock);
 
 	__cleanup_sighand(sighand);
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1408,8 +1408,16 @@ struct sighand_struct *__lock_task_sigha
 	rcu_read_lock();
 	for (;;) {
 		sighand = rcu_dereference(tsk->sighand);
-		if (unlikely(sighand == NULL))
+		if (unlikely(sighand == NULL)) {
+			/*
+			 * Pairs with the smp_store_release() in
+			 * __exit_signal().  It ensures that all state
+			 * modifications to the task preceeding the store are
+			 * visible to the callers of lock_task_sighand().
+			 */
+			smp_acquire__after_ctrl_dep();
 			break;
+		}
 
 		/*
 		 * This sighand can be already freed and even reused, but
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -461,6 +461,109 @@ static void disarm_timer(struct k_itimer
 		trigger_base_recalc_expires(timer, p);
 }
 
+/*
+ * Lookup the task via timer->it.cpu.pid and attempt to lock the task's sighand.
+ *
+ * This can race with the reaping of the task:
+ *
+ * CPU0					CPU1
+ *
+ * // Finds task
+ * p = pid_task(pid, pid_type);		__exit_signal(p)
+ *					  lock(p, sighand);
+ *					  posix_cpu_timers*_exit();
+ * sighand = lock_task_sighand(p);	  unhash_task(p);
+ *					  p->sighand = NULL;
+ *					  unlock(sighand);
+ *
+ * In this case sighand is NULL, which means the task and the associated timer
+ * queue cannot be longer accessed safely.
+ *
+ * __exit_signal() invokes posix_cpu_timers_exit() and if the thread group is
+ * dead it also invokes posix_cpu_timers_group_exit(). These functions delete
+ * all pending timers from the related timer queues. The POSIX timers (k_itimer)
+ * themself are still accessible, but not longer connected to the task.
+ *
+ * exec() works slightly differently. The task which exec()'s terminates all
+ * other threads in the thread group and runs __exit_signal() on them. As the
+ * thread group is not dead they only clean up the per task timers via
+ * posix_cpu_timers_exit().
+ *
+ * As the TGID on exec() stays the same per process timers stay queued, if they
+ * are armed. This works without a problem when exec() is done by the thread
+ * group leader. If a non-leader thread exec()'s this can end up in the
+ * following scenario:
+ *
+ * CPU0					CPU1
+ * // Returns old leader
+ * p = pid_task(pid, pid_type);		de_thread()
+ *					switch_leader()
+ *					release_task(old leader)
+ *					  __exit_signal()
+ *					  old_leader->sighand = NULL;
+ * // Returns NULL
+ * sighand = lock_task_sighand(p)
+ *
+ * That's problematic for several functions:
+ *
+ *  - posix_cpu_timer_del(): If the timer is still enqueued on the task the
+ *    underlying k_itimer will be freed which results in a UAF in
+ *    run_posix_cpu_timers() or on timerqueue related add/delete operations.
+ *    If the timer is not enqueued, the failure is harmless
+ *
+ *  - posix_cpu_timer_set(): Independent of the enqueued state that results in a
+ *    transient failure which is user space visible (-ESRCH) for regular posix
+ *    timers. But for the use case in do_cpu_nanosleep() it's the same UAF
+ *    problem just that the timer is allocated on the stack.
+ *
+ *  - posix_cpu_timer_rearm(): Timer is not enqueued at that point, but this
+ *    silently ignores the rearm request, which is a functional problem as the
+ *    timer wont expire anymore.
+ */
+static struct task_struct *timer_lock_sighand(struct k_itimer *timer, unsigned long *flags)
+{
+	enum pid_type type = clock_pid_type(timer->it_clock);
+	struct cpu_timer *ctmr = &timer->it.cpu;
+
+	guard(rcu)();
+
+	for (;;) {
+		struct task_struct *t = pid_task(timer->it.cpu.pid, type);
+
+		/* Fail if the task cannot be found. */
+		if (!t)
+			break;
+
+		/* Try to lock the task's sighand */
+		if (lock_task_sighand(t, flags))
+			return t;
+
+		/*
+		 * The next PID lookup might either fail or return the new
+		 * leader. This is correct for both exit() and exec().
+		 */
+	}
+
+	/*
+	 * If the timer is still enqueued, warn. There is nothing safe to do
+	 * here as there might be two timers in there which are removed in
+	 * parallel and that will cause more damage than good. This should never
+	 * happen!
+	 *
+	 * Ensure that the stores to the timer and timerqueue are visible:
+	 *
+	 * __exit_signal()
+	 *   posix_cpu_timers*_exit()
+	 *   write_seqlock(seqlock)
+	 *	smp_wmb(); <-------
+	 *   __unhash_process()	  |	!pid_task()
+	 *			  ---->	smp_rmb();
+	 *				WARN_ON_ONCE(...)
+	 */
+	smp_rmb();
+	WARN_ON_ONCE(ctmr->head || timerqueue_node_queued(&ctmr->node));
+	return NULL;
+}
 
 /*
  * Clean up a CPU-clock timer that is about to be destroyed.
@@ -470,29 +573,13 @@ static void disarm_timer(struct k_itimer
  */
 static int posix_cpu_timer_del(struct k_itimer *timer)
 {
-	struct cpu_timer *ctmr = &timer->it.cpu;
-	struct sighand_struct *sighand;
 	struct task_struct *p;
 	unsigned long flags;
 	int ret = 0;
 
-	rcu_read_lock();
-	p = cpu_timer_task_rcu(timer);
-	if (!p)
-		goto out;
+	p = timer_lock_sighand(timer, &flags);
 
-	/*
-	 * Protect against sighand release/switch in exit/exec and process/
-	 * thread timer list entry concurrent read/writes.
-	 */
-	sighand = lock_task_sighand(p, &flags);
-	if (unlikely(sighand == NULL)) {
-		/*
-		 * This raced with the reaping of the task. The exit cleanup
-		 * should have removed this timer from the timer queue.
-		 */
-		WARN_ON_ONCE(ctmr->head || timerqueue_node_queued(&ctmr->node));
-	} else {
+	if (likely(p)) {
 		if (timer->it.cpu.firing)
 			ret = TIMER_RETRY;
 		else
@@ -501,10 +588,8 @@ static int posix_cpu_timer_del(struct k_
 		unlock_task_sighand(p, &flags);
 	}
 
-out:
-	rcu_read_unlock();
 	if (!ret)
-		put_pid(ctmr->pid);
+		put_pid(timer->it.cpu.pid);
 
 	return ret;
 }
@@ -626,21 +711,17 @@ static int posix_cpu_timer_set(struct k_
 	clockid_t clkid = CPUCLOCK_WHICH(timer->it_clock);
 	u64 old_expires, new_expires, old_incr, val;
 	struct cpu_timer *ctmr = &timer->it.cpu;
-	struct sighand_struct *sighand;
 	struct task_struct *p;
 	unsigned long flags;
 	int ret = 0;
 
-	rcu_read_lock();
-	p = cpu_timer_task_rcu(timer);
-	if (!p) {
-		/*
-		 * If p has just been reaped, we can no
-		 * longer get any information about it at all.
-		 */
-		rcu_read_unlock();
+	p = timer_lock_sighand(timer, &flags);
+	/*
+	 * If p has just been reaped, we can no longer get any information about
+	 * it at all.
+	 */
+	if (!p)
 		return -ESRCH;
-	}
 
 	/*
 	 * Use the to_ktime conversion because that clamps the maximum
@@ -649,20 +730,6 @@ static int posix_cpu_timer_set(struct k_
 	new_expires = ktime_to_ns(timespec64_to_ktime(new->it_value));
 
 	/*
-	 * Protect against sighand release/switch in exit/exec and p->cpu_timers
-	 * and p->signal->cpu_timers read/write in arm_timer()
-	 */
-	sighand = lock_task_sighand(p, &flags);
-	/*
-	 * If p has just been reaped, we can no
-	 * longer get any information about it at all.
-	 */
-	if (unlikely(sighand == NULL)) {
-		rcu_read_unlock();
-		return -ESRCH;
-	}
-
-	/*
 	 * Disarm any old timer after extracting its expiry time.
 	 */
 	old_incr = timer->it_interval;
@@ -710,6 +777,7 @@ static int posix_cpu_timer_set(struct k_
 				old->it_value.tv_sec = 0;
 			}
 		}
+		old->it_interval = ns_to_timespec64(old_incr);
 	}
 
 	if (unlikely(ret)) {
@@ -720,7 +788,7 @@ static int posix_cpu_timer_set(struct k_
 		 * it as an overrun (thanks to bump_cpu_timer above).
 		 */
 		unlock_task_sighand(p, &flags);
-		goto out;
+		return ret;
 	}
 
 	if (new_expires != 0 && !(timer_flags & TIMER_ABSTIME)) {
@@ -733,11 +801,11 @@ static int posix_cpu_timer_set(struct k_
 	 * arm the timer (we'll just fake it for timer_gettime).
 	 */
 	cpu_timer_setexpires(ctmr, new_expires);
-	if (new_expires != 0 && val < new_expires) {
+	if (new_expires != 0 && val < new_expires)
 		arm_timer(timer, p);
-	}
+	else
+		trigger_base_recalc_expires(timer, p);
 
-	unlock_task_sighand(p, &flags);
 	/*
 	 * Install the new reload setting, and
 	 * set up the signal and overrun bookkeeping.
@@ -754,35 +822,18 @@ static int posix_cpu_timer_set(struct k_
 	timer->it_overrun_last = 0;
 	timer->it_overrun = -1;
 
-	if (val >= new_expires) {
-		if (new_expires != 0) {
-			/*
-			 * The designated time already passed, so we notify
-			 * immediately, even if the thread never runs to
-			 * accumulate more time on this clock.
-			 */
-			cpu_timer_fire(timer);
-		}
+	unlock_task_sighand(p, &flags);
 
+	if (new_expires && val >= new_expires) {
 		/*
-		 * Make sure we don't keep around the process wide cputime
-		 * counter or the tick dependency if they are not necessary.
+		 * The designated time already passed, so we notify immediately,
+		 * even if the thread never runs to accumulate more time on this
+		 * clock.
 		 */
-		sighand = lock_task_sighand(p, &flags);
-		if (!sighand)
-			goto out;
-
-		if (!cpu_timer_queued(ctmr))
-			trigger_base_recalc_expires(timer, p);
-
-		unlock_task_sighand(p, &flags);
+		cpu_timer_fire(timer);
 	}
- out:
-	rcu_read_unlock();
-	if (old)
-		old->it_interval = ns_to_timespec64(old_incr);
 
-	return ret;
+	return 0;
 }
 
 static void posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec64 *itp)
@@ -1048,19 +1099,12 @@ static void posix_cpu_timer_rearm(struct
 {
 	clockid_t clkid = CPUCLOCK_WHICH(timer->it_clock);
 	struct task_struct *p;
-	struct sighand_struct *sighand;
 	unsigned long flags;
 	u64 now;
 
-	rcu_read_lock();
-	p = cpu_timer_task_rcu(timer);
-	if (!p)
-		goto out;
-
-	/* Protect timer list r/w in arm_timer() */
-	sighand = lock_task_sighand(p, &flags);
-	if (unlikely(sighand == NULL))
-		goto out;
+	p = timer_lock_sighand(timer, &flags);
+	if (unlikely(!p))
+		return;
 
 	/*
 	 * Fetch the current sample and update the timer's expiry time.
@@ -1077,8 +1121,6 @@ static void posix_cpu_timer_rearm(struct
 	 */
 	arm_timer(timer, p);
 	unlock_task_sighand(p, &flags);
-out:
-	rcu_read_unlock();
 }
 
 /**
