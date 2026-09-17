Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3096446074;
	Thu, 17 Sep 2026 07:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789630579; cv=none; b=GsfHjuEAZxBbpbIU/ALXmoIbFE8xLrjmIp/Yq2GFlGOS5zTA8KV28nKOUhM9f0fj/ohTVo1agTNaGLAUvEF5x5BsFbSCOjR+EvTfLy32c7hGp5tRcFJ+7F+vX7XZLXhddk6Cg6gdjQhlG0pGdf5pVdiU/K25wxOA+87Sdg2l4s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789630579; c=relaxed/simple;
	bh=fFsXsdJmM+T4Frta7q8+ZDhdN43sXhlIZkM4hMO7Tzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZkROFmdWU7FrkdI6V9hx2oFk3ksUiIdBL0mYEZYU5b6OIA8EaAUESETpXZvH6fDMBMSIWyeYH828oQq6z+tssC8aufOVLA/4WrZHkI/D9ipgYZ2rZZWI/lDTDvrrbWmvRlViv3BogPuqc7IJgqtKameJs8ijLV0+x1IAiZ9YaY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JNUHVPwt; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JNUHVPwt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789630577; x=1821166577;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fFsXsdJmM+T4Frta7q8+ZDhdN43sXhlIZkM4hMO7Tzo=;
  b=JNUHVPwtggfXcCQOyV93uYcUKy6qOA9VSj2COJv1w6b9ICjYhk6BDr+S
   IN9xT/oS2dph0oo0faR9qk5X7HFi3mOO5Cq5i9OBLNlzsfKahhNZ5ZGxb
   KUzkJkpRmpjYdDigYBglrNwamc7i2SB/zvhbqqsGkmWBnQ2YUbGaI243D
   nC98c6VLT0l2TSkRDGrgfsRdB4rkNSYW6JndkuxuPbOaZWyDfYQnWGFnc
   0szawwuFAjkzhkjI8tFBdoDbDYUxR9G8/CIL5x89NEc2nvaXeTAnDWq3a
   OWcdUk2DYdmxjDctkyeVfoToFR3KPpMfNOFviqVsYtU8UO/T+orDzOzSW
   Q==;
X-CSE-ConnectionGUID: wiFYJu72Q4CnBU5DdM92CA==
X-CSE-MsgGUID: Cdi6xV2FSsiwRx5sEtmkzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="93851404"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="93851404"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 00:36:16 -0700
X-CSE-ConnectionGUID: +aL9pj8+TmC9blf2PDAP1A==
X-CSE-MsgGUID: b9575PWxRCCOdcnOvfVcvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="297122013"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 17 Sep 2026 00:36:13 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x76fB-000000007GH-3VKM;
	Thu, 17 Sep 2026 07:36:09 +0000
Date: Thu, 17 Sep 2026 15:35:46 +0800
From: kernel test robot <lkp@intel.com>
To: Wentao Liang <vulab@iscas.ac.cn>, airlied@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, dri-devel@lists.freedesktop.org,
	jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org, mperttunen@nvidia.com, simona@ffwll.ch,
	thierry.reding@kernel.org, Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: Re: [PATCH] drm/tegra: Fix bo reference leak in
 host1x_reloc_copy_from_user()
Message-ID: <202609171531.CIG2e49k-lkp@intel.com>
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
[also build test ERROR on daeinki-drm-exynos/exynos-drm-next drm/drm-next drm-i915/for-linux-next drm-i915/for-linux-next-fixes drm-misc/drm-misc-next drm-tip/drm-tip linus/master v7.3-rc3 next-20260916]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wentao-Liang/drm-tegra-Fix-bo-reference-leak-in-host1x_reloc_copy_from_user/20260916-182550
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git for-next
patch link:    https://lore.kernel.org/r/20260916182550.2091797-1-vulab%40iscas.ac.cn
patch subject: [PATCH] drm/tegra: Fix bo reference leak in host1x_reloc_copy_from_user()
config: arc-randconfig-1001-20260917 (https://download.01.org/0day-ci/archive/20260917/202609171531.CIG2e49k-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260917/202609171531.CIG2e49k-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609171531.CIG2e49k-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/gpu/drm/tegra/drm.c: In function 'host1x_reloc_copy_from_user':
>> drivers/gpu/drm/tegra/drm.c:163:48: error: passing argument 1 of 'drm_gem_object_put' from incompatible pointer type [-Wincompatible-pointer-types]
     163 |                 drm_gem_object_put(dest->cmdbuf.bo);
         |                                    ~~~~~~~~~~~~^~~
         |                                                |
         |                                                struct host1x_bo *
   In file included from include/drm/drm_gpuvm.h:35,
                    from include/drm/drm_debugfs.h:38,
                    from drivers/gpu/drm/tegra/drm.c:19:
   include/drm/drm_gem.h:572:43: note: expected 'struct drm_gem_object *' but argument is of type 'struct host1x_bo *'
     572 | drm_gem_object_put(struct drm_gem_object *obj)
         |                    ~~~~~~~~~~~~~~~~~~~~~~~^~~


vim +/drm_gem_object_put +163 drivers/gpu/drm/tegra/drm.c

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
