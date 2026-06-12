Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32BC20C00C;
	Fri, 12 Jun 2026 10:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781261521; cv=none; b=LzlA8YS3/TfisX08N/dg5nd7J/aJlWmS9yWuKh8Ps5Xycxc+UHwfOEA/EeTXMNPg6qrl1F1LX7KhjpBbmpDrDq0fgoi05/OtYQEjHRW2GuQ7J1rWB4dJ9XK11iHn+2JvHmudBRcdk4ivAGpboePKJmM8OxVYyOnU6ANK5M0p6Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781261521; c=relaxed/simple;
	bh=pMOnB/VdBXmdUjIVbiD9nrvItT0vIkK1YmjB2wpMXxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B14Xsq007rA3eEzTCiiZBBuNbJE2xOwiwdNEW8HsjE35j99pZAI8Jr50D2g1Pc20RtEP+Da4xbTWR4JFwG0j4UFE5bPJdDnbP/Dsx080ZeGJmzrw0vrb36nCwVZjY/GpW5SsELoXwds1lm4+juWCwbVT5t14XKYe+AlE5bmXtIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ROG16Wg1; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ROG16Wg1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781261518; x=1812797518;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pMOnB/VdBXmdUjIVbiD9nrvItT0vIkK1YmjB2wpMXxQ=;
  b=ROG16Wg1KhrMWbKcNk5AWmYsE6lr7ewwPhPJxc66EO3FWyu1rzgesx06
   hEbQYFiBIspy9zIAMNILIr2Swxg4uIwLCOB3dk7IvWEUlgYYk9aaxHKxY
   j55N+KAFDEjMl/OMeuj33pcIppEVkHCfO35jogXGvqU+4A/jpb1Tud+Vn
   w9qb9DI5DNVsL7m11zsLe8dCePoSJLUn+Lx2DVoaf/moPKUvjytQTypHU
   EFeiuq6ALN5y8fmDcVSu/sokad7YxU9moOCIFjN8KTUIq99gZ2y0zCsT+
   8Bz7bKg0M6g3QSEjVFT0oNj6fOLltp0LUR64GFWstnpz/uCP3VUKSp8OY
   A==;
X-CSE-ConnectionGUID: gzHeI798RLqvVJKvPLnBFA==
X-CSE-MsgGUID: smLuZ+gRSwuIHMk9q1eurQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="81225541"
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="81225541"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 03:51:57 -0700
X-CSE-ConnectionGUID: +m0b2O1nRG2ZVT/wGcft6Q==
X-CSE-MsgGUID: K7G8RJqfQ3ytrgkqBeLqGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="270834789"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 12 Jun 2026 03:51:55 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wXzUO-00000000OdB-1fzT;
	Fri, 12 Jun 2026 10:51:52 +0000
Date: Fri, 12 Jun 2026 18:51:04 +0800
From: kernel test robot <lkp@intel.com>
To: Kyle Zeng <kylebot@openai.com>, jfs-discussion@lists.sourceforge.net
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Dave Kleikamp <shaggy@kernel.org>, outbounddisclosures@openai.com,
	Kyle Zeng <kylebot@openai.com>, stable@vger.kernel.org
Subject: Re: [PATCH] jfs: validate active AG before updating db_active
Message-ID: <202606121834.MtsXleJq-lkp@intel.com>
References: <20260611212956.10206-1-kylebot@openai.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611212956.10206-1-kylebot@openai.com>

Hi Kyle,

kernel test robot noticed the following build errors:

[auto build test ERROR on brauner-vfs/vfs.all]
[also build test ERROR on linus/master kleikamp-shaggy/jfs-next v7.1-rc7 next-20260611]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kyle-Zeng/jfs-validate-active-AG-before-updating-db_active/20260612-054255
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20260611212956.10206-1-kylebot%40openai.com
patch subject: [PATCH] jfs: validate active AG before updating db_active
config: s390-defconfig (https://download.01.org/0day-ci/archive/20260612/202606121834.MtsXleJq-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260612/202606121834.MtsXleJq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606121834.MtsXleJq-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/jfs/file.c:52:3: error: call to undeclared function 'jfs_error'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      52 |                 jfs_error(inode->i_sb,
         |                 ^
   fs/jfs/file.c:52:3: note: did you mean 'xas_error'?
   include/linux/xarray.h:1435:19: note: 'xas_error' declared here
    1435 | static inline int xas_error(const struct xa_state *xas)
         |                   ^
   1 error generated.


vim +/jfs_error +52 fs/jfs/file.c

    43	
    44	static int jfs_get_active_ag(struct inode *inode, int *agp)
    45	{
    46		struct jfs_inode_info *ji = JFS_IP(inode);
    47		struct jfs_sb_info *sbi = JFS_SBI(inode->i_sb);
    48		struct bmap *bmap = sbi->bmap;
    49		u64 ag = BLKTOAG(addressPXD(&ji->ixpxd), sbi);
    50	
    51		if (ag >= bmap->db_numag) {
  > 52			jfs_error(inode->i_sb,
    53				  "inode %lu has invalid active ag %llu\n",
    54				  inode->i_ino, (unsigned long long)ag);
    55			return -EIO;
    56		}
    57	
    58		*agp = ag;
    59		return 0;
    60	}
    61	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
