Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512832F8E98;
	Tue, 15 Sep 2026 06:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789454503; cv=none; b=HkaHy3+4Aq7CpRkeMqnQ9eoiTEux7P6VGT1ToWjpTksw3QXfpdBb4+s662651CH4H4s3DgmA8PNgnKj4gJcOxqL26wP7Hjc7gTZSC61wYbKamFQWmA0taZVg4LWzKZuxH/Wr7RC2ddVQJI+kVWTa+8mCheuhPfCcFNQKYqD65J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789454503; c=relaxed/simple;
	bh=8xsDiHnrTVHnMEPDXfmMj6XBJcFRIj24SgEwMPFYk0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rrqvhk1NHCL28Jglh8vuTa+N11uiqioDpqVlHpOecR6GFrGSMNiWDgQOYaRuJDpascp22wX8/yFbClAxrFXM/q/cgo0oUoSkqmvsjGkb7YiHUp44OjBLNIGvkE7ZtRU7QeG8yH2wV1A1YWAkHzkamdFGit+9vjjR+3M/DowPQsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bEsL92r9; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bEsL92r9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789454500; x=1820990500;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8xsDiHnrTVHnMEPDXfmMj6XBJcFRIj24SgEwMPFYk0Y=;
  b=bEsL92r9VMWgPzN6szjdkKWUOHv+007r3Z+eq31uVYfA8TLwzibuwt9e
   HM8sq1Zh3M2Ek6SUW0T6NlTE0ALoiZsVzAkxIecg1iqup4QGC0ZzvDEm6
   0FqyAS8yaGfIaWp3sPjR9te/Ofs4ee5TlDy1a0wZ+FRzi36rUNSqpChgH
   OEwipUI6R9byZ74Cq4iMpD3nxHNMs8XUT86vSVWOfbp2aRitQYbLzkTye
   ebcjDhijpr8kMbm6K/PAWf6zEv0eoSdjWwHaXiHnGIMMwgB3KNXK7F+K/
   FeTEblDcd01bPV7RcD4wz5GPqYd+dOj0I6dTc8EG0nk4wZDoXP62UAPJ+
   Q==;
X-CSE-ConnectionGUID: Sai7WhFrRX23tyti5JCJmw==
X-CSE-MsgGUID: uwMSRZbeQ6eyLLVgXgq4zg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="93632883"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="93632883"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 23:41:40 -0700
X-CSE-ConnectionGUID: VznnDdlgTX+jg4YVBXqBAw==
X-CSE-MsgGUID: sOZgthxqQaW0wQlBHLf1rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1255241"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by fmviesa013.fm.intel.com with ESMTP; 14 Sep 2026 23:41:37 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x6MrF-0000000048U-2nsv;
	Tue, 15 Sep 2026 06:41:33 +0000
Date: Tue, 15 Sep 2026 14:40:37 +0800
From: kernel test robot <lkp@intel.com>
To: Zihan Xi <zihanx@nebusec.ai>, dhowells@redhat.com,
	marc.dionne@auristor.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, zihanx@nebusec.ai,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, linux-afs@lists.infradead.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Vega <vega@nebusec.ai>,
	Luxing Yin <root@tr0jan.top>
Subject: Re: [PATCH net v5 1/1] rxrpc: fix encap_rcv skb accounting exhaustion
Message-ID: <202609151453.yX0JDG4h-lkp@intel.com>
References: <d38b683f6d583cbbc23ee149b50b15b6e4efc567.1789273347.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d38b683f6d583cbbc23ee149b50b15b6e4efc567.1789273347.git.zihanx@nebusec.ai>

Hi Zihan,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Zihan-Xi/rxrpc-fix-encap_rcv-skb-accounting-exhaustion/20260914-130912
base:   net/main
patch link:    https://lore.kernel.org/r/d38b683f6d583cbbc23ee149b50b15b6e4efc567.1789273347.git.zihanx%40nebusec.ai
patch subject: [PATCH net v5 1/1] rxrpc: fix encap_rcv skb accounting exhaustion
config: x86_64-randconfig-073-20260915 (https://download.01.org/0day-ci/archive/20260915/202609151453.yX0JDG4h-lkp@intel.com/config)
compiler: clang version 22.1.3 (https://github.com/llvm/llvm-project e9846648fd6183ee6d8cbdb4502213fcf902a211)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260915/202609151453.yX0JDG4h-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609151453.yX0JDG4h-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: net/rxrpc/rxrpc.ko: symbol 'sysctl_rmem_default' undefined!

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
