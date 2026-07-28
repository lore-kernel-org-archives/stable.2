Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050F5430309;
	Tue, 28 Jul 2026 13:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785244867; cv=none; b=c+qvgTLaezLIKgClZ3lOtz/jp+xBDY3AjOvYU0bq2POjTRplZzdbuw4ApITCoZZrsUcdFBjb6o9/bBDIa2zpkVe5ygqRGkmEuTUtfLj1x4qNeqP5Z7eXmmzqiAiWqrjFFdTpadnNxI3i7dmvC7UmC8N4kw9n0zoQDTT96iiizoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785244867; c=relaxed/simple;
	bh=l2OI5XW6b4bUAvMGLAEq7yPgORw8FVO/LHpvIq84IyQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fmQeokiNtdor2Ro0fj/ScvqMGdHSpSOytUCdjFXhLrnsFjSfD58tkeEAxOgTIId4j3+qYFUC3V7wJCUilA3v34q3RlexIdfHX20odBd3s8DeFC0rhHU4N/mQYiPGXzTJjODYKLk2Lc8ZswWZI6LsLywScbKHKlrkCjr8c94tHpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/cLRW2o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/cLRW2o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D0D1F00A3E;
	Tue, 28 Jul 2026 13:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785244864;
	bh=tnyJE2XrVEsTWKnnEs8VPH1AQg7SPMsoOS3xHpjDqCA=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=L/cLRW2o1gtKb/NnlXnZoE6A2VCrxnOC3BH2wihMvVfQ468/Uk41hq6P1NVsvvwPC
	 xLYV7vDavOZaFVnczoeb1iN3VpGS3gCYj5YjEI0rgEgeCWwU25PGloZXEYW10qGh3E
	 +TzzPLZslDDsQw4td5rONIuknx5RIm63eRsC3xI80bQRxL/Heh+I8lRiHBrRjb7Z63
	 IRnIt24p0CusRHHnuS/8bxy1KoucsJO2XXoiHRU3eSkuztMDpEGVMC+MhI333E2ZWT
	 hcCu+fhDZFQNawTgiopZZh+Wwn+gPS73XCFinCLXFMkbIGiqHr3Q9QTzN5FruDL495
	 1CccTN4uBzwlA==
Message-ID: <4a5b7df7-265d-4a93-8987-a22568b17149@kernel.org>
Date: Tue, 28 Jul 2026 15:21:02 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: hverkuil+cisco@kernel.org
Subject: Re: [PATCH v2] media: cx231xx-audio: drain wq_trigger before audio
 fini
To: Fan Wu <fanwu01@zju.edu.cn>, mchehab@kernel.org
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260708141622.3936490-1-fanwu01@zju.edu.cn>
 <20260716134846.3132097-1-fanwu01@zju.edu.cn>
Content-Language: en-US, nl
In-Reply-To: <20260716134846.3132097-1-fanwu01@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/07/2026 15:48, Fan Wu wrote:
> audio_trigger() is deferred work (dev->wq_trigger) armed from
> snd_cx231xx_capture_trigger() on every PCM START/STOP; it dereferences
> dev->adev state and may free the URBs via cx231xx_isoc_audio_deinit().
> cx231xx_audio_fini() tore down that state without draining wq_trigger,
> so work armed before or racing fini ran against freed state.
> 
> Use disable_work_sync() in fini to drain the work and prevent further
> queueing.  Initialize the work, lock and stream_started counter at the
> top of cx231xx_audio_init(), before any fallible allocation, and clear
> the partially-built audio state on its error path, so fini is safe even
> if a later step fails.
> 
> This issue was found by an in-house static analysis tool.
> 
> Fixes: 61b04cb24a12 ("[media] cx231xx-audio: fix some locking issues")
> Cc: stable@vger.kernel.org # needs adjustments for <= 6.6: use cancel_work_sync()
> Link: https://lore.kernel.org/r/8c7e1294-b906-4636-890c-b64d03b0e1d0@kernel.org
> Assisted-by: Codex:gpt-5.6
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
> ---
> Changes in v2: use disable_work_sync() instead of a teardown flag +
> cancel_work_sync(), as suggested by Hans Verkuil.  The init-ordering
> fix and error-path cleanup from v1 are retained.
> ---
>  drivers/media/platform/ti/vpe/vip.c   | 37 ++++++++++++++++++++++++---
>  drivers/media/platform/ti/vpe/vpdma.c |  3 ++-

These are the ti/vpe patches, not the cx231xx patches!

Please repost.

Regards,

	Hans

>  2 files changed, 35 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/media/platform/ti/vpe/vip.c b/drivers/media/platform/ti/vpe/vip.c
> index cb0a5a07a3d4..30e9a85d4cf5 100644
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
> +	 * Unpublish the stream and quiesce its IRQ handler and recovery worker
> +	 * before releasing stream-owned resources.
> +	 */
> +	stream->port->cap_streams[stream->stream_id] = NULL;
> +	vip_quiesce_stream(stream);
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
> diff --git a/drivers/media/platform/ti/vpe/vpdma.c b/drivers/media/platform/ti/vpe/vpdma.c
> index 573aa83f62eb..f9f5b2f1ee1a 100644
> --- a/drivers/media/platform/ti/vpe/vpdma.c
> +++ b/drivers/media/platform/ti/vpe/vpdma.c
> @@ -988,7 +988,8 @@ void *vpdma_hwlist_release(struct vpdma_data *vpdma, int list_num)
>  
>  	spin_lock_irqsave(&vpdma->lock, flags);
>  	vpdma->hwlist_used[list_num] = false;
> -	priv = vpdma->hwlist_priv;
> +	priv = vpdma->hwlist_priv[list_num];
> +	vpdma->hwlist_priv[list_num] = NULL;
>  	spin_unlock_irqrestore(&vpdma->lock, flags);
>  
>  	return priv;

