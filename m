Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792750713;
	b=bA+hg9tujxPLbKLMhunLQIZKhXqaVQ+Hrql9bkQ0mCw8LlB6Ay+adIGnWXgdftUE3oM6
	 3UE7suAjM66QO4brD+VEePPYkJ0+AQrp10ZUp+fUUIB51dJJnuO1YTq5jps2SwDrVTkji
	 YXduq8b6FTaaiW0fM0Kt893lBx2TkXlv3fIdWrebVB7FjxGrNaaQdlmU26SP/qgxoOFfd
	 rCRwNUdJb1tPgk0gTUFU3o/A1wtSQRp7lviN1DuFtima7KRlgkWQxntq+7mY7a5aXR9ob
	 YZVXTmvyDSo7aZBPT8POmMNUdpU8xGLNycTlDKFTrQEZzll5xI1sT9sJFMANzr6vXTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792750713;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=48rUw1Z2YCN0d1r+igM4P0aPkMs18zYpkWGEVt5x0Lg=;
	b=fdkT9hLKVbfg6s/Vw7wzDuqESHdjfV7lHrKYOJYcdP/A2DJYwEU7kjrJGaTYXJeZizyb
	 DwGbtguG8P1pJK33dW+QUODJRmwTevQB/YJHdZpVy5kHmGs0IcbS6Dmn1JOMY52dVU9HI
	 f5iJ5sVht2y507F2+tXn1ZUpf6Vmn04DoRx2Pxi3j0rhzrWItIbNXCSI67uisCoVplkLw
	 k5dq/x1D6+EIltToQ10WeqezJ5GsBezURudGAgfy2cCFv6LpowbIdrJTZ32Og3kFWS3JO
	 yHM4L1NmQt0PqzKLD6OfW5BJpxCoUS+63tIyNWa0avdDzoYr3RGBDiWn66XqxvabwlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Gv0tPwNP;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CCD606A32E;
	Fri, 23 Oct 2026 10:18:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79CCD606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Gv0tPwNP
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49A5A1650;
	Fri, 23 Oct 2026 03:18:27 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA9CC3F7B4;
	Fri, 23 Oct 2026 03:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792750710; bh=rDCKGdRiz166rbp3L1GqdW0EbXoka1CMQiZb1poZNJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gv0tPwNP8G2Bw0xRprgdfHjdFBGNFMpk/hG8nosXDB1w7Glh9RBzUtz+iqZOceuqt
	 mV0LBePmBjv5oLWjuqGK9bhC+ApU8fxvizU/c3YNVk8ks5ke0P3dwGpCmBZ76NwIbf
	 fVBicOBhEo6p+0BCv8JfVzLhwHxKLSqtRnu3CS3g=
Date: Fri, 23 Oct 2026 15:48:27 +0530
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: Muchun Song <songmuchun@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Oscar Salvador <osalvador@suse.de>, 
	Dave Hansen <dave.hansen@intel.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org, 
	linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH v3 1/4] mm: fix missing page-table destructor in
 pagetable_free()
Message-ID: <s5wpe6iiidy6eo5lqs5zqut3d2of3erbxz6xofah4i4n56qxdn@r7vjivchqfil>
References: <20261023063428.3658761-1-songmuchun@bytedance.com>
 <20261023063428.3658761-2-songmuchun@bytedance.com>
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
In-Reply-To: <20261023063428.3658761-2-songmuchun@bytedance.com>

On Fri, Oct 23, 2026 at 02:34:25PM +0800, Muchun Song wrote:
> Since commit 49f599666420 ("mm: call ctor/dtor for kernel PTEs"),
> pte_alloc_one_kernel() runs the page-table constructor for kernel PTE
> tables.
> 
> HVO (HugeTLB Vmemmap Optimization) uses pte_alloc_one_kernel() when
> splitting a PMD. Restoring the vmemmap backing pages does not collapse
> the PTE table, so a later memory hot-remove eventually frees it through
> pagetable_free() on x86-64. That releases the page without running the
> matching destructor and leaves NR_PAGETABLE elevated.
> 
> Make pagetable_free() the common free-side primitive for page-table
> pages. It checks PageTable() and runs the destructor only when the
> constructor state is still present. Callers that explicitly ran
> pagetable_dtor() have already cleared PageTable(), so they are not
> destructed twice; pages that never ran a constructor are freed directly.
> 
> Fixes: 49f599666420 ("mm: call ctor/dtor for kernel PTEs")
> Cc: stable@vger.kernel.org # bf9e4e30f353: x86/mm: use pagetable_free()
> Cc: stable@vger.kernel.org # 39406c05f8f1: x86/mm: Fix freeing of PMD-sized vmemmap pages
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
> Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
> Acked-by: Dave Hansen <dave.hansen@intel.com>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
> v3:
> - Explain why pagetable_free() does not run the destructor twice
>   (requested by Kevin Brodsky)
> - Add x86 stable prerequisites (suggested by
>   Jose A. Perez de Azpillaga)
> - Collect Acked-by from Dave Hansen and David Hildenbrand
> - Collect Reviewed-by from Jose A. Perez de Azpillaga and Kevin
>   Brodsky
> 
> v2:
> - Move destructor handling from x86 into pagetable_free() (suggested by
>   David Hildenbrand)
> - Trim and update the commit message (requested by Dave Hansen)
> ---
>  include/linux/mm.h | 37 ++++++++++++++++++++-----------------
>  1 file changed, 20 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index dd09c438fa23..466875c5908b 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3812,23 +3812,6 @@ static inline void pagetable_free_kernel(struct ptdesc *pt)
>  	__pagetable_free(pt);
>  }
>  #endif
> -/**
> - * pagetable_free - Free pagetables
> - * @pt:	The page table descriptor
> - *
> - * pagetable_free frees the memory of all page tables described by a page
> - * table descriptor and the memory for the descriptor itself.
> - */
> -static inline void pagetable_free(struct ptdesc *pt)
> -{
> -	if (ptdesc_test_kernel(pt)) {
> -		ptdesc_clear_kernel(pt);
> -		pagetable_free_kernel(pt);
> -	} else {
> -		__pagetable_free(pt);
> -	}
> -}
> -
>  #if defined(CONFIG_SPLIT_PTE_PTLOCKS)
>  #if ALLOC_SPLIT_PTLOCKS
>  void __init ptlock_cache_init(void);
> @@ -3921,6 +3904,26 @@ static inline void pagetable_dtor(struct ptdesc *ptdesc)
>  	lruvec_stat_sub_folio(folio, NR_PAGETABLE);
>  }
>  
> +/**
> + * pagetable_free - Free pagetables
> + * @pt:	The page table descriptor
> + *
> + * pagetable_free frees the memory of all page tables described by a page
> + * table descriptor and the memory for the descriptor itself.
> + */
> +static inline void pagetable_free(struct ptdesc *pt)
> +{
> +	if (PageTable(ptdesc_page(pt)))
> +		pagetable_dtor(pt);
> +
> +	if (ptdesc_test_kernel(pt)) {
> +		ptdesc_clear_kernel(pt);
> +		pagetable_free_kernel(pt);
> +	} else {
> +		__pagetable_free(pt);
> +	}
> +}
> +
>  static inline void pagetable_dtor_free(struct ptdesc *ptdesc)
>  {
>  	pagetable_dtor(ptdesc);
> -- 
> 2.54.0
> 
