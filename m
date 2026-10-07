Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC7B48383C;
	Wed,  7 Oct 2026 10:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791369006; cv=none; b=ehcxOEiEmBsUvEJqWZbvXpBaqZGj4Ls3dY3OeTS6JnM/jDpTE29/ZxXthGnLA3UER9RbmajxjlYii0tyAD6YqHl9ZFZXujbn0zChy27nVmZ2/KubtEtJrphW5ImGjCaMPQP3RjjY4UQQHFYINokuYRv/5AfETRlAe5dtMkW/S8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791369006; c=relaxed/simple;
	bh=YLAMddstn1TdC6dj6d62pz8vG6y5Ko1Mdg4jA91wFoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=egiSuN4I9tXmsMckhLR064BOw402h0QO/5IoYkAQxLOAfsLhzM0hF/as4A9OC32SHhurrLE5C1ggTJsnTPD4Bs0hu8ntAEzswF0D1Wl+3Z+4T+0LocK/gBjHuT1+l+W/0yB8U9vGk0GdhbIAF1UEyHtphPE/nkwXEj181jKwv6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=t04kAcBz; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="t04kAcBz"
Received: from [192.168.0.43] (chfd-03-b2-v4wan-176392-cust229.vm15.cable.virginm.net [82.19.20.230])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id C5CAE1494;
	Wed,  7 Oct 2026 12:27:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1791368875;
	bh=YLAMddstn1TdC6dj6d62pz8vG6y5Ko1Mdg4jA91wFoM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=t04kAcBzACKzy1qQVQE84iYj/deeMsQjAAszWheD38x/xRSICsri6ov3jcCqx93w/
	 tOBgzX0870WeUj+OXh/pi7Gn+7Oxp2AYBzaA0O6yeAtlaXgasAtdHAkVNiwwCmJ/tl
	 tMr6QWl36hrHxykQdDlXtfc+xamMqeU3ZL4qEPtk=
Message-ID: <d458c817-85d8-435d-9da5-2aee7b09fc34@ideasonboard.com>
Date: Wed, 7 Oct 2026 11:29:48 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] media: mali-c55: Fix frame sequence numbers on
 dual-pipe hardware
To: David Carlier <devnexen@gmail.com>,
 Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Nayden Kanchev <nayden.kanchev@arm.com>,
 Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260930174621.791831-1-devnexen@gmail.com>
Content-Language: en-US
From: Dan Scally <dan.scally@ideasonboard.com>
In-Reply-To: <20260930174621.791831-1-devnexen@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi David

On 30/09/2026 18:46, David Carlier wrote:
> The single frame_sequence counter in struct mali_c55_isp is incremented
> in mali_c55_set_plane_done(), which runs once per completed buffer per
> capture device rather than once per frame. Hardware fitted with the
> downscale pipe always hits this: mali_c55_pipeline_ready() refuses to
> start the ISP unless both the full-resolution and the downscale queues
> are streaming, so the counter advances twice per frame.
> 
> Each video node then reports sequence numbers 0, 2, 4, ..., which
> userspace reads as a dropped frame between every pair of frames, and the
> two pipes never number the same frame alike, contrary to
> Documentation/admin-guide/media/mali-c55.rst. The V4L2_EVENT_FRAME_SYNC
> event and the statistics and parameters buffers only read the counter,
> so their sequence numbers stop identifying a frame too.
> 
> Increment the counter once per frame, when the ISP start interrupt is
> handled, and stamp each capture buffer when mali_c55_set_next_buffer()
> programs it, as it is written out during the following frame. Stamping
> at completion would be off by one whenever DONE(n) and START(n+1) are
> handled in the same interrupt, since ISP_START is processed first. Hold
> the counter at UINT_MAX while the ISP is stopped, as the first buffers
> are programmed before it starts, so the first frame gets sequence zero.
> 
> Fixes: d5f281f3dd29 ("media: mali-c55: Add Mali-C55 ISP driver")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---

I think this approach is fine. In v1 Jacopo said that he'd rather handle it with per-output counters 
though; @Jacopo, do you mean there that you'd rather an independent sequence counter for the FR and 
DS outputs?

Thanks
Dan

> v2:
>   - Stamp the buffer sequence in mali_c55_set_next_buffer() instead of
>     at completion, which broke when START(n+1) and DONE(n) are handled
>     together (Jacopo)
>   - Reset the counter when the ISP stops instead of when it starts
> 
> v1: https://lore.kernel.org/r/20260801205311.386692-1-devnexen@gmail.com
> ---
>   drivers/media/platform/arm/mali-c55/mali-c55-capture.c | 5 +++--
>   drivers/media/platform/arm/mali-c55/mali-c55-common.h  | 4 ++++
>   drivers/media/platform/arm/mali-c55/mali-c55-core.c    | 1 +
>   drivers/media/platform/arm/mali-c55/mali-c55-isp.c     | 3 ++-
>   4 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/platform/arm/mali-c55/mali-c55-capture.c b/drivers/media/platform/arm/mali-c55/mali-c55-capture.c
> index ff01553026fb..fa073ce4b2bd 100644
> --- a/drivers/media/platform/arm/mali-c55/mali-c55-capture.c
> +++ b/drivers/media/platform/arm/mali-c55/mali-c55-capture.c
> @@ -413,6 +413,9 @@ void mali_c55_set_next_buffer(struct mali_c55_cap_dev *cap_dev)
>   		return;
>   	}
>   
> +	/* The buffer is written out during the frame following this one. */
> +	buf->vb.sequence = cap_dev->mali_c55->isp.frame_sequence + 1;
> +
>   	pix_mp = &cap_dev->format.format;
>   
>   	mali_c55_cap_dev_update_bits(cap_dev, MALI_C55_REG_Y_WRITER_MODE,
> @@ -457,7 +460,6 @@ void mali_c55_set_next_buffer(struct mali_c55_cap_dev *cap_dev)
>   void mali_c55_set_plane_done(struct mali_c55_cap_dev *cap_dev,
>   			     enum mali_c55_planes plane)
>   {
> -	struct mali_c55_isp *isp = &cap_dev->mali_c55->isp;
>   	struct mali_c55_buffer *buf;
>   
>   	scoped_guard(spinlock, &cap_dev->buffers.processing_lock) {
> @@ -476,7 +478,6 @@ void mali_c55_set_plane_done(struct mali_c55_cap_dev *cap_dev,
>   
>   	/* If the other plane is also done... */
>   	buf->vb.vb2_buf.timestamp = ktime_get_boottime_ns();
> -	buf->vb.sequence = isp->frame_sequence++;
>   	vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_DONE);
>   }
>   
> diff --git a/drivers/media/platform/arm/mali-c55/mali-c55-common.h b/drivers/media/platform/arm/mali-c55/mali-c55-common.h
> index 13a3e9dc4243..50f2b7a85f62 100644
> --- a/drivers/media/platform/arm/mali-c55/mali-c55-common.h
> +++ b/drivers/media/platform/arm/mali-c55/mali-c55-common.h
> @@ -76,6 +76,10 @@ struct mali_c55_isp {
>   	struct media_pad *remote_src;
>   	/* Mutex to guard vb2 start/stop streaming */
>   	struct mutex capture_lock;
> +	/*
> +	 * Sequence of the frame being processed, incremented at SOF. Held at
> +	 * UINT_MAX while stopped so the first frame gets sequence 0.
> +	 */
>   	unsigned int frame_sequence;
>   };
>   
> diff --git a/drivers/media/platform/arm/mali-c55/mali-c55-core.c b/drivers/media/platform/arm/mali-c55/mali-c55-core.c
> index fb81141d1653..be562156b295 100644
> --- a/drivers/media/platform/arm/mali-c55/mali-c55-core.c
> +++ b/drivers/media/platform/arm/mali-c55/mali-c55-core.c
> @@ -573,6 +573,7 @@ static irqreturn_t mali_c55_isr(int irq, void *context)
>   	for_each_set_bit(i, &interrupt_status, MALI_C55_NUM_IRQ_BITS) {
>   		switch (i) {
>   		case MALI_C55_IRQ_ISP_START:
> +			mali_c55->isp.frame_sequence++;
>   			mali_c55_isp_queue_event_sof(mali_c55);
>   
>   			mali_c55_set_next_buffer(&mali_c55->cap_devs[MALI_C55_CAP_DEV_FR]);
> diff --git a/drivers/media/platform/arm/mali-c55/mali-c55-isp.c b/drivers/media/platform/arm/mali-c55/mali-c55-isp.c
> index e128adf6ee37..dd3bce287a3d 100644
> --- a/drivers/media/platform/arm/mali-c55/mali-c55-isp.c
> +++ b/drivers/media/platform/arm/mali-c55/mali-c55-isp.c
> @@ -342,7 +342,6 @@ static int mali_c55_isp_enable_streams(struct v4l2_subdev *sd,
>   
>   	src_sd = media_entity_to_v4l2_subdev(isp->remote_src->entity);
>   
> -	isp->frame_sequence = 0;
>   	ret = mali_c55_isp_start(mali_c55, state);
>   	if (ret) {
>   		dev_err(mali_c55->dev, "Failed to start ISP\n");
> @@ -380,6 +379,7 @@ static int mali_c55_isp_disable_streams(struct v4l2_subdev *sd,
>   	isp->remote_src = NULL;
>   
>   	mali_c55_isp_stop(mali_c55);
> +	isp->frame_sequence = UINT_MAX;
>   
>   	return 0;
>   }
> @@ -584,6 +584,7 @@ int mali_c55_register_isp(struct mali_c55 *mali_c55)
>   	int ret;
>   
>   	isp->mali_c55 = mali_c55;
> +	isp->frame_sequence = UINT_MAX;
>   
>   	v4l2_subdev_init(sd, &mali_c55_isp_ops);
>   	sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE | V4L2_SUBDEV_FL_HAS_EVENTS;
> 
> base-commit: 95f76f51937fdfb0fc1e14cae606b1ef574a56f3

