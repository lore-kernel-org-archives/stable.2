Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA81F30C632;
	Sat,  8 Aug 2026 00:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786150747; cv=none; b=RDUwglaB+nXI8i14zIR7EAiPKZT7l+Q94va04CVIeAMmv+PRV5Li73Gaxsm/t2mEu9O/LvmMtpP7UNYtgfyPmbzuvnw41svarmUAU2Pq3Q8CaVysY8DhC0/Luw4bWHpdZYCY7FGHBNx4QF63mzG6c2s9m367I8S6Ovm5d22b/QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786150747; c=relaxed/simple;
	bh=tDsgwi2+k+THwubQx+A8h/nHxkN0MXsHSi+73LAr1l8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fr5FJrjX27rC8yrH2DKPKUwiIxFGZc0qshuVmlKMpBKNgzjk9a2kIqnoyWJDVfVPUEdPlukLVMQ5C4i6EuAhZzSvv2dv6okXxZm4/o2OFIso0UPooRhd9ntDg7Ut1sguITRDonZNb1FhbXGJakB2o1ZHzvTSsShHC2DdECayJbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e9sTGxuc; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e9sTGxuc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786150744; x=1817686744;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tDsgwi2+k+THwubQx+A8h/nHxkN0MXsHSi+73LAr1l8=;
  b=e9sTGxucwP8CBTYH7k+gP62HlFh5W2aXNhJi5nDiD+e3XNTpX2kxBQ1z
   l/PiKFoooyaH2FRQy6e3sulFBpWH4yF4kxKw5VVrfL3kHpGPJ9Emm3uE+
   ZDMAa9+kw51PL/mwR/FiE34ZtU/bRlyECmWfUNcrWBHq8/NPaS0PavKdO
   cQbIt7bivCZb/JN60/mohLeds6wC4xSNE/58j8PB6s5vt6ClrEBOW/fch
   qNzbFSes2togTKJlBBowJSdyvOQveTWovDQTLkQZGbZnMwJ4p6DGbPa3n
   5WYsr2iSlNTggP/vA9lemUH+sx/Bk6ieYrHqgVBTHu0YxV9KxERugpbg3
   g==;
X-CSE-ConnectionGUID: IuvnsDHiSSGtBxvBIpIcHQ==
X-CSE-MsgGUID: cJIQoy4kRmukJ87gPCHAtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11868"; a="86841946"
X-IronPort-AV: E=Sophos;i="6.25,211,1779174000"; 
   d="scan'208";a="86841946"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 17:59:04 -0700
X-CSE-ConnectionGUID: oVI4r9TbROqmryREAQmPiQ==
X-CSE-MsgGUID: 1u6Sx5aARbCQUu/2v1uMnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,211,1779174000"; 
   d="scan'208";a="256310033"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 07 Aug 2026 17:59:00 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wsVOr-00000000Jab-02ue;
	Sat, 08 Aug 2026 00:58:57 +0000
Date: Sat, 8 Aug 2026 08:58:47 +0800
From: kernel test robot <lkp@intel.com>
To: WenTao Liang <vulab@iscas.ac.cn>, Zack Rusin <zack.rusin@broadcom.com>,
	dri-devel@lists.freedesktop.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	bcm-kernel-feedback-list@broadcom.com,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Thomas Hellstrom <thellstrom@vmware.com>, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, WenTao Liang <vulab@iscas.ac.cn>
Subject: Re: [PATCH] fix: drm/vmwgfx: vmw_user_shader_alloc: fix base object
 refcount leak on ttm_base_object_init failure
Message-ID: <202608080849.rqxWdd9U-lkp@intel.com>
References: <20260626150142.49732-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626150142.49732-1-vulab@iscas.ac.cn>

Hi WenTao,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on daeinki-drm-exynos/exynos-drm-next drm/drm-next drm-i915/for-linux-next drm-i915/for-linux-next-fixes drm-tip/drm-tip linus/master v7.2-rc6 next-20260807]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/WenTao-Liang/fix-drm-vmwgfx-vmw_user_shader_alloc-fix-base-object-refcount-leak-on-ttm_base_object_init-failure/20260807-080356
base:   https://gitlab.freedesktop.org/drm/misc/kernel.git drm-misc-next
patch link:    https://lore.kernel.org/r/20260626150142.49732-1-vulab%40iscas.ac.cn
patch subject: [PATCH] fix: drm/vmwgfx: vmw_user_shader_alloc: fix base object refcount leak on ttm_base_object_init failure
config: arm64-randconfig-002-20260807 (https://download.01.org/0day-ci/archive/20260808/202608080849.rqxWdd9U-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 12df34b8469b8095359de8c249cb1b2753fadeea)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260808/202608080849.rqxWdd9U-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608080849.rqxWdd9U-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/vmwgfx/vmwgfx_shader.c:727:25: error: incompatible pointer types passing 'struct ttm_base_object *' to parameter of type 'struct ttm_base_object **' [-Wincompatible-pointer-types]
     727 |                 ttm_base_object_unref(&ushader->base);
         |                                       ^~~~~~~~~~~~~~
   drivers/gpu/drm/vmwgfx/ttm_object.h:192:60: note: passing argument to parameter 'p_base' here
     192 | extern void ttm_base_object_unref(struct ttm_base_object **p_base);
         |                                                            ^
   1 error generated.


vim +727 drivers/gpu/drm/vmwgfx/vmwgfx_shader.c

   684	
   685	static int vmw_user_shader_alloc(struct vmw_private *dev_priv,
   686					 struct vmw_bo *buffer,
   687					 size_t shader_size,
   688					 size_t offset,
   689					 SVGA3dShaderType shader_type,
   690					 uint8_t num_input_sig,
   691					 uint8_t num_output_sig,
   692					 struct ttm_object_file *tfile,
   693					 u32 *handle)
   694	{
   695		struct vmw_user_shader *ushader;
   696		struct vmw_resource *res, *tmp;
   697		int ret;
   698	
   699		ushader = kzalloc_obj(*ushader);
   700		if (unlikely(!ushader)) {
   701			ret = -ENOMEM;
   702			goto out;
   703		}
   704	
   705		res = &ushader->shader.res;
   706		ushader->base.shareable = false;
   707		ushader->base.tfile = NULL;
   708	
   709		/*
   710		 * From here on, the destructor takes over resource freeing.
   711		 */
   712	
   713		ret = vmw_gb_shader_init(dev_priv, res, shader_size,
   714					 offset, shader_type, num_input_sig,
   715					 num_output_sig, buffer,
   716					 vmw_user_shader_free);
   717		if (unlikely(ret != 0))
   718			goto out;
   719	
   720		tmp = vmw_resource_reference(res);
   721		ret = ttm_base_object_init(tfile, &ushader->base, false,
   722					   VMW_RES_SHADER,
   723					   &vmw_user_shader_base_release);
   724	
   725		if (unlikely(ret != 0)) {
   726			vmw_resource_unreference(&tmp);
 > 727			ttm_base_object_unref(&ushader->base);
   728			goto out_err;
   729		}
   730	
   731		if (handle)
   732			*handle = ushader->base.handle;
   733	out_err:
   734		vmw_resource_unreference(&res);
   735	out:
   736		return ret;
   737	}
   738	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
