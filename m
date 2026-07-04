Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DA62DECCC;
	Sat,  4 Jul 2026 11:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783165737; cv=none; b=hbaSCIFrhtmzIgp3BgE93Gd12Pj7jfmRbUWUKptPbp8z0CTmhY8DldbxVu+sQFdbZ2ng87DRPuD1z2SR6jZdLYmK77c1YdSNODQZ55DS9XJbV7zLh8gFjuTFRyjDT3G04FcP5fbPOAizk30jyrd59XcWiwCbAjh73N+/jISFac4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783165737; c=relaxed/simple;
	bh=btzbKisjFex9bTSgjIWLUm3D21TzJ8wWCH0apwsH90c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O9QrZPCJrdZpfWAm0dV3RtTHv3BFOvWs8hma6hIx1O++SNy9fh97/V9q2qqjxC5Qf59JZr//QdigABZOvyjwT+TyK2e/AnaINJsWP9lRa8Edp9EPu+65RtGNW6otJXj1XXqoXO5CroAe49p7gK8g6Hqh2ueLCElnuWH/sWWU1tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a+3v2TQX; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a+3v2TQX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783165736; x=1814701736;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=btzbKisjFex9bTSgjIWLUm3D21TzJ8wWCH0apwsH90c=;
  b=a+3v2TQXd05pZpGylRS7YE3XVIwHyr8q4sESjMaUL/6jvtReVO+tWduH
   rItoCDFG+VDyRRVQZkl5xzmYFL4T3JYSl0VGhS6hYSvnCXD4FOEoVW+YM
   rNRV4qil4HDPbUfoOwcBzxVf3RF7iqKb7djjMjaN8/rbEC5lVgVwNM13t
   Ro/b8sK9SuWwW0ap96/qIzwfv8j1z58GX/cy1KqhNnT9bTQ7UZRkAPrKk
   gmbytNsS8aFRBzaWg9ZP9ghO3gYQnQ5eTWagxW2aMR/kuco5TBBjwu1wj
   pfLGT6n4epp3SMtBipzpGHmyPQ8VEDwFClB7iJ5QthzaR4oDnSYjgAVwB
   w==;
X-CSE-ConnectionGUID: 35TOiuYdSAmPPyManoQO+Q==
X-CSE-MsgGUID: ElcFGD5XRuGrBszXMs+W9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11836"; a="106674779"
X-IronPort-AV: E=Sophos;i="6.25,147,1779174000"; 
   d="scan'208";a="106674779"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2026 04:48:55 -0700
X-CSE-ConnectionGUID: NCBY9eCTSPGK7Z3Va7eIGg==
X-CSE-MsgGUID: qd1/4NiySvm/0hmN/fcIMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,147,1779174000"; 
   d="scan'208";a="248844828"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.245.218])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2026 04:48:52 -0700
Date: Sat, 4 Jul 2026 14:48:49 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>,
	jean-baptiste.maneyrol@tdk.com,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: imu: inv_icm42600: fix timestamping by limiting
 FIFO reading
Message-ID: <akjzIfY5xnA6ahM0@ashevche-desk.local>
References: <20260629-inv-icm42600-fix-watermark-fifo-reading-v2-1-967e375db7b3@tdk.com>
 <20260703200455.5fa70e5b@jic23-huawei>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703200455.5fa70e5b@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 03, 2026 at 08:04:55PM +0100, Jonathan Cameron wrote:
> On Mon, 29 Jun 2026 21:51:55 +0200
> Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org> wrote:
> 
> > From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> > 
> > Timestamps are made by measuring the chip clock using the watermark
> > interrupts. If we read more than watermark samples as done today, we
> > are reducing the period between interrupts and distort the time
> > measurement. Fix that by reading only watermark samples in the
> > interrupt case.
> > 
> > Fixes: 7f85e42a6c54 ("iio: imu: inv_icm42600: add buffer support in iio devices")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
> > ---
> > Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> That's not confusing at all :)
> 
> I've applied with the invensense one only - shout if you want something else.

But the From should be equal to SoB, that's the requirement. So if you also
changed the authorship to follow it's fine, otherwise you need to use @tdk one
in SoB (and that's what I think was the initial intention).

-- 
With Best Regards,
Andy Shevchenko


