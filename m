Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85543C0A02
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 08:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789115115; cv=none; b=YCbP11T2Tbx8cjAJFyuft40O/fvB70/bcUgQCDgccscsqb/UUkjdg1D275dIRAnJUex2ovsAMh2brfy6HwdWE983FKdAHhuGHpmTK5KSJUF8aIoO0kv8Z3IEx7bBqQTyiC1KyYVaO4MfOZH/4cDRbyX3Q6PIk744X162n0CCxYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789115115; c=relaxed/simple;
	bh=pg2xKrTSSwShkOsUdLdeGDqS93TawwwTnBwMiecesqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J0KebiJzO808uCIaADzLc1TVfUQPG+vUMagm8nqrv1kB+porje5awRU0RF7MLuBT+/wkusbsWAGKFusJb03vhbpJtl+9D8ttKm/KXKtnEkCJwAB0c2F5PCig3K+SVSbsFdKJIxQqK6MYp3+OaN5y0wKa4GJX4b95Wa8adSQhN18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=RO5kr237; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="RO5kr237"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C5A81570
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 01:25:09 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EBE8C3F7B4
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 01:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789115113; bh=pg2xKrTSSwShkOsUdLdeGDqS93TawwwTnBwMiecesqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RO5kr237pNsXdFqRTsKeb1Moa/tntoM+Bu9XNjMJAK4VYaNPseQV06SsTIbl4WQA5
	 4laB6FXWc7FmwcJ7Liv0MPeVbMHWJH9g1nvG2atAeesQfdQNoP8QnAyCQcYOZWaEZw
	 KI/hh+S1MFOKJTEeKCAwFUxhQOWAyDe7xqBwffPU=
Date: Fri, 11 Sep 2026 09:24:49 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Zhenhao Wan <whi4ed0g@gmail.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Grant Likely <grant.likely@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Danilo Krummrich <dakr@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Alice Ryhl <aliceryhl@google.com>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
	nouveau@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>,
	Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] drm/gpuvm: reject zero-length range in
 drm_gpuvm_range_valid()
Message-ID: <aqO60UtyI9WlN0fw@e142607>
References: <20260902-drm-gpuvm-zerorange-v2-v2-0-da63269c6ec4@gmail.com>
 <20260902-drm-gpuvm-zerorange-v2-v2-2-da63269c6ec4@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260902-drm-gpuvm-zerorange-v2-v2-2-da63269c6ec4@gmail.com>

On Wed, Sep 02, 2026 at 08:28:43PM +0800, Zhenhao Wan wrote:
> drm_gpuvm_range_valid() is the common gate every GPUVM map/unmap path
> funnels through: drm_gpuva_insert(), __drm_gpuvm_sm_map() and
> __drm_gpuvm_sm_unmap() all reject a request unless it passes. It checks
> for overflow, the managed-range bounds and kernel-node overlap, but it
> never rejects a zero-length range. A range of 0 is page-aligned and
> addr + 0 does not overflow, so a zero-length VM_BIND request from
> userspace passes validation.
> 
> The GPUVA interval tree derives a node's last key as addr + range - 1
> (GPUVA_LAST()). With range == 0 this underflows to addr - 1, producing
> an interval whose end lies below its start (and, for addr == 0, wraps to
> U64_MAX). __drm_gpuva_insert() then issues its overlap query with that
> inverted interval, so the -EEXIST guard matches nothing and a malformed
> zero-length node is inserted, corrupting the augmented interval tree's
> subtree-last invariant and misleading the overlap checks of later
> map/unmap operations on the same VM.
> 
> Because the shared helper's own kerneldoc promises to validate "the
> range" yet silently accepts range == 0, drivers have papered over this
> individually and inconsistently: imagination and xe reject a zero range
> at/near the ioctl boundary, while nouveau and msm do not. Fix it once at
> the common gate so every current and future caller is covered.
> 
> The only in-tree user that legitimately accepts a zero range,
> xe's DRM_XE_VM_BIND_OP_UNMAP_ALL, interprets it at its ioctl layer and
> never passes range == 0 into the GPUVM core, so it is unaffected. The
> in-core lookups drm_gpuva_find_prev()/drm_gpuva_find_next() pass
> range == 1 and are likewise unaffected.
> 
> Fixes: e6303f323b1a ("drm: manager to keep track of GPUs VA mappings")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Assisted-by: Claude:claude-opus-5
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/drm_gpuvm.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
> index c422c5af1f4b..b73ad6988171 100644
> --- a/drivers/gpu/drm/drm_gpuvm.c
> +++ b/drivers/gpu/drm/drm_gpuvm.c
> @@ -1021,7 +1021,8 @@ drm_gpuvm_in_kernel_node(struct drm_gpuvm *gpuvm, u64 addr, u64 range)
>   * @addr: the base address
>   * @range: the range starting from the base address
>   *
> - * Checks whether the range is within the GPUVM's managed boundaries.
> + * Checks whether the range is non-zero and within the GPUVM's managed
> + * boundaries.
>   *
>   * Returns: true for a valid range, false otherwise
>   */
> @@ -1029,7 +1030,8 @@ bool
>  drm_gpuvm_range_valid(struct drm_gpuvm *gpuvm,
>  		      u64 addr, u64 range)
>  {
> -	return !drm_gpuvm_check_overflow(addr, range) &&
> +	return range != 0 &&
> +	       !drm_gpuvm_check_overflow(addr, range) &&
>  	       drm_gpuvm_in_mm_range(gpuvm, addr, range) &&
>  	       !drm_gpuvm_in_kernel_node(gpuvm, addr, range);
>  }
> 
> -- 
> 2.34.1
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
