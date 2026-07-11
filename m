Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C37823EA97;
	Sat, 11 Jul 2026 09:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783760591; cv=none; b=qYMH310V1iNe+Q7vlJB09xn3E//wCrqk9ozQdP4bRRiy47E4nHg/ZMD/hh66PWw4y9CcAmJ4DE0iyRGw0uAiPkNhvNXUbesmuATIbxXYaBBGOC4v4/Q63c3fLRcp7tgjgkFKDfluJIuzzjRZw9nKoC5yc3r+oACsE+ciS6PNrLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783760591; c=relaxed/simple;
	bh=TECfJzSril8F/9C6S9AFXUPhJ7BkHCauPMvlj5RBzGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EtXkFHHkiR3iBQvsl/JTYodiaOp8wVKTA0Le1tDmMObg2h946Cpb7JQkb9/WwHRYZ1OltIqEJJTi9whZ0hWIgPVIMo/d7d3zRNzBsoS/qtIpUpQtq3tama0TvE6inENHhHLexBTNXpsw+B/u40IBT0EA2p37VoJm7T0R810TLZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n012FwOn; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n012FwOn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783760590; x=1815296590;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TECfJzSril8F/9C6S9AFXUPhJ7BkHCauPMvlj5RBzGo=;
  b=n012FwOnNi2eggLSHI6N+EMzz2pyTCzNOwQ11CDJNVKgxKCNxe+BY0Rr
   ueCm0eG2b7ImizOC9RAr56hWkLa47q0jg0mKWUYOseE/MEVhmIpdPH2h1
   NOgu4lygf5Ij1fcAzwloHfs41QiuZe1txFWXbb7y9FXxuPZijQl+KDUhc
   hRony29sTH+s5i5Y16JP8QZ/UJ07DmfUU3M+tSQ3P0xewZAgGYO8bKWpJ
   aLD2pUlB5TLzAwCY3jJDlwC7noGFgoFnmgB77y2rxB96wC4sYZh/iCwgI
   HX7KXJsOAhee701gd9VxHSu0P2X7xvUZW4ZQ2DxNYcmac3xWE9tIllVR2
   Q==;
X-CSE-ConnectionGUID: wzOh15J8SfupE2UoRYMujg==
X-CSE-MsgGUID: o6R3OS//QJOH/lnOcNZHoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84415560"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84415560"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 02:03:09 -0700
X-CSE-ConnectionGUID: fFo/Wt0tQXiLbSj/yv2B3w==
X-CSE-MsgGUID: wogpkr6BSx6lTwTqxc67pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="255741346"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.254])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 02:03:06 -0700
Date: Sat, 11 Jul 2026 12:03:03 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Yasin Lee <yasin.lee.x@gmail.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: proximity: hx9023s: validate firmware size
Message-ID: <alIGx7rZkvTc8J51@ashevche-desk.local>
References: <20260710142212.52225-1-acharyalaxman8848@gmail.com>
 <20260710152842.53659-1-acharyalaxman8848@gmail.com>
 <20260710132151.00000f37@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710132151.00000f37@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 10, 2026 at 01:21:51PM -0700, Jonathan Cameron wrote:
> On Fri, 10 Jul 2026 21:13:42 +0545
> Laxman Acharya Padhya <acharyalaxman8848@gmail.com> wrote:

...

> >  	struct hx9023s_bin *bin __free(kfree) =
> > -		kzalloc(fw->size + sizeof(*bin), GFP_KERNEL);
> > +		kzalloc(sizeof(*bin) + fw->size, GFP_KERNEL);
> 
> This doesn't belong in the fix given it is just a reorder. Maybe it makes sense
> but if it does, separate patch with an explanation of why.

Semantically this should use struct_size() which brings us to the kzalloc_flex().
And this will be a separate patch.

> >  	if (!bin)
> >  		return -ENOMEM;

-- 
With Best Regards,
Andy Shevchenko


