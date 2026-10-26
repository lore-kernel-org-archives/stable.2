Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793005562;
	b=ngvF+SgmHHZbbBG2SIwOt1KW8+XNmPuWg50CZ9GfCrUkp4888Rd6TmDyz42Cmcq/+icC
	 D6m13SFeHS/0Ybe5YdYyktHpsRMPO6AOVAq3dUau3jyTsEIn2npDAbXo4IbIxQ3LI56tO
	 61Dhog/mWYC/8qR6GyTSSTv6CjD7OmcbBdydV3i9Jol71Kj8OUkqdBsAJKLmLvmd3H6DO
	 Dl385ycbdfqHfO1IKB3+GUMHYJjDBcRNkxRen320NP8MBuXQxFmEYmcmaytE8CFEnbdD3
	 1NwC+a24jtaR3BLecpeE8zjinZktIOrQFCEdbcF2/2lxIrxRYFHDMjHinMxYH+iBLNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793005562;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=6rfumQaYpABxgWOFoid1PGociqatj2vsd6oLQZ3XZn0=;
	b=38h6oKpPN3BMOxhwtQepCAs10rpu718K5NcosnsD5uh2/LxkFUEwdSOZprEmCtwdCpTr
	 NfcW8k8BJdrmp7XIA+nC3v9KgtiaktvqwEwJd+CiiNwYHyAWIdUp2Q1h2FQB2VBtoCybH
	 51wGnYBK1zpqeUtYKrpDYrCiJVOMinHuN7vkiCHCLRdXcAOr7/akJiWIVhKAhGu2KshF3
	 tdmmeRInBt2Ejn+svT2B6xWQrq+5SMlD6y37KFunbXtPYMH/A/VSdi/XZKKKxp8ECL4t+
	 L1kTlbGRtFT86xnXj9MHiyk/y/Vgf717yOCWryQfRJ+snjZkW5vid9kjX94adO972TA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZUyqw5Kc;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011A8606A31A;
	Mon, 26 Oct 2026 09:06:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 011A8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZUyqw5Kc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793005562; x=1824541562;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IYmuIJpwOSwQUw1waf6LOAjny4OLysbFDIu56qrcZ+Y=;
  b=ZUyqw5KcHSggmuDUcV/PAAbQz7jGhFOMFA/vK/44skTLlNOpt7Z2GtGy
   IbiD1+inxOfJDk6E4DxzBOlKx4yAbFmkStSdqkCGxaFLDWrxeV4Bfk9P0
   8CyX4f5xXILmDt9bEI5hl20UmgKoPb0StwBdA/hJK3ddRF+bQuL19uOwM
   yBgW2Jaw3ZbWfG7oaluz1Kj5E3/CwaZFW9o7K36R3d07oLuM80Sk0/aNI
   RHXSPFVVmq9JSMhktz0Kj9W6Odh29IzgZa00tv5P4PwRRJekQbl6D0Bxc
   WrQij0/7GnbU/jMPb0vIK49bIT6bbFdVW7cD0wfqF7ezgVyV+rfya3gdj
   w==;
X-CSE-ConnectionGUID: Ui8d48fSTEqdOC9XCXQsvQ==
X-CSE-MsgGUID: J1NgKjXYQzmI7cCiGWFyDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1572970"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1572970"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 02:06:01 -0700
X-CSE-ConnectionGUID: UXkaq4sISqG3pbmLkJ04bg==
X-CSE-MsgGUID: iVx9PH64Rqy4VwCN+JYzWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4564737"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.93])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 02:05:57 -0700
Date: Mon, 26 Oct 2026 11:05:55 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Rupesh Majhi <zoone.rupert@gmail.com>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>, Joel Stanley <joel@jms.id.au>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] iio: pressure: dps310: wait for a new sample after a
 ratio change
Message-ID: <at8X810dwa98w9iL@ashevche-desk.local>
References: <20261019153328.80739-1-zoone.rupert@gmail.com>
 <atZqSXI14WojGso5@ashevche-desk.local>
 <20261026024605.3286702f@jic23-hlaptop>
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
In-Reply-To: <20261026024605.3286702f@jic23-hlaptop>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 26, 2026 at 02:46:05AM +0000, Jonathan Cameron wrote:
> On Mon, 19 Oct 2026 22:06:49 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Mon, Oct 19, 2026 at 06:33:28PM +0300, Rupesh Majhi wrote:

...

> > >  /* Make sure sleep time is <= 30ms for usleep_range */
> > >  #define DPS310_POLL_SLEEP_US(t)		min(30000, (t) / 8)
> > 
> > Seems the use of USEC_PER_SEC below should be postponed to a regular cleanup.
> > Because otherwise it will be inconsistent with the above where it would need
> > to be 30 * USEC_PER_MSEC
> Do we want to have the extra churn on the below?

I would bother in case there is no clean up patch attached and we will be left
with the good *temporary* inconsistency that lasts for years :-)

If Rupesh is going to add the patch to clean up that (before or after this patch)
I wouldn't be triggered.

> I'm not that bothered by a temporary state of different styles.
> Nice indeed to have a follow up tidying up other cases though!
> 
> There is quite a bit going on around this driver, so I'm going to pick this
> one up for the testing branch of iio.git rather than the faster path.

> > > -/* Silently handle error in rate value here */
> > > -#define DPS310_POLL_TIMEOUT_US(rc)	((rc) <= 0 ? 1000000 : 1000000 / (rc))
> > > +/* A period plus a measurement time; silently handle error in rate value */
> > > +#define DPS310_POLL_TIMEOUT_US(rc)	(2 * USEC_PER_SEC / max(rc, 1))

My comment basically based on the existence of the no-multiplier style, and
this patch *changes* it here, but not there. And it's *this* patch that brings
inconsistency.

However, this is quite a minor thingy, so up to you.

-- 
With Best Regards,
Andy Shevchenko


