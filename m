Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793753226;
	b=W2qDh8emZeYqmIDgkWHp7neeDcGD1ahY+Jb/Nhn0VY7M0Ns9dYlOpU6bEJu6WJ7vdNtd
	 9O7603jpAAp7d8RbOyz6jKmVM7+3dRigseWAmyrc/wjKwbhneqXBtlDNEW6d6yIU2oqHr
	 mFwOCvmB5ytdB8+1x82u6j9VI+egIboGdu5gJJBnzCNgnFlAl5MNiEcWaBaB+FBTYDWuL
	 igpRwuhj+ZFiq1ey9/myNuxHHbApUkMnWXdlm4nr3zDtmRaOk44ohfIvs/4G5E7CChP3m
	 qepnHNaZzxbPCTdrzsuOXRDWfg7cnyCkwp4tX5IlmhGIfUoMiGBGhTvOOE1OsS/YG7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793753226;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=d5KJfmnKlGtFw7NgfSB/GJ/Z3Gq/KQL5ojh/xtpl3rI=;
	b=cMVOXu56c2VDlpM5au/mV5AgNTGNOHsiBzDUsArlUPEC2UFyFagiNRtz0/IZkEXhdJSi
	 jFXXYjVIJy+0jV1A9SHbWb8LOct1JoKap1Kj3BGKys+LmzmWAKCr8D4xKgp0EEnU23SIo
	 J26P3NV8TmodcQb+pDNVcXr7f9onY6x7P8uIop0ee3ZeaaXy5R1gu0c6Jab0DuY0QTZYZ
	 wm5LlC/CfDrrPjnLc2Xziq2UMJLJbvt/Y664sw92pvdmBtOFuXoHC/1sXImYs5foe07RN
	 kDMp9oVcCfVieT9ok0f60buis4u8iQNmPd2bJ03uTgn7MtIzGchD6dbZpseMoBC/guQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MXWkF0Z+;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB7F606A324;
	Wed,  4 Nov 2026 00:47:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CB7F606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MXWkF0Z+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793753224; x=1825289224;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eO9RgMFMHY/n7dfljbY+dPbmxddgUyWXLqsFPKPRdWc=;
  b=MXWkF0Z+aJRAc9NG7OKe9rjHUUUBVL6pZ4T7Zr4WZzrVOHuK9ygeRzE8
   KWVfmo4KaDw62G5oqdK2o/OjbRWZ5aoKcnOEpEfUJyUtJW30Wkq58Intn
   QhrycdVG++gPyaUelPy3GDDomkmhV57YQIPp6Amj8cFSxdOXavDL70ra+
   tazYeaIDMEyCSfTjIwn4wvHTDcOY5ERSIhkzJaC8SxXLXCT+nDU5hm5kw
   vUm7iSRYnTVf4AZ9f3z1QVtddaK8Sja15QyPIZVaf+ZZ3kPrzQqJe0Doz
   2q/ewU82DBLvIeAbPQyBTOxGyNH4srUvGOW4U1VUxW0XY8HKQXofkmHJV
   A==;
X-CSE-ConnectionGUID: 2WbCDCvGQG6PDWP/i0V1+g==
X-CSE-MsgGUID: 43moedStT+apF5uJDzydMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2494384"
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="2494384"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 16:47:03 -0800
X-CSE-ConnectionGUID: kXLDlRHLR7WPsm1F2JXkHA==
X-CSE-MsgGUID: 9lcTGpPXSAGOpQwfEUq4KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="6688137"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 03 Nov 2026 16:47:01 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xOP9X-00000000jYB-1zz3;
	Wed, 04 Nov 2026 00:46:59 +0000
Date: Wed, 4 Nov 2026 08:46:30 +0800
From: kernel test robot <lkp@intel.com>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	jic23@kernel.org, andy@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] iio: hid-sensors: fix fractional part for unit exponents
 -7 and -8
Message-ID: <202611040826.T95bI1SU-lkp@intel.com>
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
config: i386-randconfig-1001-20261103 (https://download.01.org/0day-ci/archive/20261104/202611040826.T95bI1SU-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.4.0-5) 12.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261104/202611040826.T95bI1SU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611040826.T95bI1SU-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/iio/common/hid-sensors/hid-sensor-attributes.o: in function `split_micro_fraction':
>> drivers/iio/common/hid-sensors/hid-sensor-attributes.c:102:(.text+0x573): undefined reference to `__udivdi3'


vim +102 drivers/iio/common/hid-sensors/hid-sensor-attributes.c

    95	
    96	static void split_micro_fraction(unsigned int no, int exp, int *val1, int *val2)
    97	{
    98		int divisor = int_pow(10, exp);
    99	
   100		*val1 = no / divisor;
   101		if (exp > 6)
 > 102			*val2 = no % divisor / int_pow(10, exp - 6);
   103		else
   104			*val2 = no % divisor * int_pow(10, 6 - exp);
   105	}
   106	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
