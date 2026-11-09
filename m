Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794260353;
	b=xbtju/yXBefxh2wnHHd1J84FVyQw50F1feOhp+sq+R/oKpQjblbtTFAv/A85miDxYnT+
	 hDNYcaYpkz9a04JJqEZjZNBAG1k09On6jhIGf/q3ByOKERBldYXzeOYMwYNI/r1QxOm/B
	 bMNQ83D7+1xDJRWvd51KdTV7HnX0t5AaioPTvw9d3fEZCZusSOXOBF6GicuD8/rlGoPh2
	 awrqtcaCPe48laa2slNBy9E0hNuy9OsoTbnjlnFvbCcEWj2x2XL2UL19xdBvxdH5UcR7T
	 ZXGTwUFjnV66ihK8WMvctFE1zWQEwDx9WqpsdLfsf6u/eTADN7WVFxeG6ovEFRDQtag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794260353;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=FEOSlh0slL9lzfjDFsxhcuq5DZBLDQNDE3K8Ix3LK58=;
	b=FDdi0DvpIMgZysQjZLY2hymt/dMQcSj9EM71WkyX55mByQOphBUPoNRMn7U9uC5xSRLp
	 RTDcf37tFlgH75YchR6VjO9hUdjl+7L7RC/gd7W02BudT6ea0p3fusQszbjYpvyvkGM4x
	 nxXJtE1TkkdQyxHyA+fLEpf1RcpZOpBHMFAIAqrR5LAJKFp8AFT+fAE1Mf4ReGoo6KfpZ
	 ER8h/Y+rpRphDMjyFPbSruOo46n+kl9DT7KlBIinEpClLZqVOm0gq595u0fQnXA34CmLV
	 o/6OidfaF+Zf2ut3EUUT6qyy3g5CwJKn5rBNadcrnLFuwhYr7vSIiz9hYKxmEfHxtug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kDjVbURZ;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD08606A336;
	Mon,  9 Nov 2026 21:39:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBD08606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kDjVbURZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794260352; x=1825796352;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n59xh4ThW8wY2o8B+J5hT31WyrWmamzID8/o7Mebbvs=;
  b=kDjVbURZ7w3kVz/HpGyhct6m3nLaKQBtWE2A/0n4L39vc2zljKnbEE8I
   effO2DhM+Q0l10uE96UlTXAfp6RDMr7dm2i4rHCAgOdey53aYq6KDUFy7
   kGRcFBGZQvalg2/teRdUa/TfpXilHCDjmCQiCmQMzqN+H3NtJh4G+QOhz
   3BJfOqcEZUr5S0aotVOFV00nsPplDJ070joih00zutIQHi/OwJ+NAUuHC
   FU5b+f0k3hV4EmRZVv96yueu68DGI6Tt16YOtuoNcj8n+fPYT8MngyfmW
   A+HxOdc0WoZMRMERGqISv6xPWsr+6FMwJvcZKmWPKIv6SY0OJZe6p57eA
   g==;
X-CSE-ConnectionGUID: r6e593o8TBWauqYMibuseQ==
X-CSE-MsgGUID: Rph65iH3Tt+35/RrmOACTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2894825"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2894825"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 13:39:12 -0800
X-CSE-ConnectionGUID: nzHce1zPR0u3KmM12VuC0A==
X-CSE-MsgGUID: H2KvwVYXQSuuFI+wFKmkOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="7841553"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 13:39:11 -0800
Date: Mon, 9 Nov 2026 23:39:08 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: raoxu <raoxu@uniontech.com>
Cc: lee@kernel.org, mika.westerberg@linux.intel.com, mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mfd: intel-lpss: Clamp latency tolerance to the register
 value mask
Message-ID: <avI9fDRmwFyIfTDv@ashevche-desk.local>
References: <82545EC5E5ABC9F0+20261109094242.3783672-1-raoxu@uniontech.com>
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
In-Reply-To: <82545EC5E5ABC9F0+20261109094242.3783672-1-raoxu@uniontech.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 09, 2026 at 05:42:42PM +0800, raoxu wrote:
> 
> The PM QoS latency tolerance interface accepts non-negative s32 values,
> but the LPSS active and idle LTR registers have only a ten-bit value
> field. intel_lpss_ltr_set() selects the larger scale for requests above
> 1023 us and ORs val >> 5 into the register without limiting its width.
> 
> For a request of 32768 us, the shifted value is 1024 and the latency
> value field becomes zero. A request of 100000 us leaves only 53 in the
> value field. Still larger requests can set bits outside both the value
> and scale fields. Thus a relaxed latency request can produce a much
> stricter tolerance and unnecessarily restrict power saving.
> 
> Clamp the shifted value to LPSS_PRIV_LTR_VALUE_MASK before combining it
> with LPSS_PRIV_LTR_SCALE_32US. This saturates oversized requests instead
> of wrapping the field, matching the Intel LTR handling in sdhci-pci.
> Negative values and PM_QOS_LATENCY_ANY retain their existing handling.

Shouldn't we rather forbid to apply wrong values?

> The supplied fix was reviewed and this commit message prepared with
> OpenCode AI assistance.

This paragraph should go after '---' line below.

> Fixes: 4b45efe85263 ("mfd: Add support for Intel Sunrisepoint LPSS devices")
> Signed-off-by: Xu Rao <raoxu@uniontech.com>
> Cc: stable@vger.kernel.org
> ---

...

>  		if (val > LPSS_PRIV_LTR_VALUE_MASK)
> -			ltr |= LPSS_PRIV_LTR_SCALE_32US | val >> 5;
> +			ltr |= LPSS_PRIV_LTR_SCALE_32US |
> +			       min_t(u32, val >> 5, LPSS_PRIV_LTR_VALUE_MASK);

No min_t() in a new code. You mentioned clamping, use clamp(),
it's exactly for that.

>  		else
>  			ltr |= LPSS_PRIV_LTR_SCALE_1US | val;

-- 
With Best Regards,
Andy Shevchenko


