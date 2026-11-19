Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795108943;
	b=3oVjyRBSvcU2GWrbKdG8J5UKq/m0H9aJSHiAu2T4+ncBJKFexr0xRwrSJh4g+izYWGzK
	 DuxbnEuntmGyw4Nmkt/ko9kSzuLTHO92VU4U741qHDgNYtFys43H2Ee+TQR02OBALQvwk
	 JAGTphdkyiArRCx1kbDRdH363Ci9ta4WjOOViDTXV4vNGRdpr03Nc12iTjMaT5NxAoBC4
	 VyOvDVOIaK8xW5Tfwk+mAzEpsHDlaWQYToCoc5uxM63Z6W7dP1uRRPN28e7b1yLnc5re7
	 icg6bZ+pYPJEXDrknzkUHDCBmbBvxX9dOnpEsodE3IyjS56chJN6fDe2jqQvlBcdjKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795108943;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=LFTcJDjmQNamNWl0i13a+B1pqLhYbuJ5BQzFwJtb1Ak=;
	b=qPNc27ztT4Nbi8j56QwSNjwrsUumVBAtHjyyZ0TcOAcFnazUBvhCz4hwGYIcUUKXDe6V
	 WNXtDFR+Y+hGyJphEwvh7ce6G3sH8rCRkqiabmjxe5BEl2/AO4DZ7Bz/2SjQu3sDvSR8E
	 oT+1I+NSL3G2E8hvi+b+BYPZITkv7gXa/6buVKFht8+jF1AKRrLMccgLqCLZhrODRoUmE
	 EoEMviYt18wR6XL4YwkUBpVJATVGNZzVLFCWmXJT0iCgCWESEDBfCUBGIYiutEzyVeacp
	 pv2dVOmdJ9K0Cgea8EdC/qINMs9vxs/zoEUZTGlc0E/OnlbI4sDwztSkS9LbCOD9BRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WpPUdVSY;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3480606A320;
	Thu, 19 Nov 2026 17:22:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3480606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WpPUdVSY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795108943; x=1826644943;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WD1V4uwNJWIfTh4IzBkdti1BKZInvd5fb14FvohizjE=;
  b=WpPUdVSYX17FDHtlj81s2AlI1godU7pePITjQYgE2w7WdsiZKP+vB4U9
   XawUOxYfLinGz6uu/t+YspUWzutFAVrWH0pBzcq7EdN1fqic/mPx3uohn
   TwOASDdtNAMZt4fmXwfJOFPjkXKv29urmS7YREO9Jac3tr0qN6bBBHw+Z
   ub1rncfTswAYN9dZmXwK0MCHNqK1iY2BeddY3N4FsFO6hLqSVcC0tKV84
   leYUH0eLkdSxWItlrrVHpxIboU3Mk//JDr3Rm4C+ea3VMza87dUf4BgLz
   cYHnoCOMLWWqQVRptH8G9LAMenYfks2VO89tjm7WekClM8/JrHJuJsXlS
   w==;
X-CSE-ConnectionGUID: fGOac/1qQQm73uPabro01A==
X-CSE-MsgGUID: LQcZDEGkQi6b7Y8OElWV/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3855453"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="3855453"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 09:22:22 -0800
X-CSE-ConnectionGUID: 1+mZrb/XQgyvlx5hwfvc8Q==
X-CSE-MsgGUID: QrSmd2FPSQ24MxVfp8hH9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="12326946"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.61])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 09:22:19 -0800
Date: Thu, 19 Nov 2026 19:22:17 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Lee Jones <lee@kernel.org>
Cc: Lucas Stankus <lucas.p.stankus@gmail.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lothar Rubusch <l.rubusch@gmail.com>, linux@analog.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 02/10] iio: accel: adxl313: Prevent FIFO buffer overflow
 in adxl313_fifo_transfer()
Message-ID: <av8wSW6-ukmvRDnp@ashevche-desk.local>
References: <20261119153151.1397003-1-lee@kernel.org>
 <20261119153151.1397003-3-lee@kernel.org>
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
In-Reply-To: <20261119153151.1397003-3-lee@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 19, 2026 at 03:30:35PM +0000, Lee Jones wrote:
> The ADXL313 32-entry FIFO plus one sample held in the output filter can
> yield up to 33 3-axis samples (ADXL313_FIFO_SIZE + 1).  Because of
> missing parentheses in ADXL313_NUM_AXIS * ADXL313_FIFO_SIZE + 1,
> fifo_buf is sized at 97 16-bit elements instead of 99, overflowing the
> buffer by four bytes whenever all 33 entries are read.
> 
> In addition, adxl313_get_samples() returns the 6-bit FIFO_STATUS entries
> field (0..63) without bounds checking, allowing a malfunctioning or
> spoofed bus device to overflow fifo_buf on the heap in
> adxl313_fifo_transfer().
> 
> Parenthesise (ADXL313_FIFO_SIZE + 1) when sizing fifo_buf and reject
> entry counts exceeding ADXL313_FIFO_SIZE + 1 in adxl313_get_samples().

...

> -	return FIELD_GET(ADXL313_REG_FIFO_STATUS_ENTRIES_MSK, regval);
> +	/* 32 FIFO entries plus 1 entry at the output filter */
> +	ret = FIELD_GET(ADXL313_REG_FIFO_STATUS_ENTRIES_MSK, regval);
> +	if (ret > ADXL313_FIFO_SIZE + 1)
> +		return -EINVAL;

ERANGE? EIO? EPROTO? (I think from the listed the first suits better, but maybe
in errno.h a better one is lurking.)

> +	return ret;

-- 
With Best Regards,
Andy Shevchenko


