Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67D21F94F;
	Tue,  1 Sep 2026 06:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788242713; cv=none; b=csdiouIoJFIoFZ2BmqIoyocFHuvwOI5sjoGaazqzs/6yyq7h/QnES5C21H45hxOLOgOZtdP2NCjBS2IF5J5523gq1VbDWSVAr6Zv/U9EiKWBqrbGC+0v7B3qBCHd/QCZEVglzD5TNDjx/yGBE2WRGUuBnrffV5BSwwacpVhqz20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788242713; c=relaxed/simple;
	bh=EoiPgqXxf5X6lRNnz7OLUZD5TX0UjOjYcZu4svIQeYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ImBsGsANuRwv/KClopKeeZ6qYB4GVAEN4Lq2vVhegCOopSfZPYTEWwfa3rG43AcRRlhn/1D78BYnmPJ9QJL9jX+jfJT7KuenOHNHrihYjONPfbzLziWUz4D9Sh3mLQWbfk++/91lG1rO1p1+tNNJE1hl0MaPthXl2gWdVRBIcjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b48kfpxu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b48kfpxu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1004A1F00A3F;
	Tue,  1 Sep 2026 06:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788242711;
	bh=yYujhla635YIC29pToBJFfX6II2OO6wsdmrh9OYvk8A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=b48kfpxuS8hQIfvcvM8p35qoaCRmgQZTiyYimk9eL8nfLA7ipN3SErTO6jDwK7CKW
	 WLJX2qt60vqifeR34lPf8YMO4w6dCwvBQIu/0qkXs3wx6bfR4nDWaojNk0WFXJ3ZF8
	 evxC4TYNswNIb7o/7ZCatavjeESzFQHtffXuQuML03ddc4tJ3+DaMl+Qu4XS82nUE/
	 y44hQPkoh4Fbwl4c+BKCeBETcIyMSfZTEFtTXBA+u9u9IhWOoRFbWufCTtL/Z5rCXR
	 gfRSN1aGkNyjqdXunVRhKIs2CwIwC+zIj4kYRTvyy1AK9rxcpsoZXjY7h1F3KY/w0V
	 L8mxaYJW34c1g==
Message-ID: <ea12e0a4-36b3-4c71-8930-72fc4eaf369f@kernel.org>
Date: Tue, 1 Sep 2026 08:05:07 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [tip: x86/urgent] x86/mm/pat: Acquire init_mm read lock on
 attribute change to avoid UAF
To: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Atish Patra <atishp@meta.com>,
 Nikunj A Dadhania <nikunj@amd.com>, stable@vger.kernel.org, x86@kernel.org
References: <20260813-cpa-fixes-v2-2-39b4ff90f91d@kernel.org>
 <178821524648.3717435.13938325908577682845.tip-bot2@tip-bot2>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <178821524648.3717435.13938325908577682845.tip-bot2@tip-bot2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01. 09. 26, 0:27, tip-bot2 for Lorenzo Stoakes (ARM) wrote:
> The following commit has been merged into the x86/urgent branch of tip:
> 
> Commit-ID:     477cf5cd1f698053df7426b7b8d9339e85e00946
> Gitweb:        https://git.kernel.org/tip/477cf5cd1f698053df7426b7b8d9339e85e00946
> Author:        Lorenzo Stoakes (ARM) <ljs@kernel.org>
> AuthorDate:    Thu, 13 Aug 2026 12:01:25 +03:00
> Committer:     Dave Hansen <dave.hansen@linux.intel.com>
> CommitterDate: Mon, 31 Aug 2026 15:15:42 -07:00
> 
> x86/mm/pat: Acquire init_mm read lock on attribute change to avoid UAF
> 
> A previous commit protected against races between ptdump and CPA collapse,
> however one still exists between attribute changes and collapse as reported
> by Denis V. Lunev (linked).
> 
> When an attribute change arises, a lockless page table walker obtains a PTE
> entry, which is later written to via set_pte_atomic():
> 
> ...
> -> change_page_attr_set_clr()
> -> __change_page_attr_set_clr()
> -> __change_page_attr()
> 	-> _lookup_address_cpa()
> 	-> lookup_address_in_pgd_attr()
> 	-> [ lockless page table walker ]
> -> set_pte_atomic()
> 
> There is nothing preventing a concurrent CPA collapse which can free the
> PTE that was retrieved here, resulting in a use-after-free.
> 
> With the mmap write lock taken on init_mm over CPA collapse, resolve this
> race by acquiring an mmap read lock on init_mm over
> __change_page_attr_set_clr().
> 
> This locks across the whole operation over which the walk and the PTE entry
> write occurs, solving the race.
> 
> It is safe to do this here, as no spinlocks are held upon entry to
> __change_page_attr_set_clr().
> 
> However, the lock must not be held over an allocation, as allocation can
> trigger reclaim and shrinkers may call into CPA recursively, making
> deadlocks possible (init_mm -> ... -> fs_reclaim -> init_mm).
> 
> A page table is allocated when a huge page needs to be split:
> 
> -> change_page_attr_set_clr()
> -> __change_page_attr_set_clr()
> -> __change_page_attr()
> -> split_large_page()
> [ pagetable_alloc() ]
> -> __split_large_page()
> 
> Avoid deadlocks by dropping the mmap lock across pagetable_alloc() in
> split_large_page() and track whether this is needed by adding a new
> 'init_mm_read_locked' flag to struct cpa_data.
> 
> This is safe as __split_large_page() (called with locks re-established)
> revalidates that the page table entry is the same as it was prior to the
> locks being dropped and __change_page_attr() repeats the entire page table
> walk whenever a split occurs, so concurrent split and collapse are
> accounted for.
> 
> Concurrent ptdump is also safe as the lock is only dropped over page table
> allocation during which time the page table has not yet been modified.
> 
> The CPA_COLLAPSE flag is only set by set_memory_rox(), which exclusively
> operates upon vmalloc ranges, and on x86 only within the module mapping
> space.
> 
> This is important, because some callers directly invoke
> __change_page_attr_set_clr(), bypassing this lock. However, none of these
> operate within the module mapping space.
> 
> * cpa_process_alias() - a recursive helper called by
>    __change_page_attr_set_clr().
> * __set_memory_enc_pgtable() - operates on the direct mapping and (via
>    __vmbus_establish_gpadl()) the vmalloc mapping space.
> * __set_pages_[n]p() - called by set_direct_map_[invalid, default,
>    valid]_noflush(), __kernel_map_pages() - operates on the direct map.
> * kernel_[un]map_pages_in_pgd() - operates on EFI ranges.
> 
> This work is based upon Denis V. Lunev's excellent analysis of the bug with
> gratitude.
> 
> Fixes: 41d88484c71c ("x86/mm/pat: restore large ROX pages after fragmentation")
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Tested-by: Atish Patra <atishp@meta.com>
> Tested-by: Nikunj A Dadhania <nikunj@amd.com>
> Link: https://lore.kernel.org/all/20260626163213.2284080-1-den@openvz.org/
> Cc:stable@vger.kernel.org
> Link: https://patch.msgid.link/20260813-cpa-fixes-v2-2-39b4ff90f91d@kernel.org
> ---
>   arch/x86/mm/pat/set_memory.c | 28 +++++++++++++++++++++++++---
>   1 file changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index c38faf3..cb5d6d6 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -22,6 +22,7 @@
>   #include <linux/cc_platform.h>
>   #include <linux/set_memory.h>
>   #include <linux/memregion.h>
> +#include <linux/cleanup.h>
>   
>   #include <asm/e820/api.h>
>   #include <asm/processor.h>
> @@ -49,7 +50,8 @@ struct cpa_data {
>   	unsigned int	flags;
>   	unsigned int	force_split		: 1,
>   			force_static_prot	: 1,
> -			force_flush_all		: 1;
> +			force_flush_all		: 1,
> +			init_mm_read_locked	: 1;
>   	struct page	**pages;
>   };
>   
> @@ -409,7 +411,7 @@ static void __cpa_flush_tlb(void *data)
>   
>   static int collapse_large_pages(unsigned long addr, struct list_head *pgtables);
>   
> -static void cpa_collapse_large_pages(struct cpa_data *cpa)
> +static void __cpa_collapse_large_pages(struct cpa_data *cpa)
>   {
>   	unsigned long start, addr, end;
>   	struct ptdesc *ptdesc, *tmp;
> @@ -443,6 +445,18 @@ static void cpa_collapse_large_pages(struct cpa_data *cpa)
>   	}
>   }
>   
> +static void cpa_collapse_large_pages(struct cpa_data *cpa)
> +{
> +	/*
> +	 * Take the mmap write lock on init_mm to:
> +	 * - Avoid a use-after-free if raced by ptdump (which takes its own
> +	 *   write lock on init_mm).
> +	 * - Serialise concurrent CPA walkers.
> +	 */
> +	scoped_guard(mmap_write_lock, &init_mm)
> +		__cpa_collapse_large_pages(cpa);
> +}
> +

Ah, this belongs to the "Acquire init_mm *write* lock" counterpart. Not 
sure how you managed to split/combine these two 8-).

thanks,
-- 
js
suse labs

