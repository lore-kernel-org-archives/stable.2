Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793279951;
	b=kETXTdeXssD0A2D4BZXUYvpcROwZood16WBeGY096OYy2qLoRiv6iAUXnnfA7NhMlT4n
	 /A087S9ZFIEk08Ihov1NWPPsp/iV/IhuGB28JiO3/9bXdmCgaa1BKkpi5OETyBxUu+YFS
	 o4VqSr049V+9VVxh3FZ13Y9uM4YTLtwufS7G0iAW5XmvrIpbaP1pKJAhrJKPQoCLm9V3Z
	 n6hed3D6iaUc0vUFLgyuUGaRoLPGZRAT42+BcZPDsJiG8BIaGllhMZyHu85sUZa2CCvgI
	 IwC2HOg6xovBXw+vBDc4Wk9QCfn9rHOQOhNsjJgRLZwhCEtKgkX1SFj44oMf3o+dofw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793279951;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=P9aTY6Y7+MtguZH9UX86Hx6mdEqowM9IHKfA/xNeRKQ=;
	b=yjpwYV1oFLQwjgfs8G1YjdRUNBiupV+BJYbCiSfcbUjmCMjO8l+Rl6PqflpQPPGHiIhI
	 epFQxFO1tiH3dSuTZDpnTlXLPtqfDBY6F8slJfRVax+TQYhHtVwHanLQcjsEXQOJgNBYc
	 G7YW2rD4Yrs72mtnNBYibjZwxmOAZVuDkD4IJDOQ4Ncetz6nbkJbwMUKpSWrXTl2yX4w4
	 xxZEaYgiNC6QLxNSXY4UMReWJ5nFe8JUuuVH+8Tkmo9hzZ9o+QIW/rFXCxU83PTcfDN2x
	 PtK1gjlh18peyqLLpGi+z5k6PESDbw/E7PNmP0sksKq8LsAerfNrutyoFAYIBWgt4/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EicX68n4;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35104606A31A;
	Thu, 29 Oct 2026 13:19:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35104606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EicX68n4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793279951; x=1824815951;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NvjTTIe6UHqhGrx5HYZ+BE+S0MbAmWkir5Ulab06dtQ=;
  b=EicX68n4MEmb0zxtzD/hVqsi8Rnen61K2Bz7ACnzv6RQ7QNswwCgWqLu
   KAuDH/6/vDPGiJmH+pMNfscy49egNEi45k0eGzO15nsPC0ccN1skpRgdF
   zmmP+42V4zOrnwWx4G8fOYjvVfJ9S/PBK+uYtdcgpYlSZQWJdOMszjUl+
   JHwOYhBeB2FhTd4Jiooj1O4QUh7TgX3vIgsLrwdHiabd5cqoSfwt0HN/O
   xqaaN1nYYN5FykhpJtOOgR7sghBPjeAK/spzXZuCFf6zjWeX8ZiltTCbW
   oL88Wx7BnilbOx5S0kwuQnd8XwEivymzMdgrkBEolMqfd0MP/taukw5/f
   w==;
X-CSE-ConnectionGUID: 8sCtgaKkQe+r/kH0540zqg==
X-CSE-MsgGUID: 874vaowiQxujKQsznRFtlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="2015311"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="2015311"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 06:19:10 -0700
X-CSE-ConnectionGUID: XAVI6bC8RxCF1vxKIAzWJA==
X-CSE-MsgGUID: SHOmO7qiSqSmUr9GTFtF0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5103504"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.129])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 06:19:07 -0700
Date: Thu, 29 Oct 2026 15:19:05 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Liu Yufei <lyf98405@gmail.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Gustavo Silva <gustavograzs@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: imu: bmi270: fix zero timestamp in triggered buffer
Message-ID: <auNHyQGAcTcq8G2V@ashevche-desk.local>
References: <20261028-bmi270-fix-timestamp-v1-1-99c0e5fe7d0c@gmail.com>
 <auG5MXTh9ZkXMw55@ashevche-desk.local>
 <auID4_vQSZXuNk0Q@gmail.com>
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
In-Reply-To: <auID4_vQSZXuNk0Q@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Oct 28, 2026 at 10:24:11PM +0800, Liu Yufei wrote:
> On Wed, Oct 28, 2026 at 10:58:25AM +0200, Andy Shevchenko wrote:
> > On Wed, Oct 28, 2026 at 10:59:26AM +0800, Liu Yufei wrote:

...

> > > +	s64 timestamp = iio_get_time_ns(indio_dev);
> >
> > Do we need this variable? Why not call it directly?
> 
> The intent was to capture the timestamp before the bus read, so it is
> as close as possible to the data ready event rather than after the
> regmap_bulk_read() over I2C/SPI.
> 
> If that difference is not considered significant here, I'm happy to
> call it directly in v2.

But the time of the event in the kernel should be ideally with data we get,
not in the past, right?

Jonathan, what our expectations / requirements on the timestamp capture?

-- 
With Best Regards,
Andy Shevchenko


