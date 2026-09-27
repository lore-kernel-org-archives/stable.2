Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABED363C6F
	for <stable@vger.kernel.org>; Sun, 27 Sep 2026 10:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790505158; cv=none; b=FYBZhY5Wwf+VAKCVnkp7IGDyV58+VvKAwcBia5oeyBVg82MjoAhp0G8AajufbsEoND9zKVeJdjSMIOpDKA9ZK2PrpLBbC6a+wqwOQvLQsoPfsmMgsl1MPj1LxNzZGpoR7RQ135y9+9KqAkonGK2VS0f3Mgqe6zrchbQGyS1b2O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790505158; c=relaxed/simple;
	bh=VADAQDY3LuFUiFZ861zgafnVfH1m3pFcM9dQhwGfLg4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IsMqQtKil7R4IEuDiS9w4yZoSWhrRmH21MVcRO6W67R46Zl5QeYbboU9gmid1TiXxIIqw5K91xxjxGUat22GgQ+hztWlH0GbLVUPS5j5wpJRZd10b1vgWxUglSQpxR2OtzwVLhjaanIICNBVB7uIslKxS7wGU78IxWvd26fsH+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=phLgZl76; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="phLgZl76"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e7d2bb404so6965125e9.1
        for <stable@vger.kernel.org>; Sun, 27 Sep 2026 03:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790505155; x=1791109955; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=45tBD3kZBcNwqDCe4McFRRFSHceImT3aj0kJG1xkuLo=;
        b=phLgZl76tRFWgJMDMvkblerRj/O/iXqN5RPWVcLZVcO94oHdlw+4jtwU50lQ5pm/R4
         89oBbh392Aq6JQbO5LT3b3ZKbKA/r/WlO1IGIMtx7pX8tmlNbEmUhp+Dot8dUVsOCWGF
         eDK/1rt25b3L4q+gkwjiFsD6RgSZhDj0AM07KP5dIY1VtcQu7LK40IZOuhnp3Rke78iW
         iI6d2RQ1QWmvAVb1+D0gqlDxL8F6FvqGdNhYtPBYa36Nwgs1lBCrLSrvczUIN/mGO1ww
         3ChcZP9SIHEUbv8jb+vMsNM5msvlnRxY1FEyRf4rT5SZFLO3HHDD//G72WmuANz5zac5
         861w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790505155; x=1791109955;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=45tBD3kZBcNwqDCe4McFRRFSHceImT3aj0kJG1xkuLo=;
        b=bI+nFJ2rRk80KTIlDCJzacGFoNL36xtvbXq5oCnq+wPp+hpwsgeKRREQf4iJjIyWU6
         XMmep99Illoc2cnnt+vk/iVNp7sdjvh8AyrYplsscgTWAVGiSHT88YdvC3760r24IqAn
         B1RF3YC5ngqmaZ8dk8VwCBTyFgagSwjJuPQl+ImCDMFQUhhfMyvCEStrPo4os69pis8+
         6vVFpsyelAZs5+nsKA/qr+c7Jhw9dnW7gdbMgWVBmMv676I+j65M9iZyMp81RU8BOY/L
         cGjCfxPJJsPN1eipNT2VleewVp1ixEMlTHtPRu1ew3LKlHgiJNnFW2LXnZ10PDbXhJbF
         lwrA==
X-Forwarded-Encrypted: i=1; AKwUvBy7pvuP3d42e5CTAPiz3JRbkKwaZ5ivqJsK8qDClLYYjL475nsNJs4n1X/XMRkMmzbSt24QT5M=@vger.kernel.org
X-Gm-Message-State: AFuF++kKJyNbZ2IGvgBbAed/a44/jUzkc9DgZkCaDVLzBqCNQ8p+fzeu
	CvqLaSn6JOlv3+4yGn1JEy8K7KSHYnmKaTr4I0Q1PZdmYuf0iBJB6TMr
X-Gm-Gg: AYBFou2SWkG2J77NxdeA9aRe/41uAiRU9NL9YzVnl9ewUtze58aYqxcWB4ZnYUg5Ety
	IdUlfslyWf+HBaPl9fIl/bAAiojw7PhhIQXKzW0N13QQgngkWNgUp2yU2XR1qCQJOp2vSqnWVhv
	7847NlDrGBAEhU9f50q6tulpjIokJq1geH4yYrTbK82hjIqIDy8P1f0rSpXhCydWAEfs6EuLJxZ
	b1ogenhV8NtGeZ9cpzDvBFKujHWRM95b3GBSzrVBj2Qu9dI+MmUfl9QRxrImFLxDGzBGfFGTluI
	PvKqaZTag2HNvk2maGQlxDO/PbSi944w7vLUsTtE6N1eNZg1ccx8dkH/27U1eCcG7OPkh1Z7joP
	1VcVGAwd7LmiLSoToIoiDBRJeC/XKbf+vQ4uxwGGgvlnDxL6+ZHYa1H49d76fKQ2lT634YvkiZg
	hi+9K4xVbzi+UtLrfrlOBcobQtQS8R4g0UByrjsN+knq8V+IDSg00S2UkpkdHs4hooin5WJFuhh
	9OCfeKSguTNLYdBJINRIa1Qq0QHvBUNyxb4Qv6cBzmTBERXOyjGhb/kzB+FVw==
X-Received: by 2002:a05:600c:a00e:b0:49e:6865:904e with SMTP id 5b1f17b1804b1-49fe66f176dmr201357565e9.12.1790505155186;
        Sun, 27 Sep 2026 03:32:35 -0700 (PDT)
Received: from torre-GIGABYTE-B550-AORUS-ELITE-V2 (212.pool95-21-2.static.orange.es. [95.21.2.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ffd137346sm79586805e9.1.2026.09.27.03.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 03:32:34 -0700 (PDT)
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
Subject: [PATCH v6] Memory leak error in qxl unbind
Date: Sun, 27 Sep 2026 12:32:27 +0200
Message-ID: <20260927103231.47692-1-megia.oscar@gmail.com>
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
(I updated it and added udevadm settle to allow the cache to
recover):

i=0;\
while [ 1 -eq 1 ]; do\
    i=$((i+1)); echo 0000:00:01.0 > /sys/bus/pci/drivers/qxl/unbind;\
    if (($i%1000==0)); then\
        echo loops=$i; free;\
        grep nr_free_pages /proc/vmstat;\
        grep -E "VmallocUsed|Slab|Reclaimable|SUnreclaim" /proc/meminfo;\
        sync; echo 3 > /proc/sys/vm/drop_caches;\
        echo 1 > /proc/sys/vm/compact_memory;\
        echo "running udevadm settle;";\
        udevadm settle;\
        free;\
        grep nr_free_pages /proc/vmstat;\
        grep -E "VmallocUsed|Slab|Reclaimable|SUnreclaim" /proc/meminfo;\
        uptime;\
    fi;\
    echo 0000:00:01.0 > /sys/bus/pci/drivers/qxl/bind;\
done

ttm_pool_mgr_fini() does not destroy the list lru leaving memory leak.

Fix: Add list_lru_destroy() after ttm_pool_type_fini().

This patch depends on patch ("[PATCH v4] drm/qxl: fix use-after-free in
qxl_irq_handler on PCI"), link [1] below.

Assisted-by: OpenCode:1.17.18-Big Pickle/DeepSeek V4 Flash
Assisted-by: https://claude.ai:Sonnet 5
Assisted-by: https://gemini.google.com:3.6 Flash
Link: https://lore.kernel.org/virtualization/
20260927101026.45411-1-megia.oscar@gmail.com/ [1]
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

Changes in v5:
 - In ttm_pool_init() return int and check return value from
   ttm_pool_type_init and propagate error. Free pt and pg->pages
   if returns error.
 - In ttm_pool_mgr_init() free previous ttm_pool_type_init() if returns
   error.
 - In ttm_global_init() check return value from ttm_pool_mgr_init() and
   propagate.

Changes in v6:
 - Add list_lru_destroy in ttm_pool_mgr_fini to avoid memory leak.
---
 drivers/gpu/drm/ttm/ttm_pool.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 278bbe7a11ad..09fdfe45e39f 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -1453,6 +1453,18 @@ void ttm_pool_mgr_fini(void)
 		ttm_pool_type_fini(&global_dma32_uncached[i]);
 	}
 
+	/* We removed the pool types from the LRU, but we need to also make sure
+	 * that no shrinker is concurrently freeing pages from the pool.
+	 */
+	ttm_pool_synchronize_shrinkers();
+
+	for (i = 0; i < NR_PAGE_ORDERS; ++i) {
+		list_lru_destroy(&global_write_combined[i].pages);
+		list_lru_destroy(&global_uncached[i].pages);
+		list_lru_destroy(&global_dma32_write_combined[i].pages);
+		list_lru_destroy(&global_dma32_uncached[i].pages);
+	}
+
 	shrinker_free(mm_shrinker);
 	WARN_ON(!list_empty(&shrinker_list));
 }
-- 
2.55.0

