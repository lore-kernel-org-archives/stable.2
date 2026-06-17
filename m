Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E45C1ACED5;
	Wed, 17 Jun 2026 04:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781668968; cv=none; b=ncxhywvkhBGLGljIMqndItCUwoogNWPJBLjkD4zER6lnvvOtR4F7cXqRqhso+ejrWxPlXkF4w/4LvvmPQ4gRHuXxCLRjqNx+gvB1wL9DxSrJKEfUcMWP211u8tsdxWLwe/bs2IgAKSfz+d2Cv0/bFUv1lMdG0RA4ZtRZMttaxqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781668968; c=relaxed/simple;
	bh=v3TRQLO8OadiC0coQqe0mnaIFhzyOjLMbqXK3aHjIyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nzy2LHubtaLyK7/+fjHNshRDX9vXOpUDtu8AVo7T8dp6uZwGxqqBoBpqttx6Fi2+Cs72K1jYYKIKPV8zfRZsD+R82MLL5K1FSqCBr6u4cK9/J3v1CLu+qnKGeeA+JKhZORem44ilodKyfdpc2NtrNM0ypO52ZcmoKnqX3AEnSR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X2Da2TKl; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X2Da2TKl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781668967; x=1813204967;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v3TRQLO8OadiC0coQqe0mnaIFhzyOjLMbqXK3aHjIyw=;
  b=X2Da2TKlrbdLZoOni55uTRbJzFJcV+kFBwH+3IU+Rxnr30BpMVJQPi9R
   RrZk6heUGB1gIW69xoN2AJrG3gsD1cVNGcXJ43Sl/v3Jbnth0br0GdbYn
   zDWSx9pUrDyd4cY9kP4ZBkqU5i4TjjhiuiEi9fYy0tzWVtyhV9MddoVsm
   QhcHlz6KNGbR7fNY8JmPjk9jVyecwCydlx2skXAHKIshhy2/+w96a5BbA
   HzqibHC+df/9rd6n6UL04BjPBQ4wzEYkOs7X44waMPU4FhwTwyrbHdAip
   MISPvLev5AtvCi7TYreTePfS4dT9fFMV9nYttdWUZ6y3CqtzAlUSkcn2o
   A==;
X-CSE-ConnectionGUID: PIkxfJcCQM+/TqbvgTpDNA==
X-CSE-MsgGUID: h64X5+kBQkmfyAPB0yaToQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="93121079"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="93121079"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 21:02:46 -0700
X-CSE-ConnectionGUID: 5WRkAdeaQhK+bvjbd87GOA==
X-CSE-MsgGUID: FA7N4ovlQqy/Os+WzPvFWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="248022880"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 16 Jun 2026 21:02:44 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wZhU8-00000000U4o-3KO8;
	Wed, 17 Jun 2026 04:02:40 +0000
Date: Wed, 17 Jun 2026 12:02:23 +0800
From: kernel test robot <lkp@intel.com>
To: Wentao Liang <vulab@iscas.ac.cn>, bhelgaas@google.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	mika.westerberg@linux.intel.com, mani@kernel.org,
	andriy.shevchenko@intel.com, kees@kernel.org, adiyenga@cisco.com,
	vulab@iscas.ac.cn, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] PCI/PTM: fix refcount leak in pci_enable_ptm()
Message-ID: <202606171116.hVjtUYrV-lkp@intel.com>
References: <20260616141733.1688264-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616141733.1688264-1-vulab@iscas.ac.cn>

Hi Wentao,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus westeri-thunderbolt/next linus/master v7.1 next-20260616]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wentao-Liang/PCI-PTM-fix-refcount-leak-in-pci_enable_ptm/20260617-043856
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20260616141733.1688264-1-vulab%40iscas.ac.cn
patch subject: [PATCH] PCI/PTM: fix refcount leak in pci_enable_ptm()
config: powerpc-randconfig-002-20260617 (https://download.01.org/0day-ci/archive/20260617/202606171116.hVjtUYrV-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260617/202606171116.hVjtUYrV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606171116.hVjtUYrV-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/pci/pcie/ptm.c:204:20: error: use of undeclared identifier 'parent'
     204 |                         pci_disable_ptm(parent);
         |                                         ^
   1 error generated.


vim +/parent +204 drivers/pci/pcie/ptm.c

   162	
   163	/**
   164	 * pci_enable_ptm() - Enable Precision Time Measurement
   165	 * @dev: PCI device
   166	 *
   167	 * Enable Precision Time Measurement for @dev.
   168	 *
   169	 * Return: zero if successful, or -EINVAL if @dev lacks a PTM Capability or
   170	 * is not a PTM Root and lacks an upstream path of PTM-enabled devices.
   171	 */
   172	int pci_enable_ptm(struct pci_dev *dev)
   173	{
   174		int rc;
   175		char clock_desc[8];
   176	
   177		/*
   178		 * A device uses local PTM Messages to request time information
   179		 * from a PTM Root that's farther upstream. Every device along
   180		 * the path must support PTM and have it enabled so it can
   181		 * handle the messages. Therefore, if this device is not a PTM
   182		 * Root, the upstream link partner must have PTM enabled before
   183		 * we can enable PTM.
   184		 */
   185		if (!dev->ptm_root) {
   186			struct pci_dev *parent;
   187	
   188			parent = pci_upstream_ptm(dev);
   189			if (!parent)
   190				return -EINVAL;
   191			/* Enable PTM for the parent */
   192			rc = pci_enable_ptm(parent);
   193			if (rc)
   194				return rc;
   195		}
   196	
   197		/* Already enabled? */
   198		if (atomic_inc_return(&dev->ptm_enable_cnt) > 1)
   199			return 0;
   200	
   201		rc = __pci_enable_ptm(dev);
   202		if (rc) {
   203			if (!dev->ptm_root)
 > 204				pci_disable_ptm(parent);
   205			atomic_dec(&dev->ptm_enable_cnt);
   206			return rc;
   207		}
   208	
   209		switch (dev->ptm_granularity) {
   210		case 0:
   211			snprintf(clock_desc, sizeof(clock_desc), "unknown");
   212			break;
   213		case 255:
   214			snprintf(clock_desc, sizeof(clock_desc), ">254ns");
   215			break;
   216		default:
   217			snprintf(clock_desc, sizeof(clock_desc), "%uns",
   218				 dev->ptm_granularity);
   219			break;
   220		}
   221		pci_info(dev, "PTM enabled%s, %s granularity\n",
   222			 dev->ptm_root ? " (root)" : "", clock_desc);
   223	
   224		return 0;
   225	}
   226	EXPORT_SYMBOL(pci_enable_ptm);
   227	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
