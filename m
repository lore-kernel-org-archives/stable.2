Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F442FD665
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 16:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786294433; cv=none; b=rodxFQ7uvw/DcMkYdHMesk0RMpo4XAVQYJoas3zmk97mXuM713ZMZlsh80OZRNnffkgvxgb1gM/cypAw46RBuVr49LZBxhWH6Gy6hY7fwjOKqFIAkISH2Y5yfq62OJ41Y9FqmEcmCS1zlKPS3OLjwq62IEASZ67emPwslgkmUng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786294433; c=relaxed/simple;
	bh=oVAfk0wAOZd9sn7UJJsCvJ6nCTuPo03/JIINR55Ic38=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=difEwM5D+m+mLZX3Tyihy+ZkK9rnIk8dIK5gvp9c9f2SUSzJnYw2ixeIAcM/Q2WCeiaY6PY7JGSQHqHIBhJfJ/c8NaFA9W4cgiI4CVAyprXXPSWHQgRNttti1VxCg9OMxvnVBGrC5oYGImSt6ZJWW/yy/DfR0Z+CuTLm9fcVC1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HC8ZmoEj; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HC8ZmoEj"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-495437bb891so8859185e9.1
        for <stable@vger.kernel.org>; Sun, 09 Aug 2026 09:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786294430; x=1786899230; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5/XLgqYK873A1GIVt6yKDgXm2bgfPi9SEqbj4J+hicw=;
        b=HC8ZmoEjbX0YUG0DmOX/WTCdtr6N6TDmOIQ/smg8CFZ4w6k1Hp9GJNxfwORocF7O/M
         GrTaVDNmG7M+CIwZyP5Vfnw6xxn3wGsVd4jVU6+a/9Kx8vLTYZqpKyshe1lVmt14l4n1
         GI+OKtDJI/xy5jbXiM2VfCC63mpEVl7J/j04HJ41A4YhypDmHq3fVf0psPfcvBiyhuO1
         ErLHFAqakS0ya8OAQQsDsxTi3SkTIbejguEp2nlfNdKC+++Sl05q7nZ3AExDt60CKdH9
         2GwFg5ZmZ1+dUqqunXS6wTQKv8a56NfztlXsl8TlWGL+tx+1vaERtsNhLns7eZMqOFqM
         SrUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786294430; x=1786899230;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5/XLgqYK873A1GIVt6yKDgXm2bgfPi9SEqbj4J+hicw=;
        b=g+ZZICugRa9U4y8PVsGGK6fc8us9bEebZliNdZbvvHqZKyn2K1t/mbc23zqwwR4ZNV
         bmCzrnXWeENvh1oB9BbJBGa/mPF1uHGaXy7IMMu+Y4M4T4/XPkmFgqOmebLu6LFHkNK0
         w8G2LsUnOpDzIN/YO9tKKiX1ZQCvZJ5s6j4OOjarqXdL1Vf4TPjds7W1tuALZBpVWWgI
         zhvGSe/+su7ix5F3+u3/fCsbnwEYG3s47mVaZX7MzMwx/ZKLdYwGJbdXbPMJZUuGXvxR
         FfpiALn0cLvdA1dhr0V9Mi3HotA2kHWR++56LPl9Mgkeg3WhrjtdfKgg+JqsNemaHlC0
         hHtg==
X-Forwarded-Encrypted: i=1; AHgh+Rq1cqyi1XzIsii3IkkR22Ic5KjrMqGX1slmxk0K5+LNKidbtZX9803Q1xxbCEf2AdqeZEjii7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO4yvWvH/e/HGkspeYGQvTo87i1hGntyGR1VQ+SRW9//+6AM0b
	QmFSZPtVKnXENz4gHdKT1fLOdBTfZJbfcimZdTFFXirCEHEOPKOZD2GT
X-Gm-Gg: AR+sD104P5lp/ztEv3XnpSdziGTt9y3TkbaOhlsqa3PDWu1chFZv5Lfu2pBb3gRH9Tr
	hYE4A0HHtMnPbivL7IebkD3T1IHnblUSZ6kmUVjxGVPwPekVPkKCqwBm7iepI1yc57p/inI2Mdp
	XYndle27IWifhjOxmtWaJBLx6ev53+LcyNHNbrw9iUUvAjnRXkZUGPJ/zOH35baqzbL1LqpBDqd
	sOkabZ9uzlIJbjCQwzCamXIcZFXiA+tq1qvzNmSF2+wNxazOVbsgf9BxI9hv+zslxcWlXw/9yGM
	FvW6rtPQRjXJl5im/bm160g76YIS+4mZpDF0+VsAfAB3cb1xk7AMjEflO7gLTmEq9tjqU2/APPn
	pETrYMMGQLkZ6vdhBhauZ/fVA3s8jf5bGF/7KydRv6tphtSrPp2BE73K0IC2L4PKV6itqrwM6dz
	wTJX5FWTe0a8PqOUHrwGgFyMpleOgV7+wessIB6yW1WfqvioujHBO8fiCpDu/UDGNWfEaAR1h68
	ViEyuQgKMih2WEkrulJK5BNBXYb8oizByVRNCYbHkGxre5030ox+w==
X-Received: by 2002:a05:600c:45d5:b0:495:69eb:27d3 with SMTP id 5b1f17b1804b1-4996247a562mr148297525e9.8.1786294429885;
        Sun, 09 Aug 2026 09:53:49 -0700 (PDT)
Received: from torre-GIGABYTE-B550-AORUS-ELITE-V2 (212.pool95-21-2.static.orange.es. [95.21.2.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480020be8f3sm23599092f8f.0.2026.08.09.09.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 09:53:49 -0700 (PDT)
From: =?UTF-8?q?=C3=93scar=20Meg=C3=ADa=20L=C3=B3pez?= <megia.oscar@gmail.com>
To: Christian Koenig <christian.koenig@amd.com>,
	Huang Rui <ray.huang@amd.com>
Cc: =?UTF-8?q?=C3=93scar=20Meg=C3=ADa=20L=C3=B3pez?= <megia.oscar@gmail.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH v4] Memory leak error in qxl unbind
Date: Sun,  9 Aug 2026 18:53:14 +0200
Message-ID: <20260809165326.164763-1-megia.oscar@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I discovered an OOM after run the script below
(I updated it and added a sleep to allow enough time for the cache to
recover):

while [ 1 -eq 1 ]; do\
  i=$((i+1)); echo 0000:00:01.0 > /sys/bus/pci/drivers/qxl/unbind;\
  if (($i%1000==0)); then\
    echo i=$i; free;\
    grep nr_free_pages /proc/vmstat;\
    grep -E "PageTables|VmallocUsed|Slab|Reclaimable" /proc/meminfo;\
    sync; echo 3 > /proc/sys/vm/drop_caches;\
    echo 1 > /proc/sys/vm/compact_memory;\
    sleep 10s;\
    free;\
    grep nr_free_pages /proc/vmstat;\
    grep -E "PageTables|VmallocUsed|Slab|Reclaimable" /proc/meminfo;\
    uptime;\
  fi;\
  echo 0000:00:01.0 > /sys/bus/pci/drivers/qxl/bind;\
 done

The OOM isn't just a simple leak; it's a refcount corruption which renders
the list_lru fix dead code after the first mid-init failure.

Here's the chain:

Bug 1: ttm_pool_type_init() does not check return from list_lru_init().

Fix: Check the return value from list_lru_init() and propagate the error.

Bug 2: ttm_pool_fini() does not destroy list lru with list_lru_destroy().

Fix: Add list_lru_destroy() after ttm_pool_type_fini().

Bug 3: ttm_pool_mgr_init() does not check ttm_pool_type_init() return
and does not free pool if returns error.

Fix: Move up shrinker_alloc(), check ttm_pool_type_init() return and free
pool types and shrinker if non-zero and return error.

Bug 4: ttm_pool_mgr_fini() does not destroy the list_lru.

Fix: Add list_lru_destroy() after ttm_pool_type_fini().

Fixed check for an empty shrinker_list.

This patch depends on patch ("[PATCH v3] drm/qxl: fix use-after-free in
qxl_irq_handler on PCI"), link [1] below.

Assisted-by: OpenCode:1.17.18-Big Pickle/DeepSeek V4 Flash
Assisted-by: claude.ai:Sonnet 5
Link: https://lore.kernel.org/lkml/
20260727110212.64913-1-megia.oscar@gmail.com/ [1]
Link: https://lore.kernel.org/dri-devel/
20260731053047.24503-1-megia.oscar@gmail.com/ [2]
Cc: <stable@vger.kernel.org> # 7.1.0
Fixes: 444e2a19d7fd ("ttm/pool: port to list_lru. (v2)")
Signed-off-by: Óscar Megía López <megia.oscar@gmail.com>
---
Changes in v2:
 - Bug 1: ttm_global_init ignores ttm_pool_mgr_init() return.
   If shrinker_alloc() fails under memory pressure, ttm_pool_mgr_init
   returns -ENOMEM with pool types already initialized (64 list_lru_init
   calls done). ttm_global_init ignored this and returned 0, leaving orphaned
   pool types with a NULL mm_shrinker.

   Fix: Check ret from ttm_pool_mgr_init; if non-zero, goto out cleans up
   refcount + debugfs.

 - Bug 2: ttm_pool_mgr_init leaks pool types on shrinker_alloc failure
   If shrinker_alloc fails after all 64 pool types were list_lru_init'd,
   the function returned -ENOMEM without undoing them. With Bug 1 now
   triggering proper error handling, this undo is necessary.

   Fix: err_shrinker: label that finalizes + destroys all 64 pool types
   before returning.

Changes in v3:
 - Fix: "Unchecked list_lru_init() return value in ttm_pool_type_init()
   causes a deterministic NULL pointer dereference in the newly added
   error path."
   Now check list_lru_init return value in ttm_pool_type_init() and
   returns error if any.

 - Solved pre-existing issues reported by kernel test robot:
   - [High] `ttm_pool_type_init()` ignores the return value of
     `list_lru_init()`, leading to a NULL pointer dereference
     if allocation fails.

     Fix: get return value from list_lru_init and return error if any.

   - [High] `ttm_pool_shrink()` assumes `shrinker_list` is never empty,
     causing memory corruption and crashes during module unload
     if triggered.

     Fix: Check if shrinker_list is empty and return 0 if it is empty.

Changes in v4:
 - removed check return value in ttm_pool_mgr_init, now in new patch
 ("[PATCH] ttm: Add error handling for ttm_pool_mgr_init()")
 link [2] above.
 - Fixed check empty shrinker_list.
 - Check return value from ttm_pool_type_init.
 - Move up shrinker_alloc.
 - Deleted dput(backup_fault_inject.dname);
 - Fixed issue [High] The patch introduces a use-after-free race condition
   between `ttm_pool_type_fini()` and the active memory shrinker
   `ttm_pool_shrink()` by calling `list_lru_destroy()` prematurely as
   reported by kernel test robot.

   Fix: separate ttm_pool_type_fini and list_lru_destroy. Then, add
   ttm_pool_synchronize_shrinkers between them.
---
 drivers/gpu/drm/ttm/ttm_pool.c | 135 ++++++++++++++++++++++++++++-----
 1 file changed, 115 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 278bbe7a11ad..183836f2df34 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -354,17 +354,23 @@ static struct page *ttm_pool_type_take(struct ttm_pool_type *pt, int nid)
 }
 
 /* Initialize and add a pool type to the global shrinker list */
-static void ttm_pool_type_init(struct ttm_pool_type *pt, struct ttm_pool *pool,
+static int ttm_pool_type_init(struct ttm_pool_type *pt, struct ttm_pool *pool,
 			       enum ttm_caching caching, unsigned int order)
 {
+	int ret = 0;
+
 	pt->pool = pool;
 	pt->caching = caching;
 	pt->order = order;
-	list_lru_init(&pt->pages);
+	ret = list_lru_init(&pt->pages);
+	if (ret)
+		return ret;
 
 	spin_lock(&shrinker_lock);
 	list_add_tail(&pt->shrinker_list, &shrinker_list);
 	spin_unlock(&shrinker_lock);
+
+	return 0;
 }
 
 static enum lru_status pool_move_to_dispose_list(struct list_head *item,
@@ -438,6 +444,9 @@ static unsigned int ttm_pool_shrink(int nid, unsigned long num_to_free)
 	struct ttm_pool_type *pt;
 	unsigned int num_pages;
 
+	if ((shrinker_list.prev == &shrinker_list) && (shrinker_list.next == &shrinker_list))
+		return 0;
+
 	down_read(&pool_shrink_rwsem);
 	spin_lock(&shrinker_lock);
 	pt = list_first_entry(&shrinker_list, typeof(*pt), shrinker_list);
@@ -1198,6 +1207,17 @@ void ttm_pool_fini(struct ttm_pool *pool)
 	 * that no shrinker is concurrently freeing pages from the pool.
 	 */
 	ttm_pool_synchronize_shrinkers();
+
+	for (i = 0; i < TTM_NUM_CACHING_TYPES; ++i) {
+		for (j = 0; j < NR_PAGE_ORDERS; ++j) {
+			struct ttm_pool_type *pt;
+
+			pt = ttm_pool_select_type(pool, i, j);
+			if (pt != &pool->caching[i].orders[j])
+				continue;
+			list_lru_destroy(&pt->pages);
+		}
+	}
 }
 EXPORT_SYMBOL(ttm_pool_fini);
 
@@ -1376,6 +1396,54 @@ static inline u64 ttm_get_node_memory_size(int nid)
 	return managed_pages * PAGE_SIZE;
 }
 
+static void ttm_pool_type_fini_and_list_lru_destroy(unsigned int nr)
+{
+	unsigned int i;
+
+	if (nr == 0)
+		return;
+
+	for (i = 0; i < nr; ++i) {
+		ttm_pool_type_fini(&global_write_combined[i]);
+		ttm_pool_type_fini(&global_uncached[i]);
+		ttm_pool_type_fini(&global_dma32_write_combined[i]);
+		ttm_pool_type_fini(&global_dma32_uncached[i]);
+	}
+
+	/* We removed the pool types from the LRU, but we need to also make sure
+	 * that no shrinker is concurrently freeing pages from the pool.
+	 */
+	ttm_pool_synchronize_shrinkers();
+
+	for (i = 0; i < nr; ++i) {
+		list_lru_destroy(&global_write_combined[i].pages);
+		list_lru_destroy(&global_uncached[i].pages);
+		list_lru_destroy(&global_dma32_write_combined[i].pages);
+		list_lru_destroy(&global_dma32_uncached[i].pages);
+	}
+
+}
+
+static void ttm_pool_type_fini_and_list_lru_destroy_partial(
+				struct ttm_pool_type *types[], unsigned int n)
+{
+	unsigned int k;
+
+	if (n == 0)
+		return;
+
+	for (k = 0; k < n; ++k)
+		ttm_pool_type_fini(types[k]);
+
+	/* We removed the pool types from the LRU, but we need to also make sure
+	 * that no shrinker is concurrently freeing pages from the pool.
+	 */
+	ttm_pool_synchronize_shrinkers();
+
+	for (k = 0; k < n; ++k)
+		list_lru_destroy(&types[k]->pages);
+}
+
 /**
  * ttm_pool_mgr_init - Initialize globals
  *
@@ -1386,6 +1454,8 @@ static inline u64 ttm_get_node_memory_size(int nid)
 int ttm_pool_mgr_init(unsigned long num_pages)
 {
 	unsigned int i;
+	int ret = 0;
+	struct ttm_pool_type *types_free[3];
 
 	int nid;
 	for_each_node(nid) {
@@ -1400,15 +1470,53 @@ int ttm_pool_mgr_init(unsigned long num_pages)
 	spin_lock_init(&shrinker_lock);
 	INIT_LIST_HEAD(&shrinker_list);
 
+	mm_shrinker = shrinker_alloc(SHRINKER_NUMA_AWARE, "drm-ttm_pool");
+	if (!mm_shrinker)
+		return -ENOMEM;
+
 	for (i = 0; i < NR_PAGE_ORDERS; ++i) {
-		ttm_pool_type_init(&global_write_combined[i], NULL,
+		ret = ttm_pool_type_init(&global_write_combined[i], NULL,
 				   ttm_write_combined, i);
-		ttm_pool_type_init(&global_uncached[i], NULL, ttm_uncached, i);
+		if (ret) {
+			ttm_pool_type_fini_and_list_lru_destroy(i);
+			shrinker_free(mm_shrinker);
+			return ret;
+		}
+
+		ret = ttm_pool_type_init(&global_uncached[i], NULL, ttm_uncached, i);
+		if (ret) {
+			types_free[0] = &global_write_combined[i];
+			ttm_pool_type_fini_and_list_lru_destroy_partial(types_free, 1);
 
-		ttm_pool_type_init(&global_dma32_write_combined[i], NULL,
+			ttm_pool_type_fini_and_list_lru_destroy(i);
+			shrinker_free(mm_shrinker);
+			return ret;
+		}
+
+		ret = ttm_pool_type_init(&global_dma32_write_combined[i], NULL,
 				   ttm_write_combined, i);
-		ttm_pool_type_init(&global_dma32_uncached[i], NULL,
+		if (ret) {
+			types_free[0] = &global_write_combined[i];
+			types_free[1] = &global_uncached[i];
+			ttm_pool_type_fini_and_list_lru_destroy_partial(types_free, 2);
+
+			ttm_pool_type_fini_and_list_lru_destroy(i);
+			shrinker_free(mm_shrinker);
+			return ret;
+		}
+
+		ret = ttm_pool_type_init(&global_dma32_uncached[i], NULL,
 				   ttm_uncached, i);
+		if (ret) {
+			types_free[0] = &global_write_combined[i];
+			types_free[1] = &global_uncached[i];
+			types_free[2] = &global_dma32_write_combined[i];
+			ttm_pool_type_fini_and_list_lru_destroy_partial(types_free, 3);
+
+			ttm_pool_type_fini_and_list_lru_destroy(i);
+			shrinker_free(mm_shrinker);
+			return ret;
+		}
 	}
 
 #ifdef CONFIG_DEBUG_FS
@@ -1422,10 +1530,6 @@ int ttm_pool_mgr_init(unsigned long num_pages)
 #endif
 #endif
 
-	mm_shrinker = shrinker_alloc(SHRINKER_NUMA_AWARE, "drm-ttm_pool");
-	if (!mm_shrinker)
-		return -ENOMEM;
-
 	mm_shrinker->count_objects = ttm_pool_shrinker_count;
 	mm_shrinker->scan_objects = ttm_pool_shrinker_scan;
 	mm_shrinker->batch = TTM_SHRINKER_BATCH;
@@ -1443,16 +1547,7 @@ int ttm_pool_mgr_init(unsigned long num_pages)
  */
 void ttm_pool_mgr_fini(void)
 {
-	unsigned int i;
-
-	for (i = 0; i < NR_PAGE_ORDERS; ++i) {
-		ttm_pool_type_fini(&global_write_combined[i]);
-		ttm_pool_type_fini(&global_uncached[i]);
-
-		ttm_pool_type_fini(&global_dma32_write_combined[i]);
-		ttm_pool_type_fini(&global_dma32_uncached[i]);
-	}
-
 	shrinker_free(mm_shrinker);
+	ttm_pool_type_fini_and_list_lru_destroy(NR_PAGE_ORDERS);
 	WARN_ON(!list_empty(&shrinker_list));
 }
-- 
2.55.0

