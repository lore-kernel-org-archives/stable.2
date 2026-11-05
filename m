Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793903484;
	b=SeR5WcczlGBD5drhznGRa7jOj2c+DdyK6bF8+JpyWqirmFP5OKtWyaUK/DeFFy4NBCDw
	 KIgdkij61f5dk8TDjpU5xzMvCtgLH/LHGtewr+bdaw5nIink/4C/SaXdVYFta78+affuX
	 y+dQbjOJ7hLrnlEqedkuhWVz1sHQ2Kxg80qi8Ui+DujsGJ8m4ZpAOTWPzhBiKfqo2+Ov0
	 ZIHVDtyXAnmC9DxJYrpg6BGq+TDHOI85lpkypUQvK7CK5Dr05aIXzQBKhkqrKxheNSPzB
	 PGGqJMtLEPYUQhYW8ikfpUndjhFOjaGXwg+M1oZb+GwvNdDObfvP0DM8pWhSo/jSTXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793903484;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 X-Patchwork-Hint:Organization;
	bh=WwkvDRtHEJBciSzWk9FpLgZP6gn0rZI7lUvTL7qFPGk=;
	b=Ix1vllCBGChE3+jwNFJmpwcEejf7O2og1FDkyDf4mh51ZFZkFvqmQHxrjbrYpM8ww23V
	 vMNFZg2JJM+Y6Me48EYqIUzM9/Nq807dqSabjHbXZgTkwJtVdk/VYfTLWgNMZU/Dvf9uR
	 YCab5BZnhLA9BeBeaE9xAN/gQVGRIJZYCk1yIQScvKtviz0Os7rEyTZX1u88GHWbFuZhn
	 f6iRQXqOamDe1+VckIvrQu5Q3kBb50mA2D5V7AITViAsExyMMzsKsLlQkKlODzaDbcdWv
	 Wcc/FOQUdyBreupB8uTIA22/R2AA2YdQ09Rz+bv875/aVdK7EFo5/hbIFAfA0AQDydA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TvAofHOz;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D933606A326
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 18:31:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D933606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TvAofHOz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793903483; x=1825439483;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=j2mvJ5a8fsbbPNHvdOtBbrbBDAd2SqqYDHITBf9HNKs=;
  b=TvAofHOzZbtU3yfa8z0G6BUEC0uMQ2Po68Vrxh6juZhcujYlU+v5wFVz
   J/6lY3pWPN2tLI6nFAeCyl1MVniW7r80XU3SwizfiVW1Y6MKBSUs/cfni
   CsDRXWk2KQZzuKk4BJip6eW4iEl7/zDsvaawWJY2/pQE7wxKkR3lbS/aT
   6LcbT45qJOmXuTZCMc3Ze8kLCNg5JFdffIrmHBVzPUi+ENxi9yJpDOuFj
   /8qQ/5eNPplnSQCacozWm7jMN6A4jofr16pUSr2Ww3qTJDMT5s95uq8BC
   sl1Z0uRvJgl5HiASnKyqMX5qDOlq+clytinSCUZtDEZu9868yMq9fpjOu
   g==;
X-CSE-ConnectionGUID: 0j63kcCsR7O2+2nZf/wtdA==
X-CSE-MsgGUID: xoCApWevTpOvxCawbYWqbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2697726"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2697726"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 10:31:02 -0800
X-CSE-ConnectionGUID: ASmBuyjaQRWTE2vht7cW5A==
X-CSE-MsgGUID: PUpXyBVYQYeBraWHrXpUUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7497834"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.198])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 10:31:00 -0800
Date: Thu, 5 Nov 2026 20:30:56 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm/i915/cdclk: Ignore SWF18 in SKL CDCLK sanitization
Message-ID: <auzLYHTMuLVVktJv@intel.com>
References: <20261105124737.24456-1-ville.syrjala@linux.intel.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261105124737.24456-1-ville.syrjala@linux.intel.com>
X-Patchwork-Hint: comment
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland

On Thu, Nov 05, 2026 at 02:47:37PM +0200, Ville Syrjala wrote:
> From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> 
> Currently on SKL/derivatives we are checking whether
> the VBIOS/GOP programmed the SWF18 scratch register
> appropriately. Based on the original commit, and the
> set of bits checked, the code actually wanted to check
> SWF06 instead. Looks like it's just completely confused
> whether the register offset should be 0x6*4 vs. 0x18 vs.
> 0x18*4. SWF06 is where the VBIOS/GOP should stuff some
> information about what outputs it enabled. SWF18 is
> where the VBIOS/GOP is supposed to stuff the maximum
> CDCLK frequency.

Actually it's me who is confused. SWF06 is the CDCLK thing
and SWF18 is the pipe/output thing. So I guess it was checking
the right register after all. Oh well, that doesn't change the
fact that it doesn't work on chromebooks.

> 
> I suppose either of these scratch registers are part
> of the expected protocol between the VBIOS/GOP and
> driver, but it looks like at least some coreboot
> based systems don't set them up.
> 
> SWF18 not being populated leads us to reprogram the
> CDCLK PLL during driver initialization, while the
> display pipes are still potentially active. We also
> set CDCLK to its minimum frequency, under the
> assumption that nothing actually needs a higher
> CDCLK frequency when it hasn't even been correctly
> initialized.
> 
> Due to some other changes in the code we may no longer
> force a full CDCLK recalculation and reprogramming upon
> the first atomic commit, so CDCLK can remain at a
> potentially too low a frequency indefinitely.
> 
> To fix this let's just stop looking at SWF18 completely.
> The code is anyway confused about which register
> it's actually looking at, and we don't look at that
> register on any other platform either. We also do an
> actual readout of the CDCLK state from the hardware
> so we should be able to spot if anything is wrong
> enough to need reprogramming.
> 
> Cc: stable@vger.kernel.org
> Fixes: ba91b9eecb47 ("drm/i915/cdclk: Decouple cdclk from state->modeset")
> Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/16595
> Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/17423
> Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> ---
>  drivers/gpu/drm/i915/display/intel_cdclk.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_cdclk.c b/drivers/gpu/drm/i915/display/intel_cdclk.c
> index 92e6fca861f6..0f2f693c78d4 100644
> --- a/drivers/gpu/drm/i915/display/intel_cdclk.c
> +++ b/drivers/gpu/drm/i915/display/intel_cdclk.c
> @@ -1269,18 +1269,7 @@ static void skl_set_cdclk(struct intel_display *display,
>  
>  static void skl_sanitize_cdclk(struct intel_display *display)
>  {
> -	u32 cdctl, expected, swf18;
> -
> -	/*
> -	 * check if the pre-os initialized the display
> -	 * There is SWF18 scratchpad register defined which is set by the
> -	 * pre-os which can be used by the OS drivers to check the status
> -	 */
> -	swf18 = intel_de_read(display, SWF_ILK(0x18));
> -	if ((swf18 & 0x00FFFFFF) == 0) {
> -		drm_dbg_kms(display->drm, "Sanitizing CDCLK due to SWF18 0x%x\n", swf18);
> -		goto sanitize;
> -	}
> +	u32 cdctl, expected;
>  
>  	intel_update_cdclk(display);
>  	intel_cdclk_dump_config(display, &display->cdclk.hw, "Current CDCLK");
> -- 
> 2.56.0

-- 
Ville Syrjälä
Intel
