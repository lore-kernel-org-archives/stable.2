Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793086811;
	b=swbNtN+m4l7fiI/1gQY1aY62Q8GVMXcLgx6pPjHSRshugQcpQtdmI6caAMS5QTyz1UAw
	 vV3vqGSUDpy7KLfdRpVY76XKUSrYWVZEvc27FO93bm28x4bugFu2XAiLY+rYgE4sNZPPR
	 hup1zyhiWtVb0OzUW0ziun2c2L2qMHxPeLGxErFuib8aZg+29zQF9toZ2xu+GqNRo8m0Q
	 TQ520CtLRgo7zNbL8Pkm5HhDCqZQ9300/uZ3TUzqTZrSbgJD3POU8d1KRSajy2GIJWVWE
	 xCzaiyRFIY+XbjxJvL7CSuFefFpiDDqcuVpFBHd3CGJZONbtlrg0Q6w8R4zEofzrUqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793086811;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=zhzRbOY+f2fkhfI8wKvgdJCyZcEUpeNqMO1bmo1gL0Y=;
	b=K9Tzn2BMV5P7ihWtLr7oEeV8v6Okq3DmfZO6ed7sQIhfkHaHNQKll8vMFirOI+PPPPBj
	 GIjOLFtuSZJnWT5TrWTs5TxAMdhkmbjwwN53ylP/iwPrWBqgAVnAFWFL2FV5MVQ6cmRHS
	 440xAENVVV14szybBVCnc2mF4FknguyiSQvnxLEIPvj9/ipq62ltZheetYBKemBtHNbup
	 cvIw/w1h+TFqGVkM7IMiT+Fw2BHu1WBYkYGuc1QQgEaDHm3KntosuvEnvaoO4ewrJ7ud2
	 wdzZyH89dW0RXEu1yalHywC6rNmxXhNanWyLkJm4RYN3hay/ECB/ixclkFBpmiz+KaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nPs8ehIB;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFAF606A31A;
	Tue, 27 Oct 2026 07:40:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DFAF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nPs8ehIB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793086809; x=1824622809;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VOrxgR1L2PkAfv7reE/vBjtMkl1xSbA981UX2w0vwKM=;
  b=nPs8ehIB4AeZ0M6vKCh7dkreqSksv0tvhZiTHNIHfO2W6eY7wXmwKLZ5
   k04N2YBEK8OfaD2BudbMBLzIgCRXtokYnjoPznXWjtMJomJF/VWcacDWQ
   fUbdA3lQmaT43wfZbOnXx76QgEOP65hytf1CSp4wiSgBaT4lpyNW9dpH+
   KshxV0mk74HFAwcX7SmnvGy5Yb8GI9uOUXR0k5CDtNmVrma9mj01vvrWn
   7jKXiKmulyAGFd349no+OEmyZrOhSh4ZSPOB3tAeR6R0CbOg7L5Z1y7Hp
   tQBm8J8j6GJ0b/O2+2DqMzePaasNK+LuqieNTc8EEaGeFlsVOEEE3bUte
   w==;
X-CSE-ConnectionGUID: XkPr2EXzTPOAqbsznK9hww==
X-CSE-MsgGUID: F3CWHr5zSUqI0az6dp3a/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1689915"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1689915"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 00:40:09 -0700
X-CSE-ConnectionGUID: hUQzUt6LTd2GxtwR6NNHmg==
X-CSE-MsgGUID: wU/CpHueSe2bzmMIPEj2qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="4865936"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.196])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 00:40:07 -0700
Date: Tue, 27 Oct 2026 09:40:04 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Tristan Madani <tristmd@gmail.com>
Cc: Marius Cristea <marius.cristea@microchip.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	tristan@talencesecurity.com
Subject: Re: [PATCH] iio: adc: pac1934: validate ACPI _DSM return type and
 bounds
Message-ID: <auBVVIuIPhZZf9OH@ashevche-desk.local>
References: <20261026230910.2569782-1-tristan@talencesecurity.com>
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
In-Reply-To: <20261026230910.2569782-1-tristan@talencesecurity.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 26, 2026 at 11:09:10PM +0000, Tristan Madani wrote:
> pac1934_acpi_parse_channel_config() calls acpi_evaluate_dsm() four
> times to read channel configuration but does not validate the returned
> object type or array bounds:
> 
>   1. No check that the returned object is ACPI_TYPE_PACKAGE.  If
>      firmware returns a different type, accessing rez->package.count
>      and rez->package.elements on a non-package object produces
>      unpredictable values.
> 
>   2. The loop bounds use rez->package.count directly without capping
>      to PAC1934_MAX_NUM_CHANNELS (4).  A package with more elements
>      than expected causes writes past the fixed-size labels[],
>      shunts[], and active_channels[] arrays.
> 
>   3. The bipolar and sample rate DSM calls access elements[0] without
>      verifying package.count >= 1.
> 
> Add ACPI_TYPE_PACKAGE validation after each acpi_evaluate_dsm() call,
> cap loop iterations to PAC1934_MAX_NUM_CHANNELS, and verify package
> count >= 1 before accessing elements[0].

...

>  	rez = acpi_evaluate_dsm(handle, &guid, 0, PAC1934_ACPI_GET_NAMES_AND_MOHMS_VALS, NULL);
>  	if (!rez)
>  		return -EINVAL;
> +	if (rez->type != ACPI_TYPE_PACKAGE) {
> +		ACPI_FREE(rez);
> +		return -EINVAL;
> +	}

So, what's wrong with acpi_evaluate_dsm_typed()?
Ditto for other cases below.

...

> -	for (i = 0; i < rez->package.count; i += 2) {
> +	for (i = 0; i + 1 < rez->package.count &&
> +	     i / 2 < PAC1934_MAX_NUM_CHANNELS; i += 2) {

This is ugly and inefficient. Why can't you just check count to be even number?
Or choose the limit in the loop making it an even number?

	for (i = 0; i < (rez->package.count & ~1); i += 2) {

>  		idx = i / 2;
>  		info->labels[idx] =
>  			devm_kmemdup(dev, rez->package.elements[i].string.pointer,

>  	}

-- 
With Best Regards,
Andy Shevchenko


