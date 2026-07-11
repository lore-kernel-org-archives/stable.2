Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D45233149;
	Sat, 11 Jul 2026 09:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783763247; cv=none; b=d5C5nbj3+6BvliByoEoL6ZKs0xT1DA9vb6IVNRW75BLk6M4PDN3oEJbJXYpm+DPd1JNa1+G83mczcQr9lP5qsyYoGz5NFkPKz6SpHYWmKcvKIyF3BoAOxfas7QqK1Rp8LuLxnkqsLoDTzVb9GC2KuuuOlri0a+HZB6svpar1rMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783763247; c=relaxed/simple;
	bh=Myl2BvsXEAApICtxbRdY9p3y0+4hx6JD5C+wzmSOtc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZrvCkZC1px936L+SQiVviIMO5z+ZoNqEMcUCFgzJNSHj1+MMkTUJROiqcnmrpHr13Z8ZUncc1Fn4fI5ZoXi9lu+8+zSDAfwbA8whfAISsa14WDN4kM73+rVCGU6EMNTNJ2h0cd7pJBDuPJtcymiflIh3OwnhJJIN8HtttAGgrgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ObujDkOc; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ObujDkOc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783763246; x=1815299246;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Myl2BvsXEAApICtxbRdY9p3y0+4hx6JD5C+wzmSOtc4=;
  b=ObujDkOcxcgimirjLCQAWpLjx2t8T1CxsyO5JypeWCz1au/8cE3surtE
   3325Tf2zsXnp1PClqe5plaWhbvnd5UxYyXMayEY4cKmQ91QBc92S0gg7S
   qXzMqQm+qfieborY/8/VINksbJDk66aE9dEXN+Le5Ca0ozIobttzgkPEq
   AkFeSoqpLiNnTrLVNY1lNLPuI3u4eCo6oSUIz4lK0YIyna/UOcDwNk1Ul
   NBVNwGT1VFBE7mcB++4roGJ67g7gsLeefNiNMy929Sd1Ox1gNzLlc6KcT
   gai9NkBIGHGB4Sd+fWY4v1xQo9ULsuLoXM7nuutgs34hTbQxKYacb1WM4
   g==;
X-CSE-ConnectionGUID: pSWjaTd4Q1mOuYL8E12JYQ==
X-CSE-MsgGUID: QVoAk7imQE6ZujoNdHW/Nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84498500"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84498500"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 02:47:25 -0700
X-CSE-ConnectionGUID: qoBoc8+uRWGfOe7RGIyXEQ==
X-CSE-MsgGUID: U6O/wZskQk2LG90IzCZg4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="251121304"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 11 Jul 2026 02:47:23 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wiUIq-00000000JxC-0CYt;
	Sat, 11 Jul 2026 09:47:20 +0000
Date: Sat, 11 Jul 2026 17:47:09 +0800
From: kernel test robot <lkp@intel.com>
To: Hongling Zeng <zenghongling@kylinos.cn>, akpm@linux-foundation.org,
	david@fromorbit.com, qi.zheng@linux.dev, roman.gushchin@linux.dev,
	muchun.song@linux.dev
Cc: oe-kbuild-all@lists.linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>, stable@vger.kernel.org
Subject: Re: [PATCH] mm: shrinker: fix double-free in alloc_shrinker_info
 error path
Message-ID: <202607111736.7pLPe0yR-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on v7.2-rc2]
[cannot apply to akpm-mm/mm-everything linus/master next-20260710]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hongling-Zeng/mm-shrinker-fix-double-free-in-alloc_shrinker_info-error-path/20260711-122040
base:   v7.2-rc2
patch link:    https://lore.kernel.org/r/20260711041823.95135-1-zenghongling%40kylinos.cn
patch subject: [PATCH] mm: shrinker: fix double-free in alloc_shrinker_info error path
config: nios2-allmodconfig (https://download.01.org/0day-ci/archive/20260711/202607111736.7pLPe0yR-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260711/202607111736.7pLPe0yR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202607111736.7pLPe0yR-lkp@intel.com/

All warnings (new ones prefixed by >>):

   mm/shrinker.c: In function 'alloc_shrinker_info':
   mm/shrinker.c:108:24: error: implicit declaration of function 'shrinker_info_protected' [-Werror=implicit-function-declaration]
     108 |                 info = shrinker_info_protected(memcg, nid);
         |                        ^~~~~~~~~~~~~~~~~~~~~~~
>> mm/shrinker.c:108:22: warning: assignment to 'struct shrinker_info *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     108 |                 info = shrinker_info_protected(memcg, nid);
         |                      ^
   mm/shrinker.c: At top level:
   mm/shrinker.c:117:30: error: conflicting types for 'shrinker_info_protected'; have 'struct shrinker_info *(struct mem_cgroup *, int)'
     117 | static struct shrinker_info *shrinker_info_protected(struct mem_cgroup *memcg,
         |                              ^~~~~~~~~~~~~~~~~~~~~~~
   mm/shrinker.c:108:24: note: previous implicit declaration of 'shrinker_info_protected' with type 'int()'
     108 |                 info = shrinker_info_protected(memcg, nid);
         |                        ^~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +108 mm/shrinker.c

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

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
