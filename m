Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365A3432E80
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 12:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787662120; cv=none; b=SUt53J164+V9a4m51JRBETH8F379PsBWtH716xTgunssHPSivy1NxEminEjDXq/0xwSNCWyXAYUdD7EkkzjDOFHBCZ+HejTa4olUKN0mn9XkSIvmniqxFXqiEB3HWpWKDajMo6TW2UepB9ayWsRYMP0KProW+YEiqcOkO5YAa4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787662120; c=relaxed/simple;
	bh=x4PXYglfOcKj/2BD5lhfQf6zwS70YNJEdkvEiiiyYnA=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=r77HlRzcn5Gq1KrpJL3O0LTuAuDxEdSbVmiYRbQJekvICXRBe/mCXdkiI3n3pX+3Sj6mVLbMR7ZRVs8/V19aCVcGZlQOGmzb89wIeB1bSIueznlIrS6AQsV/U6KnLHCDAZNJ2OoAlW1BMzubeHefpcfeNyWPlHlVS1iCp+Qo4SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A24jnKA3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A24jnKA3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E161F00A3D;
	Tue, 25 Aug 2026 12:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787662114;
	bh=tteNOC+gfH1hm9I89bY/wI7g8ZP+BVpF/FQASyG/0tQ=;
	h=Date:From:To:Cc:Subject:References;
	b=A24jnKA3SqOwFSRxi8SBw79Bp1QZ38TJnPgAsVGC+GoFXVq9xVj5NKMU9cfTUQVag
	 HylHEl7UoVqjSb2zTbr6KqJVkVjZQHiYSZau8j5F/hmc8I8rwwn6Ruh62O8CjVwJ3/
	 FJr+OBC0RZWR6VL+DuKnehFkKkcf97zEox1U7d99/EI3VVkdPK9RXDHsYwwFR6+dV7
	 UaBWg3J41r9LrkoZKlAMUXGnZjxPGIZALWfAx2+s6d9ad5TJpJW2Gg6GBA8jio2u7M
	 whu/FOkU4bqf4onB8QOJGMJ2fe/wF6fc+l+RVhbNrVTnHcwKW4H62jIsOkOgsTfy0f
	 Tio4ulvYgYyIw==
Date: Tue, 25 Aug 2026 14:48:31 +0200
Message-ID: <20260825091708.499779920@kernel.org>
User-Agent: quilt/0.69
From: Thomas Gleixner <tglx@kernel.org>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
 peterz@infradead.org,
 Kyle Zeng <kylebot@openai.com>
Subject: [patch 7.1.y 2/6] futex: Sanitize and document
 task_struct::futex::state transitions
References: <2026082446-lumpish-subdivide-9766@gregkh>
 <20260825091624.748852250@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Thomas Gleixner <tglx@kernel.org>

commit f9ece060cc43eae8a1f148737d193ba0d07b8f88 upstream.

The futex state is used to prevent a waiter from attaching to the lock
owner while the owner runs the futex cleanup in exit() or exec().

Only the state transition from FUTEX_STATE_OK to FUTEX_STATE_EXITING must
be done with the task's pi_lock held, the transition away from
FUTEX_STATE_EXITING has no serialization requirements on the writer side,
but it's completely non obvious why. It's magically protected by
exit_pi_state(), which operates under tsk::pi_lock, as that's the state
which has to be correct when the waiter observes the new state.

OTOH, taking the pi_lock in futex_cleanup_end() is not a performance issue
because at that point the lock should be uncontended in the vast majority
of cases.

Aside of that the handling of FUTEX_STATE_EXITING in attach_to_pi_owner()
and handle_exit_race() is confusing at best.

Protect the store in futex_cleanup_end() with tsk::pi_lock, handle
FUTEX_STATE_EXITING in attach_to_pi_owner() explicitly and document how
this is supposed to work.

Reported-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Kyle Zeng <kylebot@openai.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: stable@vger.kernel.org
---
 kernel/futex/core.c |    8 +--
 kernel/futex/pi.c   |  105 ++++++++++++++++++++++++++++++++++------------------
 2 files changed, 73 insertions(+), 40 deletions(-)
---
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -1501,11 +1501,9 @@ static void futex_cleanup_begin(struct t
 static void futex_cleanup_end(struct task_struct *tsk, int state)
 	__releases(&tsk->futex_exit_mutex)
 {
-	/*
-	 * Lockless store. The only side effect is that an observer might
-	 * take another loop until it becomes visible.
-	 */
-	tsk->futex_state = state;
+	scoped_guard(raw_spinlock_irq, &tsk->pi_lock)
+		tsk->futex_state = state;
+
 	/*
 	 * Drop the exit protection. This unblocks waiters which observed
 	 * FUTEX_STATE_EXITING to reevaluate the state.
--- a/kernel/futex/pi.c
+++ b/kernel/futex/pi.c
@@ -193,6 +193,48 @@ void put_pi_state(struct futex_pi_state
  *     pi_mutex->wait_lock
  *       p->pi_lock
  *
+ * Futex kernel state:
+ *
+ * The kernel tracks the task state in p::futex::state to protect against exit()
+ * and exec(). The states are:
+ *
+ * - FUTEX_STATE_OK when the task is alive and waiters can be attached
+ *
+ * - FUTEX_STATE_EXITING when the task cleans up the robust list and pi
+ *   state. Concurrent waiters cannot attach anymore and have to wait until the
+ *   cleanup is finished to re-evaluate the potential changes of robust list and
+ *   pi state cleanups.
+ *
+ * - FUTEX_STATE_DEAD when the task has cleaned up the robust list and
+ *   is about to fully exit.
+ *
+ * exec() switches back to FUTEX_STATE_OK after the cleanup.
+ *
+ * The state has two related locks:
+ *
+ * 1) p::pi_lock
+ *
+ *    p::pi_lock has to be taken by the waiter when evaluating the state to
+ *    protect against a concurrent exit/exec cleanup by the owner. If the state
+ *    is OK then the waiter can be attached to the owner while still holding
+ *    pi_lock.
+ *
+ *    The cleanup code has to hold it for all state transitions to ensure that
+ *    the stores to the state cannot be reordered against previous stores on
+ *    which the waiter correctness depends on.
+ *
+ * 2) p::futex::exit_mutex
+ *
+ *    The mutex is acquired when the cleanup starts and released at the end. It
+ *    obviously is not serializing the owner's cleanup against itself. It is
+ *    used to avoid a live lock caused by a waiter preempting the owner's
+ *    cleanup. Such a waiter would busy loop forever waiting for the owner to
+ *    finish the cleanup.
+ *
+ *    To prevent this, waiters have to drop all locks when observing
+ *    FUTEX_STATE_EXITING and block on the mutex. When the owner releases the
+ *    mutex after finishing the cleanup the waiters make progress and
+ *    re-evaluate the situation.
  */
 
 /*
@@ -318,19 +360,11 @@ static int attach_to_pi_state(u32 __user
 	return ret;
 }
 
-static int handle_exit_race(u32 __user *uaddr, u32 uval,
-			    struct task_struct *tsk)
+static int handle_exit_race(u32 __user *uaddr, u32 uval)
 {
 	u32 uval2;
 
 	/*
-	 * If the futex exit state is not yet FUTEX_STATE_DEAD, tell the
-	 * caller that the alleged owner is busy.
-	 */
-	if (tsk && tsk->futex_state != FUTEX_STATE_DEAD)
-		return -EBUSY;
-
-	/*
 	 * Reread the user space value to handle the following situation:
 	 *
 	 * CPU0				CPU1
@@ -427,7 +461,7 @@ static int attach_to_pi_owner(u32 __user
 		return -EAGAIN;
 	p = find_get_task_by_vpid(pid);
 	if (!p)
-		return handle_exit_race(uaddr, uval, NULL);
+		return handle_exit_race(uaddr, uval);
 
 	if (unlikely(p->flags & PF_KTHREAD)) {
 		put_task_struct(p);
@@ -435,41 +469,42 @@ static int attach_to_pi_owner(u32 __user
 	}
 
 	/*
-	 * We need to look at the task state to figure out, whether the
-	 * task is exiting. To protect against the change of the task state
-	 * in futex_exit_release(), we do this protected by p->pi_lock:
+	 * We need to look at the task state to figure out whether the task is
+	 * exiting. To protect against the change of the task state from
+	 * FUTEX_STATE_OK to FUTEX_STATE_EXISTING in futex_cleanup_begin() it is
+	 * required to do this protected by p->pi_lock, which prevents the owner
+	 * from concurrently starting the exit cleanup.
+	 *
+	 * If the state is FUTEX_STATE_OK pi_lock must be held until the waiter
+	 * is attached to protect against a concurrent exit()/exec().
 	 */
 	raw_spin_lock_irq(&p->pi_lock);
+
+	/* Validate that the task is ready for futex operations. */
 	if (unlikely(p->futex_state != FUTEX_STATE_OK)) {
 		/*
-		 * The task is on the way out. When the futex state is
-		 * FUTEX_STATE_DEAD, we know that the task has finished
-		 * the cleanup:
+		 * The task is on the way out. When state is FUTEX_STATE_EXITING
+		 * the cleanup is in progress. To avoid a live lock when the
+		 * waiter preempted the owner, store the task pointer in
+		 * @exiting and keep the reference on the task. The calling code
+		 * will drop all locks, block on @p::futex::exit_mutex and wait
+		 * for the owner to finish the cleanup. Once the owner released
+		 * the mutex the waiter drops the reference count and
+		 * re-evaluates the situation.
 		 */
-		int ret = handle_exit_race(uaddr, uval, p);
+		if (p->futex_state == FUTEX_STATE_EXITING) {
+			raw_spin_unlock_irq(&p->pi_lock);
+			*exiting = p;
+			return -EBUSY;
+		}
+
+		int ret = handle_exit_race(uaddr, uval);
 
 		raw_spin_unlock_irq(&p->pi_lock);
-		/*
-		 * If the owner task is between FUTEX_STATE_EXITING and
-		 * FUTEX_STATE_DEAD then store the task pointer and keep
-		 * the reference on the task struct. The calling code will
-		 * drop all locks, wait for the task to reach
-		 * FUTEX_STATE_DEAD and then drop the refcount. This is
-		 * required to prevent a live lock when the current task
-		 * preempted the exiting task between the two states.
-		 */
-		if (ret == -EBUSY)
-			*exiting = p;
-		else
-			put_task_struct(p);
+		put_task_struct(p);
 		return ret;
 	}
 
-	/*
-	 * If the owner is about to exit() or exec() and tries to modify
-	 * p::futex::exit_state it is serialized against this code by
-	 * p::pi_lock.
-	 */
 	if (IS_ENABLED(CONFIG_MMU) && futex_key_is_private(key)) {
 		/*
 		 * A private futex key holds a pointer to the waiter's mm

