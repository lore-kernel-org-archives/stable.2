Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C5C35BDC2;
	Sat,  8 Aug 2026 20:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786220168; cv=none; b=Dg7VonlR6WLQInKx7StKaVAhCUF67loYiR0pI29rwvUG5I3CMaVq3/mdVhA7WyEhLxCVAtv+2tmvi5iBDz1s8cC4IjK/XXk5I6I2E6vNLg77Qh7LLgI+TOePzrHiECGnbEiQqCfw0U+5aGR90uq/f+UYY3bwKYrDtUOJthqkphE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786220168; c=relaxed/simple;
	bh=eAVKQvncR3HUbaZ+G5m1TSjYE0dST4KF6cYGeOTLwG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iTUlEHT1IiKHdbP4zs/P2nF9QRBv/vkrszuaDMVpdwlAn+JRZ3z4Ny5bK8TvQXb1PmSG14FrUTDzi/P8Tg1+I4AS5xWWE2BYmeHSRcZRIxq9uGDjiw/3y6Zx4yhFffz1ntLygxtMMp2WXHdLfEnPppk997s+XWZ1BaLWtseJPLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S9qY68s4; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S9qY68s4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786220165; x=1817756165;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eAVKQvncR3HUbaZ+G5m1TSjYE0dST4KF6cYGeOTLwG0=;
  b=S9qY68s4URUZxXwcaEQtyVQrECfgCLlTfrK0fgNLllrSmnEYTCLR9e5b
   VGMQ0cFYgTVI31e6IKk7uXHMzoUr/Y/YHlkTMOjm+4SU7n8eayiO5pD7I
   zm/m6JHg5Tcrr6d+iDClu2OcH4Uqq2k18ph9t2cj7FL/kFuyqDEslYcxC
   /q+xIp5Z/MPSQoux/YCWmQHiJECKfzH+GGvvxR4QAxmLpK0PtCJLhTcQF
   bYqp63g19NQS7Jv0zH4e1ZTOthSsfhvLp0bB7AehzcoXTDE5zXa6vjpUK
   F0JTWrldiKrYUmjX0iLraeoI9eDq4UcXX4u8MK/0JPCcQXlxb/Gl6a2h/
   g==;
X-CSE-ConnectionGUID: QT1ZEejtRQqr61JAQppscg==
X-CSE-MsgGUID: l8hEQ5LrSJ640NY7K2gt+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11869"; a="74329514"
X-IronPort-AV: E=Sophos;i="6.25,212,1779174000"; 
   d="scan'208";a="74329514"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2026 13:16:03 -0700
X-CSE-ConnectionGUID: 5JMrj7AZRQ2uFbA0yW0mSw==
X-CSE-MsgGUID: vw1MsWHwR5iX2BDvO/VJKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,212,1779174000"; 
   d="scan'208";a="267846107"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.2])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2026 13:16:00 -0700
Date: Sat, 8 Aug 2026 23:15:58 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Shengzhuo Wei <me@cherr.cc>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Sean Nyekjaer <sean@geanix.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] iio: accel: fxls8962af: clamp FIFO sample count
Message-ID: <aneOfps4hcZAaohn@ashevche-desk.local>
References: <20260806-fxls8962af-fifo-v1-1-bd9d27047fee@cherr.cc>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806-fxls8962af-fifo-v1-1-bd9d27047fee@cherr.cc>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Aug 06, 2026 at 05:14:53AM +0800, Shengzhuo Wei wrote:
> fxls8962af_fifo_flush() copies the number of samples the device reports
> in its FIFO status register into an on-stack buffer
> 
> 	u16 buffer[FXLS8962AF_FIFO_LENGTH * 3];
> 
> which is sized for at most FXLS8962AF_FIFO_LENGTH (32) samples. The
> sample count is read from the BUF_STATUS register and only masked to its
> 6 valid bits:
> 
> 	count = reg & FXLS8962AF_BUF_STATUS_BUF_CNT;
> 
> so it can be 0..63, while the buffer holds 32. The only other limit,
> the watermark, is applied on the write path (fxls8962af_set_watermark)
> but not here on the read path. count samples are then transferred into
> buffer[]:
> 
> 	fxls8962af_fifo_transfer(data, buffer, count);
> 
> fxls8962af_fifo_transfer() reads count * 6 bytes through regmap, so a
> malfunctioning, malicious or counterfeit accelerometer (or an attacker
> tampering with the I2C/SPI bus) that reports up to 63 samples writes up
> to 378 bytes into the 192-byte buffer: a stack out-of-bounds write of up
> to 186 bytes that clobbers the stack canary, saved registers and the
> return address.
> 
> Clamp count to FXLS8962AF_FIFO_LENGTH, the number of samples buffer[] is
> sized for, before the transfer, mirroring the watermark clamp already
> done in fxls8962af_set_watermark(). A well-formed flush reports at most
> FXLS8962AF_FIFO_LENGTH samples, so legitimate devices are unaffected.

...

>  	count = reg & FXLS8962AF_BUF_STATUS_BUF_CNT;
> +	count = min_t(u8, count, FXLS8962AF_FIFO_LENGTH);

min_t(u8, ...) is almost always wrong. Please, find a better solution (even if
the current approach is correct).

Hint: first of all, do not use min_t() (mind '_t' part!).

>  	if (!count)
>  		return 0;

-- 
With Best Regards,
Andy Shevchenko


