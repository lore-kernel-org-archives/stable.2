Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794142015;
	b=NqhhflEOZAkUXqv4QIjHtjjJCmBF02ydJHGlm9fei8ZdS6tXyU5EBCFmv+TlWK9D5AIt
	 F7HnrP6Xn4UUhaUrVe43okjZxn5rOHUHeylfsl5Dvc2eVrxhR5quMHY+tPMvQKbAsUEA1
	 9IM5ruhTA2FL3ISgeDAdsldoDfBM1h+FpjHr6d0rP7wsZJ2j+71DTjdeaELvxxFxF8DcK
	 YC5fO2VFfk0okCnyaudhZpO2wGZVUhVanEyKizDOD4PMlCUrEA0TK4G74ZIz3DGw5HMAw
	 1Dw6BJ8gW2a9GrSbX24S4CCK1TayVYNmo2c/eUp7Doso1pRCZlyF9sFy9GPhIPZ8D+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794142015;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8cuXoAzvjbzM1k71qV0nweh+2ny0uRzIzLhdBKWNFKw=;
	b=q/iUxm3s/ecFSFj5wlgoFXzqwRuHJ/EvM6guN0iNaCmYwR+dJfLcNBm3piA3d3JGs/lH
	 WdQSzszVghZ+MZ9WfqfpG33uOy+m/7SYpVd7ASc0lS3e+yhYsGJ/HBYbs8LsPkhvLJzpH
	 9RO9pI/bUKZ4CCzU0YStlqW7XpRXQRwocW3WaBsEnLK+tgjHxFqJmA1ThI6D8T3cM8ZkJ
	 XwGudzffdrifzZdW9gqpjzXXMQQxis6/4K7fiNa4/RkGFxpk6L1B60gTQwJlNu69Lelfj
	 U9yR0j8nLQlg5ibuPIjKd60PxA7Q1Jc9GxdYBSWaErMw+qQ70hC3fKa0A3OFtnmJEkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Y4KFP+wi;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D527606A31C
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 12:46:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D527606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Y4KFP+wi
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6AAD515A1;
	Sun,  8 Nov 2026 04:46:50 -0800 (PST)
Received: from e127648.arm.com (unknown [10.57.14.94])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3ABC13F628;
	Sun,  8 Nov 2026 04:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794142013; bh=404NpgiHElwDFTP+YkNIMPwXPVjOO1/Vf750v2DYQmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y4KFP+wi+JSanVjJlDXOoGUQgpp2wdE/hcX6bz5xe+yme89qP3ROlpJqJhv9Wt2pa
	 B7IUC6ZzmfsYOQLAWLUA3qV2pr+tv488W3QxbZEV73NnMnaQiy8yNDDfPESgnvKir9
	 qRbTkzcB5WMzuSz90XHmWyMkOi5HnVaK6J5G68Qc=
From: Christian Loehle <christian.loehle@arm.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	peterz@infradead.org,
	bigeasy@linutronix.de,
	tglx@linutronix.de
Subject: [PATCH 5.15 1/2] debugobjects,locking: Annotate debug_object_fill_pool() wait type violation
Date: Sun,  8 Nov 2026 12:46:40 +0000
Message-Id: <20261108124641.2604547-2-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261108124641.2604547-1-christian.loehle@arm.com>
References: <20261108124641.2604547-1-christian.loehle@arm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Zijlstra <peterz@infradead.org>

commit 0cce06ba859a515bd06224085d3addb870608b6d upstream.

There is an explicit wait-type violation in debug_object_fill_pool()
for PREEMPT_RT=n kernels which allows them to more easily fill the
object pool and reduce the chance of allocation failures.

Lockdep's wait-type checks are designed to check the PREEMPT_RT
locking rules even for PREEMPT_RT=n kernels and object to this, so
create a lockdep annotation to allow this to stand.

Specifically, create a 'lock' type that overrides the inner wait-type
while it is held -- allowing one to temporarily raise it, such that
the violation is hidden.

Reported-by: Vlastimil Babka <vbabka@suse.cz>
Reported-by: Qi Zheng <zhengqi.arch@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Qi Zheng <zhengqi.arch@bytedance.com>
Link: https://lkml.kernel.org/r/20230429100614.GA1489784@hirez.programming.kicks-ass.net
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
5.15 has no debug_objects_fill_pool() helper; annotate its existing
fill_pool() call.

 include/linux/lockdep.h       | 14 ++++++++++++++
 include/linux/lockdep_types.h |  1 +
 kernel/locking/lockdep.c      | 28 +++++++++++++++++++++-------
 lib/debugobjects.c            | 15 +++++++++++++--
 4 files changed, 49 insertions(+), 9 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index e8cb0f1925ba..5abb22964e36 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -345,6 +345,16 @@ extern void lock_unpin_lock(struct lockdep_map *lock, struct pin_cookie);
 #define lockdep_repin_lock(l,c)	lock_repin_lock(&(l)->dep_map, (c))
 #define lockdep_unpin_lock(l,c)	lock_unpin_lock(&(l)->dep_map, (c))
 
+/*
+ * Must use lock_map_aquire_try() with override maps to avoid
+ * lockdep thinking they participate in the block chain.
+ */
+#define DEFINE_WAIT_OVERRIDE_MAP(_name, _wait_type)	\
+	struct lockdep_map _name = {			\
+		.name = #_name "-wait-type-override",	\
+		.wait_type_inner = _wait_type,		\
+		.lock_type = LD_LOCK_WAIT_OVERRIDE, }
+
 #else /* !CONFIG_LOCKDEP */
 
 static inline void lockdep_init_task(struct task_struct *task)
@@ -432,6 +442,9 @@ extern int lockdep_is_held(const void *);
 #define lockdep_repin_lock(l, c)		do { (void)(l); (void)(c); } while (0)
 #define lockdep_unpin_lock(l, c)		do { (void)(l); (void)(c); } while (0)
 
+#define DEFINE_WAIT_OVERRIDE_MAP(_name, _wait_type)	\
+	struct lockdep_map __maybe_unused _name = {}
+
 #endif /* !LOCKDEP */
 
 #ifdef CONFIG_PROVE_LOCKING
@@ -582,6 +595,7 @@ do {									\
 #define rwsem_release(l, i)			lock_release(l, i)
 
 #define lock_map_acquire(l)			lock_acquire_exclusive(l, 0, 0, NULL, _THIS_IP_)
+#define lock_map_acquire_try(l)			lock_acquire_exclusive(l, 0, 1, NULL, _THIS_IP_)
 #define lock_map_acquire_read(l)		lock_acquire_shared_recursive(l, 0, 0, NULL, _THIS_IP_)
 #define lock_map_acquire_tryread(l)		lock_acquire_shared_recursive(l, 0, 1, NULL, _THIS_IP_)
 #define lock_map_release(l)			lock_release(l, _THIS_IP_)
diff --git a/include/linux/lockdep_types.h b/include/linux/lockdep_types.h
index 6c5c27046946..aaa681ba6554 100644
--- a/include/linux/lockdep_types.h
+++ b/include/linux/lockdep_types.h
@@ -33,6 +33,7 @@ enum lockdep_wait_type {
 enum lockdep_lock_type {
 	LD_LOCK_NORMAL = 0,	/* normal, catch all */
 	LD_LOCK_PERCPU,		/* percpu */
+	LD_LOCK_WAIT_OVERRIDE,	/* annotation */
 	LD_LOCK_MAX,
 };
 
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 43a58e749d5f..7fdf066620c2 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2253,6 +2253,9 @@ static inline bool usage_match(struct lock_list *entry, void *mask)
 
 static inline bool usage_skip(struct lock_list *entry, void *mask)
 {
+	if (entry->class->lock_type == LD_LOCK_NORMAL)
+		return false;
+
 	/*
 	 * Skip local_lock() for irq inversion detection.
 	 *
@@ -2279,14 +2282,16 @@ static inline bool usage_skip(struct lock_list *entry, void *mask)
 	 * As a result, we will skip local_lock(), when we search for irq
 	 * inversion bugs.
 	 */
-	if (entry->class->lock_type == LD_LOCK_PERCPU) {
-		if (DEBUG_LOCKS_WARN_ON(entry->class->wait_type_inner < LD_WAIT_CONFIG))
-			return false;
+	if (entry->class->lock_type == LD_LOCK_PERCPU &&
+	    DEBUG_LOCKS_WARN_ON(entry->class->wait_type_inner < LD_WAIT_CONFIG))
+		return false;
 
-		return true;
-	}
+	/*
+	 * Skip WAIT_OVERRIDE for irq inversion detection -- it's not actually
+	 * a lock and only used to override the wait_type.
+	 */
 
-	return false;
+	return true;
 }
 
 /*
@@ -4781,7 +4786,8 @@ static int check_wait_context(struct task_struct *curr, struct held_lock *next)
 
 	for (; depth < curr->lockdep_depth; depth++) {
 		struct held_lock *prev = curr->held_locks + depth;
-		u8 prev_inner = hlock_class(prev)->wait_type_inner;
+		struct lock_class *class = hlock_class(prev);
+		u8 prev_inner = class->wait_type_inner;
 
 		if (prev_inner) {
 			/*
@@ -4791,6 +4797,14 @@ static int check_wait_context(struct task_struct *curr, struct held_lock *next)
 			 * Also due to trylocks.
 			 */
 			curr_inner = min(curr_inner, prev_inner);
+
+			/*
+			 * Allow override for annotations -- this is typically
+			 * only valid/needed for code that only exists when
+			 * CONFIG_PREEMPT_RT=n.
+			 */
+			if (unlikely(class->lock_type == LD_LOCK_WAIT_OVERRIDE))
+				curr_inner = prev_inner;
 		}
 	}
 
diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 81b319d57417..29b495adac24 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -609,10 +609,21 @@ __debug_object_init(void *addr, const struct debug_obj_descr *descr, int onstack
 
 	/*
 	 * On RT enabled kernels the pool refill must happen in preemptible
-	 * context:
+	 * context -- for !RT kernels we rely on the fact that spinlock_t and
+	 * raw_spinlock_t are basically the same type and this lock-type
+	 * inversion works just fine.
 	 */
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible())
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible()) {
+		/*
+		 * Annotate away the spinlock_t inside raw_spinlock_t warning
+		 * by temporarily raising the wait-type to LD_WAIT_SLEEP,
+		 * allowing the allocator's spinlock_t and local_lock_t locks.
+		 */
+		static DEFINE_WAIT_OVERRIDE_MAP(fill_pool_map, LD_WAIT_SLEEP);
+		lock_map_acquire_try(&fill_pool_map);
 		fill_pool();
+		lock_map_release(&fill_pool_map);
+	}
 
 	db = get_bucket((unsigned long) addr);
 
-- 
2.34.1

