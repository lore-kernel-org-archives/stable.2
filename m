Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5F647F773;
	Fri, 18 Sep 2026 11:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789732235; cv=none; b=Yvdi/BHAVbXVBcSud/zAkAXKsce2lDXRGfH/IBa8UZ5ggoCRkum6JCGleEHmXh/ahxCeShgkhfPhESuIxBnudU5a5/5QZfuVr4o+xf1Jsh2tOsNXvuK4BZ+GO2JTkYVqjhI16fSorx8CYPLEGj3hV9yDptvkr78f83wvJNyXa0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789732235; c=relaxed/simple;
	bh=M3PKuP+ZuLN2R57TyQdFDTeRL/N6gNhBhoZkvXSsgEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUI0MICdK8gWrsp3sdPRMbAJwWwcZJYeflrPHmXH+cU9Kvyerx2uIHIaGPjzXULGGHqn6w2Lz2z7xNRjVqAgXBH92JIWIzEL5UV2iSQp0Y9z8OnJrEj9uNQKtoVraycOzlWru8qLD6EANBuBTmDG/rrxFFzQhcZfaeyJ4kJVr9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J+vMRqqy; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J+vMRqqy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789732233; x=1821268233;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M3PKuP+ZuLN2R57TyQdFDTeRL/N6gNhBhoZkvXSsgEw=;
  b=J+vMRqqyk3CFnbRZ0XhbQpVI9QuEmA6AxqCeFvi2LvgaFiAPllbJF0bC
   GUGmXQRCz4gDOGS8kXjJd0dxeo7Ss46xxrDKn27pcqoPiGY+5L9UQYrIM
   r0i2F2xUmYBcnHqG0JQJRjlSOPNnlr/wHRIFNjRczAPNeYNY8l9YnLIdp
   3tyWL33oKDAKxZDhJ3zuIiEW+vo1aUPbxrk54GSa7sYhAaNVQr5TlNzJk
   fTt6F5ptlAo1kSSyWCHjGDAs5w3xJss2zDx/aazLYDnQ/uOrF0nCJZEsB
   3X+fZJk/qdnCTpVQVqjUn23Q0KbqPGyJg7gmFKHiQTA+tGagA+eXq+SwX
   Q==;
X-CSE-ConnectionGUID: NW4mM5JuQ0CJpec0f3QMmg==
X-CSE-MsgGUID: 83HcDN48R+SlLupyGALehg==
X-IronPort-AV: E=McAfee;i="6800,10657,11908"; a="90364730"
X-IronPort-AV: E=Sophos;i="6.27,108,1787036400"; 
   d="scan'208";a="90364730"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 04:50:32 -0700
X-CSE-ConnectionGUID: YjCwekh+Rg6Oe3AG//pnvw==
X-CSE-MsgGUID: E+S0OuYLSQ2n+eTUm+aEnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,108,1787036400"; 
   d="scan'208";a="2597426"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by fmviesa011.fm.intel.com with ESMTP; 18 Sep 2026 04:50:29 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x7X6o-000000009jx-2ZaJ;
	Fri, 18 Sep 2026 11:50:26 +0000
Date: Fri, 18 Sep 2026 19:50:23 +0800
From: kernel test robot <lkp@intel.com>
To: Wentao Liang <vulab@iscas.ac.cn>, Liviu.Dudau@arm.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	bhelgaas@google.com, kwilczynski@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, lpieralisi@kernel.org, mani@kernel.org,
	robh@kernel.org, tinamdar@apm.com, toan@os.amperecomputing.com,
	Wentao Liang <vulab@iscas.ac.cn>, stable@vger.kernel.org
Subject: Re: [PATCH] PCI: xgene: Fix device node reference leak in
 xgene_pcie_probe()
Message-ID: <202609181924.6ZUpd4Ww-lkp@intel.com>
References: <20260917132235.2153154-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917132235.2153154-1-vulab@iscas.ac.cn>

Hi Wentao,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus linus/master v7.3-rc3 next-20260916]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wentao-Liang/PCI-xgene-Fix-device-node-reference-leak-in-xgene_pcie_probe/20260917-132235
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20260917132235.2153154-1-vulab%40iscas.ac.cn
patch subject: [PATCH] PCI: xgene: Fix device node reference leak in xgene_pcie_probe()
config: riscv-randconfig-1001-20260918 (https://download.01.org/0day-ci/archive/20260918/202609181924.6ZUpd4Ww-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 7252edd9aa82ef1c570ff6694ef7f4763a8a5d2f)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260918/202609181924.6ZUpd4Ww-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609181924.6ZUpd4Ww-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/pci/controller/pci-xgene.c:646:20: error: no member named 'node' in 'struct xgene_pcie'
     646 |         of_node_put(port->node);
         |                     ~~~~  ^
   1 error generated.


vim +646 drivers/pci/controller/pci-xgene.c

   603	
   604	static int xgene_pcie_probe(struct platform_device *pdev)
   605	{
   606		struct device *dev = &pdev->dev;
   607		struct xgene_pcie *port;
   608		struct pci_host_bridge *bridge;
   609		int ret;
   610	
   611		if (!xgene_check_pcie_msi_ready())
   612			return dev_err_probe(&pdev->dev, -EPROBE_DEFER,
   613					     "MSI driver not ready\n");
   614	
   615		bridge = devm_pci_alloc_host_bridge(dev, sizeof(*port));
   616		if (!bridge)
   617			return -ENOMEM;
   618	
   619		port = pci_host_bridge_priv(bridge);
   620	
   621		port->dev = dev;
   622		port->version = XGENE_PCIE_IP_VER_1;
   623	
   624		ret = xgene_pcie_map_reg(port, pdev);
   625		if (ret)
   626			goto err_put_node;
   627	
   628		ret = xgene_pcie_init_port(port);
   629		if (ret)
   630			goto err_put_node;
   631	
   632		ret = xgene_pcie_setup(port);
   633		if (ret)
   634			goto err_put_node;
   635	
   636		bridge->sysdata = port;
   637		bridge->ops = &xgene_pcie_ops;
   638	
   639		ret = pci_host_probe(bridge);
   640		if (ret)
   641			goto err_put_node;
   642	
   643		return 0;
   644	
   645	err_put_node:
 > 646		of_node_put(port->node);
   647		return ret;
   648	}
   649	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
