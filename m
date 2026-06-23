Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD12386573
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 02:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782182684; cv=none; b=TvG9KrkwKyrjzlJDZgHyfZojqRHVe7B7e9YZozWoVjXyLtnyj6dOjd/q3Pu9wFOibNTY+ViadbsVFrLCw48CzJoiFg1LClVo0rBJZiUUHGHTkz6xybtFuOfWt26q99mKgBNHwOgjmlDEp9yWwm7Tx+NcOniyWFtiFPDWGVhuPOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782182684; c=relaxed/simple;
	bh=M4cTZOsUtp3cYswHivr9vnJI0i1A+C1YgFKpFVlh9PQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d8TwNCSrmmlGvmkXTVCeay3+Vj3t2VeLBLRCKbNpgpgF1dklxQN2wdVKgUM8UgmCPcQylU86XSesijqnZ2gwTX/oomPRtXrG9DxwV8clnCWeK3+6LN6Xphr93TZapoN9krf/umdRJO5ZMstMmT93AgZ7zauMWt2MPNsNMQe86EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PJaN6uT9; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PJaN6uT9"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782182670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=a8+eeytXWCIVLCbNBOynGcBvbUA5M39lvYGkiNnFZO8=;
	b=PJaN6uT9J5NDYZoml3Hbdmj+s929N+ngw8MxLLg7VrG/3KFVLHJ00nBb8oVd4Pevs3i3WX
	DmnWEBkUt16AaqT/66s8Nw9kMBzMCS9/jybeucwFcjVSWTmkVRDi5Q92oib9s2Ma5zrafi
	dFJfp1wUHfx4vfdPehzulUYLwsoDnyQ=
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
Subject: [PATCH v2] mm: mglru: fix stale batch updates after memcg reparenting
Date: Tue, 23 Jun 2026 10:42:37 +0800
Message-ID: <20260623024237.45990-1-qi.zheng@linux.dev>
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

To fix it, add lrugen->reparented to remember the new owner of a
reparented lruvec, and make reset_batch_size() charge pending deltas to
that owner.

Reported-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
Closes: https://lore.kernel.org/all/5A9E929D82717101+12fcf643-efb8-4b9a-a53a-1e28cc894f0b@smail.nju.edu.cn
Fixes: f304652609ea ("mm: vmscan: prepare for reparenting MGLRU folios")
Cc: <stable@vger.kernel.org>
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Barry Song <baohua@kernel.org>
---
 include/linux/mmzone.h |  4 ++++
 mm/vmscan.c            | 43 +++++++++++++++++++++++++++++++++++-------
 2 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index ca2712187147..0d572db2ef64 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -584,6 +584,10 @@ struct lru_gen_folio {
 	u8 gen;
 	/* the list segment this lru_gen_folio belongs to */
 	u8 seg;
+#ifdef CONFIG_MEMCG
+	/* the lruvec this lruvec has been reparented to */
+	struct lruvec *reparented;
+#endif
 	/* per-node lru_gen_folio list for global reclaim */
 	struct hlist_nulls_node list;
 };
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 35c3bb15ae96..64362cbed814 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3262,10 +3262,37 @@ static void update_batch_size(struct lru_gen_mm_walk *walk, struct folio *folio,
 	walk->nr_pages[new_gen][type][zone] += delta;
 }
 
+#ifdef CONFIG_MEMCG
+static struct lruvec *lock_batch_lruvec(struct lruvec *lruvec)
+{
+	struct lruvec *reparented;
+
+	for (;;) {
+		lruvec_lock_irq(lruvec);
+
+		reparented = lruvec->lrugen.reparented;
+		if (!reparented)
+			break;
+
+		lruvec_unlock_irq(lruvec);
+		lruvec = reparented;
+	}
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
@@ -3285,6 +3312,8 @@ static void reset_batch_size(struct lru_gen_mm_walk *walk)
 			lru += LRU_ACTIVE;
 		__update_lru_size(lruvec, lru, zone, delta);
 	}
+
+	lruvec_unlock_irq(lruvec);
 }
 
 static int should_skip_vma(unsigned long start, unsigned long end, struct mm_walk *args)
@@ -3779,11 +3808,8 @@ static void walk_mm(struct mm_struct *mm, struct lru_gen_mm_walk *walk)
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
@@ -4563,6 +4589,8 @@ void lru_gen_reparent_memcg(struct mem_cgroup *memcg, struct mem_cgroup *parent,
 			mem_cgroup_update_lru_size(parent_lruvec, lru, zid, size);
 		}
 	}
+
+	child_lruvec->lrugen.reparented = parent_lruvec;
 }
 
 #endif /* CONFIG_MEMCG */
@@ -4867,9 +4895,7 @@ static int evict_folios(unsigned long nr_to_scan, struct lruvec *lruvec,
 	walk = current->reclaim_state->mm_walk;
 	if (walk && walk->batched) {
 		walk->lruvec = lruvec;
-		lruvec_lock_irq(lruvec);
 		reset_batch_size(walk);
-		lruvec_unlock_irq(lruvec);
 	}
 
 	mod_lruvec_state(lruvec, PGDEMOTE_KSWAPD + reclaimer_offset(sc),
@@ -5784,6 +5810,9 @@ void lru_gen_init_lruvec(struct lruvec *lruvec)
 
 	lrugen->max_seq = MIN_NR_GENS + 1;
 	lrugen->enabled = lru_gen_enabled();
+#ifdef CONFIG_MEMCG
+	lrugen->reparented = NULL;
+#endif
 
 	for (i = 0; i <= MIN_NR_GENS + 1; i++)
 		lrugen->timestamps[i] = jiffies;
-- 
2.54.0

