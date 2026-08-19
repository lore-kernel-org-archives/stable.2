Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D00E3EC2EF
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 23:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787183854; cv=none; b=sxAPzFTdwgQw5qGyYbC/hrxMHpulT2AYyoX68OF+ZsCa9ACuAiFEc23v0yH0eRGPHdwV0CWif/Tb/9LD1RsnezgsHdifVMpJQo+D5y5T5aGvlp07Fp5C9/k4jbwOAeQ5uTn9miApJ6bQT6v1b3elmkwf4xviUokt9xGxseqHvBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787183854; c=relaxed/simple;
	bh=mJeJtM1MGcCSH6M+FitFagsQU/dv60z3qvYdVQX+21I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eb14AGoZtF5icBklSU4uvxsfYkkcypXLRao24jIb4l5tnIKgInmD5edcGEnWS9hqH8MfJQC+65P/9Tj2NQ5Y9oH5K/Oa2rBovvyj6GuLs88XrRf+iUTzN/YeqOXNv3wSGKHitQPldJ2UOrkNYVBtMiKh9UPfTf29KhzCrcl56xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XmaO8xk0; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XmaO8xk0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787183852; x=1818719852;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mJeJtM1MGcCSH6M+FitFagsQU/dv60z3qvYdVQX+21I=;
  b=XmaO8xk0iXUw83p1f+amgRfwy7KmsDPKaCFRrlNI6YcgpbvRW2zkem31
   zHTbO5AE3hW4D/8zRyi+9CtH5Z2wIbh94yyoTP72uZsTANKb7e8RGPPps
   jfb8dqH8gDxJo8BD7WuR7/JbQ4LZrc/ECED/4/sTUoJ7LvOJLZ/8YDUjg
   vlj0oqdD3c0YcSXDROAcbMVeGaTBxSAko9oaWJbFs2fJRna3SfAWIDFa9
   Hce4pfrM+TFMuKn4GocRp94222F0V63Zuq3hiAk2Btb6DQpDKaHfAQIcy
   uRKoR8YSIf6Ft0mJ0mrVVZBW6ihrXOhf0uNm52PYexUt59iMwzLHNWXpS
   g==;
X-CSE-ConnectionGUID: 59bB/t4WTDWqU5G04wf4qA==
X-CSE-MsgGUID: 1nSZSAiDTsCluy47ug+pcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="86830457"
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; 
   d="scan'208";a="86830457"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 16:57:31 -0700
X-CSE-ConnectionGUID: dQMW+0IFQz2vl4fU+6sySg==
X-CSE-MsgGUID: sRTa2ll7Qq6jQJ2PWHxeRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; 
   d="scan'208";a="295640577"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 19 Aug 2026 16:57:27 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wwq9s-00000000gyL-0oyn;
	Wed, 19 Aug 2026 23:57:24 +0000
Date: Thu, 20 Aug 2026 07:57:17 +0800
From: kernel test robot <lkp@intel.com>
To: dayou5941@163.com, akpm@linux-foundation.org, linmiaohe@huawei.com,
	david@kernel.org, ljs@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, nao.horiguchi@gmail.com,
	linux-mm@kvack.org, ziy@nvidia.com,
	Li Youhong <liyouhong@kylinos.cn>, Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH v4] mm/memory-failure: fix folio refcount leak and
 locking in soft/hard offline
Message-ID: <202608200744.OjhLdVKY-lkp@intel.com>
References: <20260806031958.677935-1-dayou5941@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806031958.677935-1-dayou5941@163.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/dayou5941-163-com/mm-memory-failure-fix-folio-refcount-leak-and-locking-in-soft-hard-offline/20260806-111958
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20260806031958.677935-1-dayou5941%40163.com
patch subject: [PATCH v4] mm/memory-failure: fix folio refcount leak and locking in soft/hard offline
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20260820/202608200744.OjhLdVKY-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260820/202608200744.OjhLdVKY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608200744.OjhLdVKY-lkp@intel.com/

All warnings (new ones prefixed by >>):

   mm/memory-failure.c: In function 'memory_failure':
>> mm/memory-failure.c:2492:21: warning: variable 'err' set but not used [-Wunused-but-set-variable=]
    2492 |                 int err;
         |                     ^~~


vim +/err +2492 mm/memory-failure.c

2ec41967189cd6 Ankit Agrawal           2025-11-02  2340  
cd42f4a3b2b1c4 Tony Luck               2011-12-15  2341  /**
cd42f4a3b2b1c4 Tony Luck               2011-12-15  2342   * memory_failure - Handle memory failure of a page.
cd42f4a3b2b1c4 Tony Luck               2011-12-15  2343   * @pfn: Page Number of the corrupted page
cd42f4a3b2b1c4 Tony Luck               2011-12-15  2344   * @flags: fine tune action taken
cd42f4a3b2b1c4 Tony Luck               2011-12-15  2345   *
cd42f4a3b2b1c4 Tony Luck               2011-12-15  2346   * This function is called by the low level machine check code
cd42f4a3b2b1c4 Tony Luck               2011-12-15  2347   * of an architecture when it detects hardware memory corruption
cd42f4a3b2b1c4 Tony Luck               2011-12-15  2348   * of a page. It tries its best to recover, which includes
cd42f4a3b2b1c4 Tony Luck               2011-12-15  2349   * dropping pages, killing processes etc.
cd42f4a3b2b1c4 Tony Luck               2011-12-15  2350   *
cd42f4a3b2b1c4 Tony Luck               2011-12-15  2351   * The function is primarily of use for corruptions that
cd42f4a3b2b1c4 Tony Luck               2011-12-15  2352   * happen outside the current execution context (e.g. when
cd42f4a3b2b1c4 Tony Luck               2011-12-15  2353   * detected by a background scrubber)
cd42f4a3b2b1c4 Tony Luck               2011-12-15  2354   *
cd42f4a3b2b1c4 Tony Luck               2011-12-15  2355   * Must run in process context (e.g. a work queue) with interrupts
5885c6a62533cb Miaohe Lin              2023-07-11  2356   * enabled and no spinlocks held.
d1fe111fb62a1c luofei                  2022-03-22  2357   *
d2734f044f8483 Shuai Xue               2025-03-12  2358   * Return:
d2734f044f8483 Shuai Xue               2025-03-12  2359   *   0             - success,
d2734f044f8483 Shuai Xue               2025-03-12  2360   *   -ENXIO        - memory not managed by the kernel
d2734f044f8483 Shuai Xue               2025-03-12  2361   *   -EOPNOTSUPP   - hwpoison_filter() filtered the error event,
d2734f044f8483 Shuai Xue               2025-03-12  2362   *   -EHWPOISON    - the page was already poisoned, potentially
d2734f044f8483 Shuai Xue               2025-03-12  2363   *                   kill process,
d2734f044f8483 Shuai Xue               2025-03-12  2364   *   other negative values - failure.
cd42f4a3b2b1c4 Tony Luck               2011-12-15  2365   */
83b57531c58f41 Eric W. Biederman       2017-07-09  2366  int memory_failure(unsigned long pfn, int flags)
6a46079cf57a7f Andi Kleen              2009-09-16  2367  {
6a46079cf57a7f Andi Kleen              2009-09-16  2368  	struct page *p;
5dba5c356ab3bb Matthew Wilcox (Oracle  2024-04-12  2369) 	struct folio *folio;
6100e34b2526e1 Dan Williams            2018-07-13  2370  	struct dev_pagemap *pgmap;
171936ddaf97e6 Tony Luck               2021-06-24  2371  	int res = 0;
524fca1e7356f8 Naoya Horiguchi         2013-02-22  2372  	unsigned long page_flags;
a8b2c2ce89d4e0 Oscar Salvador          2020-12-14  2373  	bool retry = true;
6a46079cf57a7f Andi Kleen              2009-09-16  2374  
6a46079cf57a7f Andi Kleen              2009-09-16  2375  	if (!sysctl_memory_failure_recovery)
83b57531c58f41 Eric W. Biederman       2017-07-09  2376  		panic("Memory failure on page %lx", pfn);
6a46079cf57a7f Andi Kleen              2009-09-16  2377  
03b122da74b22f Tony Luck               2021-10-26  2378  	mutex_lock(&mf_mutex);
03b122da74b22f Tony Luck               2021-10-26  2379  
67f22ba7750f94 zhenwei pi              2022-06-15  2380  	if (!(flags & MF_SW_SIMULATED))
67f22ba7750f94 zhenwei pi              2022-06-15  2381  		hw_memory_failure = true;
67f22ba7750f94 zhenwei pi              2022-06-15  2382  
96c804a6ae8c59 David Hildenbrand       2019-10-18  2383  	p = pfn_to_online_page(pfn);
96c804a6ae8c59 David Hildenbrand       2019-10-18  2384  	if (!p) {
03b122da74b22f Tony Luck               2021-10-26  2385  		res = arch_memory_failure(pfn, flags);
03b122da74b22f Tony Luck               2021-10-26  2386  		if (res == 0)
03b122da74b22f Tony Luck               2021-10-26  2387  			goto unlock_mutex;
03b122da74b22f Tony Luck               2021-10-26  2388  
2ec41967189cd6 Ankit Agrawal           2025-11-02  2389  		if (!pfn_valid(pfn) && !arch_is_platform_page(PFN_PHYS(pfn))) {
2ec41967189cd6 Ankit Agrawal           2025-11-02  2390  			/*
2ec41967189cd6 Ankit Agrawal           2025-11-02  2391  			 * The PFN is not backed by struct page.
2ec41967189cd6 Ankit Agrawal           2025-11-02  2392  			 */
2ec41967189cd6 Ankit Agrawal           2025-11-02  2393  			res = memory_failure_pfn(pfn, flags);
2ec41967189cd6 Ankit Agrawal           2025-11-02  2394  			goto unlock_mutex;
2ec41967189cd6 Ankit Agrawal           2025-11-02  2395  		}
2ec41967189cd6 Ankit Agrawal           2025-11-02  2396  
96c804a6ae8c59 David Hildenbrand       2019-10-18  2397  		if (pfn_valid(pfn)) {
614d850efda98e Alistair Popple         2025-09-04  2398  			pgmap = get_dev_pagemap(pfn);
d51b68469bc780 Miaohe Lin              2023-07-01  2399  			put_ref_page(pfn, flags);
03b122da74b22f Tony Luck               2021-10-26  2400  			if (pgmap) {
03b122da74b22f Tony Luck               2021-10-26  2401  				res = memory_failure_dev_pagemap(pfn, flags,
96c804a6ae8c59 David Hildenbrand       2019-10-18  2402  								 pgmap);
03b122da74b22f Tony Luck               2021-10-26  2403  				goto unlock_mutex;
03b122da74b22f Tony Luck               2021-10-26  2404  			}
96c804a6ae8c59 David Hildenbrand       2019-10-18  2405  		}
96f96763de26d6 Kefeng Wang             2022-07-26  2406  		pr_err("%#lx: memory outside kernel control\n", pfn);
03b122da74b22f Tony Luck               2021-10-26  2407  		res = -ENXIO;
03b122da74b22f Tony Luck               2021-10-26  2408  		goto unlock_mutex;
6a46079cf57a7f Andi Kleen              2009-09-16  2409  	}
6a46079cf57a7f Andi Kleen              2009-09-16  2410  
a8b2c2ce89d4e0 Oscar Salvador          2020-12-14  2411  try_again:
5ee5ff9dbce0b8 Ye Liu                  2026-05-15  2412  	res = try_memory_failure_hugetlb(pfn, flags);
5ee5ff9dbce0b8 Ye Liu                  2026-05-15  2413  	/*
5ee5ff9dbce0b8 Ye Liu                  2026-05-15  2414  	 * -ENOENT means the page we found is not hugetlb, so proceed with normal page handling
5ee5ff9dbce0b8 Ye Liu                  2026-05-15  2415  	 */
5ee5ff9dbce0b8 Ye Liu                  2026-05-15  2416  	if (res != -ENOENT)
171936ddaf97e6 Tony Luck               2021-06-24  2417  		goto unlock_mutex;
171936ddaf97e6 Tony Luck               2021-06-24  2418  
6a46079cf57a7f Andi Kleen              2009-09-16  2419  	if (TestSetPageHWPoison(p)) {
47af12bae17f99 Aili Yao                2021-06-24  2420  		res = -EHWPOISON;
a3f5d80ea401ac Naoya Horiguchi         2021-06-28  2421  		if (flags & MF_ACTION_REQUIRED)
a3f5d80ea401ac Naoya Horiguchi         2021-06-28  2422  			res = kill_accessing_process(current, pfn, flags);
f361e2462e8ccc Naoya Horiguchi         2022-04-28  2423  		if (flags & MF_COUNT_INCREASED)
f361e2462e8ccc Naoya Horiguchi         2022-04-28  2424  			put_page(p);
b8b9488d50b715 Jane Chu                2024-05-24  2425  		action_result(pfn, MF_MSG_ALREADY_POISONED, MF_FAILED);
171936ddaf97e6 Tony Luck               2021-06-24  2426  		goto unlock_mutex;
6a46079cf57a7f Andi Kleen              2009-09-16  2427  	}
6a46079cf57a7f Andi Kleen              2009-09-16  2428  
6a46079cf57a7f Andi Kleen              2009-09-16  2429  	/*
6a46079cf57a7f Andi Kleen              2009-09-16  2430  	 * We need/can do nothing about count=0 pages.
6a46079cf57a7f Andi Kleen              2009-09-16  2431  	 * 1) it's a free page, and therefore in safe hand:
9cf2819159d5a3 Miaohe Lin              2022-08-30  2432  	 *    check_new_page() will be the gate keeper.
761ad8d7c7b548 Naoya Horiguchi         2017-07-10  2433  	 * 2) it's part of a non-compound high order page.
6a46079cf57a7f Andi Kleen              2009-09-16  2434  	 *    Implies some kernel user: cannot stop them from
6a46079cf57a7f Andi Kleen              2009-09-16  2435  	 *    R/W the page; let's pray that the page has been
6a46079cf57a7f Andi Kleen              2009-09-16  2436  	 *    used and will be freed some time later.
6a46079cf57a7f Andi Kleen              2009-09-16  2437  	 * In fact it's dangerous to directly bump up page count from 0,
1c4c3b99c03d3e Jiang Biao              2018-08-21  2438  	 * that may make page_ref_freeze()/page_ref_unfreeze() mismatch.
6a46079cf57a7f Andi Kleen              2009-09-16  2439  	 */
0ed950d1f28142 Naoya Horiguchi         2021-06-28  2440  	res = get_hwpoison_page(p, flags);
737a97548c4a31 Breno Leitao            2026-06-30  2441  	switch (res) {
737a97548c4a31 Breno Leitao            2026-06-30  2442  	case 0:
8d22ba1b74aa94 Wu Fengguang            2009-12-16  2443  		if (is_free_buddy_page(p)) {
a8b2c2ce89d4e0 Oscar Salvador          2020-12-14  2444  			if (take_page_off_buddy(p)) {
a8b2c2ce89d4e0 Oscar Salvador          2020-12-14  2445  				page_ref_inc(p);
a8b2c2ce89d4e0 Oscar Salvador          2020-12-14  2446  				res = MF_RECOVERED;
a8b2c2ce89d4e0 Oscar Salvador          2020-12-14  2447  			} else {
a8b2c2ce89d4e0 Oscar Salvador          2020-12-14  2448  				/* We lost the race, try again */
a8b2c2ce89d4e0 Oscar Salvador          2020-12-14  2449  				if (retry) {
a8b2c2ce89d4e0 Oscar Salvador          2020-12-14  2450  					ClearPageHWPoison(p);
a8b2c2ce89d4e0 Oscar Salvador          2020-12-14  2451  					retry = false;
a8b2c2ce89d4e0 Oscar Salvador          2020-12-14  2452  					goto try_again;
a8b2c2ce89d4e0 Oscar Salvador          2020-12-14  2453  				}
a8b2c2ce89d4e0 Oscar Salvador          2020-12-14  2454  				res = MF_FAILED;
a8b2c2ce89d4e0 Oscar Salvador          2020-12-14  2455  			}
b66d00dfebe79e Kefeng Wang             2022-10-21  2456  			res = action_result(pfn, MF_MSG_BUDDY, res);
8d22ba1b74aa94 Wu Fengguang            2009-12-16  2457  		} else {
b66d00dfebe79e Kefeng Wang             2022-10-21  2458  			res = action_result(pfn, MF_MSG_KERNEL_HIGH_ORDER, MF_IGNORED);
8d22ba1b74aa94 Wu Fengguang            2009-12-16  2459  		}
171936ddaf97e6 Tony Luck               2021-06-24  2460  		goto unlock_mutex;
737a97548c4a31 Breno Leitao            2026-06-30  2461  	case 1:
737a97548c4a31 Breno Leitao            2026-06-30  2462  		/* Got a refcount on a handlable page. */
737a97548c4a31 Breno Leitao            2026-06-30  2463  		break;
737a97548c4a31 Breno Leitao            2026-06-30  2464  	case -ENOTRECOVERABLE:
737a97548c4a31 Breno Leitao            2026-06-30  2465  		/*
737a97548c4a31 Breno Leitao            2026-06-30  2466  		 * Stable unhandlable kernel-owned page (PG_reserved,
737a97548c4a31 Breno Leitao            2026-06-30  2467  		 * slab, page tables, large-kmalloc).
737a97548c4a31 Breno Leitao            2026-06-30  2468  		 * No recovery possible.
737a97548c4a31 Breno Leitao            2026-06-30  2469  		 */
737a97548c4a31 Breno Leitao            2026-06-30  2470  		res = action_result(pfn, MF_MSG_KERNEL, MF_IGNORED);
737a97548c4a31 Breno Leitao            2026-06-30  2471  		goto unlock_mutex;
737a97548c4a31 Breno Leitao            2026-06-30  2472  	default:
737a97548c4a31 Breno Leitao            2026-06-30  2473  		/* Transient lifecycle race with the page allocator. */
b8b9488d50b715 Jane Chu                2024-05-24  2474  		res = action_result(pfn, MF_MSG_GET_HWPOISON, MF_IGNORED);
0ed950d1f28142 Naoya Horiguchi         2021-06-28  2475  		goto unlock_mutex;
0ed950d1f28142 Naoya Horiguchi         2021-06-28  2476  	}
6a46079cf57a7f Andi Kleen              2009-09-16  2477  
5dba5c356ab3bb Matthew Wilcox (Oracle  2024-04-12  2478) 	folio = page_folio(p);
9b0ab153d76972 Jane Chu                2024-05-24  2479  
9b0ab153d76972 Jane Chu                2024-05-24  2480  	/* filter pages that are protected from hwpoison test by users */
9b0ab153d76972 Jane Chu                2024-05-24  2481  	folio_lock(folio);
9b0ab153d76972 Jane Chu                2024-05-24  2482  	if (hwpoison_filter(p)) {
9b0ab153d76972 Jane Chu                2024-05-24  2483  		ClearPageHWPoison(p);
9b0ab153d76972 Jane Chu                2024-05-24  2484  		folio_unlock(folio);
9b0ab153d76972 Jane Chu                2024-05-24  2485  		folio_put(folio);
9b0ab153d76972 Jane Chu                2024-05-24  2486  		res = -EOPNOTSUPP;
9b0ab153d76972 Jane Chu                2024-05-24  2487  		goto unlock_mutex;
9b0ab153d76972 Jane Chu                2024-05-24  2488  	}
9b0ab153d76972 Jane Chu                2024-05-24  2489  	folio_unlock(folio);
9b0ab153d76972 Jane Chu                2024-05-24  2490  
5dba5c356ab3bb Matthew Wilcox (Oracle  2024-04-12  2491) 	if (folio_test_large(folio)) {
689b8986776c82 Zi Yan                  2025-10-31 @2492  		int err;
689b8986776c82 Zi Yan                  2025-10-31  2493  
eac96c3efdb593 Yang Shi                2021-10-28  2494  		/*
eac96c3efdb593 Yang Shi                2021-10-28  2495  		 * The flag must be set after the refcount is bumped
eac96c3efdb593 Yang Shi                2021-10-28  2496  		 * otherwise it may race with THP split.
eac96c3efdb593 Yang Shi                2021-10-28  2497  		 * And the flag can't be set in get_hwpoison_page() since
eac96c3efdb593 Yang Shi                2021-10-28  2498  		 * it is called by soft offline too and it is just called
5885c6a62533cb Miaohe Lin              2023-07-11  2499  		 * for !MF_COUNT_INCREASED.  So here seems to be the best
eac96c3efdb593 Yang Shi                2021-10-28  2500  		 * place.
eac96c3efdb593 Yang Shi                2021-10-28  2501  		 *
eac96c3efdb593 Yang Shi                2021-10-28  2502  		 * Don't need care about the above error handling paths for
eac96c3efdb593 Yang Shi                2021-10-28  2503  		 * get_hwpoison_page() since they handle either free page
eac96c3efdb593 Yang Shi                2021-10-28  2504  		 * or unhandlable page.  The refcount is bumped iff the
eac96c3efdb593 Yang Shi                2021-10-28  2505  		 * page is a valid handlable page.
eac96c3efdb593 Yang Shi                2021-10-28  2506  		 */
5dba5c356ab3bb Matthew Wilcox (Oracle  2024-04-12  2507) 		folio_set_has_hwpoisoned(folio);
546d4271307492 Li Youhong              2026-08-06  2508  
546d4271307492 Li Youhong              2026-08-06  2509  		lock_page(p);
546d4271307492 Li Youhong              2026-08-06  2510  		err = split_huge_page_to_order(p, min_order_for_split(folio));
546d4271307492 Li Youhong              2026-08-06  2511  		unlock_page(p);
689b8986776c82 Zi Yan                  2025-10-31  2512  		/*
689b8986776c82 Zi Yan                  2025-10-31  2513  		 * If splitting a folio to order-0 fails, kill the process.
689b8986776c82 Zi Yan                  2025-10-31  2514  		 * Split the folio regardless to minimize unusable pages.
689b8986776c82 Zi Yan                  2025-10-31  2515  		 * Because the memory failure code cannot handle large
689b8986776c82 Zi Yan                  2025-10-31  2516  		 * folios, this split is always treated as if it failed.
689b8986776c82 Zi Yan                  2025-10-31  2517  		 */
689b8986776c82 Zi Yan                  2025-10-31  2518  		folio = page_folio(p);
546d4271307492 Li Youhong              2026-08-06  2519  		if (folio_test_large(folio)) {
1a3798dececa8c Jane Chu                2024-05-24  2520  			res = -EHWPOISON;
1a3798dececa8c Jane Chu                2024-05-24  2521  			kill_procs_now(p, pfn, flags, folio);
1a3798dececa8c Jane Chu                2024-05-24  2522  			put_page(p);
1a3798dececa8c Jane Chu                2024-05-24  2523  			action_result(pfn, MF_MSG_UNSPLIT_THP, MF_FAILED);
171936ddaf97e6 Tony Luck               2021-06-24  2524  			goto unlock_mutex;
5d1fd5dc877bc1 Naoya Horiguchi         2020-10-15  2525  		}
415c64c1453aa2 Naoya Horiguchi         2015-06-24  2526  	}
415c64c1453aa2 Naoya Horiguchi         2015-06-24  2527  
e43c3afb367112 Wu Fengguang            2009-09-29  2528  	/*
e43c3afb367112 Wu Fengguang            2009-09-29  2529  	 * We ignore non-LRU pages for good reasons.
e43c3afb367112 Wu Fengguang            2009-09-29  2530  	 * - PG_locked is only well defined for LRU pages and a few others
48c935ad88f5be Kiryl Shutsemau         2016-01-15  2531  	 * - to avoid races with __SetPageLocked()
e43c3afb367112 Wu Fengguang            2009-09-29  2532  	 * - to avoid races with __SetPageSlab*() (and more non-atomic ops)
e43c3afb367112 Wu Fengguang            2009-09-29  2533  	 * The check (unnecessarily) ignores LRU pages being isolated and
e43c3afb367112 Wu Fengguang            2009-09-29  2534  	 * walked by the page reclaim code, however that's not a big loss.
e43c3afb367112 Wu Fengguang            2009-09-29  2535  	 */
5dba5c356ab3bb Matthew Wilcox (Oracle  2024-04-12  2536) 	shake_folio(folio);
e43c3afb367112 Wu Fengguang            2009-09-29  2537  
5dba5c356ab3bb Matthew Wilcox (Oracle  2024-04-12  2538) 	folio_lock(folio);
847ce401df392b Wu Fengguang            2009-12-16  2539  
f37d4298aa7f8b Andi Kleen              2014-08-06  2540  	/*
75ee64b3c9a969 Miaohe Lin              2022-03-22  2541  	 * We're only intended to deal with the non-Compound page here.
8a78882dac1c8c Miaohe Lin              2024-07-08  2542  	 * The page cannot become compound pages again as folio has been
8a78882dac1c8c Miaohe Lin              2024-07-08  2543  	 * splited and extra refcnt is held.
f37d4298aa7f8b Andi Kleen              2014-08-06  2544  	 */
8a78882dac1c8c Miaohe Lin              2024-07-08  2545  	WARN_ON(folio_test_large(folio));
f37d4298aa7f8b Andi Kleen              2014-08-06  2546  
524fca1e7356f8 Naoya Horiguchi         2013-02-22  2547  	/*
524fca1e7356f8 Naoya Horiguchi         2013-02-22  2548  	 * We use page flags to determine what action should be taken, but
524fca1e7356f8 Naoya Horiguchi         2013-02-22  2549  	 * the flags can be modified by the error containment action.  One
524fca1e7356f8 Naoya Horiguchi         2013-02-22  2550  	 * example is an mlocked page, where PG_mlocked is cleared by
4d8f7418e8ba36 David Hildenbrand       2023-12-20  2551  	 * folio_remove_rmap_*() in try_to_unmap_one(). So to determine page
4d8f7418e8ba36 David Hildenbrand       2023-12-20  2552  	 * status correctly, we save a copy of the page flags at this time.
524fca1e7356f8 Naoya Horiguchi         2013-02-22  2553  	 */
53fbef56e07df8 Matthew Wilcox (Oracle  2025-08-05  2554) 	page_flags = folio->flags.f;
524fca1e7356f8 Naoya Horiguchi         2013-02-22  2555  
e8675d291ac007 yangerkun               2021-06-15  2556  	/*
5dba5c356ab3bb Matthew Wilcox (Oracle  2024-04-12  2557) 	 * __munlock_folio() may clear a writeback folio's LRU flag without
5dba5c356ab3bb Matthew Wilcox (Oracle  2024-04-12  2558) 	 * the folio lock. We need to wait for writeback completion for this
5dba5c356ab3bb Matthew Wilcox (Oracle  2024-04-12  2559) 	 * folio or it may trigger a vfs BUG while evicting inode.
e8675d291ac007 yangerkun               2021-06-15  2560  	 */
5dba5c356ab3bb Matthew Wilcox (Oracle  2024-04-12  2561) 	if (!folio_test_lru(folio) && !folio_test_writeback(folio))
0bc1f8b0682caa Chen Yucong             2014-07-02  2562  		goto identify_page_state;
0bc1f8b0682caa Chen Yucong             2014-07-02  2563  
6edd6cc66201e0 Naoya Horiguchi         2014-06-04  2564  	/*
6edd6cc66201e0 Naoya Horiguchi         2014-06-04  2565  	 * It's very difficult to mess with pages currently under IO
6edd6cc66201e0 Naoya Horiguchi         2014-06-04  2566  	 * and in many cases impossible, so we just avoid it here.
6edd6cc66201e0 Naoya Horiguchi         2014-06-04  2567  	 */
5dba5c356ab3bb Matthew Wilcox (Oracle  2024-04-12  2568) 	folio_wait_writeback(folio);
6a46079cf57a7f Andi Kleen              2009-09-16  2569  
6a46079cf57a7f Andi Kleen              2009-09-16  2570  	/*
6a46079cf57a7f Andi Kleen              2009-09-16  2571  	 * Now take care of user space mappings.
6ffcd825e7d041 Matthew Wilcox (Oracle  2022-06-28  2572) 	 * Abort on fail: __filemap_remove_folio() assumes unmapped page.
6a46079cf57a7f Andi Kleen              2009-09-16  2573  	 */
03468a0f52893b Matthew Wilcox (Oracle  2024-04-12  2574) 	if (!hwpoison_user_mappings(folio, p, pfn, flags)) {
b8b9488d50b715 Jane Chu                2024-05-24  2575  		res = action_result(pfn, MF_MSG_UNMAP_FAILED, MF_FAILED);
171936ddaf97e6 Tony Luck               2021-06-24  2576  		goto unlock_page;
1668bfd5be9d8a Wu Fengguang            2009-12-16  2577  	}
6a46079cf57a7f Andi Kleen              2009-09-16  2578  
6a46079cf57a7f Andi Kleen              2009-09-16  2579  	/*
6a46079cf57a7f Andi Kleen              2009-09-16  2580  	 * Torn down by someone else?
6a46079cf57a7f Andi Kleen              2009-09-16  2581  	 */
5dba5c356ab3bb Matthew Wilcox (Oracle  2024-04-12  2582) 	if (folio_test_lru(folio) && !folio_test_swapcache(folio) &&
5dba5c356ab3bb Matthew Wilcox (Oracle  2024-04-12  2583) 	    folio->mapping == NULL) {
b66d00dfebe79e Kefeng Wang             2022-10-21  2584  		res = action_result(pfn, MF_MSG_TRUNCATED_LRU, MF_IGNORED);
171936ddaf97e6 Tony Luck               2021-06-24  2585  		goto unlock_page;
6a46079cf57a7f Andi Kleen              2009-09-16  2586  	}
6a46079cf57a7f Andi Kleen              2009-09-16  2587  
0bc1f8b0682caa Chen Yucong             2014-07-02  2588  identify_page_state:
0348d2ebec9b00 Naoya Horiguchi         2017-07-10  2589  	res = identify_page_state(pfn, p, page_flags);
ea6d0630100b28 Naoya Horiguchi         2021-06-24  2590  	mutex_unlock(&mf_mutex);
ea6d0630100b28 Naoya Horiguchi         2021-06-24  2591  	return res;
171936ddaf97e6 Tony Luck               2021-06-24  2592  unlock_page:
5dba5c356ab3bb Matthew Wilcox (Oracle  2024-04-12  2593) 	folio_unlock(folio);
171936ddaf97e6 Tony Luck               2021-06-24  2594  unlock_mutex:
171936ddaf97e6 Tony Luck               2021-06-24  2595  	mutex_unlock(&mf_mutex);
6a46079cf57a7f Andi Kleen              2009-09-16  2596  	return res;
6a46079cf57a7f Andi Kleen              2009-09-16  2597  }
cd42f4a3b2b1c4 Tony Luck               2011-12-15  2598  EXPORT_SYMBOL_GPL(memory_failure);
847ce401df392b Wu Fengguang            2009-12-16  2599  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
