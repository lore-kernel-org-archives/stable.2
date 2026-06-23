Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCBC395AE7;
	Tue, 23 Jun 2026 20:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782245701; cv=none; b=P151ZDBEmjb0H32keHxJBPeYWmdk66fZiu087eMsciA55rwoOjAqaNuY59EKL90fBi5MaefZ1NfZVwrIWMYbBWSzqzSSzvpuDw4pSxgZBs8wJ1ivIuZB85zjhJG9xwomIxRWq+TZLIIyxIZaulzE4BKu0JB1Y4nQc8PPOPe7THM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782245701; c=relaxed/simple;
	bh=JhveSp07tSCHgDphz8hRbsEB38K+EDMblTYhxwKyh20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMhhjDel1rD5lS8MofkCo/jGPBIpEJgyxq+mh3ZDvV9gs5abEnoTduWfUNxii2qslZjy64KwYcROLrAb8mYxAn89o96tyFhZNuUJVbJjbLStc28ql0QKHzHG5d+//hZrx0AMoWbLEt1EmExXcOU9ZbfWTL0AR4H6R5Vsevjc5i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U8EH9yBR; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U8EH9yBR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782245700; x=1813781700;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JhveSp07tSCHgDphz8hRbsEB38K+EDMblTYhxwKyh20=;
  b=U8EH9yBRjF0jvBA8dW3Zolj2WMK+pnYE9+gdOWuCRSZTAZGUA4KaL5kL
   w5Gh7WawXBVpw1c7ubSqtjS9tXpQxwtDad2LGEt3tobVkOMrGoM3UplPG
   A8jNx9c/WQVweTr26CkwfGOcw04tHywtGzgEq/QfBz2uzQs+r50c4iXbN
   UWbnSIX5b3uyfnvmC3snM/xfD1oUeGabOY7PT+OR1eVhja3Yg5Exi7KeE
   03bppfIB01aeQaqnTKIOKgSTvUxbP7AUC+7DUT1c5qzf1r64+5aQteKOH
   Ac7auS18zJoMFZSvJZ0gNZv/DaP96V78cnDWU4NzSKKa7OjGl4OCRIu9u
   g==;
X-CSE-ConnectionGUID: RaHiDpyCR7Kue8daorGQ5A==
X-CSE-MsgGUID: ytk/Vz+UTwq70DXI9D8wyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="100550543"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="100550543"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 13:14:59 -0700
X-CSE-ConnectionGUID: EP95sZZnQAedd38PegXbmg==
X-CSE-MsgGUID: hN6IdZ0QRASEMOsiYztC3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="249726881"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.7])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 13:14:55 -0700
Date: Tue, 23 Jun 2026 23:14:52 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bradley Morgan <include@grrlz.net>
Cc: Petr Mladek <pmladek@suse.com>, Feng Tang <feng.tang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>,
	Jinchao Wang <wangjinchao600@gmail.com>,
	Kees Cook <kees@kernel.org>, Rio <rioo.tsukatsukii@gmail.com>,
	Joel Granados <joel.granados@kernel.org>,
	Pnina Feder <pnina.feder@mobileye.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	Mayank Rungta <mrungta@google.com>, Tejun Heo <tj@kernel.org>,
	Zhenguo Yao <yaozhenguo1@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/4] sys_info: add helper for callers that handle
 all_bt
Message-ID: <ajrpPMo3Qc_SgFkG@ashevche-desk.local>
References: <9b8c96e291696815d3c7de5d3e199298dee0279d.1782228656.git.include@grrlz.net>
 <ajrob9r6cVtxqv72@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajrob9r6cVtxqv72@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 23, 2026 at 11:11:34PM +0300, Andy Shevchenko wrote:
> On Tue, Jun 23, 2026 at 03:34:58PM +0000, Bradley Morgan wrote:
> > Some callers handle SYS_INFO_ALL_BT themselves before calling sys_info().
> > Add a helper that strips that bit without turning an all_bt only mask into
> > a kernel_sys_info fallback.
> 
> You also want a getter with check
> 
> bool sysinfo_is_all_bt_enabled(...,  *si_mask)
> 
> where *si_mask is the result of READ_ONCE() that you keep as implementation
> detail inside this helper.

Ah, sorry, I have thought that the mask is part of sysinfo implementation.
Disregard my above comment, it can't be done without also supplying the pointer
to the original one, which makes no sense.

-- 
With Best Regards,
Andy Shevchenko


