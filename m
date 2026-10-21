Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792601401;
	b=cpvGf9dux4K5Jy/bT9X8LrVVzXIsWrHXt2Q5FjEhrLeSNiIHTQov5gRLWJFGFMB+AMCV
	 zz/EZQ5J+Fz1bI7/O6JpfjuubKdoxVY/1EP5F6ZYxtx0WlbwgH2b73ew+awcuOh+cAmP5
	 q1pXjiEjthseUeKKPX+e2xntyZsMzWN64nLv0FJwYcO48Kl88i99wo3TTa4u1n+pfBV5l
	 24BGQ3W+sGZ/ACdr6vfwiy5AM2PX4R4JClmq7Mpnxo7GA1wLCbJ6zf4z1aOXGmXDd8HsQ
	 U6KkidEQpj4h2ZcrjxYviDr99M8n0JeRKSAPe8Hws8sx+owmSu0jJX/RXZjmj2sIPqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792601401;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=pbQHvtP2agFCDLvgA6a8a1Qn0DguhjOVQOQh4hVyc1c=;
	b=sb8SOYs/drt4I47v89sS2CzwUW+XKzvC7GNrs8lP3aDK1debwdDsnWAC1GWndKsu1jOR
	 mGXZtjGNDyWZ1eZdc+xOsfDdWlwgSinDUNQCqtePxB73Bp4ZJPMijmTmHxm10CytaBciq
	 ViQoXf8voJVHRg5dxO+RUKRL0a5SU3psJ/UUBqBvmq2FPXYPfV+LXK8V01y1j4hcWzGIQ
	 JaAC1+bqwide8Tv5ySKDOCCJ1jOFc2nmd7qCv9kmOR2CM8dTSoSa4eQKELQD8VKZ0u11/
	 X9dpHj2BfBnNK8UvC3kVk5cQhN8GTPjDqeFvObXm4krj/BwdihW4a5ZID16/L3PldfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TtL3b4Qz;
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FEE606A31A;
	Wed, 21 Oct 2026 16:50:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6FEE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TtL3b4Qz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792601401; x=1824137401;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RsaIR9ZqUTnA7KEwP2H9857dgRToTlZ4wBXaAm3lM58=;
  b=TtL3b4QzHR3c0pbIr/VYY2tYHXKcfsdUqkZxeP+1QsmelH85guwdi5NZ
   +cZ+0M0B905NL0V3/KAyJcszmTfkFzHSncI5CRoJKL7vokPsE0CWjrd/s
   8+gyGlWF3yXEtEThUiUsYgmCW8Uag4gufBFSpVrKH0SfKKCuRXHwyb6Sd
   FP4pj+22OAvVQjNgcykx00vgr1DXsMbe8vzU2k2MR3Hp06RJjvs+6MiCi
   GB5jCkAIuwEERmWxJQpip7RDJzrT5tPgH0iNawRZEJtkhMgNfG4kdgmpB
   Cg7DHDGHfkDzmhFHv3gdVZn9edDbAYnnRxZWiMvz/T7UtR7usl4+ZADP1
   A==;
X-CSE-ConnectionGUID: I2dq5ym0Td2ANakLw+xJBQ==
X-CSE-MsgGUID: Wlkn+ZEVRDuqqZD0Rxnp3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1345890"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1345890"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 09:50:01 -0700
X-CSE-ConnectionGUID: iChk2JnlSxK8bI30Mvmjrg==
X-CSE-MsgGUID: ZR+AyCOiQgy61ICoW35aQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3015296"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 09:49:58 -0700
Date: Wed, 21 Oct 2026 19:49:56 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lee Jones <lee@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>, mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 11/28] mfd: intel-lpss: Remove registered MFD child
 devices on probe failure
Message-ID: <atjtNCBf-geYL3yY@ashevche-desk.local>
References: <20261021121245.3111563-1-lee@kernel.org>
 <20261021121245.3111563-11-lee@kernel.org>
 <atjFroYp0Cp7eN8c@ashevche-desk.local>
 <20261021163333.GH1795367@google.com>
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
In-Reply-To: <20261021163333.GH1795367@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Oct 21, 2026 at 05:33:33PM +0100, Lee Jones wrote:
> On Wed, 21 Oct 2026, Andy Shevchenko wrote:
> > On Wed, Oct 21, 2026 at 12:09:33PM +0000, Lee Jones wrote:
> > > When intel_lpss_has_idma() is true, intel_lpss_probe() registers the
> > > iDMA64 child device via mfd_add_devices() before registering the host
> > > controller cell.  If the second mfd_add_devices() call fails, the
> > > err_remove_ltr error path returns without calling mfd_remove_devices(),
> > > leaving the iDMA64 child device registered after the parent's
> > > device-managed resources are freed.
> > > 
> > > Call mfd_remove_devices() on the probe error path to clean up any
> > > previously registered MFD child devices, matching intel_lpss_remove().
> > 
> > Good catch!
> > 
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > assuming you will add Reported-by: Sashiko...
> 
> Roman suggested Closes:.

But Closes goes with Reported-by. The Submitting Patches says:

"The Reported-by tag gives credit to people who find bugs and report them and it
hopefully inspires them to help us again in the future. The tag is intended for
bugs; please do not use it to credit feature requests. The tag should be
followed by a Closes: tag pointing to the report, unless the report is not
available on the web."

Okay, you can argue on 'people', but the established practice includes 0day LKP
bot for a long time.

-- 
With Best Regards,
Andy Shevchenko


