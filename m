Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F3B478869
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 19:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786477363; cv=none; b=alod42/xEw1tAZYu2/c4gyLC0Rmpl11ch9i+9wWb9sXp+bIIVSnqmAWWGO4bQDeWJMRCWBGfZ1OpnKQdEV4WjlwPpQAOIdcYZbo1oQQJSQxmQIePfFAJUxs0FGhYRiS9x3n8ghLLYq0t5RdT4k+Gb4Yrvn9DiDY20O0dvIs/RWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786477363; c=relaxed/simple;
	bh=sD2zqEI8mU6Stm2UFCGxVthy9dR8oc2MSeMLosLduRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=STA1fj2IPeU2m3zbyXWlg+UQg0GoYLe4+pjkKyWpUgwnG0WI4+IUCiwWqL8c6IZSTpcb1Mk68tMXqaZva4RrK4rxLcvVmhu8j81Shmg9FWvHh7w8qRtK0FqS2dIVbaBiUWQfBFa1IN/ZZJ1ReA+s080KckXkBxpYek+VFRuSdlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C25d6HM8; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C25d6HM8"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4956242332dso1320305e9.2
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 12:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786477360; x=1787082160; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Yi6COyPD9cih637RhWmDl/GrYJABMEvAXSPzHDaHyRc=;
        b=C25d6HM8BL3i+Xm0ff+3ZyeovlzqLMX4MJk64OcFVarbvLv/KI5ug2I4fvbLdPHs29
         bd/9ELmKqpICGAUNmM026TKljQZIcy1A5Dd2eLWzRFQyUOZzZUAUxF+G9TcCMIGEzNQS
         gBBnUaPmrQB+NzyghT86SrX4skoCzAnq0bxcgQhWq7NC/EA0I9TpqMBvryCGqFjfGyeW
         QjYvazo6Cd9Db6u6lR1lPAl/qX/0IjhvwFGrGjDqFkzfTvj40yyXD3HsqMoJLHb0OhU8
         oQjOTzAnmd27BrI2+82vDQUbPTIWxSIddzwQ1Ja4kzkJEY1a1lRPLlGgLovwJuNUwKYf
         Yfig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786477360; x=1787082160;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yi6COyPD9cih637RhWmDl/GrYJABMEvAXSPzHDaHyRc=;
        b=XBsXc73MeHVrDf4N7D2fKEZpsLRyngtO8MTm9MnUI6GqMppKD5HtGLhBT2CpFUA35N
         gPl1GLFB+Fovt2SDLlRu4MSZdCmEJ5C0+NDUZBBXMZqTWhyQ8XqHVjhjRcCjWQkE5mNH
         DPHH8xBpJHIp2dKAy+7vhC7WS4UPVWSkArvrInvFrx98dthsDp6SN5ia9eVQdJrg5hf0
         Cxi1+PbhVDexY3tBBRAy6WKn2NDND9e8m4hnBx+ljcayXgr6nvL2P30zDm1sVJyG1WTr
         jp5W9ikRwLKlA8aFW/EIYdNMvV34L1nukhdaQmN138BFJuQeQPsHR1bB66ym4BDnXd3o
         a2eA==
X-Forwarded-Encrypted: i=1; AHgh+Rq3YzM9IbeH8knRxLnqwhRNsrQN78+ujpuC8ZWFsYQGkPneCi8ThysG8xh1/rIk+pamVwrxjSo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx08x3+HQQUJprXsP31Qed6VsXB4oQSfbqU/YraKVlR8hnrEVKF
	Qfy0ZzRN8ziB6kyGAMQyS80WjvOFwPwv3Aj+2sLGd+6Ouy+9+M5ponYM
X-Gm-Gg: AR+sD13kPbWIRrsQVXRRcvQv+MuIEkSbLoNQNBhhLzY5Zmev2lYgKJxMGOVp24+mms8
	QPInDwoJo3SLREoLkDQFJ/UGOmNnMOrGycs4C3y4DCQGiHHD06jMOb9RlvC3Awa5VMLk4XLT2Jw
	Z/WTjbe/1yiqlfhqHBwsEJlAIAoro4B+seZz1b+zICkbnuDq/TZcepMtuvJy02UA6cFgBvHpGWb
	aGqF9S9vRqNZWEJdL1Fo7IseJOovt5Mmko+tPVkRyy7x7szMEGhveJIBkTXXMtDWMzDFj3vJzJU
	2R2lAmYiObcNBohepdiYRjAl8G66XRxGP/1vnGOUXclIQ8kSBk+mbBd4FsvpOoWbPdpB8T8lmKl
	FFhHC5LIcUQA1w2jTDj/ubG1WmYk4l5grLvmdfen4D444NtTU0z6cDqYP81PqKAMbBnbpvHGrZ3
	Pf3iIi96Wyxf8kUyxHEyCjggKyh+e/LHupkMg7f1OuIOwN5a/5/Pvq09649MFKVW0jdWdNrjWPp
	ajMylKb7lB0ZFA2no7T8NqaVBwzetd12i52mI86CZawho7+i+nX
X-Received: by 2002:a05:600c:4f86:b0:496:c378:6420 with SMTP id 5b1f17b1804b1-4997843b3famr69845395e9.8.1786477359442;
        Tue, 11 Aug 2026 12:42:39 -0700 (PDT)
Received: from torre-GIGABYTE-B550-AORUS-ELITE-V2 (212.pool95-21-2.static.orange.es. [95.21.2.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997adad05esm3986195e9.3.2026.08.11.12.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 12:42:39 -0700 (PDT)
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
Subject: [PATCH v5 1/6] Memory leak error in qxl unbind
Date: Tue, 11 Aug 2026 21:42:16 +0200
Message-ID: <20260811194224.121597-2-megia.oscar@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811194224.121597-1-megia.oscar@gmail.com>
References: <20260811194224.121597-1-megia.oscar@gmail.com>
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
 drivers/gpu/drm/ttm/ttm_pool.c | 62 ++++++++++++++++++++++++----------
 include/drm/ttm/ttm_pool.h     |  2 +-
 2 files changed, 46 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 278bbe7a11ad..88c0d33eed1a 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -437,13 +437,21 @@ static unsigned int ttm_pool_shrink(int nid, unsigned long num_to_free)
 	LIST_HEAD(dispose);
 	struct ttm_pool_type *pt;
 	unsigned int num_pages;
+	int empty = 0;
 
 	down_read(&pool_shrink_rwsem);
 	spin_lock(&shrinker_lock);
-	pt = list_first_entry(&shrinker_list, typeof(*pt), shrinker_list);
-	list_move_tail(&pt->shrinker_list, &shrinker_list);
+	if ((shrinker_list.prev == &shrinker_list) && (shrinker_list.next == &shrinker_list)) {
+		empty = 1;
+	} else {
+		pt = list_first_entry(&shrinker_list, typeof(*pt), shrinker_list);
+		list_move_tail(&pt->shrinker_list, &shrinker_list);
+	}
 	spin_unlock(&shrinker_lock);
 
+	if (empty)
+		return 0;
+
 	num_pages = list_lru_walk_node(&pt->pages, nid, pool_move_to_dispose_list, &dispose, &num_to_free);
 	num_pages *= 1 << pt->order;
 
@@ -1122,6 +1130,18 @@ long ttm_pool_backup(struct ttm_pool *pool, struct ttm_tt *tt,
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
@@ -1132,10 +1152,13 @@ long ttm_pool_backup(struct ttm_pool *pool, struct ttm_tt *tt,
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
 
@@ -1152,23 +1175,28 @@ void ttm_pool_init(struct ttm_pool *pool, struct device *dev,
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

