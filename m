Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F8035F5E7;
	Tue, 28 Jul 2026 11:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785236825; cv=none; b=efzQz1gtXX+5OW/ve1H7e+1DvmPr02EdZcUZWQW44UQFAD6LsZzFznLF+HA4s5pEcatiVb4GNmIrXuSpY/9U5e7HHRARGuFwcW0Cpy2hABmiDh2jYv8p3oHBfFFjNQT/3Gj6KEhDN9v9hKReo7x5odouGiGTejH52uIyPF+TrKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785236825; c=relaxed/simple;
	bh=/dyVoCgacFxJ+p6AYLgch3xMsuHZujp10LCUCNiYUDk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=k2ASS4yhYNrN8io0RcfKzHA4/sAr8oarmSTfT1yv1fjmBwIERROnkzfnnJVxVixDTrZmnohND9bLPS8uTR2OoWC45AGOCbNoMdBX1JXz5ul0oyzc5Lr0pvCsh34iEGmQnjchQh2oYMtc4U9w4+iQqJLYX2s3oSU7IlM077HhwyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OeYjbgoE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OeYjbgoE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC1001F000E9;
	Tue, 28 Jul 2026 11:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785236823;
	bh=k/LTqdPGuwExzf4wtGtZksVH9GEKvU1dyU5kkDSeuzY=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=OeYjbgoECs72wQQXAXiSAuaaDg7hVnn+GdOqygcKzl56OYErFzErteUg8yzVouMR1
	 q2WVp2jbrpz/g+UoXl4bCIOeA+iwi4D0yVnm8R8pLLxMJqdNdFH4uL6oKg2l803lH8
	 d/7EtOYixvmSyztkTxIqeSIUYB1pQXzhtwSjTF9lOa3qBVMdT2WeSZvb0+7KTcSQI3
	 u5NmpK6rTmOO6bmW2KvSrsdJlSIIPlECLUEMrJV+a4uvCmJjiDEsIDp4EosIGf2h+X
	 rgFySqsSDUXDjD94b3hNrhuo7UG3XtWwfTqnmDDq9N0ibVdFj2RHlNxlXjolSOIgya
	 GFwaEFzrmK6YQ==
Message-ID: <bf618e7c-6b18-4015-aa4d-9d08c86d5577@kernel.org>
Date: Tue, 28 Jul 2026 13:06:58 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: hverkuil+cisco@kernel.org
Subject: Re: [PATCH v4] media: ti: vpe: quiesce overflow recovery before
 freeing streams
To: Fan Wu <fanwu01@zju.edu.cn>, mchehab@kernel.org
Cc: y-abhilashchandra@ti.com, bparrot@ti.com, dale@farnsworth.org,
 dagriego@biglakesoftware.com, sbellary@baylibre.com,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <801025b7-a3b8-4655-af49-f9bb65254170@kernel.org>
 <20260716113230.3131086-1-fanwu01@zju.edu.cn>
Content-Language: en-US, nl
In-Reply-To: <20260716113230.3131086-1-fanwu01@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/07/2026 13:32, Fan Wu wrote:
> The VIP overflow recovery worker is armed from the hardirq handler when a
> FIFO overflow is detected, and the list-complete path looks the stream up
> through the VPDMA list private pointer. Both keep touching stream, port
> and device state; the recovery worker also resets the parser and VPDMA,
> repopulates the descriptor list, and re-enables the per-list IRQs.
> 
> vip_stop_streaming() masks and clears the per-list IRQs, but it neither
> synchronizes the hardirq handler nor disables recovery_work. An overflow
> IRQ that has already queued recovery_work, or a list-complete IRQ in
> flight when the stream is torn down, can therefore still dereference the
> stream after its resources are released: the descriptor list is freed by
> vip_release_stream() on file release, and the stream itself by
> free_stream() on unbind/remove.
> 
> Drain the recovery worker and the IRQ handler at both teardown points
> through a shared vip_quiesce_stream() helper, before any stream-owned
> resource is released. disable_work_sync() cancels pending recovery_work,
> drains a running instance, and raises its disable depth, so a subsequent
> schedule_work() issued by a racing IRQ handler is rejected at the
> workqueue scheduler: recovery_work cannot be requeued after
> disable_work_sync() takes effect. The worker may still re-enable the
> per-list IRQs before disable_work_sync() returns; disable_irqs() then
> masks those sources and synchronize_irq() waits for any in-flight handler
> that still dereferences stream state. In vip_stop_streaming() the helper
> runs before the parser is stopped, since a worker drained by
> disable_work_sync() may re-enable the parser before exiting and would
> otherwise undo the stop. recovery_work is created disabled and enabled in
> vip_start_streaming() before IRQs, pairing the enable with the teardown
> disable across the streaming lifecycle.
> 
> This issue was found by an in-house static analysis tool and confirmed
> by manual code review.
> 
> Fixes: fc2873aa4a21 ("media: ti: vpe: Add the VIP driver")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
> ---
> Changes in v4:
> - Drop the unrelated vpdma_hwlist_release() cleanup from this fix (Hans
>   Verkuil).
> - In free_stream(), call vip_quiesce_stream() before clearing
>   cap_streams[], so the stream remains published while in-flight IRQ
>   handling is drained (Hans Verkuil).

Ah, I already merged v3, so v4 doesn't apply.

Can you post a new patch that sits on top of the current media-committers/next
tree?

Thank you,

	Hans

> 
> Changes in v3:
> - Replace the per-stream irq_rearm_allowed flag and the repeated IRQ
>   disable/synchronize_irq() in vip_quiesce_stream() with the workqueue
>   disable-depth API (disable_work_sync/enable_work/disable_work), as
>   suggested by Yemike Abhilash Chandra. This also closes a window the v2
>   double-drain left open, where its second synchronize_irq() waited for
>   the in-flight handler but did not cancel the recovery_work it had
>   requeued, so that work could run after free.
> - Create recovery_work disabled and enable it in vip_start_streaming()
>   before IRQs.
> - In vip_stop_streaming(), quiesce before stopping the parser: a worker
>   drained by disable_work_sync() may re-enable the parser before exiting,
>   so stopping the parser first would be undone.
> 
> Changes in v2:
> - Drain the overflow recovery worker at both teardown points through a
>   shared vip_quiesce_stream() helper: vip_stop_streaming() (file release
>   path) and free_stream() (unbind/remove). v1 drained only in
>   free_stream().
> - Document how the issue was found and that the patch was prepared with
>   LLM assistance (Assisted-by trailer and body note).
> 
> Link: https://lore.kernel.org/r/20260708013738.110752-1-fanwu01@zju.edu.cn/
> ---
>  drivers/media/platform/ti/vpe/vip.c | 37 +++++++++++++++++++++++++----
>  1 file changed, 33 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/platform/ti/vpe/vip.c b/drivers/media/platform/ti/vpe/vip.c
> index cb0a5a07a3d4..673f9addfade 100644
> --- a/drivers/media/platform/ti/vpe/vip.c
> +++ b/drivers/media/platform/ti/vpe/vip.c
> @@ -814,6 +814,22 @@ static void clear_irqs(struct vip_dev *dev, int irq_num, int list_num)
>  	vpdma_clear_list_stat(dev->shared->vpdma, irq_num, dev->slice_id);
>  }
>  
> +/*
> + * Quiesce recovery work and per-list IRQs before releasing stream resources.
> + * disable_work_sync() prevents the overflow handler from requeueing recovery
> + * work. Mask and synchronize IRQs afterwards because a running worker may
> + * have re-enabled them before exiting.
> + */
> +static void vip_quiesce_stream(struct vip_stream *stream)
> +{
> +	struct vip_dev *dev = stream->port->dev;
> +
> +	disable_work_sync(&stream->recovery_work);
> +	disable_irqs(dev, dev->slice_id, stream->list_num);
> +	clear_irqs(dev, dev->slice_id, stream->list_num);
> +	synchronize_irq(dev->irq);
> +}
> +
>  static void populate_desc_list(struct vip_stream *stream)
>  {
>  	struct vip_port *port = stream->port;
> @@ -2428,6 +2444,7 @@ static int vip_start_streaming(struct vb2_queue *vq, unsigned int count)
>  		goto err;
>  
>  	stream->num_recovery = 0;
> +	enable_work(&stream->recovery_work);
>  
>  	clear_irqs(dev, dev->slice_id, stream->list_num);
>  	enable_irqs(dev, dev->slice_id, stream->list_num);
> @@ -2452,13 +2469,17 @@ static void vip_stop_streaming(struct vb2_queue *vq)
>  	struct vip_dev *dev = port->dev;
>  	int ret;
>  
> +	/*
> +	 * A running recovery worker may re-enable the parser, so quiesce it
> +	 * and its IRQ handler before stopping the parser or releasing the
> +	 * descriptor list.
> +	 */
> +	vip_quiesce_stream(stream);
> +
>  	vip_parser_stop_imm(port, true);
>  	vip_enable_parser(port, false);
>  	unset_fmt_params(stream);
>  
> -	disable_irqs(dev, dev->slice_id, stream->list_num);
> -	clear_irqs(dev, dev->slice_id, stream->list_num);
> -
>  	if (port->subdev) {
>  		ret = v4l2_subdev_call(port->subdev, video, s_stream, 0);
>  		if (ret)
> @@ -3074,6 +3095,8 @@ static int alloc_stream(struct vip_port *port, int stream_id, int vfl_type)
>  		goto do_free_hwlist;
>  
>  	INIT_WORK(&stream->recovery_work, vip_overflow_recovery_work);
> +	/* Start disabled; vip_start_streaming() enables it before IRQs. */
> +	disable_work(&stream->recovery_work);
>  
>  	INIT_LIST_HEAD(&stream->vidq);
>  
> @@ -3139,6 +3162,13 @@ static void free_stream(struct vip_stream *stream)
>  		return;
>  
>  	dev = stream->port->dev;
> +	/*
> +	 * Quiesce the IRQ handler and recovery worker, then drop the stream
> +	 * from cap_streams[], before releasing stream-owned resources.
> +	 */
> +	vip_quiesce_stream(stream);
> +	stream->port->cap_streams[stream->stream_id] = NULL;
> +
>  	/* Free up the Drop queue */
>  	list_for_each_safe(pos, q, &stream->dropq) {
>  		buf = list_entry(pos,
> @@ -3150,7 +3180,6 @@ static void free_stream(struct vip_stream *stream)
>  
>  	video_unregister_device(stream->vfd);
>  	vpdma_hwlist_release(dev->shared->vpdma, stream->list_num);
> -	stream->port->cap_streams[stream->stream_id] = NULL;
>  	kfree(stream);
>  }
>  

