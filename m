Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793297426;
	b=5slQhSaEHzrED5QWduhjB3bVtnzAlVzLm/B4CUoOiTab5NWLJKC2KtjY/4rE65BOKXBk
	 dsaww3Fxc0N1TKjP2/lMdolfmp/A1Ehu5T9TuGglc46meBi54TMb00tNPWu9occXAjj5c
	 dYH/1b0QfeO2ZkgbNMbVOYFzUtHTKYWKZjrjKngegdphCm3JqvzfYyT50i7RNSG6YquKi
	 lINLI6bMS7A4KjOqNaX0dQ+MRv8ChC+Y5GaNdgzkJmf2xLy1iNcjZChg9nYXvWhKZEcNg
	 CNLMI5n/W2g3s2Ts8labKDRuvlCKeIoPc5aiilTyjW8sIh8iwLdYuwVf51bCX28gKUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793297426;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=YhtoC8abtd12mu+rBuvcv/XkTwddyXJZrrtv2/voX0Y=;
	b=ur6KMa7QZbV2j0KZ/Efj13V4PxUjVupW8FCNeyQaMWa2yNw4A6H9YXEeEOFi7lBkCoko
	 7XQt4lFV20FDTG0ktiF0mdt4PGTQKindHlY/TLucZ71wxKFqKgAdcNqJgWO4Ll/DbAN4v
	 v3assSQVmu9NRw6XVClm+oHS4vnmw1APLzKgckdn6uzNzw6VnNuKvXGU7sJOUepiD9pGl
	 aCZJXNJu6JXu0FbjJESpd/SCXNJuT0SNqNG4dOIMhUIbjkFnq++56x3/EjALWfINVWWHc
	 AMEFQ2XfyQvlLPeKFbThWJQBdnxqIi/XP83cMxB2S4Xs/95xls+MjYZK0GhBq9qRBRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VtievZEi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CEF60A380E;
	Thu, 29 Oct 2026 18:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VtievZEi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 565281F01176;
	Thu, 29 Oct 2026 18:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793297425;
	bh=YhtoC8abtd12mu+rBuvcv/XkTwddyXJZrrtv2/voX0Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=VtievZEidSVJKJ8wgbiTyLqG2cFPhE5Pkzw8ITYYjhGHuopw91uKJ9JtJJdRSMp7F
	 M2UqZkhfBFg1lLeA8FWkN2BhW/bw5tRWjEgKb5mCzZHqQhOKiRyb5dBXGRNKduN/C/
	 HdJX54ceYFkIb/lIpcSEH7JL9BNLd2+wXtYeqxBfrzz35lBQkZFDs2sMw+rNalIzlZ
	 H/Yz0Rg0YFmSD1A+4EfXPNMfRbhHRh9eLrQyrr6++JrV5sREhUgg9l3wqbVMCRXPBU
	 116/V5xj5GH0fxIc/woLjEPZOKHPaBaWmzSg1SSYfwsx5cyHxvemiTdvhRWAnXNXkI
	 z1GGNTHz/rJGg==
Message-ID: <7a1807d0-4f3b-4094-b73b-b6950040e3ab@kernel.org>
Date: Thu, 29 Oct 2026 19:10:19 +0100
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
Subject: Re: [PATCH v4 7/8] mm/page_alloc: retry alloc_contig_pages() when the
 zonelist is rebuilt
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
 <20261028211930.3504634-8-gourry@gourry.net>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <20261028211930.3504634-8-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/28/26 22:19, Gregory Price (Meta) wrote:
> Onlining the first block of a zone rebuilds every zonelist in place,
> shifting the slots after the new zone.
> alloc_contig_frozen_pages_noprof() approves a slot by the caller's gfp
> and nodemask, then loads the zone from it:
> 
>   CPU 0                             CPU 1
>   alloc_contig_frozen_pages_noprof(GFP_HIGHUSER | __GFP_THISNODE)
>     slot 0 (NORMAL1) approved
>                                     online_pages()
>                                       build_all_zonelists()
>                                         [NORMAL1]
>                                         -> [MOVABLE1, NORMAL1]
>     zone = zonelist_zone(slot 0)    /* MOVABLE1 */
>     alloc_contig_frozen_range(MOVABLE1 pfns)
> 
> A gigantic hugetlb page can then land in ZONE_MOVABLE, and a nodemask
> caller can get a range from another node.  Gigantic pages are kept out
> of ZONE_MOVABLE since commit 79b63f12abcb ("mm, hugetlb: do not allocate
> non-migrateable gigantic pages from movable zones").
> 
> Check zonelist_update_seq before using each zone, and restart the walk
> if it changed, as the hugetlb pool walk does.  Check again before
> escalating to the pass that may migrate hugetlb pages, so a pass a
> rebuild cut short is redone rather than escalated.
> 
> With kprobes holding the walk across the online, the base kernel put the
> 1G page in ZONE_MOVABLE in 3 of 3 runs, and this change put it in
> ZONE_NORMAL in 3 of 3.  Direct GFP_KERNEL calls with nodemask {1} and
> {2} got a ZONE_MOVABLE range and a node 1 range on base, 3 of 3 each,
> and neither with this change.
> 
> Fixes: 5e27a2df03b8 ("mm/page_alloc: add alloc_contig_pages()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

> ---
>  mm/page_alloc.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 70830689048a..7d06c6c4011a 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7593,6 +7593,7 @@ struct page *alloc_contig_frozen_pages_noprof(unsigned long nr_pages,
>  		gfp_t gfp_mask, int nid, nodemask_t *nodemask)
>  {
>  	unsigned long ret, pfn, flags;
> +	unsigned int zonelist_cookie;
>  	struct zonelist *zonelist;
>  	struct zone *zone;
>  	struct zoneref *z;
> @@ -7601,8 +7602,13 @@ struct page *alloc_contig_frozen_pages_noprof(unsigned long nr_pages,
>  
>  retry:
>  	zonelist = node_zonelist(nid, gfp_mask);
> +	zonelist_cookie = zonelist_iter_begin();
>  	for_each_zone_zonelist_nodemask(zone, z, zonelist,
>  					gfp_zone(gfp_mask), nodemask) {
> +		/* A rebuild may have shifted an ineligible zone into this slot. */
> +		if (unlikely(check_retry_zonelist(zonelist_cookie)))
> +			goto retry;
> +
>  		spin_lock_irqsave(&zone->lock, flags);
>  
>  		pfn = ALIGN(zone->zone_start_pfn, nr_pages);
> @@ -7637,6 +7643,9 @@ struct page *alloc_contig_frozen_pages_noprof(unsigned long nr_pages,
>  	 * second pass, we will try moving HugeTLB pages when those pages are
>  	 * smaller than the requested contiguous region size.
>  	 */
> +	/* Redo a pass that a rebuild cut short before escalating. */
> +	if (unlikely(check_retry_zonelist(zonelist_cookie)))
> +		goto retry;
>  	if (skip_hugetlb && skipped_hugetlb) {
>  		skip_hugetlb = false;
>  		goto retry;

