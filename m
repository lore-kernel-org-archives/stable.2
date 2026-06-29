Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CE83655F1;
	Mon, 29 Jun 2026 17:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782753640; cv=none; b=q9qDkNUK+YT0kuE3asg7QUF6X4XZ6usyXGcrvYqjHGEwVoOGcYAoN/t6vhNWi0WODq2Ev3HnPBvtHCGPomfYkAP6JAl4RR1cgcV3VXoco7qgrHhIqiewwIGsp5MrmlDAtWJjP5+2f4lmJOFCbtVHKGfE9Zorib1RFQB1bFbkEkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782753640; c=relaxed/simple;
	bh=al5yQE0+dYMsecaa6NaCOaeK0Yanl/mTELVPQXEbJIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+3BtZsVBd+Avq8MrHaa7vDT6RwZIS33PDc6ohcUrmwKtCUHh1UKnTK2wlhC67K4gV6f872PXq3RQkHGZSYGGuhT/P4yc8kYbw0ojUQLA62A8f2Pw5cO38DeRSfWr8tjC4MS8MA5cpX87Y3GZbCFtImXP0TqWyNTwg0SCnzlOZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vb4sF2Wx; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vb4sF2Wx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782753639; x=1814289639;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=al5yQE0+dYMsecaa6NaCOaeK0Yanl/mTELVPQXEbJIs=;
  b=Vb4sF2WxOaICnsuNCJ8qXijkTZHz+/fEE/XSjY6ELFGj5WUGsWXVPWRI
   5IZuuyvDaOXZlr0HZC8t6CGrcFzPVCA9qbzsZxP/15dp144DM+HisLQHj
   NMCF3pnQTLTyVdRBcrzSVl1pn6gOi0swPVmnp9PIR8f0rTWlau/I4zHEC
   4m6le2SEg9cEZ6pyh4tcYWxiS6G0YAWpEuEEhb0e0XQ25knz6MauZJJjK
   bEiuu7pk07xz9z5xtp74eT+Fw4M2QAO59fSRD49ymtBW6p4/afPy/fxIa
   UlA7gmwYVepu6oyubMz6dATKVRSG6Gm+ST1vNu0nY1+0Ug0FsUcDAKUdQ
   Q==;
X-CSE-ConnectionGUID: Xvxip7/uQ0ecSRnjAJUoTQ==
X-CSE-MsgGUID: wtTNEFijRvm0kEBEk9mnRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="83651019"
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="83651019"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 10:20:38 -0700
X-CSE-ConnectionGUID: 0vRtVAJ/SG22+p1DOcbZCg==
X-CSE-MsgGUID: sNaMJrLLR/K0VUi71Nij5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="250315835"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 29 Jun 2026 10:20:36 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1weFer-000000007bt-3yh3;
	Mon, 29 Jun 2026 17:20:33 +0000
Date: Tue, 30 Jun 2026 01:19:41 +0800
From: kernel test robot <lkp@intel.com>
To: Peiyang He <peiyang_he@smail.nju.edu.cn>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, syzkaller@googlegroups.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ntfs: fix mrec_lock ABBA deadlock in rename
Message-ID: <202606300141.H6Io52CJ-lkp@intel.com>
References: <53BDDD94CF346272+20260629105036.2137914-1-peiyang_he@smail.nju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53BDDD94CF346272+20260629105036.2137914-1-peiyang_he@smail.nju.edu.cn>

Hi Peiyang,

kernel test robot noticed the following build errors:

[auto build test ERROR on 1a3746ccbb0a97bed3c06ccde6b880013b1dddc1]

url:    https://github.com/intel-lab-lkp/linux/commits/Peiyang-He/ntfs-fix-mrec_lock-ABBA-deadlock-in-rename/20260629-185343
base:   1a3746ccbb0a97bed3c06ccde6b880013b1dddc1
patch link:    https://lore.kernel.org/r/53BDDD94CF346272%2B20260629105036.2137914-1-peiyang_he%40smail.nju.edu.cn
patch subject: [PATCH] ntfs: fix mrec_lock ABBA deadlock in rename
config: arm-randconfig-001-20260629 (https://download.01.org/0day-ci/archive/20260630/202606300141.H6Io52CJ-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260630/202606300141.H6Io52CJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606300141.H6Io52CJ-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "d_ancestor" [fs/ntfs/ntfs.ko] undefined!

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
