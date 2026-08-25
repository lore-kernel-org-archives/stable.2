Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB46A4964F;
	Tue, 25 Aug 2026 03:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787629689; cv=none; b=Gxn0c5dIxgALD+Vm0K2RXv5RXXI1KRKTIV8crKf4CRVmt3skJ7f1yVSWJJMW/20f616zCwmSwbXRZ0n2Gsi98fvyCZyIye6EjXX9oq0sRejOiVaPqrC7BZyLFg+LOaadpCmeb3OlKdXViVKZjA76ubi/JfvL/eHvlTTVLmexytg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787629689; c=relaxed/simple;
	bh=Ynybgv7A+W1fp7KTrZunT26NYoDJCixA6pNkrbvhQ9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AP0FThFkvLkrKgj2W3krChytW3rWVYM3weJu9zuTTsjboFhIsr4k5QvuYg/wGU5BGBgzqkonnc1y7rHI573WBB3IVIVsMdVgvWPPXtVV4lymH0bj8N7o1HRilhxqyp/PJ9rgdOyOFwvYj8nWQJ1vWioWM28aTRlu6Y4KXHMYfvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UD6SEQ2n; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UD6SEQ2n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787629688; x=1819165688;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ynybgv7A+W1fp7KTrZunT26NYoDJCixA6pNkrbvhQ9Q=;
  b=UD6SEQ2nNYChEzBcAo0cMYY0kJcCXpNlMXJO3ajYEA9lkZe+XAXOZKc4
   W9ShRkQgeIpmD7h0eWKG6d2Q4HNAdDiTWh+VvElPpWbXdJFBXPH2ocGUs
   JGz963g1ZRpLEdfiZHgcv9P1Zx4Lt1EyGLPoDLBc1eitl8FKznbkSEsNj
   EobaW4Kzo00w0T1gkAroajv6ZQpESrvNwudF13BQj8hHZKuwAlxoMe2Eq
   FVkwPBwkW4syp6zKm2Ep3JqmY5qjDDUgoUUedHDRa4O6bbqHPt8Ljp26v
   gzKrhmPUM+Rdbl51/a6TVDlVz86VsIMulCRgnUyy+C9SE/hFnJrGKBhAV
   A==;
X-CSE-ConnectionGUID: pI3VT3PpRl2Df2kZc+kM5A==
X-CSE-MsgGUID: TYFjPulBTbywuRgKLQ4kew==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="88146669"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="88146669"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 20:48:07 -0700
X-CSE-ConnectionGUID: kQc/aVQyR0ep32AfgPUDfg==
X-CSE-MsgGUID: QcoA7d+TTNWlxJsbrXM2wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="292024231"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa001.fm.intel.com with ESMTP; 24 Aug 2026 20:48:05 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id CB82F99; Tue, 25 Aug 2026 05:48:03 +0200 (CEST)
Date: Tue, 25 Aug 2026 05:48:03 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Raag Jadav <raag.jadav@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Ramesh Babu B <ramesh.babu.b@intel.com>,
	"Michael J. Ruhl" <michael.j.ruhl@intel.com>,
	linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v7 1/3] i2c: designware: Global register definitions
Message-ID: <20260825034803.GJ893316@black.igk.intel.com>
References: <20260811121008.1493015-1-heikki.krogerus@linux.intel.com>
 <20260811121008.1493015-2-heikki.krogerus@linux.intel.com>
 <aoyb0WYzCd-DEIWC@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aoyb0WYzCd-DEIWC@intel.com>

On Mon, Aug 24, 2026 at 03:30:25PM -0400, Rodrigo Vivi wrote:
> On Tue, Aug 11, 2026 at 02:10:06PM +0200, Heikki Krogerus wrote:
> > Moving the register definitions to a global header file
> > include/linux/designware_i2c.h. That removes the need to
> > duplicate them in the adaptation layers for this driver
> > outside of drivers/i2c/busses/. There is at least one of
> > those in drivers/gpu/drm/xe/xe_i2c.c.
> > 
> > Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Suggested-by: Raag Jadav <raag.jadav@intel.com>
> > Reviewed-by: Raag Jadav <raag.jadav@intel.com>
> > Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Andi, Mika, are you okay to get this merged through drm-xe-next?

Sure.
