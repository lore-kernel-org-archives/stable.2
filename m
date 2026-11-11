Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794372473;
	b=cT1SUJc12iJGHrIBfIeH1igZVruK35rm3EU0F1NfRLlOUcr2aNPidDmf7zPR02hH3GUL
	 sIO2TwdKVatU8yxDjnW/MUSvYec2YIoxhZhm//apL8Ftf0NxPJLZevt02qeFdVBeK9FWH
	 syF/553/DKSNk8yyE+n0fyXU403DZp2qM0/VL4C0FgjCA2atwvrEXsWM5IZKQh2d/taJK
	 5NaF4pqVesyG3HuubCMl3GGldWfWO4dw171aUNJ3fmpjqYEjiOoxr3ANXKihaUKaQ/uY/
	 EAM95Dd4vLxkMRe2L9v40APEDdbdoR/oJgsImtq/R/MOcdnv3skTl43P1IpCrJ1G/nQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794372473;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=nnLOvLkvC3FCuX73j8/Sz/J/jXxuH3kNSAmEVAzkdWw=;
	b=OUoWp7D8o5VoRPytqkLOmgaCp9kdiADx922l6/kMzlPEzDEcZJv0aiUIfXHLfjfagKqX
	 hbTnSEGRQfpcqyqP7n8WqaQCXBsfFa8THY4oRQS8/anfgAfb3Ef45jywuRKzRrdfxA0pv
	 2VMdCfCD7T8T9g6w0KjHssg8UAmsQ9f8c8qaBRDG3LiT+g5s7NwVNL9Ks+C/DZECse6Au
	 Yf9h1wHcMDjqUg112NtadR2jM9/pPWCzNuN8wFFXulLaER5wZ3fQhjH52P1XIA6cRGgEd
	 QLHzpfLioHBc1ZwkjccxruwsfSh4bQ33dih5atvWmWT2PWtvgK9yAaqssLcqyByEhcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kymZKhON;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5225606A31C;
	Wed, 11 Nov 2026 04:47:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5225606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kymZKhON
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794372472; x=1825908472;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jLMhntaC4N/0al64g9oViVfrYTAAZHkHOXPQag0q/Ro=;
  b=kymZKhON69bC1ahtVV6T1JEgNlrW0inCR6Ac2Z6TCCuL11yfg9AFBmNS
   0xFqwAsF5FuT5UnlgE4xqEDXYc4V/nSBgpxguhABSzbqJfIKMBF8RcyU3
   QQg2VBWEsQdL00urGD0aEuW4PVJi1lYb21dSHTx/XeJXv6LhAUXVxRxvz
   wGSXhmNipx7D4XvfxsaauSuKkfXuTUrcXPGSDERh6isDCzLKcEjp6B3a6
   RYRl25/drogSxNufT48Iru4hJo1Od/18MD8hxfYtm++Y3wO0n3QMxEpjk
   uyLf48VXMk9cnaOPd4lZacbz3SjMqHyzaFYgLrJfc/zTWgZKBABA9fpz4
   A==;
X-CSE-ConnectionGUID: d6FC7/xKSCaGPTgqGiPMEQ==
X-CSE-MsgGUID: Z6u74JBPQauotDQimqPGag==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3222886"
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="3222886"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 20:47:51 -0800
X-CSE-ConnectionGUID: o3gCRP/hT8SPoSB6SsbScw==
X-CSE-MsgGUID: ZsTNSzd6QXSmKEP5Qe3lNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="8484697"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 10 Nov 2026 20:47:47 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xR0FN-00000000y6t-0BPB;
	Wed, 11 Nov 2026 04:47:45 +0000
Date: Wed, 11 Nov 2026 12:46:57 +0800
From: kernel test robot <lkp@intel.com>
To: Richard Leitner <richard.leitner@linux.dev>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Daniele Alessandrelli <daniele.alessandrelli@gmail.com>,
	"Paul J. Murphy" <paul.j.murphy@intel.com>,
	Martina Krasteva <martinax.krasteva@intel.com>,
	Hans Verkuil <hverkuil@kernel.org>,
	Bryan O'Donoghue <bod@kernel.org>, Jacopo Mondi <jacopo@jmondi.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-media@vger.kernel.org,
	Gyula Kelemen <gyula.kelemen@advasolutions.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 6/8] media: i2c: ov9282: recalculate strobe span on
 HBLANK change
Message-ID: <202611111252.5aHBFhG6-lkp@intel.com>
References: <20261110-ov9282-fixes-v3-6-cb6df80cbc22@linux.dev>
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
In-Reply-To: <20261110-ov9282-fixes-v3-6-cb6df80cbc22@linux.dev>

Hi Richard,

kernel test robot noticed the following build errors:

[auto build test ERROR on 7475ea8b58616b33c04afb976cf0fbaad9dd63fb]

url:    https://github.com/intel-lab-lkp/linux/commits/Richard-Leitner/media-i2c-ov9282-handle-error-from-exposure-range-update/20261110-141010
base:   7475ea8b58616b33c04afb976cf0fbaad9dd63fb
patch link:    https://lore.kernel.org/r/20261110-ov9282-fixes-v3-6-cb6df80cbc22%40linux.dev
patch subject: [PATCH v3 6/8] media: i2c: ov9282: recalculate strobe span on HBLANK change
config: i386-buildonly-randconfig-1004-20261111 (https://download.01.org/0day-ci/archive/20261111/202611111252.5aHBFhG6-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261111/202611111252.5aHBFhG6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611111252.5aHBFhG6-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/media/i2c/ov9282.o: in function `ov9282_set_ctrl':
   ov9282.c:(.text+0xc91): undefined reference to `__udivdi3'
>> ld: ov9282.c:(.text+0xf2f): undefined reference to `__udivdi3'
   ld: drivers/media/i2c/ov9282.o: in function `ov9282_try_ctrl':
   ov9282.c:(.text+0x10a0): undefined reference to `__udivdi3'

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
