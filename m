Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794820104;
	b=Mu2Mjmw9EPKmteWbOPvyM7A1elpcH1PqZtvDnhuC8hQDNOqca1f7+Pz3A+9Fjy6D738o
	 +jH7MDlyVG74ujMJElLjMsKrefJfy33zbwRrTlQcvXmUqypWykx8i0y2W+fF1qsj2m45Q
	 4heqh1I4EXGwOtHRpYx/lih0rfN0YZdFhHXrCzrAeXiTCLGObxzVzvMLqgPRTH3kWJF3e
	 au4M22wwyk7z2d5uh8TETFSgmhfCiwiSAPRVK4jmaTYI+DYpZYTo6kcyn3qXfpsSqDq3D
	 QgBscpwAcuAXus877XVpbD7IFzuHD4cC/Vi6UTnufx6DLCTB/5NOY523GnD4a3w8oJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794820104;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:In-Reply-To:References:Organization:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=ksbtNwdPlyrqr166ttgWc6YSauGVe8TWCdQcvqRjLSw=;
	b=aKXvyrcVxdGp83KnVfDUbuAdnB+0p/ZLFRQ7rxHaZPCQj8xMy00WdkmuIqiHlCMXa9j1
	 gUAsX1JyeCIeztbs5IAiKSlaDk3nsFJfxX2Y95v9dJgAWRTd3/jFTuGeaHlMGE0ubvvUP
	 8Vwk8+7OdLYwobteS37Klbe5jTaYUS6H4z1FyEc/UsGkA3BazY+8jBU6KlQWFUe2ITeoq
	 UT5DjQI641QtFsYjFuiyfdncL94sD3mtjmmcAPP/ffV6C3Pyj5By0Gj0LNj4KHw7Jj+1b
	 gdSsPnifWv+VkNFwzpyAxvVJCKTQSGggbjmxheUP2MGXJpKGYX3WHk0+EIN1W3MDvSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=WGl2yRam;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B855606A31C;
	Mon, 16 Nov 2026 09:08:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B855606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=WGl2yRam
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1794820095;
	bh=hlC/R4LOevWhkF5ng3EXC9EMhzSuGqmJWPWnFO26Gdo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WGl2yRamacQZJIk5APiBXv0PdsKUMDiMNmCn1L85IR9XTCIZy17e5YaVKtQW1//ya
	 xS13l21DFgqvuRA8gnphhi0fJnEC6lyAiqI9vvIZhxXAJ4LBCDpDQAC1OevNX4+inr
	 oLQbLZ/q45UqbJPFQcNDoDlTIczz9e87r/ZTQxhzViaTRpQlKZcVSccrvByxsXfAoR
	 VOo/l1ROMWfvvrEXKZImwH/tVoIw19NUGnU4uQeJVMErM5peATf7VD0cjF6J5cOqb5
	 V2o2rh6MGdAwVUjXWiuXdfguX6Q/9C2ZOiVsxyfg9GeVWba4uXrIXw6M6TKWeWR7af
	 JR4/p3wcqhdwQ==
Received: from fedora1.home (unknown [100.64.0.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BFA4817E0480;
	Mon, 16 Nov 2026 10:08:14 +0100 (CET)
Date: Mon, 16 Nov 2026 10:08:11 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Akash Goel <akash.goel@arm.com>, Karunika Choo <karunika.choo@arm.com>,
 Lukas Zapolskas <lukas.zapolskas@arm.com>, Chris Diamand
 <chris.diamand@arm.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Heiko Stuebner <heiko@sntech.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] drm/panthor: Fix race when retrieving the new chunk
 in panthor_heap_grow()
Message-ID: <20261116100811.3c0b48f3@fedora1.home>
In-Reply-To: <20261113204717.35195-1-osama.abdelkader@gmail.com>
References: <20261113110217.6c1513be@fedora1.home>
	<20261113204717.35195-1-osama.abdelkader@gmail.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Nov 2026 21:47:16 +0100
Osama Abdelkader <osama.abdelkader@gmail.com> wrote:

> panthor_heap_grow() allocates a new chunk with panthor_alloc_heap_chunk(),
> which adds the chunk at the head of heap->chunks under heap->lock, and
> then drops the lock. panthor_heap_grow() then assumes the head of the
> list is the chunk it just added, and reads its GPU VA through
> list_first_entry() without holding heap->lock.
> 
> panthor_heap_grow() and panthor_heap_return_chunk() only take pool->lock
> in read mode, and tiler OOM events of different groups are processed in
> parallel on the unbound heap_alloc_wq. If two groups use the same heap
> context, they can modify the chunk list concurrently:
> 
>   group A OOM work                     group B OOM work
>   alloc C_A, list_add()
>                                        alloc C_B, list_add()
>   list_first_entry() -> C_B
>                                        group scheduled out:
>                                        panthor_heap_return_chunk(C_B)
>                                          list_del(), destroy BO, kfree()
>   C_B->bo                              <- use-after-free
> 
> Even without the free, both groups end up being handed the same chunk,
> and the chunk allocated by group A is never linked to the heap context.
> 
> Fix this by having panthor_alloc_heap_chunk() return the GPU VA of the
> chunk it allocated, retrieved before the chunk is published in the list,
> instead of looking it up afterwards. Do the same for the initial chunks
> allocated by panthor_heap_create(), so the first chunk GPU VA is
> returned by panthor_alloc_heap_chunks() rather than retrieved from the
> list.
> 
> Fixes: 9cca48fa4f89 ("drm/panthor: Add the heap logical block")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5.5
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
> v2:
> - Always write chunk_gpu_va in panthor_alloc_heap_chunk().
> - Have panthor_alloc_heap_chunks() return the first chunk GPU VA, and drop
>   the list_first_entry() lookup in panthor_heap_create().
> 
>  drivers/gpu/drm/panthor/panthor_heap.c | 39 +++++++++++++++-----------
>  1 file changed, 23 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_heap.c b/drivers/gpu/drm/panthor/panthor_heap.c
> index 99311abdf1e9..febc18b43af8 100644
> --- a/drivers/gpu/drm/panthor/panthor_heap.c
> +++ b/drivers/gpu/drm/panthor/panthor_heap.c
> @@ -139,7 +139,8 @@ static void panthor_free_heap_chunk(struct panthor_heap_pool *pool,
>  
>  static int panthor_alloc_heap_chunk(struct panthor_heap_pool *pool,
>  				    struct panthor_heap *heap,
> -				    bool initial_chunk)
> +				    bool initial_chunk,
> +				    u64 *chunk_gpu_va)
>  {
>  	struct panthor_heap_chunk *chunk;
>  	struct panthor_heap_chunk_header *hdr;
> @@ -181,6 +182,14 @@ static int panthor_alloc_heap_chunk(struct panthor_heap_pool *pool,
>  
>  	panthor_kernel_bo_vunmap(chunk->bo);
>  
> +	/*
> +	 * Retrieve the GPU VA before the chunk becomes visible in the heap
> +	 * chunk list: once heap->lock is released, a concurrent grow or
> +	 * return_chunk on the same heap can modify the list, and the chunk
> +	 * can be freed.
> +	 */
> +	*chunk_gpu_va = panthor_kernel_bo_gpuva(chunk->bo);
> +
>  	mutex_lock(&heap->lock);
>  	list_add(&chunk->node, &heap->chunks);
>  	heap->chunk_count++;
> @@ -210,13 +219,19 @@ static void panthor_free_heap_chunks(struct panthor_heap_pool *pool,
>  
>  static int panthor_alloc_heap_chunks(struct panthor_heap_pool *pool,
>  				     struct panthor_heap *heap,
> -				     u32 chunk_count)
> +				     u32 chunk_count,
> +				     u64 *first_chunk_gpu_va)
>  {
>  	int ret;
>  	u32 i;
>  
> +	/*
> +	 * Chunks are inserted at the head of the list, so the last chunk
> +	 * allocated is the first chunk of the heap.
> +	 */
>  	for (i = 0; i < chunk_count; i++) {
> -		ret = panthor_alloc_heap_chunk(pool, heap, true);
> +		ret = panthor_alloc_heap_chunk(pool, heap, true,
> +					       first_chunk_gpu_va);
>  		if (ret)
>  			return ret;
>  	}
> @@ -280,7 +295,6 @@ int panthor_heap_create(struct panthor_heap_pool *pool,
>  			u64 *first_chunk_gpu_va)
>  {
>  	struct panthor_heap *heap;
> -	struct panthor_heap_chunk *first_chunk;
>  	struct panthor_vm *vm;
>  	int ret = 0;
>  	u32 id;
> @@ -315,15 +329,11 @@ int panthor_heap_create(struct panthor_heap_pool *pool,
>  	heap->max_chunks = max_chunks;
>  	heap->target_in_flight = target_in_flight;
>  
> -	ret = panthor_alloc_heap_chunks(pool, heap, initial_chunk_count);
> +	ret = panthor_alloc_heap_chunks(pool, heap, initial_chunk_count,
> +					first_chunk_gpu_va);
>  	if (ret)
>  		goto err_free_heap;
>  
> -	first_chunk = list_first_entry(&heap->chunks,
> -				       struct panthor_heap_chunk,
> -				       node);
> -	*first_chunk_gpu_va = panthor_kernel_bo_gpuva(first_chunk->bo);
> -
>  	down_write(&pool->lock);
>  	/* The pool has been destroyed, we can't create a new heap. */
>  	if (!pool->vm) {
> @@ -437,8 +447,8 @@ int panthor_heap_grow(struct panthor_heap_pool *pool,
>  {
>  	u64 offset = heap_gpu_va - panthor_kernel_bo_gpuva(pool->gpu_contexts);
>  	u32 heap_id = (u32)offset / panthor_heap_ctx_stride(pool->ptdev);
> -	struct panthor_heap_chunk *chunk;
>  	struct panthor_heap *heap;
> +	u64 chunk_gpu_va;
>  	int ret;
>  
>  	if (offset > U32_MAX || heap_id >= MAX_HEAPS_PER_POOL)
> @@ -473,14 +483,11 @@ int panthor_heap_grow(struct panthor_heap_pool *pool,
>  	 * further jobs in this queue fail immediately instead of having to
>  	 * wait for the job timeout.
>  	 */
> -	ret = panthor_alloc_heap_chunk(pool, heap, false);
> +	ret = panthor_alloc_heap_chunk(pool, heap, false, &chunk_gpu_va);
>  	if (ret)
>  		goto out_unlock;
>  
> -	chunk = list_first_entry(&heap->chunks,
> -				 struct panthor_heap_chunk,
> -				 node);
> -	*new_chunk_gpu_va = (panthor_kernel_bo_gpuva(chunk->bo) & GENMASK_ULL(63, 12)) |
> +	*new_chunk_gpu_va = (chunk_gpu_va & GENMASK_ULL(63, 12)) |
>  			    (heap->chunk_size >> 12);
>  	ret = 0;
>  

