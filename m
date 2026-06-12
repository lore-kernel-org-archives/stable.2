Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A927736657B;
	Fri, 12 Jun 2026 09:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781257555; cv=none; b=WACWWD8qupbbb2BGuiaUn968SB6isd849loVKdYpC/rCezH2s6iJyQNb6+LBzEGNI/cfcFYL1vNz1jcdX6+UGMpSRdjZza55vWxF7ub7sTjxK5LNIc6XA79rLepVF2ecp0hGDMmCBuej6BON7ZkpnyvkWvNJ51gpTWk+/mRr/V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781257555; c=relaxed/simple;
	bh=5kZYGlAIeZV0FMnxTw7YDi5SkMcsdsV5OoS4J4WqUhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cB3YYO4YHHrypzUKSDHem7JyoKqwR8U9r+nsPXUdOo/g31bOQtJMkP8dsCBP12e/oOc3R6hfnAsHXk+FoSk+wqvweqKPkU3cGTyZyIg4rVt61POMUywImseggioL11iEDMbvBYzEONbhQhCRXXdjCpbIYLC9RH3LDDOgjnq3cpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eD0RBu9b; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eD0RBu9b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781257554; x=1812793554;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5kZYGlAIeZV0FMnxTw7YDi5SkMcsdsV5OoS4J4WqUhw=;
  b=eD0RBu9bwRYnNWh+qQoO7sankAGw9m1EP50hbHA1iTQSXui4G1RI0qQ6
   /KWAwFpPYP2SSZ4K4cPggt2AsWgoONhAzvbjIzyBxpbYTs7Td4seO+XAT
   elF9UUkVJMfYzpJkZFomiLCZ5+RWQbOXy1QrTDmgIpvqanHMBcJXtM4wk
   Y43D28cf61eJQ+7cqn4DzTnziNIbSjZdCHr6FqaLOVXB8wCrzqAWXry/a
   DuHmlEqd3CYsGbzIPczl5m2OQftGP4VcL/eRVEFBYsskY6NLKjWz9H+WC
   oBfphyh1Lits20rIh6f2Nl2BV1YDfsSc23Sq4fG405X3XxgLmxtMqG9sW
   A==;
X-CSE-ConnectionGUID: XazpO8uESweiLnUpBRdD6A==
X-CSE-MsgGUID: Ry12DRWaSXG8/2GglOfLyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="81992484"
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="81992484"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 02:45:53 -0700
X-CSE-ConnectionGUID: XwyvusprSpCsORDhyLtpDQ==
X-CSE-MsgGUID: vltGDbzWR7+p4T3OmRE3wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="248664732"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 12 Jun 2026 02:45:51 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wXySS-00000000OZl-3xFe;
	Fri, 12 Jun 2026 09:45:48 +0000
Date: Fri, 12 Jun 2026 17:45:39 +0800
From: kernel test robot <lkp@intel.com>
To: Kyle Zeng <kylebot@openai.com>, jfs-discussion@lists.sourceforge.net
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Dave Kleikamp <shaggy@kernel.org>, outbounddisclosures@openai.com,
	Kyle Zeng <kylebot@openai.com>, stable@vger.kernel.org
Subject: Re: [PATCH] jfs: validate active AG before updating db_active
Message-ID: <202606121758.6bifYIqm-lkp@intel.com>
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
config: s390-randconfig-002-20260612 (https://download.01.org/0day-ci/archive/20260612/202606121758.6bifYIqm-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260612/202606121758.6bifYIqm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606121758.6bifYIqm-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/jfs/file.c: In function 'jfs_get_active_ag':
>> fs/jfs/file.c:52:3: error: implicit declaration of function 'jfs_error'; did you mean 'xas_error'? [-Werror=implicit-function-declaration]
      jfs_error(inode->i_sb,
      ^~~~~~~~~
      xas_error
   cc1: some warnings being treated as errors


vim +52 fs/jfs/file.c

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
