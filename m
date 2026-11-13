Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794572013;
	b=Oc4HI3JCtjKe0sFCsHn9B0jp/xgi96J5ANMvEXWQQWoBV7ngyH+DQDiYsz0VfCDsVaee
	 mje8wfoTJGMJBeONEOOFKmbV0d+Z04Mk10zmL5Om7YeJMvkxP9wkZl50f6s0Mt3xmOeuK
	 EjeRjwZpuBchApqu+X78Jq45yaGLGiS4v1dzmrtoVm2dz+a7NVJAB+/bSZLSQDOLfQdMi
	 2IZg0NWZXzWg0CznsZQua4gbciMcA9i9wjLRWnetXQW2Uy1uSLTn8DquDNEBmU/tvcxD9
	 SOrYR640Rp/Z7BrGajVAtNU8OZ1MpvWlM9sBFkDQigLtyHujc8ghoCC5jXsyGwDrvjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794572013;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=1iUZT/JRKjiRUq3S3wXoQz2Mr1XA+Ebv5deNzL+Hfx0=;
	b=yCo2AbfbH8AWbbZit1IPUaz6n/hvQNowYtE+JISkoL/3f8k6B+owzv9+KiUg2LWGxzxZ
	 WFMJxMYWQJuhmE0lwZb6Fy5BheQeASXyrzo5PsCYMWyAtTn0TcjS3zAQlojq2DVnV0+LU
	 5UuF9iyiJtjW0045KIbccDDpdwUDHg+OptxMbxOL/lETx/xEK/FNMADmja0UC+lTRa8M1
	 x8apZz7vAlbbQVm1+a7ZkuIQBh8rJu871dgsc9Xvc+rlB9EBXrq8RRnAmgWqmawi0qLiN
	 idNGJWf7zfEMek74lZ0ZP0Mt0eMeVrx4aHoVZ6hAJ4nULyqDg5hOZoi0OqLtDzV3EIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Fuo0fjLv;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2F2606A323;
	Fri, 13 Nov 2026 12:13:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A2F2606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Fuo0fjLv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794572012; x=1826108012;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rHH8i6Jaj4wG/QVHWjBNd4UsOpx6pzu7l9kaAO5hq6U=;
  b=Fuo0fjLvrze0KqzVK+2WW5qq3YrJg3MdGtNA39cv01DroWDEJIVZUlKg
   Mas+DEnMhGP+u4Ztz9wGv0+kdrq6Twrtf8QnLEaKpz8U9ZmU+Lrr7NPpn
   iCR/36fV9rgnJ4qAeUT++pIX1YkkvYUtcMunBIf1FSxxgfjOv7iPikg8D
   CmSLawqPsfg6JsrlPhwmSMfBwD4FTIba/TSb92BmwhuMh3HfuW5c9sdKi
   Om9xhJYSrbe1qVU8mhiX+IWWRvT4H5GDHj8gTN3d6vVd4sS3mrJW8noL8
   OHfNDRb1yO3GVh3HJ8sMu27T2EER0vlFi6xvzCnEftHFeItXH3wGQMXNv
   A==;
X-CSE-ConnectionGUID: p+P7pV79RzyZfgAi3G1pOQ==
X-CSE-MsgGUID: Q6NfsCNGQEGZ/JXhSkYnMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3385781"
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="3385781"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 04:13:31 -0800
X-CSE-ConnectionGUID: TtlvUlykT4SNAU2R1Isc5g==
X-CSE-MsgGUID: iB+z62UDSbW0eDhITPJ7GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="8834698"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.148])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 04:13:28 -0800
Date: Fri, 13 Nov 2026 14:13:26 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: lee@kernel.org, maz@kernel.org, andy@kernel.org, jic23@kernel.org,
	dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
	mfd@lists.linux.dev, linux-iio@vger.kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/2] mfd: mxs-lradc: Pass parent IRQs to child drivers
Message-ID: <avb-5lw3JHpfmIlz@ashevche-desk.local>
References: <20261113013212.470981-1-festevam@gmail.com>
 <20261113013212.470981-2-festevam@gmail.com>
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
In-Reply-To: <20261113013212.470981-2-festevam@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 12, 2026 at 10:32:12PM -0300, Fabio Estevam wrote:
> The MFD driver stores raw DT interrupt indices in IRQ resources but
> registers its child devices without an IRQ domain or IRQ base. The child
> drivers consequently receive the indices as if they were mapped Linux
> IRQ numbers. IRQ index 0 triggers the platform_get_irq_byname() warning:
> 
>   0 is an invalid IRQ number
> 
> The children then try to recover the indices from their resources and
> map them against the parent OF node. Besides duplicating IRQ names in
> the parent and children, this relies on invalid platform IRQ resources
> and fails when IRQ 0 is rejected.
> 
> Resolve the interrupts with platform_get_irq() in the MFD parent and
> store the mapped IRQs in the shared LRADC data. Drop the child IRQ
> resources and duplicated name arrays, and have both child drivers
> request the mapped IRQs directly. Use the MFD memory base support to
> translate a single relative memory resource shared by both cells.
> 
> Tested on an i.MX28 EVK. The mxs-lradc-ts driver probes successfully,
> touch events are reported, and the touch-detect and LRADC channel 7
> interrupt counters increase as expected.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

Thanks for fixing this, I hope it will be applied sooner than later to reduce
the number of weird cases in the kernel.

-- 
With Best Regards,
Andy Shevchenko


