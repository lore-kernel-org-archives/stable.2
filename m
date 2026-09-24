Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563402673AA;
	Thu, 24 Sep 2026 13:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790258359; cv=none; b=QfysT13vs5PVGfVfGxQ1KUIsvqDNLWMOQ4ktTRGr0EnYun6Rfni0si7QN5N998/KJQbgsxl0Vb6RE3rZAZrZ04l6UQYHIEUK91ilAjHJ9t0ih8FAZvj4xN7q/VeDD9TFN/FYXNDW2szrPuceUYkHHt3oAw12xMu7tqEB5aQ2RyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790258359; c=relaxed/simple;
	bh=8KMJp4l5scS6ux5Pa9OBYN91E878i428O2BdSDBLFVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GSpcm/yWsbd+e+elUNTJiwTA4m4mfSeMmbPgZccPlOnvHtc9MRlQrnWBS5i8wzkbrBlDbmyhJXddOVCSbtiNW3Vdbwq7z02cM+uxI9QRoq3wEqc7r2XsLtMjpXHqsuK7gp9bWR0luVaMUsjhcplilwfJF2yy3DX+4ZkLarNaho0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=lMt+eMLs; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="lMt+eMLs"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id AE6CFC23;
	Thu, 24 Sep 2026 15:57:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1790258247;
	bh=8KMJp4l5scS6ux5Pa9OBYN91E878i428O2BdSDBLFVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lMt+eMLs1r5yHIJANFw4QjdwgZK1CFv+1yYIrzAAcAu+9sy4ct2q5mY04rWFSODDH
	 wv9jcKWEoYQpWLqgeidOe3mIZ2CbNqkkp+a7uSR6BZOc+9jYiO/jW6IXxupb9CHIVq
	 dr6NutuwWyTvNNcu3n6TUg1OrFiMMI9U6/T448I0=
Date: Thu, 24 Sep 2026 16:59:13 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Hongbing Hu <huhb04@gmail.com>
Cc: hansg@kernel.org, mchehab@kernel.org, kieran.bingham@ideasonboard.com,
	ribalda@chromium.org, linux-media@vger.kernel.org,
	linux5-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] media: uvcvideo: defer cancelled buffer completion
 until copies finish
Message-ID: <20260924135913.GB135998@killaraus.ideasonboard.com>
References: <20260903131141.6368-1-huhb1@xiaopeng.com>
 <20260917144630.16923-1-huhb04@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260917144630.16923-1-huhb04@gmail.com>

On Thu, Sep 17, 2026 at 10:46:30PM +0800, Hongbing Hu wrote:
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
> 1. With the default (drop corrupted frames enabled), the old worker's
>    final kref_put reaches uvc_queue_buffer_complete(), sees buf->error set,

What sets buf->error in that case ?

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
> Introduce a dedicated bool cancelled flag in struct uvc_buffer,this keeps
> the cancellation semantics explicit regardless of any later state updates
> from the packet decoder.
> Cancelled buffers are forced to complete as errors; normal malformed frames
> continue to be requeued or dropped as before.
> 
> Fixes: 01e90464e42e ("media: uvcvideo: queue: Support asynchronous buffer handling")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongbing Hu <huhb04@gmail.com>
> ---
> v3:
> - invoke uvc_queue_buffer_release() while holding the spinlock to keep it simple
> - Set/clear the new cancelled flag in uvc_queue_cancel() and
>   uvc_buffer_prepare() instead of overloading buf->state. 
> - Force cancelled buffers to complete as errors,
>   so the returned buff->state is UVC_BUF_STATE_ERROR.
> 
>  drivers/media/usb/uvc/uvc_queue.c | 17 +++++++++++++++--
>  drivers/media/usb/uvc/uvcvideo.h  |  1 +
>  2 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_queue.c b/drivers/media/usb/uvc/uvc_queue.c
> index 3c002c8f44..1026d7def3 100644
> --- a/drivers/media/usb/uvc/uvc_queue.c
> +++ b/drivers/media/usb/uvc/uvc_queue.c
> @@ -122,6 +122,7 @@ static int uvc_buffer_prepare(struct vb2_buffer *vb)
>  
>  	buf->state = UVC_BUF_STATE_QUEUED;
>  	buf->error = 0;
> +	buf->cancelled = false;
>  	buf->mem = vb2_plane_vaddr(vb, 0);
>  	buf->length = vb2_plane_size(vb, 0);
>  	if (vb->type != V4L2_BUF_TYPE_VIDEO_OUTPUT)
> @@ -289,10 +290,17 @@ int uvc_queue_init(struct uvc_streaming *stream, struct uvc_video_queue *queue,
>   */
>  void uvc_queue_cancel(struct uvc_video_queue *queue, int disconnect)
>  {
> +	struct uvc_buffer *buf;
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&queue->irqlock, flags);
> -	__uvc_queue_return_buffers(queue, UVC_BUF_STATE_ERROR);
> +	while (!list_empty(&queue->irqqueue)) {
> +		buf = list_first_entry(&queue->irqqueue, struct uvc_buffer, queue);
> +		list_del(&buf->queue);
> +		buf->error = 1;
> +		buf->cancelled = true;
> +		uvc_queue_buffer_release(buf);
> +	}
>  	/*
>  	 * This must be protected by the irqlock spinlock to avoid race
>  	 * conditions between uvc_buffer_queue and the disconnection event that
> @@ -356,7 +364,12 @@ static void uvc_queue_buffer_complete(struct kref *ref)
>  	struct vb2_buffer *vb = &buf->buf.vb2_buf;
>  	struct uvc_video_queue *queue = vb2_get_drv_priv(vb->vb2_queue);
>  
> -	if (buf->error && !uvc_no_drop_param) {
> +	/*
> +	 * Buffers cancelled from uvc_queue_cancel() are forced to complete as
> +	 * errors. They must not be requeued by the corrupted-frame policy even
> +	 * when buf->error is set.
> +	 */
> +	if (!buf->cancelled && buf->error && !uvc_no_drop_param) {
>  		uvc_queue_buffer_requeue(queue, buf);
>  		return;
>  	}
> diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> index b6bcee4a22..1b611715fa 100644
> --- a/drivers/media/usb/uvc/uvcvideo.h
> +++ b/drivers/media/usb/uvc/uvcvideo.h
> @@ -317,6 +317,7 @@ struct uvc_buffer {
>  
>  	enum uvc_buffer_state state;
>  	unsigned int error;
> +	bool cancelled;
>  
>  	void *mem;
>  	unsigned int length;

-- 
Regards,

Laurent Pinchart
