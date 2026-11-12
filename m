Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794491423;
	b=cOx7zPc7Tx91pY2YRCtZJumD6xxJGm5MEK+BEAIszCxhqG3414sMBXPj1xaXffP0tIhm
	 VgAdL/Kydf4Prx9XBduYhoN6WNV5XaFY27TWLKvy2dTcwW4ygMgRFD6nKy7oSq6aIVbbj
	 5x+XYSC9s8cJbQ465dObveVxSVewtezL4clFxH647/ES7xobypz4zAnN0cjHOjuphuj5Y
	 7VAv+GNBT58Z6+OcwrOk9GCkrw+0PVMJudpMdmxRHQx7OzvxjPyTt1FbATDs4zcQ57geQ
	 D9Hsw9+1+rbqVY6GT07ZuvAA8NUg52sjSeqob8IY0bUi2BNnFHOsgXdYp6yVrrWTIXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794491423;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:From:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=AZ/2DY2hA/HMWVbI0xtLxP0KJxLR1RirVD6s8sQ4jc8=;
	b=eF+ODzBraY483LsZ8UCBTiT3kBCWCYGnzyYLUTGXEUrzaf6DN8tNw2tlyemoTVEVZpCT
	 AGwGiUsvfQbWgpTzMS5BEf3zZkqpezI3boHWC/ENCdN4olh/BRIg3J9+oozSpbvsntUsH
	 hVq8FpTwrQ56HCUcw4zNEBkOp7CRhHmwQy28FqI0z0BLN3Rjd0UB+8gdh9SSVrYOvTWU8
	 /xZn+2/uI2qJ8bP3m++FZ7cKwPxvZo/YbbVY5fhIH6/nOunpCtjMYyiPwMsVW7TD+p9Z8
	 ARscYfoh+BkV+Dx30SaEh+ffLWEFJdh6GDB2Qg71pz4rb53ytokFQOkjmAJOEPcpStw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GHHaMRdW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3559606A321;
	Thu, 12 Nov 2026 13:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GHHaMRdW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 521AD1F00A05;
	Thu, 12 Nov 2026 13:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794491422;
	bh=AZ/2DY2hA/HMWVbI0xtLxP0KJxLR1RirVD6s8sQ4jc8=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=GHHaMRdWdMUou3wbRT4ViUZUPJdwSfIjp87zf5WT8JaWwQVM2QF1iYTQeGhIH+pKY
	 3l4Qy27BMbJnjepWhImrQAtQyLvYpr3DWiX3f7UHk3K2Z3s6Sdb+bouJ18mr4b622K
	 PL6CszetbzHDSoclmLLOOYU0QL/WLBKK0KZlWC9heFlj4pJ8v53p0JNUWoEjNCngBE
	 Nwz8sYXrH94ePw3YfUqC/7EczMqsbplVR4PXMQyXz5G+S4qIg/HbGNbURd1j6OO9zo
	 PgLQvctzrQbkX9jamKkFVSGLd9+xFXAv7mmWquVaJUh1QXYxCymCuwyA6d86REuWez
	 gZH7Yip7Aa0Jw==
Message-ID: <de8171d4-b355-4fc1-8472-8682a897d928@kernel.org>
Date: Thu, 12 Nov 2026 14:50:19 +0100
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
Subject: Re: [PATCH] media: go7007: return queued buffers on start_streaming()
 failure
To: YuanZhe Liu <25031212351@stu.xidian.edu.cn>,
 Hans Verkuil <hverkuil@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Bin Yu <byu@xidian.edu.cn>,
 Cheng Wen <wencheng@xidian.edu.cn>
References: <20261016102213.42771-1-25031212351@stu.xidian.edu.cn>
Content-Language: en-US, nl
In-Reply-To: <20261016102213.42771-1-25031212351@stu.xidian.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/10/2026 12:22, YuanZhe Liu wrote:
> The vb2 framework hands ownership of every queued buffer to the driver
> through the buf_queue() callback before start_streaming() is called.  If
> start_streaming() then returns an error, the driver must return those
> buffers to vb2 with vb2_buffer_done() and VB2_BUF_STATE_QUEUED.
> Otherwise vb2_start_streaming() fires WARN_ON(owned_by_drv_count) and
> forcibly reclaims the buffers.
> 
> go7007_start_streaming() returns -EIO when go7007_start_encoder() fails,
> which happens for example when a USB transfer cannot be submitted because
> the device has been disconnected:
> 
>     go7007 1-1:1.0: error submitting audio urb 5: -2
>     go7007 1-1:1.0: error starting stream transfer
>     WARNING: drivers/media/common/videobuf2/videobuf2-core.c:1797 at vb2_start_streaming
> 
> but it leaves the already queued buffers on go->vidq_active.  Give them
> back to vb2 with VB2_BUF_STATE_QUEUED before bailing out, clearing
> go->active_buf as well.
> 
> Fixes: 7955f03d18d1 ("[media] go7007: move out of staging into drivers/media/usb.")
> Cc: stable@vger.kernel.org
> Co-developed-by: Bin Yu <byu@xidian.edu.cn>
> Signed-off-by: Bin Yu <byu@xidian.edu.cn>
> Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
> Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
> Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
> ---
>  drivers/media/usb/go7007/go7007-v4l2.c | 29 +++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/usb/go7007/go7007-v4l2.c b/drivers/media/usb/go7007/go7007-v4l2.c
> index 2087ffcb85a5..e0b646e8dad1 100644
> --- a/drivers/media/usb/go7007/go7007-v4l2.c
> +++ b/drivers/media/usb/go7007/go7007-v4l2.c
> @@ -394,6 +394,31 @@ static void go7007_buf_finish(struct vb2_buffer *vb)
>  	vbuf->field = V4L2_FIELD_NONE;
>  }
>  
> +/*
> + * Return all buffers that have been queued to the driver back to vb2.
> + *
> + * The vb2 framework hands ownership of every queued buffer to the driver
> + * before calling start_streaming().  If start_streaming() fails, those
> + * buffers must be returned with VB2_BUF_STATE_QUEUED, otherwise
> + * vb2_start_streaming() triggers WARN_ON(owned_by_drv_count).
> + */
> +static void go7007_return_queued_buffers(struct go7007 *go)
> +{
> +	struct go7007_buffer *vb, *tmp;
> +	unsigned long flags;
> +	LIST_HEAD(buffers);
> +
> +	spin_lock_irqsave(&go->spinlock, flags);
> +	list_splice_init(&go->vidq_active, &buffers);
> +	go->active_buf = NULL;
> +	spin_unlock_irqrestore(&go->spinlock, flags);

This part should not be needed: if go7007_start_encoder() fails, then active_buf is
still NULL.

> +
> +	list_for_each_entry_safe(vb, tmp, &buffers, list) {
> +		list_del(&vb->list);
> +		vb2_buffer_done(&vb->vb.vb2_buf, VB2_BUF_STATE_QUEUED);
> +	}
> +}
> +
>  static int go7007_start_streaming(struct vb2_queue *q, unsigned int count)
>  {
>  	struct go7007 *go = vb2_get_drv_priv(q);
> @@ -409,8 +434,10 @@ static int go7007_start_streaming(struct vb2_queue *q, unsigned int count)
>  	else
>  		ret = 0;
>  	mutex_unlock(&go->hw_lock);
> -	if (ret)
> +	if (ret) {
> +		go7007_return_queued_buffers(go);

I would just move the code from go7007_return_queued_buffers to here.

Regards,

	Hans

>  		return ret;
> +	}
>  	call_all(&go->v4l2_dev, video, s_stream, 1);
>  	v4l2_ctrl_grab(go->mpeg_video_gop_size, true);
>  	v4l2_ctrl_grab(go->mpeg_video_gop_closure, true);

