Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E5B221546;
	Sun,  4 Oct 2026 08:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791103085; cv=none; b=WdS8m72+33TqCvUiPOB6fWHxYVMQlZWLCdA+nHRVAr7pa2TJbsyZDX5VwBZhrUW/8AJM3se2cvS3XvV2kvoCAy+RJmP0jsYrrjj/e0Ee8hqscDMOWC+SA5+EuvYQsd3uUwR81494fLfX2q9xuOkEooDz4QlExXfqbMOVwkgX+Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791103085; c=relaxed/simple;
	bh=IMcLQQxd7Mxh6dB7j3tZV6cCtdB4uJjBpBLuMnuoQw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NReYw8/Tjhk1i2QO6P9EwI+4AeWNERGfthn706HBBaidkSfwvPSkATbctZJbB3Ux2XbN+i3a30vMoz124Za9UDN9spAHKV4ucmz/8yomjHicB+9AjtPGbgs5ir2W31l1Nxz/IkU9ReLWAhjZeEyiQKNWeoaGi3VEAaJP282Z+W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KWHyS57Q; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KWHyS57Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791103084; x=1822639084;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IMcLQQxd7Mxh6dB7j3tZV6cCtdB4uJjBpBLuMnuoQw4=;
  b=KWHyS57QG+TEJwJXIb5exi/h0aGU0VbOFxAok7mdq+eaTXq1I9J4epeh
   hnqi+tzfHJaAOOkhhFkLDSlXHdTq2kjs7V2JK2kGfN8xhhwK7wY97yOuC
   WdZfymHPMSDf+AsZIIY00HdpFX+i4Gig7w5I0eWyseyqhls76eJ08Ev0Z
   iitgDdyTAWaccp7VR52eBl3Go8/s5VuzzO1zLdRgwUSD9F+zfry0kr2Ac
   lVuN6/b22v2oSkmhsAlwQARloh+lzcJUbMXxs8vMCdN2W5QgI4VLQIJI+
   lctbwUkuvcviH4EFEw5Okcfd6TfNh1qStsiLK6U4SH9gHaXTtnFVCy5sq
   w==;
X-CSE-ConnectionGUID: vCshJOtkQYybizUmr0nypw==
X-CSE-MsgGUID: qeUOhELoRWmBD2qZ8/D5Jw==
X-IronPort-AV: E=McAfee;i="6800,10657,11924"; a="94513098"
X-IronPort-AV: E=Sophos;i="6.27,139,1787036400"; 
   d="scan'208";a="94513098"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2026 01:38:03 -0700
X-CSE-ConnectionGUID: ngJrZwJlRLeKKNCMs4tMCA==
X-CSE-MsgGUID: n+3jFFvORWm0bwj4IQ8fng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,139,1787036400"; 
   d="scan'208";a="274691150"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.100])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2026 01:38:01 -0700
Date: Sun, 4 Oct 2026 11:37:59 +0300
From: Andriy Shevchenko <andriy.shevchenko@intel.com>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Karol Wrona <k.wrona@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH] iio: ssp: Serialize watchdog timer state changes
Message-ID: <asIQZ7no-0OrOGn0@ashevche-desk.local>
References: <20260930070319.2933744-1-runyu.xiao@seu.edu.cn>
 <arzdLtzXQ4cvObrL@ashevche-desk.local>
 <20261004053915.1138888-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261004053915.1138888-1-runyu.xiao@seu.edu.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Oct 04, 2026 at 01:39:15PM +0800, Runyu Xiao wrote:
> On Wed, Sep 30, 2026 at 03:03:19PM +0800, Runyu Xiao wrote:

...

> > struct ssp_data {
> >     struct timer_list wdt_timer;
> >     struct mutex wdt_lock;
> >     bool wdt_enabled;
> >     struct work_struct work_wdt;
> > };
> 
> On the x86_64 build, pahole reports wdt_timer at offset 16, wdt_lock at
> 56, wdt_enabled at 80, and work_wdt at 88; sizeof(struct ssp_data) is
> 816 bytes. There is a 7-byte hole after wdt_enabled.

Right, so you can make it 3, correct?

-- 
With Best Regards,
Andy Shevchenko


