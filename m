Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2709184524;
	Wed, 16 Sep 2026 04:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789531444; cv=none; b=g6zczYWs6Uzr7uuyyhSL92wSF8c45kqRH9MwHQe/oH1C1slDFMF0zAiqKQaS3HxxQv11lSRiafQG1DuoUtyHoU6gBfudHA5lgZayhQZ9wB2afnWqHKrTKYcnrBR1Pc1sDPEsw46LqPhvZVGXJXp618Sqlz1zUHCsHksMLijm+7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789531444; c=relaxed/simple;
	bh=YW0Xe4FZmzkbLBEJu3FgyR3bCMlylarX7NFYocYeHVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/54y1XPXKfOs1v5/JqEILUO1FTP+9WoSZrivOpFZRfkw/VyP3SvIEow71CUy8Wp0CGcZ5rS8mRQQtQE/XdLw7dQpHDA61aCBRj1X+GZB2p0n2rRgV6RlXM1mIr3ZHm5ECqoCPZnMNgFEI9FX/CugoNcTKR8NWi2yXHkX4WYH2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TufMgn9B; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TufMgn9B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789531440; x=1821067440;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YW0Xe4FZmzkbLBEJu3FgyR3bCMlylarX7NFYocYeHVU=;
  b=TufMgn9B/hTMvULrxGIfyR9suD6QZX9/hmA3WUDLgTexQwMioSAQkk+T
   Gm6EGugEUn8JkmZmSDXvIDSuecncMXI4IbSnoNzLFVGQ617+r5ebYnnc/
   zmBV9Fl9JniH5eYfSyozNa+17PVYmSip1qcpQrytXwmG3zY8s8Qk0OdlB
   wizfVrsUVJLFnzvBamVMCY6ZTZN4reU+Ar/dHK9U6aPAnmcYzP33gIhUs
   4z6wHhIr6FOxYCBOkMgr6QJYx/ER++/kSVMmJOtZehj9L/M6r6HZ/wAle
   XVzJYagYEZZbf72OofilSEVgjVc2wePzlmDoCtgIJreAPgeYCUeEiwDDh
   w==;
X-CSE-ConnectionGUID: i5FuLMHiQHGKaP9g7sDnNQ==
X-CSE-MsgGUID: L7tYa+cQQzuZE1xKcHyu+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="93726681"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="93726681"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 21:03:59 -0700
X-CSE-ConnectionGUID: 7H7tpPJSRX6hoFJ51FqF1g==
X-CSE-MsgGUID: 5e0oc0nkTrmei+KUaD29TQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="270584091"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 15 Sep 2026 21:03:55 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x6gsB-000000005UT-0EZw;
	Wed, 16 Sep 2026 04:03:51 +0000
Date: Wed, 16 Sep 2026 12:03:22 +0800
From: kernel test robot <lkp@intel.com>
To: Guangshuo Li <lgs201920130244@gmail.com>,
	Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
	Bryan O'Donoghue <bod@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-media@vger.kernel.org,
	Guangshuo Li <lgs201920130244@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] media: venus: avoid HFI resource leak on IRQ request
 failure
Message-ID: <202609161130.IsnPB09N-lkp@intel.com>
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
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20260916/202609161130.IsnPB09N-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260916/202609161130.IsnPB09N-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609161130.IsnPB09N-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/media/platform/qcom/venus/core.c: In function 'venus_probe':
>> drivers/media/platform/qcom/venus/core.c:443:9: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
     443 |         if (ret)
         |         ^~
   drivers/media/platform/qcom/venus/core.c:446:17: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
     446 |                 enable_irq(core->irq);
         |                 ^~~~~~~~~~


vim +/if +443 drivers/media/platform/qcom/venus/core.c

687bfbba5a1cb15 Bryan O'Donoghue    2024-12-30  379  
af2c3834c8ca7cc Stanimir Varbanov   2017-06-15  380  static int venus_probe(struct platform_device *pdev)
af2c3834c8ca7cc Stanimir Varbanov   2017-06-15  381  {
af2c3834c8ca7cc Stanimir Varbanov   2017-06-15  382  	struct device *dev = &pdev->dev;
af2c3834c8ca7cc Stanimir Varbanov   2017-06-15  383  	struct venus_core *core;
af2c3834c8ca7cc Stanimir Varbanov   2017-06-15  384  	int ret;
af2c3834c8ca7cc Stanimir Varbanov   2017-06-15  385  
af2c3834c8ca7cc Stanimir Varbanov   2017-06-15  386  	core = devm_kzalloc(dev, sizeof(*core), GFP_KERNEL);
af2c3834c8ca7cc Stanimir Varbanov   2017-06-15  387  	if (!core)
af2c3834c8ca7cc Stanimir Varbanov   2017-06-15  388  		return -ENOMEM;
af2c3834c8ca7cc Stanimir Varbanov   2017-06-15  389  
af2c3834c8ca7cc Stanimir Varbanov   2017-06-15  390  	core->dev = dev;
af2c3834c8ca7cc Stanimir Varbanov   2017-06-15  391  
b4dac22d27a2cc4 Cai Huoqing         2021-09-01  392  	core->base = devm_platform_ioremap_resource(pdev, 0);
af2c3834c8ca7cc Stanimir Varbanov   2017-06-15  393  	if (IS_ERR(core->base))
af2c3834c8ca7cc Stanimir Varbanov   2017-06-15  394  		return PTR_ERR(core->base);
af2c3834c8ca7cc Stanimir Varbanov   2017-06-15  395  
5a465c5391a856a Christophe JAILLET  2021-01-28  396  	core->video_path = devm_of_icc_get(dev, "video-mem");
32f0a6ddc8c98a1 Stanimir Varbanov   2019-08-13  397  	if (IS_ERR(core->video_path))
32f0a6ddc8c98a1 Stanimir Varbanov   2019-08-13  398  		return PTR_ERR(core->video_path);
32f0a6ddc8c98a1 Stanimir Varbanov   2019-08-13  399  
5a465c5391a856a Christophe JAILLET  2021-01-28  400  	core->cpucfg_path = devm_of_icc_get(dev, "cpu-cfg");
32f0a6ddc8c98a1 Stanimir Varbanov   2019-08-13  401  	if (IS_ERR(core->cpucfg_path))
32f0a6ddc8c98a1 Stanimir Varbanov   2019-08-13  402  		return PTR_ERR(core->cpucfg_path);
32f0a6ddc8c98a1 Stanimir Varbanov   2019-08-13  403  
af2c3834c8ca7cc Stanimir Varbanov   2017-06-15  404  	core->irq = platform_get_irq(pdev, 0);
af2c3834c8ca7cc Stanimir Varbanov   2017-06-15  405  	if (core->irq < 0)
af2c3834c8ca7cc Stanimir Varbanov   2017-06-15  406  		return core->irq;
af2c3834c8ca7cc Stanimir Varbanov   2017-06-15  407  
af2c3834c8ca7cc Stanimir Varbanov   2017-06-15  408  	core->res = of_device_get_match_data(dev);
af2c3834c8ca7cc Stanimir Varbanov   2017-06-15  409  	if (!core->res)
af2c3834c8ca7cc Stanimir Varbanov   2017-06-15  410  		return -ENODEV;
af2c3834c8ca7cc Stanimir Varbanov   2017-06-15  411  
63342afea65e9ef Stanimir Varbanov   2020-01-30  412  	mutex_init(&core->pm_lock);
63342afea65e9ef Stanimir Varbanov   2020-01-30  413  
7482a983dea3b8d Stanimir Varbanov   2019-12-05  414  	core->pm_ops = venus_pm_get(core->res->hfi_version);
7482a983dea3b8d Stanimir Varbanov   2019-12-05  415  	if (!core->pm_ops)
7482a983dea3b8d Stanimir Varbanov   2019-12-05  416  		return -ENODEV;
7482a983dea3b8d Stanimir Varbanov   2019-12-05  417  
7482a983dea3b8d Stanimir Varbanov   2019-12-05  418  	if (core->pm_ops->core_get) {
08b1cf474b7f727 Bryan O'Donoghue    2021-02-05  419  		ret = core->pm_ops->core_get(core);
af2c3834c8ca7cc Stanimir Varbanov   2017-06-15  420  		if (ret)
af2c3834c8ca7cc Stanimir Varbanov   2017-06-15  421  			return ret;
7482a983dea3b8d Stanimir Varbanov   2019-12-05  422  	}
af2c3834c8ca7cc Stanimir Varbanov   2017-06-15  423  
af2c3834c8ca7cc Stanimir Varbanov   2017-06-15  424  	ret = dma_set_mask_and_coherent(dev, core->res->dma_mask);
af2c3834c8ca7cc Stanimir Varbanov   2017-06-15  425  	if (ret)
98cd831088c64aa Rajendra Nayak      2020-07-29  426  		goto err_core_put;
af2c3834c8ca7cc Stanimir Varbanov   2017-06-15  427  
0df720e59d9543a Robin Murphy        2020-09-03  428  	dma_set_max_seg_size(dev, UINT_MAX);
de2563bce7a157f Vivek Gautam        2018-12-05  429  
af2c3834c8ca7cc Stanimir Varbanov   2017-06-15  430  	INIT_LIST_HEAD(&core->instances);
af2c3834c8ca7cc Stanimir Varbanov   2017-06-15  431  	mutex_init(&core->lock);
af2c3834c8ca7cc Stanimir Varbanov   2017-06-15  432  	INIT_DELAYED_WORK(&core->work, venus_sys_error_handler);
3227a8f7cf331ed Stanimir Varbanov   2021-04-23  433  	init_waitqueue_head(&core->sys_err_done);
af2c3834c8ca7cc Stanimir Varbanov   2017-06-15  434  
f7594c2d3a2ae92 Guangshuo Li        2026-09-15  435  	ret = devm_request_threaded_irq(dev, core->irq, hfi_isr,
f7594c2d3a2ae92 Guangshuo Li        2026-09-15  436  					venus_isr_thread,
f7594c2d3a2ae92 Guangshuo Li        2026-09-15  437  					IRQF_TRIGGER_HIGH | IRQF_ONESHOT |
f7594c2d3a2ae92 Guangshuo Li        2026-09-15  438  					IRQF_NO_AUTOEN, "venus", core);
af2c3834c8ca7cc Stanimir Varbanov   2017-06-15  439  	if (ret)
98cd831088c64aa Rajendra Nayak      2020-07-29  440  		goto err_core_put;
af2c3834c8ca7cc Stanimir Varbanov   2017-06-15  441  
f7594c2d3a2ae92 Guangshuo Li        2026-09-15  442  	ret = hfi_create(core, &venus_core_ops);
af2c3834c8ca7cc Stanimir Varbanov   2017-06-15 @443  	if (ret)
98cd831088c64aa Rajendra Nayak      2020-07-29  444  		goto err_core_put;
af2c3834c8ca7cc Stanimir Varbanov   2017-06-15  445  
f7594c2d3a2ae92 Guangshuo Li        2026-09-15  446  		enable_irq(core->irq);
f7594c2d3a2ae92 Guangshuo Li        2026-09-15  447  
b4053a2097ec2f8 Bryan O'Donoghue    2021-04-02  448  	venus_assign_register_offsets(core);
b4053a2097ec2f8 Bryan O'Donoghue    2021-04-02  449  
08b1cf474b7f727 Bryan O'Donoghue    2021-02-05  450  	ret = v4l2_device_register(dev, &core->v4l2_dev);
08b1cf474b7f727 Bryan O'Donoghue    2021-02-05  451  	if (ret)
523cea3a19f0b3b Loic Poulain        2025-03-27  452  		goto err_hfi_destroy;
08b1cf474b7f727 Bryan O'Donoghue    2021-02-05  453  
08b1cf474b7f727 Bryan O'Donoghue    2021-02-05  454  	platform_set_drvdata(pdev, core);
08b1cf474b7f727 Bryan O'Donoghue    2021-02-05  455  
af2c3834c8ca7cc Stanimir Varbanov   2017-06-15  456  	pm_runtime_enable(dev);
af2c3834c8ca7cc Stanimir Varbanov   2017-06-15  457  
af2c3834c8ca7cc Stanimir Varbanov   2017-06-15  458  	ret = pm_runtime_get_sync(dev);
af2c3834c8ca7cc Stanimir Varbanov   2017-06-15  459  	if (ret < 0)
af2c3834c8ca7cc Stanimir Varbanov   2017-06-15  460  		goto err_runtime_disable;
af2c3834c8ca7cc Stanimir Varbanov   2017-06-15  461  
f9799fcce4bb383 Stanimir Varbanov   2018-10-17  462  	ret = venus_firmware_init(core);
f9799fcce4bb383 Stanimir Varbanov   2018-10-17  463  	if (ret)
85c853b7043657d Jorge Ramirez-Ortiz 2025-08-14  464  		goto err_runtime_disable;
f9799fcce4bb383 Stanimir Varbanov   2018-10-17  465  
a4cf7e3c069db63 Vikash Garodia      2018-10-17  466  	ret = venus_boot(core);
af2c3834c8ca7cc Stanimir Varbanov   2017-06-15  467  	if (ret)
8cc7a1b2aca0673 Christophe JAILLET  2021-08-19  468  		goto err_firmware_deinit;
af2c3834c8ca7cc Stanimir Varbanov   2017-06-15  469  
ba4fdff9201190d Jorge Ramirez-Ortiz 2025-08-14  470  	ret = venus_firmware_cfg(core);
ba4fdff9201190d Jorge Ramirez-Ortiz 2025-08-14  471  	if (ret)
ba4fdff9201190d Jorge Ramirez-Ortiz 2025-08-14  472  		goto err_venus_shutdown;
ba4fdff9201190d Jorge Ramirez-Ortiz 2025-08-14  473  
af2c3834c8ca7cc Stanimir Varbanov   2017-06-15  474  	ret = hfi_core_resume(core, true);
af2c3834c8ca7cc Stanimir Varbanov   2017-06-15  475  	if (ret)
af2c3834c8ca7cc Stanimir Varbanov   2017-06-15  476  		goto err_venus_shutdown;
af2c3834c8ca7cc Stanimir Varbanov   2017-06-15  477  
af2c3834c8ca7cc Stanimir Varbanov   2017-06-15  478  	ret = hfi_core_init(core);
af2c3834c8ca7cc Stanimir Varbanov   2017-06-15  479  	if (ret)
af2c3834c8ca7cc Stanimir Varbanov   2017-06-15  480  		goto err_venus_shutdown;
af2c3834c8ca7cc Stanimir Varbanov   2017-06-15  481  
85c853b7043657d Jorge Ramirez-Ortiz 2025-08-14  482  	ret = venus_firmware_check(core);
1a73374a04e5551 Stanimir Varbanov   2018-07-06  483  	if (ret)
523cea3a19f0b3b Loic Poulain        2025-03-27  484  		goto err_core_deinit;
1a73374a04e5551 Stanimir Varbanov   2018-07-06  485  
85c853b7043657d Jorge Ramirez-Ortiz 2025-08-14  486  	if (core->res->dec_nodename || core->res->enc_nodename) {
85c853b7043657d Jorge Ramirez-Ortiz 2025-08-14  487  		ret = venus_add_dynamic_nodes(core);
1a73374a04e5551 Stanimir Varbanov   2018-07-06  488  		if (ret)
523cea3a19f0b3b Loic Poulain        2025-03-27  489  			goto err_core_deinit;
85c853b7043657d Jorge Ramirez-Ortiz 2025-08-14  490  	}
85c853b7043657d Jorge Ramirez-Ortiz 2025-08-14  491  
85c853b7043657d Jorge Ramirez-Ortiz 2025-08-14  492  	ret = of_platform_populate(dev->of_node, NULL, NULL, dev);
85c853b7043657d Jorge Ramirez-Ortiz 2025-08-14  493  	if (ret)
85c853b7043657d Jorge Ramirez-Ortiz 2025-08-14  494  		goto err_remove_dynamic_nodes;
85c853b7043657d Jorge Ramirez-Ortiz 2025-08-14  495  
85c853b7043657d Jorge Ramirez-Ortiz 2025-08-14  496  	ret = venus_enumerate_codecs(core, VIDC_SESSION_TYPE_DEC);
85c853b7043657d Jorge Ramirez-Ortiz 2025-08-14  497  	if (ret)
85c853b7043657d Jorge Ramirez-Ortiz 2025-08-14  498  		goto err_of_depopulate;
85c853b7043657d Jorge Ramirez-Ortiz 2025-08-14  499  
85c853b7043657d Jorge Ramirez-Ortiz 2025-08-14  500  	ret = venus_enumerate_codecs(core, VIDC_SESSION_TYPE_ENC);
85c853b7043657d Jorge Ramirez-Ortiz 2025-08-14  501  	if (ret)
85c853b7043657d Jorge Ramirez-Ortiz 2025-08-14  502  		goto err_of_depopulate;
1a73374a04e5551 Stanimir Varbanov   2018-07-06  503  
af2c3834c8ca7cc Stanimir Varbanov   2017-06-15  504  	ret = pm_runtime_put_sync(dev);
bbe516e976fce53 Dinghao Liu         2020-06-28  505  	if (ret) {
bbe516e976fce53 Dinghao Liu         2020-06-28  506  		pm_runtime_get_noresume(dev);
85c853b7043657d Jorge Ramirez-Ortiz 2025-08-14  507  		goto err_of_depopulate;
bbe516e976fce53 Dinghao Liu         2020-06-28  508  	}
af2c3834c8ca7cc Stanimir Varbanov   2017-06-15  509  
f08abe6a1e07fdf Stanimir Varbanov   2020-05-21  510  	venus_dbgfs_init(core);
f08abe6a1e07fdf Stanimir Varbanov   2020-05-21  511  
af2c3834c8ca7cc Stanimir Varbanov   2017-06-15  512  	return 0;
af2c3834c8ca7cc Stanimir Varbanov   2017-06-15  513  
85c853b7043657d Jorge Ramirez-Ortiz 2025-08-14  514  err_of_depopulate:
85c853b7043657d Jorge Ramirez-Ortiz 2025-08-14  515  	of_platform_depopulate(dev);
85c853b7043657d Jorge Ramirez-Ortiz 2025-08-14  516  err_remove_dynamic_nodes:
85c853b7043657d Jorge Ramirez-Ortiz 2025-08-14  517  	venus_remove_dynamic_nodes(core);
523cea3a19f0b3b Loic Poulain        2025-03-27  518  err_core_deinit:
523cea3a19f0b3b Loic Poulain        2025-03-27  519  	hfi_core_deinit(core, false);
af2c3834c8ca7cc Stanimir Varbanov   2017-06-15  520  err_venus_shutdown:
df381dc8e475204 Vikash Garodia      2018-10-17  521  	venus_shutdown(core);
8cc7a1b2aca0673 Christophe JAILLET  2021-08-19  522  err_firmware_deinit:
8cc7a1b2aca0673 Christophe JAILLET  2021-08-19  523  	venus_firmware_deinit(core);
af2c3834c8ca7cc Stanimir Varbanov   2017-06-15  524  err_runtime_disable:
bbe516e976fce53 Dinghao Liu         2020-06-28  525  	pm_runtime_put_noidle(dev);
af2c3834c8ca7cc Stanimir Varbanov   2017-06-15  526  	pm_runtime_disable(dev);
2a20869f7d798aa Jinjie Ruan         2024-11-01  527  	pm_runtime_set_suspended(dev);
523cea3a19f0b3b Loic Poulain        2025-03-27  528  	v4l2_device_unregister(&core->v4l2_dev);
523cea3a19f0b3b Loic Poulain        2025-03-27  529  err_hfi_destroy:
af2c3834c8ca7cc Stanimir Varbanov   2017-06-15  530  	hfi_destroy(core);
98cd831088c64aa Rajendra Nayak      2020-07-29  531  err_core_put:
98cd831088c64aa Rajendra Nayak      2020-07-29  532  	if (core->pm_ops->core_put)
08b1cf474b7f727 Bryan O'Donoghue    2021-02-05  533  		core->pm_ops->core_put(core);
af2c3834c8ca7cc Stanimir Varbanov   2017-06-15  534  	return ret;
af2c3834c8ca7cc Stanimir Varbanov   2017-06-15  535  }
af2c3834c8ca7cc Stanimir Varbanov   2017-06-15  536  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
