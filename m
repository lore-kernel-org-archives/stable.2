Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3657C40096C;
	Mon, 27 Jul 2026 13:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785157938; cv=none; b=ZTFiFqVM7yXFBG0BMxw78wHRKN2xuBLk7X54A1UzdF0rwY6qztL8dxnYHS3RoLwR49VgTnfTnrYe7sXmK48LG1w7SA7eUfeTeUmDXAxlrbiKl9Mo8R1BcwJxy0V/SIiEkWVxXvubrnfEBhedCNUOA1E90Qc686oA4jhwnxSyANM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785157938; c=relaxed/simple;
	bh=9vtxrXI1XJ5ZniTqUB0rmQUPfjjpMAtMlba39/704Qk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z8DeEVQ6owBGuRV/0w7yRNR92r8HdOkCEbVeD4zDKnPMRs2WOhhWldLPinQSU3Txy6R0ckU1yzglQey3MJX4I1g1dEjoS8kMQ6X/lIZ6WW4Ru3oWaYNVWSheRsmvirJMF4QJa99cD4tGxWWKKyhvdq1eP8YWdXwXp1nnt3DAV78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1zvJAXQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1zvJAXQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B5DC1F000E9;
	Mon, 27 Jul 2026 13:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785157936;
	bh=URzOno02y8g3HbjIuGsbOekTNekjY67KSbP8PLZyPno=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=B1zvJAXQxJYbRxu6BodCGT06hph6AVeTuS8gtk4WPrwjcqY9KvV4orCkDZVX04SrJ
	 uy+szEj8cjzWdglN/CviF33mkO4Qw7d9xSQ2zLtNUqPyT6LImb18ZZ0LyeT18DzgBq
	 PatRnW5xUMGTLnz5uG1AESZxcCcehqRHVv50MnWFOWaecz7DmkjIK8dxG05Czk4nTb
	 GD82r7SIWEfV4wUfgbsdAUrRczxCjoXtaNDUFms7ImD9FO9JTuu3dIGRtI3Bb9ak5H
	 CYSaqNQHG3mG/GzdIbs8E6I+PToO8/D3eoWFrd4PLLXEUPdOH13hUENz/j5QIarqk3
	 lNQ4sP8AvlOrw==
From: Thomas Gleixner <tglx@kernel.org>
To: Keno Fischer <keno@juliahub.com>
Cc: Keno Fischer <keno@juliahub.com>, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, =?utf-8?Q?Andr=C3=A9?= Almeida
 <andrealmeid@igalia.com>, Yang Tao <yang.tao172@zte.com.cn>, Yi Wang
 <wang.yi59@zte.com.cn>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, stable@vger.kernel.org, Florian Weimer
 <fweimer@redhat.com>, Oleg Nesterov <oleg@redhat.com>, Christian Brauner
 <brauner@kernel.org>
Subject: Re: [PATCH] futex: Prevent robust futex exit race more
In-Reply-To: <CABV8kRz1nLxUDAgCSKHB2oqME74M6PyxB-t+u1it=6eYo5cFAQ@mail.gmail.com>
References: <CABV8kRwvex1VvQ0eGwUQmJL_vA7AP2h64VpHqtXvfOXMvvJQZA@mail.gmail.com>
 <87bjc0led9.ffs@fw13>
 <CABV8kRwDhwa_OoQ9zx4sv3tDATZc0Yy-mYGObRXw59DO0cDfLw@mail.gmail.com>
 <87v7a7jeav.ffs@fw13>
 <CABV8kRz5c4opGVA3CPdALWxjUH_DkLf_tBLdefajsSevfHFYpQ@mail.gmail.com>
 <87zezdiiyg.ffs@fw13>
 <CABV8kRz1nLxUDAgCSKHB2oqME74M6PyxB-t+u1it=6eYo5cFAQ@mail.gmail.com>
Date: Mon, 27 Jul 2026 15:12:13 +0200
Message-ID: <87ldawinki.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Keno!

On Sun, Jul 26 2026 at 15:54, Keno Fischer wrote:
> On Sun, 26 Jul 2026 22:39:35 +0200, Thomas Gleixner <tglx@kernel.org> wrote:
>> Something like the compiled but completely untested below.
>
> Two issues noted below. With those fixed, passed my local test cases.
> However, I re-ran the full TLA+ analysis over this protocol and it doesn't
> fully resolve the lost-wakeup issue (both your and my revised patch).
> In particular, if we drop the hb lock for a pagefault,
> the waiter(s) we collected could have died and run exit
> processing before we perform the store (so exit handling wouldn't
> have performed the extra wakeup). In that case, waiters behind are stranded.

The problem is independent of the pagefault and the hash bucket lock. At
the point where the waiter is dequeued from the hash bucket it can
vanish:

  collect_waiters()
    collect T2
      q->lock_ptr = NULL	kill(T2);
      				T2 runs
                                if (!q->lock_ptr)
                                   return;
                                exit_to_user()
                                  handle_signal()
                                    do_exit()
                                      handle_futex_death()
                                      // observes lock = TID(T1)
  lock = FUTEX_WAITERS;

> I think the simplest fix would be to separate the count and waiter
> collection and only ->wake the waiters *AFTER* the release store has
> run successfully.

I really wanted to avoid the double search, but yes ...

>> +static int collect_waiters(struct futex_hash_bucket *hb, struct futex_wake_q_head *fwake_q,
>> +			   union futex_key *key, unsigned int nr_wake, u32 bitset)
>> +{
>> +	struct futex_q *this, *next;
>> +	unsigned int matches = 0;
>
> `matches` cannot be local here - either needs to go into futex_wake_q_head or
> needs to set `waiters_left` in `continue` path an the robust nr_wake
> path.

It can be set unconditionally here:

   unsigned int matches = fwake_q->wakees;

But with the separate count/collect it does not matter anymore.

>> +/*
>> + * Wake up waiters matching bitset queued on this futex (uaddr).
>> + */
>> +int futex_wake(u32 __user *uaddr, unsigned int flags, void __user *pop, int nr_wake, u32 bitset)
>> +{
>> +	bool robust_unlock = !!(flags & FUTEX_ROBUST_UNLOCK);
>
> FLAGS_ROBUST_UNLOCK

Indeed.

>> +	if (!bitset || nr_wake < 0)
>> +		return -EINVAL;
>
> Noting that this changes userspace ABI for `nr_wake < 0` (e.g. for userspace
> accidentally passing UINT_MAX rather than INT_MAX), although the current
> behavior is of course surprising and in a quick audit, I didn't see any public
> userspace code that gets this wrong, so worth trying probably. It's certainly
> better behavior.

I did'nt find any evidence either. It bugged me because it's ill defined.

Aside of that any value > INT_MAX will not result in the intended mass
wake up in the current code. It will wake exactly one waiter due to the
loop termination condition:

     if (++waiters >= nr_wake)
     	  break;

So that'd be broken already and I rather be explicit about it than
silently "handling" it. The other option to solve this is to make the
@nr_wake argument of futex_wake() unsigned int. That would be consistent
with the sys_futex() @val argument is u32, but the @nr_wake argument of
sys_futex_wake() is int. Duh!

Reworked version below.

Thanks,

        tglx
---
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
@@ -149,83 +149,257 @@ void futex_wake_mark(struct wake_q_head
 	wake_q_add_safe(wake_q, p);
 }
 
+static int evaluate_waiters(struct futex_hash_bucket *hb, union futex_key *key,
+			    unsigned int nr_wake, u32 bitset)
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
+		if (this->bitset & bitset)
+			wakees++;
+	}
+
+	/* Tell the caller whether there are more waiters than wakees */
+	return waiters > wakees;
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
+	int ret, nr_woken;
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
+		ret = evaluate_waiters(hb, &key, nr_wake, bitset);
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
+		 * for wake up.
+		 */
+		nr_woken = collect_waiters(hb, wake_q, &key, nr_wake, bitset);
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
+		return 0;
 
-	spin_lock(&hb->lock);
+	scoped_guard(spinlock, &hb->lock)
+		ret = collect_waiters(hb, &wake_q, &key, nr_wake, bitset);
 
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
-
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

