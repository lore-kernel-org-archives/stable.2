Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434C22DC789;
	Tue, 13 Oct 2026 18:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791915349; cv=none; b=Nz3Ncqko10u2udXz3F7PU1S3ExKev6JkC4/ICHZAafEWH9NcsEJ0LQq4VCTaNERswhSZPTZMzCorJOb1r5uRtP9pnyCbf6HOCgmkVJi6A11tE9BP+DwHWoKi1Io0GjpixiKKSxmgdX+rf2sFvjrCqmg9Hnu70173jtOMgjworuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791915349; c=relaxed/simple;
	bh=Qv1CvT4tZ96DIlwANVX9XMFIJ4hcjcRRr+xrn/F0hhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b1IoQQP+lBoiJSJ+QdgU90EsYLktIin8OIsHDNY59dTVQDg4taH8P1LUskuKiPlSZ2jeVK2Ao599aPjDbXCQnqMhXNkrdI+iul8Xd5uOXJgGffKTSzhUMBVbPbXx5G327JNsxhgrA8uzQfeejWp9VuN5duAKimRNkkH9b50kJT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c8L5vrQe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8L5vrQe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFDE11F000FF;
	Tue, 13 Oct 2026 18:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791915347;
	bh=7eFeDKak6G7QTjlikd0utMlJUAH18N9G3C9/xQ9npw4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=c8L5vrQeu1NmmlEVpcK56QAFDFhRdM74zac3J76d3JD5avcFrlJ00RHf0Vl9jjQ38
	 I4cvg6Q0xuE+R2BxeJ6pZFpQAzgGejak0ZZK9B6dcUP+gbTpuCNUTR1+GPGo3U0f2X
	 jhh+qlHgIZJ5UYZrTdBefc/TL2GWdGQvhnpsO49LmpgtWV7O7lyg9SyNbQ52Z1XRIG
	 amPmILGpJerZa7hqiPyW/5cEtBVUG3xbnZR7+NECMTJv2bswIOdNP7MOn8QkHfEFr2
	 9wCKs4S0BgKwfXuf50OptGV7Ke3J7zcIovRwUvpmlaEr16tTTXD2I+SKL5I4ycdTyK
	 KqEwGxlDlUjLw==
Message-ID: <1f765ae3-434c-4e65-b749-c1e71cce7f33@kernel.org>
Date: Tue, 13 Oct 2026 20:15:42 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm: page_alloc: make defrag_mode retries follow the
 promoted order
Content-Language: en-US
To: Kiryl Shutsemau <kas@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand
 <david@kernel.org>, Harry Yoo <harry@kernel.org>,
 Usama Arif <usama.arif@linux.dev>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <brendan.jackman@linux.dev>,
 Zi Yan <ziy@nvidia.com>, Shakeel Butt <shakeel.butt@linux.dev>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 kernel-team@meta.com
References: <20261009125503.126202-1-kas@kernel.org>
 <15a9e03e-c748-4e51-b8cc-583a3610c897@kernel.org>
 <20261012192834.6934ef85444dee4a60d6d876@linux-foundation.org>
 <as5q14OsbK2CmOrh@thinkstation>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <as5q14OsbK2CmOrh@thinkstation>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/13/26 19:37, Kiryl Shutsemau wrote:
> On Mon, Oct 12, 2026 at 07:28:34PM -0700, Andrew Morton wrote:
>> On Mon, 12 Oct 2026 13:40:36 +0200 "Vlastimil Babka (SUSE)" <vbabka@kernel.org> wrote:
>> 
>> > > In a VM reproducer (32G, defrag_mode, inode churn under memory.low):
>> > > 
>> > >                                         before    after
>> > >     should_reclaim_retry() calls           63M     293k
>> > >     peak memory pressure (PSI some avg10)  99%      12%
>> > > 
>> > > File creation runs 5.7x faster.
>> > > 
>> > > Fixes: 7e8756d7ad22 ("mm: page_alloc: fix non-movable reclaim storm in defrag_mode")
>> > > Cc: stable@vger.kernel.org
>> > > Assisted-by: LLM
>> > > Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
>> > 
>> > LGTM, but I think we could simplify and get rid of all the function
>> > parameter additions by adding a field to alloc_context instead? We could
>> > call it e.g. reclaim_compact_order.
>> > 
>> > The function nofrag_promote_order() probably doesn't need to exist, given it
>> > has just one caller, could be just open coded.
>> > 
>> > What could be useful instead is wrapper for comparing order vs
>> > ac->reclaim_compact_order. E.g. something like bool
>> > order_nofrag_promoted(order, ac) ?
>> 
>> I'm concerned about the sheer size of this patch.  It fixes significant
>> issues, but it's not going to be a simple or safe backport.
>> 
>> So for now please let's optimize for simplicity and backportability and
>> defer cleanups for the -rc cycle.
>> 
>> Of course, if the changes you suggest achieve that then go for it.
> 
> They do. The patch with Vlastimil's suggestion is below. It is shorter.
> Behaviour is unchanged; the reproducer gives the same results on both
> versions.
> 
> Vlastimil, does it look like what you had in mind?

Yeah LGTM.

Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

> 
>> Perhaps we should defer this change into next -rc?  It has cc:stable so
>> it'll eventually end up where we want it.
> 
> Do you mean the next -rc cycle? I hoped to get it into 7.4-rc1, as we
> agreed earlier.

We're fixing a 7.3 commit that went into the stable trees. Too late to rush
for the 7.3 final though. The impact is mitigated by defrag_mode not being
default, so it's fine to fix it in 7.3.x. Thus 7.4-rc1 would be great, rc2
could also work, but wouldn't delay more. I read the merge window might be 3
weeks this time [1] so perhaps rc1 is comfortable in any case.

[1] https://lwn.net/Articles/1099594

> 
> ----------------------------------->8----------------------------------
> 
> From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
> Subject: [PATCH v4] mm: page_alloc: make defrag_mode retries follow the promoted order
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
> When a promoted request takes the fallback, reset the retry counters,
> so that the fallback attempt gets a full retry budget before the OOM
> killer is considered. A request whose reclaim was not promoted spent
> its budget on the request itself and keeps its counters, as Usama Arif
> pointed out.
> 
> __alloc_pages_slowpath() computes the promoted order once per iteration
> and keeps it in alloc_context for direct reclaim, direct compaction and
> the two retry helpers, so no callee has to recompute it. Harry Yoo asked
> for the promoted order to be explicit rather than derived in each
> callee, and Vlastimil Babka suggested alloc_context over new function
> parameters.
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
> ---
> v4:
>  - keep the promoted order in alloc_context instead of passing it as a
>    new parameter (Vlastimil Babka)
> 
>  mm/page_alloc.c | 65 +++++++++++++++++++++++++++++--------------------
>  mm/page_alloc.h |  2 ++
>  2 files changed, 41 insertions(+), 26 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 12fac9084c48..c593913a14f8 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4127,6 +4127,12 @@ __alloc_pages_may_oom(gfp_t gfp_mask, unsigned int order,
>  	return page;
>  }
>  
> +static inline bool order_nofrag_promoted(unsigned int order,
> +					 const struct alloc_context *ac)
> +{
> +	return ac->reclaim_compact_order != order;
> +}
> +
>  /*
>   * Maximum number of compaction retries with a progress before OOM
>   * killer is consider as the only way to move forward.
> @@ -4149,22 +4155,7 @@ __alloc_pages_direct_compact(gfp_t gfp_mask, unsigned int order,
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
> +	int compact_order = ac->reclaim_compact_order;
>  
>  	if (!compact_order)
>  		return NULL;
> @@ -4257,7 +4248,7 @@ should_compact_retry(gfp_t gfp_mask, struct alloc_context *ac, int order,
>  	int retries = *compaction_retries;
>  	enum compact_priority priority = *compact_priority;
>  
> -	if (!order)
> +	if (!ac->reclaim_compact_order)
>  		return false;
>  
>  	if (fatal_signal_pending(current))
> @@ -4266,10 +4257,12 @@ should_compact_retry(gfp_t gfp_mask, struct alloc_context *ac, int order,
>  	/*
>  	 * Compaction was skipped due to a lack of free order-0
>  	 * migration targets. Continue if reclaim can help.
> +	 * Promoted requests fall back instead.
>  	 */
>  	if (compact_result == COMPACT_SKIPPED) {
> -		ret = compaction_zonelist_suitable(ac, order, alloc_flags,
> -						   gfp_mask);
> +		if (!order_nofrag_promoted(order, ac))
> +			ret = compaction_zonelist_suitable(ac, order,
> +							   alloc_flags, gfp_mask);
>  		goto out;
>  	}
>  
> @@ -4468,11 +4461,7 @@ __alloc_pages_direct_reclaim(gfp_t gfp_mask, unsigned int order,
>  	struct page *page = NULL;
>  	unsigned long pflags;
>  	bool drained = false;
> -	int reclaim_order = order;
> -
> -	/* Match the slowpath compaction promotion in __alloc_pages_direct_compact */
> -	if ((alloc_flags & ALLOC_NOFRAGMENT) && ac->migratetype != MIGRATE_MOVABLE)
> -		reclaim_order = max(order, pageblock_order);
> +	int reclaim_order = ac->reclaim_compact_order;
>  
>  	psi_memstall_enter(&pflags);
>  	*did_some_progress = __perform_reclaim(gfp_mask, reclaim_order, ac);
> @@ -4648,9 +4637,12 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned order,
>  	/*
>  	 * Costly allocations might have made a progress but this doesn't mean
>  	 * their order will become available due to high fragmentation so
> -	 * always increment the no progress counter for them
> +	 * always increment the no progress counter for them. The same goes for
> +	 * promoted requests: their reclaim reports progress when it backs off
> +	 * for compaction without freeing anything.
>  	 */
> -	if (did_some_progress && order <= PAGE_ALLOC_COSTLY_ORDER)
> +	if (did_some_progress && order <= PAGE_ALLOC_COSTLY_ORDER &&
> +	    !order_nofrag_promoted(order, ac))
>  		*no_progress_loops = 0;
>  	else
>  		(*no_progress_loops)++;
> @@ -4934,6 +4926,22 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>  	/* If allocation has taken excessively long, warn about it */
>  	check_alloc_stall_warn(gfp_mask, ac->nodemask, order, alloc_start_time);
>  
> +	/*
> +	 * If fallbacks are not permitted (defrag_mode), we either
> +	 * need to reclaim space in a block of matching type, or clear
> +	 * out an entire block to allow __rmqueue_claim() to convert.
> +	 *
> +	 * Reclaim by itself is primarily freeing space in movable
> +	 * blocks, since that's where the LRU pages live. So this
> +	 * works for movable requests, but not for others.
> +	 *
> +	 * For those, promote the order to help make blocks, instead
> +	 * of spinning in reclaim alone unproductively.
> +	 */
> +	ac->reclaim_compact_order = order;
> +	if ((alloc_flags & ALLOC_NOFRAGMENT) && ac->migratetype != MIGRATE_MOVABLE)
> +		ac->reclaim_compact_order = max(order, pageblock_order);
> +
>  	/* Try direct reclaim and then allocating */
>  	if (!compact_first) {
>  		page = __alloc_pages_direct_reclaim(gfp_mask, order, alloc_flags,
> @@ -5015,6 +5023,11 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>  	/* Reclaim/compaction failed to prevent the fallback */
>  	if (defrag_mode && (alloc_flags & ALLOC_NOFRAGMENT)) {
>  		alloc_flags &= ~ALLOC_NOFRAGMENT;
> +		/* Retries went into making blocks, start the fallback afresh */
> +		if (order_nofrag_promoted(order, ac)) {
> +			no_progress_loops = 0;
> +			compaction_retries = 0;
> +		}
>  		goto retry;
>  	}
>  
> diff --git a/mm/page_alloc.h b/mm/page_alloc.h
> index b9259deddb59..2b1017a91928 100644
> --- a/mm/page_alloc.h
> +++ b/mm/page_alloc.h
> @@ -93,6 +93,8 @@ struct alloc_context {
>  	bool spread_dirty_pages;
>  	/* Only flags that are global to the whole allocation go here. */
>  	unsigned int alloc_flags;
> +	/* Set by __alloc_pages_slowpath() before reclaim and compaction */
> +	unsigned int reclaim_compact_order;
>  };
>  
>  /*

