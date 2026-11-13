Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794531777;
	b=AsR2QrKhccOzw+M10lflWSQBhDJ3Jmp21MY8kTZiLX3H2CRwUWdkbUeMJCD1P+77TG8n
	 UaxRXzcBmxXOerw2HaiRwVBabn2XY9d32vva/bln+RCeHXcOxH7BiXv1jfb85vJ3dYdul
	 7W2uXxyeGTZGqWmXuBuyooHMxHxX4qU3QJbazqmxfVYXHvIk+ngVFWXzGbQbBK20J98q2
	 jFBdSldvlUXgFSzjeyv+8jBlZEzWVku92+a+PTsPSfuJ705tNGe8A8yb8GlVPHLzrPvpH
	 2MRJMcb0SkDNbJadg42WBXd2LiNI9U5UEADH5XEsbh/7CBokrqo03b/jaoyd6w7UAdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794531777;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=FykfmgAPqHTxTSp27gbwTeMio+wbYbSRIFzyKLbkdRY=;
	b=TBx3umF5NYNyXk6I2u2Qe32UA1WI5tFNncSBTTYs49bfNJLoR+arABsgkoBhSqc9L/Y/
	 guucDmpn+gV76IzCdfop0rnAEw4ooH/dXCIxDZaP9nwixGXcHyXkYZ6Ee56sEuBhOkg0m
	 xD5c314C9VqewXJUAMoV7yunIJyQM6CGzyFIEpsW9BSi/A0Lzz2rGy0EK9vPvJhwfaIuS
	 LFm2M2BzK+SNpr1fIS35jCYqUNvvBe+f4wFVdO+c/n3eO7rehpgNXtpkww56YoGGJS2mj
	 UieDzDMiGcHuaM+H3lUKRVBCO2bFH4pMr6Ty7z6+dPVKbD+Jka8Rxd/unWweXVEr5Ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=R9brNIwr;
	arc=none smtp.remote-ip=95.215.58.97
Received: from mta1.migadu.com (out-97.mta1.migadu.com [95.215.58.97])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4141606A33D
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 01:02:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4141606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=R9brNIwr
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=BF3X4sfAAGZDFbKdkmTbmSYx6CaOf04nwmeq6oXxtzI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794531773; v=1; x=1795136573;
 b=R9brNIwrYnS6aG9f3LJaa+HLum7i05blqjI/ZRe0bh0OswKZUgZLyxsD+gVOnBBHFsdWfpg5
 fP9Pe8hG0gzPsSJou6vbhTJOllsnD/9qpcl1FZP+WJRefQC556kg0xFai9CHhIH6IqKe+DNDuIz
 7BKUYMcGbpTLuypaw+1fex64=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4fa07f28e6c8e2e0;
	Fri, 13 Nov 2026 01:02:53 +0000
X-Mizu-Trace-ID: 4fa07f28e6c8e2e0
X-Migadu-Flow: FLOW_OUT
Message-ID: <096620df-7200-48a5-8ba7-0ad69d008869@linux.dev>
Date: Fri, 13 Nov 2026 09:02:43 +0800
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
Subject: Re: [PATCH v4] mm/huge_memory: prevent losing PG_waiters in
 __split_folio_to_order()
To: Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 Kiryl Shutsemau <kas@kernel.org>, Brendan Jackman
 <brendan.jackman@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261110-fix-split_folio_to_order-race-v4-1-cc5042f33408@nvidia.com>
Content-Language: en-US
From: Ye Liu <ye.liu@linux.dev>
In-Reply-To: <20261110-fix-split_folio_to_order-race-v4-1-cc5042f33408@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2026/11/11 11:19, Zi Yan 写道:
> __split_folio_to_order() calls prep_compound_page() on each new head page
> to create a compound page after clear_compound_head(). prep_compound_page()
> uses non atomic __SetPageHead(). It is mostly OK, since the folio is locked
> and frozen and no one else is supposed to modify the folio's flags.
> 
> However, code calling migration_entry_wait() can reach the folio by PFN,
> then access its flags. It is because softleaf_entry_wait_on_locked() used
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
> Fix it by setting PG_head along with other flags in new_folio->flags before
> smp_wmb() and clear_compound_head(). The remaining compound page metadata
> is set after clear_compound_head(). In that way, after
> clear_compound_head() makes new_folio visible, nothing overwrites the
> PG_waiters from softleaf_entry_wait_on_locked() by modifying
> new_folio->flags non-atomically.
> 
> While at it, use data_race() to suppress the KCSAN issue reported by Ye
> Liu's patch (the second Closes) on reading folio->flags in
> __split_folio_to_order().
> 
> Suggested-by: Kiryl Shutsemau <kas@kernel.org>
> Reported-by: David Hildenbrand <david@kernel.org>
> Closes: https://lore.kernel.org/all/DMHE8BEEER1H.2BIY52NXATPIA@nvidia.com/
> Reported-by: Ye Liu <ye.liu@linux.dev>
> Closes: https://lore.kernel.org/all/20261029-data_race_huge_mem-v1-1-112e331291c1@linux.dev/
> Fixes: c010d47f107f6 ("mm: thp: split huge page to any lower order pages")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
> The issue was raised by David when reviewing Ye Liu's "mm/huge_memory: use
> READ_ONCE() when cloning folio flags during split" [1]. This patch also
> supersedes Ye Liu's patch.
> 
> [1] https://lore.kernel.org/all/20261029-data_race_huge_mem-v1-1-112e331291c1@linux.dev/

Fine with this superseding my READ_ONCE() patch.

Reviewed-by: Ye Liu <liuye@kylinos.cn>

> ---
> Changes in v4:
> - removed the data_race() on new_folio->flags read, since there is no data
>   race on it.
> - rephrased the comment above data_race() to avoid confusion.
> - rephrased the comment on setting PG_head to clarify why it needs to be
>   set before smp_wmb() and why no plain RMW is allowed after
>   clear_compound_head().
> - adjusted the comment on __prep_compound_page() about PG_head.
> - Link to v3: https://patch.msgid.link/20261109-fix-split_folio_to_order-race-v3-1-1cdc509e34be@nvidia.com
> 
> Changes in v3:
> - set PG_head before smp_wmb() like Kiryl suggested instead of
>   prep_compound_page_atomic().
> - used data_race() to suppress KCSAN reports while at it.
> - dropped Lorenzo's ack, since the patch is changed.
> - Link to v2: https://patch.msgid.link/20261106-fix-split_folio_to_order-race-v2-1-1b59c67b8af3@nvidia.com
> 
> Changes in v2:
> - renamed __prep_compound_head_and_tail() to __prep_compound_page().
> - added comments to prep_compound_page() and __prep_compound_page().
> - Link to v1: https://patch.msgid.link/20261029-fix-split_folio_to_order-race-v1-1-a483c7451b0d@nvidia.com
> ---
>  mm/huge_memory.c | 32 ++++++++++++++++++++++++++++----
>  mm/internal.h    |  2 ++
>  mm/page_alloc.c  | 17 +++++++++++++++--
>  3 files changed, 45 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index bd44d58e86845..76c57d845269e 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3714,6 +3714,7 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
>  		 * Don't pass it around before clear_compound_head().
>  		 */
>  		struct folio *new_folio = (struct folio *)new_head;
> +		memdesc_flags_t new_flags;
>  
>  		VM_BUG_ON_PAGE(atomic_read(&new_folio->_mapcount) != -1, new_head);
>  
> @@ -3730,8 +3731,15 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
>  		 * unreferenced sub-pages of an anonymous THP: we can simply drop
>  		 * PG_anon_exclusive (-> PG_mappedtodisk) for these here.
>  		 */
> -		new_folio->flags.f &= ~PAGE_FLAGS_CHECK_AT_PREP;
> -		new_folio->flags.f |= (folio->flags.f &
> +		new_flags.f = new_folio->flags.f & ~PAGE_FLAGS_CHECK_AT_PREP;
> +		/*
> +		 * data_race() is used because folio->flags is only read here,
> +		 * but a reference-less writer can still write to it, e.g.,
> +		 * PG_waiters update from softleaf_entry_wait_on_locked().
> +		 * The flag is not transferred to new_flags as it is
> +		 * folio specific, so it is not lost.
> +		 */
> +		new_flags.f |= data_race(folio->flags.f) &
>  				((1L << PG_referenced) |
>  				 (1L << PG_swapbacked) |
>  				 (1L << PG_swapcache) |
> @@ -3749,7 +3757,19 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
>  #endif
>  				 (1L << PG_dirty) |
>  				 (1L << PG_dropbehind) |
> -				 LRU_GEN_MASK | LRU_REFS_MASK));
> +				 LRU_GEN_MASK | LRU_REFS_MASK);
> +
> +		/*
> +		 * Set PG_head before smp_wmb() and clear_compound_head().
> +		 * After clear_compound_head() marks new_head as a folio of its
> +		 * own, new_head->flags must not be modified by plain RMWs.
> +		 * A plain RMW can cause a loss of atomic PG_* updates from
> +		 * a reference-less writer, e.g., setting PG_waiters via
> +		 * softleaf_entry_wait_on_locked().
> +		 */
> +		if (new_order)
> +			new_flags.f |= 1L << PG_head;
> +		WRITE_ONCE(new_folio->flags.f, new_flags.f);
>  
>  		new_folio->mapping = folio->mapping;
>  		new_folio->index = folio->index + i;
> @@ -3779,7 +3799,11 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
>  		 */
>  		clear_compound_head(new_head);
>  		if (new_order) {
> -			prep_compound_page(new_head, new_order);
> +			/*
> +			 * PG_head is set above, so only set up the remaining
> +			 * metadata on head page and tail pages.
> +			 */
> +			__prep_compound_page(new_head, new_order);
>  			folio_set_large_rmappable(new_folio);
>  		}
>  
> diff --git a/mm/internal.h b/mm/internal.h
> index aeebb3e49ed11..4ce67ce2f3fba 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -807,6 +807,8 @@ static inline void prep_compound_tail(struct page *tail,
>  	VM_WARN_ON_ONCE(tail->private);
>  }
>  
> +void __prep_compound_page(struct page *page, unsigned int order);
> +
>  #if defined CONFIG_COMPACTION || defined CONFIG_CMA
>  
>  /*
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 143776e671abb..5f03f3725dd2e 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -682,18 +682,31 @@ static inline bool pcp_allowed_order(unsigned int order)
>   * This usage means that zero-order pages may not be compound.
>   */
>  
> -void prep_compound_page(struct page *page, unsigned int order)
> +/*
> + * Set up the metadata on head page and tail pages.
> + * Caller must set PG_head before this.
> + */
> +void __prep_compound_page(struct page *page, unsigned int order)
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
> +/*
> + * PG_head is set non-atomically. It should be used when no one else can modify
> + * @page's flags.
> + */
> +void prep_compound_page(struct page *page, unsigned int order)
> +{
> +	__SetPageHead(page);
> +	__prep_compound_page(page, order);
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

-- 
Thanks,
Ye Liu

