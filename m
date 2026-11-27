Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795796449;
	b=H6Vui0xFyxMkNstoAC0aPZfRgqa4YS3k3O4D0SOOCj1wTlMlxjaA9TRK0iCQMga2e/At
	 7+o5Kq0U4V1a+PjKEF5SG7QA84VaEdzkmotGHQ1wY80yCwDYtxXdrqcjp+o1tSEpZD7kS
	 2edG6jGH0NVf4kws01d+iK57jm5mir5sF9s2/khX7YOA4A3RA98hzWFk7ycbffK2NdIIl
	 oXgIzxRtWN9h0fYMU+81VQjgOAbu8g4JFFe/cSgN7fHCabZbrTXDFZ1JKXoBIDJY1w8cP
	 NTlloyqPaZSM5/+EaTEsAQr3TB6JE/GAIrrCyLMbSAiTZfWX8iA+8HSbE2KLZ7uf49w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795796449;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=K7pbcPEO9RAHcbUUDzVxbpJY0yDm0J0hZH2yEiq0dJg=;
	b=4WjjBBjZ9rHF/YC63S8Fp3EFe0KLB0W5zugtpa4RS/u5v5o4pkuVwp3DsN/q9zfRRLP1
	 eruX283vR8ZJGVBYXekAE5KaHa24NXUvdsAnfqgMcllKY+MIGmXOAd4k5SFZgMt+HodCn
	 r071hrbRT23z9pW5qZkjERvn+ZpCwWoCR4u+XrhDYTCPwUBBvOKuNhlxpZUuA8m16MFsg
	 MbhjOsEbZsdSmKKt/pZhzHCJNQ77o+cRb8MI9WfUEF+SKdmVbDj8DZXaHYQL0YZ/5PCSi
	 FN+CJQ5KDh6O95TTlfBvTasd1QQrguf04lCR3gLWyplW5sE/DK16GYy2/7WlcfQhMfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=CeiOKUj3;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9258D606A31E;
	Fri, 27 Nov 2026 16:20:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9258D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=CeiOKUj3
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D2C41570;
	Fri, 27 Nov 2026 08:20:44 -0800 (PST)
Received: from [10.0.129.128] (e122027.cambridge.arm.com [10.0.129.128])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E60123F632;
	Fri, 27 Nov 2026 08:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795796447; bh=YWYVJy6Zcj9T84QCaab6JYnUa5XB+sHSowf3FjvcGBM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CeiOKUj33P9EF1X+JNoBQhYtrJosCaT77qK+d0WZVUgKQm79E9K4QNYhMDqRs0pCE
	 LFfyZOHUVxsM6YfM/Q/0lyxyw0INTOo7YgBb/eAATimHahf1DvcGcMsCdjJdg64GWy
	 eQ6oyfgP0NxgCIK/Sh9UANOqD1az5Wfbl/zeRzxs=
Message-ID: <819cab19-0756-4ba2-806a-dbeb7c5c2474@arm.com>
Date: Fri, 27 Nov 2026 16:20:40 +0000
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
Subject: Re: [PATCH] drm/panthor: Don't access gpu_contexts of a destroyed
 heap pool
To: Jiwoo Kim <arpe1618@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>
Cc: Akash Goel <akash.goel@arm.com>, Karunika Choo <karunika.choo@arm.com>,
 Lukas Zapolskas <lukas.zapolskas@arm.com>,
 Chris Diamand <chris.diamand@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261113162648.110226253-1-arpe1618@gmail.com_quarantine>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20261113162648.110226253-1-arpe1618@gmail.com_quarantine>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/11/2026 16:26, Jiwoo Kim wrote:
> panthor_heap_grow() and panthor_heap_return_chunk() compute the heap
> context offset from pool->gpu_contexts before taking pool->lock.
> 
> The tiler OOM work holds references on the group, its VM and the heap
> pool when it calls these functions, but nothing stops
> panthor_vm_destroy() from destroying the pool in the meantime.
> panthor_heap_pool_destroy() frees the gpu_contexts BO under pool->lock
> and marks the pool as destroyed by clearing pool->vm, but leaves
> pool->gpu_contexts pointing to the freed BO. VM destruction doesn't
> wait for the work either: panthor_sched_prepare_for_vm_destruction()
> only flushes the scheduler tick work, and only when the VM is active,
> and evicting the group doesn't help, as group_unbind_locked() uses
> cancel_work(), which doesn't wait for a tiler OOM work that is already
> running. Such a work can then read the freed BO.
> 
> Take pool->lock before dereferencing pool->gpu_contexts, and return
> -EINVAL if the pool has been destroyed, as panthor_heap_create()
> already does.
> 
> The problem was found through AI-assisted source code review. The fix
> is compile-tested only and there is no reproducer, as I don't have
> Mali CSF hardware.

This does look plausible, and doesn't break my hardware ;) I'm not sure
how to actually test the described issue, so I haven't been able to test
that.

> Fixes: 9cca48fa4f89 ("drm/panthor: Add the heap logical block")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5-5

Note that the requirement to include "Assisted-by" for LLM patches was
dropped (and checkpatch now complains about these tags).

> Signed-off-by: Jiwoo Kim <arpe1618@gmail.com>

Reviewed-by: Steven Price <steven.price@arm.com>

Thanks,
Steve

> ---
> 
> Notes:
>     This conflicts trivially with Osama Abdelkader's pending "drm/panthor:
>     Fix race when retrieving the new chunk in panthor_heap_grow()", as both
>     change the local variables at the top of panthor_heap_grow(). I can
>     rebase on top of it if it lands first.
>     
>     While looking at this, I also noticed that panthor_heap_create() reads
>     pool->vm without pool->lock when allocating the initial chunks, in
>     panthor_alloc_heap_chunk(), so a concurrent VM destroy can make
>     panthor_kernel_bo_create() hit its drm_WARN_ON(!vm). That doesn't touch
>     freed memory and is left for a separate patch.
> 
>  drivers/gpu/drm/panthor/panthor_heap.c | 44 +++++++++++++++++++-------
>  1 file changed, 33 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_heap.c b/drivers/gpu/drm/panthor/panthor_heap.c
> index 99311abdf1..e55f7e648d 100644
> --- a/drivers/gpu/drm/panthor/panthor_heap.c
> +++ b/drivers/gpu/drm/panthor/panthor_heap.c
> @@ -90,7 +90,7 @@ struct panthor_heap_pool {
>  	/** @vm: VM this pool is bound to. */
>  	struct panthor_vm *vm;
>  
> -	/** @lock: Lock protecting access to @xa. */
> +	/** @lock: Lock protecting access to @xa, @vm and @gpu_contexts. */
>  	struct rw_semaphore lock;
>  
>  	/** @xa: Array storing panthor_heap objects. */
> @@ -371,16 +371,27 @@ int panthor_heap_return_chunk(struct panthor_heap_pool *pool,
>  			      u64 heap_gpu_va,
>  			      u64 chunk_gpu_va)
>  {
> -	u64 offset = heap_gpu_va - panthor_kernel_bo_gpuva(pool->gpu_contexts);
> -	u32 heap_id = (u32)offset / panthor_heap_ctx_stride(pool->ptdev);
>  	struct panthor_heap_chunk *chunk, *tmp, *removed = NULL;
>  	struct panthor_heap *heap;
> +	u32 heap_id;
> +	u64 offset;
>  	int ret;
>  
> -	if (offset > U32_MAX || heap_id >= MAX_HEAPS_PER_POOL)
> -		return -EINVAL;
> -
>  	down_read(&pool->lock);
> +
> +	/* The heap contexts are gone if the pool has been destroyed. */
> +	if (!pool->vm) {
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}
> +
> +	offset = heap_gpu_va - panthor_kernel_bo_gpuva(pool->gpu_contexts);
> +	heap_id = (u32)offset / panthor_heap_ctx_stride(pool->ptdev);
> +	if (offset > U32_MAX || heap_id >= MAX_HEAPS_PER_POOL) {
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}
> +
>  	heap = xa_load(&pool->xa, heap_id);
>  	if (!heap) {
>  		ret = -EINVAL;
> @@ -435,16 +446,27 @@ int panthor_heap_grow(struct panthor_heap_pool *pool,
>  		      u32 pending_frag_count,
>  		      u64 *new_chunk_gpu_va)
>  {
> -	u64 offset = heap_gpu_va - panthor_kernel_bo_gpuva(pool->gpu_contexts);
> -	u32 heap_id = (u32)offset / panthor_heap_ctx_stride(pool->ptdev);
>  	struct panthor_heap_chunk *chunk;
>  	struct panthor_heap *heap;
> +	u32 heap_id;
> +	u64 offset;
>  	int ret;
>  
> -	if (offset > U32_MAX || heap_id >= MAX_HEAPS_PER_POOL)
> -		return -EINVAL;
> -
>  	down_read(&pool->lock);
> +
> +	/* The heap contexts are gone if the pool has been destroyed. */
> +	if (!pool->vm) {
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}
> +
> +	offset = heap_gpu_va - panthor_kernel_bo_gpuva(pool->gpu_contexts);
> +	heap_id = (u32)offset / panthor_heap_ctx_stride(pool->ptdev);
> +	if (offset > U32_MAX || heap_id >= MAX_HEAPS_PER_POOL) {
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}
> +
>  	heap = xa_load(&pool->xa, heap_id);
>  	if (!heap) {
>  		ret = -EINVAL;
> 
> base-commit: bafda823590ddf7031ecb765d673572fae7ab44a

