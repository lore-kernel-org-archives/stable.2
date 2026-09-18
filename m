Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5EC423160;
	Fri, 18 Sep 2026 09:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789725039; cv=none; b=sHzNGjO396R2tAONAfa2aGir3i9I+yhYlTCX6h5Uq/Dq1VwbRj9sG1qirESDIFYg2tYrjz2+qnGtE5IHgYFvx0DpVTfDkn9Jy8v0qy0rQL5kjn5cJsbbj3iqwarnPtNW8gzTFa5kZ4EeAafCh2O1+dfSAtdsEeCW4bbZbrzxcQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789725039; c=relaxed/simple;
	bh=8BDh/dSNbd3YS9umNxhs6RpKOK7YENlhdXLWHbvrcqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Itmoq1IzavjjFcUH7hnTkbE60H7xPEA/H/7JXJRz1LhAJw8fhcNvYDFbnnFAd00oZjv3uyLWG1nyJiUsVzN4fzawGH7x7V9GXebb6ESSJ5xraoXE3OrY8y+rmuZGVnK5DPTJ0LBU/Rxk7DzfefyXqR/TAbB1bp4NAJWU/RRKqZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KS8wOdzR; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KS8wOdzR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789725038; x=1821261038;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8BDh/dSNbd3YS9umNxhs6RpKOK7YENlhdXLWHbvrcqQ=;
  b=KS8wOdzRVa64dd6uCW1mVCZvF0r6095zLkRJZCR8kcX9ic/QGxPvxz7M
   jljPyT2UTza/962CllF9iCBwwe/nWTV+CM6Inn5GfREKBDGFJhdr3c14P
   t8rzY3UARMcDzGccba1hZhYpGdnUUT+sjdOhWRzTEHFlhy3mG8Ixx0GSu
   0A0Oaa3O1ju6MIeE5wzYWuw4XrxRaivKxZNxQjtzZ1hd7H4hp+E2AhTuQ
   xSO8lpi9jSFLBZELFD8SDSQg/o1Hy3sWirP7wpWjukPaeppk/2aGhBKnL
   CENJluIuVOO442ad7HnTVNuX2DPH9tgzISOWOrIjGNV3GeMvIyLGg89Qd
   g==;
X-CSE-ConnectionGUID: RRVZS1YATCu+h4wT/saK9w==
X-CSE-MsgGUID: 1C6C3EiWQbChFcAF64NVFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="107723711"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="107723711"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 02:50:37 -0700
X-CSE-ConnectionGUID: 085ojRMeQTKJ5t+/0LDZaA==
X-CSE-MsgGUID: jUOqaZtESJS0xoTh46ricA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="270996609"
Received: from carterle-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.170])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 02:50:35 -0700
Date: Fri, 18 Sep 2026 12:50:29 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	sashiko-bot@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v7 06/11] iio: dac: mcp47feb02: Avoid unjustified probe
 error on missing label
Message-ID: <aq0JZSwTtu0Lugqj@ashevche-desk.local>
References: <20260918-mcp47feb02_refactor-v7-0-82ca794eafe2@microchip.com>
 <20260918-mcp47feb02_refactor-v7-6-82ca794eafe2@microchip.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918-mcp47feb02_refactor-v7-6-82ca794eafe2@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 18, 2026 at 12:06:32PM +0300, Ariana Lazar wrote:
> Fix unjustified probe error on missing optional 'label' property by
> replacing dev_err_probe() with dev_warn_probe(). Correct %pfw usage by
> passing the child fwnode handle directly in the error message. Besides the
> probe warning a read error is returned at the attempt of reading a null
> label.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


