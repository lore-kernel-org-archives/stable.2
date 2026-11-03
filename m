Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793703007;
	b=tbfM4GZ1nnrNSOkJ4nQgso7tZ3Eg7RkPFzwvA3HeBg8TUapMxDnO4Wg1LEG6aOv8WueO
	 oBAvAGAMNobC9C9PYDx5G3B6DJxmMrU3wSZlH7dNJQJh5vPqTxDYEB3towFetsMSqRW0a
	 H2iu7qYj705ij15f2u16Zqh6sTeDSC9mu59OYnTn2BD7wo5AoIufA7q6MWAUXSCpMhSu0
	 Med20DdwicQWBq3cECHZBwU2NFk5UzV96aAn58TKIdtyxnBy+Uksix4ykmP1YXVhcwCut
	 glXITWARwtJ+DHhb1vBCAAut/Xly6zGSRkOTDJmQAmGRRC5ClprEUMm+WVBnMI5i5Yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793703007;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=0Twt1ubhhwkSVqa2+NBMmrxwJ9oj4oW0ZidUXiGlzd0=;
	b=0/TojzIozQTL19SyAAPd9t9Hm2DV+aFNNeRQlCkzEhPTtzqm9J7j5HvRw2du5vLZi9HI
	 zj6Xa5x4LZ78UHbKSAzZqngfNyH0zvwg4XEudt2wHLYj0YkulvKK8KHbNh4GxzXqha7hM
	 INso3exCvrcpnuOE8wG96hwp7ju/dUm6z/HGWsI95SLMjIxxgRSSaKfq+R6Ida+rxnN0v
	 Dc/s6iVljRryQwX/jbbgBVXP2EYw7gveEbsGTNKX7y1JEonAxQMoazv5IctZ+Jfpou6yV
	 SjO/rKNtP/ufgvRapeCMfJoYSt4zydYOAXA9ksWM3erGMXxlu3SLO2nTWPTjrqO8EMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ObOhRzDg;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7194606C5C3;
	Tue,  3 Nov 2026 10:50:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7194606C5C3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ObOhRzDg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793703007; x=1825239007;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AeMP+Dno2BcuEEsDtGcb0+AdPetsLph8H2MHxksDXOs=;
  b=ObOhRzDgytrmJJU8ujP4j8Q76DkIXcHAlNyIVZDx6m+NKBvg8LnE5Pdi
   kfUlvwqZcfytCKJmUJyYN8iCaSZ6Djyanu/B+N3FMs8v3Q35FyoYpbtXR
   qeZih96XNj9CIkjNtQ6TU13iZ6ccmdW+2kE5C1x5SVo6I6piKKpKTCs1S
   jQbJF9N9EMX2yAmYkF4nIZAf2nIfkrD4J18hWlhQ5XYN3pUD6TOKmcedU
   dtA+xlWWb5gILsNTIr2f2Zk+uZWZ3IUvcIpXueP85dVKWtwNTBLNaJASx
   gGFhB6bZKjJnzpBypf8PfZFzG8z4q5155njzusi2NT9/2P/tVHLbNSEFf
   Q==;
X-CSE-ConnectionGUID: HvpkqQ0+RmqCUTxFBwTuew==
X-CSE-MsgGUID: SuNO2PhETTGuS+VRCxu/8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2449422"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2449422"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 02:50:07 -0800
X-CSE-ConnectionGUID: IwlDpm9ITMKOWL+QsRTtLQ==
X-CSE-MsgGUID: q+42XmEGSPetp0HGeZ7B4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6387891"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 02:50:03 -0800
Date: Tue, 3 Nov 2026 12:50:01 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Kent Gibson <warthog618@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Jia Jia <physicalmtea@gmail.com>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v5 1/7] gpiolib: wait for pending label frees before
 cleaning up desc_srcu
Message-ID: <aum8WdFzoi_f_RnN@ashevche-desk.local>
References: <20261103-gpiolib-chip-removal-v5-0-aambrozewicz@nvidia.com>
 <20261103-gpiolib-chip-removal-v5-1-aambrozewicz@nvidia.com>
 <aum8DRhBqCOiEUsj@ashevche-desk.local>
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
In-Reply-To: <aum8DRhBqCOiEUsj@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 03, 2026 at 12:48:51PM +0200, Andy Shevchenko wrote:
> On Tue, Nov 03, 2026 at 12:32:34PM +0200, Adrian Ambrozewicz wrote:
> > desc_set_label() frees the old label with call_srcu() on
> > gdev->desc_srcu, and gpiodev_release() calls synchronize_srcu() before
> > cleanup_srcu_struct(). synchronize_srcu() waits for a grace period, not
> > for queued callbacks. Once the srcu_struct uses per-CPU callback lists,
> > a label freed by gpiochip_free_hogs() can still be pending, and
> > cleanup_srcu_struct() warns:
> > 
> >   WARNING: kernel/rcu/srcutree.c:706 at cleanup_srcu_struct+0x239/0x330, CPU#0: init/1
> >   Call Trace:
> >    gpiodev_release
> >    device_release
> >    kobject_put
> >    devres_release_all
> >    device_release_driver_internal
> >    platform_device_unregister
> >    gpio_sim_device_deactivate
> > 
> > Use srcu_barrier(), which waits for them.
> > 
> > Reproduced with a hogged gpio-sim line, setting the chip live and back
> > on a 4-CPU guest with srcutree.convert_to_big=1: it warns within 60
> > cycles; with this change, 1000 cycles pass.

...

> > Assisted-by: LLM
> 
> This tag is obsoleted. Instead explain under '---' how AI has been used to
> generate this contribution.

Actually do it in the cover letter, as seems the whole series tagged with it.

-- 
With Best Regards,
Andy Shevchenko


