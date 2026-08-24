Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06D840B104;
	Mon, 24 Aug 2026 11:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787571485; cv=none; b=HvAaFUVCNcn1Pt/67jk4TO14FBmRkmG5Gm0UZmixHA+P6BUSsfOFSj61QA87A3LQGsMqFXzsGOnmtth4thYuon1R/x3ALpogg3EDc++2FNtZbI8P22H4b19Q4mQVPy2x/hVxM1pVk9zAOACdolbSRALXbpgWqkMDZ2Fx8XJZEXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787571485; c=relaxed/simple;
	bh=eaRibzZOI4YUd0JJtNw6YOBGcNU3+xlM6gRdCa+m2Qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VsA9SFi1iF5CPL8LYuh/Iowe2UR+U5kXlMIqEtPD6zmnxxWmtP1S2WUBkCwYFkGdVDEuDJK1QQxOkab2hXmIhWgxIeM0Coj0Jc9fMr/n0REjLt01rwaTXYjUrXfMaizn/cu4dfOQPuFle42mS5OcCrjrvzAyM/7y9/4vbGcUcps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aXlMMzXi; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aXlMMzXi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787571483; x=1819107483;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eaRibzZOI4YUd0JJtNw6YOBGcNU3+xlM6gRdCa+m2Qs=;
  b=aXlMMzXiQKHRNvubvjAdMnaLWbCX9pjmZi60+qAMzrKgZpGkBYUsJGhY
   oD3AYJfWRUvH+dphSuxnuu+DUOWHNyeO9u0qCWx5SZRXJnn7TboRBQRXv
   pB/8T25goCp7pndr/yaOQ0cqWsbrhkkyO6QPgcKCs0TFGpRN3+qBJ+8Qi
   SdMyAHATbXsm+SoIMH2+loAtAwG4lpWBm5QuA9jVlTT0eGRyFTz2DdCrV
   LdKuxyNyesD0gd52KcbvEa+ltDT14Sj8+Zgs0qnE9hLiDZ0evghCsfz6E
   ePVcM0IKSTorj2R2r6Zzl73t+bRn48uU6hh3yEiPWpJagb2KylJRmm+e6
   Q==;
X-CSE-ConnectionGUID: Xr/OCrlDT5WiXR9ncNPeUA==
X-CSE-MsgGUID: dF3RLXeeQGS1XygMsNUcLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="113552970"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="113552970"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 04:38:02 -0700
X-CSE-ConnectionGUID: O1u0tRQxSMKyOcwPk2GUZw==
X-CSE-MsgGUID: 1rOKWyhnR7+fhkdOnNJoIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="290500688"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa002.fm.intel.com with ESMTP; 24 Aug 2026 04:38:00 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id A77EE99; Mon, 24 Aug 2026 13:37:59 +0200 (CEST)
Date: Mon, 24 Aug 2026 13:37:59 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Sven Peter <sven@kernel.org>
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Konrad Dybcio <konradybcio@kernel.org>, asahi@lists.linux.dev,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/7] thunderbolt: Hold a router reference for each
 path hop
Message-ID: <20260824113759.GH893316@black.igk.intel.com>
References: <20260823-b4-tbt-fixes-v2-0-26a18a426c9f@kernel.org>
 <20260823-b4-tbt-fixes-v2-1-26a18a426c9f@kernel.org>
 <20260824104237.GF893316@black.igk.intel.com>
 <295cce78-47d2-4a6e-af90-696edb60a05d@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <295cce78-47d2-4a6e-af90-696edb60a05d@kernel.org>

Hi,

On Mon, Aug 24, 2026 at 01:06:12PM +0200, Sven Peter wrote:
> So unfortunately the entire USB hardware is best described as horribly
> broken :(

:-(

> For USB2 already we only ever receive a single hotplug interrupt in dwc3. If
> the first device is unplugged and another one plugged in nothing happens.
> The only way around that is to tear down dwc3/xhci and the PHY completely,
> assert all external reset lines and then bring them up again.
> Upstream drivers/usb/dwc3/dwc3-apple.c contains more details in the very
> first comment at the top.
> 
> With USB4 this gets a bit worse: There's a block called "ACIO" (Apple
> Converged I/O) which can only be brought up correctly after the PHY has been
> switched to Thunderbolt/USB4 mode. This block has a co-processor which then
> exposes the host router, NHI, IOMMU, etc. to our address space.
> We then have to write cable information into a vendor-specific capabilities
> register and only then do we get the hotplug event and the link comes up.
> This register appears to be effectively write-once after each boot of the
> co-processor. If I try to write 0 that still works but trying to write the
> value for the next connection then crashes the co-processor with a very
> helpful message along the lines of "assert 4357 violated".
> So there's no way around first tearing everything down, then shutting down
> the co-processor and the entire ACIO block and then finally bringing it all
> up again after the next cable is connected. I've tried to find ways around
> this but didn't succeed without documentation and could only reproduce what
> XNU does.

Thanks for sharing the interesting details! I totally understand the pain
of reverse engineering things. The initial USB4/TB driver was also result
of a huge reverse engineering effort by Andreas Noever, but it was and
still is functional, and we still support Apple TB1/2 hardware (although
not too much testing is done these days, I fire up my Cactus Ridge based
Mac maybe once a year).

But okay it does not sound like the PC ACPI hotplug "solution" we had at
least. It's just a much more complex subsystem with many interactions that
need to be done in certain order which is not documented anywhere ;-)
