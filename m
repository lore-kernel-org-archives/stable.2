Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E591FE471;
	Fri,  9 Oct 2026 01:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791511093; cv=none; b=Nsfqq7HVBVgHqmkbqcy/ypE7SBe2peU2zwJfC3JO11cyeZ50HRz5Remby6uQC/g7SjQpv7Y7EwWQm/0VV1vmpwIt9upvumenwm/Jf4XUmt0mDn04ntMZALd/zcNMmkkCJ3u8UYh59WlXeT1zIhzjl+pHmbUp2NHmLeeJPtVXxIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791511093; c=relaxed/simple;
	bh=Ssa9RMpdCUqcoxtMUFOU4/eomJ7fGRCthjt3m6UbLk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQDLDEuFSDeiq+aUAiYfCkZIyz5/bKKtVymQauw+fIp+Q2uG25+ZmeQ3ExLqo11luDnMcvHIl4BBOi728QolXMyEnqZ/xmDw6DbAy2Tcd9aC5be5y0oa71G9UgmdB09fqC5JK4FuWnK6bdPqHiGE52qMq+3ArxQKG/UL2NvgDwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xk8IyIkl; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xk8IyIkl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791511092; x=1823047092;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ssa9RMpdCUqcoxtMUFOU4/eomJ7fGRCthjt3m6UbLk8=;
  b=Xk8IyIklnp3J75Ai7G5+fUjRvh3GL/zgy/XMOhFJktrmEB1aGcAz4Jng
   pvNc2Vi24mdbIbfP4C84kk8z4MRAjbhnRYYW1WIb0jm32Gmh2S1JHC3eY
   6NBiIAAMNh8t3ojO4BThhS6ZKBqg7t4kWrOiuZ7K21eaWX2iTKrR7DjBc
   keCdl1NXg6gqBGZTx9L5DISf9FP1AJEPqqHA90snt1PUV8wVtwIOTk8JD
   tkI106iN97rXJEP4r4XePZCpfjplJn+ztHnFsp5crgaweSsFFYm1WGOGm
   DepCPu6WM9UFKVt+GdFi8BVNNjPzTeFs4ibK0X/CBTdu7HN743V5B4I49
   g==;
X-CSE-ConnectionGUID: 6GctPszKR6aOTYgoe/mHFA==
X-CSE-MsgGUID: 0Nk2jSYeQ1edZFrqLZW9Ow==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="301568"
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="301568"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 18:58:11 -0700
X-CSE-ConnectionGUID: rqjf5P6jSDii/VV5wCPVrA==
X-CSE-MsgGUID: Jk+EVrYcR62pIs6UgQAU4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="556000"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 08 Oct 2026 18:58:07 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xEzs5-000000005Ae-0px4;
	Fri, 09 Oct 2026 01:58:05 +0000
Date: Fri, 9 Oct 2026 09:57:24 +0800
From: kernel test robot <lkp@intel.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, rafael@kernel.org,
	lenb@kernel.org, pavel@kernel.org, willemdebruijn.kernel@gmail.com,
	kuba@kernel.org, pabeni@redhat.com, linux-pm@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, "Jason A. Donenfeld" <Jason@zx2c4.com>,
	stable@vger.kernel.org,
	=?iso-8859-1?B?Suly6W15?= Jean <jeremy.jean@oss.cyber.gouv.fr>
Subject: Re: [PATCH net] udp_tunnel: drop packets when hibernating
Message-ID: <202610090909.eskhKpxA-lkp@intel.com>
References: <20261008124106.665014-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008124106.665014-1-Jason@zx2c4.com>

Hi Jason,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Jason-A-Donenfeld/udp_tunnel-drop-packets-when-hibernating/20261008-144021
base:   net/main
patch link:    https://lore.kernel.org/r/20261008124106.665014-1-Jason%40zx2c4.com
patch subject: [PATCH net] udp_tunnel: drop packets when hibernating
config: parisc-randconfig-1000-20261009 (https://download.01.org/0day-ci/archive/20261009/202610090909.eskhKpxA-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261009/202610090909.eskhKpxA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610090909.eskhKpxA-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/list.h:11,
                    from include/linux/kobject.h:19,
                    from include/linux/cdev.h:5,
                    from drivers/char/virtio_console.c:7:
   drivers/char/virtio_console.c: In function '__send_to_port':
>> include/linux/freezer.h:79:21: error: expected identifier before '(' token
    #define pm_freezing (false)
                        ^
   arch/parisc/include/asm/barrier.h:66:18: note: in definition of macro '__smp_load_acquire'
     union { typeof(*p) __val; char __c[1]; } __u;   \
                     ^
   drivers/char/virtio_console.c:636:6: note: in expansion of macro 'smp_load_acquire'
     if (smp_load_acquire(&portdev->pm_freezing)) /* pairs with freeze/restore */
         ^~~~~~~~~~~~~~~~
   drivers/char/virtio_console.c:636:33: note: in expansion of macro 'pm_freezing'
     if (smp_load_acquire(&portdev->pm_freezing)) /* pairs with freeze/restore */
                                    ^~~~~~~~~~~
>> include/linux/freezer.h:79:21: error: expected identifier before '(' token
    #define pm_freezing (false)
                        ^
   arch/parisc/include/asm/barrier.h:67:9: note: in definition of macro '__smp_load_acquire'
     typeof(p) __p = (p);      \
            ^
   drivers/char/virtio_console.c:636:6: note: in expansion of macro 'smp_load_acquire'
     if (smp_load_acquire(&portdev->pm_freezing)) /* pairs with freeze/restore */
         ^~~~~~~~~~~~~~~~
   drivers/char/virtio_console.c:636:33: note: in expansion of macro 'pm_freezing'
     if (smp_load_acquire(&portdev->pm_freezing)) /* pairs with freeze/restore */
                                    ^~~~~~~~~~~
>> include/linux/freezer.h:79:21: error: expected identifier before '(' token
    #define pm_freezing (false)
                        ^
   arch/parisc/include/asm/barrier.h:67:19: note: in definition of macro '__smp_load_acquire'
     typeof(p) __p = (p);      \
                      ^
   drivers/char/virtio_console.c:636:6: note: in expansion of macro 'smp_load_acquire'
     if (smp_load_acquire(&portdev->pm_freezing)) /* pairs with freeze/restore */
         ^~~~~~~~~~~~~~~~
   drivers/char/virtio_console.c:636:33: note: in expansion of macro 'pm_freezing'
     if (smp_load_acquire(&portdev->pm_freezing)) /* pairs with freeze/restore */
                                    ^~~~~~~~~~~
   In file included from <command-line>:
>> include/linux/freezer.h:79:21: error: expected identifier before '(' token
    #define pm_freezing (false)
                        ^
   include/linux/compiler_types.h:682:9: note: in definition of macro '__compiletime_assert'
      if (!(condition))     \
            ^~~~~~~~~
   include/linux/compiler_types.h:702:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:705:2: note: in expansion of macro 'compiletime_assert'
     compiletime_assert(__native_word(t),    \
     ^~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:705:21: note: in expansion of macro '__native_word'
     compiletime_assert(__native_word(t),    \
                        ^~~~~~~~~~~~~
   arch/parisc/include/asm/barrier.h:68:2: note: in expansion of macro 'compiletime_assert_atomic_type'
     compiletime_assert_atomic_type(*p);    \
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/barrier.h:176:29: note: in expansion of macro '__smp_load_acquire'
    #define smp_load_acquire(p) __smp_load_acquire(p)
                                ^~~~~~~~~~~~~~~~~~
   drivers/char/virtio_console.c:636:6: note: in expansion of macro 'smp_load_acquire'
     if (smp_load_acquire(&portdev->pm_freezing)) /* pairs with freeze/restore */
         ^~~~~~~~~~~~~~~~
   drivers/char/virtio_console.c:636:33: note: in expansion of macro 'pm_freezing'
     if (smp_load_acquire(&portdev->pm_freezing)) /* pairs with freeze/restore */
                                    ^~~~~~~~~~~
>> include/linux/freezer.h:79:21: error: expected identifier before '(' token
    #define pm_freezing (false)
                        ^
   include/linux/compiler_types.h:682:9: note: in definition of macro '__compiletime_assert'
      if (!(condition))     \
            ^~~~~~~~~
   include/linux/compiler_types.h:702:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:705:2: note: in expansion of macro 'compiletime_assert'
     compiletime_assert(__native_word(t),    \
     ^~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:705:21: note: in expansion of macro '__native_word'
     compiletime_assert(__native_word(t),    \
                        ^~~~~~~~~~~~~
   arch/parisc/include/asm/barrier.h:68:2: note: in expansion of macro 'compiletime_assert_atomic_type'
     compiletime_assert_atomic_type(*p);    \
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/barrier.h:176:29: note: in expansion of macro '__smp_load_acquire'
    #define smp_load_acquire(p) __smp_load_acquire(p)
                                ^~~~~~~~~~~~~~~~~~
   drivers/char/virtio_console.c:636:6: note: in expansion of macro 'smp_load_acquire'
     if (smp_load_acquire(&portdev->pm_freezing)) /* pairs with freeze/restore */
         ^~~~~~~~~~~~~~~~
   drivers/char/virtio_console.c:636:33: note: in expansion of macro 'pm_freezing'
     if (smp_load_acquire(&portdev->pm_freezing)) /* pairs with freeze/restore */
                                    ^~~~~~~~~~~
>> include/linux/freezer.h:79:21: error: expected identifier before '(' token
    #define pm_freezing (false)
                        ^
   include/linux/compiler_types.h:682:9: note: in definition of macro '__compiletime_assert'
      if (!(condition))     \
            ^~~~~~~~~
   include/linux/compiler_types.h:702:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:705:2: note: in expansion of macro 'compiletime_assert'
     compiletime_assert(__native_word(t),    \
     ^~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:705:21: note: in expansion of macro '__native_word'
     compiletime_assert(__native_word(t),    \
                        ^~~~~~~~~~~~~
   arch/parisc/include/asm/barrier.h:68:2: note: in expansion of macro 'compiletime_assert_atomic_type'
     compiletime_assert_atomic_type(*p);    \
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/barrier.h:176:29: note: in expansion of macro '__smp_load_acquire'
    #define smp_load_acquire(p) __smp_load_acquire(p)
                                ^~~~~~~~~~~~~~~~~~
   drivers/char/virtio_console.c:636:6: note: in expansion of macro 'smp_load_acquire'
     if (smp_load_acquire(&portdev->pm_freezing)) /* pairs with freeze/restore */
         ^~~~~~~~~~~~~~~~
   drivers/char/virtio_console.c:636:33: note: in expansion of macro 'pm_freezing'
     if (smp_load_acquire(&portdev->pm_freezing)) /* pairs with freeze/restore */
                                    ^~~~~~~~~~~
>> include/linux/freezer.h:79:21: error: expected identifier before '(' token
    #define pm_freezing (false)
                        ^
   include/linux/compiler_types.h:682:9: note: in definition of macro '__compiletime_assert'
      if (!(condition))     \
            ^~~~~~~~~
   include/linux/compiler_types.h:702:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:705:2: note: in expansion of macro 'compiletime_assert'
     compiletime_assert(__native_word(t),    \
     ^~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:705:21: note: in expansion of macro '__native_word'
     compiletime_assert(__native_word(t),    \
                        ^~~~~~~~~~~~~
   arch/parisc/include/asm/barrier.h:68:2: note: in expansion of macro 'compiletime_assert_atomic_type'
     compiletime_assert_atomic_type(*p);    \
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/barrier.h:176:29: note: in expansion of macro '__smp_load_acquire'
    #define smp_load_acquire(p) __smp_load_acquire(p)
                                ^~~~~~~~~~~~~~~~~~
   drivers/char/virtio_console.c:636:6: note: in expansion of macro 'smp_load_acquire'
     if (smp_load_acquire(&portdev->pm_freezing)) /* pairs with freeze/restore */
         ^~~~~~~~~~~~~~~~
   drivers/char/virtio_console.c:636:33: note: in expansion of macro 'pm_freezing'
     if (smp_load_acquire(&portdev->pm_freezing)) /* pairs with freeze/restore */
                                    ^~~~~~~~~~~
   In file included from include/linux/list.h:11,
                    from include/linux/kobject.h:19,
                    from include/linux/cdev.h:5,
                    from drivers/char/virtio_console.c:7:
>> include/linux/freezer.h:79:21: error: expected identifier before '(' token
    #define pm_freezing (false)
                        ^
   arch/parisc/include/asm/barrier.h:69:18: note: in definition of macro '__smp_load_acquire'
     switch (sizeof(*p)) {      \
                     ^
   drivers/char/virtio_console.c:636:6: note: in expansion of macro 'smp_load_acquire'
     if (smp_load_acquire(&portdev->pm_freezing)) /* pairs with freeze/restore */
         ^~~~~~~~~~~~~~~~
   drivers/char/virtio_console.c:636:33: note: in expansion of macro 'pm_freezing'
     if (smp_load_acquire(&portdev->pm_freezing)) /* pairs with freeze/restore */
                                    ^~~~~~~~~~~
   drivers/char/virtio_console.c: In function 'put_chars':
>> include/linux/freezer.h:79:21: error: expected identifier before '(' token
    #define pm_freezing (false)
                        ^
   arch/parisc/include/asm/barrier.h:66:18: note: in definition of macro '__smp_load_acquire'
     union { typeof(*p) __val; char __c[1]; } __u;   \
                     ^
   drivers/char/virtio_console.c:1173:6: note: in expansion of macro 'smp_load_acquire'
         smp_load_acquire(&portdev->pm_freezing)) /* pairs with freeze/restore */
         ^~~~~~~~~~~~~~~~
   drivers/char/virtio_console.c:1173:33: note: in expansion of macro 'pm_freezing'
         smp_load_acquire(&portdev->pm_freezing)) /* pairs with freeze/restore */
                                    ^~~~~~~~~~~
>> include/linux/freezer.h:79:21: error: expected identifier before '(' token
    #define pm_freezing (false)
                        ^
   arch/parisc/include/asm/barrier.h:67:9: note: in definition of macro '__smp_load_acquire'
     typeof(p) __p = (p);      \
            ^
   drivers/char/virtio_console.c:1173:6: note: in expansion of macro 'smp_load_acquire'
         smp_load_acquire(&portdev->pm_freezing)) /* pairs with freeze/restore */
         ^~~~~~~~~~~~~~~~
   drivers/char/virtio_console.c:1173:33: note: in expansion of macro 'pm_freezing'
         smp_load_acquire(&portdev->pm_freezing)) /* pairs with freeze/restore */
                                    ^~~~~~~~~~~
>> include/linux/freezer.h:79:21: error: expected identifier before '(' token
    #define pm_freezing (false)
                        ^
   arch/parisc/include/asm/barrier.h:67:19: note: in definition of macro '__smp_load_acquire'
     typeof(p) __p = (p);      \
                      ^
   drivers/char/virtio_console.c:1173:6: note: in expansion of macro 'smp_load_acquire'
         smp_load_acquire(&portdev->pm_freezing)) /* pairs with freeze/restore */
         ^~~~~~~~~~~~~~~~
   drivers/char/virtio_console.c:1173:33: note: in expansion of macro 'pm_freezing'
         smp_load_acquire(&portdev->pm_freezing)) /* pairs with freeze/restore */
                                    ^~~~~~~~~~~
   In file included from <command-line>:
>> include/linux/freezer.h:79:21: error: expected identifier before '(' token
    #define pm_freezing (false)
                        ^
   include/linux/compiler_types.h:682:9: note: in definition of macro '__compiletime_assert'
      if (!(condition))     \
            ^~~~~~~~~
   include/linux/compiler_types.h:702:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:705:2: note: in expansion of macro 'compiletime_assert'
     compiletime_assert(__native_word(t),    \
     ^~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:705:21: note: in expansion of macro '__native_word'
     compiletime_assert(__native_word(t),    \
                        ^~~~~~~~~~~~~
   arch/parisc/include/asm/barrier.h:68:2: note: in expansion of macro 'compiletime_assert_atomic_type'
     compiletime_assert_atomic_type(*p);    \
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/barrier.h:176:29: note: in expansion of macro '__smp_load_acquire'
    #define smp_load_acquire(p) __smp_load_acquire(p)
                                ^~~~~~~~~~~~~~~~~~
   drivers/char/virtio_console.c:1173:6: note: in expansion of macro 'smp_load_acquire'
         smp_load_acquire(&portdev->pm_freezing)) /* pairs with freeze/restore */
         ^~~~~~~~~~~~~~~~
   drivers/char/virtio_console.c:1173:33: note: in expansion of macro 'pm_freezing'
         smp_load_acquire(&portdev->pm_freezing)) /* pairs with freeze/restore */
                                    ^~~~~~~~~~~
>> include/linux/freezer.h:79:21: error: expected identifier before '(' token
    #define pm_freezing (false)
                        ^
   include/linux/compiler_types.h:682:9: note: in definition of macro '__compiletime_assert'
      if (!(condition))     \
            ^~~~~~~~~
   include/linux/compiler_types.h:702:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:705:2: note: in expansion of macro 'compiletime_assert'
     compiletime_assert(__native_word(t),    \
     ^~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:705:21: note: in expansion of macro '__native_word'
     compiletime_assert(__native_word(t),    \
                        ^~~~~~~~~~~~~
   arch/parisc/include/asm/barrier.h:68:2: note: in expansion of macro 'compiletime_assert_atomic_type'
     compiletime_assert_atomic_type(*p);    \
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/barrier.h:176:29: note: in expansion of macro '__smp_load_acquire'
    #define smp_load_acquire(p) __smp_load_acquire(p)
                                ^~~~~~~~~~~~~~~~~~
   drivers/char/virtio_console.c:1173:6: note: in expansion of macro 'smp_load_acquire'
         smp_load_acquire(&portdev->pm_freezing)) /* pairs with freeze/restore */
         ^~~~~~~~~~~~~~~~
   drivers/char/virtio_console.c:1173:33: note: in expansion of macro 'pm_freezing'
         smp_load_acquire(&portdev->pm_freezing)) /* pairs with freeze/restore */
                                    ^~~~~~~~~~~
>> include/linux/freezer.h:79:21: error: expected identifier before '(' token
    #define pm_freezing (false)
                        ^
   include/linux/compiler_types.h:682:9: note: in definition of macro '__compiletime_assert'
      if (!(condition))     \
            ^~~~~~~~~
   include/linux/compiler_types.h:702:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:705:2: note: in expansion of macro 'compiletime_assert'
     compiletime_assert(__native_word(t),    \
     ^~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:705:21: note: in expansion of macro '__native_word'
     compiletime_assert(__native_word(t),    \
                        ^~~~~~~~~~~~~
   arch/parisc/include/asm/barrier.h:68:2: note: in expansion of macro 'compiletime_assert_atomic_type'
     compiletime_assert_atomic_type(*p);    \
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/barrier.h:176:29: note: in expansion of macro '__smp_load_acquire'
    #define smp_load_acquire(p) __smp_load_acquire(p)
                                ^~~~~~~~~~~~~~~~~~
   drivers/char/virtio_console.c:1173:6: note: in expansion of macro 'smp_load_acquire'
         smp_load_acquire(&portdev->pm_freezing)) /* pairs with freeze/restore */
         ^~~~~~~~~~~~~~~~
   drivers/char/virtio_console.c:1173:33: note: in expansion of macro 'pm_freezing'
         smp_load_acquire(&portdev->pm_freezing)) /* pairs with freeze/restore */
                                    ^~~~~~~~~~~
>> include/linux/freezer.h:79:21: error: expected identifier before '(' token
    #define pm_freezing (false)
                        ^
   include/linux/compiler_types.h:682:9: note: in definition of macro '__compiletime_assert'
      if (!(condition))     \
            ^~~~~~~~~
   include/linux/compiler_types.h:702:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:705:2: note: in expansion of macro 'compiletime_assert'
     compiletime_assert(__native_word(t),    \
     ^~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:705:21: note: in expansion of macro '__native_word'
     compiletime_assert(__native_word(t),    \
                        ^~~~~~~~~~~~~
   arch/parisc/include/asm/barrier.h:68:2: note: in expansion of macro 'compiletime_assert_atomic_type'
     compiletime_assert_atomic_type(*p);    \
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/barrier.h:176:29: note: in expansion of macro '__smp_load_acquire'
    #define smp_load_acquire(p) __smp_load_acquire(p)
                                ^~~~~~~~~~~~~~~~~~
   drivers/char/virtio_console.c:1173:6: note: in expansion of macro 'smp_load_acquire'
         smp_load_acquire(&portdev->pm_freezing)) /* pairs with freeze/restore */
         ^~~~~~~~~~~~~~~~
   drivers/char/virtio_console.c:1173:33: note: in expansion of macro 'pm_freezing'
         smp_load_acquire(&portdev->pm_freezing)) /* pairs with freeze/restore */
                                    ^~~~~~~~~~~
   In file included from include/linux/list.h:11,
                    from include/linux/kobject.h:19,
                    from include/linux/cdev.h:5,
                    from drivers/char/virtio_console.c:7:
>> include/linux/freezer.h:79:21: error: expected identifier before '(' token
    #define pm_freezing (false)
                        ^
   arch/parisc/include/asm/barrier.h:69:18: note: in definition of macro '__smp_load_acquire'
     switch (sizeof(*p)) {      \
                     ^
   drivers/char/virtio_console.c:1173:6: note: in expansion of macro 'smp_load_acquire'
         smp_load_acquire(&portdev->pm_freezing)) /* pairs with freeze/restore */
         ^~~~~~~~~~~~~~~~
   drivers/char/virtio_console.c:1173:33: note: in expansion of macro 'pm_freezing'
         smp_load_acquire(&portdev->pm_freezing)) /* pairs with freeze/restore */
                                    ^~~~~~~~~~~
   In file included from drivers/char/virtio_console.c:12:
   drivers/char/virtio_console.c: In function 'virtcons_probe':
>> include/linux/freezer.h:79:21: error: expected identifier before '(' token
    #define pm_freezing (false)
                        ^
   drivers/char/virtio_console.c:2071:11: note: in expansion of macro 'pm_freezing'
     portdev->pm_freezing = false;
              ^~~~~~~~~~~


vim +79 include/linux/freezer.h

    77	
    78	#else /* !CONFIG_FREEZER */
  > 79	#define pm_freezing (false)
    80	static inline bool frozen(struct task_struct *p) { return false; }
    81	static inline bool freezing(struct task_struct *p) { return false; }
    82	static inline void __thaw_task(struct task_struct *t) {}
    83	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
