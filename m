Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794245474;
	b=G6V6x0CTCEzjgwj4ckYb+Tos1RV+WPx4N4Fd+JQqqxhSBxyN0ge9MnfRrRoag+JDJB8N
	 +0oLVijnpLhjZoAalmusCROGTtyxlsZCxLmuykYk23ittEHbLKqDasO0WqVMwsdJ6toVb
	 LOLRcv2aguJ5td/y0FNNJvI0uLrMVEoG8bhk5prBuDiMCaAsSFdc2omC/TpBJBBq6U1jw
	 kxoTUxEvJViTJ/0beXIBQP9eMKt9qyiQH/G0rUfJ5zHuTregPrGSaR7otbqU0iEyGvP6w
	 yzIdRox3dPfZfFwIBHGTzzCsiHLEFRtkJPXlTL34lfu2ijGX9cDUGCsiHMbFRUCP+Ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794245474;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=maAY46smz/hc1WG0hz0t00I4PVEDyy9ueVgD72DqbEw=;
	b=45pgTfjzRH3U+cgBuEwY4/lzQiisdzOU+GXlJ74ePMDv4SuEbPPO0OM7eLTr+N05SF2A
	 Wa4ATwy5Rf1azuyBCNIqyV8jYhosVAgd2HOKEjQS7K1kx0XJq8EElWEuAV9iC/apU5pik
	 bc7j+S3H0zNOCFR7FgKf+0CD/SSXvXSPjAh5cTIwd38e3oAIPVu/jtp/jxa/h18weJKoE
	 xylR5dR8lH0wnuNeSHAu9VdvHpZhJRPiULHkPVElZYmDHF1UyFlv0bCXYrdhBNCvtSV0t
	 hRizgdCHMgLNuxPEtsJqRvwmahYkKotXzaTCWQgWaohgEnib6VxGnSFbBA0MAtJBVGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mLsd138q;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A12606A31C;
	Mon,  9 Nov 2026 17:31:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72A12606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mLsd138q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794245473; x=1825781473;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WGmuMAyXDrqF6JtYO5O17Lq18UypLNVFNsn4Xibzyvg=;
  b=mLsd138q/a9JHBX3oI6/2C3671f2iVUm9GVV/iKy1gahQ2G/ae8zcym2
   1B6MlZ5BAkV2e4UxTF90kCY1raasYoLgmYh2nb4qNwqPOYrrmGzqsoZW9
   zR+4W8XfYP6sZKWpUNZr/S4ADdtuuZga6bYCEO8EIt+s+q+vir5dVe1vb
   8cSYKcbZCrP1TrCocmbKlBj6Ssll61C9uJWmF9K9tYhyIqOp7prR5wfWX
   j0q2EnP/RyWPhROEzDCAUltO8mAG7u2+0Td2RdlxckvT5PGX3RddaxFkF
   BXtS7HSihWlsTRHcLcWRIJAgP9AAUPXJYaCLTxHEMOPFmyAADNn+j46g0
   A==;
X-CSE-ConnectionGUID: oT6a7NmeRza6lzksHA+RcQ==
X-CSE-MsgGUID: 0sOl166IRWiCUZcm79zslQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2868689"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2868689"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 09:31:12 -0800
X-CSE-ConnectionGUID: BQXUcpmsTfWazMayI2w95A==
X-CSE-MsgGUID: YngmMmmrTlG8cc8yPhe+sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="7795622"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 09:31:10 -0800
Date: Mon, 9 Nov 2026 19:31:07 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <crofts@kernel.org>
Cc: raoxu <raoxu@uniontech.com>, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, luiz.von.dentz@intel.com,
	brgl@kernel.org, pmenzel@molgen.mpg.de, pengpeng@iscas.ac.cn,
	u.kleine-koenig@baylibre.com, lars@metafoo.de,
	mike.looijmans@topic.nl, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: ltc2471: Fix LTC2473 differential offset
Message-ID: <avIDW76X2QKSIYH-@ashevche-desk.local>
References: <AD0B78CBE86D2045+20261109100659.3796603-1-raoxu@uniontech.com>
 <20261109131208.00006886@kernel.org>
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
In-Reply-To: <20261109131208.00006886@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 09, 2026 at 01:12:08PM +0100, Joshua Crofts wrote:
> On Mon,  9 Nov 2026 18:06:59 +0800
> raoxu <raoxu@uniontech.com> wrote:
> 
> > The LTC2473 reports its differential conversion result as an unsigned
> > 16-bit value spanning -VREF to +VREF. The IIO scale is consequently
> > reported as 2 * VREF divided by 2^16.
> > 
> > IIO offsets are expressed in raw codes, but the driver currently returns
> > -LTC2471_VREF, which is a millivolt value. This makes the processed
> > reading incorrect: with a 1.25 V reference, the midpoint raw code is
> > shifted by 1250 instead of 32768 codes.
> > 
> > Return the raw-code offset so that the midpoint maps to 0 mV and the
> > endpoints map to -VREF and +VREF as intended. The single-ended LTC2471
> > does not expose the offset attribute and is unaffected.
> > 
> > The supplied fix was reviewed and this commit message prepared with
> > OpenCode AI assistance.
> > 
> > Fixes: 1d3eacbfa644 ("iio: Add LTC2471/LTC2473 driver")
> > Signed-off-by: Xu Rao <raoxu@uniontech.com>
> > Cc: stable@vger.kernel.org
> > ---
> 
> Looks fine, but please wait at least 24 hours before sending a
> new version. If you spot an issue after sending the patch, please
> reply to it describing the problem.

Yep, it misses tag from Nuno now. So, v3 with changelog and all tags please!
Easy to get if you use `b4` for that.

> Reviewed-by: Joshua Crofts <crofts@kernel.org>

-- 
With Best Regards,
Andy Shevchenko


