Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878433DE457
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 19:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784835873; cv=pass; b=ns41TyXQ+yMTNdY5nZqB4i3et01ErU56ZQJRl3wKfx1BAt7kA2Lra23LZkGVtD3MtRR3pNYz8OJ+lGPVNZNasxcghSUo5QqHSh53+gCeyNv8prRva4+5IyV0vByH8MEgv4fiTgbgNVT3dcB58okJGqvM9rH6dVFazyjDYWwVABE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784835873; c=relaxed/simple;
	bh=w1DU8Rl1YH8JvY02/XfgB8+OmlRx7VZf9zPWJSLM1u0=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OS+lygO0m+vrv4a93SlFLDK4ArVAZ3ZXpR3Ul67PFyzo1bAnUBPu3ehTD641SxO81WJXTe0YymBQCEy1xSq/Q73yY6hxzLBq4870qDv5LMlBITowFRQuHcn4cOVr1ppHchrHGixMR5vghS7I1fhE3+71si9+gidNdDOVbPUTWd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=juliahub.com; spf=pass smtp.mailfrom=juliahub.com; dkim=pass (2048-bit key) header.d=juliahub.com header.i=@juliahub.com header.b=XY/UB8MD; arc=pass smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=juliahub.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=juliahub.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=juliahub.com header.i=@juliahub.com header.b="XY/UB8MD"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8ff88549786so12758596d6.3
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 12:44:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784835862; cv=none;
        d=google.com; s=arc-20260327;
        b=jPzsJqZwgxt9v9VczRdNARv//IkmW625NK9x9iFLM4RxlMS1uMA998NSBKlRhbfn3A
         m+fPL2yI2twA0S7aODI7FAS1AClbANoxNEOkhX6T2fwWVaCL3c180JoBG0yD0CC/fycQ
         drdCZBeT33e/tRYuq4sZbrdUdtGuM/BpgOmYsk4qBahp2uYN7D/0/9quRHD7K8i2k6EH
         jQZWZuWV0+H37YI8jYakE6ygCOiWSKZvXWPeonCTH8xCLU95OuLyyvuM50UG9l07AzG5
         glLTLMM9B7HtQMVvzvf+EMK7izaqMzfYqIV+w1azToDT2NUrqb8izF+Wsn1qDJ4EJHhR
         U/Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature;
        bh=YmAwEUVDsgoqK5MoBv/fTt6tDTPOqS+wZ9ziTUnEPTE=;
        fh=JRFncvRvgoANjLQKr3FihMPSYIEfyl8iuVTL2bigipM=;
        b=QlR1EKdCP9B6kJxSJzXqanbENv5aXnrpOz0OWSyN/BuMv11CLXo0K3Sp7WCBOHZZjE
         tsSmd7oOyhpTtaykbDQTg4O4as/YN1tttfBVnBiQ8lUJ7k03bb3mTgjrQ4B9Wuq8b+Dm
         TnaxVm1vPAMzUkudtWvJy6ltEJKXfikaRuuDezeUDALHSlQ8GVdty6P2E+oegDdY2eJq
         bOYCdiL8TmJwp6XvtVHcz6+JpaOtij6LPjmJY5XX8D6VWyI+6yzgX4uGqsre4JhxqlwQ
         TnqtdEwqM8bubdyTV410ajOSE2tujm6CLMulQlY6idLKRynOjwk+6RWj6USArhrcf0+s
         RWyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=juliahub.com; s=google; t=1784835862; x=1785440662; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YmAwEUVDsgoqK5MoBv/fTt6tDTPOqS+wZ9ziTUnEPTE=;
        b=XY/UB8MDi3twbywdregkw8wG5BaLT6Wsgk7qSoBTmTxMxwma5U6DGk7VIiZDpB2s7c
         N0RYsvsa0Lq41AKnYhr50nxmT/gd9zINI84EA8fhTdcD3/z9yVBQPF62hKc03uhbM73q
         FNZXXZtNyCfJHQZ1zhA+qE5JOFkBY9QLfK/spyDIuahpwvoArcoq14xuEA46u3HbOLDp
         gd56E5C0m0DzdLFpIyZm3+kziRkPqn5iRUm66y31Dq4DjnluNVvZcwTPOYuR1T1z02Mu
         5X+IPnldEjkHd9DbRQpvIl3u4vvTeo4VAS0VxWcKD1nKp9jh1o+Zc7goqX0tOg9xvfRM
         ZGLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784835862; x=1785440662;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YmAwEUVDsgoqK5MoBv/fTt6tDTPOqS+wZ9ziTUnEPTE=;
        b=J0mRDprmwgnVII5XtMTsQtT1e6nC0ORXVK7FjGsq5Y0cDKTSo/MZepJFCjCLkbRyw0
         yWHCtYKJdqzIoP5THeNKfiMqcA95Q07TuxasnrJ8FcEzLA1IoZuma/8ZBby6sN5cUzrH
         rW+hA3zSAMAqFTLRl5iM7S2RclnU/enZ5czEpeWhRg92rJwMfjClS8PudJeW2+K12UJ7
         f7LTuoYkK2Lpw//9uboZ6qRLdsR43s2CFx/hr2JyUwCOJzPmy2RibXlJcm8u0BmR4UjM
         ivAuscYzNePZ0mEWzvMtcoF+LlT6ADB/E0OieSPjWECtCkpuHqVoxR3PP1dV5uLcHupa
         1Kdw==
X-Forwarded-Encrypted: i=1; AHgh+RqP4j74u1dK4GRRBh54/oq9hhOcIoTTXlefHIHEmkjE9WZJDMPDQO5HKIsfrIHtT2uU8CcdH7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfnY4OHsPwZzwztQ3CmoD2C5frfblgHjiMNj83GZyiKzYZb6RU
	AS7m4Ocu+b2iVntBJiSt86VUQmy9GTCBy7G6ZwfCQpSiIMqsZTZ7W1pefVPIHrA6S6opeqJ6wDu
	9jnG5OrXMpw7F1ul7uvozi1oWHhji+nRQTlYvbcutcg==
X-Gm-Gg: AR+sD12LBb6rsFXR997odn/ikRqEbm0BpGkkFq4q3yTf+EWZTA6/dGy++h2wLB0s4dC
	vOkVUp1969N/NBMANg/s5DzPYaoyjL08Z1R3JzICbQ0rj6HInZM0i5DBJSyXqQYDKHBlkr+itgY
	ANqGz6KNArF5vMAfLOsb5bKu5DTqHU/Jd5fp7y8/DRh/aUIowozqfOFdwdyAIz6bebRwpXS5OlK
	X44+JV/mpICoP5pVa6FhJTyK54LagAqbywMT5xW3zBzme415hoQp5CAOANplP4EZwohC7pzQNU4
	fAHoBiWp1UjyI+bcuQ==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:620a:2590:b0:92b:6805:9191 with SMTP id
 af79cd13be357-93103b0e694mr475503785a.73.1784835862571; Thu, 23 Jul 2026
 12:44:22 -0700 (PDT)
Received: from 960782262270 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 23 Jul 2026 12:44:20 -0700
Received: from 960782262270 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 23 Jul 2026 12:44:20 -0700
In-Reply-To: <87v7a7jeav.ffs@fw13>
References: <CABV8kRwvex1VvQ0eGwUQmJL_vA7AP2h64VpHqtXvfOXMvvJQZA@mail.gmail.com>
    <87bjc0led9.ffs@fw13>    <CABV8kRwDhwa_OoQ9zx4sv3tDATZc0Yy-mYGObRXw59DO0cDfLw@mail.gmail.com>
    <87v7a7jeav.ffs@fw13>
From: Keno Fischer <keno@juliahub.com>
Date: Thu, 23 Jul 2026 12:44:20 -0700
X-Gm-Features: AUfX_mxsP8I2az4lSi31OtYK2DKYHyE5efsIPKg0iLaqBiW_NNViEkar6NeE-k0
Message-ID: <CABV8kRz5c4opGVA3CPdALWxjUH_DkLf_tBLdefajsSevfHFYpQ@mail.gmail.com>
Subject: Re: [PATCH] futex: Prevent robust futex exit race more
To: Thomas Gleixner <tglx@kernel.org>
Cc: Keno Fischer <keno@juliahub.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	Yang Tao <yang.tao172@zte.com.cn>, Yi Wang <wang.yi59@zte.com.cn>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, stable@vger.kernel.org, 
	Florian Weimer <fweimer@redhat.com>, Oleg Nesterov <oleg@redhat.com>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 Jul 2026 16:21:12 +0200, Thomas Gleixner <tglx@kernel.org> wrote:
> We should rather fix that than hacking around it in the exit handling
> code.

Ok, I do think that would be better. If we changed the FUTEX_ROBUST_UNLOCK
semantics to set FUTEX_WAITERS if and only if there are any remaining waiters
(being careful to synchronize this with the addition of new waiters in
FUTEX_WAIT),
then we don't need this code in the exit processing. It is also better because
it avoids the extra wakeup just to re-set FUTEX_WAITERS and it
solves the related (minor) annoyance that userspace currently cannot know
whether there are remaining waiters and has to conservatively go through
the contended unlock path after any wait. I've tried the quick-and-dirty
candidate patch below and it fixes the issue. See if you like that approach
better.

The main downside I think is that this would be a userspace-visible change
to the futex ABI protocol. Of course, it is opt-in using FUTEX_ROBUST_UNLOCK,
so there's no problem from the kernel perspective, but for cross-process mutexes
userspace will have to coordinate to make sure that all processes in question
(including statically linked ones, etc.) upgrade simultaneously.
glibc could potentially use a free kind bit to coordinate and make an
ABI mismatch loud,
but I don't see a good way for musl to do this.
That said, both libcs have made these kinds of breaking ABI changes
before (although
rarely), so perhaps that's not a real concern.

> Unsurprisingly a robust futex depends on unique PIDs, which are not
> obviously not guaranteed accross multiple PID namespaces.

Well, non-PI robust futexes depend on each thread in the synchronization
domain having a unique token for their process lifetimes, but it doesn't
necessarily have to be a PID - anything that can be robustly released
would do (obviously the situation is different for PI futexes since
the kernel needs to be able to find the owner). The proposal here would
be to let userspace decide what that token is (either in the robust list
head or in each entry). Some applications already have suitable tokens
(e.g. LMDB assigns a reader index for each reader, although its protocol
for doing so would need adjustment since it assumes mutexes work), but
there are several options - I don't think the kernel has to care.

-- >8 --
Subject: [PATCH] futex: Retain FUTEX_WAITERS across a contended robust unlock

In the contended unlock path of a futex (using FUTEX_ROBUST_UNLOCK
for the sake of the present discussion - the legacy path has
additional races anyway), the kernel will store 0 to release the
futex word, clean up the robust list pending entry and wake the
appropriate number of waiting tasks (if any).

However, because userspace does not know if there were any remaining
waiters on the futex, this opens up a race: After the futex word
is released, an unrelated thread can perform an uncontended acquire
without setting FUTEX_WAITERS. If the woken-up thread dies before
it has a chance to set FUTEX_WAITERS, there is no indication to
userspace that the next release needs the contended-unlock path and
thus any remaining waiters will never be woken. An example sequence
is the following:

  A owns the futex, B and C sleep in FUTEX_WAIT
                                        uval == A | FUTEX_WAITERS
  A FUTEX_ROBUST_UNLOCK: store 0, wakes B
                                        uval == 0
  D fast path acquire: cmpxchg(0 -> D)
                                        uval == D, no FUTEX_WAITERS
  B killed before acting on the wakeup
  B exit walk, pending op: owner D != B -> no action
  D unlock: no FUTEX_WAITERS -> no wake
                                        C sleeps forever

This closes that race by instead having the kernel retain the
FUTEX_WAITERS bit to indicate whether any waiters remain. Another
thread is only permitted to perform an uncontended lock if there are
no remaining waiters. The release store is performed under the futex
spinlock, and thus synchronizes with the check of the futex word
in FUTEX_WAIT.

This is a change in the futex protocol. 0|FUTEX_WAITERS was previously
not a state that was used in the futex state machine (although
very old glibc versions have a bug that produces it). Userspace
implementations will need to be adapted to handle this state when
switching to FUTEX_ROBUST_UNLOCK.

Fixes: 3ca9595d9fb6 ("futex: Add support for unlocking robust futexes")
Signed-off-by: Keno Fischer <keno@juliahub.com>
Assisted-by: ClaudeCode:claude-fable-5 tla+
---
 Documentation/locking/robust-futex-ABI.rst |  17 ++-
 kernel/futex/futex.h                       |  12 ++
 kernel/futex/waitwake.c                    | 123 ++++++++++++++-------
 3 files changed, 113 insertions(+), 39 deletions(-)

diff --git a/Documentation/locking/robust-futex-ABI.rst
b/Documentation/locking/robust-futex-ABI.rst
index 5e6a0665b8ba..7e83b3d6f4f0 100644
--- a/Documentation/locking/robust-futex-ABI.rst
+++ b/Documentation/locking/robust-futex-ABI.rst
@@ -215,8 +215,21 @@ For the contended unlock case, where other
threads are waiting for the lock
 release, there's the ``FUTEX_ROBUST_UNLOCK`` operation feature flag for the
 ``futex()`` system call, which must be used with one of the following
 operations: ``FUTEX_WAKE``, ``FUTEX_WAKE_BITSET`` or ``FUTEX_UNLOCK_PI``.
-The kernel will release the lock (set the futex word to zero), clean the
-``list_op_pending`` field. Then, it will proceed with the normal wake path.
+The kernel will release the lock, clean the ``list_op_pending`` field and
+wake the requested number of waiters. The value stored into the futex word
+by the release reflects the remaining contention: if waiters remain queued
+in the kernel after the wakeup, the futex word is set to ``FUTEX_WAITERS``,
+otherwise to zero. This keeps subsequent lock acquisitions on the contended
+path so that every unlock wakes the next waiter, even if a woken waiter is
+killed before it can take over the lock in user space (the released,
+ownerless futex word also lets the robust list exit handling of such a
+waiter wake its successor).
+
+Lock implementations using ``FUTEX_ROBUST_UNLOCK`` must therefore treat a
+futex word whose TID portion is zero as free regardless of the
+``FUTEX_WAITERS`` bit: it is acquired with an atomic compare-and-exchange
+which preserves ``FUTEX_WAITERS``, and a thread must never wait on a futex
+word with a zero TID portion.

 For the non-contended path, there's still a race between checking the
futex word
 and clearing the ``list_op_pending`` field. To solve this without the need of a
diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index f00f0863ed44..367a8eaa650d 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -305,6 +305,18 @@ static inline int futex_get_value_locked(u32
*dest, u32 __user *from)
 	return get_user_inline(*dest, from);
 }

+/* Store to user memory with release ordering and pagefaults disabled */
+static inline int futex_put_value_locked(u32 val, u32 __user *to)
+{
+	guard(pagefault)();
+
+	scoped_user_write_access(to, efault)
+		unsafe_atomic_store_release_user(val, to, efault);
+	return 0;
+efault:
+	return -EFAULT;
+}
+
 extern void __futex_unqueue(struct futex_q *q);
 extern void __futex_queue(struct futex_q *q, struct futex_hash_bucket *hb,
 				struct task_struct *task);
diff --git a/kernel/futex/waitwake.c b/kernel/futex/waitwake.c
index d4483d15d30a..2983d6d257b2 100644
--- a/kernel/futex/waitwake.c
+++ b/kernel/futex/waitwake.c
@@ -150,26 +150,69 @@ void futex_wake_mark(struct wake_q_head *wake_q,
struct futex_q *q)
 }

 /*
- * If requested, clear the robust list pending op and unlock the futex
+ * Mark up to @nr_wake waiters for wake up. Must be called with @hb->lock held.
+ * Returns the number of marked waiters (or -EINVAL).
  */
-static bool futex_robust_unlock(u32 __user *uaddr, unsigned int
flags, void __user *pop)
+static int futex_wake_locked(struct futex_hash_bucket *hb, union
futex_key *key,
+			     struct wake_q_head *wake_q, int nr_wake, u32 bitset)
 {
-	if (!(flags & FLAGS_ROBUST_UNLOCK))
-		return true;
+	struct futex_q *this, *next;
+	int ret = 0;

-	/* First unlock the futex, which requires release semantics. */
-	scoped_user_write_access(uaddr, efault)
-		unsafe_atomic_store_release_user(0, uaddr, efault);
+	plist_for_each_entry_safe(this, next, &hb->chain, list) {
+		if (futex_match(&this->key, key)) {
+			if (this->pi_state || this->rt_waiter)
+				return -EINVAL;

-	/*
-	 * Clear the pending list op now. If that fails, then the task is in
-	 * deeper trouble as the robust list head is usually part of the TLS.
-	 * The chance of survival is close to zero.
-	 */
-	return futex_robust_list_clear_pending(pop, flags);
+			/* Check if one of the bits is set in both bitsets */
+			if (!(this->bitset & bitset))
+				continue;
+
+			this->wake(wake_q, this);
+			if (++ret >= nr_wake)
+				break;
+		}
+	}
+	return ret;
+}
+
+/*
+ * Release the futex word of a robust futex (FUTEX_ROBUST_UNLOCK) by storing
+ * either 0 or (0)|FUTEX_WAITERS depending on the presence of
remaining waiters.
+ * Must be called with @hb->lock held. The lock may be dropped and reacquired
+ * to fault in the futex word.
+ */
+static int futex_robust_release(struct futex_hash_bucket *hb, union
futex_key *key,
+				u32 __user *uaddr)
+{
+	struct futex_q *this;
+	int ret;
+
+	for (;;) {
+		u32 mval = 0;
+
+		/*
+		 * Check for remaining waiters on this futex. Error
+		 * conditions from futex_wake_locked() are ignored here to
+		 * ensure that the next wake takes the contended path and
+		 * observes those errors.
+		 */
+		plist_for_each_entry(this, &hb->chain, list) {
+			if (futex_match(&this->key, key)) {
+				mval = FUTEX_WAITERS;
+				break;
+			}
+		}
+
+		if (!futex_put_value_locked(mval, uaddr))
+			return 0;

-efault:
-	return false;
+		spin_unlock(&hb->lock);
+		ret = fault_in_user_writeable(uaddr) ? -EFAULT : 0;
+		spin_lock(&hb->lock);
+		if (ret)
+			return ret;
+	}
 }

 /*
@@ -177,8 +220,9 @@ static bool futex_robust_unlock(u32 __user *uaddr,
unsigned int flags, void __us
  */
 int futex_wake(u32 __user *uaddr, unsigned int flags, void __user
*pop, int nr_wake, u32 bitset)
 {
+	bool robust = flags & FLAGS_ROBUST_UNLOCK;
+	bool wake = !((flags & FLAGS_STRICT) && !nr_wake);
 	union futex_key key = FUTEX_KEY_INIT;
-	struct futex_q *this, *next;
 	DEFINE_WAKE_Q(wake_q);
 	int ret;

@@ -189,39 +233,44 @@ int futex_wake(u32 __user *uaddr, unsigned int
flags, void __user *pop, int nr_w
 	if (unlikely(ret != 0))
 		return ret;

-	if (!futex_robust_unlock(uaddr, flags, pop))
-		return -EFAULT;
-
-	if ((flags & FLAGS_STRICT) && !nr_wake)
+	if (!robust && !wake)
 		return 0;

 	CLASS(hbr, hbr)(&key);
 	auto hb = hbr.hb;

-	/* Make sure we really have tasks to wakeup */
-	if (!futex_hb_waiters_pending(hb))
-		return ret;
+	/*
+	 * Make sure we really have tasks to wakeup. No fast path for @robust,
+	 * the unlock needs to happen regardless.
+	 */
+	if (!robust && !futex_hb_waiters_pending(hb))
+		return 0;

 	spin_lock(&hb->lock);

-	plist_for_each_entry_safe(this, next, &hb->chain, list) {
-		if (futex_match (&this->key, &key)) {
-			if (this->pi_state || this->rt_waiter) {
-				ret = -EINVAL;
-				break;
-			}
+	if (wake)
+		ret = futex_wake_locked(hb, &key, &wake_q, nr_wake, bitset);

-			/* Check if one of the bits is set in both bitsets */
-			if (!(this->bitset & bitset))
-				continue;
-
-			this->wake(&wake_q, this);
-			if (++ret >= nr_wake)
-				break;
-		}
+	if (robust && futex_robust_release(hb, &key, uaddr)) {
+		spin_unlock(&hb->lock);
+		/*
+		 * The futex word could not be released. Keep the pending list armed.
+		 */
+		ret = -EFAULT;
+		goto out;
 	}

 	spin_unlock(&hb->lock);
+
+	/*
+	 * With the futex word released, clear the pending list op now. If
+	 * that fails, then the task is in deeper trouble as the robust list
+	 * head is usually part of the TLS. The chance of survival is close
+	 * to zero.
+	 */
+	if (robust && !futex_robust_list_clear_pending(pop, flags))
+		ret = -EFAULT;
+out:
 	wake_up_q(&wake_q);
 	return ret;
 }
-- 
2.54.0
