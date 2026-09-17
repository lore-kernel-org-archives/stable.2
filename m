Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDA44DDB49;
	Thu, 17 Sep 2026 15:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789658076; cv=none; b=lRCbr00mhQ9qtLFug3NCZ0gglk7+3dGEnOP3M5B1oeFDDjG1GjyljSse9sYfCB6zs1sxwoh1VFhoHreMeqHOq/M4vZgVp8ZtNZ3QB7V1aZbnl+04041Ny6JzqY7QmR8fjd/NocX0ifXPWCi0tK7LP6B74M6SJZXCNZjFr03zPUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789658076; c=relaxed/simple;
	bh=I44UDW2h7/52M2InM+ZBm8K2Baaos4kp8Ir96D14/OM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ctYL050/zXCwqrZ5FbZqoQQgGJeY5Yj9km6kM/hWMT7qrVzZurns1icuH0+YJJzEp7/pZAT4pFKZIksBdVe06sAQPamtxoc3m3SPCtwLpxv/qld158zjfIqsqVot7zf/dpqBSMioz6/KaM6wC0uoFBTui2u/JfyfSwVmPFDj+bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nDzV3sIr; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nDzV3sIr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789658055; x=1821194055;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I44UDW2h7/52M2InM+ZBm8K2Baaos4kp8Ir96D14/OM=;
  b=nDzV3sIrX8fR6O2mP1pvbyzIpJFp6irOq/bB/VaR2hJtabe0RYmo+bYf
   p6PYnceb6LrPmm2n8O1cxvecWoutu9y7tvYIXsDRGc6Rpj6GY1hp3VIoQ
   78vzMXKMl99p32UnDCCrNtTj07NXgC5EWgyObSkO0k6iWHq/RAMe6ZsGd
   w5XbwquvDju1Eb6Mv5hjFaavfnOmvGd2PuNKXekkP8okxye7g1A1cKY++
   jAeKRRlPE1utsAYPalFwrfJukLAhsKtoHF1K7ETxPnY2jhph0WXXA5Uka
   jtSQgeafQOf5cVb66MFMcTXwOioUBtqsKyUEAqOPTIZ6rCdntRNFTQToH
   Q==;
X-CSE-ConnectionGUID: TBYvB+VqTiGydRJfGn4v5A==
X-CSE-MsgGUID: 77GjsaAuRuKsd1SxdjsTPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="107596136"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="107596136"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 08:14:04 -0700
X-CSE-ConnectionGUID: 6YbKWdJfRPKs75QfmjKBTg==
X-CSE-MsgGUID: jBtzLQBaRl65rwR5ujfNGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="271214585"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.11])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 08:13:52 -0700
Date: Thu, 17 Sep 2026 18:13:49 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: hansg@kernel.org, ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org, mingo@kernel.org,
	platform-driver-x86@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] platform/x86: pmc_atom: Fix PCI device reference leak in
 pmc_atom_init()
Message-ID: <aqwDrUzCW7_Xkfjq@ashevche-desk.local>
References: <20260917141414.2156326-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917141414.2156326-1-vulab@iscas.ac.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Sep 17, 2026 at 02:14:14PM +0000, Wentao Liang wrote:
> pmc_atom_init() iterates over the PCI devices with for_each_pci_dev()
> and returns pmc_setup_dev()'s result directly from inside the loop when
> a matching device is found. The reference obtained for the matched
> device by pci_get_device() (via for_each_pci_dev()) is never dropped,
> leaking a reference to the PCI device on every successful init.
> 
> Break out of the loop, drop the reference with pci_dev_put() before
> returning, as pci_dev_put() on a NULL pointer is a no-op when no device
> was matched.

...

>  	/*
>  	 * We look for our device - PCU PMC.

>  	 */

Have you had a chance to read this ^^^ comment in full?

>  	for_each_pci_dev(pdev) {
>  		ent = pci_match_id(pmc_pci_ids, pdev);
> -		if (ent)
> -			return pmc_setup_dev(pdev, ent);
> +		if (ent) {
> +			ret = pmc_setup_dev(pdev, ent);
> +			break;
> +		}
>  	}

...

Have you checked what the below means and why the MODULE_*() are commented out?

>  device_initcall(pmc_atom_init);

-- 
With Best Regards,
Andy Shevchenko


