Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCA34302F8;
	Sun, 18 Oct 2026 12:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792327321; cv=none; b=cLyQ801lQXLMpzVsDVA0Ri6xBu7ZbfBq6pFCNGw4FINg09uk7MB0zGorWVjagZgx1VZc2Lg+FXjAX+7wQ5Kqt/14Hz5ZHDJ0GpeVGy6sH6rXTSYjqA/WqTSmkUAAsNcKMmqQ8yUQnt5CqxrQM6q852PAxSJR13I+pi+aNOVtBYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792327321; c=relaxed/simple;
	bh=ljISuKdFNzWjNUak1u7QomQ2GJ0OH4brWZu+VeZg79c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ow1MK98e8zbG6nQRG9hscqH/p82/9cZ+p6TLD25A2+zTA7BMqnBEgjQWBk9PUASvbtfMBXcGyuaVntFJ9TyOlAR/c2UIDXJDaHkZlhqg8jVuOyvWXnoO55PhXqjqm1c5uleZXtT715evwJtwMRXPt1tDQLKPE92NQRSmMw+Xf4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=erZnlLWH; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="erZnlLWH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792327318; x=1823863318;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ljISuKdFNzWjNUak1u7QomQ2GJ0OH4brWZu+VeZg79c=;
  b=erZnlLWHgPTcXOlaQuYMLabvxLJzDCqyIWyoxUyJCuz4IFdg0vODRxRi
   dU5EhA95aVgiU6tgpw9zAAyo3EKhyvy+QRomIAs0tMxENIkKsir/cwb4W
   C/4R9sLyOf93a3b6pOBLcrGQu3zVhJZSXQJCkgJzNmgK9QC8PAsC4rGnz
   7wRPbL+l2MIY3nhclW7ItsQkZeEW3Zjvkvpj4t5fYV7Pt8JFcHMIAA3CA
   Ez6Kz/rpx985xcUzzvVV2vHOiDwMu7kg2fTHwIz6c752TxE19Ibf09TAx
   7y0CeEhUIoY096bzp2lgJmRxne8X8wOSrxBz+dgl2oP7fkOshgEU//Csq
   A==;
X-CSE-ConnectionGUID: 8/gkeVekT6Cv63TQ1uWYaw==
X-CSE-MsgGUID: DuqB+XG5Rt6LT5Q7Czzjtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11938"; a="916846"
X-IronPort-AV: E=Sophos;i="6.27,165,1787036400"; 
   d="scan'208";a="916846"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2026 05:41:57 -0700
X-CSE-ConnectionGUID: Y0PYbu4cQqC9Up8wlgUHpA==
X-CSE-MsgGUID: DcSeRGkgQ4ml/xyAGnCNFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,165,1787036400"; 
   d="scan'208";a="2306648"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 18 Oct 2026 05:41:55 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xIQD3-00000000KQ6-1GsN;
	Sun, 18 Oct 2026 12:41:53 +0000
Date: Sun, 18 Oct 2026 20:41:17 +0800
From: kernel test robot <lkp@intel.com>
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>, jikos@kernel.org,
	bentiss@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: Re: [PATCH v8 1/2] HID: haptic: reorder try_module_get/get_device
 before input_ff_create
Message-ID: <202610182035.85qazamu-lkp@intel.com>
References: <20261016173056.3397211-2-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016173056.3397211-2-qwe.aldo@gmail.com>

Hi Aldo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on hid/for-next]
[also build test WARNING on linus/master v7.3-rc7 next-20261016]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Aldo-Ariel-Panzardo/HID-multitouch-fix-use-after-free-of-haptic-data-on-delayed-input-release/20261016-143056
base:   https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-next
patch link:    https://lore.kernel.org/r/20261016173056.3397211-2-qwe.aldo%40gmail.com
patch subject: [PATCH v8 1/2] HID: haptic: reorder try_module_get/get_device before input_ff_create
config: i386-randconfig-1010-20261017 (https://download.01.org/0day-ci/archive/20261018/202610182035.85qazamu-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261018/202610182035.85qazamu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610182035.85qazamu-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/hid/hid-haptic.c:533:1: warning: unused label 'stop_buffer_free' [-Wunused-label]
     533 | stop_buffer_free:
         | ^~~~~~~~~~~~~~~~~
   1 warning generated.


vim +/stop_buffer_free +533 drivers/hid/hid-haptic.c

344ff358495706a Angela Czubak       2025-08-18  410  
344ff358495706a Angela Czubak       2025-08-18  411  int hid_haptic_init(struct hid_device *hdev,
7939f787f450d93 Dmitry Torokhov     2026-08-03  412  		    struct hid_haptic_device *haptic,
7939f787f450d93 Dmitry Torokhov     2026-08-03  413  		    struct input_dev *dev)
344ff358495706a Angela Czubak       2025-08-18  414  {
344ff358495706a Angela Czubak       2025-08-18  415  	struct ff_device *ff;
344ff358495706a Angela Czubak       2025-08-18  416  	int ret = 0, r;
344ff358495706a Angela Czubak       2025-08-18  417  	struct ff_haptic_effect stop_effect = {
344ff358495706a Angela Czubak       2025-08-18  418  		.hid_usage = HID_HP_WAVEFORMSTOP & HID_USAGE,
344ff358495706a Angela Czubak       2025-08-18  419  	};
344ff358495706a Angela Czubak       2025-08-18  420  	const char *prefix = "hid-haptic";
344ff358495706a Angela Czubak       2025-08-18  421  	char *name;
344ff358495706a Angela Czubak       2025-08-18  422  
344ff358495706a Angela Czubak       2025-08-18  423  	haptic->hdev = hdev;
344ff358495706a Angela Czubak       2025-08-18  424  	haptic->max_waveform_id = max(2u, haptic->max_waveform_id);
344ff358495706a Angela Czubak       2025-08-18  425  	haptic->max_duration_id = max(2u, haptic->max_duration_id);
344ff358495706a Angela Czubak       2025-08-18  426  
344ff358495706a Angela Czubak       2025-08-18  427  	haptic->hid_usage_map = kcalloc(haptic->max_waveform_id + 1,
344ff358495706a Angela Czubak       2025-08-18  428  					sizeof(u16), GFP_KERNEL);
344ff358495706a Angela Czubak       2025-08-18  429  	if (!haptic->hid_usage_map) {
344ff358495706a Angela Czubak       2025-08-18  430  		ret = -ENOMEM;
344ff358495706a Angela Czubak       2025-08-18  431  		goto exit;
344ff358495706a Angela Czubak       2025-08-18  432  	}
344ff358495706a Angela Czubak       2025-08-18  433  	haptic->duration_map = kcalloc(haptic->max_duration_id + 1,
344ff358495706a Angela Czubak       2025-08-18  434  				       sizeof(u32), GFP_KERNEL);
344ff358495706a Angela Czubak       2025-08-18  435  	if (!haptic->duration_map) {
344ff358495706a Angela Czubak       2025-08-18  436  		ret = -ENOMEM;
344ff358495706a Angela Czubak       2025-08-18  437  		goto usage_map;
344ff358495706a Angela Czubak       2025-08-18  438  	}
344ff358495706a Angela Czubak       2025-08-18  439  
344ff358495706a Angela Czubak       2025-08-18  440  	if (haptic->max_waveform_id != haptic->max_duration_id)
344ff358495706a Angela Czubak       2025-08-18  441  		dev_warn(&hdev->dev,
344ff358495706a Angela Czubak       2025-08-18  442  			 "Haptic duration and waveform lists have different max id (%u and %u).\n",
344ff358495706a Angela Czubak       2025-08-18  443  			 haptic->max_duration_id, haptic->max_waveform_id);
344ff358495706a Angela Czubak       2025-08-18  444  
344ff358495706a Angela Czubak       2025-08-18  445  	haptic->hid_usage_map[HID_HAPTIC_ORDINAL_WAVEFORMNONE] =
344ff358495706a Angela Czubak       2025-08-18  446  		HID_HP_WAVEFORMNONE & HID_USAGE;
344ff358495706a Angela Czubak       2025-08-18  447  	haptic->hid_usage_map[HID_HAPTIC_ORDINAL_WAVEFORMSTOP] =
344ff358495706a Angela Czubak       2025-08-18  448  		HID_HP_WAVEFORMSTOP & HID_USAGE;
344ff358495706a Angela Czubak       2025-08-18  449  
ff66b8eebbab371 Angela Czubak       2025-08-18  450  	mutex_init(&haptic->auto_trigger_mutex);
344ff358495706a Angela Czubak       2025-08-18  451  	for (r = 0; r < haptic->auto_trigger_report->maxfield; r++)
344ff358495706a Angela Czubak       2025-08-18  452  		parse_auto_trigger_field(haptic, haptic->auto_trigger_report->field[r]);
344ff358495706a Angela Czubak       2025-08-18  453  
344ff358495706a Angela Czubak       2025-08-18  454  	haptic->input_dev = dev;
344ff358495706a Angela Czubak       2025-08-18  455  	haptic->manual_trigger_report_len =
344ff358495706a Angela Czubak       2025-08-18  456  		hid_report_len(haptic->manual_trigger_report);
344ff358495706a Angela Czubak       2025-08-18  457  	mutex_init(&haptic->manual_trigger_mutex);
344ff358495706a Angela Czubak       2025-08-18  458  	name = kmalloc(strlen(prefix) + strlen(hdev->name) + 2, GFP_KERNEL);
344ff358495706a Angela Czubak       2025-08-18  459  	if (name) {
344ff358495706a Angela Czubak       2025-08-18  460  		sprintf(name, "%s %s", prefix, hdev->name);
344ff358495706a Angela Czubak       2025-08-18  461  		haptic->wq = create_singlethread_workqueue(name);
344ff358495706a Angela Czubak       2025-08-18  462  		kfree(name);
344ff358495706a Angela Czubak       2025-08-18  463  	}
344ff358495706a Angela Czubak       2025-08-18  464  	if (!haptic->wq) {
344ff358495706a Angela Czubak       2025-08-18  465  		ret = -ENOMEM;
344ff358495706a Angela Czubak       2025-08-18  466  		goto duration_map;
344ff358495706a Angela Czubak       2025-08-18  467  	}
32a92f8c8932698 Linus Torvalds      2026-02-21  468  	haptic->effect = kzalloc_objs(struct hid_haptic_effect, FF_MAX_EFFECTS);
344ff358495706a Angela Czubak       2025-08-18  469  	if (!haptic->effect) {
344ff358495706a Angela Czubak       2025-08-18  470  		ret = -ENOMEM;
344ff358495706a Angela Czubak       2025-08-18  471  		goto output_queue;
344ff358495706a Angela Czubak       2025-08-18  472  	}
344ff358495706a Angela Czubak       2025-08-18  473  	for (r = 0; r < FF_MAX_EFFECTS; r++) {
344ff358495706a Angela Czubak       2025-08-18  474  		haptic->effect[r].report_buf =
344ff358495706a Angela Czubak       2025-08-18  475  			hid_alloc_report_buf(haptic->manual_trigger_report,
344ff358495706a Angela Czubak       2025-08-18  476  					     GFP_KERNEL);
344ff358495706a Angela Czubak       2025-08-18  477  		if (!haptic->effect[r].report_buf) {
344ff358495706a Angela Czubak       2025-08-18  478  			dev_err(&hdev->dev,
344ff358495706a Angela Czubak       2025-08-18  479  				"Failed to allocate a buffer for an effect.\n");
344ff358495706a Angela Czubak       2025-08-18  480  			ret = -ENOMEM;
344ff358495706a Angela Czubak       2025-08-18  481  			goto buffer_free;
344ff358495706a Angela Czubak       2025-08-18  482  		}
344ff358495706a Angela Czubak       2025-08-18  483  		haptic->effect[r].input_dev = dev;
344ff358495706a Angela Czubak       2025-08-18  484  		INIT_WORK(&haptic->effect[r].work, haptic_work_handler);
344ff358495706a Angela Czubak       2025-08-18  485  	}
344ff358495706a Angela Czubak       2025-08-18  486  	haptic->stop_effect.report_buf =
344ff358495706a Angela Czubak       2025-08-18  487  		hid_alloc_report_buf(haptic->manual_trigger_report,
344ff358495706a Angela Czubak       2025-08-18  488  				     GFP_KERNEL);
344ff358495706a Angela Czubak       2025-08-18  489  	if (!haptic->stop_effect.report_buf) {
344ff358495706a Angela Czubak       2025-08-18  490  		dev_err(&hdev->dev,
344ff358495706a Angela Czubak       2025-08-18  491  			"Failed to allocate a buffer for stop effect.\n");
344ff358495706a Angela Czubak       2025-08-18  492  		ret = -ENOMEM;
344ff358495706a Angela Czubak       2025-08-18  493  		goto buffer_free;
344ff358495706a Angela Czubak       2025-08-18  494  	}
344ff358495706a Angela Czubak       2025-08-18  495  	haptic->stop_effect.input_dev = dev;
344ff358495706a Angela Czubak       2025-08-18  496  	INIT_WORK(&haptic->stop_effect.work, haptic_work_handler);
344ff358495706a Angela Czubak       2025-08-18  497  	fill_effect_buf(haptic, &stop_effect, &haptic->stop_effect,
344ff358495706a Angela Czubak       2025-08-18  498  			HID_HAPTIC_ORDINAL_WAVEFORMSTOP);
344ff358495706a Angela Czubak       2025-08-18  499  
344ff358495706a Angela Czubak       2025-08-18  500  	input_set_capability(dev, EV_FF, FF_HAPTIC);
344ff358495706a Angela Czubak       2025-08-18  501  
7668dc668064c7a Aldo Ariel Panzardo 2026-10-16  502  	if (!try_module_get(THIS_MODULE)) {
7668dc668064c7a Aldo Ariel Panzardo 2026-10-16  503  		dev_err(&hdev->dev, "Failed to increase module count.\n");
7668dc668064c7a Aldo Ariel Panzardo 2026-10-16  504  		ret = -ENODEV;
7668dc668064c7a Aldo Ariel Panzardo 2026-10-16  505  		goto ff_cap_clear;
7668dc668064c7a Aldo Ariel Panzardo 2026-10-16  506  	}
7668dc668064c7a Aldo Ariel Panzardo 2026-10-16  507  	if (!get_device(&hdev->dev)) {
7668dc668064c7a Aldo Ariel Panzardo 2026-10-16  508  		dev_err(&hdev->dev, "Failed to get hdev device.\n");
7668dc668064c7a Aldo Ariel Panzardo 2026-10-16  509  		ret = -ENODEV;
7668dc668064c7a Aldo Ariel Panzardo 2026-10-16  510  		module_put(THIS_MODULE);
7668dc668064c7a Aldo Ariel Panzardo 2026-10-16  511  		goto ff_cap_clear;
7668dc668064c7a Aldo Ariel Panzardo 2026-10-16  512  	}
7668dc668064c7a Aldo Ariel Panzardo 2026-10-16  513  
344ff358495706a Angela Czubak       2025-08-18  514  	ret = input_ff_create(dev, FF_MAX_EFFECTS);
344ff358495706a Angela Czubak       2025-08-18  515  	if (ret) {
344ff358495706a Angela Czubak       2025-08-18  516  		dev_err(&hdev->dev, "Failed to create ff device.\n");
7668dc668064c7a Aldo Ariel Panzardo 2026-10-16  517  		put_device(&hdev->dev);
7668dc668064c7a Aldo Ariel Panzardo 2026-10-16  518  		module_put(THIS_MODULE);
7668dc668064c7a Aldo Ariel Panzardo 2026-10-16  519  		goto ff_cap_clear;
344ff358495706a Angela Czubak       2025-08-18  520  	}
344ff358495706a Angela Czubak       2025-08-18  521  
344ff358495706a Angela Czubak       2025-08-18  522  	ff = dev->ff;
344ff358495706a Angela Czubak       2025-08-18  523  	ff->private = haptic;
344ff358495706a Angela Czubak       2025-08-18  524  	ff->upload = hid_haptic_upload_effect;
344ff358495706a Angela Czubak       2025-08-18  525  	ff->playback = hid_haptic_playback;
344ff358495706a Angela Czubak       2025-08-18  526  	ff->erase = hid_haptic_erase;
344ff358495706a Angela Czubak       2025-08-18  527  	ff->destroy = hid_haptic_destroy;
344ff358495706a Angela Czubak       2025-08-18  528  	return 0;
344ff358495706a Angela Czubak       2025-08-18  529  
7668dc668064c7a Aldo Ariel Panzardo 2026-10-16  530  ff_cap_clear:
7668dc668064c7a Aldo Ariel Panzardo 2026-10-16  531  	__clear_bit(FF_HAPTIC, dev->ffbit);
7668dc668064c7a Aldo Ariel Panzardo 2026-10-16  532  	__clear_bit(EV_FF, dev->evbit);
344ff358495706a Angela Czubak       2025-08-18 @533  stop_buffer_free:
344ff358495706a Angela Czubak       2025-08-18  534  	kfree(haptic->stop_effect.report_buf);
344ff358495706a Angela Czubak       2025-08-18  535  	haptic->stop_effect.report_buf = NULL;
344ff358495706a Angela Czubak       2025-08-18  536  buffer_free:
344ff358495706a Angela Czubak       2025-08-18  537  	while (--r >= 0)
344ff358495706a Angela Czubak       2025-08-18  538  		kfree(haptic->effect[r].report_buf);
344ff358495706a Angela Czubak       2025-08-18  539  	kfree(haptic->effect);
344ff358495706a Angela Czubak       2025-08-18  540  	haptic->effect = NULL;
344ff358495706a Angela Czubak       2025-08-18  541  output_queue:
344ff358495706a Angela Czubak       2025-08-18  542  	destroy_workqueue(haptic->wq);
344ff358495706a Angela Czubak       2025-08-18  543  	haptic->wq = NULL;
344ff358495706a Angela Czubak       2025-08-18  544  duration_map:
344ff358495706a Angela Czubak       2025-08-18  545  	kfree(haptic->duration_map);
344ff358495706a Angela Czubak       2025-08-18  546  	haptic->duration_map = NULL;
344ff358495706a Angela Czubak       2025-08-18  547  usage_map:
344ff358495706a Angela Czubak       2025-08-18  548  	kfree(haptic->hid_usage_map);
344ff358495706a Angela Czubak       2025-08-18  549  	haptic->hid_usage_map = NULL;
344ff358495706a Angela Czubak       2025-08-18  550  exit:
344ff358495706a Angela Czubak       2025-08-18  551  	return ret;
344ff358495706a Angela Czubak       2025-08-18  552  }
344ff358495706a Angela Czubak       2025-08-18  553  EXPORT_SYMBOL_GPL(hid_haptic_init);
a77efca3aa85e38 Angela Czubak       2025-08-18  554  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
