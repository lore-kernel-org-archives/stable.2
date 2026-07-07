Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B6C338939;
	Tue,  7 Jul 2026 07:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783408916; cv=none; b=t9r+9hgpvCv5o67W1k4eYVjdK+nFNn6IbbMdvELquLnRcsxmwtFncvXwQ3d7IgBOkIc0AFyYHyGYOU2pL6M52DgQ5Kr9UC866vF2b2krTYPgvIkTOTx/GHngHafFb867SXg2T2rYJnFnmAfMuiMTAAYKHpzyWehQ/HgfwxkszGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783408916; c=relaxed/simple;
	bh=ZtojGnZBKjhZ1jLcpv9HXgUyb0rU4ioNyze1gBgUHis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pNZrUPSN2LEE613Xp3/O66+4LO8WUESzB7sgKwo2bGwbZedYivOua4tG8Of2jCjrLOhxgrwoycNlmQMAyDHOoqJP1OO7RerVkC9YVJDRaFIHjw2XgX/UM4ua7e2cZTGIU2ZkI6QShfeRZw2/qXJEvNJ/Cv6ktf9T7b8cxYCi8xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HScdk+4F; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HScdk+4F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783408911; x=1814944911;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZtojGnZBKjhZ1jLcpv9HXgUyb0rU4ioNyze1gBgUHis=;
  b=HScdk+4FAYn/VgI4R/RHE18wf1aWbVdkmOxRIJC8X+WhxbHPf1rTm1jf
   zCxGVjZzmH/n3Dhp/TBuR1fXCkx+4/bGLfPJYydGe9IVIOihQ0Ru3N1jR
   sGteQpqSnfs+jkr6hsuGF5fve35PgofsUsSvmZKnCWcAuMALm7JhCOOPK
   IRX0HeK8lrrEDCya0KVO99EpY3CFH74/hbVsgXo9a88PQMCDQhS5jllMU
   cFA3dLGQLUM77x4y+p+JqObsqgI9D554dZ5sh5jsezpLTQK3N6B1og8rz
   q/jkg96hYHX85tzCz06a1T90dB4NtnuN/KFn1JK30zWfNXReJWaLHE2AK
   g==;
X-CSE-ConnectionGUID: O9Vcwz6xRb+Xbl7bahfSGw==
X-CSE-MsgGUID: A0eDHh30TsKCIePa76PkIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="84073166"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="84073166"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 00:21:46 -0700
X-CSE-ConnectionGUID: 5TvB1YjcQqClyy7q0nrN3g==
X-CSE-MsgGUID: fsS68N2JRiW3UszHmq1CCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="254010121"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.178])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 00:21:45 -0700
Date: Tue, 7 Jul 2026 10:21:42 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Usyskin, Alexander" <alexander.usyskin@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	"Nilawar, Badal" <badal.nilawar@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Adin, Menachem" <menachem.adin@intel.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	lkp <lkp@intel.com>
Subject: Re: [PATCH char-misc v2] mei: lb: fix incorrect type in assignment
Message-ID: <akypBhzJdxGLJiYq@ashevche-desk.local>
References: <20260706-fix_type_le-v2-1-586826351454@intel.com>
 <2026070608-reformat-pungent-aeb4@gregkh>
 <CY5PR11MB63665C97B337ACAC21A8A626EDF02@CY5PR11MB6366.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY5PR11MB63665C97B337ACAC21A8A626EDF02@CY5PR11MB6366.namprd11.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 07, 2026 at 06:43:20AM +0000, Usyskin, Alexander wrote:
> > On Mon, Jul 06, 2026 at 04:01:30PM +0300, Alexander Usyskin wrote:

...

> > > Cc: stable@vger.kernel.org
> > 
> > Why cc: stable?  It doesn't actually cause any functional change to the
> > code at all, right?  This isn't running on s390, or am I mistaken?
> 
> This driver is for discrete graphics card, so it may run on non-x86 system, thus all conversions.
> 
> I've been told that if there is Fixes: for commit that already in stable, I should cc: stable.
> If it is not hard rule, I'll drop cc: from the next patch revision.

Cc'ing stable@ is a rule which is documented in-tree. Many developers just omit
it for unknown reasons.

-- 
With Best Regards,
Andy Shevchenko


