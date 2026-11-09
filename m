Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794260426;
	b=sA1NkYb9U+8fR98OvCGXdONC4dKckZaz+ABdmF1FnXwpe/gi7Hk3/dXKIYalmoOeLNWf
	 AzPDI6USHrpGXF09MG6EFkjBCX9sD6i0a+9l/v2LZqJ4puTOD1ACYjIs8lTNgdUNA9MfA
	 UF/mwc+eOmbGy2nXMy1+/WcU6NhmEdAIYIqbOzoLqiUCvSRC00assWA6GJuTe+hOWRGwG
	 ul0lgAMjc1Q+sZqZOKO/GJL/cDc0pxwag3TEy2As7wgyMj1SxVHX/N5r1/CUjKxPBeP8z
	 ZBEB3cgJan9hhL9UmQ6s3+xuvw4lXU7v2TUYRECHEmDl97/aPHUrt7yqZwilbxZybEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794260426;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=kbXpWsGA6wjP0sgcEePfgquKyUEPpPh/l8eqP/BlFbU=;
	b=GEljXpMlPXt5eMiyBSGES6vZkaIK+4lATdOS046yhF4ZB/zD54AfgLV+mLo6gerNvYW3
	 Z+0oQqTmTws5hNj44yyo23xvCxBLOvAPBdCUmcg7vSwSLZhE0CX3JTUoaddcoRv9et7TN
	 hlD/7lSSgqnkrwVuetl0TNhKuvgsxlVp6CGjjupL8ghT00e1kKTQzrLegn3UrwAonIhjO
	 1xu0voNdqzWtup+HHjObV3ZcztPM+cFQOUD8tzwUVx+upKg2LPaI95749VJ3ssHLgpGOi
	 IISLYKk17uaKiQrwDAZmIbJhGs8Hh4eGcGcDAvakaTe0327WqCFq/yaEemwugcSz9Sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=b7Gc1CB4;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424C7606A321;
	Mon,  9 Nov 2026 21:40:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 424C7606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=b7Gc1CB4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794260425; x=1825796425;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5NVSwZOPfn0jj1MPptSgjkG5ckE1/OJgvnBjUPbvvjQ=;
  b=b7Gc1CB41EaIKUg/0YAxvkZvKWjVsyN4jPjyI3y/pB7BjZ5F5d8HJnrh
   95wA2dkFt24iAdKKKi5Im3DYNbWoXTY7VMU+6BLJqgTmi92w5y8pOiI1L
   PcmG6hge2GJHZaOdZx12LLzilDaC4HWKypMOuRgVfTGz6ZYVvLgnA6K3N
   sAMV8RLPwIQO3/Xh9MqqMUWmc7bL5qjAmVt9nPbVxAW0uiUJmtmKyV4Wg
   SjGDXJ7r+goxD22SmlAkk5OZyTuFs516SfdymtuvSkiIyPrrzZovCcPrL
   hnXLtwGZo4xkpDlqqHY5BVlcPQgixlpYj3o0XYm8AjC8fmAz0DGoBI58x
   Q==;
X-CSE-ConnectionGUID: RZjJT9jPQ5CGR0Wu66Ht7w==
X-CSE-MsgGUID: zZ13kACRSB2H5tiTt5+sBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2883929"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2883929"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 13:40:25 -0800
X-CSE-ConnectionGUID: MSujhSu6TWWx9FrasFgZjQ==
X-CSE-MsgGUID: ElzKqfZjQLmrvIcNW8Q4dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="7989377"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 13:40:23 -0800
Date: Mon, 9 Nov 2026 23:40:21 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: raoxu <raoxu@uniontech.com>
Cc: lee@kernel.org, mika.westerberg@linux.intel.com, mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mfd: intel-lpss: Clamp latency tolerance to the register
 value mask
Message-ID: <avI9xV5PbYvKdFe1@ashevche-desk.local>
References: <82545EC5E5ABC9F0+20261109094242.3783672-1-raoxu@uniontech.com>
 <avI9fDRmwFyIfTDv@ashevche-desk.local>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avI9fDRmwFyIfTDv@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 09, 2026 at 11:39:12PM +0200, Andy Shevchenko wrote:
> On Mon, Nov 09, 2026 at 05:42:42PM +0800, raoxu wrote:
> > 
> > The PM QoS latency tolerance interface accepts non-negative s32 values,
> > but the LPSS active and idle LTR registers have only a ten-bit value
> > field. intel_lpss_ltr_set() selects the larger scale for requests above
> > 1023 us and ORs val >> 5 into the register without limiting its width.
> > 
> > For a request of 32768 us, the shifted value is 1024 and the latency
> > value field becomes zero. A request of 100000 us leaves only 53 in the
> > value field. Still larger requests can set bits outside both the value
> > and scale fields. Thus a relaxed latency request can produce a much
> > stricter tolerance and unnecessarily restrict power saving.
> > 
> > Clamp the shifted value to LPSS_PRIV_LTR_VALUE_MASK before combining it
> > with LPSS_PRIV_LTR_SCALE_32US. This saturates oversized requests instead
> > of wrapping the field, matching the Intel LTR handling in sdhci-pci.
> > Negative values and PM_QOS_LATENCY_ANY retain their existing handling.
> 
> Shouldn't we rather forbid to apply wrong values?
> 
> > The supplied fix was reviewed and this commit message prepared with
> > OpenCode AI assistance.
> 
> This paragraph should go after '---' line below.

...

> > Fixes: 4b45efe85263 ("mfd: Add support for Intel Sunrisepoint LPSS devices")
> > Signed-off-by: Xu Rao <raoxu@uniontech.com>
> > Cc: stable@vger.kernel.org

Ah, and it's not a fix, it's just improving user experience. The interface even
not a sysfs one IIRC.

> > ---

...

> >  		if (val > LPSS_PRIV_LTR_VALUE_MASK)
> > -			ltr |= LPSS_PRIV_LTR_SCALE_32US | val >> 5;
> > +			ltr |= LPSS_PRIV_LTR_SCALE_32US |
> > +			       min_t(u32, val >> 5, LPSS_PRIV_LTR_VALUE_MASK);
> 
> No min_t() in a new code. You mentioned clamping, use clamp(),
> it's exactly for that.
> 
> >  		else
> >  			ltr |= LPSS_PRIV_LTR_SCALE_1US | val;

-- 
With Best Regards,
Andy Shevchenko


