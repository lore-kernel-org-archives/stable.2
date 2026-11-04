Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793805499;
	b=XtsNoPhSLv16pim+gHrPtmvrq3YwLajoL3tZyn/i4idTBNYxi+kgcpF9BX8db1DA92R1
	 w6s/QKrdFkvRxtdXG6n0PoZJhrj8kDlipw5UoeJtKLRI3F63DAYvt+qaIUL2PTGpOhmrx
	 NMDr51B4vxdWuc7uxq3PW+xVuQWFrsVXKbetzdV7ypNZ63WJOiAJJiQe65C9Eul5ye54a
	 sLzpE3d9pJ3qiikl5vPyBxmDHjP2DKlIBpWtox+b/y1fQz8x03ogBvlWaGpCIpM0kyGBR
	 NXX98IVlyGKZT2Bty5oz8CiY/NBCQR/XdwpIFzQizpUQYfCaWmvsJtXq0x46ntMgBxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793805499;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 X-Patchwork-Hint:Organization;
	bh=yBZLvlIQ8z70a2Wr1ymf4FFDCT+5HoGOnnRPNF17kG0=;
	b=d4eNki77Ja8+Ya/Pb5GR2wWyN/y4FGtEl8c8pTenPJDhIXxbtL3DvO7iwGtjkM7c0vfz
	 uMez9cgJ3VYp5Ckby1KwwxlHpS7PfeVKGCjKr+WjjvadsbPYPqqDNrKsTFCCdZSqEr1+J
	 vFGIM+FzVjC7P+M/+BAaIPH5F1raf4P22XF6g4EJOY6dfGovP8InNZG162QeiNzbZ1bI6
	 +rFSGtAs8Ln3uazx2rYPqr4l2CEkgQEzQQVLa6k9GOxd+krozMB3pgBM1vAbOEj87bYBC
	 uXN3XKuG7Jx8QTDYfW0Bge3sXKjwLOFBzNkhDcfDiNptI/rIDj7TBLRILStQmUwH7iA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mAvO84X+;
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB858606A33E
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 15:18:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB858606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mAvO84X+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793805497; x=1825341497;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=aZNTFXwM/wcgpwxafNC8PNs4ZQ3LDaLEX0ahb1iRUVk=;
  b=mAvO84X+GOctPX7IWfjxG8HfXEDVS5qhhQ0tffRWW80kMNW6E2xihE2G
   CiTSpPJI41YqO29RhZ1zq6WjbVrlWBUYX9SMRcBkp/neUiur+rY8xEScW
   +MOroiSZfSpneT72EtuUsnM+lk/oVj4mawWF7DEc6y/HMvVvx1qnbVGcy
   fj/gLdlimPPrjAN7XP3v0FlessOp1n9hL/POQDb2HreNFIcs/iYDcS5WO
   hkSzSrvN86vXNrYTYKZ87EAwCUGOIr+bYcA68cOKBF4BsP1wcSKwvpEnm
   JgH1jyQcqhmieV3+jsD8zNsZPSh/UnTm3RpWV+XBwAVVE6DRjd6X2aHnw
   A==;
X-CSE-ConnectionGUID: GrqGxl8oRzOzmsfoVzJP2w==
X-CSE-MsgGUID: bRiqpspkQBOLiWEToW/7Nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2577016"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2577016"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 07:18:12 -0800
X-CSE-ConnectionGUID: GQe38O66SFqTMGlAkUZJIA==
X-CSE-MsgGUID: o4n7ANsfRAuUtGmOVChJmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6877305"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.86])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 07:18:09 -0800
Date: Wed, 4 Nov 2026 17:18:05 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Chengyu Liu <lui2012qwq@gmail.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
	rodrigo.vivi@intel.com, tursulin@ursulin.net,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] i915/gt: tolerate ERR_PTR pd in gen6_ppgtt teardown
Message-ID: <autMrRaeVWRtBlMP@intel.com>
References: <20261104073311.1617823-1-lui2012qwq@gmail.com>
 <20261104073311.1617823-2-lui2012qwq@gmail.com>
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
In-Reply-To: <20261104073311.1617823-2-lui2012qwq@gmail.com>
X-Patchwork-Hint: comment
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland

On Wed, Nov 04, 2026 at 03:33:10PM +0800, Chengyu Liu wrote:
> gen6_ppgtt_create() stores the result of gen6_alloc_top_pd() into
> ppgtt->base.pd and, on failure, jumps to err_put with the ERR_PTR still
> in the field.  i915_vm_put() runs vm->cleanup = gen6_ppgtt_cleanup(),
> which calls gen6_ppgtt_free_pd(), where gen6_for_all_pdes() immediately
> dereferences pd - with an ERR_PTR that is an invalid dereference and a
> crash (in the async release worker).  The free_pd() right after is only
> guarded against NULL, not ERR_PTR.
> 
> Bail out of gen6_ppgtt_free_pd() for an invalid pd and skip free_pd()
> likewise, so an allocation failure under memory pressure stays a plain
> -ENOMEM instead of an oops.

The correct fix would be to not assign the error pointer
into ppgtt->base.pd in the first place.

Looks like a somwhat common bad pattern in this code that
received pointers are assigned directly into their final
location, and if the pointer is an error then the pointer is
cleared. IMO one should never do that because it's very easy
to forget the clearing part. Instead one should always use 
local variable first, and only assign the final pointer after
having checked that the pointer is valid.

> 
> Found by static analysis.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengyu Liu <lui2012qwq@gmail.com>
> ---
>  drivers/gpu/drm/i915/gt/gen6_ppgtt.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/gt/gen6_ppgtt.c b/drivers/gpu/drm/i915/gt/gen6_ppgtt.c
> index 438cd4724a..72a9ad4642 100644
> --- a/drivers/gpu/drm/i915/gt/gen6_ppgtt.c
> +++ b/drivers/gpu/drm/i915/gt/gen6_ppgtt.c
> @@ -259,6 +259,9 @@ static void gen6_ppgtt_free_pd(struct gen6_ppgtt *ppgtt)
>  	struct i915_page_table *pt;
>  	u32 pde;
>  
> +	if (IS_ERR_OR_NULL(pd))
> +		return;
> +
>  	gen6_for_all_pdes(pt, pd, pde)
>  		if (pt)
>  			free_pt(&ppgtt->base.vm, pt);
> @@ -271,7 +274,7 @@ static void gen6_ppgtt_cleanup(struct i915_address_space *vm)
>  	gen6_ppgtt_free_pd(ppgtt);
>  	free_scratch(vm);
>  
> -	if (ppgtt->base.pd)
> +	if (!IS_ERR_OR_NULL(ppgtt->base.pd))
>  		free_pd(&ppgtt->base.vm, ppgtt->base.pd);
>  
>  	mutex_destroy(&ppgtt->flush);
> -- 
> 2.25.1

-- 
Ville Syrjälä
Intel
