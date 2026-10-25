Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792925395;
	b=fcMP7L9zDsaTAxO+lrT3so5TyyAOV+VWbEOMNlpBVRa63moFZEeU7bxURd6+AI+l+OdI
	 r0R8dkORImzdhzVg5HSBYNjzaIyv5KJgBUKmUs1nzHr8sj2kuY2oFTv4lG6ribJvJBnbn
	 X5U/JfwKTo+DmxgF3xQVn1u7/LSNuGPcd2+7ptzLr2elpXlTGdVZeKEUtEUix5O7C+qAL
	 eNDbGMi5/VV26B/7Xpev6iejJLWAOe2+zePXhJLZDEbF2fDKURXmCgr8oLLkSpUidhR80
	 DsUwUIsQMZlt4je9jn1Q72y9T986H7KzNUcpEAFDepUL5F2Y+oRmo4A/X7YppoBgS/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792925395;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=7JSyZw8IlAUawccxS8oDgVXImKxbTAY0ZCG5l352BOA=;
	b=YHvgKN9p/QRzuI3RUOOKCgBnSXMIrsyzW/mipiRfYkSGaGTmaFliQZjetx5Dx5eG6+Uj
	 8qtdDQhkQkDYX49LV+8eqbWwYSABM43P5xekC3DVp6VaffYiE5DrpiTn+BFkrg3W78m6L
	 Q3DYco6fvmJSLXDQsyT8Ya/XXm5nMAqIHZDMiGLV/Aq9IOU4H7yopH5CFedgh60RRpW4j
	 Bq1G8auPTXi2o/WpJn8Ysc0JBAtPO+RtDVWLqigjwmpvsOWTAejWIjlrJq2wtbqBWpGEc
	 yjUcr00FJdQ9lawDgi3O2UTI8cey0C2MXNpMo5wZnXjlBWHV3aBIC8EXS4hk/MuDAfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="ft8/267K";
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D8E606A31B;
	Sun, 25 Oct 2026 10:49:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6D8E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ft8/267K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792925394; x=1824461394;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Rt5BEY7DwxcNCG/AAfpdZnZc2Khftj/I/zbWxZry5XY=;
  b=ft8/267KabzBwRNH1iLUrT7DKqfUPTM0zm6oBudj+uoU/29XpNzws9R/
   RiuHY8t9Xrrr+5HMhGPhNAe/1ZaHBBqNWBd75hk4uKDg+/7Pvq0a6ihoT
   CYF0ImVdakUBi/OLz48to9ev1QAy2l3XgGs6m3vFQHehlBtYZM3eJenaQ
   EozcrkWzit94MZ2IdXS2yBQbfv45tY11+2I5cMEGH7hnzIhuVpUEOOxXS
   9Vok7LF2ghn3LJrFH4Vzhjf/gn3ZMQtxUtdCZ2Zzs+4x3TEYv4WKBBvy6
   ugEmbz98MvMM3AVWsdVQIHmox9mMv1WqfXQiW26TNxWDVZLbtOOxD0o7F
   A==;
X-CSE-ConnectionGUID: dbCem85MT3yuhGf6FW1hNQ==
X-CSE-MsgGUID: HtmCVHebRDCZ2/URso4QmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11945"; a="1501274"
X-IronPort-AV: E=Sophos;i="6.27,177,1787036400"; 
   d="scan'208";a="1501274"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 03:49:53 -0700
X-CSE-ConnectionGUID: JYgqJlDmQu+LqbHMhBjFnA==
X-CSE-MsgGUID: URc1XrjISym5V9UmBj1B9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,177,1787036400"; 
   d="scan'208";a="4005441"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 25 Oct 2026 03:49:51 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xKvnQ-00000000UjS-1aE7;
	Sun, 25 Oct 2026 10:49:48 +0000
Date: Sun, 25 Oct 2026 18:49:43 +0800
From: kernel test robot <lkp@intel.com>
To: Tristan Madani <tristmd@gmail.com>, Even Xu <even.xu@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Xinpeng Sun <xinpeng.sun@intel.com>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: Re: [PATCH] HID: intel-thc-hid: validate ACPI buffer length before
 use
Message-ID: <202610251809.9IHSydrI-lkp@intel.com>
References: <20261024205850.4051206-1-tristmd@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261024205850.4051206-1-tristmd@gmail.com>

Hi Tristan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on hid/for-next]
[also build test WARNING on linus/master v7.3 next-20261023]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tristan-Madani/HID-intel-thc-hid-validate-ACPI-buffer-length-before-use/20261024-205850
base:   https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-next
patch link:    https://lore.kernel.org/r/20261024205850.4051206-1-tristmd%40gmail.com
patch subject: [PATCH] HID: intel-thc-hid: validate ACPI buffer length before use
config: x86_64-randconfig-1003-20261025 (https://download.01.org/0day-ci/archive/20261025/202610251809.9IHSydrI-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.4.0-5) 12.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261025/202610251809.9IHSydrI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610251809.9IHSydrI-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c:66 function parameter 'buf_size' not described in 'quicki2c_acpi_get_dsm_property'
>> Warning: drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c:109 function parameter 'buf_size' not described in 'quicki2c_acpi_get_dsd_property'
>> Warning: drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c:66 function parameter 'buf_size' not described in 'quicki2c_acpi_get_dsm_property'
>> Warning: drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c:109 function parameter 'buf_size' not described in 'quicki2c_acpi_get_dsd_property'
--
>> Warning: drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c:85 function parameter 'buf_size' not described in 'thc_acpi_get_property'
>> Warning: drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c:85 function parameter 'buf_size' not described in 'thc_acpi_get_property'

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
