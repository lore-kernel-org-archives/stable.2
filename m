Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021F6348C5E
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 16:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784304334; cv=none; b=kMbp8gcpZxrIDs7R3+60o7IRRvimFfzQg33DuzD0sUVEPQdwGTmOB9rWWoUEKNMmvhXYHZyMbclRuYttnP5onrJ4tJ1+agz3vxssVCfw7ukhVqJonncACCwFJOcwK5lGTc7czmhR422rS6ZerzFbHYpUWKlsFBv+nl9KuSRtNwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784304334; c=relaxed/simple;
	bh=tM4dT+Nmv5zOrvAbTwI+ob1hRXlnRoJ6llL+/ffH6e8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dd5TkO+0cEP2EPDUJg+mtENrrZlQTLBQ90bJmoJqBrTiBv2kvnhxMKwDGsWkHRQhd1+Q3ky+JHJewN3l/nV1J0egeQisLRCoi6BG1cj2CHFV6fVj2OYGmXYkmMdm0fIJydvTqnyDCR+yznqjlMPRuxrP8wcqEN6Au/crsNQs0+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AF9EL/pW; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AF9EL/pW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784304332; x=1815840332;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=tM4dT+Nmv5zOrvAbTwI+ob1hRXlnRoJ6llL+/ffH6e8=;
  b=AF9EL/pWpMfQBeHnkrhAmIo22VkoMpG6qSxu5qTD5o6HFVfIaqlxYlyF
   pPTB4841Qbd0umY1J8aQnAlH42gHQHOWuBiAwSgxYmmscRQi5hvAIhcIr
   /7qq7DvFPiuTP4zZ532x/c7X89YR31aWJIIkQWxIO206XQRuyYTDBSObG
   vIZMOHJPt5KTXeoMUagQrsXeBvhKjYdmmW7m67IWvScCHSNH/kcM/ChH6
   AVTqmrwBPQ3zeY0bEGkvXo5G/VeODJwaHMBymTSCjlL1fwQWjOF1z2Uqr
   +m5qC4x3dj+H4byo8NtrhNlTljOyKNozsmOeL4ONXWk+IFfqWfwmk+l8T
   Q==;
X-CSE-ConnectionGUID: h53aTo1aRjySGkGzlYsFaA==
X-CSE-MsgGUID: jfUopPW+SWG7h3oNYA4exA==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="85020191"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="85020191"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 09:05:32 -0700
X-CSE-ConnectionGUID: XZ9XCs/zRw2W7ITlek9Uew==
X-CSE-MsgGUID: ZrgroqvvRcy+6Dvts+/Huw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="260409492"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.241])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 09:05:29 -0700
Date: Fri, 17 Jul 2026 19:05:26 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org, stable@vger.kernel.org,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: Re: [PATCH 1/2] drm/i915/cdclk: Avoid spurious cdclk sanitization on
 PTL+
Message-ID: <alpSxjjmv34zKW2p@intel.com>
References: <20260717155107.17801-1-ville.syrjala@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260717155107.17801-1-ville.syrjala@linux.intel.com>
X-Patchwork-Hint: comment
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland

On Fri, Jul 17, 2026 at 06:51:06PM +0300, Ville Syrjala wrote:
> From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> 
> Apparently PTL+ no longer has the cd2x pipe select field in
> CDCLK_CTL. Take that into account during CDCLK sanitization.
> 
> This currently triggers a spurious CDCLK sanitization during
> driver load on PTL+ which will causes a visible glitch on all
> active displays.
> 
> Cc: stable@vger.kernel.org
> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8550
> Fixes: 3f9de66f8acb ("drm/i915/cdclk: Fix up CDCLK_FREQ_DECIMAL without a full PLL re-enable")
> Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> ---

Unfortunately the regression itself has a cc:stable on it, so we'll
need to backport this fix as well.

To do that cleanly we need to pick up these as well:
commit cd16e794aead ("drm/i915/cdclk: Clean up CDCLK_CTL defines")
commit 67d77d9472c6 ("drm/i915/cdclk: Introduce bxt_cdclk_cd2x_pipe_mask() and use it")

>  drivers/gpu/drm/i915/display/intel_cdclk.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_cdclk.c b/drivers/gpu/drm/i915/display/intel_cdclk.c
> index a53d88727177..9e5e15b0c4d1 100644
> --- a/drivers/gpu/drm/i915/display/intel_cdclk.c
> +++ b/drivers/gpu/drm/i915/display/intel_cdclk.c
> @@ -2381,8 +2381,10 @@ static void bxt_sanitize_cdclk(struct intel_display *display)
>  	 * dividers both syncing to an active pipe, or asynchronously
>  	 * (PIPE_NONE).
>  	 */
> -	cdctl &= ~bxt_cdclk_cd2x_pipe_mask(display);
> -	cdctl |= bxt_cdclk_cd2x_pipe(display, INVALID_PIPE);
> +	if (DISPLAY_VER(display) < 30) {
> +		cdctl &= ~bxt_cdclk_cd2x_pipe_mask(display);
> +		cdctl |= bxt_cdclk_cd2x_pipe(display, INVALID_PIPE);
> +	}
>  
>  	if (cdctl != expected) {
>  		if (DISPLAY_VER(display) < 20) {
> -- 
> 2.54.0

-- 
Ville Syrjälä
Intel
