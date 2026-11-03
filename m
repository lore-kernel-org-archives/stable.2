Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793713181;
	b=XBcVoGOh0lagVC1qEwQIfiNEbeHcqGODpR5RS2M+Yx+8gBHIObGrkLzJuBI9fy3ceW1m
	 1SUDnfXWwD9g4cWM8Betmoa7er0RJHSmpsB++Ag/W5m0D0UxeQ/CwCyonZt9CPBaEeyLA
	 gUb8/HBShZwDS+R3BavKN9xagGHfHhoRDEY89t23CEmufUlYPAMPBiG6uInN9qbYQ9JdF
	 eB4QUkRoJ5dzCut6gQSBsY6HX56bIihSL708sCBF5NLrqmgKxXHdwG3PBmYrp0rTv07dQ
	 0ZDXJUQRZsCzYVG9cM8QWQsUt1ClrzybqkBqbSMvAYsArV4F3CR1owCdWxlaBmTOqyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793713181;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 Content-Language:From:In-Reply-To:Content-Transfer-Encoding:
	 X-CMS-MailID:X-Msg-Generator:Content-Type:X-RootMTR:X-EPHeader:
	 X-CMS-RootMailID:References;
	bh=eCTQKqZQWEhJr5ICgztXNdT6Rk+XZuJPxbHYVLLd/5E=;
	b=duCQQsyDNqVJiiKjbF6V3L/q6Y1NNgO0f8aBlNf7anPrtPZtvsS0CwSnK2YXxl9BKGbS
	 JdvTgFhOH14opdFzYpWAG/3WXpdLZd3GktB58K7qS8ATAXB3PD7pNkL96GaFzN7KAKZBr
	 rVofVlagHBPBubHwT05zTvDD33F59WPT5M+XCQyiSqy4ARoUivnLLFOMaZcAw0hTFTYZH
	 v1CfyFZh2vx7aQ8DScmNBz8zMUlYp8xRNtN/9kZzQCNrgB/FJtJfoiP1il77DYM4xWT3Y
	 DjPMB5P4waJyR5KuMEl2QyzKBiycue0Zt2m80YCp6gyqcaMyepCAbQ+w3pifY0SSAKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=NwczvEWg;
	arc=none smtp.remote-ip=210.118.77.11
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CD8606A32C
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 13:39:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71CD8606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=NwczvEWg
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20261103133937euoutp010b603fbeb01bf4b480502f9c766cf7c8~kjKGxJF4p0448904489euoutp01e
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 13:39:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20261103133937euoutp010b603fbeb01bf4b480502f9c766cf7c8~kjKGxJF4p0448904489euoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1793713177;
	bh=eCTQKqZQWEhJr5ICgztXNdT6Rk+XZuJPxbHYVLLd/5E=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=NwczvEWg3h0EtY/vIPvzciqgQbv8MOKNlT3KPlILdtOv5PhcYZd4sQdZTJqm2mCYH
	 G+mKQqVNx6l9+X2sXCvX/Cm27hWdaW2Q1EwShLkvfzmDccOI6gWuyvx+ivJZwB38K2
	 9oxaQrw3BPuYITRmERc/7+NCCSA1T6+KoMI7L858=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261103133937eucas1p17f7def2c1abc7cc44f548598b73cad6e~kjKGYKMeo1065010650eucas1p1h;
	Tue,  3 Nov 2026 13:39:37 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261103133936eusmtip1a2fd8fb8ca124bf3d332e4cf67d02b17~kjKFyMPSj2503025030eusmtip1R;
	Tue,  3 Nov 2026 13:39:36 +0000 (GMT)
Message-ID: <c1caf0c5-d82e-44c1-9d0f-934008f4febd@samsung.com>
Date: Tue, 3 Nov 2026 14:39:36 +0100
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
Subject: Re: [PATCH v2 2/2] media: videobuf2: order buffer initialization
 before bufs_bitmap publication
To: Ricardo Ribalda <ribalda@chromium.org>, Tomasz Figa
	<tfiga@chromium.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Hans
	Verkuil <hverkuil@kernel.org>, Benjamin Gaignard
	<benjamin.gaignard@collabora.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20261103-vb2-mmap_lock-v2-2-054e11dcd013@chromium.org>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20261103133937eucas1p17f7def2c1abc7cc44f548598b73cad6e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261103105616eucas1p212ea654a93c4754fcc58bf449a2e58b4
X-EPHeader: CA
X-CMS-RootMailID: 20261103105616eucas1p212ea654a93c4754fcc58bf449a2e58b4
References: <20261103-vb2-mmap_lock-v2-0-054e11dcd013@chromium.org>
	<CGME20261103105616eucas1p212ea654a93c4754fcc58bf449a2e58b4@eucas1p2.samsung.com>
	<20261103-vb2-mmap_lock-v2-2-054e11dcd013@chromium.org>

On 03.11.2026 11:56, Ricardo Ribalda wrote:
> Stateless mem2mem decoders call vb2_find_buffer() -> vb2_get_buffer()
> from .device_run() without holding q->lock or q->mmap_lock, which can
> run concurrently with VIDIOC_CREATE_BUFS on a streaming queue.
>
> Both set_bit() and test_bit() are unordered, and mutex_lock(&q->mmap_lock)
> is only an acquire barrier. On weakly-ordered architectures such as
> arm64, a lockless vb2_get_buffer() caller can observe a newly set bit in
> q->bufs_bitmap before the kzalloc() zeroing, buffer initialization, and
> q->bufs[] pointer store performed by __vb2_queue_alloc() become visible.
>
> Pair smp_mb__before_atomic() in vb2_queue_publish_buffers() with
> test_bit_acquire() in vb2_get_buffer() so that any reader observing a
> set bit in q->bufs_bitmap also sees a fully initialized vb2_buffer.
>
> Fixes: a286b0837e13 ("media: core: Add bitmap manage bufs array entries")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>


Can't we use ordinary locking instead of those memory barriers and relying
on not-always-atomic bit operations? For me this looks like over-optimization,
taking into account that those operations are not on the critical path nor
anyhow time-comparable with filling the whole buffer with image data.


> ---
>  drivers/media/common/videobuf2/videobuf2-core.c | 8 ++++++++
>  include/media/videobuf2-core.h                  | 6 +++++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
> index 70ef38c3d16a..d0dd4b22b646 100644
> --- a/drivers/media/common/videobuf2/videobuf2-core.c
> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> @@ -461,6 +461,14 @@ static void vb2_queue_publish_buffers(struct vb2_queue *q, unsigned int start,
>  
>  	lockdep_assert_held(&q->mmap_lock);
>  
> +	/*
> +	 * Order the buffer initialization and the q->bufs[] stores done by
> +	 * __vb2_queue_alloc() before the bits that publish them. Pairs with
> +	 * test_bit_acquire() in vb2_get_buffer(), which is also called
> +	 * without q->lock or q->mmap_lock held, e.g. by vb2_find_buffer()
> +	 * from a mem2mem .device_run().
> +	 */
> +	smp_mb__before_atomic();
>  	for (i = start; i < start + count; i++) {
>  		if (WARN_ON(i >= q->max_num_buffers || !q->bufs[i] ||
>  			    test_bit(i, q->bufs_bitmap)))
> diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
> index 2e93e6985d5f..20b961da21e0 100644
> --- a/include/media/videobuf2-core.h
> +++ b/include/media/videobuf2-core.h
> @@ -1288,7 +1288,11 @@ static inline struct vb2_buffer *vb2_get_buffer(struct vb2_queue *q,
>  	if (index >= q->max_num_buffers)
>  		return NULL;
>  
> -	if (test_bit(index, q->bufs_bitmap))
> +	/*
> +	 * A set bit guarantees that the buffer is fully initialized, pairs
> +	 * with smp_mb__before_atomic() in vb2_queue_publish_buffers().
> +	 */
> +	if (test_bit_acquire(index, q->bufs_bitmap))
>  		return q->bufs[index];
>  	return NULL;
>  }
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

