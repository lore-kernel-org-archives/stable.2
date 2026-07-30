Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD9533A9D1;
	Thu, 30 Jul 2026 22:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785449754; cv=none; b=GcMupVWnhNbjym+KDsfh1W30kIpA/myRP+ZooxJbZeauA1dwlt9+ThrlFOZ6/kVW/1J4GgFZYqp+E4d87eTeZyOcmDIhcorYgiW/aDEgXUm9dBXpEOslGQc1fgRmTwj1Iz5MktQdZuRND/tLtgtHsgUVNS/nhNWmT83yMknkWHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785449754; c=relaxed/simple;
	bh=3GQEtLZxW/FPnxr79ZlXt9gUNMbRdxAg2VK3x4+/XHs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rg49b1PTxOLiRFhZuajyuf5a/sYckYO4/wb340oHQSXoUjHf5N8e5FFz2y/BC7+oSsMVN/ONQSXMRgUoG191TmAGYUxX8GPfaUr1XlSGH/tlFbZ3b/wYe2dRNiJBrSIu8w87qlFJnkv+c6T7eEcUZvp677T99W85UQloYkUqLJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=noY9JsQL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="noY9JsQL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE7F41F000E9;
	Thu, 30 Jul 2026 22:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785449750;
	bh=rLSGg6EeYbVxdlw89wm4kgexTK8xxz6gFq/spPhyyFM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=noY9JsQLlJNrlMLTazgFQtvVBbJc/BbiuWLhBj5Piw40beDgg5Tc28Mgm+QJqhWTL
	 qXX5OMSWdz9TmgqwIKpMSZUhttbnRL9JK/rxS8Jrb/sAAlXX9BrEt9/tzGSM9wfDF2
	 a/jS5SniNBSmnc/tyojDz6gDxLiA2OoWd+hPs7MlxTGTdOHbr9/KAMwpahxnWdPW0d
	 M47flbEpNQWbuDClfozpRjfw8XhelbHBkdkiBlOOk+NkpM+5PeQfhCrtc0v5G4Rb0q
	 Z+3ib2WBsyQ4BEn4aPbnzovBkXkrpsqTxVhORnukPSRfwMJEGipNBt5BfMtWXe6q0X
	 14US3OOP46Rjw==
From: Thomas Gleixner <tglx@kernel.org>
To: Keno Fischer <keno@juliahub.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>, Yang Tao
 <yang.tao172@zte.com.cn>,
 Yi Wang <wang.yi59@zte.com.cn>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, stable@vger.kernel.org, Florian Weimer
 <fweimer@redhat.com>, Oleg Nesterov <oleg@redhat.com>, Christian Brauner
 <brauner@kernel.org>
Subject: [PATCH] futex: Make FUTEX_WAITERS state consistent for robust futex
 unlock
In-Reply-To: <87fr10faqi.ffs@fw13>
References: <CABV8kRwvex1VvQ0eGwUQmJL_vA7AP2h64VpHqtXvfOXMvvJQZA@mail.gmail.com>
 <87bjc0led9.ffs@fw13>
 <CABV8kRwDhwa_OoQ9zx4sv3tDATZc0Yy-mYGObRXw59DO0cDfLw@mail.gmail.com>
 <87v7a7jeav.ffs@fw13>
 <CABV8kRz5c4opGVA3CPdALWxjUH_DkLf_tBLdefajsSevfHFYpQ@mail.gmail.com>
 <87zezdiiyg.ffs@fw13>
 <CABV8kRz1nLxUDAgCSKHB2oqME74M6PyxB-t+u1it=6eYo5cFAQ@mail.gmail.com>
 <87ldawinki.ffs@fw13>
 <CABV8kRw92-0sx6Mi=z5pzCA9gEE9nnBbTjwKHzEr35DpSk6keg@mail.gmail.com>
 <87o6fqhpcw.ffs@fw13> <87fr10faqi.ffs@fw13>
Date: Fri, 31 Jul 2026 00:15:46 +0200
Message-ID: <87cxw4f7jh.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Keno reported another subtle futex exit race, which is neither handled by
commit 3ca9595d9fb6 ("futex: Add support for unlocking robust futexes") nor
by the recent efforts around commit 3ca9595d9fb6 ("futex: Add support for
unlocking robust futexes").

The problem requires four tasks:

  T1 owns the futex, T2 and T3 sleep on the futex. The user space lock
  value is TID(T1) | FUTEX_WAITERS.

  T1
     Either:
        lockval = 0;		// Clears the FUTEX_WAITERS bit
	sys_futex(WAKE)
	   wakeup(T2)
     Or:
	sys_futex(ROBUST_UNLOCK)
	   lockval = 0;		// Clears the FUTEX_WAITERS bit
	   wakeup(T2)

     Note that both have the same issue:

  T4	pthread_mutex_lock()
  	   cmpxchg(0 -> TID(T4)) succeeds

  T2	exit_to_user()
           handle_signal()
	     do_exit()
	        exit_robust_list()
		   observes lockval = TID(T4)

  T4 	pthread_mutex_unlock()
  	   cmpxchg(TID(T4) -> 0) succeeds as the FUTEX_WAITERS bit is 0

That leaves T3 queued in the kernel. It only can get woken up by chance
when the futex becomes contended again.

Keno worked around this by unconditionally waking up a potential waiter
when exit_robust_list() observes that the user space lock value is owned
by another thread, but the FUTEX_WAITERS bit is not set. That "works",
but the whole mechanism is still inconsistent. Relying on a waiter
eventually coming around to clean up the mess in the robust list exit
path has to be considered the last resort.

Similar to PI futexes, robust futexes rely on consistent state, but robust
futexes lack the waiter accounting through the shared PI state of PI futex
waiters.

commit 3ca9595d9fb6 ("futex: Add support for unlocking robust futexes")
added support for unlocking contended robust futexes completely in the
kernel to "atomically" unlock the user space lock, clear the robust list
pending operation pointer and wake up eventually queued waiters, but
the unlock still unconditionally clears the FUTEX_WAITERS bit.

Amend that proceedure so it does the following steps:

   1) Skip the lockless check whether the hash bucket has waiters at all.

      This is required because using the quick check would still have the
      same problem:
						user_lock |= FUTEX_WAITERS;
	if (!futex_hb_waiters_pending(hb))
	   robust_unlock(0)			atomic_inc(hb::waiters);
						lock(hb);
						// Succeeds!
						if (compare_user_lock())
						   queue();

            user_lock = 0; // clears the FUTEX_WAITERS bit

      Though as the preceeding user space TIF(owner) -> 0 transition failed
      due to the FUTEX_WAITERS bit set it's likely that there is a waiter
      pending. The case where the waiter set the FUTEX_WAITERS bit in user
      space but did not make it into the waiters queue is unfortunate but
      unavoidable.

   2) Lock the hash bucket

      This ensures that any newly incoming waiters are serialized until the
      unlock operation has completed and observe the new state.

   3) Count the to be woken up tasks and check whether there are remaining
      waiters.

   4) Try to unlock the user space lock value either with 0 or
      FUTEX_WAITERS according to the result of #3

   5) If #4 succeeded proceed to #6. If not try to resolve the page fault
      and if successful go back to #1 otherwise fail.

   6) Collect the to be woken waiters

   7) Unlock the hash bucket

   8) Clear the robust list pending operation pointer in user space

   9) Wake the collected waiters

While it preserves the FUTEX_WAITERS bit when there are still waiters
queued after collecting the to be woken waiters, it still creates a window
of harmless inconsistency versus a newly incoming waiter:

       T1                                       T2
  #2   lock(hb);
  #3   remaining = evaluate_waiters();		if (!cmpxchg(0 -> TID))
  #4   lockval = remaining ? FUTEX_WAITERS : 0;	    sys_futex(WAIT, lockval)
  #6   collect_waiters();                             lock(hb) ...
  #7   unlock(hb);
                                                      if (lockval != uval)
						         return -EWOULDBLOCK;
						lockval |= FUTEX_WAITERS;
						sys_futex(WAIT, lockval)

When T1 sets the lock value to 0 because it can't find remaining waiters,
then T2 will observe under the hash bucket lock that the lock value has
changed and goes back to try again. That's part of the futex protocol and
both kernel and user space are prepared to handle it not only for this
case.

As #3 and #6 seem to be redundant operations they are not because as
explained above the elegible waiters cannot be collected into the wake
queue before the to be set state of the FUTEX_WAITERS bit has been
established.

Though this double list walk is avoided for the most common use case, which
just wakes exactly one waiter. That just requires to cache the pointer to
that wake up elegible waiter in #3, i.e. evaluate_waiters(), skipping the
second list walk in #6, i.e. collect_waiters() and collecting that cached
waiter directly. That's safe because the hash bucket lock is held across
the whole set of operations, i.e.the list is immutable.

Fixes: 3ca9595d9fb6 ("futex: Add support for unlocking robust futexes")
Reported-by: Keno Fischer <keno@juliahub.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Closes: https://lore.kernel.org/CABV8kRwvex1VvQ0eGwUQmJL_vA7AP2h64VpHqtXvfOXMvvJQZA@mail.gmail.com
---
 kernel/futex/futex.h    |    4 
 kernel/futex/waitwake.c |  288 ++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 242 insertions(+), 50 deletions(-)

--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -347,7 +347,7 @@ static inline void futex_hb_waiters_inc(
 #ifdef CONFIG_SMP
 	atomic_inc(&hb->waiters);
 	/*
-	 * Full barrier (A), see the ordering comment above.
+	 * Full barrier (A), see the ordering comment in waitwake.c
 	 */
 	smp_mb__after_atomic();
 #endif
@@ -368,7 +368,7 @@ static inline int futex_hb_waiters_pendi
 {
 #ifdef CONFIG_SMP
 	/*
-	 * Full barrier (B), see the ordering comment above.
+	 * Full barrier (B), see the ordering comment in waitwake.c
 	 */
 	smp_mb();
 	return atomic_read(&hb->waiters);
--- a/kernel/futex/waitwake.c
+++ b/kernel/futex/waitwake.c
@@ -149,83 +149,275 @@ void futex_wake_mark(struct wake_q_head
 	wake_q_add_safe(wake_q, p);
 }
 
+static int evaluate_waiters(struct futex_hash_bucket *hb, union futex_key *key,
+			    unsigned int nr_wake, u32 bitset, struct futex_q **to_wake)
+{
+	unsigned int waiters = 0, wakees = 0;
+	struct futex_q *this, *next;
+
+	plist_for_each_entry_safe(this, next, &hb->chain, list) {
+		if (!futex_match(&this->key, key))
+			continue;
+
+		if (this->pi_state || this->rt_waiter)
+			return -EINVAL;
+
+		/*
+		 * Waiters are counted independent of the bitset match. Stop the
+		 * list walk when the total number of waiters becomes larger
+		 * than the number of to be woken up tasks. In that case it does
+		 * not matter how many wakees have been found. There will be
+		 * waiters queued after the wake up no matter what.
+		 */
+		if (++waiters > nr_wake)
+			return 1;
+
+		/*
+		 * If the bitset matches increment @wakees unconditionally. It
+		 * can't get larger than @nr_wake due to the exit condition
+		 * above.
+		 */
+		if (this->bitset & bitset) {
+			*to_wake = this;
+			wakees++;
+		}
+	}
+
+	/* Tell the caller whether there are more waiters than wakees */
+	return waiters > wakees;
+}
+
+static inline int collect_cached_waiter(struct wake_q_head *wake_q, struct futex_q *to_wake)
+{
+	if (!to_wake)
+		return 0;
+	to_wake->wake(wake_q, to_wake);
+	return 1;
+}
+
+static int collect_waiters(struct futex_hash_bucket *hb, struct wake_q_head *wake_q,
+			   union futex_key *key, unsigned int nr_wake, u32 bitset)
+{
+	struct futex_q *this, *next;
+	unsigned int wakees = 0;
+
+	plist_for_each_entry_safe(this, next, &hb->chain, list) {
+		if (!futex_match(&this->key, key))
+			continue;
+
+		if (this->pi_state || this->rt_waiter)
+			return -EINVAL;
+
+		/* Check if one of the bits is set in both bitsets */
+		if (!(this->bitset & bitset))
+			continue;
+
+		this->wake(wake_q, this);
+		if (++wakees == nr_wake)
+			break;
+	}
+
+	return wakees;
+}
+
+static int __futex_robust_unlock(u32 __user *uaddr, void __user *pop, unsigned int flags,
+				 unsigned int nr_wake, u32 bitset,
+				 struct wake_q_head *wake_q)
+{
+	union futex_key key = FUTEX_KEY_INIT;
+	int ret, nr_woken = 0;
+
+	/*
+	 * In the case that unlocking of the user space lock faulted, this could
+	 * be optimized to not re-evaluate the key for private futexes, but
+	 * there is actually zero benefit to do so. It's very unlikely that the
+	 * unlock faults right after user space attempted a TID -> 0 transition
+	 * on that address, so optimizing for that corner case is pointless.
+	 */
+	ret = get_futex_key(uaddr, flags, &key, FUTEX_WRITE);
+	if (unlikely(ret))
+		return ret;
+
+	CLASS(hbr, hbr)(&key);
+	auto hb = hbr.hb;
+
+	/*
+	 * This has to take the hash bucket lock unconditionally and cannot rely
+	 * on futex_hb_waiters_pending(hb) as that would open a race condition
+	 * between the unlock operation and a concurrent incoming waiter:
+	 *
+	 *						user_lock |= FUTEX_WAITERS;
+	 *   if (!futex_hb_waiters_pending(hb))
+	 *	robust_unlock(0)			atomic_inc(hb::waiters);
+	 *						lock(hb)
+	 *						// Succeeds!
+	 *						compare_user_lock()
+	 *
+	 *	    user_lock = 0; // clears the FUTEX_WAITERS bit
+	 *
+	 * Though it's likely that there is at least one waiter queued because
+	 * the userspace TID -> 0 transition failed due to the FUTEX_WAITERS bit
+	 * being set, which means the lock has to be taken in the majority of
+	 * cases anyway.
+	 */
+	scoped_guard(spinlock, &hb->lock) {
+		struct futex_q *to_wake = NULL;
+
+		/*
+		 * The unlock has to happen _before_ waiters are collected
+		 * because they can return from futex_wait() without taking the
+		 * hash bucket lock when collect_waiters() sets futex_q::lock_ptr
+		 * to NULL. That can result in the following situation:
+		 *
+		 * collect_waiters()
+		 *   collects T2		kill(T2);
+		 *	q->lock_ptr = NULL	T2 runs
+		 *				if (!q->lock_ptr)
+		 *				    return;
+		 *				exit_to_user()
+		 *				  handle_signal()
+		 *				    do_exit()
+		 *				      handle_futex_death()
+		 *				      // observes lock = TID(OWNER)
+		 * lock = FUTEX_WAITERS;
+		 *
+		 * That means all waiters which are still queued can become
+		 * stale unless there is another lock/unlock operation on the
+		 * futex later.
+		 *
+		 * Evaluate waiters and wakees to keep the FUTEX_WAITERS bit in
+		 * the user space lock consistent.
+		 */
+		ret = evaluate_waiters(hb, &key, nr_wake, bitset, &to_wake);
+		if (ret < 0)
+			return ret;
+
+		/*
+		 * Unlock the futex in user space while holding the hash bucket
+		 * lock to keep the FUTEX_WAITERS bit consistent. Newly incoming
+		 * waiters are serialized on the hash bucket lock and will
+		 * observe that the user space value has changed once they
+		 * acquired it.
+		 */
+		u32 uval = ret ? FUTEX_WAITERS : 0;
+
+		guard(pagefault)();
+		scoped_user_write_access(uaddr, efault_uaddr)
+			unsafe_atomic_store_release_user(uval, uaddr, efault_uaddr);
+
+		/*
+		 * Now that the unlock has been successful, collect the waiters
+		 * for wake up. If @nr_wake is 1, which is the common case, then
+		 * evaluate_waiters() has stored the first elegible waiter in
+		 * @to_wake, if it found one.  Spare another hash bucket walk
+		 * for that case.
+		 */
+		if (likely(nr_wake == 1))
+			nr_woken = collect_cached_waiter(wake_q, to_wake);
+		else
+			nr_woken = collect_waiters(hb, wake_q, &key, nr_wake, bitset);
+
+		/*
+		 * This should never happen because evaluate_waiters() would
+		 * have detected a PI futex mixup already.
+		 */
+		if (WARN_ON_ONCE(nr_woken < 0))
+			return nr_woken;
+	}
+
+	/*
+	 * Clear the pending list op now that everything is done. If clearing
+	 * the pending op fails, then the task is in deeper trouble as the
+	 * robust list head is usually part of the TLS. The chance of survival
+	 * is close to zero and retry is pointless as the fault is terminal.
+	 */
+	return futex_robust_list_clear_pending(pop, flags) ? nr_woken : -EFAULT;
+
+efault_uaddr:
+	/* Unlock faulted. Try to fault in @uaddr and repeat if successful */
+	return fault_in_user_writeable(uaddr) ? : -EAGAIN;
+}
+
 /*
- * If requested, clear the robust list pending op and unlock the futex
+ * Robust futex unlock procedure:
+ *
+ *	- count waiters to determine the FUTEX_WAITERS bit for the unlock
+ *	- unlock the user space lock
+ *	- collect up to @nr_wake waiters
+ *	- clear the user space robust list pending op pointer
+ *	- wake up the collected waiters.
  */
-static bool futex_robust_unlock(u32 __user *uaddr, unsigned int flags, void __user *pop)
+static int futex_robust_unlock(u32 __user *uaddr, void __user *pop, unsigned int flags,
+			       unsigned int nr_wake, u32 bitset)
 {
-	if (!(flags & FLAGS_ROBUST_UNLOCK))
-		return true;
-
-	/* First unlock the futex, which requires release semantics. */
-	scoped_user_write_access(uaddr, efault)
-		unsafe_atomic_store_release_user(0, uaddr, efault);
+	DEFINE_WAKE_Q(wake_q);
+	int ret = -EAGAIN;
 
 	/*
-	 * Clear the pending list op now. If that fails, then the task is in
-	 * deeper trouble as the robust list head is usually part of the TLS.
-	 * The chance of survival is close to zero.
+	 * This loops in case that unlocking the user space lock faults and the
+	 * fault resolution is successful.
 	 */
-	return futex_robust_list_clear_pending(pop, flags);
+	for (; ret == -EAGAIN;)
+		ret = __futex_robust_unlock(uaddr, pop, flags, nr_wake, bitset, &wake_q);
 
-efault:
-	return false;
+	wake_up_q(&wake_q);
+	return ret;
 }
 
 /*
- * Wake up waiters matching bitset queued on this futex (uaddr).
+ * Plain wake() operation procedure:
+ *	- collect and wake up to @nr_wake waiters
  */
-int futex_wake(u32 __user *uaddr, unsigned int flags, void __user *pop, int nr_wake, u32 bitset)
+static int __futex_wake(u32 __user *uaddr, unsigned int flags, unsigned int nr_wake, u32 bitset)
 {
 	union futex_key key = FUTEX_KEY_INIT;
-	struct futex_q *this, *next;
 	DEFINE_WAKE_Q(wake_q);
 	int ret;
 
-	if (!bitset)
-		return -EINVAL;
-
 	ret = get_futex_key(uaddr, flags, &key, FUTEX_READ);
-	if (unlikely(ret != 0))
+	if (unlikely(ret))
 		return ret;
 
-	if (!futex_robust_unlock(uaddr, flags, pop))
-		return -EFAULT;
-
-	if ((flags & FLAGS_STRICT) && !nr_wake)
-		return 0;
-
 	CLASS(hbr, hbr)(&key);
 	auto hb = hbr.hb;
 
-	/* Make sure we really have tasks to wakeup */
+	/*
+	 * For regular wakeup operations the lockless quick check is
+	 * sufficient. See the ordering guarantees documentation at the top of
+	 * this file.
+	 */
 	if (!futex_hb_waiters_pending(hb))
-		return ret;
-
-	spin_lock(&hb->lock);
+		return 0;
 
-	plist_for_each_entry_safe(this, next, &hb->chain, list) {
-		if (futex_match (&this->key, &key)) {
-			if (this->pi_state || this->rt_waiter) {
-				ret = -EINVAL;
-				break;
-			}
-
-			/* Check if one of the bits is set in both bitsets */
-			if (!(this->bitset & bitset))
-				continue;
-
-			this->wake(&wake_q, this);
-			if (++ret >= nr_wake)
-				break;
-		}
-	}
+	scoped_guard(spinlock, &hb->lock)
+		ret = collect_waiters(hb, &wake_q, &key, nr_wake, bitset);
 
-	spin_unlock(&hb->lock);
 	wake_up_q(&wake_q);
 	return ret;
 }
 
+/*
+ * Wake up waiters matching bitset queued on this futex (uaddr).
+ */
+int futex_wake(u32 __user *uaddr, unsigned int flags, void __user *pop, int nr_wake, u32 bitset)
+{
+	bool robust_unlock = !!(flags & FLAGS_ROBUST_UNLOCK);
+
+	if (!bitset || nr_wake < 0)
+		return -EINVAL;
+
+	if (unlikely(!nr_wake)) {
+		if (flags & FLAGS_STRICT)
+			return robust_unlock ? -EINVAL : 0;
+		nr_wake = 1;
+	}
+
+	if (robust_unlock)
+		return futex_robust_unlock(uaddr, pop, flags, nr_wake, bitset);
+
+	return __futex_wake(uaddr, flags, nr_wake, bitset);
+}
+
 static int futex_atomic_op_inuser(unsigned int encoded_op, u32 __user *uaddr)
 {
 	unsigned int op =	  (encoded_op & 0x70000000) >> 28;
