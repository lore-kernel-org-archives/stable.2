Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793177923;
	b=FRVFZB7M6Ydi3phBcMoj0GsNV98vclLRpPl/9CS+LYqG7SQzDHy4kXKkasIuynu0iy4k
	 4GyZyw5ISiYTRApbHJX5JLanCrO7KbUVwB0I2HkUNEBDAiQfdY0j/oQ0mgdzoCuj2ayhN
	 f4GA6rw9pGFpClDfKf6ppDKvNQuKWf0tZdLa1S8oXv+u4a1F5zBYu+CT6vxLh3EF/enWA
	 HMysWh7DcskmfNiuGWe30Lum617WJnmsC7/XfNniZA+RtUtDxxpkOa9TWY78opSZuUc3k
	 r8wnl53wU1jKVY4C6+05PTiAY+o3au+6SkBxrzgGzhw8fz11XIVXM1n4P+kyltBO38w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793177923;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=hyZ5Lwu8SMBVRBwLh8kZgA0sCCYpIwKQI8+279KkkiU=;
	b=F7kwlfakVCXlKVg9zqcGA7cJIVPPNqZFBRtpWuvI/X3ehZn/m54D1qyVK0ynJbGnzxN6
	 ShALoQtEGEjo+DvLjW1gNRPHgj8KfUBnwEi8nFsjwahm7ObCm40quTHU3HBvIrOUjCBab
	 8aERiDUUkgbLJfZpJpKqWbHMc2WajtL0z6A76CATCY+olAD1PvOsG22rdaVoq1qnA9OZi
	 ZqFUBjjNkWZ7jJhFXhFYCwy4mUjUw4vY90FkaN6WFGrkPWlffwcbQ3USigb9T17xM/lrl
	 pYQsrvDtCI6XjdoQXzA0kKAPQOpYKbLB5k1NJu7+LNyerLYPCZS3MWMQufoMT0tSixg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ps4tImTM;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6C8606A31A;
	Wed, 28 Oct 2026 08:58:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D6C8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ps4tImTM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793177922; x=1824713922;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n4vzte860tEFDWBsmPV9qA1KRJ78LNoSE1oRaVJEtMQ=;
  b=Ps4tImTMCGqdV/4slmJFgaFjX8bSrANRM8AbW5sFTYhqQ1ZsWLCN3lH0
   eZcqjC5qklYg9vJJAIxuv9v3rDLBlylANEtdSbAa68y3xMGHHQ4niyD8p
   Ej8K3yn9IGFxjoUB+MsKufy2cGgST4SUM4UTNngkAFpXqh++Ba1IHpn87
   TGdRrqs/z0zDhYqv3B0hgr6jnbqgyV3qFD1YW53SF+go0KOXW+3GZueXi
   r3p4uVQQo16lX6NInGtIpNJE32WnBakm2Pg9h1JAQRKUh6HLZ3op48KaP
   z3mTjC4u8udXg9whzNnoijBiwy0pDJyViIvicxozBSIjSNzhFSUVKifop
   Q==;
X-CSE-ConnectionGUID: 2m6vB2JFT22fEIJO6UoDrw==
X-CSE-MsgGUID: EtiD6Oy4R9iTI4qTTybC5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1880375"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1880375"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 01:58:30 -0700
X-CSE-ConnectionGUID: PDRaA+LHTs+SxbUjqibCiA==
X-CSE-MsgGUID: AaUISLVcSEihYf+6KxOMbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="4768897"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.117])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 01:58:28 -0700
Date: Wed, 28 Oct 2026 10:58:25 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Liu Yufei <lyf98405@gmail.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Gustavo Silva <gustavograzs@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: imu: bmi270: fix zero timestamp in triggered buffer
Message-ID: <auG5MXTh9ZkXMw55@ashevche-desk.local>
References: <20261028-bmi270-fix-timestamp-v1-1-99c0e5fe7d0c@gmail.com>
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
In-Reply-To: <20261028-bmi270-fix-timestamp-v1-1-99c0e5fe7d0c@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Oct 28, 2026 at 10:59:26AM +0800, Liu Yufei wrote:
> When the device's own data ready trigger is used, the trigger is
> polled with iio_trigger_poll_nested() from the threaded IRQ handler.
> In that path the pollfunc top half, iio_pollfunc_store_time(), is
> never run, so pf->timestamp is left at zero and every sample pushed
> to the buffer carries a zero timestamp.
> 
> Take the timestamp in the trigger handler itself and drop the top
> half, so that a valid timestamp is provided for all triggers.

...

> +	s64 timestamp = iio_get_time_ns(indio_dev);

Do we need this variable? Why not call it directly?

>  	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
> -					   pf->timestamp);
> +					   timestamp);

					   iio_get_time_ns(indio_dev);

-- 
With Best Regards,
Andy Shevchenko


