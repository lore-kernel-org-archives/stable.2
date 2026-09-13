Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCA5361956;
	Sun, 13 Sep 2026 19:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789328825; cv=none; b=lHnltOU7MGZLwrMioSwp/Hce5zpDmo8exMtsNqRSM6GG8h+rW4uNIOJrJLovYiZ/tOgAkKd2pNwHSSI3iky0WSv2p4LgKBtXGtTQ++5eH0h1tSdp1Ip2cCfVpDEUnG6zRoV17QtwiIPRUsarJvFDT/SD5+pRgcODRELoKDQCNhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789328825; c=relaxed/simple;
	bh=izrSfcSyLZ17qqk49jxHMCdN9N8POUPieQ93sAyIQJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rI0wZuZ+zeHvAS9pGiO8d+n2jPSpQGF84A9MM4eHhP0Z7CCRzxQD3ooVQqTmdeE9fRv3nB14eHgZR458Py1PScXnoorLd2TzEW01t1GdBMFmbudNOlkSw+ObC3NHuFfrmex+yKVYasvoSn1QvMSpPerUQ7Erct2kSJQmEmnWn4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VuJ1F/E5; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VuJ1F/E5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789328822; x=1820864822;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=izrSfcSyLZ17qqk49jxHMCdN9N8POUPieQ93sAyIQJI=;
  b=VuJ1F/E5JcCk9m5YmCMozDx64ipE2OjVF9SB7wDmqbgkjgoSNru6w/Vh
   XRjr3sT2gUcN0HR8NRkZfvXD1jC8dlnEMM/WBu76LZbxfS6TjOywPAY4U
   2PL13fbdD/MLMT0OD3xPh+4WpAied/g6Bn64QGM70SJobsA4lmJ7ScJeC
   D5/KqEiA+e646GgM0F70ujIYOlz+nRkE62lNeHojVxeV3fW+/V3EPvzbT
   ma50+7CfcsM7QBhwVWrMoNZr4F5JzsySg+Mgw4jEdZ/uXnHo8JYzk4UYh
   rrxzeClBFpJJEfhFtbMpxguD19ZRLTVGCUWspqcHCGSuI60/x7Tgmrfhv
   Q==;
X-CSE-ConnectionGUID: K/f5x3qgSxqQCzObzwb2Fg==
X-CSE-MsgGUID: tWor/TofRCSrJRadv9S1Aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="89631545"
X-IronPort-AV: E=Sophos;i="6.27,100,1787036400"; 
   d="scan'208";a="89631545"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2026 12:47:02 -0700
X-CSE-ConnectionGUID: tfwz/l4FTxyRE+IssMkOaw==
X-CSE-MsgGUID: HgEr8MiaTuqiFbT1OCdF1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,100,1787036400"; 
   d="scan'208";a="271041011"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 13 Sep 2026 12:46:59 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x5qAC-000000001Gh-1LWL;
	Sun, 13 Sep 2026 19:46:56 +0000
Date: Mon, 14 Sep 2026 03:46:16 +0800
From: kernel test robot <lkp@intel.com>
To: Guangshuo Li <lgs201920130244@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <jesszhan0024@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Linus Walleij <linusw@kernel.org>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Guangshuo Li <lgs201920130244@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] drm/panel: ilitek-ili9881c: fix panel cleanup on attach
 failure
Message-ID: <202609140343.MDs2yjJe-lkp@intel.com>
References: <20260913102608.1526916-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260913102608.1526916-1-lgs201920130244@gmail.com>

Hi Guangshuo,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v7.3-rc2]
[cannot apply to drm-misc/drm-misc-next next-20260911]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Guangshuo-Li/drm-panel-ilitek-ili9881c-fix-panel-cleanup-on-attach-failure/20260913-182608
base:   linus/master
patch link:    https://lore.kernel.org/r/20260913102608.1526916-1-lgs201920130244%40gmail.com
patch subject: [PATCH] drm/panel: ilitek-ili9881c: fix panel cleanup on attach failure
config: riscv-randconfig-001-20260914 (https://download.01.org/0day-ci/archive/20260914/202609140343.MDs2yjJe-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260914/202609140343.MDs2yjJe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609140343.MDs2yjJe-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/gpu/drm/panel/panel-ilitek-ili9881c.c:15:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:27:
   In file included from include/linux/kernel_stat.h:8:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:12:
   In file included from arch/riscv/include/asm/io.h:148:
   include/asm-generic/io.h:1209:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
    1209 |         return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
         |                                                   ~~~~~~~~~~ ^
>> drivers/gpu/drm/panel/panel-ilitek-ili9881c.c:2599:64: error: expected ';' after return statement
    2599 |                 return dev_err_probe(&dsi->dev, ret, "Failed to add panel\n")
         |                                                                              ^
         |                                                                              ;
   1 warning and 1 error generated.


vim +2599 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c

  2545	
  2546	static int ili9881c_dsi_probe(struct mipi_dsi_device *dsi)
  2547	{
  2548		struct ili9881c *ctx;
  2549		int ret;
  2550	
  2551		ctx = devm_drm_panel_alloc(&dsi->dev, struct ili9881c, panel, &ili9881c_funcs,
  2552					   DRM_MODE_CONNECTOR_DSI);
  2553		if (IS_ERR(ctx))
  2554			return PTR_ERR(ctx);
  2555	
  2556		mipi_dsi_set_drvdata(dsi, ctx);
  2557		ctx->dsi = dsi;
  2558		ctx->desc = of_device_get_match_data(&dsi->dev);
  2559	
  2560		ctx->power = devm_regulator_get(&dsi->dev, "power");
  2561		if (IS_ERR(ctx->power))
  2562			return dev_err_probe(&dsi->dev, PTR_ERR(ctx->power),
  2563					     "Couldn't get our power regulator\n");
  2564	
  2565		ctx->iovcc = devm_regulator_get_optional(&dsi->dev, "iovcc");
  2566		if (IS_ERR(ctx->iovcc)) {
  2567			if (PTR_ERR(ctx->iovcc) != -ENODEV)
  2568				return dev_err_probe(&dsi->dev, PTR_ERR(ctx->iovcc),
  2569					     "Couldn't get our iovcc regulator\n");
  2570			ctx->iovcc = NULL;
  2571		}
  2572	
  2573		ctx->reset = devm_gpiod_get_optional(&dsi->dev, "reset", GPIOD_OUT_LOW);
  2574		if (IS_ERR(ctx->reset))
  2575			return dev_err_probe(&dsi->dev, PTR_ERR(ctx->reset),
  2576					     "Couldn't get our reset GPIO\n");
  2577	
  2578		ret = drm_of_get_panel_orientation(dsi->dev.of_node, &ctx->orientation);
  2579		if (ret) {
  2580			dev_err(&dsi->dev, "%pOF: failed to get orientation: %d\n",
  2581				dsi->dev.of_node, ret);
  2582			return ret;
  2583		}
  2584	
  2585		ctx->address_mode = ctx->desc->default_address_mode;
  2586		if (ctx->orientation == DRM_MODE_PANEL_ORIENTATION_BOTTOM_UP) {
  2587			ctx->address_mode ^= 0x03;
  2588			ctx->orientation = DRM_MODE_PANEL_ORIENTATION_NORMAL;
  2589		}
  2590	
  2591		ctx->panel.prepare_prev_first = true;
  2592	
  2593		ret = drm_panel_of_backlight(&ctx->panel);
  2594		if (ret)
  2595			return ret;
  2596	
  2597		ret = devm_drm_panel_add(&dsi->dev, &ctx->panel);
  2598		if (ret)
> 2599			return dev_err_probe(&dsi->dev, ret, "Failed to add panel\n")
  2600	
  2601		dsi->mode_flags = ctx->desc->mode_flags;
  2602		dsi->format = MIPI_DSI_FMT_RGB888;
  2603		dsi->lanes = ctx->desc->lanes;
  2604	
  2605		return mipi_dsi_attach(dsi);
  2606	}
  2607	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
