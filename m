Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AE035E1D5;
	Mon, 24 Aug 2026 15:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787585578; cv=none; b=NezL+ETvaGozUe9DfoZ6OchEAeLeQeYxH21rm/hovxEMW3hlgVWsYrOcQ7xd5jm3LjbN+5L/NrT0R1Tx2kYpqYcBmFMdk52UvE8vfWA9GZ8bPShZpp5JSgFMCFmwkTm3gldbUpnRbuekh0Tpa60wQWMc9bq+umUqPWNjCoz8OQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787585578; c=relaxed/simple;
	bh=OfARlw9nsXER7L4K7sbe5xbl4bur1xzTIEX0rdw1c/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ff/JLr7CiFvHDCiKLKhvi8BcQmDYG0KROOJQnJMqbj02lE18oVG/yXS6z/x+2QbNJtHV1zYo0et94ZZM2pnmZ+27ELUUH7w/ySHxDkdhH6Tj7olHA9dR5qN95f+yYQ8Bv4et9h2nOpvu6KTc6CRdnGVkWnRMfdU5sn8QXVC6xvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fXbQ/urL; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fXbQ/urL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787585577; x=1819121577;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OfARlw9nsXER7L4K7sbe5xbl4bur1xzTIEX0rdw1c/8=;
  b=fXbQ/urLMiR16nw2rO55UQanli2EujscsbdVvStC3znMzSD7Xp4x8nHF
   9L/1/Rsgy6FzlzwQ1wzbvrgDAhBg4bYs2dYr+xV8uW44DzdL74sixNxKs
   63OCM91eZjDUyVdw9glMmPAWMWra4gog2OPcDhNfyd1cg+4JSsWaUQOeN
   ID7uN8JDs01Ni+8JnfrF4yByJ+i+RXiMNHn3MyBoDFCWE8SnjNm7TNBmL
   rXP7/cMIrvh84BnwlmdH+9uinMy/5HYQIO8Z1s/cDtdTA+Cq1a0QouCz3
   lFlWqzxiXPx3leAF7/X42PMYUgsoD5DRHiPEEkkj+r/n+pOSAbiFH53Bp
   w==;
X-CSE-ConnectionGUID: ftGiKVauTRCt8tqU5/3cvQ==
X-CSE-MsgGUID: q8/XZT6MSQS+tc32++fDew==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="87807258"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="87807258"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 08:32:56 -0700
X-CSE-ConnectionGUID: nvDKjNIMTpWJ37d4vql8ag==
X-CSE-MsgGUID: oNACP2q2QeOAyQPivu96Sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="305253632"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.130])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 08:32:54 -0700
Date: Mon, 24 Aug 2026 18:32:51 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: jean-baptiste.maneyrol@tdk.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] iio: inv_sensors: fix estimated value larger than
 interrupt timestamp
Message-ID: <aoxkI3SV4IGumncy@ashevche-desk.local>
References: <20260824-iio-common-inv-sensors-fix-estimated-use-v1-1-6e93506e7e93@tdk.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824-iio-common-inv-sensors-fix-estimated-use-v1-1-6e93506e7e93@tdk.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 24, 2026 at 05:16:58PM +0200, Jean-Baptiste Maneyrol via B4 Relay wrote:

> When interrupt timestamp interval is not valid, we use an estimated value
> that can in rare case be bigger than the interrupt timestamp. This is
> obviously wrong, so better use interrupt timestamp in this case.

...

> -		ts->period = ts->mult * ts->chip_period.val;
> +		ts->period = min(ts->mult * ts->chip_period.val, period);

It's u32 * u32, how is this guaranteed to be always under the u32 result?

-- 
With Best Regards,
Andy Shevchenko


