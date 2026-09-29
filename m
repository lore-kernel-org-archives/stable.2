Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DC4530E04;
	Tue, 29 Sep 2026 18:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790707185; cv=none; b=bopdBFTbJ+xE9dPHRcnSH+slkB9jOyhSPHk/82oqis4ySgGalPNqcHWBfglyLFE91Yo4n7ijKmRS4DRaP73OvsUixItNaf1fQh2GWfdcQh73/Fl/PPeHQI9K6yHSMuFqMBP4MciIrAEID/uHfho8h8Xj/4ahurs4ywxN5csN5f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790707185; c=relaxed/simple;
	bh=ph9bHsYI3JqLzB4PWc/Eu+4+s7+BpjjhNBexqghz8Y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DwJjPEzf69b0EU8RMOsfMqlWJSTRWTUKJ1qFaYjOq9LZgzh1HE2S5hcMyTC444GeabpaK3muxpmi2tGdR4UFDxvwIDOl7OhkepV2W0qpNWI/t5wFhmO/HcxqhZlC2gs6kWAs4/RADxVOyRYmE5MSnssFyBKt2PQMewS2UWWH//Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bsq+MtNW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bsq+MtNW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E10C51F000FF;
	Tue, 29 Sep 2026 18:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790707183;
	bh=eoY6gHtBmU6a534BKFQNg6hiDEc/4mQhGdZ4OCtJxeQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bsq+MtNWtOdA2aq+jJuJnDVkljsirbp93Y5SrZcHi14dt0uaKoWpyhZ/rbbQBd7vt
	 XVyIEV0VOlNgIor4uAWUz/xisoDqPgJJPxHNmWSBSgyAn50jJwS3oy8atqrVH2Nuai
	 XaIk6M37xjlp6hWy61bSibBbRVBiljmy6yQTzmcrEMaa5eMjcZGMamnFDKNM+9s+5Z
	 N2DfxO52obWbANfCpTuRhA2brNAZ7RLFiWIGMuOdPYBeG+1WnCtb1uSIsEgcSkPaOY
	 ChyUj47kxyIld535jBIctREbkI6Dj5g0tymHTgh+L1cVoDtftXbdRcmb3bcxQgBKAW
	 dAYoJMRNTM1vA==
Date: Tue, 29 Sep 2026 19:39:41 +0100
From: Harry Yoo <harry@kernel.org>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@kernel.org>, "Kiryl Shutsemau (Meta)" <kas@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Zi Yan <ziy@nvidia.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] mm: page_alloc: make defrag_mode retries follow the
 promoted order
Message-ID: <arv8J7ysrdazJmfY@thinkstation>
References: <20260929174553.175333-1-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929174553.175333-1-kirill@shutemov.name>

On Tue, Sep 29, 2026 at 06:45:51PM +0100, Kiryl Shutsemau wrote:
> From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
> 
> Since commit 7e8756d7ad22 ("mm: page_alloc: fix non-movable reclaim
> storm in defrag_mode"), direct reclaim and compaction for non-movable
> requests under defrag_mode run at pageblock_order, to produce the whole
> blocks that ALLOC_NOFRAGMENT needs.

> The retry decisions that follow still use the request order.

Indeed, good catch!

> An order-0 request can therefore retry
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

Makes sense to me.

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
> Treat promoted requests like costly orders:
> 
> - Reclaim progress does not reset no_progress_loops for them.
> 
> - should_compact_retry() checks the compaction result at the promoted
>   order. It does not retry COMPACT_SKIPPED, since the request can fall
>   back, and it does not escalate compaction to COMPACT_PRIO_SYNC_FULL.
> 
> When the fallback is taken, reset the retry counters, so that the
> fallback attempt gets a full retry budget before the OOM killer is
> considered.
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
> Cc: <stable@vger.kernel.org>
> Assisted-by: LLM
> Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> ---
>  mm/page_alloc.c | 85 ++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 56 insertions(+), 29 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 12fac9084c48..608487672d93 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4127,6 +4127,31 @@ __alloc_pages_may_oom(gfp_t gfp_mask, unsigned int order,
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
> + * compaction results - must account for the promotion as well, see
> + * should_reclaim_retry() and should_compact_retry().
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

I think we should start distinguishing order and compact/reclaim_order
in __alloc_pages_slowpath(). Silently overriding it makes it harder to
follow and easy to make a mistake.

>  /*
>   * Maximum number of compaction retries with a progress before OOM
>   * killer is consider as the only way to move forward.
> @@ -4256,8 +4266,11 @@ should_compact_retry(gfp_t gfp_mask, struct alloc_context *ac, int order,
>  	bool ret = false;
>  	int retries = *compaction_retries;
>  	enum compact_priority priority = *compact_priority;
> +	unsigned int compact_order;
>  
> -	if (!order)
> +	/* Check the compaction result at the order compaction ran at */
> +	compact_order = nofrag_promote_order(order, alloc_flags, ac);
> +	if (!compact_order)
>  		return false;
>  
>  	if (fatal_signal_pending(current))
> @@ -4299,7 +4316,7 @@ should_compact_retry(gfp_t gfp_mask, struct alloc_context *ac, int order,
>  	/*
>  	 * Compaction failed. Retry with increasing priority.
>  	 */
> -	min_priority = (order > PAGE_ALLOC_COSTLY_ORDER) ?
> +	min_priority = (compact_order > PAGE_ALLOC_COSTLY_ORDER) ?
>  			MIN_COMPACT_COSTLY_PRIORITY : MIN_COMPACT_PRIORITY;

This would change how hard we try to compact with defrag_mode in direct
compaction as it won't try compaction with MIN_COMPACT_PRIORITY anymore.

It doesn't make much sense to change that as part of this fix?

>  
>  	if (*compact_priority > min_priority) {

-- 
Cheers,
Harry / Hyeonggon
