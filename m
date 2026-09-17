Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF7A4E0218;
	Thu, 17 Sep 2026 20:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789677014; cv=none; b=PUZfuVPv3cXLETEegOwd00H1xUxZiy/17K3a1aGmGNxk8qKIb/H7NAfTRK8DDGbhR+6KVhNtjGDryagzO/epg9KMhqYnxRlsE7A9WH1UQgCOYYqyvsf77i9/ppBxx40jw6VIHNoRurdUXWouVzWqCYvLeCBGvr6y/6iD/P0/UUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789677014; c=relaxed/simple;
	bh=O4E/r/TO4Ia/0BjZxJmv84fyinvl9/+1ynT1NWdhvas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mX26IMyGppycc35y179uoWSKf89fwlp7nV8tJtNXnq5bOuEI/lmWv8LozDXgq97o4ro2dYe4hEne9QQc3zTDj23wqOJi1fSvedKwwJoCU1zdgh1DCrRvcZEGn2iLi7hzYQxh/Fn0pUHd4bPoP5qMVD509ESjqXrx6s0+xTC9Fn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y/O9H4/J; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y/O9H4/J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789677013; x=1821213013;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O4E/r/TO4Ia/0BjZxJmv84fyinvl9/+1ynT1NWdhvas=;
  b=Y/O9H4/JvHtY233JWEPekKTQrT47IzeBjH2m2xL0I4gZeAarqOYsKruj
   tW2acy7rx8ifiOxI+LWOxmoAhsaTsJZTI/bGoUaZMcMtaqd6omlCUGdRS
   8GVKrupUQ0JcC5hzhrTG8IebXj7LS33kOPzxKft7/Z9GHiCDnlw8xvWzs
   6IpIHgnWvvo2ZMgWjbhcrkdyXeORb5QdOx02gBmp9dZZRW8P05r4kJu1B
   cEAfnN/AsbYafHz5OKofO91wUxW7MGBVZfJg9YqsgGIxci8SMwIvvc07f
   gmAokr81FsUUug0dyCkw9JJTU/NbjdqF8KXC3qKfPFFhmUWSUlPFTuybD
   g==;
X-CSE-ConnectionGUID: iyumjsCySpSyIQWxjbIh4g==
X-CSE-MsgGUID: 3sjK4EGlSfqzKknHO9k6gQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="90007920"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="90007920"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 13:30:12 -0700
X-CSE-ConnectionGUID: dSxZsrCVRm6JjrCxhaBwiw==
X-CSE-MsgGUID: LwfJGjC0QIGxUw/0hFem2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="267777446"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 17 Sep 2026 13:30:08 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x7Ik9-000000008TJ-42b7;
	Thu, 17 Sep 2026 20:30:05 +0000
Date: Fri, 18 Sep 2026 04:29:06 +0800
From: kernel test robot <lkp@intel.com>
To: Wentao Liang <vulab@iscas.ac.cn>, airlied@gmail.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	dri-devel@lists.freedesktop.org, jernej.skrabec@gmail.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, samuel@sholland.org, simona@ffwll.ch,
	tzimmermann@suse.de, wens@kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>, stable@vger.kernel.org
Subject: Re: [PATCH] drm/sun4i: Fix pdev reference leak in
 sun8i_r40_tcon_tv_set_mux()
Message-ID: <202609180443.vTkwAZL6-lkp@intel.com>
References: <20260916182412.2091681-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916182412.2091681-1-vulab@iscas.ac.cn>

Hi Wentao,

kernel test robot noticed the following build errors:

[auto build test ERROR on sunxi/sunxi/for-next]
[also build test ERROR on daeinki-drm-exynos/exynos-drm-next drm/drm-next drm-i915/for-linux-next drm-i915/for-linux-next-fixes drm-misc/drm-misc-next drm-tip/drm-tip linus/master v7.3-rc3 next-20260916]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wentao-Liang/drm-sun4i-Fix-pdev-reference-leak-in-sun8i_r40_tcon_tv_set_mux/20260916-182412
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git sunxi/for-next
patch link:    https://lore.kernel.org/r/20260916182412.2091681-1-vulab%40iscas.ac.cn
patch subject: [PATCH] drm/sun4i: Fix pdev reference leak in sun8i_r40_tcon_tv_set_mux()
config: arm-defconfig (https://download.01.org/0day-ci/archive/20260918/202609180443.vTkwAZL6-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 7252edd9aa82ef1c570ff6694ef7f4763a8a5d2f)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260918/202609180443.vTkwAZL6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609180443.vTkwAZL6-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/sun4i/sun4i_tcon.c:811:14: error: use of undeclared identifier 'pdev'; did you mean 'dev'?
     811 |         put_device(&pdev->dev);
         |                     ^~~~
         |                     dev
   drivers/gpu/drm/sun4i/sun4i_tcon.c:786:50: note: 'dev' declared here
     786 | static int sun4i_tcon_init_clocks(struct device *dev,
         |                                                  ^
>> drivers/gpu/drm/sun4i/sun4i_tcon.c:811:20: error: no member named 'dev' in 'struct device'
     811 |         put_device(&pdev->dev);
         |                     ~~~~  ^
   2 errors generated.


vim +811 drivers/gpu/drm/sun4i/sun4i_tcon.c

   785	
   786	static int sun4i_tcon_init_clocks(struct device *dev,
   787					  struct sun4i_tcon *tcon)
   788	{
   789		tcon->clk = devm_clk_get_enabled(dev, "ahb");
   790		if (IS_ERR(tcon->clk)) {
   791			dev_err(dev, "Couldn't get the TCON bus clock\n");
   792			return PTR_ERR(tcon->clk);
   793		}
   794	
   795		if (tcon->quirks->has_channel_0) {
   796			tcon->sclk0 = devm_clk_get_enabled(dev, "tcon-ch0");
   797			if (IS_ERR(tcon->sclk0)) {
   798				dev_err(dev, "Couldn't get the TCON channel 0 clock\n");
   799				return PTR_ERR(tcon->sclk0);
   800			}
   801		}
   802	
   803		if (tcon->quirks->has_channel_1) {
   804			tcon->sclk1 = devm_clk_get(dev, "tcon-ch1");
   805			if (IS_ERR(tcon->sclk1)) {
   806				dev_err(dev, "Couldn't get the TCON channel 1 clock\n");
   807				return PTR_ERR(tcon->sclk1);
   808			}
   809		}
   810	
 > 811		put_device(&pdev->dev);
   812	
   813		return 0;
   814	}
   815	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
