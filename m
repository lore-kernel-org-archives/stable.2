Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A9F391836;
	Sat, 11 Jul 2026 13:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783776438; cv=none; b=VvDHwc1eH8NsirUuVMR45Gs45wLhhuAfZXOUspvxI2te5RcIDjABoJBvkMGhOA+M1XL6S/xLpvWVwIkDESOpxEp3Aog8yf5/GcPWuVIl7roXT1Hob1+YY7pBUOMPqNkn1xBO47T8wzpvgwF7T94N0e9ZCU2D0aWBkcHDuw8pb4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783776438; c=relaxed/simple;
	bh=QMRwmmcabKQsDt2EYSGPCKTrdu5/Efzn6kpB0nGGT5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AJLNt5e2bWSWyBEg8AtNKnSRHE9JX/o0dfgm+J2aV/hYoWC39czGQGd/Kyz1i79Ei7RVn8a9TnETB6udFYQxnJ5dnm47HCMZFPixqEp40MyRUiSg+jxV0MhOOcjNjnaZkuwxIwfdPFPL2bZfy6x61N4qTlXT8UNY0+1e+oHW4Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=djXpW8DF; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="djXpW8DF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783776436; x=1815312436;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QMRwmmcabKQsDt2EYSGPCKTrdu5/Efzn6kpB0nGGT5U=;
  b=djXpW8DFMmytLvE1Cx8JRGjkJNqI+wiQpFIdY3cG8EKt05qqArilIeCo
   FNNHV1NyX22lJkrJxU+u/aIFYWuxolBg2PZoE43bgrXN0ZS/gBavJDq3S
   ESDXUXlFgB1A287pafKKoYlLIfcBAtjLJTpxCK+pP+0EXBW1KXh65DRHr
   yCexhtb7boIkS7aYr0McrQIJhPi2NPpbi8XaUcPgR4jkey1H30pvgJTYG
   IWfoFLxHShzVacVLH3UfTIi4Su9btUz/YVrSISVaNkQ+CMttilBu+zzZQ
   w8jWXbd0Tr5K0PuQUWVdNePP/X2Y2Tyh5/4Y+HWBCYg39RB5a5RMinBNf
   w==;
X-CSE-ConnectionGUID: cvtnhsEtSumsSnUzwNSymw==
X-CSE-MsgGUID: tUe4TjNyTLiv6RzcUQlD/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84649717"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84649717"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 06:27:16 -0700
X-CSE-ConnectionGUID: km0FdE8EQwS8E6vFC4DnIw==
X-CSE-MsgGUID: AFD9okqYQpmb3ZBBQN83ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="250711149"
Received: from igk-lkp-server01.igk.intel.com (HELO e5a8ed462067) ([10.211.93.152])
  by fmviesa006.fm.intel.com with ESMTP; 11 Jul 2026 06:27:13 -0700
Received: from kbuild by e5a8ed462067 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wiXja-000000003M9-3DKs;
	Sat, 11 Jul 2026 13:27:10 +0000
Date: Sat, 11 Jul 2026 15:27:06 +0200
From: kernel test robot <lkp@intel.com>
To: Hongling Zeng <zenghongling@kylinos.cn>, akpm@linux-foundation.org,
	david@fromorbit.com, qi.zheng@linux.dev, roman.gushchin@linux.dev,
	muchun.song@linux.dev
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>, stable@vger.kernel.org
Subject: Re: [PATCH] mm: shrinker: fix double-free in alloc_shrinker_info
 error path
Message-ID: <202607111559.uTGMAUhC-lkp@intel.com>
References: <20260711041823.95135-1-zenghongling@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260711041823.95135-1-zenghongling@kylinos.cn>

Hi Hongling,

kernel test robot noticed the following build errors:

[auto build test ERROR on v7.2-rc2]
[cannot apply to akpm-mm/mm-everything linus/master next-20260710]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hongling-Zeng/mm-shrinker-fix-double-free-in-alloc_shrinker_info-error-path/20260711-122040
base:   v7.2-rc2
patch link:    https://lore.kernel.org/r/20260711041823.95135-1-zenghongling%40kylinos.cn
patch subject: [PATCH] mm: shrinker: fix double-free in alloc_shrinker_info error path
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260711/202607111559.uTGMAUhC-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260711/202607111559.uTGMAUhC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202607111559.uTGMAUhC-lkp@intel.com/

All errors (new ones prefixed by >>):

>> mm/shrinker.c:108:10: error: call to undeclared function 'shrinker_info_protected'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     108 |                 info = shrinker_info_protected(memcg, nid);
         |                        ^
>> mm/shrinker.c:108:8: error: incompatible integer to pointer conversion assigning to 'struct shrinker_info *' from 'int' [-Wint-conversion]
     108 |                 info = shrinker_info_protected(memcg, nid);
         |                      ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> mm/shrinker.c:117:30: error: conflicting types for 'shrinker_info_protected'
     117 | static struct shrinker_info *shrinker_info_protected(struct mem_cgroup *memcg,
         |                              ^
   mm/shrinker.c:108:10: note: previous implicit declaration is here
     108 |                 info = shrinker_info_protected(memcg, nid);
         |                        ^
   3 errors generated.


vim +/shrinker_info_protected +108 mm/shrinker.c

    76	
    77	int alloc_shrinker_info(struct mem_cgroup *memcg)
    78	{
    79		int nid, ret = 0;
    80		int array_size = 0;
    81		int failed_nid;
    82	
    83		mutex_lock(&shrinker_mutex);
    84		array_size = shrinker_unit_size(shrinker_nr_max);
    85		for_each_node(nid) {
    86			struct shrinker_info *info = kvzalloc_node(sizeof(*info) + array_size,
    87								   GFP_KERNEL, nid);
    88			if (!info)
    89				goto err;
    90			info->map_nr_max = shrinker_nr_max;
    91			if (shrinker_unit_alloc(info, NULL, nid)) {
    92				kvfree(info);
    93				goto err;
    94			}
    95			rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, info);
    96		}
    97		mutex_unlock(&shrinker_mutex);
    98	
    99		return ret;
   100	
   101	err:
   102		failed_nid = nid;
   103		for_each_node(nid) {
   104			struct shrinker_info *info;
   105	
   106			if (nid >= failed_nid)
   107				break;
 > 108			info = shrinker_info_protected(memcg, nid);
   109			rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, NULL);
   110			shrinker_unit_free(info, 0);
   111			kvfree(info);
   112		}
   113		mutex_unlock(&shrinker_mutex);
   114		return -ENOMEM;
   115	}
   116	
 > 117	static struct shrinker_info *shrinker_info_protected(struct mem_cgroup *memcg,
   118							     int nid)
   119	{
   120		return rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_info,
   121						 lockdep_is_held(&shrinker_mutex));
   122	}
   123	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
