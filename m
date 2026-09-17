Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E794D955E;
	Thu, 17 Sep 2026 11:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789645726; cv=none; b=XWhudoDAmJyd0LdII9oQOPeEbo0m1rsI7Q0C+MVDZX1GvrAjQsUpBkXCCvb7lOmlA6TrDzhlL1Mph77g/QsIFcJx7X6LXbM6jvZROdGd31vNVmNrmgPBBXmxPNGGfsQdV/AgX0OdCfrtsbswzIBvTHR6KSuDjc/ooKofK+bUHQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789645726; c=relaxed/simple;
	bh=oIPgUxwSIorXzoJrCau0WJycmLIK5xU1/WW6WAWA7og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kk/Mc162pl2n6eQVWv8c0Ruur6Z6FGV77Uh7BQnWbkSC8wOdA3M+TOPvIcFUsvGo5ZplKOTBcfK1p8vVlvVCg9as6Qv/vEyjq8AWbWgTDf8muh0GhYGPmbxW2w5iHsdRD8lNNUtcbygrY/+CGMAFu+YWyuq7cw8BRfDWF4ZE9kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g1WwyFp5; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g1WwyFp5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789645723; x=1821181723;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=oIPgUxwSIorXzoJrCau0WJycmLIK5xU1/WW6WAWA7og=;
  b=g1WwyFp5gq74Su8TRDKTFizE142YTsdWZ4i8GSz5Cl2+BqoghhDdn/Md
   tFi9qHqTLfWNNNK1YU+Q0btocy5VpYRtuoYiempcAcN2B8eZ9KSZRNfMD
   dNpbVjeM+2HeLjuMfa7Na0x2Py0ocBxZEEAf5l77bp/w83IjN2yKk9p6R
   omrVdCngxVFGXZJtaEL6ybrZgjhhgAUKCY0a0ElFPvIs2oEoNyTRGsovr
   SaHuH+0dxUlTe0X5yeQy8jqON1Xgt1Kcgeo+jicuWDYvuLBCeRpo+Tt8s
   6N4H4yyz/R0iswhgc4mQXeixI9nQYKIBgghf6IuLwQcHWLCujN03bngqY
   g==;
X-CSE-ConnectionGUID: B6JH/0WsQAao3+Lt7um29w==
X-CSE-MsgGUID: Ayrrg/xbQFq3HG++YP/BLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="90076027"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="90076027"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 04:48:42 -0700
X-CSE-ConnectionGUID: hhKhDru7R2arnMNkk5CEVw==
X-CSE-MsgGUID: 3k1AwqgbTDes8po5vElcRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="270441041"
Received: from alekseim-mobl.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.32])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 04:48:39 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 2791911FB34;
	Thu, 17 Sep 2026 14:48:36 +0300 (EEST)
Date: Thu, 17 Sep 2026 14:48:36 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Junjie Cao <junjie.cao@intel.com>
Cc: Miguel Vadillo <miguel.vadillo@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Manuel Knitza <manuel.knitza@googlemail.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Antti Laakso <antti.laakso@linux.intel.com>,
	Mehdi Djait <mehdi.djait@linux.intel.com>,
	linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH] media: i2c: cvs: Do not hide the option in the ancillary
 menu
Message-ID: <aqvTlNnMw4FRqom_@kekkonen.localdomain>
References: <20260913125345.588586-1-junjie.cao@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260913125345.588586-1-junjie.cao@intel.com>

Hi Junjie,

Thanks for the patch.

On Sun, Sep 13, 2026 at 08:53:45PM +0800, Junjie Cao wrote:
> A camera behind a CVS device needs intel_cvs bound: since commit
> c28527ce5d06 ("ACPI: scan: Honor _DEP for Intel CVS devices") the
> sensor is not enumerated until the driver's probe clears the _DEP, and
> since commit c6b1b34b5090 ("media: pci: intel: Add CVS support for IPU
> bridge driver") the IPU notifier waits for the "Intel CVS" sub-device.
> The option is sourced from the "Miscellaneous helper chips" menu, which
> MEDIA_HIDE_ANCILLARY_SUBDRV hides on any config with
> MEDIA_SUBDRV_AUTOSELECT=y and neither EXPERT nor COMPILE_TEST, and
> nothing selects or implies it, so olddefconfig on such a config does
> not write the symbol out at all.
> 
> Arch Linux's config.x86_64 for 7.2.4 is one: I2C, ACPI, VIDEO_DEV=m,
> IPU_BRIDGE=m, INTEL_VSC=m, VIDEO_INTEL_IPU6=m, VIDEO_INTEL_IPU7=m and
> no VIDEO_INTEL_CVS line. On such a kernel a Panther Lake laptop has
> either no CVS driver, so the sensor is never enumerated, or the
> out-of-tree intel_cvs from intel/vision-drivers, which registers no
> sub-device; the second Link shows the IPU notifier pending on
> INTC10E1-0/port@1/endpoint@0 on such a kernel. Both reports had a
> working camera on 7.1.
> 
> Source the Kconfig from drivers/media/pci/intel/ next to INTEL_VSC and
> imply it from the IPU6 and IPU7 drivers, which are the IPUs the driver
> looks for, so that a config that has them picks up intel_cvs=m on the
> next olddefconfig.
> 
> Fixes: 8e2b43d2c10b ("media: i2c: cvs: Add driver of Intel Computer Vision Sensing Controller(CVS)")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/linux-media/20260912185836.309071-1-manuel.knitza@googlemail.com/
> Link: https://github.com/omacom/omarchy/issues/10948
> Signed-off-by: Junjie Cao <junjie.cao@intel.com>

I agree there's a problem here with Kconfig but I don't think this is a
proper fix for it: CVS is clearly an I²C device and unrelated to IPU6 as
such. (Well, you could claim this about IVSC, too, but we don't have MEI
directory under media tree.)

I any case I think the MEDIA_HIDE_ANCILLARY_SUBDRV option should go; it
hides configuration options that should be selected for most distribution
kernels while "autoselecting" the necessary drivers appears to be helpful
while actually just selecting those that are mounted on actual devices,
e.g. PCI cards.

I'll post a patch for this.

-- 
Kind regards,

Sakari Ailus
