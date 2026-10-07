Received: from mta1.migadu.com (out-145.mta1.migadu.com [95.215.58.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CBE42123E
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 15:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791388404; cv=none; b=S9zzXZ6eHa8xRRdJVkWObQop4XSLf6tC/k342Q1I+JbPX/JKeL+F+kSF8vFcMbPd6oDEPyFK9Z3P6MhjLeEnMm5xAe+xSQwL96i+l+DjrkXG7MUpklgw4QYOetCTNG9qTZf8GMCI/XgEZSfLplUi5k+6gmuIBROUgnriIoTgJ4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791388404; c=relaxed/simple;
	bh=NN1LFKmcwSNUSABIR1+OWEbwCszOVMREwMQ7NIyyAac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hnx2RBu35GequmRx2iG0rlQZM0nMrWwMkwcu8OMhu7mGbixn/rayHhgyin+sZF6VvV+F3kdEav6ZOm+gELDZgMPkOYN63kJUbzVkwnDz/dhWZN7P6gl7U6WsaI4fHaYIPQFv/DO0Vyz7e3mKD50BqE2W/MkxKpcXghDwnRVFFjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uilj2SZU; arc=none smtp.client-ip=95.215.58.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uilj2SZU"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=NN1LFKmcwSNUSABIR1+OWEbwCszOVMREwMQ7NIyyAac=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791388399; v=1; x=1791993199;
 b=uilj2SZUkBURt9YqcDIAmABHh2QctRQepCZbWeadF5qUA09EtcaqbSncRa0M4DzffigSNfBF
 VEJ2+GqzvReRRp1XU/ZO55YG/wj3C2vbZXg3BVlIJrMxN/U3i3d/QkeEbF6RgBgnCabgYDr7SJh
 gQga4N+JpONq2OuU+jRbaM5U=
X-Envelope-To: stable@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 096a6bbfb1de998f;
	Wed, 07 Oct 2026 15:53:19 +0000
X-Mizu-Trace-ID: 096a6bbfb1de998f
X-Migadu-Flow: FLOW_OUT
From: Usama Arif <usama.arif@linux.dev>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Usama Arif <usama.arif@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	David Hildenbrand <david@kernel.org>,
	Harry Yoo <harry@kernel.org>,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Zi Yan <ziy@nvidia.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v2] mm: page_alloc: make defrag_mode retries follow the promoted order
Date: Wed,  7 Oct 2026 08:53:14 -0700
Message-ID: <20261007155316.2010164-1-usama.arif@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006091815.897133-1-kirill@shutemov.name>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
> When the fallback is taken, reset the retry counters, so that the
> fallback attempt gets a full retry budget before the OOM killer is
> considered.
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

[..]

>  @@ -5007,14 +5034,20 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
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
> +	 * Reclaim/compaction failed to prevent the fallback. The retry
> +	 * budget was spent on making blocks, not on the request itself;
> +	 * give the fallback a fresh one before considering OOM.
> +	 */
>  	if (defrag_mode && (alloc_flags & ALLOC_NOFRAGMENT)) {
>  		alloc_flags &= ~ALLOC_NOFRAGMENT;
> +		no_progress_loops = 0;
> +		compaction_retries = 0;

Should these counters be reset only when the work order was actually
promoted?

For movable requests, and requests already at or above pageblock
order, `reclaim_order == order`. Their retry budget was therefore
spent on the request itself rather than on promoted pageblock
production. Resetting the counters here can give those requests
another 17 no-progress reclaim attempts, plus additional
compaction-success retries, before OOM or allocation failure.

How about:
	if (reclaim_order != order) {
		no_progress_loops = 0;
		compaction_retries = 0;
	}

instead?

>  		goto retry;
>  	}
>  
> -- 
> 2.54.0
> 
> 
