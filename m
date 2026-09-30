Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3ECD5111AC;
	Wed, 30 Sep 2026 15:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790782555; cv=none; b=aSPYriyOh2H7MlC5pgS2m2r8+tGcFVLu+03ELq8/wKppUBjtjYXP1qozkVON4G6mYWmRp+i1rWj+J5eWbEjmPalPreWCyquW2gG8L9R4cCEWLIVXYtknktBwatXOdJStigLKZujonkJSZD6u5NaOMiDqqUF/M9JyFFwXC9EKYkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790782555; c=relaxed/simple;
	bh=pjXzmMKx+VT+YrCpTmZGCos4vMY7MFlGWXegA0QcZeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BTaxHgzPcJF1fF+X7qrtGADycb14mbzrlAxtJ1MNmhpJugEgB30RwMsJCfgJ6X0D05WzK/4X6RYwQyAY2Bi2qVBUXlueootdyl5qAeNXkGhaU22+cFlcyyFXOGBZUhMrNB4Q5pXTLehWJKUe4mp4SckpVU5AEJ3WFWPOarSxUpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=UtGyOGF/; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="UtGyOGF/"
Received: from ideasonboard.com (unknown [93.65.100.155])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 42999593;
	Wed, 30 Sep 2026 17:33:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1790782430;
	bh=pjXzmMKx+VT+YrCpTmZGCos4vMY7MFlGWXegA0QcZeA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UtGyOGF/BajmXqfTSeTjFBREK/VkApGKRYqfzPCw28PtFexr4CBnm9KfndIs9tp/b
	 rMJkgk5quyvquFJdCAIQ5uZkM6B98b1NCqhN8JwUarUEZCMffvXtZqdahiPWuK9goQ
	 YTwG14j/OCi6fisNxH291auDlN+bmJhxpq7AUcgM=
Date: Wed, 30 Sep 2026 17:35:39 +0200
From: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To: David Carlier <devnexen@gmail.com>
Cc: dan.scally@ideasonboard.com, jacopo.mondi@ideasonboard.com, 
	mchehab@kernel.org, nayden.kanchev@arm.com, hverkuil+cisco@kernel.org, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] media: mali-c55: Fix frame sequence numbers on dual-pipe
 hardware
Message-ID: <ar0r6Ej8JgH5Sj3c@zed>
References: <20260801205311.386692-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260801205311.386692-1-devnexen@gmail.com>

Hi David

On Sat, Aug 01, 2026 at 09:53:11PM +0100, David Carlier wrote:
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
> handled, and let mali_c55_set_plane_done() only read it. Initialise it
> to UINT_MAX so the first increment yields sequence zero. Hardware
> without the downscale pipe keeps the numbering it had before.
>
> Fixes: d5f281f3dd29 ("media: mali-c55: Add Mali-C55 ISP driver")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>  drivers/media/platform/arm/mali-c55/mali-c55-capture.c | 2 +-
>  drivers/media/platform/arm/mali-c55/mali-c55-core.c    | 1 +
>  drivers/media/platform/arm/mali-c55/mali-c55-isp.c     | 3 ++-
>  3 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/media/platform/arm/mali-c55/mali-c55-capture.c b/drivers/media/platform/arm/mali-c55/mali-c55-capture.c
> index ff01553026fb..7e1190d7fffc 100644
> --- a/drivers/media/platform/arm/mali-c55/mali-c55-capture.c
> +++ b/drivers/media/platform/arm/mali-c55/mali-c55-capture.c
> @@ -476,7 +476,7 @@ void mali_c55_set_plane_done(struct mali_c55_cap_dev *cap_dev,
>
>  	/* If the other plane is also done... */
>  	buf->vb.vb2_buf.timestamp = ktime_get_boottime_ns();
> -	buf->vb.sequence = isp->frame_sequence++;
> +	buf->vb.sequence = isp->frame_sequence;
>  	vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_DONE);
>  }
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

ISP_DONE and ISP_START interrupts might be handled together, if the
handling of DONE(n) interrupt is delayed enough to be handled at the
same time as START(n+1).

I would rather handle this with per-ouput queue counters ?

>  			mali_c55_isp_queue_event_sof(mali_c55);
>
>  			mali_c55_set_next_buffer(&mali_c55->cap_devs[MALI_C55_CAP_DEV_FR]);
> diff --git a/drivers/media/platform/arm/mali-c55/mali-c55-isp.c b/drivers/media/platform/arm/mali-c55/mali-c55-isp.c
> index e128adf6ee37..39178f6a1bd6 100644
> --- a/drivers/media/platform/arm/mali-c55/mali-c55-isp.c
> +++ b/drivers/media/platform/arm/mali-c55/mali-c55-isp.c
> @@ -342,7 +342,8 @@ static int mali_c55_isp_enable_streams(struct v4l2_subdev *sd,
>
>  	src_sd = media_entity_to_v4l2_subdev(isp->remote_src->entity);
>
> -	isp->frame_sequence = 0;
> +	/* first pre-increment at SOF yields sequence 0 */
> +	isp->frame_sequence = UINT_MAX;
>  	ret = mali_c55_isp_start(mali_c55, state);
>  	if (ret) {
>  		dev_err(mali_c55->dev, "Failed to start ISP\n");
> --
> 2.53.0
>
>
