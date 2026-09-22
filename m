Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6258947D932;
	Tue, 22 Sep 2026 12:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790080413; cv=none; b=c+rs6FyJFjURSfzYxdhkQYjAXihtiCupLk3AqUifx+R724+4sjrJz0/PwjEMvn3RREQ1w0DRBo8hiAmTNj1yJVAXLchbxR+uGDcrL4eG3erWwXLnqsQCg4tPtHuou3yZ+QkwrqLopVMUuXFPaAhY1IiA13lUd0lRwIyz4aT/III=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790080413; c=relaxed/simple;
	bh=P3ltc2Duz/f1Q6/dJd0Szn19QXKlHosvcoLDAUNGLP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lIrKSRGOOq61EKk/Hwyp/gobZ6/LPg8AQOOnGivzgBrCNHZCFFna0K79coe/hKy9oInqGiSYPPrLRW1CmQTKrclJgEUOckEkIseUTVc9DdVO2Lv1MugzkP2l/aIRKDUaSWV5fUOmvh8m4Od5iumzyahKNHpUklEv5EOUbF7GBWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J/4IA8zk; arc=none smtp.client-ip=192.198.163.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J/4IA8zk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790080412; x=1821616412;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P3ltc2Duz/f1Q6/dJd0Szn19QXKlHosvcoLDAUNGLP8=;
  b=J/4IA8zkqicgl16ze37cN5+kmBJOMXwSb6iJpSw5N6bOv/uk8aIYWy2V
   GbjZE1LL/B20isDkxNFQEZxp/wnL3zYlcKDfQw9jKkVnLdaocnTCW+R5b
   dQGmVmyX4ZpN0PvR2ysVo3fiM3c9yCACuwE1duAJlTbOWZwu4PKdx6wBG
   vgMCmpOLyPiYWlXGe3PRwSWcjwhzwIWRI37zuhPzZeU0LZZhVfNDaqH2J
   GtIzi7u5X7aOk9CooDiXSkZcZIDCsOnGmFfoTx1bLP1952LBBoUky1JkC
   sIMNbGSmKn3QB8aluph5WqBv9ar042GQ5nzXoBZceLaWv6LnyCAUh6l0I
   w==;
X-CSE-ConnectionGUID: Cj4Ky979ROC8yqMJ9oE8hA==
X-CSE-MsgGUID: krBaUK9ATC+tUAbHDomG7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="1185660"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="1185660"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 05:33:32 -0700
X-CSE-ConnectionGUID: ydOt1EOfSE6SSZDFTF82ow==
X-CSE-MsgGUID: wqN6RhUKSom0DG3vXqQ0Kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="269626874"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa009.fm.intel.com with ESMTP; 22 Sep 2026 05:33:30 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id E4CA199; Tue, 22 Sep 2026 14:33:15 +0200 (CEST)
Date: Tue, 22 Sep 2026 14:33:15 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Guangshuo Li <lgs201920130244@gmail.com>, Lee Jones <lee@kernel.org>,
	mfd@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mfd: intel-lpss: fix iDMA device leak on probe failure
Message-ID: <20260922123315.GF106095@black.igk.intel.com>
References: <20260921104058.353748-1-lgs201920130244@gmail.com>
 <20260921110512.GS106095@black.igk.intel.com>
 <CANUHTR9gA-mKn8Y496Pty4_Fhu3BSSyhXWrmiod1WvuVdQjkag@mail.gmail.com>
 <arJ0pDlXpdlsF0sT@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <arJ0pDlXpdlsF0sT@ashevche-desk.local>

On Tue, Sep 22, 2026 at 03:29:24PM +0300, Andy Shevchenko wrote:
> On Tue, Sep 22, 2026 at 03:59:32PM +0800, Guangshuo Li wrote:
> > On Mon, 21 Sept 2026 at 19:05, Mika Westerberg
> > <mika.westerberg@linux.intel.com> wrote:
> > > On Mon, Sep 21, 2026 at 06:40:58PM +0800, Guangshuo Li wrote:
> 
> > > I think this could use devm_mfd_add_devices() instead.
> > >
> > > > The issue was identified by a static analysis tool I developed and
> > > > confirmed by manual review.
> 
> > Do you mean converting both MFD registrations to devm_mfd_add_devices()
> > and dropping the explicit mfd_remove_devices() from the remove path, like
> > this?
> 
> Won't work properly. The rule of thumb, it should be no 'goto' after devm_*() call.

hmm, isn't the unwind done in driver core and has nothing to do with goto?
Maybe things have changed since I last time looked? ;-)
