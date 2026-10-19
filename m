Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1CE3E7BB2;
	Mon, 19 Oct 2026 08:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399249; cv=none; b=JvqpyoA1m0GSk9YE7fQDDvCZ2v1S4saVU/NF37c83cd5sv4WWi3UevAJ3gRrAoPEQAxe3OkYG3Kw/kDwpjhGc5rbSgpJX3J0ITm8rruvD5H1kB0g+93LFGYtPO9tPVCI99mh48EOdK7rBenBT35rMVagbPZTjd6KO3Z61fGLJPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399249; c=relaxed/simple;
	bh=fX34RxUdLPhnUUa1czFBK/3YfZMFivcIJGFk3/35Pu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y5z1FSzl+rwhZpTRRMaoZyed6K2aImNjid30uaXHLBsT3wqo/aLcWeDqV2BI9z7iVkjrjZkdI+hh04ZCb4dOVkVkDGhG2QBIfU5QiW/RLpcwlKqH3RBbhY29N+epu637ljaigUPcQanV5JWbExyyKp5DXDD4d2/aQp2T0ddUzxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HHr+UKjY; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HHr+UKjY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792399248; x=1823935248;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fX34RxUdLPhnUUa1czFBK/3YfZMFivcIJGFk3/35Pu4=;
  b=HHr+UKjYz+4xGz/G2l6Wisqi+FQ9+jSizSUW25p1Iztbi7mCqrkHqY82
   hl06zA8OGwVni/LkYShH1rVHZ/lAaHkTbhwrDhc0gULUffOV6MwzqoM/x
   hdM/GlwABZTJqFfOpLM7SewYS2s1G9poHIx7c5ea20fHMPlPxr4mDau9X
   D6fcsUWKtlrAQePetXtSf/w3VimeW0n0+j/J5sBWq71G+3+beAwJ0XBPL
   ihNFvn3UeU1s4KYKxzW4Mf/w5muLoKIIu1Bg5TnTWNp4ssSMXMCEqlv32
   jqIbyux71h/jlVdFd5N3ZoT3yK30X+B9HKYtnRcuCedRdXyKYPZSRQARe
   Q==;
X-CSE-ConnectionGUID: svalk9L0RAOPY7HYLVGl2A==
X-CSE-MsgGUID: F7ME3vXbRMSNA47J7gA1Yw==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="979119"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="979119"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 01:40:48 -0700
X-CSE-ConnectionGUID: gq8fyXY2Qxih9MnZQ50UAQ==
X-CSE-MsgGUID: Ai7bu1tDRZudeONvXMK8hA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2477948"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 01:40:45 -0700
Date: Mon, 19 Oct 2026 11:40:43 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kent Gibson <warthog618@gmail.com>
Cc: Adrian Ambrozewicz <aambrozewicz@nvidia.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Jia Jia <physicalmtea@gmail.com>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 6/6] gpiolib: let the character device free its IRQs
 first on chip removal
Message-ID: <atXXi_EA6iROhK0C@ashevche-desk.local>
References: <20261016-gpiolib-chip-removal-v2-0-aambrozewicz@nvidia.com>
 <20261016-gpiolib-chip-removal-v2-6-aambrozewicz@nvidia.com>
 <20261016134003.GA155960@rigel>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016134003.GA155960@rigel>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 16, 2026 at 09:40:03PM +0800, Kent Gibson wrote:
> On Fri, Oct 16, 2026 at 12:23:38PM +0300, Adrian Ambrozewicz wrote:

...

> > +	/* Called with gdev->chip already NULL, so gpiod_to_irq() can't be used. */
> > +	if (gc->to_irq)
> > +		irq = gc->to_irq(gc, gpiod_hwgpio(desc));
> > +	else
> > +		irq = 0;
> > +	if (irq <= 0)
> > +		return;
> 
> Perhaps I'm channelling Andy here, but how about:

It was in the previous version and I suggested to move it to the above. Seems
like we have an opposite comments. Can you provide a rationale behind your choice?

> 	if (!gc->to_irq)
>         return;
> 	irq = gc->to_irq(gc, gpiod_hwgpio(desc));
> 	if (irq <= 0)
> 		return;

-- 
With Best Regards,
Andy Shevchenko


