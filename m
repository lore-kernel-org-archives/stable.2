Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7520151E43C;
	Fri, 18 Sep 2026 18:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789756018; cv=none; b=kUXUiOzpjRMz9UydsqVvVM+iIto0pBfctRMNb4YpN2u2SmX8J4sdPV/+WoTfggkRvH7dhYkGKW31I4bM3JviQpUQyIxjHoKqMtZ174Bjtw67ril/x7KAf4twenex2LQYTzudVv76RfNwJhfF/1VK1ah3Ga5IduTlkaSgdxGGUww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789756018; c=relaxed/simple;
	bh=EdDDaOd9GbyFbBr3QKGXD3hrM6xggMfEAHFpUFaDOUI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HHRirBoaHh8ThLqNqnjg0SJA/4yb3seAIm9esi8uvUU6ADIWRm45PIDQfGQROqp+jVdEgXUbFQ5qSCJVsKDMMB3nAY2oPLCNMPZjaTbSkR1hFROAZrqVI4FYHEDjP+D/W0+cyfMlmQsEH4gWK/qRTySqW2Gr9M2G1jBNcOc179k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z7Ym4ka7; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z7Ym4ka7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789756017; x=1821292017;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=EdDDaOd9GbyFbBr3QKGXD3hrM6xggMfEAHFpUFaDOUI=;
  b=Z7Ym4ka7v3JuQz4FqPCUtOkL0N5lzDHQiP85guB5nDC4HjBVWiSgazca
   dtoWlU6d+FEh/Ec/Q7wmlptrd6Tj0ZOvC6lf5aQFso/5Gq3Zy2a46L5vX
   2wZI0GGSkqnvWBc9R4GA0/YcZAlX3/ZU6FuDtPN3xXcXn2syppSYxU9SW
   hr8aFFBV5Gs+Gi+Z4Cw3ikgfniY22/CtH2m8fGM6BACtL0gQuRjQ1Qa6o
   4mXZSrLx4erer5g30LHK9QyHdhp5hoHQtY9sf4WbDErhlu8W6jFZTI7JJ
   SaVQPBUc9p7AW5TnjRD94AK5RekK3YWUAjLRX0t7agroRCMqdrgb5Jd5t
   Q==;
X-CSE-ConnectionGUID: OWStUqmZRmifhUuB+jKHSw==
X-CSE-MsgGUID: /OdzSkl1T1KC6fk3yNDLCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="100881109"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="100881109"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 11:26:56 -0700
X-CSE-ConnectionGUID: eSkCg5ZwSsSM6kFVIHTdnQ==
X-CSE-MsgGUID: nL3UIVrSStWceniEGEzHgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="276499396"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.223])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 11:26:54 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Shyam-sundar.S-k@amd.com, hansg@kernel.org, 
 Mario Limonciello <mario.limonciello@amd.com>
Cc: Daniel Gibson <daniel@gibson.sh>, stable@vger.kernel.org, 
 platform-driver-x86@vger.kernel.org
In-Reply-To: <20260914141734.2703545-1-mario.limonciello@amd.com>
References: <20260914141734.2703545-1-mario.limonciello@amd.com>
Subject: Re: [PATCH] platform/x86/amd: Stop counting intermediate cycles
 with metrics table
Message-Id: <178975600590.29716.14404803961111316143.b4-ty@b4>
Date: Fri, 18 Sep 2026 21:26:45 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Mon, 14 Sep 2026 09:17:32 -0500, Mario Limonciello wrote:

> The metrics table doesn't increment for all cases that can cause an
> intermediate wakeup if the cycle is very fast.  This can make the intent
> from commit 9f5595d5f03fd ("platform/x86/amd: pmc: Require at least 2.5
> seconds between HW sleep cycles") not work properly.
> 
> That commit originally was measured to work properly, but it was
> accidental due to a logic error.  The logic error was fixed in
> commit 4dbd11796f3a8 ("platform/x86/amd: pmc: Clear metrics table at
> start of cycle") but this now masked the table doesn't always update.
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
[1/1] platform/x86/amd: Stop counting intermediate cycles with metrics table
      commit: 9d45679a02f5e434ec48b27f671e22243a5c99cc

--
 i.

