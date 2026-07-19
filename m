Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B1E2609C5;
	Sun, 19 Jul 2026 09:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784454566; cv=none; b=GOE3Z52c0EHlGYaSIhdmXHMaHMWpvo+pcMXp3xRShJpUywQfY2iINMRamPpL9olyTo+hspQyyQs7vWwue0jtDqq/XIlSPm+xocXbb/TgRRQnc0cZzrQzpgPSNiO9G79nbAcxflEMIMS+3LVWRvCytSdUwbJdVuN8c36hxLikqTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784454566; c=relaxed/simple;
	bh=saByvZ6CrG7X8x9R/giPvCfdhn+z4EQvMxRtiQW1nl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JMCu32zvbMKonGubUB7W+Z9GLTLebPyP0BBO4uaiZSfRHLm2/yt2tEsovRNP+l5YqzkmOxPvNEG/DkV+h1Z79PKf0GQh/zerXayhvi+fR1DDzv7HuKp2yrjJ+pY/fPHbVD4h9uW60yDYLKjjWAg84Jo2LX6XY4DfepVNudP7pKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BJp48ITA; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BJp48ITA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784454565; x=1815990565;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=saByvZ6CrG7X8x9R/giPvCfdhn+z4EQvMxRtiQW1nl0=;
  b=BJp48ITA4MsfM4UxWrZVZlDhdb/XSibs1OFzNtxrxooJbOA+e0jdHINl
   tJRqVsvgbmB1SZbePDReBCJFvrgodSqjN7BUdRrG/R4TPhFIOTlygRpv5
   IXMSYJopdkD/2kWqkxYSBcNxrydE5T8crunpolx4P6ZSgFIBnuxA900Bw
   uj0G6Bb7ag1KEjcjluc6C32VzE7KfcK2/7o3h2wcocreukafgk2Q0fs4d
   3lG3K5ic54S7vDCuiJGET3kR/8OAymvGD4JpdpJfXMicrNvRbecmCHXiy
   pUxETsVl0ADhMSZ6wEoBNiSNPwBXT2kLty0Tv2eY/SAZoysiykxALO0WX
   A==;
X-CSE-ConnectionGUID: /VbMMvDNSxi5LT5SlkpvhA==
X-CSE-MsgGUID: d5I8/UC4Rwefa9UH0fFyfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11850"; a="84831985"
X-IronPort-AV: E=Sophos;i="6.25,172,1779174000"; 
   d="scan'208";a="84831985"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2026 02:49:24 -0700
X-CSE-ConnectionGUID: IsEO89ltRe+Q7wmTo90pPA==
X-CSE-MsgGUID: p43xZHhyR4K+wO14mR5Ylg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,172,1779174000"; 
   d="scan'208";a="262156186"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.56])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2026 02:49:21 -0700
Date: Sun, 19 Jul 2026 12:49:18 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Benjamin Boortz <bennib@mailbox.org>
Cc: linusw@kernel.org, andy.shevchenko@gmail.com, lee@kernel.org,
	vladimir.oltean@nxp.com, colin.foster@in-advantage.com,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v2] pinctrl: microchip-sgpio: add missing select
 REGMAP_MMIO
Message-ID: <alydngVPPaqCoaw9@ashevche-desk.local>
References: <20260719094427.1328725-1-bennib@mailbox.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260719094427.1328725-1-bennib@mailbox.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Jul 19, 2026 at 11:41:46AM +0200, Benjamin Boortz wrote:
> The driver calls ocelot_regmap_from_resource() via <linux/mfd/ocelot.h>,
> which internally uses devm_regmap_init_mmio() and requires REGMAP_MMIO.
> The Kconfig entry does not select REGMAP_MMIO, causing a build failure
> when no other driver in the config happens to pull in REGMAP_MMIO:
> 
>   include/linux/mfd/ocelot.h:34:24: error: implicit declaration of function 'devm_regmap_init_mmio'
> 
> Found by randconfig testing on arm64; tinyconfig reproducer below.
> 
> Fixes: 2afbbab45c26 ("pinctrl: microchip-sgpio: update to support regmap")
> Cc: stable@vger.kernel.org
> Signed-off-by: Benjamin Boortz <bennib@mailbox.org>
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
> ---

This is v2. It misses a changelog here.

No need to resend _this_ time, just reply to this query with
what has been changed v1..v2.

-- 
With Best Regards,
Andy Shevchenko


