Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F10733DED5;
	Tue,  9 Jun 2026 14:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015106; cv=none; b=LYRgJ2nczvE44/kTBPRJj+podfbpvzoeMFAWVZKV15dYEatP7ayOK3whtQDMUNfYvougaMgp1MN6ga9HIUgujyQcFdzq7mX1eA7TzOV0FRKf5rM5WX7mZ0LIWyj2IuTXIY4MmFJvRgr2bPYwNhlXyXlOzOt0C3j5qFAT9ppJ5dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015106; c=relaxed/simple;
	bh=52VYIBCEPZpc8tS4RmT8Kih78+4CYrkFm+4zN33iM88=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MhZgJ3fU4/lk2pzXgD04t0yemFRugePRk4EFBm/m2t0wAtsbEqxyncdB/tZ6V2z73OJXz7NloY8Zo7XFlas+LW3ADClDpe2Cbfq9BnKZWKdE18ralhu5p01T//bbn35YBvXUSG9UHoWQ5qg1rJ0O0yIDj3wk2a8MCs5FxJIsjBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VWD/Dw1D; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VWD/Dw1D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781015105; x=1812551105;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=52VYIBCEPZpc8tS4RmT8Kih78+4CYrkFm+4zN33iM88=;
  b=VWD/Dw1Dja/4xCmfb2z7tXrvMhJCIGlQtN/1+mzhN7twlr9tqx7uibrW
   SIjyIxIWeo9Vw5H9CQt8H/NO3p05pwgTiFwq57lajb4uidJfBvev3BSlb
   hNuIpWG2PXpWkWc06iZmCmcfd+0Jx60OHCnylWRxzHi4hzlAgESIHk/F5
   XrOSNYfgBSzRy+IroZi3x6R1dQkvCYdxsVhKvIFf45yEQaH9vUqnGkeSL
   DMwJ5Jjkj2jHfblDWUeCQEVN5C0pUlVy7REwosPsHvlAQ7R6MvNt2wtOk
   oShTXaTdwj0aiI+S2rRteg+hw1KyVtdhuuc8yz/EAZe76uvPxjNeQH2GZ
   A==;
X-CSE-ConnectionGUID: uI7m4KkmS8CmE/MkrWmL6g==
X-CSE-MsgGUID: myQbL/8CRiiwS01WVqllHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="107212769"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="107212769"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 07:25:05 -0700
X-CSE-ConnectionGUID: USrBiuUdQve/gN8Ik98zWw==
X-CSE-MsgGUID: dWNRshVSSsGWs1+cgMaZPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="245970925"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.81])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 07:25:02 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: srinivas.pandruvada@linux.intel.com, 
 ZhaoJinming <zhaojinming@uniontech.com>
Cc: hansg@kernel.org, platform-driver-x86@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260521130848.2860219-1-zhaojinming@uniontech.com>
References: <20260521130848.2860219-1-zhaojinming@uniontech.com>
Subject: Re: [PATCH v4 1/2] platform/x86/intel/tpmi: use cleanup helpers in
 mem_write()
Message-Id: <178101509763.11417.8292496981912442140.b4-ty@b4>
Date: Tue, 09 Jun 2026 17:24:57 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Thu, 21 May 2026 21:08:47 +0800, ZhaoJinming wrote:

> In mem_write(), the temporary array returned by
> parse_int_array_user() must be released on all exit paths.
> Convert the array variable to use cleanup.h scope-based
> cleanup so it is freed automatically on return.
> 
> This also moves the array declaration next to
> parse_int_array_user() as required by cleanup.h usage
> guidelines.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/2] platform/x86/intel/tpmi: use cleanup helpers in mem_write()
      commit: a221557958e3a82d8565729d445a7385963f30b6
[2/2] platform/x86/intel/tpmi: convert mutex in mem_write() to guard
      commit: 6736b1801908acfa64ef2b651c5bb78389a8a4c6

--
 i.

