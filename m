Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795104130;
	b=QC0QnJ37gqtGUtTBM9pafz/AHNyABkO8fJaSPLoNsnlphKNGR7G21PWuHerS0Xp8TBaH
	 Bs4vRizB1NwEh3NXBF5Pq7jK+mZQZM0eDXO833U0kNGx3Oq7/07uInl014UXaQxFMj0pO
	 581ApIorqGtpAobM+cAKlbS4NsvdcfyYNaYyUvuiOqpETTP8sR5iqEJRDisTq6SsNxjis
	 W07K8uaPce2h7U7oXzeW02LSb84PuNKsK3+kaAwIEgPZLKf9FJJKRSklVZCxxY/FWxlhM
	 sLZ513tyouCwITr14xgsns+y0QuN2iB73vKq2o7Dn2pkB2htapo4t6dD0qh+Cd4zQ0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795104130;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:
	 In-Reply-To:References:Subject:Message-Id:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=jwti4s5rITv8xU0s69yI5rBwfOqDxIGRtEOMN/ujo+k=;
	b=gQCugkaFSRdpvggtJyU0R2hnWySrus8OwHNbKSx0CFKv2+Hy0VVi9yxeWOm2cWIxXSa7
	 AmyRYr93P821HBjBSwScQz+3Tnc0ApUrzBRscx/M3fGNPLG6In8SpcX5vp0TjRm85pGzI
	 0mF3ZldUMg98hXQdSktK1PlkWwmjNPWw77tIA0RWTk34QjuwXKatekqu7Tb3xs8a8UHpw
	 AcU5LuTn6ZFEQKQaWLhoxPOpYJHmugKyz5JrbAdb7hP7eJOntww7GmZEsR8zge0DJa3Mk
	 XgmlzP4sjaWW3jqGCJ4OQ34Bjx4MBglSb3AAs+Rk1ZMVr4r8Q612fGfmWpsIObQFnQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=f7qFXtRN;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D73D606A331;
	Thu, 19 Nov 2026 16:02:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D73D606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=f7qFXtRN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795104129; x=1826640129;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=tnVEEQtn6BF+eiDIsVITBHXOFEqTebTSJBmNrc5ej3E=;
  b=f7qFXtRNyp2BfBRjCpTciMLnLHQ8KN0NFDTTTTP5hWrdz5uznaE5YWxC
   IwCfASBT0VcMVVeGCYmQphbzSWaW4aoegAy1HsMzf9GEM6lDlL2KtV52o
   zKlzFqQGAjP28fAhQRp8Bx1YfZXoqeI7vCWYhPoLabfuaSQlMPCLcIclZ
   C7HhZRWo5a9KD0vrpXYLZFVF1eMxEt/Er24fjk8y0mW5ADZRain/dYV2e
   yJKb4Y4ZVtgLavrGgoLQ1GLqfVHUjX9u7AJjYTwAYYZPgYmKCsuoWkR3e
   ZUUKfOwnJGkb3/0PRzfpBgP4yohMcMN5zyJYXOqsCxbZ5lr/m7Iu2D0AK
   A==;
X-CSE-ConnectionGUID: 2isjHS/WTpmJokZmXx8rCw==
X-CSE-MsgGUID: VTUMtJA+Th+TEX4mrwM4Eg==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3803245"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="3803245"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 08:02:09 -0800
X-CSE-ConnectionGUID: BwhIC+gSQ+GTzgLYtRLX4g==
X-CSE-MsgGUID: m4pZe/h2QtO88atbIbPl3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="10590988"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.132])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 08:02:05 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
 Hans de Goede <hansg@kernel.org>, 
 Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>, 
 Sanket Goswami <Sanket.Goswami@amd.com>, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20261102053503.102598-1-christian.aurichzm@gmail.com>
References: <20261102053503.102598-1-christian.aurichzm@gmail.com>
Subject: Re: [PATCH] platform/x86/amd/pmc: Fix S2D message ID on Rembrandt
Message-Id: <179510411959.21358.4834449524709551919.b4-ty@b4>
Date: Thu, 19 Nov 2026 18:01:59 +0200
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Mon, 02 Nov 2026 02:35:02 -0300, Christian Aurich Zanettini Martins wrote:

> Commit 382fe403dc31 ("platform/x86/amd/pmc: Add STB support for AMD
> Desktop variants") added S2D message ID 0x9B for Granite Ridge (family
> 1Ah, model 44h), but only checks the model. Rembrandt is family 19h,
> model 44h and goes through the same AMD_CPU_ID_YC case, so it sends 0x9B
> instead of 0xBE. The firmware then reports a telemetry size of 1 instead
> of 0x100000 and amd_stb_s2d_init() fails with -EIO.
> 
> [...]

Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

FYI [if applicable to your patch], as per Linus' policy change, also
fixes are mostly routed through for-next unless the fix is for a
commit introduced in the most recent cycle or is clearly a regression
fix.

The list of commits applied:
[1/1] platform/x86/amd/pmc: Fix S2D message ID on Rembrandt
      commit: 918b3cafc1eeda758a21b1a21c6517722a4a6f94

--
 i.

