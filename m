Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4011840927D;
	Thu, 30 Jul 2026 11:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785410367; cv=none; b=J+Ep8PPe758JSTa2VmC89K26McXOGmgrHSqd0FNguVAVIO7eA3O3rbEuAz2U4kRwXV9ps8DzRiSVF9mj1/1mUN/A2tjI+xh64Gue3G8dn9HVp/1rpn8L+G5z27hJGSB8TfINFGkX05pm3jMztGtnSf1Y/TM05piMIeKBBVFfSMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785410367; c=relaxed/simple;
	bh=iF6AxhMHrHZ2DFXbsUv/xm7/zYQRBYF+iUCXLyQ7bZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p1w87boMkOU5okRY3PPkxaSgd2B97MlU+Kt9KcZi2cTQC9MEXTPeMi81VSscnbUtJeCaIJ+a9AnsFSnUsnDMUo9e7pBFY0JlLrgrmfxi1Ey7uzuHzDkS/h/NLgbsEXf6opBjWRPodTOYAxCzlxFrB5S7bw5pD3uybfynbqSjpKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WUObWKzy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WUObWKzy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 352181F000E9;
	Thu, 30 Jul 2026 11:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785410364;
	bh=vi1BK2Y5krbc1Kr42POfCi5TZkx2Z1/1okkyc3JBv5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WUObWKzyp6USoo5P/5mhChBozQqUbWtLa8eQpacfpyPseH5WIdtlkKdTSQ8PshBuM
	 nBwSA+qqtoiQAWwl2EswfAgdq4VBeNLBqm9G+tYssOthkIqWcAPt4InEqVcab9fwIg
	 7PUuX9sQVwY3EXFZveM7GPxj7hi0CWF5ecNMY61A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.12.100
Date: Thu, 30 Jul 2026 13:19:05 +0200
Message-ID: <2026073005-pencil-mooned-edf7@gregkh>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026073004-dividers-evaluator-22ed@gregkh>
References: <2026073004-dividers-evaluator-22ed@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index a5fb7f21c310..40f2b39cfced 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 12
-SUBLEVEL = 99
+SUBLEVEL = 100
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/kernel/exit.c b/kernel/exit.c
index e798078f958c..8ae45b2b8cf9 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -205,7 +205,13 @@ static void __exit_signal(struct task_struct *tsk)
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
diff --git a/kernel/signal.c b/kernel/signal.c
index b832158a9c46..e6e812f8b80f 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1395,8 +1395,16 @@ struct sighand_struct *__lock_task_sighand(struct task_struct *tsk,
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
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 635fac5f5fbd..f0471fbe8728 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -462,6 +462,109 @@ static void disarm_timer(struct k_itimer *timer, struct task_struct *p)
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
@@ -471,29 +574,13 @@ static void disarm_timer(struct k_itimer *timer, struct task_struct *p)
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
@@ -502,10 +589,8 @@ static int posix_cpu_timer_del(struct k_itimer *timer)
 		unlock_task_sighand(p, &flags);
 	}
 
-out:
-	rcu_read_unlock();
 	if (!ret)
-		put_pid(ctmr->pid);
+		put_pid(timer->it.cpu.pid);
 
 	return ret;
 }
@@ -627,21 +712,17 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 	clockid_t clkid = CPUCLOCK_WHICH(timer->it_clock);
 	struct cpu_timer *ctmr = &timer->it.cpu;
 	u64 old_expires, new_expires, now;
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
@@ -649,20 +730,6 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 	 */
 	new_expires = ktime_to_ns(timespec64_to_ktime(new->it_value));
 
-	/*
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
 	/* Retrieve the current expiry time before disarming the timer */
 	old_expires = cpu_timer_getexpires(ctmr);
 
@@ -693,7 +760,7 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 	/* Retry if the timer expiry is running concurrently */
 	if (unlikely(ret)) {
 		unlock_task_sighand(p, &flags);
-		goto out;
+		return ret;
 	}
 
 	/* Convert relative expiry time to absolute */
@@ -728,8 +795,6 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 	 */
 	if (!sigev_none && new_expires && now >= new_expires)
 		cpu_timer_fire(timer);
-out:
-	rcu_read_unlock();
 	return ret;
 }
 
@@ -1011,19 +1076,12 @@ static void posix_cpu_timer_rearm(struct k_itimer *timer)
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
@@ -1040,8 +1098,6 @@ static void posix_cpu_timer_rearm(struct k_itimer *timer)
 	 */
 	arm_timer(timer, p);
 	unlock_task_sighand(p, &flags);
-out:
-	rcu_read_unlock();
 }
 
 /**
