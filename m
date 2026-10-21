Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792564549;
	b=04Yw/wcIgZMLIKlIZd6Vt/qanh+IKm+DLnD3SCabKgM3k7/yTAz6ZBQeGkWWRcRZETxv
	 sGrRlRsejFNLdJkTWEo9ednu3FQ1Ek/cAeeV8Z6mrkDglgoqKdMhY5yXgWvfB9osFQMvC
	 8EzK2FOUGBzJbyY/qrGLD/C2CbYWFtXQBoyO+HVjXoi+er3I+QsAEpwUWazKQYsynQzBe
	 NN6MyVNdn6CQKQrPt2p+dGKhkjhG6Kg94TTJd06i6LA4d40r0FJI1oT8kWerO7NzsY/ym
	 wsSV2L0lkMZKg1UAXgYK/qTdmP9VDr565BF6k+kpf5v5CVLcCLAPrD99kipSDRzR7kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792564549;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=nI2lebnxiMrb8Ko9vQ5ebF7pfSORHUslFYD8iWIpiYQ=;
	b=yS6gR67bzQS9EzkU4almiX6691aiBG2sYDaUumUxyG1ywI3O9mvHRCwF9fvJs3VdofPN
	 68w9M3PXaliiMmd9+/gmoX8GrYcHRf46myOpYponBrWtLW6zCkH3i3kxOK3IAhw7pyws/
	 jLqm2QB3IuZtoZr0LgQHSos+RyVXjBjiJ55INhunOQSJwa9AZYlSsQlvRQoQFi1ST9heJ
	 KBJqj24me2HUh/rVvZxl7Von9RsNggTor22yNKAhdHTd56REMzQMirln7gGLua8yOARb4
	 SGgl0pgP4UmF8jV8X1slcGd6M+fVX27qL36XOBgqwzIgpNZlC7vHrrFa4cYEU0cb3Og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ehEEkDKU;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2106606A31C;
	Wed, 21 Oct 2026 06:35:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2106606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ehEEkDKU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792564549; x=1824100549;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=204hoocMj5W7Cd2xOMa0yV5znDDU09JGjewWWWcCJoM=;
  b=ehEEkDKU/2FUTLo+H8BA0oBL03fzbN0r4vQaQvIFPL6wGXl/XlKLGBoj
   8STKpoRX25mOmaSIMTVfe6MgWfIfKW6zm3M88ZO+gKS5xEasSM0jN9tgK
   ps6WsUN2oGzRtCwf0QlN7J+p5iKxDdRvczye6p1kBwuTwdMUYx0GE7Hlk
   gUs4igeGg0wNaHFs5uthmzh2sOaNCBPDmu72inRArp01E2v5Ta9Q556kC
   cacoMX1iLtnkScIQa47iZMCwCRaGk9RuchfSBG/h2DnhjqcT0dmyjTD+6
   +0Dss901in+jcQIdSZQQ8FMDCRlV84xNdISrvzKuuTF7Lp8VGzYB7yRdy
   w==;
X-CSE-ConnectionGUID: nHH3e11FRii9Q+v8LxW6Nw==
X-CSE-MsgGUID: AY5FqkXwSHCI5iqWKNUu5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1273109"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1273109"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 23:35:48 -0700
X-CSE-ConnectionGUID: AZ92ABLjRo2tGbTW+uc0LA==
X-CSE-MsgGUID: 16YwEvqvSDepxi1uDl/OLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="2957654"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 23:35:46 -0700
Date: Wed, 21 Oct 2026 09:35:44 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Muhammad Bilal <meatuni001@gmail.com>
Cc: Jorge Lopez <jorge.lopez2@hp.com>, Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v6] platform/x86: hp-bioscfg: fix heap OOB in
 hp_enforce_single_line_input()
Message-ID: <athdQF9HW4cDR7xI@ashevche-desk.local>
References: <20261016025352.230535-1-meatuni001@gmail.com>
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
In-Reply-To: <20261016025352.230535-1-meatuni001@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 16, 2026 at 07:53:52AM +0500, Muhammad Bilal wrote:
> The input is copied with kstrdup(), which stops at the first NUL, but
> the full write size is passed to hp_enforce_single_line_input(). With
> an embedded NUL the helper reads, and can write one byte, past the
> copy. Return -EINVAL if the input contains a NUL.
>  
> Tested on HP EliteBook 840 G2 (Fedora 44, Linux 7.2.8): writing "A\0"
> followed by 4093 bytes of "B" to current_password 100 times returns
> -EINVAL every time, without reading into the heap.

...

>  {
>  	char *p;
>  
> +	/* buf is a string, so a NUL before count is invalid input */
> +	if (strnlen(buf, count) < count)
> +		return -EINVAL;
> +
>  	p = memchr(buf, '\n', count);
>  
>  	if (p == buf + count - 1)

Let's look at the full implementation

int hp_enforce_single_line_input(char *buf, size_t count)
{
	char *p;

	p = memchr(buf, '\n', count);

	if (p == buf + count - 1)
		*p = '\0'; /* strip trailing newline */
	else if (p)
		return -EINVAL;  /* enforce single line input */

	return 0;
}

With your enforcement in place the rest can be simplified and refactored.
The hint is to use strnchrnul().

int hp_enforce_single_line_input(char *buf, size_t count)
{
	char *p;

	p = strnchrnul(buf, count, '\n');

	if (p == buf + count - 1)
		*p = '\0'; /* strip trailing newline */
	else if (p < buf + count - 1)
		return -EINVAL;  /* enforce single line input */

	return 0;
}

(the above done with the less intrusive changes)

-- 
With Best Regards,
Andy Shevchenko


