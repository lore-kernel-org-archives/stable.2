Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684F53B0AF3;
	Thu,  8 Oct 2026 17:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791481047; cv=none; b=UGXdgIRPOaQVNn6c+EhKDptjQWeNYDKej+K6LVMP7xlP2NOCzmdMFq+y2dg4FTBCSajtlhffwx2q74YKVUxPJkf4Ih+Fg9fvftFMR1dnixdaH1nSGCzdrvhr6WN22Ex8LqTphUKflOf5Mh43lq8v8bKoYRG+KYMjbyAkSQJuFXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791481047; c=relaxed/simple;
	bh=C8FRc21ToLgly1zNs9iWthM1k4vpySfouYPYFYaPMGM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DhyS/IL7KKWCnKPCptLykpWVAMKd9L0sSAyRYYDup0PdEfRlLV5oFV2chXwqShSu9+6nfaskyn5Ugj6GSlwStYfciiH91K9bx1vlrq34TTWOLq9CuJ9hHUxlBvxRytYG3zJ3idCxcTZHFUwuYRi3s9SUnyyPOKaNsRfhkqS/pBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iZZ2WSdm; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iZZ2WSdm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791481045; x=1823017045;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=C8FRc21ToLgly1zNs9iWthM1k4vpySfouYPYFYaPMGM=;
  b=iZZ2WSdmMmFbet9LIiVqxl3QCbF55zs6kt+lirIC9WDebOKVJhLzCgYF
   siYjlDGStJIYO8E488kCrRYOxN8Qqvz9bEBUfkcZ9JQDjyWVvZkl29cyJ
   gSZcdx5bZt8NuSqENpGOMiUhd1VLPHL+loBRWQRniQHjq3eR7fO4bFrcm
   Y41VWiwzUPd1NVj55MNZWAJ4gt7IMVXves+PCGC61VJvGQkySZEXdtiQN
   bhAFJS+RwueRM4YoZfyBGI8rhGzl4CItZK3Ajw/7BydBHV3OkIQSGr0Fh
   3MZlitK9d2xjP/nt6JpwmgCXJDyv/aLusNinaWGzgoEfXnA5F0bjEnTVn
   w==;
X-CSE-ConnectionGUID: LMvarR/rT76ccRVcN1BBRQ==
X-CSE-MsgGUID: NufcZBRyR1OUh1cAJNoByQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="299262"
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="299262"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 10:37:24 -0700
X-CSE-ConnectionGUID: V+MbeSriQASe12lD8KZKkA==
X-CSE-MsgGUID: JyHZm77+SXiBx3I3152h2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="428718"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.140])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 10:37:22 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>, 
 Perry Yuan <perry.yuan@amd.com>, Hans de Goede <hansg@kernel.org>, 
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
 "Borislav Petkov (AMD)" <bp@alien8.de>, platform-driver-x86@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Guangshuo Li <lgs201920130244@gmail.com>
Cc: stable@vger.kernel.org
In-Reply-To: <20260921082609.244774-1-lgs201920130244@gmail.com>
References: <20260921082609.244774-1-lgs201920130244@gmail.com>
Subject: Re: [PATCH] platform/x86/amd/hfi: fix platform device leak on init
 failure
Message-Id: <179148103665.29028.12297507526234628809.b4-ty@b4>
Date: Thu, 08 Oct 2026 20:37:16 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Mon, 21 Sep 2026 16:26:09 +0800, Guangshuo Li wrote:

> amd_hfi_init() registers the HFI platform device before registering
> the platform driver. If platform_driver_register() fails, the function
> returns the error without unregistering the already registered platform
> device.
> 
> Since the failed init path does not run amd_hfi_exit(), the platform
> device remains registered and its reference is never dropped, preventing
> the associated platform object from being released.
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
[1/1] platform/x86/amd/hfi: fix platform device leak on init failure
      commit: a15d58ff15a6ede327e3814c791c6912b973e434

--
 i.

