Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794897890;
	b=nbVkpnigUuiQwyNNkeeHhEhCGW9q/TICyOOq+j9siWSmxO3Hr8gjhd+68XWnRiLsDBg3
	 DvomcqPdt84KX47XZJjveeF0QecBnsMuD7MnP3ozovX9XZtLXGk+BMyRB9Xw2gM4bco9R
	 qySGEnzUjA5zG7bT9vsLVLomBYXDsEjNSxKjuZMVJ8oWN/CmTMOO9AbVMjI7jvzzT60/L
	 TATrF45VjZILJZh2480JiNAS2HC/tuSuw4Z5XLxOKzWwd2YeLA2CdtInzWVNwbpQ93eux
	 ojELikn9q/dpzPJ01+PVyiU/UkBtgZt5DPOm1S4/zLY9ouD15Y11lm5RPf7F8Tobj1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794897890;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=hOnWhf2UYUafyeK5eqb3reqBBAwOK+jIEmpgbPZ8v1k=;
	b=5bwoUHsBeb9saDM350QKGwpu9jUooBdYXRJOi/WDMM/xrKqOSFhqL3R9Nnvj3xazGt90
	 cJ322sUIy1c+WJq1IyeeiQ1grdZ7Y43FQ4yJvGDePmZ0EgjcAgXqVs25UG1tLWAbQzrVv
	 i3Hg1jX5EjnRu/R6n9jDYhJrKQPJDp1MfmalDTSU5XO4G5LG8TA2DDSmbS3jOtG2JW2Md
	 sMKai/NiGgsrL0Tgyp64uJv41diAg9lWdE3i8gAe/RWNIjRqf4X4ObwRxAFzQMWEmjMMp
	 PVmkR65FOX/qe+WI2cl9tksIQDSgWNPWfkEQR0TRq6xBo2FTJj43tNqFVUkG7k4D7eA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gvcYvyi2;
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C74606A323;
	Tue, 17 Nov 2026 06:44:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3C74606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gvcYvyi2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794897890; x=1826433890;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ESQjpD8S2LW070yACMHY9t3rIJIM32CEwZ+XZ+1Vu5E=;
  b=gvcYvyi2Z1tJPBKlvSs3Eu9JbUzgSZQbkeY01iIV7guv1lDKYVbim4oT
   fCApOSUphr4v7YAW82Hgmi1byDcMVZ5MDFn7BVhTvr0uCTQieiB8oDBGH
   lheCqJ7kpF6ofSLhmNxAtnN4TL7IHZQKV6cMA2Rnkypc+OXAhwNY1dFsq
   MhVH4NwXUJTS3rNf1hQ7T7UO6VOS87PEdyoWSgK3baNQonvqGE9EpAobY
   hht3QGhxXQTLY1QAPryvO6rbAxCvJLrX89HLQQDhHAaP+ADpiYZq5JOnN
   LGMLGDu1myK8MnH4nbsMdk9D9d3A2CYiUQVu9b8MFaJaHO1iPJeSx/xHQ
   w==;
X-CSE-ConnectionGUID: fvif3nhYS3GV8MQ1PPGmaA==
X-CSE-MsgGUID: INSYKuGeRm+4t4mrQ+OdzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3564578"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3564578"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 22:44:49 -0800
X-CSE-ConnectionGUID: K2ZTOQLqQ36QOI5pE7FNuA==
X-CSE-MsgGUID: 3W5u5vGJQKGsicfVVW/6ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="10152989"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 16 Nov 2026 22:44:46 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xTCvr-00000001AAp-04dz;
	Tue, 17 Nov 2026 06:44:43 +0000
Date: Tue, 17 Nov 2026 14:44:22 +0800
From: kernel test robot <lkp@intel.com>
To: Hang Nan <2122295973@qq.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, mptcp@lists.linux.dev,
	matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org,
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, kuniyu@google.com,
	willemb@google.com, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, 2122295973@qq.com
Subject: Re: [PATCH net v5 2/3] net: mptcp: reject token 0 in
 mptcp_token_get_sock()
Message-ID: <202611171407.G0WgWRA6-lkp@intel.com>
References: <tencent_46FC62D4DE8FB8E6C90049F5AB28BDAA8C05@qq.com>
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
In-Reply-To: <tencent_46FC62D4DE8FB8E6C90049F5AB28BDAA8C05@qq.com>

Hi Hang,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Hang-Nan/net-mptcp-reject-token-0-in-mptcp_token_get_sock/20261116-225828
base:   net/main
patch link:    https://lore.kernel.org/r/tencent_46FC62D4DE8FB8E6C90049F5AB28BDAA8C05%40qq.com
patch subject: [PATCH net v5 2/3] net: mptcp: reject token 0 in mptcp_token_get_sock()
config: x86_64-rhel-9.4-kunit (https://download.01.org/0day-ci/archive/20261117/202611171407.G0WgWRA6-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261117/202611171407.G0WgWRA6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611171407.G0WgWRA6-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: net/mptcp/mptcp_token_test.ko: symbol 'mptcp_token_exists' undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
