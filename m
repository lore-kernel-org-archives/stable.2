Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874E147A89E
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 11:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790250132; cv=none; b=YxZdr/w4wcjNMkgHt1jfVhy9Fuf31+DWt3+Q7JL1fjpEQEL/YnSDFd5mWlMhJqyE0tB6YNx8nNQDCHOtMr9LcX3+CeKketMIPHOi8vKEYAUtdcLfklYpBP1Q9UP+cG5uQOdfjpz0O6vWQs/BId2FHQ2nYe6dxo67i0XiU/U+ogg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790250132; c=relaxed/simple;
	bh=6Ci/VEJZSM0bGfJtrVrGJaZlcyvyeDLOe93SO47o/Ls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Toj6tPPrAtbkKoMsoIri7zTQAqeINs0k7xX1R/4kZZ4e8D6Q7lVJ2nvTxQRfL+4+GXzvvt2qBAgAssSir/aRSyVtyc+SoyxH2SvrzEvRpUPPhBvw/ocMtJ/nUXkQb0hMPpy9s3RdNEUd1CxbXaSFjyzoIQ95IiSyl3emeOpeU2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HnUyyAqj; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HnUyyAqj"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccb1a98fso1350897a91.1
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 04:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790250126; x=1790854926; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VOOv2O6zq4PyMopt568prr5tiBYbBpQ3ybLcCpUCdfI=;
        b=HnUyyAqj4t7eUQBKHBoH6ym+Rj5Gv0LYC/jsoZLX6bz1u/QN1PTj/M9ctMCJEZmOs/
         ugqL/mwxoQuaCH9RJ3DtQ9rCG+OQfjn3n88BkwUAVRMcE2kQCVg3PwnyNExeNNawosxP
         QSupAMsP7qzeQpK3EsaP+Ci07SRAlNFUywJU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790250126; x=1790854926;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VOOv2O6zq4PyMopt568prr5tiBYbBpQ3ybLcCpUCdfI=;
        b=Gv2FXPVO6yyd7YHDTfLbU57kPKbURROL+7vRla4F/X7q+Uid10KFQK/LA2RyDfa4id
         +tmqz0R/QVtEm1RCGlxbtP9dxt42gLo1c+DPhm8NuBu2oDXKi/IFfhM1lpmazlWm0xUa
         vtQLpxPQ/fxNX/EOlcO7nBTGQTGGoFY2WWi3GgdE1LUGGFzjfZgQNJS7GGG7mnEAb0ni
         We0aqg0k7oo33s0Btw9Nv95Bxe2gaNq0ewqLbGPbziqaCyDc/ZBiaQMt77u7a2FEeBKj
         /VAxiHsjqMgmRy4JBG1jKEwA5yXk+uWGa69zVr9Fr3SN2tNgm6hENI6+fPtBVzF5V0Rv
         ADTg==
X-Forwarded-Encrypted: i=1; AKwUvBy22e57YP2C29yal5rchruaUwMM6T5blYOD2oFMD+gkNi93S9f+Bfk9816FOhsViR4rkqOLi3M=@vger.kernel.org
X-Gm-Message-State: AFuF++k8KuJCLLp8P97ONah7hlA/nZzY6MTceo1b2iSMHtKQXVnsg4M9
	E5PE1ixLAJzPbPEg54u1KaF3dALlueM4vzFbQI1dRXPAXUtLRj51rxNigh7w80sRiQn3eMqm3SE
	LRDFbaA==
X-Gm-Gg: AYBFou3/ry5k4mrVPS7Agc/AcC3J3ldVMw4H98U5ZXEjYoKS7u6Q1y+YEzWsQoIVQLl
	gEo2As9D1gATE+FPadypvcVVS2pu7FJO6EdzeyPiZlp+JS8uY1OrQVP3eZXNzyh6kvuuB7tcuy+
	QAl7+eYCNNxtTU/0dNIJOEmefRU1iHVGfr5dt/D3bc+m2ZhDrVc+vRtRGVWIe6VuQLVAqT2RsF+
	povg5FZUACcecXF+wzxGjtJLehg81iz+DYxIzyIs40BPeiplaa69j1ddZltkn1aKT04Y+r21k5d
	oD4QaeEyCtLX24DRsnHGyrcHQ4Su9NQqEXnK37df8MGfjrB8f2GYQpj9Up7Q6k/hpSVtYmk3xh3
	XT9NluXlWbn+TLW3clAJng+vPqEG0E5SFjp6An5ZDetVhgwhnsy2ZP3rhx/5bBZICjdc/npWxsT
	6jti6YTHikrfvxPxEa2McwjN4vCMBBDM8bjTHyP9UEEBZuYfEwux88EwDF84S90AQplTxQMUKd4
	jgEInIz3A/Hg+6AgNT2HPzvWUKM9/Ii+6NgQA==
X-Received: by 2002:a17:90b:1644:b0:3a0:345a:3646 with SMTP id 98e67ed59e1d1-3a098967e86mr2024304a91.45.1790250125524;
        Thu, 24 Sep 2026 04:42:05 -0700 (PDT)
Received: from mail-dl2-f36.google.com (mail-dl2-f36.google.com. [74.125.229.164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0972f2cddsm4757430a91.1.2026.09.24.04.42.04
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 04:42:04 -0700 (PDT)
Received: by mail-dl2-f36.google.com with SMTP id a92af1059eb24-14373bcc010so2076462c88.1
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 04:42:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwkqZXrYPOIT3bMKbSuAPTrgOyxMk6q3vikufYAy40Va8HzL9v90i5ZtOV8PXiA/XRvzLTVxlk=@vger.kernel.org
X-Received: by 2002:a05:7022:f508:b0:13c:dc9f:51c9 with SMTP id
 a92af1059eb24-14503f0e17emr1725764c88.12.1790250123198; Thu, 24 Sep 2026
 04:42:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903131141.6368-1-huhb1@xiaopeng.com> <20260917144630.16923-1-huhb04@gmail.com>
In-Reply-To: <20260917144630.16923-1-huhb04@gmail.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 24 Sep 2026 13:41:49 +0200
X-Gmail-Original-Message-ID: <CANiDSCvrcjTvZGoyYk1Ari3teaNEvorxk1YZL1LbLZxBzXepew@mail.gmail.com>
X-Gm-Features: AclHuK9Cen_qwGLrCLpHMX7fJkmbCIl91iGwSkSnidsxCDIu_h_ukU9-Qanppuw
Message-ID: <CANiDSCvrcjTvZGoyYk1Ari3teaNEvorxk1YZL1LbLZxBzXepew@mail.gmail.com>
Subject: Re: [PATCH v3] media: uvcvideo: defer cancelled buffer completion
 until copies finish
To: Hongbing Hu <huhb04@gmail.com>
Cc: laurent.pinchart@ideasonboard.com, hansg@kernel.org, mchehab@kernel.org, 
	kieran.bingham@ideasonboard.com, linux-media@vger.kernel.org, 
	linux5-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Hongbing

Something is wrong with your mail agent, it should not add:
In-Reply-To: <20260903131141.6368-1-huhb1@xiaopeng.com>
References: <20260903131141.6368-1-huhb1@xiaopeng.com>

Otherwise it is added to the previous email thread [1]

[1] https://lore.kernel.org/linux-media/20260917144630.16923-1-huhb04@gmail.com/

Have you looked into using b4 for contributing code? I find it much
simpler to use.

On Thu, 17 Sept 2026 at 16:47, Hongbing Hu <huhb04@gmail.com> wrote:
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
> 1. With the default (drop corrupted frames enabled), the old worker's
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
> Introduce a dedicated bool cancelled flag in struct uvc_buffer,this keeps
> the cancellation semantics explicit regardless of any later state updates
> from the packet decoder.
> Cancelled buffers are forced to complete as errors; normal malformed frames
> continue to be requeued or dropped as before.

I prefer my commit message [2], but I am probably biased :)

[2] https://lore.kernel.org/linux-media/CANiDSCuxtH1wbXAwoWrbV6Y97dN3Ym-A2zSbkEpLVEGFToXLfg@mail.gmail.com/

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
>         buf->state = UVC_BUF_STATE_QUEUED;
>         buf->error = 0;
> +       buf->cancelled = false;
>         buf->mem = vb2_plane_vaddr(vb, 0);
>         buf->length = vb2_plane_size(vb, 0);
>         if (vb->type != V4L2_BUF_TYPE_VIDEO_OUTPUT)
> @@ -289,10 +290,17 @@ int uvc_queue_init(struct uvc_streaming *stream, struct uvc_video_queue *queue,
>   */
>  void uvc_queue_cancel(struct uvc_video_queue *queue, int disconnect)
>  {
> +       struct uvc_buffer *buf;
>         unsigned long flags;
>
>         spin_lock_irqsave(&queue->irqlock, flags);
> -       __uvc_queue_return_buffers(queue, UVC_BUF_STATE_ERROR);
> +       while (!list_empty(&queue->irqqueue)) {
> +               buf = list_first_entry(&queue->irqqueue, struct uvc_buffer, queue);
> +               list_del(&buf->queue);
> +               buf->error = 1;
> +               buf->cancelled = true;
> +               uvc_queue_buffer_release(buf);
> +       }
>         /*
>          * This must be protected by the irqlock spinlock to avoid race
>          * conditions between uvc_buffer_queue and the disconnection event that
> @@ -356,7 +364,12 @@ static void uvc_queue_buffer_complete(struct kref *ref)

Please add a comment to the function header noting that if
buf->cancelled is true, this function may be called with
queue->irqlock held.

I am dreaming of a day where we can finally remove uvc_no_drop_param :)


>         struct vb2_buffer *vb = &buf->buf.vb2_buf;
>         struct uvc_video_queue *queue = vb2_get_drv_priv(vb->vb2_queue);
>
> -       if (buf->error && !uvc_no_drop_param) {
> +       /*
> +        * Buffers cancelled from uvc_queue_cancel() are forced to complete as
> +        * errors. They must not be requeued by the corrupted-frame policy even
> +        * when buf->error is set.
> +        */
> +       if (!buf->cancelled && buf->error && !uvc_no_drop_param) {
>                 uvc_queue_buffer_requeue(queue, buf);
>                 return;
>         }
> diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> index b6bcee4a22..1b611715fa 100644
> --- a/drivers/media/usb/uvc/uvcvideo.h
> +++ b/drivers/media/usb/uvc/uvcvideo.h
> @@ -317,6 +317,7 @@ struct uvc_buffer {
>
>         enum uvc_buffer_state state;
>         unsigned int error;
> +       bool cancelled;
>
>         void *mem;
>         unsigned int length;
> --
> 2.34.1
>

With the comment (and maybe a new commit message, up to you), feel
free to add my:

Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>


-- 
Ricardo Ribalda
