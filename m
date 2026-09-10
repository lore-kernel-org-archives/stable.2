Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8900549DBB1
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 14:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789049187; cv=none; b=TkcLmAnBv3QKoSAGwMKEYrvXwTp4F/p55aFRgTQCJcY5kC2hzE7tixPqQ/9PlrwPsQMKq8CklWFR1U6XX2n4UWunFvuAox3Vkf/IJCxc1ibtWddiOrwxsnB2djYrfX/Gx/2Ub+u934aJB0kb/1ybSFJ21SCesivfjJ6dxmDbWno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789049187; c=relaxed/simple;
	bh=KMueSXUcq4clM7ugvgJax1p6eBS0O2Iew49E7VeG66w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Opazjf2M4IwIIcCB/UkSIhzFOyQm8EX7Xz/ZHOI1RfhPGvxInpjYv9s6YzdDRZG2tQwLnT6jhQfFLTgaImvllpOeWVNFgYcH/owElag6lnX+KHTEnG0Jnb8z18hpiHPQ82sBF4IKIdjEsHjtS2XKq+m3NV7fCauxDxPg1r1b7e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQGSnu9n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQGSnu9n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C97A1F00899;
	Thu, 10 Sep 2026 14:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789049182;
	bh=09Bvq5Qr7rMqi55xQGZF53xPyJm5nBf5+4oUCvauUEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nQGSnu9n4A50ms5svPPo6w1yvl14Nxr/OusF7XlBYWrN9zmu9McDA+tV6J2Jyqmxe
	 gDY9QOLdUuME9kQ/uAXxYzl3AVZL63zMWEWMNhoR9kI/bwbfKqXvfoWHwiJ9Pme1Xm
	 A0YmagruuJBtr/6v7/RKQJJ61xqtH4UKuRqAk3LfGfYp/c8xl9F2LPt3OkxLbyX1+g
	 EbodOH/QjUz8LM2gZuRduKbiWBNTbL6Uytys5OYalHP5dOyVIfpxsNc7bQeiCaSGOA
	 XWA3KOwu/K84Ed9mzdJIaJeytlxw56Mk9di+Q0K1Z5CacR4VIM98Mx+RMuIUGnJNs+
	 JDHHzqDjwmMVA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 5/6] futex: Split out requeue
Date: Thu, 10 Sep 2026 10:06:16 -0400
Message-ID: <20260910140617.564852-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910140617.564852-1-sashal@kernel.org>
References: <2026090826-jeep-tassel-64cd@gregkh>
 <20260910140617.564852-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit e5c6828493b5fa6a3c4606b43e80ab6c5ec1111f ]

Move all the requeue bits into their own file.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: André Almeida <andrealmeid@collabora.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: André Almeida <andrealmeid@collabora.com>
Link: https://lore.kernel.org/r/20210923171111.300673-14-andrealmeid@collabora.com

Adapt the split to 5.15, which still keeps the syscall and PI code in
core.c and lacks several of the preceding helper renames. Move this
branch's existing requeue functions, state machine and initializer into
requeue.c. Build only core.o and requeue.o; move the shared types and
inline helpers into futex.h and expose the existing core helpers needed
by requeue.c, retaining their stable names. No new functions are added.

Also carry the task-pointer ordering prerequisite from b549113738e8c
("futex: Prevent use-after-free during requeue-PI"): read q->task with
READ_ONCE before publishing Q_REQUEUE_PI_LOCKED, and use the saved task
for wake_up_state(). Target a3b8d46fe401 explicitly relies on this ordering
when it removes the redundant rcuwait wake. Leave that target's change
to futex_requeue_pi_complete() unapplied so it can be picked cleanly.

Stable-dep-of: a3b8d46fe401 ("futex: Prevent rcuwait use-after-free during requeue PI")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/futex/Makefile  |    2 +-
 kernel/futex/core.c    | 1103 +---------------------------------------
 kernel/futex/futex.h   |  238 +++++++++
 kernel/futex/requeue.c |  906 +++++++++++++++++++++++++++++++++
 4 files changed, 1164 insertions(+), 1085 deletions(-)
 create mode 100644 kernel/futex/futex.h
 create mode 100644 kernel/futex/requeue.c

diff --git a/kernel/futex/Makefile b/kernel/futex/Makefile
index b89ba3fba3437..9b73e3b6068e0 100644
--- a/kernel/futex/Makefile
+++ b/kernel/futex/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-y += core.o
+obj-y += core.o requeue.o
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 40b9c5f6c0d74..e21ab1310ba27 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -42,6 +42,7 @@
 
 #include <asm/futex.h>
 
+#include "futex.h"
 #include "../locking/rtmutex_common.h"
 
 /*
@@ -150,152 +151,6 @@
 static int  __read_mostly futex_cmpxchg_enabled;
 #endif
 
-/*
- * Futex flags used to encode options to functions and preserve them across
- * restarts.
- */
-#ifdef CONFIG_MMU
-# define FLAGS_SHARED		0x01
-#else
-/*
- * NOMMU does not have per process address space. Let the compiler optimize
- * code away.
- */
-# define FLAGS_SHARED		0x00
-#endif
-#define FLAGS_CLOCKRT		0x02
-#define FLAGS_HAS_TIMEOUT	0x04
-
-/*
- * Priority Inheritance state:
- */
-struct futex_pi_state {
-	/*
-	 * list of 'owned' pi_state instances - these have to be
-	 * cleaned up in do_exit() if the task exits prematurely:
-	 */
-	struct list_head list;
-
-	/*
-	 * The PI object:
-	 */
-	struct rt_mutex_base pi_mutex;
-
-	struct task_struct *owner;
-	refcount_t refcount;
-
-	union futex_key key;
-} __randomize_layout;
-
-/**
- * struct futex_q - The hashed futex queue entry, one per waiting task
- * @list:		priority-sorted list of tasks waiting on this futex
- * @task:		the task waiting on the futex
- * @lock_ptr:		the hash bucket lock
- * @key:		the key the futex is hashed on
- * @pi_state:		optional priority inheritance state
- * @rt_waiter:		rt_waiter storage for use with requeue_pi
- * @requeue_pi_key:	the requeue_pi target futex key
- * @bitset:		bitset for the optional bitmasked wakeup
- * @requeue_state:	State field for futex_requeue_pi()
- * @requeue_wait:	RCU wait for futex_requeue_pi() (RT only)
- *
- * We use this hashed waitqueue, instead of a normal wait_queue_entry_t, so
- * we can wake only the relevant ones (hashed queues may be shared).
- *
- * A futex_q has a woken state, just like tasks have TASK_RUNNING.
- * It is considered woken when plist_node_empty(&q->list) || q->lock_ptr == 0.
- * The order of wakeup is always to make the first condition true, then
- * the second.
- *
- * PI futexes are typically woken before they are removed from the hash list via
- * the rt_mutex code. See unqueue_me_pi().
- */
-struct futex_q {
-	struct plist_node list;
-
-	struct task_struct *task;
-	spinlock_t *lock_ptr;
-	union futex_key key;
-	struct futex_pi_state *pi_state;
-	struct rt_mutex_waiter *rt_waiter;
-	union futex_key *requeue_pi_key;
-	u32 bitset;
-	atomic_t requeue_state;
-#ifdef CONFIG_PREEMPT_RT
-	struct rcuwait requeue_wait;
-#endif
-} __randomize_layout;
-
-/*
- * On PREEMPT_RT, the hash bucket lock is a 'sleeping' spinlock with an
- * underlying rtmutex. The task which is about to be requeued could have
- * just woken up (timeout, signal). After the wake up the task has to
- * acquire hash bucket lock, which is held by the requeue code.  As a task
- * can only be blocked on _ONE_ rtmutex at a time, the proxy lock blocking
- * and the hash bucket lock blocking would collide and corrupt state.
- *
- * On !PREEMPT_RT this is not a problem and everything could be serialized
- * on hash bucket lock, but aside of having the benefit of common code,
- * this allows to avoid doing the requeue when the task is already on the
- * way out and taking the hash bucket lock of the original uaddr1 when the
- * requeue has been completed.
- *
- * The following state transitions are valid:
- *
- * On the waiter side:
- *   Q_REQUEUE_PI_NONE		-> Q_REQUEUE_PI_IGNORE
- *   Q_REQUEUE_PI_IN_PROGRESS	-> Q_REQUEUE_PI_WAIT
- *
- * On the requeue side:
- *   Q_REQUEUE_PI_NONE		-> Q_REQUEUE_PI_INPROGRESS
- *   Q_REQUEUE_PI_IN_PROGRESS	-> Q_REQUEUE_PI_DONE/LOCKED
- *   Q_REQUEUE_PI_IN_PROGRESS	-> Q_REQUEUE_PI_NONE (requeue failed)
- *   Q_REQUEUE_PI_WAIT		-> Q_REQUEUE_PI_DONE/LOCKED
- *   Q_REQUEUE_PI_WAIT		-> Q_REQUEUE_PI_IGNORE (requeue failed)
- *
- * The requeue side ignores a waiter with state Q_REQUEUE_PI_IGNORE as this
- * signals that the waiter is already on the way out. It also means that
- * the waiter is still on the 'wait' futex, i.e. uaddr1.
- *
- * The waiter side signals early wakeup to the requeue side either through
- * setting state to Q_REQUEUE_PI_IGNORE or to Q_REQUEUE_PI_WAIT depending
- * on the current state. In case of Q_REQUEUE_PI_IGNORE it can immediately
- * proceed to take the hash bucket lock of uaddr1. If it set state to WAIT,
- * which means the wakeup is interleaving with a requeue in progress it has
- * to wait for the requeue side to change the state. Either to DONE/LOCKED
- * or to IGNORE. DONE/LOCKED means the waiter q is now on the uaddr2 futex
- * and either blocked (DONE) or has acquired it (LOCKED). IGNORE is set by
- * the requeue side when the requeue attempt failed via deadlock detection
- * and therefore the waiter q is still on the uaddr1 futex.
- */
-enum {
-	Q_REQUEUE_PI_NONE		=  0,
-	Q_REQUEUE_PI_IGNORE,
-	Q_REQUEUE_PI_IN_PROGRESS,
-	Q_REQUEUE_PI_WAIT,
-	Q_REQUEUE_PI_DONE,
-	Q_REQUEUE_PI_LOCKED,
-};
-
-static const struct futex_q futex_q_init = {
-	/* list gets initialized in queue_me()*/
-	.key		= FUTEX_KEY_INIT,
-	.bitset		= FUTEX_BITSET_MATCH_ANY,
-	.requeue_state	= ATOMIC_INIT(Q_REQUEUE_PI_NONE),
-};
-
-/*
- * Hash buckets are shared by all the futex_keys that hash to the same
- * location.  Each key may have multiple futex_q structures, one for each task
- * waiting on a futex.
- */
-struct futex_hash_bucket {
-	atomic_t waiters;
-	spinlock_t lock;
-	struct plist_head chain;
-} ____cacheline_aligned_in_smp;
-
 /*
  * The base of the bucket array and its size are always used together
  * (after initialization only in futex_hash()), so ensure that they
@@ -329,7 +184,7 @@ static int __init setup_fail_futex(char *str)
 }
 __setup("fail_futex=", setup_fail_futex);
 
-static bool should_fail_futex(bool fshared)
+bool should_fail_futex(bool fshared)
 {
 	if (fail_futex.ignore_private && !fshared)
 		return false;
@@ -358,42 +213,12 @@ late_initcall(fail_futex_debugfs);
 
 #endif /* CONFIG_FAULT_INJECTION_DEBUG_FS */
 
-#else
-static inline bool should_fail_futex(bool fshared)
-{
-	return false;
-}
 #endif /* CONFIG_FAIL_FUTEX */
 
 #ifdef CONFIG_COMPAT
 static void compat_exit_robust_list(struct task_struct *curr);
 #endif
 
-/*
- * Reflects a new waiter being added to the waitqueue.
- */
-static inline void hb_waiters_inc(struct futex_hash_bucket *hb)
-{
-#ifdef CONFIG_SMP
-	atomic_inc(&hb->waiters);
-	/*
-	 * Full barrier (A), see the ordering comment above.
-	 */
-	smp_mb__after_atomic();
-#endif
-}
-
-/*
- * Reflects a waiter being removed from the waitqueue by wakeup
- * paths.
- */
-static inline void hb_waiters_dec(struct futex_hash_bucket *hb)
-{
-#ifdef CONFIG_SMP
-	atomic_dec(&hb->waiters);
-#endif
-}
-
 static inline int hb_waiters_pending(struct futex_hash_bucket *hb)
 {
 #ifdef CONFIG_SMP
@@ -414,7 +239,7 @@ static inline int hb_waiters_pending(struct futex_hash_bucket *hb)
  * We hash on the keys returned from get_futex_key (see below) and return the
  * corresponding hash bucket in the global hash.
  */
-static struct futex_hash_bucket *futex_hash(union futex_key *key)
+struct futex_hash_bucket *futex_hash(union futex_key *key)
 {
 	u32 hash = jhash2((u32 *)key, offsetof(typeof(*key), both.offset) / 4,
 			  key->both.offset);
@@ -423,26 +248,6 @@ static struct futex_hash_bucket *futex_hash(union futex_key *key)
 }
 
 
-/**
- * match_futex - Check whether two futex keys are equal
- * @key1:	Pointer to key1
- * @key2:	Pointer to key2
- *
- * Return 1 if two futex_keys are equal, 0 otherwise.
- */
-static inline int match_futex(union futex_key *key1, union futex_key *key2)
-{
-	return (key1 && key2
-		&& key1->both.word == key2->both.word
-		&& key1->both.ptr == key2->both.ptr
-		&& key1->both.offset == key2->both.offset);
-}
-
-enum futex_access {
-	FUTEX_READ,
-	FUTEX_WRITE
-};
-
 /**
  * futex_setup_timer - set up the sleeping hrtimer.
  * @time:	ptr to the given timeout value
@@ -453,7 +258,7 @@ enum futex_access {
  * Return: Initialized hrtimer_sleeper structure or NULL if no timeout
  *	   value given
  */
-static inline struct hrtimer_sleeper *
+struct hrtimer_sleeper *
 futex_setup_timer(ktime_t *time, struct hrtimer_sleeper *timeout,
 		  int flags, u64 range_ns)
 {
@@ -539,7 +344,7 @@ static u64 get_inode_sequence_number(struct inode *inode)
  *
  * lock_page() might sleep, the caller should not hold a spinlock.
  */
-static int get_futex_key(u32 __user *uaddr, bool fshared, union futex_key *key,
+int get_futex_key(u32 __user *uaddr, bool fshared, union futex_key *key,
 			 enum futex_access rw)
 {
 	unsigned long address = (unsigned long)uaddr;
@@ -738,7 +543,7 @@ static int get_futex_key(u32 __user *uaddr, bool fshared, union futex_key *key,
  * disabled section so we can as well avoid the #PF overhead by
  * calling get_user_pages() right away.
  */
-static int fault_in_user_writeable(u32 __user *uaddr)
+int fault_in_user_writeable(u32 __user *uaddr)
 {
 	struct mm_struct *mm = current->mm;
 	int ret;
@@ -758,7 +563,7 @@ static int fault_in_user_writeable(u32 __user *uaddr)
  *
  * Must be called with the hb lock held.
  */
-static struct futex_q *futex_top_waiter(struct futex_hash_bucket *hb,
+struct futex_q *futex_top_waiter(struct futex_hash_bucket *hb,
 					union futex_key *key)
 {
 	struct futex_q *this;
@@ -782,7 +587,7 @@ static int futex_cmpxchg_value_locked(u32 *curval, u32 __user *uaddr,
 	return ret;
 }
 
-static int futex_get_value_locked(u32 *dest, u32 __user *from)
+int futex_get_value_locked(u32 *dest, u32 __user *from)
 {
 	int ret;
 
@@ -797,7 +602,7 @@ static int futex_get_value_locked(u32 *dest, u32 __user *from)
 /*
  * PI code:
  */
-static int refill_pi_state_cache(void)
+int refill_pi_state_cache(void)
 {
 	struct futex_pi_state *pi_state;
 
@@ -853,7 +658,7 @@ static void pi_state_update_owner(struct futex_pi_state *pi_state,
 	}
 }
 
-static void get_pi_state(struct futex_pi_state *pi_state)
+void get_pi_state(struct futex_pi_state *pi_state)
 {
 	WARN_ON_ONCE(!refcount_inc_not_zero(&pi_state->refcount));
 }
@@ -862,7 +667,7 @@ static void get_pi_state(struct futex_pi_state *pi_state)
  * Drops a reference to the pi_state object and frees or caches it
  * when the last reference is gone.
  */
-static void put_pi_state(struct futex_pi_state *pi_state)
+void put_pi_state(struct futex_pi_state *pi_state)
 {
 	if (!pi_state)
 		return;
@@ -1193,7 +998,7 @@ static int attach_to_pi_state(u32 __user *uaddr, u32 uval,
  *
  * Caller must hold a refcount on @exiting.
  */
-static void wait_for_owner_exiting(int ret, struct task_struct *exiting)
+void wait_for_owner_exiting(int ret, struct task_struct *exiting)
 {
 	if (ret != -EBUSY) {
 		WARN_ON_ONCE(exiting);
@@ -1411,7 +1216,7 @@ static int lock_pi_update_atomic(u32 __user *uaddr, u32 uval, u32 newval)
  * a refcount on the exiting task on return and the caller needs to drop it
  * after waiting for the exit to complete.
  */
-static int futex_lock_pi_atomic(u32 __user *uaddr, struct futex_hash_bucket *hb,
+int futex_lock_pi_atomic(u32 __user *uaddr, struct futex_hash_bucket *hb,
 				union futex_key *key,
 				struct futex_pi_state **ps,
 				struct task_struct *task,
@@ -1513,7 +1318,7 @@ static int futex_lock_pi_atomic(u32 __user *uaddr, struct futex_hash_bucket *hb,
  *
  * The q->lock_ptr must not be NULL and must be held by the caller.
  */
-static void __futex_unqueue(struct futex_q *q)
+void __futex_unqueue(struct futex_q *q)
 {
 	struct futex_hash_bucket *hb;
 
@@ -1532,7 +1337,7 @@ static void __futex_unqueue(struct futex_q *q)
  * must ensure to later call wake_up_q() for the actual
  * wakeups to occur.
  */
-static void futex_wake_mark(struct wake_q_head *wake_q, struct futex_q *q)
+void futex_wake_mark(struct wake_q_head *wake_q, struct futex_q *q)
 {
 	struct task_struct *p = q->task;
 
@@ -1630,30 +1435,6 @@ static int wake_futex_pi(u32 __user *uaddr, u32 uval, struct futex_pi_state *pi_
 	return ret;
 }
 
-/*
- * Express the locking dependencies for lockdep:
- */
-static inline void
-double_lock_hb(struct futex_hash_bucket *hb1, struct futex_hash_bucket *hb2)
-{
-	if (hb1 <= hb2) {
-		spin_lock(&hb1->lock);
-		if (hb1 < hb2)
-			spin_lock_nested(&hb2->lock, SINGLE_DEPTH_NESTING);
-	} else { /* hb1 > hb2 */
-		spin_lock(&hb2->lock);
-		spin_lock_nested(&hb1->lock, SINGLE_DEPTH_NESTING);
-	}
-}
-
-static inline void
-double_unlock_hb(struct futex_hash_bucket *hb1, struct futex_hash_bucket *hb2)
-{
-	spin_unlock(&hb1->lock);
-	if (hb1 != hb2)
-		spin_unlock(&hb2->lock);
-}
-
 /*
  * Wake up waiters matching bitset queued on this futex (uaddr).
  */
@@ -1836,623 +1617,6 @@ futex_wake_op(u32 __user *uaddr1, unsigned int flags, u32 __user *uaddr2,
 	return ret;
 }
 
-/**
- * requeue_futex() - Requeue a futex_q from one hb to another
- * @q:		the futex_q to requeue
- * @hb1:	the source hash_bucket
- * @hb2:	the target hash_bucket
- * @key2:	the new key for the requeued futex_q
- */
-static inline
-void requeue_futex(struct futex_q *q, struct futex_hash_bucket *hb1,
-		   struct futex_hash_bucket *hb2, union futex_key *key2)
-{
-
-	/*
-	 * If key1 and key2 hash to the same bucket, no need to
-	 * requeue.
-	 */
-	if (likely(&hb1->chain != &hb2->chain)) {
-		plist_del(&q->list, &hb1->chain);
-		hb_waiters_dec(hb1);
-		hb_waiters_inc(hb2);
-		plist_add(&q->list, &hb2->chain);
-		q->lock_ptr = &hb2->lock;
-	}
-	q->key = *key2;
-}
-
-static inline bool futex_requeue_pi_prepare(struct futex_q *q,
-					    struct futex_pi_state *pi_state)
-{
-	int old, new;
-
-	/*
-	 * Set state to Q_REQUEUE_PI_IN_PROGRESS unless an early wakeup has
-	 * already set Q_REQUEUE_PI_IGNORE to signal that requeue should
-	 * ignore the waiter.
-	 */
-	old = atomic_read_acquire(&q->requeue_state);
-	do {
-		if (old == Q_REQUEUE_PI_IGNORE)
-			return false;
-
-		/*
-		 * futex_proxy_trylock_atomic() might have set it to
-		 * IN_PROGRESS and a interleaved early wake to WAIT.
-		 *
-		 * It was considered to have an extra state for that
-		 * trylock, but that would just add more conditionals
-		 * all over the place for a dubious value.
-		 */
-		if (old != Q_REQUEUE_PI_NONE)
-			break;
-
-		new = Q_REQUEUE_PI_IN_PROGRESS;
-	} while (!atomic_try_cmpxchg(&q->requeue_state, &old, new));
-
-	q->pi_state = pi_state;
-	return true;
-}
-
-static inline void futex_requeue_pi_complete(struct futex_q *q, int locked)
-{
-	int old, new;
-
-	old = atomic_read_acquire(&q->requeue_state);
-	do {
-		if (old == Q_REQUEUE_PI_IGNORE)
-			return;
-
-		if (locked >= 0) {
-			/* Requeue succeeded. Set DONE or LOCKED */
-			WARN_ON_ONCE(old != Q_REQUEUE_PI_IN_PROGRESS &&
-				     old != Q_REQUEUE_PI_WAIT);
-			new = Q_REQUEUE_PI_DONE + locked;
-		} else if (old == Q_REQUEUE_PI_IN_PROGRESS) {
-			/* Deadlock, no early wakeup interleave */
-			new = Q_REQUEUE_PI_NONE;
-		} else {
-			/* Deadlock, early wakeup interleave. */
-			WARN_ON_ONCE(old != Q_REQUEUE_PI_WAIT);
-			new = Q_REQUEUE_PI_IGNORE;
-		}
-	} while (!atomic_try_cmpxchg(&q->requeue_state, &old, new));
-
-#ifdef CONFIG_PREEMPT_RT
-	/* If the waiter interleaved with the requeue let it know */
-	if (unlikely(old == Q_REQUEUE_PI_WAIT))
-		rcuwait_wake_up(&q->requeue_wait);
-#endif
-}
-
-static inline int futex_requeue_pi_wakeup_sync(struct futex_q *q)
-{
-	int old, new;
-
-	old = atomic_read_acquire(&q->requeue_state);
-	do {
-		/* Is requeue done already? */
-		if (old >= Q_REQUEUE_PI_DONE)
-			return old;
-
-		/*
-		 * If not done, then tell the requeue code to either ignore
-		 * the waiter or to wake it up once the requeue is done.
-		 */
-		new = Q_REQUEUE_PI_WAIT;
-		if (old == Q_REQUEUE_PI_NONE)
-			new = Q_REQUEUE_PI_IGNORE;
-	} while (!atomic_try_cmpxchg(&q->requeue_state, &old, new));
-
-	/* If the requeue was in progress, wait for it to complete */
-	if (old == Q_REQUEUE_PI_IN_PROGRESS) {
-#ifdef CONFIG_PREEMPT_RT
-		rcuwait_wait_event(&q->requeue_wait,
-				   atomic_read(&q->requeue_state) != Q_REQUEUE_PI_WAIT,
-				   TASK_UNINTERRUPTIBLE);
-#else
-		(void)atomic_cond_read_relaxed(&q->requeue_state, VAL != Q_REQUEUE_PI_WAIT);
-#endif
-	}
-
-	/*
-	 * Requeue is now either prohibited or complete. Reread state
-	 * because during the wait above it might have changed. Nothing
-	 * will modify q->requeue_state after this point.
-	 */
-	return atomic_read(&q->requeue_state);
-}
-
-/**
- * requeue_pi_wake_futex() - Wake a task that acquired the lock during requeue
- * @q:		the futex_q
- * @key:	the key of the requeue target futex
- * @hb:		the hash_bucket of the requeue target futex
- *
- * During futex_requeue, with requeue_pi=1, it is possible to acquire the
- * target futex if it is uncontended or via a lock steal.
- *
- * 1) Set @q::key to the requeue target futex key so the waiter can detect
- *    the wakeup on the right futex.
- *
- * 2) Dequeue @q from the hash bucket.
- *
- * 3) Set @q::rt_waiter to NULL so the woken up task can detect atomic lock
- *    acquisition.
- *
- * 4) Set the q->lock_ptr to the requeue target hb->lock for the case that
- *    the waiter has to fixup the pi state.
- *
- * 5) Complete the requeue state so the waiter can make progress. After
- *    this point the waiter task can return from the syscall immediately in
- *    case that the pi state does not have to be fixed up.
- *
- * 6) Wake the waiter task.
- *
- * Must be called with both q->lock_ptr and hb->lock held.
- */
-static inline
-void requeue_pi_wake_futex(struct futex_q *q, union futex_key *key,
-			   struct futex_hash_bucket *hb)
-{
-	q->key = *key;
-
-	__futex_unqueue(q);
-
-	WARN_ON(!q->rt_waiter);
-	q->rt_waiter = NULL;
-
-	q->lock_ptr = &hb->lock;
-
-	/* Signal locked state to the waiter */
-	futex_requeue_pi_complete(q, 1);
-	wake_up_state(q->task, TASK_NORMAL);
-}
-
-/**
- * futex_proxy_trylock_atomic() - Attempt an atomic lock for the top waiter
- * @pifutex:		the user address of the to futex
- * @hb1:		the from futex hash bucket, must be locked by the caller
- * @hb2:		the to futex hash bucket, must be locked by the caller
- * @key1:		the from futex key
- * @key2:		the to futex key
- * @ps:			address to store the pi_state pointer
- * @exiting:		Pointer to store the task pointer of the owner task
- *			which is in the middle of exiting
- * @set_waiters:	force setting the FUTEX_WAITERS bit (1) or not (0)
- *
- * Try and get the lock on behalf of the top waiter if we can do it atomically.
- * Wake the top waiter if we succeed.  If the caller specified set_waiters,
- * then direct futex_lock_pi_atomic() to force setting the FUTEX_WAITERS bit.
- * hb1 and hb2 must be held by the caller.
- *
- * @exiting is only set when the return value is -EBUSY. If so, this holds
- * a refcount on the exiting task on return and the caller needs to drop it
- * after waiting for the exit to complete.
- *
- * Return:
- *  -  0 - failed to acquire the lock atomically;
- *  - >0 - acquired the lock, return value is vpid of the top_waiter
- *  - <0 - error
- */
-static int
-futex_proxy_trylock_atomic(u32 __user *pifutex, struct futex_hash_bucket *hb1,
-			   struct futex_hash_bucket *hb2, union futex_key *key1,
-			   union futex_key *key2, struct futex_pi_state **ps,
-			   struct task_struct **exiting, int set_waiters)
-{
-	struct futex_q *top_waiter = NULL;
-	u32 curval;
-	int ret;
-
-	if (futex_get_value_locked(&curval, pifutex))
-		return -EFAULT;
-
-	if (unlikely(should_fail_futex(true)))
-		return -EFAULT;
-
-	/*
-	 * Find the top_waiter and determine if there are additional waiters.
-	 * If the caller intends to requeue more than 1 waiter to pifutex,
-	 * force futex_lock_pi_atomic() to set the FUTEX_WAITERS bit now,
-	 * as we have means to handle the possible fault.  If not, don't set
-	 * the bit unnecessarily as it will force the subsequent unlock to enter
-	 * the kernel.
-	 */
-	top_waiter = futex_top_waiter(hb1, key1);
-
-	/* There are no waiters, nothing for us to do. */
-	if (!top_waiter)
-		return 0;
-
-	/*
-	 * Ensure that this is a waiter sitting in futex_wait_requeue_pi()
-	 * and waiting on the 'waitqueue' futex which is always !PI.
-	 */
-	if (!top_waiter->rt_waiter || top_waiter->pi_state)
-		return -EINVAL;
-
-	/* Ensure we requeue to the expected futex. */
-	if (!match_futex(top_waiter->requeue_pi_key, key2))
-		return -EINVAL;
-
-	/* Ensure that this does not race against an early wakeup */
-	if (!futex_requeue_pi_prepare(top_waiter, NULL)) {
-		plist_del(&top_waiter->list, &hb1->chain);
-		hb_waiters_dec(hb1);
-		return -EAGAIN;
-	}
-
-	/*
-	 * Try to take the lock for top_waiter and set the FUTEX_WAITERS bit
-	 * in the contended case or if @set_waiters is true.
-	 *
-	 * In the contended case PI state is attached to the lock owner. If
-	 * the user space lock can be acquired then PI state is attached to
-	 * the new owner (@top_waiter->task) when @set_waiters is true.
-	 */
-	ret = futex_lock_pi_atomic(pifutex, hb2, key2, ps, top_waiter->task,
-				   exiting, set_waiters);
-	if (ret == 1) {
-		/*
-		 * Lock was acquired in user space and PI state was
-		 * attached to @top_waiter->task. That means state is fully
-		 * consistent and the waiter can return to user space
-		 * immediately after the wakeup.
-		 */
-		requeue_pi_wake_futex(top_waiter, key2, hb2);
-	} else if (ret < 0) {
-		/* Rewind top_waiter::requeue_state */
-		futex_requeue_pi_complete(top_waiter, ret);
-	} else {
-		/*
-		 * futex_lock_pi_atomic() did not acquire the user space
-		 * futex, but managed to establish the proxy lock and pi
-		 * state. top_waiter::requeue_state cannot be fixed up here
-		 * because the waiter is not enqueued on the rtmutex
-		 * yet. This is handled at the callsite depending on the
-		 * result of rt_mutex_start_proxy_lock() which is
-		 * guaranteed to be reached with this function returning 0.
-		 */
-	}
-	return ret;
-}
-
-/**
- * futex_requeue() - Requeue waiters from uaddr1 to uaddr2
- * @uaddr1:	source futex user address
- * @flags:	futex flags (FLAGS_SHARED, etc.)
- * @uaddr2:	target futex user address
- * @nr_wake:	number of waiters to wake (must be 1 for requeue_pi)
- * @nr_requeue:	number of waiters to requeue (0-INT_MAX)
- * @cmpval:	@uaddr1 expected value (or %NULL)
- * @requeue_pi:	if we are attempting to requeue from a non-pi futex to a
- *		pi futex (pi to pi requeue is not supported)
- *
- * Requeue waiters on uaddr1 to uaddr2. In the requeue_pi case, try to acquire
- * uaddr2 atomically on behalf of the top waiter.
- *
- * Return:
- *  - >=0 - on success, the number of tasks requeued or woken;
- *  -  <0 - on error
- */
-static int futex_requeue(u32 __user *uaddr1, unsigned int flags,
-			 u32 __user *uaddr2, int nr_wake, int nr_requeue,
-			 u32 *cmpval, int requeue_pi)
-{
-	union futex_key key1 = FUTEX_KEY_INIT, key2 = FUTEX_KEY_INIT;
-	int task_count = 0, ret;
-	struct futex_pi_state *pi_state = NULL;
-	struct futex_hash_bucket *hb1, *hb2;
-	struct futex_q *this, *next;
-	DEFINE_WAKE_Q(wake_q);
-
-	if (nr_wake < 0 || nr_requeue < 0)
-		return -EINVAL;
-
-	/*
-	 * When PI not supported: return -ENOSYS if requeue_pi is true,
-	 * consequently the compiler knows requeue_pi is always false past
-	 * this point which will optimize away all the conditional code
-	 * further down.
-	 */
-	if (!IS_ENABLED(CONFIG_FUTEX_PI) && requeue_pi)
-		return -ENOSYS;
-
-	if (requeue_pi) {
-		/*
-		 * Requeue PI only works on two distinct uaddrs. This
-		 * check is only valid for private futexes. See below.
-		 */
-		if (uaddr1 == uaddr2)
-			return -EINVAL;
-
-		/*
-		 * futex_requeue() allows the caller to define the number
-		 * of waiters to wake up via the @nr_wake argument. With
-		 * REQUEUE_PI, waking up more than one waiter is creating
-		 * more problems than it solves. Waking up a waiter makes
-		 * only sense if the PI futex @uaddr2 is uncontended as
-		 * this allows the requeue code to acquire the futex
-		 * @uaddr2 before waking the waiter. The waiter can then
-		 * return to user space without further action. A secondary
-		 * wakeup would just make the futex_wait_requeue_pi()
-		 * handling more complex, because that code would have to
-		 * look up pi_state and do more or less all the handling
-		 * which the requeue code has to do for the to be requeued
-		 * waiters. So restrict the number of waiters to wake to
-		 * one, and only wake it up when the PI futex is
-		 * uncontended. Otherwise requeue it and let the unlock of
-		 * the PI futex handle the wakeup.
-		 *
-		 * All REQUEUE_PI users, e.g. pthread_cond_signal() and
-		 * pthread_cond_broadcast() must use nr_wake=1.
-		 */
-		if (nr_wake != 1)
-			return -EINVAL;
-
-		/*
-		 * requeue_pi requires a pi_state, try to allocate it now
-		 * without any locks in case it fails.
-		 */
-		if (refill_pi_state_cache())
-			return -ENOMEM;
-	}
-
-retry:
-	ret = get_futex_key(uaddr1, flags & FLAGS_SHARED, &key1, FUTEX_READ);
-	if (unlikely(ret != 0))
-		return ret;
-	ret = get_futex_key(uaddr2, flags & FLAGS_SHARED, &key2,
-			    requeue_pi ? FUTEX_WRITE : FUTEX_READ);
-	if (unlikely(ret != 0))
-		return ret;
-
-	/*
-	 * The check above which compares uaddrs is not sufficient for
-	 * shared futexes. We need to compare the keys:
-	 */
-	if (requeue_pi && match_futex(&key1, &key2))
-		return -EINVAL;
-
-	hb1 = futex_hash(&key1);
-	hb2 = futex_hash(&key2);
-
-retry_private:
-	hb_waiters_inc(hb2);
-	double_lock_hb(hb1, hb2);
-
-	if (likely(cmpval != NULL)) {
-		u32 curval;
-
-		ret = futex_get_value_locked(&curval, uaddr1);
-
-		if (unlikely(ret)) {
-			double_unlock_hb(hb1, hb2);
-			hb_waiters_dec(hb2);
-
-			ret = get_user(curval, uaddr1);
-			if (ret)
-				return ret;
-
-			if (!(flags & FLAGS_SHARED))
-				goto retry_private;
-
-			goto retry;
-		}
-		if (curval != *cmpval) {
-			ret = -EAGAIN;
-			goto out_unlock;
-		}
-	}
-
-	if (requeue_pi) {
-		struct task_struct *exiting = NULL;
-
-		/*
-		 * Attempt to acquire uaddr2 and wake the top waiter. If we
-		 * intend to requeue waiters, force setting the FUTEX_WAITERS
-		 * bit.  We force this here where we are able to easily handle
-		 * faults rather in the requeue loop below.
-		 *
-		 * Updates topwaiter::requeue_state if a top waiter exists.
-		 */
-		ret = futex_proxy_trylock_atomic(uaddr2, hb1, hb2, &key1,
-						 &key2, &pi_state,
-						 &exiting, nr_requeue);
-
-		/*
-		 * At this point the top_waiter has either taken uaddr2 or
-		 * is waiting on it. In both cases pi_state has been
-		 * established and an initial refcount on it. In case of an
-		 * error there's nothing.
-		 *
-		 * The top waiter's requeue_state is up to date:
-		 *
-		 *  - If the lock was acquired atomically (ret == 1), then
-		 *    the state is Q_REQUEUE_PI_LOCKED.
-		 *
-		 *    The top waiter has been dequeued and woken up and can
-		 *    return to user space immediately. The kernel/user
-		 *    space state is consistent. In case that there must be
-		 *    more waiters requeued the WAITERS bit in the user
-		 *    space futex is set so the top waiter task has to go
-		 *    into the syscall slowpath to unlock the futex. This
-		 *    will block until this requeue operation has been
-		 *    completed and the hash bucket locks have been
-		 *    dropped.
-		 *
-		 *  - If the trylock failed with an error (ret < 0) then
-		 *    the state is either Q_REQUEUE_PI_NONE, i.e. "nothing
-		 *    happened", or Q_REQUEUE_PI_IGNORE when there was an
-		 *    interleaved early wakeup.
-		 *
-		 *  - If the trylock did not succeed (ret == 0) then the
-		 *    state is either Q_REQUEUE_PI_IN_PROGRESS or
-		 *    Q_REQUEUE_PI_WAIT if an early wakeup interleaved.
-		 *    This will be cleaned up in the loop below, which
-		 *    cannot fail because futex_proxy_trylock_atomic() did
-		 *    the same sanity checks for requeue_pi as the loop
-		 *    below does.
-		 */
-		switch (ret) {
-		case 0:
-			/* We hold a reference on the pi state. */
-			break;
-
-		case 1:
-			/*
-			 * futex_proxy_trylock_atomic() acquired the user space
-			 * futex. Adjust task_count.
-			 */
-			task_count++;
-			ret = 0;
-			break;
-
-		/*
-		 * If the above failed, then pi_state is NULL and
-		 * waiter::requeue_state is correct.
-		 */
-		case -EFAULT:
-			double_unlock_hb(hb1, hb2);
-			hb_waiters_dec(hb2);
-			ret = fault_in_user_writeable(uaddr2);
-			if (!ret)
-				goto retry;
-			return ret;
-		case -EBUSY:
-		case -EAGAIN:
-			/*
-			 * Two reasons for this:
-			 * - EBUSY: Owner is exiting and we just wait for the
-			 *   exit to complete.
-			 * - EAGAIN: The user space value changed.
-			 */
-			double_unlock_hb(hb1, hb2);
-			hb_waiters_dec(hb2);
-			/*
-			 * Handle the case where the owner is in the middle of
-			 * exiting. Wait for the exit to complete otherwise
-			 * this task might loop forever, aka. live lock.
-			 */
-			wait_for_owner_exiting(ret, exiting);
-			cond_resched();
-			goto retry;
-		default:
-			goto out_unlock;
-		}
-	}
-
-	plist_for_each_entry_safe(this, next, &hb1->chain, list) {
-		if (task_count - nr_wake >= nr_requeue)
-			break;
-
-		if (!match_futex(&this->key, &key1))
-			continue;
-
-		/*
-		 * FUTEX_WAIT_REQUEUE_PI and FUTEX_CMP_REQUEUE_PI should always
-		 * be paired with each other and no other futex ops.
-		 *
-		 * We should never be requeueing a futex_q with a pi_state,
-		 * which is awaiting a futex_unlock_pi().
-		 */
-		if ((requeue_pi && !this->rt_waiter) ||
-		    (!requeue_pi && this->rt_waiter) ||
-		    this->pi_state) {
-			ret = -EINVAL;
-			break;
-		}
-
-		/* Plain futexes just wake or requeue and are done */
-		if (!requeue_pi) {
-			if (++task_count <= nr_wake)
-				futex_wake_mark(&wake_q, this);
-			else
-				requeue_futex(this, hb1, hb2, &key2);
-			continue;
-		}
-
-		/* Ensure we requeue to the expected futex for requeue_pi. */
-		if (!match_futex(this->requeue_pi_key, &key2)) {
-			ret = -EINVAL;
-			break;
-		}
-
-		/*
-		 * Requeue nr_requeue waiters and possibly one more in the case
-		 * of requeue_pi if we couldn't acquire the lock atomically.
-		 *
-		 * Prepare the waiter to take the rt_mutex. Take a refcount
-		 * on the pi_state and store the pointer in the futex_q
-		 * object of the waiter.
-		 */
-		get_pi_state(pi_state);
-
-		/* Don't requeue when the waiter is already on the way out. */
-		if (!futex_requeue_pi_prepare(this, pi_state)) {
-			/*
-			 * Early woken waiter signaled that it is on the
-			 * way out. Drop the pi_state reference and try the
-			 * next waiter. @this->pi_state is still NULL.
-			 */
-			put_pi_state(pi_state);
-			continue;
-		}
-
-		ret = rt_mutex_start_proxy_lock(&pi_state->pi_mutex,
-						this->rt_waiter,
-						this->task);
-
-		if (ret == 1) {
-			/*
-			 * We got the lock. We do neither drop the refcount
-			 * on pi_state nor clear this->pi_state because the
-			 * waiter needs the pi_state for cleaning up the
-			 * user space value. It will drop the refcount
-			 * after doing so. this::requeue_state is updated
-			 * in the wakeup as well.
-			 */
-			requeue_pi_wake_futex(this, &key2, hb2);
-			task_count++;
-		} else if (!ret) {
-			/* Waiter is queued, move it to hb2 */
-			requeue_futex(this, hb1, hb2, &key2);
-			futex_requeue_pi_complete(this, 0);
-			task_count++;
-		} else {
-			/*
-			 * rt_mutex_start_proxy_lock() detected a potential
-			 * deadlock when we tried to queue that waiter.
-			 * Drop the pi_state reference which we took above
-			 * and remove the pointer to the state from the
-			 * waiters futex_q object.
-			 */
-			this->pi_state = NULL;
-			put_pi_state(pi_state);
-			futex_requeue_pi_complete(this, ret);
-			/*
-			 * We stop queueing more waiters and let user space
-			 * deal with the mess.
-			 */
-			break;
-		}
-	}
-
-	/*
-	 * We took an extra initial reference to the pi_state in
-	 * futex_proxy_trylock_atomic(). We need to drop it here again.
-	 */
-	put_pi_state(pi_state);
-
-out_unlock:
-	double_unlock_hb(hb1, hb2);
-	wake_up_q(&wake_q);
-	hb_waiters_dec(hb2);
-	return ret ? ret : task_count;
-}
-
 /* The key must be already stored in q->key. */
 static inline struct futex_hash_bucket *queue_lock(struct futex_q *q)
 	__acquires(&hb->lock)
@@ -2477,14 +1641,6 @@ static inline struct futex_hash_bucket *queue_lock(struct futex_q *q)
 	return hb;
 }
 
-static inline void
-queue_unlock(struct futex_hash_bucket *hb)
-	__releases(&hb->lock)
-{
-	spin_unlock(&hb->lock);
-	hb_waiters_dec(hb);
-}
-
 static inline void __queue_me(struct futex_q *q, struct futex_hash_bucket *hb)
 {
 	int prio;
@@ -2581,7 +1737,7 @@ static int unqueue_me(struct futex_q *q)
  * PI futexes can not be requeued and must remove themselves from the
  * hash bucket. The hash bucket lock (i.e. lock_ptr) is held.
  */
-static void unqueue_me_pi(struct futex_q *q)
+void unqueue_me_pi(struct futex_q *q)
 {
 	__futex_unqueue(q);
 
@@ -2793,7 +1949,7 @@ static long futex_wait_restart(struct restart_block *restart);
  *  -  0 - success, lock not taken;
  *  - <0 - on error (-EFAULT)
  */
-static int fixup_owner(u32 __user *uaddr, struct futex_q *q, int locked)
+int fixup_owner(u32 __user *uaddr, struct futex_q *q, int locked)
 {
 	if (locked) {
 		/*
@@ -2836,7 +1992,7 @@ static int fixup_owner(u32 __user *uaddr, struct futex_q *q, int locked)
  * @q:		the futex_q to queue up on
  * @timeout:	the prepared hrtimer_sleeper, or null for no timeout
  */
-static void futex_wait_queue_me(struct futex_hash_bucket *hb, struct futex_q *q,
+void futex_wait_queue_me(struct futex_hash_bucket *hb, struct futex_q *q,
 				struct hrtimer_sleeper *timeout)
 {
 	/*
@@ -2884,7 +2040,7 @@ static void futex_wait_queue_me(struct futex_hash_bucket *hb, struct futex_q *q,
  *  -  0 - uaddr contains val and hb has been locked;
  *  - <1 - -EFAULT or -EWOULDBLOCK (uaddr does not contain val) and hb is unlocked
  */
-static int futex_wait_setup(u32 __user *uaddr, u32 val, unsigned int flags,
+int futex_wait_setup(u32 __user *uaddr, u32 val, unsigned int flags,
 			   struct futex_q *q, struct futex_hash_bucket **hb)
 {
 	u32 uval;
@@ -3334,227 +2490,6 @@ static int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
 	return ret;
 }
 
-/**
- * handle_early_requeue_pi_wakeup() - Handle early wakeup on the initial futex
- * @hb:		the hash_bucket futex_q was original enqueued on
- * @q:		the futex_q woken while waiting to be requeued
- * @timeout:	the timeout associated with the wait (NULL if none)
- *
- * Determine the cause for the early wakeup.
- *
- * Return:
- *  -EWOULDBLOCK or -ETIMEDOUT or -ERESTARTNOINTR
- */
-static inline
-int handle_early_requeue_pi_wakeup(struct futex_hash_bucket *hb,
-				   struct futex_q *q,
-				   struct hrtimer_sleeper *timeout)
-{
-	int ret;
-
-	/*
-	 * With the hb lock held, we avoid races while we process the wakeup.
-	 * We only need to hold hb (and not hb2) to ensure atomicity as the
-	 * wakeup code can't change q.key from uaddr to uaddr2 if we hold hb.
-	 * It can't be requeued from uaddr2 to something else since we don't
-	 * support a PI aware source futex for requeue.
-	 */
-	WARN_ON_ONCE(&hb->lock != q->lock_ptr);
-
-	/*
-	 * We were woken prior to requeue by a timeout or a signal.
-	 * Conditionally unqueue the futex_q and determine which it was.
-	 */
-	if (!plist_node_empty(&q->list)) {
-		plist_del(&q->list, &hb->chain);
-		hb_waiters_dec(hb);
-	}
-
-	/* Handle spurious wakeups gracefully */
-	ret = -EWOULDBLOCK;
-	if (timeout && !timeout->task)
-		ret = -ETIMEDOUT;
-	else if (signal_pending(current))
-		ret = -ERESTARTNOINTR;
-	return ret;
-}
-
-/**
- * futex_wait_requeue_pi() - Wait on uaddr and take uaddr2
- * @uaddr:	the futex we initially wait on (non-pi)
- * @flags:	futex flags (FLAGS_SHARED, FLAGS_CLOCKRT, etc.), they must be
- *		the same type, no requeueing from private to shared, etc.
- * @val:	the expected value of uaddr
- * @abs_time:	absolute timeout
- * @bitset:	32 bit wakeup bitset set by userspace, defaults to all
- * @uaddr2:	the pi futex we will take prior to returning to user-space
- *
- * The caller will wait on uaddr and will be requeued by futex_requeue() to
- * uaddr2 which must be PI aware and unique from uaddr.  Normal wakeup will wake
- * on uaddr2 and complete the acquisition of the rt_mutex prior to returning to
- * userspace.  This ensures the rt_mutex maintains an owner when it has waiters;
- * without one, the pi logic would not know which task to boost/deboost, if
- * there was a need to.
- *
- * We call schedule in futex_wait_queue_me() when we enqueue and return there
- * via the following--
- * 1) wakeup on uaddr2 after an atomic lock acquisition by futex_requeue()
- * 2) wakeup on uaddr2 after a requeue
- * 3) signal
- * 4) timeout
- *
- * If 3, cleanup and return -ERESTARTNOINTR.
- *
- * If 2, we may then block on trying to take the rt_mutex and return via:
- * 5) successful lock
- * 6) signal
- * 7) timeout
- * 8) other lock acquisition failure
- *
- * If 6, return -EWOULDBLOCK (restarting the syscall would do the same).
- *
- * If 4 or 7, we cleanup and return with -ETIMEDOUT.
- *
- * Return:
- *  -  0 - On success;
- *  - <0 - On error
- */
-static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
-				 u32 val, ktime_t *abs_time, u32 bitset,
-				 u32 __user *uaddr2)
-{
-	struct hrtimer_sleeper timeout, *to;
-	struct rt_mutex_waiter rt_waiter;
-	struct futex_hash_bucket *hb;
-	union futex_key key2 = FUTEX_KEY_INIT;
-	struct futex_q q = futex_q_init;
-	struct rt_mutex_base *pi_mutex;
-	int res, ret;
-
-	if (!IS_ENABLED(CONFIG_FUTEX_PI))
-		return -ENOSYS;
-
-	if (uaddr == uaddr2)
-		return -EINVAL;
-
-	if (!bitset)
-		return -EINVAL;
-
-	to = futex_setup_timer(abs_time, &timeout, flags,
-			       current->timer_slack_ns);
-
-	/*
-	 * The waiter is allocated on our stack, manipulated by the requeue
-	 * code while we sleep on uaddr.
-	 */
-	rt_mutex_init_waiter(&rt_waiter);
-
-	ret = get_futex_key(uaddr2, flags & FLAGS_SHARED, &key2, FUTEX_WRITE);
-	if (unlikely(ret != 0))
-		goto out;
-
-	q.bitset = bitset;
-	q.rt_waiter = &rt_waiter;
-	q.requeue_pi_key = &key2;
-
-	/*
-	 * Prepare to wait on uaddr. On success, it holds hb->lock and q
-	 * is initialized.
-	 */
-	ret = futex_wait_setup(uaddr, val, flags, &q, &hb);
-	if (ret)
-		goto out;
-
-	/*
-	 * The check above which compares uaddrs is not sufficient for
-	 * shared futexes. We need to compare the keys:
-	 */
-	if (match_futex(&q.key, &key2)) {
-		queue_unlock(hb);
-		ret = -EINVAL;
-		goto out;
-	}
-
-	/* Queue the futex_q, drop the hb lock, wait for wakeup. */
-	futex_wait_queue_me(hb, &q, to);
-
-	switch (futex_requeue_pi_wakeup_sync(&q)) {
-	case Q_REQUEUE_PI_IGNORE:
-		/* The waiter is still on uaddr1 */
-		spin_lock(&hb->lock);
-		ret = handle_early_requeue_pi_wakeup(hb, &q, to);
-		spin_unlock(&hb->lock);
-		break;
-
-	case Q_REQUEUE_PI_LOCKED:
-		/* The requeue acquired the lock */
-		if (q.pi_state && (q.pi_state->owner != current)) {
-			spin_lock(q.lock_ptr);
-			ret = fixup_owner(uaddr2, &q, true);
-			/*
-			 * Drop the reference to the pi state which the
-			 * requeue_pi() code acquired for us.
-			 */
-			put_pi_state(q.pi_state);
-			spin_unlock(q.lock_ptr);
-			/*
-			 * Adjust the return value. It's either -EFAULT or
-			 * success (1) but the caller expects 0 for success.
-			 */
-			ret = ret < 0 ? ret : 0;
-		}
-		break;
-
-	case Q_REQUEUE_PI_DONE:
-		/* Requeue completed. Current is 'pi_blocked_on' the rtmutex */
-		pi_mutex = &q.pi_state->pi_mutex;
-		ret = rt_mutex_wait_proxy_lock(pi_mutex, to, &rt_waiter);
-
-		/* Current is not longer pi_blocked_on */
-		spin_lock(q.lock_ptr);
-		if (ret && !rt_mutex_cleanup_proxy_lock(pi_mutex, &rt_waiter))
-			ret = 0;
-
-		debug_rt_mutex_free_waiter(&rt_waiter);
-		/*
-		 * Fixup the pi_state owner and possibly acquire the lock if we
-		 * haven't already.
-		 */
-		res = fixup_owner(uaddr2, &q, !ret);
-		/*
-		 * If fixup_owner() returned an error, propagate that.  If it
-		 * acquired the lock, clear -ETIMEDOUT or -EINTR.
-		 */
-		if (res)
-			ret = (res < 0) ? res : 0;
-
-		unqueue_me_pi(&q);
-		spin_unlock(q.lock_ptr);
-
-		if (ret == -EINTR) {
-			/*
-			 * We've already been requeued, but cannot restart
-			 * by calling futex_lock_pi() directly. We could
-			 * restart this syscall, but it would detect that
-			 * the user space "val" changed and return
-			 * -EWOULDBLOCK.  Save the overhead of the restart
-			 * and return -EWOULDBLOCK directly.
-			 */
-			ret = -EWOULDBLOCK;
-		}
-		break;
-	default:
-		BUG();
-	}
-
-out:
-	if (to) {
-		hrtimer_cancel(&to->timer);
-		destroy_hrtimer_on_stack(&to->timer);
-	}
-	return ret;
-}
-
 /*
  * Support for robust futexes: the kernel cleans up held futexes at
  * thread exit time.
diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
new file mode 100644
index 0000000000000..738b8a5885fe0
--- /dev/null
+++ b/kernel/futex/futex.h
@@ -0,0 +1,238 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _FUTEX_H
+#define _FUTEX_H
+
+#include <linux/futex.h>
+#include <linux/rcuwait.h>
+#include <linux/sched/wake_q.h>
+
+/*
+ * Futex flags used to encode options to functions and preserve them across
+ * restarts.
+ */
+#ifdef CONFIG_MMU
+# define FLAGS_SHARED		0x01
+#else
+/*
+ * NOMMU does not have per process address space. Let the compiler optimize
+ * code away.
+ */
+# define FLAGS_SHARED		0x00
+#endif
+#define FLAGS_CLOCKRT		0x02
+#define FLAGS_HAS_TIMEOUT	0x04
+
+/*
+ * Priority Inheritance state:
+ */
+struct futex_pi_state {
+	/*
+	 * list of 'owned' pi_state instances - these have to be
+	 * cleaned up in do_exit() if the task exits prematurely:
+	 */
+	struct list_head list;
+
+	/*
+	 * The PI object:
+	 */
+	struct rt_mutex_base pi_mutex;
+
+	struct task_struct *owner;
+	refcount_t refcount;
+
+	union futex_key key;
+} __randomize_layout;
+
+/**
+ * struct futex_q - The hashed futex queue entry, one per waiting task
+ * @list:		priority-sorted list of tasks waiting on this futex
+ * @task:		the task waiting on the futex
+ * @lock_ptr:		the hash bucket lock
+ * @key:		the key the futex is hashed on
+ * @pi_state:		optional priority inheritance state
+ * @rt_waiter:		rt_waiter storage for use with requeue_pi
+ * @requeue_pi_key:	the requeue_pi target futex key
+ * @bitset:		bitset for the optional bitmasked wakeup
+ * @requeue_state:	State field for futex_requeue_pi()
+ * @requeue_wait:	RCU wait for futex_requeue_pi() (RT only)
+ *
+ * We use this hashed waitqueue, instead of a normal wait_queue_entry_t, so
+ * we can wake only the relevant ones (hashed queues may be shared).
+ *
+ * A futex_q has a woken state, just like tasks have TASK_RUNNING.
+ * It is considered woken when plist_node_empty(&q->list) || q->lock_ptr == 0.
+ * The order of wakeup is always to make the first condition true, then
+ * the second.
+ *
+ * PI futexes are typically woken before they are removed from the hash list via
+ * the rt_mutex code. See unqueue_me_pi().
+ */
+struct futex_q {
+	struct plist_node list;
+
+	struct task_struct *task;
+	spinlock_t *lock_ptr;
+	union futex_key key;
+	struct futex_pi_state *pi_state;
+	struct rt_mutex_waiter *rt_waiter;
+	union futex_key *requeue_pi_key;
+	u32 bitset;
+	atomic_t requeue_state;
+#ifdef CONFIG_PREEMPT_RT
+	struct rcuwait requeue_wait;
+#endif
+} __randomize_layout;
+
+/*
+ * Hash buckets are shared by all the futex_keys that hash to the same
+ * location.  Each key may have multiple futex_q structures, one for each task
+ * waiting on a futex.
+ */
+struct futex_hash_bucket {
+	atomic_t waiters;
+	spinlock_t lock;
+	struct plist_head chain;
+} ____cacheline_aligned_in_smp;
+
+extern const struct futex_q futex_q_init;
+
+#ifdef CONFIG_FAIL_FUTEX
+extern bool should_fail_futex(bool fshared);
+#else
+static inline bool should_fail_futex(bool fshared)
+{
+	return false;
+}
+#endif
+
+/**
+ * match_futex - Check whether two futex keys are equal
+ * @key1:	Pointer to key1
+ * @key2:	Pointer to key2
+ *
+ * Return 1 if two futex_keys are equal, 0 otherwise.
+ */
+static inline int match_futex(union futex_key *key1, union futex_key *key2)
+{
+	return (key1 && key2
+		&& key1->both.word == key2->both.word
+		&& key1->both.ptr == key2->both.ptr
+		&& key1->both.offset == key2->both.offset);
+}
+
+enum futex_access {
+	FUTEX_READ,
+	FUTEX_WRITE
+};
+
+/*
+ * Reflects a new waiter being added to the waitqueue.
+ */
+static inline void hb_waiters_inc(struct futex_hash_bucket *hb)
+{
+#ifdef CONFIG_SMP
+	atomic_inc(&hb->waiters);
+	/*
+	 * Full barrier (A), see the ordering comment above.
+	 */
+	smp_mb__after_atomic();
+#endif
+}
+
+/*
+ * Reflects a waiter being removed from the waitqueue by wakeup
+ * paths.
+ */
+static inline void hb_waiters_dec(struct futex_hash_bucket *hb)
+{
+#ifdef CONFIG_SMP
+	atomic_dec(&hb->waiters);
+#endif
+}
+
+/*
+ * Express the locking dependencies for lockdep:
+ */
+static inline void
+double_lock_hb(struct futex_hash_bucket *hb1, struct futex_hash_bucket *hb2)
+{
+	if (hb1 <= hb2) {
+		spin_lock(&hb1->lock);
+		if (hb1 < hb2)
+			spin_lock_nested(&hb2->lock, SINGLE_DEPTH_NESTING);
+	} else { /* hb1 > hb2 */
+		spin_lock(&hb2->lock);
+		spin_lock_nested(&hb1->lock, SINGLE_DEPTH_NESTING);
+	}
+}
+
+static inline void
+double_unlock_hb(struct futex_hash_bucket *hb1, struct futex_hash_bucket *hb2)
+{
+	spin_unlock(&hb1->lock);
+	if (hb1 != hb2)
+		spin_unlock(&hb2->lock);
+}
+
+static inline void
+queue_unlock(struct futex_hash_bucket *hb)
+	__releases(&hb->lock)
+{
+	spin_unlock(&hb->lock);
+	hb_waiters_dec(hb);
+}
+
+extern struct futex_hash_bucket *futex_hash(union futex_key *key);
+
+extern int get_futex_key(u32 __user *uaddr, bool fshared, union futex_key *key,
+			 enum futex_access rw);
+
+extern struct hrtimer_sleeper *
+futex_setup_timer(ktime_t *time, struct hrtimer_sleeper *timeout,
+		  int flags, u64 range_ns);
+
+extern int fault_in_user_writeable(u32 __user *uaddr);
+
+extern struct futex_q *futex_top_waiter(struct futex_hash_bucket *hb,
+					union futex_key *key);
+
+extern int futex_get_value_locked(u32 *dest, u32 __user *from);
+
+extern int refill_pi_state_cache(void);
+
+extern void get_pi_state(struct futex_pi_state *pi_state);
+
+extern void put_pi_state(struct futex_pi_state *pi_state);
+
+extern void wait_for_owner_exiting(int ret, struct task_struct *exiting);
+
+extern int futex_lock_pi_atomic(u32 __user *uaddr, struct futex_hash_bucket *hb,
+				union futex_key *key,
+				struct futex_pi_state **ps,
+				struct task_struct *task,
+				struct task_struct **exiting,
+				int set_waiters);
+
+extern void __futex_unqueue(struct futex_q *q);
+
+extern void futex_wake_mark(struct wake_q_head *wake_q, struct futex_q *q);
+
+extern void unqueue_me_pi(struct futex_q *q);
+
+extern int fixup_owner(u32 __user *uaddr, struct futex_q *q, int locked);
+
+extern void futex_wait_queue_me(struct futex_hash_bucket *hb, struct futex_q *q,
+				struct hrtimer_sleeper *timeout);
+
+extern int futex_wait_setup(u32 __user *uaddr, u32 val, unsigned int flags,
+			   struct futex_q *q, struct futex_hash_bucket **hb);
+
+extern int futex_requeue(u32 __user *uaddr1, unsigned int flags,
+			 u32 __user *uaddr2, int nr_wake, int nr_requeue,
+			 u32 *cmpval, int requeue_pi);
+
+extern int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
+				 u32 val, ktime_t *abs_time, u32 bitset,
+				 u32 __user *uaddr2);
+
+#endif /* _FUTEX_H */
diff --git a/kernel/futex/requeue.c b/kernel/futex/requeue.c
new file mode 100644
index 0000000000000..0378f603fb04f
--- /dev/null
+++ b/kernel/futex/requeue.c
@@ -0,0 +1,906 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/sched/signal.h>
+#include <linux/uaccess.h>
+
+#include "futex.h"
+#include "../locking/rtmutex_common.h"
+
+/*
+ * On PREEMPT_RT, the hash bucket lock is a 'sleeping' spinlock with an
+ * underlying rtmutex. The task which is about to be requeued could have
+ * just woken up (timeout, signal). After the wake up the task has to
+ * acquire hash bucket lock, which is held by the requeue code.  As a task
+ * can only be blocked on _ONE_ rtmutex at a time, the proxy lock blocking
+ * and the hash bucket lock blocking would collide and corrupt state.
+ *
+ * On !PREEMPT_RT this is not a problem and everything could be serialized
+ * on hash bucket lock, but aside of having the benefit of common code,
+ * this allows to avoid doing the requeue when the task is already on the
+ * way out and taking the hash bucket lock of the original uaddr1 when the
+ * requeue has been completed.
+ *
+ * The following state transitions are valid:
+ *
+ * On the waiter side:
+ *   Q_REQUEUE_PI_NONE		-> Q_REQUEUE_PI_IGNORE
+ *   Q_REQUEUE_PI_IN_PROGRESS	-> Q_REQUEUE_PI_WAIT
+ *
+ * On the requeue side:
+ *   Q_REQUEUE_PI_NONE		-> Q_REQUEUE_PI_INPROGRESS
+ *   Q_REQUEUE_PI_IN_PROGRESS	-> Q_REQUEUE_PI_DONE/LOCKED
+ *   Q_REQUEUE_PI_IN_PROGRESS	-> Q_REQUEUE_PI_NONE (requeue failed)
+ *   Q_REQUEUE_PI_WAIT		-> Q_REQUEUE_PI_DONE/LOCKED
+ *   Q_REQUEUE_PI_WAIT		-> Q_REQUEUE_PI_IGNORE (requeue failed)
+ *
+ * The requeue side ignores a waiter with state Q_REQUEUE_PI_IGNORE as this
+ * signals that the waiter is already on the way out. It also means that
+ * the waiter is still on the 'wait' futex, i.e. uaddr1.
+ *
+ * The waiter side signals early wakeup to the requeue side either through
+ * setting state to Q_REQUEUE_PI_IGNORE or to Q_REQUEUE_PI_WAIT depending
+ * on the current state. In case of Q_REQUEUE_PI_IGNORE it can immediately
+ * proceed to take the hash bucket lock of uaddr1. If it set state to WAIT,
+ * which means the wakeup is interleaving with a requeue in progress it has
+ * to wait for the requeue side to change the state. Either to DONE/LOCKED
+ * or to IGNORE. DONE/LOCKED means the waiter q is now on the uaddr2 futex
+ * and either blocked (DONE) or has acquired it (LOCKED). IGNORE is set by
+ * the requeue side when the requeue attempt failed via deadlock detection
+ * and therefore the waiter q is still on the uaddr1 futex.
+ */
+enum {
+	Q_REQUEUE_PI_NONE		=  0,
+	Q_REQUEUE_PI_IGNORE,
+	Q_REQUEUE_PI_IN_PROGRESS,
+	Q_REQUEUE_PI_WAIT,
+	Q_REQUEUE_PI_DONE,
+	Q_REQUEUE_PI_LOCKED,
+};
+
+const struct futex_q futex_q_init = {
+	/* list gets initialized in queue_me()*/
+	.key		= FUTEX_KEY_INIT,
+	.bitset		= FUTEX_BITSET_MATCH_ANY,
+	.requeue_state	= ATOMIC_INIT(Q_REQUEUE_PI_NONE),
+};
+
+/**
+ * requeue_futex() - Requeue a futex_q from one hb to another
+ * @q:		the futex_q to requeue
+ * @hb1:	the source hash_bucket
+ * @hb2:	the target hash_bucket
+ * @key2:	the new key for the requeued futex_q
+ */
+static inline
+void requeue_futex(struct futex_q *q, struct futex_hash_bucket *hb1,
+		   struct futex_hash_bucket *hb2, union futex_key *key2)
+{
+
+	/*
+	 * If key1 and key2 hash to the same bucket, no need to
+	 * requeue.
+	 */
+	if (likely(&hb1->chain != &hb2->chain)) {
+		plist_del(&q->list, &hb1->chain);
+		hb_waiters_dec(hb1);
+		hb_waiters_inc(hb2);
+		plist_add(&q->list, &hb2->chain);
+		q->lock_ptr = &hb2->lock;
+	}
+	q->key = *key2;
+}
+
+static inline bool futex_requeue_pi_prepare(struct futex_q *q,
+					    struct futex_pi_state *pi_state)
+{
+	int old, new;
+
+	/*
+	 * Set state to Q_REQUEUE_PI_IN_PROGRESS unless an early wakeup has
+	 * already set Q_REQUEUE_PI_IGNORE to signal that requeue should
+	 * ignore the waiter.
+	 */
+	old = atomic_read_acquire(&q->requeue_state);
+	do {
+		if (old == Q_REQUEUE_PI_IGNORE)
+			return false;
+
+		/*
+		 * futex_proxy_trylock_atomic() might have set it to
+		 * IN_PROGRESS and a interleaved early wake to WAIT.
+		 *
+		 * It was considered to have an extra state for that
+		 * trylock, but that would just add more conditionals
+		 * all over the place for a dubious value.
+		 */
+		if (old != Q_REQUEUE_PI_NONE)
+			break;
+
+		new = Q_REQUEUE_PI_IN_PROGRESS;
+	} while (!atomic_try_cmpxchg(&q->requeue_state, &old, new));
+
+	q->pi_state = pi_state;
+	return true;
+}
+
+static inline void futex_requeue_pi_complete(struct futex_q *q, int locked)
+{
+	int old, new;
+
+	old = atomic_read_acquire(&q->requeue_state);
+	do {
+		if (old == Q_REQUEUE_PI_IGNORE)
+			return;
+
+		if (locked >= 0) {
+			/* Requeue succeeded. Set DONE or LOCKED */
+			WARN_ON_ONCE(old != Q_REQUEUE_PI_IN_PROGRESS &&
+				     old != Q_REQUEUE_PI_WAIT);
+			new = Q_REQUEUE_PI_DONE + locked;
+		} else if (old == Q_REQUEUE_PI_IN_PROGRESS) {
+			/* Deadlock, no early wakeup interleave */
+			new = Q_REQUEUE_PI_NONE;
+		} else {
+			/* Deadlock, early wakeup interleave. */
+			WARN_ON_ONCE(old != Q_REQUEUE_PI_WAIT);
+			new = Q_REQUEUE_PI_IGNORE;
+		}
+	} while (!atomic_try_cmpxchg(&q->requeue_state, &old, new));
+
+#ifdef CONFIG_PREEMPT_RT
+	/* If the waiter interleaved with the requeue let it know */
+	if (unlikely(old == Q_REQUEUE_PI_WAIT))
+		rcuwait_wake_up(&q->requeue_wait);
+#endif
+}
+
+static inline int futex_requeue_pi_wakeup_sync(struct futex_q *q)
+{
+	int old, new;
+
+	old = atomic_read_acquire(&q->requeue_state);
+	do {
+		/* Is requeue done already? */
+		if (old >= Q_REQUEUE_PI_DONE)
+			return old;
+
+		/*
+		 * If not done, then tell the requeue code to either ignore
+		 * the waiter or to wake it up once the requeue is done.
+		 */
+		new = Q_REQUEUE_PI_WAIT;
+		if (old == Q_REQUEUE_PI_NONE)
+			new = Q_REQUEUE_PI_IGNORE;
+	} while (!atomic_try_cmpxchg(&q->requeue_state, &old, new));
+
+	/* If the requeue was in progress, wait for it to complete */
+	if (old == Q_REQUEUE_PI_IN_PROGRESS) {
+#ifdef CONFIG_PREEMPT_RT
+		rcuwait_wait_event(&q->requeue_wait,
+				   atomic_read(&q->requeue_state) != Q_REQUEUE_PI_WAIT,
+				   TASK_UNINTERRUPTIBLE);
+#else
+		(void)atomic_cond_read_relaxed(&q->requeue_state, VAL != Q_REQUEUE_PI_WAIT);
+#endif
+	}
+
+	/*
+	 * Requeue is now either prohibited or complete. Reread state
+	 * because during the wait above it might have changed. Nothing
+	 * will modify q->requeue_state after this point.
+	 */
+	return atomic_read(&q->requeue_state);
+}
+
+/**
+ * requeue_pi_wake_futex() - Wake a task that acquired the lock during requeue
+ * @q:		the futex_q
+ * @key:	the key of the requeue target futex
+ * @hb:		the hash_bucket of the requeue target futex
+ *
+ * During futex_requeue, with requeue_pi=1, it is possible to acquire the
+ * target futex if it is uncontended or via a lock steal.
+ *
+ * 1) Set @q::key to the requeue target futex key so the waiter can detect
+ *    the wakeup on the right futex.
+ *
+ * 2) Dequeue @q from the hash bucket.
+ *
+ * 3) Set @q::rt_waiter to NULL so the woken up task can detect atomic lock
+ *    acquisition.
+ *
+ * 4) Set the q->lock_ptr to the requeue target hb->lock for the case that
+ *    the waiter has to fixup the pi state.
+ *
+ * 5) Complete the requeue state so the waiter can make progress. After
+ *    this point the waiter task can return from the syscall immediately in
+ *    case that the pi state does not have to be fixed up.
+ *
+ * 6) Wake the waiter task.
+ *
+ * Must be called with both q->lock_ptr and hb->lock held.
+ */
+static inline
+void requeue_pi_wake_futex(struct futex_q *q, union futex_key *key,
+			   struct futex_hash_bucket *hb)
+{
+	struct task_struct *task;
+
+	q->key = *key;
+
+	__futex_unqueue(q);
+
+	WARN_ON(!q->rt_waiter);
+	q->rt_waiter = NULL;
+
+	q->lock_ptr = &hb->lock;
+	task = READ_ONCE(q->task);
+
+	/* Signal locked state to the waiter */
+	futex_requeue_pi_complete(q, 1);
+	wake_up_state(task, TASK_NORMAL);
+}
+
+/**
+ * futex_proxy_trylock_atomic() - Attempt an atomic lock for the top waiter
+ * @pifutex:		the user address of the to futex
+ * @hb1:		the from futex hash bucket, must be locked by the caller
+ * @hb2:		the to futex hash bucket, must be locked by the caller
+ * @key1:		the from futex key
+ * @key2:		the to futex key
+ * @ps:			address to store the pi_state pointer
+ * @exiting:		Pointer to store the task pointer of the owner task
+ *			which is in the middle of exiting
+ * @set_waiters:	force setting the FUTEX_WAITERS bit (1) or not (0)
+ *
+ * Try and get the lock on behalf of the top waiter if we can do it atomically.
+ * Wake the top waiter if we succeed.  If the caller specified set_waiters,
+ * then direct futex_lock_pi_atomic() to force setting the FUTEX_WAITERS bit.
+ * hb1 and hb2 must be held by the caller.
+ *
+ * @exiting is only set when the return value is -EBUSY. If so, this holds
+ * a refcount on the exiting task on return and the caller needs to drop it
+ * after waiting for the exit to complete.
+ *
+ * Return:
+ *  -  0 - failed to acquire the lock atomically;
+ *  - >0 - acquired the lock, return value is vpid of the top_waiter
+ *  - <0 - error
+ */
+static int
+futex_proxy_trylock_atomic(u32 __user *pifutex, struct futex_hash_bucket *hb1,
+			   struct futex_hash_bucket *hb2, union futex_key *key1,
+			   union futex_key *key2, struct futex_pi_state **ps,
+			   struct task_struct **exiting, int set_waiters)
+{
+	struct futex_q *top_waiter = NULL;
+	u32 curval;
+	int ret;
+
+	if (futex_get_value_locked(&curval, pifutex))
+		return -EFAULT;
+
+	if (unlikely(should_fail_futex(true)))
+		return -EFAULT;
+
+	/*
+	 * Find the top_waiter and determine if there are additional waiters.
+	 * If the caller intends to requeue more than 1 waiter to pifutex,
+	 * force futex_lock_pi_atomic() to set the FUTEX_WAITERS bit now,
+	 * as we have means to handle the possible fault.  If not, don't set
+	 * the bit unnecessarily as it will force the subsequent unlock to enter
+	 * the kernel.
+	 */
+	top_waiter = futex_top_waiter(hb1, key1);
+
+	/* There are no waiters, nothing for us to do. */
+	if (!top_waiter)
+		return 0;
+
+	/*
+	 * Ensure that this is a waiter sitting in futex_wait_requeue_pi()
+	 * and waiting on the 'waitqueue' futex which is always !PI.
+	 */
+	if (!top_waiter->rt_waiter || top_waiter->pi_state)
+		return -EINVAL;
+
+	/* Ensure we requeue to the expected futex. */
+	if (!match_futex(top_waiter->requeue_pi_key, key2))
+		return -EINVAL;
+
+	/* Ensure that this does not race against an early wakeup */
+	if (!futex_requeue_pi_prepare(top_waiter, NULL)) {
+		plist_del(&top_waiter->list, &hb1->chain);
+		hb_waiters_dec(hb1);
+		return -EAGAIN;
+	}
+
+	/*
+	 * Try to take the lock for top_waiter and set the FUTEX_WAITERS bit
+	 * in the contended case or if @set_waiters is true.
+	 *
+	 * In the contended case PI state is attached to the lock owner. If
+	 * the user space lock can be acquired then PI state is attached to
+	 * the new owner (@top_waiter->task) when @set_waiters is true.
+	 */
+	ret = futex_lock_pi_atomic(pifutex, hb2, key2, ps, top_waiter->task,
+				   exiting, set_waiters);
+	if (ret == 1) {
+		/*
+		 * Lock was acquired in user space and PI state was
+		 * attached to @top_waiter->task. That means state is fully
+		 * consistent and the waiter can return to user space
+		 * immediately after the wakeup.
+		 */
+		requeue_pi_wake_futex(top_waiter, key2, hb2);
+	} else if (ret < 0) {
+		/* Rewind top_waiter::requeue_state */
+		futex_requeue_pi_complete(top_waiter, ret);
+	} else {
+		/*
+		 * futex_lock_pi_atomic() did not acquire the user space
+		 * futex, but managed to establish the proxy lock and pi
+		 * state. top_waiter::requeue_state cannot be fixed up here
+		 * because the waiter is not enqueued on the rtmutex
+		 * yet. This is handled at the callsite depending on the
+		 * result of rt_mutex_start_proxy_lock() which is
+		 * guaranteed to be reached with this function returning 0.
+		 */
+	}
+	return ret;
+}
+
+/**
+ * futex_requeue() - Requeue waiters from uaddr1 to uaddr2
+ * @uaddr1:	source futex user address
+ * @flags:	futex flags (FLAGS_SHARED, etc.)
+ * @uaddr2:	target futex user address
+ * @nr_wake:	number of waiters to wake (must be 1 for requeue_pi)
+ * @nr_requeue:	number of waiters to requeue (0-INT_MAX)
+ * @cmpval:	@uaddr1 expected value (or %NULL)
+ * @requeue_pi:	if we are attempting to requeue from a non-pi futex to a
+ *		pi futex (pi to pi requeue is not supported)
+ *
+ * Requeue waiters on uaddr1 to uaddr2. In the requeue_pi case, try to acquire
+ * uaddr2 atomically on behalf of the top waiter.
+ *
+ * Return:
+ *  - >=0 - on success, the number of tasks requeued or woken;
+ *  -  <0 - on error
+ */
+int futex_requeue(u32 __user *uaddr1, unsigned int flags,
+			 u32 __user *uaddr2, int nr_wake, int nr_requeue,
+			 u32 *cmpval, int requeue_pi)
+{
+	union futex_key key1 = FUTEX_KEY_INIT, key2 = FUTEX_KEY_INIT;
+	int task_count = 0, ret;
+	struct futex_pi_state *pi_state = NULL;
+	struct futex_hash_bucket *hb1, *hb2;
+	struct futex_q *this, *next;
+	DEFINE_WAKE_Q(wake_q);
+
+	if (nr_wake < 0 || nr_requeue < 0)
+		return -EINVAL;
+
+	/*
+	 * When PI not supported: return -ENOSYS if requeue_pi is true,
+	 * consequently the compiler knows requeue_pi is always false past
+	 * this point which will optimize away all the conditional code
+	 * further down.
+	 */
+	if (!IS_ENABLED(CONFIG_FUTEX_PI) && requeue_pi)
+		return -ENOSYS;
+
+	if (requeue_pi) {
+		/*
+		 * Requeue PI only works on two distinct uaddrs. This
+		 * check is only valid for private futexes. See below.
+		 */
+		if (uaddr1 == uaddr2)
+			return -EINVAL;
+
+		/*
+		 * futex_requeue() allows the caller to define the number
+		 * of waiters to wake up via the @nr_wake argument. With
+		 * REQUEUE_PI, waking up more than one waiter is creating
+		 * more problems than it solves. Waking up a waiter makes
+		 * only sense if the PI futex @uaddr2 is uncontended as
+		 * this allows the requeue code to acquire the futex
+		 * @uaddr2 before waking the waiter. The waiter can then
+		 * return to user space without further action. A secondary
+		 * wakeup would just make the futex_wait_requeue_pi()
+		 * handling more complex, because that code would have to
+		 * look up pi_state and do more or less all the handling
+		 * which the requeue code has to do for the to be requeued
+		 * waiters. So restrict the number of waiters to wake to
+		 * one, and only wake it up when the PI futex is
+		 * uncontended. Otherwise requeue it and let the unlock of
+		 * the PI futex handle the wakeup.
+		 *
+		 * All REQUEUE_PI users, e.g. pthread_cond_signal() and
+		 * pthread_cond_broadcast() must use nr_wake=1.
+		 */
+		if (nr_wake != 1)
+			return -EINVAL;
+
+		/*
+		 * requeue_pi requires a pi_state, try to allocate it now
+		 * without any locks in case it fails.
+		 */
+		if (refill_pi_state_cache())
+			return -ENOMEM;
+	}
+
+retry:
+	ret = get_futex_key(uaddr1, flags & FLAGS_SHARED, &key1, FUTEX_READ);
+	if (unlikely(ret != 0))
+		return ret;
+	ret = get_futex_key(uaddr2, flags & FLAGS_SHARED, &key2,
+			    requeue_pi ? FUTEX_WRITE : FUTEX_READ);
+	if (unlikely(ret != 0))
+		return ret;
+
+	/*
+	 * The check above which compares uaddrs is not sufficient for
+	 * shared futexes. We need to compare the keys:
+	 */
+	if (requeue_pi && match_futex(&key1, &key2))
+		return -EINVAL;
+
+	hb1 = futex_hash(&key1);
+	hb2 = futex_hash(&key2);
+
+retry_private:
+	hb_waiters_inc(hb2);
+	double_lock_hb(hb1, hb2);
+
+	if (likely(cmpval != NULL)) {
+		u32 curval;
+
+		ret = futex_get_value_locked(&curval, uaddr1);
+
+		if (unlikely(ret)) {
+			double_unlock_hb(hb1, hb2);
+			hb_waiters_dec(hb2);
+
+			ret = get_user(curval, uaddr1);
+			if (ret)
+				return ret;
+
+			if (!(flags & FLAGS_SHARED))
+				goto retry_private;
+
+			goto retry;
+		}
+		if (curval != *cmpval) {
+			ret = -EAGAIN;
+			goto out_unlock;
+		}
+	}
+
+	if (requeue_pi) {
+		struct task_struct *exiting = NULL;
+
+		/*
+		 * Attempt to acquire uaddr2 and wake the top waiter. If we
+		 * intend to requeue waiters, force setting the FUTEX_WAITERS
+		 * bit.  We force this here where we are able to easily handle
+		 * faults rather in the requeue loop below.
+		 *
+		 * Updates topwaiter::requeue_state if a top waiter exists.
+		 */
+		ret = futex_proxy_trylock_atomic(uaddr2, hb1, hb2, &key1,
+						 &key2, &pi_state,
+						 &exiting, nr_requeue);
+
+		/*
+		 * At this point the top_waiter has either taken uaddr2 or
+		 * is waiting on it. In both cases pi_state has been
+		 * established and an initial refcount on it. In case of an
+		 * error there's nothing.
+		 *
+		 * The top waiter's requeue_state is up to date:
+		 *
+		 *  - If the lock was acquired atomically (ret == 1), then
+		 *    the state is Q_REQUEUE_PI_LOCKED.
+		 *
+		 *    The top waiter has been dequeued and woken up and can
+		 *    return to user space immediately. The kernel/user
+		 *    space state is consistent. In case that there must be
+		 *    more waiters requeued the WAITERS bit in the user
+		 *    space futex is set so the top waiter task has to go
+		 *    into the syscall slowpath to unlock the futex. This
+		 *    will block until this requeue operation has been
+		 *    completed and the hash bucket locks have been
+		 *    dropped.
+		 *
+		 *  - If the trylock failed with an error (ret < 0) then
+		 *    the state is either Q_REQUEUE_PI_NONE, i.e. "nothing
+		 *    happened", or Q_REQUEUE_PI_IGNORE when there was an
+		 *    interleaved early wakeup.
+		 *
+		 *  - If the trylock did not succeed (ret == 0) then the
+		 *    state is either Q_REQUEUE_PI_IN_PROGRESS or
+		 *    Q_REQUEUE_PI_WAIT if an early wakeup interleaved.
+		 *    This will be cleaned up in the loop below, which
+		 *    cannot fail because futex_proxy_trylock_atomic() did
+		 *    the same sanity checks for requeue_pi as the loop
+		 *    below does.
+		 */
+		switch (ret) {
+		case 0:
+			/* We hold a reference on the pi state. */
+			break;
+
+		case 1:
+			/*
+			 * futex_proxy_trylock_atomic() acquired the user space
+			 * futex. Adjust task_count.
+			 */
+			task_count++;
+			ret = 0;
+			break;
+
+		/*
+		 * If the above failed, then pi_state is NULL and
+		 * waiter::requeue_state is correct.
+		 */
+		case -EFAULT:
+			double_unlock_hb(hb1, hb2);
+			hb_waiters_dec(hb2);
+			ret = fault_in_user_writeable(uaddr2);
+			if (!ret)
+				goto retry;
+			return ret;
+		case -EBUSY:
+		case -EAGAIN:
+			/*
+			 * Two reasons for this:
+			 * - EBUSY: Owner is exiting and we just wait for the
+			 *   exit to complete.
+			 * - EAGAIN: The user space value changed.
+			 */
+			double_unlock_hb(hb1, hb2);
+			hb_waiters_dec(hb2);
+			/*
+			 * Handle the case where the owner is in the middle of
+			 * exiting. Wait for the exit to complete otherwise
+			 * this task might loop forever, aka. live lock.
+			 */
+			wait_for_owner_exiting(ret, exiting);
+			cond_resched();
+			goto retry;
+		default:
+			goto out_unlock;
+		}
+	}
+
+	plist_for_each_entry_safe(this, next, &hb1->chain, list) {
+		if (task_count - nr_wake >= nr_requeue)
+			break;
+
+		if (!match_futex(&this->key, &key1))
+			continue;
+
+		/*
+		 * FUTEX_WAIT_REQUEUE_PI and FUTEX_CMP_REQUEUE_PI should always
+		 * be paired with each other and no other futex ops.
+		 *
+		 * We should never be requeueing a futex_q with a pi_state,
+		 * which is awaiting a futex_unlock_pi().
+		 */
+		if ((requeue_pi && !this->rt_waiter) ||
+		    (!requeue_pi && this->rt_waiter) ||
+		    this->pi_state) {
+			ret = -EINVAL;
+			break;
+		}
+
+		/* Plain futexes just wake or requeue and are done */
+		if (!requeue_pi) {
+			if (++task_count <= nr_wake)
+				futex_wake_mark(&wake_q, this);
+			else
+				requeue_futex(this, hb1, hb2, &key2);
+			continue;
+		}
+
+		/* Ensure we requeue to the expected futex for requeue_pi. */
+		if (!match_futex(this->requeue_pi_key, &key2)) {
+			ret = -EINVAL;
+			break;
+		}
+
+		/*
+		 * Requeue nr_requeue waiters and possibly one more in the case
+		 * of requeue_pi if we couldn't acquire the lock atomically.
+		 *
+		 * Prepare the waiter to take the rt_mutex. Take a refcount
+		 * on the pi_state and store the pointer in the futex_q
+		 * object of the waiter.
+		 */
+		get_pi_state(pi_state);
+
+		/* Don't requeue when the waiter is already on the way out. */
+		if (!futex_requeue_pi_prepare(this, pi_state)) {
+			/*
+			 * Early woken waiter signaled that it is on the
+			 * way out. Drop the pi_state reference and try the
+			 * next waiter. @this->pi_state is still NULL.
+			 */
+			put_pi_state(pi_state);
+			continue;
+		}
+
+		ret = rt_mutex_start_proxy_lock(&pi_state->pi_mutex,
+						this->rt_waiter,
+						this->task);
+
+		if (ret == 1) {
+			/*
+			 * We got the lock. We do neither drop the refcount
+			 * on pi_state nor clear this->pi_state because the
+			 * waiter needs the pi_state for cleaning up the
+			 * user space value. It will drop the refcount
+			 * after doing so. this::requeue_state is updated
+			 * in the wakeup as well.
+			 */
+			requeue_pi_wake_futex(this, &key2, hb2);
+			task_count++;
+		} else if (!ret) {
+			/* Waiter is queued, move it to hb2 */
+			requeue_futex(this, hb1, hb2, &key2);
+			futex_requeue_pi_complete(this, 0);
+			task_count++;
+		} else {
+			/*
+			 * rt_mutex_start_proxy_lock() detected a potential
+			 * deadlock when we tried to queue that waiter.
+			 * Drop the pi_state reference which we took above
+			 * and remove the pointer to the state from the
+			 * waiters futex_q object.
+			 */
+			this->pi_state = NULL;
+			put_pi_state(pi_state);
+			futex_requeue_pi_complete(this, ret);
+			/*
+			 * We stop queueing more waiters and let user space
+			 * deal with the mess.
+			 */
+			break;
+		}
+	}
+
+	/*
+	 * We took an extra initial reference to the pi_state in
+	 * futex_proxy_trylock_atomic(). We need to drop it here again.
+	 */
+	put_pi_state(pi_state);
+
+out_unlock:
+	double_unlock_hb(hb1, hb2);
+	wake_up_q(&wake_q);
+	hb_waiters_dec(hb2);
+	return ret ? ret : task_count;
+}
+
+/**
+ * handle_early_requeue_pi_wakeup() - Handle early wakeup on the initial futex
+ * @hb:		the hash_bucket futex_q was original enqueued on
+ * @q:		the futex_q woken while waiting to be requeued
+ * @timeout:	the timeout associated with the wait (NULL if none)
+ *
+ * Determine the cause for the early wakeup.
+ *
+ * Return:
+ *  -EWOULDBLOCK or -ETIMEDOUT or -ERESTARTNOINTR
+ */
+static inline
+int handle_early_requeue_pi_wakeup(struct futex_hash_bucket *hb,
+				   struct futex_q *q,
+				   struct hrtimer_sleeper *timeout)
+{
+	int ret;
+
+	/*
+	 * With the hb lock held, we avoid races while we process the wakeup.
+	 * We only need to hold hb (and not hb2) to ensure atomicity as the
+	 * wakeup code can't change q.key from uaddr to uaddr2 if we hold hb.
+	 * It can't be requeued from uaddr2 to something else since we don't
+	 * support a PI aware source futex for requeue.
+	 */
+	WARN_ON_ONCE(&hb->lock != q->lock_ptr);
+
+	/*
+	 * We were woken prior to requeue by a timeout or a signal.
+	 * Conditionally unqueue the futex_q and determine which it was.
+	 */
+	if (!plist_node_empty(&q->list)) {
+		plist_del(&q->list, &hb->chain);
+		hb_waiters_dec(hb);
+	}
+
+	/* Handle spurious wakeups gracefully */
+	ret = -EWOULDBLOCK;
+	if (timeout && !timeout->task)
+		ret = -ETIMEDOUT;
+	else if (signal_pending(current))
+		ret = -ERESTARTNOINTR;
+	return ret;
+}
+
+/**
+ * futex_wait_requeue_pi() - Wait on uaddr and take uaddr2
+ * @uaddr:	the futex we initially wait on (non-pi)
+ * @flags:	futex flags (FLAGS_SHARED, FLAGS_CLOCKRT, etc.), they must be
+ *		the same type, no requeueing from private to shared, etc.
+ * @val:	the expected value of uaddr
+ * @abs_time:	absolute timeout
+ * @bitset:	32 bit wakeup bitset set by userspace, defaults to all
+ * @uaddr2:	the pi futex we will take prior to returning to user-space
+ *
+ * The caller will wait on uaddr and will be requeued by futex_requeue() to
+ * uaddr2 which must be PI aware and unique from uaddr.  Normal wakeup will wake
+ * on uaddr2 and complete the acquisition of the rt_mutex prior to returning to
+ * userspace.  This ensures the rt_mutex maintains an owner when it has waiters;
+ * without one, the pi logic would not know which task to boost/deboost, if
+ * there was a need to.
+ *
+ * We call schedule in futex_wait_queue_me() when we enqueue and return there
+ * via the following--
+ * 1) wakeup on uaddr2 after an atomic lock acquisition by futex_requeue()
+ * 2) wakeup on uaddr2 after a requeue
+ * 3) signal
+ * 4) timeout
+ *
+ * If 3, cleanup and return -ERESTARTNOINTR.
+ *
+ * If 2, we may then block on trying to take the rt_mutex and return via:
+ * 5) successful lock
+ * 6) signal
+ * 7) timeout
+ * 8) other lock acquisition failure
+ *
+ * If 6, return -EWOULDBLOCK (restarting the syscall would do the same).
+ *
+ * If 4 or 7, we cleanup and return with -ETIMEDOUT.
+ *
+ * Return:
+ *  -  0 - On success;
+ *  - <0 - On error
+ */
+int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
+				 u32 val, ktime_t *abs_time, u32 bitset,
+				 u32 __user *uaddr2)
+{
+	struct hrtimer_sleeper timeout, *to;
+	struct rt_mutex_waiter rt_waiter;
+	struct futex_hash_bucket *hb;
+	union futex_key key2 = FUTEX_KEY_INIT;
+	struct futex_q q = futex_q_init;
+	struct rt_mutex_base *pi_mutex;
+	int res, ret;
+
+	if (!IS_ENABLED(CONFIG_FUTEX_PI))
+		return -ENOSYS;
+
+	if (uaddr == uaddr2)
+		return -EINVAL;
+
+	if (!bitset)
+		return -EINVAL;
+
+	to = futex_setup_timer(abs_time, &timeout, flags,
+			       current->timer_slack_ns);
+
+	/*
+	 * The waiter is allocated on our stack, manipulated by the requeue
+	 * code while we sleep on uaddr.
+	 */
+	rt_mutex_init_waiter(&rt_waiter);
+
+	ret = get_futex_key(uaddr2, flags & FLAGS_SHARED, &key2, FUTEX_WRITE);
+	if (unlikely(ret != 0))
+		goto out;
+
+	q.bitset = bitset;
+	q.rt_waiter = &rt_waiter;
+	q.requeue_pi_key = &key2;
+
+	/*
+	 * Prepare to wait on uaddr. On success, it holds hb->lock and q
+	 * is initialized.
+	 */
+	ret = futex_wait_setup(uaddr, val, flags, &q, &hb);
+	if (ret)
+		goto out;
+
+	/*
+	 * The check above which compares uaddrs is not sufficient for
+	 * shared futexes. We need to compare the keys:
+	 */
+	if (match_futex(&q.key, &key2)) {
+		queue_unlock(hb);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* Queue the futex_q, drop the hb lock, wait for wakeup. */
+	futex_wait_queue_me(hb, &q, to);
+
+	switch (futex_requeue_pi_wakeup_sync(&q)) {
+	case Q_REQUEUE_PI_IGNORE:
+		/* The waiter is still on uaddr1 */
+		spin_lock(&hb->lock);
+		ret = handle_early_requeue_pi_wakeup(hb, &q, to);
+		spin_unlock(&hb->lock);
+		break;
+
+	case Q_REQUEUE_PI_LOCKED:
+		/* The requeue acquired the lock */
+		if (q.pi_state && (q.pi_state->owner != current)) {
+			spin_lock(q.lock_ptr);
+			ret = fixup_owner(uaddr2, &q, true);
+			/*
+			 * Drop the reference to the pi state which the
+			 * requeue_pi() code acquired for us.
+			 */
+			put_pi_state(q.pi_state);
+			spin_unlock(q.lock_ptr);
+			/*
+			 * Adjust the return value. It's either -EFAULT or
+			 * success (1) but the caller expects 0 for success.
+			 */
+			ret = ret < 0 ? ret : 0;
+		}
+		break;
+
+	case Q_REQUEUE_PI_DONE:
+		/* Requeue completed. Current is 'pi_blocked_on' the rtmutex */
+		pi_mutex = &q.pi_state->pi_mutex;
+		ret = rt_mutex_wait_proxy_lock(pi_mutex, to, &rt_waiter);
+
+		/* Current is not longer pi_blocked_on */
+		spin_lock(q.lock_ptr);
+		if (ret && !rt_mutex_cleanup_proxy_lock(pi_mutex, &rt_waiter))
+			ret = 0;
+
+		debug_rt_mutex_free_waiter(&rt_waiter);
+		/*
+		 * Fixup the pi_state owner and possibly acquire the lock if we
+		 * haven't already.
+		 */
+		res = fixup_owner(uaddr2, &q, !ret);
+		/*
+		 * If fixup_owner() returned an error, propagate that.  If it
+		 * acquired the lock, clear -ETIMEDOUT or -EINTR.
+		 */
+		if (res)
+			ret = (res < 0) ? res : 0;
+
+		unqueue_me_pi(&q);
+		spin_unlock(q.lock_ptr);
+
+		if (ret == -EINTR) {
+			/*
+			 * We've already been requeued, but cannot restart
+			 * by calling futex_lock_pi() directly. We could
+			 * restart this syscall, but it would detect that
+			 * the user space "val" changed and return
+			 * -EWOULDBLOCK.  Save the overhead of the restart
+			 * and return -EWOULDBLOCK directly.
+			 */
+			ret = -EWOULDBLOCK;
+		}
+		break;
+	default:
+		BUG();
+	}
+
+out:
+	if (to) {
+		hrtimer_cancel(&to->timer);
+		destroy_hrtimer_on_stack(&to->timer);
+	}
+	return ret;
+}
-- 
2.53.0

