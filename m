Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C271524B18
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 20:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788553956; cv=none; b=imQqmGf2U/LsJdv0wAxekK0D7twmcKmN15S9NShsCADN6HEt8cofIfOik7ifzib1EOxUvmLLWQMVK4wEWz9ysDVNkTfsAAUXRv1dtdNlhOWlCuop8forOGzWEwo7UrpVxJDYqESwKEouAYtHJLAHi1qxsswLKsU+MpWVswQv7Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788553956; c=relaxed/simple;
	bh=w/2NKlUuEe6RjOId9LgMNCv39Gjg4I35SrkwyhJy8Ys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rTFk1KtupVKC7HyCD5swi0j5JPEvGlo1QESANZ1rMo0acNiTBQDgGOPfPMwaWWNldBeBbQwVt/utkYgQ5n+9dNKnbJ6mSfvEEEWEFFDuK4LUjDAj/Le/iybc8WqGXeg68yB/L4AGIOB8AlR+tJXePQLBx4taPWSno2uJjNHipzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J7P+6ab4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J7P+6ab4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D42431F00ADB;
	Fri,  4 Sep 2026 20:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788553946;
	bh=dI6v15SO4bYIDyl9sHrXjPsJ7D6oax7SHKBuzNv7rPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J7P+6ab4i6FcG32hWKckIir8BTnt6fGVT1Ull322GXpzE3fA2DVBfIEe5J/aiNk9e
	 NDofCQ1Q8guDJRRKqd4XqXgndftlt9/IwlpJs1Icd01t3sK1x6BNI+IzHEzCWiqAk8
	 XIkaE52jFuncFdoyDxMHip2QhuVl4uHs+SdIxzLNM8NLISeR9WDhLlPVhO6AnMxVQt
	 BYRKQV3z5CEOmBf+GSI30QjN51CSQXBWlwPACLTHpZgyEB3ThjWCDyhSBg0vDAbctw
	 ZAg7w0u6IQwBMD3851nY+C6EMayiICpubWwerGWLRx62kugEr9pboWvv1C/8AfIv1B
	 Vzcrqgv+n1T0A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chengming Zhou <zhouchengming@bytedance.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Minchan Kim <minchan@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 6/9] mm/zsmalloc: change back to per-size_class lock
Date: Fri,  4 Sep 2026 16:32:14 -0400
Message-ID: <20260904203217.1548415-6-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904203217.1548415-1-sashal@kernel.org>
References: <2026090349-deniable-copilot-d36a@gregkh>
 <20260904203217.1548415-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chengming Zhou <zhouchengming@bytedance.com>

[ Upstream commit 64bd0197ae0c7d779e21410fe6d1782a3b59ee32 ]

Patch series "mm/zsmalloc: change back to per-size_class lock, v2".

Commit c0547d0b6a4b ("zsmalloc: consolidate zs_pool's migrate_lock and
size_class's locks") changed per-size_class lock to pool spinlock to
prepare reclaim support in zsmalloc.  Then reclaim support in zsmalloc had
been dropped in favor of LRU reclaim in zswap, but this locking change had
been left there.

Obviously, the scalability of pool spinlock is worse than per-size_class.
And we have a workaround that using 32 pools in zswap to avoid this
scalability problem, which brings its own problems like memory waste and
more memory fragmentation.

So this series changes back to use per-size_class lock and using testing
data in much stressed situation to verify that we can use only one pool in
zswap.  Note we only test and care about the zsmalloc backend, which makes
sense now since zsmalloc became a lot more popular than other backends.

Testing kernel build (make bzImage -j32) on tmpfs with memory.max=1GB, and
zswap shrinker enabled with 10GB swapfile on ext4.

				real	user    sys
6.10.0-rc3			138.18	1241.38 1452.73
6.10.0-rc3-onepool		149.45	1240.45 1844.69
6.10.0-rc3-onepool-perclass	138.23	1242.37 1469.71

We can see from "sys" column that per-size_class locking with only one
pool in zswap can have near performance with the current 32 pools.

This patch (of 2):

This patch is almost the revert of the commit c0547d0b6a4b ("zsmalloc:
consolidate zs_pool's migrate_lock and size_class's locks"), which changed
to use a global pool->lock instead of per-size_class lock and
pool->migrate_lock, was preparation for suppporting reclaim in zsmalloc.
Then reclaim in zsmalloc had been dropped in favor of LRU reclaim in
zswap.

In theory, per-size_class is more fine-grained than the pool->lock, since
a pool can have many size_classes.  As for the additional
pool->migrate_lock, only free() and map() need to grab it to access stable
handle to get zspage, and only in read lock mode.

Link: https://lkml.kernel.org/r/20240625-zsmalloc-lock-mm-everything-v3-0-ad941699cb61@linux.dev
Link: https://lkml.kernel.org/r/20240621-zsmalloc-lock-mm-everything-v2-0-d30e9cd2b793@linux.dev
Link: https://lkml.kernel.org/r/20240617-zsmalloc-lock-mm-everything-v1-0-5e5081ea11b3@linux.dev
Link: https://lkml.kernel.org/r/20240617-zsmalloc-lock-mm-everything-v1-1-5e5081ea11b3@linux.dev
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Nhat Pham <nphamcs@gmail.com>
Cc: Yosry Ahmed <yosryahmed@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Obviously, the scalability of pool spinlock is worse than per-size_class.
And we have a workaround that using 32 pools in zswap to avoid this
scalability problem, which brings its own problems like memory waste and
more memory fragmentation.

So this series changes back to use per-size_class lock and using testing
data in much stressed situation to verify that we can use only one pool in
zswap.  Note we only test and care about the zsmalloc backend, which makes
sense now since zsmalloc became a lot more popular than other backends.

Testing kernel build (make bzImage -j32) on tmpfs with memory.max=1GB, and
zswap shrinker enabled with 10GB swapfile on ext4.

				real	user    sys
6.10.0-rc3			138.18	1241.38 1452.73
6.10.0-rc3-onepool		149.45	1240.45 1844.69
6.10.0-rc3-onepool-perclass	138.23	1242.37 1469.71

We can see from "sys" column that per-size_class locking with only one
pool in zswap can have near performance with the current 32 pools.

This patch (of 2):

This patch is almost the revert of the commit c0547d0b6a4b ("zsmalloc:
consolidate zs_pool's migrate_lock and size_class's locks"), which changed
to use a global pool->lock instead of per-size_class lock and
pool->migrate_lock, was preparation for suppporting reclaim in zsmalloc.

Stable-dep-of: f7bf5cd5b5f2 ("zsmalloc: account for handle size in class lookup")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/zsmalloc.c | 85 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 50 insertions(+), 35 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 187936f3ea794..6b78584c4183a 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -33,7 +33,8 @@
 /*
  * lock ordering:
  *	page_lock
- *	pool->lock
+ *	pool->migrate_lock
+ *	class->lock
  *	zspage->lock
  */
 
@@ -180,6 +181,7 @@ static struct dentry *zs_stat_root;
 static size_t huge_class_size;
 
 struct size_class {
+	spinlock_t lock;
 	struct list_head fullness_list[NR_FULLNESS_GROUPS];
 	/*
 	 * Size of objects stored in this class. Must be multiple
@@ -234,7 +236,8 @@ struct zs_pool {
 #ifdef CONFIG_COMPACTION
 	struct work_struct free_work;
 #endif
-	spinlock_t lock;
+	/* protect page/zspage migration */
+	rwlock_t migrate_lock;
 	atomic_t compaction_in_progress;
 };
 
@@ -336,7 +339,7 @@ static void cache_free_zspage(struct zs_pool *pool, struct zspage *zspage)
 	kmem_cache_free(pool->zspage_cachep, zspage);
 }
 
-/* pool->lock(which owns the handle) synchronizes races */
+/* class->lock(which owns the handle) synchronizes races */
 static void record_obj(unsigned long handle, unsigned long obj)
 {
 	*(unsigned long *)handle = obj;
@@ -431,7 +434,7 @@ static __maybe_unused int is_first_page(struct page *page)
 	return PagePrivate(page);
 }
 
-/* Protected by pool->lock */
+/* Protected by class->lock */
 static inline int get_zspage_inuse(struct zspage *zspage)
 {
 	return zspage->inuse;
@@ -555,7 +558,7 @@ static int zs_stats_size_show(struct seq_file *s, void *v)
 		if (class->index != i)
 			continue;
 
-		spin_lock(&pool->lock);
+		spin_lock(&class->lock);
 
 		seq_printf(s, " %5u %5u ", i, class->size);
 		for (fg = ZS_INUSE_RATIO_10; fg < NR_FULLNESS_GROUPS; fg++) {
@@ -566,7 +569,7 @@ static int zs_stats_size_show(struct seq_file *s, void *v)
 		obj_allocated = class_stat_read(class, ZS_OBJS_ALLOCATED);
 		obj_used = class_stat_read(class, ZS_OBJS_INUSE);
 		freeable = zs_can_compact(class);
-		spin_unlock(&pool->lock);
+		spin_unlock(&class->lock);
 
 		objs_per_zspage = class->objs_per_zspage;
 		pages_used = obj_allocated / objs_per_zspage *
@@ -825,7 +828,7 @@ static void __free_zspage(struct zs_pool *pool, struct size_class *class,
 {
 	struct page *page, *next;
 
-	assert_spin_locked(&pool->lock);
+	assert_spin_locked(&class->lock);
 
 	VM_BUG_ON(get_zspage_inuse(zspage));
 	VM_BUG_ON(zspage->fullness != ZS_INUSE_RATIO_0);
@@ -1185,19 +1188,19 @@ void *zs_map_object(struct zs_pool *pool, unsigned long handle,
 	BUG_ON(in_interrupt());
 
 	/* It guarantees it can get zspage from handle safely */
-	spin_lock(&pool->lock);
+	read_lock(&pool->migrate_lock);
 	obj = handle_to_obj(handle);
 	obj_to_location(obj, &page, &obj_idx);
 	zspage = get_zspage(page);
 
 	/*
-	 * migration cannot move any zpages in this zspage. Here, pool->lock
+	 * migration cannot move any zpages in this zspage. Here, class->lock
 	 * is too heavy since callers would take some time until they calls
 	 * zs_unmap_object API so delegate the locking from class to zspage
 	 * which is smaller granularity.
 	 */
 	migrate_read_lock(zspage);
-	spin_unlock(&pool->lock);
+	read_unlock(&pool->migrate_lock);
 
 	class = zspage_class(pool, zspage);
 	off = offset_in_page(class->size * obj_idx);
@@ -1350,8 +1353,8 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
 	size += ZS_HANDLE_SIZE;
 	class = pool->size_class[get_size_class_index(size)];
 
-	/* pool->lock effectively protects the zpage migration */
-	spin_lock(&pool->lock);
+	/* class->lock effectively protects the zpage migration */
+	spin_lock(&class->lock);
 	zspage = find_get_zspage(class);
 	if (likely(zspage)) {
 		obj = obj_malloc(pool, zspage, handle);
@@ -1363,7 +1366,7 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
 		goto out;
 	}
 
-	spin_unlock(&pool->lock);
+	spin_unlock(&class->lock);
 
 	zspage = alloc_zspage(pool, class, gfp);
 	if (!zspage) {
@@ -1371,7 +1374,7 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
 		return (unsigned long)ERR_PTR(-ENOMEM);
 	}
 
-	spin_lock(&pool->lock);
+	spin_lock(&class->lock);
 	obj = obj_malloc(pool, zspage, handle);
 	newfg = get_fullness_group(class, zspage);
 	insert_zspage(class, zspage, newfg);
@@ -1383,7 +1386,7 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
 	/* We completely set up zspage so mark them as movable */
 	SetZsPageMovable(pool, zspage);
 out:
-	spin_unlock(&pool->lock);
+	spin_unlock(&class->lock);
 
 	return handle;
 }
@@ -1428,14 +1431,16 @@ void zs_free(struct zs_pool *pool, unsigned long handle)
 		return;
 
 	/*
-	 * The pool->lock protects the race with zpage's migration
+	 * The pool->migrate_lock protects the race with zpage's migration
 	 * so it's safe to get the page from handle.
 	 */
-	spin_lock(&pool->lock);
+	read_lock(&pool->migrate_lock);
 	obj = handle_to_obj(handle);
 	obj_to_page(obj, &f_page);
 	zspage = get_zspage(f_page);
 	class = zspage_class(pool, zspage);
+	spin_lock(&class->lock);
+	read_unlock(&pool->migrate_lock);
 
 	class_stat_sub(class, ZS_OBJS_INUSE, 1);
 	obj_free(class->size, obj);
@@ -1444,7 +1449,7 @@ void zs_free(struct zs_pool *pool, unsigned long handle)
 	if (fullness == ZS_INUSE_RATIO_0)
 		free_zspage(pool, class, zspage);
 
-	spin_unlock(&pool->lock);
+	spin_unlock(&class->lock);
 	cache_free_handle(pool, handle);
 }
 EXPORT_SYMBOL_GPL(zs_free);
@@ -1770,12 +1775,16 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	pool = zspage->pool;
 
 	/*
-	 * The pool's lock protects the race between zpage migration
+	 * The pool migrate_lock protects the race between zpage migration
 	 * and zs_free.
 	 */
-	spin_lock(&pool->lock);
+	write_lock(&pool->migrate_lock);
 	class = zspage_class(pool, zspage);
 
+	/*
+	 * the class lock protects zpage alloc/free in the zspage.
+	 */
+	spin_lock(&class->lock);
 	/* the migrate_write_lock protects zpage access via zs_map_object */
 	migrate_write_lock(zspage);
 
@@ -1805,9 +1814,10 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	replace_sub_page(class, zspage, newpage, page);
 	/*
 	 * Since we complete the data copy and set up new zspage structure,
-	 * it's okay to release the pool's lock.
+	 * it's okay to release migration_lock.
 	 */
-	spin_unlock(&pool->lock);
+	write_unlock(&pool->migrate_lock);
+	spin_unlock(&class->lock);
 	migrate_write_unlock(zspage);
 
 	get_page(newpage);
@@ -1851,20 +1861,20 @@ static void async_free_zspage(struct work_struct *work)
 		if (class->index != i)
 			continue;
 
-		spin_lock(&pool->lock);
+		spin_lock(&class->lock);
 		list_splice_init(&class->fullness_list[ZS_INUSE_RATIO_0],
 				 &free_pages);
-		spin_unlock(&pool->lock);
+		spin_unlock(&class->lock);
 	}
 
 	list_for_each_entry_safe(zspage, tmp, &free_pages, list) {
 		list_del(&zspage->list);
 		lock_zspage(zspage);
 
-		spin_lock(&pool->lock);
 		class = zspage_class(pool, zspage);
+		spin_lock(&class->lock);
 		__free_zspage(pool, class, zspage);
-		spin_unlock(&pool->lock);
+		spin_unlock(&class->lock);
 	}
 };
 
@@ -1928,7 +1938,8 @@ static unsigned long __zs_compact(struct zs_pool *pool,
 	 * protect the race between zpage migration and zs_free
 	 * as well as zpage allocation/free
 	 */
-	spin_lock(&pool->lock);
+	write_lock(&pool->migrate_lock);
+	spin_lock(&class->lock);
 	while (zs_can_compact(class)) {
 		int fg;
 
@@ -1954,13 +1965,15 @@ static unsigned long __zs_compact(struct zs_pool *pool,
 		src_zspage = NULL;
 
 		if (get_fullness_group(class, dst_zspage) == ZS_INUSE_RATIO_100
-		    || spin_is_contended(&pool->lock)) {
+		    || rwlock_is_contended(&pool->migrate_lock)) {
 			putback_zspage(class, dst_zspage);
 			dst_zspage = NULL;
 
-			spin_unlock(&pool->lock);
+			spin_unlock(&class->lock);
+			write_unlock(&pool->migrate_lock);
 			cond_resched();
-			spin_lock(&pool->lock);
+			write_lock(&pool->migrate_lock);
+			spin_lock(&class->lock);
 		}
 	}
 
@@ -1970,7 +1983,8 @@ static unsigned long __zs_compact(struct zs_pool *pool,
 	if (dst_zspage)
 		putback_zspage(class, dst_zspage);
 
-	spin_unlock(&pool->lock);
+	spin_unlock(&class->lock);
+	write_unlock(&pool->migrate_lock);
 
 	return pages_freed;
 }
@@ -1982,10 +1996,10 @@ unsigned long zs_compact(struct zs_pool *pool)
 	unsigned long pages_freed = 0;
 
 	/*
-	 * Pool compaction is performed under pool->lock so it is basically
+	 * Pool compaction is performed under pool->migrate_lock so it is basically
 	 * single-threaded. Having more than one thread in __zs_compact()
-	 * will increase pool->lock contention, which will impact other
-	 * zsmalloc operations that need pool->lock.
+	 * will increase pool->migrate_lock contention, which will impact other
+	 * zsmalloc operations that need pool->migrate_lock.
 	 */
 	if (atomic_xchg(&pool->compaction_in_progress, 1))
 		return 0;
@@ -2104,7 +2118,7 @@ struct zs_pool *zs_create_pool(const char *name)
 		return NULL;
 
 	init_deferred_free(pool);
-	spin_lock_init(&pool->lock);
+	rwlock_init(&pool->migrate_lock);
 	atomic_set(&pool->compaction_in_progress, 0);
 
 	pool->name = kstrdup(name, GFP_KERNEL);
@@ -2176,6 +2190,7 @@ struct zs_pool *zs_create_pool(const char *name)
 		class->index = i;
 		class->pages_per_zspage = pages_per_zspage;
 		class->objs_per_zspage = objs_per_zspage;
+		spin_lock_init(&class->lock);
 		pool->size_class[i] = class;
 
 		fullness = ZS_INUSE_RATIO_0;
-- 
2.53.0

