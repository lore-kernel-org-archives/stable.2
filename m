Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF61236F91C;
	Wed, 17 Jun 2026 07:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781681950; cv=none; b=tmjnPTX7GO3d6bMFI8QMAaZkERgEdMLsYE3ogKZi6KZ2+k19sJS9uoDjEErm7/QgavDgclFpoMFHvzHSsLEVwm942DrijT868sh1uAZgwkPS2ANdDHwbwH5MMCAnNW5Kt8NtoZ96srm1mfDobtXtAepEFKVZjjbDkEDHB6F/iFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781681950; c=relaxed/simple;
	bh=CpEDmXb91/TWr4Fgpip+CAc92egKL1pPgELfKsjl1QI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XWoopfy3pbCO4sCjYJ7ThQUdKDqNTPzujzPFlvmiAVJ2mLWC0NVMgADvOoFXzQBMkj9AuxQNGcLR7Bd6q/77pQ2V2EoUjmzA8DKUS33uHJtml4lbpsp65TF82+DgbbIu9YkQHPvNKlARq9m9Wc9/JccOEzWg23LXkslpOzX/9fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rpbq/1Qo; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rpbq/1Qo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781681948; x=1813217948;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CpEDmXb91/TWr4Fgpip+CAc92egKL1pPgELfKsjl1QI=;
  b=Rpbq/1QoNmxxxJqah3/RpyeCuGDf7FdL58hx3uEI4mn+oFkxU1HDZUFF
   JMvTP7MVokOuuR4zIGWEdCcjwiHSoVR8hfTBgKYdSJQvPBrGACQlTD0mU
   i6BZjlL0ewK9KxRTzdrNoxbtslRYyOOpaeSwda/x3XyeAp3stfbnB/5Dg
   FzMw3nYci3RZ+CYElwDr8HfM07LNWhPyDpwfLDnzfIvqcw43Cwlm1LvDi
   gE5TusBVIJaplak7auz97mwzuQeoC1WEt8ilqN4JKkwN0UW6B7PCGDRyz
   4aD8pvSaHiiD4ZdrCcDDJmntHIRmoEFpheDh92gmCBlu/lC04NIQCEpfo
   w==;
X-CSE-ConnectionGUID: PYn87Q3DSHC7wUs5xcCFNA==
X-CSE-MsgGUID: cKJR55rDS2mAjjrYIc9tbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="100031244"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="100031244"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 00:39:07 -0700
X-CSE-ConnectionGUID: l0E97XhTTf2fm8AXVgu/fA==
X-CSE-MsgGUID: YrCctxhzQWKGcZNHsJIm4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="243620213"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 17 Jun 2026 00:39:04 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wZkrW-00000000UF0-0LUj;
	Wed, 17 Jun 2026 07:39:02 +0000
Date: Wed, 17 Jun 2026 15:38:57 +0800
From: kernel test robot <lkp@intel.com>
To: Wentao Liang <vulab@iscas.ac.cn>, bhelgaas@google.com
Cc: oe-kbuild-all@lists.linux.dev, mika.westerberg@linux.intel.com,
	mani@kernel.org, andriy.shevchenko@intel.com, kees@kernel.org,
	adiyenga@cisco.com, vulab@iscas.ac.cn, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] PCI/PTM: fix refcount leak in pci_enable_ptm()
Message-ID: <202606171537.E42T5ZLo-lkp@intel.com>
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
config: s390-randconfig-r072-20260617 (https://download.01.org/0day-ci/archive/20260617/202606171537.E42T5ZLo-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 8.5.0
smatch: v0.5.0-9185-gbcc58b9c
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260617/202606171537.E42T5ZLo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606171537.E42T5ZLo-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pci/pcie/ptm.c: In function 'pci_enable_ptm':
>> drivers/pci/pcie/ptm.c:204:20: error: 'parent' undeclared (first use in this function); did you mean 'xa_parent'?
       pci_disable_ptm(parent);
                       ^~~~~~
                       xa_parent
   drivers/pci/pcie/ptm.c:204:20: note: each undeclared identifier is reported only once for each function it appears in


vim +204 drivers/pci/pcie/ptm.c

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
