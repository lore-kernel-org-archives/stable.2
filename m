Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7927332B107;
	Sun, 16 Aug 2026 05:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786857441; cv=none; b=Y96l1mz2sPmhVEH9b/jaqifV+5JjnBuGlZwtfvFLA8J66WAm66pCW5SRGv3vHsNCQwuHryOfAFQnnDxS/HEoLCNQuKIkda6dWji2Hjar/PS89Z0rn7JeBrWADji0witQh+Y127MQ3V2aMvx41Av4rYO6o873PaKKEgGkIaMUwik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786857441; c=relaxed/simple;
	bh=VfXD0eRxgae+TtU/Q7eMx8k52VXZwPzo9TG9IGvTy3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uv2/Mle3VGbmcuZ1/yqiPxK09Q/qG6720yTYAOdyAef8jYlpISEII6B4cPT2+VKLPYS5N5nayCRqTVWn6snziwLCQKAd2PF8mEi23rW3zQF4fzd0sJqofpYyDD8YjLv8ynA5dz3fVsg7xkg0A+FL/PBmh623NmW12RFrLdcnh6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=APxwxssp; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="APxwxssp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786857439; x=1818393439;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VfXD0eRxgae+TtU/Q7eMx8k52VXZwPzo9TG9IGvTy3U=;
  b=APxwxssptHj9fX2BboNKByUub6ub0CLpRuA34ThLV2pkaXaDKo0eILCx
   l69mEC99tBAuFjqDlW5V1ROuEvsXtyXeyH8e2QZ6m+4tH3v3RrgakYw9y
   IzTVmSGlBTg3EeakRoXr7zOnZnshKiVvW7h51AZyurKF9xTNh2/93aUly
   xOnRi7tBkFtXagEr6Y/DpBIGpWWwEBF0w/tYQ8kzzKXEPzEHWTBs4hCxc
   fhZbih7yQBkasMblfoyPqkgarwfRyCrmc7r9SQoTPznwSVRjjqnNSNzbz
   irVHC+u4FLFFELckqjfXNiEIE6AIXM0pi8WoSTxpEYgxmEHkvQhHJlBld
   A==;
X-CSE-ConnectionGUID: sDu7aFqZTHKfzd6mUSUjrw==
X-CSE-MsgGUID: s8jqeIomR/CbaeBjbVu3pQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11876"; a="87391590"
X-IronPort-AV: E=Sophos;i="6.25,226,1779174000"; 
   d="scan'208";a="87391590"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2026 22:17:19 -0700
X-CSE-ConnectionGUID: d7JKQlxAQDyjYniT/djYJQ==
X-CSE-MsgGUID: R8KTK66LR/WwXsy1M8Y0vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,226,1779174000"; 
   d="scan'208";a="288079862"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 15 Aug 2026 22:17:17 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wvTFC-00000000ckO-1K5y;
	Sun, 16 Aug 2026 05:17:14 +0000
Date: Sun, 16 Aug 2026 13:16:20 +0800
From: kernel test robot <lkp@intel.com>
To: WenTao Liang <vulab@iscas.ac.cn>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-pci@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kw@linux.com>,
	Bjorn Helgaas <helgaas@kernel.org>, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, WenTao Liang <vulab@iscas.ac.cn>
Subject: Re: [PATCH] fix: PCI: dra7xx: dra7xx_pcie_probe: fix missing
 device_link_del on phy   error paths
Message-ID: <202608161318.LcyznJeH-lkp@intel.com>
References: <20260626154809.53770-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626154809.53770-1-vulab@iscas.ac.cn>

Hi WenTao,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus linus/master v7.2-rc7 next-20260814]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/WenTao-Liang/fix-PCI-dra7xx-dra7xx_pcie_probe-fix-missing-device_link_del-on-phy-error-paths/20260815-023710
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20260626154809.53770-1-vulab%40iscas.ac.cn
patch subject: [PATCH] fix: PCI: dra7xx: dra7xx_pcie_probe: fix missing device_link_del on phy   error paths
config: arm64-randconfig-001-20260816 (https://download.01.org/0day-ci/archive/20260816/202608161318.LcyznJeH-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 844a18e753e822736c9805ab779144b647a2c186)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260816/202608161318.LcyznJeH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608161318.LcyznJeH-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/pci/controller/dwc/pci-dra7xx.c:918:8: error: use of undeclared label 'err_link'
     918 |                 goto err_link;
         |                      ^
   1 error generated.


vim +/err_link +918 drivers/pci/controller/dwc/pci-dra7xx.c

   908	
   909	static int dra7xx_pcie_resume_noirq(struct device *dev)
   910	{
   911		struct dra7xx_pcie *dra7xx = dev_get_drvdata(dev);
   912		int ret;
   913	
   914		ret = dra7xx_pcie_enable_phy(dra7xx);
   915		if (ret) {
   916			dev_err(dev, "failed to enable phy\n");
   917			dra7xx_pcie_disable_phy(dra7xx);
 > 918			goto err_link;
   919		}
   920	
   921		return 0;
   922	}
   923	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
