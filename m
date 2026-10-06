Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6026547072;
	Tue,  6 Oct 2026 07:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791272507; cv=none; b=Nq5V4R/DrcLqnbSMpOkQg7faIeoXsYiC4Qhvsq/urcjAjUv569OZB4MV0ZPYWjA2AJPwkyyCzUVmrZOQv0YTlGQ1mGXM0Rng3TMOJR7o6jsys1OhorudVqqDyy6hDWFYa6fXf5z4hkO8kZgCHv8IwIWctJzEgbLc5codTocK2Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791272507; c=relaxed/simple;
	bh=Jvs7bD7PA4yEwVd5cuhIyWWuagFCWt/2y23LxYYManc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PGR2YC2el3sQYOi13OGutBH7bDBxSyZpdSbomrhhFRQ8GzgSOlkCDz1ETQSuc+iLC5jJDsiWU0lABeqeUcqrzNfTJwGpP6lfJ1oUXa3zfQaP2dhjzpxKHGJI+gYmuONBTOPZ9XoCcFmezuGofM+aKmvEDxwdkCojVxsVjwcYgQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D+XhfEht; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D+XhfEht"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791272505; x=1822808505;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Jvs7bD7PA4yEwVd5cuhIyWWuagFCWt/2y23LxYYManc=;
  b=D+XhfEht05rjtlkk3M6k8wVn1MeudWGD1X+TFgr8HlOTQgaKcFPHO/BS
   d+qSsvd5J+KCzmH2+WAJwALhOn4HKtFPU1SDhDIOOmifEuCWu9lS0rLD3
   WRiVODjiXSMmjSPU7OudrNdhffpXAk2v3XEqnt2V0oSF/x6FkH8PIJR6J
   VxkaNJsghAbJm8PtwobZhuSgVS029lc/mVsKsVpOB0gpoXupcASzzxBtq
   SSSFPju0ejdB9rD+HXEjKqyJ0UEESC5MNA68V9enp1U/VTLU3JfuWUkSi
   fqZDCxWrXL+XfrDOfeT96NaMRZqrn8rTnEj8c31VntIbopXI7LIs0Qvo9
   A==;
X-CSE-ConnectionGUID: nn24cThLRXCWVCkAwTSgcw==
X-CSE-MsgGUID: QxF+oHeoSs26UgOOIKxbVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="3722"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="3722"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 00:41:44 -0700
X-CSE-ConnectionGUID: NvKzBjS1SFGc6dKHvOE3lg==
X-CSE-MsgGUID: 7jEUxuY8Qsiw/5ZQ1mJDrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="285187984"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.59])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 00:41:41 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Yuho Choi <oss.patchbox@gmail.com>, Zhenyu Wang
 <zhenyuw.linux@gmail.com>, Zhi Wang <zhi.wang.linux@gmail.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>, Xiaolin
 Zhang <xiaolin.zhang@intel.com>, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Yuho Choi
 <oss.patchbox@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH v1] drm/i915/gvt: Don't replace a DMA mapping that is
 still in use
In-Reply-To: <20261004212403.208681-1-oss.patchbox@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20261004212403.208681-1-oss.patchbox@gmail.com>
Date: Tue, 06 Oct 2026 10:41:39 +0300
Message-ID: <5e03928e7817104f062e27f0b14d180549f209c2@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, 04 Oct 2026, Yuho Choi <oss.patchbox@gmail.com> wrote:
> intel_gvt_dma_map_guest_page() unmaps and frees the cache entry of a
> gfn when it is requested with a different size, and maps the page again.
> The entry is still referenced: shadow GTT entries and dma-bufs keep
> using its DMA address after the page is unpinned and the DMA mapping is
> torn down. When the new mapping gets the same DMA address, their later
> intel_gvt_dma_unmap_guest_page() calls also drop the references of the
> new entry.
>
> Keep the existing entry instead. A 2M mapping covers a 4K request for
> its first page, so take a reference on it. If the entry is smaller than
> the request, fail and let the caller split the 2M entry into 4K pages,
> as it already does when a 2M mapping cannot be set up.
>
> Fixes: 7366aeb77cd8 ("drm/i915/gvt: fix incorrect cache entry for guest page mapping")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
> ---
> Compile-tested only (x86_64 defconfig + DRM_I915_GVT_KVMGT, W=1, sparse).

IOW, you're not hitting the issue yourself? How did you find the issue?
Did you use LLM to write the patch?

BR,
Jani.

>
>  drivers/gpu/drm/i915/gvt/kvmgt.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
> index ec62db5cc3675..9a3e305253469 100644
> --- a/drivers/gpu/drm/i915/gvt/kvmgt.c
> +++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
> @@ -1626,19 +1626,15 @@ int intel_gvt_dma_map_guest_page(struct intel_vgpu *vgpu, unsigned long gfn,
>  		ret = __gvt_cache_add(vgpu, gfn, *dma_addr, size);
>  		if (ret)
>  			goto err_unmap;
> -	} else if (entry->size != size) {
> -		/* the same gfn with different size: unmap and re-map */
> -		gvt_dma_unmap_page(vgpu, gfn, entry->dma_addr, entry->size);
> -		__gvt_cache_remove_entry(vgpu, entry);
> -
> -		ret = gvt_dma_map_page(vgpu, gfn, dma_addr, size);
> -		if (ret)
> -			goto err_unlock;
> -
> -		ret = __gvt_cache_add(vgpu, gfn, *dma_addr, size);
> -		if (ret)
> -			goto err_unmap;
> +	} else if (entry->size < size) {
> +		/*
> +		 * The smaller mapping may still be in use, so don't replace
> +		 * it. Fail and let the caller map the range in smaller pages.
> +		 */
> +		ret = -EBUSY;
> +		goto err_unlock;
>  	} else {
> +		/* A mapping of the same or a larger size covers the request */
>  		kref_get(&entry->ref);
>  		*dma_addr = entry->dma_addr;
>  	}
>
> base-commit: 7704c4c5bb127673b4f0ead839919db573559e38

-- 
Jani Nikula, Intel
