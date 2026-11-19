Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795108874;
	b=qnas28YaI+0m8kAYgc78riB/4sfk/mFG5u1gp/6TanvTzpgNM3P9Q6e+wjvrYVWsZDay
	 yx3xQMFhNeDJUG9W1llx0K5m8s/hAeNjZOoX/6QAJgzxlyRLLRZ9EA6+gKOjmiH+YhqAC
	 YE+mStLUiXxJTgLi7OieC5euPHaLoHtyaL7D0dO6+UpOvBr30/ZPuTSDVzvyZLbiNyQzW
	 f/zvAA84KGrQJPQpudDpvzDA0+SrK01N1RiTrdRbAMeZL6cafOQuVYaI3yxskMTLr3sx7
	 S4vKHYsnY9vviVhjeoMZRzPg5YA7DSqCl8HVvgnwCPIKj7uqifzBUNcCSJcn6xDkvyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795108874;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=XdED9eR4y5ifUgKd7CctMUIndCPjoT0qvFTq9/Do+VQ=;
	b=BbMTJ738ek7bBt734QJv5TrQK/u+xtk+sCnLVUHBx3e6lTW6BkPh3sdXyF+xsPifNADi
	 +D3DVQcArFrB70ddaU6HrHba2X7oyOVWtPQij2EQap9Odnaa2jEAAMMUD9WDlpX76SNQ3
	 +Cc65LgV8yNDD0X8BVBvKfcMJ9M7Y2pvog3YAOMyH0hHaXnllW+MX8z34KY9PeW86fscj
	 k2Orzu4oNtwY0JOyWMn94nxW3RFNz9veyKfXLw7uIb6EoF8DrEkUC9aBefKJp73Qb5B06
	 erBcQ2Y40M8iIA8WYt5qYONQVrJGbARx5kJ0EQtlMF5oETXZkFef7Li+PezCeqh5d1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mNz3J1C8;
	arc=none smtp.remote-ip=95.215.58.144
Received: from mta1.migadu.com (out-144.mta1.migadu.com [95.215.58.144])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D74606A324
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 17:21:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12D74606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mNz3J1C8
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=sOswK0QnaKHmU3QatFBxqViiRvCRLsYYOvUns0Kes0k=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795108871; v=1; x=1795713671;
 b=mNz3J1C8srKM79V3RO/Lli7dLeXuiEJ5akyDkZGo0pyS8CYc0pzsRNR5t36BRj8fnj1xZmhn
 rJ10q2nmgXkggzoFwWZUTcxRnzA6mptrgHzXKP5Oj8+5qxEnSHkpUTh1kGpYKig8aPF3JJo5to6
 4L50yE0wNG6Ot4UXZ3x8jBOU=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a14ab644d5b40bce;
	Thu, 19 Nov 2026 17:21:10 +0000
X-Mizu-Trace-ID: a14ab644d5b40bce
X-Migadu-Flow: FLOW_OUT
Message-ID: <299b3f93-f7dd-490a-8a6b-68afe4b0e473@linux.dev>
Date: Thu, 19 Nov 2026 09:21:04 -0800
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
Subject: Re: [PATCH] mm/madvise: fix MADV_FREE handling for PMD-mapped THPs
To: "David Hildenbrand (Arm)" <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Kiryl Shutsemau <kas@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
 Ying Huang <huang.ying.caritas@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Chris Mason <mason@kernel.org>, Sashiko <sashiko-bot@kernel.org>
References: <20261119-madv_free_thp-v1-1-a312919e1ee5@kernel.org>
Content-Language: en-US
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <20261119-madv_free_thp-v1-1-a312919e1ee5@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 19/11/2026 08:04, David Hildenbrand (Arm) wrote:
> After MADV_FREE cleared the dirty flag of an anonymous folio, reclaim will
> later free the folio without writing it back if no mappings are dirty.
> 
> If our folio is still in the swap cache, the swap entries then point at
> swap slots that were never written, exposing stale content of the swap
> device. Bad.
> 
> madvise_free_pte_range() therefore frees the swap slots first, and skips
> the folio if that is impossible. madvise_free_huge_pmd() does not, and a
> PMD-mapped THP can be in the swap cache if try_to_unmap() failed during
> reclaim, for example due to a racing mlock().
> 
> Further, madvise_free_huge_pmd() checks whether the THP is mapped by
> other processes before taking the folio lock. Another process that still
> has swap entries for the THP can concurrently map it from the swap cache,
> and we might end up clearing the dirty flag of a shared folio.
> 
> Fix it by factoring out the folio handling of madvise_free_pte_range()
> into madvise_free_try_prepare_folio(), and using it for PMD-mapped THPs
> as well. Hopefully this prevents further bugs.
> 
> For PMD-mapped THPs, this change implies:
> 
> 1. We free the swap slots of a THP in the swap cache, and skip the THP if
>    that is impossible.
> 2. We check the mapcount under the folio lock.
> 3. We no longer lock and check THPs that are neither dirty nor in the
>    swap cache, just like for PTE-mapped folios.
> 
> For PTE-mapped folios, this means:
> 
> 4. We check the mapcount once before taking the folio lock, to not lock
>    folios that are mapped by other processes.
> 
> Only compile madvise_free_huge_pmd() with CONFIG_ADVISE_SYSCALLS to keep
> !CONFIG_ADVISE_SYSCALLS builds working.
> 
> Chris and Sashiko reported the missing swap cache handling for PMD-mapped
> THPs, the other issue was found by code inspection.
> 
> This has medium urgency.
> 
> Fixes: bd4c82c22c36 ("mm, THP, swap: delay splitting THP after swapped out")
> Cc: stable@vger.kernel.org
> Reported-by: Chris Mason <mason@kernel.org>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/sashiko-outbox-202086@kernel.org/
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
> I would queue this fairly soon on mm-core/for-next-fixes
> ---
>  mm/huge_memory.c | 19 ++++++-----------
>  mm/internal.h    |  1 +
>  mm/madvise.c     | 65 +++++++++++++++++++++++++++++---------------------------
>  3 files changed, 41 insertions(+), 44 deletions(-)
> 

Yeah looking at pmd swap, I imagine there might be more cases
which are correctly handled by pte path but not pmd.

Acked-by: Usama Arif <usama.arif@linux.dev>

> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 79d400ea9553d..e22daf846dbe3 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2421,6 +2421,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_ADVISE_SYSCALLS
>  /*
>   * Return true if we do MADV_FREE successfully on entire pmd page.
>   * Otherwise, return false.
> @@ -2455,21 +2456,13 @@ bool madvise_free_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  	if (folio_is_zone_device(folio))
>  		goto out;
>  
> -	/*
> -	 * If other processes are mapping this folio, we couldn't discard
> -	 * the folio unless they all do MADV_FREE so let's skip the folio.
> -	 */
> -	if (folio_maybe_mapped_shared(folio))
> -		goto out;
> -
> -	if (!folio_trylock(folio))
> -		goto out;
> -
>  	/*
>  	 * If user want to discard part-pages of THP, split it so MADV_FREE
>  	 * will deactivate only them.
>  	 */
>  	if (next - addr != HPAGE_PMD_SIZE) {
> +		if (folio_maybe_mapped_shared(folio) || !folio_trylock(folio))
> +			goto out;
>  		folio_get(folio);
>  		spin_unlock(ptl);
>  		split_folio(folio);
> @@ -2478,9 +2471,8 @@ bool madvise_free_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  		goto out_unlocked;
>  	}
>  
> -	if (folio_test_dirty(folio))
> -		folio_clear_dirty(folio);
> -	folio_unlock(folio);
> +	if (!madvise_free_try_prepare_folio(folio, 1))
> +		goto out;
>  
>  	if (pmd_young(orig_pmd) || pmd_dirty(orig_pmd)) {
>  		pmdp_invalidate(vma, addr, pmd);
> @@ -2498,6 +2490,7 @@ bool madvise_free_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  out_unlocked:
>  	return ret;
>  }
> +#endif /* CONFIG_ADVISE_SYSCALLS */
>  
>  static inline void zap_deposited_table(struct mm_struct *mm, pmd_t *pmd)
>  {
> diff --git a/mm/internal.h b/mm/internal.h
> index 85cf7becf8588..96cb55d7816b1 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -61,6 +61,7 @@ void lru_add_drain_cpu(int cpu);
>  void lru_add_drain_cpu_zone(struct zone *zone);
>  void folio_deactivate(struct folio *folio);
>  void folio_mark_lazyfree(struct folio *folio);
> +bool madvise_free_try_prepare_folio(struct folio *folio, int nr_mappings);
>  
>  /* mm/vmscan.c */
>  unsigned long zone_reclaimable_pages(struct zone *zone);
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 0214efd2a014f..ebb4ce7daf6cb 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -661,6 +661,38 @@ static long madvise_pageout(struct madvise_behavior *madv_behavior)
>  	return 0;
>  }
>  
> +bool madvise_free_try_prepare_folio(struct folio *folio, int nr_mappings)
> +{
> +	if (!folio_test_swapcache(folio) && !folio_test_dirty(folio))
> +		return true;
> +
> +	if (folio_mapcount(folio) != nr_mappings || !folio_trylock(folio))
> +		return false;
> +
> +	/*
> +	 * KSM folios can gain new mappings at any time, so we must
> +	 * not clear their dirty flag.
> +	 */
> +	if (folio_test_ksm(folio))
> +		goto unlock;
> +
> +	/*
> +	 * Check under the folio lock that the folio is exclusive: we own all
> +	 * mappings, and there are no references from swap entries.
> +	 */
> +	if (folio_mapcount(folio) != nr_mappings)
> +		goto unlock;
> +	if (folio_test_swapcache(folio) && !folio_free_swap(folio))
> +		goto unlock;
> +
> +	folio_clear_dirty(folio);
> +	folio_unlock(folio);
> +	return true;
> +unlock:
> +	folio_unlock(folio);
> +	return false;
> +}
> +
>  static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
>  				unsigned long end, struct mm_walk *walk)
>  
> @@ -753,37 +785,8 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
>  			}
>  		}
>  
> -		if (folio_test_swapcache(folio) || folio_test_dirty(folio)) {
> -			if (!folio_trylock(folio))
> -				continue;
> -			/*
> -			 * KSM folios can gain new mappings at any time, so we must
> -			 * not clear their dirty flag.
> -			 */
> -			if (folio_test_ksm(folio)) {
> -				folio_unlock(folio);
> -				continue;
> -			}
> -
> -			/*
> -			 * If we have a large folio at this point, we know it is
> -			 * fully mapped so if its mapcount is the same as its
> -			 * number of pages, it must be exclusive.
> -			 */
> -			if (folio_mapcount(folio) != folio_nr_pages(folio)) {
> -				folio_unlock(folio);
> -				continue;
> -			}
> -
> -			if (folio_test_swapcache(folio) &&
> -			    !folio_free_swap(folio)) {
> -				folio_unlock(folio);
> -				continue;
> -			}
> -
> -			folio_clear_dirty(folio);
> -			folio_unlock(folio);
> -		}
> +		if (!madvise_free_try_prepare_folio(folio, folio_nr_pages(folio)))
> +			continue;
>  
>  		if (pte_young(ptent) || pte_dirty(ptent)) {
>  			clear_young_dirty_ptes(vma, addr, pte, nr, cydp_flags);
> 
> ---
> base-commit: 5e600d79135124a4eb8e9db30ad524224c267c07
> change-id: 20261119-madv_free_thp-3c2a9887a722
> 
> Best regards,
> --  
> David Hildenbrand (Arm) <david@kernel.org>

