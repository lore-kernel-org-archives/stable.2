Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE44A3CBE80;
	Wed, 16 Sep 2026 05:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789535890; cv=none; b=tLEQWxBcadMgufIpjnPAT3ndqi+CjEjop4nBcYHaqCnEW2NcsjRdmlTflmFvB8B808Z/H/8tAjNOELZqwsXWEj7cj//KsvG8rRzBRhWiTo54TxCVhICBsGRA3Gdyn+3JAX9eBmVgBAjvGfLOYlWPTvYoZ5DGDyhEBgnK21mbT5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789535890; c=relaxed/simple;
	bh=7K9m8F0mD1KG4TcDKDJKxVH0VueNV6FDVlQ8Ad7+dF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hGPTKHZ92TpuSD2C8TmzSunC+TMvJ7tEfS8K0XnO2qUiqGDZMn81ismRfrDNV2vqYuoqKxeiRX7HuBWtor+MElLUw4JB56naXa7mX29Rro2ZxGFnEYH96UHA/0KIKayl4yaFM0iGVc6DwLnzQH88xMvy0B901cHpwpHTVvmuQ+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pd9w6tb9; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pd9w6tb9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789535885; x=1821071885;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7K9m8F0mD1KG4TcDKDJKxVH0VueNV6FDVlQ8Ad7+dF4=;
  b=Pd9w6tb9mhG5ljwwppW1v5mbGVRPq9YIWp5wRjCranDIsp2qf99VnspJ
   NotvAz4FI+Aou1X6o/kNOo+6hBmbu1hiwBrv1yH6xicVwgBrM0DbaHZcR
   86pqOAblgiYdkPCnKqHGtJwt4wCu4mOgY+y1IJ8Vjp/9vmj7XUh9Hwjka
   s+FSgvzOMRk2/hJ4eT4TqNkQBThfyOiWTJzECfkN0AhhpIMbUiebzLq8o
   bt83FzYbcLRKOUAGCeg9LHdofpUrg+pPMUzeguXB5oCI4EFH34wfC/p+1
   He7ciRQDHyth9MkF0KVipPFcpYLkarIln8tlv43yv90Mjo9XrniApOVJq
   A==;
X-CSE-ConnectionGUID: fOMs1mN3TniWtEJI5hn/mA==
X-CSE-MsgGUID: U3c0mfJNQO+fFbxIzwWH5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="107416577"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="107416577"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 22:17:59 -0700
X-CSE-ConnectionGUID: e4iKesyjTzeod7b1HLHAUQ==
X-CSE-MsgGUID: i4wUTo/ZSzGY0adSHgPQTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="267017284"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 15 Sep 2026 22:17:56 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x6i1p-000000005X7-0J2U;
	Wed, 16 Sep 2026 05:17:53 +0000
Date: Wed, 16 Sep 2026 13:17:23 +0800
From: kernel test robot <lkp@intel.com>
To: Guangshuo Li <lgs201920130244@gmail.com>,
	Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
	Bryan O'Donoghue <bod@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-media@vger.kernel.org,
	Guangshuo Li <lgs201920130244@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] media: venus: avoid HFI resource leak on IRQ request
 failure
Message-ID: <202609161343.qH6ypqkG-lkp@intel.com>
References: <20260915123009.2420780-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915123009.2420780-1-lgs201920130244@gmail.com>

Hi Guangshuo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linuxtv-media-pending/master]
[also build test WARNING on media-tree/master linus/master v7.3-rc3 next-20260914]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Guangshuo-Li/media-venus-avoid-HFI-resource-leak-on-IRQ-request-failure/20260915-203009
base:   https://git.linuxtv.org/media-ci/media-pending.git master
patch link:    https://lore.kernel.org/r/20260915123009.2420780-1-lgs201920130244%40gmail.com
patch subject: [PATCH] media: venus: avoid HFI resource leak on IRQ request failure
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20260916/202609161343.qH6ypqkG-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260916/202609161343.qH6ypqkG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609161343.qH6ypqkG-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/media/platform/qcom/venus/core.c:446:3: warning: misleading indentation; statement is not part of the previous 'if' [-Wmisleading-indentation]
     446 |                 enable_irq(core->irq);
         |                 ^
   drivers/media/platform/qcom/venus/core.c:443:2: note: previous statement is here
     443 |         if (ret)
         |         ^
   1 warning generated.


vim +/if +446 drivers/media/platform/qcom/venus/core.c

   379	
   380	static int venus_probe(struct platform_device *pdev)
   381	{
   382		struct device *dev = &pdev->dev;
   383		struct venus_core *core;
   384		int ret;
   385	
   386		core = devm_kzalloc(dev, sizeof(*core), GFP_KERNEL);
   387		if (!core)
   388			return -ENOMEM;
   389	
   390		core->dev = dev;
   391	
   392		core->base = devm_platform_ioremap_resource(pdev, 0);
   393		if (IS_ERR(core->base))
   394			return PTR_ERR(core->base);
   395	
   396		core->video_path = devm_of_icc_get(dev, "video-mem");
   397		if (IS_ERR(core->video_path))
   398			return PTR_ERR(core->video_path);
   399	
   400		core->cpucfg_path = devm_of_icc_get(dev, "cpu-cfg");
   401		if (IS_ERR(core->cpucfg_path))
   402			return PTR_ERR(core->cpucfg_path);
   403	
   404		core->irq = platform_get_irq(pdev, 0);
   405		if (core->irq < 0)
   406			return core->irq;
   407	
   408		core->res = of_device_get_match_data(dev);
   409		if (!core->res)
   410			return -ENODEV;
   411	
   412		mutex_init(&core->pm_lock);
   413	
   414		core->pm_ops = venus_pm_get(core->res->hfi_version);
   415		if (!core->pm_ops)
   416			return -ENODEV;
   417	
   418		if (core->pm_ops->core_get) {
   419			ret = core->pm_ops->core_get(core);
   420			if (ret)
   421				return ret;
   422		}
   423	
   424		ret = dma_set_mask_and_coherent(dev, core->res->dma_mask);
   425		if (ret)
   426			goto err_core_put;
   427	
   428		dma_set_max_seg_size(dev, UINT_MAX);
   429	
   430		INIT_LIST_HEAD(&core->instances);
   431		mutex_init(&core->lock);
   432		INIT_DELAYED_WORK(&core->work, venus_sys_error_handler);
   433		init_waitqueue_head(&core->sys_err_done);
   434	
   435		ret = devm_request_threaded_irq(dev, core->irq, hfi_isr,
   436						venus_isr_thread,
   437						IRQF_TRIGGER_HIGH | IRQF_ONESHOT |
   438						IRQF_NO_AUTOEN, "venus", core);
   439		if (ret)
   440			goto err_core_put;
   441	
   442		ret = hfi_create(core, &venus_core_ops);
   443		if (ret)
   444			goto err_core_put;
   445	
 > 446			enable_irq(core->irq);
   447	
   448		venus_assign_register_offsets(core);
   449	
   450		ret = v4l2_device_register(dev, &core->v4l2_dev);
   451		if (ret)
   452			goto err_hfi_destroy;
   453	
   454		platform_set_drvdata(pdev, core);
   455	
   456		pm_runtime_enable(dev);
   457	
   458		ret = pm_runtime_get_sync(dev);
   459		if (ret < 0)
   460			goto err_runtime_disable;
   461	
   462		ret = venus_firmware_init(core);
   463		if (ret)
   464			goto err_runtime_disable;
   465	
   466		ret = venus_boot(core);
   467		if (ret)
   468			goto err_firmware_deinit;
   469	
   470		ret = venus_firmware_cfg(core);
   471		if (ret)
   472			goto err_venus_shutdown;
   473	
   474		ret = hfi_core_resume(core, true);
   475		if (ret)
   476			goto err_venus_shutdown;
   477	
   478		ret = hfi_core_init(core);
   479		if (ret)
   480			goto err_venus_shutdown;
   481	
   482		ret = venus_firmware_check(core);
   483		if (ret)
   484			goto err_core_deinit;
   485	
   486		if (core->res->dec_nodename || core->res->enc_nodename) {
   487			ret = venus_add_dynamic_nodes(core);
   488			if (ret)
   489				goto err_core_deinit;
   490		}
   491	
   492		ret = of_platform_populate(dev->of_node, NULL, NULL, dev);
   493		if (ret)
   494			goto err_remove_dynamic_nodes;
   495	
   496		ret = venus_enumerate_codecs(core, VIDC_SESSION_TYPE_DEC);
   497		if (ret)
   498			goto err_of_depopulate;
   499	
   500		ret = venus_enumerate_codecs(core, VIDC_SESSION_TYPE_ENC);
   501		if (ret)
   502			goto err_of_depopulate;
   503	
   504		ret = pm_runtime_put_sync(dev);
   505		if (ret) {
   506			pm_runtime_get_noresume(dev);
   507			goto err_of_depopulate;
   508		}
   509	
   510		venus_dbgfs_init(core);
   511	
   512		return 0;
   513	
   514	err_of_depopulate:
   515		of_platform_depopulate(dev);
   516	err_remove_dynamic_nodes:
   517		venus_remove_dynamic_nodes(core);
   518	err_core_deinit:
   519		hfi_core_deinit(core, false);
   520	err_venus_shutdown:
   521		venus_shutdown(core);
   522	err_firmware_deinit:
   523		venus_firmware_deinit(core);
   524	err_runtime_disable:
   525		pm_runtime_put_noidle(dev);
   526		pm_runtime_disable(dev);
   527		pm_runtime_set_suspended(dev);
   528		v4l2_device_unregister(&core->v4l2_dev);
   529	err_hfi_destroy:
   530		hfi_destroy(core);
   531	err_core_put:
   532		if (core->pm_ops->core_put)
   533			core->pm_ops->core_put(core);
   534		return ret;
   535	}
   536	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
