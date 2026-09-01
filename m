Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064DB370AE5;
	Tue,  1 Sep 2026 08:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788251122; cv=none; b=Ou3ciDH2yVpYJ09pP33VkiSAqio6ZoJA45QRoW+T4GykTw4bv8QOy88m4zOIRb4JYsycMSo1xtIr2TsgBleMlT0boFv97CZljsH5zOUGAZ4YAFWbo076WVoOVziL7V94EI2z9z1itSszM3inq2djpfWoJ/NxX2YkMC3WuUuyv7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788251122; c=relaxed/simple;
	bh=iRZTdjP4a0nk+McE3IZXdnR6pSeTAkVaDrKHZcKX8xY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SLpJCchLBJdgtie1/ItYd6NsAewr4Gi2Vzv4+kayJO4oQ9Gg9013JrOU3PK0hquiKfD22Ypy4JyD+XMfzXur5gThw5w5/g4vWVfXJHqpvDSCZc6mVdu/pIGjflCJ275EbIScMM6F6ARxbuZQKMXHMzJ5tOT0MOKy6rArd8gRDBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MplQJzO9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MplQJzO9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE2F91F000E9;
	Tue,  1 Sep 2026 08:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788251120;
	bh=cwoiwAp4oLTxvCVw8zP4O4iMvSZjkBTBMfxJMXq0q0Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=MplQJzO9GXIGFKUoOSptRVi8mKjaWyFhrcH8xSJybcRgSuWsU0TEfFfgfpToHg+yM
	 vopzdEZHD1wQVuHEfaPM58r5DfLe1ry+aGpQZbuNbJHiKzJqPzqW+BaHjLA30rNcIE
	 g2fwmmNmE6Ezc8dIh0M2C6qsBFkUSj8mjiN65Y2LLbMgnsfb8tvoVo/1EvFGUPNFGJ
	 Vjxeex+yCRWRJ1qxijT4hjIHUODsD67MVZ6cX6K07/Y8vug0Ge7i298a3zRnuT0Dxr
	 YbSgWZZ4uEaI15ebien7/je/aVs42s4EPnLeK2thvO36Ob5QlLpSzDQOZmg+GHzioN
	 2J9c4ntQ7Nv8w==
Message-ID: <c8d6c58f-f9ff-4de5-96b2-b0ada727c51a@kernel.org>
Date: Tue, 1 Sep 2026 10:25:15 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/nouveau/uvmm: reject zero-length range in
 validate_range
To: Zhenhao Wan <whi4ed0g@gmail.com>
Cc: Lyude Paul <lyude@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dave Airlie <airlied@redhat.com>, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
References: <20260812-nouveau-uvmm-pt-fixes-v1-1-ab3a823f946e@gmail.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20260812-nouveau-uvmm-pt-fixes-v1-1-ab3a823f946e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/12/26 4:56 PM, Zhenhao Wan wrote:
> nouveau_uvmm_validate_range() rejects misaligned addresses and ranges and
> defers the remaining bounds check to drm_gpuvm_range_valid(), but neither
> rejects a zero range: 0 is page-aligned and addr + 0 does not overflow, so
> a zero-length VM_BIND request from userspace passes validation. It then
> reaches the generic GPUVA interval-tree insertion, where the node last key
> is computed as addr + range - 1. With range == 0 this underflows to
> addr - 1, producing an interval whose end lies below its start. The
> resulting malformed node corrupts the augmented interval tree and misleads
> the overlap checks of later map/unmap operations on the same VM.

Given this, why do you think drm_gpuvm_range_valid() intentionally leaves
the zero-range rejection to its callers? Why not fix this in GPUVM instead?

> drm_gpuvm_range_valid() intentionally leaves the zero-range rejection to
> its callers; drm/imagination does exactly this with an explicit "size != 0"
> test next to its drm_gpuvm_range_valid() call. nouveau simply omitted it.
> 
> Reject range == 0 alongside the existing alignment test.
> 
> Fixes: b88baab82871 ("drm/nouveau: implement new VM_BIND uAPI")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Assisted-by: Claude:claude-opus-5
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_uvmm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> index f5e4756b4de4..0efedd9ecc75 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> @@ -1008,7 +1008,7 @@ nouveau_uvmm_validate_range(struct nouveau_uvmm *uvmm, u64 addr, u64 range)
>  	if (addr & ~PAGE_MASK)
>  		return -EINVAL;
>  
> -	if (range & ~PAGE_MASK)
> +	if (!range || range & ~PAGE_MASK)
>  		return -EINVAL;
>  
>  	if (!drm_gpuvm_range_valid(&uvmm->base, addr, range))
> 
> ---
> base-commit: db2ddb87143519e20a95aa36c60b36107b736a58
> change-id: 20260812-nouveau-uvmm-pt-fixes-9706da1a03cf
> 
> Best regards,
> --  
> Zhenhao Wan <whi4ed0g@gmail.com>
> 

