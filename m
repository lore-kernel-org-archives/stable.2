Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793008357;
	b=loZT3fnjK+Wxl1KE3+6p1M29x7Tt+nxvMv23KFQRXrrMm64vaDXeBZt485SbRQXQRZQG
	 /NzfeceV1LmJKNTiBF/3vh8lFIJmQbCpA/K+RbQZHilUIoHySuAcMH5hkt/7kJ/JJJG74
	 0PijjslTxkhz9eZ4ujc15ZXPMyZ8ecShesLn0Wb0+ZUKJpK24D2jqmKUe2jLv3Bl9qGas
	 +mI8YE9oYnSUQa4s+/kpSjrMx2GZSMqkiEt6aL8majrMX0VUfmiVvoKFkTjVH57DtLvaZ
	 7SbnhW5C1ZEa0TBaxslM9lVC8nbr2YCGvBOua0sc9Shu6oXtfwd+oaX0levgixzmtDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008357;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=ia+DMI3WqUj18cxUlgYQ9GOKAY9I2+g78j3wxqOshuo=;
	b=refB4qFuP3Xxt6raNbDE6GmC3369CpkzOm01utGPN6d3XwpW+zk7iK8xdOWNVaYHmCkp
	 OIY6oT+mR1hj4oYAKNOeEBQPwg3TR7QMUdX2XiPUfn56VwfZhz641KH6EvW9XEV+VFD/R
	 cur0umSE/wBIhJijs/N0i2Roq9LB7PuIK7j12BPhM9MkOkklf9qzxi5D5w9zEoM11x4t3
	 GMSevw9o6d40oNJswle1fNqUQRnXr5bghnng0ZhSUNOI6252qp3ZaaWKBPkg46pX6GuKp
	 tFtWnW3FyIhUyXbNqtasQt8GSnAwtIW05HvP836KDD4eHN0+vOKig7RTBiKyh8I73yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aDxWDnfU;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F02606A31E;
	Mon, 26 Oct 2026 09:52:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49F02606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aDxWDnfU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793008358; x=1824544358;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ity+bpTy8tXsipyPr92EtpFHpmJ9cJtcI7YcpljbMkQ=;
  b=aDxWDnfU/uo48ixrYQ94FUyMkriVcbz72SetclVXKDioxUU7sbk+BV0n
   kLQtPy/MQJnrphtYe8WuYYy+Ep6ghhDk77fsQNQrKba31lE4SJ16dDO5P
   GK3Yw3Dc1zg+b65NwNF3bjDDhzRrG1O2lra/oU62Bs3Z/ldSRno6ElJlm
   dROLeECEiWOduHIHxoAmmxW6+Cyv6LH7z56lSvIDjuiNW33AAby6BTjhD
   B3Zyp847HDcGAjzpBHdRYvJt1j3ewesyOsr01EgrttIcHePCBtbeVdDHD
   FAq+BSq9NO/SfyCETARen9YTrHf8jndBj9rzctd6uxMZpwqpcBuZmauo9
   w==;
X-CSE-ConnectionGUID: 108fUaN/RkCKOVuHUs2ITw==
X-CSE-MsgGUID: K4MProUxStCoWip1n9MeuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1570151"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1570151"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 02:52:37 -0700
X-CSE-ConnectionGUID: 2DbDZJm6Sv2BT5XpKDFVyw==
X-CSE-MsgGUID: cEvPn91mSMyBt4Cf1w1WKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="6048570"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.93])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 02:52:35 -0700
Date: Mon, 26 Oct 2026 11:52:31 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Muhammad Bilal <meatuni001@gmail.com>
Cc: jorge.lopez2@hp.com, hansg@kernel.org, ilpo.jarvinen@linux.intel.com,
	linux@weissschuh.net, platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v8] platform/x86: hp-bioscfg: fix heap OOB in
 hp_enforce_single_line_input()
Message-ID: <at8i35nLTr1weldL@ashevche-desk.local>
References: <20261026051740.88791-1-meatuni001@gmail.com>
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
In-Reply-To: <20261026051740.88791-1-meatuni001@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 26, 2026 at 10:17:40AM +0500, Muhammad Bilal wrote:
> The input is copied with kstrdup(), which stops at the first NUL, but
> the full write size is passed to hp_enforce_single_line_input(). With
> an embedded NUL the helper reads, and can write one byte, past the
> copy. Use strnchrnul() so the scan stops at the first NUL, and return
> -EINVAL for a NUL or newline before the last byte.
> 
> Tested on HP EliteBook 840 G2 (Fedora 44, Linux 7.2.8): writing "A\0"
> followed by 4093 bytes of "B" to current_password 100 times returns
> -EINVAL every time, without reading into the heap.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


