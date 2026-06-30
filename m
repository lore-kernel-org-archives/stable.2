Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD6A3D1CCF;
	Tue, 30 Jun 2026 07:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782805454; cv=none; b=B84Q7xGac/NhGseKSV3J5D9guzt1B2nvpVHgZvjrJElZUx0RGWHMtgH26YW7LMUTIWKV120dKXglSLqS+atG1IHkL0rjFHUIfm1YmM+n5NoXnhjTWUky4YlkszbRzCb0teW9Oa9SS9bEXazQDJqolCkzASdjjjoMpZ91a8RWU88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782805454; c=relaxed/simple;
	bh=7DbOLKL0rLvcvNDP28oH6c82QlbGx/4fWe6uzgVFgRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D/TrApZv88t67cT84+wVRzht12Q+yY5RZXGkP0uZsytlMUiVGUAyDNeX403rhjILqZOZfy+wPjrzsmjk4QotMMzI0ofq4FrWq+GjpRzoL6cCjEiz3BcubhQP0nygAfPt9BxRRoIrk6+t7vpsOvocevFcVZ/Xad2jSynk6OGY+28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CkRZKX/b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CkRZKX/b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED68B1F00A3A;
	Tue, 30 Jun 2026 07:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782805453;
	bh=E0KgZjmuVYnhggcedT+cDC7Ty8G96rX4EfII0AXlJBc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=CkRZKX/bA42/uEJ5XxOREyoadqjTygMIt74dA2qVxbuawMc1GSM0yzs633B3Tz2Mp
	 beFyyifGnnR5RMB9iDUdGHwTYb7nThu3cByxooWGzkC9q5L0DgNlp4RGKOF0mb2gYw
	 Tk+3eY1YbRGGBk5/z7rDeqxVdHEoll1eEUlccMfvQDJs6EgAJi2iB7gOrgZVXfld0Z
	 sL7A/q9rmCpWOrvANDV7DVruik0tM2zCCbGGtmzNJIhjfP8Tuo91RuvXdzBCEEWFJt
	 mCO/ihVsbG9zr37T8zLuH+OVGAlb/m4Afew6Hs3XrUsKe0UnlwMSF+ITUKsOl1HXNS
	 4C8x5cWcUc55Q==
Message-ID: <4549ad0e-abb1-4156-95c6-5e3c1319dffe@kernel.org>
Date: Tue, 30 Jun 2026 09:44:08 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/page_alloc: free allocated PFNs if the range does not
 match
Content-Language: en-US
To: Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>,
 Yu Zhao <yuzhao@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260629-free-pfn-on-alloc-contig-range-error-path-v1-1-496ff9ca22db@nvidia.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <20260629-free-pfn-on-alloc-contig-range-error-path-v1-1-496ff9ca22db@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/30/26 03:35, Zi Yan wrote:
> When using __GFP_COMP in alloc_contig_frozen_range(), if the allocated
> range does not match the requested one, the code errors out with EINVAL
> without freeing the allocated PFNs and causes free page leaks. Fix it by
> calling release_free_list() in the error path.
> 
> The issue is reported by Sashiko[1].

So this?
Reported-by: Sashiko <sashiko-bot@kernel.org>

> Fixes: e98337d11bbd ("mm/contig_alloc: support __GFP_COMP")
> Link: https://sashiko.dev/#/patchset/20260628-keep-subpage-private-zero-at-free-v1-0-f4ce3930d10f@nvidia.com [1]
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Cc: stable@vger.kernel.org

Hm well, it's a path that warns, can only happen due to a development error?
Not sure we care about stable then. Anyway.

Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

> ---
> Sashiko reports that if alloc_contig_range() with __GFP_COMP cannot
> allocate PFNs with the given range, it returns EINVAL without freeing the
> allocated PFNs and causes free memory leaks. Fix it by properly freeing the
> isolated free pages and adjusting WARN message for clarification.
> ---
>  mm/compaction.c | 2 +-
>  mm/internal.h   | 1 +
>  mm/page_alloc.c | 6 ++++--
>  3 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index b776f35ad020..4e3f06ff9304 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -88,7 +88,7 @@ static struct page *mark_allocated_noprof(struct page *page, unsigned int order,
>  }
>  #define mark_allocated(...)	alloc_hooks(mark_allocated_noprof(__VA_ARGS__))
>  
> -static unsigned long release_free_list(struct list_head *freepages)
> +unsigned long release_free_list(struct list_head *freepages)
>  {
>  	int order;
>  	unsigned long high_pfn = 0;
> diff --git a/mm/internal.h b/mm/internal.h
> index 181e79f1d6a2..6f9e5c2a6065 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -821,6 +821,7 @@ static inline void clear_zone_contiguous(struct zone *zone)
>  }
>  
>  extern int __isolate_free_page(struct page *page, unsigned int order);
> +extern unsigned long release_free_list(struct list_head *freepages);
>  extern void __putback_isolated_page(struct page *page, unsigned int order,
>  				    int mt);
>  extern void memblock_free_pages(unsigned long pfn, unsigned int order);
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index ee902a468c2f..c1a35adb40f1 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7235,9 +7235,11 @@ int alloc_contig_frozen_range_noprof(unsigned long start, unsigned long end,
>  		check_new_pages(head, order);
>  		prep_new_page(head, order, gfp_mask, 0);
>  	} else {
> +		release_free_list(cc.freepages);
>  		ret = -EINVAL;
> -		WARN(true, "PFN range: requested [%lu, %lu), allocated [%lu, %lu)\n",
> -		     start, end, outer_start, outer_end);
> +		WARN(true,
> +		     "PFN range: allocated [%lu, %lu) does not match requested [%lu, %lu), freeing allocated PFNs\n",
> +		     outer_start, outer_end, start, end);
>  	}
>  done:
>  	undo_isolate_page_range(start, end);
> 
> ---
> base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
> change-id: 20260629-free-pfn-on-alloc-contig-range-error-path-acc001232468
> 
> Best regards,

