Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B601E4A3F26;
	Mon, 19 Oct 2026 09:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792403935; cv=none; b=HVzmSkfbx3KEnp5tUo/06HgdoHPi+NNBGxO8OFh+L1PbCBcYHZjkeo7E7zXmO/i9iIYkgkyju9XNK/PeDEIIceWRcM1Gah352gVFPTdPWJs6G/KfRoZz/EW1j9vYFL2tgYi7J88nHpvg929gCidSyzck/iLpdBBCXDiuXEKvBV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792403935; c=relaxed/simple;
	bh=FCF+CStTLQKo129wcMJjO9zPQelHyhJZb6dyEUr5q7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ElLhOWQFNUxXaVY7faBRKIz9jwJCzoOywnY26UiSAvYIk79tUww9jMX9v99ia8mstYB+3Hy9P39uftxgNSR+vcD0ZH1l14GYVJf2G32nM11hDhSMuo//Nzpa+ogfdWKETX08UU3LfoSddANDhZmOYNAQoZijiNCErvTE359rXnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e4nwNIKa; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e4nwNIKa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792403934; x=1823939934;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FCF+CStTLQKo129wcMJjO9zPQelHyhJZb6dyEUr5q7k=;
  b=e4nwNIKaUVbDN50Wdgdp0BrJANLCNqBsGbFd1NAKEl9Xv51svADuVnCB
   XQGDbPsZNsouM0xTMZOxJW+vK35MxaWif9KSH7vgbIw9RMqOJMM/sjeJF
   9yYhR8Wwoe7a79aeDD3oXjQ1WRzuIVzKSF1lfxW6TqNkt0OqxRZep5wlF
   SVHRiZY/uck9smPu5V3pRfkGhNFRr/vJ0GZsJMfO3d84LNsbXCdb/qP1I
   9Lf6b1HeDV/Mjg/9g6nrWA5YhTU0SxzfWqQZRN4h1I79NC7BTu/zGQ52J
   uQkOYO4U+bs5pl8Pj9LsP7FiZXtzf2JDEfyJyz2hHI4S1kWzHsNMVjQwM
   w==;
X-CSE-ConnectionGUID: BonMpdgZRhmG0kTYrwAXgw==
X-CSE-MsgGUID: ICGuKOeAQLStyCo3zpo/4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="1103095"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1103095"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 02:58:54 -0700
X-CSE-ConnectionGUID: 7uDefMOhT1e07ff2UgJhDQ==
X-CSE-MsgGUID: oZGsXOw8Qty5qXALoo+IuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="4277332"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 02:58:51 -0700
Date: Mon, 19 Oct 2026 12:58:48 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: mwwa919@gmail.com
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	intel-gfx@lists.freedesktop.org,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Hans de Goede <hansg@kernel.org>, intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] drm/i915/dsi: Use owned panel/backlight GPIOs in VLV
 MIPI sequences
Message-ID: <atXp2NSPKZUPj8sq@ashevche-desk.local>
References: <20261018-vlv-dsi-owned-gpios-v1-1-3ca18bcda670@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261018-vlv-dsi-owned-gpios-v1-1-3ca18bcda670@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Oct 18, 2026 at 04:12:40PM -0400, Mike Anderson via B4 Relay wrote:

> On VLV with PPS_BLC_SOC, intel_dsi_vbt_gpio_init() requests the
> backlight and panel enable GPIOs (INT33FC:01 pins 10 and 11) for i915
> itself. Since commit 8241b55f1ded ("drm/i915/dsi: Replace poking of VLV
> GPIOs behind the driver's back") the GPIO elements of the VBT MIPI
> sequences also request their pin through gpiolib, so when a sequence
> toggles one of these two pins the request fails and the toggle is
> dropped:
> 
>   i915 0000:00:02.0: [drm] *ERROR* GPIO index 10 request failed (-EBUSY)
> 
> Before that commit the pad registers were written directly, so the
> sequences could still drive the pins i915 owned.
> 
> The Toshiba Encore 2 WT8-B (Bay Trail, DSI panel) uses pin 10 as the
> panel reset line: MIPI_SEQ_ASSERT_RESET drives it low and
> MIPI_SEQ_DEASSERT_RESET pulses it high-low-high. With every toggle
> failing, the panel is never reset after i915 sends MIPI_SEQ_DISPLAY_OFF
> during takeover and stays black, even though the backlight PWM and both
> enable GPIOs read back as on. The tablet only has a usable display
> with nomodeset.
> 
> When a VLV MIPI sequence targets pin 10 or 11 and i915 holds the
> corresponding descriptor, set it through that descriptor instead of
> requesting the pin a second time.

Ah, nice, this should be solved via using reset-gpio, which is exactly fixed
for the reset shared lines case.

-- 
With Best Regards,
Andy Shevchenko


