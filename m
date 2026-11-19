Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795094612;
	b=iM3++hWcefEZZrKt3d3YiseX6FPjOpJAxBXIgvzZYqVT77r5M9Y1XkOt/hRByGoKvrt3
	 cALOXQpuSkZugUm3xjiah0N0g03EmRjofoZFYBayVk3Q45OFFupkTRZL4zasA4xNMx0HR
	 OlDNx+it2Kv90YAKbCbmBbhUKpDVx2MaLY9biYr+rdxzwJDgGry8op95wir/UjeRKDjzF
	 Dc6kdeHiW1RTIRbFZbIEg3o5ZDTDwzQkfcZ7V3FWMXDWpMRJLEsi7maRRUui550ZJh/tw
	 TUMHhN+1uDAM5PNX4L9ChJcfFdMA4xmcQjhiRqhfsm/lB4+wzQqi/XrHrGUJcz2hYKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795094612;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=NTpzirKbp7wgHPt5BJeerlD4lUmv8WbyAY5FQdaUO/o=;
	b=rYtDjMneuMnmjmM07euwKucCAwHc48H/5gx2Z8mQQcu7YGQXgSwhDRcj80bex0NF2fkj
	 8NLb02XSY0UL+AtSmAMReiR6iWeVxS/jbqKvH42WQhtu3QIRYhgaNHot88AIn8orHdVsb
	 OoUqSUPnoVhQsLZPvs60QiWp91LR/aItE3S6kWwOFEw0m/lUzuE/1R9R+du+nyxroqG1p
	 2jQzczf+jhmkSam3rpCpDn5QFFaLkBkLZpMwCbdRhHtI+FuqyKhpawZ73StLye442OUq8
	 BcWf6R5FeJHiG+rPb31/RWxg92ZkxFvFg5/bAcQF+sj9OQgUAAt7x03/u5MZAzHBAiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lRSsvKq9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DE5606A320;
	Thu, 19 Nov 2026 13:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lRSsvKq9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D29741F000C5;
	Thu, 19 Nov 2026 13:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795094612;
	bh=NTpzirKbp7wgHPt5BJeerlD4lUmv8WbyAY5FQdaUO/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lRSsvKq96cZP+ZvRxMNmPxuVc7KhlNo9eMqm29qw5DCKm45kIjq33tGklLv9RPJtf
	 t6RczbudOiO2LMymrjP1y6LNb0aKcSGmOGp5FyT39efpLlLCf4U5LM+D+0c/GEkpEk
	 gzlaW5UItrxJlnlfb6IGjMLEfo+1drnDc6D3D5fDt3ljoFk7YVMqR5uyF224lzM8BC
	 YpzLpMQHBIf97+teq849ecYAptGyyN8oUAFtXco7o1CZm37j9zpvCmiY+QZUqaDYUX
	 tgLbo8AGY4TxoMAcqT7WjgnDica4lHZWfD+Fxm5cNuVOxC/Nms9Huo8Cruy2SVPeqx
	 icQJxqxZWq4zA==
Date: Thu, 19 Nov 2026 14:23:26 +0100
From: "Oscar Salvador (SUSE)" <osalvador@kernel.org>
To: Nilay Vaish <nilayvaish@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Zi Yan <ziy@nvidia.com>, Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/page_owner: fix double decrement of stack count on
 unpoison
Message-ID: <av74TpCUPQkXFkOH@localhost.localdomain>
References: <20261118212819.403059-1-nilayvaish@google.com>
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
In-Reply-To: <20261118212819.403059-1-nilayvaish@google.com>

On Wed, Nov 18, 2026 at 01:28:19PM -0800, Nilay Vaish wrote:
> page_owner counts, for each allocation stack, how many pages allocated
> from that stack are still in use. The count is incremented when a page
> is allocated and decremented in __reset_page_owner() when it is freed.
> 
> A page that is hwpoisoned while in use and later unpoisoned passes
> through free_pages_prepare() twice:
> 
>   1. On poisoning, the last reference is dropped. free_pages_prepare()
>      calls reset_page_owner() but, because the page is PageHWPoison(),
>      keeps it off the free lists.
> 
>   2. On unpoisoning, unpoison_memory() drops the poison reference and
>      free_pages_prepare() calls reset_page_owner() again, this time
>      really freeing the page.
> 
> __reset_page_owner() decrements the stack count both times, although
> the page was allocated only once. The first call clears
> PAGE_EXT_OWNER_ALLOCATED, but the second call never checks it.
> 
> If this drives the count to zero while the stack is still in use,
> stackdepot treats the record as freed and warns on every later
> allocation or free that uses the same stack:
> 
>   dec_stack_record_count: refcount went to 0 for 92274844 handle
>   WARNING: lib/stackdepot.c:517 at depot_fetch_stack+0x5c/0x70
>   Call Trace:
>    __set_page_owner+0x110/0x290
>    get_page_from_freelist+0x1225/0x1440
>    __alloc_frozen_pages_noprof+0x1fc/0x1b00
>    __folio_alloc_noprof+0x12/0xa0
>    alloc_migration_target+0x81/0x1e0
>    migrate_pages_batch+0x1f2/0x14c0
>    migrate_pages+0x9c3/0xca0
>    soft_offline_page+0x189/0x570
> 
> A single soft offline followed by an unpoison is enough to trigger it,
> because the migration-target stack that the offlined page is accounted
> to usually has very few pages.
> 
> Fix it by decrementing the stack count only if PAGE_EXT_OWNER_ALLOCATED
> was still set, i.e. only the first time the page is freed.
> 
> To reproduce, boot with page_owner=on and CONFIG_HWPOISON_INJECT, soft
> offline anonymous pages with madvise(MADV_SOFT_OFFLINE), and unpoison
> each old PFN through debugfs hwpoison/unpoison-pfn. Without this patch
> the first cycle prints the message above and 2200 cycles produce 6597
> warnings. With it, the same run is clean and all stack counts return
> to their initial values.
> 
> Fixes: 217b2119b9e2 ("mm,page_owner: implement the tracking of the stacks count")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nilay Vaish <nilayvaish@google.com>

Reviewed-by: Oscar Salvador (SUSE) <osalvador@kernel.org>

Nit below:

> ---
>  mm/page_owner.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index 02bb304b53cf..0793a460d615 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -320,11 +320,13 @@ void __reset_page_owner(struct page *page, unsigned short order)
>  	depot_stack_handle_t alloc_handle;
>  	struct page_owner *page_owner;
>  	u64 free_ts_nsec = local_clock();
> +	bool allocated;
>  
>  	page_ext = page_ext_get(page);
>  	if (unlikely(!page_ext))
>  		return;
>  
> +	allocated = test_bit(PAGE_EXT_OWNER_ALLOCATED, &page_ext->flags);
>  	page_owner = get_page_owner(page_ext);
>  	alloc_handle = page_owner->handle;
>  	page_ext_put(page_ext);
> @@ -339,7 +341,7 @@ void __reset_page_owner(struct page *page, unsigned short order)
>  	__update_page_owner_free_handle(page, handle, order, current->pid,
>  					current->tgid, free_ts_nsec);
>  
> -	if (alloc_handle != early_handle)
> +	if (allocated && alloc_handle != early_handle) {
>  		/*
>  		 * early_handle is being set as a handle for all those
>  		 * early allocated pages. See init_pages_in_zone().
> @@ -348,6 +350,7 @@ void __reset_page_owner(struct page *page, unsigned short order)
>  		 * their refcount either.
>  		 */

I would expand this comment to integrate the allocated logic.
Because someone might think that every page hitting this function should have
been previously allocated. 

 

-- 
Oscar Salvador
SUSE Labs
