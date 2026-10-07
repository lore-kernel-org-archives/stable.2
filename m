Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F6B376BF2;
	Wed,  7 Oct 2026 22:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791412529; cv=none; b=HAF41kG/u8w1HLdEzFTaTv3jbHyADfzPG86fMlnNR9goS60zI2iPmOjANnQNJKJ3ka+hlSnE2Y+GKDQzOfFbjuX2RjWtDJ5OXeRGHYlY2CWbnFksE5X9pCfYy3h/2pD+6B5ShWwqyFYZMzdcB0LjvvgT0jqCt6uTB/lx1VwjHPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791412529; c=relaxed/simple;
	bh=c47Pbxh9dK+1wv90SojXKKsIfBfWUBz3KPuY5rzCmLM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=WFIagtGaBfDSCcvSGQ7rE8fjpYupDLegztSy8rFyHyWuuXid1+bFWRHSvTUQ4jYTtvc/MnoWznC4Ua+ezIQeAmAvqc0dk9zrD9ieJUgIKzaGlkUp1ZVImx2sVEx5tjBCZqryHcLrQZTBb9N/ocwTRX0/DjfOxKK4cswdbqKl9Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OHbq7WvW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OHbq7WvW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D83261F000FF;
	Wed,  7 Oct 2026 22:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1791412527;
	bh=B+VMO+YMjXevl0hOsc4oTcVQo83xucHvyssxvgfaocc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OHbq7WvW7VgYYAX/mYOnO5AJwUDhQ5vPApvLzHa8f0U6z24RKHye8eJK+TQGwMIxQ
	 BpIU2ThZjznvdTr9jkgJhNfuc2Cvv0rZ+AV7i6eE3DJSCtrCajiABjniiNAjbIX6s4
	 KpKpY9bfm5813BUGteKy34MbO5nbuSeeUJeeG0mw=
Date: Wed, 7 Oct 2026 15:35:26 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Hongfu Li <hongfu.li@linux.dev>
Cc: hughd@google.com, baolin.wang@linux.alibaba.com,
 vivek.kasireddy@intel.com, muchun.song@linux.dev, osalvador@suse.de,
 david@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Hongfu
 Li <lihongfu@kylinos.cn>, stable@vger.kernel.org
Subject: Re: [PATCH v3] mm/memfd: fix hugetlb reservation accounting in
 error paths
Message-Id: <20261007153526.cb4473601fc9038a9ca4f517@linux-foundation.org>
In-Reply-To: <20260927094757.31665-1-hongfu.li@linux.dev>
References: <20260927094757.31665-1-hongfu.li@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 27 Sep 2026 17:47:57 +0800 Hongfu Li <hongfu.li@linux.dev> wrote:

> From: Hongfu Li <lihongfu@kylinos.cn>
> 
> If hugetlb_add_to_page_cache() in memfd_alloc_folio() fails with -EEXIST,
> a concurrent fault has already instantiated the folio in the page cache,
> and the reservation now belongs to that folio. Calling
> hugetlb_unreserve_pages() in that case incorrectly removes the region
> backing the cached folio and releases one reservation more than it
> should, leaving that folio in the page cache with no region recording it.
> 
> That leaves resv_huge_pages one page short until that folio is removed
> from the page cache, so available_huge_pages() reports a page that is
> not actually free and the pool can grant one reservation more than it
> can back. Applications using hugetlb memfds can then fail to allocate
> or fault in a page they already reserved. They see -ENOMEM or -ENOSPC
> from the allocation or fault path even though the reservation and
> HugePages_Free still look healthy.
> 
> So hold the hugetlb fault mutex from hugetlb_reserve_pages() until the
> error-path unreserve completes to make the reserve, allocate and
> instantiate steps atomic against concurrent faults. With the mutex held
> from the start, a concurrent fault can no longer consume the reservation
> between reserve and allocate/instantiate. If a fault completed before the
> mutex was taken, it has already added the region for that index, so
> hugetlb_reserve_pages() returns 0 and the error path leaves the region in
> place.
> 
> Fixes: 717cf9357325 ("mm/memfd: reserve hugetlb folios before allocation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongfu Li <lihongfu@kylinos.cn>

Can we please have review of this cc:stable regression fix?

> v3:
> - Update commit message to describe the accounting damage and its
>   user-visible effect; no code changes.
> - Add Cc: stable@vger.kernel.org.
> v2:
> - Take the hugetlb fault mutex before hugetlb_reserve_pages() and hold
>   it until the error-path unreserve completes.
> - Update commit message
> - Link to v1: https://lore.kernel.org/all/20260831090631.29227-1-hongfu.li@linux.dev/
> ---
>  mm/memfd.c | 31 ++++++++++++++++---------------
>  1 file changed, 16 insertions(+), 15 deletions(-)
> 
> diff --git a/mm/memfd.c b/mm/memfd.c
> index c708d92533f4..0f6fff004f5e 100644
> --- a/mm/memfd.c
> +++ b/mm/memfd.c
> @@ -82,22 +82,31 @@ struct folio *memfd_alloc_folio(struct file *memfd, pgoff_t idx)
>  		struct hstate *h = hstate_file(memfd);
>  		int err = -ENOMEM;
>  		long nr_resv;
> +		u32 hash;
>  
>  		gfp_mask = htlb_alloc_mask(h);
>  		gfp_mask &= ~(__GFP_HIGHMEM | __GFP_MOVABLE);
>  		idx >>= huge_page_order(h);
>  
> +		/*
> +		 * Serialize hugepage allocation and instantiation to prevent
> +		 * races with concurrent allocations, as required by all other
> +		 * callers of hugetlb_add_to_page_cache().
> +		 */
> +		hash = hugetlb_fault_mutex_hash(memfd->f_mapping, idx);
> +		mutex_lock(&hugetlb_fault_mutex_table[hash]);
> +
>  		nr_resv = hugetlb_reserve_pages(inode, idx, idx + 1, NULL, EMPTY_VMA_FLAGS);
> -		if (nr_resv < 0)
> -			return ERR_PTR(nr_resv);
> +		if (nr_resv < 0) {
> +			err = nr_resv;
> +			goto out_unlock;
> +		}
>  
>  		folio = alloc_hugetlb_folio_reserve(h,
>  						    numa_node_id(),
>  						    NULL,
>  						    gfp_mask);
>  		if (folio) {
> -			u32 hash;
> -
>  			/*
>  			 * Zero the folio to prevent information leaks to userspace.
>  			 * Use folio_zero_user() which is optimized for huge/gigantic
> @@ -112,20 +121,9 @@ struct folio *memfd_alloc_folio(struct file *memfd, pgoff_t idx)
>  			 */
>  			__folio_mark_uptodate(folio);
>  
> -			/*
> -			 * Serialize hugepage allocation and instantiation to prevent
> -			 * races with concurrent allocations, as required by all other
> -			 * callers of hugetlb_add_to_page_cache().
> -			 */
> -			hash = hugetlb_fault_mutex_hash(memfd->f_mapping, idx);
> -			mutex_lock(&hugetlb_fault_mutex_table[hash]);
> -
>  			err = hugetlb_add_to_page_cache(folio,
>  							memfd->f_mapping,
>  							idx);
> -
> -			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
> -
>  			if (err) {
>  				folio_put(folio);
>  				goto err_unresv;
> @@ -133,11 +131,14 @@ struct folio *memfd_alloc_folio(struct file *memfd, pgoff_t idx)
>  
>  			hugetlb_set_folio_subpool(folio, subpool_inode(inode));
>  			folio_unlock(folio);
> +			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
>  			return folio;
>  		}
>  err_unresv:
>  		if (nr_resv > 0)
>  			hugetlb_unreserve_pages(inode, idx, idx + 1, 0);
> +out_unlock:
> +		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
>  		return ERR_PTR(err);
>  	}
>  #endif
> -- 
> 2.54.0
> 
