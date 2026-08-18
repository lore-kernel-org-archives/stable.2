Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001A7479870;
	Tue, 18 Aug 2026 14:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787062099; cv=none; b=N0BpCTVq55ZGn1/3B+Xv6138Zydvj2X9u4F3y5KNRdIa6JvVQtFHT8NWQb9nwlSgWyUJD9Un8jtASYnXIBK7GVbXGOz1+tPx17CLQCsAtSz7/bKTvWE1jgplCI+o59A7Lyi3zEJChLhPy6l00zsye2wZ73O2S6RPnrriQehPwGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787062099; c=relaxed/simple;
	bh=y0qIQfsfnjCzWHH5SCmNWGw61fVjAkqM0d9gnZANLBI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Wx06KM7kxn03ctVfGTq33sD3akOdQoel4lI2nVTBcau811odvpHCkvgozrspLe7l/a5lcOY2ICdXGCnqAmSBnfFZkq9DLr5h1SkQFtq5MhQCKQrrPF/NeOBWw15jycxPI6T165X23QhPPd6GdOIN/gN+zgVXC7K8g/pAJTlsnOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hIit5Q1J; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hIit5Q1J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787062099; x=1818598099;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=y0qIQfsfnjCzWHH5SCmNWGw61fVjAkqM0d9gnZANLBI=;
  b=hIit5Q1J+rk7UBCOIIduYQPYoSVOVAs9YNsJB+CBr56PnyOR0pBSO6bi
   zjP60LgHR+VChut3QqVY2h2PVpqQ5nCLNrPenKfVU86kozoUHGNulqnSo
   jpBNvO0jhsEZ/gt0LcfZQ9/34PSIbPFj9ttuw1P2+yEbf7ke0qjnRYSIw
   /pzTpXzYS3kJMkbNbErVFbQnluPNeojhWXR4+16VycT+vkVAR8v76yCGt
   DbYarylk4T1xeOtpsW00ncD9dqBjH89PorIxL1OmylygmLT24Yd9dPTtX
   mOBMs903HUfTFzC1R8Q254NMvfO5E7nzhnGcUsOMPw7wzWW5KsVzUKQ4U
   A==;
X-CSE-ConnectionGUID: CUjY/PVXSiWmxoo47MflXg==
X-CSE-MsgGUID: IiQhVJ6HTXu5/ymUBCxHew==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="98708804"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="98708804"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 07:08:02 -0700
X-CSE-ConnectionGUID: WPKUgEvHTbKoDJFTzSMNDw==
X-CSE-MsgGUID: xq/wzcHlTfaqzGy2CfhrgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="264792118"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.38])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 07:07:58 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Mark Pearson <mpearson-lenovo@squebb.ca>, 
 "Derek J. Clark" <derekjohn.clark@gmail.com>, 
 Hans de Goede <hansg@kernel.org>, Thorsten Blum <thorsten.blum@linux.dev>
Cc: stable@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260810204106.165895-2-thorsten.blum@linux.dev>
References: <20260810204106.165895-2-thorsten.blum@linux.dev>
Subject: Re: [PATCH] platform/x86: think-lmi: Free system certificate
 signatures
Message-Id: <178706207424.20251.13597407060065679354.b4-ty@b4>
Date: Tue, 18 Aug 2026 17:07:54 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Mon, 10 Aug 2026 22:41:07 +0200, Thorsten Blum wrote:

> Multi-certificate support also allows the system authentication object
> to store ->signature and ->save_signature, which leak when the driver is
> removed. Free the signatures to avoid leaking memory.

Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

FYI [if applicable to your patch], as per Linus' policy change, also
fixes are mostly routed through for-next unless the fix is for a
commit introduced in the most recent cycle or is clearly a regression
fix.

The list of commits applied:
[1/1] platform/x86: think-lmi: Free system certificate signatures
      commit: c81f167393d4379148d603b88b881918e4c66e2e

--
 i.

