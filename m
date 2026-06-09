Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F67B3DA7EE;
	Tue,  9 Jun 2026 07:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780989300; cv=none; b=tGOSSO99wPTpDofk/PMt/1we5h2IGdB/qr8A+Ee/VsY7EkFv4KosmvpPvabfH49mq9lj0b1d89R+pPzkvDj95Q+x7RkOfZFnowIqaYIwKeeWveP1BjtNsZOy8ROSNsNVJuBqcGPyDicBVCVkgELrDtyJfVdJ3gkQtKxp9O6uiLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780989300; c=relaxed/simple;
	bh=2qu81oasOVE9oPvab2zZBXtjwJyxu88n0NTYxYVTBeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NH96JoRoYEDZP4CPfANucq2cZr8DxhqJ4LYK4KDk6S6YR2UcB+wwsnUL/xdhSufdNyGZRqsI6hunCRbyOoLGcnpnN4hm/SYRTHMFLZSnvfocxuD0gcAsykmzsT3PBa0w2bN7M+i/k5AzQXJpBtrE9ZqGot3inXDkAd58jZyOYkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WFpakDu1; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WFpakDu1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780989299; x=1812525299;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2qu81oasOVE9oPvab2zZBXtjwJyxu88n0NTYxYVTBeI=;
  b=WFpakDu1q7hza3mtAX0qR4r+kEi9gp0inCMFG1jb1WNcSPnMTcEOjPLr
   +VM7rtcgiUWHWf7Xwgb5TMt0U4p/7xVOPaQMQ277jqRzqiJgIs3d8Z8ih
   SZqEg+OQvDjMuDRgr5RWw1EdMf2sa+/KVdR9KyZjK8qsLgjmMmBEuLH18
   XXWzuEulsds4Su1PPJqHC95DbOSzKo6n/l7oDMXUuVLLn/PfJtS22CDYg
   siyjlQN5K1wqMYZvzIhyuI6q30Yxfz8reTeSYN3wJ0YIDxSvvNryHrlfA
   TVvJ8vOUkgcyocNNR1fj9E6IPKUYCLHquVGIx0R/7EhwyU6aXNSmx7ctw
   A==;
X-CSE-ConnectionGUID: riru4tfpTciiQ4iLmvuhQg==
X-CSE-MsgGUID: MUtBuIr7TGybRKGJfdBv/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="85365658"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="85365658"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 00:14:59 -0700
X-CSE-ConnectionGUID: bYIz3a1aQoqRuhWtVUyaig==
X-CSE-MsgGUID: NjQINNlqT06cCOW38m5ijw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="243343826"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.39])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 00:14:56 -0700
Date: Tue, 9 Jun 2026 10:14:54 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nikoloz Bakuradze <nbakuradze28@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Khushal Chitturi <khushalchitturi@gmail.com>,
	Archit Anant <architanant5@gmail.com>,
	Minu Jin <s9430939@naver.com>, Kees Cook <kees@kernel.org>,
	Hans de Goede <hansg@kernel.org>, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: core: avoid NULL pointer dereference
 in c2h_wk_callback
Message-ID: <aie9bqpiNDJ_IU0M@ashevche-desk.local>
References: <20260608190700.85755-1-nbakuradze28@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608190700.85755-1-nbakuradze28@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 08, 2026 at 11:06:58PM +0400, Nikoloz Bakuradze wrote:
> c2h_wk_callback() allocates a 16-byte buffer with kmalloc(GFP_ATOMIC)
> when the c2h event needs to be read by the host. The existing guard
> only wraps the read step, so on allocation failure the loop body falls
> through with a NULL c2h_evt and dereferences it in rtw_hal_c2h_valid()
> (via c2h_evt_valid() which reads buf->id).
> 
> Restructure the check into an early continue so the rest of the loop
> iteration cannot be reached with a NULL pointer.


Not sure if we need any Fixes tag. kmalloc(16) won't ever fail (otherwise
the system is already in the state when nothing can help).

...

>  			c2h_evt = kmalloc(16, GFP_ATOMIC);
> -			if (c2h_evt) {
> -				/* This C2H event is not read, read & clear now */
> -				if (c2h_evt_read_88xx(adapter, c2h_evt) != _SUCCESS) {
> -					kfree(c2h_evt);
> -					continue;
> -				}

> +			if (!c2h_evt)
> +				continue;
> +			/* This C2H event is not read, read & clear now */
> +			if (c2h_evt_read_88xx(adapter, c2h_evt) != _SUCCESS) {
> +				kfree(c2h_evt);
> +				continue;

It's too verbose way of saying

			} else
				continue;

here.

>  			}

-- 
With Best Regards,
Andy Shevchenko


