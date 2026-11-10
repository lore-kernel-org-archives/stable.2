Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794350832;
	b=NbObtPJdoA582nNoodp6b/8BiVnbA9AERt9c3Xp7xZ6RAUJW45nej0K3i66s6/MPCqRC
	 l/sjbTEileHC++0graX198QmkDj6jFbRceh07AWAe0dQzgJRQAFhw7jUNiCUPYECJb4oY
	 tfC3oPmO+jLBrDHRaXKS7k9EjGXPf4ljprtlECOGYoHFyn3urhTRgM8jWJ303n4ZBPtYp
	 scxT++Fyzs9RyWRbrSR29uggsnRIxPJPHmgMfG3DGaDAaUXqRtXeZWzftImkEnRSP1RPr
	 zYQVq/ljrsGdJLCOgYbAFSck6oVcBuK0n6wAV2dHZyy5xNbK2Ml1C2lJO/xw5bWljPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794350832;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=HxrdlL/XfMoTl/zUIrrA3OXdJLxhcFbEpuGIK05Enlw=;
	b=REzdrn1/Q61pW9z67f6E5tDm3MBCrUMxT20Ia6i9pKvHk3OftRE6mAoAVmh+LPswYQtn
	 EhBAluOFhcuNPy6tocaWRkC90tGjl0Ivfq6bctz684XGIQCAanpbcZysNcAu+hci4GrCf
	 2AeiFXJZxfMUlDBY6qRMP9bAeZ//1IRQpDdeTOI5IfIMxEa7GGjfQlUj1m+cRFq0fKxzx
	 D1C9a31x9xu2pWVfVALoFhiLj2GDF9AUQ8ayT0+5rPSXdwhqY30LuNjBAUhiwRgn48LYF
	 0C1+tPSM/X92i9di/yLfu/r71Q4mRbi//SCU2KDulE/SeG7fpnf0q1S2gQ9HJJ5+x9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JZBz5guF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075D6606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 22:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JZBz5guF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF1A1F00A04;
	Tue, 10 Nov 2026 22:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794350831;
	bh=HxrdlL/XfMoTl/zUIrrA3OXdJLxhcFbEpuGIK05Enlw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JZBz5guFCce89eptx/EZ2xtUQgF9/lxRE0QHn+6FMfulyY2TKBbit2dpNwICxRPqg
	 FNAmR2+Pk2R6uMmQUls6Log6anXouyDZq5zSi0b/EH4S9dTtmz7+Fku6hStMy1+EIk
	 Jz7HoyNzC3CCHYn8uE1QNIbUCKUiA/uYOqxSCNF5RHQa0rvSBRaxikfImtcbi88/8r
	 r/rV/6fyor4jGEDHbU6q3hCDtyTucWjaek6elpcVTZnmS7JbVEqJ4iRAAJpu8LUeC1
	 flglJrtJw6iGj7eYQeOrIcbSdQbjxTmz1Ccj0oMps7xGsB+htioOZZv/3vd4LEZpxq
	 p6zI34lAUohAw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Barry Song <v-songbaohua@oppo.com>,
	Minchan Kim <minchan@kernel.org>,
	SeongJae Park <sj@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] mm: madvise: pageout: ignore references rather than clearing young
Date: Tue, 10 Nov 2026 17:47:08 -0500
Message-ID: <20261110224525.4066997-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053858-failed-6.6-246c8cc33438@kernel.org>
References: <20261107053858-failed-6.6-246c8cc33438@kernel.org>
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

From: Barry Song <v-songbaohua@oppo.com>

[ Upstream commit 2864f3d0f5831a50253befc5d4583868268b7153 ]

While doing MADV_PAGEOUT, the current code will clear PTE young so that
vmscan won't read young flags to allow the reclamation of madvised folios
to go ahead.  It seems we can do it by directly ignoring references, thus
we can remove tlb flush in madvise and rmap overhead in vmscan.

Regarding the side effect, in the original code, if a parallel thread runs
side by side to access the madvised memory with the thread doing madvise,
folios will get a chance to be re-activated by vmscan (though the time gap
is actually quite small since checking PTEs is done immediately after
clearing PTEs young).  But with this patch, they will still be reclaimed.
But this behaviour doing PAGEOUT and doing access at the same time is
quite silly like DoS.  So probably, we don't need to care.  Or ignoring
the new access during the quite small time gap is even better.

For DAMON's DAMOS_PAGEOUT based on physical address region, we still keep
its behaviour as is since a physical address might be mapped by multiple
processes.  MADV_PAGEOUT based on virtual address is actually much more
aggressive on reclamation.  To untouch paddr's DAMOS_PAGEOUT, we simply
pass ignore_references as false in reclaim_pages().

A microbench as below has shown 6% decrement on the latency of
MADV_PAGEOUT,

 #define PGSIZE 4096
 main()
 {
 	int i;
 #define SIZE 512*1024*1024
 	volatile long *p = mmap(NULL, SIZE, PROT_READ | PROT_WRITE,
 			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);

 	for (i = 0; i < SIZE/sizeof(long); i += PGSIZE / sizeof(long))
 		p[i] =  0x11;

 	madvise(p, SIZE, MADV_PAGEOUT);
 }

w/o patch                    w/ patch
root@10:~# time ./a.out      root@10:~# time ./a.out
real	0m49.634s            real   0m46.334s
user	0m0.637s             user   0m0.648s
sys	0m47.434s            sys    0m44.265s

Link: https://lkml.kernel.org/r/20240226005739.24350-1-21cnbao@gmail.com
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
Acked-by: Minchan Kim <minchan@kernel.org>
Cc: SeongJae Park <sj@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 246c8cc33438 ("mm/madvise: atomically clear the young bit on THP MADV_COLD")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/damon/paddr.c |  2 +-
 mm/internal.h    |  2 +-
 mm/madvise.c     |  8 ++++----
 mm/vmscan.c      | 12 +++++++-----
 4 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index fe481ae64f37e..200bb7e64fd88 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -237,7 +237,7 @@ static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s)
 put_folio:
 		folio_put(folio);
 	}
-	applied = reclaim_pages(&folio_list);
+	applied = reclaim_pages(&folio_list, false);
 	cond_resched();
 	return applied * PAGE_SIZE;
 }
diff --git a/mm/internal.h b/mm/internal.h
index 03cfd9f736597..5e1642a8e5553 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -874,7 +874,7 @@ extern unsigned long  __must_check vm_mmap_pgoff(struct file *, unsigned long,
         unsigned long, unsigned long);
 
 extern void set_pageblock_order(void);
-unsigned long reclaim_pages(struct list_head *folio_list);
+unsigned long reclaim_pages(struct list_head *folio_list, bool ignore_references);
 unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 					    struct list_head *folio_list);
 /* The ALLOC_WMARK bits are used as an index to zone->watermark */
diff --git a/mm/madvise.c b/mm/madvise.c
index 209d0cc950139..7d3a9c4b993f0 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -403,7 +403,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 			return 0;
 		}
 
-		if (pmd_young(orig_pmd)) {
+		if (!pageout && pmd_young(orig_pmd)) {
 			pmdp_invalidate(vma, addr, pmd);
 			orig_pmd = pmd_mkold(orig_pmd);
 
@@ -427,7 +427,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 huge_unlock:
 		spin_unlock(ptl);
 		if (pageout)
-			reclaim_pages(&folio_list);
+			reclaim_pages(&folio_list, true);
 		cond_resched();
 		return 0;
 	}
@@ -497,7 +497,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 
 		VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
 
-		if (pte_young(ptent)) {
+		if (!pageout && pte_young(ptent)) {
 			ptent = ptep_get_and_clear_full(mm, addr, pte,
 							tlb->fullmm);
 			ptent = pte_mkold(ptent);
@@ -531,7 +531,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		pte_unmap_unlock(start_pte, ptl);
 	}
 	if (pageout)
-		reclaim_pages(&folio_list);
+		reclaim_pages(&folio_list, true);
 	cond_resched();
 
 	return 0;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index cbc2de77db3ed..32058c20e12d8 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2775,7 +2775,8 @@ static void shrink_active_list(unsigned long nr_to_scan,
 }
 
 static unsigned int reclaim_folio_list(struct list_head *folio_list,
-				      struct pglist_data *pgdat)
+				      struct pglist_data *pgdat,
+				      bool ignore_references)
 {
 	struct reclaim_stat dummy_stat;
 	unsigned int nr_reclaimed;
@@ -2788,7 +2789,7 @@ static unsigned int reclaim_folio_list(struct list_head *folio_list,
 		.no_demotion = 1,
 	};
 
-	nr_reclaimed = shrink_folio_list(folio_list, pgdat, &sc, &dummy_stat, false);
+	nr_reclaimed = shrink_folio_list(folio_list, pgdat, &sc, &dummy_stat, ignore_references);
 	while (!list_empty(folio_list)) {
 		folio = lru_to_folio(folio_list);
 		list_del(&folio->lru);
@@ -2798,7 +2799,7 @@ static unsigned int reclaim_folio_list(struct list_head *folio_list,
 	return nr_reclaimed;
 }
 
-unsigned long reclaim_pages(struct list_head *folio_list)
+unsigned long reclaim_pages(struct list_head *folio_list, bool ignore_references)
 {
 	int nid;
 	unsigned int nr_reclaimed = 0;
@@ -2820,11 +2821,12 @@ unsigned long reclaim_pages(struct list_head *folio_list)
 			continue;
 		}
 
-		nr_reclaimed += reclaim_folio_list(&node_folio_list, NODE_DATA(nid));
+		nr_reclaimed += reclaim_folio_list(&node_folio_list, NODE_DATA(nid),
+						   ignore_references);
 		nid = folio_nid(lru_to_folio(folio_list));
 	} while (!list_empty(folio_list));
 
-	nr_reclaimed += reclaim_folio_list(&node_folio_list, NODE_DATA(nid));
+	nr_reclaimed += reclaim_folio_list(&node_folio_list, NODE_DATA(nid), ignore_references);
 
 	memalloc_noreclaim_restore(noreclaim_flag);
 
-- 
2.53.0

