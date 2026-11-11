Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794399530;
	b=qYbEp0bgOeZaZ4vj3Z9smOtiYr0kU5id7ip1zwBEf07QRC0aJ32vFANurl1oARzyI+/j
	 sJmZwU9R7+VAjDzpdy/EmQrS4S6mUvChajq/GTSlPpslC2UkTse6YHAu2DiGVY/LznGWS
	 4mhhtE1bn731E4uiN38JeSozIiytM6PifnyKVqpzDzOLReEmjJHVR71xD8NaNJLAg586s
	 HA0sHPZYsPX+X2E4A9KUo+AndEsI3X6W1k/APfWIcmdtfU9rYGJ1KrJY7ca766m3G9izg
	 mTeS0jxA+ddSzXptHv0hhxfjKrLuKHbKvl/Y9cXsSYKVqQ79XKuZ19+oLxIZpkSGz0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794399530;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Tf4dhCIJ4+3hC6+ZflSD5vc5I61Peo0d/uikIVNa/tQ=;
	b=vY1d9jWf6V1xWc2Py7RbJDZ1uuzHipJ0GPTDSGSq3VLKUkfaZQT+5yL9xQ/csW4Ke7r/
	 QUh7s9rcShyZhhn2gwU9Ru9oXfn/dBPZ9H7jcmPWsGv2iEJpo9Z7gtVn2NjLDNIRL/QHO
	 VXTCND9KXyr674dgVllHY+2N86rU/C1WBGn66TwXSOgD696tJY9UGHogA7ci4eisKoTiZ
	 Qp+O1dJPsoJCeI5OiI2rfPDnSNQBrYWnA+wThc4iXaI6cmYJWDTNqdcqHOBODCKE/v99o
	 DsgFK6ZiQEky1BRgxDJH6Tkuqwvvv9SH42iVeVxpF5WVqCXol23LKMY4X31wB+nUFkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KiapajGH;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005AD606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 12:18:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 005AD606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KiapajGH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794399530; x=1825935530;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mkFqJX62KijkMmgEeIt8jKa0wlwYNQ1L6nJBDkV8q4I=;
  b=KiapajGHE1EdnMRQ3a+jw4gOVjn0Qt1Ugwdt1X6HrT5z42p20cFvdmtM
   hFf+7bS/E1tXRsLckpqI4m9Iyxp3gNfLQG8LfojrAvpUaKhljlLGJTzOX
   0exd+BsDeBUXFzM1L+ttkw2sjKv915plhheNBFD3I1SH1U0EaPI/GO6Jt
   +RQgvk3MEMdLmdX38sp7kqupom5EtREMf4dSRRJFeZ3gIgDxTg+6uTTzQ
   iUFa7B/sSI5VWFTlr48jD2uZQkqKboxPNbOpUnfjJUK0hZj81lAwfMm/+
   NTbV9krOxY5mOs3WpuRAMeCqxXAm+bah3vP0LM3y4obi73jsbGsRLAAPt
   A==;
X-CSE-ConnectionGUID: 6Th/SF9kQ6eSZ+9g2MUS7w==
X-CSE-MsgGUID: 2fi218FtRLW19QGbD9rdKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3089710"
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="3089710"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 04:18:50 -0800
X-CSE-ConnectionGUID: 5OuONr73TrqjbVDNvRrmCQ==
X-CSE-MsgGUID: dOjm/moxTrWpXx6pVxP/8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="8444842"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO [10.245.245.160]) ([10.245.245.160])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 04:18:48 -0800
Message-ID: <fc3a08df-bc2e-47bf-a0f8-a7e284e5f3c2@intel.com>
Date: Wed, 11 Nov 2026 12:18:45 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/xe/dma-buf: Validate BOs on export to charge the
 exporter
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>, Dave Airlie
 <airlied@redhat.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 stable@vger.kernel.org
References: <20261111100929.2228-1-thomas.hellstrom@linux.intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20261111100929.2228-1-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/11/2026 10:09, Thomas Hellström wrote:
> xe_gem_prime_export() calls ttm_bo_setup_export() to make sure the
> exporter is charged for the memory backing an exported BO. However,
> that only populates a TTM_PL_SYSTEM tt. A BO that has been evicted, or
> that has deferred backing, will instead get its memory allocated when
> the importer maps it. For p2p imports this happens through
> xe_bo_validate() in xe_dma_buf_map(), so the importer, not the
> exporter, is charged for the allocation.
> 
> Call xe_bo_validate() at export time instead, so that the BO is moved
> into its preferred placement and the exporter is charged.

Is it maybe also worth mentioning somewhere the unreclaimable pages 
angle? I could be mistaken here, but I think that was maybe also the 
issue I saw in a workload. For example:

1. Create say 100G VRAM buffer. Use DEFERRED. This leaves lingering tt 
structure.

2. Validate it on native side. This is now resident in VRAM. But still 
has lingering tt.

3. Export it. This now populates 100G worth of TT pages due to lingering 
tt. But we now have a populated VRAM buffer which is also populated with 
100G TT pages. That 100G TT pages is not reclaimable and is hidden from 
shrinker since this still just looks like normal VRAM buffer.

> 
> Do the purgeable checks and the validation in the same
> xe_validation_guard() transaction, to avoid locking the BO twice.
> 
> The commit message and code was drafted using LLM.
> 
> Link: https://patchwork.freedesktop.org/patch/747480/?series=172524&rev=1
> Fixes: 91494dee1091 ("xe: populate buffers before exporting them.")
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: intel-xe@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v6.18+
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>

Reviewed-by: Matthew Auld <matthew.auld@intel.com>

> ---
>   drivers/gpu/drm/xe/xe_dma_buf.c | 76 +++++++++++++++++----------------
>   1 file changed, 39 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c b/drivers/gpu/drm/xe/xe_dma_buf.c
> index 5bf13dc4b61d..90c9b90de552 100644
> --- a/drivers/gpu/drm/xe/xe_dma_buf.c
> +++ b/drivers/gpu/drm/xe/xe_dma_buf.c
> @@ -263,60 +263,62 @@ struct drm_gem_object *xe_dma_buf_to_gem(struct drm_device *dev,
>   struct dma_buf *xe_gem_prime_export(struct drm_gem_object *obj, int flags)
>   {
>   	struct xe_bo *bo = gem_to_xe_bo(obj);
> +	struct xe_validation_ctx ctx;
> +	struct drm_exec exec;
>   	struct dma_buf *buf;
> -	struct ttm_operation_ctx ctx = {
> -		.interruptible = true,
> -		.no_wait_gpu = true,
> -		/* We opt to avoid OOM on system pages allocations */
> -		.gfp_retry_mayfail = true,
> -		.allow_res_evict = false,
> -	};
> -	int ret;
> +	int ret = 0;
>   
>   	if (bo->vm)
>   		return ERR_PTR(-EPERM);
>   
> -	/*
> -	 * Reject exporting purgeable BOs. DONTNEED BOs can be purged
> -	 * at any time, making the exported dma-buf unusable. Purged BOs
> -	 * have no backing store and are permanently invalid.
> -	 */
> -	ret = xe_bo_lock(bo, true);
> -	if (ret)
> -		return ERR_PTR(ret);
> +	xe_validation_guard(&ctx, &xe_bo_device(bo)->val, &exec,
> +			    (struct xe_val_flags) {.interruptible = true}, ret) {
> +		ret = drm_exec_lock_obj(&exec, &bo->ttm.base);
> +		drm_exec_retry_on_contention(&exec);
> +		if (ret)
> +			break;
>   
> -	if (xe_bo_madv_is_dontneed(bo)) {
> -		ret = -EBUSY;
> -		goto out_unlock;
> -	}
> +		/*
> +		 * Reject exporting purgeable BOs. DONTNEED BOs can be purged
> +		 * at any time, making the exported dma-buf unusable. Purged BOs
> +		 * have no backing store and are permanently invalid.
> +		 */
> +		if (xe_bo_madv_is_dontneed(bo)) {
> +			ret = -EBUSY;
> +			break;
> +		}
>   
> -	if (xe_bo_is_purged(bo)) {
> -		ret = -EINVAL;
> -		goto out_unlock;
> -	}
> +		if (xe_bo_is_purged(bo)) {
> +			ret = -EINVAL;
> +			break;
> +		}
>   
> -	xe_bo_willneed_get_locked(bo);
> -	xe_bo_unlock(bo);
> +		/*
> +		 * Make sure the BO is backed in its preferred placement so that
> +		 * the exporter, rather than the importer, is charged for the
> +		 * memory allocation.
> +		 */
> +		ret = xe_bo_validate(bo, NULL, false, &exec);
> +		drm_exec_retry_on_contention(&exec);
> +		xe_validation_retry_on_oom(&ctx, &ret);
> +		if (ret)
> +			break;
>   
> -	ret = ttm_bo_setup_export(&bo->ttm, &ctx);
> +		xe_bo_willneed_get_locked(bo);
> +	}
>   	if (ret)
> -		goto out_put;
> +		return ERR_PTR(ret);
>   
>   	buf = drm_gem_prime_export(obj, flags);
>   	if (IS_ERR(buf)) {
> -		ret = PTR_ERR(buf);
> -		goto out_put;
> +		xe_bo_lock(bo, false);
> +		xe_bo_willneed_put_locked(bo);
> +		xe_bo_unlock(bo);
> +		return buf;
>   	}
>   
>   	buf->ops = &xe_dmabuf_ops;
>   	return buf;
> -
> -out_put:
> -	xe_bo_lock(bo, false);
> -	xe_bo_willneed_put_locked(bo);
> -out_unlock:
> -	xe_bo_unlock(bo);
> -	return ERR_PTR(ret);
>   }
>   
>   static struct drm_gem_object *

