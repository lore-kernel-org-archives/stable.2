Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2F255C329;
	Wed,  9 Sep 2026 14:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788962824; cv=none; b=FJKWfvc5auMfombXF1av4YAwN13z2BlrsFDZcXXU1+O3Qc+x+/oCwV6Iop0H5k0VU2boO/pXr20dnDhRL6Kwy7wgEeIuoCYGpt83TrYayc/U+H03mQGQafj3aT6kzZMVjFL5olOk9vrp6h+dUwW9ugvSyHe5tMR9XkMMYlnxxyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788962824; c=relaxed/simple;
	bh=B3R3XmC6SH+JhTMAarkjpGwPDzWHrvcZ17/Vqk8hZyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gqBZDlTxd47lol4B0WJ3VMRDhvCXicthWy5V91M9oTNuZVQGH4LN/8bdq+IrfAxhn9yBwn6finUNxUTZETbjph5z7nrL+j2bIC5BStGPaBWIWMvnoqXg1cg3mDQAJp+Jk+6/qoeiSlG1VjXFj/vyJo9uHn3Q4rasyao7P86hH2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OLTj5muQ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OLTj5muQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788962822; x=1820498822;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B3R3XmC6SH+JhTMAarkjpGwPDzWHrvcZ17/Vqk8hZyk=;
  b=OLTj5muQMpCYDvg9v/+68tVP/NWMKsTNKD0KYf57uULJpbNSj8B31kBX
   MGmQ5jc9vu98al5kaQgCxL8Ip/MPqOTl3BDFI+nDNVUfdR5akGA7a587b
   bUy6Z9XV/hwSfcTsm7kiEOYZ3duS+jETq2VSU2z7Y7sbTtcENjbhp+q1S
   9Fq9qP3RtbjWhFznjBQBvEOXzCrsqlDWlT2Pe7Gbairhbv9rhcFUWe/jX
   cs4rrbnZ3tTTzuFcz5daiXR5TKNdpAooyFwRtHT5Ei+1d+85/a/pxkX0+
   eYf+NnhWcHPLaAyEo4fbiRU9CWw218/Iv1N3wzbI9N71xDQLsqocqWxhP
   A==;
X-CSE-ConnectionGUID: 0TGk5Xr+Qzq7brgof3q6+w==
X-CSE-MsgGUID: kM5oQ9ZkREKw3znEyC/OAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="89259003"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="89259003"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 07:06:05 -0700
X-CSE-ConnectionGUID: IaAKWW0jTlmg9q+DvdwSSA==
X-CSE-MsgGUID: YQFnG5fgTzG/WPPOtDdvVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="269563313"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.249])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 07:05:54 -0700
Date: Wed, 9 Sep 2026 17:05:50 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Kim Seer Paller <kimseer.paller@analog.com>,
	Marilene Andrade Garcia <marilene.agarcia@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: max14001: add missing MODULE_DEVICE_TABLE
 macro
Message-ID: <aqFnvoGj1ZNEUlUw@ashevche-desk.local>
References: <20260909130304.1395-1-joshua.crofts1@gmail.com>
 <aqFhagdhM4Z57eqh@ashevche-desk.local>
 <20260909154526.00002640@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909154526.00002640@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 09, 2026 at 03:45:26PM +0200, Joshua Crofts wrote:
> On Wed, 9 Sep 2026 16:38:50 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> 
> > On Wed, Sep 09, 2026 at 01:03:04PM +0000, Joshua Crofts wrote:
> > > The MAX14001 has an SPI ID table, but does not export it with the
> > > MODULE_DEVICE_TABLE(spi, ...) macro. Because of this, SPI-based module
> > > autoloading fails on systems that don't use devicetree (e.g. via
> > > spi_board_info).
> > > 
> > > Add the missing macro to export the alias information.
> > > 
> > > Fixes: 59795109fa67 ("iio: adc: max14001: New driver")
> > > Cc: <stable@vger.kernel.org>
> > > Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> > > ---  
> > 
> > Changelog?
> 
> God, I should start using AI to check my patches before sending.
> Appending below.
> 
> Changes in v2:
> - edit commit message (expand on module autoloading and SPI)

Thanks.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


