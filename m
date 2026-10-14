Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90C325F7A9;
	Wed, 14 Oct 2026 13:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791985438; cv=none; b=ovajAdvTmi1nmSbp9CeGOvBDPXA4Liy0U91WvnaIcrko0j0C8eG8m+Vi90fk04ovtC5Xw1qoreTT3PzvUUjBa6/hf70UMtIorMUeHJRszJqNGr2fAQWPqdjlF9MGgjDiTMSxmEXs6xJZZi8R1KFYt65r/DxfSbnUqE+EieC8SEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791985438; c=relaxed/simple;
	bh=MbZnv2aFyF7Ym5YMUYAQMddwf0kzFG8Yuq53XRxGvBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UwPN0PRDd9zfS4eeGliPZq3LNepKRFBw7gmBYU8HuGiB2OYyxZW0EzPfOTQPXn2jmdaAnTFMEioVJV5QOphUbm8jzUncNoPIi7dgK2uMkMcZ5dRsYdp6pxjtNIvn9S74Q5OYbrJBXiZCdWfZ79g9PA2RS6J5az6y9N1Twvvmv8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=a0uePfgJ; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="a0uePfgJ"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DAF7A1570;
	Wed, 14 Oct 2026 06:43:51 -0700 (PDT)
Received: from [10.164.19.62] (unknown [10.164.19.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3ED6A3F7B4;
	Wed, 14 Oct 2026 06:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791985435; bh=MbZnv2aFyF7Ym5YMUYAQMddwf0kzFG8Yuq53XRxGvBs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=a0uePfgJ3M7g6AzfBFSq8n0o0CS2ReXcjjPBvbP4NBO1XBKIWzbkRPVXX/FXvC18x
	 ZBv9YIMxapU9BbupxpSBDBe71Z8onU2XAj1DkhmK+C4c7SnWHe2/hVU1iEKh9jobUD
	 b7ebjeOBq59RymK0dH8y6YcsgrB809oHV/h1p16c=
Message-ID: <13ebe0c7-35c2-45e2-a217-54723ff7f0ba@arm.com>
Date: Wed, 14 Oct 2026 19:13:46 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/5] mm/page_alloc: count guard pages as free again
 when their buddy merges
To: Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <brendan.jackman@linux.dev>,
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
 Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Barry Song <baohua@kernel.org>,
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>,
 linux-mm@kvack.org, stable@vger.kernel.org
References: <20261007021250.1665929-1-riel@surriel.com>
 <20261007021250.1665929-2-riel@surriel.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20261007021250.1665929-2-riel@surriel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 07/10/26 7:42 am, Rik van Riel wrote:
> With debug_guardpage_minorder set, expand() turns the unused halves of a
> split into guard pages, which page_del_and_expand() leaves out of the free
> counts. Freeing the allocated half credits only that half, and
> __free_one_page() then merges the guard buddy with clear_page_guard(),
> which no longer touches the counters.
> 
> The merged block goes on a free list with the guard pages never counted,
> so NR_FREE_PAGES falls behind the free lists by every guard that merges.
> Before commit e0932b6c1f94 ("mm: page_alloc: consolidate free page
> accounting"), __set_page_guard() and __clear_page_guard() adjusted the
> counts themselves; that commit dropped both adjustments but kept the
> subtraction implicit in expand().
> 
> Count the guard pages under the merged block's migratetype when the
> buddy is cleared. account_freepages() skips an isolated block as it does
> for every other free page, and moving the block off the isolated list
> counts it then.
> 
> Booting a 16GB VM with debug_pagealloc=on debug_guardpage_minorder=1,
> check the difference in free pages reported between /proc/vmstat
> and /proc/buddyinfo.
> 
> At three points (idle, after a read and file-creation load, after
> a second load), check the difference between nr_free_pages and the
> buddyinfo numbers in the normal zone, as a number of pages:
> 
>                 idle   after load   after second load
>     unpatched   -130        79205               99121
>     patched      -16           45                   0
> 
> The small remaining difference seems to be due to the numbers
> not being read at exactly the same time, and is also seen
> without guard pages.
> 
> Fixes: e0932b6c1f94 ("mm: page_alloc: consolidate free page accounting")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Rik van Riel <riel@surriel.com>
> ---

LGTM

Reviewed-by: Dev Jain <dev.jain@arm.com>

Probably send this separately? RFC on a fix will delay
the patch.


>  mm/page_alloc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 12fac9084c483..4658af97be010 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -988,10 +988,12 @@ static inline void __free_one_page(struct page *page,
>  		 * Our buddy is free or it is CONFIG_DEBUG_PAGEALLOC guard page,
>  		 * merge with it and move up one order.
>  		 */
> -		if (page_is_guard(buddy))
> +		if (page_is_guard(buddy)) {
>  			clear_page_guard(zone, buddy, order);
> -		else
> +			account_freepages(zone, 1 << order, migratetype);
> +		} else {
>  			__del_page_from_free_list(buddy, zone, order, buddy_mt);
> +		}
>  
>  		if (unlikely(buddy_mt != migratetype)) {
>  			/*

