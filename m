Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FF94A8A33;
	Tue, 15 Sep 2026 12:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789474672; cv=none; b=TILoVF+RnYO6Lkg0kTg+8YqLVUtgHszHTV/BxNXM99/8u+sAJydUp2oZ4ThSpepkBtg2Lm7baiv7sDDV1O/7Iuf+nYGgjYfaNlpVyQT1ZV0suHLVG47CmZRn2FJOCf0QsSPP8JrJBZ1DUd0khnwUjazy23nwX4jaL/ra7rZpOHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789474672; c=relaxed/simple;
	bh=QWIzsJE0Kai3KownbKrQWHTGaGpa7cST5QF1p4oyIVc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Dw9CF+88WHv0odmUKPucod+nyy06lS775r0dpChd8bxw7H1x2V0Wg1IaejiLfmM98Z2GZJa+1wnImEA9rX1953DGongdNBCtYKqphf86gk2lEts27DAcCWy2fJiNJwHUszEuO3oWW+qtyrX+ZuEYpVrKih077lnHHsZKPohWcTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mv+l42g+; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mv+l42g+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789474671; x=1821010671;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=QWIzsJE0Kai3KownbKrQWHTGaGpa7cST5QF1p4oyIVc=;
  b=Mv+l42g+Gg25jwIJEjupqXVPAQxbRGdPD0THbF3LaiQxmyKgTBxM3aLZ
   SrTaRkOv5kBGGAzpQFYPY7gE6MBLvoUdCcFkeAy1hatrlbR6nQiRSIi96
   0pWwvSqiYK7FAYkW/QVkpHKyYTHJLpLVDlh+5bMumkk4RBuC8VJvQQ9vu
   rAByw+RjCKGrQGZpo8JNc26oU3h5bc8K+5wiIQNmED5J394w7a7u7xqHT
   XTSo9oVCvvPl6OyJDxWCKWG/ZdmZIBvPqkhiE4BhO1tPOyQgY9VZYjhkk
   yMC9RPNSzllvDofaQ4rG4oL0OLn5hZdVq3kdQioiwboR/K6gD+2LJvgfl
   w==;
X-CSE-ConnectionGUID: rjGcIv2MQIGNPhYpMu1Rcg==
X-CSE-MsgGUID: fPMX3L7fTZ+iFVcoM8rUqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="112604460"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="112604460"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 05:17:50 -0700
X-CSE-ConnectionGUID: TnyOsk/mR3ieOxzN4m1p0g==
X-CSE-MsgGUID: 8U7stX10R/6Ese6/vpmuIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="276755304"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.24])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 05:17:47 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 15 Sep 2026 15:17:42 +0300 (EEST)
To: Ma Ke <make_ruc2021@163.com>
cc: Shyam-sundar.S-k@amd.com, Hans de Goede <hansg@kernel.org>, 
    mario.limonciello@amd.com, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, akpm@linux-foundation.org, 
    stable@vger.kernel.org
Subject: Re: [PATCH v2] platform/x86/amd/pmc: Fix RTC reference leak in
 amd_pmc_verify_czn_rtc()
In-Reply-To: <20260915120943.3988720-1-make_ruc2021@163.com>
Message-ID: <c6096e2c-0112-81d0-1940-35ba54a66305@linux.intel.com>
References: <20260915120943.3988720-1-make_ruc2021@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 15 Sep 2026, Ma Ke wrote:

> amd_pmc_verify_czn_rtc() opens the RTC with rtc_class_open(), which
> takes both a device reference and a module reference on the RTC
> driver. rtc_class_close() is the matching release, but it is not
> called.
> 
> Use a __free() to cleanup call on the declaration
> 
> Found by code review.
> 
> Fixes: 59348401ebed ("platform/x86: amd-pmc: Add special handling for timer based S0i3 wakeup")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ma Ke <make_ruc2021@163.com>
> ---
> Changes in v2:
> - modified the patch, thanks for developer's suggestions.
> ---
>  drivers/platform/x86/amd/pmc/pmc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/amd/pmc/pmc.c
> index 6792aa2c6187..b1ad79b22c07 100644
> --- a/drivers/platform/x86/amd/pmc/pmc.c
> +++ b/drivers/platform/x86/amd/pmc/pmc.c
> @@ -14,6 +14,7 @@
>  #include <linux/array_size.h>
>  #include <linux/bitfield.h>
>  #include <linux/bits.h>
> +#include <linux/cleanup.h>
>  #include <linux/debugfs.h>
>  #include <linux/delay.h>
>  #include <linux/dmi.h>
> @@ -646,9 +647,11 @@ static int amd_pmc_wa_irq1(struct amd_pmc_dev *pdev)
>  	return 0;
>  }
>  
> +DEFINE_FREE(rtc_class_close, struct rtc_device *, rtc_class_close(_T));

I'm sorry, I only now realize this is not a local thing at all so it would 
below to the header defining rtc_class_open/close().

More importantly, rtc_class_close() does not handle NULL inputs so 
this DEFINE_FREE() should have the if (_T) boilerplate.

> +
>  static int amd_pmc_verify_czn_rtc(struct amd_pmc_dev *pdev, u32 *arg)
>  {
> -	struct rtc_device *rtc_device;
> +	struct rtc_device *rtc_device __free(rtc_class_close) = NULL;

Please move this to where the actual assignment to rtc_device occurs as 
explained in the long comment in cleanup.h.

>  	time64_t then, now, duration;
>  	struct rtc_wkalrm alarm;
>  	struct rtc_time tm;
> 

-- 
 i.

