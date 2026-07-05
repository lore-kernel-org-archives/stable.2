Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7459619E7F7;
	Sun,  5 Jul 2026 09:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783244802; cv=none; b=arAvyNnEgQR54fO6hdOqVClfFSpD3lYuf+SjBt6PbCyFHWq4+2QC6cvwMApyN8N8KFyiGt8/FIBCD0g3jJ79aEBIbA5Tw2/ce9GJGJEHe5RQHNiv1Ie4m/MjBYYcTy95X//YjzZYAxQSbTdw7ps9SxfCMUTRJTYMNKrUQSW5Vt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783244802; c=relaxed/simple;
	bh=Aj8AN0/v1YC3lGMR08L85VFjh/Wo1RZPOkUVHj1SkwA=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=c9lCkD1Nw5B9FVlleIIji52SixbnQCAB8e/oKKDNDdAuABYTPBCpafMKJj1pTOBw2SGPgZEu4KJ8I1/z3ymjh5GIP/Iz4FStq3isp3nQk6A8nP7yQshSlTB2GfMRz6AEcxlBhkEjnBRHR+UIudEjv7+wt+RZDpnxh74yFVnLmZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lq5a8+jT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sjOmG/iy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lq5a8+jT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sjOmG/iy"
Date: Sun, 05 Jul 2026 09:46:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783244798;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=CNIXnOVYuWMjxhTq4Q9QYAXK1fs5GbqYpRUw5X2EdqU=;
	b=lq5a8+jTK+v6InTNwiOj2Sp2ufaJh2j6D2WToQcuHJFp4xJApdzXwJOR9VklbwO+noTvgS
	KhZGGuPGOjlxZn5fG9nkOP8h8X6l4IO0DUyXWdboUe+epY38IGMwq8IaYak6cZEkdQMl1u
	1PgvTzV/iJwUpGkLwRsmF2fj6ZYwF2Aoemc0cgmKoTuyXmI1RNJMgGpDvdDzOxFRwW7jWg
	bj0hTh9W2eh6DxyjxVtErZcuhijY67SXqFwFJeCTeLW7/kwjOxO715TlYu7x+GPzQxFdqm
	FWRlb46eGdiY67vV2szK8XwjTd0kplsq5OQjWvoB3eeXmPU16dlnPyYugffjWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783244798;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=CNIXnOVYuWMjxhTq4Q9QYAXK1fs5GbqYpRUw5X2EdqU=;
	b=sjOmG/iywT6tYVIgJtOI0euKeXO1aX7CwixC8SZK/PaJKp20nc5a+qo979rvEnypbr9MmN
	o7tJpGHfSEIlH6Aw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] posix-cpu-timers: Prevent UAF caused by
 non-leader exec() race
Cc: Wongi Lee <qw3rtyp0@gmail.com>, Jungwoo Lee <jwlee2217@gmail.com>,
 Thomas Gleixner <tglx@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178324479651.744054.11944477307374142373.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     920f893f735e92ba3a1cd9256899a186b161928d
Gitweb:        https://git.kernel.org/tip/920f893f735e92ba3a1cd9256899a186b16=
1928d
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Fri, 03 Jul 2026 12:02:38 +02:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Sun, 05 Jul 2026 11:44:06 +02:00

posix-cpu-timers: Prevent UAF caused by non-leader exec() race

Wongi and Jungwoo decoded and reported a non-leader exec() related race
which can result in an UAF:

 sys_timer_delete()			exec()
   posix_cpu_timer_del()
   // Observes old leader
   p =3D pid_task(pid, pid_type);		de_thread()
   					  switch_leader();
					  release_task(old_leader)
					    __exit_signal(old_leader)
					      sighand =3D lock(old_leader, sighand);
					      posix_cpu_timers*_exit();
   sighand =3D lock_task_sighand(p)	      unhash_task(old_leader);
     sh =3D lock(p, sighand)	    	      old_leader->sighand =3D NULL;
					      unlock(sighand);
     (p->sighand =3D=3D NULL)
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
					  p->sighand =3D NULL;
     sh =3D lock_task_sighand(p)
        sighand =3D p->sighand;
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
     which does not return when sighand =3D=3D NULL. Instead it retries the
     task lookup and only if that fails it gives up.

  4) Using that helper in the three affected functions.

#1/#2 ensures that the reader side which observes sighand =3D=3D NULL also
observes all preceeding stores, i.e. the stores in posix_cpu_timers*_exit()
and the ones in unhash_task().

#3 ensures that the above described non-leader exec() situation is handled
gracefully. When the task lookup returns the old leader, but sighand =3D=3D
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

Fixes: 55e8c8eb2c7b ("posix-cpu-timers: Store a reference to a pid not a task=
")
Reported-by: Wongi Lee <qw3rtyp0@gmail.com>
Reported-by: Jungwoo Lee <jwlee2217@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Cc: stable@vger.kernel.org
---
 kernel/exit.c                  |   7 +-
 kernel/signal.c                |  10 +-
 kernel/time/posix-cpu-timers.c | 173 +++++++++++++++++++++-----------
 3 files changed, 130 insertions(+), 60 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index 1056422..2c0b1c0 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -212,7 +212,12 @@ static void __exit_signal(struct release_task_post *post=
, struct task_struct *ts
 	__unhash_process(post, tsk, group_dead);
 	write_sequnlock(&sig->stats_lock);
=20
-	tsk->sighand =3D NULL;
+	/*
+	 * Ensure that all preceeding state is visible. Pairs with
+	 * the smp_acquire__after_ctrl_dep() in the sighand =3D=3D NULL
+	 * path of lock_task_sighand().
+	 */
+	smp_store_release(&tsk->sighand, NULL);
 	spin_unlock(&sighand->siglock);
=20
 	__cleanup_sighand(sighand);
diff --git a/kernel/signal.c b/kernel/signal.c
index 9c2b32c..bbc0fd4 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1362,8 +1362,16 @@ struct sighand_struct *lock_task_sighand(struct task_s=
truct *tsk,
 	rcu_read_lock();
 	for (;;) {
 		sighand =3D rcu_dereference(tsk->sighand);
-		if (unlikely(sighand =3D=3D NULL))
+		if (unlikely(sighand =3D=3D NULL)) {
+			/*
+			 * Pairs with the smp_store_release() in
+			 * __exit_signal().  It ensures that all state
+			 * modifications to the task preceeding the store are
+			 * visible to the callers of lock_task_sighand().
+			 */
+			smp_acquire__after_ctrl_dep();
 			break;
+		}
=20
 		/*
 		 * This sighand can be already freed and even reused, but
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 5e633d8..a7d3e82 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -461,6 +461,109 @@ static void disarm_timer(struct k_itimer *timer, struct=
 task_struct *p)
 		trigger_base_recalc_expires(timer, p);
 }
=20
+/*
+ * Lookup the task via timer->it.cpu.pid and attempt to lock the task's sigh=
and.
+ *
+ * This can race with the reaping of the task:
+ *
+ * CPU0					CPU1
+ *
+ * // Finds task
+ * p =3D pid_task(pid, pid_type);		__exit_signal(p)
+ *					  lock(p, sighand);
+ *					  posix_cpu_timers*_exit();
+ * sighand =3D lock_task_sighand(p);	  unhash_task(p);
+ *					  p->sighand =3D NULL;
+ *					  unlock(sighand);
+ *
+ * In this case sighand is NULL, which means the task and the associated tim=
er
+ * queue cannot be longer accessed safely.
+ *
+ * __exit_signal() invokes posix_cpu_timers_exit() and if the thread group is
+ * dead it also invokes posix_cpu_timers_group_exit(). These functions delete
+ * all pending timers from the related timer queues. The POSIX timers (k_iti=
mer)
+ * themself are still accessible, but not longer connected to the task.
+ *
+ * exec() works slightly differently. The task which exec()'s terminates all
+ * other threads in the thread group and runs __exit_signal() on them. As the
+ * thread group is not dead they only clean up the per task timers via
+ * posix_cpu_timers_exit().
+ *
+ * As the TGID on exec() stays the same per process timers stay queued, if t=
hey
+ * are armed. This works without a problem when exec() is done by the thread
+ * group leader. If a non-leader thread exec()'s this can end up in the
+ * following scenario:
+ *
+ * CPU0					CPU1
+ * // Returns old leader
+ * p =3D pid_task(pid, pid_type);		de_thread()
+ *					switch_leader()
+ *					release_task(old leader)
+ *					  __exit_signal()
+ *					  old_leader->sighand =3D NULL;
+ * // Returns NULL
+ * sighand =3D lock_task_sighand(p)
+ *
+ * That's problematic for several functions:
+ *
+ *  - posix_cpu_timer_del(): If the timer is still enqueued on the task the
+ *    underlying k_itimer will be freed which results in a UAF in
+ *    run_posix_cpu_timers() or on timerqueue related add/delete operations.
+ *    If the timer is not enqueued, the failure is harmless
+ *
+ *  - posix_cpu_timer_set(): Independent of the enqueued state that results =
in a
+ *    transient failure which is user space visible (-ESRCH) for regular pos=
ix
+ *    timers. But for the use case in do_cpu_nanosleep() it's the same UAF
+ *    problem just that the timer is allocated on the stack.
+ *
+ *  - posix_cpu_timer_rearm(): Timer is not enqueued at that point, but this
+ *    silently ignores the rearm request, which is a functional problem as t=
he
+ *    timer wont expire anymore.
+ */
+static struct task_struct *timer_lock_sighand(struct k_itimer *timer, unsign=
ed long *flags)
+{
+	enum pid_type type =3D clock_pid_type(timer->it_clock);
+	struct cpu_timer *ctmr =3D &timer->it.cpu;
+
+	guard(rcu)();
+
+	for (;;) {
+		struct task_struct *t =3D pid_task(timer->it.cpu.pid, type);
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
=20
 /*
  * Clean up a CPU-clock timer that is about to be destroyed.
@@ -470,29 +573,13 @@ static void disarm_timer(struct k_itimer *timer, struct=
 task_struct *p)
  */
 static int posix_cpu_timer_del(struct k_itimer *timer)
 {
-	struct cpu_timer *ctmr =3D &timer->it.cpu;
-	struct sighand_struct *sighand;
 	struct task_struct *p;
 	unsigned long flags;
 	int ret =3D 0;
=20
-	rcu_read_lock();
-	p =3D cpu_timer_task_rcu(timer);
-	if (!p)
-		goto out;
+	p =3D timer_lock_sighand(timer, &flags);
=20
-	/*
-	 * Protect against sighand release/switch in exit/exec and process/
-	 * thread timer list entry concurrent read/writes.
-	 */
-	sighand =3D lock_task_sighand(p, &flags);
-	if (unlikely(sighand =3D=3D NULL)) {
-		/*
-		 * This raced with the reaping of the task. The exit cleanup
-		 * should have removed this timer from the timer queue.
-		 */
-		WARN_ON_ONCE(ctmr->head || timerqueue_node_queued(&ctmr->node));
-	} else {
+	if (likely(p)) {
 		if (timer->it.cpu.firing) {
 			/*
 			 * Prevent signal delivery. The timer cannot be dequeued
@@ -508,11 +595,8 @@ static int posix_cpu_timer_del(struct k_itimer *timer)
 		unlock_task_sighand(p, &flags);
 	}
=20
-out:
-	rcu_read_unlock();
-
 	if (!ret) {
-		put_pid(ctmr->pid);
+		put_pid(timer->it.cpu.pid);
 		timer->it_status =3D POSIX_TIMER_DISARMED;
 	}
 	return ret;
@@ -626,21 +710,17 @@ static int posix_cpu_timer_set(struct k_itimer *timer, =
int timer_flags,
 	clockid_t clkid =3D CPUCLOCK_WHICH(timer->it_clock);
 	struct cpu_timer *ctmr =3D &timer->it.cpu;
 	u64 old_expires, new_expires, now;
-	struct sighand_struct *sighand;
 	struct task_struct *p;
 	unsigned long flags;
 	int ret =3D 0;
=20
-	rcu_read_lock();
-	p =3D cpu_timer_task_rcu(timer);
-	if (!p) {
-		/*
-		 * If p has just been reaped, we can no
-		 * longer get any information about it at all.
-		 */
-		rcu_read_unlock();
+	p =3D timer_lock_sighand(timer, &flags);
+	/*
+	 * If p has just been reaped, we can no longer get any information about
+	 * it at all.
+	 */
+	if (!p)
 		return -ESRCH;
-	}
=20
 	/*
 	 * Use the to_ktime conversion because that clamps the maximum
@@ -648,20 +728,6 @@ static int posix_cpu_timer_set(struct k_itimer *timer, i=
nt timer_flags,
 	 */
 	new_expires =3D ktime_to_ns(timespec64_to_ktime(new->it_value));
=20
-	/*
-	 * Protect against sighand release/switch in exit/exec and p->cpu_timers
-	 * and p->signal->cpu_timers read/write in arm_timer()
-	 */
-	sighand =3D lock_task_sighand(p, &flags);
-	/*
-	 * If p has just been reaped, we can no
-	 * longer get any information about it at all.
-	 */
-	if (unlikely(sighand =3D=3D NULL)) {
-		rcu_read_unlock();
-		return -ESRCH;
-	}
-
 	/* Retrieve the current expiry time before disarming the timer */
 	old_expires =3D cpu_timer_getexpires(ctmr);
=20
@@ -698,7 +764,7 @@ static int posix_cpu_timer_set(struct k_itimer *timer, in=
t timer_flags,
 	/* Retry if the timer expiry is running concurrently */
 	if (unlikely(ret)) {
 		unlock_task_sighand(p, &flags);
-		goto out;
+		return ret;
 	}
=20
 	/* Convert relative expiry time to absolute */
@@ -733,8 +799,6 @@ static int posix_cpu_timer_set(struct k_itimer *timer, in=
t timer_flags,
 	 */
 	if (!sigev_none && new_expires && now >=3D new_expires)
 		cpu_timer_fire(timer);
-out:
-	rcu_read_unlock();
 	return ret;
 }
=20
@@ -1018,19 +1082,12 @@ static void check_process_timers(struct task_struct *=
tsk,
 static bool posix_cpu_timer_rearm(struct k_itimer *timer)
 {
 	clockid_t clkid =3D CPUCLOCK_WHICH(timer->it_clock);
-	struct sighand_struct *sighand;
 	struct task_struct *p;
 	unsigned long flags;
 	u64 now;
=20
-	guard(rcu)();
-	p =3D cpu_timer_task_rcu(timer);
-	if (!p)
-		return true;
-
-	/* Protect timer list r/w in arm_timer() */
-	sighand =3D lock_task_sighand(p, &flags);
-	if (unlikely(sighand =3D=3D NULL))
+	p =3D timer_lock_sighand(timer, &flags);
+	if (unlikely(!p))
 		return true;
=20
 	/*
