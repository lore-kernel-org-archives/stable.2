Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702389;
	b=oxB+MsoYGfO9+TBnUarAhl7Cikt8L+OszE2Wz/z8efCTW+DtWsQOHaOylF61pIqTkCDF
	 kpwVUKLu1TyxaOFCsvIOPk5jToep3kRma5taWRgchEIKs9z4obKB3Ek9fcLFPYEJLagEr
	 T2ZdUBl8Ycv4sHhoCp39j/SUnYwCBqTwzfNdjtO9SsYXJX2UfqtiOtqxDfAgK2lyQaUZf
	 +vsWJhUtDhtKNIekamLxRhYk8UrCtP7u5KLpSi+cCKWjBLG7vPYVaFl2eM71XsJuJb+WD
	 kSt23dAZ22/5AbYV1W4x8IPEf1yEa9PROuHKcTzMqzbc6MnmoDEFuI3jkifkTSFKxnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702389;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=es1dRp+nmR3wTyijhs0uDXN9nhs9m30oWm2TPAcAJZI=;
	b=KOUD77IbBOsC6jkji/G9Wv8/W1vcaoR0gxuUyLG/XaLobOphnwyPk47OfTq4ASUt6x4J
	 DBXKwdkp6hb/pBGsZSROfDoPM1k9YlarJJJ5SZbSpw1zB0deO9fcdzeFR2t8csfuQnJKv
	 ILnN8fLw1R3J0spea/GG2O6idTpPlVfmr6Ho9XUMR4nZDOYKvrhP8S7F3vw/Jm43oiwjS
	 2RWiiQ95Bmi/mdXBAaaJqm3MfrxzicwE6f2hdZMtWUHBC5dXexWGXtp0O7NHgNSWeNhFD
	 iYNug1Tw1z0tkNo41T7HvaXQIvFNaZbXb+p9RlEzDAYy08kzVj+gSNRLBBEu6G4Af1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fjRkmWG7;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43128606C5C2;
	Tue,  3 Nov 2026 10:39:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43128606C5C2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fjRkmWG7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793702388; x=1825238388;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6Lxxw+t4l7aMoqnSZ1WF3pHvo+Vr7obYg4glBpcmk/g=;
  b=fjRkmWG78k+ExPe3yI5u+lzzGwK4sM3fSPGf3iU5TmncDVX2oqYBUf/n
   PJTBwpiPv+LODX8c986HVVrqwsNh0VTYS/x85sp0HKcaA/csYSj+oUaxg
   3eRZnre7EM2o1q0nsJuUTv8GjwhJFOWS2FTJil7J0AiYFUPw30rOzFkSm
   4pcMEB2GKCgDdqp35/1Tt4812XVxGMeuyfIbrMDES03ysB87LHjhyzuDD
   RWWO8Rm0fSKGfMWvuJQ/eR5sUAkB/GBDBLVohA4g6zUt3BJtlnkh3qsiR
   cz4xtetw/Gbsgn2NU2qRuKv9c/GifxLSup8hTUdZqyMYs13Ws2vaWHxaN
   A==;
X-CSE-ConnectionGUID: ZxpVm1+qTtWZafJOaCHt3A==
X-CSE-MsgGUID: j8+PFVaNSdqDVgI684b3Gg==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2428040"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2428040"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 02:39:47 -0800
X-CSE-ConnectionGUID: 07pBhRz2TESPSbWErKskxg==
X-CSE-MsgGUID: 8rBMWhjmTpS3vbKNmAWdGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6235417"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 02:39:47 -0800
Date: Tue, 3 Nov 2026 12:39:43 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: jic23@kernel.org, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: hid-sensors: fix fractional part for unit exponents
 -7 and -8
Message-ID: <aum57zKQwN2nJCAg@ashevche-desk.local>
References: <20261102222309.439895-1-srinivas.pandruvada@linux.intel.com>
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
In-Reply-To: <20261102222309.439895-1-srinivas.pandruvada@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 02, 2026 at 02:23:08PM -0800, Srinivas Pandruvada wrote:
> split_micro_fraction() scales the remainder to micro units by
> multiplying it by 10^(6 - exp). The unit exponent of a HID field goes
> down to -8, so exp can be 7 or 8 here. Then the argument of int_pow()
> is negative, which the unsigned parameter turns into a huge power of
> ten: 0 modulo 2^64. As a result, the fractional part of a value read
> from the hysteresis attributes is always reported as 0.
> 
> Divide by 10^(exp - 6) in these two cases. This matches the reverse
> conversion in convert_to_vtf_format().

...

>  	*val1 = no / divisor;
> -	*val2 = no % divisor * int_pow(10, 6 - exp);
> +	if (exp > 6)
> +		*val2 = no % divisor / int_pow(10, exp - 6);
> +	else
> +		*val2 = no % divisor * int_pow(10, 6 - exp);

Please, make no % divisor to be in a temporary variable. It may lead to

	foo = var / div;
	bar = var % div;

compiled to the single assembly instruction (on x86, for example).

-- 
With Best Regards,
Andy Shevchenko


