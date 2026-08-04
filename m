Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793C43F0A9B;
	Tue,  4 Aug 2026 09:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785836107; cv=none; b=sd3QH78/GqzILSaiISg3pxjXUgbtUn03RJe8qU0YhFm8LDy9k/H4Z2y/nMFs8O+I7jPUhBZ/isKeHHwi3H1swLRqqeAvqQ+wnAQiC2i0rdmZbugIznyL8NYXVTx2TUXRt3JjvJvhT7pFp38vYPnDptkup9HmJPZ9qMAUakvY3pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785836107; c=relaxed/simple;
	bh=hv13t7z2577/jtf5gTd03vLdwH2iFsUJsa+WSPPu3R0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jsODOO9Jxiq13CJwBEZmHOvlRG8uVsEgjPheWnMpzWeYjO3uMujM+Fjy3Q/7f1dEAB1i75YYAXoBf9SNvLwPMUWwdYyqavzC/0HoskGFdDQXOidrzG1HSRPXJqqwUiB3/pUpwaH9F2CFA1YcpJfA52TPGfdMnbLkbOS+4sXzn5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JLgiYiy2; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JLgiYiy2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785836102; x=1817372102;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hv13t7z2577/jtf5gTd03vLdwH2iFsUJsa+WSPPu3R0=;
  b=JLgiYiy2mrmCmmIrdkK3IEkCpXMYisafLNJU0ZZkwf5wYF2w5mzjFpk3
   QQGO4k0BADfYrq6XrZHrFlNso08cB1wRNUu36HAqnB0HsxStdLob3ZtDF
   KQT9rWEVH3VPBUdvX9SuBFSgR7OTqkAumgwPZVTkqBft8MUUJf6C5FOQL
   FVK6pFocli2ozO7BreIQZxOGyWYqJqm1om5SRmL0JBebs+QbA8cBCTVN0
   vYUhwKc288Z9gC6DI+r7oQepaDWubPHTg+4rbinP//Q9Ddw2rn2DuZd8R
   HgDD8rRBhQJEC+t7NOl2grV1Xs4M7PvDnPiGrvDOxHASFy3VhB404nJrY
   A==;
X-CSE-ConnectionGUID: JA43thTNRKyXIXPlqonrKw==
X-CSE-MsgGUID: fmTOZYWQRQClUe3+iOWgBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="96975326"
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="96975326"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 02:34:50 -0700
X-CSE-ConnectionGUID: UMUvbBujTvGEXSCL5zzi3g==
X-CSE-MsgGUID: kEZ2DI3MRyu5fsGUPQxGkg==
X-ExtLoop1: 1
Received: from junjie-desk-dev.bj.intel.com (HELO junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 02:34:47 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Linus Walleij <linusw@kernel.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH] gpio: ml-ioh: use raw_spinlock_t for the register lock
Date: Tue,  4 Aug 2026 17:33:53 +0800
Message-ID: <20260804093355.2110800-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAD++jLkAjQG7hFsdX+dy8wZUoKKDCaOzMD0EJ0nn3gYmaEOJDw@mail.gmail.com>
References: <20260731032747.2987292-1-junjie.cao@intel.com> <CAD++jLkAjQG7hFsdX+dy8wZUoKKDCaOzMD0EJ0nn3gYmaEOJDw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Thanks for the review.

I checked it, and the report is correct. The PM callbacks take
chip[0].spinlock while the save and restore helpers walk all eight
channels, each with its own lock.

I have a follow-up that uses one lock shared by all channels. I'll send
it separately on top of this patch.

Thanks,
Junjie
