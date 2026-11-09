Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794253186;
	b=ZPicfuMQFM8Y3P0GkzGZYBdXMs7WwTpfLKez71iusTjR+JWyaqE21YdVGsyRmGwuQqo9
	 l8/MsCGCsS26RhN00Z3TovbVFod8OmOEhDMjuijMatSpD+yygynGZX9M9rvXAv7arWgs9
	 q4E6TyCyFKBIDlj5lJq+4eASAjau2ioNxPkSEA4w97cGzdDE5n8CHkivR4IXbjRDGqwqn
	 3g8t0HyQDjxMQbC7jUb9d4BS3J2sE3sUZEuqsCyqXRmV/WNXUN+zsWq3hXSBs3QxOwr68
	 daiTe6tV8/5INh7wb4OP+JiedsvtDjP8UkAvIOMDLmnRXAcaX+oaXnZRTt6VB8U7e7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253186;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:
	 In-Reply-To:References:Subject:Message-Id:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=ZdfTvhaFlxAY9qhVTuH7nBLLFVv4E+4zk2xSljCVV40=;
	b=pGLI6xH9abst5UHSHt/c2cSmSPtwPGWOS72F+Lubnvav5qCYOw26FxOG61veyAuMfVib
	 eytUOjuV5opqb/AhVxgBQuqJO6cbc9HRF7R0o/wEIeCQ8zrhaSYeHT5lDMB2AbAol52tB
	 CNxE3fmCKLhlmR+SJGRj+LaTg8S4UamEGmLAW4dckRmfvwjLAtdE2k5Nj0ObsN/Wj1ZKt
	 qSUcw3GDt535mXFWU+qZgjs+6f2b5k4Kne/kPIvA92M+NnEICK5yL/6oa8W1RaEbdV7KC
	 MxJ7noleoBX0+cje0CuDlWGhPzq+A2mRzMc4w7pzafv3sJbQXmpCk1IgFrOUt2jkKWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ExH28ikV;
	arc=none smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1EF60A2625;
	Mon,  9 Nov 2026 19:39:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB1EF60A2625
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ExH28ikV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794253186; x=1825789186;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=R9CNjeY4WdqHEnSJpOsePk/kYnW5XVOT/Y1CPn0j0+8=;
  b=ExH28ikVBODjUzLTLCi4+L+m92jqMOGIERTHH6HZBaJHgUe88ghkH4Iy
   5byEBdMw/Ilzo1aElEcAI6QoyVnhSlTZ4cf9Kn99Zcsnwpzqr7QMFZ91L
   Zb3E5WcFwzizVa9oXbdgVW1eBpJG2qkRURI0fqiP3BVddVDV3+XLCoS5L
   5XxR6nPW6kgqFPbJJIZcaEihUOO35YU/bRp8MtjfUAevBK91LJGowmWhn
   DiujQ4kMHVH2yO1+whindySxjgOFyKzl2GRPwIQ2fICHO1ggDulXx32/K
   3ui5LAImC7iLKHNVTsp1iEtThfcnUdKjm7C7ngrQR3f/RwJAsk+xtHH/1
   A==;
X-CSE-ConnectionGUID: pZmhbkqYQca0o2/hPowfyQ==
X-CSE-MsgGUID: DJEVhs6pSumOwQtj09CqGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2867506"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2867506"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 11:39:45 -0800
X-CSE-ConnectionGUID: skpbr71QQWCguv3nLbHeeQ==
X-CSE-MsgGUID: hGGfGgpdT7iVxh/loHRE3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="9727682"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.139])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 11:39:42 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: jorge.lopez2@hp.com, hansg@kernel.org, 
 Muhammad Bilal <meatuni001@gmail.com>
Cc: andriy.shevchenko@linux.intel.com, linux@weissschuh.net, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20261026051740.88791-1-meatuni001@gmail.com>
References: <20261026051740.88791-1-meatuni001@gmail.com>
Subject: Re: [PATCH v8] platform/x86: hp-bioscfg: fix heap OOB in
 hp_enforce_single_line_input()
Message-Id: <179425317709.10927.8604237354153885108.b4-ty@b4>
Date: Mon, 09 Nov 2026 21:39:37 +0200
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

On Mon, 26 Oct 2026 10:17:40 +0500, Muhammad Bilal wrote:

> The input is copied with kstrdup(), which stops at the first NUL, but
> the full write size is passed to hp_enforce_single_line_input(). With
> an embedded NUL the helper reads, and can write one byte, past the
> copy. Use strnchrnul() so the scan stops at the first NUL, and return
> -EINVAL for a NUL or newline before the last byte.
> 
> Tested on HP EliteBook 840 G2 (Fedora 44, Linux 7.2.8): writing "A\0"
> followed by 4093 bytes of "B" to current_password 100 times returns
> -EINVAL every time, without reading into the heap.
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
[1/1] platform/x86: hp-bioscfg: fix heap OOB in hp_enforce_single_line_input()
      commit: e7cf4282a8694f14eb44a2f110c7628a161e9692

--
 i.

