Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFCE39B4AD
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 08:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781078815; cv=none; b=h7xePf8e4y/d8vpeHnVthXUaXr1T2RjukSCj68fDuaEifcyif35XeEIvkU2DLgB4Hy2dgSjdjLrRLCKGNvQspytygEWk1GIVmWzXEkM8i3C294fcg15lbDDjtxTgq2az7YAJn1HxNeuilfjJDi/o8/pHGwVDJhCsGOqmVJ5GYDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781078815; c=relaxed/simple;
	bh=c61ZUQoJtB0rHTiFvqMpD3/N2ph5ckMa47xktcDV1zU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uoqTfZYQA8QBlAoBP4vTbo2IUdTzmZ3jdscNRcUYYdfGx7r/Q3gtrlfJfz4EXzjw8/DTAX5NUQz1krwvg3sxsFBfcFbtafwII2mxu004fWlO6wWrzhZyMer6ku7adNIP1V9f6UZgkoLcqCuOP7UfO0QeQqy16pKMMB8On7dt1YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=pass smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.b=gNZAl7kd; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ursulin.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.b="gNZAl7kd"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-68c19f1f3ceso10350997a12.2
        for <stable@vger.kernel.org>; Wed, 10 Jun 2026 01:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin.net; s=google; t=1781078812; x=1781683612; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tV8bVaCGg3y34HefJ73rptnGNh2U6CedJrnOiZid/gE=;
        b=gNZAl7kdYHVXQKI2SUUaAfKsc2Qya62zteulOsm80EoLh1HLPbkM+NMzJzcJ0HQWa+
         faBH9YdBngqC8nL9fqub/3OQedIxg/z/gtNF8En/NstXNW4wOeIbO1thwX4TyjmynaqG
         g56+2xEfw3py4rr0BP7WUZYBZ1NlzliWlpwclP5od/kf3uaSrmVj7i3WK1omZ/Ml+OA4
         lWNK4LoaCpnVpodITVfmRF0DANpCXnylTXkiF/pXT3b8S9BnzwLBpbuCV9F9jnJ55GMF
         Z4AKEmcv+aB8yr6wjGtdwBxCHGF7AKFAzh405JKvbXmMvv6KDxRGkS6HArOlTD2c9GGb
         N7fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781078812; x=1781683612;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tV8bVaCGg3y34HefJ73rptnGNh2U6CedJrnOiZid/gE=;
        b=Q+nOs5VdArkNhunvNY12EnJBCtg62bN2ZffL85DWzGCxfM0whQ2PXSqi62hoqHRYys
         YVi0HeA5bY9NtTIMyAMoT7+/znwDcNguZ3Dzs+Y7rtNUP9Hy3GOxjJ3pnjNHxsWXnhuA
         /7QSh9ovzb35yybL/M5xntT7+hnnAMwCLt2l5mFvZrE+6h1cOMZPNxSYdns6r86pHsCc
         cHojKasyLymEd1TMSpO1IiMhBQ4dUl1XV/Uaeu1R0R9NjPIO115lvqOFNC5/7EK9URrh
         t3lybRTqcWy1+iUUnESd7ZDUYmkUOGxvQP5GCHChSc1ZvBDZW6CsYnGeDQnZub3nj5Lk
         nrjQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Gd5aJfbkrDfgUDJlcnS3eMvNkAR4HNoPB14cp58PWsCdFZaB3uHnbly5wFD021M1yqg4A0ro=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIXz3r7fLnqnshFXfzdC+fsWGXFWvQepATdcS7gJ73FXFSksix
	LMgvg8VXl2KrBD/dJxsGuN1n4TxHGa4lf+/7aUhWAOvF9qAaZ4MtIaG0euhCgLa10+q/c3v4VWj
	/E2o6vhk=
X-Gm-Gg: Acq92OHNAhx+U1v0BE/ZnK/udJntZLyYs/Jl2P273jf8+gDwFO0xz4NzmGFYJhJH1pp
	rFiGflvD1YClDtVkQ3abMxTYyWkv6RxtEFcCb6WWqpLnn7xieut3BnxyX2z4JMXh0HjgUdl/eHg
	fSGtWWUSDYISHvNBevIvIgglmP1u9dC3w0drg14tG98y9UsN0s4BW4VXizbTY0d2UPy+S5a/BcF
	EMSrvWsDa7GP7Y2qEZ+9GinzgjkYH6Z+tbLGOmUvVm34BEv25ljLDeZKxZcaeKA7hMoReG4Z68J
	J4DE08ZCWyNzfZu/9WaiWV4g6cnN+L0BvZepgsOdMYQqVby40zTx4N7gFF5U0sCn/+F50FDJYZw
	7IUZ+h4h5HEOkqqYDQBrGhJs73THJ375XSqC59q9rvUR6jJ8wFMUzD+C6sbNXsCSw2EI9fI95Ad
	2TZQX0hBGu7To6VFa+1kdSmRU3tXU9Vs5qWlnkDaKJYDLZiTrPn2FbwJw=
X-Received: by 2002:a05:6402:d0d:b0:676:988e:8eb6 with SMTP id 4fb4d7f45d1cf-68fa5354446mr10490926a12.26.1781078812054;
        Wed, 10 Jun 2026 01:06:52 -0700 (PDT)
Received: from [192.168.0.116] ([90.240.106.137])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e6585154dsm9480292a12.15.2026.06.10.01.06.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 01:06:51 -0700 (PDT)
Message-ID: <9f827a2e-bb9a-4356-96d1-6b10d100695b@ursulin.net>
Date: Wed, 10 Jun 2026 09:06:50 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/i915/gem: Fix phys BO pread/pwrite with offset
To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Intel graphics driver community testing & development
 <intel-gfx@lists.freedesktop.org>
Cc: Direct Rendering Infrastructure - Development
 <dri-devel@lists.freedesktop.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, stable@vger.kernel.org,
 Simona Vetter <simona@ffwll.ch>, Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>
References: <20260610060314.26111-1-joonas.lahtinen@linux.intel.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260610060314.26111-1-joonas.lahtinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/06/2026 07:03, Joonas Lahtinen wrote:
> sg_page() returns struct page pointer not (void *) so the scaling
> of pread/pwrite is wrong for phys BO and wrong parts of BO would be
> accessed if non-zero offset is used.
> 
> Last impacted platform with overlay or cursor planes using phys
> mapping was Gen3/945G/Lakeport.
> 
> Reported-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Fixes: c6790dc22312 ("drm/i915: Wean off drm_pci_alloc/drm_pci_free")
> Cc: <stable@vger.kernel.org> # v4.5+
> Cc: Tvrtko Ursulin <tursulin@ursulin.net>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> ---
>   drivers/gpu/drm/i915/gem/i915_gem_phys.c | 19 +++++++++++++++----
>   1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_phys.c b/drivers/gpu/drm/i915/gem/i915_gem_phys.c
> index e375afbf458e..d53129eb5603 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_phys.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_phys.c
> @@ -18,6 +18,17 @@
>   #include "i915_gem_tiling.h"
>   #include "i915_scatterlist.h"
>   
> +/* Abuse scatterlist to store pointer instead of struct page. */
> +static inline void __set_phys_vaddr(struct scatterlist *sg, void *vaddr)
> +{
> +	sg_assign_page(sg, (struct page *)vaddr);
> +}
> +
> +static inline void *__get_phys_vaddr(struct scatterlist *sg)
> +{
> +	return (void *)sg_page(sg);
> +}
> +
>   static int i915_gem_object_get_pages_phys(struct drm_i915_gem_object *obj)
>   {
>   	struct address_space *mapping = obj->base.filp->f_mapping;
> @@ -58,7 +69,7 @@ static int i915_gem_object_get_pages_phys(struct drm_i915_gem_object *obj)
>   	sg->offset = 0;
>   	sg->length = obj->base.size;
>   
> -	sg_assign_page(sg, (struct page *)vaddr);
> +	__set_phys_vaddr(sg, vaddr);
>   	sg_dma_address(sg) = dma;
>   	sg_dma_len(sg) = obj->base.size;
>   
> @@ -99,7 +110,7 @@ i915_gem_object_put_pages_phys(struct drm_i915_gem_object *obj,
>   			       struct sg_table *pages)
>   {
>   	dma_addr_t dma = sg_dma_address(pages->sgl);
> -	void *vaddr = sg_page(pages->sgl);
> +	void *vaddr = __get_phys_vaddr(pages->sgl);
>   
>   	__i915_gem_object_release_shmem(obj, pages, false);
>   
> @@ -139,7 +150,7 @@ i915_gem_object_put_pages_phys(struct drm_i915_gem_object *obj,
>   int i915_gem_object_pwrite_phys(struct drm_i915_gem_object *obj,
>   				const struct drm_i915_gem_pwrite *args)
>   {
> -	void *vaddr = sg_page(obj->mm.pages->sgl) + args->offset;
> +	void *vaddr = __get_phys_vaddr(obj->mm.pages->sgl) + args->offset;
>   	char __user *user_data = u64_to_user_ptr(args->data_ptr);
>   	struct drm_i915_private *i915 = to_i915(obj->base.dev);
>   	int err;
> @@ -170,7 +181,7 @@ int i915_gem_object_pwrite_phys(struct drm_i915_gem_object *obj,
>   int i915_gem_object_pread_phys(struct drm_i915_gem_object *obj,
>   			       const struct drm_i915_gem_pread *args)
>   {
> -	void *vaddr = sg_page(obj->mm.pages->sgl) + args->offset;
> +	void *vaddr = __get_phys_vaddr(obj->mm.pages->sgl) + args->offset;
>   	char __user *user_data = u64_to_user_ptr(args->data_ptr);
>   	int err;
>   

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

