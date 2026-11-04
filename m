Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793751476;
	b=NCJge1RWBFPK3ympVgbvL1fcr1jrubNDjCHgaGQfjGfi0ooZ6ujLuSBJCl41NbR9bnaE
	 z8GNhCLkb+C4VJk2fABF73Zrz+W7lvoqhEp7G+zyKhEaEX+Rt1dRE7OcIdCnfAx+VbTeu
	 CMzBS/vpufwVo5PYmRsgbm4ih5vmAsezMp5joFBJWNgZVVoKL1cvKpu5auJkCTbkORyH9
	 zjKXRSIpptdPexON0CXwDvWMnFrlLsNhD3qTseN+8peyNfsPUOZJy4UWd5ylbAwyaOVbD
	 dIKo8oRP/E6AbVTLqSKvEofpdhUw5dgFkKv0ol1//u+rjzVfHSeq25LseXLzrMlkssw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793751476;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=FXAXjRSUbOLjrS4vrWtde+SaB6uZ/+VB41woDrAbWOs=;
	b=FFopj01b5BPRPlbaaB9H867cYTK+6ooq3s/RCXD2jEywjyvugcYWbhNhcWLms9487Dh6
	 ynIhqnLyA5JSvbUN1aSwhduFs5spm180b6N/vgAChtkqDMySBpy9X9e3nL4X4KzO6u2iW
	 DH/qIy9RxE1BQ3parY5fg2llN9Ith7kjDDi6bJqNE51R/AUFeu5NcfDDP4xNgDIH/OLTm
	 ko35qlgh4aYrZGMNncSpMkmDoGa4Bthr+nfh/wKJAcUVK5NHgKF99Nax4iVEqyY/NTl1Y
	 nV3m9E2OoFOeTSOqkQpX8A/khnh2ycNC9J08t9U2NuLwJF20bCIHd7ksjzOw2kKqvwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="DOrkw/4D";
	arc=none smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97882606A324;
	Wed,  4 Nov 2026 00:17:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97882606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DOrkw/4D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793751476; x=1825287476;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/MksnKs3/LA3Id6bFlj3XQy2BHXig5n194B3PRJNlvQ=;
  b=DOrkw/4Dm2r9yDTxegel8WsQ+Zmk7F4j5yYaYGwEauT2pWXVC3fufTXc
   CMoiQHXTYdwpIlqgq5LnsZuhHg0a/v6UTEGukJI1apuP05le/BpeoGnTV
   /0Dv8ivK2aVc1XCHCkKJjsWEkYpFsF0GWSYecK1zhOb/piosG5tEiMctn
   N5wcILMXdZXLdTA9pY+zvUdLn4nw4g8GJXcDyCqpBag7wIobgHYz/qglG
   oB630WrUeS1vhb+165VRmuTRvs2wApaYOagpjYaudfKT/5UBGXq1au2If
   SXUvu6iLMOkW1aBpOkuT1Pg4Baonm5p2iG+FW+vcpMZ6wjqrQ+TloJwa7
   Q==;
X-CSE-ConnectionGUID: rgwhwHCYS2m7ZUtQsRFI5g==
X-CSE-MsgGUID: +NvEHjfmQ7SqeBsW90T73Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2376345"
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="2376345"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 16:17:55 -0800
X-CSE-ConnectionGUID: ExhY+f+vS6SE7GSEwgiZCw==
X-CSE-MsgGUID: iWzs5gGfSFGiwucAwA5ITw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="7116555"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 03 Nov 2026 16:17:54 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xOOhL-00000000jWR-0aqD;
	Wed, 04 Nov 2026 00:17:51 +0000
Date: Wed, 4 Nov 2026 08:17:49 +0800
From: kernel test robot <lkp@intel.com>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	jic23@kernel.org, andy@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] iio: hid-sensors: fix fractional part for unit exponents
 -7 and -8
Message-ID: <202611040803.1mUBmX0y-lkp@intel.com>
References: <20261102222309.439895-1-srinivas.pandruvada@linux.intel.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102222309.439895-1-srinivas.pandruvada@linux.intel.com>

Hi Srinivas,

kernel test robot noticed the following build errors:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on linus/master v7.3 next-20261030]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Srinivas-Pandruvada/iio-hid-sensors-fix-fractional-part-for-unit-exponents-7-and-8/20261102-142308
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20261102222309.439895-1-srinivas.pandruvada%40linux.intel.com
patch subject: [PATCH] iio: hid-sensors: fix fractional part for unit exponents -7 and -8
config: parisc-randconfig-1000-20261104 (https://download.01.org/0day-ci/archive/20261104/202611040803.1mUBmX0y-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261104/202611040803.1mUBmX0y-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611040803.1mUBmX0y-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: drivers/iio/common/hid-sensors/hid-sensor-iio-common.ko: symbol '__udivdi3' undefined!

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
