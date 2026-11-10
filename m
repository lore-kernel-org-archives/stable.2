Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316975;
	b=HXwjnuJ9+DKKsILxCl6HgNutPwFb/KgGKz/Hu7IaSSe4gFHNvL0kyvh6wkV1m61T+H8S
	 uIqP/HBqwADx7yeGxXHAruZg7RaLtfadFjoFFPlWPdl3EyvonnC8lPisp54zR/nQwJG/u
	 wWHJlE6jK1s11PEhM7RqDrZldehy0KUNS1qtwqOzzBdM8N7UqXzeMq2JOrnIodsUtwHsw
	 KdVXBkMb0NTb7YX+TD6tC01pioHeqHLq+m7eLJNjB0CTaA5whts5Gq7o5BfxEeQsMoz6o
	 xO8CLRzpGFldaBiUqrrFTQoHqzrF7HtyUymPqM5XeR3nkk3rV3BG9VBRQSH5ec/j9Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316975;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=XeO964uUPSLwtzP70XsCBAGb4qL+qATxOz1wVc1F6Dg=;
	b=DBHqkx5Ea80XEiTimBpVf1tM930MvnZykCvz5WmsN3cKi5PI5zoCpZS7DWrSVHxVKg+/
	 ncqXTaBfabUS8UkZr0bQyrSwuPGLlneZ7qYA/z3/8I4wb0iy0SBIbGnnE5PJ9CBdeM3Xw
	 kIJjdQ/VYJh94yPIsPKodUhLis/82ATXnBx1oUL+bCILtjEyQI1U27MWktFSvwT0PLG2m
	 ZlIHMPlim6cVF19+TJgI0jNZMhT2t4vOC5oMYS/MvBZ9q0QWwsaGh9IMlVdio/6xMyGja
	 NBAnSDX13W1oRou7mTxu/qpctGk4ngoTskgKtfuQiLZzfGr2w8lCKcjEY8E4uwt4xmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=TthVUSRr;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F1E606A76F;
	Tue, 10 Nov 2026 13:22:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42F1E606A76F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=TthVUSRr
Received: from ideasonboard.com (unknown [93.65.100.155])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 51F2CC14;
	Tue, 10 Nov 2026 14:20:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1794316829;
	bh=h6z6z5gce8U4pqtxTIISYTaxBt5TCij7rxt3To8CkhM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TthVUSRr5ZaK9b2P3huwddCCvt864ORCPxjaPJbs7IHY8/2zmTk0tBipPz/14nqyW
	 Pf9lYKUCrM66jYYwWdashBWVBKkqQ6y16WLes8034DZFg84nbQJD0PAK1UYrRYFqUU
	 7tJok+8Iu/10N7YfkwA98kwHadaoAHd35L+aJ1gE=
Date: Tue, 10 Nov 2026 14:22:48 +0100
From: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To: David Carlier <devnexen@gmail.com>
Cc: Daniel Scally <dan.scally@ideasonboard.com>, 
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Nayden Kanchev <nayden.kanchev@arm.com>, Hans Verkuil <hverkuil+cisco@kernel.org>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] media: mali-c55: Fix frame sequence numbers on
 dual-pipe hardware
Message-ID: <avMX7TrGYCUl8c4C@zed>
References: <20260930174621.791831-1-devnexen@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260930174621.791831-1-devnexen@gmail.com>

Hi David

On Wed, Sep 30, 2026 at 06:46:21PM +0100, David Carlier wrote:
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

Sorry to ask, this is not meant to be detrimental to the value of this
patch, but in these days I feel like I should ask:

- is this an error found running the system with an FR/DS pipeline
- is this a report from an LLM

Mostly I'm curious to know as I can't test on a system with a DS pipe
fitted, knowing you actually tested this would make me more confident
in accepting the patch

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
> v2:
>  - Stamp the buffer sequence in mali_c55_set_next_buffer() instead of
>    at completion, which broke when START(n+1) and DONE(n) are handled
>    together (Jacopo)
>  - Reset the counter when the ISP stops instead of when it starts
>
> v1: https://lore.kernel.org/r/20260801205311.386692-1-devnexen@gmail.com
> ---
>  drivers/media/platform/arm/mali-c55/mali-c55-capture.c | 5 +++--
>  drivers/media/platform/arm/mali-c55/mali-c55-common.h  | 4 ++++
>  drivers/media/platform/arm/mali-c55/mali-c55-core.c    | 1 +
>  drivers/media/platform/arm/mali-c55/mali-c55-isp.c     | 3 ++-
>  4 files changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/media/platform/arm/mali-c55/mali-c55-capture.c b/drivers/media/platform/arm/mali-c55/mali-c55-capture.c
> index ff01553026fb..fa073ce4b2bd 100644
> --- a/drivers/media/platform/arm/mali-c55/mali-c55-capture.c
> +++ b/drivers/media/platform/arm/mali-c55/mali-c55-capture.c
> @@ -413,6 +413,9 @@ void mali_c55_set_next_buffer(struct mali_c55_cap_dev *cap_dev)
>  		return;
>  	}
>
> +	/* The buffer is written out during the frame following this one. */
> +	buf->vb.sequence = cap_dev->mali_c55->isp.frame_sequence + 1;
> +
>  	pix_mp = &cap_dev->format.format;
>
>  	mali_c55_cap_dev_update_bits(cap_dev, MALI_C55_REG_Y_WRITER_MODE,
> @@ -457,7 +460,6 @@ void mali_c55_set_next_buffer(struct mali_c55_cap_dev *cap_dev)
>  void mali_c55_set_plane_done(struct mali_c55_cap_dev *cap_dev,
>  			     enum mali_c55_planes plane)
>  {
> -	struct mali_c55_isp *isp = &cap_dev->mali_c55->isp;
>  	struct mali_c55_buffer *buf;
>
>  	scoped_guard(spinlock, &cap_dev->buffers.processing_lock) {
> @@ -476,7 +478,6 @@ void mali_c55_set_plane_done(struct mali_c55_cap_dev *cap_dev,
>
>  	/* If the other plane is also done... */
>  	buf->vb.vb2_buf.timestamp = ktime_get_boottime_ns();
> -	buf->vb.sequence = isp->frame_sequence++;
>  	vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_DONE);
>  }
>
> diff --git a/drivers/media/platform/arm/mali-c55/mali-c55-common.h b/drivers/media/platform/arm/mali-c55/mali-c55-common.h
> index 13a3e9dc4243..50f2b7a85f62 100644
> --- a/drivers/media/platform/arm/mali-c55/mali-c55-common.h
> +++ b/drivers/media/platform/arm/mali-c55/mali-c55-common.h
> @@ -76,6 +76,10 @@ struct mali_c55_isp {
>  	struct media_pad *remote_src;
>  	/* Mutex to guard vb2 start/stop streaming */
>  	struct mutex capture_lock;
> +	/*
> +	 * Sequence of the frame being processed, incremented at SOF. Held at
> +	 * UINT_MAX while stopped so the first frame gets sequence 0.
> +	 */
>  	unsigned int frame_sequence;
>  };
>
> diff --git a/drivers/media/platform/arm/mali-c55/mali-c55-core.c b/drivers/media/platform/arm/mali-c55/mali-c55-core.c
> index fb81141d1653..be562156b295 100644
> --- a/drivers/media/platform/arm/mali-c55/mali-c55-core.c
> +++ b/drivers/media/platform/arm/mali-c55/mali-c55-core.c
> @@ -573,6 +573,7 @@ static irqreturn_t mali_c55_isr(int irq, void *context)
>  	for_each_set_bit(i, &interrupt_status, MALI_C55_NUM_IRQ_BITS) {
>  		switch (i) {
>  		case MALI_C55_IRQ_ISP_START:
> +			mali_c55->isp.frame_sequence++;
>  			mali_c55_isp_queue_event_sof(mali_c55);
>
>  			mali_c55_set_next_buffer(&mali_c55->cap_devs[MALI_C55_CAP_DEV_FR]);
> diff --git a/drivers/media/platform/arm/mali-c55/mali-c55-isp.c b/drivers/media/platform/arm/mali-c55/mali-c55-isp.c
> index e128adf6ee37..dd3bce287a3d 100644
> --- a/drivers/media/platform/arm/mali-c55/mali-c55-isp.c
> +++ b/drivers/media/platform/arm/mali-c55/mali-c55-isp.c
> @@ -342,7 +342,6 @@ static int mali_c55_isp_enable_streams(struct v4l2_subdev *sd,
>
>  	src_sd = media_entity_to_v4l2_subdev(isp->remote_src->entity);
>
> -	isp->frame_sequence = 0;
>  	ret = mali_c55_isp_start(mali_c55, state);
>  	if (ret) {
>  		dev_err(mali_c55->dev, "Failed to start ISP\n");
> @@ -380,6 +379,7 @@ static int mali_c55_isp_disable_streams(struct v4l2_subdev *sd,
>  	isp->remote_src = NULL;
>
>  	mali_c55_isp_stop(mali_c55);
> +	isp->frame_sequence = UINT_MAX;
>
>  	return 0;
>  }
> @@ -584,6 +584,7 @@ int mali_c55_register_isp(struct mali_c55 *mali_c55)
>  	int ret;
>
>  	isp->mali_c55 = mali_c55;
> +	isp->frame_sequence = UINT_MAX;

The patch looks ok to me:
Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>

but I wish we could test it.

Knowing the current frame counter stamping is broken already makes it
easier for me to collect this patch.

>
>  	v4l2_subdev_init(sd, &mali_c55_isp_ops);
>  	sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE | V4L2_SUBDEV_FL_HAS_EVENTS;
>
> base-commit: 95f76f51937fdfb0fc1e14cae606b1ef574a56f3
> --
> 2.55.0
>
