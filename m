Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C751E4908BE
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 15:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787671995; cv=none; b=GMFtmAGYDEuf74JMOya7USEAGOVIVDK7XajNGUzJS/7x+fDu3B2Bpjvi3ptCtlNS2BsHaFZm3dY34x0BH0695dn6HUloQWrk6hTf8E8h4w6qHmMoWlHeFfrQte/9tkZhGfQbee+T3nwVCy+JzJ3AKY6yGBee8t9Dc6VLFCT1coY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787671995; c=relaxed/simple;
	bh=Jh2gKBEy3BE7nS+IcGs+JPCEiTgLWMWQaDNWJKyP0dY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i6CMWGESfx1Zq20ZlITY+LKKHR/6Q9VmhnTsndQjw+IOI5b7p2B/jP7uAPfmUq81g+jf12nlegnEJxfgF75L85ZvS7cTFZ3IE7mP8tszxf/cncSgdrrCCjA9WVi5EJeiKKEF6SLgzJUxYhwZdaamQQpZ5NteRKY+SqvLEm5W9Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mppy8G25; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mppy8G25"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFB6C1F00ACA;
	Tue, 25 Aug 2026 15:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787671993;
	bh=UWfjr2dYvdLuVfqlguHNR7sO04L0zn7QgFedU9D1pww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Mppy8G25MVmC5jsNNvEv4H40jPEWzwDfXvagpHbfnqnViGwzRVM0vyo0w3E7tvsLv
	 2NfhgSI9qirhN5kotSHji1hgimwSetFE9o9dLfaDKbKrVdGhjcJQNkRgTD68g1Cfvs
	 KJkT8Polufw016nzNBVHhX0NoEQ6pPOgm4sKm/csEGX6gTtP6yhviu6pUCw+f3q1k3
	 3vAXwQnM4K2KgLHvyuG7KNnM9nS9+50spgkPJRQea2oQLOue7hxMYSZeW8uRzQg99s
	 7GTM13jCe8Eyo5W1S8tiQiNP0mBAxPqw5MmhrKNoDTb/vHxV4KD5OeUIEpebqomNYN
	 TyFeM7IGqXnmg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 2/3] futex: Move futex related mm_struct data into a struct
Date: Tue, 25 Aug 2026 11:33:09 -0400
Message-ID: <20260825153310.4065884-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260825153310.4065884-1-sashal@kernel.org>
References: <2026082406-engaged-statistic-82bb@gregkh>
 <20260825153310.4065884-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@kernel.org>

[ Upstream commit 1f7f4816b9b05e5110bc1c8a05c3c478e2dae11b ]

Having all these members in mm_struct along with the required #ifdeffery is
annoying, does not allow efficient initializing of the data with
memset() and makes extending it tedious.

Move it into a data structure and fix up all usage sites.

The extra struct for the private hash is intentional to make integration of
other conditional mechanisms easier in terms of initialization and separation.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260602090535.407756793@kernel.org
Stable-dep-of: bde023808364 ("futex: Fix race on the initial mm->futex.phash.ref allocation")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/futex_types.h |  45 ++++++++++++
 include/linux/mm_types.h    |  12 +---
 kernel/futex/core.c         | 133 +++++++++++++++++-------------------
 3 files changed, 108 insertions(+), 82 deletions(-)
 create mode 100644 include/linux/futex_types.h

diff --git a/include/linux/futex_types.h b/include/linux/futex_types.h
new file mode 100644
index 0000000000000..dab677995c2e5
--- /dev/null
+++ b/include/linux/futex_types.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_FUTEX_TYPES_H
+#define _LINUX_FUTEX_TYPES_H
+
+#ifdef CONFIG_FUTEX
+#include <linux/compiler_types.h>
+#include <linux/mutex_types.h>
+#include <linux/types.h>
+
+#ifdef CONFIG_FUTEX_PRIVATE_HASH
+/**
+ * struct futex_mm_phash - Futex private hash related per MM data
+ * @lock:	Mutex to protect the private hash operations
+ * @hash:	RCU managed pointer to the private hash
+ * @hash_new:	Pointer to a newly allocated private hash
+ * @batches:	Batch state for RCU synchronization
+ * @rcu:	RCU head for call_rcu()
+ * @atomic:	Aggregate value for @hash_ref
+ * @ref:	Per CPU reference counter for a private hash
+ */
+struct futex_mm_phash {
+	struct mutex			lock;
+	struct futex_private_hash	__rcu *hash;
+	struct futex_private_hash	*hash_new;
+	unsigned long			batches;
+	struct rcu_head			rcu;
+	atomic_long_t			atomic;
+	unsigned int			__percpu *ref;
+};
+#else  /* CONFIG_FUTEX_ROBUST_UNLOCK */
+struct futex_mm_phash { };
+#endif /* !CONFIG_FUTEX_ROBUST_UNLOCK */
+
+/**
+ * struct futex_mm_data - Futex related per MM data
+ * @phash:	Futex private hash related data
+ */
+struct futex_mm_data {
+	struct futex_mm_phash		phash;
+};
+#else  /* CONFIG_FUTEX */
+struct futex_mm_data { };
+#endif /* !CONFIG_FUTEX */
+
+#endif /* _LINUX_FUTEX_TYPES_H */
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index a308e2c23b829..1d0c8d8875aa8 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -20,6 +20,7 @@
 #include <linux/seqlock.h>
 #include <linux/percpu_counter.h>
 #include <linux/types.h>
+#include <linux/futex_types.h>
 #include <linux/rseq_types.h>
 #include <linux/bitmap.h>
 
@@ -1270,16 +1271,7 @@ struct mm_struct {
 		 */
 		seqcount_t mm_lock_seq;
 #endif
-#ifdef CONFIG_FUTEX_PRIVATE_HASH
-		struct mutex			futex_hash_lock;
-		struct futex_private_hash	__rcu *futex_phash;
-		struct futex_private_hash	*futex_phash_new;
-		/* futex-ref */
-		unsigned long			futex_batches;
-		struct rcu_head			futex_rcu;
-		atomic_long_t			futex_atomic;
-		unsigned int			__percpu *futex_ref;
-#endif
+		struct futex_mm_data	futex;
 
 		unsigned long hiwater_rss; /* High-watermark of RSS usage */
 		unsigned long hiwater_vm;  /* High-water virtual memory usage */
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index cfaa96c009320..033f373fdcc05 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -187,13 +187,13 @@ __futex_hash_private(union futex_key *key, struct futex_private_hash *fph)
 		return NULL;
 
 	if (!fph)
-		fph = rcu_dereference(key->private.mm->futex_phash);
+		fph = rcu_dereference(key->private.mm->futex.phash.hash);
 	if (!fph || !fph->hash_mask)
 		return NULL;
 
-	hash = jhash2((void *)&key->private.address,
-		      sizeof(key->private.address) / 4,
+	hash = jhash2((void *)&key->private.address, sizeof(key->private.address) / 4,
 		      key->both.offset);
+
 	return &fph->queues[hash & fph->hash_mask];
 }
 
@@ -232,18 +232,17 @@ static void futex_rehash_private(struct futex_private_hash *old,
 	}
 }
 
-static bool __futex_pivot_hash(struct mm_struct *mm,
-			       struct futex_private_hash *new)
+static bool __futex_pivot_hash(struct mm_struct *mm, struct futex_private_hash *new)
 {
+	struct futex_mm_phash *mmph = &mm->futex.phash;
 	struct futex_private_hash *fph;
 
-	WARN_ON_ONCE(mm->futex_phash_new);
+	WARN_ON_ONCE(mmph->hash_new);
 
-	fph = rcu_dereference_protected(mm->futex_phash,
-					lockdep_is_held(&mm->futex_hash_lock));
+	fph = rcu_dereference_protected(mmph->hash, lockdep_is_held(&mmph->lock));
 	if (fph) {
 		if (!futex_ref_is_dead(fph)) {
-			mm->futex_phash_new = new;
+			mmph->hash_new = new;
 			return false;
 		}
 
@@ -251,8 +250,8 @@ static bool __futex_pivot_hash(struct mm_struct *mm,
 	}
 	new->state = FR_PERCPU;
 	scoped_guard(rcu) {
-		mm->futex_batches = get_state_synchronize_rcu();
-		rcu_assign_pointer(mm->futex_phash, new);
+		mmph->batches = get_state_synchronize_rcu();
+		rcu_assign_pointer(mmph->hash, new);
 	}
 	kvfree_rcu(fph, rcu);
 	return true;
@@ -260,12 +259,12 @@ static bool __futex_pivot_hash(struct mm_struct *mm,
 
 static void futex_pivot_hash(struct mm_struct *mm)
 {
-	scoped_guard(mutex, &mm->futex_hash_lock) {
+	scoped_guard(mutex, &mm->futex.phash.lock) {
 		struct futex_private_hash *fph;
 
-		fph = mm->futex_phash_new;
+		fph = mm->futex.phash.hash_new;
 		if (fph) {
-			mm->futex_phash_new = NULL;
+			mm->futex.phash.hash_new = NULL;
 			__futex_pivot_hash(mm, fph);
 		}
 	}
@@ -288,7 +287,7 @@ struct futex_private_hash *futex_private_hash(void)
 	scoped_guard(rcu) {
 		struct futex_private_hash *fph;
 
-		fph = rcu_dereference(mm->futex_phash);
+		fph = rcu_dereference(mm->futex.phash.hash);
 		if (!fph)
 			return NULL;
 
@@ -411,8 +410,7 @@ static int futex_mpol(struct mm_struct *mm, unsigned long addr)
  * private hash) is returned if existing. Otherwise a hash bucket from the
  * global hash is returned.
  */
-static struct futex_hash_bucket *
-__futex_hash(union futex_key *key, struct futex_private_hash *fph)
+static struct futex_hash_bucket *__futex_hash(union futex_key *key, struct futex_private_hash *fph)
 {
 	int node = key->both.node;
 	u32 hash;
@@ -425,8 +423,7 @@ __futex_hash(union futex_key *key, struct futex_private_hash *fph)
 			return hb;
 	}
 
-	hash = jhash2((u32 *)key,
-		      offsetof(typeof(*key), both.offset) / sizeof(u32),
+	hash = jhash2((u32 *)key, offsetof(typeof(*key), both.offset) / sizeof(u32),
 		      key->both.offset);
 
 	if (node == FUTEX_NO_NODE) {
@@ -441,8 +438,7 @@ __futex_hash(union futex_key *key, struct futex_private_hash *fph)
 		 */
 		node = (hash >> futex_hashshift) % nr_node_ids;
 		if (!node_possible(node)) {
-			node = find_next_bit_wrap(node_possible_map.bits,
-						  nr_node_ids, node);
+			node = find_next_bit_wrap(node_possible_map.bits, nr_node_ids, node);
 		}
 	}
 
@@ -459,9 +455,8 @@ __futex_hash(union futex_key *key, struct futex_private_hash *fph)
  * Return: Initialized hrtimer_sleeper structure or NULL if no timeout
  *	   value given
  */
-struct hrtimer_sleeper *
-futex_setup_timer(ktime_t *time, struct hrtimer_sleeper *timeout,
-		  int flags, u64 range_ns)
+struct hrtimer_sleeper *futex_setup_timer(ktime_t *time, struct hrtimer_sleeper *timeout,
+					  int flags, u64 range_ns)
 {
 	if (!time)
 		return NULL;
@@ -1584,17 +1579,17 @@ static void __futex_ref_atomic_begin(struct futex_private_hash *fph)
 	 * otherwise it would be impossible for it to have reported success
 	 * from futex_ref_is_dead().
 	 */
-	WARN_ON_ONCE(atomic_long_read(&mm->futex_atomic) != 0);
+	WARN_ON_ONCE(atomic_long_read(&mm->futex.phash.atomic) != 0);
 
 	/*
 	 * Set the atomic to the bias value such that futex_ref_{get,put}()
 	 * will never observe 0. Will be fixed up in __futex_ref_atomic_end()
 	 * when folding in the percpu count.
 	 */
-	atomic_long_set(&mm->futex_atomic, LONG_MAX);
+	atomic_long_set(&mm->futex.phash.atomic, LONG_MAX);
 	smp_store_release(&fph->state, FR_ATOMIC);
 
-	call_rcu_hurry(&mm->futex_rcu, futex_ref_rcu);
+	call_rcu_hurry(&mm->futex.phash.rcu, futex_ref_rcu);
 }
 
 static void __futex_ref_atomic_end(struct futex_private_hash *fph)
@@ -1615,7 +1610,7 @@ static void __futex_ref_atomic_end(struct futex_private_hash *fph)
 	 * Therefore the per-cpu counter is now stable, sum and reset.
 	 */
 	for_each_possible_cpu(cpu) {
-		unsigned int *ptr = per_cpu_ptr(mm->futex_ref, cpu);
+		unsigned int *ptr = per_cpu_ptr(mm->futex.phash.ref, cpu);
 		count += *ptr;
 		*ptr = 0;
 	}
@@ -1623,7 +1618,7 @@ static void __futex_ref_atomic_end(struct futex_private_hash *fph)
 	/*
 	 * Re-init for the next cycle.
 	 */
-	this_cpu_inc(*mm->futex_ref); /* 0 -> 1 */
+	this_cpu_inc(*mm->futex.phash.ref); /* 0 -> 1 */
 
 	/*
 	 * Add actual count, subtract bias and initial refcount.
@@ -1631,7 +1626,7 @@ static void __futex_ref_atomic_end(struct futex_private_hash *fph)
 	 * The moment this atomic operation happens, futex_ref_is_dead() can
 	 * become true.
 	 */
-	ret = atomic_long_add_return(count - LONG_MAX - 1, &mm->futex_atomic);
+	ret = atomic_long_add_return(count - LONG_MAX - 1, &mm->futex.phash.atomic);
 	if (!ret)
 		wake_up_var(mm);
 
@@ -1641,8 +1636,8 @@ static void __futex_ref_atomic_end(struct futex_private_hash *fph)
 
 static void futex_ref_rcu(struct rcu_head *head)
 {
-	struct mm_struct *mm = container_of(head, struct mm_struct, futex_rcu);
-	struct futex_private_hash *fph = rcu_dereference_raw(mm->futex_phash);
+	struct mm_struct *mm = container_of(head, struct mm_struct, futex.phash.rcu);
+	struct futex_private_hash *fph = rcu_dereference_raw(mm->futex.phash.hash);
 
 	if (fph->state == FR_PERCPU) {
 		/*
@@ -1671,7 +1666,7 @@ static void futex_ref_drop(struct futex_private_hash *fph)
 	/*
 	 * Can only transition the current fph;
 	 */
-	WARN_ON_ONCE(rcu_dereference_raw(mm->futex_phash) != fph);
+	WARN_ON_ONCE(rcu_dereference_raw(mm->futex.phash.hash) != fph);
 	/*
 	 * We enqueue at least one RCU callback. Ensure mm stays if the task
 	 * exits before the transition is completed.
@@ -1682,9 +1677,9 @@ static void futex_ref_drop(struct futex_private_hash *fph)
 	 * In order to avoid the following scenario:
 	 *
 	 * futex_hash()			__futex_pivot_hash()
-	 *   guard(rcu);		  guard(mm->futex_hash_lock);
-	 *   fph = mm->futex_phash;
-	 *				  rcu_assign_pointer(&mm->futex_phash, new);
+	 *   guard(rcu);		  guard(mm->futex.phash.lock);
+	 *   fph = mm->futex.phash.hash;
+	 *				  rcu_assign_pointer(&mm->futex.phash.hash, new);
 	 *				futex_hash_allocate()
 	 *				  futex_ref_drop()
 	 *				    fph->state = FR_ATOMIC;
@@ -1699,7 +1694,7 @@ static void futex_ref_drop(struct futex_private_hash *fph)
 	 * There must be at least one full grace-period between publishing a
 	 * new fph and trying to replace it.
 	 */
-	if (poll_state_synchronize_rcu(mm->futex_batches)) {
+	if (poll_state_synchronize_rcu(mm->futex.phash.batches)) {
 		/*
 		 * There was a grace-period, we can begin now.
 		 */
@@ -1707,7 +1702,7 @@ static void futex_ref_drop(struct futex_private_hash *fph)
 		return;
 	}
 
-	call_rcu_hurry(&mm->futex_rcu, futex_ref_rcu);
+	call_rcu_hurry(&mm->futex.phash.rcu, futex_ref_rcu);
 }
 
 static bool futex_ref_get(struct futex_private_hash *fph)
@@ -1717,11 +1712,11 @@ static bool futex_ref_get(struct futex_private_hash *fph)
 	guard(preempt)();
 
 	if (READ_ONCE(fph->state) == FR_PERCPU) {
-		__this_cpu_inc(*mm->futex_ref);
+		__this_cpu_inc(*mm->futex.phash.ref);
 		return true;
 	}
 
-	return atomic_long_inc_not_zero(&mm->futex_atomic);
+	return atomic_long_inc_not_zero(&mm->futex.phash.atomic);
 }
 
 static bool futex_ref_put(struct futex_private_hash *fph)
@@ -1731,11 +1726,11 @@ static bool futex_ref_put(struct futex_private_hash *fph)
 	guard(preempt)();
 
 	if (READ_ONCE(fph->state) == FR_PERCPU) {
-		__this_cpu_dec(*mm->futex_ref);
+		__this_cpu_dec(*mm->futex.phash.ref);
 		return false;
 	}
 
-	return atomic_long_dec_and_test(&mm->futex_atomic);
+	return atomic_long_dec_and_test(&mm->futex.phash.atomic);
 }
 
 static bool futex_ref_is_dead(struct futex_private_hash *fph)
@@ -1747,27 +1742,23 @@ static bool futex_ref_is_dead(struct futex_private_hash *fph)
 	if (smp_load_acquire(&fph->state) == FR_PERCPU)
 		return false;
 
-	return atomic_long_read(&mm->futex_atomic) == 0;
+	return atomic_long_read(&mm->futex.phash.atomic) == 0;
 }
 
 void futex_mm_init(struct mm_struct *mm)
 {
-	mutex_init(&mm->futex_hash_lock);
-	RCU_INIT_POINTER(mm->futex_phash, NULL);
-	mm->futex_phash_new = NULL;
-	/* futex-ref */
-	mm->futex_ref = NULL;
-	atomic_long_set(&mm->futex_atomic, 0);
-	mm->futex_batches = get_state_synchronize_rcu();
+	memset(&mm->futex, 0, sizeof(mm->futex));
+	mutex_init(&mm->futex.phash.lock);
+	mm->futex.phash.batches = get_state_synchronize_rcu();
 }
 
 void futex_hash_free(struct mm_struct *mm)
 {
 	struct futex_private_hash *fph;
 
-	free_percpu(mm->futex_ref);
-	kvfree(mm->futex_phash_new);
-	fph = rcu_dereference_raw(mm->futex_phash);
+	free_percpu(mm->futex.phash.ref);
+	kvfree(mm->futex.phash.hash_new);
+	fph = rcu_dereference_raw(mm->futex.phash.hash);
 	if (fph)
 		kvfree(fph);
 }
@@ -1778,10 +1769,10 @@ static bool futex_pivot_pending(struct mm_struct *mm)
 
 	guard(rcu)();
 
-	if (!mm->futex_phash_new)
+	if (!mm->futex.phash.hash_new)
 		return true;
 
-	fph = rcu_dereference(mm->futex_phash);
+	fph = rcu_dereference(mm->futex.phash.hash);
 	return futex_ref_is_dead(fph);
 }
 
@@ -1823,7 +1814,7 @@ static int futex_hash_allocate(unsigned int hash_slots, unsigned int flags)
 	 * Once we've disabled the global hash there is no way back.
 	 */
 	scoped_guard(rcu) {
-		fph = rcu_dereference(mm->futex_phash);
+		fph = rcu_dereference(mm->futex.phash.hash);
 		if (fph && !fph->hash_mask) {
 			if (custom)
 				return -EBUSY;
@@ -1831,15 +1822,15 @@ static int futex_hash_allocate(unsigned int hash_slots, unsigned int flags)
 		}
 	}
 
-	if (!mm->futex_ref) {
+	if (!mm->futex.phash.ref) {
 		/*
 		 * This will always be allocated by the first thread and
 		 * therefore requires no locking.
 		 */
-		mm->futex_ref = alloc_percpu(unsigned int);
-		if (!mm->futex_ref)
+		mm->futex.phash.ref = alloc_percpu(unsigned int);
+		if (!mm->futex.phash.ref)
 			return -ENOMEM;
-		this_cpu_inc(*mm->futex_ref); /* 0 -> 1 */
+		this_cpu_inc(*mm->futex.phash.ref); /* 0 -> 1 */
 	}
 
 	fph = kvzalloc(struct_size(fph, queues, hash_slots),
@@ -1862,14 +1853,14 @@ static int futex_hash_allocate(unsigned int hash_slots, unsigned int flags)
 		wait_var_event(mm, futex_pivot_pending(mm));
 	}
 
-	scoped_guard(mutex, &mm->futex_hash_lock) {
+	scoped_guard(mutex, &mm->futex.phash.lock) {
 		struct futex_private_hash *free __free(kvfree) = NULL;
 		struct futex_private_hash *cur, *new;
 
-		cur = rcu_dereference_protected(mm->futex_phash,
-						lockdep_is_held(&mm->futex_hash_lock));
-		new = mm->futex_phash_new;
-		mm->futex_phash_new = NULL;
+		cur = rcu_dereference_protected(mm->futex.phash.hash,
+						lockdep_is_held(&mm->futex.phash.lock));
+		new = mm->futex.phash.hash_new;
+		mm->futex.phash.hash_new = NULL;
 
 		if (fph) {
 			if (cur && !cur->hash_mask) {
@@ -1879,7 +1870,7 @@ static int futex_hash_allocate(unsigned int hash_slots, unsigned int flags)
 				 * the second one returns here.
 				 */
 				free = fph;
-				mm->futex_phash_new = new;
+				mm->futex.phash.hash_new = new;
 				return -EBUSY;
 			}
 			if (cur && !new) {
@@ -1909,7 +1900,7 @@ static int futex_hash_allocate(unsigned int hash_slots, unsigned int flags)
 
 		if (new) {
 			/*
-			 * Will set mm->futex_phash_new on failure;
+			 * Will set mm->futex.phash.new_hash on failure;
 			 * futex_private_hash_get() will try again.
 			 */
 			if (!__futex_pivot_hash(mm, new) && custom)
@@ -1928,11 +1919,9 @@ int futex_hash_allocate_default(void)
 		return 0;
 
 	scoped_guard(rcu) {
-		threads = min_t(unsigned int,
-				get_nr_threads(current),
-				num_online_cpus());
+		threads = min_t(unsigned int, get_nr_threads(current), num_online_cpus());
 
-		fph = rcu_dereference(current->mm->futex_phash);
+		fph = rcu_dereference(current->mm->futex.phash.hash);
 		if (fph) {
 			if (fph->custom)
 				return 0;
@@ -1959,7 +1948,7 @@ static int futex_hash_get_slots(void)
 	struct futex_private_hash *fph;
 
 	guard(rcu)();
-	fph = rcu_dereference(current->mm->futex_phash);
+	fph = rcu_dereference(current->mm->futex.phash.hash);
 	if (fph && fph->hash_mask)
 		return fph->hash_mask + 1;
 	return 0;
-- 
2.53.0

