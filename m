Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795433482;
	b=Q9PFGWlSH43AHdIElp5zfZVarCb6Iwf9405wEjJtv3FUprbh7Ni1M57Dd42hGRvDhV/s
	 UU6jW/oNHydKtgUFRqi4PIypF52Yi4xraVZGKVNg/sBx/DzJa1ieL0fJrXBZnGFXK5U0t
	 wop3wG0BihRJDGjb4ZmiWyb+U3ac5wWjuC0kNW0xoCjZnik1wsLkpUL42/3O90f92DKM3
	 c5D/nwgQ+hZOlRi4skqioFKmzmACpevu1OQwEtm7+gKe6+BPfep6sSBxCzSyeayYQ2p3q
	 LfxeO0DkwmrAY55F7mSeEXH9Ys0vdMidFO8SZXLuRal5pI3GzYOg3nQDNnNZo/lAXwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795433482;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=yfrlej6qyd4zr3J56wD+mtwsn9dmfEHw/O0sbFEMubM=;
	b=0x0G+Mych96kO4YuQvwiTudJ0JSlWHXVPCg/N1VHCrSuYKnAb1gUWSCeHf+3I2RIQShS
	 Ful4/gZ9vyRh/Q7mqr6P82AQVV3uAX6SpGfYE4BThgvsL1M26pXSM+76l+YwMJAJ+1ZHE
	 92zd+d6e4YlGF9YOOcTrD6xsOqEv838vDCx1DrqwS5owJgJXnbrkwPjYEOYGMUNTs67BC
	 yJ07s5NR6YFo9zoaXKLpTy8dg1XKn4eg2eJ7BO98qBP+nZH+cPDTzleazhJDUNG9U41Aa
	 0283tEubAvw3HgeBz0be+60iNpA5Z2njKMbr/PsUsw6FcrSGk5+sGucp3hix+3diiGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mBzJ9ssv;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073A6606A31A;
	Mon, 23 Nov 2026 11:31:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 073A6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mBzJ9ssv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795433483; x=1826969483;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=buSJuJMS4qx78LvNp3wcNBjX6N049hlAhRKf7lhMUi0=;
  b=mBzJ9ssvBzpDhoqszFCNS5sCrhq1rmkFUWdeWXIV0Imi+kEYWMWb8RWs
   867FfEkYAnP+KCUcZ06tNG29ncjFZBm5V+LuT4UdLX6mTNcpdxkdcHkKU
   1OtbQyrYEOBq4XaraZ9DXbW3mXBapw9YMNBrjNBy/LEu7WFd0OC/wrqDt
   PEf6UADjdRMtER85Q0YJebd/nn9I3PilrslW6bt7pK/qkUcxnpWQu7QPg
   /6oa3VPDzgLfb2geNxLQ3dMaTlWWirKCWnS2R3LRTV4JOyNXftphU+g32
   RA3ImHYDuJaEM5RIPXN6ptc2z7fTbBJafJfQWcb46yYyMqHjFq/gqV07U
   w==;
X-CSE-ConnectionGUID: MN8xuuXsRZOv9PkqbQtikg==
X-CSE-MsgGUID: D6AIdkSCQta8wF9I889DqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4324865"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4324865"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 03:31:22 -0800
X-CSE-ConnectionGUID: NQ79MQVYQL+tyEKxworH9g==
X-CSE-MsgGUID: acwzS4tyRFWTrLBXkeTjTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="11612293"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.204])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 03:31:19 -0800
Date: Mon, 23 Nov 2026 13:31:16 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Lee Jones <lee@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Mathieu Othacehe <othacehe@gnu.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 7/7] iio: proximity: isl29501: Fix division by zero
 and overflow in isl29501_set_freq()
Message-ID: <awQkBAEaRuPqR3vb@ashevche-desk.local>
References: <20261123075122.373060-1-lee@kernel.org>
 <20261123075122.373060-8-lee@kernel.org>
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
In-Reply-To: <20261123075122.373060-8-lee@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 23, 2026 at 07:50:33AM +0000, Lee Jones wrote:
> isl29501_set_freq() computes freq = val * 1000000 + val2 % 1000000 in a
> signed 32-bit int and passes it directly to do_div() without checking
> for zero or negative inputs.  Writing 0 to the sampling_frequency
> attribute triggers a division by zero in the kernel, while valid
> frequencies above 2147 Hz up to the sensor's 2222 Hz limit overflow
> signed int.
> 
> Validate that val and val2 are non-negative, compute freq using
> HZ_PER_MHZ as an unsigned int within [1, 2222 * HZ_PER_MHZ], and return
> -ERANGE otherwise.

...

> -	int freq;
>  	unsigned long long sample_time;
> +	unsigned int freq;
> +
> +	if (val < 0 || val > 2222 || val2 < 0)
> +		return -ERANGE;
>  
>  	/* sample_freq = 1 / (0.000450 * (sample_time + 1) * 10^-6) */
> -	freq = val * 1000000 + val2 % 1000000;
> -	sample_time = 2222ULL * 1000000ULL;
> +	freq = val * HZ_PER_MHZ + val2 % HZ_PER_MHZ;
> +	if (!freq || freq > 2222U * HZ_PER_MHZ)

But the second one is implied already by the val validation above, no?

> +		return -ERANGE;
> +
> +	sample_time = 2222ULL * HZ_PER_MHZ;

Taking this into consideration, perhaps not to touch these lines at all?
Just add a check for 0 above?

	if (val < 0 || val > 2222 || val2 < 0 || (val == 0 && val2 == 0))

?

-- 
With Best Regards,
Andy Shevchenko


