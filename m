Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7216937F01C
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 12:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791550513; cv=none; b=UmS9au+FH68ZVWHSAQox4NYcnQ1gGgxkmZGpwqNV2mePbBA+3VJlvQdlbO449BYPEQdWzkL7wT20pdea0su0hXO1pmI5N9TlT7k3bTcbvMGqgEktM/d6akw3AmbECkmVi99UyRJgVoO9boTuJfqAY83Po8ZAxlyvPac/Qn83Arc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791550513; c=relaxed/simple;
	bh=wvZXaHgNE6+zoopf4sAvPE1vKbzcuUuTPfQv+xggaFk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BwbrfMwteh49wDgyp+pJNFpesqukz9Ib1K4oJ3lnnCquoVJ1Q1FDs97QtXBFQF9eltagkq5jH5sBTnVG9UC2Nq+Szva3UrrFEzEPV6LlTyVNO5bHSfB+vPOuXxMdQVuIJGBD16RG/d3/KR6wF69B0+L4w5hKpawv/1s03wTf3tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hnFhV8T5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hnFhV8T5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD4021F00898;
	Fri,  9 Oct 2026 12:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791550512;
	bh=F3k/xSn6ZWvYkLldUYuGNx7F+fXwYZDL1mMWHiHXu9Q=;
	h=From:To:Cc:Subject:Date;
	b=hnFhV8T54Epis8q0XnTD3NbiqIB1eAbXNSRulp3i3VB5+CUy5MMZyd2tztF1wn1EQ
	 WQKzUkqnpt4CWdu0VdsnOpwKYUxGmgl5UmA8mE4HEM4sdaJ2ikzOc7pq2bg7gz/yuF
	 htdvYccRgsoixtkmjAw7MUYlYxdGqdL878l/uaocvYHGwby9Vr5udKFF81QAZ4qsgW
	 hIMog+lXQld7UKEPg3fH6Bk5IfWOQdt4pb9JNpwO3mG5+6tleNVBst3g+rDiMho9ny
	 gfuLhLesfNF199HXhH8KTjhJmbKv1WlJldW64yjvxE+OSAFd+U0S1m8EPvAA73S/F2
	 SwgItMvpT4CCg==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.ams.internal (Postfix) with ESMTP id E83FD198003A;
	Fri,  9 Oct 2026 08:55:07 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 09 Oct 2026 08:55:09 -0400
X-ME-Sender: <xms:K-TIap0zm5XS49EikJ90qgXGB28pCdtBwxpEpIMd8yV5oUdRUJKvuQ>
    <xme:K-TIan8S2_hucRnChyu9m9D4Y28hpGYnRnMjFuVZ9luQ0lhR0L_7Eh3zagr8tV2Ma
    GwG4DoPTqToS02ZBQAn94Xg5ZWM0ct6EliHE0YDnACa-FOAf8Z4Lz9q>
X-ME-Received: <xmr:K-TIapRZrKqtdAZV0BataSlrFdUUNQkb_65tqnLfJsNgPcbCmjjjcoMfttY>
X-ME-Proxy-Cause: dmFkZTExuCsPDqWL3/AU985tfKvpN8OMbafdFBQf3l+GbK/HgNnlVqSjR+3K4v4kq8HRce
    DisAFTvxg/eHKkD7mblMBPY7QJZl1f2YAzUMguVE/+Pul2HWwXro5Nisfs/kH7HJxFs8qE
    CdhZgAdPEzP/44O5JZnCvv6wsRKgWDM3kolMUOtHKp70LXzLx17I8C49oTk5x2+RkIqFUN
    GYpodtZDnFGotcyIvEgFWGFl25M8RJ7xjOk6+9Q6k5+Uhy9BInrWn3Y9SqObECxzJ4MMEr
    IeGTIaSsH11AICVZwbfo6EZDGOmbkFSwMfpMmv2J+m/HSXXJwX5oxq67f+u2+NuLkq/HkQ
    K2J4IjZfWYJ8awjZyMLzUmG6jR29ye3OnJ2IIh2tR0jBx3ATwyNgYNkmjJVG6d/FPZLuw7
    oszLo0MqDxcMoz4fYnHr/Vl24/T6eURJT2Iz01P+OGSdQLWB+LSJ2tgHIXhfxjeir2gt5r
    GHlux5rW5A4zh1MKsQzmetTeWk+yLGS4zh9tAAZnTMJUrBvMdtfzDwi2e31le73WGGehbe
    UmEbezO6+ameWp3A1Qz5E8EQGxQ3hx3Tv7JdUO01PMggbt5rWrjZNJY7oWgUGFnxk/klq8
    z/DNQgtf4z1TTsizXcx8sAzlmVpmBLbTX0vfGp4KWFoZdVsfCyBPXDp7fG4Q
X-ME-Proxy: <xmx:K-TIaumjnoSHDffea_63FM_t6bahGan7V9Q9Hzj5SmxLydewRVksVQ>
    <xmx:K-TIakVeIQc5Y2cNCMcLvh8NMZIayUB_b63haKJzAgfsD2LVuiqoZA>
    <xmx:K-TIajc9fzdZzmGd7fwaRE4D0yPp4Rqm1DZRQCMJtY3wPl9TQBcbkA>
    <xmx:K-TIainGRuTOFQWj31UGIGMdJI1Z3hb-GG9RbLfdnrOFFkTVbiY2bA>
    <xmx:K-TIalBz9tMwjgoyZNNNAEotCnf8z1yGLL5PIt--FMmEtskLV1YWRfoM>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Oct 2026 08:55:06 -0400 (EDT)
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	David Hildenbrand <david@kernel.org>,
	Harry Yoo <harry@kernel.org>,
	Usama Arif <usama.arif@linux.dev>
Cc: "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Zi Yan <ziy@nvidia.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v3] mm: page_alloc: make defrag_mode retries follow the promoted order
Date: Fri,  9 Oct 2026 13:55:02 +0100
Message-ID: <20261009125503.126202-1-kas@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 7e8756d7ad22 ("mm: page_alloc: fix non-movable reclaim
storm in defrag_mode"), direct reclaim and compaction for non-movable
requests under defrag_mode run at pageblock_order, to produce the whole
blocks that ALLOC_NOFRAGMENT needs. The retry decisions that follow
still use the request order. An order-0 request can therefore retry
indefinitely without ever reaching the ALLOC_NOFRAGMENT fallback:

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
checks their pageblock_order compaction result against the request
order.

On a production host (64G, defrag_mode, memory.low covering most of the
workload), 95% of direct reclaim runs were order-9 runs that returned 1
with nothing reclaimed, at up to 60k runs per second. Across ~200M
should_reclaim_retry() calls in a day, no_progress_loops never left 0.
The spinning allocations were SLUB slab refills for inode and dentry
caches. The time spent registers as memory pressure, and pressure-based
OOM killing takes down both workloads and system services.

For promoted requests:

- Reclaim progress does not reset no_progress_loops, as for costly
  orders.

- should_compact_retry() checks the compaction result at the promoted
  order and does not retry COMPACT_SKIPPED, since the request can fall
  back. The compaction priority floor and the COMPACT_SUCCESS retry
  limit stay those of the request order, so a non-costly request still
  gets its COMPACT_PRIO_SYNC_FULL pass before it falls back.

When a promoted request takes the fallback, reset the retry counters,
so that the fallback attempt gets a full retry budget before the OOM
killer is considered. A request whose reclaim was not promoted spent
its budget on the request itself and keeps its counters, as Usama Arif
pointed out.

__alloc_pages_slowpath() computes the promoted order once per iteration
and passes it to direct reclaim, direct compaction and the two retry
helpers next to the request order, so no callee has to recompute it.
Harry Yoo asked for the two orders to be explicit rather than derived
in each callee.

In a VM reproducer (32G, defrag_mode, inode churn under memory.low):

                                        before    after
    should_reclaim_retry() calls           63M     293k
    peak memory pressure (PSI some avg10)  99%      12%

File creation runs 5.7x faster.

Fixes: 7e8756d7ad22 ("mm: page_alloc: fix non-movable reclaim storm in defrag_mode")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
v3:
 - reset the retry counters at the fallback only for requests whose
   reclaim was promoted; a movable request already spent its budget on
   itself (Usama Arif)

v2:
 - keep the compaction priority floor and the COMPACT_SUCCESS retry
   limit on the request order, so non-costly requests still escalate to
   SYNC_FULL before falling back (Harry Yoo, Johannes Weiner)
 - compute the promoted order once in __alloc_pages_slowpath() and pass
   it to direct reclaim, direct compaction and the retry helpers, instead
   of each of them deriving it (Harry Yoo)

 mm/page_alloc.c | 126 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 81 insertions(+), 45 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 12fac9084c48..c0be88d2c3ad 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4127,6 +4127,32 @@ __alloc_pages_may_oom(gfp_t gfp_mask, unsigned int order,
 	return page;
 }
 
+/*
+ * If fallbacks are not permitted (defrag_mode), we either need to
+ * reclaim space in a block of matching type, or clear out an entire
+ * block to allow __rmqueue_claim() to convert.
+ *
+ * Reclaim by itself is primarily freeing space in movable blocks,
+ * since that's where the LRU pages live. So this works for movable
+ * requests, but not for others.
+ *
+ * For those, promote the order of reclaim and compaction to help make
+ * blocks, instead of spinning in reclaim alone unproductively. Retry
+ * decisions based on the outcome of that work - reclaim progress and
+ * compaction results - must account for the promotion as well, so
+ * __alloc_pages_slowpath() computes the promoted order once and passes
+ * it alongside the request order.
+ */
+static inline unsigned int nofrag_promote_order(unsigned int order,
+						unsigned int alloc_flags,
+						const struct alloc_context *ac)
+{
+	if ((alloc_flags & ALLOC_NOFRAGMENT) && ac->migratetype != MIGRATE_MOVABLE)
+		return max(order, pageblock_order);
+
+	return order;
+}
+
 /*
  * Maximum number of compaction retries with a progress before OOM
  * killer is consider as the only way to move forward.
@@ -4137,8 +4163,9 @@ __alloc_pages_may_oom(gfp_t gfp_mask, unsigned int order,
 /* Try memory compaction for high-order allocations before reclaim */
 static struct page *
 __alloc_pages_direct_compact(gfp_t gfp_mask, unsigned int order,
-		unsigned int alloc_flags, const struct alloc_context *ac,
-		enum compact_priority prio, enum compact_result *compact_result)
+		unsigned int compact_order, unsigned int alloc_flags,
+		const struct alloc_context *ac, enum compact_priority prio,
+		enum compact_result *compact_result)
 {
 	struct page *page = NULL;
 	unsigned long pflags;
@@ -4149,22 +4176,6 @@ __alloc_pages_direct_compact(gfp_t gfp_mask, unsigned int order,
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
 
 	if (!compact_order)
 		return NULL;
@@ -4246,7 +4257,7 @@ __alloc_pages_direct_compact(gfp_t gfp_mask, unsigned int order,
 
 static inline bool
 should_compact_retry(gfp_t gfp_mask, struct alloc_context *ac, int order,
-		     int alloc_flags,
+		     int compact_order, int alloc_flags,
 		     enum compact_result compact_result,
 		     enum compact_priority *compact_priority,
 		     int *compaction_retries)
@@ -4257,7 +4268,7 @@ should_compact_retry(gfp_t gfp_mask, struct alloc_context *ac, int order,
 	int retries = *compaction_retries;
 	enum compact_priority priority = *compact_priority;
 
-	if (!order)
+	if (!compact_order)
 		return false;
 
 	if (fatal_signal_pending(current))
@@ -4266,10 +4277,14 @@ should_compact_retry(gfp_t gfp_mask, struct alloc_context *ac, int order,
 	/*
 	 * Compaction was skipped due to a lack of free order-0
 	 * migration targets. Continue if reclaim can help.
+	 *
+	 * Promoted requests have exhausted their reclaim retries at
+	 * this point, and they can fall back instead.
 	 */
 	if (compact_result == COMPACT_SKIPPED) {
-		ret = compaction_zonelist_suitable(ac, order, alloc_flags,
-						   gfp_mask);
+		if (compact_order == order)
+			ret = compaction_zonelist_suitable(ac, order, alloc_flags,
+							   gfp_mask);
 		goto out;
 	}
 
@@ -4314,8 +4329,9 @@ should_compact_retry(gfp_t gfp_mask, struct alloc_context *ac, int order,
 #else
 static inline struct page *
 __alloc_pages_direct_compact(gfp_t gfp_mask, unsigned int order,
-		unsigned int alloc_flags, const struct alloc_context *ac,
-		enum compact_priority prio, enum compact_result *compact_result)
+		unsigned int compact_order, unsigned int alloc_flags,
+		const struct alloc_context *ac, enum compact_priority prio,
+		enum compact_result *compact_result)
 {
 	*compact_result = COMPACT_SKIPPED;
 	return NULL;
@@ -4323,7 +4339,7 @@ __alloc_pages_direct_compact(gfp_t gfp_mask, unsigned int order,
 
 static inline bool
 should_compact_retry(gfp_t gfp_mask, struct alloc_context *ac, int order,
-		     int alloc_flags,
+		     int compact_order, int alloc_flags,
 		     enum compact_result compact_result,
 		     enum compact_priority *compact_priority,
 		     int *compaction_retries)
@@ -4462,17 +4478,12 @@ __perform_reclaim(gfp_t gfp_mask, unsigned int order,
 /* The really slow allocator path where we enter direct reclaim */
 static inline struct page *
 __alloc_pages_direct_reclaim(gfp_t gfp_mask, unsigned int order,
-		unsigned int alloc_flags, const struct alloc_context *ac,
-		unsigned long *did_some_progress)
+		unsigned int reclaim_order, unsigned int alloc_flags,
+		const struct alloc_context *ac, unsigned long *did_some_progress)
 {
 	struct page *page = NULL;
 	unsigned long pflags;
 	bool drained = false;
-	int reclaim_order = order;
-
-	/* Match the slowpath compaction promotion in __alloc_pages_direct_compact */
-	if ((alloc_flags & ALLOC_NOFRAGMENT) && ac->migratetype != MIGRATE_MOVABLE)
-		reclaim_order = max(order, pageblock_order);
 
 	psi_memstall_enter(&pflags);
 	*did_some_progress = __perform_reclaim(gfp_mask, reclaim_order, ac);
@@ -4638,8 +4649,9 @@ bool gfp_pfmemalloc_allowed(gfp_t gfp_mask)
  */
 static inline bool
 should_reclaim_retry(gfp_t gfp_mask, unsigned order,
-		     struct alloc_context *ac, int alloc_flags,
-		     bool did_some_progress, int *no_progress_loops)
+		     unsigned int reclaim_order, struct alloc_context *ac,
+		     int alloc_flags, bool did_some_progress,
+		     int *no_progress_loops)
 {
 	struct zone *zone;
 	struct zoneref *z;
@@ -4648,9 +4660,17 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned order,
 	/*
 	 * Costly allocations might have made a progress but this doesn't mean
 	 * their order will become available due to high fragmentation so
-	 * always increment the no progress counter for them
+	 * always increment the no progress counter for them.
+	 *
+	 * The same goes for requests whose reclaim is promoted to make whole
+	 * blocks. At that order, reclaim also reports progress when it backs
+	 * off for compaction without freeing anything.
+	 *
+	 * The watermark check below stays at the request order: it asks
+	 * whether the request itself could succeed after reclaim.
 	 */
-	if (did_some_progress && order <= PAGE_ALLOC_COSTLY_ORDER)
+	if (did_some_progress && order <= PAGE_ALLOC_COSTLY_ORDER &&
+	    reclaim_order == order)
 		*no_progress_loops = 0;
 	else
 		(*no_progress_loops)++;
@@ -4790,6 +4810,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	const bool costly_order = order > PAGE_ALLOC_COSTLY_ORDER;
 	struct page *page = NULL;
 	unsigned int alloc_flags;
+	unsigned int reclaim_order;
 	unsigned long did_some_progress;
 	enum compact_priority compact_priority;
 	enum compact_result compact_result;
@@ -4934,17 +4955,22 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	/* If allocation has taken excessively long, warn about it */
 	check_alloc_stall_warn(gfp_mask, ac->nodemask, order, alloc_start_time);
 
+	/* The order reclaim and compaction work at, see nofrag_promote_order() */
+	reclaim_order = nofrag_promote_order(order, alloc_flags, ac);
+
 	/* Try direct reclaim and then allocating */
 	if (!compact_first) {
-		page = __alloc_pages_direct_reclaim(gfp_mask, order, alloc_flags,
-							ac, &did_some_progress);
+		page = __alloc_pages_direct_reclaim(gfp_mask, order, reclaim_order,
+						    alloc_flags, ac,
+						    &did_some_progress);
 		if (page)
 			goto got_pg;
 	}
 
 	/* Try direct compaction and then allocating */
-	page = __alloc_pages_direct_compact(gfp_mask, order, alloc_flags, ac,
-					compact_priority, &compact_result);
+	page = __alloc_pages_direct_compact(gfp_mask, order, reclaim_order,
+					    alloc_flags, ac, compact_priority,
+					    &compact_result);
 	if (page)
 		goto got_pg;
 
@@ -4996,8 +5022,9 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	    check_retry_zonelist(zonelist_iter_cookie))
 		goto restart;
 
-	if (should_reclaim_retry(gfp_mask, order, ac, alloc_flags,
-				 did_some_progress > 0, &no_progress_loops))
+	if (should_reclaim_retry(gfp_mask, order, reclaim_order, ac,
+				 alloc_flags, did_some_progress > 0,
+				 &no_progress_loops))
 		goto retry;
 
 	/*
@@ -5007,14 +5034,23 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	 * of free memory (see __compaction_suitable)
 	 */
 	if (did_some_progress > 0 && can_compact &&
-	    should_compact_retry(gfp_mask, ac, order, alloc_flags,
-				 compact_result, &compact_priority,
+	    should_compact_retry(gfp_mask, ac, order, reclaim_order,
+				 alloc_flags, compact_result, &compact_priority,
 				 &compaction_retries))
 		goto retry;
 
-	/* Reclaim/compaction failed to prevent the fallback */
+	/*
+	 * Reclaim/compaction failed to prevent the fallback. A promoted
+	 * request spent its retry budget on making blocks, not on the
+	 * request itself; give its fallback a fresh one before
+	 * considering OOM.
+	 */
 	if (defrag_mode && (alloc_flags & ALLOC_NOFRAGMENT)) {
 		alloc_flags &= ~ALLOC_NOFRAGMENT;
+		if (reclaim_order != order) {
+			no_progress_loops = 0;
+			compaction_retries = 0;
+		}
 		goto retry;
 	}
 
-- 
2.54.0

