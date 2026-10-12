Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35543B6360;
	Mon, 12 Oct 2026 20:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791838556; cv=none; b=DvQXYppyis55PzLuVkAMq5oSlMAgSiG+GrEzmRd93x8LnrjWjyjrPHFspryt2knXQ9jmAsVoKUwiyxTziN7i1scWc7gVzwI4COyLI+emYfbhbNVRvbPGqIuDbFQqFN5FvFKPBiSHvEYzOPx7BWCZQFArxPtLnWo0KVwvWt7QaBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791838556; c=relaxed/simple;
	bh=+nfZABIaUamH+2DRheHYOScZlicKn7PcPmYphZR7ovQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pp8wF//d6GR15RkrqT5npmLclKeM8koKnr3CR69BE0qBKyK0vHjYuXhaNpqa4U/QT0nZ3lkhtfwwTaClymANgs3lw6eo6iSqQm+A/ph/YZan2lpacLZ60M09N3mHS5KqDuAUv3Raz7j50MqDOrjQhSohCmilhsfKYuNmG70qLP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dr50EHkp; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dr50EHkp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791838554; x=1823374554;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+nfZABIaUamH+2DRheHYOScZlicKn7PcPmYphZR7ovQ=;
  b=Dr50EHkpbAH7Ys5AgGYfpI85TsjfMiMzkhdXKQnQP3rcGfO4mjXbei8m
   NenJdkBlhCzTmWa3os2zziYEYTi5wkzM4UMs5XYLrKcxc5eTU3fYSYedM
   FWptEBPh5HKPq2SU78mYB3Apbl/5Na89/3M2Qd/XsMc48tRZnONzE5M2L
   WXLPs8+yCnFv570YiRgNCKzPk0U3fI7NVjDSqZvQvBsLHRhxaUNFXleZH
   WpD6oZzhPuNNDTNgt+WtfAA6mdSYUhL/na9NiCfRhWGLaD5ud1t0KUsa/
   WWJiEIYsjfa08UcOfNDzjr2JDbP97bj9pvRFfQRLq9prhXZE7dflc/vb1
   g==;
X-CSE-ConnectionGUID: FNBXsPauTr+Fo9MKH0ZuFQ==
X-CSE-MsgGUID: T4E6E/QqSMWdN4dBbAJZnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="443606"
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="443606"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 13:55:54 -0700
X-CSE-ConnectionGUID: 669eaP5UQU+FxR9dDhYXTg==
X-CSE-MsgGUID: YaH5e3m1SdyqKynIfkAwAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="1079536"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.179])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 13:55:51 -0700
Date: Mon, 12 Oct 2026 23:55:49 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Yu-Hsiang Tseng <asas1asas200@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: acpi: Accept comma separated values in ROTM strings
Message-ID: <as1JVWC8FiN704Uj@ashevche-desk.local>
References: <20261012074144.1060625-1-asas1asas200@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012074144.1060625-1-asas1asas200@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 12, 2026 at 03:41:44PM +0800, Yu-Hsiang Tseng wrote:
> The ROTM method of the MXC6655 accelerometer on the Higole F9B, an
> Alder Lake-N handheld (AMI BIOS F9D_16G_P800217, DMI strings are all
> "Default string"), separates the values with a comma and a space:
> 
> 	Method (ROTM, 0, NotSerialized)
> 	{
> 	    Name (SBUF, Package (0x03)
> 	    {
> 	        "-1, 0, 0",
> 	        "0, 1, 0",
> 	        "0, 0, 1"
> 	    })
> 	    Return (SBUF)
> 	}
> 
> iio_read_acpi_mount_matrix() only accepts the space separated form used
> in Microsoft's example ("0 1 0"). It rejects this matrix and mxc4005
> falls back to the identity matrix:
> 
> 	mxc4005 i2c-MXC6655:00: Incorrect ACPI mount matrix string format
> 	mxc4005 i2c-MXC6655:00: mounting matrix not found: using identity...
> 
> With the X axis not inverted, iio-sensor-proxy reports left-up when the
> device is held right-up and vice versa, so the desktop turns the
> picture upside down whenever the handheld is held in landscape.
> 
> It is not the only BIOS written this way. The BOSC0200 on the AYANEO
> Air Plus uses commas in its ROMS method as well, with a space before
> one of them, and its ROMK method has "1, 0,0":
> 
> 	Method (ROMS, 0, NotSerialized)
> 	{
> 	    Name (SBUF, Package (0x03)
> 	    {
> 	        "-1, 0, 0",
> 	        "0, -1 , 0",
> 	        "0, 0, -1"
> 	    })
> 	    Return (SBUF)
> 	}
> 
> The kernel's sscanf() does not support '%*[', so there is no clean way
> to take both separators in a single format string. That leaves either
> a second sscanf() call with a comma format, or normalizing the
> separator first. Do the latter: turn the commas into spaces before
> parsing, so the existing "%d %d %d" format, which already takes any
> amount of white space around the values, keeps working unchanged. The
> strings live in the buffer acpi_evaluate_object() allocated for us, so
> they can be modified in place.
> 
> With this change in_accel_mount_matrix on the Higole F9B reads
> "-1, 0, 0; 0, 1, 0; 0, 0, 1" and, with no udev hwdb override, the
> desktop rotates correctly in all four orientations. The AYANEO Air
> Plus was not tested; systemd's hwdb has an entry for it, which
> iio-sensor-proxy prefers over the kernel's matrix.

Makes sense, and fix is neat.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


