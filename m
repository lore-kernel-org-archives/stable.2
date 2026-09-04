Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CF54A3D56
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 20:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788553950; cv=none; b=Zy3diDtfXmDhEErLv/I5Q2zfKdg+DT4uOEHIUSVH/rvoJfk11KnaR+VV1Rv0TkXvF9Jl5pMruMI5o8ptArur8p3n4jv9idxxHCgaQ3L7Zxo5nrVjqAOsgcLgMiA3hi7lKs8g2DrmEAfXEHaeHflps5KC57mAA9EPm/wKQuUqVaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788553950; c=relaxed/simple;
	bh=eSQ/wIQqfJV3mXNNWTIdgCWX3wPqQrrHzyUwxkcHbcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e9Hk1f7REeHpysoWOaUMDwHiEaam5pc5n4h1oitn7nGFIZhzWqCDndbhyYBkgQXYOCnJDxAUpWA9/JX3n3mnYClO/+jZyK3d1qHffXgKMv0i75QM7PFCIxHegppeFBwqoe6DgtrHxOo3RNfUz/O/tWAxScqfUv0nt3XUpzTrCV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F5E+zF5Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F5E+zF5Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB2041F00ADF;
	Fri,  4 Sep 2026 20:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788553940;
	bh=2FNv/zv/WwCxvsNZwbqfmvsX5pX8LbKmHUOT4/4psrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F5E+zF5Yzzu27BKRgtZuRKD683/Y5M7VYjqCb7N9BYUx/VvG6XJ1mhKMagg85s2Uu
	 yTT32Q+eN+8a+2FbDB9Ys0etnMAMSU8SMxsItqCNaNHJ4IT4aCPH3LKaJQc6LyHe/2
	 58vjJFBrd0vid2EVJDvLsZJpxQo8U0zyXxdRyDWOOk609crhyIhmnDygJZN1XQVNVx
	 6w+4uKOGqrYvETd3vwmasWrSzT44nC36QGFiSpW11VWj7uYEF+/rXw/RxaXUUu2Cjd
	 lg1W5r6cIieRjw5eDHV9waaVhqrw4DjcnGQ/QxUqs/PjUl/Z4lH2ia0uu6/dNZF6jD
	 Ue7eJcTv4tTgw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chengming Zhou <zhouchengming@bytedance.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Minchan Kim <minchan@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/9] mm/zsmalloc: remove unused zspage->isolated
Date: Fri,  4 Sep 2026 16:32:10 -0400
Message-ID: <20260904203217.1548415-2-sashal@kernel.org>
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

[ Upstream commit 4ad63e163264063b8cac8f681c20a303933842f2 ]

The zspage->isolated is not used anywhere, we don't need to maintain it,
which needs to hold the heavy pool lock to update it, so just remove it.

Link: https://lkml.kernel.org/r/20240219-b4-szmalloc-migrate-v1-3-34cd49c6545b@bytedance.com
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Nhat Pham <nphamcs@gmail.com>
Cc: Yosry Ahmed <yosryahmed@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: f7bf5cd5b5f2 ("zsmalloc: account for handle size in class lookup")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/zsmalloc.c | 69 ++++++++++++++-------------------------------------
 1 file changed, 18 insertions(+), 51 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 874d7d24d2d0f..2f37901ace99a 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -116,7 +116,6 @@
 #define HUGE_BITS	1
 #define FULLNESS_BITS	4
 #define CLASS_BITS	8
-#define ISOLATED_BITS	5
 #define MAGIC_VAL_BITS	8
 
 #define ZS_MAX_PAGES_PER_ZSPAGE	(_AC(CONFIG_ZSMALLOC_CHAIN_SIZE, UL))
@@ -244,7 +243,6 @@ struct zspage {
 		unsigned int huge:HUGE_BITS;
 		unsigned int fullness:FULLNESS_BITS;
 		unsigned int class:CLASS_BITS + 1;
-		unsigned int isolated:ISOLATED_BITS;
 		unsigned int magic:MAGIC_VAL_BITS;
 	};
 	unsigned int inuse;
@@ -515,19 +513,19 @@ static int get_size_class_index(int size)
 	return min_t(int, ZS_SIZE_CLASSES - 1, idx);
 }
 
-static inline void class_stat_inc(struct size_class *class,
-				int type, unsigned long cnt)
+static inline void class_stat_add(struct size_class *class, int type,
+				  unsigned long cnt)
 {
 	class->stats.objs[type] += cnt;
 }
 
-static inline void class_stat_dec(struct size_class *class,
-				int type, unsigned long cnt)
+static inline void class_stat_sub(struct size_class *class, int type,
+				  unsigned long cnt)
 {
 	class->stats.objs[type] -= cnt;
 }
 
-static inline unsigned long zs_stat_get(struct size_class *class, int type)
+static inline unsigned long class_stat_read(struct size_class *class, int type)
 {
 	return class->stats.objs[type];
 }
@@ -579,12 +577,12 @@ static int zs_stats_size_show(struct seq_file *s, void *v)
 
 		seq_printf(s, " %5u %5u ", i, class->size);
 		for (fg = ZS_INUSE_RATIO_10; fg < NR_FULLNESS_GROUPS; fg++) {
-			inuse_totals[fg] += zs_stat_get(class, fg);
-			seq_printf(s, "%9lu ", zs_stat_get(class, fg));
+			inuse_totals[fg] += class_stat_read(class, fg);
+			seq_printf(s, "%9lu ", class_stat_read(class, fg));
 		}
 
-		obj_allocated = zs_stat_get(class, ZS_OBJS_ALLOCATED);
-		obj_used = zs_stat_get(class, ZS_OBJS_INUSE);
+		obj_allocated = class_stat_read(class, ZS_OBJS_ALLOCATED);
+		obj_used = class_stat_read(class, ZS_OBJS_INUSE);
 		freeable = zs_can_compact(class);
 		spin_unlock(&pool->lock);
 
@@ -689,7 +687,7 @@ static void insert_zspage(struct size_class *class,
 				struct zspage *zspage,
 				int fullness)
 {
-	class_stat_inc(class, fullness, 1);
+	class_stat_add(class, fullness, 1);
 	list_add(&zspage->list, &class->fullness_list[fullness]);
 }
 
@@ -704,7 +702,7 @@ static void remove_zspage(struct size_class *class,
 	VM_BUG_ON(list_empty(&class->fullness_list[fullness]));
 
 	list_del_init(&zspage->list);
-	class_stat_dec(class, fullness, 1);
+	class_stat_sub(class, fullness, 1);
 }
 
 /*
@@ -869,7 +867,7 @@ static void __free_zspage(struct zs_pool *pool, struct size_class *class,
 
 	cache_free_zspage(pool, zspage);
 
-	class_stat_dec(class, ZS_OBJS_ALLOCATED, class->objs_per_zspage);
+	class_stat_sub(class, ZS_OBJS_ALLOCATED, class->objs_per_zspage);
 	atomic_long_sub(class->pages_per_zspage, &pool->pages_allocated);
 }
 
@@ -1383,7 +1381,7 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
 		/* Now move the zspage to another fullness group, if required */
 		fix_fullness_group(class, zspage);
 		record_obj(handle, obj);
-		class_stat_inc(class, ZS_OBJS_INUSE, 1);
+		class_stat_add(class, ZS_OBJS_INUSE, 1);
 
 		goto out;
 	}
@@ -1403,8 +1401,8 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
 	set_zspage_mapping(zspage, class->index, newfg);
 	record_obj(handle, obj);
 	atomic_long_add(class->pages_per_zspage, &pool->pages_allocated);
-	class_stat_inc(class, ZS_OBJS_ALLOCATED, class->objs_per_zspage);
-	class_stat_inc(class, ZS_OBJS_INUSE, 1);
+	class_stat_add(class, ZS_OBJS_ALLOCATED, class->objs_per_zspage);
+	class_stat_add(class, ZS_OBJS_INUSE, 1);
 
 	/* We completely set up zspage so mark them as movable */
 	SetZsPageMovable(pool, zspage);
@@ -1463,7 +1461,7 @@ void zs_free(struct zs_pool *pool, unsigned long handle)
 	zspage = get_zspage(f_page);
 	class = zspage_class(pool, zspage);
 
-	class_stat_dec(class, ZS_OBJS_INUSE, 1);
+	class_stat_sub(class, ZS_OBJS_INUSE, 1);
 	obj_free(class->size, obj);
 
 	fullness = fix_fullness_group(class, zspage);
@@ -1733,18 +1731,6 @@ static void migrate_write_unlock(struct zspage *zspage)
 	write_unlock(&zspage->lock);
 }
 
-/* Number of isolated subpage for *page migration* in this zspage */
-static void inc_zspage_isolation(struct zspage *zspage)
-{
-	zspage->isolated++;
-}
-
-static void dec_zspage_isolation(struct zspage *zspage)
-{
-	VM_BUG_ON(zspage->isolated == 0);
-	zspage->isolated--;
-}
-
 static const struct movable_operations zsmalloc_mops;
 
 static void replace_sub_page(struct size_class *class, struct zspage *zspage,
@@ -1772,21 +1758,12 @@ static void replace_sub_page(struct size_class *class, struct zspage *zspage,
 
 static bool zs_page_isolate(struct page *page, isolate_mode_t mode)
 {
-	struct zs_pool *pool;
-	struct zspage *zspage;
-
 	/*
 	 * Page is locked so zspage couldn't be destroyed. For detail, look at
 	 * lock_zspage in free_zspage.
 	 */
 	VM_BUG_ON_PAGE(PageIsolated(page), page);
 
-	zspage = get_zspage(page);
-	pool = zspage->pool;
-	spin_lock(&pool->lock);
-	inc_zspage_isolation(zspage);
-	spin_unlock(&pool->lock);
-
 	return true;
 }
 
@@ -1851,7 +1828,6 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	kunmap_atomic(s_addr);
 
 	replace_sub_page(class, zspage, newpage, page);
-	dec_zspage_isolation(zspage);
 	/*
 	 * Since we complete the data copy and set up new zspage structure,
 	 * it's okay to release the pool's lock.
@@ -1873,16 +1849,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 
 static void zs_page_putback(struct page *page)
 {
-	struct zs_pool *pool;
-	struct zspage *zspage;
-
 	VM_BUG_ON_PAGE(!PageIsolated(page), page);
-
-	zspage = get_zspage(page);
-	pool = zspage->pool;
-	spin_lock(&pool->lock);
-	dec_zspage_isolation(zspage);
-	spin_unlock(&pool->lock);
 }
 
 static const struct movable_operations zsmalloc_mops = {
@@ -1967,8 +1934,8 @@ static inline void zs_flush_migration(struct zs_pool *pool) { }
 static unsigned long zs_can_compact(struct size_class *class)
 {
 	unsigned long obj_wasted;
-	unsigned long obj_allocated = zs_stat_get(class, ZS_OBJS_ALLOCATED);
-	unsigned long obj_used = zs_stat_get(class, ZS_OBJS_INUSE);
+	unsigned long obj_allocated = class_stat_read(class, ZS_OBJS_ALLOCATED);
+	unsigned long obj_used = class_stat_read(class, ZS_OBJS_INUSE);
 
 	if (obj_allocated <= obj_used)
 		return 0;
-- 
2.53.0

