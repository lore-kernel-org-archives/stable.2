Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB4F369D71;
	Fri,  9 Oct 2026 23:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791589719; cv=none; b=iKEgXCb1hOFpRzDMebRXNkwGfvwHeZlg7098eEj1a/XPvIhEZ7j/3WaT53Sf0SrXF/PaAOZDXQflIHbnYoemOmszUmNH1JR0yzQrDcDBT72ZZ0VWxsULDbIsEVx2doUZSsHf9idu8FZUhsgn9v7y9rbsSCPAz1OMU2EbQRDipgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791589719; c=relaxed/simple;
	bh=nFksT7jr0H7znj6H4e1sOyfixlG8c0+BFvQkGSoJ2hI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CFHwgyVD6+Lo+A5IgMLD//ZOllM+GBwQZNEBBMdLDA8KWV5svDfSSGEk4437BrVTySyEGQr9IvGaTKL+CKvwvXNHf3rRdS6SjuyWQ00VBxuKn8NPW4mpr2LmE2O6kBmuTF1MRYi2DjiqFWT7ICo9dzBEWQwagZaM5x938GaKqp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KuFT2kMZ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KuFT2kMZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791589717; x=1823125717;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nFksT7jr0H7znj6H4e1sOyfixlG8c0+BFvQkGSoJ2hI=;
  b=KuFT2kMZuhCBE9X7xetnXbyeANYLk8Y3FYuGRmuQDCUJG7q0JvMOFcdZ
   cQ1fMHTDG09u/8Oc1qRkmBktOmji0kM8SJgueqhGZttpdFV9i2jvBDxab
   w1sAKr0J7T1XUdW41FIk/9Ejh/40PqaVheB+qs8IXmMJipnlW5aPHZ8g+
   JcydgJIQf/HJNvbx8zBfc3+YUPGfo00DHQ6Ji/74lXRYggzZsCvWsS9ij
   /AW+CsmpKwX2P/K8ikwxhZD2ofBl4v7YpE7LyACQAyJbFWxomjbA7GPwM
   TQtSl8D0p9lqzAwkL03jn8hUN0Dx3u96gThwbLajypxPRgzWxf5kBCcWr
   A==;
X-CSE-ConnectionGUID: yLazDjbTS8C2/wBGAQo+BQ==
X-CSE-MsgGUID: o2TxFQDoSU+sL+GqDanrDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="402905"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="402905"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 16:48:37 -0700
X-CSE-ConnectionGUID: zYZemT7FRKiXhIDZ54CJtw==
X-CSE-MsgGUID: lAf2XBhhSr6pK8gli9KZUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="879781"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 09 Oct 2026 16:48:33 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xFKKE-000000006IS-1xKj;
	Fri, 09 Oct 2026 23:48:30 +0000
Date: Sat, 10 Oct 2026 07:47:55 +0800
From: kernel test robot <lkp@intel.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, rafael@kernel.org,
	lenb@kernel.org, pavel@kernel.org, willemdebruijn.kernel@gmail.com,
	kuba@kernel.org, pabeni@redhat.com, linux-pm@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, "Jason A. Donenfeld" <Jason@zx2c4.com>,
	stable@vger.kernel.org,
	=?iso-8859-1?B?Suly6W15?= Jean <jeremy.jean@oss.cyber.gouv.fr>
Subject: Re: [PATCH net] udp_tunnel: drop packets when hibernating
Message-ID: <202610100745.bqMCEIml-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Jason-A-Donenfeld/udp_tunnel-drop-packets-when-hibernating/20261008-144021
base:   net/main
patch link:    https://lore.kernel.org/r/20261008124106.665014-1-Jason%40zx2c4.com
patch subject: [PATCH net] udp_tunnel: drop packets when hibernating
config: arm64-randconfig-1000-20261010 (https://download.01.org/0day-ci/archive/20261010/202610100745.bqMCEIml-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261010/202610100745.bqMCEIml-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610100745.bqMCEIml-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/char/virtio_console.c:636:33: note: in expansion of macro 'pm_freezing'
     if (smp_load_acquire(&portdev->pm_freezing)) /* pairs with freeze/restore */
                                    ^~~~~~~~~~~
   include/linux/freezer.h:79:21: error: expected identifier before '(' token
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
   arch/arm64/include/asm/barrier.h:169:2: note: in expansion of macro 'compiletime_assert_atomic_type'
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
   include/linux/freezer.h:79:21: error: expected identifier before '(' token
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
   arch/arm64/include/asm/barrier.h:169:2: note: in expansion of macro 'compiletime_assert_atomic_type'
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
   include/linux/freezer.h:79:21: error: expected identifier before '(' token
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
   arch/arm64/include/asm/barrier.h:169:2: note: in expansion of macro 'compiletime_assert_atomic_type'
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
   include/linux/freezer.h:79:21: error: expected identifier before '(' token
    #define pm_freezing (false)
                        ^
   arch/arm64/include/asm/barrier.h:170:32: note: in definition of macro '__smp_load_acquire'
     kasan_check_read(__p, sizeof(*p));    \
                                   ^
   drivers/char/virtio_console.c:636:6: note: in expansion of macro 'smp_load_acquire'
     if (smp_load_acquire(&portdev->pm_freezing)) /* pairs with freeze/restore */
         ^~~~~~~~~~~~~~~~
   drivers/char/virtio_console.c:636:33: note: in expansion of macro 'pm_freezing'
     if (smp_load_acquire(&portdev->pm_freezing)) /* pairs with freeze/restore */
                                    ^~~~~~~~~~~
>> arch/arm64/include/asm/barrier.h:170:19: warning: passing argument 1 of 'kasan_check_read' makes pointer from integer without a cast [-Wint-conversion]
     kasan_check_read(__p, sizeof(*p));    \
                      ^~~
   include/asm-generic/barrier.h:176:29: note: in expansion of macro '__smp_load_acquire'
    #define smp_load_acquire(p) __smp_load_acquire(p)
                                ^~~~~~~~~~~~~~~~~~
   drivers/char/virtio_console.c:636:6: note: in expansion of macro 'smp_load_acquire'
     if (smp_load_acquire(&portdev->pm_freezing)) /* pairs with freeze/restore */
         ^~~~~~~~~~~~~~~~
   In file included from include/asm-generic/rwonce.h:26,
                    from arch/arm64/include/asm/rwonce.h:81,
                    from include/linux/compiler.h:369,
                    from include/linux/build_bug.h:5,
                    from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/kobject.h:19,
                    from include/linux/cdev.h:5,
                    from drivers/char/virtio_console.c:7:
   include/linux/kasan-checks.h:40:58: note: expected 'const volatile void *' but argument is of type 'int'
    static inline bool kasan_check_read(const volatile void *p, unsigned int size)
                                        ~~~~~~~~~~~~~~~~~~~~~^
   In file included from include/linux/list.h:11,
                    from include/linux/kobject.h:19,
                    from include/linux/cdev.h:5,
                    from drivers/char/virtio_console.c:7:
   include/linux/freezer.h:79:21: error: expected identifier before '(' token
    #define pm_freezing (false)
                        ^
   arch/arm64/include/asm/barrier.h:171:18: note: in definition of macro '__smp_load_acquire'
     switch (sizeof(*p)) {      \
                     ^
   drivers/char/virtio_console.c:636:6: note: in expansion of macro 'smp_load_acquire'
     if (smp_load_acquire(&portdev->pm_freezing)) /* pairs with freeze/restore */
         ^~~~~~~~~~~~~~~~
   drivers/char/virtio_console.c:636:33: note: in expansion of macro 'pm_freezing'
     if (smp_load_acquire(&portdev->pm_freezing)) /* pairs with freeze/restore */
                                    ^~~~~~~~~~~
   arch/arm64/include/asm/barrier.h:175:11: error: invalid type argument of unary '*' (have 'int')
       : "Q" (*__p) : "memory");   \
              ^~~~
   include/asm-generic/barrier.h:176:29: note: in expansion of macro '__smp_load_acquire'
    #define smp_load_acquire(p) __smp_load_acquire(p)
                                ^~~~~~~~~~~~~~~~~~
   drivers/char/virtio_console.c:636:6: note: in expansion of macro 'smp_load_acquire'
     if (smp_load_acquire(&portdev->pm_freezing)) /* pairs with freeze/restore */
         ^~~~~~~~~~~~~~~~
   arch/arm64/include/asm/barrier.h:180:11: error: invalid type argument of unary '*' (have 'int')
       : "Q" (*__p) : "memory");   \
              ^~~~
   include/asm-generic/barrier.h:176:29: note: in expansion of macro '__smp_load_acquire'
    #define smp_load_acquire(p) __smp_load_acquire(p)
                                ^~~~~~~~~~~~~~~~~~
   drivers/char/virtio_console.c:636:6: note: in expansion of macro 'smp_load_acquire'
     if (smp_load_acquire(&portdev->pm_freezing)) /* pairs with freeze/restore */
         ^~~~~~~~~~~~~~~~
   arch/arm64/include/asm/barrier.h:185:11: error: invalid type argument of unary '*' (have 'int')
       : "Q" (*__p) : "memory");   \
              ^~~~
   include/asm-generic/barrier.h:176:29: note: in expansion of macro '__smp_load_acquire'
    #define smp_load_acquire(p) __smp_load_acquire(p)
                                ^~~~~~~~~~~~~~~~~~
   drivers/char/virtio_console.c:636:6: note: in expansion of macro 'smp_load_acquire'
     if (smp_load_acquire(&portdev->pm_freezing)) /* pairs with freeze/restore */
         ^~~~~~~~~~~~~~~~
   arch/arm64/include/asm/barrier.h:190:11: error: invalid type argument of unary '*' (have 'int')
       : "Q" (*__p) : "memory");   \
              ^~~~
   include/asm-generic/barrier.h:176:29: note: in expansion of macro '__smp_load_acquire'
    #define smp_load_acquire(p) __smp_load_acquire(p)
                                ^~~~~~~~~~~~~~~~~~
   drivers/char/virtio_console.c:636:6: note: in expansion of macro 'smp_load_acquire'
     if (smp_load_acquire(&portdev->pm_freezing)) /* pairs with freeze/restore */
         ^~~~~~~~~~~~~~~~
   include/linux/freezer.h:79:21: error: expected identifier before '(' token
    #define pm_freezing (false)
                        ^
   arch/arm64/include/asm/barrier.h:193:11: note: in definition of macro '__smp_load_acquire'
     (typeof(*p))__u.__val;      \
              ^
   drivers/char/virtio_console.c:636:6: note: in expansion of macro 'smp_load_acquire'
     if (smp_load_acquire(&portdev->pm_freezing)) /* pairs with freeze/restore */
         ^~~~~~~~~~~~~~~~
   drivers/char/virtio_console.c:636:33: note: in expansion of macro 'pm_freezing'
     if (smp_load_acquire(&portdev->pm_freezing)) /* pairs with freeze/restore */
                                    ^~~~~~~~~~~
   In file included from <command-line>:
   drivers/char/virtio_console.c: In function 'put_chars':
   include/linux/freezer.h:79:21: error: expected identifier before '(' token
    #define pm_freezing (false)
                        ^
   include/linux/compiler_types.h:626:13: note: in definition of macro '__unqual_scalar_typeof'
      _Generic((x),      \
                ^
   include/asm-generic/barrier.h:176:29: note: in expansion of macro '__smp_load_acquire'
    #define smp_load_acquire(p) __smp_load_acquire(p)
                                ^~~~~~~~~~~~~~~~~~
   drivers/char/virtio_console.c:1173:6: note: in expansion of macro 'smp_load_acquire'
         smp_load_acquire(&portdev->pm_freezing)) /* pairs with freeze/restore */
         ^~~~~~~~~~~~~~~~
   drivers/char/virtio_console.c:1173:33: note: in expansion of macro 'pm_freezing'
         smp_load_acquire(&portdev->pm_freezing)) /* pairs with freeze/restore */
--
   drivers/char/virtio_console.c:1173:33: note: in expansion of macro 'pm_freezing'
         smp_load_acquire(&portdev->pm_freezing)) /* pairs with freeze/restore */
                                    ^~~~~~~~~~~
   include/linux/freezer.h:79:21: error: expected identifier before '(' token
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
   arch/arm64/include/asm/barrier.h:169:2: note: in expansion of macro 'compiletime_assert_atomic_type'
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
   include/linux/freezer.h:79:21: error: expected identifier before '(' token
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
   arch/arm64/include/asm/barrier.h:169:2: note: in expansion of macro 'compiletime_assert_atomic_type'
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
   include/linux/freezer.h:79:21: error: expected identifier before '(' token
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
   arch/arm64/include/asm/barrier.h:169:2: note: in expansion of macro 'compiletime_assert_atomic_type'
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
   include/linux/freezer.h:79:21: error: expected identifier before '(' token
    #define pm_freezing (false)
                        ^
   arch/arm64/include/asm/barrier.h:170:32: note: in definition of macro '__smp_load_acquire'
     kasan_check_read(__p, sizeof(*p));    \
                                   ^
   drivers/char/virtio_console.c:1173:6: note: in expansion of macro 'smp_load_acquire'
         smp_load_acquire(&portdev->pm_freezing)) /* pairs with freeze/restore */
         ^~~~~~~~~~~~~~~~
   drivers/char/virtio_console.c:1173:33: note: in expansion of macro 'pm_freezing'
         smp_load_acquire(&portdev->pm_freezing)) /* pairs with freeze/restore */
                                    ^~~~~~~~~~~
>> arch/arm64/include/asm/barrier.h:170:19: warning: passing argument 1 of 'kasan_check_read' makes pointer from integer without a cast [-Wint-conversion]
     kasan_check_read(__p, sizeof(*p));    \
                      ^~~
   include/asm-generic/barrier.h:176:29: note: in expansion of macro '__smp_load_acquire'
    #define smp_load_acquire(p) __smp_load_acquire(p)
                                ^~~~~~~~~~~~~~~~~~
   drivers/char/virtio_console.c:1173:6: note: in expansion of macro 'smp_load_acquire'
         smp_load_acquire(&portdev->pm_freezing)) /* pairs with freeze/restore */
         ^~~~~~~~~~~~~~~~
   In file included from include/asm-generic/rwonce.h:26,
                    from arch/arm64/include/asm/rwonce.h:81,
                    from include/linux/compiler.h:369,
                    from include/linux/build_bug.h:5,
                    from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/kobject.h:19,
                    from include/linux/cdev.h:5,
                    from drivers/char/virtio_console.c:7:
   include/linux/kasan-checks.h:40:58: note: expected 'const volatile void *' but argument is of type 'int'
    static inline bool kasan_check_read(const volatile void *p, unsigned int size)
                                        ~~~~~~~~~~~~~~~~~~~~~^
   In file included from include/linux/list.h:11,
                    from include/linux/kobject.h:19,
                    from include/linux/cdev.h:5,
                    from drivers/char/virtio_console.c:7:
   include/linux/freezer.h:79:21: error: expected identifier before '(' token
    #define pm_freezing (false)
                        ^
   arch/arm64/include/asm/barrier.h:171:18: note: in definition of macro '__smp_load_acquire'
     switch (sizeof(*p)) {      \
                     ^
   drivers/char/virtio_console.c:1173:6: note: in expansion of macro 'smp_load_acquire'
         smp_load_acquire(&portdev->pm_freezing)) /* pairs with freeze/restore */
         ^~~~~~~~~~~~~~~~
   drivers/char/virtio_console.c:1173:33: note: in expansion of macro 'pm_freezing'
         smp_load_acquire(&portdev->pm_freezing)) /* pairs with freeze/restore */
                                    ^~~~~~~~~~~
   arch/arm64/include/asm/barrier.h:175:11: error: invalid type argument of unary '*' (have 'int')
       : "Q" (*__p) : "memory");   \
              ^~~~
   include/asm-generic/barrier.h:176:29: note: in expansion of macro '__smp_load_acquire'
    #define smp_load_acquire(p) __smp_load_acquire(p)
                                ^~~~~~~~~~~~~~~~~~
   drivers/char/virtio_console.c:1173:6: note: in expansion of macro 'smp_load_acquire'
         smp_load_acquire(&portdev->pm_freezing)) /* pairs with freeze/restore */
         ^~~~~~~~~~~~~~~~
   arch/arm64/include/asm/barrier.h:180:11: error: invalid type argument of unary '*' (have 'int')
       : "Q" (*__p) : "memory");   \
              ^~~~
   include/asm-generic/barrier.h:176:29: note: in expansion of macro '__smp_load_acquire'
    #define smp_load_acquire(p) __smp_load_acquire(p)
                                ^~~~~~~~~~~~~~~~~~
   drivers/char/virtio_console.c:1173:6: note: in expansion of macro 'smp_load_acquire'
         smp_load_acquire(&portdev->pm_freezing)) /* pairs with freeze/restore */
         ^~~~~~~~~~~~~~~~
   arch/arm64/include/asm/barrier.h:185:11: error: invalid type argument of unary '*' (have 'int')
       : "Q" (*__p) : "memory");   \
              ^~~~
   include/asm-generic/barrier.h:176:29: note: in expansion of macro '__smp_load_acquire'
    #define smp_load_acquire(p) __smp_load_acquire(p)
                                ^~~~~~~~~~~~~~~~~~
   drivers/char/virtio_console.c:1173:6: note: in expansion of macro 'smp_load_acquire'
         smp_load_acquire(&portdev->pm_freezing)) /* pairs with freeze/restore */
         ^~~~~~~~~~~~~~~~
   arch/arm64/include/asm/barrier.h:190:11: error: invalid type argument of unary '*' (have 'int')
       : "Q" (*__p) : "memory");   \
              ^~~~
   include/asm-generic/barrier.h:176:29: note: in expansion of macro '__smp_load_acquire'
    #define smp_load_acquire(p) __smp_load_acquire(p)
                                ^~~~~~~~~~~~~~~~~~
   drivers/char/virtio_console.c:1173:6: note: in expansion of macro 'smp_load_acquire'
         smp_load_acquire(&portdev->pm_freezing)) /* pairs with freeze/restore */
         ^~~~~~~~~~~~~~~~
   include/linux/freezer.h:79:21: error: expected identifier before '(' token
    #define pm_freezing (false)
                        ^
   arch/arm64/include/asm/barrier.h:193:11: note: in definition of macro '__smp_load_acquire'
     (typeof(*p))__u.__val;      \
              ^
   drivers/char/virtio_console.c:1173:6: note: in expansion of macro 'smp_load_acquire'
         smp_load_acquire(&portdev->pm_freezing)) /* pairs with freeze/restore */
         ^~~~~~~~~~~~~~~~
   drivers/char/virtio_console.c:1173:33: note: in expansion of macro 'pm_freezing'
         smp_load_acquire(&portdev->pm_freezing)) /* pairs with freeze/restore */
                                    ^~~~~~~~~~~
   In file included from drivers/char/virtio_console.c:12:
   drivers/char/virtio_console.c: In function 'virtcons_probe':
   include/linux/freezer.h:79:21: error: expected identifier before '(' token
    #define pm_freezing (false)
                        ^
   drivers/char/virtio_console.c:2071:11: note: in expansion of macro 'pm_freezing'
     portdev->pm_freezing = false;
              ^~~~~~~~~~~


vim +/kasan_check_read +170 arch/arm64/include/asm/barrier.h

47933ad41a86a4 Peter Zijlstra     2013-11-06  164  
fd072df850e536 Michael S. Tsirkin 2015-12-27  165  #define __smp_load_acquire(p)						\
47933ad41a86a4 Peter Zijlstra     2013-11-06  166  ({									\
10223c5286f738 Will Deacon        2019-12-19  167  	union { __unqual_scalar_typeof(*p) __val; char __c[1]; } __u;	\
131e135f7fd14b Mark Rutland       2019-04-09  168  	typeof(p) __p = (p);						\
47933ad41a86a4 Peter Zijlstra     2013-11-06  169  	compiletime_assert_atomic_type(*p);				\
131e135f7fd14b Mark Rutland       2019-04-09 @170  	kasan_check_read(__p, sizeof(*p));				\
47933ad41a86a4 Peter Zijlstra     2013-11-06  171  	switch (sizeof(*p)) {						\
878a84d5a8a18a Andre Przywara     2015-04-20  172  	case 1:								\
878a84d5a8a18a Andre Przywara     2015-04-20  173  		asm volatile ("ldarb %w0, %1"				\
c139aa60c10074 Will Deacon        2015-11-18  174  			: "=r" (*(__u8 *)__u.__c)			\
131e135f7fd14b Mark Rutland       2019-04-09  175  			: "Q" (*__p) : "memory");			\
878a84d5a8a18a Andre Przywara     2015-04-20  176  		break;							\
878a84d5a8a18a Andre Przywara     2015-04-20  177  	case 2:								\
878a84d5a8a18a Andre Przywara     2015-04-20  178  		asm volatile ("ldarh %w0, %1"				\
c139aa60c10074 Will Deacon        2015-11-18  179  			: "=r" (*(__u16 *)__u.__c)			\
131e135f7fd14b Mark Rutland       2019-04-09  180  			: "Q" (*__p) : "memory");			\
878a84d5a8a18a Andre Przywara     2015-04-20  181  		break;							\
47933ad41a86a4 Peter Zijlstra     2013-11-06  182  	case 4:								\
47933ad41a86a4 Peter Zijlstra     2013-11-06  183  		asm volatile ("ldar %w0, %1"				\
c139aa60c10074 Will Deacon        2015-11-18  184  			: "=r" (*(__u32 *)__u.__c)			\
131e135f7fd14b Mark Rutland       2019-04-09  185  			: "Q" (*__p) : "memory");			\
47933ad41a86a4 Peter Zijlstra     2013-11-06  186  		break;							\
47933ad41a86a4 Peter Zijlstra     2013-11-06  187  	case 8:								\
47933ad41a86a4 Peter Zijlstra     2013-11-06  188  		asm volatile ("ldar %0, %1"				\
c139aa60c10074 Will Deacon        2015-11-18  189  			: "=r" (*(__u64 *)__u.__c)			\
131e135f7fd14b Mark Rutland       2019-04-09  190  			: "Q" (*__p) : "memory");			\
47933ad41a86a4 Peter Zijlstra     2013-11-06  191  		break;							\
47933ad41a86a4 Peter Zijlstra     2013-11-06  192  	}								\
10223c5286f738 Will Deacon        2019-12-19  193  	(typeof(*p))__u.__val;						\
47933ad41a86a4 Peter Zijlstra     2013-11-06  194  })
47933ad41a86a4 Peter Zijlstra     2013-11-06  195  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
