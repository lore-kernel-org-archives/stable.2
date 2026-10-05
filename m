Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94B24BE43A;
	Mon,  5 Oct 2026 15:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791214665; cv=none; b=EUFOEZ7m5yTl2An2ShifBVGf3/VYoBU1kThuihS7JKdh6uDyyH9pMfayS5vlqOgWdm0ThOPaYW2od0J84VChLuKv47ke793vjxp26Ia1y94C6hJZObB3k04tUDxF/l3FKhobj3wzJwJkdFnGBR2BDt1OxzHUgAq+LbHxKaSVqKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791214665; c=relaxed/simple;
	bh=1sCao4d2Tir93W/YfSldO/yQJrDkaT5vlxVSGtUblcg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=m+vsm6XS+lbjBnHFlpjK579P/kLyah1j+d711DbcI7bGUKEHfjoZZNI+saFjXOSmVCqHLx/ZXzlsxjffKbskGMhpRmBJNlYlklUFGK3sDgnZfMCImfoaWo0DMMfp6fJbbVl1bm4n3zGhr+M6BbXhSFvrDtvGlTXkFdFMaD6qg+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mp47QITc; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mp47QITc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791214663; x=1822750663;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=1sCao4d2Tir93W/YfSldO/yQJrDkaT5vlxVSGtUblcg=;
  b=Mp47QITc6H49dZhp+Eg81j2V6SnRVLMd73/UnmzfKs1q3GLOBc3y0V0P
   Q9zdXScMDUbOn8Sq2xNoZ64upUa/TERGqFn1jD3NHTNE0M7Yv9k/DO7SL
   F7TaqBm45vaWlTciRyZF8URgryql+HoEpMDP5t0iw2qu1Ie+uQl2hMKDp
   GKDJ0s0ezqBjzhvR2P44bjzYbN6mC5IkgOpTwK4X3ebhyNSBc1UdwMWor
   GlUcgLngCCf0+mguebL8ggqzClSxhHGg8I8rYY3t58Th1PuB3GafOq12b
   vji/vS4DN3qRXjrOFxDS4N4Fxb+xQQhbUmEOMYDImzR1pZN47Z95HHkfs
   Q==;
X-CSE-ConnectionGUID: 6nHWYQigTj+zjHsbY3pW+g==
X-CSE-MsgGUID: a9o1TIniRyiuU/876paKBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="91995649"
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="91995649"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 08:37:39 -0700
X-CSE-ConnectionGUID: bG26QZYcRY+nZVN7Z9qM3A==
X-CSE-MsgGUID: keGBikKiSceyD6+mSsm5rQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="873971"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.199])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 08:37:37 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Jorge Lopez <jorge.lopez2@hp.com>, Hans de Goede <hansg@kernel.org>, 
 Muhammad Bilal <meatuni001@gmail.com>
Cc: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260919061108.87240-1-meatuni001@gmail.com>
References: <20260919061108.87240-1-meatuni001@gmail.com>
Subject: Re: [PATCH v3] platform/x86: hp-bioscfg: remove dead bounds check
 in audit_log_entries_show
Message-Id: <179121465285.12659.11452762308819122949.b4-ty@b4>
Date: Mon, 05 Oct 2026 18:37:32 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Sat, 19 Sep 2026 11:11:08 +0500, Muhammad Bilal wrote:

> audit_log_entries_show() checks "count * LOG_ENTRY_SIZE > PAGE_SIZE"
> prior to entering the loop. Because "count" is already bounded to fit
> within PAGE_SIZE, the inner loop check "(LOG_ENTRY_SIZE * i) > PAGE_SIZE"
> can never be reached and is dead code.
> 
> Remove the redundant inner bounds check and eliminate the unnecessary
> "else" block after "break" to clean up the loop control flow.
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
[1/1] platform/x86: hp-bioscfg: remove dead bounds check in audit_log_entries_show
      commit: c0c6999b8cff6fbb8b2511b37e74a03a2538e260

--
 i.

