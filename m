Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5937E2F361B;
	Thu, 13 Aug 2026 19:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786649113; cv=none; b=Ppb0OGs1HAw4WQTnYjby6Ml9TTcctdZu0wWkQh8eTGgm1fMnnSFTIyntoW1cdydcqbvF/83QGmoNfjoRygEY6VGDrQCqJ77ku3qUnmwVkLK1uSsMDy49ogixuDcV3aytFQjCswuS+TTerqhxrJzZm0QrrzQN+2yBjYCHTSRMuqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786649113; c=relaxed/simple;
	bh=6ckX8TBN9F4koDpmJ3VXPg8frlr2wRrtyoiXs/hAf2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQNnnTccGG7It3/CKZz1fhWrZYXrAr3GhKzr8Pzjuy4yBGIC9YSPqzX1gAIkwdKv94Hj0AF5eYYgw+9d141Ns2L7AitSGXfdQopCK9jxBFyTZ8PZ8ked1qPbZlktHFcPSbQcSvEA6Wgqky1EZYW/vvY/z6zrhrOdCRLi9csH4zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EXEH6pBC; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EXEH6pBC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786649112; x=1818185112;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6ckX8TBN9F4koDpmJ3VXPg8frlr2wRrtyoiXs/hAf2s=;
  b=EXEH6pBCZT1h6t4HhRrBSPgOHCPH1KHS5OM/Y1kj3GWwGvFbxTXkaobg
   HbrDnz4Oy2hrZ1tYVhWarWgNWlIA/VwvfSN8HyWF23yke+mJGFoKinHVK
   /qWMwZHcT36ybhCALG4KZEWQXw76+8DTrYi1mitAbR/x2WzJGJGUneBwo
   UEB+LCCiZpsypX1uijgXV5C+Uanx0d+PliqMmuS22bEIMJOX1A90u/ito
   1sw2FqQ392BTMYYMySjCfBwWRJ/V/yDWB+OGCc9PaZspxwZeJWcJbrUpu
   N4RMsfcykybGcBb26yeSt2RwNYxPM0M/b9OaIxhK+qrM344C0/vk+gfsl
   w==;
X-CSE-ConnectionGUID: XOzOWMtzRmesGx96dJRqNA==
X-CSE-MsgGUID: qNCdP1jqQfaHgMk4ThO+Zw==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="90909158"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="90909158"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 12:25:12 -0700
X-CSE-ConnectionGUID: Oqpf11YdSs6L1N3EWL++bQ==
X-CSE-MsgGUID: Q5MnzNdXTLCvEt61Epmvzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="269215252"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 13 Aug 2026 12:25:10 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wub35-00000000WM2-2krK;
	Thu, 13 Aug 2026 19:25:07 +0000
Date: Fri, 14 Aug 2026 03:24:17 +0800
From: kernel test robot <lkp@intel.com>
To: Jiaming Zhang <r772577952@gmail.com>, agruenba@redhat.com,
	gfs2@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, r772577952@gmail.com,
	linux-kernel@vger.kernel.org, syzkaller@googlegroups.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] gfs2: validate stuffed inode size before unstuffing
Message-ID: <202608140317.5gzCSRj5-lkp@intel.com>
References: <20260705140620.1732914-1-r772577952@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260705140620.1732914-1-r772577952@gmail.com>

Hi Jiaming,

kernel test robot noticed the following build warnings:

[auto build test WARNING on gfs2/for-next]
[also build test WARNING on linus/master v7.2-rc7 next-20260812]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jiaming-Zhang/gfs2-validate-stuffed-inode-size-before-unstuffing/20260813-232845
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git for-next
patch link:    https://lore.kernel.org/r/20260705140620.1732914-1-r772577952%40gmail.com
patch subject: [PATCH] gfs2: validate stuffed inode size before unstuffing
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20260814/202608140317.5gzCSRj5-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260814/202608140317.5gzCSRj5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608140317.5gzCSRj5-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: fs/gfs2/bmap.c:55 function parameter 'size' not described in 'gfs2_unstuffer_folio'
>> Warning: fs/gfs2/bmap.c:55 function parameter 'size' not described in 'gfs2_unstuffer_folio'

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
