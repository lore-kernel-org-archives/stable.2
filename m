Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928904AFE2F;
	Thu,  3 Sep 2026 13:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788441893; cv=none; b=SFvoSBSgajQnBavCRSxc6zRhRP4oWKx8K0zLiV1tCN+DxLvYFlSAspP8YUBBXyZh1cM3Ehn8j9i8iHV5/bjWN2C8xAhVhV/HSDQIKUKyBS92kZNpos+LRqiX3sGamMMPX2RcoFyy0idQa3jyCbmXT7ejL+GhyHIwCOFdk4aWPqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788441893; c=relaxed/simple;
	bh=Qpozlw3HfHIQnZb684XPWj4BpOgsDr1nmVOC1eUdtUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uf8qZYEko4FLvS1ElMj6E/Fg2worvf1SifnuwNqroI6FQzDQR0kCxpsnFASRN0XWY7OKmRnGcV0GfcPI0TkWtPN1KMffc4M3/cIxVPYZGD3XQUzNmLUJyei4ydaZqSjVPvXFJ+WNvpfMwBy723WFP90rPpfCO5H87E5Wn8x9EEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Q1UwKSAN; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Q1UwKSAN"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id E4C422335;
	Thu,  3 Sep 2026 15:23:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1788441781;
	bh=Qpozlw3HfHIQnZb684XPWj4BpOgsDr1nmVOC1eUdtUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q1UwKSANmZpu7kPAdD7jWopYWfGoHFbQuCVq7ZnzcM2H8K/oI9JEjJPb6MY64JH/x
	 UmTZ+mT3QQ0IVoAnBPtQ8+tCTzYcCtwctSL5jhjHNRAs+7yfqvd54gHDJ2mvEpyu8M
	 1NW9BTvm3SNcwlXSA+TzEzoGDeuLuYvS7r+0R5MI=
Date: Thu, 3 Sep 2026 16:24:31 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: huhb1 <huhb04@gmail.com>
Cc: hansg@kernel.org, mchehab@kernel.org, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] media: uvcvideo: defer cancelled buffer completion until
 copies finish
Message-ID: <20260903132431.GG541154@killaraus.ideasonboard.com>
References: <20260903131141.6368-1-huhb1@xiaopeng.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260903131141.6368-1-huhb1@xiaopeng.com>

On Thu, Sep 03, 2026 at 09:11:41PM +0800, huhb1 wrote:
> From: huhb04 <huhb04@gmail.com>
> 
> uvc_queue_cancel() returns queued buffers to videobuf2 directly via
> vb2_buffer_done(). This is unsafe because asynchronous memcpy workers may
> still hold a reference on the same uvc_buffer. Once vb2_buffer_done() has
> run, userspace can dequeue and requeue the buffer while the old worker is
> still running, leading to the same list_head being inserted into irqqueue
> twice and corrupting the list.
> 
> The crash manifests in two ways depending on the drop-corrupted-frames
> module parameter:
> 
> 1. With the drop corrupted frames enabled, the old worker's
>    final kref_put reaches uvc_queue_buffer_complete(), sees buf->error set,
>    and calls uvc_queue_buffer_requeue(). This performs list_add_tail() on
>    buf->queue even though userspace has already QBUF'd the same buffer and
>    added it to irqqueue.
> 
> 2. With nodrop=1, uvc_queue_buffer_complete() calls vb2_buffer_done() a
>    second time. If userspace has already dequeued and requeued the buffer,
>    the second completion exposes it to userspace again, and the next
>    DQBUF/QBUF inserts the still-linked list_head into irqqueue a second
>    time.
> 
> Both cases produce the kind of list_del corruption seen here:
> 
>     list_del corruption. next->prev should be ..., but was ...
>     kernel BUG at lib/list_debug.c:64!
> 
> Fix the cancel path to remove buffers from irqqueue and drop the queue's
> reference through uvc_queue_buffer_release() (i.e. kref_put()). The final
> VB2 completion then only happens from uvc_queue_buffer_complete() once the
> last async reference is released, so userspace cannot reuse the buffer
> while an old worker still accesses it.
> 
> A buffer whose state is already UVC_BUF_STATE_ERROR is forced to complete
> as an error and must not be requeued by the corrupted-frame policy. Normal
> malformed frames are still requeued/dropped as before.
> 
> Fixes: 01e90464e42e ("media: uvcvideo: queue: Support asynchronous buffer handling")
> Cc: stable@vger.kernel.org
> Signed-off-by: huhb04 <huhb04@gmail.com>

We need a real name here and in the author field.

> ---
>  drivers/media/usb/uvc/uvc_queue.c | 30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_queue.c b/drivers/media/usb/uvc/uvc_queue.c
> index 3c002c8f44..9206e0a355 100644
> --- a/drivers/media/usb/uvc/uvc_queue.c
> +++ b/drivers/media/usb/uvc/uvc_queue.c
> @@ -289,10 +289,19 @@ int uvc_queue_init(struct uvc_streaming *stream, struct uvc_video_queue *queue,
>   */
>  void uvc_queue_cancel(struct uvc_video_queue *queue, int disconnect)
>  {
> +	struct uvc_buffer *buf, *next;
> +	struct list_head local_list;
>  	unsigned long flags;
>  
> +	INIT_LIST_HEAD(&local_list);
> +
>  	spin_lock_irqsave(&queue->irqlock, flags);
> -	__uvc_queue_return_buffers(queue, UVC_BUF_STATE_ERROR);
> +	while (!list_empty(&queue->irqqueue)) {
> +		buf = list_first_entry(&queue->irqqueue, struct uvc_buffer, queue);
> +		list_del(&buf->queue);
> +		buf->state = UVC_BUF_STATE_ERROR;
> +		list_add_tail(&buf->queue, &local_list);
> +	}
>  	/*
>  	 * This must be protected by the irqlock spinlock to avoid race
>  	 * conditions between uvc_buffer_queue and the disconnection event that
> @@ -303,6 +312,17 @@ void uvc_queue_cancel(struct uvc_video_queue *queue, int disconnect)
>  	if (disconnect)
>  		queue->flags |= UVC_QUEUE_DISCONNECTED;
>  	spin_unlock_irqrestore(&queue->irqlock, flags);
> +
> +	/*
> +	 * Release the queue-owned kref outside the irqlock. The final VB2
> +	 * completion only happens from uvc_queue_buffer_complete() once all
> +	 * asynchronous copy references have been released, preventing userspace
> +	 * from reusing the buffer while an old worker still accesses it.
> +	 */
> +	list_for_each_entry_safe(buf, next, &local_list, queue) {
> +		list_del(&buf->queue);
> +		uvc_queue_buffer_release(buf);
> +	}
>  }
>  
>  /*
> @@ -356,7 +376,13 @@ static void uvc_queue_buffer_complete(struct kref *ref)
>  	struct vb2_buffer *vb = &buf->buf.vb2_buf;
>  	struct uvc_video_queue *queue = vb2_get_drv_priv(vb->vb2_queue);
>  
> -	if (buf->error && !uvc_no_drop_param) {
> +	/*
> +	 * Buffers cancelled from uvc_queue_cancel() are forced to complete as
> +	 * errors. They must not be requeued by the corrupted-frame policy even
> +	 * when buf->error is set.
> +	 */
> +	if (buf->state != UVC_BUF_STATE_ERROR &&
> +	    buf->error && !uvc_no_drop_param) {
>  		uvc_queue_buffer_requeue(queue, buf);
>  		return;
>  	}

-- 
Regards,

Laurent Pinchart
