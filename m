Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792957957;
	b=iwcu8RgjimcxFUfqe4l2RgddXO7pcpvRWiGNf+ichk5ARpdbhYYcsLx1iy3BhCt2v/R7
	 R2KfgKy1MPLjgE1Iez9fL/L5bAW0sRHWWxawHYwyZ8ilkXqA7Xkeo3rU7LItSAL4ugQRt
	 7WnQ3r9UWDZVT4bNl7Pag8MGhwDcdzsWTyvW8Fhd8C77H3L4xb2fReSAp8mCTP2MH6c86
	 OixKbuM4n1k7pl5iJgA1Q2/4XFRyNNMmL74Rjz5bntz1DGCnHFdnRR7BDMUWijM84PPkG
	 4Z8XuAwk2bBkC9KWbC1JIcEXHlfQYHJ7Uboj8tficZN/QnTMIfffWKl8T1g3uVHcdXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792957957;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=phNHyna0u7LX1lVWmmLhmAYjf4k2mLRW1J3H+0fjjJs=;
	b=R6PiuU600LdBR7avWbAxMUlmLdialDzHdPWlq4deBBwKdDm7sDPnfgsUSm85FkGzQf+f
	 vB9Ua98tKcJ+EMwvGbdieEmOSR03MGPo25V52bB59Zw044AdXPkgJuMnYDDQrr2LRsw0D
	 4TmQ3zrtsfqNjMx0/G4NKGTijUZtvrSnXdgVlHGtL9Uy7WGU4aVWCP2nZfvBVx+Y1B8tM
	 zjDzkuJNuGO275sRb/mJP/KxckYeaZERDnC8dr7vK3lR2G+js3qCjRiENt+V55nLZeJwD
	 BVwMTWQJMcsxTruzNpKfL0S+o4jaGfwRft3MYbWAdr4tw9iPFHY+K1A/K1OP9flXHHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=W7V8IHiw;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F527606A31A;
	Sun, 25 Oct 2026 19:52:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F527606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=W7V8IHiw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792957957; x=1824493957;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qBwv+wPUM4FN0ctAG5SZcloMYd4fYBZyh+tCuPCnIk0=;
  b=W7V8IHiwk3bBFdubAc1ID4zLhCLRLZwtUT1VDoiHU+Bo+HAMZc3pc0KU
   Q9K1eqAUwyv2RkxP459b+5Oj9SPv8VPOdEkPySnwqyVEGRm5MpB2ehpbP
   VUd9Wv68LG99hnXXmxQf/lfiwEXgux9+Nrv54nPWIF6O//K8ckg9Vfz3V
   UNyGA7TGw8lULp2wNMlERc+34y7fh8fg4y9HBYXqFyradevf3mrR00H7o
   jl4tghz84XpjgsQHa1XEVnya60XidFR2o4yM0A0NmWRt/G1UKGAIXQeeG
   b1i2YT2E+9oMd7fcwpSWMxUqB5ZgB1pN3mFLZP+c4+zeBZLROwkf5P1OV
   Q==;
X-CSE-ConnectionGUID: 1TduCIkpSjmstLpMMBTo+Q==
X-CSE-MsgGUID: 3AluGXc5SpW1mNfudAkIDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1533469"
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="1533469"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 12:52:36 -0700
X-CSE-ConnectionGUID: 7E3+Zwn8TUayQpI4TO0L6g==
X-CSE-MsgGUID: 9D+HxSH9TIybHSEEXSv5nQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="4464161"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.10])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 12:52:34 -0700
Date: Sun, 25 Oct 2026 21:52:31 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Muhammad Bilal <meatuni001@gmail.com>
Cc: jorge.lopez2@hp.com, hansg@kernel.org, ilpo.jarvinen@linux.intel.com,
	linux@weissschuh.net, platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v7] platform/x86: hp-bioscfg: fix heap OOB in
 hp_enforce_single_line_input()
Message-ID: <at5d__q_RzGad7zt@ashevche-desk.local>
References: <20261024172641.19424-1-meatuni001@gmail.com>
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
In-Reply-To: <20261024172641.19424-1-meatuni001@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Oct 24, 2026 at 10:26:41PM +0500, Muhammad Bilal wrote:
> The input is copied with kstrdup(), which stops at the first NUL, but
> the full write size is passed to hp_enforce_single_line_input(). With
> an embedded NUL the helper reads, and can write one byte, past the
> copy. Use strnchrnul() so the scan stops at the first NUL, and return
> -EINVAL for a NUL or newline before the last byte.
> 
> Tested on HP EliteBook 840 G2 (Fedora 44, Linux 7.2.8): writing "A\0"
> followed by 4093 bytes of "B" to current_password 100 times returns
> -EINVAL every time, without reading into the heap.

...

>  - Drop the trailing comments

Why? At least The first one has the same meaning as before, what's wrong with
the second one?

-- 
With Best Regards,
Andy Shevchenko


