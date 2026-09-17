Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33AA3DAADD;
	Thu, 17 Sep 2026 15:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789657457; cv=none; b=ql5yh5Ve+QCvlt/b/WR/QEOtsFESyms52cN1kCKtB6iEvHU97o8WYi/Llohgf8C8Rznp137PHFyE8ywSWC4P+P2I1jlYATyGOx0B6DmqJLvYkGEPzaXR2FicasdIS08ggahHe0RoHG4kSHBh4OPq2R1R6S3Cy8Nbf4Gpyy36uXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789657457; c=relaxed/simple;
	bh=CR8wXOZCs8JZ4Pnv+Uc+I+9zn7iCGsN0bBlV9B5ok8E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=J2FpU5OqIzsUnIN/yvz/R1O0PRf3mDJrFBlKQ0UTQ6NYmmzSiM0R2xnqIZBWewVx80ek+ef3F0FBbqN0HrwId9miKr8L3lCJdwtltyHEda78LtcerLA2bB2lsK4SWxVj0RRUfwAelMdOPSRhXK4C8Grh1CdTz7HwHeLiPMHSGaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F6x1Rbj2; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F6x1Rbj2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789657451; x=1821193451;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=CR8wXOZCs8JZ4Pnv+Uc+I+9zn7iCGsN0bBlV9B5ok8E=;
  b=F6x1Rbj2TPGMTwXTXj4UFMibdT/PPZ24v1k0Jy89Hn7IA7G2LytlqEc4
   5oR+MKWdUjMFDQl+FqoIJoLJqDZ7LpOkf0T+3lIpFinrH+toOho7v3zgy
   70epqLT1Tu0CVdfpnrwBexpjCC3fX0ElWly7j51C6Ow90hhQSz1+sZ5rr
   u2Fyew/jA05uolfsDscPew95kQhrkz5llIWINEPLdNxWGFoINg108b+6H
   y7B8plz9p5iC1SyZ3ER07Ou4uK2PxJI2y+g4hJV8dLoWE4ld5km3djJGJ
   UdnzowmkkRqC7G4Bi5x6K7oaAibMV0fI6DEr9iApKDFw0Vo8u60ncF3tJ
   A==;
X-CSE-ConnectionGUID: v9MmZMmfRn6jh701BXvXyA==
X-CSE-MsgGUID: VSEF51IYRZuFyNClDEj9ZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="92597419"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="92597419"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 08:04:04 -0700
X-CSE-ConnectionGUID: m6SZ/YTuSO2Z4g+B6412Qg==
X-CSE-MsgGUID: wNf1l5LcQjaehTxWD8SOiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="279078492"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.62])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 08:04:01 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: platform-driver-x86@vger.kernel.org, 
 Muhammad Bilal <meatuni001@gmail.com>
Cc: jorge.lopez2@hp.com, hansg@kernel.org, linux@weissschuh.net, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260818191120.38556-1-meatuni001@gmail.com>
References: <20260818191120.38556-1-meatuni001@gmail.com>
Subject: Re: [PATCH v3 0/2] platform/x86: hp-bioscfg: fix empty auth token
 overflow and clean up audit log loop
Message-Id: <178965743658.22350.7756455850249606782.b4-ty@b4>
Date: Thu, 17 Sep 2026 18:03:56 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Wed, 19 Aug 2026 00:11:06 +0500, Muhammad Bilal wrote:

> This is v3 for the remaining two patches (patches 4 and 5) from the v2
> series [2], addressing your review feedback:
> 
> - Patch 1/2 (was patch 4 in v2): Remove the special-case "if (!authlen)"
>   return entirely in hp_calculate_security_buffer(). The generic
>   calculation already naturally yields 20 bytes for empty strings,
>   eliminating duplicate logic and fixing the 16-byte heap overflow
>   (reported earlier by Josh Snyder [3]).
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
[1/2] platform/x86: hp-bioscfg: fix 16-byte heap overflow for empty auth token
      commit: 5714a846afa8d7b8363aa134d4acbd129f68d049
[2/2] platform/x86: hp-bioscfg: remove dead bounds check in audit_log_entries_show
      (no commit info)

--
 i.

