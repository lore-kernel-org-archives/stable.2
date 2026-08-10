Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19979442FB2;
	Mon, 10 Aug 2026 19:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786390540; cv=none; b=H6apg3VtXgH7Ms0hZncdpip2ms+vVOXFUFTLl+pfOomBiz9Egs/2R2zdbT06n3gT/0Zw1uxFE3EROv4ijbb3z9WHKczlm7wQAZ9VrC0Hi/iYJbuaFsSD6166NX0r8Tgh1N5S1KRxJjkgjIbXpyCkyw8C89hwudvPYqrfIAQ1f3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786390540; c=relaxed/simple;
	bh=1rln9h0th9UT2H7asbAR35WQMctyOCvsCuzZ/4SDAWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CL4j4LjUHGOQDEtC5mjYhLOBngLgk+TAlK/xMBJMZrmzEVhF9z/cr6HM/crwFldOlPkAQUaD6UFUup0CK729MHzjfLv60e1ihwJuCNV0Q/BMK4U2LNYhqCgUoiioLAhNkhu+YyZ1yem1q8G3gCxfaRAd9/Ajqjc7l8/gkmd1WNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e4vSDKX/; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e4vSDKX/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786390538; x=1817926538;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1rln9h0th9UT2H7asbAR35WQMctyOCvsCuzZ/4SDAWI=;
  b=e4vSDKX/sn/0kFY1VTfF3JGZaRjDh9KfzFv2jrDj9BzOKXd3zFfYo0H2
   xr6/K1zlbfqzeUKeT06ULkm690hWBPvS8TKqKkKiyjq88g1X7wXvnVFrZ
   2HsHoK2/gXBYeUDJZfQQENakYJGQ8bTsw/gFdltoSVV1vopt9sgQFmPX9
   p2bh3E3rOCsWi5X93tr0Apxa047o+XPU30NwN4mCURR/tToR7L9LZhrDc
   H/I90+NQZlHwLnik5DVCvonM29oI2tK+9h+ZG9B140aKOItglJq1MLRo9
   p7tbv//Yk+k6xNLRtgfkM+cJGF66+aqOsL6IYy4AP2zeifYAaLW3My/Pk
   Q==;
X-CSE-ConnectionGUID: 3hPSZcIZQkCPDQU1LuLsNw==
X-CSE-MsgGUID: PHPv2vnuRnaPh6jaWVLAyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="98275564"
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="98275564"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 12:35:37 -0700
X-CSE-ConnectionGUID: s2lD62tCSK2AhYshBMXk/Q==
X-CSE-MsgGUID: jwBTRbH0T6yvGJWhW1OPqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="259280283"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.99])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 12:35:35 -0700
Date: Mon, 10 Aug 2026 22:35:33 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hui Su <sh_def@163.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: pressure: bmp280: fix out-of-bounds access in
 sampling frequency lookup
Message-ID: <anooBVyIlGojG06D@ashevche-desk.local>
References: <20260805074127.473731-1-sh_def@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805074127.473731-1-sh_def@163.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 05, 2026 at 03:41:27PM +0800, Hui Su wrote:
> The sampling frequency tables store each frequency as an integer part
> and a fractional part in micro units. num_sampling_freq_avail is
> initialized to the number of flattened integer elements because
> read_avail() returns the table as a flat array.
> 
> bmp280_write_sampling_frequency(), however, indexes the same table as a
> two-dimensional array and uses num_sampling_freq_avail as the number of
> rows. This makes the lookup walk past the end of the table when an
> unsupported sampling frequency is written.
> 
> Convert the flattened element count back to the number of rows before
> iterating over the table.

...

> static int bmp280_write_sampling_frequency(struct bmp280_data *data,
>  					   int val, int val2)
>  {
>  	const int (*avail)[2] = data->chip_info->sampling_freq_avail;
> -	const int n = data->chip_info->num_sampling_freq_avail;
> +	const int n = data->chip_info->num_sampling_freq_avail /
> +		      ARRAY_SIZE(*avail);

For the consistency's sake use just plain 2 as initialisators do.

...

Nice catch! This seems to work because the page is present, but after this
array it contains some garbage that doesn't induce page fault, otherwise this
must have led to oops very easily (and no one reported it before).

-- 
With Best Regards,
Andy Shevchenko


