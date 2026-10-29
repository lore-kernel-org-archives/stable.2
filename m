Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793296052;
	b=RrayNFAnlJol1WqOlIUxor53TM6fW6MNfFGVpS/Bcn+ixIykpnHRFAp1O2kvlp1Th9DZ
	 +ulYN5rzldKCXJ3k7kN63f0HLFCi9Y5bLGyAxnX2vFiIaA9jqgeOaEsC3aUcpTFYAbE/2
	 GqLEMo9dgSKnj/FMV9Wm9yjHfklFDg5eMXSxFt4FDUtbeV9Gtr5We/B/Z+i0488A1Put3
	 ZOtSjn/2rSRp5cIdhTqgedxzzX2jEAjNeV4JlJ27lzgPZbTF62snq39gCo20zej1jAOTC
	 699skxMfpeyII2k+MLIOejKxETR8erxFte4OK5FzvUXNWdWyIe7izvnZ6qh1CzkIIwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793296052;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=Lu9NmCps7cwWhw9kB4kp6caSi9tSD3jrL00zfdQIbj4=;
	b=DVeaefF6XVDrHjOf0nl3r0GYaaVTFlJjKxtRziYDYxWo6fWt9MCS06X8HJePJqBmffSF
	 +CMQptOmYsmAU7bViOwzWoQlffXryaHz7bQZcV18qHjI06zee7bx8g1G5r7nlgk/uPSKj
	 tQT+ao7XRT3QvFYXQ0n6bGkyJNV9KNgAr/Grb0nnu6pVFfKJlKj7Du9XlwtqjRH6tGoZ9
	 p4IDw9WszbAtVpWKojhPloKa+UFCM2U9sR30iYra4gTL9ujVl8VKI1i7txrTpObYcOrFc
	 66eRkaIRo0QNkDV9db5qdMp8Nk4H3Ym4A+iZoyHxyf8yuZLTocnAhglL5DT97dN5JpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=opV9ITIu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB30606A31C;
	Thu, 29 Oct 2026 17:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=opV9ITIu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 580461F031E2;
	Thu, 29 Oct 2026 17:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793296051;
	bh=Lu9NmCps7cwWhw9kB4kp6caSi9tSD3jrL00zfdQIbj4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=opV9ITIuvYyN325Vo64Ehi4GBE5Kl15I5XlLgwfsb/0L0RXrVFvX7yax9DaCEFBLI
	 tCCZeb5nYdYcbsSzz9BBeAsTi8a7mSSLdGIkLYZiIb3PxC/7BG2wMVPQzsbx3D+6X0
	 TkJX6LVYQhPAle9xIRIBYAa8mY9CjwjuKyiGafn1gJicnr6JSeNdmJWpsN4G3IIl73
	 Gnm83uHOkjSwpNDtqdgHbsVZ7NNCdlk4mTrO+aitlRqzFId//iFxYcEEFl21sDQfSP
	 FYIEFnjenNPCVib+NByyKxd2pIsiczeQ3HHgy+icNG3hcxGQ3Z5+KMBqbR5LaYCclf
	 f+MOnYd8wuLtQ==
Message-ID: <cd89f6bb-f054-401a-8656-1a8c38bff6ed@kernel.org>
Date: Thu, 29 Oct 2026 18:47:25 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/8] mm/page_alloc: retry allocations that raced with a
 zonelist rebuild
Content-Language: en-US
To: "Gregory Price (Meta)" <gourry@gourry.net>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
 muchun.song@linux.dev, osalvador@suse.de, david@kernel.org,
 akpm@linux-foundation.org, ziy@nvidia.com, joshua.hahnjy@gmail.com,
 rakie.kim@sk.com, ying.huang@linux.alibaba.com, ljs@kernel.org,
 liam@infradead.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 brendan.jackman@linux.dev, hannes@cmpxchg.org, mgorman@techsingularity.net,
 anshuman.khandual@arm.com, stable@vger.kernel.org
References: <20261028211930.3504634-1-gourry@gourry.net>
 <20261028211930.3504634-6-gourry@gourry.net>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <20261028211930.3504634-6-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/28/26 22:19, Gregory Price (Meta) wrote:
> Onlining the first block of a zone rebuilds every zonelist in place,
> shifting the slots after the new zone.  The iterator approves a slot,
> then the allocator loads the zone from it, so a GFP_KERNEL request can
> land in ZONE_MOVABLE and a nodemask request on a node outside its mask:
> 
>   CPU 0                             CPU 1
>   prepare_alloc_pages()
>     first_zones_zonelist(nodemask {1})
>       slot 0 (NORMAL1) approved
>                                     online_pages()
>                                       build_all_zonelists()
>                                         [NORMAL1, NORMAL2, ...]
>                                         -> [MOVABLE1, NORMAL1, ...]
>   get_page_from_freelist()
>     zone = zonelist_zone(slot 0)    /* MOVABLE1 */
>     allocates from MOVABLE1
> 
> zonelist_update_seq detects the rebuild, but only the slowpath's failure
> exits check it.
> 
> Check it whenever an allocation succeeds too, and if it changed, free
> the page and retry, as the memcg charge failure path does.  Eligible
> pages are dropped as well: zonelists only change when memory comes or
> goes, and a retry is simpler than rechecking the page.
> 
> Freeing the page does not undo a block the allocation claimed.  A
> GFP_KERNEL request that lands in a fresh ZONE_MOVABLE converts a free
> block to MIGRATE_UNMOVABLE, which stays until the zone's movable free
> list runs out and a movable allocation takes it back.

Yeah that's fine.

> The fast and bulk paths read the seqlock's raw seqcount without waiting:
> an ALLOC_NOLOCK caller can be an NMI that interrupted the writer, and on
> PREEMPT_RT the seqlock accessor takes the spinlock.  A sample taken
> mid-write costs a retry, or NULL under ALLOC_NOLOCK.
> check_retry_zonelist() returns 0 when compiled out, so a backport
> without the hot-add change stays harmless.

Hmm wasn't even aware there's waiting possible otherwise for seqcounts.

> Fixes: 11cd8638c37f ("mm, page_alloc: remove stop_machine from build_all_zonelists")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

> ---
>  mm/page_alloc.c | 34 +++++++++++++++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 24106c881ec2..33aab9deaaa1 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4419,12 +4419,25 @@ static unsigned int zonelist_iter_begin(void)
>  	return 0;
>  }
>  
> +/*
> + * Never wait for the writer, which an ALLOC_NOLOCK caller in NMI may have
> + * interrupted. Read the raw seqcount: on PREEMPT_RT the seqlock accessor takes
> + * the spinlock while a write is in progress.
> + */
> +static unsigned int zonelist_iter_sample(void)
> +{
> +	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
> +		return raw_seqcount_begin(&zonelist_update_seq.seqcount.seqcount);
> +
> +	return 0;
> +}
> +
>  static unsigned int check_retry_zonelist(unsigned int seq)
>  {
>  	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
>  		return read_seqretry(&zonelist_update_seq, seq);
>  
> -	return seq;
> +	return 0;
>  }
>  
>  /* Perform direct synchronous page reclaim */
> @@ -5115,6 +5128,12 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>  	warn_alloc(gfp_mask, ac->nodemask,
>  			"page allocation failure: order:%u", order);
>  got_pg:
> +	/* A rebuild during the walk may have handed out an ineligible zone. */
> +	if (page && check_retry_zonelist(zonelist_iter_cookie)) {
> +		__free_frozen_pages(page, order, FPI_NONE);
> +		page = NULL;
> +		goto restart;
> +	}
>  	return page;
>  }
>  
> @@ -5199,6 +5218,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
>  	struct list_head *pcp_list;
>  	struct alloc_context ac;
>  	unsigned int alloc_flags = ALLOC_WMARK_LOW;
> +	unsigned int zonelist_iter_cookie;
>  	int nr_populated = 0, nr_account = 0;
>  
>  	/*
> @@ -5239,6 +5259,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
>  	/* May set ALLOC_NOFRAGMENT, fragmentation will return 1 page. */
>  	gfp &= gfp_allowed_mask;
>  	gfp = current_gfp_context(gfp);
> +	zonelist_iter_cookie = zonelist_iter_sample();
>  	if (!prepare_alloc_pages(gfp, 0, preferred_nid, nodemask, &ac, &gfp, &alloc_flags))
>  		goto out;
>  
> @@ -5288,6 +5309,10 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
>  	if (unlikely(!zone))
>  		goto failed;
>  
> +	/* The zone was chosen from a zonelist that a rebuild may have changed. */
> +	if (unlikely(check_retry_zonelist(zonelist_iter_cookie)))
> +		goto failed;
> +
>  	/* spin_trylock may fail due to a parallel drain or IRQ reentrancy. */
>  	pcp = pcp_spin_trylock(zone->per_cpu_pageset);
>  	if (!pcp)
> @@ -5428,6 +5453,7 @@ struct page *__alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order,
>  		.alloc_flags = alloc_flags,
>  	};
>  	unsigned int fastpath_alloc_flags = alloc_flags;
> +	unsigned int zonelist_iter_cookie;
>  
>  	/* Other flags could be supported later if needed. */
>  	if (WARN_ON(alloc_flags & ~(ALLOC_NOLOCK | ALLOC_NO_CODETAG)))
> @@ -5457,6 +5483,7 @@ struct page *__alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order,
>  	 */
>  	gfp = current_gfp_context(gfp);
>  	alloc_gfp = gfp;
> +	zonelist_iter_cookie = zonelist_iter_sample();
>  	if (!prepare_alloc_pages(gfp, order, preferred_nid, nodemask, &ac,
>  			&alloc_gfp, &fastpath_alloc_flags))
>  		return NULL;
> @@ -5473,6 +5500,11 @@ struct page *__alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order,
>  
>  	/* First allocation attempt (or, for nolock, only attempt) */
>  	page = get_page_from_freelist(alloc_gfp, order, fastpath_alloc_flags, &ac);
> +	if (likely(page) && unlikely(check_retry_zonelist(zonelist_iter_cookie))) {
> +		__free_frozen_pages(page, order,
> +				    alloc_flags & ALLOC_NOLOCK ? FPI_NOLOCK : 0);
> +		page = NULL;
> +	}
>  	if (likely(page) || (alloc_flags & ALLOC_NOLOCK))
>  		goto out;
>  

