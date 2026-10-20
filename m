Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792490527;
	b=iOLiEKMvl7K9Me7xUF4Kb2Y86igTZbY92uKtdN8Rk8dIyZWxVEVPlpVCZnTxXqAyytRz
	 Y0X/X2ihSUhVUgeUhZcW8hYlKDMMCgjREkI2jP3eP4ddl02MIY/5mqVEQ/mWGLSX6Dd/4
	 yXoSKAqu4sKnBoKt2hziG39a5dA96YfKPBLdJDaKwUCh9NSsROfCqWp3GqwqCjTPgORl7
	 I/ZVfVQDmS9AWy8tdemSuhQVZbzG1eCUC1Bds8mAcmetlQT+ABnXwIfne22VNX9mTpQph
	 ueCg1pcy/GyQ2mkJfMZUjENk8tIZpwnudPSJSsb1ebPF+8J7Fen4t8E/rHOq1pI8Amw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792490527;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=34jo2lTPBFEDXI1aSdUvkUPUth9L8yOyLhTCG7rWYZM=;
	b=aLj3yp1PXwNnfnXZGPcFQ9oG75k/1fXm4TvCa0h389Dav0iE50T+mgQWhWUgPaKVC7aP
	 5yu4+C/SRXV7M8diRVA6ntsBjF5KmuAzKd95JaIxSraE7gV4XFJdviKnACd5Se6QlYo3/
	 RjyllSaiuJDY55q3/32mP/riqRbKUjBZMJGFUbTVFE62lIgT0D2Nk2dIgvic4seiteFGy
	 8EZsaMK3PlDUhMN3I0Qi0/sTopffvaKCAp+D2iN0ysFHuQepLfUJS30aiyKltPi6PcAvV
	 tNz7oeSzsjLl5NTQqPScg4as8h5cXhrLjZvGkz6rCiShdfD3I7vE1nGdUc0Nw36DN4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GDAqly89;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB29F606A31D;
	Tue, 20 Oct 2026 10:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GDAqly89
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B78FD1F000C4;
	Tue, 20 Oct 2026 10:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792490526;
	bh=34jo2lTPBFEDXI1aSdUvkUPUth9L8yOyLhTCG7rWYZM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=GDAqly89F/GH8yY5EhL1wwCAlHSQ1x3pwskc+bkhbIsZ8HRGCxNNpO9+Hxc3k2IzQ
	 YcOA5kV75DK7i08tKqUtrnU2C7yvmBBxI72+1b6zLYGfkFbxISwpQOtDQfIKK2+gDC
	 0iSWEYVdJ4tfVAqXHm1g8Wu7rA6WJKqSuFK+ikFVpHiuMEfQnK9/tr8oIpL2t3M2gC
	 Q9lincGUMOWlQBms4PTWH4SUg2PX8+Ow8Tsj3kdfDQCaS3efG70dPs+64nNk/5+QsA
	 NIMa9ANXzjLvRd9GkzFa2y5pIWyR4lllJ18vpYeltIGgelooasDh8vi4zR2zRMZcrF
	 ekgAf1uuGVzmQ==
Message-ID: <f5e7b114-2bda-49e3-974f-170211501203@kernel.org>
Date: Tue, 20 Oct 2026 12:02:01 +0200
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
Subject: Re: [PATCH] mm/page_alloc: skip shuffling and reporting for no-lock
 frees
Content-Language: en-US
To: Karl Mehltretter <kmehltretter@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Alexander Duyck <alexanderduyck@fb.com>, David Hildenbrand
 <david@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <brendan.jackman@linux.dev>,
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Shakeel Butt <shakeel.butt@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261005063515.6312-1-kmehltretter@gmail.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <20261005063515.6312-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/5/26 08:35, Karl Mehltretter wrote:
> free_pages_nolock() may run in NMI context or while a raw spinlock is
> held. When its zone trylock succeeds, __free_one_page() still reaches
> optional work written for ordinary frees.
> 
> shuffle_pick_tail() can refill its random-bit cache through
> get_random_u64(), which takes a per-CPU local lock.
> page_reporting_notify_free() can queue delayed work. Both operations can
> enter locking outside the trylock-or-defer mechanism used by no-lock
> frees.

For page_reporting_notify_free() are any raw spinlocks bad or is it the
scheduler locks?

> An instrumented PREEMPT_RT lockdep run forced a random-bit cache refill
> while calling free_pages_nolock() under a raw spinlock. The unpatched
> allocator reported:
> 
>     BUG: Invalid wait context
> 
> The attempted lock was batched_entropy_u64.lock in get_random_u64().
> Lockdep showed the raw test lock and zone->lock both held.

In slab we solved this by using prandom - commit a1e244a9f177 ("mm/slab: use
prandom if !allow_spin")
Could be better?

> Skip allocator shuffling and page-reporting notification for FPI_NOLOCK.
> The freed page remains on the buddy list and can be collected by a later
> reporting pass.
> 
> Trees from v6.15 through v7.2 call this flag FPI_TRYLOCK. Use
> FPI_TRYLOCK in place of FPI_NOLOCK when backporting this change.
> 
> Fixes: 8c57b687e833 ("mm, bpf: Introduce free_pages_nolock()")
> Cc: <stable@vger.kernel.org> # see patch description, needs adjustments for <= 7.2
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
> This was found while auditing the no-lock paths discussed at:
> https://lore.kernel.org/r/20260919171443.90512-1-kmehltretter@gmail.com
> 
> Tested on base e767a4ea70a3 in four-vCPU x86-64 QEMU TCG with
> PREEMPT_RT, PROVE_LOCKING, PROVE_RAW_LOCK_NESTING,
> SHUFFLE_PAGE_ALLOCATOR, PAGE_REPORTING and page_alloc.shuffle=1.
> 
> A temporary initcall registered page reporting and freed 65 maximum-order
> allocations with free_pages_nolock() under a raw spinlock. This exhausts
> shuffle_pick_tail()'s cache and forces a refill.
> 
>                                              unpatched  patched
>   free_pages_nolock() calls                          65       65
>   __free_one_page() calls                           130      130
>   shuffle_pick_tail() calls                          65        0
>   page_reporting_notify_free() calls                130        0
>   reporting work pending                              1        0
>   invalid-wait-context reports                        1        0
> 
> Maximum-order splitting accounts for the 130 __free_one_page() calls.
> Both guests powered off. The patched guest emitted no diagnostics. This
> forced test does not measure normal frequency.
> 
> A second A/B used no test-only MM caller. A BPF arena program attached to
> mm_page_free_batched requested 2,048 pages from a memcg-limited map. Partial
> failures rolled allocated pages back through free_pages_nolock() while the
> tracepoint held the per-CPU page-list lock. A virtio-balloon device provided
> page reporting.
> 
>                                       unpatched  patched
>   arena allocation attempts                  70       70
>   arena allocation failures                  70       70
>   shuffle calls from rollback                 9        0
>   get_random_u64() calls from shuffle         1        0
>   reporting notifications                    12        0
>   delayed-work queues                         5        0
> 
> Both guests powered off without a diagnostic. This confirms that an in-tree
> caller reaches the optional operations. It did not reproduce a deadlock or
> lockdep warning.
> 
> The upstream form applies to v7.3-rc1, mainline and next-20261002. The
> FPI_TRYLOCK backport applies to v6.15 through v7.2. mm/page_alloc.o builds
> on v6.18 and v7.2.7. Stable backports were not runtime tested.
> 
>  mm/page_alloc.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 12fac9084c48..3e21dc90b858 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -89,7 +89,10 @@ typedef int __bitwise fpi_t;
>   */
>  #define FPI_TO_TAIL		((__force fpi_t)BIT(1))
>  
> -/* Free the page without taking locks. Rely on trylock only. */
> +/*
> + * Request the no-lock free path. Use trylocks and skip optional operations
> + * which can take other locks or queue work.
> + */
>  #define FPI_NOLOCK		((__force fpi_t)BIT(2))
>  
>  /* free_pages_prepare() has already been called for page(s) being freed. */
> @@ -1013,7 +1016,7 @@ static inline void __free_one_page(struct page *page,
>  
>  	if (fpi_flags & FPI_TO_TAIL)
>  		to_tail = true;
> -	else if (is_shuffle_order(order))
> +	else if (!(fpi_flags & FPI_NOLOCK) && is_shuffle_order(order))

is_shuffle_order() should be checked first as it has
CONFIG_SHUFFLE_PAGE_ALLOCATOR=n compole-time false variant, and static key.

>  		to_tail = shuffle_pick_tail();
>  	else
>  		to_tail = buddy_merge_likely(pfn, buddy_pfn, page, order);
> @@ -1021,7 +1024,7 @@ static inline void __free_one_page(struct page *page,
>  	__add_to_free_list(page, zone, order, migratetype, to_tail);
>  
>  	/* Notify page reporting subsystem of freed page */
> -	if (!(fpi_flags & FPI_SKIP_REPORT_NOTIFY))
> +	if (!(fpi_flags & (FPI_SKIP_REPORT_NOTIFY | FPI_NOLOCK)))

Maybe add a comment why we check FPI_NOLOCK too?

>  		page_reporting_notify_free(order);
>  }
>  

