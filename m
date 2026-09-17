Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B663E6DEB;
	Thu, 17 Sep 2026 05:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789621669; cv=none; b=Y09ZU3J8/2btzXVnJsLzHSI8Oiq1yThdQU9qvSzgZtD1uE8OpvqeZGxct7cqMIQkYZHJ9QB6bqcnAoYsro4hqEIuSM9RWtYQ8yiNSv0WlPQMoJPsv7jGzopSe1dK/Pv2xPjboL2tgBwfPtkXBkrf9X7Gj9IGCGx/l6hX3XBmf98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789621669; c=relaxed/simple;
	bh=JDHt+DZA2r3cGukq83JQ5GZAP0tXyFrszNZ+k1moAOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s+WBduopAhY6lWQJURFzQe/ke5ofCfNxLPL5MwdVEIZUDPpvzCXMn6X57bhgcWzoi+I8ZbYA6eu0Qwy7MtqXQJMUXuYQb/So2JukjCsW0xTuXjGifZi0UbTQeOeoBgL/A8OjHVHO/jSUAZiq1K8kDGq2zJ0tVRbkeLdXSr2Fs1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kHbmNo62; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kHbmNo62"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789621667; x=1821157667;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JDHt+DZA2r3cGukq83JQ5GZAP0tXyFrszNZ+k1moAOg=;
  b=kHbmNo62DtYt7gKlusww2G5daIkC/CDytQxdNDbnbtPSd3xMGbgNnJwg
   0yrYH+Zdn8iHBgyKPT1FTrVqQs9t8GM9EaVmk5Oc8REcjDKbRiGeoABGo
   +qoASeNSTQIfnkAsgiUW51TDWvqs3AqOxY2oLln6HZ6izl6W5tL6yKa7k
   wLBw1Fy0P3mw//awWp7/WwLdKaUmqAxnF2bqNTiF74wZU+a0k91+FYPxz
   iJW9OTlVSn/R39VZ02BcwhXkX8paI5cpFMHSnbaTt2069h/1QvBYLxs1/
   VEJC/kELaPI9pA/gTyVhPfzeBz+t9y54KZ2ScSs9QGySuJyVuHlqQ7zIP
   g==;
X-CSE-ConnectionGUID: A9smDBa5QHuWYAy7rlyA8w==
X-CSE-MsgGUID: 3vH6GRF4SR2C4oQ+kSFA0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="77569704"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="77569704"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 22:07:46 -0700
X-CSE-ConnectionGUID: 06bxm0V8TL+zpU/jg7yeOw==
X-CSE-MsgGUID: 08O/Qh76Tn+MX2mQQjldlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="278799025"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 16 Sep 2026 22:07:44 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x74LV-00000000785-1aRx;
	Thu, 17 Sep 2026 05:07:41 +0000
Date: Thu, 17 Sep 2026 13:06:57 +0800
From: kernel test robot <lkp@intel.com>
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: Re: [PATCH v2] HID: wacom: avoid overflows in sequence number
 tracking
Message-ID: <202609171246.TbpsuolV-lkp@intel.com>
References: <20260915141621.3011011-1-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915141621.3011011-1-qwe.aldo@gmail.com>

Hi Aldo,

kernel test robot noticed the following build errors:

[auto build test ERROR on hid/for-next]
[also build test ERROR on linus/master v7.3-rc3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Aldo-Ariel-Panzardo/HID-wacom-avoid-overflows-in-sequence-number-tracking/20260915-111621
base:   https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-next
patch link:    https://lore.kernel.org/r/20260915141621.3011011-1-qwe.aldo%40gmail.com
patch subject: [PATCH v2] HID: wacom: avoid overflows in sequence number tracking
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20260917/202609171246.TbpsuolV-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 148ee2b266b73a49f1f31d0bd17d4818b91bee9f)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260917/202609171246.TbpsuolV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609171246.TbpsuolV-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: drivers/hid/wacom.ko: symbol '__hexagon_moddi3' undefined!

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
