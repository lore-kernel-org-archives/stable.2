Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793715597;
	b=v3eFZ6qTGJYbC5aDnEGHipS9ZKzmXXcxgeWIFQGVTbti1fNUY/nfPzHgGC5b0td3DAd7
	 aFMOsAmGFfWbQkaUoQpbxtZHsKV5JuAlCw+RCyQDSm6N5ptMIpeTTT/FEJuRSo83DCyK0
	 ckl3XU4Oa8gRu3R+hxgRxJzQbh+2eOi9Px0YhJv3O8PqFtExpkc/BjXTi7NWgXh25ZLUj
	 SPMnzBPrPozKENbF4TQNJi/K6JDXPBuUGCnIJ41Ole/ONheHdpEIVTFgzoKfBP/2e7Gdu
	 eG1NOAA7IMximevQ2xCXz/3K7a+eEKOHxSJR8CspIpu9kqJObOI0ILhf16qnsA4vHSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793715597;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=SZCN1KJ0Gxb3baIrMzkxwxg1JoGJHrMBrLpX0iRDcDQ=;
	b=rYhPfrHHwcvrbe/dYqipjCQm9IckwBuP/cv/5l92rNuSanme6vTpi0auquZ3suHrlutc
	 HWxRoYERcCuQ6NFK4edOqOTC5KJptUrllH7T9gx8XktGF802IqOl+gSpf25XO0/Eep6QR
	 UqDwXp9qNZgyfaUQQC4e+6e/SB+T+y1zqWepgXLg90vJlBn/3t/LKPnswyXV7etnwJe3S
	 kmPNXbeV0EvvP0BYw2B3TIk22WsYekcs08D/JcUhheB4ZWQNZQYC5kR7BIiB0tUYZENYp
	 PFeu0tKhk2k5HWbetG03eGmcGEDJ3tho5YPISQq1vKh7WVPk04tkBa7OgPdw4Nl0qjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c0kMnQsS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF96606A327;
	Tue,  3 Nov 2026 14:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c0kMnQsS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B53C21F000C1;
	Tue,  3 Nov 2026 14:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793715596;
	bh=SZCN1KJ0Gxb3baIrMzkxwxg1JoGJHrMBrLpX0iRDcDQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=c0kMnQsSOC5cxQwmlZLw8EGmyMWEFgPbWGm1M9peib0BSrFl+zK8FYEf8gcjgs6HG
	 E/7vFzVvnDyAQiwvvr+rmEO4BmDtMZoAjLBCB8uwIh2oOS2ZGViO44iXFqPIXIPCXK
	 So+dNI6VbTOqt8/wJxBvL/IG3sgPaYvOWsC4iB4idqwEBuCHo2InTFUyt3XSNtc8cs
	 jtXr4l0gFUsa8ihfJzrCmFGeHYUQqfyTrO1mobWwBgWyo+NimJZQHu444pLWRH8jWZ
	 Njb3Dj5UTK487c9IwBL8aqobl6jwLdG73YczFMjWY/uBCEAFl+0cRbKQ/5rFCfoxUX
	 P+pOS6Rl+kU0w==
Message-ID: <593b9102-73cd-44f1-9a57-7df0806d6505@kernel.org>
Date: Tue, 3 Nov 2026 15:19:53 +0100
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
Subject: Re: [PATCH v2 2/2] media: videobuf2: order buffer initialization
 before bufs_bitmap publication
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 Ricardo Ribalda <ribalda@chromium.org>, Tomasz Figa <tfiga@chromium.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Hans Verkuil <hverkuil@kernel.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261103-vb2-mmap_lock-v2-0-054e11dcd013@chromium.org>
 <CGME20261103105616eucas1p212ea654a93c4754fcc58bf449a2e58b4@eucas1p2.samsung.com>
 <20261103-vb2-mmap_lock-v2-2-054e11dcd013@chromium.org>
 <c1caf0c5-d82e-44c1-9d0f-934008f4febd@samsung.com>
From: Hans Verkuil <hverkuil+cisco@kernel.org>
Content-Language: en-US
In-Reply-To: <c1caf0c5-d82e-44c1-9d0f-934008f4febd@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/3/26 14:39, Marek Szyprowski wrote:
> On 03.11.2026 11:56, Ricardo Ribalda wrote:
>> Stateless mem2mem decoders call vb2_find_buffer() -> vb2_get_buffer()
>> from .device_run() without holding q->lock or q->mmap_lock, which can
>> run concurrently with VIDIOC_CREATE_BUFS on a streaming queue.
>>
>> Both set_bit() and test_bit() are unordered, and mutex_lock(&q->mmap_lock)
>> is only an acquire barrier. On weakly-ordered architectures such as
>> arm64, a lockless vb2_get_buffer() caller can observe a newly set bit in
>> q->bufs_bitmap before the kzalloc() zeroing, buffer initialization, and
>> q->bufs[] pointer store performed by __vb2_queue_alloc() become visible.
>>
>> Pair smp_mb__before_atomic() in vb2_queue_publish_buffers() with
>> test_bit_acquire() in vb2_get_buffer() so that any reader observing a
>> set bit in q->bufs_bitmap also sees a fully initialized vb2_buffer.
>>
>> Fixes: a286b0837e13 ("media: core: Add bitmap manage bufs array entries")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> 
> 
> Can't we use ordinary locking instead of those memory barriers and relying
> on not-always-atomic bit operations? For me this looks like over-optimization,
> taking into account that those operations are not on the critical path nor
> anyhow time-comparable with filling the whole buffer with image data.

I was thinking the same thing.

I *think* the code is correct, but I'm not sure. Memory barriers are hard to get
right, and I consider myself to be a newbie when it comes to that. A simple spinlock
is much easier to understand, and this is hardly a high-performance loop where you
need to squeeze the last bit of performance out of it.

It's why I wanted to split this off from the original patch, so it is easier to
review.

Regards,

	Hans

> 
> 
>> ---
>>  drivers/media/common/videobuf2/videobuf2-core.c | 8 ++++++++
>>  include/media/videobuf2-core.h                  | 6 +++++-
>>  2 files changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
>> index 70ef38c3d16a..d0dd4b22b646 100644
>> --- a/drivers/media/common/videobuf2/videobuf2-core.c
>> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
>> @@ -461,6 +461,14 @@ static void vb2_queue_publish_buffers(struct vb2_queue *q, unsigned int start,
>>  
>>  	lockdep_assert_held(&q->mmap_lock);
>>  
>> +	/*
>> +	 * Order the buffer initialization and the q->bufs[] stores done by
>> +	 * __vb2_queue_alloc() before the bits that publish them. Pairs with
>> +	 * test_bit_acquire() in vb2_get_buffer(), which is also called
>> +	 * without q->lock or q->mmap_lock held, e.g. by vb2_find_buffer()
>> +	 * from a mem2mem .device_run().
>> +	 */
>> +	smp_mb__before_atomic();
>>  	for (i = start; i < start + count; i++) {
>>  		if (WARN_ON(i >= q->max_num_buffers || !q->bufs[i] ||
>>  			    test_bit(i, q->bufs_bitmap)))
>> diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
>> index 2e93e6985d5f..20b961da21e0 100644
>> --- a/include/media/videobuf2-core.h
>> +++ b/include/media/videobuf2-core.h
>> @@ -1288,7 +1288,11 @@ static inline struct vb2_buffer *vb2_get_buffer(struct vb2_queue *q,
>>  	if (index >= q->max_num_buffers)
>>  		return NULL;
>>  
>> -	if (test_bit(index, q->bufs_bitmap))
>> +	/*
>> +	 * A set bit guarantees that the buffer is fully initialized, pairs
>> +	 * with smp_mb__before_atomic() in vb2_queue_publish_buffers().
>> +	 */
>> +	if (test_bit_acquire(index, q->bufs_bitmap))
>>  		return q->bufs[index];
>>  	return NULL;
>>  }
>>
> Best regards

