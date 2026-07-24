Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9F5372663;
	Fri, 24 Jul 2026 15:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784907876; cv=none; b=ZciOlCBYLrjwIxctk36kQireOzKOb1CnI3crEXlYeR+e4tpaFPu9a6ySwlcL3c1ICCRTiqVjuCR67KKUFmZhhK/oGVIMleZqfTU7mzQx6EpPGHGYeAK9lgnD8h7QzbyutYccd2AQK/2cm82VQdM44Fte5F53IiP0A7Wq9cSEv/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784907876; c=relaxed/simple;
	bh=ASZ2VW1P7ycIu8Nkxkio47CE4/4WpGf7NfU9mkelfVI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Gh4YyoAnfYnmxss52Op7jDUJFU9Mqbc1tmnJkwoeJIhDFC27ItsAg1SEZPKe742A/vtLgFb8IchQCiZJa1MMA8FcZUZ14MoB73Vvf27bn5xhMK9fDFaGB6/TOEAyLWvWRyN2OTPCvhvoWCB9/PA73sW+4AD09ts/Qa7600roY8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XnVt+/b1; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XnVt+/b1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784907875; x=1816443875;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=ASZ2VW1P7ycIu8Nkxkio47CE4/4WpGf7NfU9mkelfVI=;
  b=XnVt+/b1dgySLf9ZHfOgLZr+u8WFZ8/AQfwpeA0vfihw6/qH6BuxqE0/
   4oJ20p8OqzU3UgGETGp7wT9HpiuYliGXwcoXFJHNEGMPGU2xnZCDT2Njm
   fIZEq7qjFXuYg7nSTD5zwe503+WFu0pvb9uEHldCWtGS2zyWPEwdcpX79
   JY95xvPU6wlzv4zRktagTx0pn2uUzj3bsVvUu3i5KNOCdZYwRPRjc5qus
   S/J1MaHuvB2HuUrEmB0uSdInMjyqjuLWLwwKTJJAHZjzNEKsSGcmEHCQy
   o511eIEBFEmsovcSBciyNtWx61SPlsR0V3iHNWU7g49UkVqRFggo4abID
   w==;
X-CSE-ConnectionGUID: +nKHzO/fSLSXLKSgEDjGgQ==
X-CSE-MsgGUID: 740tNe17QQW2D/2GZCwJRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="102985981"
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; 
   d="scan'208";a="102985981"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 08:44:35 -0700
X-CSE-ConnectionGUID: fZimFD8gTgi/bp/7nd9JSA==
X-CSE-MsgGUID: +5Wyr5JlSIqyJMypj0PaRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; 
   d="scan'208";a="263053689"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.8])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 08:44:32 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Shravan Sudhakar <s.shravan@intel.com>, 
 Hans de Goede <hansg@kernel.org>, Abdun Nihaal <nihaal@cse.iitm.ac.in>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
In-Reply-To: <20260723-platx86-v4-0-93b4a178b595@cse.iitm.ac.in>
References: <20260723-platx86-v4-0-93b4a178b595@cse.iitm.ac.in>
Subject: Re: [PATCH v4 0/2] platform/x86: int1092: Fix two bugs in SAR
 driver
Message-Id: <178490786733.16604.4329926433327066711.b4-ty@b4>
Date: Fri, 24 Jul 2026 18:44:27 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Thu, 23 Jul 2026 18:14:14 +0530, Abdun Nihaal wrote:

> The patchset includes two fixes for
> - a potential memory leak in sar_probe()
> - an information leak in parse_package()
> 
> Both patches are compile tested only.
> 
> v2->v3:
> - Converted into a patch set with two patches
> v3->v4:
> - Updated commit message of the info leak patch to include the path in
>   which kernel memory leaks.
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
[1/2] platform/x86: int1092: Fix potential memory leak in sar_probe()
      commit: 30c906cff490c3601ee9ff110fe8115fabe75fd4
[2/2] platform/x86: int1092: Fix info leak in parse_package()
      commit: f5eb833730c071b68a68de5d1df442aae4ae7e6e

--
 i.

