Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBAF383320
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 18:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788461261; cv=none; b=QUYf89Yl6pMHTxfm8078uY09c7vycw1GWxkC6vQdMpLIAxQARWqnOfZDfMAnhkIJoMJwzE6L7yDlSEpYWqsRgujIVd0+jDPzTkFtBf8WTUyyvigFhkdofoPQgjpT1/zYE7RcJ6cAyZUa5AYg48IbWKhX2uVOdQdtluPJnSumZpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788461261; c=relaxed/simple;
	bh=6M+u0RiCSX+RrjNHu1z+Zh8ApuG+FiTcPeOcVW7pFmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qf155nrB+NiFRS5O730ghgrgxzNx4tZUckRUk+8WJ3jJ2VuTeCfk9E5VVTFXO0SFUUwAYm5hEBrtffrAgIuwboOuLct0EnPAjR+h0oPWOIJ1sA4Rar/uD0kX7pGhY46GpHkI5vau8xdzShuz9e48lXR3AoLS4smZHCdt9yYeHW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8zESjcb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8zESjcb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A35F1F00ACF;
	Thu,  3 Sep 2026 18:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788461260;
	bh=tjfRO5KFtOqM28OREbvR6bbnFwBE2TBqaOT5ykWkqb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z8zESjcbdkv/A5LjjtQ+FJj7WKP4rG8WVCOnsR23KTK+bQK1itqJvnQhy318ayiMo
	 ZJDqKP1W6QsGe+xhgOgC54XK58udSG9a4fCR53N4b+ECoj7VerdsQzp0ul/Wikff5I
	 dKURY82Cj0YQ2riqI8oRU/qEhgRe1sYe0fThPYdo2JSDCh2pI3CsG9v7tCrr5cByUE
	 c+tJqC4gnBFplHNfg1MY6ZZFMn1bZeYmJPjnowtboJNK6N7nQNOvRgEP2Qv7Ujzlzv
	 NSzcO/UXvVtXIxbot0oqhd3g+rallu2J8Oe0BnFA92W6e8zOe3I1hY7VabRNI+JMh6
	 V7gXsZJ9k3cOQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"ke.wang" <ke.wang@unisoc.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Zhaoyang Huang <huangzhaoyang@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 5/7] mm: use stack_depot for recording kmemleak's backtrace
Date: Thu,  3 Sep 2026 14:47:31 -0400
Message-ID: <20260903184733.1484444-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903184733.1484444-1-sashal@kernel.org>
References: <2026090333-boney-opium-0272@gregkh>
 <20260903184733.1484444-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

[ Upstream commit 56a61617dd2276cbc56a6c868599716386d70041 ]

Using stack_depot to record kmemleak's backtrace which has been
implemented on slub for reducing redundant information.

[akpm@linux-foundation.org: fix build - remove now-unused __save_stack_trace()]
[zhaoyang.huang@unisoc.com: v3]
  Link: https://lkml.kernel.org/r/1667101354-4669-1-git-send-email-zhaoyang.huang@unisoc.com
[akpm@linux-foundation.org: fix v3 layout oddities]
[akpm@linux-foundation.org: coding-style cleanups]
Link: https://lkml.kernel.org/r/1666864224-27541-1-git-send-email-zhaoyang.huang@unisoc.com
Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: ke.wang <ke.wang@unisoc.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Zhaoyang Huang <huangzhaoyang@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 5d10d4e19e6d ("mm/kmemleak: avoid soft lockup when scanning task stacks")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/Kconfig.debug |   1 +
 mm/kmemleak.c     | 141 +++++++++++++++++++++++++---------------------
 2 files changed, 79 insertions(+), 63 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 6749581d920e8..8dc542107bde5 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -718,6 +718,7 @@ config DEBUG_KMEMLEAK
 	select STACKTRACE if STACKTRACE_SUPPORT
 	select KALLSYMS
 	select CRC32
+	select STACKDEPOT
 	help
 	  Say Y here if you want to enable the memory leak
 	  detector. The memory allocation/freeing is traced in a way
diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index b4d7c1deedc17..6c26262aac844 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -13,11 +13,11 @@
  *
  * The following locks and mutexes are used by kmemleak:
  *
- * - kmemleak_lock (raw_spinlock_t): protects the object_list modifications and
- *   accesses to the object_tree_root. The object_list is the main list
- *   holding the metadata (struct kmemleak_object) for the allocated memory
- *   blocks. The object_tree_root is a red black tree used to look-up
- *   metadata based on a pointer to the corresponding memory block.  The
+ * - kmemleak_lock (raw_spinlock_t): protects the object_list and del_state
+ *   modifications as well as accesses to the object_tree_root. The object_list
+ *   is the main list holding the metadata (struct kmemleak_object) for the
+ *   allocated memory blocks. The object_tree_root is a red black tree used to
+ *   look-up metadata based on a pointer to the corresponding memory block. The
  *   kmemleak_object structures are added to the object_list and
  *   object_tree_root in the create_object() function called from the
  *   kmemleak_alloc() callback and removed in delete_object() called from the
@@ -77,6 +77,7 @@
 #include <linux/mutex.h>
 #include <linux/rcupdate.h>
 #include <linux/stacktrace.h>
+#include <linux/stackdepot.h>
 #include <linux/cache.h>
 #include <linux/percpu.h>
 #include <linux/memblock.h>
@@ -145,6 +146,7 @@ struct kmemleak_object {
 	struct rcu_head rcu;		/* object_list lockless traversal */
 	/* object usage count; object freed when use_count == 0 */
 	atomic_t use_count;
+	unsigned int del_state;		/* deletion state */
 	unsigned long pointer;
 	size_t size;
 	/* pass surplus references to this pointer */
@@ -157,8 +159,7 @@ struct kmemleak_object {
 	u32 checksum;
 	/* memory ranges to be scanned inside an object (empty for all) */
 	struct hlist_head area_list;
-	unsigned long trace[MAX_TRACE];
-	unsigned int trace_len;
+	depot_stack_handle_t trace_handle;
 	unsigned long jiffies;		/* creation timestamp */
 	pid_t pid;			/* pid of the current task */
 	char comm[TASK_COMM_LEN];	/* executable name */
@@ -173,6 +174,11 @@ struct kmemleak_object {
 /* flag set to fully scan the object when scan_area allocation failed */
 #define OBJECT_FULL_SCAN	(1 << 3)
 
+/* set when __remove_object() called */
+#define DELSTATE_REMOVED	(1 << 0)
+/* set to temporarily prevent deletion from object_list */
+#define DELSTATE_NO_DELETE	(1 << 1)
+
 #define HEX_PREFIX		"    "
 /* number of bytes to print per line; must be 16 or 32 */
 #define HEX_ROW_SIZE		16
@@ -337,18 +343,21 @@ static void print_unreferenced(struct seq_file *seq,
 			       struct kmemleak_object *object)
 {
 	int i;
+	unsigned long *entries;
+	unsigned int nr_entries;
 	unsigned int msecs_age = jiffies_to_msecs(jiffies - object->jiffies);
 
+	nr_entries = stack_depot_fetch(object->trace_handle, &entries);
 	warn_or_seq_printf(seq, "unreferenced object 0x%08lx (size %zu):\n",
-		   object->pointer, object->size);
+			  object->pointer, object->size);
 	warn_or_seq_printf(seq, "  comm \"%s\", pid %d, jiffies %lu (age %d.%03ds)\n",
-		   object->comm, object->pid, object->jiffies,
-		   msecs_age / 1000, msecs_age % 1000);
+			   object->comm, object->pid, object->jiffies,
+			   msecs_age / 1000, msecs_age % 1000);
 	hex_dump_object(seq, object);
 	warn_or_seq_printf(seq, "  backtrace:\n");
 
-	for (i = 0; i < object->trace_len; i++) {
-		void *ptr = (void *)object->trace[i];
+	for (i = 0; i < nr_entries; i++) {
+		void *ptr = (void *)entries[i];
 		warn_or_seq_printf(seq, "    [<%p>] %pS\n", ptr, ptr);
 	}
 }
@@ -360,16 +369,22 @@ static void print_unreferenced(struct seq_file *seq,
  */
 static void dump_object_info(struct kmemleak_object *object)
 {
+	unsigned long *entries;
+	unsigned int nr_entries;
+
 	pr_notice("Object 0x%08lx (size %zu):\n",
-		  object->pointer, object->size);
+			object->pointer, object->size);
 	pr_notice("  comm \"%s\", pid %d, jiffies %lu\n",
-		  object->comm, object->pid, object->jiffies);
+			object->comm, object->pid, object->jiffies);
 	pr_notice("  min_count = %d\n", object->min_count);
 	pr_notice("  count = %d\n", object->count);
 	pr_notice("  flags = 0x%x\n", object->flags);
 	pr_notice("  checksum = %u\n", object->checksum);
 	pr_notice("  backtrace:\n");
-	stack_trace_print(object->trace, object->trace_len, 4);
+	if (object->trace_handle) {
+		nr_entries = stack_depot_fetch(object->trace_handle, &entries);
+		stack_trace_print(entries, nr_entries, 4);
+	}
 }
 
 /*
@@ -538,7 +553,9 @@ static struct kmemleak_object *find_and_get_object(unsigned long ptr, int alias)
 static void __remove_object(struct kmemleak_object *object)
 {
 	rb_erase(&object->rb_node, &object_tree_root);
-	list_del_rcu(&object->object_list);
+	if (!(object->del_state & DELSTATE_NO_DELETE))
+		list_del_rcu(&object->object_list);
+	object->del_state |= DELSTATE_REMOVED;
 }
 
 /*
@@ -560,12 +577,18 @@ static struct kmemleak_object *find_and_remove_object(unsigned long ptr, int ali
 	return object;
 }
 
-/*
- * Save stack trace to the given array of MAX_TRACE size.
- */
-static int __save_stack_trace(unsigned long *trace)
+static noinline depot_stack_handle_t __save_stack_trace(void)
 {
-	return stack_trace_save(trace, MAX_TRACE, 2);
+	depot_stack_handle_t trace_handle;
+	unsigned long entries[MAX_TRACE];
+	unsigned int nr_entries;
+
+	if (!kmemleak_initialized)
+		return 0;
+	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 3);
+	trace_handle = stack_depot_save(entries, nr_entries, GFP_NOWAIT);
+
+	return trace_handle;
 }
 
 /*
@@ -600,6 +623,7 @@ static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
 	object->count = 0;			/* white color initially */
 	object->jiffies = jiffies;
 	object->checksum = 0;
+	object->del_state = 0;
 
 	/* task information */
 	if (in_hardirq()) {
@@ -620,7 +644,7 @@ static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
 	}
 
 	/* kernel backtrace */
-	object->trace_len = __save_stack_trace(object->trace);
+	object->trace_handle = __save_stack_trace();
 
 	raw_spin_lock_irqsave(&kmemleak_lock, flags);
 
@@ -651,7 +675,6 @@ static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
 	}
 	rb_link_node(&object->rb_node, rb_parent, link);
 	rb_insert_color(&object->rb_node, &object_tree_root);
-
 	list_add_tail_rcu(&object->object_list, &object_list);
 out:
 	raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
@@ -1037,7 +1060,7 @@ void __ref kmemleak_update_trace(const void *ptr)
 	}
 
 	raw_spin_lock_irqsave(&object->lock, flags);
-	object->trace_len = __save_stack_trace(object->trace);
+	object->trace_handle = __save_stack_trace();
 	raw_spin_unlock_irqrestore(&object->lock, flags);
 
 	put_object(object);
@@ -1405,28 +1428,38 @@ static void scan_gray_list(void)
 /*
  * Conditionally call resched() in a object iteration loop while making sure
  * that the given object won't go away without RCU read lock by performing a
- * get_object() if !pinned.
- *
- * Return: false if can't do a cond_resched() due to get_object() failure
- *	   true otherwise
+ * get_object() if necessary.
  */
-static bool kmemleak_cond_resched(struct kmemleak_object *object, bool pinned)
+static void kmemleak_cond_resched(struct kmemleak_object *object)
 {
-	if (!pinned && !get_object(object))
-		return false;
+	if (!get_object(object))
+		return;	/* Try next object */
+
+	raw_spin_lock_irq(&kmemleak_lock);
+	if (object->del_state & DELSTATE_REMOVED)
+		goto unlock_put;	/* Object removed */
+	object->del_state |= DELSTATE_NO_DELETE;
+	raw_spin_unlock_irq(&kmemleak_lock);
 
 	rcu_read_unlock();
 	cond_resched();
 	rcu_read_lock();
-	if (!pinned)
-		put_object(object);
-	return true;
+
+	raw_spin_lock_irq(&kmemleak_lock);
+	if (object->del_state & DELSTATE_REMOVED)
+		list_del_rcu(&object->object_list);
+	object->del_state &= ~DELSTATE_NO_DELETE;
+unlock_put:
+	raw_spin_unlock_irq(&kmemleak_lock);
+	put_object(object);
 }
 
 /*
- * Scan data sections and all the referenced memory blocks allocated via the
- * kernel's standard allocators. This function must be called with the
- * scan_mutex held.
+ * Print one leak inline. The hex dump is gated on OBJECT_ALLOCATED so it
+ * does not touch user memory that was freed concurrently; the rest of the
+ * report is emitted directly by kmemleak_scan() while the object metadata is
+ * protected. kmemleak_scan() scans data sections and referenced allocations
+ * and must be called with scan_mutex held.
  */
 static void kmemleak_scan(void)
 {
@@ -1434,15 +1467,12 @@ static void kmemleak_scan(void)
 	struct zone *zone;
 	int __maybe_unused i;
 	int new_leaks = 0;
-	int loop_cnt = 0;
 
 	jiffies_last_scan = jiffies;
 
 	/* prepare the kmemleak_object's */
 	rcu_read_lock();
 	list_for_each_entry_rcu(object, &object_list, object_list) {
-		bool obj_pinned = false;
-
 		raw_spin_lock_irq(&object->lock);
 #ifdef DEBUG
 		/*
@@ -1457,19 +1487,13 @@ static void kmemleak_scan(void)
 #endif
 		/* reset the reference count (whiten the object) */
 		object->count = 0;
-		if (color_gray(object) && get_object(object)) {
+		if (color_gray(object) && get_object(object))
 			list_add_tail(&object->gray_list, &gray_list);
-			obj_pinned = true;
-		}
 
 		raw_spin_unlock_irq(&object->lock);
 
-		/*
-		 * Do a cond_resched() every 64k objects to avoid soft lockup.
-		 */
-		if (!(++loop_cnt & 0xffff) &&
-		    !kmemleak_cond_resched(object, obj_pinned))
-			loop_cnt--; /* Try again on next object */
+		if (need_resched())
+			kmemleak_cond_resched(object);
 	}
 	rcu_read_unlock();
 
@@ -1536,14 +1560,9 @@ static void kmemleak_scan(void)
 	 * scan and color them gray until the next scan.
 	 */
 	rcu_read_lock();
-	loop_cnt = 0;
 	list_for_each_entry_rcu(object, &object_list, object_list) {
-		/*
-		 * Do a cond_resched() every 64k objects to avoid soft lockup.
-		 */
-		if (!(++loop_cnt & 0xffff) &&
-		    !kmemleak_cond_resched(object, false))
-			loop_cnt--;	/* Try again on next object */
+		if (need_resched())
+			kmemleak_cond_resched(object);
 
 		/*
 		 * This is racy but we can save the overhead of lock/unlock
@@ -1578,14 +1597,9 @@ static void kmemleak_scan(void)
 	 * Scanning result reporting.
 	 */
 	rcu_read_lock();
-	loop_cnt = 0;
 	list_for_each_entry_rcu(object, &object_list, object_list) {
-		/*
-		 * Do a cond_resched() every 64k objects to avoid soft lockup.
-		 */
-		if (!(++loop_cnt & 0xffff) &&
-		    !kmemleak_cond_resched(object, false))
-			loop_cnt--;	/* Try again on next object */
+		if (need_resched())
+			kmemleak_cond_resched(object);
 
 		/*
 		 * This is racy but we can save the overhead of lock/unlock
@@ -2020,6 +2034,7 @@ void __init kmemleak_init(void)
 	if (kmemleak_error)
 		return;
 
+	stack_depot_init();
 	jiffies_min_age = msecs_to_jiffies(MSECS_MIN_AGE);
 	jiffies_scan_wait = msecs_to_jiffies(SECS_SCAN_WAIT * 1000);
 
-- 
2.53.0

