Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F5647CA73;
	Thu, 23 Jul 2026 15:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784819610; cv=none; b=B0dOKE3M98uWIbXTzU/OgcSr64ca7JGZpzv6v3GpeaorculrPOIXZsrh/zBgZcPdEI6D14gy8MoeBHFfFUHGusUHFyF1gwISVW9KEM0L3Ha52FYQqAiUK0aEpzge9P36ntq2yTGvjB5WlddWUj5ux+Knq8J0nu6xONc7oY48D7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784819610; c=relaxed/simple;
	bh=RVG9GWqH5Ev/ge3l6nhXB6vNlKLVAD6oswc33bn050g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u6a0JW4OnPzrShCRIhw7358L507PNQBR0DcxSESovXO386x1BVqsu/8pjJ72ZKF16DC+XBDsNBjorRmKEqnC+zqVNYhdg3tjqz9UzAfP8AC1nldk/AG/JrU5gJhZlgHwR37o6HpKTKFjYD8GOZ1Gn7Y5BEKCkmeUsBZQKYpzWAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C4+cOItT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4+cOItT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3EB41F000E9;
	Thu, 23 Jul 2026 15:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784819608;
	bh=HoPBMTykAXQKt94M9v95tVhkcDwfjpfMlCnu/Xxm4ds=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=C4+cOItT0PnzdfroCEjzlIBcCT0iIVNJSMJ00DEA+XRUedcSK6kfHfm+olDKn9cvS
	 RuYLPUeq8jIyqtW9cYE7NmaPAeTYXW/QatXLgk7nbo3wAS1g170Ogvc0CJdqOOWKYq
	 bAuXzmxNp2eZ1vblRVf7VC7++Nf1+AlokNWcQxqwwNbBZ5k67EBaaiW3GKwW/Z9zy7
	 Y/pQu3lVPRBYIjjeMC5JRXrhN76RBHxvwOFSVP87Poe5dln9KLLpey8rcmjaVWdlrw
	 ozFj8yBt5plg+LI3gv/RC/zaMEVVhxvBToTzbv9ckomOw3NTlmt+yWI0jZMFnZN6ZZ
	 fcBJo+594FICw==
Message-ID: <5a0702a3-9aa1-48e5-bbd8-924289fb1993@kernel.org>
Date: Thu, 23 Jul 2026 17:13:23 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] mm: page_alloc: fix non-movable reclaim storm in
 defrag_mode
Content-Language: en-US
To: Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Brendan Jackman <jackmanb@google.com>, Zi Yan <ziy@nvidia.com>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R . Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260722150006.3848560-1-hannes@cmpxchg.org>
 <20260722150006.3848560-5-hannes@cmpxchg.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 xsFNBFZdmxYBEADsw/SiUSjB0dM+vSh95UkgcHjzEVBlby/Fg+g42O7LAEkCYXi/vvq31JTB
 KxRWDHX0R2tgpFDXHnzZcQywawu8eSq0LxzxFNYMvtB7sV1pxYwej2qx9B75qW2plBs+7+YB
 87tMFA+u+L4Z5xAzIimfLD5EKC56kJ1CsXlM8S/LHcmdD9Ctkn3trYDNnat0eoAcfPIP2OZ+
 9oe9IF/R28zmh0ifLXyJQQz5ofdj4bPf8ecEW0rhcqHfTD8k4yK0xxt3xW+6Exqp9n9bydiy
 tcSAw/TahjW6yrA+6JhSBv1v2tIm+itQc073zjSX8OFL51qQVzRFr7H2UQG33lw2QrvHRXqD
 Ot7ViKam7v0Ho9wEWiQOOZlHItOOXFphWb2yq3nzrKe45oWoSgkxKb97MVsQ+q2SYjJRBBH4
 8qKhphADYxkIP6yut/eaj9ImvRUZZRi0DTc8xfnvHGTjKbJzC2xpFcY0DQbZzuwsIZ8OPJCc
 LM4S7mT25NE5kUTG/TKQCk922vRdGVMoLA7dIQrgXnRXtyT61sg8PG4wcfOnuWf8577aXP1x
 6mzw3/jh3F+oSBHb/GcLC7mvWreJifUL2gEdssGfXhGWBo6zLS3qhgtwjay0Jl+kza1lo+Cv
 BB2T79D4WGdDuVa4eOrQ02TxqGN7G0Biz5ZLRSFzQSQwLn8fbwARAQABzSNWbGFzdGltaWwg
 QmFia2EgPHZiYWJrYUBrZXJuZWwub3JnPsLBsAQTAQoAWhYhBKlA1DSZLC6OmRA9UCJPp+fM
 gqZkBQJqFFy6GxSAAAAAAAQADm1hbnUyLDIuNSsxLjEyLDIsMgIbAwUJGtCBUAULCQgHAwUV
 CgkICwUWAgMBAAIeBQIXgAAKCRAiT6fnzIKmZJIUEADFx/tREzUImHrEwVHeSvDFmA7tJysI
 UVrlvrM09E7GIuzphzv7jYmo8n3ANpCczLEVr4G0syYQdTigaZgv3+FQDIIzhKih1IHhu1Ei
 XHlywNWKnQxxQEUNi5Mwx43wQz5XVw9F1A7gtKBKNtfogO511hAbrzagrYajyQacEJ/+sfhZ
 9Da8ltHIXD8pcYaHUfQgEusCgmEd9+KrUwrTbckFKmYq5chuE6yJ4J0EmWknL096jIE6CnzF
 FRslQ3B1UKDjxVsm1ZHfir5NeWszLkTvGFsddFaWTgh8UycESG6VQzKXjjewXu2pG7YQYRpj
 QKm1W5X2TkwWkXRBZTmfmbhxIUMh3+zf5wQ463rSmDN/8v81tdqBtAW6rH/kzg1GvkaTHXn0
 507yEHFzBksk2viAuIxxr7km8+/KARYLIdGtx30EG8cKzAUZOK6WqxtNCsXUJNrVE8CWrCaD
 icoNu7Fs1c5hmPHdSTnU48ce67449DdnO4neLSNhRiGlMHJgfJUmgrxu/hcYeOZ3haWmEQ2w
 uW1Mh01OHi8QZHCEyAbABrPs9GUgccc/4eYXX9hIgxfSkYzn8f+8NuIFPWl/0uTvjgqU29FQ
 SbzOLxHq9439Ox40G5mS5eZXRGxITYR+6TXvRGI6P/264jvflnr/pDGUttaikU+0W+1uxgKH
 cmYbEc7ATQRbGTU1AQgAn0H6UrFiWcovkh6EXVcl+SeqyO6JHOPm+e9Wu0Vw+VIUvXZVUVVQ
 La1PQDUi6j00ChlcR66g9/V0sPIcSutacPKfdKYOBvzd4rlhL8rfrdEsQw5ApZxrA8kYZVMh
 FmBRKAa6wos25moTlMKpCWzTH84+WO5+ziCTsTUZASAToz3RdunTD+vQcHj0GqNTPAHK63sf
 bAB2I0BslZkXkY1RLb/YhuA6E7JyEd2pilZOrIuBGl/5q2qSakgnAVFWFBR/DO27JuAksYnq
 +aH8vI0xGvwn75KqSk4UzAkDzWSmO4ZHuahKtQgZNsMYV+PGayRBX9b9zbldzopoLBdqHc4n
 jQARAQABwsF8BBgBCgAmAhsMFiEEqUDUNJksLo6ZED1QIk+n58yCpmQFAmfIHFQFCRYU6J8A
 CgkQIk+n58yCpmS2PA//bqN1LfcotmArgElsa+0EGZSQlYgK48pm8WAeTXTngudP9IJ4SuKY
 HR5RNjHcBeqN+Me0zxRqYzRb8nGanHEkDyf4Im8DQM8d6vbyU+FcPmG4skud4kgS1zMHnlVd
 SXfSIwKC/hKgdHG8aBV7545Lz9X6Iohea+94wneD0aw/hqF+QWewGZhWJriWAZtvEkzNjQOi
 4U9F/trLten/x7bpphDSnDMKJtITbtzATT1Dq7o7VpIUK1nCTQALMuMjKCdi8OdU/+V+R3O4
 0PXWvX8qrvqYapVbZ+9KqT74FsuB0Ya9uXwgBF2Q6cRuETZk5vqaqKxzqoQZCO8AOz/58j6O
 2RHNy/mZEN+7tJ5Tsq42zVJ4jxsT8b9YplavCMsnBgDeRWhcbYhCyttoL7nYISyWg4kQYZ/P
 wIV3OuNv2f8iKYsxNsRuClOAF82+gvqOy1/1pprFjy8uo2pkoOrb63aOP3vO5VHnRKgra6dq
 NcaZ+c6J4H+nEJGi2SkHAUJz5oBzuThvPudLvPA/SK8sKoM01IRxSihev/S/5WLazXB1PGem
 OCbvzC1IjWJJraxiDJ5IygokapUa2RP7+WBR22skQ3SSl6G107QgWKSyTOGWEaRmV53vxQLV
 jXuCmzSSasTL60zq5yGrT4/DYQVSNEUiUbG4pYekxJujNeEDkUlky0Y=
In-Reply-To: <20260722150006.3848560-5-hannes@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/22/26 16:56, Johannes Weiner wrote:
> As we deployed defrag_mode into Meta production, pressure spikes and
> excessive swapping were observed on some workloads. Tracing confirmed
> that this is unmovable/reclaimable requests spinning in the allocator
> and direct reclaim, causing excessive amounts of swap.
> 
> The initial plan for defrag_mode was to rely on kswapd/kcompactd to
> produce blocks, and if those are overwhelmed under high pressure, let
> the allocator fall back (__rmqueue_steal()) after its retry loops.
> However, that retrying results in more reclaim on some of these
> workloads than we'd hoped, sometimes excessively so, spurred on by the
> !costly order conditions in should_reclaim_retry().
> 
> The storms are dependent on the request type. Reclaim will inevitably
> make room in existing movable blocks, since that's where the LRU pages
> live. So if movable requests retry on reclaim, they make progress.
> 
> When non-movable requests spin in reclaim that isn't productive. They
> cannot use the individually freed pages, and the process is unlikely
> to accidentally free whole blocks to meet the ALLOC_NOFRAGMENT bar.
> They spin and overreclaim excessively, which tanks performance and
> triggers userspace guards like swap exhaustion or pressure based OOM.
> 
> To fix this, send non-movable requests, regardless of order, into
> pageblock reclaim/compaction. This way, they help move things along to
> meet the ALLOC_NOFRAGMENT bar. After this patch, the reclaim storms
> and excess OOM rates are no longer observed in production.
> 
> The longer-term plan is still to have all requests, including the
> movable ones, help make blocks to spread the cost of defragmenting
> more evenly and fairly; combined with proper watermarking to reduce
> allocation latencies in the common case. However, doing this naively
> unearths scaling and concurrency limitations in compaction that need
> to be addressed first. Promoting just non-movables for now is the
> minimally viable bug fix for the above issue.
> 
> Fixes: e3aa7df331bc ("mm: page_alloc: defrag_mode")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

> ---
>  mm/internal.h   |  6 ++++++
>  mm/page_alloc.c | 31 ++++++++++++++++++++++++++-----
>  2 files changed, 32 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index 6d3402001b93..5acba3470659 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1061,6 +1061,12 @@ struct compact_control {
>  struct capture_control {
>  	struct zone *zone;
>  	int migratetype;
> +	/*
> +	 * Allocation request order. May differ from the compaction
> +	 * order: defrag_mode promotes sub-block allocations to
> +	 * pageblock-order compaction; capture still matches at the
> +	 * original allocation order so prep_new_page() is consistent.
> +	 */

Yeah, a premature capture can't jeopardize the full-pageblock clearing
because compaction_capture() disallows capturing <pageblock_order page from
MOVABLE pageblock for !MOVABLE allocations.

It's thus unlikely the capture will ever succeed in these scenarios. But
it's not wrong.

>  	int order;
>  	struct page *page;
>  };
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 4b9686fedb71..f92055827ae9 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4152,8 +4152,24 @@ __alloc_pages_direct_compact(gfp_t gfp_mask, unsigned int order,
>  		.order = order,
>  		.page = NULL,
>  	};
> +	int compact_order = order;
>  
> -	if (!order)
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
> +	if ((alloc_flags & ALLOC_NOFRAGMENT) && ac->migratetype != MIGRATE_MOVABLE)
> +		compact_order = max(order, pageblock_order);
> +
> +	if (!compact_order)
>  		return NULL;
>  
>  	psi_memstall_enter(&pflags);
> @@ -4169,8 +4185,8 @@ __alloc_pages_direct_compact(gfp_t gfp_mask, unsigned int order,
>  	barrier();
>  	WRITE_ONCE(current->capture_control, &capc);
>  
> -	*compact_result = try_to_compact_pages(gfp_mask, order, alloc_flags, ac,
> -							       prio, &capc);
> +	*compact_result = try_to_compact_pages(gfp_mask, compact_order,
> +					       alloc_flags, ac, prio, &capc);
>  
>  	/*
>  	 * Make sure we hide capture control first before we read the captured
> @@ -4215,7 +4231,7 @@ __alloc_pages_direct_compact(gfp_t gfp_mask, unsigned int order,
>  		struct zone *zone = page_zone(page);
>  
>  		zone->compact_blockskip_flush = false;
> -		compaction_defer_reset(zone, order, true);
> +		compaction_defer_reset(zone, compact_order, true);
>  		count_vm_event(COMPACTSUCCESS);
>  		return page;
>  	}
> @@ -4455,9 +4471,14 @@ __alloc_pages_direct_reclaim(gfp_t gfp_mask, unsigned int order,
>  	struct page *page = NULL;
>  	unsigned long pflags;
>  	bool drained = false;
> +	int reclaim_order = order;
> +
> +	/* Match the slowpath compaction promotion in __alloc_pages_direct_compact */
> +	if ((alloc_flags & ALLOC_NOFRAGMENT) && ac->migratetype != MIGRATE_MOVABLE)
> +		reclaim_order = max(order, pageblock_order);
>  
>  	psi_memstall_enter(&pflags);
> -	*did_some_progress = __perform_reclaim(gfp_mask, order, ac);
> +	*did_some_progress = __perform_reclaim(gfp_mask, reclaim_order, ac);
>  	if (unlikely(!(*did_some_progress)))
>  		goto out;
>  

