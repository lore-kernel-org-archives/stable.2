Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB85435EF0
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 15:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783698256; cv=none; b=Nj7h6mMnQ2XHoFyFewI4ZEW7fZYOAsqRojL6grqxMuK20M6kjc7e8QZc8hEv4ZGHrJRrTkoMtNT5mVi+VBKQFRpvSneb9d2ARHsxIDxj8rFOvq4ljoL+uV8Zo65AIX2dm/z5AU9ffP+PpKI/yx2JO3XBt2ShNy4r1IjNz4dNxZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783698256; c=relaxed/simple;
	bh=zjmyzRBsCBM/W5pCHKR8WbASYjQoEG3syzN9fxyFj0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QzSCD0lQJa58Oe3VzvJLpmkKzG6KceNA1fs1mkZJ41NHiDu+4yC9aUibNpSdcQ3CQu5VpQk31Zf6d4fOLJKiw++L/WYVKmrIcXCRwFFwbDrVe3iSEJWaqvBNOjSD/yV5+EfQwjswYDVzvYuHi65rSoUw+1To70e4APxlk8faNE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cDeQqpyd; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cDeQqpyd"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783698231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/60L6Gw7LaN6NkHAg/NT5Zrh/O6NlqQ8F4DkibQxuFk=;
	b=cDeQqpydjIuRjVm7QrrG8tYD4fmABjnIWojxi26sfQ6ogWR+27YgI1RC1Djgt55UpXsodx
	R/poROmIofG4314ypP+lOm1nQ5seu5a3JlyBg225TeR2wh8zDKM7xPdbH1GoAvTYtHJLLs
	CdIxtvMDSyNySfxhJt0G6kp8xJkWv0c=
From: Qi Zheng <qi.zheng@linux.dev>
To: akpm@linux-foundation.org,
	david@kernel.org,
	kasong@tencent.com,
	shakeel.butt@linux.dev,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	hannes@cmpxchg.org,
	harry@kernel.org,
	muchun.song@linux.dev,
	peiyang_he@smail.nju.edu.cn,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	ljs@kernel.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	stable@vger.kernel.org
Subject: [PATCH v5] mm: mglru: fix stale batch updates after memcg reparenting
Date: Fri, 10 Jul 2026 23:43:18 +0800
Message-ID: <20260710154318.75388-1-qi.zheng@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Qi Zheng <zhengqi.arch@bytedance.com>

The mglru page table walker batches per-generation size deltas in
walk->nr_pages while walking page tables without holding the lruvec lock.
The reset_batch_size() later folds those deltas into walk->lruvec under
the lruvec lock.

The page table walker can run concurrently with the memcg reparenting path
as follows:

CPU0                           CPU1
====                           ====

walk_mm
--> walk_page_range
    --> update_batch_size
        --> walk->nr_pages += delta

                              mem_cgroup_css_offline
                              --> memcg_reparent_objcgs
                                  --> lock lruvec
                                      lru_gen_reparent_memcg
                                      --> reparent child folios to parent
                                      unlock lruvec

    lock lruvec
    reset_batch_size
    --> child lrugen->nr_pages += delta

This will trigger the following warning in lru_gen_exit_memcg():

	VM_WARN_ON_ONCE(memchr_inv(lruvec->lrugen.nr_pages, 0,
				   sizeof(lruvec->lrugen.nr_pages)));

And the user-visible impact of underestimated nr_pages in MGLRU was
premature OOMs because MGLRU does not try to reclaim memory when nr_pages
reaches zero, but there are still more pages.

To fix it, make reset_batch_size() check CSS_DYING under RCU before
flushing the pending batch. A non-dying memcg keeps the original lruvec
stable against RCU-delayed offlining; a dying memcg redirects the deltas
to the first non-dying ancestor.

Reported-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
Closes: https://lore.kernel.org/all/5A9E929D82717101+12fcf643-efb8-4b9a-a53a-1e28cc894f0b@smail.nju.edu.cn
Fixes: f304652609ea ("mm: vmscan: prepare for reparenting MGLRU folios")
Cc: <stable@vger.kernel.org>
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>
---
Changes in v5:
 - rename lock_batch_lruvec() to lruvec_live_lock_irq(), and move it to
   include/linux/memcontrol.h
   (suggested by Johannes and Shakeel)

Changes in v4:
 - re-implement lock_batch_lruvec() in a simpler way
   (suggested by Johannes and Harry)
 - collect Reviewed-by
 - rebase onto the next-20260630

Changes in v3:
 - re-implement lock_batch_lruvec() by checking CSS_DYING under the RCU lock
   (suggested by Harry)
 - update the commit message (suggested by Harry)
 - temporarily drop the previous Reviewed-by tags
   (since the sync method has changed)
 - rebase onto the next-20260624

Changes in v2:
 - update the commit message (pointed by Barry)
 - collect Reviewed-by

 include/linux/memcontrol.h | 25 +++++++++++++++++++++++++
 mm/vmscan.c                | 11 ++++-------
 2 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index e1f46a0016fcf..9572606776781 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1472,6 +1472,31 @@ static inline void lruvec_lock_irq(struct lruvec *lruvec)
 	spin_lock_irq(&lruvec->lru_lock);
 }
 
+static inline struct lruvec *lruvec_live_lock_irq(struct lruvec *lruvec)
+{
+#ifdef CONFIG_MEMCG
+	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
+	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
+
+	rcu_read_lock();
+
+	/*
+	 * The memcg can be NULL when the memory controller is disabled.
+	 * Otherwise, the caller keeps the memcg owning @lruvec alive.
+	 */
+	while (unlikely(memcg && css_is_dying(&memcg->css))) {
+		memcg = parent_mem_cgroup(memcg);
+		lruvec = mem_cgroup_lruvec(memcg, pgdat);
+	}
+
+	spin_lock_irq(&lruvec->lru_lock);
+#else
+	lruvec_lock_irq(lruvec);
+#endif
+
+	return lruvec;
+}
+
 static inline void lruvec_unlock(struct lruvec *lruvec)
 {
 	spin_unlock(&lruvec->lru_lock);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 35c3bb15ae96a..1a142c58700d0 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3265,7 +3265,7 @@ static void update_batch_size(struct lru_gen_mm_walk *walk, struct folio *folio,
 static void reset_batch_size(struct lru_gen_mm_walk *walk)
 {
 	int gen, type, zone;
-	struct lruvec *lruvec = walk->lruvec;
+	struct lruvec *lruvec = lruvec_live_lock_irq(walk->lruvec);
 	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 
 	walk->batched = 0;
@@ -3285,6 +3285,8 @@ static void reset_batch_size(struct lru_gen_mm_walk *walk)
 			lru += LRU_ACTIVE;
 		__update_lru_size(lruvec, lru, zone, delta);
 	}
+
+	lruvec_unlock_irq(lruvec);
 }
 
 static int should_skip_vma(unsigned long start, unsigned long end, struct mm_walk *args)
@@ -3779,11 +3781,8 @@ static void walk_mm(struct mm_struct *mm, struct lru_gen_mm_walk *walk)
 			mmap_read_unlock(mm);
 		}
 
-		if (walk->batched) {
-			lruvec_lock_irq(lruvec);
+		if (walk->batched)
 			reset_batch_size(walk);
-			lruvec_unlock_irq(lruvec);
-		}
 
 		cond_resched();
 	} while (err == -EAGAIN);
@@ -4867,9 +4866,7 @@ static int evict_folios(unsigned long nr_to_scan, struct lruvec *lruvec,
 	walk = current->reclaim_state->mm_walk;
 	if (walk && walk->batched) {
 		walk->lruvec = lruvec;
-		lruvec_lock_irq(lruvec);
 		reset_batch_size(walk);
-		lruvec_unlock_irq(lruvec);
 	}
 
 	mod_lruvec_state(lruvec, PGDEMOTE_KSWAPD + reclaimer_offset(sc),
-- 
2.54.0

