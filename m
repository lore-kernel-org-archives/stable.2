Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794475810;
	b=lqoOPJ7jPSJ4gu+yk5blpNWyvTtdNcEfXLWxSm7tnLhw4sNT0HujtOsCe+/ExVKhFp8W
	 KdA9BisUicYCJRUJcPQ6cAd0o8tc1uiCeXt+xE6CZmlj1CExL6Uev5782Tjs/d/pRobNh
	 P9d8FjSmFk1UfSIYApr7XlnQ6k20U1S3KJbMjG8Fel+2BBFiscUsMMRh7Y0gD+4jRBHDd
	 +5y9+to4s90DRM4c5pIfaKpF2GkmcayI7sbESdmNYqPo1VUMh6ROIRIWhiBl6T1Zdi0kn
	 EAPYGSOxK9rVPcSSiLkhHUMg2Oszmpq8h+j7APVKQDdlD/YO6Vtg4xxDdmxCraumlxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794475810;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:From:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=vzevhNG5JFs0RVkSnfodtzB0p/zfyxnOobhhof5FUa0=;
	b=zljrdkGTqpdNeeuu9rVXUCxEG40FUHW8X+iCYttkNlABvwdFcqJCAJI/7nMtOEZ0Li00
	 uR4F9x6/CBKGYKTWxEQz4iORJJWwNebTkDhMsePeJGIZ2mHeIdC46F193k8A6Y+ucbDs7
	 0RMlOERjZuh4WKWeFd6SwppatqezZWKWDh8i4vz6uhDeNLJO+nTi1b3be0qhQeWXn2U5t
	 6wXq2aHX/gxe86NTLTatU/6xxDTGIsXUAiIBdgjTsrv720PI5kazYgcBjGMVZKw2s8r18
	 zapYZkGXXPd85Ma8o2LPdAUWXqQdYQpdD2l57gV8W5HFGpEOeAQ2Tm1fvd+sG6/emrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UemG+hYf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74322606A32A;
	Thu, 12 Nov 2026 09:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UemG+hYf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8055D1F00A05;
	Thu, 12 Nov 2026 09:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794475810;
	bh=vzevhNG5JFs0RVkSnfodtzB0p/zfyxnOobhhof5FUa0=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=UemG+hYfsMfdAnBPQczYzTD0GdeqV5TGqUDnBPR3BBSJ2GKHu6ULU4khLE/brhAc5
	 4wdObE+PA7quX56lAEIkIvOPPZLuqHdem02oMWADgOCIMvWIc5p282F5KUKWTfl/Yc
	 DrIHH3oxxmIHJ5jmr+UH6qn0JdwUTmaprdNluBnEpnPkUWczrTPnTTNQYxXmkzHx3P
	 7BEPr4nt1v22di8bR5uB9i9kUiwC8Exn5K1d1LgxZ6yFdd42zCUQfS1ibG235mkZrR
	 N8WfLmKKHJmJ+mofdchtPsAzHUr6w275Z1y/n/VkJCyph++X9v5puqQ5qz6pr0J3Yj
	 AGMvbULHvYsuw==
Message-ID: <8ee51709-5c3a-4708-b10d-86d172c4397b@kernel.org>
Date: Thu, 12 Nov 2026 10:30:06 +0100
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
Subject: Re: [PATCH v4] media: gspca: don't complete buffers before streaming
 has started
To: YuanZhe Liu <25031212351@stu.xidian.edu.cn>,
 Hans Verkuil <hverkuil@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Hans de Goede <hansg@kernel.org>,
 Bin Yu <byu@xidian.edu.cn>, Cheng Wen <wencheng@xidian.edu.cn>
References: <20261103161540.23947-1-25031212351@stu.xidian.edu.cn>
Content-Language: en-US, nl
In-Reply-To: <20261103161540.23947-1-25031212351@stu.xidian.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/11/2026 17:15, YuanZhe Liu wrote:
> gspca enables the data transfers before it knows whether start_streaming()
> will succeed: gspca_init_transfer() sets gspca_dev->streaming before the
> URBs are submitted, so an URB that has already been submitted can complete
> and gspca_frame_add() can hand its buffer to videobuf2 while the remaining
> URBs are still being submitted.
> 
> When one of those submissions fails, gspca_start_streaming() returns the
> buffers that are still queued to vb2 in QUEUED state, but the buffer that
> has already been completed is no longer on the driver's queue, and
> vb2_buffer_done() cannot take it back (it only accepts active buffers).
> vb2_start_streaming() then warns because the driver left a buffer on the
> done list although it failed to start:
> 
>  ------------[ cut here ]------------
>  WARNING: drivers/media/common/videobuf2/videobuf2-core.c:1821 at vb2_start_streaming+0x312/0x680
>  ...
>  Call Trace:
>   <TASK>
>   vb2_core_streamon+0x285/0x470
>   __vb2_init_fileio+0xdc1/0x1120
>   __vb2_perform_fileio+0xa7a/0x15e0
>   vb2_fop_read+0x219/0x3e0
>   v4l2_read+0x1fc/0x320
>   vfs_read+0x1d9/0x980
>   ksys_read+0x111/0x210
>  ...
>  gspca_main: set alt 0 err -19
>  gspca_main: usb_submit_urb alt 1 err -2
> 
> This was observed on a camera whose USB configuration was changed from
> userspace while a read() was starting the stream: the endpoint is removed,
> so usb_submit_urb() fails with -ENOENT, and the driver is unbound.
> 
> Do not hand a buffer to videobuf2 before the transfers are set up.  A frame
> that completes earlier is moved from the queue of free buffers to a pending
> list, and is given to videobuf2 only once gspca_init_transfer() reports
> success.  A failing start_streaming() therefore always leaves the done list
> empty, while the frame is not lost either: the subdrivers that restart
> their transfer from the frame completion callback (sq930x, se401) keep
> working when the very first frame completes inside that window.  When the
> start fails, the pending frames are put back on the driver's queue and
> gspca_start_streaming() returns them in QUEUED state with the others.
> 
> The frame has to be taken out of the queue of free buffers: it is that
> queue's first entry, so the next frame would take the same buffer and
> overwrite the completed one, which would then never reach videobuf2.
> 
> The state of the frame being received is now also reset when a lower
> alternate setting is retried, so that the packets of the retried transfer
> cannot be appended to a frame left over from the previous one.
> 
> A driver side flag is needed because videobuf2 sets q->streaming before
> calling start_streaming() when VIDIOC_STREAMON comes in with fewer buffers
> queued than min_queued_buffers, and start_streaming() is then called later
> from vb2_core_qbuf(), with the first URBs possibly already completed.  The
> flag is cleared when gspca_init_transfer() starts rather than when the
> stream is stopped: gspca_suspend() does not go through gspca_stream_off(),
> and gspca_resume() calls gspca_init_transfer() directly.
> 
> Fixes: 1f5965c4dfd7 ("media: gspca: convert to vb2")
> Cc: stable@vger.kernel.org
> Co-developed-by: Bin Yu <byu@xidian.edu.cn>
> Signed-off-by: Bin Yu <byu@xidian.edu.cn>
> Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
> Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
> Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
> ---
> Changes in v4:
> - Move the frames that complete before the transfers are set up to a separate
>   pending list.  Leaving them in the queue of free buffers, as v3 did, did
>   not protect them: the completed frame was still that queue's first entry,
>   so the next FIRST_PACKET took the same buffer and overwrote the frame,
>   which was then never handed to videobuf2.  The subdrivers that send
>   FIRST_PACKET right after LAST_PACKET (etoms, ov519, konica, nw80x) hit
>   that on every start.
> - Put the pending frames back on the queue in gspca_return_all_buffers(), so
>   a failed start still returns every buffer to videobuf2.
>  drivers/media/usb/gspca/gspca.c | 58 ++++++++++++++++++++++++++++++---
>  drivers/media/usb/gspca/gspca.h |  2 ++
>  2 files changed, 55 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/media/usb/gspca/gspca.c b/drivers/media/usb/gspca/gspca.c
> index 594d73e50b9f..1232f5d10bae 100644
> --- a/drivers/media/usb/gspca/gspca.c
> +++ b/drivers/media/usb/gspca/gspca.c
> @@ -392,7 +392,7 @@ void gspca_frame_add(struct gspca_dev *gspca_dev,
>  	spin_unlock_irqrestore(&gspca_dev->qlock, flags);
>  
>  	if (packet_type == FIRST_PACKET) {
> -		/* if there is no queued buffer, discard the whole frame */
> +		/* If there is no queued buffer, discard the whole frame */
>  		if (!buf) {
>  			gspca_dev->last_packet_type = DISCARD_PACKET;
>  			gspca_dev->sequence++;
> @@ -439,11 +439,10 @@ void gspca_frame_add(struct gspca_dev *gspca_dev,
>  	 * next first packet, wake up the application and advance
>  	 * in the queue */
>  	if (packet_type == LAST_PACKET) {
> +		bool ready;
> +
>  		if (gspca_dev->image_len > gspca_dev->pixfmt.sizeimage)
>  			gspca_dev->image_len = gspca_dev->pixfmt.sizeimage;
> -		spin_lock_irqsave(&gspca_dev->qlock, flags);
> -		list_del(&buf->list);
> -		spin_unlock_irqrestore(&gspca_dev->qlock, flags);
>  		buf->vb.vb2_buf.timestamp = ktime_get_ns();
>  		vb2_set_plane_payload(&buf->vb.vb2_buf, 0,
>  				      gspca_dev->image_len);
> @@ -451,7 +450,25 @@ void gspca_frame_add(struct gspca_dev *gspca_dev,
>  		buf->vb.field = V4L2_FIELD_NONE;
>  		gspca_dbg(gspca_dev, D_FRAM, "frame complete len:%d\n",
>  			  gspca_dev->image_len);
> -		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_DONE);
> +		/*
> +		 * The frame can complete before gspca_init_transfer() has set
> +		 * up all the transfers: the first URB can complete while the
> +		 * others are still being submitted, and a submission can then
> +		 * fail.  Videobuf2 requires that start_streaming() leaves its
> +		 * done list empty in that case, and a completed buffer cannot
> +		 * be taken back, so the frame is only released to videobuf2
> +		 * once the transfers are known to be set up.  Until then it is
> +		 * parked on the pending list, out of reach of the next frame.
> +		 */
> +		spin_lock_irqsave(&gspca_dev->qlock, flags);
> +		ready = gspca_dev->streaming_ready;
> +		if (ready)
> +			list_del(&buf->list);
> +		else
> +			list_move_tail(&buf->list, &gspca_dev->pending);
> +		spin_unlock_irqrestore(&gspca_dev->qlock, flags);
> +		if (ready)
> +			vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_DONE);
>  		gspca_dev->image = NULL;
>  		gspca_dev->image_len = 0;
>  	}
> @@ -732,6 +749,7 @@ static int create_urbs(struct gspca_dev *gspca_dev,
>  static void gspca_stream_off(struct gspca_dev *gspca_dev)
>  {
>  	gspca_dev->streaming = false;
> +	gspca_dev->streaming_ready = false;
>  	gspca_dev->usb_err = 0;
>  	if (gspca_dev->sd_desc->stopN)
>  		gspca_dev->sd_desc->stopN(gspca_dev);
> @@ -745,6 +763,26 @@ static void gspca_stream_off(struct gspca_dev *gspca_dev)
>  	gspca_dbg(gspca_dev, D_STREAM, "stream off OK\n");
>  }
>  
> +/*
> + * The transfers are set up: from now on the frames are handed to videobuf2
> + * as soon as they are complete.  Release the ones that completed while the
> + * URBs were being submitted, they could not be completed earlier because
> + * start_streaming() could still have failed.
> + */
> +static void gspca_flush_pending_frames(struct gspca_dev *gspca_dev)
> +{
> +	struct gspca_buffer *buf, *node;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&gspca_dev->qlock, flags);
> +	gspca_dev->streaming_ready = true;
> +	list_for_each_entry_safe(buf, node, &gspca_dev->pending, list) {
> +		list_del(&buf->list);
> +		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_DONE);
> +	}
> +	spin_unlock_irqrestore(&gspca_dev->qlock, flags);
> +}
> +
>  /*
>   * start the USB transfer
>   */
> @@ -760,6 +798,7 @@ static int gspca_init_transfer(struct gspca_dev *gspca_dev)
>  	gspca_dev->image = NULL;
>  	gspca_dev->image_len = 0;
>  	gspca_dev->last_packet_type = DISCARD_PACKET;
> +	gspca_dev->streaming_ready = false;
>  
>  	gspca_dev->usb_err = 0;
>  
> @@ -870,6 +909,10 @@ static int gspca_init_transfer(struct gspca_dev *gspca_dev)
>  		/* the bandwidth is not wide enough
>  		 * negotiate or try a lower alternate setting */
>  retry:
> +		/* the frame of the previous transfer is lost */
> +		gspca_dev->image = NULL;
> +		gspca_dev->image_len = 0;
> +		gspca_dev->last_packet_type = DISCARD_PACKET;
>  		gspca_err(gspca_dev, "alt %d - bandwidth not wide enough, trying again\n",
>  			  alt);
>  		msleep(20);	/* wait for kill complete */
> @@ -887,6 +930,8 @@ static int gspca_init_transfer(struct gspca_dev *gspca_dev)
>  		}
>  	}
>  out:
> +	if (ret >= 0)
> +		gspca_flush_pending_frames(gspca_dev);
>  	gspca_input_create_urb(gspca_dev);
>  	return ret;
>  }

This patch feels far too complicated. Isn't the problem simply that gspca_init_transfer
sets gspca_dev->streaming too early?

I don't really want to make such a large change for this very old and rarely used
driver.

Regards,

	Hans

> @@ -1338,6 +1383,8 @@ static void gspca_return_all_buffers(struct gspca_dev *gspca_dev,
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&gspca_dev->qlock, flags);
> +	/* the frames that never reached videobuf2 are still queued */
> +	list_splice_init(&gspca_dev->pending, &gspca_dev->buf_list);
>  	list_for_each_entry_safe(buf, node, &gspca_dev->buf_list, list) {
>  		vb2_buffer_done(&buf->vb.vb2_buf, state);
>  		list_del(&buf->list);
> @@ -1518,6 +1565,7 @@ int gspca_dev_probe2(struct usb_interface *intf,
>  	gspca_dev->vdev.queue = q;
>  
>  	INIT_LIST_HEAD(&gspca_dev->buf_list);
> +	INIT_LIST_HEAD(&gspca_dev->pending);
>  	spin_lock_init(&gspca_dev->qlock);
>  
>  	/* configure the subdriver and initialize the USB device */
> diff --git a/drivers/media/usb/gspca/gspca.h b/drivers/media/usb/gspca/gspca.h
> index a6554d5e9e1a..93f304787cd4 100644
> --- a/drivers/media/usb/gspca/gspca.h
> +++ b/drivers/media/usb/gspca/gspca.h
> @@ -187,6 +187,7 @@ struct gspca_dev {
>  	__u8 last_packet_type;
>  	__s8 empty_packet;		/* if (-1) don't check empty packets */
>  	bool streaming;
> +	bool streaming_ready;		/* buffers can be completed */
>  
>  	__u8 curr_mode;			/* current camera mode */
>  	struct v4l2_pix_format pixfmt;	/* current mode parameters */
> @@ -196,6 +197,7 @@ struct gspca_dev {
>  
>  	spinlock_t qlock;
>  	struct list_head buf_list;
> +	struct list_head pending;	/* completed, not given to videobuf2 yet */
>  
>  	wait_queue_head_t wq;		/* wait queue */
>  	struct mutex usb_lock;		/* usb exchange protection */

