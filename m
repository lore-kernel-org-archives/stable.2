Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D990367B62
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 15:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782400681; cv=none; b=Emlp+McyArlHZgJiDMRy/7mpn1SXYX0Cwb5xM+x5A0HoIKy6/ArTHkGgYV/KyRC28QstDjJcI8yXg1mLwYFUgDTsjw/gPYlt8niZFYf/GkTzcw8LPfeE6STFrfSdmUL+C29x8PdeDJ3UkaMfCMlGIBFYE7cDnB655QKdBh/TfBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782400681; c=relaxed/simple;
	bh=ekx5cr7T299wlK8jCLijW3dhHd83+VG4kNX/35JMfiM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DjIw5861wmOAxUNsPkdLxU1xK6s2GHLungnJjRpMF07KWeOa74wbhVhJPGQ1jb0ovnf5u+YNPNeG0DbENNPksp1xiWsKjk3QXQKxgOajQjWduAgKwsqk6mokAfFr0GmSw/+7+KSWkkqhXe70g45SGFZI25DBITDOCwfN+7na4jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=araeRisd; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="araeRisd"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782400676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0abFjDD7MeWR8jXMZ2j0zCKAbj5uTG1W2qlcF8YqFc4=;
	b=araeRisdZjkkXDB5B5YHuyjgxiM3QgILhTA3HYQM2YO4riqCwXB16muACRB18zccxmj6HB
	uk5sdyKDreRF+CYXqUsePISuTN1byrhnIsvTqYnq8CpyfVWyZlNIte2FgGzk+V6kjepyj3
	1MUTcDj9eg6EsdVDrA1sykzJH9DqGZo=
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
Subject: [PATCH v3] mm: mglru: fix stale batch updates after memcg reparenting
Date: Thu, 25 Jun 2026 23:15:54 +0800
Message-ID: <20260625151554.55105-1-qi.zheng@linux.dev>
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
---
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

 mm/vmscan.c | 45 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 38 insertions(+), 7 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 35c3bb15ae96..1ec8c23c72b9 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3262,10 +3262,44 @@ static void update_batch_size(struct lru_gen_mm_walk *walk, struct folio *folio,
 	walk->nr_pages[new_gen][type][zone] += delta;
 }
 
+#ifdef CONFIG_MEMCG
+static struct lruvec *lock_batch_lruvec(struct lruvec *lruvec)
+{
+	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
+	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
+
+	rcu_read_lock();
+
+	/*
+	 * The memcg can be NULL when the memory controller is disabled.
+	 * Otherwise, the caller keeps the memcg owning @lruvec alive.
+	 */
+	if (!memcg || !css_is_dying(&memcg->css))
+		goto lock;
+
+	do {
+		memcg = parent_mem_cgroup(memcg);
+	} while (memcg && css_is_dying(&memcg->css));
+	lruvec = mem_cgroup_lruvec(memcg, pgdat);
+
+lock:
+	spin_lock_irq(&lruvec->lru_lock);
+
+	return lruvec;
+}
+#else
+static struct lruvec *lock_batch_lruvec(struct lruvec *lruvec)
+{
+	lruvec_lock_irq(lruvec);
+
+	return lruvec;
+}
+#endif
+
 static void reset_batch_size(struct lru_gen_mm_walk *walk)
 {
 	int gen, type, zone;
-	struct lruvec *lruvec = walk->lruvec;
+	struct lruvec *lruvec = lock_batch_lruvec(walk->lruvec);
 	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 
 	walk->batched = 0;
@@ -3285,6 +3319,8 @@ static void reset_batch_size(struct lru_gen_mm_walk *walk)
 			lru += LRU_ACTIVE;
 		__update_lru_size(lruvec, lru, zone, delta);
 	}
+
+	lruvec_unlock_irq(lruvec);
 }
 
 static int should_skip_vma(unsigned long start, unsigned long end, struct mm_walk *args)
@@ -3779,11 +3815,8 @@ static void walk_mm(struct mm_struct *mm, struct lru_gen_mm_walk *walk)
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
@@ -4867,9 +4900,7 @@ static int evict_folios(unsigned long nr_to_scan, struct lruvec *lruvec,
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

