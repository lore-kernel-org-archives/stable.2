Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759403F86E6;
	Thu, 24 Sep 2026 13:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790257282; cv=none; b=GQA2QCFCAd/M37ivDutI2hj6eyjdA4EMUbyuoXmceTdSxM5e14gxA7nGKRi5bGAkQ+NjjN1//jvI+lPsgr71NznpXvWoLcS8/pZIE2Kem3QzkZO3qcVOUCq1VxADbaDXJKAM8PPEKrU8KhXqt3aWBBecezH1egj2terz7cJI454=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790257282; c=relaxed/simple;
	bh=PFdeZvRwJ03GC0MI8yKsz1xucQfg/jVwJ3DLdZiHs5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fnNNCVIozBALftiy5KJorGlLShX2dMfm14Fu14Rsy96fabZagj/AhJYNfV4uMsF/6Qw1mCSJFS/3eQSF/R0727UVJDhhGVQIs+9d5mwyvv0qzwYZfI0W8jAbUiC/+bcXZPjgXV/hyVsIpTYRbwLrvsFjNrA6kjgNj2hZZ9VoFM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n74Qdsmr; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n74Qdsmr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790257279; x=1821793279;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PFdeZvRwJ03GC0MI8yKsz1xucQfg/jVwJ3DLdZiHs5E=;
  b=n74Qdsmr9telr3TDhy8D7HPXx+onMyprrFIl8dI5YHywNPMzXo8vFbLj
   XlKrjYSJ3LRWzIBUNvUkEjS6ZzK6YiPOflHgM7S5Qzw1B7wcGVfc5WLxF
   gdDMhX0oEJ8wAJGWV6AJhj2ht4eMpruwNEsKQPSWgpIiIVCNrmaUtLB/H
   Wo6kfdqBSxO8hPHkDv/75QQuMDBeZMs1YvAfs7pLDP6KwAZ7RhGHH7mAo
   hzTpIzRJauM8qvv3vZ5ShL2FZi2eBosKvac4VJ1Ys87oIAGNS2EIanLSa
   V3fOzZ2M97T/CCANmLg6wANWZZZGWf+HkV++BOUv817bCqrUAw4QEUCcZ
   g==;
X-CSE-ConnectionGUID: O8U3n5HtRmqI8PQuaHMgEg==
X-CSE-MsgGUID: COcbSJOBQcmTS/9sBC6xUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="93526124"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="93526124"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 06:41:16 -0700
X-CSE-ConnectionGUID: knjfqmmySg2aLKvheaeQwA==
X-CSE-MsgGUID: rRbQ4xjGQI6NLFU44M0APg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="311944280"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa001.jf.intel.com with ESMTP; 24 Sep 2026 06:41:14 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id CFF7F99; Thu, 24 Sep 2026 15:41:13 +0200 (CEST)
Date: Thu, 24 Sep 2026 15:41:13 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Lee Jones <lee@kernel.org>, mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mfd: intel-lpss: fix iDMA device leak on probe failure
Message-ID: <20260924134113.GQ106095@black.igk.intel.com>
References: <20260921104058.353748-1-lgs201920130244@gmail.com>
 <20260921110512.GS106095@black.igk.intel.com>
 <CANUHTR9gA-mKn8Y496Pty4_Fhu3BSSyhXWrmiod1WvuVdQjkag@mail.gmail.com>
 <arJ0pDlXpdlsF0sT@ashevche-desk.local>
 <20260922123315.GF106095@black.igk.intel.com>
 <CANUHTR_Su1KxOeB2fJDwzVeyW4WpnWuzTYm=6Yz4z12Pr6GugQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANUHTR_Su1KxOeB2fJDwzVeyW4WpnWuzTYm=6Yz4z12Pr6GugQ@mail.gmail.com>

On Thu, Sep 24, 2026 at 08:00:29PM +0800, Guangshuo Li wrote:
> Thanks Andy and Mika.
> 
> On Tue, 22 Sept 2026 at 20:33, Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > On Tue, Sep 22, 2026 at 03:29:24PM +0300, Andy Shevchenko wrote:
> > > On Tue, Sep 22, 2026 at 03:59:32PM +0800, Guangshuo Li wrote:
> > > > On Mon, 21 Sept 2026 at 19:05, Mika Westerberg
> > > > <mika.westerberg@linux.intel.com> wrote:
> > > > > On Mon, Sep 21, 2026 at 06:40:58PM +0800, Guangshuo Li wrote:
> > >
> > > > > I think this could use devm_mfd_add_devices() instead.
> > > > >
> > > > > > The issue was identified by a static analysis tool I developed and
> > > > > > confirmed by manual review.
> > >
> > > > Do you mean converting both MFD registrations to devm_mfd_add_devices()
> > > > and dropping the explicit mfd_remove_devices() from the remove path, like
> > > > this?
> > >
> > > Won't work properly. The rule of thumb, it should be no 'goto' after devm_*() call.
> >
> > hmm, isn't the unwind done in driver core and has nothing to do with goto?
> > Maybe things have changed since I last time looked? ;-)
> 
> devm_mfd_add_devices() would remove the children when the parent
> device's devres is released after probe returns an error. However, the
> current error path tears down the debugfs, LTR, clock, and IDA state
> before returning, while intel_lpss_remove() removes the MFD children
> before those resources.
> 
> Given that ordering, would keeping mfd_add_devices() and adding
> mfd_remove_devices() at err_remove_ltr, as in the original patch, be
> preferable here?

Yes I agree,

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
