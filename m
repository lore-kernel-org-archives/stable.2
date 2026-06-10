Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9967040960C;
	Wed, 10 Jun 2026 13:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781098205; cv=none; b=luf4Zi9ICuVeCqNjcyT/TcJF6dKUIAJfJ9CBmHAVXllkUCFxtP8cs6J6lbmYd7RBA3kPAlX0LO9DQXSr/qKrc77HFMP4MvOT+nuI54qy0g4wc8E88ijeIG1DPOLxyUPx/CVW5pfSgN9m0RNxC1ZhZQZE83vKzjFwtGIlkst62qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781098205; c=relaxed/simple;
	bh=zcwajM4IA03WJgAiEfbGtrnsPVUGTxF5gdek3L3ApSA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jG4xmJDfZoZOa4fP/ewiVVNqNfduw69T0mOloti9jkLew9LMRWPkMgtrdg7FA46vpOeno7cWdIgjVp5LrsRHxe9eqr4X248nPSSjW4e0EeRqEmJiQ7eF9mE6szPgD+wr6VAsdEYkj3bZyGYKp5VMsH/j038OZH9hoLQGO7rrAAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J//aNyq9; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J//aNyq9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781098205; x=1812634205;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=zcwajM4IA03WJgAiEfbGtrnsPVUGTxF5gdek3L3ApSA=;
  b=J//aNyq9IiR88HTnyPn/DYUBnalAUXOnhmZ0Z9friiVMMnM5HdoYAGlc
   Szb3Gto716W/nKQlFL+SZFftt4bYCLgk0R6IJaDvm27r4bQK+a1aYQMfT
   Mq/tJNYYPHZZaSZO8h+Ce3OdhFUneiTg3u9nqVop/K/bn2fhL+McnrJtW
   ISjIWrdqJBWwPAgQ0KsJnOldULXAi8837YPEMayh9TeohIj+22Xhq9E+h
   GMMcf408Fcqhi6L3j+fpDRv1NNsAEYDXanC13nsvks1ytgnfOZOqO7rgb
   EveaSsMbtluOA/8aCAqF/79NRrrjolVfpkBvMQ/q+811P8/2ZJxnSod5Y
   Q==;
X-CSE-ConnectionGUID: tHtrWEZuSE6N+PwNbPcCCw==
X-CSE-MsgGUID: EYR0s6t8T4eIjDJMEZHmpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="85517590"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="85517590"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 06:30:04 -0700
X-CSE-ConnectionGUID: mQreGsK3RJuMoMNA4uCzUg==
X-CSE-MsgGUID: lgkA2fT8RxmG3MOxzj9jOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="242040153"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.18])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 06:30:01 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: hansg@kernel.org, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Srinivas Pandruvada <srinivas.pandruvada@intel.com>, 
 Yi Lai <yi1.lai@intel.com>, stable@vger.kernel.org
In-Reply-To: <20260528204521.3531456-1-srinivas.pandruvada@linux.intel.com>
References: <20260528204521.3531456-1-srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] platform/x86: ISST: Restore SST-PP control to all
 domains
Message-Id: <178109819599.24283.6736261471538142.b4-ty@b4>
Date: Wed, 10 Jun 2026 16:29:55 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Thu, 28 May 2026 13:45:21 -0700, Srinivas Pandruvada wrote:

> The SST-PP control offset is only restored to power domain 0 after
> resume. During suspend, control values are read and stored for all
> power domains.
> 
> Use pd_info->sst_base instead of power_domain_info->sst_base, which
> only points to power domain 0 base address.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: ISST: Restore SST-PP control to all domains
      commit: 2565a28cdcdcb035e151d285efcba26bccb3726e

--
 i.

