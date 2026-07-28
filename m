Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAC72D978A;
	Tue, 28 Jul 2026 13:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785244475; cv=none; b=unGXkN00OIqcDXpLaVJHHH+3w2xjqHZEVEwCq7cHSFFPLxCFriIFFMqzgNUrfk9cs4+jhnVlYW+Rx+tdcnrYOg2OXImgr5GSV+Ld3PzHg0/19PMvNofibZ+kWcpCHg0Ek4P9okdQDJdmdwW+BNLW0DyxChE1UAm7EzNXlFoMjEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785244475; c=relaxed/simple;
	bh=2b/dbxAbTzCv1z8r8K5TbN7iQcHN42VAbOiy8xKTR3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H8srZ0EcDgHYaRRidqyTNX4QLp/lfHTpR2Bxxs9kC5hf4AabFHiqXrnIj1UpWNKUst7Q/3uZ23wZW9bHt5S8O692+PmXoeNeW2TeUYLOLR5+3pkGqnVahNoSsOKCckWhznHYXcm7tzXFB/okyrrh+AXVwFsvZ6xPCDP+3EkROyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7X7QH35; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7X7QH35"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 716651F000E9;
	Tue, 28 Jul 2026 13:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785244473;
	bh=qbwU4aSdbq572P+LX2wQCxTtLNDpkBnloEYwPXL7Nuw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=C7X7QH35TPBuHWnrxp28qYBp1ERkpdC+j6p6/YnPX6KoI8ok44xMwehXB+oYTg9wb
	 T2DRRcyerAS7PJYbbrcywQx0IdywT2g9PjPXHK3ADRvMbpkITagEvtusZ3UKg5ootL
	 DNadL4WKr5tna0W1aHqEIOXNKy3RQFpIfADJHqzhTku9kWp0/uAHqKqHVyyZbhZr9/
	 gXBtJMHBUwZh26cYwpKYW1saSGd9AQ28K3P11m+Hqyb7vJ3SujfyJQ8EJh9sgeKeUN
	 nig2R1ErWthg0/VZN9Jcgnxq73Fp4h7scnY5M6x7RtzPbEp7CSfxbmSOMqTqh59Laa
	 fz6OASSuBbCtA==
Date: Tue, 28 Jul 2026 14:14:12 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, David CARLIER <devnexen@gmail.com>, 
	David Hildenbrand <david@kernel.org>, Ingo Molnar <mingo@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Juergen Gross <jgross@suse.com>, Kevin Tian <kevin.tian@intel.com>, 
	Kiryl Shutsemau <kas@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@kernel.org>, 
	Toshi Kani <toshi.kani@hpe.com>, Vishal Moola <vishal.moola@gmail.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Will Deacon <will@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 3/5] x86/mm/pat: acquire init_mm read lock on attribute
 change to avoid UAF
Message-ID: <amirDCXprZuCnHF9@lucifer>
References: <20260728-cpa-fixes-v1-0-2ed2352300b3@kernel.org>
 <20260728-cpa-fixes-v1-3-2ed2352300b3@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728-cpa-fixes-v1-3-2ed2352300b3@kernel.org>

On Tue, Jul 28, 2026 at 04:07:46PM +0300, Mike Rapoport wrote:
> From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
>
> A previous commit protected us against races between ptdump and CPA
> collapse, however one still exists between attribute changes and collapse
> as reported by Denis V. Lunev (linked).
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
> With the mmap write lock taken on init_mm over CPA collapse, we can now
> resolve this race by acquiring an mmap read lock on init_mm over
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
>   __change_page_attr_set_clr().
> * __set_memory_enc_pgtable() - operates on the direct mapping and (via
>   __vmbus_establish_gpadl()) the vmalloc mapping space.
> * __set_pages_[n]p() - called by set_direct_map_[invalid, default,
>   valid]_noflush(), __kernel_map_pages() - operates on the direct map.
> * kernel_[un]map_pages_in_pgd() - operates on EFI ranges.
>
> This work is based upon Denis V. Lunev's excellent analysis of the bug with
> gratitude.
>
> Link: https://lore.kernel.org/all/20260626163213.2284080-1-den@openvz.org/
> Fixes: 41d88484c71c ("x86/mm/pat: restore large ROX pages after fragmentation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  arch/x86/mm/pat/set_memory.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
>
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index 4ba16d72a535..26131ecc0e1c 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -50,7 +50,8 @@ struct cpa_data {
>  	unsigned int	flags;
>  	unsigned int	force_split		: 1,
>  			force_static_prot	: 1,
> -			force_flush_all		: 1;
> +			force_flush_all		: 1,
> +			init_mm_read_locked	: 1;
>  	struct page	**pages;
>  };
>
> @@ -435,8 +436,6 @@ static void __cpa_collapse_large_pages(struct cpa_data *cpa)
>  	int collapsed = 0;
>  	int i;
>
> -	cpa_lock();
> -
>  	if (cpa->flags & (CPA_PAGES_ARRAY | CPA_ARRAY)) {
>  		for (i = 0; i < cpa->numpages; i++)
>  			collapsed += collapse_large_pages(__cpa_addr(cpa, i),
> @@ -450,10 +449,8 @@ static void __cpa_collapse_large_pages(struct cpa_data *cpa)
>  			collapsed += collapse_large_pages(addr, &pgtables);
>  	}
>
> -	if (!collapsed) {
> -		cpa_unlock();
> +	if (!collapsed)
>  		return;
> -	}
>
>  	flush_tlb_all();
>
> @@ -461,8 +458,6 @@ static void __cpa_collapse_large_pages(struct cpa_data *cpa)
>  		list_del(&ptdesc->pt_list);
>  		pagetable_free(ptdesc);
>  	}
> -
> -	cpa_unlock();
>  }
>
>  static void cpa_collapse_large_pages(struct cpa_data *cpa)
> @@ -1270,8 +1265,13 @@ static int split_large_page(struct cpa_data *cpa, pte_t *kpte,
>  	struct ptdesc *ptdesc;
>
>  	cpa_unlock();
> +	if (cpa->init_mm_read_locked)
> +		mmap_read_unlock(&init_mm);
>  	ptdesc = pagetable_alloc(GFP_KERNEL, 0);
> +	if (cpa->init_mm_read_locked)
> +		mmap_read_lock(&init_mm);
>  	cpa_lock();

Yeah this retains the correct ordering (sem -> spinlock) so LGTM!

> +
>  	if (!ptdesc)
>  		return -ENOMEM;
>
> @@ -2139,7 +2139,11 @@ static int change_page_attr_set_clr(unsigned long *addr, int numpages,
>  	cpa.curpage = 0;
>  	cpa.force_split = force_split;
>
> -	ret = __change_page_attr_set_clr(&cpa, 1);
> +	/* Avoid race with concurrent CPA collapse. */
> +	cpa.init_mm_read_locked = true;
> +	scoped_guard(mmap_read_lock, &init_mm)
> +		ret = __change_page_attr_set_clr(&cpa, 1);
> +	cpa.init_mm_read_locked = false;
>
>  	/*
>  	 * Check whether we really changed something:
>
> --
> 2.53.0
>

Cheers, Lorenzo
