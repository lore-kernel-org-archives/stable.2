Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D63E48382F;
	Mon, 19 Oct 2026 11:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792408860; cv=none; b=F+IaowkXbXz2uOGCfq2U8WjKDyx55RdfmX2tmc4ARW/TddSK7vIjLp0ZsoD5l135B1OQ9/ZNvVas+YM6EB5+WgilRTsXV5+OSEPoc9c4Y5+wh0JDNMFUt8Nz5GnbuaBH9cxiefoMcDJ2lEHe+bHiHjjnjIZ+CXt4dSqrfKSsGi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792408860; c=relaxed/simple;
	bh=OjjfwwLZbDqlnlqqnl+VhPdVOwG66obu/ngPBAEEJ60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TN7m3y1YGlK644vwn/gcGS6F+YpmF8B6OlazNN6rpCj/wv1tE8ZzCk/qOYgvofwjmx1Mrr+6wb6x8NZL8Sxe8m+XQBjM/9cLdjOd79vKrCG3GOTSk2zUvnfeCev6POjOSIjE6PKVkwK7NJ69lE1iN9L/5afkzbSzPFNnWoSnDm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Viat4dnx; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Viat4dnx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792408857; x=1823944857;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=OjjfwwLZbDqlnlqqnl+VhPdVOwG66obu/ngPBAEEJ60=;
  b=Viat4dnxGRZ2G8UEiYOPPdjVHunkgp0Uka8wAOZORJ1wjH6oC/RQ07sZ
   XE3WrTAP4429RmJNNyURLD852ajaG40KQAdCwwwjMSjfhUATCoStvPBb/
   2Ur96GE8XSDhweRpOulgHw8b9d8oAU5tP4rXCygExaxF68en9VWCq03nK
   KMFHwbuymcMU0DXoAYTAhEJrhkowj3FKrUxHcD3fnPQnrN37oB4Z3HqTa
   lJFAGyA3fLwQpepjBly2Ps02TUJwHH8etZPcKPM1TKV5/KE9GdabKATN0
   UkkeQZuD0yft44WAmbCqzSHln3E8WGV/wixgP3X+0mLmX9leV+zh6W42o
   w==;
X-CSE-ConnectionGUID: X1UZNggIQdKqkVX6a96ZHQ==
X-CSE-MsgGUID: XdyIYFN6SgmSooMf94zmxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="993082"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="993082"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 04:18:56 -0700
X-CSE-ConnectionGUID: 2EQXLQQ7Q3Wkw2XbewmDww==
X-CSE-MsgGUID: 34XvGfjIT8a4JiB7DgQHWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2570954"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 04:18:53 -0700
Date: Mon, 19 Oct 2026 14:18:50 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Michael Anderson <mwwa919@gmail.com>,
	Bartosz Golaszewski <brgl@kernel.org>
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
Message-ID: <atX8mpg19_WkIa27@ashevche-desk.local>
References: <20261018-vlv-dsi-owned-gpios-v1-1-3ca18bcda670@gmail.com>
 <atXp2NSPKZUPj8sq@ashevche-desk.local>
 <CAL-Wm=O-Gr3CuvCn8iSQceQMhu=LGFz0SPhmWeFL=RiVnoprdw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL-Wm=O-Gr3CuvCn8iSQceQMhu=LGFz0SPhmWeFL=RiVnoprdw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

+Cc: Bart (as GPIOLIB maintainer and author of the reset-gpio rework).

On Mon, Oct 19, 2026 at 07:03:57AM -0400, Michael Anderson wrote:
> Thanks for looking at this. I'd like to make sure I understand before
> doing a v2.
> 
> Here both users of pin 10 are i915 itself: intel_dsi_vbt_gpio_init()
> takes it as the "backlight" enable GPIO (soc_panel_gpio_table,
> PPS_BLC_SOC), and the VBT MIPI sequences on this tablet then toggle the
> same pin as the panel reset (low in ASSERT_RESET, high-low-high in
> DEASSERT_RESET). Do you mean describing pin 10 with a software-node
> "reset-gpios" reference and having both paths go through
> reset_control_*(), or something else?
> 
> One concern: the VBT drives explicit pulses on the pin, and shared reset
> controls are refcounted, so a pulse from one path wouldn't reach the line
> while the other holds it deasserted. Would an exclusive reset obtained
> once by i915 and used by both paths work instead, or am I missing how
> reset-gpio handles this?

But then it sounds like the request-by-demand?
Bart, any ideas how to address this case?

> On Mon, Oct 19, 2026 at 5:58 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Sun, Oct 18, 2026 at 04:12:40PM -0400, Mike Anderson via B4 Relay wrote:
> >
> > > On VLV with PPS_BLC_SOC, intel_dsi_vbt_gpio_init() requests the
> > > backlight and panel enable GPIOs (INT33FC:01 pins 10 and 11) for i915
> > > itself. Since commit 8241b55f1ded ("drm/i915/dsi: Replace poking of VLV
> > > GPIOs behind the driver's back") the GPIO elements of the VBT MIPI
> > > sequences also request their pin through gpiolib, so when a sequence
> > > toggles one of these two pins the request fails and the toggle is
> > > dropped:
> > >
> > >   i915 0000:00:02.0: [drm] *ERROR* GPIO index 10 request failed (-EBUSY)
> > >
> > > Before that commit the pad registers were written directly, so the
> > > sequences could still drive the pins i915 owned.
> > >
> > > The Toshiba Encore 2 WT8-B (Bay Trail, DSI panel) uses pin 10 as the
> > > panel reset line: MIPI_SEQ_ASSERT_RESET drives it low and
> > > MIPI_SEQ_DEASSERT_RESET pulses it high-low-high. With every toggle
> > > failing, the panel is never reset after i915 sends MIPI_SEQ_DISPLAY_OFF
> > > during takeover and stays black, even though the backlight PWM and both
> > > enable GPIOs read back as on. The tablet only has a usable display
> > > with nomodeset.
> > >
> > > When a VLV MIPI sequence targets pin 10 or 11 and i915 holds the
> > > corresponding descriptor, set it through that descriptor instead of
> > > requesting the pin a second time.
> >
> > Ah, nice, this should be solved via using reset-gpio, which is exactly fixed
> > for the reset shared lines case.

-- 
With Best Regards,
Andy Shevchenko


