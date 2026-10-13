Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071C552F277;
	Tue, 13 Oct 2026 18:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791914965; cv=none; b=i79o+VHhjPXdAgycGQ86L1hIwcQBXjghZ7urZZuG0yZi5+efDQW8m93djmaWVcslUa4nlxJU8BGnYgRoLeom5TumtSPEsNeg7hudUXdAH4bE4tCQCrrtygxLcyk382bt80OyBx2kEa6iyuPVc5YAVRaaLfNUwAeObyU4Vz2dwNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791914965; c=relaxed/simple;
	bh=ra9TmfFPSk6PZ5bwWVQRAqd0nkB2k78Y7v0WgbbMMDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=btscK46G9x7nGvfTfCfBEVEFL2ZUeAbVxrZPxqYruQFNN1sKnQxgV99kXcmedPkbxQKyEdysCbFNP8u5IEQuK+9tlAbdAL1XTX+e+ZlygVc4XEdcKd7DK35SxLgTPHnnKUsOQXqePAdpmlq+soHHi9RDBwlff8ivZrRkXmRfiN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HEjTltkS; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HEjTltkS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791914963; x=1823450963;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ra9TmfFPSk6PZ5bwWVQRAqd0nkB2k78Y7v0WgbbMMDw=;
  b=HEjTltkSl6fHf8GBt4T3Qr6Fsf8JupliLoBbKg7XdpSGj9ddXJyYcWXB
   Vi326TB02X5pcb8wCaeqlcCLTeMN70fJNqgTqtl495sPQOywi9SbcD4A7
   HK1c8JWRIkd5gC3F5mTgEF6IZGMNaam0yLIdEtpar7BjE9Mt+Cdqk5kbb
   vZzMVPO66gk2uKPxsiDzZXxCFFRh4VcucHNlIu1MFM5PrKqI6uLvX1zcC
   P7pQpj0BW7bHXvYZt0gGYYlINwlEoQdsDJIEE4Ad4ucsKCcKPabuRyzYb
   cRO3V9mJk1KQZDUhIMfCxhpie9TFFTWpAvp72HYqyXxJJvGrYH+gQ5++U
   w==;
X-CSE-ConnectionGUID: AEVheA6BQTqsYIe5sx7aQg==
X-CSE-MsgGUID: J/e5rPYwSoifx2Q115IqSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="659396"
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="659396"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 11:09:21 -0700
X-CSE-ConnectionGUID: 8mlNk+jsQS2G3by8VXzeOQ==
X-CSE-MsgGUID: Dcp/WFp+See0oScltxFBUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="2987263"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.48])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 11:09:18 -0700
Date: Tue, 13 Oct 2026 21:09:15 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jan Remes <ciakval@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Joe Sandom <joe.g.sandom@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jan Remes <jan.remes@mycroftmind.com>,
	stable@vger.kernel.org,
	Martin Triska <martin.triska@mycroftmind.com>
Subject: Re: [PATCH 1/4] iio: light: tsl2591: don't divide by zero
Message-ID: <as5zy1LRyE5hr6vn@ashevche-desk.local>
References: <20261013143943.436816-1-ciakval@gmail.com>
 <20261013143943.436816-2-ciakval@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013143943.436816-2-ciakval@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 13, 2026 at 04:39:40PM +0200, Jan Remes wrote:

> The TSL2591 has two raw light channels - CH0 and CH1. The algorithm for
> calculating illumination from the raw channels requires division by CH0
> (which can be zero) and by "counts per lux" (CPL) value which is also zero
> for (gain = LOW, integration time <= 400 ms).
> 
> Furthermore, the algorithm assumes CH0 > CH1, which can be violated in
> almost complete darkness.
> 
> As a result, reading from 'in_illuminance_input' results in
> division-by-zero whenever CH0 is 0 (complete darkness) or whenever the
> parameters result in CPL being zero. This results in kernel oops on
> x86_64 and in reading the value as 0 on arm64.
> 
> Fix that by:
> - reporting CH0 <= CH1 as zero (catches also CH0 = 0)
> - updating the lux algorithm to only do the division at the end
> 
> Fixes: 2335f0d7c790 ("iio: light: Added AMS tsl2591 driver implementation")
> Cc: stable@vger.kernel.org
> Reported-by: Martin Triska <martin.triska@mycroftmind.com>

How was it reported? Offline? Off the list?
Otherwise we have Closes tag to point to the report

-- 
With Best Regards,
Andy Shevchenko


