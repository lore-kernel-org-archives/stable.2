Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04EF332601;
	Wed, 16 Sep 2026 18:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789582459; cv=none; b=jU0Eb1PMBxsf+so9Yk6Cay7Sx8KDPXUeTn9eBKfBJuZXKkhA+YsrPkeSYw5QOcPOTFC4bRIDl+zX90a33PFUFZScTL47t3BWEMXaNO0Sm+EI11JIzwRbDBBScZows6heZHJCQtNkfln1x0JE3svbBshWk56pF+NVraIbQVT3oNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789582459; c=relaxed/simple;
	bh=KjEfwPecyT60Bm/IoDRCxjnztRpecWag3huifqW5vRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MOuUU4nSj2W6I8FJO/QxbN/ODM61DMbe1MtMAjBKW2n7GqWautw/o/Y3KOJ7NqgEG3c80788Ny40AaACAfBNsCAC6UGFlE9ffCXNR/tk2tPmq+mPqWm9eFYINESA65hSDBoiDMgx1nJ5KQXYjjZa+JaUXAodZM9CSHXDY5TSKi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qch4oeKI; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qch4oeKI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789582446; x=1821118446;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KjEfwPecyT60Bm/IoDRCxjnztRpecWag3huifqW5vRs=;
  b=Qch4oeKIeMcAtWYAzIWWTAyN8ZLg/rFYhf17uCzJ+cHY5fCGXZITnc8y
   kVIai6cdw96ayBwBeiosmSj0IwrLO62d8asbe/o48K3acDTym+QAVTjbl
   iYxAhG4rqic/IBdGB3qDVaLOvVcMaeJeeM0keTQYvFpDHmcnuS9LaunUB
   DjXfym1O7HaTfE3OEzrYevzVnhHfgBJESUx3LguY8Ja6M5e/aTsRu9QyH
   RGfj2aMOvsoumVTgozprWAwKq5a11Eh6yLdjz9BmfieErwM+k6LElyITw
   0T4KlKlsgVK2aW9WQ5DmvCPyqH91waPJ5vGapObTVzaDwSYDklGMd+L6H
   A==;
X-CSE-ConnectionGUID: WGbqBczpTHq6hT0RuchNcg==
X-CSE-MsgGUID: 2/g7ZFzBRvSo16490byh6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100632538"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="100632538"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 11:14:00 -0700
X-CSE-ConnectionGUID: V/qfv/AxTbqZ+ljzrI0/TA==
X-CSE-MsgGUID: aMDd1673QlKPBzYk4G7f4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1636979"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by fmviesa011.fm.intel.com with ESMTP; 16 Sep 2026 11:13:59 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x6u8p-000000006XT-2Zgs;
	Wed, 16 Sep 2026 18:13:55 +0000
Date: Thu, 17 Sep 2026 02:13:28 +0800
From: kernel test robot <lkp@intel.com>
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: Re: [PATCH v2] HID: wacom: avoid overflows in sequence number
 tracking
Message-ID: <202609170218.u9lMtoL0-lkp@intel.com>
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
[also build test ERROR on linus/master v7.3-rc3 next-20260914]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Aldo-Ariel-Panzardo/HID-wacom-avoid-overflows-in-sequence-number-tracking/20260915-111621
base:   https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-next
patch link:    https://lore.kernel.org/r/20260915141621.3011011-1-qwe.aldo%40gmail.com
patch subject: [PATCH v2] HID: wacom: avoid overflows in sequence number tracking
config: arm-randconfig-1001-20260916 (https://download.01.org/0day-ci/archive/20260917/202609170218.u9lMtoL0-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260917/202609170218.u9lMtoL0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609170218.u9lMtoL0-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: drivers/hid/wacom.ko: symbol '__aeabi_ldivmod' undefined!

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
