Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792509767;
	b=LTwxbsHRoYECgmK5RqR4038By/r/CKDVWtRpuRGQ0pKva+DEoX8HSRZ2ZY3T0BKv8gXk
	 qeB46Q7aDXaQzUnSbBrDKA98tha4Jew93RVl7livvjTT6s7A5QtjWqKYYJkJvPugorKPq
	 W3qKzCmXJYDfd3yWnfgfY/gQeMKP4kIcycUEcoh8l/2r6PLMJUK7H11ZrV/Mxc6wOPIBk
	 bGfNUL2K2itDYAAfMub646XaqSiSOu3uXBSYqDxTL8CTizid50yAO+gAL6FO3uvocg3BU
	 XJdmPk1hmpOAu4g8gWJ531TRtEzEO8zwFpatqXYZdWZjltTyLYe6HMGEXImtoH/H3PQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792509767;
	h=Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=NxIFDVsD5axqabICLrNLsV0/HgE+/FfIy2AFMMdvPg4=;
	b=aCbtVqx2Qy+WcmZ5QuZiPy31aRiSwyg8DuJLtHBeqSsy4c/T/d3MVSKmxic7pNeEwhH1
	 7wj2yPruI3RDozgzuJy+A4zytcJpMiq5VSP41nlAJPrV9Th5xcFwAKENKJCoXSb6YAAji
	 4B6FljOJxlf5wSiK70c1Oyv9kV2IRLszVVC4QHTJgWHLWQiQdgOl2CywDpa1m769tVXox
	 XXwUuDsnusWVeY7Ma7X45oemQc5yDWNVw2IMAnjPV7F898rwO6eLZXFwVT2QCTixUPyii
	 wxe4JDRhtM2Jwb3kLqYjgJU67NT601Z26DJUyd/2+7a6vqO8u3h8i0QA9ao8zo0zVsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257A6606A31E;
	Tue, 20 Oct 2026 15:22:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68ABB1F000C4;
	Tue, 20 Oct 2026 15:22:43 +0000 (UTC)
Message-ID: <45ef34c7-eea5-4813-b54f-3e34675697b5@kernel.org>
Date: Tue, 20 Oct 2026 17:22:11 +0200
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
Subject: Re: [PATCH v2 2/5] mm/page_alloc: validate zonelist slots against
 concurrent rebuilds
Content-Language: en-US
To: "Gregory Price (Meta)" <gourry@gourry.net>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
 akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org,
 liam@infradead.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 brendan.jackman@linux.dev, hannes@cmpxchg.org, ziy@nvidia.com,
 mgorman@techsingularity.net, jiang.liu@huawei.com, Bessel.Wang@huawei.com,
 stable@vger.kernel.org
References: <20261019172346.3344005-1-gourry@gourry.net>
 <20261019172346.3344005-3-gourry@gourry.net>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <20261019172346.3344005-3-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/19/26 19:23, Gregory Price (Meta) wrote:
> Onlining the first block of a zone rebuilds every zonelist in place,
> shifting the slots after the new zone. An in-flight walk can use a
> zone it previously filtered. e.g.:
>   - a GFP_KERNEL request can land in ZONE_MOVABLE,
>   - a node not in the nodemask can have its zones selected.
> 
> With kprobes holding the walk across the online, I was able to get this
> zone/node misplacement to happen consistently across hotplug events.
> 
> The iterator approves a slot by its zone index and node, and the
> allocator then loads the zone pointer from the slot again:
> 
>   CPU 0                             CPU 1
>   first_zones_zonelist(nodemask {1})
>     slot 0 (NORMAL1) approved
>                                     online_pages()
>                                       build_all_zonelists()
>                                         [NORMAL1, NORMAL2, ...]
>                                         -> [MOVABLE1, NORMAL1, ...]
>   get_page_from_freelist()
>     zone = zonelist_zone(slot 0)    /* MOVABLE1 */

Since the zonelist_zone_valid() checks you're adding happen before the
"zone = zonelist_zone(slot 0)" part, I don't understand how they can be
helping here. Aren't we just reapproving slot 0 when CPU 1 can mess it up
between that reapproval and load? Am I missing something?

Furthermore, since we have the zonelist_update_seq anyway, wouldn't it be
better to use it to avoid these kinds of races rather than the more tricky
way of relying on what exact updates in what order can derail the allocator
side and trying to protect against those specifically?

> Every later step of the walk filters and loads the same way, so a slot
> approved for one node can also hold another node's zone by that time.
> 
> Recheck the loaded zone against highest_zoneidx and the nodemask in both
> allocator loops, and skip it on a mismatch. Hot-add only inserts zones,
> so the zone that was in a skipped slot is still ahead in the walk, and a
> walk that runs off the end meanwhile is retried by the zonelist seq-check.
> 
> The recheck adds about a dozen instructions per zone visited. The two
> fields it reads share a cacheline with zone->per_cpu_pageset, which the
> pcp allocation path loads anyway.
> 
> Fixes: c33d6c06f60f7 ("mm, page_alloc: avoid looking up the first zone in a zonelist twice")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
> ---
>  mm/page_alloc.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index c7125f6693574..aa3cd44fdaa5b 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3784,6 +3784,19 @@ static inline unsigned int alloc_flags_cma(gfp_t gfp_mask)
>  	return ALLOC_DEFAULT;
>  }
>  
> +/*
> + * The zonelist can be rebuilt in place while it is walked, so the iterator's
> + * filters may have passed a slot that now holds a different zone. Recheck the
> + * zone itself.
> + */
> +static inline bool zonelist_zone_valid(struct zone *zone,
> +				       const struct alloc_context *ac)
> +{
> +	if (zone_idx(zone) > ac->highest_zoneidx)
> +		return false;
> +	return !ac->nodemask || node_isset(zone_to_nid(zone), *ac->nodemask);
> +}
> +
>  /*
>   * get_page_from_freelist goes through the zonelist trying to allocate
>   * a page.
> @@ -3812,6 +3825,9 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
>  		struct page *page;
>  		unsigned long mark;
>  
> +		if (unlikely(!zonelist_zone_valid(zone, ac)))
> +			continue;
> +
>  		if (cpusets_enabled() &&
>  			(alloc_flags & ALLOC_CPUSET) &&
>  			!__cpuset_zone_allowed(zone, gfp_mask))
> @@ -5236,6 +5252,9 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
>  	for_next_zone_zonelist_nodemask(zone, z, ac.highest_zoneidx, ac.nodemask) {
>  		unsigned long mark;
>  
> +		if (unlikely(!zonelist_zone_valid(zone, &ac)))
> +			continue;
> +
>  		if (cpusets_enabled() && (alloc_flags & ALLOC_CPUSET) &&
>  		    !__cpuset_zone_allowed(zone, gfp)) {
>  			continue;

