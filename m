Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795109523;
	b=JGZpLF9jzZTTVaW6tEBPLMkulTSmlc2eMNxvBoW+fgHWKQyRvCtXoOoEWhNhY2aWxRLO
	 uMzaJNZCTPhCkh2dVH7kyJOT50EtnIjCPA6W90ne49K7cuEzakWX1EPpdL8EkXB2eAuzg
	 F+NJSCeschUI06fypxAoKdxRvczHFAu0PwytwWUXHiq6vEOT2qW4I9j0tKsPxO7rqZBOP
	 5bUbuL8zynO8RztP97vhcnCRZH5SDioxxDvkPPxNr83frTMY6EkPVJ1dC7p5P4AoY8tGj
	 Id9RSrAb/cui/MM/jbGWatqPqQozOzAKH2Z4GvJMY+gGfTBil5W6OR4UBPqU56cygsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795109523;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=QIb93aGY/E/TgiYuhu1hDFabzf7PY33CpXyYmWrZj6c=;
	b=XNhU3QmYs3IOVbnO4ZBwiKM1r1UMa2LPTs6QpZAcqe91eBAEpUzkAN64lIRyXCL8OEEC
	 HnyUxAzrJkS1Og2djUcr/Gkhl3RTxY2ufT3a7qwWB4a2XrvDYx0Tgca9Iy0EhyYs1Q185
	 91vVMUyFIm38jTQ9HfX09aN+bHww2aMT5h6VQwkD++meSfJgAgPZFDXmDJcCeZtBJthKb
	 w5O9brGJCGxJWVjzYO84eQUWult+RrrThoYpoaK6OUxZ3o4xcTF0CPx6KLcvrDRYGUFbn
	 UiPRMP0gTUnmr445fjTQAwi7wtoHohXqUNa6pGyHfxB+z2T6QITPXPnkXfXcfSBoj9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ru2lGQSQ;
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1225606A332;
	Thu, 19 Nov 2026 17:32:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1225606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ru2lGQSQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795109523; x=1826645523;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VqT9+QR2O2+xPAeeUAxzi2kxKVNvpdZn4xmj3vO+yIg=;
  b=Ru2lGQSQRy80GoBymnWicAy21OmBL/ACaj+y8ZR6IX8xc4UDctMoPEbI
   ppYP8r0kjDMNK1Xeqt08A0nynE5v/dbrLDt8lnr542hHpEk3gajU0nDjT
   P1G4VO0BAmIvXgl3K4lrmm8PLg2Jf1RTwJF+WO7btoxt8f4CsgzJO+TLR
   Va8JBbTYjmuYhPH4WpJLRtQfs0nbN3nx0G/tU87x4JsiMZl4cs0wDDB4c
   VQzDKcqJi9Vqb9ZSiF4lKi6nU8yA5SZtDnoeg359HPbCMQ0PM3qkCUDir
   5utpMRqyAIRe6UbWOOFeFwseGOJKLlHdmEBzI5xOnTfUjGpCigLVlHtWg
   Q==;
X-CSE-ConnectionGUID: n5YYgHCpSei8YQgD5pmLYg==
X-CSE-MsgGUID: y5S2DFUGTAaDpfuNDWVxOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="4015427"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="4015427"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 09:28:01 -0800
X-CSE-ConnectionGUID: cWZWhXzvSaSzto0YOBMSIQ==
X-CSE-MsgGUID: 1VrIU6f8TD+a+oVj+JI9QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="10577549"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.61])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 09:27:58 -0800
Date: Thu, 19 Nov 2026 19:27:56 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Lee Jones <lee@kernel.org>
Cc: Marius Cristea <marius.cristea@microchip.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Bogdan Bolocan <bogdan.bolocan@microchip.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 06/10] iio: adc: pac1934: Fix custom attribute allocation
 and channel bounds
Message-ID: <av8xnBRNUzEo4YdZ@ashevche-desk.local>
References: <20261119153151.1397003-1-lee@kernel.org>
 <20261119153151.1397003-7-lee@kernel.org>
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
In-Reply-To: <20261119153151.1397003-7-lee@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 19, 2026 at 03:30:39PM +0000, Lee Jones wrote:
> pac1934_prep_custom_attributes() sizes the pac1934_custom_attr pointer
> array using sizeof(*pac1934_group) instead of
> sizeof(*pac1934_custom_attr) and adds 1 byte rather than one pointer
> element for the terminating NULL entry.  When active_channels_count is
> zero, only a single byte is allocated and iio_device_register_sysfs()
> reads past the allocation when scanning the attribute list.
> 
> In addition, active_channels_count is counted over info->phys_channels,
> whereas the population steps unconditionally inspect all four entries of
> info->active_channels[], which can write past the end of the array on
> 1-, 2-, and 3-channel chip variants.
> 
> Allocate active_channels_count + 1 attribute pointers with
> devm_kzalloc_objs() and bound the population loop by
> info->phys_channels.

...

> -	int i, active_channels_count = 0;
> +	int i, j, active_channels_count = 0;

While at it, can we move to make it more like a reversed xmas tree order?
But see below first.

...

> +	j = 0;
> +	for (i = 0; i < info->phys_channels; i++)
> +		if (info->active_channels[i])
> +			pac1934_custom_attr[j++] = pac1934_shunt_attrs[i];

But i is not used outside of the loop, can we rather have

	i = 0;
	for (int j = 0; j < info->phys_channels; j++)
		if (info->active_channels[j])
			pac1934_custom_attr[i++] = pac1934_shunt_attrs[j];

? In such a case the above hunk won't be needed.

-- 
With Best Regards,
Andy Shevchenko


