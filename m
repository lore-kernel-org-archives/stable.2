Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B977F426419;
	Thu, 17 Sep 2026 06:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789627055; cv=none; b=IS/ct5F4ivls4cS1svyP1svmaq5skD7vC3GgGZQgFRMOnhDHpU8GWp8KXjPI8SyUl/9YioHlh963lS980tFr98u4zwZIhIKUd/iKT/MiFLIR4uHvj/yFtqPMnWHqy9uIANBDYVfJgxG836AL5GmRTuFCH1Jzv7gNXPAwwzVawZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789627055; c=relaxed/simple;
	bh=78P9uDbVpVsDBbxBNte9yapveZ3PtV/4i6FzzhSTwKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/qUxJqKDuZORnZyGUcpnRU/4eKx0QWR+sTiJlRadMZLi2osLS1O+HOV+Uwm5gFRkJOe8LD6MMYQgvDeeeBIHOjb4SYOg7HxaG01WfMImlSeLNh+R1cLKvwi8oZqQXHmAaeo1F1cQCZngqLEn1TPq1w5H3KpqorwKicT/HEMu3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tz/Rd+4o; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tz/Rd+4o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789627053; x=1821163053;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=78P9uDbVpVsDBbxBNte9yapveZ3PtV/4i6FzzhSTwKo=;
  b=Tz/Rd+4oSKS4IWvBTPoJ3mQiXkJy2hJILMBK0sQRpgFOip7bmnNXpzgv
   NDgGafD2wqp/qWvBQ315Oqzwa+dDTAXU6EWD7RATqeY/lydw+8z4oL5IU
   V5UonmLKNbBScLI5BW6Gd1M5q0yoEvAs5jJmXVH4JfJOVpELT+MvTjSOc
   /sD3+yzmJx0cNFIpnQ7TGXSNIvWbP0kKbjrkOYTptXWyCRtezU2SkVjsw
   qQ+tmLLO+ACeLJwaTXSQoJcTFZ8hPwwFL2q3atUW3tgbIIjwykhi33A8u
   QRPlnOuN5At6qcG6PSF2b2aZXejbugwQ8y/h9LIV8blwBLJMNvNUCH9wi
   g==;
X-CSE-ConnectionGUID: kJFG+inBQpyNuPPkWGL6rQ==
X-CSE-MsgGUID: qdzl3/+5TgSf1s1WKCSYHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="90151626"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="90151626"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 23:37:32 -0700
X-CSE-ConnectionGUID: Fa8hJPMZQrqasr8yiCW3dQ==
X-CSE-MsgGUID: OkfdFBPIQg6itJ72x9YO/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1829865"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.11])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 23:37:29 -0700
Date: Thu, 17 Sep 2026 09:37:27 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	linux-iio@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v3] iio: adc: stm32-adc: fix possible division by zero in
 processed channel
Message-ID: <aquKpzrNNpX0gy1c@ashevche-desk.local>
References: <20260916-adc-fix-div0-v3-1-bedf027a6e7e@foss.st.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916-adc-fix-div0-v3-1-bedf027a6e7e@foss.st.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 16, 2026 at 07:15:04PM +0200, Fabrice Gasnier wrote:
> In case the conversion has failed or returned zero, processing *val
> can lead to a division by zero. Need to check for errors, or converted
> value is zero, before processing the data. In case the converted value
> is zero, e.g. the Vrefint channel, this should be considered as invalid
> in all cases.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


