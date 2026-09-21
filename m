Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58C1489FDE;
	Mon, 21 Sep 2026 11:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789988721; cv=none; b=t4pZRUDLlahV+QApqIaomEKbrVTE04/jkDq7hvbP97NM777bMDk3m0rY3QSZL17UaXBgb4FNzs0bdIZhPwzJST6ub4bxcXECr3LzXzLAIy0TWaRA3/Vg2f2Q4tmf+gcViN4gfNW5Y8pVCRKH6gR6bQReX1M5xgOQvdr8sXx/oT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789988721; c=relaxed/simple;
	bh=qLPP3i3QZKEJaRBsoBTTq9gGZE1U11jdY6+r+SxdhKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g1zjO3vfR6ZwKH8h0M8j+Ljr1l3VAbSd0kszgxFFAt0tHgzgXTaZHaCou50SjuMLs/f+tFCNqjr+Xoxi5HH4FBQraXUTdbXa9f4s538u806XxtaMoTDC9CDsTecc62tneUR2dbfUGZoE2qfQvuOtP/0U1NpTrVBZwf3TbxlK4kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FO3hmbcb; arc=none smtp.client-ip=192.198.163.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FO3hmbcb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789988718; x=1821524718;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qLPP3i3QZKEJaRBsoBTTq9gGZE1U11jdY6+r+SxdhKU=;
  b=FO3hmbcbHgu5ZwTCtN3JALTxHcK815JzyxkAgX6e3GDyvbsL4HCKSb8W
   ZXzO5FOjbEI24ZSj6HYt9iI4zYxOS6K/OaTnuTKAJLuOeTE7SIiZdyyu5
   oJSiiYWk423NObLUVOmohEHap0ojYZ4BY2UXDSSJPXapx50BK6oYVZlLw
   qUhtlXwl3cSFZ1EWDZhX3JXp6sWOoVHib5BqTZvr+uXmUGhPqijFwvgzq
   Y1B87kORzdQJuTuWBHaw3oP2yfTsAPTYNG1rtGpWQVzlWEHKMMD9ZqaRh
   7C7PoDABDuRY9/rJ7estluv3HNVFaVNRTUyWJPpKt/UcEr/brIt0P0bjE
   Q==;
X-CSE-ConnectionGUID: +l0ZcFdqSGu/Jf0FFOpDqA==
X-CSE-MsgGUID: wPoecQxUT2enFIaEp0m3GQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11911"; a="998216"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="998216"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 04:05:15 -0700
X-CSE-ConnectionGUID: LPFxbG/VQfmpHLJsSmJzig==
X-CSE-MsgGUID: rZoRl1K6QoSJ3rAi5rCgGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="3910502"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa013.fm.intel.com with ESMTP; 21 Sep 2026 04:05:13 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 1371799; Mon, 21 Sep 2026 13:05:12 +0200 (CEST)
Date: Mon, 21 Sep 2026 13:05:12 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Lee Jones <lee@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	mfd@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mfd: intel-lpss: fix iDMA device leak on probe failure
Message-ID: <20260921110512.GS106095@black.igk.intel.com>
References: <20260921104058.353748-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260921104058.353748-1-lgs201920130244@gmail.com>

Hi,

On Mon, Sep 21, 2026 at 06:40:58PM +0800, Guangshuo Li wrote:
> intel_lpss_probe() may register an iDMA MFD child before registering
> the main controller cell. If the iDMA child is registered successfully
> but the subsequent mfd_add_devices() call for the main cell fails, the
> probe error path returns without removing the already registered iDMA
> device.
> 
> Since the normal remove callback is not called after a failed probe,
> the iDMA platform device remains registered and is never released.
> 
> Call mfd_remove_devices() on the probe error path to remove any MFD
> children that were successfully registered before the main cell
> registration failed.

I think this could use devm_mfd_add_devices() instead.

> The issue was identified by a static analysis tool I developed and
> confirmed by manual review.
> 
> Fixes: 4b45efe85263 ("mfd: Add support for Intel Sunrisepoint LPSS devices")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/mfd/intel-lpss.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mfd/intel-lpss.c b/drivers/mfd/intel-lpss.c
> index 63d6694f7145..657b1e3fb896 100644
> --- a/drivers/mfd/intel-lpss.c
> +++ b/drivers/mfd/intel-lpss.c
> @@ -455,6 +455,7 @@ int intel_lpss_probe(struct device *dev,
>  	return 0;
>  
>  err_remove_ltr:
> +	mfd_remove_devices(dev);
>  	intel_lpss_debugfs_remove(lpss);
>  	intel_lpss_ltr_hide(lpss);
>  	intel_lpss_unregister_clock(lpss);
> -- 
> 2.43.0
