Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA3336728B;
	Mon, 24 Aug 2026 15:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787584122; cv=none; b=DZQwcQaxf23A/6H4yR2qsmBc0lgBIw6PCx8yxVRggy4sZcn8qxNdeN6yFStzUA9u+9kA1RvZhIeo9ctLHTWriZTR/t0JDX0n/hKbfOXfh/yIXxy3h/pPNHjCL8Frft/SLX9lYNEYfIYRjqVG7THL7PRSdrZSjiZ0aQ8PTKhd7gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787584122; c=relaxed/simple;
	bh=LNFC3oXT9Tqn++1D8LUfQ5/HGZwKuyB65r3pa+0U8ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+fFw7wToOTLHa91YQJsMiYZWk+PJ7eLokkcOdKwQAJvq7Pk6jguQeYpJX/Tbeokaq6WQNAo93jgRxC1JWYTsV7t7ERl0RkK8wpuJJ8SogF/4NDIkH15DoPhSZ2mEP2gB52x5FsSQZDkLu9PUYX7GiFqOC1A8TfiwJgDHHUwmW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XJ8/3/bF; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XJ8/3/bF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787584121; x=1819120121;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LNFC3oXT9Tqn++1D8LUfQ5/HGZwKuyB65r3pa+0U8ug=;
  b=XJ8/3/bFLMetoQv4TRP3aOWM87KbfsxKvR5kk8fKC3C2Ar6pw1AmI+qW
   +AIRSVF3EGCyRQujDX88PYuzuI/0vsYrFq4W9lbtSK80hIXBCavVVDbha
   xEPUSLBBrdQAYsjKz0i1AzJiSZIxOX3YJIKISnyRBqAaBDzwIPVR59PZJ
   JZwhzOe/+p2gJCMRWsPQXxpzEc1nybChD5Ne8lVQXl7jInb7EcZ3cWIig
   Ls48K+rglG6p1xnnoRfCkm/2+IUbz7npb3vRThGhMGsVdzvGTltLQQ9Rj
   14oEVoDO8/r9p1CSvF9zNVqW4Sx1HQ9JIM1InyxtpfeAhCpebIkCkSXZc
   g==;
X-CSE-ConnectionGUID: olmQfWnASPG5QLW6xvCW2w==
X-CSE-MsgGUID: /fJZE0O2SASBenj2kscIjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="87909699"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="87909699"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 08:08:40 -0700
X-CSE-ConnectionGUID: KFl+8677Rl6CgaEGVOwWvQ==
X-CSE-MsgGUID: YKXJtkdXQ6acJLW2dQSaxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="272246764"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.130])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 08:08:37 -0700
Date: Mon, 24 Aug 2026 18:08:33 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Linmao Li <lilinmao@kylinos.cn>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, linux@analog.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ade9000: fix NULL pointer dereference in
 clkout registration
Message-ID: <aoxecT3hNa-M3UMn@ashevche-desk.local>
References: <20260824125210.1644319-1-lilinmao@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824125210.1644319-1-lilinmao@kylinos.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 24, 2026 at 08:52:10PM +0800, Linmao Li wrote:
> ade9000_setup_clkout() passes NULL as the register address when
> registering a divider clock. During clock registration, the common
> clock framework calls clk_divider_recalc_rate(), which dereferences
> the address through readl(). As a result, probing an ADE9000 configured
> as a clock provider with an external input clock crashes.
> 
> CLKOUT passes CLKIN through without changing its rate. Register it as
> a 1:1 fixed-factor clock, which does not require register access.

Do you have HW to test? What will be the result for the internal clock case?

-- 
With Best Regards,
Andy Shevchenko


