Received: from mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44733B2FDB
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 14:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791554765; cv=none; b=M13QHXHrekQ54oSQOtZY919c2jZHQP0MsK5WQAVZK4kdum3/KZ/VcERgickoMbmCOcNXmuUudtY5p8cf0FZ5IYuaMY58v8RddkncVVXqGFUbD/JyU7kG+zJ/JdNvEJChvv1VCtDYLUv9aRhv1BD1WpG65R538qOijWdabJau3sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791554765; c=relaxed/simple;
	bh=S/CJoQ6h8dM6bvOekOhXaJ1D4NhgPmP4sTYIwx5h4vw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S9D4PLJY375JIn76rdvKgNwX06KatmvdKDe/W4k/7dUr4LDdEOUHMq9svDTkLhUMJ0tiHcyT5VjDu7QeBOEqtHtDDsTliglxxk/CzP/RFv56yQL15dYytuOSNV4XO8B0BZcP8k23tuStMZ1RnkCRyzn/SHxtTjJY3d76tTZrehY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vc3tnERI; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vc3tnERI"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=S/CJoQ6h8dM6bvOekOhXaJ1D4NhgPmP4sTYIwx5h4vw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791554756; v=1; x=1792159556;
 b=vc3tnERIjqp7uh4ESphNz9ZrEtCr3dUje5+8j7NLo5aG+ElLDbmKfD6vCPnOKQeqc2zM4gCf
 msExhwnRz8fjHpdnmOal2V/xnr2KPi8uKMTrqc8LPnenTO9vvzXKETETlk3sD5wr39gdGh3dKHd
 t6GrCgiQY7siMn6z3Tz7ILBU=
X-Envelope-To: stable@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id a5ec3c62b9adca70;
	Fri, 09 Oct 2026 14:05:56 +0000
X-Mizu-Trace-ID: a5ec3c62b9adca70
X-Migadu-Flow: FLOW_OUT
From: Usama Arif <usama.arif@linux.dev>
To: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Cc: Usama Arif <usama.arif@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	David Hildenbrand <david@kernel.org>,
	Harry Yoo <harry@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Zi Yan <ziy@nvidia.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v3] mm: page_alloc: make defrag_mode retries follow the promoted order
Date: Fri,  9 Oct 2026 07:05:47 -0700
Message-ID: <20261009140549.541127-1-usama.arif@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009125503.126202-1-kas@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri,  9 Oct 2026 13:55:02 +0100 "Kiryl Shutsemau (Meta)" <kas@kernel.org> wrote:

> Since commit 7e8756d7ad22 ("mm: page_alloc: fix non-movable reclaim
> storm in defrag_mode"), direct reclaim and compaction for non-movable
> requests under defrag_mode run at pageblock_order, to produce the whole
> blocks that ALLOC_NOFRAGMENT needs. The retry decisions that follow
> still use the request order. An order-0 request can therefore retry
> indefinitely without ever reaching the ALLOC_NOFRAGMENT fallback:
> 
> - Reclaim at pageblock_order gives up after one pass as soon as a zone
>   looks compaction_ready(), and do_try_to_free_pages() then returns 1
>   even though nothing was reclaimed. It returns before the retry that
>   would reclaim memory.low-protected cgroups, so when most memory is
>   protected, the pass that did run finds next to nothing.
> 
> - Compaction at pageblock_order fails or is deferred.
> 
> - should_reclaim_retry() takes the reported progress as progress for
>   the order-0 request and resets no_progress_loops. The request
>   retries.
> 
> Order 1-3 requests loop the same way, and should_compact_retry() also
> checks their pageblock_order compaction result against the request
> order.
> 
> On a production host (64G, defrag_mode, memory.low covering most of the
> workload), 95% of direct reclaim runs were order-9 runs that returned 1
> with nothing reclaimed, at up to 60k runs per second. Across ~200M
> should_reclaim_retry() calls in a day, no_progress_loops never left 0.
> The spinning allocations were SLUB slab refills for inode and dentry
> caches. The time spent registers as memory pressure, and pressure-based
> OOM killing takes down both workloads and system services.
> 
> For promoted requests:
> 
> - Reclaim progress does not reset no_progress_loops, as for costly
>   orders.
> 
> - should_compact_retry() checks the compaction result at the promoted
>   order and does not retry COMPACT_SKIPPED, since the request can fall
>   back. The compaction priority floor and the COMPACT_SUCCESS retry
>   limit stay those of the request order, so a non-costly request still
>   gets its COMPACT_PRIO_SYNC_FULL pass before it falls back.
> 
> When a promoted request takes the fallback, reset the retry counters,
> so that the fallback attempt gets a full retry budget before the OOM
> killer is considered. A request whose reclaim was not promoted spent
> its budget on the request itself and keeps its counters, as Usama Arif
> pointed out.
> 
> __alloc_pages_slowpath() computes the promoted order once per iteration
> and passes it to direct reclaim, direct compaction and the two retry
> helpers next to the request order, so no callee has to recompute it.
> Harry Yoo asked for the two orders to be explicit rather than derived
> in each callee.
> 
> In a VM reproducer (32G, defrag_mode, inode churn under memory.low):
> 
>                                         before    after
>     should_reclaim_retry() calls           63M     293k
>     peak memory pressure (PSI some avg10)  99%      12%
> 
> File creation runs 5.7x faster.
> 
> Fixes: 7e8756d7ad22 ("mm: page_alloc: fix non-movable reclaim storm in defrag_mode")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

Acked-by: Usama Arif <usama.arif@linux.dev>

> ---
> v3:
>  - reset the retry counters at the fallback only for requests whose
>    reclaim was promoted; a movable request already spent its budget on
>    itself (Usama Arif)
> 
> v2:
>  - keep the compaction priority floor and the COMPACT_SUCCESS retry
>    limit on the request order, so non-costly requests still escalate to
>    SYNC_FULL before falling back (Harry Yoo, Johannes Weiner)
>  - compute the promoted order once in __alloc_pages_slowpath() and pass
>    it to direct reclaim, direct compaction and the retry helpers, instead
>    of each of them deriving it (Harry Yoo)
> 
>  mm/page_alloc.c | 126 +++++++++++++++++++++++++++++++-----------------
>  1 file changed, 81 insertions(+), 45 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 12fac9084c48..c0be88d2c3ad 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4127,6 +4127,32 @@ __alloc_pages_may_oom(gfp_t gfp_mask, unsigned int order,
>  	return page;
>  }
>  
> +/*
> + * If fallbacks are not permitted (defrag_mode), we either need to
> + * reclaim space in a block of matching type, or clear out an entire
> + * block to allow __rmqueue_claim() to convert.
> + *
> + * Reclaim by itself is primarily freeing space in movable blocks,
> + * since that's where the LRU pages live. So this works for movable
> + * requests, but not for others.
> + *
> + * For those, promote the order of reclaim and compaction to help make
> + * blocks, instead of spinning in reclaim alone unproductively. Retry
> + * decisions based on the outcome of that work - reclaim progress and
> + * compaction results - must account for the promotion as well, so
> + * __alloc_pages_slowpath() computes the promoted order once and passes
> + * it alongside the request order.
> + */
> +static inline unsigned int nofrag_promote_order(unsigned int order,
> +						unsigned int alloc_flags,
> +						const struct alloc_context *ac)
> +{
> +	if ((alloc_flags & ALLOC_NOFRAGMENT) && ac->migratetype != MIGRATE_MOVABLE)
> +		return max(order, pageblock_order);
> +
> +	return order;
> +}
> +
>  /*
>   * Maximum number of compaction retries with a progress before OOM
>   * killer is consider as the only way to move forward.
> @@ -4137,8 +4163,9 @@ __alloc_pages_may_oom(gfp_t gfp_mask, unsigned int order,
>  /* Try memory compaction for high-order allocations before reclaim */
>  static struct page *
>  __alloc_pages_direct_compact(gfp_t gfp_mask, unsigned int order,
> -		unsigned int alloc_flags, const struct alloc_context *ac,
> -		enum compact_priority prio, enum compact_result *compact_result)
> +		unsigned int compact_order, unsigned int alloc_flags,
> +		const struct alloc_context *ac, enum compact_priority prio,
> +		enum compact_result *compact_result)
>  {
>  	struct page *page = NULL;
>  	unsigned long pflags;
> @@ -4149,22 +4176,6 @@ __alloc_pages_direct_compact(gfp_t gfp_mask, unsigned int order,
>  		.order = order,
>  		.page = NULL,
>  	};
> -	int compact_order = order;
> -
> -	/*
> -	 * If fallbacks are not permitted (defrag_mode), we either
> -	 * need to reclaim space in a block of matching type, or clear
> -	 * out an entire block to allow __rmqueue_claim() to convert.
> -	 *
> -	 * Reclaim by itself is primarily freeing space in movable
> -	 * blocks, since that's where the LRU pages live. So this
> -	 * works for movable requests, but not for others.
> -	 *
> -	 * For those, promote the order to help make blocks, instead
> -	 * of spinning in reclaim alone unproductively.
> -	 */
> -	if ((alloc_flags & ALLOC_NOFRAGMENT) && ac->migratetype != MIGRATE_MOVABLE)
> -		compact_order = max(order, pageblock_order);
>  
>  	if (!compact_order)
>  		return NULL;
> @@ -4246,7 +4257,7 @@ __alloc_pages_direct_compact(gfp_t gfp_mask, unsigned int order,
>  
>  static inline bool
>  should_compact_retry(gfp_t gfp_mask, struct alloc_context *ac, int order,
> -		     int alloc_flags,
> +		     int compact_order, int alloc_flags,
>  		     enum compact_result compact_result,
>  		     enum compact_priority *compact_priority,
>  		     int *compaction_retries)
> @@ -4257,7 +4268,7 @@ should_compact_retry(gfp_t gfp_mask, struct alloc_context *ac, int order,
>  	int retries = *compaction_retries;
>  	enum compact_priority priority = *compact_priority;
>  
> -	if (!order)
> +	if (!compact_order)
>  		return false;
>  
>  	if (fatal_signal_pending(current))
> @@ -4266,10 +4277,14 @@ should_compact_retry(gfp_t gfp_mask, struct alloc_context *ac, int order,
>  	/*
>  	 * Compaction was skipped due to a lack of free order-0
>  	 * migration targets. Continue if reclaim can help.
> +	 *
> +	 * Promoted requests have exhausted their reclaim retries at
> +	 * this point, and they can fall back instead.
>  	 */
>  	if (compact_result == COMPACT_SKIPPED) {
> -		ret = compaction_zonelist_suitable(ac, order, alloc_flags,
> -						   gfp_mask);
> +		if (compact_order == order)
> +			ret = compaction_zonelist_suitable(ac, order, alloc_flags,
> +							   gfp_mask);
>  		goto out;
>  	}
>  
> @@ -4314,8 +4329,9 @@ should_compact_retry(gfp_t gfp_mask, struct alloc_context *ac, int order,
>  #else
>  static inline struct page *
>  __alloc_pages_direct_compact(gfp_t gfp_mask, unsigned int order,
> -		unsigned int alloc_flags, const struct alloc_context *ac,
> -		enum compact_priority prio, enum compact_result *compact_result)
> +		unsigned int compact_order, unsigned int alloc_flags,
> +		const struct alloc_context *ac, enum compact_priority prio,
> +		enum compact_result *compact_result)
>  {
>  	*compact_result = COMPACT_SKIPPED;
>  	return NULL;
> @@ -4323,7 +4339,7 @@ __alloc_pages_direct_compact(gfp_t gfp_mask, unsigned int order,
>  
>  static inline bool
>  should_compact_retry(gfp_t gfp_mask, struct alloc_context *ac, int order,
> -		     int alloc_flags,
> +		     int compact_order, int alloc_flags,
>  		     enum compact_result compact_result,
>  		     enum compact_priority *compact_priority,
>  		     int *compaction_retries)
> @@ -4462,17 +4478,12 @@ __perform_reclaim(gfp_t gfp_mask, unsigned int order,
>  /* The really slow allocator path where we enter direct reclaim */
>  static inline struct page *
>  __alloc_pages_direct_reclaim(gfp_t gfp_mask, unsigned int order,
> -		unsigned int alloc_flags, const struct alloc_context *ac,
> -		unsigned long *did_some_progress)
> +		unsigned int reclaim_order, unsigned int alloc_flags,
> +		const struct alloc_context *ac, unsigned long *did_some_progress)
>  {
>  	struct page *page = NULL;
>  	unsigned long pflags;
>  	bool drained = false;
> -	int reclaim_order = order;
> -
> -	/* Match the slowpath compaction promotion in __alloc_pages_direct_compact */
> -	if ((alloc_flags & ALLOC_NOFRAGMENT) && ac->migratetype != MIGRATE_MOVABLE)
> -		reclaim_order = max(order, pageblock_order);
>  
>  	psi_memstall_enter(&pflags);
>  	*did_some_progress = __perform_reclaim(gfp_mask, reclaim_order, ac);
> @@ -4638,8 +4649,9 @@ bool gfp_pfmemalloc_allowed(gfp_t gfp_mask)
>   */
>  static inline bool
>  should_reclaim_retry(gfp_t gfp_mask, unsigned order,
> -		     struct alloc_context *ac, int alloc_flags,
> -		     bool did_some_progress, int *no_progress_loops)
> +		     unsigned int reclaim_order, struct alloc_context *ac,
> +		     int alloc_flags, bool did_some_progress,
> +		     int *no_progress_loops)
>  {
>  	struct zone *zone;
>  	struct zoneref *z;
> @@ -4648,9 +4660,17 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned order,
>  	/*
>  	 * Costly allocations might have made a progress but this doesn't mean
>  	 * their order will become available due to high fragmentation so
> -	 * always increment the no progress counter for them
> +	 * always increment the no progress counter for them.
> +	 *
> +	 * The same goes for requests whose reclaim is promoted to make whole
> +	 * blocks. At that order, reclaim also reports progress when it backs
> +	 * off for compaction without freeing anything.
> +	 *
> +	 * The watermark check below stays at the request order: it asks
> +	 * whether the request itself could succeed after reclaim.
>  	 */
> -	if (did_some_progress && order <= PAGE_ALLOC_COSTLY_ORDER)
> +	if (did_some_progress && order <= PAGE_ALLOC_COSTLY_ORDER &&
> +	    reclaim_order == order)
>  		*no_progress_loops = 0;
>  	else
>  		(*no_progress_loops)++;
> @@ -4790,6 +4810,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>  	const bool costly_order = order > PAGE_ALLOC_COSTLY_ORDER;
>  	struct page *page = NULL;
>  	unsigned int alloc_flags;
> +	unsigned int reclaim_order;
>  	unsigned long did_some_progress;
>  	enum compact_priority compact_priority;
>  	enum compact_result compact_result;
> @@ -4934,17 +4955,22 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>  	/* If allocation has taken excessively long, warn about it */
>  	check_alloc_stall_warn(gfp_mask, ac->nodemask, order, alloc_start_time);
>  
> +	/* The order reclaim and compaction work at, see nofrag_promote_order() */
> +	reclaim_order = nofrag_promote_order(order, alloc_flags, ac);
> +
>  	/* Try direct reclaim and then allocating */
>  	if (!compact_first) {
> -		page = __alloc_pages_direct_reclaim(gfp_mask, order, alloc_flags,
> -							ac, &did_some_progress);
> +		page = __alloc_pages_direct_reclaim(gfp_mask, order, reclaim_order,
> +						    alloc_flags, ac,
> +						    &did_some_progress);
>  		if (page)
>  			goto got_pg;
>  	}
>  
>  	/* Try direct compaction and then allocating */
> -	page = __alloc_pages_direct_compact(gfp_mask, order, alloc_flags, ac,
> -					compact_priority, &compact_result);
> +	page = __alloc_pages_direct_compact(gfp_mask, order, reclaim_order,
> +					    alloc_flags, ac, compact_priority,
> +					    &compact_result);
>  	if (page)
>  		goto got_pg;
>  
> @@ -4996,8 +5022,9 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>  	    check_retry_zonelist(zonelist_iter_cookie))
>  		goto restart;
>  
> -	if (should_reclaim_retry(gfp_mask, order, ac, alloc_flags,
> -				 did_some_progress > 0, &no_progress_loops))
> +	if (should_reclaim_retry(gfp_mask, order, reclaim_order, ac,
> +				 alloc_flags, did_some_progress > 0,
> +				 &no_progress_loops))
>  		goto retry;
>  
>  	/*
> @@ -5007,14 +5034,23 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>  	 * of free memory (see __compaction_suitable)
>  	 */
>  	if (did_some_progress > 0 && can_compact &&
> -	    should_compact_retry(gfp_mask, ac, order, alloc_flags,
> -				 compact_result, &compact_priority,
> +	    should_compact_retry(gfp_mask, ac, order, reclaim_order,
> +				 alloc_flags, compact_result, &compact_priority,
>  				 &compaction_retries))
>  		goto retry;
>  
> -	/* Reclaim/compaction failed to prevent the fallback */
> +	/*
> +	 * Reclaim/compaction failed to prevent the fallback. A promoted
> +	 * request spent its retry budget on making blocks, not on the
> +	 * request itself; give its fallback a fresh one before
> +	 * considering OOM.
> +	 */
>  	if (defrag_mode && (alloc_flags & ALLOC_NOFRAGMENT)) {
>  		alloc_flags &= ~ALLOC_NOFRAGMENT;
> +		if (reclaim_order != order) {
> +			no_progress_loops = 0;
> +			compaction_retries = 0;
> +		}
>  		goto retry;
>  	}
>  
> -- 
> 2.54.0
> 
> 
