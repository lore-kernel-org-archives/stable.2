Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF743446B0;
	Tue, 18 Aug 2026 08:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787041607; cv=none; b=gFRh1SOF2N3QR/vRQIa0X4LpJXMQQH53CsPITiKu1EXkn237lhAO2mYhBcUbN3jncNvVOpV4vm+STmCqERfGWkKOghSF8S8W0boyirfBuAaHq/zLaBrXQujC7JMWO7kYpQaeklLIyoINzpHSTf2oyUCVcXK2i7CgO0UQcL2/39w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787041607; c=relaxed/simple;
	bh=Hw5QSf7LguCSNMBpzlpSPawZ6KwlO9KQc0tQS3V7aJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rTbbOoUPtbF9mJN28iKJPMcq8K31z++9IH+MV5wYme3xFQoSP5YONZBg/XKvP8plii0H3eyUpOFkMhbqVx/9LRyxBF8IL7XiVWIWWxSDWJuB0qgAgkGppjS5LHKcMkT5WI1oAQF3UzBOzW2Uvhd0J6JJeIdSkCtC3VEfkSdWNm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LooOcyja; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LooOcyja"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787041605; x=1818577605;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Hw5QSf7LguCSNMBpzlpSPawZ6KwlO9KQc0tQS3V7aJA=;
  b=LooOcyjagJiqP+R1UCrdsZRWY6Vjn5QXnrHnsjAJlDHlCCkitK3zsFYE
   mpkfhuG4hLq3BW/970IXjXooTrm7iyUIqgBUn6VrOzA57Nx+WFmxdLCGI
   7MPnQ8waV6aL87E96LA9dpR34/9Wda0OeXGK+42o/7H3HOA+Hv9iPqkTS
   LiDyr/0qzXnUCBGAcy3TIfPuL3PuQJuHsfviGi5pTQG/ELE0yZJJGePLv
   3T6VFHE8pLjlJ+KEF/cLgJLBqCBy95HPPk/e3MXDmk+bMQCb3tJAewN4Z
   rPvMu9e+LHihLFpuZhYMEu8CsaiispsYl9Uqnqgxxg5BhFcWOyQ09V7AB
   g==;
X-CSE-ConnectionGUID: bszbL/wrTW6XvbWOvOUpdQ==
X-CSE-MsgGUID: YQetxx0AQPa+7IqhSr5UgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="87441817"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="87441817"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 01:26:45 -0700
X-CSE-ConnectionGUID: fo6r2X9USASGIMr6kQwY/Q==
X-CSE-MsgGUID: t+X7AI4JQA6WkT8nAAIJ5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="268667909"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 01:26:42 -0700
Date: Tue, 18 Aug 2026 11:26:39 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Zhang Jie <zhangjie14@huaqin.corp-partner.google.com>,
	Hans de Goede <johannes.goede@oss.qualcomm.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, gwendal@chromium.org, swboyd@chromium.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: sx9324: Correct proximity channel
 resolution
Message-ID: <aoQXPzFaMBpD2eC8@ashevche-desk.local>
References: <20260818072803.463864-1-zhangjie14@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818072803.463864-1-zhangjie14@huaqin.corp-partner.google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Aug 18, 2026 at 03:28:03PM +0800, Zhang Jie wrote:
> The proximity channels were previously defined with 12 realbits.
> However, PROXDIFF is read from RegDiffMsb (0x65) and RegDiffLsb
> (0x66). The SX9324 datasheet assigns bits 7:0 of each register to
> PROXDIFF and documents it as a signed two's-complement value
> (Revision 3, Section 8, Table 8, page 43). In contrast, RegOffsetMsb
> explicitly marks bits 7:6 as reserved. Thus, PROXDIFF is a 16-bit
> signed value.
> 
> With realbits = 12, sx_common_read_proximity() uses bit 11 as the
> sign bit in sign_extend32(), causing samples outside the 12-bit
> signed range to wrap into the [-2048, 2047] range.
> 
> Correct the realbits value to 16 to accurately reflect the hardware.

> Tested on an SX9324-based device: a phase 0 DIFF readback of 0x7fff
> was reported as -1 before this change and as 32767 afterward.

Yeah, there seems only Chromebook devices (in ACPI world), MediaTek and
Qualcomm (in DT world). Do we have anybody from Qualcomm to test this?

Hans, I think you (or somebody you might know at QCOMM) might be interested
in this fix.

From the datasheet shared I see the same as described in this commit
and since it was tested on real devices I'm quite sure this is the case.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

> Fixes: 4c18a890dff8 ("iio:proximity:sx9324: Add SX9324 support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhang Jie <zhangjie14@huaqin.corp-partner.google.com>
> ---
>  drivers/iio/proximity/sx9324.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
> index 36c45d101336..de6176fd8d47 100644
> --- a/drivers/iio/proximity/sx9324.c
> +++ b/drivers/iio/proximity/sx9324.c
> @@ -223,7 +223,7 @@ static const struct iio_chan_spec_ext_info sx9324_channel_ext_info[] = {
>  	.scan_index = idx,					 \
>  	.scan_type = {						 \
>  		.sign = 's',					 \
> -		.realbits = 12,					 \
> +		.realbits = 16,					 \
>  		.storagebits = 16,				 \
>  		.endianness = IIO_BE,				 \
>  	},							 \

-- 
With Best Regards,
Andy Shevchenko


