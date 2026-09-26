Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C955A41BA69;
	Sat, 26 Sep 2026 10:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790419311; cv=none; b=iVo30I+XquVX4Mpl8IotzG2R2p1UiiQNyS1dmyeVEp0CQ3hjZ0VD00bcHsoTFgL/WA+wmfVO5ste1TWYLEOuZ41i1G+mJDVwMkJiffKdq5Cs7NvfIZgb3tkZoxTvGrsPTM3HkVevbPzcWO784Eg0/bA4mIMqwXZbX039g/Lrtcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790419311; c=relaxed/simple;
	bh=ko5kc8GpaxfX6EdcdK7C5rIIul58e3eUXGk4SYWbUzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JDj/d4kGBVHqPe5zRzdfUW0IfnS/T4NdeDwJEia3RQqfle0XOqLvL2sGLdg8xcNNzD7v8kOdUXZlq31ERPN8S9RB/CrBJhbSID+uvcg6jfBx+NbZyLXIyYxLGhVNqbP8wvwvQVtmBfg707Ni5/rArau/rcjgcTO3wIZJWtDIwbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1xAP4O-0007LD-00; Sat, 26 Sep 2026 11:51:48 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
	id F3309C0C0A; Sat, 26 Sep 2026 11:35:58 +0200 (CEST)
Date: Sat, 26 Sep 2026 11:35:58 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Orgad Shaneh <orgads@gmail.com>
Cc: linux-mips@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, osalvador@suse.de,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] MIPS: mm: align hugetlb mappings in
 arch_get_unmapped_area()
Message-ID: <areR_hMi-gEyUQ-0@alpha.franken.de>
References: <20260915071329.15125-1-orgads@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915071329.15125-1-orgads@gmail.com>

On Tue, Sep 15, 2026 at 07:13:24AM +0000, Orgad Shaneh wrote:
> Since hugetlb mappings were made to go through the architecture's
> arch_get_unmapped_area{,_topdown}(), every architecture that implements
> those has to align hugetlb files itself. The generic implementation and
> loongarch do it with huge_page_mask_align(); MIPS was left out.
> 
> A non-MAP_FIXED mmap() of a hugetlbfs file therefore returns an address
> that is only SHMLBA aligned, and the kernel then installs 2 MB PMDs for
> a VMA that starts in the middle of a PMD. The consequences on an
> Octeon (CN63XX) board running a process that links libhugetlbfs with
> HUGETLB_ELFMAP=R and HUGETLB_MORECORE=yes, all within a minute of
> start: the neighbouring 4 KB page table is clobbered, the TLB ends up
> with overlapping entries ("Caught Machine Check exception - caused by
> multiple matching entries in the TLB"), process exit trips
> BUG_ON(start & ~huge_page_mask(h)) in __unmap_hugepage_range(), and
> freed pages leak into unrelated kernel structures (oopses in the irq
> maple tree, in pte_offset_map, ...).
> 
> Do what loongarch does in commit 3109d5ff484b ("LoongArch: Set hugetlb
> mmap base address aligned with pmd size"): when the file is a hugetlb
> file, use its page mask as the search alignment instead of the cache
> colour mask.
> 
> Fixes: 7bd3f1e1a9ae ("mm: make hugetlb mappings go through mm_get_unmapped_area_vmflags")
> Cc: stable@vger.kernel.org # 6.13+
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Orgad Shaneh <orgads@gmail.com>
> ---
> diff --git a/arch/mips/mm/mmap.c b/arch/mips/mm/mmap.c
> --- a/arch/mips/mm/mmap.c
> +++ b/arch/mips/mm/mmap.c
> @@ -9,6 +9,7 @@
>  #include <linux/compiler.h>
>  #include <linux/elf-randomize.h>
>  #include <linux/errno.h>
> +#include <linux/hugetlb.h>
>  #include <linux/mm.h>
>  #include <linux/mman.h>
>  #include <linux/export.h>
> @@ -72,8 +73,11 @@ static unsigned long arch_get_unmapped_area_common(struct file *filp,
>  	}
>  
>  	info.length = len;
> -	info.align_mask = do_color_align ? (PAGE_MASK & shm_align_mask) : 0;
>  	info.align_offset = pgoff << PAGE_SHIFT;
> +	if (filp && is_file_hugepages(filp))
> +		info.align_mask = huge_page_mask_align(filp);
> +	else
> +		info.align_mask = do_color_align ? (PAGE_MASK & shm_align_mask) : 0;
>  
>  	if (dir == DOWN) {
>  		info.flags = VM_UNMAPPED_AREA_TOPDOWN;
> -- 
> 2.47.0

applied to mips-next

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
