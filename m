Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED31948EBE8;
	Wed, 19 Aug 2026 16:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787158783; cv=none; b=JCuK/o/jmBIdT0XhcPfHOC1hxxIIxDYgHnGSrAG2aUJV9UmQSe7cuDQ2sVXPmOSz/U/0dy18lQEzoEVxLdqn54U+MzX0H2p2Q2oPT5nrvmakVhmMeHEGxfF+VpMsYkipzTS52AuAY6Jk3Sh+Hi8AGNaZ3MXtc30fcfV3wGaolCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787158783; c=relaxed/simple;
	bh=IOTVPUO0ZiUEmg41bEMQ7kpDRfBcTt+r8BmdyGIX5b8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qgycRpww+dWCEuqwjj0+v6fLwN/5NdfbIMVzOCiLijm/fHc2X3Dv2IWk3aPvzg+N2aV2HDIo4blliJ6sfk3yPnHsKhA1RGsHWuuIt5S/f7+mkpYkTEsaD6eHKnmUZ1KH7iJzi/M9tsXrbXzRAie2Jsk7GryBdBmCwy4OI1OPSZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QxwxhnD9; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QxwxhnD9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787158779; x=1818694779;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IOTVPUO0ZiUEmg41bEMQ7kpDRfBcTt+r8BmdyGIX5b8=;
  b=QxwxhnD9k9DKEiyjok9/1A5MYelgEIPPP0zY1XesOf2L1heJbBKatM7k
   FM4qOy0vBvGvR6pMgPqkZmONcjiu35CnzX+TtzeFw6bBHsFlNZ9V3IjGI
   k8WgPR3pDoPTzHp7SzTRoLXrCZtxPg2/tuvviw6fIK8t9+Ps0PQPUQ6FQ
   IS6L/FesJFuSVcukbLYvkyrDp0Yr/M6uCRFZO6ESy9dvs1xnxXcSj5HTj
   kId7tL0uX+uSJMXyD1kPYddzQelp2H/a7eYyYSc3Q9gr5/wDC+1VmfWn4
   URq4Ev+Va3mn82Ses6vrgQ7bME5CWAciz09tROqpkzh3RrZDVwQFZHmtH
   w==;
X-CSE-ConnectionGUID: RIByvNkkQ3erYLIuye7Hfg==
X-CSE-MsgGUID: +GrnD7iTRzGFZ3otHB9Kyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="98352302"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="98352302"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 09:59:37 -0700
X-CSE-ConnectionGUID: UL1gamXjRPOcD03otLMATg==
X-CSE-MsgGUID: i6PhILTnTgKZeR+SeSVNgA==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 19 Aug 2026 09:59:33 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wwjdS-00000000fqn-15qv;
	Wed, 19 Aug 2026 16:59:30 +0000
Date: Thu, 20 Aug 2026 00:59:06 +0800
From: kernel test robot <lkp@intel.com>
To: Konstantin Fastov <kfastov@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>
Cc: oe-kbuild-all@lists.linux.dev, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	David Hildenbrand <david@kernel.org>,
	Boris Brezillon <bbrezillon@kernel.org>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev, stable@vger.kernel.org,
	Konstantin Fastov <kfastov@gmail.com>
Subject: Re: [PATCH] drm/gem-shmem: Install writable PTEs for write faults
Message-ID: <202608200018.9K0vPu3P-lkp@intel.com>
References: <20260804140403.16337-1-kfastov@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804140403.16337-1-kfastov@gmail.com>

Hi Konstantin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on drm-misc/drm-misc-next linus/master v7.2 next-20260818]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Konstantin-Fastov/drm-gem-shmem-Install-writable-PTEs-for-write-faults/20260804-170403
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20260804140403.16337-1-kfastov%40gmail.com
patch subject: [PATCH] drm/gem-shmem: Install writable PTEs for write faults
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20260820/202608200018.9K0vPu3P-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260820/202608200018.9K0vPu3P-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608200018.9K0vPu3P-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: mm/memory.c:2887 function parameter 'mkwrite' not described in '__vmf_insert_pfn_prot'
>> Warning: mm/memory.c:2887 expecting prototype for vmf_insert_pfn_prot(). Prototype was for __vmf_insert_pfn_prot() instead

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
