Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792602121;
	b=wVoeVkOk7UttZKIfwE1yZZKnhm4zh7v+QJLktTM5Tcb7WsiiCosWxXcldo3pnrI4gtC+
	 a1G4HScqQToKucxuzemVgyRyBG/Mk5knxxWW1VcyKDPpCfqKDSNnvSQa2E1uGPCroYPcg
	 FQyAsdXOW5FYI/QRfP2XJ0LDVgHlAcjaioUZCAmj37kvElvww5a3najdaxbT5F/Hnvrlu
	 mPKazw+oEN5NkzRgN/mMbK6HtvKgq1IgMAMWSipN+32VysQY5C5nMm6kS8eKUr+61ebZb
	 RtNTGN7AuLofzgJuAK9PXeaxsWDyAnyAOvwnArfm2v+gnCK4CfZvUJ6VN6yETicKbag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792602121;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=mePSPJATHsGdUfBbhs8qu+gZ9UWtO+tPw83R8tHqLNA=;
	b=YxYvFMGkdZM32dxWsGs5KllAT++IAjBn31EYXcc14yBkNldkM8WBC5lSjPt7GG5VGQCx
	 tip5rzjdSWpdcq+AbJjPYXWoZAMTrdov03rbO9QW+1RIhFiqNoiiCYlMIcNHnYf0oUwx/
	 TdXy2eMU0AfEMTqt7YSdjaHaynbJp17X/kpZ19iaIrc77jU5CXjyiPpu/EFugP6jElDLt
	 1OqgBgAoK0j+qlCIVrD9g/M/UUkAn+k8gahiNH+xhnBQZMdP0/F4/XEWMBY7Pja5MzWim
	 BZg1t9olAXSr+6ozjeXiCHUMTHrA92r5dBHSRPoqC3dP2y87BYVG9ocs86gS+H5InQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=N+2zZgEv;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B676B606A319;
	Wed, 21 Oct 2026 17:02:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B676B606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=N+2zZgEv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792602121; x=1824138121;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qampBoOPcfws+SCopvn4zE9DZ8QpoNbER85isk3vXMM=;
  b=N+2zZgEvUXmacEeqaASTl8NdgBZzQXUzXQHyOT2bjMrFeJWY/u64125l
   ctL0Phj2BuNr7NebzGrxS7JBXsS8FHi83al8TpC6Ipk8Bta0IBkLzhed7
   l4OcTWo5eZ/QhRk4M5aJSfsZVgt7PhgYYvBIbKhen0UWhNE7q4Dkk6dZU
   yAVUtU5qsX/QrQzlfkiR9sN+Gl4JE/dNCkEfNeNp8bDz5Umjn+o+hVIv4
   jSXwx4oj/lamLk4pmXVVmrtObY3lUJ8HQQaNXDCBKWKC8aMbxxk3ukJtt
   x6YNtKHszafKfdCLSiejx43wfMbuv7dxkbdtbwIwolwAAsNB0zbRPdQTO
   A==;
X-CSE-ConnectionGUID: Hhqw4JF7T0GFmLlrMUVejA==
X-CSE-MsgGUID: tRIOgTi7RimuJKcjjxlfeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1212378"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1212378"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 10:01:26 -0700
X-CSE-ConnectionGUID: I0th04K1QUizFfkakI+r4Q==
X-CSE-MsgGUID: 0v22F7vLRDu7pmlv3+91rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3083714"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 10:01:22 -0700
Date: Wed, 21 Oct 2026 20:01:19 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lee Jones <lee@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Philip Li <philip.li@intel.com>, lkp@intel.com
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>, mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 11/28] mfd: intel-lpss: Remove registered MFD child
 devices on probe failure
Message-ID: <atjv3_Njp5gW7EUF@ashevche-desk.local>
References: <20261021121245.3111563-1-lee@kernel.org>
 <20261021121245.3111563-11-lee@kernel.org>
 <atjFroYp0Cp7eN8c@ashevche-desk.local>
 <20261021163333.GH1795367@google.com>
 <atjtNCBf-geYL3yY@ashevche-desk.local>
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
In-Reply-To: <atjtNCBf-geYL3yY@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

+Cc: Documentation people, checkpatch maintainers, and Roman and LKP folks

On Wed, Oct 21, 2026 at 07:50:00PM +0300, Andy Shevchenko wrote:
> On Wed, Oct 21, 2026 at 05:33:33PM +0100, Lee Jones wrote:
> > On Wed, 21 Oct 2026, Andy Shevchenko wrote:
> > > On Wed, Oct 21, 2026 at 12:09:33PM +0000, Lee Jones wrote:
> > > > When intel_lpss_has_idma() is true, intel_lpss_probe() registers the
> > > > iDMA64 child device via mfd_add_devices() before registering the host
> > > > controller cell.  If the second mfd_add_devices() call fails, the
> > > > err_remove_ltr error path returns without calling mfd_remove_devices(),
> > > > leaving the iDMA64 child device registered after the parent's
> > > > device-managed resources are freed.
> > > > 
> > > > Call mfd_remove_devices() on the probe error path to clean up any
> > > > previously registered MFD child devices, matching intel_lpss_remove().
> > > 
> > > Good catch!
> > > 
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > assuming you will add Reported-by: Sashiko...
> > 
> > Roman suggested Closes:.
> 
> But Closes goes with Reported-by. The Submitting Patches says:
> 
> "The Reported-by tag gives credit to people who find bugs and report them and it
> hopefully inspires them to help us again in the future. The tag is intended for
> bugs; please do not use it to credit feature requests. The tag should be
> followed by a Closes: tag pointing to the report, unless the report is not
> available on the web."
> 
> Okay, you can argue on 'people', but the established practice includes 0day LKP
> bot for a long time.

OTOH, there are also examples for Closes: w/o Reported-by. I'm confused...
So, what would be the best practice for all bots WRT Reported-by/Closes?

-- 
With Best Regards,
Andy Shevchenko


