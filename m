Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793715772;
	b=Kw6yGMelyhP5ByrK+QMDVi2OH3fpE95c0o9onXrz6kzU22eifa38atHqexCVbcpPq13Y
	 nXgbzKSTdzZdMGvoxOru3kr/OA9D2SUMqGSDKAB1+OhNiZpx7X3zHZuoVZG41oL+EGCZF
	 jDThtwXBTPZ3MQASmcDZszNlDYUldVzphgnHhladDprWUvr5q+yuThq4Q7Z8FE9nL0gLC
	 l0AzhiyMdC2/r1fM2DY50WKz+0TFqrkYNeE172DRXFZuRAPxezIKuU8RtkqKH8behQfTo
	 lxZrHyml5dYCCmqJk3XeIQ5xYGUHKDTPpOwAmeFAefX0BNUVt3fAe26bjHAC/L3gR5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793715772;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=GqYHkur/ntp085W8s4UyCE7YVL8SUrXvMOVsiCCmUi4=;
	b=NsYIBMszn81+hab+FRlvB1pBiKK6X0VlIbzg4iPnKYc3CaxCkJd7R/Fztrdu16QoM/Ds
	 VkPQknej+nKPUsYreRorNbtZXX5e9kV3WPU0/8QTvGL5mxC2+qXTKWhL0zFRaNchpgHw2
	 FUmqCBRFauPenIfb+5fIuZz/06lSkfWyzVop7uW5/M/er0hsv/fDQo68q0KsLcMXcpiyO
	 upRy8ulGA8joyMEyf1n79LIZWL7oEjAwAJ32Eio+pAsl0zCUSD+HwHtwClv9cmM6QPA0/
	 ibk/ENU+EGeNrWLu/gRfUUuszAykrEwppcDKRMn8mEB7DGpSOsJQQragw8J2ITD8qUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L0xJJk5x;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C0E606D812;
	Tue,  3 Nov 2026 14:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L0xJJk5x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D73331F000C1;
	Tue,  3 Nov 2026 14:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793715771;
	bh=GqYHkur/ntp085W8s4UyCE7YVL8SUrXvMOVsiCCmUi4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=L0xJJk5xn8l1cLP+iYOxqlpSbl6P8uA+c8jUjadZrqEwcIIGFRmleQRKnpzMf4duP
	 4SG7oV8zq2duN5JSkFOo/zFscq0b4v2qiGSx7AaKHomr8mY9LkakgUtN2kzdPysHp3
	 fMeIgcPR9/g3JYQsoBGMe74/jqSrR4j1FuIPmC0Z/eaiAn2N/1CQXNe+gCCP6faH8M
	 8EZd7pC4xvwJwI6/eEczNylUjaMLpBT/UYzrRNMrMbtuStE5nGfP8LdAhd+5yyFxKF
	 wsYTlGRLZvF56mvkWFBNATpCV97Pfqlz7ugbbfb4X+nan3HdmLDgFTJXHZQZ3SdsJs
	 XdBs9ouf3obNg==
Message-ID: <a14ed90f-6aa6-4daf-97ec-880b210d4d04@kernel.org>
Date: Tue, 3 Nov 2026 15:22:48 +0100
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
Subject: Re: [PATCH v2 1/2] media: videobuf2: publish buffers in bufs_bitmap
 under mmap_lock
To: Ricardo Ribalda <ribalda@chromium.org>, Tomasz Figa <tfiga@chromium.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Hans Verkuil <hverkuil@kernel.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261103-vb2-mmap_lock-v2-0-054e11dcd013@chromium.org>
 <20261103-vb2-mmap_lock-v2-1-054e11dcd013@chromium.org>
From: Hans Verkuil <hverkuil+cisco@kernel.org>
Content-Language: en-US
In-Reply-To: <20261103-vb2-mmap_lock-v2-1-054e11dcd013@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ricardo,

On 11/3/26 11:56, Ricardo Ribalda wrote:
> vb2_mmap() only takes q->mmap_lock, not the main queue lock (q->lock).
> To keep vb2_mmap() safe, newly allocated buffers must not become visible
> in vb2_get_buffer() until they are fully initialized and q->mmap_lock is
> held.
> 
> Commit a286b0837e13 ("media: core: Add bitmap manage bufs array entries")
> started setting q->bufs_bitmap inside __vb2_queue_alloc() before buffer
> memory is allocated and without holding q->mmap_lock. As a result:
> 
> - A concurrent mmap() can find a half-initialized buffer, and if buffer
>   allocation or .buf_init() fails, __vb2_queue_alloc() frees that buffer
>   without holding q->mmap_lock, causing a use-after-free in vb2_mmap().
> - If fewer buffers are allocated than requested, they are already
>   counted as active in q->bufs_bitmap before .queue_setup() checks
>   whether the smaller count is acceptable.
> 
> Fix this by keeping new buffers only in q->bufs[] during allocation and
> setting their bits in q->bufs_bitmap under q->mmap_lock once allocation
> and .queue_setup() succeed, and let __vb2_queue_free() read q->bufs[]
> directly when cleaning up unexposed buffers.
> 

Thank you for making the change, it much easier to follow now.

Marek, Tomasz, can one (or both) of you review this patch as well?

I think this can go to the fixes branch. Patch 2/2 needs more discussion and
is something for the next branch.

Regards,

	Hans

> Fixes: a286b0837e13 ("media: core: Add bitmap manage bufs array entries")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/common/videobuf2/videobuf2-core.c | 66 +++++++++++++++++++++----
>  include/media/videobuf2-core.h                  |  8 +--
>  2 files changed, 61 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
> index b0a6084f1757..70ef38c3d16a 100644
> --- a/drivers/media/common/videobuf2/videobuf2-core.c
> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> @@ -431,6 +431,9 @@ static void init_buffer_cache_hints(struct vb2_queue *q, struct vb2_buffer *vb)
>   * @q:	pointer to &struct vb2_queue with videobuf2 queue.
>   * @vb:	pointer to &struct vb2_buffer to be added to the queue.
>   * @index: index where add vb2_buffer in the queue
> + *
> + * The buffer is stored in @q->bufs[] but remains invisible to vb2_get_buffer()
> + * until published with vb2_queue_publish_buffers().
>   */
>  static void vb2_queue_add_buffer(struct vb2_queue *q, struct vb2_buffer *vb, unsigned int index)
>  {
> @@ -439,7 +442,31 @@ static void vb2_queue_add_buffer(struct vb2_queue *q, struct vb2_buffer *vb, uns
>  	q->bufs[index] = vb;
>  	vb->index = index;
>  	vb->vb2_queue = q;
> -	set_bit(index, q->bufs_bitmap);
> +}
> +
> +/**
> + * vb2_queue_publish_buffers() - publish buffers staged by __vb2_queue_alloc()
> + * @q:		pointer to &struct vb2_queue with videobuf2 queue.
> + * @start:	index of the first buffer to publish.
> + * @count:	number of buffers to publish.
> + *
> + * Set the @q->bufs_bitmap bits of the @count fully initialized buffers that
> + * __vb2_queue_alloc() stored in @q->bufs[] starting at @start, which makes
> + * them visible to vb2_get_buffer().
> + */
> +static void vb2_queue_publish_buffers(struct vb2_queue *q, unsigned int start,
> +				      unsigned int count)
> +{
> +	unsigned int i;
> +
> +	lockdep_assert_held(&q->mmap_lock);
> +
> +	for (i = start; i < start + count; i++) {
> +		if (WARN_ON(i >= q->max_num_buffers || !q->bufs[i] ||
> +			    test_bit(i, q->bufs_bitmap)))
> +			continue;
> +		set_bit(i, q->bufs_bitmap);
> +	}
>  }
>  
>  /**
> @@ -460,6 +487,11 @@ static void vb2_queue_remove_buffer(struct vb2_buffer *vb)
>   * @first_index: index of the first created buffer, all newly allocated buffers
>   *		 have indices in the range [first_index..first_index+count-1]
>   *
> + * The allocated buffers are stored in q->bufs[] but not published in
> + * q->bufs_bitmap: the caller must either publish them with
> + * vb2_queue_publish_buffers() or free them with __vb2_queue_free(), both under
> + * q->mmap_lock.
> + *
>   * Returns the number of buffers successfully allocated.
>   */
>  static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
> @@ -562,7 +594,8 @@ static void __vb2_free_mem(struct vb2_queue *q, unsigned int start, unsigned int
>  	struct vb2_buffer *vb;
>  
>  	for (i = start; i < start + count; i++) {
> -		vb = vb2_get_buffer(q, i);
> +		/* See __vb2_queue_free() for why vb2_get_buffer() isn't used */
> +		vb = q->bufs[i];
>  		if (!vb)
>  			continue;
>  
> @@ -580,6 +613,11 @@ static void __vb2_free_mem(struct vb2_queue *q, unsigned int start, unsigned int
>   * __vb2_queue_free() - free @count buffers from @start index of the queue - video memory and
>   * related information, if no buffers are left return the queue to an
>   * uninitialized state. Might be called even if the queue has already been freed.
> + *
> + * Buffers are looked up directly in q->bufs[] instead of through
> + * vb2_get_buffer() so that buffers staged by __vb2_queue_alloc() that were
> + * never published in q->bufs_bitmap (because a later .queue_setup() call
> + * rejected the allocated number of buffers) are freed as well.
>   */
>  static void __vb2_queue_free(struct vb2_queue *q, unsigned int start, unsigned int count)
>  {
> @@ -587,9 +625,13 @@ static void __vb2_queue_free(struct vb2_queue *q, unsigned int start, unsigned i
>  
>  	lockdep_assert_held(&q->mmap_lock);
>  
> +	/* q->bufs is NULL until vb2_core_allocated_buffers_storage() runs */
> +	if (!q->bufs)
> +		return;
> +
>  	/* Call driver-provided cleanup function for each buffer, if provided */
>  	for (i = start; i < start + count; i++) {
> -		struct vb2_buffer *vb = vb2_get_buffer(q, i);
> +		struct vb2_buffer *vb = q->bufs[i];
>  
>  		if (vb && vb->planes[0].mem_priv)
>  			call_void_vb_qop(vb, buf_cleanup, vb);
> @@ -624,7 +666,7 @@ static void __vb2_queue_free(struct vb2_queue *q, unsigned int start, unsigned i
>  		q->cnt_unprepare_streaming = 0;
>  	}
>  	for (i = start; i < start + count; i++) {
> -		struct vb2_buffer *vb = vb2_get_buffer(q, i);
> +		struct vb2_buffer *vb = q->bufs[i];
>  		bool unbalanced;
>  
>  		if (!vb)
> @@ -676,7 +718,7 @@ static void __vb2_queue_free(struct vb2_queue *q, unsigned int start, unsigned i
>  
>  	/* Free vb2 buffers */
>  	for (i = start; i < start + count; i++) {
> -		struct vb2_buffer *vb = vb2_get_buffer(q, i);
> +		struct vb2_buffer *vb = q->bufs[i];
>  
>  		if (!vb)
>  			continue;
> @@ -1000,14 +1042,16 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
>  
>  	if (ret < 0) {
>  		/*
> -		 * Note: __vb2_queue_free() will subtract 'allocated_buffers'
> -		 * from already queued buffers and it will reset q->memory to
> +		 * Note: the buffers allocated by __vb2_queue_alloc() were never
> +		 * published in q->bufs_bitmap, __vb2_queue_free() frees them
> +		 * straight from q->bufs[] and resets q->memory to
>  		 * VB2_MEMORY_UNKNOWN.
>  		 */
>  		__vb2_queue_free(q, first_index, allocated_buffers);
>  		mutex_unlock(&q->mmap_lock);
>  		return ret;
>  	}
> +	vb2_queue_publish_buffers(q, first_index, allocated_buffers);
>  	mutex_unlock(&q->mmap_lock);
>  
>  	/*
> @@ -1125,14 +1169,16 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
>  
>  	if (ret < 0) {
>  		/*
> -		 * Note: __vb2_queue_free() will subtract 'allocated_buffers'
> -		 * from already queued buffers and it will reset q->memory to
> -		 * VB2_MEMORY_UNKNOWN.
> +		 * Note: the buffers allocated by __vb2_queue_alloc() were never
> +		 * published in q->bufs_bitmap, __vb2_queue_free() frees them
> +		 * straight from q->bufs[] and resets q->memory to
> +		 * VB2_MEMORY_UNKNOWN if no buffers are left.
>  		 */
>  		__vb2_queue_free(q, *first_index, allocated_buffers);
>  		mutex_unlock(&q->mmap_lock);
>  		return -ENOMEM;
>  	}
> +	vb2_queue_publish_buffers(q, *first_index, allocated_buffers);
>  	mutex_unlock(&q->mmap_lock);
>  
>  	/*
> diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
> index 4b4f4c15c53a..2e93e6985d5f 100644
> --- a/include/media/videobuf2-core.h
> +++ b/include/media/videobuf2-core.h
> @@ -564,9 +564,11 @@ struct vb2_buf_ops {
>   * @mmap_lock:	private mutex used when buffers are allocated/freed/mmapped
>   * @memory:	current memory type used
>   * @dma_dir:	DMA mapping direction.
> - * @bufs:	videobuf2 buffer structures. If it is non-NULL then
> - *		bufs_bitmap is also non-NULL.
> - * @bufs_bitmap: bitmap tracking whether each bufs[] entry is used
> + * @bufs:	videobuf2 buffer structures. Must be accessed with
> + *		vb2_get_buffer(), as an allocated buffer cannot be used
> + *		until it is published.
> + * @bufs_bitmap: bitmap tracking published buffers. Bits are set and cleared
> + *		under @mmap_lock.
>   * @max_num_buffers: upper limit of number of allocated/used buffers.
>   *		     If set to 0 v4l2 core will change it VB2_MAX_FRAME
>   *		     for backward compatibility.
> 

