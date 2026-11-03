Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793695815;
	b=OnSQfIav49tOxg5X2vosKH45ef7RAtAEwUot6rKF/em/3diA3qxo1EnVTYovo00yxosj
	 Peex+tgNhro+tOhEHWubzqDR+tFZC4LKSh+VSRoge95/ZNGpnX82aVv8EFVl+4VpzvmaF
	 auGS0g8eUxBk4UM+hNA4r2fdWQqknLf8Rc315LNkjgGk+b6De6Z0ZJqbTUm6wpbI/EKCh
	 IshyxwWVzhE+TzR/v+Td60SjdSpl+zqLgwzYGl4sT3+I6DoeqMMNGB9eyVGUNa9ojM6jn
	 U5Yx+BhV1po3dutuyOfh0uvjTzcXoK3GLEazW1cmQGf9XBN28Iq91rvq9zGxMQ/oc8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793695815;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:From:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=xyyv00RDv+h2IFmUEvqQmBS2x3EOpc+Kzx0ylyqL+AE=;
	b=BWpMmkcK+LZ3ydM2q0spiZ19SpebLf2CMt4NHEZe8iwCgrvJeb7eoUSoqOcXAfVqzDMe
	 Kk/VP+ZfdrPUN3Z7QPH9jR5MGUzF8rYPQRfwSKvHGZ3djIMtv9gu5mAWm0o3AG+Z7zLN0
	 KvORlns8SPRzlIrPBOtl+61xt4jkJdlETxPE0gm0cy438QVm4KphuMNQvR+6J89qvp87d
	 UfWj5qhMiKJgLB1c5OAgX7AD2z5YC+6gO8IRyKxaDPOHogHG+ywhfLWqGHyAWj/P3/WZL
	 6bclBfxNa4oEDqJ0m3lN/sp++HhXqEDcJtVvsYKzSgZ6tMlRU/txT/7K1Yo2ej0+OVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V3wjA9Jp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F620606A327;
	Tue,  3 Nov 2026 08:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V3wjA9Jp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D8D91F000C1;
	Tue,  3 Nov 2026 08:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793695815;
	bh=xyyv00RDv+h2IFmUEvqQmBS2x3EOpc+Kzx0ylyqL+AE=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=V3wjA9JpanZ8ZdqwykivW/zvI7NADD+Oxjej2BtlzVenyf9bdeV4DFPTd8D8Ib+kZ
	 Ree0sY5yumvQYAaIFnUw0eYRoxoOth7QIqkIWhTixgl1YDsJ8dFyWbzt5lAEuYrqxG
	 8g3A0U2PlbSEHHRpgA3l+ZYG9COGwS53mMDAGMSDNOpBeMQlak11YLfXmDjBbJw3JP
	 wCFydalGGRA0j3s59lw0Bzd33y1OG3qdqE6p/AnHq6Mo8UWyRCApXw0j0PIEJybwbt
	 tGMvfyPxxP5YSlCqC1E4bCQoc+AO9VQNBD0rF02aTBEGDGjMQDmK71xJ+OeMSvLIjE
	 WDTviZTGyFrZw==
Message-ID: <129153ba-7e5e-470d-86a7-78c346c03d6c@kernel.org>
Date: Tue, 3 Nov 2026 09:50:11 +0100
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
From: Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: Re: [PATCH] media: videobuf2: publish buffers in bufs_bitmap under
 mmap_lock
To: Ricardo Ribalda <ribalda@chromium.org>, Tomasz Figa <tfiga@chromium.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Hans Verkuil <hverkuil@kernel.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261102-vb2-mmap_lock-v1-1-fe550fe03ed8@chromium.org>
Content-Language: en-US, nl
In-Reply-To: <20261102-vb2-mmap_lock-v1-1-fe550fe03ed8@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ricardo,

Thank you for the patch, some comments below.

On 02/11/2026 18:12, Ricardo Ribalda wrote:
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
> and .queue_setup() succeed. Add a memory barrier pair on q->bufs_bitmap
> so lockless vb2_get_buffer() readers also see fully initialized buffers,
> and let __vb2_queue_free() read q->bufs[] directly when cleaning up
> unexposed buffers.
> 
> Fixes: a286b0837e13 ("media: core: Add bitmap manage bufs array entries")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
> This patch was generated by an LLM, but supervised and reviewed by a
> human (not the most handsome human, but a human).
> ---
>  drivers/media/common/videobuf2/videobuf2-core.c | 97 +++++++++++++++++++------
>  include/media/videobuf2-core.h                  | 13 +++-
>  2 files changed, 85 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
> index b0a6084f1757..185393078ce3 100644
> --- a/drivers/media/common/videobuf2/videobuf2-core.c
> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> @@ -427,19 +427,36 @@ static void init_buffer_cache_hints(struct vb2_queue *q, struct vb2_buffer *vb)
>  }
>  
>  /**
> - * vb2_queue_add_buffer() - add a buffer to a queue
> - * @q:	pointer to &struct vb2_queue with videobuf2 queue.
> - * @vb:	pointer to &struct vb2_buffer to be added to the queue.
> - * @index: index where add vb2_buffer in the queue
> + * vb2_queue_add_buffers() - publish buffers staged by __vb2_queue_alloc()
> + * @q:		pointer to &struct vb2_queue with videobuf2 queue.
> + * @start:	index of the first buffer to publish.
> + * @count:	number of buffers to publish.
> + *
> + * Set the @q->bufs_bitmap bits of the @count fully initialized buffers that
> + * __vb2_queue_alloc() stored in @q->bufs[] starting at @start, which makes
> + * them visible to vb2_get_buffer().
>   */
> -static void vb2_queue_add_buffer(struct vb2_queue *q, struct vb2_buffer *vb, unsigned int index)
> +static void vb2_queue_add_buffers(struct vb2_queue *q, unsigned int start,
> +				  unsigned int count)
>  {
> -	WARN_ON(index >= q->max_num_buffers || test_bit(index, q->bufs_bitmap) || vb->vb2_queue);
> +	unsigned int i;
> +
> +	lockdep_assert_held(&q->mmap_lock);
>  
> -	q->bufs[index] = vb;
> -	vb->index = index;
> -	vb->vb2_queue = q;
> -	set_bit(index, q->bufs_bitmap);
> +	/*
> +	 * Order the buffer initialization and the q->bufs[] stores done by
> +	 * __vb2_queue_alloc() before the bits that publish them. Pairs with
> +	 * test_bit_acquire() in vb2_get_buffer(), which is also called
> +	 * without q->lock or q->mmap_lock held, e.g. by vb2_find_buffer()
> +	 * from a mem2mem .device_run().
> +	 */
> +	smp_mb__before_atomic();

Move the memory barrier changes to a separate patch. I'm not at all certain these
are needed. I noticed before that LLMs are very 'generous' with such things and
I am not sure they know what they are doing.

> +	for (i = start; i < start + count; i++) {
> +		if (WARN_ON(i >= q->max_num_buffers || !q->bufs[i] ||
> +			    test_bit(i, q->bufs_bitmap)))
> +			continue;
> +		set_bit(i, q->bufs_bitmap);
> +	}

So if I understand it correctly, the root issue is that vb2_queue_add_buffer
sets the bit in bufs_bitmap, even though __vb2_queue_alloc() might free it
again.

I think these changes are a bit too extensive. How about just dropping the
set_bit from vb2_queue_add_buffer()? And at the end of the reqbufs/create_bufs
function call bitmap_set() to update bufs_bitmap?

>  }
>  
>  /**
> @@ -448,6 +465,8 @@ static void vb2_queue_add_buffer(struct vb2_queue *q, struct vb2_buffer *vb, uns
>   */
>  static void vb2_queue_remove_buffer(struct vb2_buffer *vb)
>  {
> +	lockdep_assert_held(&vb->vb2_queue->mmap_lock);

It doesn't hurt to have these asserts. But put these in a separate patch please.

> +
>  	clear_bit(vb->index, vb->vb2_queue->bufs_bitmap);
>  	vb->vb2_queue->bufs[vb->index] = NULL;
>  	vb->vb2_queue = NULL;
> @@ -460,6 +479,11 @@ static void vb2_queue_remove_buffer(struct vb2_buffer *vb)
>   * @first_index: index of the first created buffer, all newly allocated buffers
>   *		 have indices in the range [first_index..first_index+count-1]
>   *
> + * The allocated buffers are stored in q->bufs[] but not published in
> + * q->bufs_bitmap: the caller must either publish them with
> + * vb2_queue_add_buffers() or free them with __vb2_queue_free(), both under
> + * q->mmap_lock.
> + *
>   * Returns the number of buffers successfully allocated.
>   */
>  static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
> @@ -506,7 +530,9 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
>  		}
>  
>  		vb->state = VB2_BUF_STATE_DEQUEUED;
> +		vb->vb2_queue = q;
>  		vb->num_planes = num_planes;
> +		vb->index = index + buffer;
>  		vb->type = q->type;
>  		vb->memory = memory;
>  		init_buffer_cache_hints(q, vb);
> @@ -515,7 +541,6 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
>  			vb->planes[plane].min_length = plane_sizes[plane];
>  		}
>  
> -		vb2_queue_add_buffer(q, vb, index++);
>  		call_void_bufop(q, init_buffer, vb);
>  
>  		/* Allocate video buffer memory for the MMAP type */
> @@ -524,7 +549,6 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
>  			if (ret) {
>  				dprintk(q, 1, "failed allocating memory for buffer %d\n",
>  					buffer);
> -				vb2_queue_remove_buffer(vb);
>  				kfree(vb);
>  				break;
>  			}
> @@ -539,11 +563,20 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
>  				dprintk(q, 1, "buffer %d %p initialization failed\n",
>  					buffer, vb);
>  				__vb2_buf_mem_free(vb);
> -				vb2_queue_remove_buffer(vb);
>  				kfree(vb);
>  				break;
>  			}
>  		}
> +
> +		/*
> +		 * Stage the initialized buffer in q->bufs[]; it becomes visible
> +		 * to vb2_get_buffer() only after vb2_queue_add_buffers() sets
> +		 * its bit in q->bufs_bitmap under q->mmap_lock.
> +		 */
> +		WARN_ON(vb->index >= q->max_num_buffers ||
> +			q->bufs[vb->index] ||
> +			test_bit(vb->index, q->bufs_bitmap));
> +		q->bufs[vb->index] = vb;
>  	}
>  
>  	dprintk(q, 3, "allocated %d buffers, %d plane(s) each\n",
> @@ -562,7 +595,8 @@ static void __vb2_free_mem(struct vb2_queue *q, unsigned int start, unsigned int
>  	struct vb2_buffer *vb;
>  
>  	for (i = start; i < start + count; i++) {
> -		vb = vb2_get_buffer(q, i);
> +		/* See __vb2_queue_free() for why vb2_get_buffer() isn't used */
> +		vb = q->bufs[i];
>  		if (!vb)
>  			continue;
>  
> @@ -580,6 +614,11 @@ static void __vb2_free_mem(struct vb2_queue *q, unsigned int start, unsigned int
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
> @@ -587,9 +626,19 @@ static void __vb2_queue_free(struct vb2_queue *q, unsigned int start, unsigned i
>  
>  	lockdep_assert_held(&q->mmap_lock);
>  
> +	/*
> +	 * No buffers were ever allocated (e.g. REQBUFS(0) on a fresh queue),
> +	 * only the queue state needs to be reset.
> +	 */
> +	if (!q->bufs) {
> +		q->memory = VB2_MEMORY_UNKNOWN;
> +		INIT_LIST_HEAD(&q->queued_list);
> +		return;
> +	}

This change looks dubious. It doesn't appear to have anything to do with the actual
change. If it is meant as an optimization, then I would just drop this: this situation
almost never happens in practice, so it just adds code for no benefit.

> +
>  	/* Call driver-provided cleanup function for each buffer, if provided */
>  	for (i = start; i < start + count; i++) {
> -		struct vb2_buffer *vb = vb2_get_buffer(q, i);
> +		struct vb2_buffer *vb = q->bufs[i];
>  
>  		if (vb && vb->planes[0].mem_priv)
>  			call_void_vb_qop(vb, buf_cleanup, vb);
> @@ -624,7 +673,7 @@ static void __vb2_queue_free(struct vb2_queue *q, unsigned int start, unsigned i
>  		q->cnt_unprepare_streaming = 0;
>  	}
>  	for (i = start; i < start + count; i++) {
> -		struct vb2_buffer *vb = vb2_get_buffer(q, i);
> +		struct vb2_buffer *vb = q->bufs[i];
>  		bool unbalanced;
>  
>  		if (!vb)
> @@ -676,7 +725,7 @@ static void __vb2_queue_free(struct vb2_queue *q, unsigned int start, unsigned i
>  
>  	/* Free vb2 buffers */
>  	for (i = start; i < start + count; i++) {
> -		struct vb2_buffer *vb = vb2_get_buffer(q, i);
> +		struct vb2_buffer *vb = q->bufs[i];
>  
>  		if (!vb)
>  			continue;
> @@ -1000,14 +1049,16 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
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
> +	vb2_queue_add_buffers(q, first_index, allocated_buffers);
>  	mutex_unlock(&q->mmap_lock);
>  
>  	/*
> @@ -1125,14 +1176,16 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
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
> +	vb2_queue_add_buffers(q, *first_index, allocated_buffers);
>  	mutex_unlock(&q->mmap_lock);
>  
>  	/*
> diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
> index 4b4f4c15c53a..0b32ac7bc8fc 100644
> --- a/include/media/videobuf2-core.h
> +++ b/include/media/videobuf2-core.h
> @@ -565,8 +565,11 @@ struct vb2_buf_ops {
>   * @memory:	current memory type used
>   * @dma_dir:	DMA mapping direction.
>   * @bufs:	videobuf2 buffer structures. If it is non-NULL then
> - *		bufs_bitmap is also non-NULL.
> - * @bufs_bitmap: bitmap tracking whether each bufs[] entry is used
> + *		bufs_bitmap is also non-NULL. __vb2_queue_alloc() fills in
> + *		an entry before its bit is set in bufs_bitmap, so buffers
> + *		must be looked up with vb2_get_buffer().
> + * @bufs_bitmap: bitmap tracking which bufs[] entries hold a fully
> + *		initialized buffer. Bits are set and cleared under @mmap_lock.
>   * @max_num_buffers: upper limit of number of allocated/used buffers.
>   *		     If set to 0 v4l2 core will change it VB2_MAX_FRAME
>   *		     for backward compatibility.
> @@ -1286,7 +1289,11 @@ static inline struct vb2_buffer *vb2_get_buffer(struct vb2_queue *q,
>  	if (index >= q->max_num_buffers)
>  		return NULL;
>  
> -	if (test_bit(index, q->bufs_bitmap))
> +	/*
> +	 * A set bit guarantees that the buffer is fully initialized, pairs
> +	 * with smp_mb__before_atomic() in vb2_queue_add_buffers().
> +	 */
> +	if (test_bit_acquire(index, q->bufs_bitmap))
>  		return q->bufs[index];
>  	return NULL;
>  }

Regards,

	Hans

> 
> ---
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> change-id: 20261102-vb2-mmap_lock-959e0cc4edb3
> 
> Best regards,

