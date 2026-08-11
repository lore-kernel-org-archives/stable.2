Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B619C426D09
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 14:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786459836; cv=none; b=RV/nQC2yaMBnoU+zJYSbKH82Q3E2RbhSo3Sw1H5ZJ5GJXtLYGbDLudnRaTIYxuQjttP36jeEQtUUWQ+gBbGC3A0zOofpVO6M7lReuxmzW/1ur627rQPTWrqamy7/jYrZDaX9TPG3xP3mnE7yD91JZ/D9m8Ph1MMT+o7Q0+rJCCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786459836; c=relaxed/simple;
	bh=xxUE5ns+ZtfNK/VGeW0kQyicDkb7f0xsH+e4UFZVQww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ojZg+4mEa6jJPNT7JgJjgy3JHFsxbAP1CdprcW+6YA5T6HEc4cRr4Xw3nHe/b4c1g8o1rayP+dwrxF1V1xFCQaoegyerfEeUbhEzAz/lMQasxMLZGilW/NvWVVl2qcM9nssLyp0AEsSTk0G+vnb5Bs7E9E8euFrATQ+Mdl1ywvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d3DXHZL8; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3DXHZL8"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47f703a9e5dso468448f8f.0
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 07:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786459833; x=1787064633; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=T/C40pZFD3SAhy+cbmZCTUE/hvWJQ8Wqu6WRVa95Iq8=;
        b=d3DXHZL8PzgjAYj99KZFqKQ23YLTrvHCAW66f1IFesGBNxu0lQ8FOcK3JDmwZRywFs
         FERkGHXk0ggmbnrwSJvbWcHEkohauEwmOQ4hIgFmeFSRP3py92B3fbnKa+D3YEsrS6v8
         HB8gXJE/SZUQ2wOXYT62HONN9aRwW77dCJL2l9Jyy0fE4CG+urc/Rp5Ky0P8VGQwYr5J
         DE39q/YYT/oy8OmGa9SZEiEjPwoe/gjz70WHsqTATuJzuvvcodxE7eoYnigs463ALYc/
         dlS1e1Aw7zlm89MtidAvgI372F0gEUXbqjVgRwfeyp7v42UPpNn3zt/3hrGXCUfhsg8/
         SzLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786459833; x=1787064633;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T/C40pZFD3SAhy+cbmZCTUE/hvWJQ8Wqu6WRVa95Iq8=;
        b=LEF31JGaQUBS2oijCxEuCLjVpQl0ROve+2jgnqHM0tRGNQz4BLesZBkC++0iTf3ZSI
         o0n1juqCFpixIL0SC2A63Y2AE0YIcLAFCMACkd0js7aWAX4YCapTQATdkqg1kPNhE64a
         XtfpjX3UE9jigd5Mkw8u77iKFZATVXGBgKqSlbz6Q6QDiDbWzq60EnBlKRZnhKGkskkz
         gJWBh4xEVd55VLof0A5nZX0RTYY5Q3CBkwxH27ADVi7HltVmfZMFqA0uMzpBEEtgLzQU
         gp8N86wZvilD8X/x4HSqrLM5y3FSwC3UP5Ni+xr21geSYWGIdC9ydMVcjRFK6voufX/B
         +uOA==
X-Gm-Message-State: AOJu0YzUny6ag5HOO//x7uuodNkqaTrdHwTLdHSsc6RN8VsDDLz25ooX
	j9HXAXcaydz4bzUU85Y6IPSdbhJK0+hsoG0WYxNg5oVH+5KFqnFI279So4NXyA==
X-Gm-Gg: AR+sD12+yamynfFJ/BHbQCumMppS3mf+8j8QD/MoLCrWZP3C1g4XvSfDu2emCWJuXGx
	6AIIYdvj660vg/oCZc/Ed8h8xGwkfFtIamSc/eiRGLt2u1ngbQ4BBPwLlf/houQxIryhDn5CGzs
	OlYVTIJHJMtwHS8PjgsW+bm+pIRlcxGbvKyhaE8Ru6HFdauWDnzEWqcuUPsEVntFY2TXdwgYzt5
	rU4UxwicHiCaYF8A08h9c8t2ZEFjteW26PEE9sEeEez7WnMwnjlWkX989cXFGTec2YXMwDvgtCL
	Z6RWFESZx2AZW7FbAAHC2opSwQtE9kylUdxS59eZeQGlDsJUiF9MuyA28r4Q6bZOO9HY/hMT7N9
	g5XBbcaCxm47OGw7nahdQ1h2e5o+6wlw2a7FvCHGA0Y7l7ar4OIc9RUll0xEF34rvbT/aI9r/Zz
	5m3qa/nqydmdWWquC+CzXbWAhXZ+dPNaDtum+AL8Fgz8ocCkj/bhycq4RsjHlGBx5+495431HOY
	6QH0rxFplT9pmLKOr0Ra+8TwrdFX+St7MXwAcnLep7Zp48Olwh+GlhqqcO4ZjOW
X-Received: by 2002:a05:6000:46cf:b0:481:5003:c654 with SMTP id ffacd0b85a97d-4815003c65dmr337494f8f.7.1786459832599;
        Tue, 11 Aug 2026 07:50:32 -0700 (PDT)
Received: from torre-GIGABYTE-B550-AORUS-ELITE-V2 (212.pool95-21-2.static.orange.es. [95.21.2.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4814a72cea1sm5646271f8f.37.2026.08.11.07.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 07:50:32 -0700 (PDT)
From: =?UTF-8?q?=C3=93scar=20Meg=C3=ADa=20L=C3=B3pez?= <megia.oscar@gmail.com>
To: megia.oscar@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH v5 1/6] Memory leak error in qxl unbind
Date: Tue, 11 Aug 2026 16:49:17 +0200
Message-ID: <20260811144957.69900-2-megia.oscar@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811144957.69900-1-megia.oscar@gmail.com>
References: <20260811144957.69900-1-megia.oscar@gmail.com>
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

Fixed check if shrinker_list is empty holding shrinker_lock.
Fixed check return value from ttm_pool_type_init and run
ttm_pool_type_fini and list_lru_destroy for every pt initialized.
Fixed change return value from ttm_pool_init to int.

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
 drivers/gpu/drm/ttm/ttm_pool.c | 65 +++++++++++++++++++++++++---------
 include/drm/ttm/ttm_pool.h     |  2 +-
 2 files changed, 49 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 278bbe7a11ad..3d6f024a815f 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -437,13 +437,24 @@ static unsigned int ttm_pool_shrink(int nid, unsigned long num_to_free)
 	LIST_HEAD(dispose);
 	struct ttm_pool_type *pt;
 	unsigned int num_pages;
+	int empty = 0;
 
 	down_read(&pool_shrink_rwsem);
 	spin_lock(&shrinker_lock);
-	pt = list_first_entry(&shrinker_list, typeof(*pt), shrinker_list);
-	list_move_tail(&pt->shrinker_list, &shrinker_list);
+	if ((shrinker_list.prev == &shrinker_list) && (shrinker_list.next == &shrinker_list))
+	{
+		empty = 1;
+	}
+	else
+	{
+		pt = list_first_entry(&shrinker_list, typeof(*pt), shrinker_list);
+		list_move_tail(&pt->shrinker_list, &shrinker_list);
+	}
 	spin_unlock(&shrinker_lock);
 
+	if (empty)
+		return 0;
+
 	num_pages = list_lru_walk_node(&pt->pages, nid, pool_move_to_dispose_list, &dispose, &num_to_free);
 	num_pages *= 1 << pt->order;
 
@@ -1122,6 +1133,18 @@ long ttm_pool_backup(struct ttm_pool *pool, struct ttm_tt *tt,
 	return shrunken ? shrunken : ret;
 }
 
+/**
+ * ttm_pool_synchronize_shrinkers - Wait for all running shrinkers to complete.
+ *
+ * This is useful to guarantee that all shrinker invocations have seen an
+ * update, before freeing memory, similar to rcu.
+ */
+static void ttm_pool_synchronize_shrinkers(void)
+{
+	down_write(&pool_shrink_rwsem);
+	up_write(&pool_shrink_rwsem);
+}
+
 /**
  * ttm_pool_init - Initialize a pool
  *
@@ -1132,10 +1155,13 @@ long ttm_pool_backup(struct ttm_pool *pool, struct ttm_tt *tt,
  *
  * Initialize the pool and its pool types.
  */
-void ttm_pool_init(struct ttm_pool *pool, struct device *dev,
+int ttm_pool_init(struct ttm_pool *pool, struct device *dev,
 		   int nid, unsigned int alloc_flags)
 {
-	unsigned int i, j;
+	unsigned int i, j, k;
+	int ret;
+	struct ttm_pool_type *initialized[TTM_NUM_CACHING_TYPES * NR_PAGE_ORDERS];
+	unsigned int n_initialized = 0;
 
 	WARN_ON(!dev && ttm_pool_uses_dma_alloc(pool));
 
@@ -1152,23 +1178,28 @@ void ttm_pool_init(struct ttm_pool *pool, struct device *dev,
 			if (pt != &pool->caching[i].orders[j])
 				continue;
 
-			ttm_pool_type_init(pt, pool, i, j);
+			ret = ttm_pool_type_init(pt, pool, i, j);
+			if (ret)
+				goto error;
+
+			initialized[n_initialized++] = pt;
 		}
 	}
-}
-EXPORT_SYMBOL(ttm_pool_init);
 
-/**
- * ttm_pool_synchronize_shrinkers - Wait for all running shrinkers to complete.
- *
- * This is useful to guarantee that all shrinker invocations have seen an
- * update, before freeing memory, similar to rcu.
- */
-static void ttm_pool_synchronize_shrinkers(void)
-{
-	down_write(&pool_shrink_rwsem);
-	up_write(&pool_shrink_rwsem);
+	return 0;
+
+error:
+	for (k = 0; k < n_initialized; ++k)
+		ttm_pool_type_fini(initialized[k]);
+
+	ttm_pool_synchronize_shrinkers();
+
+	for (k = 0; k < n_initialized; ++k)
+		list_lru_destroy(&initialized[k]->pages);
+
+	return ret;
 }
+EXPORT_SYMBOL(ttm_pool_init);
 
 /**
  * ttm_pool_fini - Cleanup a pool
diff --git a/include/drm/ttm/ttm_pool.h b/include/drm/ttm/ttm_pool.h
index 26ee592e1994..66248323c2c1 100644
--- a/include/drm/ttm/ttm_pool.h
+++ b/include/drm/ttm/ttm_pool.h
@@ -81,7 +81,7 @@ int ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 		   struct ttm_operation_ctx *ctx);
 void ttm_pool_free(struct ttm_pool *pool, struct ttm_tt *tt);
 
-void ttm_pool_init(struct ttm_pool *pool, struct device *dev,
+int ttm_pool_init(struct ttm_pool *pool, struct device *dev,
 		   int nid, unsigned int alloc_flags);
 void ttm_pool_fini(struct ttm_pool *pool);
 
-- 
2.55.0

