Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A39366546;
	Tue, 18 Aug 2026 15:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787067068; cv=none; b=eLAKZXwcy5YvTdWCByROC7s0zwPkfFskQhfvpF/Xkvear/hIAbC268F1BtdlBUD878/a9rmGyaQyQPSACi6e1T1Han18gvaCLgYMKkGqP8oJRMKFF9OJergh7Nq8R32qhHorvMnbYgL2usJW/Xo9QtTHbiWsW6K6/TOtI5nALWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787067068; c=relaxed/simple;
	bh=epCAGgKuBDq0HrFhBJVZp0QbkYQWKQTK24KVjDqB9XU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PdOauP+9rQqDzLrXXoEXWqJP2Fvd528CyRN6LZSttS9hsjOqjZA6OMwzNKFkEDUsCMYbHd8EAPru9Mh9qqpJ2dMx+D09HwzAvOrMEqQ/CwZGcwEUXnwE1fHPC7tZVn0J65BZ0fb31iZ0fIxe+e4tErY08stI9qHw2MzW1ONVO6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HjGn9Tvd; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HjGn9Tvd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787067067; x=1818603067;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=epCAGgKuBDq0HrFhBJVZp0QbkYQWKQTK24KVjDqB9XU=;
  b=HjGn9TvdqNKvz8G61sT9gp0ba+PP5ZsxA5VNZCFzHPwQ77BF2O443pNp
   PYJiK4n6MZV4DWQjRYoyRms8Bf+GHbpY6qd66yhYdLPSIj93sQKUKaWOT
   31y47mOmAUi2uPvPat71Qwznc6YpQUp+6M00dN4T3EeHST6EmL8lQcDe2
   Xy0uI7aF1SWyHRrtOf6wYLCEStp2ZqxR8U47j2cvc2D/vN7r0IUSxJ1mf
   IBCHM7AnKRm3z80x/Mtjwsu2ygTIsOEA8LFRQ4Pjy+M82JI08BZ5nG9R0
   0X0/Nc46AXLNK5q/LAe1HsatZvAOeaMmIIdJuCh03ZafQn2G5H2YRjn14
   Q==;
X-CSE-ConnectionGUID: aYINyOgkT3GYDUIydiJOxw==
X-CSE-MsgGUID: l+9y6lqGQ4uIcfzxS/heCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="97900191"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="97900191"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 08:31:06 -0700
X-CSE-ConnectionGUID: hSkeBypWRFmC+PZgKDzHWw==
X-CSE-MsgGUID: 4i/kZgIcQeSzg9f1t2Yklw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="261050892"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 08:31:03 -0700
Date: Tue, 18 Aug 2026 18:31:01 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH] iio: admv1013: initialize callback mutex before
 registering notifier
Message-ID: <aoR6tWAewJiVxOBS@ashevche-desk.local>
References: <20260818142811.2264343-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818142811.2264343-1-runyu.xiao@seu.edu.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Aug 18, 2026 at 10:28:11PM +0800, Runyu Xiao wrote:
> admv1013_probe() registers a clock notifier whose callback takes
> st->lock on POST_RATE_CHANGE. Initialize the mutex before
> devm_clk_notifier_register() so the callback cannot observe an
> uninitialized lock during probe.

...

>  	st->nb.notifier_call = admv1013_freq_change;

> +	mutex_init(&st->lock);
> +

Make it also to be devm_mutex_init().

>  	ret = devm_clk_notifier_register(&spi->dev, st->clkin, &st->nb);
>  	if (ret)
>  		return ret;

-- 
With Best Regards,
Andy Shevchenko


