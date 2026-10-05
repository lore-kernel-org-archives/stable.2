Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7234481AAD;
	Mon,  5 Oct 2026 15:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791214654; cv=none; b=LzOJW9kCCHlwuxmBG38CfpUTlxPnkE/rENOMBmgzEhgzWgOgtN4w/y3O6Ze35dt9gZo+tyPOKBv+MtNjSB5IaYx/AAoSz8MuHJZIdGE3l9wqJynTmd/DY2TEmBXGfI7vsEcwAXC18jGJxfBOZzzIIcgnqnDyZewI7Z/voVW6bpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791214654; c=relaxed/simple;
	bh=bE8clMPJTr0SHUvixWvY/DACBls2szEtGhkk8jc0Z/k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=R/3Q35Y/fiDS2lIXR0W3oPVvHO08u5ncfxSFC6iXQU4ZsBampk2kwi5CShDFjLms+LWBCNgr/BncEfYuqtiNJTS4RT2ILNG8vO6o9sy46idRLMTe+mVduicSrB2JpDBg1kzxvwuvN+i8PKrbooP+UMz8klFpXCscZrHt2QNemo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h87ce3aY; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h87ce3aY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791214652; x=1822750652;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=bE8clMPJTr0SHUvixWvY/DACBls2szEtGhkk8jc0Z/k=;
  b=h87ce3aYh77jRkKIA6UwbX/hVlG+3mWeetu+hQk9Zm2fhatPRUUQCOJM
   V58HNf9R0hehShwpAvXIZP+oZYo9PH2J/0/DbqAOgK9Wv0jwMGVnykWMf
   Gz4pypCpJhAmBnw0bAIdfijrz2VIuP4azU2RKQ7OZ2G8ZVRlcKdwuq0E0
   iUmN67jK9MjMmihdJROnDxaDOn4NuzOE9Eu873Oyf9rsblfNrvsVNnFO8
   A/ZyzuwkhYOzAGl8+3mVlHqRFL1kMKaOATLhoJOiQGsK7jtfyb61iC3/h
   psnXcQ7soyBqxPvssEbvpZOp2ioZ5WAzkkrtwvc9tExvWyBIgTzBQvivN
   g==;
X-CSE-ConnectionGUID: FhNRQP67RCKfi6Qvup4wRg==
X-CSE-MsgGUID: /b7XRdQZQmaVS7aGNm0xMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="91995638"
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="91995638"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 08:37:32 -0700
X-CSE-ConnectionGUID: jYvcXt+NRNiITAcF7gOFmQ==
X-CSE-MsgGUID: cH7XUnmeS6a6zG5pUaOCWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="873948"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.199])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 08:37:30 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Jorge Lopez <jorge.lopez2@hp.com>, Hans de Goede <hansg@kernel.org>, 
 Muhammad Bilal <meatuni001@gmail.com>
Cc: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Josh Snyder <josh@code406.com>
In-Reply-To: <20260919060037.84602-1-meatuni001@gmail.com>
References: <20260919060037.84602-1-meatuni001@gmail.com>
Subject: Re: [PATCH v4] platform/x86: hp-bioscfg: fix 16-byte heap overflow
 for empty auth token
Message-Id: <179121464568.12659.4986176178438441338.b4-ty@b4>
Date: Mon, 05 Oct 2026 18:37:25 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Sat, 19 Sep 2026 11:00:37 +0500, Muhammad Bilal wrote:

> hp_calculate_security_buffer() special-cases an empty authentication
> string and returns a fixed 4 bytes (sizeof(u16) * 2). But
> hp_populate_security_buffer() does not special-case that same input:
> for any authentication string that does not start with BEAM_PREFIX,
> including the empty string, it always builds "UTF_PREFIX +
> authentication" and converts the result to UTF-16, writing a 2-byte
> length header plus 2 bytes per character of "<utf-16/>" (9 characters),
> 20 bytes total, regardless of how long "authentication" itself is.
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
[1/1] platform/x86: hp-bioscfg: fix 16-byte heap overflow for empty auth token
      commit: 67e222d412cc51d05380f2b7482a998cd4b4c638

--
 i.

