Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D4F4499BC;
	Fri, 10 Jul 2026 10:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783678880; cv=none; b=f+lgoPUs5Bgk7zaC023xNeW8e+JmtJn6G7TThpHzJh4vlKEb4v2IPUYSqMLZXo/+shf2zONL7trKWnMcFuVZvGi9xRK4uKVlh2nuB5x7v5E5sFIpCIO/ea3jx5ktWFJdc0WfzdYs6vCcmZY9RuUmsNHVVbnqb9HP9Jjkr1CFZ1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783678880; c=relaxed/simple;
	bh=1gTQiZ0MTLnd6P5ISYi16K6Kz6Bd3GlOcrhXJ2nU/bI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IauaivFP2157PumEnF71sjA5fDU4Z5ldfcqMn/oChkAf2kICZK2Ia/LkPLVbOUv/rOK2r6KgKr9oAj+aGJbOtB6Szp+ts6spMDfzsGjpgJsi+iMX7SVCtJrow8mVaVMVkc2T++NBj5dwRETZBYmRdMUifxXQT/yIKOS4kiISkic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IWGjlrJc; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IWGjlrJc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783678878; x=1815214878;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=1gTQiZ0MTLnd6P5ISYi16K6Kz6Bd3GlOcrhXJ2nU/bI=;
  b=IWGjlrJc7IgvF1+6ymqzkjM/ykdLyv5rIToEldxknGvmlK4a7jT5XHb3
   FG71cvmTvNtnptvZpVRr0FoE78Qt/7XeN7sQsF283EFvMFXrmayMbSXIa
   MZrDFpOfeHM07p/fPLGkzAx7q4gHJwlO8GTTI9EMmX3ZBC8em+1KDA5qm
   hIDUdP3Sv3RnAP608U4jBLTYI9kTqjlFyU7ODd9a41VQlQqkDjDqwwIm8
   K67C6Wa+OlXcYQlnrtyC+C+k+pMC4JFgcOnJRjZ3kzNONdkzh1m1NdNt4
   8rYMypupeessmyyBpliLVPxW/hFhYJn9DbGy+Wyi1nhblXaKk309g6Y1v
   g==;
X-CSE-ConnectionGUID: qeYJCHpgRMu4MtKFTiRU8g==
X-CSE-MsgGUID: YP1jYl81RkyeBuTQktbkZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="95530320"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="95530320"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 03:21:18 -0700
X-CSE-ConnectionGUID: fbgOdFGDRQO/iFhUXkNFYQ==
X-CSE-MsgGUID: ObqeLwiRR8uV4SXfLT92Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="278091891"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.169])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 03:21:14 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Hans de Goede <hansg@kernel.org>, Jorge Lopez <jorge.lopez2@hp.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Muhammad Bilal <meatuni001@gmail.com>
Cc: stable@vger.kernel.org, Mario Limonciello <superm1@kernel.org>, 
 Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20260709165900.30615-1-meatuni001@gmail.com>
References: <20260709165900.30615-1-meatuni001@gmail.com>
Subject: Re: [PATCH v5 0/4] platform/x86: hp-bioscfg: fix ACPI package
 handling on HP EliteBook 840 G2
Message-Id: <178367886982.11425.4709395984940191818.b4-ty@b4>
Date: Fri, 10 Jul 2026 13:21:09 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Thu, 09 Jul 2026 21:58:55 +0500, Muhammad Bilal wrote:

> This series fixes attribute enumeration failures on the HP EliteBook 840
> G2 (BIOS M71 Ver. 01.31), whose BIOS returns shorter ACPI WMI packages
> than hp_init_bios_package_attribute() currently accepts, plus occasional
> type-mismatched elements after a failed WMI query.
> 
> Patches 1 and 2 are prerequisites: they make each per-type parser bound
> itself on the real, validated package count instead of an incorrect value
> derived from the NAME string's length. Both are no-ops today, since
> every package the driver currently handles already meets the old
> minimum size. They matter because patch 3 depends on them: once the
> minimum size check is relaxed, the elements array can genuinely be
> smaller than a parser's fixed per-type count, and without patches 1 and
> 2 this would result in an out-of-bounds heap read.
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
[1/4] platform/x86: hp-bioscfg: pass validated element count to package parsers
      commit: e0ddfd77c0c320b7d12b6c9169303b140b798775
[2/4] platform/x86: hp-bioscfg: bound ordered-list parsing by the package count
      commit: 1d143d78299d0eb4536698bf98c1815ec69f22a9
[3/4] platform/x86: hp-bioscfg: accept reduced ACPI packages from older HP BIOS
      commit: 40e10e6cc8f70c041431a1e30186807e28ec46e0
[4/4] platform/x86: hp-bioscfg: warn on element type mismatch instead of failing
      commit: b0e2af3ec94e0431adb59d9f249ebbd3b7285158

--
 i.

