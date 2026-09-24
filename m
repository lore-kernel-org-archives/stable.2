Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FE947CA85;
	Thu, 24 Sep 2026 11:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790251172; cv=none; b=QsDWxDH9ePZokzg6AYcPuIG7W3PA3Y+6rfrWHWthxI2fZlEWSVfXWMy+gqvUKmCaGCvRNUWNOmRgxG2bdiUMtPUwfCscDNxIigK+fsuKW5c3bWlelFKvkDbfmzFFJVoG1oRUfnYnhtNKsZ+qAkcVEZqq7qjtjb+bq3/kBFMUguo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790251172; c=relaxed/simple;
	bh=pSVKHinBHCh6H5dX/pme0nQpAgeyXt9bAOQJp/fUXXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C3l4pXQ4OxvXyA3zdnpbPjPMBhNW1t4At3TWVqOG5Xzsg2T0dXNkV2XNDk/MXF+lWDB78kY7GCxsxcVBfhW5vHEQNzYkat9H5fGZjKczZnEOyBSGXXXbCXwMRRBUjBWHZp6+cr3r9Ad8ZGjdmF7BgAX9Y7J6Ek8tv8VkDW/bMOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b553tbGm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b553tbGm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E131F00893;
	Thu, 24 Sep 2026 11:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790251169;
	bh=eYbZw+ir6uobcOE1VSF37VlhISIRM2YlLsW83AoBJJo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=b553tbGmDz2Jw9XkJ0OT+1EdcJLLd1xe2ZQrvmCnRAvkOHHqa1VPRKhSphRq9kKgT
	 sh3Bmb0sRbHxO+iKdVUxoxhV5lkVt7Vg31zid1sKVYWKsNrD1B6G8/jcPJtQ3jA7rb
	 jVVJF/xQTvoePM0y8Zm1lu5Ja+UFQYpSD9b4LfB0VwUwkrSbAU8vvVMacZKthNTQ1v
	 VWIU1SdvduxYqXTwnA5G4k+dze/zEz6Tcc6mUIk5DZrQLZ111ViHyIDG/DaPYQGOFc
	 CiNf8Ho3CO8Vj2IA0ceBvvbr1WXx5hOlAE6xesG8PGgpjD0NdcpkHu/YN0d0hdT+3k
	 zo2sIkJZsfltg==
Message-ID: <f0cd5c54-deca-42e7-bc85-1838dfa917f3@kernel.org>
Date: Thu, 24 Sep 2026 13:59:15 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] mm: allow shared folios to be promoted to a fast
 tier
To: Gregory Price <gourry@gourry.net>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
 akpm@linux-foundation.org, ljs@kernel.org, liam@infradead.org,
 vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 kprateek.nayak@amd.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 nico.pache@linux.dev, ryan.roberts@arm.com, dev.jain@arm.com,
 baohua@kernel.org, lance.yang@linux.dev, usama.arif@linux.dev,
 kas@kernel.org, matthew.brost@intel.com, joshua.hahnjy@gmail.com,
 rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com,
 apopple@nvidia.com, jannh@google.com, pfalcato@suse.de, hannes@cmpxchg.org,
 shy828301@gmail.com, raghavendra.kt@amd.com, stable@vger.kernel.org
References: <20260922182928.2199090-1-gourry@gourry.net>
 <20260922182928.2199090-3-gourry@gourry.net>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260922182928.2199090-3-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/22/26 20:29, Gregory Price wrote:
> From: "Gregory Price (Meta)" <gourry@gourry.net>
> 
> NUMA balancing rejects shared copy-on-write folios and executable
> file folios mapped by multiple processes to avoid east-west
> migration bouncing. These checks break promotion from slow memory.

Makes sense. So in general we're happy to promote if there is no chance of
bouncing (as would happen with ordinary numa migration).

> 
> Allow such folios to participate when the folio being migrated is
> a low-tier folio and the destination is top-tier (south->north).
> This allows promotion, but prevents east-west or north->south
> migrations (north->south is handled by reclaim demotion).
> 
> Keep the existing restrictions for ordinary placement and for
> migrations that are not slow-to-top-tier promotions.
> 
> Rename folio_use_access_time() to folio_in_lowtier() so the source-tier
> condition is more obvious (timing is the mechanism, not the condition).
> The helper retains its existing behavior.
> 
> Fixes: c574bbe91703 ("NUMA balancing: optimize page placement for memory tiering system")
> Cc: stable@vger.kernel.org
> Suggested-by: Zi Yan <ziy@nvidia.com>
> Link: https://lore.kernel.org/r/DLHS4KFPQ86I.1J4LN3352RI71@nvidia.com
> Assisted-by: LLM
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
> ---

[...]

> --- a/mm/memory-tiers.c
> +++ b/mm/memory-tiers.c
> @@ -53,16 +53,19 @@ static const struct bus_type memory_tier_subsys = {
>  
>  #ifdef CONFIG_NUMA_BALANCING
>  /**
> - * folio_use_access_time - check if a folio reuses cpupid for page access time
> + * folio_in_lowtier - check if a folio is in a tiering-managed lower tier
>   * @folio: folio to check
>   *
>   * folio's _last_cpupid field is repurposed by memory tiering. In memory
>   * tiering mode, cpupid of slow memory folio (not toptier memory) is used to
>   * record page access time.
>   *
> - * Return: the folio _last_cpupid is used to record page access time
> + * If memory tiering is disabled, then lowtier has no appreciable meaning,
> + * so we return false (the folio should not be migrated on this distinction).
> + *
> + * Return: true if memory tiering can promote the folio.

I wonder if a better name would just make the comment above (about memory
tiering) implicit and make more sense of the sysctl_numa_balancing_mode &
NUMA_BALANCING_MEMORY_TIERING) check.

	folio_promotable()

	folio_is_promotable()

	folio_numa_promotable()

etc.

because that seems to be what we really test with both things combined.

> +++ b/mm/mempolicy.c
> @@ -864,8 +864,13 @@ bool folio_can_map_prot_numa(struct folio *folio, struct vm_area_struct *vma,
>  	if (!folio || folio_is_zone_device(folio) || folio_test_ksm(folio))
>  		return false;
>  
> -	/* Also skip shared copy-on-write folios */
> -	if (vma_is_cow_mapping(vma) && folio_maybe_mapped_shared(folio))
> +	/*
> +	 * Shared copy-on-write folios are poor east-west placement candidates.
> +	 * When tiering is enabled, folio_in_lowtier() identifies a promotable
> +	 * folio on a low tier, which needs a hint fault for promotion.
> +	 */
> +	if (vma_is_cow_mapping(vma) && folio_maybe_mapped_shared(folio) &&
> +	    !folio_in_lowtier(folio))
>  		return false;
>  
>  	/* Folios are pinned and can't be migrated */
> @@ -891,7 +896,8 @@ bool folio_can_map_prot_numa(struct folio *folio, struct vm_area_struct *vma,
>  	 */
>  	if (vma_is_single_threaded_private(vma) && nid == numa_node_id())
>  		return false;
> -	if (folio_use_access_time(folio))
> +
> +	if (folio_in_lowtier(folio))
>  		folio_xchg_access_time(folio, jiffies_to_msecs(jiffies));
>  
>  	return true;
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 7bdcdb57652f8..6a08690cfe219 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2694,14 +2694,20 @@ int migrate_misplaced_folio_prepare(struct folio *folio,
>  
>  	if (folio_is_file_lru(folio)) {
>  		/*
> -		 * Do not migrate file folios that are mapped in multiple
> -		 * processes with execute permissions as they are probably
> -		 * shared libraries.
> +		 * Limit east-east migration of file folios mapped in
> +		 * multiple processes with execute permissions as they
> +		 * are probably shared libraries (limits bouncing).
> +		 *
> +		 * If this is a low-tier folio, only migrate if the target
> +		 * node is toptier (this allows south->north migration while
> +		 * disallowing east-west migration between slow tiers).
>  		 *
>  		 * See folio_maybe_mapped_shared() on possible imprecision
>  		 * when we cannot easily detect if a folio is shared.
>  		 */
> -		if ((vma->vm_flags & VM_EXEC) && folio_maybe_mapped_shared(folio))
> +		if ((vma->vm_flags & VM_EXEC) &&
> +		    folio_maybe_mapped_shared(folio) &&
> +		    (!folio_in_lowtier(folio) || !node_is_toptier(node)))
>  			return -EACCES;
>  
>  		/*

Sashiko has some comment about anonymous shared COW folios. I think it has a
point, but didn't look too closely.

-- 
Cheers,

David
