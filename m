Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5010323417;
	Tue, 28 Jul 2026 15:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785253858; cv=none; b=f1W2iFmb+VQaFoGtuhyEqhIciKHXcQCj3DOrW81huvIQTYI2PoZcg8a4iG9e0OEF2ah4FSk11CxgP0toPF0a3X95CQiUeTwlPIhfj7VxBGCJ6/+Mx1VhzuubyHp7lDv5z+lw0J1DoVeZlBbuE6UvWnHVl5qpUCeUxrM92y1Db90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785253858; c=relaxed/simple;
	bh=6z5XRukXfm8FKEfmwqTb+byabOdIJDVmwC4BbmIGDQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVStXyQaK3xpuJpU6AcYNfrPgD6jP1+g4TSKkvBSTKvBlJO7qz/dOZu63veJrc57KfAtLSlKNKlpYV4tzjzfmC8KpQcK1jJCOElDU9X9Fx1BrvD6DgQWRRnqUd8tQl0DM1a+WFl0BmesOpXfGftGbONaen9a9IkEY8sZ25rfVmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b0czCm5p; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b0czCm5p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785253856; x=1816789856;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6z5XRukXfm8FKEfmwqTb+byabOdIJDVmwC4BbmIGDQA=;
  b=b0czCm5pRylLTiINlsdn0glPH5pnQd2e/WCZ6mKtcqMSC9ZBIWAjQj0S
   MT7rseTf2QaPYUOP+skgd8eNsjY/fgAV4giKgzp7s2fVJxkO+nd3QExHO
   lZrZPUAMgiCpfsgUp+Qh+Jl2DLFp3g8WLKz40MDEkq6qq4ksBC95n8ESi
   jGzUNVFJ77HI4Hpd3mPKqCELNrESzkKDeYKO1TQ1ljHHJlrUMT9+Wtcoh
   +elX1SmsLSebAWiAfrqqJKHJ/vkym4720uWl8qTrSYOCBYbkdks9XRbBs
   HugXlsWxWzPQlYxMygDtZKKnF3HTYeMneMcHo7gaZ4ZSJF1313X3Zb1D5
   Q==;
X-CSE-ConnectionGUID: JA9Rq4CcTWG7NYGcQftc0g==
X-CSE-MsgGUID: xqLfisexS8GfZ3zS1eRSCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85695966"
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; 
   d="scan'208";a="85695966"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 08:50:55 -0700
X-CSE-ConnectionGUID: 7wxUxp9ETQq1dRglBa6EqA==
X-CSE-MsgGUID: k3QUJyhOQeeQ6EKKEtFOrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; 
   d="scan'208";a="255816658"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa010.fm.intel.com with ESMTP; 28 Jul 2026 08:50:52 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 28AFC99; Tue, 28 Jul 2026 17:50:51 +0200 (CEST)
Date: Tue, 28 Jul 2026 17:50:51 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Matthew Brost <matthew.brost@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Raag Jadav <raag.jadav@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Ramesh Babu B <ramesh.babu.b@intel.com>,
	"Michael J. Ruhl" <michael.j.ruhl@intel.com>,
	linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v6 0/3] drm/xe/i2c: alerts and controller enabling
 modifications
Message-ID: <amjP22-2VVk0QgyH@black.igk.intel.com>
References: <20260722133554.2079612-1-heikki.krogerus@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722133554.2079612-1-heikki.krogerus@linux.intel.com>

On Wed, Jul 22, 2026 at 03:35:51PM +0200, Heikki Krogerus wrote:
> Hi,
> 
> Changed since v5:
> - Leaving the interrupt de-asserting to the firmware.
> - Re-asserting the interrupt before declaring the device wedged.
> - Preventing the SMBus Alert from being masked.
> 
> v5: https://lore.kernel.org/lkml/20260715153153.1243751-1-heikki.krogerus@linux.intel.com/
> v4: https://lore.kernel.org/lkml/20260713155601.711389-1-heikki.krogerus@linux.intel.com/
> v2: https://lore.kernel.org/lkml/20260625125939.429078-1-heikki.krogerus@linux.intel.com/
> v1: https://lore.kernel.org/lkml/20260622114759.3464047-1-heikki.krogerus@linux.intel.com/
> 
> Heikki Krogerus (3):
>   i2c: designware: Global register definitions
>   drm/xe/i2c: Fix the interrupt handling
>   drm/xe/i2c: Keep the i2c controller always enabled
> 
>  MAINTAINERS                                |   1 +
>  drivers/gpu/drm/xe/Makefile                |   4 +-
>  drivers/gpu/drm/xe/regs/xe_i2c_regs.h      |   2 +
>  drivers/gpu/drm/xe/xe_amc.c                | 187 +++++++++++++++++++++
>  drivers/gpu/drm/xe/xe_amc.h                |  25 +++
>  drivers/gpu/drm/xe/xe_i2c.c                | 165 +++++++++---------
>  drivers/gpu/drm/xe/xe_i2c.h                |  14 +-
>  drivers/i2c/busses/i2c-designware-common.c |   2 +
>  drivers/i2c/busses/i2c-designware-core.h   |  85 +---------
>  drivers/i2c/busses/i2c-designware-master.c |   2 +
>  drivers/i2c/busses/i2c-designware-slave.c  |   2 +
>  include/linux/designware_i2c.h             | 107 ++++++++++++
>  12 files changed, 431 insertions(+), 165 deletions(-)
>  create mode 100644 drivers/gpu/drm/xe/xe_amc.c
>  create mode 100644 drivers/gpu/drm/xe/xe_amc.h
>  create mode 100644 include/linux/designware_i2c.h

One more fix is needed for this series. Raag noticed that the i2c
driver accesses the registers after the drm device is declared wedget.
The i2c adapter is suspended after the device is declared wedged, and
the driver's suspend callback then accesses the registers.

Thanks,

-- 
heikki
