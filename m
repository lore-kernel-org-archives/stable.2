Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB198376A03;
	Sat, 19 Sep 2026 13:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789823621; cv=none; b=HJvMcqPS09aDS/xyotL3VoraNqgnoA80ZThdtl8LwlDK4p5emBEDx+2rKJ5IzWnP6cuxU85oPOikBDABLuZRBGYLhu2wUCOpwmN79qZ/8snLqjX9a1N2yMA+En89hlE9lYjJ0L/fmiNcyiQz4tGlm8gabrH458GEVqjD4VQeMZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789823621; c=relaxed/simple;
	bh=K016Xuspy0+i4gvt1BjSnZ/7rNHp4XWw8iWjdQD++EY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mGZ4FI/nR1Be9vecLEkgR28UqDSVJVnhimA5h5btIdoOmPlR269DqmnlJzoZp5exSrqvPs3ANseWM7v+yp2LmHM4DrbEmZjFk/NJb6mdLBSuRbDtjpHimjmm6jNdxB0j3B2w0EB/WY1LVVICRu8ANbR9yPm3NTn17qQkNpe9R+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aXD6mpca; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aXD6mpca"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789823620; x=1821359620;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K016Xuspy0+i4gvt1BjSnZ/7rNHp4XWw8iWjdQD++EY=;
  b=aXD6mpcagrWDyT4Eyhidxz2yYEKb2w2a2LCYiudvPJc7HpQu2edZyVnh
   sGmcIYu0px9SpAg8HIM6Waf0mlrOG9P0uecyZ97A8kHwDrDBreY5+YnQ2
   /vykwXnqLsnM3PFY7hPpA3aHmWFQvHERm+gYVSPr9I2ldU8CaQXLivkjk
   m9SehQ917AH1TBx79Wpfeo/DAsn8h7W06SoRNooTWPpE5sTWWN8b/jrHF
   VPcmYzSz4FcJvspHur2u6KLmgbHVTSELtgWndqM/WYjqjeUxoPO1X8+Q4
   LXNeyqh6YF0xdY/OKp2mC4W/gmdPkBlcZdWxxsvWG5yvoBJsSSYHjhVPQ
   w==;
X-CSE-ConnectionGUID: TrYM4lyXTl6TIhpwEPWemg==
X-CSE-MsgGUID: wvBhi80VQb+STLjWgD/4pA==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="90478348"
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; 
   d="scan'208";a="90478348"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2026 06:13:39 -0700
X-CSE-ConnectionGUID: FXgk4xsOTbyvnrr1GehSDQ==
X-CSE-MsgGUID: WhW5rkOxRee7qkVSAOOVjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; 
   d="scan'208";a="270519051"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 19 Sep 2026 06:13:37 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x7usn-00000000Aw9-4374;
	Sat, 19 Sep 2026 13:13:33 +0000
Date: Sat, 19 Sep 2026 21:13:19 +0800
From: kernel test robot <lkp@intel.com>
To: Guangshuo Li <lgs201920130244@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Sivaprakash Murugesan <sivaprak@codeaurora.org>,
	Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>,
	Govind Singh <govinds@codeaurora.org>,
	linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] remoteproc: qcom: q6v5-wcss: remove all subdevices on
 unbind
Message-ID: <202609192136.6T6AV8Dt-lkp@intel.com>
References: <20260918041321.3532355-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918041321.3532355-1-lgs201920130244@gmail.com>

Hi Guangshuo,

kernel test robot noticed the following build errors:

[auto build test ERROR on remoteproc/rproc-next]
[also build test ERROR on linus/master v7.3-rc3 next-20260918]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Guangshuo-Li/remoteproc-qcom-q6v5-wcss-remove-all-subdevices-on-unbind/20260918-121321
base:   https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git rproc-next
patch link:    https://lore.kernel.org/r/20260918041321.3532355-1-lgs201920130244%40gmail.com
patch subject: [PATCH] remoteproc: qcom: q6v5-wcss: remove all subdevices on unbind
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20260919/202609192136.6T6AV8Dt-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260919/202609192136.6T6AV8Dt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609192136.6T6AV8Dt-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/remoteproc/qcom_q6v5_wcss.c: In function 'q6v5_wcss_remove':
>> drivers/remoteproc/qcom_q6v5_wcss.c:1051:1: error: invalid use of void expression
    1051 | +       qcom_remove_ssr_subdev(rproc, &wcss->ssr_subdev);
         | ^


vim +1051 drivers/remoteproc/qcom_q6v5_wcss.c

  1039	
  1040	static void q6v5_wcss_remove(struct platform_device *pdev)
  1041	{
  1042		struct rproc *rproc = platform_get_drvdata(pdev);
  1043		struct q6v5_wcss *wcss = rproc->priv;
  1044	
  1045		rproc_del(rproc);
  1046	
  1047		qcom_q6v5_deinit(&wcss->q6v5);
  1048		qcom_remove_glink_subdev(rproc, &wcss->glink_subdev);
  1049		qcom_remove_pdm_subdev(rproc, &wcss->pdm_subdev);
  1050		qcom_remove_sysmon_subdev(wcss->sysmon);
> 1051	+	qcom_remove_ssr_subdev(rproc, &wcss->ssr_subdev);
  1052	}
  1053	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
