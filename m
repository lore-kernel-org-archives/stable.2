Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795028419;
	b=nUpDSricHXLWKawlSzEe6DO4huZrXqXaAE/HB4/n65xPVfiQouoRzc6yF0jQfkb1XFL3
	 D7HxD9KYisEDd9kaF1S3VQ/A9J9oy/uMgEDdKVqXnK1ZM3rxUIWOvlFYaaO4wEMr6qi4D
	 UWZVzWJ3t4igSjc1vUukMov2burbLR7DWC+m7mwt47LrXl6l/m1oqzF4DIC/ZSdeOsTFs
	 duTKHzVhvbf45vumxnwIRBgR4Jmt0tKRLW64oMw5Kzvfi4ZheR3UH6Gz3iNhoWvXaY6Mh
	 zdOqk/YpxtbVTwL3CfjZYR2AgVn2ZjCuBs2VjsC7y0rtZFvpnQ9qr5hIfAHiQDrd0xQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795028419;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Os+tb29jNMnP2oCpww6m9nFCa+COo9vLvWye7mQzAMM=;
	b=sbbqNKyloWBQnHr6lE/v/kYNMoieLQP25wftwjKLJ0Mm3+4mlHnBxXEEz+JuzDiFQHx4
	 egDOT9zLwaAkI5b4h9gGzFOj+g1koi8Q4JM6+bFHF7vRU9Q/5yVuaLPibKZ1HHGS23W60
	 +0c3qTqUmLMrfDvQzkorNzrieGVYmys5oyqbAzzIOo1xa9mncRoXV7RrGgt06MWkKmGQg
	 2lhadqWW23n5hxD3SDCy9IDc4kSdb/1Y57m2X6rDZaGXIt6oJK9MkZidSIaX8885oKYWf
	 OsKU+O5TJDtFcjCJeqPauJeNVXsB+DgfTXM0R3tcWeHzEgrgFe+u+GbCWU5fn8Qj9lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oU4lsZmV;
	arc=none smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B316B606A331
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 19:00:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B316B606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oU4lsZmV
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b8784a3284so598717a12.1
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 11:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795028417; x=1795633217; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Os+tb29jNMnP2oCpww6m9nFCa+COo9vLvWye7mQzAMM=;
        b=oU4lsZmV1PkgL9roaXPM478SlLBUgSwP48rs0SQBrBvN1LckftOztWeyKPg1IhPphV
         SZZNZlsHFwmkP5NEvknW72NWgumbp0yYjOiFvHUMW65EaARDkAZNMZZLQpavIjGtcs9X
         LWTo5bljzw7qGs0Oj+/P7M0QYpfl+NF5Sn/jd39QHp8DvPZntucdO9fk3ws72rDlziwS
         zksmItPHTsX+xPYxoeFSzKTXFaelck2itKi6RBGrerjXKFDnDq3hKruQxuaKwYvJOI46
         MdM1Ofceo0bOcDnc1w6thFb1Xb1DQvOkvAWfMBxBw8xJ+zgoeiHxrlt0pS+CVli3iB0n
         uNuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795028417; x=1795633217;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Os+tb29jNMnP2oCpww6m9nFCa+COo9vLvWye7mQzAMM=;
        b=RlqHRqXZmC2Aq98S91i0gQSkhA4+k2DYi4uziE3Nl36Zr6Zg+OAXJsSWII182GjKaA
         ZlVyDAebsBMUaVYrYgC4ebqY+innk/rWPdJso6vjaHAfBpCUlF2vZLiONDUcnLE+FhZ8
         NCogiUGTzAMcaYC187/ipYcv/H0g8xrfQg9XQAP92Yk8ktA2gQzTaPXli6533QAmXd0V
         +AHIg7xaUmcyTa0F7TtUalFx+M8qUvWEsv+RHLaM2zUOn3vOo97hBLdIG+tQAP+u793c
         aImC+FQ0JVFR5PFrjr5rGpxV1x3Qh08BtekM6LIyQ6x56uJja6KEnF4Z4GKaNQpGyoYw
         xVKw==
X-Forwarded-Encrypted: i=1; AL+hErFR2uQK8XVQykCh++e/Ipfq4Q4ZZ/OSPvzroJLQ/Y9XqNb60C6jeOry6o46rDi1CQutaofIWBg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+dzdl2kOj1agZBgq7dBGcn9Yh7fy73hwGVUteE+pNLdPVBlJ0+
	P+0N9cQahXs1FR0/z/4Rd7x78mGbqeVbdSs5QQDqQ2dxP52wvejNFOFL
X-Gm-Gg: AYBFou20PH3YgCSkF/yQQzhRhMZ/XOwjJigL/nEZc5r+GMGxFrczFx1oguHKyHi4IXi
	I2xPE+PkairN46+Pty1mZSMa2gDVskPtgLIeoVi5WTSQLuCO9fTG+wp6vuWttRZY9cJuoIse7pv
	0EdZNk9kMkmUAwH6LLlwXuJll5kgtPVt3jF+WQ+ntf9LQwkvUBrhciTvmuLKpJLYBRTfWKi7Yrw
	ZQaVob3zB3utqbqMuE+xHSA0gD2Rjgnkc1ytMWm7oaboJ5HExQ+zK6wUZgEjtF5IWm+7XXtGCBn
	EpDqKTfsDUXseNNvhnE0pdbJanQvQOXnpBqbjQifPm1K1UuGXGzCElaD6uJ9hM1pI0DwZKcVeuH
	djpAXSJJJ3sRU4olKdfI3SW2WA0gaEojIEQ0Omtlf/JiwV/mFLbbGiVn17SOh4ImBTJwfYaRTMa
	0GhSNNrxQqMu2iqbK0LLwlcwAQ4OtNhHQBPnEhP0ZcPM1rK0hWpOq+2bWEJQLfFRVYu6lubnEfc
	4PCEWOAejuy1PVYDOU0eqc9gmTEbMj/HViE0fPTzUpwO9P4FDX6A7Ywkw7kkUBdVZYx/johgvT7
	kxB3EZHjS713L+Q=
X-Received: by 2002:a05:6402:4409:b0:6b8:8815:ffcc with SMTP id 4fb4d7f45d1cf-6b88816003amr2894326a12.18.1795028416871;
        Wed, 18 Nov 2026 11:00:16 -0800 (PST)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b88a1eb813sm1357442a12.26.2026.11.18.11.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 11:00:16 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Wed, 18 Nov 2026 20:00:13 +0100
To: Hao Ge <hao.ge@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>,
	Uladzislau Rezki <urezki@gmail.com>, Dev Jain <dev.jain@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
	linux-mm@kvack.org, stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v5 01/11] mm/vmalloc: skip cond_resched() in the vmap
 unmap paths when atomic
Message-ID: <av31vR89G64KJHpj@milan>
References: <20261116071325.263682-1-hao.ge@linux.dev>
 <20261116071325.263682-2-hao.ge@linux.dev>
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
In-Reply-To: <20261116071325.263682-2-hao.ge@linux.dev>

On Mon, Nov 16, 2026 at 03:13:15PM +0800, Hao Ge wrote:
> The vmap failure paths can be reached with GFP_ATOMIC or GFP_NOWAIT
> since commit b186a94227b7 ("kmsan: remove hard-coded GFP_KERNEL
> flags") and commit 8da89ba18ed4 ("mm/vmalloc: handle non-blocking
> GFP in __vmalloc_area_node()"), so an undo of a partially installed
> mapping may have to run in atomic context, where the cond_resched()
> in vunmap_pmd_range() cannot schedule.
> 
> Give __vunmap_range_noflush() and kmsan_vunmap_range_noflush() a
> can_resched argument and skip the cond_resched() when it is false.
> The existing callers are on sleepable paths and pass true, so nothing
> changes for them.
> 
> Fixes: 47ebd0310e89 ("mm: kmsan: handle alloc failures in kmsan_vmap_pages_range_noflush()")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/sashiko-outbox-178439@kernel.org/
> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> ---
>  include/linux/kmsan.h |  8 ++++++--
>  mm/kmsan/hooks.c      | 14 +++++++++-----
>  mm/vmalloc.c          | 24 ++++++++++++++----------
>  mm/vmalloc.h          |  3 ++-
>  4 files changed, 31 insertions(+), 18 deletions(-)
> 
> diff --git a/include/linux/kmsan.h b/include/linux/kmsan.h
> index 7da9fd506b39..0016c032d1e7 100644
> --- a/include/linux/kmsan.h
> +++ b/include/linux/kmsan.h
> @@ -150,11 +150,14 @@ int __must_check kmsan_vmap_pages_range_noflush(unsigned long start,
>   * kmsan_vunmap_kernel_range_noflush() - Notify KMSAN about a vunmap.
>   * @start: start of vunmapped range.
>   * @end:   end of vunmapped range.
> + * @can_resched: whether the unmap walk may call cond_resched(); pass
> + * false from atomic context.
>   *
>   * KMSAN unmaps the contiguous metadata ranges created by
>   * kmsan_map_kernel_range_noflush().
>   */
> -void kmsan_vunmap_range_noflush(unsigned long start, unsigned long end);
> +void kmsan_vunmap_range_noflush(unsigned long start, unsigned long end,
> +				bool can_resched);
>  
>  /**
>   * kmsan_ioremap_page_range() - Notify KMSAN about a ioremap_page_range() call.
> @@ -355,7 +358,8 @@ static inline int __must_check kmsan_vmap_pages_range_noflush(
>  }
>  
>  static inline void kmsan_vunmap_range_noflush(unsigned long start,
> -					      unsigned long end)
> +					      unsigned long end,
> +					      bool can_resched)
>  {
>  }
>  
> diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
> index a706666db097..69008b085658 100644
> --- a/mm/kmsan/hooks.c
> +++ b/mm/kmsan/hooks.c
> @@ -136,10 +136,13 @@ static unsigned long vmalloc_origin(unsigned long addr)
>  						 KMSAN_META_ORIGIN);
>  }
>  
> -void kmsan_vunmap_range_noflush(unsigned long start, unsigned long end)
> +void kmsan_vunmap_range_noflush(unsigned long start, unsigned long end,
> +				bool can_resched)
>  {
> -	__vunmap_range_noflush(vmalloc_shadow(start), vmalloc_shadow(end));
> -	__vunmap_range_noflush(vmalloc_origin(start), vmalloc_origin(end));
> +	__vunmap_range_noflush(vmalloc_shadow(start), vmalloc_shadow(end),
> +			       can_resched);
> +	__vunmap_range_noflush(vmalloc_origin(start), vmalloc_origin(end),
> +			       can_resched);
>  	flush_cache_vmap(vmalloc_shadow(start), vmalloc_shadow(end));
>  	flush_cache_vmap(vmalloc_origin(start), vmalloc_origin(end));
>  }
> @@ -168,8 +171,9 @@ static void kmsan_iounmap_pages(unsigned long start, unsigned long end)
>  		if (origin)
>  			__free_pages(origin, KMSAN_IOREMAP_META_ORDER);
>  	}
> -	__vunmap_range_noflush(shadow_start, shadow_end);
> -	__vunmap_range_noflush(origin_start, origin_end);
> +	/* ioremap metadata mappings are always GFP_KERNEL, so resched is safe. */
> +	__vunmap_range_noflush(shadow_start, shadow_end, true);
> +	__vunmap_range_noflush(origin_start, origin_end, true);
>  	flush_tlb_kernel_range(shadow_start, shadow_end);
>  	flush_tlb_kernel_range(origin_start, origin_end);
>  }
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index ccaf158c5b7f..3c0d9e69b886 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -429,7 +429,7 @@ static void vunmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
>  }
>  
>  static void vunmap_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
> -			     pgtbl_mod_mask *mask)
> +			     pgtbl_mod_mask *mask, bool can_resched)
>  {
>  	pmd_t *pmd;
>  	unsigned long next;
> @@ -451,12 +451,14 @@ static void vunmap_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
>  			continue;
>  		vunmap_pte_range(pmd, addr, next, mask);
>  
> -		cond_resched();
> +		/* The undo path may run in atomic context. */
> +		if (can_resched)
> +			cond_resched();
>  	} while (pmd++, addr = next, addr != end);
>  }
>  
>  static void vunmap_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
> -			     pgtbl_mod_mask *mask)
> +			     pgtbl_mod_mask *mask, bool can_resched)
>  {
>  	pud_t *pud;
>  	unsigned long next;
> @@ -476,12 +478,12 @@ static void vunmap_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
>  		}
>  		if (pud_none_or_clear_bad(pud))
>  			continue;
> -		vunmap_pmd_range(pud, addr, next, mask);
> +		vunmap_pmd_range(pud, addr, next, mask, can_resched);
>  	} while (pud++, addr = next, addr != end);
>  }
>  
>  static void vunmap_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
> -			     pgtbl_mod_mask *mask)
> +			     pgtbl_mod_mask *mask, bool can_resched)
>  {
>  	p4d_t *p4d;
>  	unsigned long next;
> @@ -496,7 +498,7 @@ static void vunmap_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
>  
>  		if (p4d_none_or_clear_bad(p4d))
>  			continue;
> -		vunmap_pud_range(p4d, addr, next, mask);
> +		vunmap_pud_range(p4d, addr, next, mask, can_resched);
>  	} while (p4d++, addr = next, addr != end);
>  }
>  
> @@ -512,7 +514,8 @@ static void vunmap_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
>   *
>   * This is an internal function only. Do not use outside mm/.
>   */
> -void __vunmap_range_noflush(unsigned long start, unsigned long end)
> +void __vunmap_range_noflush(unsigned long start, unsigned long end,
> +			    bool can_resched)
>  {
>  	unsigned long next;
>  	pgd_t *pgd;
> @@ -527,7 +530,7 @@ void __vunmap_range_noflush(unsigned long start, unsigned long end)
>  			mask |= PGTBL_PGD_MODIFIED;
>  		if (pgd_none_or_clear_bad(pgd))
>  			continue;
> -		vunmap_p4d_range(pgd, addr, next, &mask);
> +		vunmap_p4d_range(pgd, addr, next, &mask, can_resched);
>  	} while (pgd++, addr = next, addr != end);
>  
>  	if (mask & ARCH_PAGE_TABLE_SYNC_MASK)
> @@ -536,8 +539,9 @@ void __vunmap_range_noflush(unsigned long start, unsigned long end)
>  
>  void vunmap_range_noflush(unsigned long start, unsigned long end)
>  {
> -	kmsan_vunmap_range_noflush(start, end);
> -	__vunmap_range_noflush(start, end);
> +	/* The unmap paths are sleepable, keep the resched point. */
> +	kmsan_vunmap_range_noflush(start, end, true);
> +	__vunmap_range_noflush(start, end, true);
>  }
>  
>  /**
> diff --git a/mm/vmalloc.h b/mm/vmalloc.h
> index d8372a4f65c4..4ec114a75f04 100644
> --- a/mm/vmalloc.h
> +++ b/mm/vmalloc.h
> @@ -44,6 +44,7 @@ int __must_check __vmap_pages_range_noflush(unsigned long addr,
>  
>  void vunmap_range_noflush(unsigned long start, unsigned long end);
>  
> -void __vunmap_range_noflush(unsigned long start, unsigned long end);
> +void __vunmap_range_noflush(unsigned long start, unsigned long end,
> +			    bool can_resched);
>  
>  #endif /* __MM_VMALLOC_H */
> -- 
> 2.25.1
> 
This looks good to me. I am not sure if passing gfp_mask is better
here since it is only for checking if-allow-blocking.

--
Uladzislau Rezki
