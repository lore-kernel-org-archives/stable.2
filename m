Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795106660;
	b=o+uurjUrsDUyec3ffdYR9Zn+xn80aNl6xnQkEGnGq7ojxyJlMwG8f8h/wCjCRXSMOr/w
	 LKwfPK2jhUIF7yIGa0c6eZqIvjPLmlrLFg5AnhbhLAYtf9VTfpc5rMwfYT4RmR+j2V7Iw
	 TVNZbjqJaNmQXOSTZ121QWIgzuhnerLf6nO0J/8y0BJYeCecKuzH/Imuz/IYyiLVMppLv
	 +bkmZdRncNu5NlYVac+j6bPtQYMhwWJHTQtttXGXAW11X5VYcvWnV10He6Y6EW2v0LWWP
	 bbIq/fnBPOx+emqEq0S5fRjqt0Gz3vy9FtP5U2JLlfu5v7aJfsbpEsOMwQvOp7za2+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795106660;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=zDXF/eCRhk1uzVkaxBfPvONixANJAFGM6Jb/fbAScSs=;
	b=s0aUOiseH67M5tKobabh96aujaNjfyTvsAiJEKAiboTG8Zeq7cKxeSoHSg0nIsat7ghg
	 7RVwoxVjOrK7Qcr+u87TzWKhzumnikB/jvQLLnv7en56J7BuoRRgQYEJnHdDCaGNKbDFL
	 wyJ9MiANqxIkyOOvew7b92OgRnNS640HR3V4Bhluy1eW6x6x4M52X0Ex0IF7A2nFuRCbl
	 Ti40RrwTnFBVX6zAdf5fNxeIsxkWkKTUCtU53TEtFvJ0EbwtSOEPEuzwvhbAAjwuAhtCc
	 HilX9hceh8BuDT4rv7ad4UVxiwatCDfUamAtzwz8yEvhGLtUKB3xhhNtErDEfHUEDzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b="Ekd1Y/TJ";
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D4160A2600
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 16:44:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3D4160A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Ekd1Y/TJ
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-49412eb1474so1582808f8f.3
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 08:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795106658; x=1795711458; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zDXF/eCRhk1uzVkaxBfPvONixANJAFGM6Jb/fbAScSs=;
        b=Ekd1Y/TJ83YsAGrG5h39tdrmeq4Dwgfg6wW/jntgzYHvfZGbioGa6D8aIDLgh2PbSu
         7b6WQ9aVXDNktnau7FNFjYaCyE6Gc8tQdBwfYYqKZQz0MkNvdPsA8J73Xs8OjcLJXzQb
         Upda5mPqSP48z/fcA42BuWGsmoZjY3JEm+KtKdtAQQiKepjKz8wsKzx2AFvzltvJvPr7
         jIP8t6mxZ/n1jZd7rf+wdFntjjR7eVCNm7KjTxVLU9VXePdP3z0WFkVGkxVKoGPxlgtd
         ty51M4lgvG7kwAIJm9fNdmDgqEJmRia0rczYPtoA6w0sZ9Ak4et9mQV5vU7f02PkIrER
         1AmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795106658; x=1795711458;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zDXF/eCRhk1uzVkaxBfPvONixANJAFGM6Jb/fbAScSs=;
        b=ZgnBSP0jE2i+nk3BSbe2qYS3c+DRdq2LsW6q00Ww4+0u2+OD6exXmscPbQlzYW3EK3
         esk4dDaE6zx+oLEyZiH95XkcxWiM1UIAqHKMQXO/iTYmhhxjTxqeCG/O5PSz73cm8X7K
         HeO5BGoTANxk2ZJzCg6iCVoEcV8851tkaa5fRxavdsfy+FJdei/FxQVK7+MS0dBYFXHs
         fpQ50VnZLE8Rl+2xoN/plVSF2dPY4v6zyqeHThuW5k5KAlbw1D6rlymFd257EdYBLnDD
         OazELkxhWhcGBij0K4y01rTRmfov9oMghtM5beb8cKQs6/lESr9epjJnWPhK6dXY7t4D
         hNMw==
X-Forwarded-Encrypted: i=1; AL+hErFzOWx5hHMqYT82LqtSQKeccuYjY7FEXuiKatyZ2SoD5D45MJau2Emidf028VBclqm0qbpCmNo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+vYGcysYWZM0FFnHaePb2nxwywds7hD48MsKG88OM0wshIv0Lx
	8fFL1lI6vZXhCw3lvXhSC3eT2PCsWszQV/9NMKqoPIJn5TbyQFP6snNYcCtdCMaTa8A=
X-Gm-Gg: AZFdTZfd1Dn1dSJRZ3KXGtw0/tVgAf2O8C0ouMASk9PT1OO6k4Pm5ZmrFpbqKLCmfy4
	IPGwo8RZcn5HpcOJjLReJbVK5f3y8UjkQZN01yWP74/EzNLj71JStn+4phTlHXtLCP5LtD46z5r
	oNgYsGUd3b3P48MJzgcfIyrGhujZD75vSrDZczktS6RzpD+rlnm6LN3a4SU3iijgAmH4ptjJ10k
	rxcMN6AhTO6WZVfvR6cr7JZAjuRngGn50KMrV9XzQwcQJvNq29TsdRSL8kkKxFfwgwasgTkvkZQ
	rOKv6Wn9wBQpYhNl+Ow7JbFoZ1DKxZBX393aqcganLGu3wLvQGWNhd62J4Dh9YQuhN/rTitsdyh
	MmDJdrSdbNKyL9jSo0pCRohs8WtNRjL/y9cKntV8Wnv0MiOKwlNzj1CH1szJwSupP16SVsXgZ7M
	+RMeyV6XjoAWoY8/nNV6IwC6kHjmM0IW5G2jwc2ElI76aMYv+3h9HLZOZTWaHDfIykGG+u99mDM
	Aggw9a6VwG51AvORRK6Pog6gBu7ZYxTwiciWmWJylbi6FjWlRjz/+fZH8YBvdhpozfFm96I1vpk
	SLuGlmZF5Kc3ZyqakHcJ52XUyxvkFHp1n0ReZw==
X-Received: by 2002:a05:6000:2087:b0:48b:db7:86a7 with SMTP id ffacd0b85a97d-4a63e223fb6mr14422264f8f.50.1795106658000;
        Thu, 19 Nov 2026 08:44:18 -0800 (PST)
Received: from localhost (109-81-24-9.rct.o2.cz. [109.81.24.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6bb98b4dsm632121f8f.53.2026.11.19.08.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 08:44:17 -0800 (PST)
Date: Thu, 19 Nov 2026 17:44:16 +0100
From: Michal Hocko <mhocko@suse.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Jann Horn <jannh@google.com>,
	Ying Huang <huang.ying.caritas@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Chris Mason <mason@kernel.org>, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH] mm/madvise: fix MADV_FREE handling for PMD-mapped THPs
Message-ID: <av8nYAco3bMhUIBI@tiehlicka>
References: <20261119-madv_free_thp-v1-1-a312919e1ee5@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119-madv_free_thp-v1-1-a312919e1ee5@kernel.org>

On Thu 19-11-26 17:04:34, David Hildenbrand wrote:
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

Acked-by: Michal Hocko <mhocko@suse.com>
Thanks!

> ---
> I would queue this fairly soon on mm-core/for-next-fixes
> ---
>  mm/huge_memory.c | 19 ++++++-----------
>  mm/internal.h    |  1 +
>  mm/madvise.c     | 65 +++++++++++++++++++++++++++++---------------------------
>  3 files changed, 41 insertions(+), 44 deletions(-)
> 
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

-- 
Michal Hocko
SUSE Labs
