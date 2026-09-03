Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0A62D7DEA
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 22:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788474694; cv=none; b=WFdkKn5h8joimhyjHy+MAUKpctOPg+2qckYPZTT9VVCMxEXHLCs5xhiuNzQwPyAw7mjljyP9FyTlkixMAgWXk7W5r648bG7+pVuJ8cdVLlBOL4uJGI3pAeZN7bueDCcNSIAZ8yVW/uELjQfTI+jsJnpKtJLITpa8VusMnLWQ/do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788474694; c=relaxed/simple;
	bh=m5cmqOn7Y+6+zv0TEFUUvCtMTTXi81VolQN0WaTOdXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cnRYvyF1fOoZq8wEG6lesBVhHAMbymxvislySI3MloH1B6Cy3enMtFQc+VKHGwC4kZVPp0P9dcO7CE3EPnGG8NV0VMVxaRdJmSk3BHSw2kiQeq7E98UzQesRT9OMXL2jvyvdGcN2aS91St3qphVzc97pzUi4WPqFgtUzNynKt94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KpEt88Gd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KpEt88Gd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F26E51F00A3D;
	Thu,  3 Sep 2026 22:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788474692;
	bh=njuFQWpVQlXfKkc7SehVIi4YmCCIy2oIUfwS49cHqwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KpEt88Gd9RoU/ogHN9QKw6QFrfyK4hjmRB2nGzAADkTxn+6cb/5pjWCy7thybSJe8
	 z0yk5G2JPh8ChZzFz+p4J/QX77GbNnjxfhg2bowrGsSDV4LhZny7bQ7omAjr9l2l6V
	 MzbIHpn7T8ySisodLHluhnkYgtt4fM3ibEqXdwd2UG75wEtxr/4YjbGPyaNLBN9bUu
	 mkHFxaMMaZ8NaxRIIxIu3/cKSZ8/kfUtadq0dIUiQ5/QGRbyEXpFS9hR4lhYBCl4ko
	 4ZCfH43K8cXdtOoe5N8uviKMJ81Q21SmVgzc5hNzjZUwbqX/gDnejxAeeJCpC+x9/G
	 A0ls6kR5b1ZzA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Waiman Long <longman@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/4] kmemleak: avoid RCU stalls when freeing metadata for per-CPU pointers
Date: Thu,  3 Sep 2026 18:31:27 -0400
Message-ID: <20260903223129.1741728-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903223129.1741728-1-sashal@kernel.org>
References: <2026090345-kabob-hardcopy-cdf7@gregkh>
 <20260903223129.1741728-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Catalin Marinas <catalin.marinas@arm.com>

[ Upstream commit 39042079a0c241d09fa6fc3bb67c2ddf60011d0f ]

On systems with large number of CPUs, the following soft lockup splat
might sometimes happen:

[ 2656.001617] watchdog: BUG: soft lockup - CPU#364 stuck for 21s! [ksoftirqd/364:2206]
  :
[ 2656.141194] RIP: 0010:_raw_spin_unlock_irqrestore+0x3d/0x70
  :
 2656.241214] Call Trace:
[ 2656.243971]  <IRQ>
[ 2656.246237]  ? show_trace_log_lvl+0x1c4/0x2df
[ 2656.251152]  ? show_trace_log_lvl+0x1c4/0x2df
[ 2656.256066]  ? kmemleak_free_percpu+0x11f/0x1f0
[ 2656.261173]  ? watchdog_timer_fn+0x379/0x470
[ 2656.265984]  ? __pfx_watchdog_timer_fn+0x10/0x10
[ 2656.271179]  ? __hrtimer_run_queues+0x5f3/0xd00
[ 2656.276283]  ? __pfx___hrtimer_run_queues+0x10/0x10
[ 2656.281783]  ? ktime_get_update_offsets_now+0x95/0x2c0
[ 2656.287573]  ? ktime_get_update_offsets_now+0xdd/0x2c0
[ 2656.293380]  ? hrtimer_interrupt+0x2e9/0x780
[ 2656.298221]  ? __sysvec_apic_timer_interrupt+0x184/0x640
[ 2656.304211]  ? sysvec_apic_timer_interrupt+0x8e/0xc0
[ 2656.309807]  </IRQ>
[ 2656.312169]  <TASK>
[ 2656.326110]  kmemleak_free_percpu+0x11f/0x1f0
[ 2656.331015]  free_percpu.part.0+0x1b/0xe70
[ 2656.335635]  free_vfsmnt+0xb9/0x100
[ 2656.339567]  rcu_do_batch+0x3c8/0xe30
[ 2656.363693]  rcu_core+0x3de/0x5a0
[ 2656.367433]  __do_softirq+0x2d0/0x9a8
[ 2656.381119]  run_ksoftirqd+0x36/0x60
[ 2656.385145]  smpboot_thread_fn+0x556/0x910
[ 2656.394971]  kthread+0x2a4/0x350
[ 2656.402826]  ret_from_fork+0x29/0x50
[ 2656.406861]  </TASK>

The issue is caused by kmemleak registering each per_cpu_ptr()
corresponding to the __percpu pointer.  This is unnecessary since such
individual per-CPU pointers are not tracked anyway.  Create a new
object_percpu_tree_root rbtree that stores a single __percpu pointer
together with an OBJECT_PERCPU flag for the kmemleak metadata.  Scanning
needs to be done for all per_cpu_ptr() pointers with a cond_resched()
between each CPU iteration to avoid RCU stalls.

[catalin.marinas@arm.com: update comment]
  Link: https://lkml.kernel.org/r/20231206114414.2085824-1-catalin.marinas@arm.com
  Link: https://lore.kernel.org/r/20231127194153.289626-1-longman@redhat.comLink: https://lkml.kernel.org/r/20231201190829.825856-1-catalin.marinas@arm.com
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Reported-by: Waiman Long <longman@redhat.com>
Closes: https://lore.kernel.org/r/20231127194153.289626-1-longman@redhat.com
Reviewed-by: Waiman Long <longman@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 3541a2b06ecd ("mm/kmemleak: report RCU-tasks quiescent states during the scan")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/kmemleak.c | 174 ++++++++++++++++++++++++++++----------------------
 1 file changed, 99 insertions(+), 75 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index b6e57e344bd6e..91edbc95a1c0f 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -14,17 +14,15 @@
  * The following locks and mutexes are used by kmemleak:
  *
  * - kmemleak_lock (raw_spinlock_t): protects the object_list as well as
- *   del_state modifications and accesses to the object_tree_root (or
- *   object_phys_tree_root). The object_list is the main list holding the
- *   metadata (struct kmemleak_object) for the allocated memory blocks.
- *   The object_tree_root and object_phys_tree_root are red
- *   black trees used to look-up metadata based on a pointer to the
- *   corresponding memory block. The object_phys_tree_root is for objects
- *   allocated with physical address. The kmemleak_object structures are
- *   added to the object_list and object_tree_root (or object_phys_tree_root)
- *   in the create_object() function called from the kmemleak_alloc() (or
- *   kmemleak_alloc_phys()) callback and removed in delete_object() called from
- *   the kmemleak_free() callback
+ *   del_state modifications and accesses to the object trees
+ *   (object_tree_root, object_phys_tree_root, object_percpu_tree_root). The
+ *   object_list is the main list holding the metadata (struct
+ *   kmemleak_object) for the allocated memory blocks. The object trees are
+ *   red black trees used to look-up metadata based on a pointer to the
+ *   corresponding memory block. The kmemleak_object structures are added to
+ *   the object_list and the object tree root in the create_object() function
+ *   called from the kmemleak_alloc{,_phys,_percpu}() callback and removed in
+ *   delete_object() called from the kmemleak_free{,_phys,_percpu}() callback
  * - kmemleak_object.lock (raw_spinlock_t): protects a kmemleak_object.
  *   Accesses to the metadata (e.g. count) are protected by this lock. Note
  *   that some members of this structure may be protected by other means
@@ -178,6 +176,8 @@ struct kmemleak_object {
 #define OBJECT_FULL_SCAN	(1 << 3)
 /* flag set for object allocated with physical address */
 #define OBJECT_PHYS		(1 << 4)
+/* flag set for per-CPU pointers */
+#define OBJECT_PERCPU		(1 << 5)
 
 /* set when __remove_object() called */
 #define DELSTATE_REMOVED	(1 << 0)
@@ -206,6 +206,8 @@ static LIST_HEAD(mem_pool_free_list);
 static struct rb_root object_tree_root = RB_ROOT;
 /* search tree for object (with OBJECT_PHYS flag) boundaries */
 static struct rb_root object_phys_tree_root = RB_ROOT;
+/* search tree for object (with OBJECT_PERCPU flag) boundaries */
+static struct rb_root object_percpu_tree_root = RB_ROOT;
 /* protecting the access to object_list, object_tree_root (or object_phys_tree_root) */
 static DEFINE_RAW_SPINLOCK(kmemleak_lock);
 
@@ -298,7 +300,7 @@ static void hex_dump_object(struct seq_file *seq,
 	const u8 *ptr = (const u8 *)object->pointer;
 	size_t len;
 
-	if (WARN_ON_ONCE(object->flags & OBJECT_PHYS))
+	if (WARN_ON_ONCE(object->flags & (OBJECT_PHYS | OBJECT_PERCPU)))
 		return;
 
 	/* limit the number of lines to HEX_MAX_LINES */
@@ -397,12 +399,18 @@ static void dump_object_info(struct kmemleak_object *object)
  * when calling this function.
  */
 static struct kmemleak_object *__lookup_object(unsigned long ptr, int alias,
-					       bool is_phys)
+					       unsigned int objflags)
 {
-	struct rb_node *rb = is_phys ? object_phys_tree_root.rb_node :
-			     object_tree_root.rb_node;
+	struct rb_node *rb;
 	unsigned long untagged_ptr = (unsigned long)kasan_reset_tag((void *)ptr);
 
+	if (objflags & OBJECT_PHYS)
+		rb = object_phys_tree_root.rb_node;
+	else if (objflags & OBJECT_PERCPU)
+		rb = object_percpu_tree_root.rb_node;
+	else
+		rb = object_tree_root.rb_node;
+
 	while (rb) {
 		struct kmemleak_object *object;
 		unsigned long untagged_objp;
@@ -429,7 +437,7 @@ static struct kmemleak_object *__lookup_object(unsigned long ptr, int alias,
 /* Look-up a kmemleak object which allocated with virtual address. */
 static struct kmemleak_object *lookup_object(unsigned long ptr, int alias)
 {
-	return __lookup_object(ptr, alias, false);
+	return __lookup_object(ptr, alias, 0);
 }
 
 /*
@@ -545,14 +553,14 @@ static void put_object(struct kmemleak_object *object)
  * Look up an object in the object search tree and increase its use_count.
  */
 static struct kmemleak_object *__find_and_get_object(unsigned long ptr, int alias,
-						     bool is_phys)
+						     unsigned int objflags)
 {
 	unsigned long flags;
 	struct kmemleak_object *object;
 
 	rcu_read_lock();
 	raw_spin_lock_irqsave(&kmemleak_lock, flags);
-	object = __lookup_object(ptr, alias, is_phys);
+	object = __lookup_object(ptr, alias, objflags);
 	raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
 
 	/* check whether the object is still available */
@@ -566,38 +574,42 @@ static struct kmemleak_object *__find_and_get_object(unsigned long ptr, int alia
 /* Look up and get an object which allocated with virtual address. */
 static struct kmemleak_object *find_and_get_object(unsigned long ptr, int alias)
 {
-	return __find_and_get_object(ptr, alias, false);
+	return __find_and_get_object(ptr, alias, 0);
 }
 
 /*
- * Remove an object from the object_tree_root (or object_phys_tree_root)
- * and object_list. Must be called with the kmemleak_lock held _if_ kmemleak
- * is still enabled.
+ * Remove an object from its object tree and object_list. Must be called with
+ * the kmemleak_lock held _if_ kmemleak is still enabled.
  */
 static void __remove_object(struct kmemleak_object *object)
 {
-	rb_erase(&object->rb_node, object->flags & OBJECT_PHYS ?
-				   &object_phys_tree_root :
-				   &object_tree_root);
+	struct rb_root *root;
+
+	if (object->flags & OBJECT_PHYS)
+		root = &object_phys_tree_root;
+	else if (object->flags & OBJECT_PERCPU)
+		root = &object_percpu_tree_root;
+	else
+		root = &object_tree_root;
+	rb_erase(&object->rb_node, root);
 	if (!(object->del_state & DELSTATE_NO_DELETE))
 		list_del_rcu(&object->object_list);
 	object->del_state |= DELSTATE_REMOVED;
 }
 
 /*
- * Look up an object in the object search tree and remove it from both
- * object_tree_root (or object_phys_tree_root) and object_list. The
- * returned object's use_count should be at least 1, as initially set
- * by create_object().
+ * Look up an object in the object search tree and remove it from both object
+ * tree root and object_list. The returned object's use_count should be at
+ * least 1, as initially set by create_object().
  */
 static struct kmemleak_object *find_and_remove_object(unsigned long ptr, int alias,
-						      bool is_phys)
+						      unsigned int objflags)
 {
 	unsigned long flags;
 	struct kmemleak_object *object;
 
 	raw_spin_lock_irqsave(&kmemleak_lock, flags);
-	object = __lookup_object(ptr, alias, is_phys);
+	object = __lookup_object(ptr, alias, objflags);
 	if (object)
 		__remove_object(object);
 	raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
@@ -630,10 +642,11 @@ static noinline depot_stack_handle_t set_track_prepare(void)
  * object_phys_tree_root).
  */
 static void __create_object(unsigned long ptr, size_t size,
-			    int min_count, gfp_t gfp, bool is_phys)
+			    int min_count, gfp_t gfp, unsigned int objflags)
 {
 	unsigned long flags;
 	struct kmemleak_object *object, *parent;
+	struct rb_root *root;
 	struct rb_node **link, *rb_parent;
 	unsigned long untagged_ptr;
 	unsigned long untagged_objp;
@@ -650,7 +663,7 @@ static void __create_object(unsigned long ptr, size_t size,
 	INIT_HLIST_HEAD(&object->area_list);
 	raw_spin_lock_init(&object->lock);
 	atomic_set(&object->use_count, 1);
-	object->flags = OBJECT_ALLOCATED | (is_phys ? OBJECT_PHYS : 0);
+	object->flags = OBJECT_ALLOCATED | objflags;
 	object->pointer = ptr;
 	object->size = kfence_ksize((void *)ptr) ?: size;
 	object->excess_ref = 0;
@@ -688,12 +701,17 @@ static void __create_object(unsigned long ptr, size_t size,
 	 * Only update min_addr and max_addr with object
 	 * storing virtual address.
 	 */
-	if (!is_phys) {
+	if (!(objflags & (OBJECT_PHYS | OBJECT_PERCPU))) {
 		min_addr = min(min_addr, untagged_ptr);
 		max_addr = max(max_addr, untagged_ptr + size);
 	}
-	link = is_phys ? &object_phys_tree_root.rb_node :
-		&object_tree_root.rb_node;
+	if (objflags & OBJECT_PHYS)
+		root = &object_phys_tree_root;
+	else if (objflags & OBJECT_PERCPU)
+		root = &object_percpu_tree_root;
+	else
+		root = &object_tree_root;
+	link = &root->rb_node;
 	rb_parent = NULL;
 	while (*link) {
 		rb_parent = *link;
@@ -716,8 +734,7 @@ static void __create_object(unsigned long ptr, size_t size,
 		}
 	}
 	rb_link_node(&object->rb_node, rb_parent, link);
-	rb_insert_color(&object->rb_node, is_phys ? &object_phys_tree_root :
-					  &object_tree_root);
+	rb_insert_color(&object->rb_node, root);
 	list_add_tail_rcu(&object->object_list, &object_list);
 out:
 	raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
@@ -727,14 +744,14 @@ static void __create_object(unsigned long ptr, size_t size,
 static void create_object(unsigned long ptr, size_t size,
 			  int min_count, gfp_t gfp)
 {
-	__create_object(ptr, size, min_count, gfp, false);
+	__create_object(ptr, size, min_count, gfp, 0);
 }
 
 /* Create kmemleak object which allocated with physical address. */
 static void create_object_phys(unsigned long ptr, size_t size,
 			       int min_count, gfp_t gfp)
 {
-	__create_object(ptr, size, min_count, gfp, true);
+	__create_object(ptr, size, min_count, gfp, OBJECT_PHYS);
 }
 
 /*
@@ -761,11 +778,11 @@ static void __delete_object(struct kmemleak_object *object)
  * Look up the metadata (struct kmemleak_object) corresponding to ptr and
  * delete it.
  */
-static void delete_object_full(unsigned long ptr)
+static void delete_object_full(unsigned long ptr, unsigned int objflags)
 {
 	struct kmemleak_object *object;
 
-	object = find_and_remove_object(ptr, 0, false);
+	object = find_and_remove_object(ptr, 0, objflags);
 	if (!object) {
 #ifdef DEBUG
 		kmemleak_warn("Freeing unknown object at 0x%08lx\n",
@@ -781,12 +798,13 @@ static void delete_object_full(unsigned long ptr)
  * delete it. If the memory block is partially freed, the function may create
  * additional metadata for the remaining parts of the block.
  */
-static void delete_object_part(unsigned long ptr, size_t size, bool is_phys)
+static void delete_object_part(unsigned long ptr, size_t size,
+			       unsigned int objflags)
 {
 	struct kmemleak_object *object;
 	unsigned long start, end;
 
-	object = find_and_remove_object(ptr, 1, is_phys);
+	object = find_and_remove_object(ptr, 1, objflags);
 	if (!object) {
 #ifdef DEBUG
 		kmemleak_warn("Partially freeing unknown object at 0x%08lx (size %zu)\n",
@@ -804,10 +822,10 @@ static void delete_object_part(unsigned long ptr, size_t size, bool is_phys)
 	end = object->pointer + object->size;
 	if (ptr > start)
 		__create_object(start, ptr - start, object->min_count,
-			      GFP_KERNEL, is_phys);
+			      GFP_KERNEL, objflags);
 	if (ptr + size < end)
 		__create_object(ptr + size, end - ptr - size, object->min_count,
-			      GFP_KERNEL, is_phys);
+			      GFP_KERNEL, objflags);
 
 	__delete_object(object);
 }
@@ -828,11 +846,11 @@ static void paint_it(struct kmemleak_object *object, int color)
 	raw_spin_unlock_irqrestore(&object->lock, flags);
 }
 
-static void paint_ptr(unsigned long ptr, int color, bool is_phys)
+static void paint_ptr(unsigned long ptr, int color, unsigned int objflags)
 {
 	struct kmemleak_object *object;
 
-	object = __find_and_get_object(ptr, 0, is_phys);
+	object = __find_and_get_object(ptr, 0, objflags);
 	if (!object) {
 		kmemleak_warn("Trying to color unknown object at 0x%08lx as %s\n",
 			      ptr,
@@ -850,16 +868,16 @@ static void paint_ptr(unsigned long ptr, int color, bool is_phys)
  */
 static void make_gray_object(unsigned long ptr)
 {
-	paint_ptr(ptr, KMEMLEAK_GREY, false);
+	paint_ptr(ptr, KMEMLEAK_GREY, 0);
 }
 
 /*
  * Mark the object as black-colored so that it is ignored from scans and
  * reporting.
  */
-static void make_black_object(unsigned long ptr, bool is_phys)
+static void make_black_object(unsigned long ptr, unsigned int objflags)
 {
-	paint_ptr(ptr, KMEMLEAK_BLACK, is_phys);
+	paint_ptr(ptr, KMEMLEAK_BLACK, objflags);
 }
 
 /*
@@ -995,8 +1013,6 @@ EXPORT_SYMBOL_GPL(kmemleak_alloc);
 void __ref kmemleak_alloc_percpu(const void __percpu *ptr, size_t size,
 				 gfp_t gfp)
 {
-	unsigned int cpu;
-
 	pr_debug("%s(0x%p, %zu)\n", __func__, ptr, size);
 
 	/*
@@ -1004,9 +1020,8 @@ void __ref kmemleak_alloc_percpu(const void __percpu *ptr, size_t size,
 	 * (min_count is set to 0).
 	 */
 	if (kmemleak_enabled && ptr && !IS_ERR(ptr))
-		for_each_possible_cpu(cpu)
-			create_object((unsigned long)per_cpu_ptr(ptr, cpu),
-				      size, 0, gfp);
+		__create_object((unsigned long)ptr, size, 0, gfp,
+				OBJECT_PERCPU);
 }
 EXPORT_SYMBOL_GPL(kmemleak_alloc_percpu);
 
@@ -1047,7 +1062,7 @@ void __ref kmemleak_free(const void *ptr)
 	pr_debug("%s(0x%p)\n", __func__, ptr);
 
 	if (kmemleak_free_enabled && ptr && !IS_ERR(ptr))
-		delete_object_full((unsigned long)ptr);
+		delete_object_full((unsigned long)ptr, 0);
 }
 EXPORT_SYMBOL_GPL(kmemleak_free);
 
@@ -1065,7 +1080,7 @@ void __ref kmemleak_free_part(const void *ptr, size_t size)
 	pr_debug("%s(0x%p)\n", __func__, ptr);
 
 	if (kmemleak_enabled && ptr && !IS_ERR(ptr))
-		delete_object_part((unsigned long)ptr, size, false);
+		delete_object_part((unsigned long)ptr, size, 0);
 }
 EXPORT_SYMBOL_GPL(kmemleak_free_part);
 
@@ -1078,14 +1093,10 @@ EXPORT_SYMBOL_GPL(kmemleak_free_part);
  */
 void __ref kmemleak_free_percpu(const void __percpu *ptr)
 {
-	unsigned int cpu;
-
 	pr_debug("%s(0x%p)\n", __func__, ptr);
 
 	if (kmemleak_free_enabled && ptr && !IS_ERR(ptr))
-		for_each_possible_cpu(cpu)
-			delete_object_full((unsigned long)per_cpu_ptr(ptr,
-								      cpu));
+		delete_object_full((unsigned long)ptr, OBJECT_PERCPU);
 }
 EXPORT_SYMBOL_GPL(kmemleak_free_percpu);
 
@@ -1153,7 +1164,7 @@ void __ref kmemleak_ignore(const void *ptr)
 	pr_debug("%s(0x%p)\n", __func__, ptr);
 
 	if (kmemleak_enabled && ptr && !IS_ERR(ptr))
-		make_black_object((unsigned long)ptr, false);
+		make_black_object((unsigned long)ptr, 0);
 }
 EXPORT_SYMBOL(kmemleak_ignore);
 
@@ -1227,7 +1238,7 @@ void __ref kmemleak_free_part_phys(phys_addr_t phys, size_t size)
 	pr_debug("%s(0x%pa)\n", __func__, &phys);
 
 	if (kmemleak_enabled)
-		delete_object_part((unsigned long)phys, size, true);
+		delete_object_part((unsigned long)phys, size, OBJECT_PHYS);
 }
 EXPORT_SYMBOL(kmemleak_free_part_phys);
 
@@ -1241,7 +1252,7 @@ void __ref kmemleak_ignore_phys(phys_addr_t phys)
 	pr_debug("%s(0x%pa)\n", __func__, &phys);
 
 	if (kmemleak_enabled)
-		make_black_object((unsigned long)phys, true);
+		make_black_object((unsigned long)phys, OBJECT_PHYS);
 }
 EXPORT_SYMBOL(kmemleak_ignore_phys);
 
@@ -1252,7 +1263,7 @@ static bool update_checksum(struct kmemleak_object *object)
 {
 	u32 old_csum = object->checksum;
 
-	if (WARN_ON_ONCE(object->flags & OBJECT_PHYS))
+	if (WARN_ON_ONCE(object->flags & (OBJECT_PHYS | OBJECT_PERCPU)))
 		return false;
 
 	kasan_disable_current();
@@ -1408,7 +1419,6 @@ static void scan_object(struct kmemleak_object *object)
 {
 	struct kmemleak_scan_area *area;
 	unsigned long flags;
-	void *obj_ptr;
 
 	/*
 	 * Once the object->lock is acquired, the corresponding memory block
@@ -1421,14 +1431,27 @@ static void scan_object(struct kmemleak_object *object)
 		/* already freed object */
 		goto out;
 
-	obj_ptr = object->flags & OBJECT_PHYS ?
-		  __va((phys_addr_t)object->pointer) :
-		  (void *)object->pointer;
+	if (object->flags & OBJECT_PERCPU) {
+		unsigned int cpu;
+
+		for_each_possible_cpu(cpu) {
+			void *start = per_cpu_ptr((void __percpu *)object->pointer, cpu);
+			void *end = start + object->size;
 
-	if (hlist_empty(&object->area_list) ||
+			scan_block(start, end, object);
+
+			raw_spin_unlock_irqrestore(&object->lock, flags);
+			cond_resched();
+			raw_spin_lock_irqsave(&object->lock, flags);
+			if (!(object->flags & OBJECT_ALLOCATED))
+				break;
+		}
+	} else if (hlist_empty(&object->area_list) ||
 	    object->flags & OBJECT_FULL_SCAN) {
-		void *start = obj_ptr;
-		void *end = obj_ptr + object->size;
+		void *start = object->flags & OBJECT_PHYS ?
+				__va((phys_addr_t)object->pointer) :
+				(void *)object->pointer;
+		void *end = start + object->size;
 		void *next;
 
 		do {
@@ -1443,11 +1466,12 @@ static void scan_object(struct kmemleak_object *object)
 			cond_resched();
 			raw_spin_lock_irqsave(&object->lock, flags);
 		} while (object->flags & OBJECT_ALLOCATED);
-	} else
+	} else {
 		hlist_for_each_entry(area, &object->area_list, node)
 			scan_block((void *)area->start,
 				   (void *)(area->start + area->size),
 				   object);
+	}
 out:
 	raw_spin_unlock_irqrestore(&object->lock, flags);
 }
-- 
2.53.0

