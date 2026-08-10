Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE4D35C69B;
	Mon, 10 Aug 2026 08:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786350249; cv=none; b=QZcXJb8mE2bUT9v5ckT1nLNU2h/kixESVDI2ayehabdPzj9W0YP4dhZYm7n/kQJiu4kW8tOk2LLyd+YutNwvEbwqrSVSvIRpbXxdxRRwWviwi2M1Scoc+8jnHW8H5BN2kb9pQ+ne1kB9xVW047MrJVf8V//aAscM7OcfDRq2Jzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786350249; c=relaxed/simple;
	bh=yecm5Pn/SYUDaqs0J181mIZ9F3jtvO0zLQgM2AejaWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e35dFGhtdQXEf+QgH8k6+4nG8Lbv8afQLKC0AX2EmMD31QVXYec7U4vRLxgrq1xxqa4sGi9bTPSa+BCiwTLksF6Ih93y0TdCrj9czx8pBmyJpIGq/cr+O6C/Ls6mQ9bWiqEHWnqsdBr/Z0jKe6UWjLhMcM+2PnH4EemZO4hPbgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PeYgPsqi; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PeYgPsqi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786350248; x=1817886248;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yecm5Pn/SYUDaqs0J181mIZ9F3jtvO0zLQgM2AejaWU=;
  b=PeYgPsqiTt8kqcnZO8SQ/iiFp/nZp13XQ9ciW8gXJzN6jKGJ41rQOIG2
   gRHCTL2JOOIXszkwYV5y4oJqM9Aep1jofUl8WRwfLfP6SUslQiOf1zI4C
   ZiXrQomE9TSaSqUEvG47TWkS1TJvdV+zXjaqP6nLPYhZqziG+aW1Mswgf
   8btjzxnkboGRlezab6smaz+QepKH75t/z2LbDDE7CHGLbdyjW3+3lxEdd
   7QtYWo4O8jCgXMBtohN1OSsuk08j1QDNWSSbXoXKUX9egMpFT99fs5Q2E
   fWsej4BPAju4ScL7jHyQEd8/zj85LQSAqcgJXYILqNaRcYRp9ebRsSA+4
   A==;
X-CSE-ConnectionGUID: 1i+RiCG9See/Xo419AcYoA==
X-CSE-MsgGUID: htO4aqKXQh+ClyCSe7XQ8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="97206175"
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="97206175"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 01:24:07 -0700
X-CSE-ConnectionGUID: 26I+uWa8QZ+UPiIbg+5hpA==
X-CSE-MsgGUID: s9+3uc2QSDSamFvDin4+lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="256762990"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa009.fm.intel.com with ESMTP; 10 Aug 2026 01:24:05 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id D77F399; Mon, 10 Aug 2026 10:24:03 +0200 (CEST)
Date: Mon, 10 Aug 2026 10:24:03 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Ramesh Babu B <ramesh.babu.b@intel.com>,
	"Michael J. Ruhl" <michael.j.ruhl@intel.com>,
	linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v6 2/3] drm/xe/i2c: Fix the interrupt handling
Message-ID: <anmKoxMONVxf5FoK@black.igk.intel.com>
References: <20260722133554.2079612-1-heikki.krogerus@linux.intel.com>
 <20260722133554.2079612-3-heikki.krogerus@linux.intel.com>
 <anlbyVOUkafs0UHE@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anlbyVOUkafs0UHE@black.igk.intel.com>

On Mon, Aug 10, 2026 at 07:04:09AM +0200, Raag Jadav wrote:
> On Wed, Jul 22, 2026 at 03:35:53PM +0200, Heikki Krogerus wrote:
> > The platforms that support the interrupt from the I2C
> > adapter can not handle the amount of interrupts the adapter
> > generates because of the way the IRQ is routed in the
> > hardware. The I2C controller driver has to be kept in
> > polling mode because of that.
> > 
> > The AMC MCU can still generate critical alerts that have to
> > be handled. The interrupt from SMBus Alert is left enabled
> > and handled separately in the Xe. The alerts from the AMC
> > will cause the device to be declared wedged for now.
> 
> ...
> 
> > +	alert_reason = response.value;
> > +	dev_dbg(&client->dev, "Alert reason: %d\n", alert_reason);
> 
> This came up in one of the internal reports. We have quite a few call
> sites for wedging and it can happen due to various reasons from driver
> POV. We really need to identify the source from logs when it happens,
> so can we atleast have this one as dev_info()?
> 
> All the reasons are rare enough to not spam the logs and it shouldn't be
> a problem IMO.

Okay by me.

> I'm okay with doing it as a follow up if the series is already merged.

I don't think this has been taken anywhere yet. I'll send v7.

-- 
heikki
