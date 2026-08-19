Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAAF415B97
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 19:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787166899; cv=none; b=bABO0XdIzGJ7nWTt+LRq+X+VFW6f9IApJKHSgyk6mFrRv7rWTHlLt/kSI2RBTwYTv/Pb3yGNjM4iF0i0C1ZgAhJGt7ku0XLM4ocyhg8Pk6lTnj+4Wds9g7HTQc8aYq5sbApsxjl/UKQ9OgLSd19F+ll9UsHjtAuLavotLm6qm7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787166899; c=relaxed/simple;
	bh=FFroz0VawWNiVrWQTxnFlPI5tuesFFTT6+JncAb8c+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Padf4bsH9OgnbdlmHi97mhCYx69gpWJYlB6M7EW+uKFhs8JbkESRgRAfzE9ahkZtnu6Xb4BGVsmLRKRCrJCPJRr5myotaJP8pOnnQAwHIJQyyptpKeXard/uqzHij2KSlq3JwUy/UaKCrifmDIgsRChAro4pi+/dP1ZDHyvHR0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nKtYqX/s; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nKtYqX/s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787166895; x=1818702895;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FFroz0VawWNiVrWQTxnFlPI5tuesFFTT6+JncAb8c+U=;
  b=nKtYqX/sQcd+wljhivf3Ixzx2ITIAy4//l5YTyjOPGQr4K/I6XMAWy+3
   8oCyGQnSltS6N4wutmrU+5feYM4nuZdw+B6PLccGtrYNU3QCFzFm9bykx
   xacRE0Nh40s32AW/+K0mZCYJV51yPYv5Qx4uDpDXtvSD/O4pIHXnA/dzD
   rSUmhz4lGaLAQSr3ZC3CYXXPem1cUEOalsBXKe+17It2/dLtMrQ9+nx6Y
   gahUuARuoxjle5Qa2xv2P1+ZNJYM33yKuYz1ZgTWyBK6Z6R84TYoTcAiO
   7BHljNtFrQ3dIwKVnUG4xPkKyBdOqa4vWfHW7KVvVB8Xwhr0+yHMTYPaE
   Q==;
X-CSE-ConnectionGUID: b8RRIhJLQz6MFp02xe+9Cw==
X-CSE-MsgGUID: Od2NFpmuQEOP7E7D8iZtdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="99220892"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="99220892"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 12:14:54 -0700
X-CSE-ConnectionGUID: gvsw3ahqR7Shm3n0CmHbhg==
X-CSE-MsgGUID: LPxiiZNeS1+nzFosNP7+xQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="261860673"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 19 Aug 2026 12:14:51 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wwlkO-00000000gBd-1H7P;
	Wed, 19 Aug 2026 19:14:48 +0000
Date: Thu, 20 Aug 2026 03:14:04 +0800
From: kernel test robot <lkp@intel.com>
To: dayou5941@163.com, akpm@linux-foundation.org, david@kernel.org,
	ljs@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, ziy@nvidia.com, linux-mm@kvack.org,
	Li Youhong <liyouhong@kylinos.cn>, Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] mm/memory-failure: fix concurrent access issue in
 min_order_for_split()
Message-ID: <202608200310.aIH2BEKj-lkp@intel.com>
References: <20260805084224.2597547-1-dayou5941@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805084224.2597547-1-dayou5941@163.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/dayou5941-163-com/mm-memory-failure-fix-concurrent-access-issue-in-min_order_for_split/20260805-164224
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20260805084224.2597547-1-dayou5941%40163.com
patch subject: [PATCH v3] mm/memory-failure: fix concurrent access issue in min_order_for_split()
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20260820/202608200310.aIH2BEKj-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260820/202608200310.aIH2BEKj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608200310.aIH2BEKj-lkp@intel.com/

All errors (new ones prefixed by >>):

   mm/memory-failure.c: In function 'memory_failure':
>> mm/memory-failure.c:2517:27: error: assignment of read-only variable 'new_order'
    2517 |                 new_order = min_order_for_split(folio);
         |                           ^
   mm/memory-failure.c: In function 'soft_offline_in_use_page':
   mm/memory-failure.c:2873:27: error: assignment of read-only variable 'new_order'
    2873 |                 new_order = min_order_for_split(folio);
         |                           ^


vim +/new_order +2517 mm/memory-failure.c

  2360	
  2361	/**
  2362	 * memory_failure - Handle memory failure of a page.
  2363	 * @pfn: Page Number of the corrupted page
  2364	 * @flags: fine tune action taken
  2365	 *
  2366	 * This function is called by the low level machine check code
  2367	 * of an architecture when it detects hardware memory corruption
  2368	 * of a page. It tries its best to recover, which includes
  2369	 * dropping pages, killing processes etc.
  2370	 *
  2371	 * The function is primarily of use for corruptions that
  2372	 * happen outside the current execution context (e.g. when
  2373	 * detected by a background scrubber)
  2374	 *
  2375	 * Must run in process context (e.g. a work queue) with interrupts
  2376	 * enabled and no spinlocks held.
  2377	 *
  2378	 * Return:
  2379	 *   0             - success,
  2380	 *   -ENXIO        - memory not managed by the kernel
  2381	 *   -EOPNOTSUPP   - hwpoison_filter() filtered the error event,
  2382	 *   -EHWPOISON    - the page was already poisoned, potentially
  2383	 *                   kill process,
  2384	 *   other negative values - failure.
  2385	 */
  2386	int memory_failure(unsigned long pfn, int flags)
  2387	{
  2388		struct page *p;
  2389		struct folio *folio;
  2390		struct dev_pagemap *pgmap;
  2391		int res = 0;
  2392		unsigned long page_flags;
  2393		bool retry = true;
  2394	
  2395		if (!sysctl_memory_failure_recovery)
  2396			panic("Memory failure on page %lx", pfn);
  2397	
  2398		mutex_lock(&mf_mutex);
  2399	
  2400		if (!(flags & MF_SW_SIMULATED))
  2401			hw_memory_failure = true;
  2402	
  2403		p = pfn_to_online_page(pfn);
  2404		if (!p) {
  2405			res = arch_memory_failure(pfn, flags);
  2406			if (res == 0)
  2407				goto unlock_mutex;
  2408	
  2409			if (!pfn_valid(pfn) && !arch_is_platform_page(PFN_PHYS(pfn))) {
  2410				/*
  2411				 * The PFN is not backed by struct page.
  2412				 */
  2413				res = memory_failure_pfn(pfn, flags);
  2414				goto unlock_mutex;
  2415			}
  2416	
  2417			if (pfn_valid(pfn)) {
  2418				pgmap = get_dev_pagemap(pfn);
  2419				put_ref_page(pfn, flags);
  2420				if (pgmap) {
  2421					res = memory_failure_dev_pagemap(pfn, flags,
  2422									 pgmap);
  2423					goto unlock_mutex;
  2424				}
  2425			}
  2426			pr_err("%#lx: memory outside kernel control\n", pfn);
  2427			res = -ENXIO;
  2428			goto unlock_mutex;
  2429		}
  2430	
  2431	try_again:
  2432		res = try_memory_failure_hugetlb(pfn, flags);
  2433		/*
  2434		 * -ENOENT means the page we found is not hugetlb, so proceed with normal page handling
  2435		 */
  2436		if (res != -ENOENT)
  2437			goto unlock_mutex;
  2438	
  2439		if (TestSetPageHWPoison(p)) {
  2440			res = -EHWPOISON;
  2441			if (flags & MF_ACTION_REQUIRED)
  2442				res = kill_accessing_process(current, pfn, flags);
  2443			if (flags & MF_COUNT_INCREASED)
  2444				put_page(p);
  2445			action_result(pfn, MF_MSG_ALREADY_POISONED, MF_FAILED);
  2446			goto unlock_mutex;
  2447		}
  2448	
  2449		/*
  2450		 * We need/can do nothing about count=0 pages.
  2451		 * 1) it's a free page, and therefore in safe hand:
  2452		 *    check_new_page() will be the gate keeper.
  2453		 * 2) it's part of a non-compound high order page.
  2454		 *    Implies some kernel user: cannot stop them from
  2455		 *    R/W the page; let's pray that the page has been
  2456		 *    used and will be freed some time later.
  2457		 * In fact it's dangerous to directly bump up page count from 0,
  2458		 * that may make page_ref_freeze()/page_ref_unfreeze() mismatch.
  2459		 */
  2460		res = get_hwpoison_page(p, flags);
  2461		switch (res) {
  2462		case 0:
  2463			if (is_free_buddy_page(p)) {
  2464				if (take_page_off_buddy(p)) {
  2465					page_ref_inc(p);
  2466					res = MF_RECOVERED;
  2467				} else {
  2468					/* We lost the race, try again */
  2469					if (retry) {
  2470						ClearPageHWPoison(p);
  2471						retry = false;
  2472						goto try_again;
  2473					}
  2474					res = MF_FAILED;
  2475				}
  2476				res = action_result(pfn, MF_MSG_BUDDY, res);
  2477			} else {
  2478				res = action_result(pfn, MF_MSG_KERNEL_HIGH_ORDER, MF_IGNORED);
  2479			}
  2480			goto unlock_mutex;
  2481		case 1:
  2482			/* Got a refcount on a handlable page. */
  2483			break;
  2484		case -ENOTRECOVERABLE:
  2485			/*
  2486			 * Stable unhandlable kernel-owned page (PG_reserved,
  2487			 * slab, page tables, large-kmalloc).
  2488			 * No recovery possible.
  2489			 */
  2490			res = action_result(pfn, MF_MSG_KERNEL, MF_IGNORED);
  2491			goto unlock_mutex;
  2492		default:
  2493			/* Transient lifecycle race with the page allocator. */
  2494			res = action_result(pfn, MF_MSG_GET_HWPOISON, MF_IGNORED);
  2495			goto unlock_mutex;
  2496		}
  2497	
  2498		folio = page_folio(p);
  2499	
  2500		/* filter pages that are protected from hwpoison test by users */
  2501		folio_lock(folio);
  2502		if (hwpoison_filter(p)) {
  2503			ClearPageHWPoison(p);
  2504			folio_unlock(folio);
  2505			folio_put(folio);
  2506			res = -EOPNOTSUPP;
  2507			goto unlock_mutex;
  2508		}
  2509	
  2510		folio_unlock(folio);
  2511	
  2512		if (folio_test_large(folio)) {
  2513			const int new_order;
  2514			int err;
  2515	
  2516			folio_lock(folio);
> 2517			new_order = min_order_for_split(folio);
  2518			folio_unlock(folio);
  2519	
  2520			/*
  2521			 * The flag must be set after the refcount is bumped
  2522			 * otherwise it may race with THP split.
  2523			 * And the flag can't be set in get_hwpoison_page() since
  2524			 * it is called by soft offline too and it is just called
  2525			 * for !MF_COUNT_INCREASED.  So here seems to be the best
  2526			 * place.
  2527			 *
  2528			 * Don't need care about the above error handling paths for
  2529			 * get_hwpoison_page() since they handle either free page
  2530			 * or unhandlable page.  The refcount is bumped iff the
  2531			 * page is a valid handlable page.
  2532			 */
  2533			folio_set_has_hwpoisoned(folio);
  2534			err = try_to_split_thp_page(p, new_order, /* release= */ false);
  2535			/*
  2536			 * If splitting a folio to order-0 fails, kill the process.
  2537			 * Split the folio regardless to minimize unusable pages.
  2538			 * Because the memory failure code cannot handle large
  2539			 * folios, this split is always treated as if it failed.
  2540			 */
  2541			if (err || new_order) {
  2542				/* get folio again in case the original one is split */
  2543				folio = page_folio(p);
  2544				res = -EHWPOISON;
  2545				kill_procs_now(p, pfn, flags, folio);
  2546				put_page(p);
  2547				action_result(pfn, MF_MSG_UNSPLIT_THP, MF_FAILED);
  2548				goto unlock_mutex;
  2549			}
  2550			VM_BUG_ON_PAGE(!page_count(p), p);
  2551			folio = page_folio(p);
  2552		}
  2553	
  2554		/*
  2555		 * We ignore non-LRU pages for good reasons.
  2556		 * - PG_locked is only well defined for LRU pages and a few others
  2557		 * - to avoid races with __SetPageLocked()
  2558		 * - to avoid races with __SetPageSlab*() (and more non-atomic ops)
  2559		 * The check (unnecessarily) ignores LRU pages being isolated and
  2560		 * walked by the page reclaim code, however that's not a big loss.
  2561		 */
  2562		shake_folio(folio);
  2563	
  2564		folio_lock(folio);
  2565	
  2566		/*
  2567		 * We're only intended to deal with the non-Compound page here.
  2568		 * The page cannot become compound pages again as folio has been
  2569		 * splited and extra refcnt is held.
  2570		 */
  2571		WARN_ON(folio_test_large(folio));
  2572	
  2573		/*
  2574		 * We use page flags to determine what action should be taken, but
  2575		 * the flags can be modified by the error containment action.  One
  2576		 * example is an mlocked page, where PG_mlocked is cleared by
  2577		 * folio_remove_rmap_*() in try_to_unmap_one(). So to determine page
  2578		 * status correctly, we save a copy of the page flags at this time.
  2579		 */
  2580		page_flags = folio->flags.f;
  2581	
  2582		/*
  2583		 * __munlock_folio() may clear a writeback folio's LRU flag without
  2584		 * the folio lock. We need to wait for writeback completion for this
  2585		 * folio or it may trigger a vfs BUG while evicting inode.
  2586		 */
  2587		if (!folio_test_lru(folio) && !folio_test_writeback(folio))
  2588			goto identify_page_state;
  2589	
  2590		/*
  2591		 * It's very difficult to mess with pages currently under IO
  2592		 * and in many cases impossible, so we just avoid it here.
  2593		 */
  2594		folio_wait_writeback(folio);
  2595	
  2596		/*
  2597		 * Now take care of user space mappings.
  2598		 * Abort on fail: __filemap_remove_folio() assumes unmapped page.
  2599		 */
  2600		if (!hwpoison_user_mappings(folio, p, pfn, flags)) {
  2601			res = action_result(pfn, MF_MSG_UNMAP_FAILED, MF_FAILED);
  2602			goto unlock_page;
  2603		}
  2604	
  2605		/*
  2606		 * Torn down by someone else?
  2607		 */
  2608		if (folio_test_lru(folio) && !folio_test_swapcache(folio) &&
  2609		    folio->mapping == NULL) {
  2610			res = action_result(pfn, MF_MSG_TRUNCATED_LRU, MF_IGNORED);
  2611			goto unlock_page;
  2612		}
  2613	
  2614	identify_page_state:
  2615		res = identify_page_state(pfn, p, page_flags);
  2616		mutex_unlock(&mf_mutex);
  2617		return res;
  2618	unlock_page:
  2619		folio_unlock(folio);
  2620	unlock_mutex:
  2621		mutex_unlock(&mf_mutex);
  2622		return res;
  2623	}
  2624	EXPORT_SYMBOL_GPL(memory_failure);
  2625	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
