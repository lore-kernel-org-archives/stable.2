Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9844C48BD2F;
	Fri,  5 Jun 2026 08:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780646896; cv=none; b=etxl0Xrsu5liCcHVF0SbSepoLWTdm8D4LMFuudAvmYQP4ob1Rrh4tzQep5uWjQFgkWrkz/s02qZbX97cs90aPKm/Kj1xhCqjS2FmdVIqLOg73fBcx4z0a/pKySC4pnAupNKEZz+S6G9dPpFBQyAZ1gKveoafYjcGGbZIiTEiKnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780646896; c=relaxed/simple;
	bh=0CCvZFCoz8MQYHFETcZzaIs2wCrCUe0u91eQVSo2Cv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bL0BaruYxHMWrF0grPwDnRn3c1jPf+8mH6UJFOikf8tV/+c9WHnpNNGv9PcJ4VZ1GdyzdxEaNjC44SIWXli2HpFYFFCfE1yA0u8ZKHqmKA2qaAWkAjJStOk6HC158sGE+wo5W7AR8tblsIwNM+bIutTUxAzRkkLnsdXwNGWuO2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R8qErh0h; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R8qErh0h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780646895; x=1812182895;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0CCvZFCoz8MQYHFETcZzaIs2wCrCUe0u91eQVSo2Cv8=;
  b=R8qErh0hYA+by6VcfrDmIk1jqv/eJD1Px4/KrMassTe9ofxEdNu28Fni
   AZ5I4Owy96E0sBFOx+1+K/5Ni/MMWVsfsLp1O54uXh5bKUI6qKxzvPEUm
   41MNjyVN/f8rnicGwZFM3DkMjAh8J7yRKO3MVHddhi0kCydxJWPKppCan
   5FdYsA72RAIDhxzWBYOP2/ynrm1JMMXzCNtzaDYTXobhdaf+HBMo6/97b
   r7Wwbfp66QILu71MIBxfANfeS7s8fmGc9nhPS5XHOCPfxRXkoVhXDJFU4
   POeo6SLG7FYLRxllRKJvooAyYwinwphDj55c6SeP4aS9ZhCJHCkMvsPNQ
   g==;
X-CSE-ConnectionGUID: x5BbC/uJRn69WxYuBejlJA==
X-CSE-MsgGUID: LY1ETgTBTkSdTuXhe4epLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="92965797"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="92965797"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 01:08:15 -0700
X-CSE-ConnectionGUID: Nl+72zvvSDGF2AEiyZlixQ==
X-CSE-MsgGUID: aZH4O/5ZS+KMnMhXfE5Jag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="282867931"
Received: from igk-lkp-server01.igk.intel.com (HELO 892db79562d4) ([10.211.93.152])
  by orviesa001.jf.intel.com with ESMTP; 05 Jun 2026 01:08:11 -0700
Received: from kbuild by 892db79562d4 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wVPb7-000000002Vt-0A7U;
	Fri, 05 Jun 2026 08:08:09 +0000
Date: Fri, 5 Jun 2026 10:07:10 +0200
From: kernel test robot <lkp@intel.com>
To: Cheng Ming Lin <linchengming884@gmail.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Takahiro Kuwano <takahiro.kuwano@infineon.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org, alvinzhou@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mtd: spi-nor: macronix: Restore fallback
 parameters for MX25L12805D
Message-ID: <202606051000.gRYPMoXy-lkp@intel.com>
References: <20260605005720.1857413-3-linchengming884@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605005720.1857413-3-linchengming884@gmail.com>

Hi Cheng,

kernel test robot noticed the following build errors:

[auto build test ERROR on mtd/spi-nor/next]
[also build test ERROR on linus/master v7.1-rc6 next-20260604]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Cheng-Ming-Lin/mtd-spi-nor-Add-support-for-MX25L12833F-and-MX25L12845G/20260605-090612
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git spi-nor/next
patch link:    https://lore.kernel.org/r/20260605005720.1857413-3-linchengming884%40gmail.com
patch subject: [PATCH v2 2/2] mtd: spi-nor: macronix: Restore fallback parameters for MX25L12805D
config: x86_64-rhel-9.4-func (https://download.01.org/0day-ci/archive/20260605/202606051000.gRYPMoXy-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260605/202606051000.gRYPMoXy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606051000.gRYPMoXy-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/mtd/spi-nor/macronix.c:119:22: error: initialization of 'int (*)(struct spi_nor *, const struct sfdp_parameter_header *, const struct sfdp_bfpt *)' from incompatible pointer type 'int (*)(struct spi_nor *)' [-Wincompatible-pointer-types]
     119 |         .post_bfpt = mx25l12805d_4pp3b_post_bfpt_fixups,
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/mtd/spi-nor/macronix.c:119:22: note: (near initialization for 'mx25l12805d_4pp3b_fixups.post_bfpt')


vim +119 drivers/mtd/spi-nor/macronix.c

   117	
   118	static const struct spi_nor_fixups mx25l12805d_4pp3b_fixups = {
 > 119		.post_bfpt = mx25l12805d_4pp3b_post_bfpt_fixups,
   120	};
   121	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
