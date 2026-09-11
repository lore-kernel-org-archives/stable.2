Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68444570D1
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 08:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789114885; cv=none; b=nuxyIEimDP5gBFmcYN19B3X3e3hObhRjFT4anUNdK8SI/ymoEGTqNPdO+PSuScm939Z19JRo9u6znsD9e5D89O9uQJA51absQXSuU/KEXTNsMEN4RCH5ixTcUf7fd9VKv8umK2/k1DZN192uvPbPrTcwybjM7ZefHrkwOI3eov8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789114885; c=relaxed/simple;
	bh=zJtaryYqa/C9k3EO/Gny1L1VYdmh/q+o7VrPEjvE2I0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p7AucWiOrTh70r93adZLfvsbDVZlkbwfya5YJLROtnvzQWK3LoQqDRirjldW7oonfT0u3U7I7+yJZO2/iPNSNc+B6f3YxV05r040BVI+8gM4/n80VoKYQDaHJaVxwxPEI4QzfzDgoGt0tbSSkD6oCCpWHhMpjM0k/tvmNcni6oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=pp+QTHaW; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="pp+QTHaW"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64E5516A3
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 01:21:17 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E2AD43F7B4
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 01:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789114881; bh=zJtaryYqa/C9k3EO/Gny1L1VYdmh/q+o7VrPEjvE2I0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pp+QTHaW8CW2HKZ39WN8UYFBXvA2c5/WkKK8zD6qVz3K7zIiiPdgVahQnLsJHiagE
	 IV33OE3D8EYimdnpxfjufE6BCyqy921pL4JIj0fuTbzZD1vwFalxEJsUybg3kmdkGC
	 UfZqErE2YYzNEV0Bmt0VOZzSQRrrAWxMX7dUlDdM=
Date: Fri, 11 Sep 2026 09:20:56 +0100
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
Subject: Re: [PATCH v2 1/2] drm/panthor: Treat a zero-length VM_BIND op as a
 no-op
Message-ID: <aqO56GMt4i3bXqk6@e142607>
References: <20260902-drm-gpuvm-zerorange-v2-v2-0-da63269c6ec4@gmail.com>
 <20260902-drm-gpuvm-zerorange-v2-v2-1-da63269c6ec4@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260902-drm-gpuvm-zerorange-v2-v2-1-da63269c6ec4@gmail.com>

On Wed, Sep 02, 2026 at 08:28:42PM +0800, Zhenhao Wan wrote:
> panthor_vm_bind_exec_sync_op() short-circuits a zero-length operation: it
> returns 0 immediately when op->size is 0. The asynchronous VM_BIND path
> has no equivalent guard.
> 
> An async MAP or UNMAP with size == 0 is not rejected: only alignment is
> checked in panthor_vm_bind_prepare_op_ctx() and IS_ALIGNED(0) is true, so
> the op is queued and panthor_vm_exec_op() calls drm_gpuvm_sm_map() /
> drm_gpuvm_sm_unmap() with a zero range. A zero-length map into unmapped
> space then reaches drm_gpuva_insert(), where the GPUVA interval-tree last
> key addr + range - 1 underflows to addr - 1 and a malformed node whose end
> lies below its start can be inserted, corrupting the augmented interval
> tree.
> 
> Mirror the synchronous path and treat a zero-length map or unmap as a no-op
> in panthor_vm_exec_op(), before any lock is taken or the GPUVA tree is
> touched. This also keeps the async path robust if the core drm_gpuvm range
> validation is tightened to reject a zero range, which would otherwise make
> panthor_vm_bind_run_job() flag the VM unusable on the resulting -EINVAL.
> 
> Fixes: 647810ec2476 ("drm/panthor: Add the MMU/VM logical block")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Assisted-by: Claude:claude-opus-5
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/panthor/panthor_mmu.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index e592a8ebb478..93542f59cb5e 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -2591,6 +2591,15 @@ panthor_vm_exec_op(struct panthor_vm *vm, struct panthor_vm_op_ctx *op,
>  	if (op_type == DRM_PANTHOR_VM_BIND_OP_TYPE_SYNC_ONLY)
>  		return 0;
>  
> +	/*
> +	 * A zero-length map or unmap is a no-op. The synchronous bind path
> +	 * already short-circuits it in panthor_vm_bind_exec_sync_op(); mirror
> +	 * that here so an asynchronous zero-length op does not fail and flag the
> +	 * VM as unusable.
> +	 */
> +	if (!op->va.range)
> +		return 0;
> +
>  	mutex_lock(&vm->op_lock);
>  	vm->op_ctx = op;
>  
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
