Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046469;
	b=KxCIPwZoy0a1JJP7oTeFRw97nTARzl/oOFOihc0xjyXiSfFJWA7m8wvNAFaz9jj+lX3g
	 e7pTQeLyzMY3ovs1ZoLJNtpf+48RcO0JyWxyLuXV7vFmjcBgT6hgN+jK5KO0ewqVotP7f
	 ru5g3bxvzx89/Gn6wPOlBqgwxbKGpgP6pEsXPjLKsajOfnaKTqBLkieaomfZSWq9sRdw0
	 QG2SiadctpPmd78cXkxDwTv3sJwVslQQKKe/7tqnYxVDlQyZDBQcVLKNddi47iUYoSdL9
	 gXGeyLSv2d2mBTXqPxi8201I/tZfTjC8V6xWz6jyMVemtZWmQ4NS/mg/JLSth9ZietQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046469;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=2fNzkqte03umeXrG16KZyldO0Gf+Q7gLsrh+1i2CmCQ=;
	b=JJ3c2hUa4BCOVyhHLg3KahmX0CWRcRJ0AAr0kFS8CLKh+ldYqHdtyIGPr36n5ESxoiaG
	 bHvU7FPwEdXV1vx5jM/xUzUpMQuRpsLHxfIUzI0GIl4brYHSk7+mjsMEfIFwUl29xwDTE
	 ES1YvsHBn9JBno9GB+/kzOYx0rxKDoVJve4EaOhDQ4ibCi53VE3q5H+8LKqJ5BDK/JCIv
	 CBMCeEDHj6DEQQXifZ7g3Kp6KjaYsKno/yL2iUPeNn/oRF+SVIWPAYbh1vBUITlymiOyR
	 VIGZlb+aNXe67j1bCnBSXHhpXD5BZiJLzZ0DYGysDd4ZSwtuDcXgcM/fyR1rDgARhlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IqDZaA+5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E61B606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IqDZaA+5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDA281F0089F;
	Sat,  7 Nov 2026 10:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046469;
	bh=2fNzkqte03umeXrG16KZyldO0Gf+Q7gLsrh+1i2CmCQ=;
	h=From:To:Cc:Subject:Date;
	b=IqDZaA+5SbDSfCoq0LCk3xIEpSe6xmOQa/9ID+58DpJ/t4/DpuxCqe7eCv9hzPbPQ
	 eIuH2JJEWCb9yXOvz+WIZrBx66VL/+DwRMIILwC0kHwrGJS5dr25XTzlmihNWlztcD
	 +kbkwhp8pe+iEGk+B7gLiqhLxSNm5829adUWr317BQE2g+RBIv9PEmIV6Lo2lbDvc4
	 69OaeogvhlVBITFfz1ROB++yE8QH+c0jCnt9GU46/tFH2CZoJyEFfjrOVkI8RPzxfP
	 51p2aS0ex2fEi5iPeGSZBIGOTQf19AW1nB/TdNEKaDQDve/nWi0sZzmiqM5/aATwTd
	 gnWDT7ewng9XA==
From: Sasha Levin <sashal@kernel.org>
To: kas@kernel.org,
	akpm@linux-foundation.org,
	vbabka@kernel.org,
	hannes@cmpxchg.org,
	david@kernel.org,
	harry@kernel.org,
	usama.arif@linux.dev,
	surenb@google.com,
	mhocko@suse.com,
	brendan.jackman@linux.dev,
	ziy@nvidia.com,
	shakeel.butt@linux.dev
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm: page_alloc: make defrag_mode retries follow the promoted order" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:14:26 -0500
Message-ID: <20261107051426-failed-6.18-4cd78a2dcfbb@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 4cd78a2dcfbb13f049f841b98763896a3d1d7750
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051426-failed-6.18-4cd78a2dcfbb@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 4cd78a2dcfbb13f049f841b98763896a3d1d7750 Mon Sep 17 00:00:00 2001
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Date: Tue, 13 Oct 2026 18:37:20 +0100
Subject: [PATCH] mm: page_alloc: make defrag_mode retries follow the promoted
 order

Since commit 7e8756d7ad22 ("mm: page_alloc: fix non-movable reclaim storm
in defrag_mode"), direct reclaim and compaction for non-movable requests
under defrag_mode run at pageblock_order, to produce the whole blocks that
ALLOC_NOFRAGMENT needs.  The retry decisions that follow still use the
request order.  An order-0 request can therefore retry indefinitely
without ever reaching the ALLOC_NOFRAGMENT fallback:

- Reclaim at pageblock_order gives up after one pass as soon as a zone
  looks compaction_ready(), and do_try_to_free_pages() then returns 1
  even though nothing was reclaimed. It returns before the retry that
  would reclaim memory.low-protected cgroups, so when most memory is
  protected, the pass that did run finds next to nothing.

- Compaction at pageblock_order fails or is deferred.

- should_reclaim_retry() takes the reported progress as progress for
  the order-0 request and resets no_progress_loops. The request
  retries.

Order 1-3 requests loop the same way, and should_compact_retry() also
checks their pageblock_order compaction result against the request order.

On a production host (64G, defrag_mode, memory.low covering most of the
workload), 95% of direct reclaim runs were order-9 runs that returned 1
with nothing reclaimed, at up to 60k runs per second.  Across ~200M
should_reclaim_retry() calls in a day, no_progress_loops never left 0.
The spinning allocations were SLUB slab refills for inode and dentry
caches.  The time spent registers as memory pressure, and pressure-based
OOM killing takes down both workloads and system services.

For promoted requests:

- Reclaim progress does not reset no_progress_loops, as for costly
  orders.

- should_compact_retry() checks the compaction result at the promoted
  order and does not retry COMPACT_SKIPPED, since the request can fall
  back. The compaction priority floor and the COMPACT_SUCCESS retry
  limit stay those of the request order, so a non-costly request still
  gets its COMPACT_PRIO_SYNC_FULL pass before it falls back.

When a promoted request takes the fallback, reset the retry counters, so
that the fallback attempt gets a full retry budget before the OOM killer
is considered.  A request whose reclaim was not promoted spent its budget
on the request itself and keeps its counters, as Usama Arif pointed out.

__alloc_pages_slowpath() computes the promoted order once per iteration
and keeps it in alloc_context for direct reclaim, direct compaction and
the two retry helpers, so no callee has to recompute it.  Harry Yoo asked
for the promoted order to be explicit rather than derived in each callee,
and Vlastimil Babka suggested alloc_context over new function parameters.

In a VM reproducer (32G, defrag_mode, inode churn under memory.low):

                                        before    after
    should_reclaim_retry() calls           63M     293k
    peak memory pressure (PSI some avg10)  99%      12%

File creation runs 5.7x faster.

[kas@kernel.org: s/order_nofrag_promoted/order_defrag_promoted/, per hannes]
  Link: https://lore.kernel.org/atDL-nSFP2KVU7cI@thinkstation
Link: https://lore.kernel.org/as5q14OsbK2CmOrh@thinkstation
Fixes: 7e8756d7ad22 ("mm: page_alloc: fix non-movable reclaim storm in defrag_mode")
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Assisted-by: LLM
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Harry Yoo <harry@kernel.org>
Cc: Usama Arif <usama.arif@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Brendan Jackman <brendan.jackman@linux.dev>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: <stable@vger.kernel.org>
---
 mm/page_alloc.c | 65 +++++++++++++++++++++++++++++--------------------
 mm/page_alloc.h |  2 ++
 2 files changed, 41 insertions(+), 26 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ff7b9acf01443..914e3c9375f24 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4117,6 +4117,12 @@ __alloc_pages_may_oom(gfp_t gfp_mask, unsigned int order,
 	return page;
 }
 
+static inline bool order_defrag_promoted(unsigned int order,
+					 const struct alloc_context *ac)
+{
+	return ac->reclaim_compact_order != order;
+}
+
 /*
  * Maximum number of compaction retries with a progress before OOM
  * killer is consider as the only way to move forward.
@@ -4139,22 +4145,7 @@ __alloc_pages_direct_compact(gfp_t gfp_mask, unsigned int order,
 		.order = order,
 		.page = NULL,
 	};
-	int compact_order = order;
-
-	/*
-	 * If fallbacks are not permitted (defrag_mode), we either
-	 * need to reclaim space in a block of matching type, or clear
-	 * out an entire block to allow __rmqueue_claim() to convert.
-	 *
-	 * Reclaim by itself is primarily freeing space in movable
-	 * blocks, since that's where the LRU pages live. So this
-	 * works for movable requests, but not for others.
-	 *
-	 * For those, promote the order to help make blocks, instead
-	 * of spinning in reclaim alone unproductively.
-	 */
-	if ((alloc_flags & ALLOC_NOFRAGMENT) && ac->migratetype != MIGRATE_MOVABLE)
-		compact_order = max(order, pageblock_order);
+	int compact_order = ac->reclaim_compact_order;
 
 	if (!compact_order)
 		return NULL;
@@ -4247,7 +4238,7 @@ should_compact_retry(gfp_t gfp_mask, struct alloc_context *ac, int order,
 	int retries = *compaction_retries;
 	enum compact_priority priority = *compact_priority;
 
-	if (!order)
+	if (!ac->reclaim_compact_order)
 		return false;
 
 	if (fatal_signal_pending(current))
@@ -4256,10 +4247,12 @@ should_compact_retry(gfp_t gfp_mask, struct alloc_context *ac, int order,
 	/*
 	 * Compaction was skipped due to a lack of free order-0
 	 * migration targets. Continue if reclaim can help.
+	 * Promoted requests fall back instead.
 	 */
 	if (compact_result == COMPACT_SKIPPED) {
-		ret = compaction_zonelist_suitable(ac, order, alloc_flags,
-						   gfp_mask);
+		if (!order_defrag_promoted(order, ac))
+			ret = compaction_zonelist_suitable(ac, order,
+							   alloc_flags, gfp_mask);
 		goto out;
 	}
 
@@ -4458,11 +4451,7 @@ __alloc_pages_direct_reclaim(gfp_t gfp_mask, unsigned int order,
 	struct page *page = NULL;
 	unsigned long pflags;
 	bool drained = false;
-	int reclaim_order = order;
-
-	/* Match the slowpath compaction promotion in __alloc_pages_direct_compact */
-	if ((alloc_flags & ALLOC_NOFRAGMENT) && ac->migratetype != MIGRATE_MOVABLE)
-		reclaim_order = max(order, pageblock_order);
+	int reclaim_order = ac->reclaim_compact_order;
 
 	psi_memstall_enter(&pflags);
 	*did_some_progress = __perform_reclaim(gfp_mask, reclaim_order, ac);
@@ -4638,9 +4627,12 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned order,
 	/*
 	 * Costly allocations might have made a progress but this doesn't mean
 	 * their order will become available due to high fragmentation so
-	 * always increment the no progress counter for them
+	 * always increment the no progress counter for them. The same goes for
+	 * promoted requests: their reclaim reports progress when it backs off
+	 * for compaction without freeing anything.
 	 */
-	if (did_some_progress && order <= PAGE_ALLOC_COSTLY_ORDER)
+	if (did_some_progress && order <= PAGE_ALLOC_COSTLY_ORDER &&
+	    !order_defrag_promoted(order, ac))
 		*no_progress_loops = 0;
 	else
 		(*no_progress_loops)++;
@@ -4924,6 +4916,22 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	/* If allocation has taken excessively long, warn about it */
 	check_alloc_stall_warn(gfp_mask, ac->nodemask, order, alloc_start_time);
 
+	/*
+	 * If fallbacks are not permitted (defrag_mode), we either
+	 * need to reclaim space in a block of matching type, or clear
+	 * out an entire block to allow __rmqueue_claim() to convert.
+	 *
+	 * Reclaim by itself is primarily freeing space in movable
+	 * blocks, since that's where the LRU pages live. So this
+	 * works for movable requests, but not for others.
+	 *
+	 * For those, promote the order to help make blocks, instead
+	 * of spinning in reclaim alone unproductively.
+	 */
+	ac->reclaim_compact_order = order;
+	if ((alloc_flags & ALLOC_NOFRAGMENT) && ac->migratetype != MIGRATE_MOVABLE)
+		ac->reclaim_compact_order = max(order, pageblock_order);
+
 	/* Try direct reclaim and then allocating */
 	if (!compact_first) {
 		page = __alloc_pages_direct_reclaim(gfp_mask, order, alloc_flags,
@@ -5005,6 +5013,11 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	/* Reclaim/compaction failed to prevent the fallback */
 	if (defrag_mode && (alloc_flags & ALLOC_NOFRAGMENT)) {
 		alloc_flags &= ~ALLOC_NOFRAGMENT;
+		/* Retries went into making blocks, start the fallback afresh */
+		if (order_defrag_promoted(order, ac)) {
+			no_progress_loops = 0;
+			compaction_retries = 0;
+		}
 		goto retry;
 	}
 
diff --git a/mm/page_alloc.h b/mm/page_alloc.h
index b9259deddb59d..2b1017a91928c 100644
--- a/mm/page_alloc.h
+++ b/mm/page_alloc.h
@@ -93,6 +93,8 @@ struct alloc_context {
 	bool spread_dirty_pages;
 	/* Only flags that are global to the whole allocation go here. */
 	unsigned int alloc_flags;
+	/* Set by __alloc_pages_slowpath() before reclaim and compaction */
+	unsigned int reclaim_compact_order;
 };
 
 /*
-- 
2.53.0




