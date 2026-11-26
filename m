Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795712158;
	b=N9mkl0X6bSulddt6QERaod68M0FPGOcvsJ5PHBWWzF2MXA3dEKBmyhpYMFlK9uQPvMK4
	 uf3e/X94May1KWjQ9jh8X4arYfW5qG8zfaw9RJm81sH3vpE+SziGf1rILhw5SKDMYWeUA
	 dVUqHlTAmlbSJMGLm+FshC5C860AodfaFcMzCpQp2/WuvSNqHlxUqUay3eCKrxZWyDBv9
	 dYf1FGBAu4TNVVur13FMqfpwJOPp2kP0R4naFTWVhuIsoUA2PCq3VSWlaUhIejqg6LiNz
	 Itusn8Gij2U7rU7XsyYARATI2AvJ0e629fIGkYWzPCnhaJeMtLjNfT7bYUkWffIn1mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795712158;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=7UMJ5fq59vACu6YIC6Tb/A5NemhqR9H7sJxjwk062+A=;
	b=ImQwNw0cyIzNqdIIafl96dkwx746Z02FQi5H64MpdbFPuuZx3EfVOxN8KsrPqhfHtSA4
	 NEPeDqNn2yjxVCxENhZbN+M7qTB5tGOdsFsRmFz4B313x7UW8r8MKDW0y1et1ZDce0tMM
	 yo2eytR1DK3x9l5FzqmvrPvdACgSMpPeyv7m+ydnzwxkBKsQybmh5t0p9UdFCMaZIit7y
	 a89OvSSEPkfxS9dGq9tg/4+/5ImsFlEjpZhs40A5gsFsfsqVF+SDpArbs4yj+1XuiEgVg
	 NjA5j1TWCc8wsCJXyVi9xfhI34k671fQOZpIDaj1FYFjvSrjFQ1YSbo9xc8gIElk4Dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="QC2DL/P2";
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F46606A321;
	Thu, 26 Nov 2026 16:55:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96F46606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QC2DL/P2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795712158; x=1827248158;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=37k69uxyRJzVO9uddzYhhEnx5L7zKQsrBkRXxwOZKbw=;
  b=QC2DL/P2hcdzxwbJJSTnCrQ03QDs5lPS9vX2Gj93TZRGEpzZIkbJqwnn
   aR/2es/ne9Dc80ggm+Q6ZH8XMj+3AYfb/E+jl7nkbc/er4nMsdNa8zUCN
   lqaUvN507Y7HiY8lC8LZuz2xl4jGfTyPq9VbzSV2XHypJ2TXYfXeJJgOH
   HLR/GljUVUIO1Cr2CbjywVMkIAMRa0gbM7no0JFhnplKP6MXFIK19GrBz
   LNtgO9r2QKVoV4Fc0dZXlSebPsZFy5IyTmo9UOdw2WfN6b8UWD+98SpnG
   ix7evuDS3ZqGBO+GAngK5wzkqLJdmmGv+MzMGJi+mlKHhMAYjdTy3ZaNx
   w==;
X-CSE-ConnectionGUID: acTgpQUSQfyXlxGOdRiHvA==
X-CSE-MsgGUID: 1rOZXWRaRcCv6J8ZaNq3yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4596261"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4596261"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 08:55:57 -0800
X-CSE-ConnectionGUID: p+r39IeoTeS/5WhFAxkNHQ==
X-CSE-MsgGUID: 5FAT+iOpSeq7ciSi986WGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="12536476"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 26 Nov 2026 08:55:56 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xWclE-00000001UVe-2lJt;
	Thu, 26 Nov 2026 16:55:52 +0000
Date: Fri, 27 Nov 2026 00:55:23 +0800
From: kernel test robot <lkp@intel.com>
To: Yingjie Wang <x-professor@outlook.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"dlemoal@kernel.org" <dlemoal@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] null_blk: reject device size overflow
Message-ID: <20261127004636.Zw6bu9Dk-lkp@intel.com>
References: <20261126074748.1076774-2-x-professor@outlook.com>
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
In-Reply-To: <20261126074748.1076774-2-x-professor@outlook.com>

Hi Yingjie,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 5a29cfaf51105039d156dd8a61d2783e8b653667]

url:    https://github.com/intel-lab-lkp/linux/commits/Yingjie-Wang/null_blk-reject-device-size-overflow/20261126-074752
base:   5a29cfaf51105039d156dd8a61d2783e8b653667
patch link:    https://lore.kernel.org/r/20261126074748.1076774-2-x-professor%40outlook.com
patch subject: [PATCH v2 1/3] null_blk: reject device size overflow
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20261127/20261127004636.Zw6bu9Dk-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project fb29ca8163c3309160711e5a14eb46bc6d4fdad2)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261127/20261127004636.Zw6bu9Dk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/20261127004636.Zw6bu9Dk-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/block/null_blk/main.c:1896:16: warning: result of comparison of constant 8796093022207 with expression of type 'unsigned long' is always false [-Wtautological-constant-out-of-range-compare]
    1896 |         if (dev->size > LLONG_MAX / SZ_1M) {
         |             ~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +1896 drivers/block/null_blk/main.c

  1893	
  1894	static int null_validate_conf(struct nullb_device *dev)
  1895	{
> 1896		if (dev->size > LLONG_MAX / SZ_1M) {
  1897			pr_err("Device size is too large\n");
  1898			return -EINVAL;
  1899		}
  1900	
  1901		if (dev->queue_mode == NULL_Q_RQ) {
  1902			pr_err("legacy IO path is no longer available\n");
  1903			return -EINVAL;
  1904		}
  1905		if (dev->queue_mode == NULL_Q_BIO) {
  1906			pr_err("BIO-based IO path is no longer available, using blk-mq instead.\n");
  1907			dev->queue_mode = NULL_Q_MQ;
  1908		}
  1909	
  1910		if (dev->use_per_node_hctx) {
  1911			if (dev->submit_queues != nr_online_nodes)
  1912				dev->submit_queues = nr_online_nodes;
  1913		} else if (dev->submit_queues > nr_cpu_ids)
  1914			dev->submit_queues = nr_cpu_ids;
  1915		else if (dev->submit_queues == 0)
  1916			dev->submit_queues = 1;
  1917		dev->prev_submit_queues = dev->submit_queues;
  1918	
  1919		if (dev->poll_queues > g_poll_queues)
  1920			dev->poll_queues = g_poll_queues;
  1921		dev->prev_poll_queues = dev->poll_queues;
  1922		dev->irqmode = min_t(unsigned int, dev->irqmode, NULL_IRQ_TIMER);
  1923	
  1924		/* Do memory allocation, so set blocking */
  1925		if (dev->memory_backed)
  1926			dev->blocking = true;
  1927		else /* cache is meaningless */
  1928			dev->cache_size = 0;
  1929		dev->cache_size = min_t(unsigned long, ULONG_MAX / 1024 / 1024,
  1930							dev->cache_size);
  1931		dev->mbps = min_t(unsigned int, 1024 * 40, dev->mbps);
  1932	
  1933		if (dev->zoned &&
  1934		    (!dev->zone_size || !is_power_of_2(dev->zone_size))) {
  1935			pr_err("zone_size must be power-of-two\n");
  1936			return -EINVAL;
  1937		}
  1938	
  1939		return 0;
  1940	}
  1941	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
