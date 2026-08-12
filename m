Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD70033B970;
	Wed, 12 Aug 2026 20:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786567655; cv=none; b=j49oqcFymWKCtseDIPacdja9AkDaGlQjuuoybsgdBTI1BVsI4SHbUzbw8piX9ov/XSVOXrXdK7D1qRMjeQdNbo0TlsoYabQJs9eJrG/njajhnMTXH2TgmiQFojJqL20L3VEXsksQwNVD0fD66hioWH8lRdeSN7SYsmmSdD6JTPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786567655; c=relaxed/simple;
	bh=w024XBgg1ZjZTH0vd9AYmyiNtdRYrahWGr88BWoZsA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K/X0sESNgvqaoHHYXgfz6hxfsa3mwqx41ZEpv8VxCXukpQlc5hdT/9x9cj7dlN5e5rQgAKgJF2DhI4px7LmmK0nIDgm/Hy6qrW2k4fFOewYmi9wITMrGonQKR0z/7/NK88YSzV5VMaeopJpnFRQKcgbhiJNGDWFyxwijw/Cawc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mm1cuohF; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mm1cuohF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786567654; x=1818103654;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w024XBgg1ZjZTH0vd9AYmyiNtdRYrahWGr88BWoZsA0=;
  b=mm1cuohFQUH2JFcRTVCUr/hWfNV3lTVoIWn6lXlk8Ar1Z/xZFjrmQ/kD
   muHkt+Ldpz6UBE7y+NAWm2XL0f8q+5zg8ECSf0UNC28dSZcOgNktMAkDk
   hYfIxvrRWvLIGtR3VomiC7Y/ifnCLV2hBo45JFkzlAYpe4Zoc20jqYkvT
   P3VvXYKWOUFQyVfeQjvbsAwYbwZ6ca+6NGFgn/fwmqZO1DXYHIKgVslLh
   O5XRiZvkqbihKzQpJWFiMkxZtA2zA8MphZ5I0WUafM6jbxLxmCHks3KTG
   IGF7rRLYuiIhQ7XYi9cnWPCyxu4Cijs4g3ThlOUzND8u1wiVuYu7H7FK8
   g==;
X-CSE-ConnectionGUID: cjJ/CFkkS8e/AVBMqv/Q+g==
X-CSE-MsgGUID: GEz4AuynQxKpb1Wk4x/bUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="87015548"
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="87015548"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 13:47:33 -0700
X-CSE-ConnectionGUID: Iiifp7rBQgiDvA2CY6xE8w==
X-CSE-MsgGUID: BJvATKfzTDe9unPHUxHYcg==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 12 Aug 2026 13:47:29 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wuFrD-00000000ReQ-0iLw;
	Wed, 12 Aug 2026 20:47:27 +0000
Date: Thu, 13 Aug 2026 04:46:49 +0800
From: kernel test robot <lkp@intel.com>
To: Pavitra Jha <jhapavitra98@gmail.com>, alexander.deucher@amd.com,
	christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Pavitra Jha <jhapavitra98@gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu/discovery: validate table offset before IP
 discovery header cast
Message-ID: <202608130435.5Msck82Q-lkp@intel.com>
References: <20260708061835.111986-1-jhapavitra98@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708061835.111986-1-jhapavitra98@gmail.com>

Hi Pavitra,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on linus/master v7.2-rc7 next-20260811]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pavitra-Jha/drm-amdgpu-discovery-validate-table-offset-before-IP-discovery-header-cast/20260812-100224
base:   https://gitlab.freedesktop.org/drm/misc/kernel.git drm-misc-next
patch link:    https://lore.kernel.org/r/20260708061835.111986-1-jhapavitra98%40gmail.com
patch subject: [PATCH v2] drm/amdgpu/discovery: validate table offset before IP discovery header cast
config: loongarch-defconfig (https://download.01.org/0day-ci/archive/20260813/202608130435.5Msck82Q-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 12df34b8469b8095359de8c249cb1b2753fadeea)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260813/202608130435.5Msck82Q-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608130435.5Msck82Q-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:534:25: error: member reference type 'struct table_info' is not a pointer; did you mean to use '.'?
     534 |         if (le16_to_cpu((*info)->offset) >= adev->discovery.size) {
         |                         ~~~~~~~^~
         |                                .
   include/linux/byteorder/generic.h:91:21: note: expanded from macro 'le16_to_cpu'
      91 | #define le16_to_cpu __le16_to_cpu
         |                     ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:536:23: error: member reference type 'struct table_info' is not a pointer; did you mean to use '.'?
     536 |                         le16_to_cpu((*info)->offset), table_id);
         |                                     ~~~~~~~^~
         |                                            .
   include/linux/dev_printk.h:154:65: note: expanded from macro 'dev_err'
     154 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                                        ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                                     ^~~~~~~~~~~
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
>> drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:536:34: error: use of undeclared identifier 'table_id'
     536 |                         le16_to_cpu((*info)->offset), table_id);
         |                                                       ^~~~~~~~
   3 errors generated.


vim +534 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c

   508	
   509	static int amdgpu_discovery_verify_npsinfo(struct amdgpu_device *adev,
   510						   struct table_info *info)
   511	{
   512		uint8_t *discovery_bin = adev->discovery.bin;
   513		uint16_t checksum;
   514		uint16_t offset;
   515	
   516		offset = le16_to_cpu(info->offset);
   517		checksum = le16_to_cpu(info->checksum);
   518	
   519		struct nps_info_header *nhdr =
   520			(struct nps_info_header *)(discovery_bin + offset);
   521	
   522		if (le32_to_cpu(nhdr->table_id) != NPS_INFO_TABLE_ID) {
   523			dev_dbg(adev->dev, "invalid ip discovery nps info table id\n");
   524			return -EINVAL;
   525		}
   526	
   527		if (!amdgpu_discovery_verify_checksum(adev, discovery_bin + offset,
   528						      le32_to_cpu(nhdr->size_bytes),
   529						      checksum)) {
   530			dev_dbg(adev->dev, "invalid nps info data table checksum\n");
   531			return -EINVAL;
   532		}
   533	
 > 534		if (le16_to_cpu((*info)->offset) >= adev->discovery.size) {
   535			dev_err(adev->dev, "invalid table offset %u for table_id %u\n",
 > 536				le16_to_cpu((*info)->offset), table_id);
   537			return -EINVAL;
   538		}
   539	
   540		return 0;
   541	}
   542	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
