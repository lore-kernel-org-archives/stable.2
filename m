Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8BD19D07A
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 06:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787551768; cv=none; b=J//80ObVAQ8jZCHiMWm34RyEpbM1n2yDlYfa9eRzDSudgxSVX/IUeb9jk+JkHJ41xGWfeGVBeL6GwPgGBDzI3egJZfOh6RLChqw8AIYU1gooV7DeOhvHSey/wZfcFuhvHiYS3z4MAHF5wvRBUHwAAlpijau1QnPZypRWaOlZ2C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787551768; c=relaxed/simple;
	bh=+2ZUV1uE9hycODsVAUZL9pR09J+/JMXRNa3kJ7fviPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uWlLuRKowsM/TQyRMPWCxyRMfwmWTgXxWYkqrrQOJPsz1Zpi+Jbv+vLvPlyId7l+epqUIGAwGaY9dTBsFUzURJIuPCSNy3kc5etsmSNJV8E0cwBX9zSua5OrNyByXMVSu+wmQFYRk9FiVyf0xoSn4Ri5vIr95HfCId7GrTnslyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AtH/Vr4A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AtH/Vr4A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41DB91F000E9;
	Mon, 24 Aug 2026 06:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787551766;
	bh=cwEpR0yGb+GeDBO3VcwaHTm/gP9Zro14v0sfLGa3KO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AtH/Vr4AlT/Ct3uuZ3/2h9FAfp5cmqmG+TIKDF33buu2+PqUPGMMp8leF68X6hwaN
	 DdR1FrLlP26sdJAV2jd4BPZzjyiZInhXupm8nWkk6kQWCETulF6/Bfp/kt+4FOkOcT
	 QplXeB4NHkZgsooyRX0YfvZ2QKlLnACkJrCJUpcA=
Date: Mon, 24 Aug 2026 08:09:23 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jia Yao <jia.yao@intel.com>
Cc: stable@vger.kernel.org, Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH 6.18.y] drm/xe/guc_ads: allocate UM queues in VRAM on dGFX
Message-ID: <2026082410-arrival-blank-fcf9@gregkh>
References: <2026082047-manned-outer-503f@gregkh>
 <20260820161128.1337094-1-jia.yao@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260820161128.1337094-1-jia.yao@intel.com>

On Thu, Aug 20, 2026 at 04:11:28PM +0000, Jia Yao wrote:
> On iGPU, the UM queue BO is allocated in system memory. On dGFX, the BO
> was previously created in system memory and later reallocated in
> xe_guc_realloc_post_hwconfig().  Allocate the UM queue BO directly in
> VRAM on dGFX, where it is ultimately required.
> 
> Fixes: 9c57bc08652a ("drm/xe/lnl: Drop force_probe requirement")
> Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: <stable@vger.kernel.org> # v6.12+
> Signed-off-by: Jia Yao <jia.yao@intel.com>
> Reviewed-by: Matthew Auld <matthew.auld@intel.com>
> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> Link: https://patch.msgid.link/20260804165057.129529-3-jia.yao@intel.com
> (cherry picked from commit ace076ef0a854ab5940bacc539bf66afd61d118c)
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> (cherry picked from commit f342810a141f8a7e8b3786a6e4b6c0695a078a74)
> ---
>  drivers/gpu/drm/xe/xe_guc.c     | 6 ------
>  drivers/gpu/drm/xe/xe_guc_ads.c | 8 +++++---
>  2 files changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_guc.c b/drivers/gpu/drm/xe/xe_guc.c
> index cc5741f751b9..ae0c88da422b 100644
> --- a/drivers/gpu/drm/xe/xe_guc.c
> +++ b/drivers/gpu/drm/xe/xe_guc.c
> @@ -700,12 +700,6 @@ static int xe_guc_realloc_post_hwconfig(struct xe_guc *guc)
>  	if (ret)
>  		return ret;
>  
> -	if (guc->ads.um_queue_bo) {
> -		ret = xe_managed_bo_reinit_in_vram(xe, tile, &guc->ads.um_queue_bo);
> -		if (ret)
> -			return ret;
> -	}
> -
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/xe/xe_guc_ads.c b/drivers/gpu/drm/xe/xe_guc_ads.c
> index 806c2618a7cd..4c3e21b5e60e 100644
> --- a/drivers/gpu/drm/xe/xe_guc_ads.c
> +++ b/drivers/gpu/drm/xe/xe_guc_ads.c
> @@ -392,15 +392,17 @@ int xe_guc_ads_init(struct xe_guc_ads *ads)
>  		/*
>  		 * Allocate a separate BO for the HW fault ring (UM queues).
>  		 *
> -		 * Round the size up to the next power of two so that
> +		 * Round the size up to the next power of two so that on iGPU
>  		 * (system memory, no IOMMU) the TTM pool issues a single
>  		 * alloc_pages(order=N) call, maximising the chance of getting
>  		 * a physically contiguous block.  GuC requires contiguous DPA.
>  		 */
> -		size_t um_size = roundup_pow_of_two(GUC_UM_QUEUE_SIZE *
> +		size_t um_size = IS_DGFX(xe) ?
> +				 GUC_UM_QUEUE_SIZE * GUC_UM_HW_QUEUE_MAX :
> +				 roundup_pow_of_two(GUC_UM_QUEUE_SIZE *
>  						    GUC_UM_HW_QUEUE_MAX);
>  
> -		u32 um_flags = XE_BO_FLAG_SYSTEM |
> +		u32 um_flags = XE_BO_FLAG_VRAM_IF_DGFX(tile) |
>  			       XE_BO_FLAG_GGTT |
>  			       XE_BO_FLAG_GGTT_INVALIDATE |
>  			       XE_BO_FLAG_PINNED_NORESTORE;
> -- 
> 2.43.0
> 
> 

Does not apply at all, are you sure you made this properly?

thanks,

greg k-h
