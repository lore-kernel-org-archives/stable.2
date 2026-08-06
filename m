Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A42C2B2D7;
	Thu,  6 Aug 2026 03:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785988103; cv=none; b=j6ACs+JCu3e5Gr0pHiYZ16oc/3Gey1pEcLuH+iqjuf+/IUgtJHsCx/kJpa7jIev3WF3XitQGM/NmT9s0/NLe+MOPlQEHLWMNJgGTr3GbxIoJWhE+5YQ8r7ca5wYC+44h/mmX0r7vui8Ojq18dPhyZ4wRR8F1upsDqgI+9QOeJH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785988103; c=relaxed/simple;
	bh=17CY3PUmUbDY4206LrobRGj6cHDNUS+fi01DdzhC8EE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nb1d+i2+CTBYoF5ZxxOaiGp62PrmuIkeead/tInL8G3+kxAyV1v99v3l8LkGEHu5nr56rgLA11nupAnelWqi2gqxVy/XpP5ckDJUcc+v++Tl7/lu+el5aGm2WFyEsdPWJm7tb3NZ6/E5zu3Ev89MQMjlIuePoxZnuoraniNvOE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HuqqpGZo; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HuqqpGZo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785988101; x=1817524101;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=17CY3PUmUbDY4206LrobRGj6cHDNUS+fi01DdzhC8EE=;
  b=HuqqpGZoNauZ6X8UbT2nc9HMvDRxA0Y1a7M0wYGa1tWOIsBL5sW/sWot
   P5mGJaHf1VlJ7E9uv5mBPFxs3rSBTFvNl5fDZafDT3RiimJMMNtLUJXJI
   coxDOUns1ddlQIQjrc8Xhy8nRxX9BezG+5StIVComThYvaQLwU2MkH/Qu
   TtiiP5YdpBiF/v41isLsJO3uGa+XdtKGqm7MaoFzW0ltFD8PhJ+LLd8KQ
   N85n6sTxN6E21dnoLxPwUfAgeDCit0zoR4IdPWjXJvC0nzZ+v06LQrVXV
   EFUiDSkqwfpkJndbvl/zvEYuLaQgyvRoPmKxtUxXlCpaL6nx9b5lKcLHL
   Q==;
X-CSE-ConnectionGUID: j6RpJCeUSd6FWN+OEt5EDA==
X-CSE-MsgGUID: /pLn9okSQ7Wa8G730OpaaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="90391110"
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="90391110"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 20:48:20 -0700
X-CSE-ConnectionGUID: 3rUXs0JSR+2YNmvlS1AgAw==
X-CSE-MsgGUID: /GpNXoZ9SJ2duOVMTxtToA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="286649429"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 05 Aug 2026 20:48:16 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wrp5a-00000000E3l-0KnC;
	Thu, 06 Aug 2026 03:48:14 +0000
Date: Thu, 6 Aug 2026 11:47:14 +0800
From: kernel test robot <lkp@intel.com>
To: Bert Karwatzki <spasswolf@web.de>, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Bert Karwatzki <spasswolf@web.de>, linux-next@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, amd-gfx@lists.freedesktop.org,
	"# = v7 . 1" <stable@vger.kernel.org>,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Rafal Ostrowski <rafal.ostrowski@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] drm/amd/display: fix usage of DC_FPU_{BEGIN,END} with
 PREEMPT_RT
Message-ID: <202608061154.QtrglsMo-lkp@intel.com>
References: <20260801071724.12998-1-spasswolf@web.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260801071724.12998-1-spasswolf@web.de>

Hi Bert,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20260804]
[cannot apply to drm-misc/drm-misc-next linus/master v7.2-rc6 v7.2-rc5 v7.2-rc4 v7.2-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bert-Karwatzki/drm-amd-display-fix-usage-of-DC_FPU_-BEGIN-END-with-PREEMPT_RT/20260805-170330
base:   next-20260804
patch link:    https://lore.kernel.org/r/20260801071724.12998-1-spasswolf%40web.de
patch subject: [PATCH] drm/amd/display: fix usage of DC_FPU_{BEGIN,END} with PREEMPT_RT
config: loongarch-defconfig (https://download.01.org/0day-ci/archive/20260806/202608061154.QtrglsMo-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project bacfe2950f8218268fcc0a8765644ea0c15f0360)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260806/202608061154.QtrglsMo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608061154.QtrglsMo-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_surface.c:89:2: error: call to undeclared function 'DC_RUN_WITH_PREEMPTION_ENABLED'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      89 |         DC_RUN_WITH_PREEMPTION_ENABLED(plane_state = kvzalloc_obj(*plane_state, GFP_ATOMIC));
         |         ^
   1 error generated.


vim +/DC_RUN_WITH_PREEMPTION_ENABLED +89 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_surface.c

    82	
    83	/*******************************************************************************
    84	 * Public functions
    85	 ******************************************************************************/
    86	struct dc_plane_state *dc_create_plane_state(const struct dc *dc)
    87	{
    88		struct dc_plane_state *plane_state;
  > 89		DC_RUN_WITH_PREEMPTION_ENABLED(plane_state = kvzalloc_obj(*plane_state, GFP_ATOMIC));
    90	
    91		if (NULL == plane_state)
    92			return NULL;
    93	
    94		kref_init(&plane_state->refcount);
    95		dc_plane_construct(dc->ctx, plane_state);
    96	
    97		return plane_state;
    98	}
    99	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
