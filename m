Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BCA57983C;
	Wed,  9 Sep 2026 13:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788961137; cv=none; b=DThJuX06aMfKa8kBxmNhfdNNKNvf0mNrh9s4Nj2XysDdsGh/otRm6e6Vj7RH+0zWUj0uSgtk8kh43NbaF4KWFNczoglIyA06PNNuon3zJB48rudEH6b5Gfa81JDLw6geY4VHwBg5J2eTEWhbJXWjZ5kNoqHRJ91N6idcHXENcwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788961137; c=relaxed/simple;
	bh=kkrUMnH8yv3h61tp8j6Sz+jX4436+w3k4skXWUq76J8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nb6b96Coe9OTYx9KUmCPaPKsW46HPilKv/1zN/39IPDEKfHnfxq/wfg8K2eq3kbNp43om5lNww8dNaqsodHWVeDsJO7fe+MHz2gDzbfawdBzfXkRBpfLn05YmKA9aAm053Me/qz8Jihc+ZC9h1qu0rXyuAFblCJw1xLd0NsRsos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f4J73DNz; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f4J73DNz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788961136; x=1820497136;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kkrUMnH8yv3h61tp8j6Sz+jX4436+w3k4skXWUq76J8=;
  b=f4J73DNzuz91q6xB1pSPvRH6xzLYKN7FYZkZ2J/a0Le03xRls/6Ht2PQ
   uny1HiOszP5/SzkphpSlOEqhvBbmAx/B+lygiSpwyPbgutAO7RBbSm+ZE
   cEgfvgq8t8tRTWS2T/WtQ/MBLyDtYy+pTSc8OdjPdUYDUoZ5rtynTefTb
   kVg0LIolDIbqzn8tDuy3NpaW0CamdplKL/0f4So+1wlpx8kA4ev4izeXN
   h1/FdkQGi289+4CJzL0WEZC2nKqo6NuhGsJcoZOzMAczMS0GM+UTcrDxN
   bBAZXGIJ6xiuCXx99UvbY3+WcLe8HNfnjC4u8W72qzzPT3Wf8elpjZC3U
   w==;
X-CSE-ConnectionGUID: 3SdAA8wQSRq+9OG3HS8Hmw==
X-CSE-MsgGUID: oPqbDYC1S0GYwl0L54fZKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="106757625"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="106757625"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 06:38:56 -0700
X-CSE-ConnectionGUID: wqVtZCvYTpWk+liciHCk3A==
X-CSE-MsgGUID: f0P5yE4hSLyEe6AC6EaKug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="271304509"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.249])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 06:38:53 -0700
Date: Wed, 9 Sep 2026 16:38:50 +0300
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
Message-ID: <aqFhagdhM4Z57eqh@ashevche-desk.local>
References: <20260909130304.1395-1-joshua.crofts1@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909130304.1395-1-joshua.crofts1@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 09, 2026 at 01:03:04PM +0000, Joshua Crofts wrote:
> The MAX14001 has an SPI ID table, but does not export it with the
> MODULE_DEVICE_TABLE(spi, ...) macro. Because of this, SPI-based module
> autoloading fails on systems that don't use devicetree (e.g. via
> spi_board_info).
> 
> Add the missing macro to export the alias information.
> 
> Fixes: 59795109fa67 ("iio: adc: max14001: New driver")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> ---

Changelog?

>  drivers/iio/adc/max14001.c | 1 +
>  1 file changed, 1 insertion(+)

Code wise LGTM.

-- 
With Best Regards,
Andy Shevchenko


