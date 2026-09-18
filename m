Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1D352843B;
	Fri, 18 Sep 2026 18:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789755959; cv=none; b=dFHyeaHdRHvIJjyf/caP8VcptHDHaaNOckwug5kti0UJOnKupRtFx9pfaRYmgPkXSzYQWLWcqr0UWC8mI8b7m4+zb4GOyzIPuVCYO8Urty8ovKoPveWD5zdexYv53gqds8XFH2IlAAL3t6cf6Rxk94csHc2n8dqZGr+00JdfZlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789755959; c=relaxed/simple;
	bh=lJcwSC59uLlPHHaubiEAgU5w5E7iWQfE12hdtzIhcq4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KmaKGCAIRDLFZtLPsKh5K99xdORnOLMQXofibw7KK40vylk+sf0l19UkSlSbe0uBJhb/H0bPHpPO/QKTb9rNyIHhDaIJ/M0+ZPDuMFkIGN+tf8SdVLLjPG7Fc47PJJCe7rrG1m5nOT0SY26g8MLuIMV9g/NOOY2W1ZbT4arFKnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gTHDKd4E; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gTHDKd4E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789755958; x=1821291958;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=lJcwSC59uLlPHHaubiEAgU5w5E7iWQfE12hdtzIhcq4=;
  b=gTHDKd4EI5mmG+d//NkZIS9yvBQOk98HHwQsjWA+EuLlJPGc5efmcj8k
   1LYMDBGfVJqNW9faD5klu4iNSylOn9DdWOoJEyWsACtYF2xbQ3uP0jRk3
   uhiAu4YTztgSvnDNixUIsBl6Zc7tLaOGxqtlwh40j6QEEXfTRYrMO3MKf
   hcBeG5CXIWVryQ4w0RFnFnEW4kyjC71xmPeDHVoRJ6BUoH+mmbJoCrURu
   JTJzdAp2Hjqb6799UK6PnkEx7rGuvsqMu4F75WyCbX11rBjfEzKGbqJ9T
   FuW+buvF0uY86WUn9I9SvqMFPZxBXbme5IbZyhyJSDBIJa45y8ohFClRy
   Q==;
X-CSE-ConnectionGUID: tzpzdl6KQSq5DxJib6TGSQ==
X-CSE-MsgGUID: L0z0J4C4Qj69NSSGOSSZWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="90297796"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="90297796"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 11:25:57 -0700
X-CSE-ConnectionGUID: kPGCQMebSuW8DZi+pZKWwQ==
X-CSE-MsgGUID: 91qlq67yTDmMbmTmhAWKEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="271192294"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.223])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 11:25:54 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Shyam-sundar.S-k@amd.com, hansg@kernel.org, Patil.Reddy@amd.com, 
 Mario Limonciello <mario.limonciello@amd.com>
Cc: stable@vger.kernel.org, platform-driver-x86@vger.kernel.org
In-Reply-To: <20260903182927.3556274-1-mario.limonciello@amd.com>
References: <20260903182927.3556274-1-mario.limonciello@amd.com>
Subject: Re: [PATCH] platform/x86/amd/pmf: Validate the APTS state index
Message-Id: <178975595040.29716.1867227315021965469.b4-ty@b4>
Date: Fri, 18 Sep 2026 21:25:50 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Thu, 03 Sep 2026 13:29:26 -0500, Mario Limonciello wrote:

> The static slider APTS state index is supplied by the BIOS as an 8-bit
> value, but apts_config_store contains only APTS_MAX_STATES entries. An
> invalid firmware value can therefore cause amd_pmf_update_slider_v2() to
> read beyond the end of the array.
> 
> Validate the selected index before applying the slider values and return
> an error when it is out of range.
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
[1/1] platform/x86/amd/pmf: Validate the APTS state index
      commit: e70b1f5fec16051dcc862a7c82ac173eb11bbbec

--
 i.

