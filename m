Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAF8481FA1;
	Mon, 31 Aug 2026 14:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788184827; cv=none; b=TFNGKenrzn1AoxEAlML7jMa7nGHBiq/cz3k/17VwBPmdg6mPlNcxUpOoUaMfuxDLkOtemChjuTRoWElRu1e1JkStqf+5e2gy8XflydfnE7Vsh/Uz0g/NiQtIBCHOHZY3TEnOno/48Xe9BWVnGURb0c+D9aGxcOHR/gzfOcFeb6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788184827; c=relaxed/simple;
	bh=cI/2g6mUL6hqQqrAMuXg7x4Fxuy4Zbt9zSvh//xoF+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TOnLIRaQjQ2ezjlCR4WS2S0UDaYBVuksxCE9UZnPaWR3PLn0ionTnuzL1dC3Q9r/5DMD4dpBYCM/VljJq+PoNwdgbWE0sTf2KECEcDdZqonOIH57yB5lASsGd7oTbA3jqMQLLchzgcwizIfCpcAORaZw+1jD7Pz8o+VuvTonHkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gWtozdU5; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gWtozdU5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788184825; x=1819720825;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cI/2g6mUL6hqQqrAMuXg7x4Fxuy4Zbt9zSvh//xoF+Y=;
  b=gWtozdU5uYKW8ALJe6IXFqbMdAJJCaXct+Za8Nvf5nKppfFgMZM/hB77
   VNYwjmNyWOADaq3+PsQ82/xkEEYM+ePWp0OTNGvoGQPOGc6wJhKvdvppN
   fwGBchWcfgbdU2LbDk0MXV4PzD1v0KpsVSsFvT+5/3oUa/SY0yxb2r8BY
   I6b2Xag4reTBOqYS09sXtBNz7XMWRt+17a4V2JyiJO0VHKPmZQv2T1U0h
   3LcsLbqq6A1mNZY38YCxZzBc4RiJ0bU2f9cjkDenuK8PtkrqKGCVp6SWh
   wTjoa5654bBd6Xgnjs5FqGK3dOLdVTYIAc78IlKdFVYmSefOjIYiPrKNd
   Q==;
X-CSE-ConnectionGUID: ARoJj8njRSaRbsCUglpv4A==
X-CSE-MsgGUID: TYFAQafnRFmznfR7ZNWHVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="106114519"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="106114519"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 07:00:24 -0700
X-CSE-ConnectionGUID: its6a53JSo6+tMLTdjEGGw==
X-CSE-MsgGUID: BajDN1iAR/W1QYpYPlBp2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="272602238"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.21])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 07:00:15 -0700
Date: Mon, 31 Aug 2026 17:00:13 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Esben Haabendal <esben@geanix.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Martin Kepplinger <martink@posteo.de>,
	Sean Nyekjaer <sean@geanix.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Martin Kepplinger <martin.kepplinger@theobroma-systems.com>,
	Christoph Muellner <christoph.muellner@theobroma-systems.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v7 7/8] iio: accel: mma8452: Fix use-after-free bug in
 error error path
Message-ID: <apWI7aYneejpZ-hs@ashevche-desk.local>
References: <20260831-mma8452-open-drain-v7-0-22946812c928@geanix.com>
 <20260831-mma8452-open-drain-v7-7-22946812c928@geanix.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831-mma8452-open-drain-v7-7-22946812c928@geanix.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 31, 2026 at 02:17:10PM +0200, Esben Haabendal wrote:
> If mma8452_probe() fails in iio_device_register() or later, we could end up
> with runtime suspend callback being called with a now freed device pointer.

> Fixes: 96c0cb2bbfe0 ("iio: mma8452: add support for runtime power management")

Can this be popped up in the series? I think previous couple of patches are not
fixes...

-- 
With Best Regards,
Andy Shevchenko


