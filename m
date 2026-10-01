Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9168E3F3270
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 17:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790875582; cv=none; b=hRosS/R9RPzRGtNjjgN6dGAapHqmE2OexAmhjrD3vfXEPy6M9ufVrFAI3tpDQJe9Pjxw1UN6lM2MHEio+W1j1m2iDlYr1vRoGV5rDTfbKdf2DAdlNjdDAVc7cE2aj+68V4Anmltz6osvRP4vsm+QcE7bhvK5B4hgzlQtpQ0tvyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790875582; c=relaxed/simple;
	bh=3CrZ/HlhKliCDcDqgRVMsehyr4B+MR7C/5hFdyPH+KQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=LkqIWdjgK6sj8sytVj6zshC70t0FsBWXe3yKFsez6LX63hiIWag1bwhtwFJ3GLVwLc/+F8SCewv9jdeOWf2N58ahgCTRrPcaAIS3FlgDtnvIHumr141Q6iQUOqrmpBLQpmPAa9Qg1LB/avF96fS56thTnEQi9Fz5c0NZgAbABPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YFFcHUu2; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YFFcHUu2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790875580; x=1822411580;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=3CrZ/HlhKliCDcDqgRVMsehyr4B+MR7C/5hFdyPH+KQ=;
  b=YFFcHUu2n+3CqQEkpGLBzWssEDcEOemoRNKaA9JB7X5ku/3s1gMbS2C0
   fBc4rkoqmk+uXEUxxLqQuOGiNs1Vv+4+h6fZeFoHLQmdva8/9zDu3Vk4z
   GO4U/MGh1vHpPVaqp5elA6GdlJijPTAgmV37xMZq55+XDllZUihPs6dJc
   lFjgvzFoZsB8Nj9WaoB7P1uM2dn6zgfTfBVs9aQb0/TqxjSr5QGHIk1r0
   6M7bKCfh/IEBwJYVlYFvOAcoqzPkMVs6N9tv5rQf0nR8FtCe4AV/3TAUB
   kC2+IgLSw3+iaRHBhm/BP4zJw7UiPqCc3WcFjrxaO4qG6sqrITsMir3sr
   A==;
X-CSE-ConnectionGUID: z2TyJSGXSOKGsZY3508z9Q==
X-CSE-MsgGUID: biawm7xtTZuN/i/CnEkhvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="101803191"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="101803191"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 10:26:20 -0700
X-CSE-ConnectionGUID: 7R0z+iOgTyCVThgH8jI8aw==
X-CSE-MsgGUID: 4lCuQaZNROCKSkJ7n5gc6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="276107101"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO [10.245.244.54]) ([10.245.244.54])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 10:26:18 -0700
Message-ID: <a0ded4eb-98e3-4142-b2c5-3dc55d9687d1@intel.com>
Date: Thu, 1 Oct 2026 18:26:15 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Matthew Auld <matthew.auld@intel.com>
Subject: Re: [PATCH v2 2/2] drm/xe: Fix stale pinned_link entry when fb-pin
 performs the final unpin
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, stable@vger.kernel.org,
 Matthew Brost <matthew.brost@intel.com>
References: <20261001134018.111553-1-thomas.hellstrom@linux.intel.com>
 <20261001134018.111553-3-thomas.hellstrom@linux.intel.com>
Content-Language: en-GB
In-Reply-To: <20261001134018.111553-3-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01/10/2026 14:40, Thomas Hellström wrote:
> xe_bo_pin_external() and xe_bo_unpin_external() maintain the bo's
> pinned_link list membership in xe->pinned.late.external, based on
> whether the current call is the outermost pin or the final unpin.
> However, the same external bo's pin_count can also be raised and
> lowered directly by __xe_pin_fb_vma()/__xe_unpin_fb_vma(), which pin
> the bo as a display scanout buffer without going through
> xe_bo_pin_external()/xe_bo_unpin_external() at all, and have no
> notion of, or ownership over, pinned_link.
> 
> If a bo is pinned both externally (e.g. dma-buf export) and as an fb,
> and the external unpin happens first, xe_bo_unpin_external() correctly
> observes pin_count > 1 and leaves the bo on pinned_link. When the fb
> unpin later performs the true last unpin (pin_count 1 -> 0), it never
> touches pinned_link, leaving the bo linked on xe->pinned.late.external
> indefinitely. Once the bo is subsequently freed, this stale list entry
> points into freed memory, corrupting the list and risking a
> use-after-free the next time the list is walked or spliced.
> 
> The backup object pin/unpin sites in xe_bo_notifier_prepare_pinned()/
> xe_bo_notifier_unprepare_pinned() have the same bypass characteristic,
> though they never add their bo to a pinned list, so are not affected
> by this particular list-corruption issue.
> 
> Move the pinned_link removal into xe_bo_account_unpin(), which already
> runs on every unpin path (kernel, external, framebuffer, backup
> object) right before the true 1 -> 0 pin_count transition. Since
> list_del_init() only operates on the node itself, this removal is
> list-agnostic and safe to perform regardless of which list (external
> or kernel_bo_present) the bo happens to be linked on, or which code
> path is performing the final unpin. Drop the now-redundant explicit
> list_del_init() calls in xe_bo_unpin_external() and xe_bo_unpin().

I think you can also use this idea to bypass the p2p checking? Create a 
VRAM + TT buffer, turn it into an fb and use it for scanout. While fb 
pinned you dma-buf export/import + map it (dynamic). AFAICT you can 
trick xe_dma_buf_map() since this buffer looks like you can migrate it 
(dual placement) but since already fb pinned this will make it skip the 
actual migrate/validate, so it falls through to mapping the VRAM using 
the pci address. However, this could be on a system that lacks p2p 
support. Don't see what prevents that?

> 
> Fixes: 44e694958b95 ("drm/xe/display: Implement display support")
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: intel-xe@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v6.8+
> Assisted-by: LLM
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> 
> v2:
> - New patch
> ---
>   drivers/gpu/drm/xe/xe_bo.c | 25 ++++++++++++++++---------
>   1 file changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> index 2fbbba7cf4b0..581bfded21db 100644
> --- a/drivers/gpu/drm/xe/xe_bo.c
> +++ b/drivers/gpu/drm/xe/xe_bo.c
> @@ -487,12 +487,27 @@ static void xe_bo_account_pin(struct xe_bo *bo)
>    * held, before &ttm_buffer_object.pin_count is decremented by
>    * ttm_bo_unpin(), so that the check against the true 1->0 transition sees
>    * the pin count that is about to be released.
> + *
> + * On the true last unpin, also removes @bo from whichever pinned-bo list
> + * (external or kernel_bo_present) it may currently be linked on, since a
> + * bo's final unpin can happen through a pin path (e.g. framebuffer,
> + * backup object) that has no notion of, or ownership over, that list.
> + * This is safe and list-agnostic: list_del_init() only needs the node
> + * itself, not knowledge of which list it is threaded through, and is a
> + * no-op if @bo is not linked.
>    */
>   static void xe_bo_account_unpin(struct xe_bo *bo)
>   {
>   	struct xe_device *xe = xe_bo_device(bo);
> +	bool last_unpin = bo->ttm.pin_count == 1;
>   
> -	if (bo->ttm.pin_count == 1 && bo->ttm.ttm && ttm_tt_is_populated(bo->ttm.ttm))
> +	if (last_unpin && !list_empty(&bo->pinned_link)) {
> +		spin_lock(&xe->pinned.lock);
> +		list_del_init(&bo->pinned_link);
> +		spin_unlock(&xe->pinned.lock);
> +	}
> +
> +	if (last_unpin && bo->ttm.ttm && ttm_tt_is_populated(bo->ttm.ttm))
>   		xe_ttm_tt_account_add(xe, bo->ttm.ttm);
>   }
>   
> @@ -3311,11 +3326,6 @@ void xe_bo_unpin_external(struct xe_bo *bo)
>   	xe_assert(xe, xe_bo_is_pinned(bo));
>   	xe_assert(xe, xe_bo_is_user(bo));
>   
> -	spin_lock(&xe->pinned.lock);
> -	if (bo->ttm.pin_count == 1 && !list_empty(&bo->pinned_link))
> -		list_del_init(&bo->pinned_link);
> -	spin_unlock(&xe->pinned.lock);
> -
>   	xe_bo_unpin_account(bo);
>   
>   	/*
> @@ -3337,10 +3347,7 @@ void xe_bo_unpin(struct xe_bo *bo)
>   	xe_assert(xe, xe_bo_is_pinned(bo));
>   
>   	if (mem_type_is_vram(place->mem_type) || bo->flags & XE_BO_FLAG_GGTT) {
> -		spin_lock(&xe->pinned.lock);
>   		xe_assert(xe, !list_empty(&bo->pinned_link));
> -		list_del_init(&bo->pinned_link);
> -		spin_unlock(&xe->pinned.lock);
>   
>   		if (bo->backup_obj) {
>   			if (xe_bo_is_pinned(bo->backup_obj))

