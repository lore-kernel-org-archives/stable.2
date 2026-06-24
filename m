Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5D1271456
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 03:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782270834; cv=none; b=V0+mEy3V2NLygcYmOIqkmPyjhpQ7Wd8tt0/qAQCUj2sMujMOd6GpbjSuJMbQZwEACSXGDtuJWAKtXR8cj4u8D7FG0nH+TPacnagkoicib6wM/Zoamx5JR/Bfa6k9c5bqA26zp6t6IFiKK+vCkiAjILvuD2wXk/fEB2GMXeEqLhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782270834; c=relaxed/simple;
	bh=C4jlcWPhrC0wzybY0QxDLLJr2pfB4v1cPwav+EQZ+Uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lvBy6j2YRO7hP2SHe57ZMBQvnhRi08z2b8ZKAmJ2JgHyCBTLb8Y+D5faRI0nxHIRffCaDONi17HmTHaTkFqZRSF0CwLQO5ldbwSKKJXe08lbFbENlk0wQEdwFQ8qJbCv4csD/feFXtPrRMMh1Sl+Wdvigq9/l16vk3FToygtm6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WtFPIqMh; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtFPIqMh"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c0115a3794bso94319566b.0
        for <stable@vger.kernel.org>; Tue, 23 Jun 2026 20:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782270831; x=1782875631; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yQrzuV1rnE++lwljv+0k3oMRhBJ0TRHfGR8h8CiTgyE=;
        b=WtFPIqMhoXH1YB8hrkU6xPanWgRRbD8/Al3fPch/Fv5aBG6Q+jvdKOLv7FR3O+6MOs
         MYJKSYnEnZTaPyQffv1lQ7CYtCjuGdORRd4eHwW+gdLzDNDiSF2TUA5ed9g06uasXFid
         3BNYa/F4ttn41v4ekoIZpv7Sl8uWmzJKc8nhCrzW8ZUc7p7NdY14sFap628AM+y5WPzq
         i3fH51MkcnI8FCzZxWUhyIiv8/OWznmvCx/r9eaOq/HvDGvCl5SZs/cyRPRrpOa50QYi
         1Kg1kknaqp6Vk4kPFfayvFNoUulWbxIhHZQC4MGx8KZxMDLG+No6jzIQtmuUKw4D3Czx
         0/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782270831; x=1782875631;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yQrzuV1rnE++lwljv+0k3oMRhBJ0TRHfGR8h8CiTgyE=;
        b=BH/2MTxLrUsqo4fD9LQIu3OyvsVa4m5tcRzJXlVGzQ60/yBcULQnQr+QoJHGHVGXK3
         zUBk1HExk5ZazAM5UomuFaN/vDc/sRDyIaZ2qmLx5Xdb6XpjUMiG5vITRfMfOgkKUk5V
         CJZJ/ENfEgZAo+3binwwrQNUP4SepInEnGsGcaRUZwCCUofLnjddtEGpiSPeHLd3YcvP
         abaQIBluaGY/S6rEFlRpfHWgIqUFmygvNl4SJuGWiVf/mEJnV7L4fJRAD5QHAf0Vo6t7
         k3vstF9gU/p8lMXpbSx6BzubKZ+pVBXmWTvZs/3NuMWdQWQ8nKelIKTrv/bZIEza7NmU
         wafQ==
X-Forwarded-Encrypted: i=1; AFNElJ/nuln2eTTaiuiKLKiEWJRhw3oN2gdrh3fLexj3E0Ks2JhSst23bp879YIuMb2KET0cFBUTcjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGW23ZBGfTRDuojPBJ5aK2mH5U32rikPnnHdzcCzmnHQ7a83cd
	xFvXnEfLJuJDTNAZKTYazY1CpVXrqeI85Co1NUTBM+Tskl+R1A2pLDG7
X-Gm-Gg: AfdE7ckr2BXGI5oSLsTVWjSNkRjYg+CenEqlIuVKDVFUd8jl7ovP3VUYLL1ERBcFu51
	hRf2QxUvpGb/lT8L7XhbPrF0iYxrN4KJNBuKBu7kNWiO8LKgXRLZI5iJ+QCC7j97FFaACq4eLCR
	j6jBU0vxcphtPFZ98LDxuRweO6E2m5n9ulQowuHXZ8B1pCQN7ygQJGzqtA7bBSXCjfU6wEtWsvM
	V3RNXzr2JP+G1YY7o8r8gZxl1g5MI3NAulAW+bJGTyB6R9CsYls/VYVVI/nq1h1qTlqTJYruRj1
	3LbHXgQvzg7TvQWkWkzNuL/1YaVkMtlybg8Rih8FNDXjAAPtvZ9IyAmXOfphMcO9Mdj7sNzhT9n
	xyD0pz1V/OZ9itSQNkPHLCAeHsIU0f63Z3RE2T+CS5Y+cwvuRCgMFlEpoeV/EzwPRHkaTF51Zg4
	1PApjkYj7kJck=
X-Received: by 2002:a17:907:1c1c:b0:c09:4ad0:9a3 with SMTP id a640c23a62f3a-c119ce7c34dmr60766066b.4.1782270830624;
        Tue, 23 Jun 2026 20:13:50 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-697f3ade18esm362886a12.7.2026.06.23.20.13.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Jun 2026 20:13:49 -0700 (PDT)
Date: Wed, 24 Jun 2026 03:13:47 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: kernel test robot <lkp@intel.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
	david@kernel.org, ljs@kernel.org, riel@surriel.com,
	liam@infradead.org, vbabka@kernel.org, harry@kernel.org,
	jannh@google.com, sj@kernel.org, ziy@nvidia.com, balbirs@nvidia.com,
	oe-kbuild-all@lists.linux.dev, linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/page_vma_mapped: revalidate and do proper check
 before return device-private pmd
Message-ID: <20260624031347.zq2lhnnthuxqcuql@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20260622130651.23359-1-richard.weiyang@gmail.com>
 <202606240042.ffPsEXVc-lkp@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202606240042.ffPsEXVc-lkp@intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Jun 24, 2026 at 12:18:20AM +0800, kernel test robot wrote:
>Hi Wei,
>
>kernel test robot noticed the following build errors:
>

Thanks for reporting.

>[auto build test ERROR on akpm-mm/mm-everything]
>
>url:    https://github.com/intel-lab-lkp/linux/commits/Wei-Yang/mm-page_vma_mapped-revalidate-and-do-proper-check-before-return-device-private-pmd/20260623-012838
>base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
>patch link:    https://lore.kernel.org/r/20260622130651.23359-1-richard.weiyang%40gmail.com
>patch subject: [PATCH] mm/page_vma_mapped: revalidate and do proper check before return device-private pmd
>config: parisc-randconfig-002-20260623 (https://download.01.org/0day-ci/archive/20260624/202606240042.ffPsEXVc-lkp@intel.com/config)

So this is parisc arch.

In the config file, HAVE_ARCH_TRANSPARENT_HUGEPAGE is not defined. Which leads
to !TRANSPARENT_HUGEPAGE and !PGTABLE_HAS_HUGE_LEAVES.

And then trigger the BUILD_BUG().

>compiler: hppa-linux-gcc (GCC) 8.5.0
>reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260624/202606240042.ffPsEXVc-lkp@intel.com/reproduce)
>
>If you fix the issue in a separate patch/commit (i.e. not just a new version of
>the same patch/commit), kindly add following tags
>| Reported-by: kernel test robot <lkp@intel.com>
>| Closes: https://lore.kernel.org/oe-kbuild-all/202606240042.ffPsEXVc-lkp@intel.com/
>
>All errors (new ones prefixed by >>):
>
>   In file included from <command-line>:
>   In function 'check_pmd.isra.24',
>       inlined from 'page_vma_mapped_walk' at mm/page_vma_mapped.c:283:11:
>>> include/linux/compiler_types.h:699:38: error: call to '__compiletime_assert_406' declared with attribute error: BUILD_BUG failed
>     _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>                                         ^
>   include/linux/compiler_types.h:680:4: note: in definition of macro '__compiletime_assert'
>       prefix ## suffix();    \
>       ^~~~~~
>   include/linux/compiler_types.h:699:2: note: in expansion of macro '_compiletime_assert'
>     _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>     ^~~~~~~~~~~~~~~~~~~
>   include/linux/build_bug.h:40:37: note: in expansion of macro 'compiletime_assert'
>    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>                                        ^~~~~~~~~~~~~~~~~~
>   include/linux/build_bug.h:60:21: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>    #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
>                        ^~~~~~~~~~~~~~~~
>   include/linux/huge_mm.h:113:28: note: in expansion of macro 'BUILD_BUG'
>    #define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
>                               ^~~~~~~~~
>   include/linux/huge_mm.h:117:26: note: in expansion of macro 'HPAGE_PMD_SHIFT'
>    #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
>                             ^~~~~~~~~~~~~~~
>   include/linux/huge_mm.h:118:26: note: in expansion of macro 'HPAGE_PMD_ORDER'
>    #define HPAGE_PMD_NR (1<<HPAGE_PMD_ORDER)
>                             ^~~~~~~~~~~~~~~
>   mm/page_vma_mapped.c:142:13: note: in expansion of macro 'HPAGE_PMD_NR'
>     if ((pfn + HPAGE_PMD_NR - 1) < pvmw->pfn)
>                ^~~~~~~~~~~~
>

This is in definition of check_pmd() which is already in kernel for a while.

I will update current version, and take a look to how to fix it.

>
>vim +/__compiletime_assert_406 +699 include/linux/compiler_types.h
>
>eb5c2d4b45e3d2d Will Deacon 2020-07-21  685  
>eb5c2d4b45e3d2d Will Deacon 2020-07-21  686  #define _compiletime_assert(condition, msg, prefix, suffix) \
>eb5c2d4b45e3d2d Will Deacon 2020-07-21  687  	__compiletime_assert(condition, msg, prefix, suffix)
>eb5c2d4b45e3d2d Will Deacon 2020-07-21  688  
>eb5c2d4b45e3d2d Will Deacon 2020-07-21  689  /**
>eb5c2d4b45e3d2d Will Deacon 2020-07-21  690   * compiletime_assert - break build and emit msg if condition is false
>eb5c2d4b45e3d2d Will Deacon 2020-07-21  691   * @condition: a compile-time constant condition to check
>eb5c2d4b45e3d2d Will Deacon 2020-07-21  692   * @msg:       a message to emit if condition is false
>eb5c2d4b45e3d2d Will Deacon 2020-07-21  693   *
>eb5c2d4b45e3d2d Will Deacon 2020-07-21  694   * In tradition of POSIX assert, this macro will break the build if the
>eb5c2d4b45e3d2d Will Deacon 2020-07-21  695   * supplied condition is *false*, emitting the supplied error message if the
>eb5c2d4b45e3d2d Will Deacon 2020-07-21  696   * compiler has support to do so.
>eb5c2d4b45e3d2d Will Deacon 2020-07-21  697   */
>eb5c2d4b45e3d2d Will Deacon 2020-07-21  698  #define compiletime_assert(condition, msg) \
>eb5c2d4b45e3d2d Will Deacon 2020-07-21 @699  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>eb5c2d4b45e3d2d Will Deacon 2020-07-21  700  
>
>--
>0-DAY CI Kernel Test Service
>https://github.com/intel/lkp-tests/wiki

-- 
Wei Yang
Help you, Help me
