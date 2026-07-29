Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721F8455196;
	Wed, 29 Jul 2026 15:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338695; cv=none; b=afeY6vKh+/YOwlRe71uQDpthks2ape5Icl2I2Hwq725txulkrJYDu+j5oKENGkAqmLOmfYe9BT6L9GZD4jNYR7fG832pICnIzQCQnELK4CXjXpYB3xsI1zOjkOlKkgvLZ8DJkqgs5m4ukWW40CxAtlTJMi8r/drBbCrH12/tMZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338695; c=relaxed/simple;
	bh=4bvcUoFf/iOBsji4Yq/iv6rM5VRcQ3R3kEZjKQNiPeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h77HobmiDySPR57dg2fgN0DQZJAl2mrz+ZLVsppDEMP8Dvw/dWtobOgjKwi3sCLZsC02Ht5v61ReB8WFhbMen6XaW3Hcr9IBxG/KyRjwxtBlxRCjWJ9YnXFgcVad5sd0nBYEF4NTm/8iyaCucE0bLlxMWMjvz27/9kKIrDSazWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FQfAnOC4; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FQfAnOC4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785338692; x=1816874692;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4bvcUoFf/iOBsji4Yq/iv6rM5VRcQ3R3kEZjKQNiPeY=;
  b=FQfAnOC44+FT2e9sFtyVJznKKuzkW58iKfnppOOMz6/8I96qWerUTBdi
   fxcOJoY4RuzHF4QD+a8StGZQbzogEveVOoixHpRVgyC1oRqKEue166DFM
   uuE1TiL2XK6yB4G9kDo4DEbBSByf6m/VcT7X7523YRGQx8bm4BD7zbAWq
   JzZ3zYl3oW6IJM7KLJKTfpA13JXv5+oDmGdyrGW1T0GGhMoWDDv9JkXgv
   c+S7yvQr1p8pyEi2ui8GATWYp9oZhhbBrRasAtc4uWJIphcG7c4UvUyXL
   6SCGcZl1d3JMKF7XmI7S5cWkBpcYg34G7EGI3MNqdzV6vImaSZ8roUI/E
   w==;
X-CSE-ConnectionGUID: Oc9sORn9SyGfpcwiRTBisw==
X-CSE-MsgGUID: y05m07fASz+YCPpbhYTv0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85819902"
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="85819902"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 08:24:52 -0700
X-CSE-ConnectionGUID: PaXvJVWCTA2/we8xYMYZcQ==
X-CSE-MsgGUID: 5aPxgvOeRqGyDa3MzO2jZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="255746885"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 08:24:49 -0700
Date: Wed, 29 Jul 2026 17:24:46 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
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
Subject: Re: [PATCH v6 0/3] drm/xe/i2c: alerts and controller enabling
 modifications
Message-ID: <amobPjBJ6V_IpaK6@black.igk.intel.com>
References: <20260722133554.2079612-1-heikki.krogerus@linux.intel.com>
 <amjP22-2VVk0QgyH@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amjP22-2VVk0QgyH@black.igk.intel.com>

On Tue, Jul 28, 2026 at 05:50:51PM +0200, Heikki Krogerus wrote:
> On Wed, Jul 22, 2026 at 03:35:51PM +0200, Heikki Krogerus wrote:
> > Hi,
> > 
> > Changed since v5:
> > - Leaving the interrupt de-asserting to the firmware.
> > - Re-asserting the interrupt before declaring the device wedged.
> > - Preventing the SMBus Alert from being masked.
> > 
> > v5: https://lore.kernel.org/lkml/20260715153153.1243751-1-heikki.krogerus@linux.intel.com/
> > v4: https://lore.kernel.org/lkml/20260713155601.711389-1-heikki.krogerus@linux.intel.com/
> > v2: https://lore.kernel.org/lkml/20260625125939.429078-1-heikki.krogerus@linux.intel.com/
> > v1: https://lore.kernel.org/lkml/20260622114759.3464047-1-heikki.krogerus@linux.intel.com/
> > 
> > Heikki Krogerus (3):
> >   i2c: designware: Global register definitions
> >   drm/xe/i2c: Fix the interrupt handling
> >   drm/xe/i2c: Keep the i2c controller always enabled
> > 
> >  MAINTAINERS                                |   1 +
> >  drivers/gpu/drm/xe/Makefile                |   4 +-
> >  drivers/gpu/drm/xe/regs/xe_i2c_regs.h      |   2 +
> >  drivers/gpu/drm/xe/xe_amc.c                | 187 +++++++++++++++++++++
> >  drivers/gpu/drm/xe/xe_amc.h                |  25 +++
> >  drivers/gpu/drm/xe/xe_i2c.c                | 165 +++++++++---------
> >  drivers/gpu/drm/xe/xe_i2c.h                |  14 +-
> >  drivers/i2c/busses/i2c-designware-common.c |   2 +
> >  drivers/i2c/busses/i2c-designware-core.h   |  85 +---------
> >  drivers/i2c/busses/i2c-designware-master.c |   2 +
> >  drivers/i2c/busses/i2c-designware-slave.c  |   2 +
> >  include/linux/designware_i2c.h             | 107 ++++++++++++
> >  12 files changed, 431 insertions(+), 165 deletions(-)
> >  create mode 100644 drivers/gpu/drm/xe/xe_amc.c
> >  create mode 100644 drivers/gpu/drm/xe/xe_amc.h
> >  create mode 100644 include/linux/designware_i2c.h
> 
> One more fix is needed for this series. Raag noticed that the i2c
> driver accesses the registers after the drm device is declared wedget.
> The i2c adapter is suspended after the device is declared wedged, and
> the driver's suspend callback then accesses the registers.

There are usecases for possible adapter access after the device is
declared wedged, so this requires more factors to be considered. I'll
take a look at it as a follow up once I'm done with RAS.

Let's get this one through for now.

Raag
