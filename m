Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794363083;
	b=NqOk2KMXC7YnVI7chfeCTJVLeaWGmrZlsVzUI0wkNfP8YPVvYtzQyCkhP0BRCE77MM19
	 hXaUIVs7RSFumHxMiLR2EywCtKi9MkghBsHqP34BvpFd6YKnEbiikT0HwT5eYKq6UH/Gl
	 HWNnm8B8UmyzZl9RecIuNn25wrPW9FYRPfE9iVn4/oSzn5kH6BgqULXiHdRbjWpO3k7ms
	 Xs9kvnHT0mVGfG16f/gXimLbB2BN/5l+/cw14RQYkjPGCOyrn1IvHP1MkRho9BnsXQFtz
	 4wcgeX517jUeZ5BXONkz/X8BYEU3EZkc2WjPaElBTm2UzeVUzJZvyU+CYjt07W+Qx9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794363083;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=ySVn32+21zYg7Tj5ZrVgbfGHI6nDULtj/EICklOEM+0=;
	b=SFAKFmzLmSh1OIi0KoslbX2uS2VJryyiRp/hoiEsSxM+mIbWciT+TV290Ht1NlA3A9C+
	 5vaikac4cMZNqEw7ZKnuW2C8vD4JRah1p/Ml0KKiEkEZKUZvqzsqHrNJIAyDF+CXKeeCN
	 ED5oPmS6p5VIGEsM8YQ3W8X/xe6eCzReV8bo6p4daAXSBqS+2UTD4ucNXAV80uIe8W2HD
	 e7pjMWqdDeilNWCh9KKnYCG3x4w7bnMzY/X/GgRicJh3lphKZaTZBpTR/0YgH9+stprta
	 33jTvGgeVWjI6vsTRR0lTvPiP0BcOwrU9e6TkOqGoivKCpZU7zT6vAY4jajbv/nsXlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RQSeL3GN;
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6A1606A320;
	Wed, 11 Nov 2026 02:11:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA6A1606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RQSeL3GN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794363083; x=1825899083;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YIl9mNbtsYzhplOgGa0cGhEfEaFtNRnooftTOeSQs1A=;
  b=RQSeL3GNx4WR18CTswrPgiR/5xj04UUzPAc4iPgfFadPPjoVocucnqGy
   Sqj3UKN21Vi60+PLVaLWlYhdXUVvQW0pwt1LPjuV4TNGoMcxN7KHNTJHP
   6aFHW2PC1H6+gsmsBpnivzY7uCod/j1W1VN6plb9GbCxCm+Nv6ewt+l/h
   dqscC8BLWKczrFeJd4x5muQ2u0jHbGxSXGwtCgbk1VZclC0VInDW0lIaC
   bUeGQPuofmORonULsgzRNOBijc80HJUTfBsIqkqsWO20Ugj+ywOPJvuN/
   Ste1qalVgAJ+QE+X5nKOgNngLqyYjlRy+ekyXV9FrUVvz7XYFvu/dCBaG
   g==;
X-CSE-ConnectionGUID: P0qoq/ZRREu4zEQymqY4WQ==
X-CSE-MsgGUID: MYw8nHOqRfC6DB32bv5gQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3150135"
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="3150135"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 18:11:22 -0800
X-CSE-ConnectionGUID: KWKSWiA6RYG2k7q5uu9mdQ==
X-CSE-MsgGUID: WcxeZuelSJ60aUdbvg1pug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="8472020"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 10 Nov 2026 18:11:17 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xQxns-00000000xt8-1mQS;
	Wed, 11 Nov 2026 02:11:12 +0000
Date: Wed, 11 Nov 2026 10:10:53 +0800
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
Subject: Re: [PATCH v3 3/8] media: i2c: ov9282: fix flash duration to/from
 microseconds conversion
Message-ID: <202611110928.rZQK4WSx-lkp@intel.com>
References: <20261110-ov9282-fixes-v3-3-cb6df80cbc22@linux.dev>
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
In-Reply-To: <20261110-ov9282-fixes-v3-3-cb6df80cbc22@linux.dev>

Hi Richard,

kernel test robot noticed the following build errors:

[auto build test ERROR on 7475ea8b58616b33c04afb976cf0fbaad9dd63fb]

url:    https://github.com/intel-lab-lkp/linux/commits/Richard-Leitner/media-i2c-ov9282-handle-error-from-exposure-range-update/20261110-141010
base:   7475ea8b58616b33c04afb976cf0fbaad9dd63fb
patch link:    https://lore.kernel.org/r/20261110-ov9282-fixes-v3-3-cb6df80cbc22%40linux.dev
patch subject: [PATCH v3 3/8] media: i2c: ov9282: fix flash duration to/from microseconds conversion
config: i386-buildonly-randconfig-1004-20261111 (https://download.01.org/0day-ci/archive/20261111/202611110928.rZQK4WSx-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261111/202611110928.rZQK4WSx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611110928.rZQK4WSx-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/media/i2c/ov9282.o: in function `ov9282_set_ctrl':
>> ov9282.c:(.text+0x9af): undefined reference to `__udivdi3'
   ld: drivers/media/i2c/ov9282.o: in function `ov9282_try_ctrl':
   ov9282.c:(.text+0xe20): undefined reference to `__udivdi3'

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
