Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8C338333A;
	Thu, 17 Sep 2026 02:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789611644; cv=none; b=q1PIMeWgXt41pkGYBWQ3B9gmr1kH0GTK6t5xBK9Q+pObniShVJ6aCEeWrvcVHRe2BZ9KK8si7rDsbPNbJ9yC23kOWGlxnUHA/E/+o5PTfcmuGvvcfcFVIndjhbxpLR9oxCeg7YOxfboi5OnlFaRh40OJzZj80CDrNATu9R3QTbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789611644; c=relaxed/simple;
	bh=uaRNHAbNqeF/mMuH2ZtQgqqmjOT8sz6v8esrl6uU8GU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YUwYN7FZA+3jq7NxzNwZEjq2moGAS25Mdw9ysb8LmRF+Xp+7WrnwpxahQ3Qic3EVGahpCwutnf0+iS21OvgeFuqs7Hjq3sgrboeEjO3s0VCkagNsChJUayDK3sPXfEE/OjwFRe3RShSHn0k3/yZtIV23BrKIcaY+53ecV8CZnHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lKbbyEzt; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lKbbyEzt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789611641; x=1821147641;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uaRNHAbNqeF/mMuH2ZtQgqqmjOT8sz6v8esrl6uU8GU=;
  b=lKbbyEzt1Cf7JshXkbtZdgUSiGLMkR2Jbda/VA3GKUl82Q1nQ8EW7rhN
   HeIDGEu2M3to8GLw8oPbpxTsotagUV2J30LQzrMz2ntcXgHVq1vCY+Ato
   0pCcUsp/StWM3YMDYakyoLHSpG+C9cEAFxZUQHZuikHVU031ifUFAnNPL
   qAr1NSzSL4iJ336bVnPU8rOdthlPZdvjyYgJPyVYW3Qyga4/A74pQcV5B
   9vLVGen0V8qm/xsWebYjztzugydF2IZ5mfN1Y69/KzY76g8h52ud4umJ6
   HFUp4B2aAd67C05wHIMdSb3ecsNp/pxGpiodfki5NYLCrzbB/sQbyKfeL
   A==;
X-CSE-ConnectionGUID: fw9a7S/aTvuIfGalZeaHZw==
X-CSE-MsgGUID: SWLBPQiSQnyf4SVCoyL1IQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100593456"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="100593456"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 19:20:38 -0700
X-CSE-ConnectionGUID: a+FrgqhxRjKDOKkVEATCSQ==
X-CSE-MsgGUID: y3/3CyIPRK6AE7Rx+yu9QQ==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 16 Sep 2026 19:20:35 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x71jk-0000000071J-3YSR;
	Thu, 17 Sep 2026 02:20:32 +0000
Date: Thu, 17 Sep 2026 10:20:03 +0800
From: kernel test robot <lkp@intel.com>
To: Wentao Liang <vulab@iscas.ac.cn>, Felix.Kuehling@amd.com
Cc: oe-kbuild-all@lists.linux.dev, airlied@gmail.com,
	alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
	christian.koenig@amd.com, david.yatsin@amd.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	rajneesh.bhardwaj@amd.com, simona@ffwll.ch,
	Wentao Liang <vulab@iscas.ac.cn>, stable@vger.kernel.org
Subject: Re: [PATCH] drm/amdkfd: Fix file reference leak in
 criu_restore_devices()
Message-ID: <202609171036.aewbdced-lkp@intel.com>
References: <20260916074216.1973191-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916074216.1973191-1-vulab@iscas.ac.cn>

Hi Wentao,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-misc/drm-misc-next]
[also build test WARNING on linus/master v7.3-rc3 next-20260916]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wentao-Liang/drm-amdkfd-Fix-file-reference-leak-in-criu_restore_devices/20260916-074216
base:   https://gitlab.freedesktop.org/drm/misc/kernel.git drm-misc-next
patch link:    https://lore.kernel.org/r/20260916074216.1973191-1-vulab%40iscas.ac.cn
patch subject: [PATCH] drm/amdkfd: Fix file reference leak in criu_restore_devices()
config: x86_64-randconfig-1300-20260917 (https://download.01.org/0day-ci/archive/20260917/202609171036.aewbdced-lkp@intel.com/config)
compiler: clang version 22.1.3 (https://github.com/llvm/llvm-project e9846648fd6183ee6d8cbdb4502213fcf902a211)
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260917/202609171036.aewbdced-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609171036.aewbdced-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_chardev.c:2383:9: warning: variable 'drm_file' is uninitialized when used here [-Wuninitialized]
    2383 |                         fput(drm_file);
         |                              ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_chardev.c:2356:24: note: initialize the variable 'drm_file' to silence this warning
    2356 |                 struct file *drm_file;
         |                                      ^
         |                                       = NULL
   1 warning generated.


vim +/drm_file +2383 drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_chardev.c

  2330	
  2331	static int criu_restore_devices(struct kfd_process *p,
  2332					struct kfd_ioctl_criu_args *args,
  2333					uint64_t *priv_offset,
  2334					uint64_t max_priv_data_size)
  2335	{
  2336		struct kfd_criu_device_bucket *device_buckets;
  2337		struct kfd_criu_device_priv_data *device_privs;
  2338		int ret = 0;
  2339		uint32_t i;
  2340	
  2341		if (args->num_devices != p->n_pdds)
  2342			return -EINVAL;
  2343	
  2344		if (*priv_offset + (args->num_devices * sizeof(*device_privs)) > max_priv_data_size)
  2345			return -EINVAL;
  2346	
  2347		device_buckets = memdup_array_user((void *)args->devices,
  2348						args->num_devices, sizeof(*device_buckets));
  2349	
  2350		if (IS_ERR(device_buckets))
  2351			return PTR_ERR(device_buckets);
  2352	
  2353		for (i = 0; i < args->num_devices; i++) {
  2354			struct kfd_node *dev;
  2355			struct kfd_process_device *pdd;
  2356			struct file *drm_file;
  2357	
  2358			/* device private data is not currently used */
  2359	
  2360			if (!device_buckets[i].user_gpu_id) {
  2361				pr_err("Invalid user gpu_id\n");
  2362				ret = -EINVAL;
  2363				goto exit;
  2364			}
  2365	
  2366			dev = kfd_device_by_id(device_buckets[i].actual_gpu_id);
  2367			if (!dev) {
  2368				pr_err("Failed to find device with gpu_id = %x\n",
  2369					device_buckets[i].actual_gpu_id);
  2370				ret = -EINVAL;
  2371				goto exit;
  2372			}
  2373	
  2374			pdd = kfd_get_process_device_data(dev, p);
  2375			if (!pdd) {
  2376				pr_err("Failed to get pdd for gpu_id = %x\n",
  2377						device_buckets[i].actual_gpu_id);
  2378				ret = -EINVAL;
  2379				goto exit;
  2380			}
  2381	
  2382			if (pdd->drm_file) {
> 2383				fput(drm_file);
  2384				ret = -EINVAL;
  2385				goto exit;
  2386			}
  2387			pdd->user_gpu_id = device_buckets[i].user_gpu_id;
  2388	
  2389			drm_file = fget(device_buckets[i].drm_fd);
  2390			if (!drm_file) {
  2391				pr_err("Invalid render node file descriptor sent from plugin (%d)\n",
  2392					device_buckets[i].drm_fd);
  2393				ret = -EINVAL;
  2394				goto exit;
  2395			}
  2396	
  2397			/* create the vm using render nodes for kfd pdd */
  2398			if (kfd_process_device_init_vm(pdd, drm_file)) {
  2399				pr_err("could not init vm for given pdd\n");
  2400				/* On success, the PDD keeps the drm_file reference */
  2401				fput(drm_file);
  2402				ret = -EINVAL;
  2403				goto exit;
  2404			}
  2405			/*
  2406			 * pdd now already has the vm bound to render node so below api won't create a new
  2407			 * exclusive kfd mapping but use existing one with renderDXXX but is still needed
  2408			 * for iommu v2 binding  and runtime pm.
  2409			 */
  2410			pdd = kfd_bind_process_to_device(dev, p);
  2411			if (IS_ERR(pdd)) {
  2412				ret = PTR_ERR(pdd);
  2413				goto exit;
  2414			}
  2415	
  2416			if (!pdd->qpd.proc_doorbells) {
  2417				ret = kfd_alloc_process_doorbells(dev->kfd, pdd);
  2418				if (ret)
  2419					goto exit;
  2420			}
  2421		}
  2422	
  2423		/*
  2424		 * We are not copying device private data from user as we are not using the data for now,
  2425		 * but we still adjust for its private data.
  2426		 */
  2427		*priv_offset += args->num_devices * sizeof(*device_privs);
  2428	
  2429	exit:
  2430		kfree(device_buckets);
  2431		return ret;
  2432	}
  2433	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
