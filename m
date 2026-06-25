Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16DF37C900;
	Thu, 25 Jun 2026 05:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782366380; cv=none; b=mBBem6zkM3OJzPU3Wd0RykJcSHTJdbKMBsrThMK1SHkFB6jfr5RNdhg6V3l0TxfuiDBN08mrq33LOXJ1enat0unxl3VmLrG5HgN8GB1DLYhLW9SJKD5UApMgFcJKgi42inVlT/LSVbB+5XN/FmdS98u6T1Nr+2flHh/cL7JLYfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782366380; c=relaxed/simple;
	bh=0xMLENcuy5XK64XhlRj6nQreCLFTSuOzxNb7Pm80sPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=glczA64QVOm3nhsPJoNWZ6fxIuvxZTqmxZh9S025uLAoxP+IQsL/FPRWHkyPwz/17mvBcbZVXzbn/4r1TmAwlUMHnU0C/ka7KQJ3s3zXjJSoLEFdop5p6kR6U3WUOBi9NB8pet+ByKr+ash2PBWVFlSvNxqucJGoecfyirg6SyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SL/dEXIn; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SL/dEXIn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782366377; x=1813902377;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0xMLENcuy5XK64XhlRj6nQreCLFTSuOzxNb7Pm80sPE=;
  b=SL/dEXInXYi2sWfeUbC9B5Eftp4XYbsVbeJ59JYF0DwGVsWF36ug1o4i
   +xOtI8w9f4kXI2FsAQpSavLa1pQqBHIPY8P90/XQ37olqRJFr09jTPURe
   doAQKQe/YGzSmkE5urW9jZAxUJljazldHAuFzZTee9D+VDpoQtMPlxhkC
   vaqT6xoRFv/jioYa9VyiuS1K9YkYe6V+5R48ub6S86ip1pNZt2u8t355j
   kiFIMRSBGgBumj1am2Fbpcmu4vrEAEt10ELElWxUuQ+HKPKcL81L6KGq9
   UwpLzCtAfEMJTsUFyW9FF18qEtiJP2Y8K3GIW17/QTA0BweHSBHPddWhf
   w==;
X-CSE-ConnectionGUID: OFPyoWqlR8eFgwz4uOHVmg==
X-CSE-MsgGUID: l1Zi2LiNTlSUw0/mIIaq8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="82121858"
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="82121858"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 22:46:11 -0700
X-CSE-ConnectionGUID: Ya1fGO+hSQ2qgsRSNC27zQ==
X-CSE-MsgGUID: fWctwNGFTbexH2ojKAyAIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="280543918"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 24 Jun 2026 22:46:06 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wccua-000000003wB-1xiI;
	Thu, 25 Jun 2026 05:46:04 +0000
Date: Thu, 25 Jun 2026 13:45:58 +0800
From: kernel test robot <lkp@intel.com>
To: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org,
	david@kernel.org, ljs@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Dev Jain <dev.jain@arm.com>, riel@surriel.com, liam@infradead.org,
	vbabka@kernel.org, harry@kernel.org, jannh@google.com,
	kas@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	ryan.roberts@arm.com, anshuman.khandual@arm.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/rmap: use huge_ptep_get() in try_to_unmap_one()
Message-ID: <202606251341.jfIr1D7m-lkp@intel.com>
References: <20260625042853.2752898-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625042853.2752898-1-dev.jain@arm.com>

Hi Dev,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Dev-Jain/mm-rmap-use-huge_ptep_get-in-try_to_unmap_one/20260625-123050
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20260625042853.2752898-1-dev.jain%40arm.com
patch subject: [PATCH] mm/rmap: use huge_ptep_get() in try_to_unmap_one()
config: hexagon-allnoconfig (https://download.01.org/0day-ci/archive/20260625/202606251341.jfIr1D7m-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 6cc609bb250b21b47fc7d394b4019101e9983597)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260625/202606251341.jfIr1D7m-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606251341.jfIr1D7m-lkp@intel.com/

All errors (new ones prefixed by >>):

>> mm/rmap.c:2100:13: error: call to undeclared function 'huge_ptep_get'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    2100 |                         pteval = huge_ptep_get(mm, address, pvmw.pte);
         |                                  ^
>> mm/rmap.c:2100:11: error: assigning to 'pte_t' from incompatible type 'int'
    2100 |                         pteval = huge_ptep_get(mm, address, pvmw.pte);
         |                                ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   2 errors generated.


vim +/huge_ptep_get +2100 mm/rmap.c

  1980	
  1981	/*
  1982	 * @arg: enum ttu_flags will be passed to this argument
  1983	 */
  1984	static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
  1985			     unsigned long address, void *arg)
  1986	{
  1987		struct mm_struct *mm = vma->vm_mm;
  1988		DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, address, 0);
  1989		bool anon_exclusive, ret = true;
  1990		pte_t pteval;
  1991		struct page *subpage;
  1992		struct mmu_notifier_range range;
  1993		enum ttu_flags flags = (enum ttu_flags)(long)arg;
  1994		unsigned long nr_pages = 1, end_addr;
  1995		unsigned long pfn;
  1996		unsigned long hsz = 0;
  1997		int ptes = 0;
  1998	
  1999		/*
  2000		 * When racing against e.g. zap_pte_range() on another cpu,
  2001		 * in between its ptep_get_and_clear_full() and folio_remove_rmap_*(),
  2002		 * try_to_unmap() may return before folio_mapped() has become false,
  2003		 * if page table locking is skipped: use TTU_SYNC to wait for that.
  2004		 */
  2005		if (flags & TTU_SYNC)
  2006			pvmw.flags = PVMW_SYNC;
  2007	
  2008		/*
  2009		 * For THP, we have to assume the worse case ie pmd for invalidation.
  2010		 * For hugetlb, it could be much worse if we need to do pud
  2011		 * invalidation in the case of pmd sharing.
  2012		 *
  2013		 * Note that the folio can not be freed in this function as call of
  2014		 * try_to_unmap() must hold a reference on the folio.
  2015		 */
  2016		range.end = vma_address_end(&pvmw);
  2017		mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma->vm_mm,
  2018					address, range.end);
  2019		if (folio_test_hugetlb(folio)) {
  2020			/*
  2021			 * If sharing is possible, start and end will be adjusted
  2022			 * accordingly.
  2023			 */
  2024			adjust_range_if_pmd_sharing_possible(vma, &range.start,
  2025							     &range.end);
  2026	
  2027			/* We need the huge page size for set_huge_pte_at() */
  2028			hsz = huge_page_size(hstate_vma(vma));
  2029		}
  2030		mmu_notifier_invalidate_range_start(&range);
  2031	
  2032		while (page_vma_mapped_walk(&pvmw)) {
  2033			nr_pages = 1;
  2034	
  2035			/*
  2036			 * If the folio is in an mlock()d vma, we must not swap it out.
  2037			 */
  2038			if (!(flags & TTU_IGNORE_MLOCK) &&
  2039			    (vma->vm_flags & VM_LOCKED)) {
  2040				ptes++;
  2041	
  2042				/*
  2043				 * Set 'ret' to indicate the page cannot be unmapped.
  2044				 *
  2045				 * Do not jump to walk_abort immediately as additional
  2046				 * iteration might be required to detect fully mapped
  2047				 * folio an mlock it.
  2048				 */
  2049				ret = false;
  2050	
  2051				/* Only mlock fully mapped pages */
  2052				if (pvmw.pte && ptes != pvmw.nr_pages)
  2053					continue;
  2054	
  2055				/*
  2056				 * All PTEs must be protected by page table lock in
  2057				 * order to mlock the page.
  2058				 *
  2059				 * If page table boundary has been cross, current ptl
  2060				 * only protect part of ptes.
  2061				 */
  2062				if (pvmw.flags & PVMW_PGTABLE_CROSSED)
  2063					goto walk_done;
  2064	
  2065				/* Restore the mlock which got missed */
  2066				mlock_vma_folio(folio, vma);
  2067				goto walk_done;
  2068			}
  2069	
  2070			if (!pvmw.pte) {
  2071				if (folio_test_lazyfree(folio)) {
  2072					if (unmap_huge_pmd_locked(vma, pvmw.address, pvmw.pmd, folio))
  2073						goto walk_done;
  2074					/*
  2075					 * unmap_huge_pmd_locked has either already marked
  2076					 * the folio as swap-backed or decided to retain it
  2077					 * due to GUP or speculative references.
  2078					 */
  2079					goto walk_abort;
  2080				}
  2081	
  2082				if (flags & TTU_SPLIT_HUGE_PMD) {
  2083					/*
  2084					 * We temporarily have to drop the PTL and
  2085					 * restart so we can process the PTE-mapped THP.
  2086					 */
  2087					split_huge_pmd_locked(vma, pvmw.address,
  2088							      pvmw.pmd, false);
  2089					flags &= ~TTU_SPLIT_HUGE_PMD;
  2090					page_vma_mapped_walk_restart(&pvmw);
  2091					continue;
  2092				}
  2093			}
  2094	
  2095			/* Unexpected PMD-mapped THP? */
  2096			VM_BUG_ON_FOLIO(!pvmw.pte, folio);
  2097	
  2098			address = pvmw.address;
  2099			if (folio_test_hugetlb(folio)) {
> 2100				pteval = huge_ptep_get(mm, address, pvmw.pte);
  2101			} else {
  2102				/*
  2103				 * Handle PFN swap PTEs, such as device-exclusive ones,
  2104				 * that actually map pages.
  2105				 */
  2106				pteval = ptep_get(pvmw.pte);
  2107			}
  2108			if (likely(pte_present(pteval))) {
  2109				pfn = pte_pfn(pteval);
  2110			} else {
  2111				const softleaf_t entry = softleaf_from_pte(pteval);
  2112	
  2113				pfn = softleaf_to_pfn(entry);
  2114				VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
  2115			}
  2116	
  2117			subpage = folio_page(folio, pfn - folio_pfn(folio));
  2118			anon_exclusive = folio_test_anon(folio) &&
  2119					 PageAnonExclusive(subpage);
  2120	
  2121			if (folio_test_hugetlb(folio)) {
  2122				bool anon = folio_test_anon(folio);
  2123	
  2124				/*
  2125				 * The try_to_unmap() is only passed a hugetlb page
  2126				 * in the case where the hugetlb page is poisoned.
  2127				 */
  2128				VM_BUG_ON_PAGE(!PageHWPoison(subpage), subpage);
  2129				/*
  2130				 * huge_pmd_unshare may unmap an entire PMD page.
  2131				 * There is no way of knowing exactly which PMDs may
  2132				 * be cached for this mm, so we must flush them all.
  2133				 * start/end were already adjusted above to cover this
  2134				 * range.
  2135				 */
  2136				flush_cache_range(vma, range.start, range.end);
  2137	
  2138				/*
  2139				 * To call huge_pmd_unshare, i_mmap_rwsem must be
  2140				 * held in write mode.  Caller needs to explicitly
  2141				 * do this outside rmap routines.
  2142				 *
  2143				 * We also must hold hugetlb vma_lock in write mode.
  2144				 * Lock order dictates acquiring vma_lock BEFORE
  2145				 * i_mmap_rwsem.  We can only try lock here and fail
  2146				 * if unsuccessful.
  2147				 */
  2148				if (!anon) {
  2149					struct mmu_gather tlb;
  2150	
  2151					VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
  2152					if (!hugetlb_vma_trylock_write(vma))
  2153						goto walk_abort;
  2154	
  2155					tlb_gather_mmu_vma(&tlb, vma);
  2156					if (huge_pmd_unshare(&tlb, vma, address, pvmw.pte)) {
  2157						hugetlb_vma_unlock_write(vma);
  2158						huge_pmd_unshare_flush(&tlb, vma);
  2159						tlb_finish_mmu(&tlb);
  2160						/*
  2161						 * The PMD table was unmapped,
  2162						 * consequently unmapping the folio.
  2163						 */
  2164						goto walk_done;
  2165					}
  2166					hugetlb_vma_unlock_write(vma);
  2167					tlb_finish_mmu(&tlb);
  2168				}
  2169				pteval = huge_ptep_clear_flush(vma, address, pvmw.pte);
  2170				if (pte_dirty(pteval))
  2171					folio_mark_dirty(folio);
  2172			} else if (likely(pte_present(pteval))) {
  2173				nr_pages = folio_unmap_pte_batch(folio, &pvmw, flags, pteval);
  2174				end_addr = address + nr_pages * PAGE_SIZE;
  2175				flush_cache_range(vma, address, end_addr);
  2176	
  2177				/* Nuke the page table entry. */
  2178				pteval = get_and_clear_ptes(mm, address, pvmw.pte, nr_pages);
  2179				/*
  2180				 * We clear the PTE but do not flush so potentially
  2181				 * a remote CPU could still be writing to the folio.
  2182				 * If the entry was previously clean then the
  2183				 * architecture must guarantee that a clear->dirty
  2184				 * transition on a cached TLB entry is written through
  2185				 * and traps if the PTE is unmapped.
  2186				 */
  2187				if (should_defer_flush(mm, flags))
  2188					set_tlb_ubc_flush_pending(mm, pteval, address, end_addr);
  2189				else
  2190					flush_tlb_range(vma, address, end_addr);
  2191				if (pte_dirty(pteval))
  2192					folio_mark_dirty(folio);
  2193			} else {
  2194				pte_clear(mm, address, pvmw.pte);
  2195			}
  2196	
  2197			/*
  2198			 * Now the pte is cleared. If this pte was uffd-wp armed,
  2199			 * we may want to replace a none pte with a marker pte if
  2200			 * it's file-backed, so we don't lose the tracking info.
  2201			 */
  2202			pte_install_uffd_wp_if_needed(vma, address, pvmw.pte, pteval);
  2203	
  2204			/* Update high watermark before we lower rss */
  2205			update_hiwater_rss(mm);
  2206	
  2207			if (PageHWPoison(subpage) && (flags & TTU_HWPOISON)) {
  2208				pteval = swp_entry_to_pte(make_hwpoison_entry(subpage));
  2209				if (folio_test_hugetlb(folio)) {
  2210					hugetlb_count_sub(folio_nr_pages(folio), mm);
  2211					set_huge_pte_at(mm, address, pvmw.pte, pteval,
  2212							hsz);
  2213				} else {
  2214					dec_mm_counter(mm, mm_counter(folio));
  2215					set_pte_at(mm, address, pvmw.pte, pteval);
  2216				}
  2217			} else if (likely(pte_present(pteval)) && pte_unused(pteval) &&
  2218				   !userfaultfd_armed(vma)) {
  2219				/*
  2220				 * The guest indicated that the page content is of no
  2221				 * interest anymore. Simply discard the pte, vmscan
  2222				 * will take care of the rest.
  2223				 * A future reference will then fault in a new zero
  2224				 * page. When userfaultfd is active, we must not drop
  2225				 * this page though, as its main user (postcopy
  2226				 * migration) will not expect userfaults on already
  2227				 * copied pages.
  2228				 */
  2229				dec_mm_counter(mm, mm_counter(folio));
  2230			} else if (folio_test_anon(folio)) {
  2231				swp_entry_t entry = page_swap_entry(subpage);
  2232				pte_t swp_pte;
  2233				/*
  2234				 * Store the swap location in the pte.
  2235				 * See handle_pte_fault() ...
  2236				 */
  2237				if (unlikely(folio_test_swapbacked(folio) !=
  2238						folio_test_swapcache(folio))) {
  2239					WARN_ON_ONCE(1);
  2240					goto walk_abort;
  2241				}
  2242	
  2243				/* MADV_FREE page check */
  2244				if (!folio_test_swapbacked(folio)) {
  2245					int ref_count, map_count;
  2246	
  2247					/*
  2248					 * Synchronize with gup_pte_range():
  2249					 * - clear PTE; barrier; read refcount
  2250					 * - inc refcount; barrier; read PTE
  2251					 */
  2252					smp_mb();
  2253	
  2254					ref_count = folio_ref_count(folio);
  2255					map_count = folio_mapcount(folio);
  2256	
  2257					/*
  2258					 * Order reads for page refcount and dirty flag
  2259					 * (see comments in __remove_mapping()).
  2260					 */
  2261					smp_rmb();
  2262	
  2263					if (folio_test_dirty(folio) && !(vma->vm_flags & VM_DROPPABLE)) {
  2264						/*
  2265						 * redirtied either using the page table or a previously
  2266						 * obtained GUP reference.
  2267						 */
  2268						set_ptes(mm, address, pvmw.pte, pteval, nr_pages);
  2269						folio_set_swapbacked(folio);
  2270						goto walk_abort;
  2271					} else if (ref_count != 1 + map_count) {
  2272						/*
  2273						 * Additional reference. Could be a GUP reference or any
  2274						 * speculative reference. GUP users must mark the folio
  2275						 * dirty if there was a modification. This folio cannot be
  2276						 * reclaimed right now either way, so act just like nothing
  2277						 * happened.
  2278						 * We'll come back here later and detect if the folio was
  2279						 * dirtied when the additional reference is gone.
  2280						 */
  2281						set_ptes(mm, address, pvmw.pte, pteval, nr_pages);
  2282						goto walk_abort;
  2283					}
  2284					add_mm_counter(mm, MM_ANONPAGES, -nr_pages);
  2285					goto discard;
  2286				}
  2287	
  2288				if (folio_dup_swap(folio, subpage) < 0) {
  2289					set_pte_at(mm, address, pvmw.pte, pteval);
  2290					goto walk_abort;
  2291				}
  2292	
  2293				/*
  2294				 * arch_unmap_one() is expected to be a NOP on
  2295				 * architectures where we could have PFN swap PTEs,
  2296				 * so we'll not check/care.
  2297				 */
  2298				if (arch_unmap_one(mm, vma, address, pteval) < 0) {
  2299					folio_put_swap(folio, subpage);
  2300					set_pte_at(mm, address, pvmw.pte, pteval);
  2301					goto walk_abort;
  2302				}
  2303	
  2304				/* See folio_try_share_anon_rmap(): clear PTE first. */
  2305				if (anon_exclusive &&
  2306				    folio_try_share_anon_rmap_pte(folio, subpage)) {
  2307					folio_put_swap(folio, subpage);
  2308					set_pte_at(mm, address, pvmw.pte, pteval);
  2309					goto walk_abort;
  2310				}
  2311				if (list_empty(&mm->mmlist)) {
  2312					spin_lock(&mmlist_lock);
  2313					if (list_empty(&mm->mmlist))
  2314						list_add(&mm->mmlist, &init_mm.mmlist);
  2315					spin_unlock(&mmlist_lock);
  2316				}
  2317				dec_mm_counter(mm, MM_ANONPAGES);
  2318				inc_mm_counter(mm, MM_SWAPENTS);
  2319				swp_pte = swp_entry_to_pte(entry);
  2320				if (anon_exclusive)
  2321					swp_pte = pte_swp_mkexclusive(swp_pte);
  2322				if (likely(pte_present(pteval))) {
  2323					if (pte_soft_dirty(pteval))
  2324						swp_pte = pte_swp_mksoft_dirty(swp_pte);
  2325					if (pte_uffd_wp(pteval))
  2326						swp_pte = pte_swp_mkuffd_wp(swp_pte);
  2327				} else {
  2328					if (pte_swp_soft_dirty(pteval))
  2329						swp_pte = pte_swp_mksoft_dirty(swp_pte);
  2330					if (pte_swp_uffd_wp(pteval))
  2331						swp_pte = pte_swp_mkuffd_wp(swp_pte);
  2332				}
  2333				set_pte_at(mm, address, pvmw.pte, swp_pte);
  2334			} else {
  2335				/*
  2336				 * This is a locked file-backed folio,
  2337				 * so it cannot be removed from the page
  2338				 * cache and replaced by a new folio before
  2339				 * mmu_notifier_invalidate_range_end, so no
  2340				 * concurrent thread might update its page table
  2341				 * to point at a new folio while a device is
  2342				 * still using this folio.
  2343				 *
  2344				 * See Documentation/mm/mmu_notifier.rst
  2345				 */
  2346				add_mm_counter(mm, mm_counter_file(folio), -nr_pages);
  2347			}
  2348	discard:
  2349			if (unlikely(folio_test_hugetlb(folio))) {
  2350				hugetlb_remove_rmap(folio);
  2351			} else {
  2352				folio_remove_rmap_ptes(folio, subpage, nr_pages, vma);
  2353			}
  2354			if (vma->vm_flags & VM_LOCKED)
  2355				mlock_drain_local();
  2356			folio_put_refs(folio, nr_pages);
  2357	
  2358			/*
  2359			 * If we are sure that we batched the entire folio and cleared
  2360			 * all PTEs, we can just optimize and stop right here.
  2361			 */
  2362			if (nr_pages == folio_nr_pages(folio))
  2363				goto walk_done;
  2364			continue;
  2365	walk_abort:
  2366			ret = false;
  2367	walk_done:
  2368			page_vma_mapped_walk_done(&pvmw);
  2369			break;
  2370		}
  2371	
  2372		mmu_notifier_invalidate_range_end(&range);
  2373	
  2374		return ret;
  2375	}
  2376	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
