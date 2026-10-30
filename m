Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793345621;
	b=FAb3eZ6c7eKG987eLVhnLWb5WEXyVZibfctxKaZmHTf8oFIk0pLCTKZ3/f8XEeSu7tbW
	 j9k+MpQLmKXcFjoBRCpZ+nChr21oTqXVjlbxE3ABH6hoQgO8+6dD4FJ1mRW0KkjO+hBid
	 RlFJQ/ri7fs1VBagjKcxKP/H20qWCFr0E051rL34Vd6po7O3xshfe5271FMRuiWEHMiWu
	 8eX3E0/CLV/QkdSbr6+nDeyRWl/teBbDY9RTemfFHkyaoLsUYMlQaDgKJmotp7Cu0QFGh
	 NDcTTpkSjsR19/bAgwhHtBuMI9ZX82gnhdaMf/y7nAY9/4pPxZ8uoqai17liHysPHaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793345621;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=nyfgh/II6LZpCSnyU0q61QMGB96//51QOCZPTDo1wog=;
	b=ToASuvxRExm6u6+06IDjRvWYOBn83meExnRIFq+ySuRfR3PKWn1sjcUbCmNJyGvZb44B
	 JddayPzEGDosSneK/Nq5w5fCvpm1HYpO7OuyPsggWBVSvD0aGrq1Io/pchbYE4qzXpL1W
	 oDA7l18gAB4E2ZI1EQ+SuVBsKAUnk0tHg/MxQTX14idccqnBtQH6PoIg3JZ7WjUT4WCbZ
	 AmtOsYD+tjkKOsbidTLHPYFxChACMLjEWiPJOdyT7yIdilVHsSmJmjq01RDDiW7VIOzMJ
	 KUOIR1n5w9bOZkOayf8niBLQhRXWPczhLsBs4WjkgNN7xOzSB78b0H/r1xCYDJRpTkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SO9LJ2FU;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5307606A31A;
	Fri, 30 Oct 2026 07:33:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5307606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SO9LJ2FU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793345620; x=1824881620;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wXoub5dVaFtT1vJ2r5ovOqT9wv0lnrNE+mRfFkW6cnQ=;
  b=SO9LJ2FUhoNKn7W0xpOmYinJG6fMotaZXmoOcCFZ3qd0TuTCRwz1XSjc
   T5ylNn9ai0Ktdhr7WvJpzPQ6KaMO9rrkLSHvGQAKsvOsDeie7UgaIVfn+
   27zW6k2gFiWawyDyIudgbcm/nfXe0JDdgEVUjB6wAv9C4Qf82Yi2QgFIv
   +Mr6XIsyd16yEyNTj/4CWKQzuext9xDRf3hPZFYpzZVqKakgku9HlmHbL
   26oKupP+9mZrJC/h1wghIY5qY6NzqWwFfShPGbaNUH2Xv1ePudR2AGJgw
   TiG0nHL7cnTj5X8NuW7bDpT5Dhc5NG5aqw31sUqc5/2YvKDahzZ+CTQNU
   Q==;
X-CSE-ConnectionGUID: Xuh5R/tURzCvNkL5lzu02w==
X-CSE-MsgGUID: wOdUYwzVR4SvRxUIEtu+8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2134085"
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="2134085"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 00:33:39 -0700
X-CSE-ConnectionGUID: P8rDnVFKSB6qDwcg3ZfUEQ==
X-CSE-MsgGUID: l2FvtpqZQDisCUHR6+M+Cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="5334479"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 30 Oct 2026 00:33:36 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xMh7F-00000000bRE-1ruu;
	Fri, 30 Oct 2026 07:33:33 +0000
Date: Fri, 30 Oct 2026 15:33:13 +0800
From: kernel test robot <lkp@intel.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Henrik Grimler <henrik@grimler.se>, stable@vger.kernel.org
Subject: Re: [PATCH v2 3/3] clk: samsung: exynos5-subcmu: Defer probe until
 power domains are available
Message-ID: <202610301504.RWCpxqfG-lkp@intel.com>
References: <20261029125118.3191455-4-m.szyprowski@samsung.com>
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
In-Reply-To: <20261029125118.3191455-4-m.szyprowski@samsung.com>

Hi Marek,

kernel test robot noticed the following build warnings:

[auto build test WARNING on krzk/for-next]
[also build test WARNING on clk/clk-next linus/master v7.3 next-20261029]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Marek-Szyprowski/clk-samsung-exynos-audss-Propagate-EPROBE_DEFER-from-input-clocks/20261029-135114
base:   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git for-next
patch link:    https://lore.kernel.org/r/20261029125118.3191455-4-m.szyprowski%40samsung.com
patch subject: [PATCH v2 3/3] clk: samsung: exynos5-subcmu: Defer probe until power domains are available
config: nios2-randconfig-1000-20261030 (https://download.01.org/0day-ci/archive/20261030/202610301504.RWCpxqfG-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261030/202610301504.RWCpxqfG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610301504.RWCpxqfG-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux: section mismatch in reference: exynos5_subcmu_probe+0x2c (section: .text) -> samsung_clk_register_div (section: .init.text)
>> WARNING: modpost: vmlinux: section mismatch in reference: exynos5_subcmu_probe+0x40 (section: .text) -> samsung_clk_register_gate (section: .init.text)

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
