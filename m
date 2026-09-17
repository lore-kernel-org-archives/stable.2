Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563EA491588;
	Thu, 17 Sep 2026 08:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789634586; cv=none; b=VbAZ45DuaKINi4AqmhVR2zw3xcIO241gRaFSUIc/7G7h02ERSlBWV5QshptcuFh+f27CuB1pzsoadivInQg49eN3OPKRr2vwJiHmMgAnF1gYtU7n1DFPJSdAe1f9UdacV8Cm9TlKxgilCP9m8rJqB5hkm5WjKy0jhrCXNcwfJ1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789634586; c=relaxed/simple;
	bh=ca2bSrHmaobUPE6FKGEwCza6bF8w2hqM+0de2rE6VS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p3cPCzBVoof1WzDEx93xa2CfHqzJrcMgtEOxZjgTUilSqRa8Gj1Wfmw1zi4zOiODQkK4fKGzP0yhSKPxzrHBlOpvlroZdtxmmogXKCNXZEBSyrvO/oR+v2PBmbdUKeCtK+WfKEFwSL0GRgoC8oessE3zei21dRgGF8zxrJjnXyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kbinsmvf; arc=none smtp.client-ip=192.198.163.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kbinsmvf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789634582; x=1821170582;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ca2bSrHmaobUPE6FKGEwCza6bF8w2hqM+0de2rE6VS4=;
  b=KbinsmvfU0s4U1U41FTbbN9SOCqu47EHIhBz52B6kMt8T/Rczp1K8OR0
   eWplR80f4pISjN3hJoGZZd8pH20vbiqJqC3xfuz6OpiyiN8pwPGNdf06m
   IfyZ4z1uhMHSF5+Tk5C9FJDScxs5AICxVoga1B/PXZOhutF1pnujhDsKg
   hsRDb48w5OAwdxdFxfyZ4MI4l9VGI3C5sLCIYMCYIim1mC59QDsDKhmxz
   yeYkm89oAPvsO1kMwU9QzLXkNSQyYDa0Li3eysj5Pmws9IDWJiTxSr3Ex
   8nkl4C23envnZGQw1O+ZNHTJFnjzNN6aah8tLkR/C7/y0mzanjvS5Qzwz
   Q==;
X-CSE-ConnectionGUID: XkOnNh1lR36QDgTOC80Mxw==
X-CSE-MsgGUID: j6QJdxrFSuSkMWpC8LEjUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="543011"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="543011"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa116.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 01:42:41 -0700
X-CSE-ConnectionGUID: YS7t7p99Qze4tZdEMVSqyA==
X-CSE-MsgGUID: sQkmySHbQd646GJ6/CCGuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1874268"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by fmviesa012.fm.intel.com with ESMTP; 17 Sep 2026 01:42:38 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x77hT-000000007Pd-19fk;
	Thu, 17 Sep 2026 08:42:35 +0000
Date: Thu, 17 Sep 2026 16:41:48 +0800
From: kernel test robot <lkp@intel.com>
To: Wentao Liang <vulab@iscas.ac.cn>, airlied@gmail.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	dri-devel@lists.freedesktop.org, jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
	mperttunen@nvidia.com, simona@ffwll.ch, thierry.reding@kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>, stable@vger.kernel.org
Subject: Re: [PATCH] drm/tegra: Fix bo reference leak in
 host1x_reloc_copy_from_user()
Message-ID: <202609171640.8lyJYO2E-lkp@intel.com>
References: <20260916182550.2091797-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916182550.2091797-1-vulab@iscas.ac.cn>

Hi Wentao,

kernel test robot noticed the following build errors:

[auto build test ERROR on tegra/for-next]
[also build test ERROR on daeinki-drm-exynos/exynos-drm-next drm/drm-next drm-i915/for-linux-next drm-i915/for-linux-next-fixes drm-misc/drm-misc-next drm-tip/drm-tip linus/master drm-tegra/drm/tegra/for-next v7.3-rc3 next-20260916]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wentao-Liang/drm-tegra-Fix-bo-reference-leak-in-host1x_reloc_copy_from_user/20260916-182550
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git for-next
patch link:    https://lore.kernel.org/r/20260916182550.2091797-1-vulab%40iscas.ac.cn
patch subject: [PATCH] drm/tegra: Fix bo reference leak in host1x_reloc_copy_from_user()
config: hexagon-randconfig-1000-20260917 (https://download.01.org/0day-ci/archive/20260917/202609171640.8lyJYO2E-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260917/202609171640.8lyJYO2E-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609171640.8lyJYO2E-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/tegra/drm.c:163:22: error: incompatible pointer types passing 'struct host1x_bo *' to parameter of type 'struct drm_gem_object *' [-Werror,-Wincompatible-pointer-types]
     163 |                 drm_gem_object_put(dest->cmdbuf.bo);
         |                                    ^~~~~~~~~~~~~~~
   include/drm/drm_gem.h:572:43: note: passing argument to parameter 'obj' here
     572 | drm_gem_object_put(struct drm_gem_object *obj)
         |                                           ^
   1 error generated.


vim +163 drivers/gpu/drm/tegra/drm.c

   126	
   127	static int host1x_reloc_copy_from_user(struct host1x_reloc *dest,
   128					       struct drm_tegra_reloc __user *src,
   129					       struct drm_device *drm,
   130					       struct drm_file *file)
   131	{
   132		u32 cmdbuf, target;
   133		int err;
   134	
   135		err = get_user(cmdbuf, &src->cmdbuf.handle);
   136		if (err < 0)
   137			return err;
   138	
   139		err = get_user(dest->cmdbuf.offset, &src->cmdbuf.offset);
   140		if (err < 0)
   141			return err;
   142	
   143		err = get_user(target, &src->target.handle);
   144		if (err < 0)
   145			return err;
   146	
   147		err = get_user(dest->target.offset, &src->target.offset);
   148		if (err < 0)
   149			return err;
   150	
   151		err = get_user(dest->shift, &src->shift);
   152		if (err < 0)
   153			return err;
   154	
   155		dest->flags = HOST1X_RELOC_READ | HOST1X_RELOC_WRITE;
   156	
   157		dest->cmdbuf.bo = tegra_gem_lookup(file, cmdbuf);
   158		if (!dest->cmdbuf.bo)
   159			return -ENOENT;
   160	
   161		dest->target.bo = tegra_gem_lookup(file, target);
   162		if (!dest->target.bo) {
 > 163			drm_gem_object_put(dest->cmdbuf.bo);
   164			return -ENOENT;
   165		}
   166	
   167		return 0;
   168	}
   169	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
