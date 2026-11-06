Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793983734;
	b=FwcAS1fE+zFzT15SrKpheMJTsZsZk/ohHK/IiyzMgbWuyDmZhg+sJGUsGfx+Se4LWl/6
	 HHHtHBKM7u6ZdtxvwmyeYlDTZuKYNNteNVwVYaOFmIJifYnLUts4AwMRT28qakIUormtb
	 nfaNtg2hs1fFlZwLRT3Cc5vgsVF6OKgvzxpwwNSypbi2MRZLYzhfJiwtqyZ+pE2YiuqWD
	 YXWv4gHGlXhl+eIZTTUJTcto1jf9bOuwW0h7Bn3Ln6+yWW6VylM2tnxafExO9yE/w5eIf
	 eZeR+E5g16ZBPMMlAvSoxbRZvCGc6NgrMyJzIvZKj7PMONGWHpL8pnlgDK1+XiJKqnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793983734;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=wwedXasY6Bp8ZwF+4iZZRJ4XWL8SdA+Fk4YfEj7+kwE=;
	b=b/QDkyep07WDPmflSwQwSWL5hEHrrWjNkGrJCA0XV5QZZXR/HfIyC62Xa2ulaPXhVnmY
	 hQji62PhuDNY2X6emYwhIPmLIIudaqE2bQ9oYCCUruGoq3uAtdwEFPZMKVNXhEuuTdKll
	 g0PqbIdY9ifsVFGUDs+HTAPL0M16qoetVAqSQnhY9tcPwHF6MNSxGXK44H6AjENL9mny+
	 7xWYW9AUlLV9fb302qP5ANnj1kM3N4RXTwBkjM3O/1KmXfX9PGzLyEoo3Olh9KiVQZwqh
	 TNIWpQ+3BlkwZfop1vQx4aM0B6CwF+g5mDhF3u4WjObzFqCEYwoiggBuBMzoZruTx2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X23zSpUc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67291606A330;
	Fri,  6 Nov 2026 16:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X23zSpUc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618661F0089F;
	Fri,  6 Nov 2026 16:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793983734;
	bh=wwedXasY6Bp8ZwF+4iZZRJ4XWL8SdA+Fk4YfEj7+kwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=X23zSpUcdN+am/IsFeY2VmYV9jInPIWBejU6sNczHeODweAqOhe7W03gMbMU/lMK/
	 H8EIPCvSaSvqFl0m4mV6/KYWV5kZhZhU0WObpKdkXn63SHiSYXO7FVKFwvaMFMuKIo
	 F3NmwRk7k0+nYiHTVvZiJ9+PNQIaULYgPbnycBbTgmNNcRbxBB1Yf/qIDx0plxIz0H
	 W1mmzh3G8rwkmhMPiShbhnoe/BKnyVYbj9i8quoEWRQj8+w0jHGRtYJH02cv1drFGc
	 PCoLSCgheRNxpmoi6y5wLow+6a3imy1fCK62Y9AvB2+kEx9MKhHqs83M382H0JF4Wg
	 ztsdFAAwbwt8A==
Date: Fri, 6 Nov 2026 16:48:46 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Brendan Jackman <brendan.jackman@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Ye Liu <ye.liu@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/huge_memory: prevent losing PG_waiters in
 __split_folio_to_order()
Message-ID: <au4A9Jx9_1PjpRCb@gremlin>
References: <20261029-fix-split_folio_to_order-race-v1-1-a483c7451b0d@nvidia.com>
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
In-Reply-To: <20261029-fix-split_folio_to_order-race-v1-1-a483c7451b0d@nvidia.com>

On Thu, Oct 29, 2026 at 10:08:44PM -0400, Zi Yan wrote:
> __split_folio_to_order() calls prep_compound_page() on each new head page
> to create a compound page after clear_compound_head(). prep_compound_page()
> uses non atomic __SetPageHead(). It is mostly OK, since the folio is locked
> and frozen and no one else is supposed to modify the folio's flags.
>
> However, code calling migration_entry_wait() can reach the folio by PFN,
> then access its flags. It is because softleaf_entry_wait_on_locked() used

Oh fun.

> by migration_entry_wait() sets PG_waiters concurrently without taking a
> reference and the frozen refcount during split cannot block it. Meanwhile,
> __SetPageHead() does a plain read and write, so PG_waiters atomically set
> by softleaf_entry_wait_on_locked() will be lost if the set happens after
> __SetPageHead()'s read and before its write.
>
> One example code interleaving:
>
> CPU0: __split_folio_to_order(new_order>0)  CPU1: do_swap_page()
>
> 1. clear_compound_head(new_head)
>    new_head->compound_info = 0
>    (page_folio(new_head) == new_head now)
>
>                                            2. migration_entry_wait()
>                                              softleaf_to_folio(entry)
>                                              page_folio() -> new_head
>                                              (not the old head any more)
>
> 3. prep_compound_page(new_head, new_order)
>      __SetPageHead(new_head)
>        tmp = new_head->flags.f  <-- load; PG_waiters == 0 in tmp
>
>                                            4. folio_set_waiters(new_head)
>                                              set_bit(PG_waiters, &flags.f)
>                                              enqueue on waitqueue, sleep
>
> 5.     new_head->flags.f = tmp | (1UL << PG_head)
>        <-- store; overwrites step 4, PG_waiters == 0 again
>
> Later, folio_unlock(new_folio) sees no PG_waiters, skips folio_wake_bit(),
> and CPU1 can remain blocked indefinitely.
>
> Fix it by adding the atomic version SetPageHead() and
> prep_compound_page_atomic() using it. __split_folio_to_order() uses
> prep_compound_page_atomic() to avoid the issue without adding an atomic ops
> to other prep_compound_page() users.
>
> Reported-by: David Hildenbrand <david@kernel.org>
> Closes: https://lore.kernel.org/all/DMHE8BEEER1H.2BIY52NXATPIA@nvidia.com/
> Fixes: c010d47f107f6 ("mm: thp: split huge page to any lower order pages")
> Signed-off-by: Zi Yan <ziy@nvidia.com>

Nasty one. Some nits below but change looks sensible to me so:

Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

BTW AI flags an hw poison thing doing the same:

memory_failure() does TestSetPageHWPoison(p) on an arbitrary subpage before
taking a reference (mm/memory-failure.c:2458), which races the same way with the
plain flag clone and with folio_set_order()'s plain _flags_1 store.

> Cc: stable@vger.kernel.org
> ---
> The issue was raised by David when reviewing Ye Liu's "mm/huge_memory: use
> READ_ONCE() when cloning folio flags during split" [1].
>
> [1] https://lore.kernel.org/all/20261029-data_race_huge_mem-v1-1-112e331291c1@linux.dev/
> ---
>  include/linux/page-flags.h |  1 +
>  mm/huge_memory.c           | 10 +++++++++-
>  mm/internal.h              |  2 ++
>  mm/page_alloc.c            | 20 ++++++++++++++++++--
>  4 files changed, 30 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index b0ddc652e76cc..08492ab3da895 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -854,6 +854,7 @@ static __always_inline int PageHead(const struct page *page)
>  	return test_bit(PG_head, &page->flags.f);
>  }
>
> +SETPAGEFLAG(Head, head, PF_ANY)
>  __SETPAGEFLAG(Head, head, PF_ANY)
>  __CLEARPAGEFLAG(Head, head, PF_ANY)
>  CLEARPAGEFLAG(Head, head, PF_ANY)
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index bd44d58e86845..319b038eba89d 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3779,7 +3779,15 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
>  		 */
>  		clear_compound_head(new_head);
>  		if (new_order) {
> -			prep_compound_page(new_head, new_order);
> +			/*
> +			 * new_head is recognized as a folio after
> +			 * clear_compound_head().
> +			 * softleaf_entry_wait_on_locked() can set PG_waiters
> +			 * on it without taking a reference, so its frozen state
> +			 * cannot prevent it. Use the atomic version to avoid
> +			 * losing a concurrently set PG_waiters.
> +			 */
> +			prep_compound_page_atomic(new_head, new_order);
>  			folio_set_large_rmappable(new_folio);
>  		}
>
> diff --git a/mm/internal.h b/mm/internal.h
> index aeebb3e49ed11..9b8864a8540aa 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -807,6 +807,8 @@ static inline void prep_compound_tail(struct page *tail,
>  	VM_WARN_ON_ONCE(tail->private);
>  }
>
> +void prep_compound_page_atomic(struct page *page, unsigned int order);
> +
>  #if defined CONFIG_COMPACTION || defined CONFIG_CMA
>
>  /*
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 143776e671abb..ace1359468046 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -682,18 +682,34 @@ static inline bool pcp_allowed_order(unsigned int order)
>   * This usage means that zero-order pages may not be compound.
>   */
>
> -void prep_compound_page(struct page *page, unsigned int order)
> +static void __prep_compound_head_and_tail(struct page *page, unsigned int order)

NIT: can this just be __prepare_compound_page()? I find the head + tail bit
quite confusing. The __ implies it's an internal function.

>  {
>  	int i;
>  	int nr_pages = 1 << order;
>
> -	__SetPageHead(page);
>  	for (i = 1; i < nr_pages; i++)
>  		prep_compound_tail(page + i, page, order);
>
>  	prep_compound_head(page, order);
>  }
>

NIT: Maybe add a comment describing this like prep_compound_page_atomic()?

> +void prep_compound_page(struct page *page, unsigned int order)
> +{
> +	__SetPageHead(page);
> +	__prep_compound_head_and_tail(page, order);
> +}
> +
> +/*
> + * PG_head is set atomically whereas the other metadata is set with plain stores.
> + * It should be used when @page's flags can be modified concurrently,
> + * e.g., in __split_folio_to_order().
> + */
> +void prep_compound_page_atomic(struct page *page, unsigned int order)
> +{
> +	SetPageHead(page);
> +	__prep_compound_head_and_tail(page, order);
> +}
> +
>  static inline void set_buddy_order(struct page *page, unsigned int order)
>  {
>  	set_page_private(page, order);
>
> ---
> base-commit: d865f2677c44cb2171b833d6775cf692756fa8be
> change-id: 20261029-fix-split_folio_to_order-race-087a2a9fbf7c
>
> Best regards,
> --
> Yan, Zi
>

--
Cheers, Lorenzo
