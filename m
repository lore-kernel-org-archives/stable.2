Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0F83451CE;
	Sun, 26 Jul 2026 20:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785098381; cv=none; b=JIdGilG/5Ta0vEyYaI+bzX6WqlUadI5bV/yXtt0KBWftPGqnJs87Dmk1TZgs/2MYQgTB2bSGrRpQJVyHIZEG0a/neq4ykHJ0ZAKz6sZ/a1K/kZkdlHhnvSlkfTXRDLyR9Uj4ANVTvum4SEGfMbDTwey025DlFVbPAzSgzGStvQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785098381; c=relaxed/simple;
	bh=r0sl2CxGfJShjsLXI9s3SyQhQwmggUCXMc76FdDLn+M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mYKEOOOWpThHz9bCz7T27sBuOL0H86N30cbAipZzMB8jJ3NZOHd8zp93UvCIVQmj4jR4cZSKKE4wSPwZ+akGeRVEzYvQBkVDSEnpTos5atta0q5rfk6Zhc8K8o/QhALrI01LaJFhm15/JS+t5BoQ1YIS7UxWIcXrLGgiumbJwL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QELJiVZ3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QELJiVZ3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF4A1F000E9;
	Sun, 26 Jul 2026 20:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785098379;
	bh=quqRCgIATdgRT0ITsYC6BFXnl0cbTKjHF6pWMEKBzX8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=QELJiVZ3Q33vSea6MxkV3BVjS1puSOG8+X7eiepEz+fDOEBOCJ8SqBazP85ont15w
	 CbobBh0aeMiS8xql6jnfvKm9Lm9RE3PqIQTuZttvJPlwIm7RCsIyFypJIaH0msqsyi
	 f7pXUWIHYu8nmAvBSld5z2WXomvAdf34tuhdyqQivQy3dZH1kMITRc+M/oJYHwP7Rp
	 SWtUPyGskudJKCFZNpyGV/+7toB1XstyI/zGs3YicPrlP4dvG9RmhXrp8yUWjTX5rC
	 S9EuAUcrs3GIcn/fouLTohfJjZknOddIbLeSiKmJicJIYqAhQKk8kza8WNK0Vr7W0Q
	 3cT6w5eNkyItw==
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
In-Reply-To: <CABV8kRz5c4opGVA3CPdALWxjUH_DkLf_tBLdefajsSevfHFYpQ@mail.gmail.com>
References: <CABV8kRwvex1VvQ0eGwUQmJL_vA7AP2h64VpHqtXvfOXMvvJQZA@mail.gmail.com>
 <87bjc0led9.ffs@fw13>
 <CABV8kRwDhwa_OoQ9zx4sv3tDATZc0Yy-mYGObRXw59DO0cDfLw@mail.gmail.com>
 <87v7a7jeav.ffs@fw13>
 <CABV8kRz5c4opGVA3CPdALWxjUH_DkLf_tBLdefajsSevfHFYpQ@mail.gmail.com>
Date: Sun, 26 Jul 2026 22:39:35 +0200
Message-ID: <87zezdiiyg.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jul 23 2026 at 12:44, Keno Fischer wrote:
>
> +/* Store to user memory with release ordering and pagefaults disabled */
> +static inline int futex_put_value_locked(u32 val, u32 __user *to)

'put' is a bad name as it does not express the release() semantics.

> +		/*
> +		 * Check for remaining waiters on this futex. Error
> +		 * conditions from futex_wake_locked() are ignored here to
> +		 * ensure that the next wake takes the contended path and
> +		 * observes those errors.
> +		 */
> +		plist_for_each_entry(this, &hb->chain, list) {
> +			if (futex_match(&this->key, key)) {
> +				mval = FUTEX_WAITERS;
> +				break;
> +			}

That can be done in the loop which collects waiters for wakeup.

> +		}
> +
> +		if (!futex_put_value_locked(mval, uaddr))
> +			return 0;
>
> -efault:
> -	return false;
> +		spin_unlock(&hb->lock);
> +		ret = fault_in_user_writeable(uaddr) ? -EFAULT : 0;
> +		spin_lock(&hb->lock);
> +		if (ret)
> +			return ret;
> +	}

You _cannot_ loop here without reevaluating the futex key if the futex
is shared. The key stays only valid for private futexes.

>  }
>
>  /*
> @@ -177,8 +220,9 @@ static bool futex_robust_unlock(u32 __user *uaddr,
> unsigned int flags, void __us
>   */
>  int futex_wake(u32 __user *uaddr, unsigned int flags, void __user
> *pop, int nr_wake, u32 bitset)
>  {
> +	bool robust = flags & FLAGS_ROBUST_UNLOCK;
> +	bool wake = !((flags & FLAGS_STRICT) && !nr_wake);

Clever, but I had to read this five times to convince myself that it and
it's usage are correct. :(

>  	union futex_key key = FUTEX_KEY_INIT;
> -	struct futex_q *this, *next;
>  	DEFINE_WAKE_Q(wake_q);
>  	int ret;
>
> @@ -189,39 +233,44 @@ int futex_wake(u32 __user *uaddr, unsigned int
> flags, void __user *pop, int nr_w
>  	if (unlikely(ret != 0))
>  		return ret;
>
> -	if (!futex_robust_unlock(uaddr, flags, pop))
> -		return -EFAULT;
> -
> -	if ((flags & FLAGS_STRICT) && !nr_wake)
> +	if (!robust && !wake)
>  		return 0;

To me a robust unlock operation with zero wakeups does not make any
sense. The point of FLAGS_ROBUST_UNLOCK is that the user space (VDSO)
transition from TID to 0 failed due to the waiter bit being set. That
requires to go into the kernel to handle the unlock, pending op and
wakeup sequence atomically, which is not possible in user space.
So I'd rather return -EINVAL for that case.

>  	CLASS(hbr, hbr)(&key);
>  	auto hb = hbr.hb;
>
> -	/* Make sure we really have tasks to wakeup */
> -	if (!futex_hb_waiters_pending(hb))
> -		return ret;
> +	/*
> +	 * Make sure we really have tasks to wakeup. No fast path for @robust,
> +	 * the unlock needs to happen regardless.

That's a pretty meager comment. If you look carefully then you'll notice
that the futex code has a comment to code ratio of 0.75. That's not
because we love comments so much :)

> +	 */
> +	if (!robust && !futex_hb_waiters_pending(hb))
> +		return 0;
>
>  	spin_lock(&hb->lock);
>
> -	plist_for_each_entry_safe(this, next, &hb->chain, list) {
> -		if (futex_match (&this->key, &key)) {
> -			if (this->pi_state || this->rt_waiter) {
> -				ret = -EINVAL;
> -				break;
> -			}
> +	if (wake)
> +		ret = futex_wake_locked(hb, &key, &wake_q, nr_wake, bitset);
>
> -			/* Check if one of the bits is set in both bitsets */
> -			if (!(this->bitset & bitset))
> -				continue;
> -
> -			this->wake(&wake_q, this);
> -			if (++ret >= nr_wake)
> -				break;
> -		}
> +	if (robust && futex_robust_release(hb, &key, uaddr)) {
> +		spin_unlock(&hb->lock);
> +		/*
> +		 * The futex word could not be released. Keep the pending list armed.
> +		 */
> +		ret = -EFAULT;
> +		goto out;
>  	}
>
>  	spin_unlock(&hb->lock);
> +
> +	/*
> +	 * With the futex word released, clear the pending list op now. If
> +	 * that fails, then the task is in deeper trouble as the robust list
> +	 * head is usually part of the TLS. The chance of survival is close
> +	 * to zero.
> +	 */
> +	if (robust && !futex_robust_list_clear_pending(pop, flags))
> +		ret = -EFAULT;
> +out:
>  	wake_up_q(&wake_q);
>  	return ret;

For my taste there are too many if (robust) conditionals in this code. I
really prefer a clear separation of the regular wake() path and the
robust_unlock() case.

Something like the compiled but completely untested below.

Thanks,

        tglx
---
 kernel/futex/futex.h    |    4 
 kernel/futex/waitwake.c |  234 +++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 187 insertions(+), 51 deletions(-)

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
@@ -149,81 +149,217 @@ void futex_wake_mark(struct wake_q_head
 	wake_q_add_safe(wake_q, p);
 }
 
+struct futex_wake_q_head {
+	struct wake_q_head	wake_q;
+	unsigned int		wakees;
+	bool			robust_unlock;
+	bool			waiters_left;
+};
+
+#define FUTEX_WAKE_Q(name)					\
+	struct futex_wake_q_head name = {			\
+		.wake_q = WAKE_Q_HEAD_INITIALIZER(name.wake_q),	\
+	}
+
+static int collect_waiters(struct futex_hash_bucket *hb, struct futex_wake_q_head *fwake_q,
+			   union futex_key *key, unsigned int nr_wake, u32 bitset)
+{
+	struct futex_q *this, *next;
+	unsigned int matches = 0;
+
+	plist_for_each_entry_safe(this, next, &hb->chain, list) {
+		if (!futex_match(&this->key, key))
+			continue;
+
+		if (this->pi_state || this->rt_waiter)
+			return -EINVAL;
+
+		/*
+		 * To determine whether there are waiters queued after
+		 * collecting @nr_wake wakees, increment the match count
+		 * independent of the bitset condition.
+		 */
+		matches++;
+
+		/* Check if one of the bits is set in both bitsets */
+		if (!(this->bitset & bitset))
+			continue;
+
+		/*
+		 * Terminates the loop for the robust_unlock case. Regular
+		 * wake() operations already terminated below.
+		 */
+		if (fwake_q->wakees == nr_wake)
+			break;
+
+		this->wake(&fwake_q->wake_q, this);
+		fwake_q->wakees++;
+		/*
+		 * For regular wake() operatins stop when the waiter count is
+		 * reached. For futex_robust_unlock() continue to figure out
+		 * whether there are more waiters queued.
+		 */
+		if (!fwake_q->robust_unlock && fwake_q->wakees == nr_wake)
+			break;
+	}
+
+	fwake_q->waiters_left = matches > fwake_q->wakees;
+	return fwake_q->wakees;
+}
+
+static int __futex_robust_unlock(u32 __user *uaddr, void __user *pop, unsigned int flags,
+				 unsigned int nr_wake, u32 bitset,
+				 struct futex_wake_q_head *fwake_q)
+{
+	union futex_key key = FUTEX_KEY_INIT;
+	int ret;
+
+	/*
+	 * In the case that unlocking the user space lock faulted, this could be
+	 * optimized to not re-evaluate the key for private futexes, but there
+	 * is actually zero benefit to do so. It's very unlikely that the unlock
+	 * faults right after user space attempted a TID -> 0 transition on that
+	 * address, so optimizing for that corner case is pointless.
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
+	 *   if (futex_hb_waiters_pending(hb))
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
+		ret = collect_waiters(hb, fwake_q, &key, nr_wake, bitset);
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
+		u32 uval = fwake_q->waiters_left ? FUTEX_WAITERS : 0;
+
+		guard(pagefault)();
+		scoped_user_write_access(uaddr, efault_uaddr)
+			unsafe_atomic_store_release_user(uval, uaddr, efault_uaddr);
+	}
+
+	/*
+	 * Clear the pending list op now that the unlock succeeded. If clearing
+	 * the pending op fails, then the task is in deeper trouble as the
+	 * robust list head is usually part of the TLS. The chance of survival
+	 * is close to zero and retry is pointless as the fault is terminal.
+	 */
+	return futex_robust_list_clear_pending(pop, flags) ? fwake_q->wakees : -EFAULT;
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
+ *	- collect up to @nr_wake waiters and check whether there are more waiters queued
+ *	- unlock the user space lock and keep the FUTEX_WAITER bit consistent
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
+	FUTEX_WAKE_Q(fwake_q);
+	int ret = -EAGAIN;
 
 	/*
-	 * Clear the pending list op now. If that fails, then the task is in
-	 * deeper trouble as the robust list head is usually part of the TLS.
-	 * The chance of survival is close to zero.
+	 * This loops in case that unlocking the user space lock faults and the
+	 * fault resolution is successful. fwake_q.wakees holds the number of
+	 * collected waiters of the first pass so collect_waiters() won't
+	 * collect more than @nr_wake, but it has to be invoked again after a
+	 * fault to keep the FUTEX_WAITER bit consistent for the next unlock
+	 * attempt.
 	 */
-	return futex_robust_list_clear_pending(pop, flags);
+	for (fwake_q.robust_unlock = true; ret == -EAGAIN;)
+		ret = __futex_robust_unlock(uaddr, pop, flags, nr_wake, bitset, &fwake_q);
 
-efault:
-	return false;
+	wake_up_q(&fwake_q.wake_q);
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
-	DEFINE_WAKE_Q(wake_q);
+	FUTEX_WAKE_Q(fwake_q);
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
+		ret = collect_waiters(hb, &fwake_q, &key, nr_wake, bitset);
 
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
+	wake_up_q(&fwake_q.wake_q);
+	return ret;
+}
+
+/*
+ * Wake up waiters matching bitset queued on this futex (uaddr).
+ */
+int futex_wake(u32 __user *uaddr, unsigned int flags, void __user *pop, int nr_wake, u32 bitset)
+{
+	bool robust_unlock = !!(flags & FUTEX_ROBUST_UNLOCK);
+
+	if (!bitset || nr_wake < 0)
+		return -EINVAL;
+
+	if (unlikely(!nr_wake)) {
+		if (flags & FLAGS_STRICT)
+			return robust_unlock ? -EINVAL : 0;
+		nr_wake = 1;
 	}
 
-	spin_unlock(&hb->lock);
-	wake_up_q(&wake_q);
-	return ret;
+	if (robust_unlock)
+		return futex_robust_unlock(uaddr, pop, flags, nr_wake, bitset);
+
+	return __futex_wake(uaddr, flags, nr_wake, bitset);
 }
 
 static int futex_atomic_op_inuser(unsigned int encoded_op, u32 __user *uaddr)


