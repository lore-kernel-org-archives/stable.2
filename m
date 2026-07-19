Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F18E380FC1;
	Sun, 19 Jul 2026 09:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784451990; cv=none; b=GrCqd6Q8ZXCpSSWxcppWEhJwQb6DOg5swo3VXs9+rnhJkjQu+XUynuxT9yZUnM3VcDPxKRbgolKe5HabUmiWdRcO6qkpfnD340bfmR4cgFzw4cZHcUtNQF0oDcBKYPJL+eLYgbIxLjgrfbuX85fzNtO4u4CTjuoSKwQaRD4nT+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784451990; c=relaxed/simple;
	bh=4aWAeNb/oSL2pfoBPYYIOOHxzj2oYaIRtHoMYr4CQCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FnuFvAwhtmkDBqBSR49jum8nkNS3+/ofGbRq6g0Td2pEyzHiyh6+lw903/E6g1DMpJCTtuqLAaxlQmqROEbQS+2DGgbf5mDPdSVIXYyoVwMimqy+wiwVZMUHPH2W1wg6QSOSlSpsj4cBJQ66Tvyd9D2cijVO9f/VA0XJsbjAYhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JeLyZu6T; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JeLyZu6T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784451987; x=1815987987;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4aWAeNb/oSL2pfoBPYYIOOHxzj2oYaIRtHoMYr4CQCo=;
  b=JeLyZu6TfYpRP37kAnsgZwB2K8NVtiVCz4ikQVIDIG2lNL4pDlx5bY6+
   bt8PgeM0DRqJL1k90zyq/nN6u+xrxKjUCGk4G1kZB7cfEpW/KTqmEH2oP
   kI6cuSt6C8Ldfo9CxXUyhj/Lf2G3y3WL5VFJjjKQN8rAuYnis/k9aavYs
   51c856+zX1gxs/kQcP7yvX040fkoINeboBrHdKvXIgEcQVL9L+gIFqate
   r7uds3UHWJtKrtMCA+/KAC2pbd0nn8QBSzUvASEfXZp91Frr6Z7N/RxRi
   H/1EHhiUNmL4LT9ViDQLOWaL+3DxBpiaRyRVAfQDJCoFpqw9YV1U5i1iz
   w==;
X-CSE-ConnectionGUID: JpKfVDPwRq+G7Q7stsTTjQ==
X-CSE-MsgGUID: yflLoVsDQa29JlBsVpBPvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11850"; a="72597673"
X-IronPort-AV: E=Sophos;i="6.25,172,1779174000"; 
   d="scan'208";a="72597673"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2026 02:06:26 -0700
X-CSE-ConnectionGUID: mINWedlFR7WkQwNt+u6bvA==
X-CSE-MsgGUID: 0mBTZbiSSOeGU6R7Z3wWSw==
X-ExtLoop1: 1
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.56])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2026 02:06:24 -0700
Date: Sun, 19 Jul 2026 12:06:22 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH] iio: pressure: dps310: fix NULL pointer dereference on
 ACPI probe
Message-ID: <alyTjkq2bCuTE3OO@ashevche-desk.local>
References: <20260719000752.75936-1-zoone.rupert@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260719000752.75936-1-zoone.rupert@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Jul 19, 2026 at 03:07:52AM +0300, Rupesh Majhi wrote:
> When the device is enumerated through its ACPI HID (IFX3100),
> i2c_client_get_device_id() returns NULL: the ACPI-derived client name
> does not match the driver's i2c_device_id table. dps310_probe() then
> dereferences that NULL pointer in "iio->name = id->name" and crashes the
> kernel during probe.
> 
> The IIO device name is always "dps310", so set it directly and drop the
> now-unused device-id lookup.

...

As a quick fix this patch is okay, the proper one is to go with chip_info
structure in the driver_data. where the name will be defined.

On top of that mutex_init() should be devm_mutex_init(), which is a fix,
and some cleanups:
- unused i2c_set_clientdata(); may be dropped
- C99 initialisers in ACPI ID table
- IWYU principle for the header inclusions
- some unneeded GENMASK()s due to use of sign_extend32()
- perhaps converting to use get_unaligned_xx() where it makes sense
- use time multipliers in _read_poll_timeout()
- use fsleep() and time multipliers instead of usleep_range()
- get rid of min_t(); perhaps replace with clamp() or min()
- use SI multipliers from units.h

-- 
With Best Regards,
Andy Shevchenko


