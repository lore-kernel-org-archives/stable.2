Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974C47083C;
	Sat, 19 Sep 2026 07:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789803317; cv=none; b=kYypFOsk62zR85BDFmgeBqg/wqg0YrEpWlzQ9kq1mPSw8h3eZryew0BpG0iST/ccMYQokCxTX3Q29BBR9uRaHg7LGp6atow0sgFfUuTlRmDck4GBb4uHD6olj8eQZhe4tYYyYfDKVWJV48obHxnIQbTsbZ0c+NsN4813EjppINY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789803317; c=relaxed/simple;
	bh=XxiSV9KB15uxRCUse5WjXjM7dc35/5V4z8ZQW4Zp7c8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c6421mmvr8BCgKhpSpWmH7hmTpmvm4ZXmHe/ibyydKQklV5fJ0aqdMOXSgHMltMgUrsOBgtH+uTfapkKV+gCiM4DqPfRSwhw9hFIjd4KCD1cq92s1TTuKxqopsXGuPNqhdlfaru8B+x4KOxetsk1lQBPphtjFN0ipqIydM4PrZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BgNfBydL; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BgNfBydL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789803316; x=1821339316;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XxiSV9KB15uxRCUse5WjXjM7dc35/5V4z8ZQW4Zp7c8=;
  b=BgNfBydLE4BdrbsegmX/JR74P1UEk5Qx1dO96Sx+SDO2ug+pNB8Zd0Dq
   A/BJoSDHLg0tNLkiYfF63Nceu1+4QNZ/vyeOYHLpCi7JJjwJfEvPdojt2
   /azMdLutGlQkxSk7ErX6j0K8NlFWXGcq91HhkmcbM5GrMxcwDqrPDqFZT
   KOBBOv5jgLGER3al2I40ljHTXLDOM8l2rsu0AlhoFshh6t7ZSUMqz0T8l
   MaoYJK4JgRZ5friOwLCyRThqx3l1c0/+aeTJ67z2ie6PRNXJLlZFXkz9p
   dbzvw3fU743hUKVllS4SwDY3SxiUAf/qe1WWCTmONujUcLNw3vXITSL3P
   w==;
X-CSE-ConnectionGUID: QBgzJU9JRSyvl2hdIAa45g==
X-CSE-MsgGUID: mx/Gm1ZVSTeSuz/xKGrXzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="107842584"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="107842584"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2026 00:35:14 -0700
X-CSE-ConnectionGUID: ZLvkaXWbQ1mcTnyE200BSw==
X-CSE-MsgGUID: O9PN042rRV6YzZkAkRxv0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="298187384"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 19 Sep 2026 00:35:11 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x7pbI-00000000AjZ-3904;
	Sat, 19 Sep 2026 07:35:08 +0000
Date: Sat, 19 Sep 2026 15:34:37 +0800
From: kernel test robot <lkp@intel.com>
To: Guangshuo Li <lgs201920130244@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Sivaprakash Murugesan <sivaprak@codeaurora.org>,
	Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>,
	Govind Singh <govinds@codeaurora.org>,
	linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Guangshuo Li <lgs201920130244@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] remoteproc: qcom: q6v5-wcss: remove all subdevices on
 unbind
Message-ID: <202609191513.bywryVFw-lkp@intel.com>
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
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20260919/202609191513.bywryVFw-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 7252edd9aa82ef1c570ff6694ef7f4763a8a5d2f)
rustc: rustc 1.96.0 (ac68faa20 2026-05-25)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260919/202609191513.bywryVFw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609191513.bywryVFw-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/remoteproc/qcom_q6v5_wcss.c:1051:1: error: invalid argument type 'void' to unary expression
    1051 | +       qcom_remove_ssr_subdev(rproc, &wcss->ssr_subdev);
         | ^       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +/void +1051 drivers/remoteproc/qcom_q6v5_wcss.c

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
