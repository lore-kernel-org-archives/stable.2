Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564143;
	b=EeiYLg6HK+8hdyUgusVE3CeMza9ln9f8F39G0pDwrS7D+bMai92/MhHbHBXXh0TujXg+
	 g4rw8PeVXDGCFDdArwKltAMyMppt/p7O7Jeuq9d3KQjYxSryv9Z0KrC1iPlAhREmtq8Po
	 hT3+whK08kTj0PIAyAzElXTn1zp4gGckSl8hhF4drR6gj90bYD1dh4avKCFkjnY78gf+A
	 5hT0X92IIAnYU+byB4FQI1ffPswX+bQ0lPkyAncjGGhvtHrdgGK3WpbFOQKRJNA58/9jR
	 eNZO62X+5pguMaLXp/oDP0fjwfAVM2MaYCx6KIu4RyydRQihe2x8o0PLVCav2TEACZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564143;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:In-Reply-To:References:Organization:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=Fbe4pygIbMaWI9S1f5XjkFJyOwzCJ2fvroyAbvF8+6o=;
	b=L3CbJ1LN17tojivKBf5A1PYgrwHClIXt4mU/7JNX1P7gb48L/VCuxbxP5/HQrua9Mvt4
	 03xV20fK5/8yP0P0bX337KEg4yus5yC+HrVLj9lX+fWRJIx4/0z/R1FyB9QWROADjkWCY
	 juBvbi9zz1NAsIcuq6D5oqTDjlQtgt2n7w6T/KGf4szuMy2FmdtyQVeS/oG8myvlx2xgq
	 f8sxqrHQe6QvLdKw1C9mV0wVgLahyPY1TadxgQBWcoxkLITCVmgXC4APsCvC2qJ1Ns7M2
	 MavicM/Cnip+u0K4TWqhFJZJdPELhVrJOLMdqy8JhP0HF/CG7M2ubUbcwesKIsW+WDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=jZic3ilP;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3271606A8AC;
	Fri, 13 Nov 2026 10:02:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3271606A8AC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=jZic3ilP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1794564140;
	bh=X1jLNoDnjVgubMenvrcefOxSRaNk8escCylD62v2PbU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jZic3ilPtAE7ff/SF1XrbewKiLagOOuvHNJs+2SHa7/LBcokuCDwPex7rbv6pXr8d
	 gk356trxUyyGPqFPgbvIpc0Qj2x0k1A2wEcIPt94Cbeztmriquyvmcsp/Yfqeb5qsQ
	 KJAYRNTvDkXwLLBxpSuZUyraF+qKwXRfxeTgIqJXhckEIt7/h4nnyRFIFCoFtIs1Qj
	 mko06yp2b7iRT1IjEo2AwxDEkdrABhFM5NcVh0ykjSF/sRk1dNBSg/WpYSKndxvVRX
	 inaIxEMRt/yRHhm4nTmexgPjjvqoxu4wohGFyb5HiICNLIZ8uB01UmQ5M0Q8archyW
	 T/47QOroubjzw==
Received: from fedora1.home (unknown [100.64.0.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5113417E09C6;
	Fri, 13 Nov 2026 11:02:20 +0100 (CET)
Date: Fri, 13 Nov 2026 11:02:17 +0100
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
Subject: Re: [PATCH] drm/panthor: Fix race when retrieving the new chunk in
 panthor_heap_grow()
Message-ID: <20261113110217.6c1513be@fedora1.home>
In-Reply-To: <20261112191650.735850-1-osama.abdelkader@gmail.com>
References: <20261112191650.735850-1-osama.abdelkader@gmail.com>
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

Hello Osama,

On Thu, 12 Nov 2026 20:16:50 +0100
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
> instead of looking it up afterwards.
> 
> Fixes: 9cca48fa4f89 ("drm/panthor: Add the heap logical block")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5.5
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> ---
>  drivers/gpu/drm/panthor/panthor_heap.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_heap.c b/drivers/gpu/drm/panthor/panthor_heap.c
> index 99311abdf1e9..d80f514366fd 100644
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
> @@ -181,6 +182,15 @@ static int panthor_alloc_heap_chunk(struct panthor_heap_pool *pool,
>  
>  	panthor_kernel_bo_vunmap(chunk->bo);
>  
> +	/*
> +	 * Retrieve the GPU VA before the chunk becomes visible in the heap
> +	 * chunk list: once heap->lock is released, a concurrent grow or
> +	 * return_chunk on the same heap can modify the list, and the chunk
> +	 * can be freed.
> +	 */
> +	if (chunk_gpu_va)
> +		*chunk_gpu_va = panthor_kernel_bo_gpuva(chunk->bo);

Let's make this unconditional and force the user to pass a non-NULL
chunk_gpu_va.

> +
>  	mutex_lock(&heap->lock);
>  	list_add(&chunk->node, &heap->chunks);
>  	heap->chunk_count++;
> @@ -216,7 +226,7 @@ static int panthor_alloc_heap_chunks(struct panthor_heap_pool *pool,

Let's have panthor_alloc_heap_chunks() retrieve the first chunk GPU VA
to simplify panthor_heap_create(). The first_chunk_gpu_va pointer can
be passed directly to panthor_alloc_heap_chunk().

The rest looks good to me.

Thanks,

Boris
