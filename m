Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890395;
	b=WnpKyaQBt8qd3Oht1SdE2Cyj5Tf6FW92u/fEZvZtDlS6umDt5NQU2q4GNMzlVqxQb17K
	 xJZ8ejpYvexf1Uiqp87AVfd8G2AUxzqN/+ICFWUSnrUW7Vzf9aby07aWJ8FZKqBCD3K1g
	 KQB17+ydxPlaeOiadABFXjuGc+S54o7D6uOpFp72WzoiolpTceZw8tORh9fE+TCbNi3fm
	 SMMODQPleY36r9+GaOho5IyCtMBxHMU24dQyq1mftvBDtCSoaZYWzsz3hrhJIu10ERq5U
	 Ea7ktwNPf5FcTwz+A3oyFcXlT+u+C1g+a7zsBJYK8xoxJsQQUxzfeVw4CB5l1CmB/AA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890395;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=O5hH3VfyULzh0DN1X+8MY3AyC3KeT6fXdQrbN3Uw/b8=;
	b=ystrnTyDRGsr+BLrPH8hjRRsrpywfVWThl84EulhQM4n4rOvHep/+qF3nsEEYMVIFGBU
	 x53kqC3G6qN8vZWUCutJ5RZnaLQhZb/Kkz8rwC4NcbOVQd+GK2B4l2YuwFSCspqRiSFq7
	 1U4VL4g0+MIrBFsa5SNL+AIsnN7cvruOwl78e0r1NWbSD79BKP3i5iV7msgnQeEIdkfDk
	 7wQUi1EG1+a+A4In5bdzMmJMaiKS8IlQZndrG8E0Vuh7C5GY6Ll2a+P4UjWYCbK63iWye
	 lR1/q4FNCwpjCYnMgkILiGkxGDVL3PiHdYgt0w5bY7AxN5o0dgaaFN5EJG+eS8E6uCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XWivxVJO;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A067C606A31B;
	Thu,  5 Nov 2026 14:53:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A067C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XWivxVJO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793890395; x=1825426395;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QMqDS3LOi71OKtkWUaXE5hLFpSteQzGSoTt3Q02rIfA=;
  b=XWivxVJOwVoc2+I6t1A6j2MlFlzlxhhC0UQ6d+KOrm+VM0md31AON8im
   uYlDLSzvXnDh2fRnDCZohZz3JfjDyeCv7aSkP8M8M5DL0aLRaqGBBlNqI
   8Xbz/jG9rqgQvPuj+jU0kMzwEu5pvFfUBh6EZrJSGOIjHnuDf8WTaq8vJ
   EdLkWxBAc475kRdQr2KrOXw205yTUUajzxskPL8r0jmGNEuKeQGt1fNiu
   M9He3oLKDaxjVzsAGqCfEOPkKUbTnMju3r65eSXJT2kUbim/b6zTbkACV
   4VJuDBzCt0r/Ei1ao2hibuNY3kMmVP4YY0r2pq7iQAQGJ5R1ApBWBfpJr
   w==;
X-CSE-ConnectionGUID: z2RzWl+yTBCSOf9gonjNKw==
X-CSE-MsgGUID: Dgqn15+FTAOfGedup2y+cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2705839"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2705839"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 06:53:14 -0800
X-CSE-ConnectionGUID: cEb3y3+mTju9ELfFRG3m4A==
X-CSE-MsgGUID: YPcdfl0VTOu5ZX8ya3qKig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7371167"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 06:53:12 -0800
Date: Thu, 5 Nov 2026 16:53:10 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] gpiolib: synchronize updates of descriptor labels
Message-ID: <auyYVmSaLBS--52n@ashevche-desk.local>
References: <20261105-gpiolib-set-desc-label-corruption-v1-1-fa84726ceac0@oss.qualcomm.com>
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
In-Reply-To: <20261105-gpiolib-set-desc-label-corruption-v1-1-fa84726ceac0@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 05, 2026 at 02:23:45PM +0100, Bartosz Golaszewski wrote:
> desc_set_label() swaps desc->label with rcu_replace_pointer() but
> without any synchronization of concurrent updates. The swap is a plain
> read + write: two threads can observe the same old label and then call

s/call//

> call_scru() on the same SRCU head corrupting the state of the chain.
> 
> Add a spinlock to struct gpio_device - we're using a single spinlock for
> all descriptors as using a per-descriptor lock would unnecessarily bloat
> the size of the desc array with very little chance and no consequences of
> contention - and use it to serialize the pointer update.

...

> -	old = rcu_replace_pointer(desc->label, new, 1);
> -	if (old)
> -		call_srcu(&desc->gdev->desc_srcu, &old->rh, desc_free_label);
> +	scoped_guard(spinlock, &desc->gdev->desc_lock) {
> +		old = rcu_replace_pointer(desc->label, new,
> +					  lockdep_is_held(&desc->gdev->desc_lock));

Can lockdep_is_held() return anything except LOCK_STATE_HELD here? Or is it
checked outside of this scoped_guard()?

> +		if (old)
> +			call_srcu(&desc->gdev->desc_srcu, &old->rh, desc_free_label);
> +	}

-- 
With Best Regards,
Andy Shevchenko


