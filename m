Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795064535;
	b=vNPv0TW2kNP0s3j6dGRZ39vL/qhKL8bUbxXvPAZ6UXb/KEODC/de6TzQM3NtNqSlckvS
	 zMmM8B7mHgMhhY2OMoErxn6TL+E4yiQ80EubItl7KZ9aa8KhFU64R/n+iFxCNwYzrMCjX
	 Dr242QNrC2yOlr2ixrYTR/SwWfu7pTNLpusz1HBOvQucsL5yzufHGQ1H68BSEHxeYTZRS
	 g75NcwbJPVFFHL6jl2lQyM9qvBDq1GxctgCaFUeCdBLraqAAAHZHXgM+XCnNgyZh9cdgC
	 quUfGsBLDqUnkNbnNjDeSg4495ZsADqQamELSIo9b+KMlzSLPNLYfZOLBh8qUflPdsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795064535;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=jJBUM15Sc5zBD7XRTeaoknfQYVt19ddrgNRFj5F3dLA=;
	b=B6Mqoi+36ccU1lTslCKjIcy6eFvH72shgHDFqtP2u1pumA6ZSl9ujR7Vtn4Pnfz/9Hpz
	 AX2WvsIPn4lsR2Y0O4fR01UQMdN+bopZqluqf+R+gudj0jQ+Bkgsxrb1TYJduSWVVHxtJ
	 mexykC7sDdL4XQ9XWR56lbNleFMZQa/bggvtmkItjW0oGmxohEtPK8OYTFuB7+sijikdm
	 gylJiuh8sSRUgKEDNNGC1tDIyIPM85xFvN6UoCl5zjE/FCqt/4WZPmiiW87soakSX2V6Q
	 J7vNVWOSOaw/E2I6/SEaqNMUQKdlbPSbKsdkb2jezhVy99Kzc8OBVMghfVPPUgD1+Kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=G3ybgh1Q;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42693606A320;
	Thu, 19 Nov 2026 05:02:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42693606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=G3ybgh1Q
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C582152B;
	Wed, 18 Nov 2026 21:02:10 -0800 (PST)
Received: from [10.163.128.149] (unknown [10.163.128.149])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 94F373F882;
	Wed, 18 Nov 2026 21:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795064533; bh=C51ekQu1v/IBwv42647Jb7sIkXDgjTDlZAAficv0zA8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=G3ybgh1QJB7U+Fd3eUN6gO7X14eGYD4hnCkyrAcdcbJx5sLBByQer++m9ddvSYfoT
	 E9+y8dCB1Qcx0Ux3HVuL7uHmNhXDx3F64qgpQb1LVBQEiIVdWOVw4vUdRxs7ewux73
	 7DY0Vi9rrnXWzMRIUh5VTwY4swxY18D7KnRFoldA=
Message-ID: <1020e36e-83bb-407b-8a6b-7669f04c26c3@arm.com>
Date: Thu, 19 Nov 2026 10:32:03 +0530
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
Subject: Re: [PATCH v5 01/11] mm/vmalloc: skip cond_resched() in the vmap
 unmap paths when atomic
To: Hao Ge <hao.ge@linux.dev>, Suren Baghdasaryan <surenb@google.com>,
 Uladzislau Rezki <urezki@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, Dennis Zhou <dennis@kernel.org>,
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-mm@kvack.org, stable@vger.kernel.org,
 Sashiko <sashiko-bot@kernel.org>
References: <20261116071325.263682-1-hao.ge@linux.dev>
 <20261116071325.263682-2-hao.ge@linux.dev>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20261116071325.263682-2-hao.ge@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 16/11/26 12:43 pm, Hao Ge wrote:
> The vmap failure paths can be reached with GFP_ATOMIC or GFP_NOWAIT
> since commit b186a94227b7 ("kmsan: remove hard-coded GFP_KERNEL
> flags") and commit 8da89ba18ed4 ("mm/vmalloc: handle non-blocking
> GFP in __vmalloc_area_node()"), so an undo of a partially installed

You mention this commit too, implying that vunmap_range_noflush() can
be called in atomic context right now, but in this patch in
vunmap_range_noflush() you pass 'true' unconditionally to
__vunmap_range_noflush()?

Can you give me the call chain existing in current kernel which makes
this bug trigger? In case it does not exist but is only triggered when
you add the rollback code later, then this patch is not fixing a bug.


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

