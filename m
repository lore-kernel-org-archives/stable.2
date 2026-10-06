Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA9939656E;
	Tue,  6 Oct 2026 23:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791330085; cv=none; b=Ia1g6ufZwwH3zmoYqIu7ExXrcUBhSfSW9g7l801h78gWqwiRNrSj8c4jnNrbH8fwXrJsjCz8/0PchGJ1aMIkwD99XlexEDGZfPM3RkcF+GFqz//RlGVw95NUVZyWSk3lynZ5pnv+luimvB+T918xcG5LS3rgf1ruGsA30j4Tj18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791330085; c=relaxed/simple;
	bh=YMZ6eUJ+sap+TL2rB/x6UMo1yw5Bj4vrLCdVeFgrdFA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=B2iVZUq60VPewzTWg94dFUlu5BQC14/1jTHrDPHOOo6R8Dga0pO+s73Mz4v4MVUt9thQeVSzShmNirNYzsl1pfb5kSjOZO1/5TgbthbWylBN+IYIxFHrKbrpUE3DZ39Tqch6OWfgUGV1nFt3Fdl0vzLBUlU5Ip1dzS7Dwl3ld0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GwUFgC0m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GwUFgC0m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC43A1F0089B;
	Tue,  6 Oct 2026 23:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1791330083;
	bh=JXvhnbg1I/58qTdGiI2cyrqoYMogxu1PGhzM7iSho2U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GwUFgC0mmphjcQ9mxmU5/b7/WLV5YfdcDbfKNRu938VS57eYhZpNKwuT/HTCXs0QI
	 oCguLae/sns7Yfa6IuPdv5ITN3FRMWvXjX8FpKINlwChpEmhBipkdlWVuON54bjayd
	 /NNrdDucrYA8OvDxcyj27RKaIm6sgE4DkeKbpGNU=
Date: Tue, 6 Oct 2026 16:41:22 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Vlastimil Babka <vbabka@kernel.org>, Johannes Weiner
 <hannes@cmpxchg.org>, David Hildenbrand <david@kernel.org>, Harry Yoo
 <harry@kernel.org>, "Kiryl Shutsemau (Meta)" <kas@kernel.org>, Suren
 Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Brendan
 Jackman <brendan.jackman@linux.dev>, Zi Yan <ziy@nvidia.com>, Shakeel Butt
 <shakeel.butt@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 kernel-team@meta.com
Subject: Re: [PATCH v2] mm: page_alloc: make defrag_mode retries follow the
 promoted order
Message-Id: <20261006164122.ea9a673b336b8ac74725c35c@linux-foundation.org>
In-Reply-To: <20261006091815.897133-1-kirill@shutemov.name>
References: <20261006091815.897133-1-kirill@shutemov.name>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  6 Oct 2026 10:18:13 +0100 Kiryl Shutsemau <kirill@shutemov.name> wrote:

> From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
> 
> Since commit 7e8756d7ad22 ("mm: page_alloc: fix non-movable reclaim
> storm in defrag_mode"), direct reclaim and compaction for non-movable
> requests under defrag_mode run at pageblock_order, to produce the whole
> blocks that ALLOC_NOFRAGMENT needs. The retry decisions that follow
> still use the request order. An order-0 request can therefore retry
> indefinitely without ever reaching the ALLOC_NOFRAGMENT fallback:
> 
> ...
> 
> In a VM reproducer (32G, defrag_mode, inode churn under memory.low):
> 
>                                         before    after
>     should_reclaim_retry() calls           63M     293k
>     peak memory pressure (PSI some avg10)  99%      12%
> 
> File creation runs 5.7x faster.

> Fixes: 7e8756d7ad22 ("mm: page_alloc: fix non-movable reclaim storm in defrag_mode")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> ---
> v2:
>  - keep the compaction priority floor and the COMPACT_SUCCESS retry
>    limit on the request order, so non-costly requests still escalate to
>    SYNC_FULL before falling back (Harry Yoo, Johannes Weiner)
>  - compute the promoted order once in __alloc_pages_slowpath() and pass
>    it to direct reclaim, direct compaction and the retry helpers, instead
>    of each of them deriving it (Harry Yoo)

Thanks.  That's a fairly large update.  v2 diff is below.

Are we sure about cc:stable?  Or even 7.3-rcX?  It's a pretty big
change.


 mm/page_alloc.c |   62 +++++++++++++++++++++++++---------------------
 1 file changed, 34 insertions(+), 28 deletions(-)

--- a/mm/page_alloc.c~a
+++ a/mm/page_alloc.c
@@ -4139,8 +4139,9 @@ out:
  * For those, promote the order of reclaim and compaction to help make
  * blocks, instead of spinning in reclaim alone unproductively. Retry
  * decisions based on the outcome of that work - reclaim progress and
- * compaction results - must account for the promotion as well, see
- * should_reclaim_retry() and should_compact_retry().
+ * compaction results - must account for the promotion as well, so
+ * __alloc_pages_slowpath() computes the promoted order once and passes
+ * it alongside the request order.
  */
 static inline unsigned int nofrag_promote_order(unsigned int order,
 						unsigned int alloc_flags,
@@ -4162,8 +4163,9 @@ static inline unsigned int nofrag_promot
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
@@ -4174,7 +4176,6 @@ __alloc_pages_direct_compact(gfp_t gfp_m
 		.order = order,
 		.page = NULL,
 	};
-	unsigned int compact_order = nofrag_promote_order(order, alloc_flags, ac);
 
 	if (!compact_order)
 		return NULL;
@@ -4256,7 +4257,7 @@ __alloc_pages_direct_compact(gfp_t gfp_m
 
 static inline bool
 should_compact_retry(gfp_t gfp_mask, struct alloc_context *ac, int order,
-		     int alloc_flags,
+		     int compact_order, int alloc_flags,
 		     enum compact_result compact_result,
 		     enum compact_priority *compact_priority,
 		     int *compaction_retries)
@@ -4266,10 +4267,7 @@ should_compact_retry(gfp_t gfp_mask, str
 	bool ret = false;
 	int retries = *compaction_retries;
 	enum compact_priority priority = *compact_priority;
-	unsigned int compact_order;
 
-	/* Check the compaction result at the order compaction ran at */
-	compact_order = nofrag_promote_order(order, alloc_flags, ac);
 	if (!compact_order)
 		return false;
 
@@ -4304,7 +4302,7 @@ should_compact_retry(gfp_t gfp_mask, str
 		 * need much more detailed feedback from compaction to
 		 * make a better decision.
 		 */
-		if (compact_order > PAGE_ALLOC_COSTLY_ORDER)
+		if (order > PAGE_ALLOC_COSTLY_ORDER)
 			max_retries /= 4;
 
 		if (++(*compaction_retries) <= max_retries) {
@@ -4316,7 +4314,7 @@ should_compact_retry(gfp_t gfp_mask, str
 	/*
 	 * Compaction failed. Retry with increasing priority.
 	 */
-	min_priority = (compact_order > PAGE_ALLOC_COSTLY_ORDER) ?
+	min_priority = (order > PAGE_ALLOC_COSTLY_ORDER) ?
 			MIN_COMPACT_COSTLY_PRIORITY : MIN_COMPACT_PRIORITY;
 
 	if (*compact_priority > min_priority) {
@@ -4331,8 +4329,9 @@ out:
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
@@ -4340,7 +4339,7 @@ __alloc_pages_direct_compact(gfp_t gfp_m
 
 static inline bool
 should_compact_retry(gfp_t gfp_mask, struct alloc_context *ac, int order,
-		     int alloc_flags,
+		     int compact_order, int alloc_flags,
 		     enum compact_result compact_result,
 		     enum compact_priority *compact_priority,
 		     int *compaction_retries)
@@ -4479,13 +4478,12 @@ __perform_reclaim(gfp_t gfp_mask, unsign
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
-	unsigned int reclaim_order = nofrag_promote_order(order, alloc_flags, ac);
 
 	psi_memstall_enter(&pflags);
 	*did_some_progress = __perform_reclaim(gfp_mask, reclaim_order, ac);
@@ -4651,8 +4649,9 @@ bool gfp_pfmemalloc_allowed(gfp_t gfp_ma
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
@@ -4671,7 +4670,7 @@ should_reclaim_retry(gfp_t gfp_mask, uns
 	 * whether the request itself could succeed after reclaim.
 	 */
 	if (did_some_progress && order <= PAGE_ALLOC_COSTLY_ORDER &&
-	    nofrag_promote_order(order, alloc_flags, ac) == order)
+	    reclaim_order == order)
 		*no_progress_loops = 0;
 	else
 		(*no_progress_loops)++;
@@ -4811,6 +4810,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, u
 	const bool costly_order = order > PAGE_ALLOC_COSTLY_ORDER;
 	struct page *page = NULL;
 	unsigned int alloc_flags;
+	unsigned int reclaim_order;
 	unsigned long did_some_progress;
 	enum compact_priority compact_priority;
 	enum compact_result compact_result;
@@ -4955,17 +4955,22 @@ retry:
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
 
@@ -5017,8 +5022,9 @@ retry:
 	    check_retry_zonelist(zonelist_iter_cookie))
 		goto restart;
 
-	if (should_reclaim_retry(gfp_mask, order, ac, alloc_flags,
-				 did_some_progress > 0, &no_progress_loops))
+	if (should_reclaim_retry(gfp_mask, order, reclaim_order, ac,
+				 alloc_flags, did_some_progress > 0,
+				 &no_progress_loops))
 		goto retry;
 
 	/*
@@ -5028,8 +5034,8 @@ retry:
 	 * of free memory (see __compaction_suitable)
 	 */
 	if (did_some_progress > 0 && can_compact &&
-	    should_compact_retry(gfp_mask, ac, order, alloc_flags,
-				 compact_result, &compact_priority,
+	    should_compact_retry(gfp_mask, ac, order, reclaim_order,
+				 alloc_flags, compact_result, &compact_priority,
 				 &compaction_retries))
 		goto retry;
 
_

