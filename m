Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89307243956;
	Sat,  3 Oct 2026 20:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791058498; cv=none; b=NgJcFW35tKwRwo9QyaCI5mLOcju1qcAwHyC1eeUV3B0fI0mLxfbZReGZlD67ToG7ftCdd6g7JzIwmdNErU4WHS/q2CWLCeOopB41oF3OgVXdWwmDEVR3l4MZ0cjxaVaj/bDqgkLEE8aZEEX1elwpZB1N0ocEWI5DjanjvAF4rxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791058498; c=relaxed/simple;
	bh=NSqc6QBhN3exxXHfH8Tav6Imgr0hJESeC+/6AgzrzrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u84sG77L6n+Z8+yA/n8v7ehPpBFga4LbYkKMphlZZSpKya5DhvH1ZTEBqGl10ZDB/bjC1ztqitRjDDitQD2gPs9pwl983IdSZZW+g/6dyWk8dQdiseObEvlX55IKdmLYLZmCG76Nz5PoFtiUAwEaE7SrxJsEsk2znTUEcD8s3Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q5F+IhIO; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q5F+IhIO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791058497; x=1822594497;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NSqc6QBhN3exxXHfH8Tav6Imgr0hJESeC+/6AgzrzrU=;
  b=Q5F+IhIOFs2MspTCPDAHog3zOZZ/oOWnjlCeDsIEZ7+KNZKIB3UOzZld
   gSovnT+vjtN/t8X0/7O1N7Cs4jExcWJx0TdxxPGMou+JpfCIwH7ge4nSj
   3j5uDKKr1ssLlS04kE3KzqvMqa4vOl1LcZKBevm84fZFLCkTcjp5toKRK
   CK3pSvHLVFtncjhEP7NvzMc+trOxXptCAkRe2LWAmdXmRpydfgBk1qDeo
   WXsgmxdmMlSLgQ+ClqshfRpjK5hqDYxs0hp7HnRIazXBP2iGIeIvxUk4M
   55zSz9BqHiPoKW6m4893PfAaGgmw4dCk+HA2/vqHnY0gDlKcF/SWqB5Lw
   A==;
X-CSE-ConnectionGUID: dyAMKkz2TSOEGNcWQdtIiA==
X-CSE-MsgGUID: XIj8Ya1TRLOj6mj3L4D09Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11924"; a="90816665"
X-IronPort-AV: E=Sophos;i="6.27,138,1787036400"; 
   d="scan'208";a="90816665"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2026 13:14:56 -0700
X-CSE-ConnectionGUID: f5mP1bFsSLqhZNHsyPD1JA==
X-CSE-MsgGUID: xTvsdTMURy2jTFm7GKjGhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,138,1787036400"; 
   d="scan'208";a="280234090"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.245.78])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2026 13:14:54 -0700
Date: Sat, 3 Oct 2026 23:14:51 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Muhammad Bilal <meatuni001@gmail.com>
Cc: Jorge Lopez <jorge.lopez2@hp.com>, Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 1/9] platform/x86: hp-bioscfg: fix OOB reads in
 hp_get_string_from_buffer()
Message-ID: <asFiO0hjqzGdmAMn@ashevche-desk.local>
References: <20261002191434.58529-1-meatuni001@gmail.com>
 <20261002191434.58529-2-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002191434.58529-2-meatuni001@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Oct 03, 2026 at 12:14:26AM +0500, Muhammad Bilal wrote:
> The escape prescan loop uses 'size' as both its bound and its
> accumulator, so each escape character found extends the loop and
> reads past the end of src[].
> 
> Use the original u16 count as the loop bound. Also include the 2-byte
> length prefix in the bounds check, pass the u16 count instead of the
> byte count to utf16s_to_utf8s(), and advance the buffer by the bytes
> actually consumed instead of the escape-inflated count.
> 
> Tested on HP EliteBook 840 G2 (Fedora 44, Linux 7.2.7).

...

> -	/* Ensure there is enough space remaining to read and convert
> -	 * the string
> +	/* Ensure there is enough space remaining for the length prefix
> +	 * just read plus the string data it describes.
>  	 */

/*
 * While at it, fix the comment style for
 * multi-line comments. You can use this example.
 */

-- 
With Best Regards,
Andy Shevchenko


