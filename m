Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F3B39CD0C;
	Mon, 10 Aug 2026 08:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786349350; cv=none; b=ba/h64rdlxn/4v/j7QquXuEXguwuqyooyV4D+zh8J16AoxGZMteUjq4pH0HhTpglo13pm1oOr3BF8ydWNPzOnMEpJpF1OiRIap9xPFOjomID6gfKWY1T5AGSm6N+QZCq9U/r90LvuszPDGsNkN1jarH0nwUyua3CKpv/yFvKKZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786349350; c=relaxed/simple;
	bh=PGKAtpR4nvrdgujrkOFW75iEiE+gOqgqxl6OwiDHGZU=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=KeLi3C8yIj7HE9Z59VPPsOnB6c6EQOkMRCf5j6sO1HTHhDXXtRwAvM66W1vtUyQ29cA6NIKonATA3/Tb56XtASLX67G9FSY+y3VTwe+ONyo5ys7MxAAh1AI7AMYEIXrTX8dvei1z4HX5KhJbS5cPugDxyAB7tQ1WNMAeAP5mXE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a9AUuEZo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vulZU6wX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a9AUuEZo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vulZU6wX"
Date: Mon, 10 Aug 2026 08:09:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1786349346;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=04X1GjOtAt9okUEEFnttGG/2gyn6DCyjWsOp/zNRnTg=;
	b=a9AUuEZoWI5wKobjFlprLcRqbx9kTL1VP27lOB/InyNX9PA8XcDL/jDMCY3/M97dEn2B5h
	XA7FcNsTDaCEGDYrfrRTJAOEW7LnvVRdlBW1VK5vkwahVU7Ws0AV+YlhUk9aB0hG4ArDGt
	dhU8RP7qEN61RIfnhMBpgdHx/EZ67Uz8fjq2U3C5t+suRQLrfXey5VGh3nCMhQcKSisAb5
	nEdW03SB6NKszPD5VPaNnOva5fYfnYiMCIiEkfQ9At2bgISErC8CAPpF6HzZNM+cyeONsI
	oeoBECJX1ymdz0GYhSBmgonu0DO+djJ4Mtcs3rcoUui9VnoSUAvyw6H+UtowFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1786349346;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=04X1GjOtAt9okUEEFnttGG/2gyn6DCyjWsOp/zNRnTg=;
	b=vulZU6wX8FMTGIwjQEMS+90PRCBMjPd9+KamY+Q2BBbJNMBSrjVWbFnu3gaTeCsjnidNOG
	/Rk5+ARYaA0HR1CA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] futex: Sanitize and document
 task_struct::futex::state transitions
Cc: Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>,
 Kyle Zeng <kylebot@openai.com>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178634934465.442315.16443340822985232972.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     f9ece060cc43eae8a1f148737d193ba0d07b8f88
Gitweb:        https://git.kernel.org/tip/f9ece060cc43eae8a1f148737d193ba0d07=
b8f88
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Fri, 07 Aug 2026 17:07:08 +02:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Mon, 10 Aug 2026 10:07:53 +02:00

futex: Sanitize and document task_struct::futex::state transitions

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
 kernel/futex/core.c |   8 +--
 kernel/futex/pi.c   | 105 ++++++++++++++++++++++++++++---------------
 2 files changed, 73 insertions(+), 40 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 128c575..0ea2c1a 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -1527,11 +1527,9 @@ static void futex_cleanup_begin(struct task_struct *ts=
k)
 static void futex_cleanup_end(struct task_struct *tsk, int state)
 	__releases(&tsk->futex.exit_mutex)
 {
-	/*
-	 * Lockless store. The only side effect is that an observer might
-	 * take another loop until it becomes visible.
-	 */
-	tsk->futex.state =3D state;
+	scoped_guard(raw_spinlock_irq, &tsk->pi_lock)
+		tsk->futex.state =3D state;
+
 	/*
 	 * Drop the exit protection. This unblocks waiters which observed
 	 * FUTEX_STATE_EXITING to reevaluate the state.
diff --git a/kernel/futex/pi.c b/kernel/futex/pi.c
index 3e277ef..2731e55 100644
--- a/kernel/futex/pi.c
+++ b/kernel/futex/pi.c
@@ -193,6 +193,48 @@ void put_pi_state(struct futex_pi_state *pi_state)
  *     pi_mutex->wait_lock
  *       p->pi_lock
  *
+ * Futex kernel state:
+ *
+ * The kernel tracks the task state in p::futex::state to protect against ex=
it()
+ * and exec(). The states are:
+ *
+ * - FUTEX_STATE_OK when the task is alive and waiters can be attached
+ *
+ * - FUTEX_STATE_EXITING when the task cleans up the robust list and pi
+ *   state. Concurrent waiters cannot attach anymore and have to wait until =
the
+ *   cleanup is finished to re-evaluate the potential changes of robust list=
 and
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
+ *    protect against a concurrent exit/exec cleanup by the owner. If the st=
ate
+ *    is OK then the waiter can be attached to the owner while still holding
+ *    pi_lock.
+ *
+ *    The cleanup code has to hold it for all state transitions to ensure th=
at
+ *    the stores to the state cannot be reordered against previous stores on
+ *    which the waiter correctness depends on.
+ *
+ * 2) p::futex::exit_mutex
+ *
+ *    The mutex is acquired when the cleanup starts and released at the end.=
 It
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
=20
 /*
@@ -318,19 +360,11 @@ out_error:
 	return ret;
 }
=20
-static int handle_exit_race(u32 __user *uaddr, u32 uval,
-			    struct task_struct *tsk)
+static int handle_exit_race(u32 __user *uaddr, u32 uval)
 {
 	u32 uval2;
=20
 	/*
-	 * If the futex exit state is not yet FUTEX_STATE_DEAD, tell the
-	 * caller that the alleged owner is busy.
-	 */
-	if (tsk && tsk->futex.state !=3D FUTEX_STATE_DEAD)
-		return -EBUSY;
-
-	/*
 	 * Reread the user space value to handle the following situation:
 	 *
 	 * CPU0				CPU1
@@ -427,7 +461,7 @@ static int attach_to_pi_owner(u32 __user *uaddr, u32 uval=
, union futex_key *key,
 		return -EAGAIN;
 	p =3D find_get_task_by_vpid(pid);
 	if (!p)
-		return handle_exit_race(uaddr, uval, NULL);
+		return handle_exit_race(uaddr, uval);
=20
 	if (unlikely(p->flags & PF_KTHREAD)) {
 		put_task_struct(p);
@@ -435,41 +469,42 @@ static int attach_to_pi_owner(u32 __user *uaddr, u32 uv=
al, union futex_key *key,
 	}
=20
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
 	if (unlikely(p->futex.state !=3D FUTEX_STATE_OK)) {
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
-		int ret =3D handle_exit_race(uaddr, uval, p);
+		if (p->futex.state =3D=3D FUTEX_STATE_EXITING) {
+			raw_spin_unlock_irq(&p->pi_lock);
+			*exiting =3D p;
+			return -EBUSY;
+		}
+
+		int ret =3D handle_exit_race(uaddr, uval);
=20
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
-		if (ret =3D=3D -EBUSY)
-			*exiting =3D p;
-		else
-			put_task_struct(p);
+		put_task_struct(p);
 		return ret;
 	}
=20
-	/*
-	 * If the owner is about to exit() or exec() and tries to modify
-	 * p::futex::exit_state it is serialized against this code by
-	 * p::pi_lock.
-	 */
 	if (IS_ENABLED(CONFIG_MMU) && futex_key_is_private(key)) {
 		/*
 		 * A private futex key holds a pointer to the waiter's mm
