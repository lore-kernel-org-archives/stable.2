Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794255682;
	b=oa/PPdYSmK8mpCkgVkrEZJRtnpuPK9uhy6ZHhZEr5qVUbewKoReATjLu1lc5NdryL7+R
	 cPRlpIK/AOmHh6xDNtrN+iWsjsbPzGn90qjBqja3707GXB4U9ixKGWQyVnv2Kx+u3e23C
	 yhP04XNwd/fb2x+gsbhQQBW4p7eHhjuDS1g67YbRfW3eGQvD3wkC/x0DVv6eHaG0ffHti
	 yamC2QZyo47ilsRcN2PWBg/NLR669pc5i2WKSFUrzEItdo/24XweajoclaTRhNk4t+hFU
	 kdrBvNAUCrkSHKsmyK+uidC/p9CpBuko8ercpmDoz2zHLYcT1Meq/3X2+EFnjk+qDBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794255682;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=wu0va37Y4jORVbHzhc2bno5TkFP29zSyjIkAss8oUKo=;
	b=hd6R/RQb0YBSE6489JXU624FPgZPyP9Lc2nhTq5XjTa+7pyqs/gEoDJGyjoiP0Yg3p6o
	 J41UImWUW4IkJsKz02OjN20ZVNk/iLxbfa+SnQGQokIYPq0G7GlcsHReIZ25WfrsgnE/F
	 L1xU4v/7TY5fCNyZSxmZ/9N21wfDIg7bfyE1ZoDD52aZOLg8CnF0NiUBZqKeZyDZ/HaUg
	 Jku6+3+SmnMGbHfT3ZLgOo9/o9G5wZEW8yU/vPoa6MfTXMfS0fcwIOQqmjIQ9RFmLjaeG
	 /TM9V0pilKm4jeo/13E7Y27FBoesnB6UkxzmkCvyT2ZGROW7ZcOg0LvTZ7G8+QNIHZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oSlq0QUl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26CA606A321;
	Mon,  9 Nov 2026 20:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oSlq0QUl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 247941F008A3;
	Mon,  9 Nov 2026 20:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794255681;
	bh=wu0va37Y4jORVbHzhc2bno5TkFP29zSyjIkAss8oUKo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=oSlq0QUlQ9SXI9uwVxk70LcfGgh9K3jdj8lbsPQY1rEfTS4lCN9QodMK759gn9MOe
	 5wCJFzYQ4mVr3PdtB98xBnPWqPy63RxiKiag2Jeeyd3ID2ck5OJYMbPmrg8ANIZ0P9
	 4HgghUkDnzzJW3m46w5SkAZhYRZhuueDGO8NI6C35PVF92NAfh7l9+7R9zFzKkd/gG
	 RqL6iU/2r8zjyG7VPA5/RwEm3LLV5j4b6Sxq1i44yVlRpUcXBUEHdkeQSjLAFIXGXe
	 fCBab64+YmKWaxpCrAMrNCzRH5mY9uk2tpJB7Yk2baBNEURD7kAVn/RAheMFdUm4Kd
	 DtRRX2/enaWxQ==
Message-ID: <5a7bb477-5392-404c-a748-4748cec2c84f@kernel.org>
Date: Mon, 9 Nov 2026 21:21:12 +0100
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
Subject: Re: [PATCH v3] mm/huge_memory: prevent losing PG_waiters in
 __split_folio_to_order()
To: Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 Kiryl Shutsemau <kas@kernel.org>, Brendan Jackman
 <brendan.jackman@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>,
 Ye Liu <ye.liu@linux.dev>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261109-fix-split_folio_to_order-race-v3-1-1cdc509e34be@nvidia.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261109-fix-split_folio_to_order-race-v3-1-1cdc509e34be@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/9/26 20:32, Zi Yan wrote:
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
> Liu's patch (the second Closes) on reading ->flags during a folio split.
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
> ---
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
> index bd44d58e86845..99b48d7c988db 100644
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
> @@ -3730,8 +3731,16 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
>  		 * unreferenced sub-pages of an anonymous THP: we can simply drop
>  		 * PG_anon_exclusive (-> PG_mappedtodisk) for these here.
>  		 */
> -		new_folio->flags.f &= ~PAGE_FLAGS_CHECK_AT_PREP;
> -		new_folio->flags.f |= (folio->flags.f &
> +		/*
> +		 * ->flags are stable since the folio is locked and frozen.
> +		 * data_race() is used because reference-less writers,
> +		 * 1. PG_waiters from softleaf_entry_wait_on_locked() and

Hm? I thought that case would be handled by your patch? How can they still write
to the page?

> +		 * 2. PG_hwpoison from memory_failure(),
> +		 * can still write to it.

We lose PG_hwpoison left and right when racing with non-atomic updates. It needs
a fundamental fix. Is this really something we should take care of in this series?

> +		 */
> +		new_flags.f = data_race(new_folio->flags.f) & ~PAGE_FLAGS_CHECK_AT_PREP;
> +		/* See above for data_race() use */
> +		new_flags.f |= data_race(folio->flags.f) &
>  				((1L << PG_referenced) |
>  				 (1L << PG_swapbacked) |
>  				 (1L << PG_swapcache) |
> @@ -3749,7 +3758,18 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
>  #endif
>  				 (1L << PG_dirty) |
>  				 (1L << PG_dropbehind) |
> -				 LRU_GEN_MASK | LRU_REFS_MASK));
> +				 LRU_GEN_MASK | LRU_REFS_MASK);

-- 
Cheers,

David
