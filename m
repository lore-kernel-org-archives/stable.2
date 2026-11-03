Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793723214;
	b=thoGMXfnLMP5kDrH0SFTYOT/geU/uA1YSBJYz90Kq0WCvOvBtrsI0QYAedlsXWlxiJxp
	 ofhjjEpqLBeSqTi4+VWEgLRtZHmbxI4ocJqJYuodo4IqHWqF0tu51RA524pSdGz3NsrG8
	 ThDPqsR6BuFXJskeZ5tLcazIcrh1qHKbeUu5DkusDvNOVODWN3jQKRXyXeBxBkDBs28a8
	 EMyTU1uLtAB1RAqGgeNeBjHmkQF22pcruFpKkobWB1Utb6YbvPAzzRtKORQL7El0/xpNX
	 +7AdfNO63iBK0Q8vhCSo0DbkK5yHMPWh3VimtpJAYDoSydSZyP4KL3edQy0CYzT4mrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793723214;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 Content-Language:From:In-Reply-To:Content-Transfer-Encoding:
	 X-CMS-MailID:X-Msg-Generator:Content-Type:X-RootMTR:X-EPHeader:
	 X-CMS-RootMailID:References;
	bh=YVSDIrIIzR9VS4mWTO/q1Mp+Me/njugHvJ+exw7MsBc=;
	b=iUPZ/ZqmmCOcC5/T7YODV3iB3/wYXLgH6g1jVhWT55vgvCyEi8sjDA5tlo4UtFR8YXOP
	 LYl2/tQzo3EesF8tKl1k8ZhmxyGg4jcnagCOCU4AkEdqEwVFaE3diuc+Y4w0j6vs5/fYC
	 hOx/UOSwj/o6aaUa4mN109/3IUpujCYZaWXxznPxfVcnWrVRzROo0LS4B+816LkOvgvwU
	 ZCczaiHpIxicvVNa2CFvRTEQj4zSdUjyRDvfUkV6Jmli2vQ41OrVxOKRKBa6Qm7d3FMHn
	 /KSpkJrNO8ZlKqh6KUbQbuqnNB0q/SyxvN8rHPe6MKw5aUJ6BiL+CDjxTnGnYc+OrPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=Vo2qH0rt;
	arc=none smtp.remote-ip=210.118.77.11
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91844606D81A
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 16:26:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91844606D81A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=Vo2qH0rt
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20261103162650euoutp01b0e3bdb5611f6b8b269e29c8c877035e~klcGrf6u_2388623886euoutp01E
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 16:26:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20261103162650euoutp01b0e3bdb5611f6b8b269e29c8c877035e~klcGrf6u_2388623886euoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1793723210;
	bh=YVSDIrIIzR9VS4mWTO/q1Mp+Me/njugHvJ+exw7MsBc=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=Vo2qH0rtUulQjTrvDSQeJ3FpQ5/0v4yjObZmApKDrtovCvqGFLsds5v4aD5h7yjGw
	 wCypu29RbvmDDkS2f66RSUdwWk03EBJ1dibVH/lGC+fCL5SjE8eE49epyXQaLhhvqV
	 doLOZNNKtAG8LABMwmRcRzAYnQajLB12K4sfollI=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20261103162649eucas1p2160b4c61bbe857eb702337e35ad8b2e8~klcFy-Wv13209832098eucas1p29;
	Tue,  3 Nov 2026 16:26:49 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261103162649eusmtip1b9257770e9aa42f127e639da49ee93ae~klcFXrMLm2977329773eusmtip1Q;
	Tue,  3 Nov 2026 16:26:49 +0000 (GMT)
Message-ID: <d495affe-2501-4a82-9798-aa4b279a0cba@samsung.com>
Date: Tue, 3 Nov 2026 17:26:48 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v2 1/2] media: videobuf2: publish buffers in bufs_bitmap
 under mmap_lock
To: Ricardo Ribalda <ribalda@chromium.org>, Tomasz Figa
	<tfiga@chromium.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Hans
	Verkuil <hverkuil@kernel.org>, Benjamin Gaignard
	<benjamin.gaignard@collabora.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20261103-vb2-mmap_lock-v2-1-054e11dcd013@chromium.org>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20261103162649eucas1p2160b4c61bbe857eb702337e35ad8b2e8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261103105616eucas1p17559c1ea1dd190d5516ac1be2a88bf96
X-EPHeader: CA
X-CMS-RootMailID: 20261103105616eucas1p17559c1ea1dd190d5516ac1be2a88bf96
References: <20261103-vb2-mmap_lock-v2-0-054e11dcd013@chromium.org>
	<CGME20261103105616eucas1p17559c1ea1dd190d5516ac1be2a88bf96@eucas1p1.samsung.com>
	<20261103-vb2-mmap_lock-v2-1-054e11dcd013@chromium.org>

On 03.11.2026 11:56, Ricardo Ribalda wrote:
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
> Fixes: a286b0837e13 ("media: core: Add bitmap manage bufs array entries")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

One minor issue below, besides that is look fine.

Reviewed-by: Marek Szyprowski <m.szyprowski@samsung.com>


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


"Drivers must access it through vb2_get_buffer()", otherwise You risk getting
tons of poor-LLM generated patches fixing vb2-core to use vb2_get_buffer()
instead of poking q->bufs[].

> + * @bufs_bitmap: bitmap tracking published buffers. Bits are set and cleared
> + *		under @mmap_lock.
>   * @max_num_buffers: upper limit of number of allocated/used buffers.
>   *		     If set to 0 v4l2 core will change it VB2_MAX_FRAME
>   *		     for backward compatibility.
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

