Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8213D902E
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 14:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782828636; cv=none; b=EQrS6LcdlRIbRqlGxY23/gYtK7NPoyhuRAvAIX5mdIiWPouodzhRaNsOUqGu4mmS5LSontnj21xUJxCp4YINBf/NifHdPfuN1L8vV3sD4r/csfFQMC2soAzPbMfgLovxUMh6+j0L2EL6T3vzOizW3SVUf9pyJsUPbl5p7xAjSZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782828636; c=relaxed/simple;
	bh=IJNiwnDhUaYxadbQfyXaJfgaQA2F6/sw4Kz1SI5XEA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CsPi5miTVtWw6YzPdg70irRevBWWBZaUCEWAOdOL2eixFzpDI9FpXEI7U4BDzRuzVl0rDyQcx8gAMCbWgmS6IyYDOd8YAb6kbx7ZL1vaYs64rP9xoSOsuNMEpvzcSozNY7qbg/ZxITvCGxkCtf/Fdcd1EUSNiHd70571+VsMAqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RXbD/JxL; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RXbD/JxL"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c1269e4721aso307103566b.0
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 07:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1782828632; x=1783433432; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VGuocZfEyF7VOWVQLWPnHwJJAM0ZAgJiH5ScPggGTw0=;
        b=RXbD/JxLbTD46ZSB1Bb9S/dgNyeJRfDpL0xrBX0ghgquySZSbCaAn07qELVNgD7eKv
         Vp/VH473Zucwn2+g53qoEpO309EuORYfUj3G8TCvbsM/8ka1d8Wfs/tMOHnlXBvXaNF1
         WCGtmzVNtx0H7Ptto1YfxPkjylZAIwq0Usw+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782828632; x=1783433432;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VGuocZfEyF7VOWVQLWPnHwJJAM0ZAgJiH5ScPggGTw0=;
        b=Z7meO8Qxe2bbBEGYTTZ8RDeoiA+mAcvl+QoS2gBbzlTdMNfMWGI1iG/zyJ0qj3O0Uk
         XbAdDrcBj+sfUpDyMigGcV0xC4IU9ZKbnFkFda6bxuaxQ3lYQWtbQD4ymFUASHpw25MH
         DWPcZQTGKu8Xy9gwiUY8PfUsErQBQCFZAvqSX2e4hgHu7oK32QlzvzH2aC7uhFfwD0ZK
         eJ8/nP7tXA9PFpUzVOjTRxfjBWqE0kSxBVS+xomwTo/sj0qbO8/pTCJPQFqCtx6Ab94w
         scKv1mimbao2F9wfWakP0XrLSBgTv/Mh1IaEGH0Eohu8nss+9TFzuPhaFP1VGTzapTsa
         r2nA==
X-Forwarded-Encrypted: i=1; AHgh+Rr/mXpiOwjse2BEft/LRytZjkDHsUPiWc4fTqRxsLrN6SauYIRIvGIgXY4S8wT9xgWkhBW7Mvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzicRSyEQzXBiCq/wr71PDru+pzEhIjqXB+NeEr/xYdF1PMKFWx
	oQCuByK8Ux33Yk+wXorA5iSbSLd/migacQKsFt3M6P/laraYEiuNe+SJ7QVsEBFwJW65mZB2Cuj
	gMuEgn+YN
X-Gm-Gg: AfdE7cl4f3Lr7m4eRvdxmIuOWDiPnQVsNByFq7c7QlDl7HFqVxxpIo3JEeeTTWyGb6r
	JLr7NctRgppM4jWbXY4OQ37qZ4cdTMX3fx9+nubGBbtto1Vz5GYLqSgICFXiLA+UPU+w/yxDQVu
	1MDpxMdqE7rksssrK8/gmlIo8XdYVj2wlcK9wva4BIzmvPFFpDBmEXc+zq+94Axp5/HbRao/JVK
	Lywuit8pdrE4BVZk6BtggqOVaMUiaHjqgQSY0Ay5zpgCLyf8ZgEUi77gBOPTWtTo+hyaGgmJMJO
	2ne6pyTC8fdZ/DvcpDuwyuVE+juWnOwmJzFkNRoQ4sYOT4MEwIaqmwYVIN7NC6DtBKo+DSPAMUS
	bNjkI14UY1ODkuNJyFzaeLCScjZhEEWu+arQgPl57qCrrltn3gku9sWAPGqCaWxEATcMnoUulFW
	WubcamMPT6Lc1X0dqkn+YKoqrlHDl6R85l7w9xAHbLusEqspzfMRvwXQcCjgWX
X-Received: by 2002:a17:907:6e8e:b0:c12:6db4:4bf9 with SMTP id a640c23a62f3a-c1297b7acddmr26358766b.1.1782828631447;
        Tue, 30 Jun 2026 07:10:31 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288d19ec9sm136711966b.2.2026.06.30.07.10.30
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 07:10:30 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c126e47a82cso278380366b.2
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 07:10:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqYKLxPENoPo9DyZySRnNRjTFOV/ZyAQ7WRs8Vd0HQM5ga1aRJxgCggkisWgbrotfcvOJwyQFI=@vger.kernel.org
X-Received: by 2002:a17:907:60d4:b0:c12:508a:2b49 with SMTP id
 a640c23a62f3a-c1297ee3b6emr36458666b.33.1782828628740; Tue, 30 Jun 2026
 07:10:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629-uvc-racemeta-v2-0-10e91d2afba0@chromium.org>
 <20260629-uvc-racemeta-v2-1-10e91d2afba0@chromium.org> <a0e4d412-f0bf-4415-9e4b-2c6347bf8c69@kernel.org>
 <CANiDSCtv_ZmTWUzbuxuEy0JmLmFs2Wqj31O3neGZ4ee=p065-g@mail.gmail.com> <5327bf8c-270e-4650-8f44-6026dce36457@kernel.org>
In-Reply-To: <5327bf8c-270e-4650-8f44-6026dce36457@kernel.org>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 30 Jun 2026 16:10:16 +0200
X-Gmail-Original-Message-ID: <CANiDSCskW6qhuGsDj2JN9UqAobAzqxEn7bKxVLZKEpEi0P9bWA@mail.gmail.com>
X-Gm-Features: AVVi8CdH2Hl8SFJfOlyAMPyCejMsszHUvfbC6ezyX0y8qPGPlvkHqFpXz75htDA
Message-ID: <CANiDSCskW6qhuGsDj2JN9UqAobAzqxEn7bKxVLZKEpEi0P9bWA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] media: uvcvideo: Fix race condition for meta
 buffer list
To: Hans de Goede <hansg@kernel.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Hans,

On Tue, 30 Jun 2026 at 15:21, Hans de Goede <hansg@kernel.org> wrote:
>
> Hi Ricardo,
>
> On 30-Jun-26 12:17, Ricardo Ribalda wrote:
> > Hi Hans,
> >
> > Thanks for the prompt reply.
> >
> > On Tue, 30 Jun 2026 at 11:47, Hans de Goede <hansg@kernel.org> wrote:
> >>
> >> Hi Ricardo,
> >>
> >> On 29-Jun-26 19:31, Ricardo Ribalda wrote:
> >>> queue->irqueue contains a list of the buffers owned by the driver. The
> >>> list is protected by queue->irqlock. uvc_queue_get_current_buffer()
> >>> returns a pointer to the current buffer in that list, but does not
> >>> remove the buffer from it. This can lead to race conditions.
> >>>
> >>> Inspecting the code, it seems that the candidate for such race is
> >>> uvc_queue_return_buffers(). For the capture queue, that function is
> >>> called with the device streamoff, so no race can occur. On the other
> >>> hand, the metadata queue, could trigger a race condition, because
> >>> stop_streaming can be called with the device in any streaming state.
> >>>
> >>> We can solve this issue introducing a flag, stream->meta.in_flight,
> >>> protected with a spinlock. When there is a buffer in flight that can
> >>> write into metadata the flag is raised, notifying the stop streaming
> >>> that it needs to wait.
> >>>
> >>> Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >>> Closes: https://lore.kernel.org/linux-media/20250630141707.GG20333@pendragon.ideasonboard.com/
> >>> Cc: stable@vger.kernel.org
> >>> Fixes: 088ead255245 ("media: uvcvideo: Add a metadata device node")
> >>> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> >>
> >> First of all thank you for looking into fixing this.
> >>
> >> I'm sorry, but this feels more like a band-aid then a proper fix.
> >>
> >> How about adding a started bool to struct uvc_streaming which gets
> >> set to 1 by uvc_video_start_streaming() and 0 by uvc_video_stop_streaming().
> >>
> >> And then call uvc_video_stop_streaming() from either
> >> uvc_stop_streaming_video() or uvc_stop_streaming_meta()
> >> depending on which one gets called first ?
> >>
> >> With a mutex protecting the started bool and being held
> >> over calling uvc_video_stop_streaming() ?
> >>
> >> So stop the actual hw streaming when either of the
> >> 2 possible /dev/video0 nodes gets its vb2_ops.stop_streaming
> >> callback called?
> >>
> >> And to this before draining the buffer queue.
> >>
> >> That seems cleaner then this approach?
> >
> > Assuming /dev/video0 is the video node and /dev/video1 is the meta device.
> >
> > Currently, we support something like:
> >
> > 1) yavta -c /dev/video0 &
> > 2) yavta --capture=2 /dev/video1
> > 3) yavta --capture=2 /dev/video1
> > 4) kill %1
> >
> >
> > If I understood correctly, your proposal would cause the camera to
> > stop streaming when step 2 completes.
>
> Yes. But this very much feels like a case of:
>
> https://quotefancy.com/media/wallpaper/1600x900/5523002-Henny-Youngman-Quote-The-patient-says-Doctor-it-hurts-when-I-do.jpg

We have a similar joke in Spanish:
Doctor, doctor, it hurts here, here, here, here, here. What do I have?
A broken finger :P

>
> > I think this risks breaking use cases.
>
> That would have to be some rather convoluted use-case.

I believe we have a similar scheme to test the metadata node in
ChromeOS... but we can change that.
My worry is the outside apps that we do not control.

>
> IMHO the simplicity of fixing the race you're trying to fix is
> worth the userspace regression risk (which I deem low).
>
> Worst case we revert the fix and go back to the drawing board.

Are you concerned of this asymmetric behaviour, or do you think that it is fine?

open /dev/video0 (streaming starts)
open /dev/video1
close /dev/video1 (streaming stops)
open /dev/video1 (streaming still off)


vs

open /dev/video0 (streaming starts)
open /dev/video1
close /dev/video0 (streaming stops)
open /dev/video0 (streaming resumes)


>
> > As I see it, the issue is that the camera's live capture cycle is
> > controlled solely by video0. We need some kind of synchronization
> > mechanism with video1 if we do not want to change the behaviour and
> > risk breaking apps.
>
> IMHO for a device with multiple /dev/video# nodes it makes sense
> to wait with actually starting streaming/DMA-engines until all
> enabled queues are started and stop when the first queue is stopped.
>
> The problem with uvcvideo is that we do not know if the metadata
> queue is going to get used at all. In hindsight we should maybe
> have had some way for userspace to explictly enable/disable metadata
> support.
>
> So we start as soon as the main video node is opened, still I think
> that stopping as soon as one of the queues is stopped makes sense.
>
> Laurent, do you have any input here?
>
> Regards,
>
> Hans
>
>
>
>
> >> p.s.
> >>
> >> 1. It is tempting to also apply the same approach to
> >> vb2_ops.start_streaming, but allowing the meta queue to be
> >> the one to start streaming will likely cause issues. E.g.
> >> the streaming code assumes having a meta-queue active is
> >> optional, but not the other way around.
> >>
> >> TL;DR: vb2_ops.start_streaming should stay as is.
> >>
> >> 2. While looking into this I noticed that struct uvc_streaming
> >> already has an active member, but unless I'm missing something
> >> that ever only gets initialized to 0. So I think that can be
> >> dropped. (If you re-use this please change it to a bool, no
> >> need to have it atomic while protected by a mutex).
> >
> > I will send a patch to fix this. Thanks for noticing :)
> >
> >>
> >>
> >>
> >>> ---
> >>>  drivers/media/usb/uvc/uvc_queue.c | 14 ++++++++++++++
> >>>  drivers/media/usb/uvc/uvc_video.c | 30 +++++++++++++++++++++++++++++-
> >>>  drivers/media/usb/uvc/uvcvideo.h  |  2 ++
> >>>  3 files changed, 45 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/media/usb/uvc/uvc_queue.c b/drivers/media/usb/uvc/uvc_queue.c
> >>> index 3c002c8f442f..af9dbfcf6f53 100644
> >>> --- a/drivers/media/usb/uvc/uvc_queue.c
> >>> +++ b/drivers/media/usb/uvc/uvc_queue.c
> >>> @@ -209,10 +209,24 @@ static void uvc_stop_streaming_video(struct vb2_queue *vq)
> >>>  static void uvc_stop_streaming_meta(struct vb2_queue *vq)
> >>>  {
> >>>       struct uvc_video_queue *queue = vb2_get_drv_priv(vq);
> >>> +     struct uvc_streaming *stream = queue->stream;
> >>>
> >>>       lockdep_assert_irqs_enabled();
> >>>
> >>> +     spin_lock_irq(&stream->meta.irqlock);
> >>> +     while (stream->meta.in_flight) {
> >>> +             spin_unlock_irq(&stream->meta.irqlock);
> >>> +             schedule();
> >>> +             spin_lock_irq(&stream->meta.irqlock);
> >>> +     }
> >>> +     stream->meta.in_flight = true;
> >>> +     spin_unlock_irq(&stream->meta.irqlock);
> >>> +
> >>>       uvc_queue_return_buffers(queue, UVC_BUF_STATE_ERROR);
> >>> +
> >>> +     scoped_guard(spinlock_irq, &stream->meta.irqlock) {
> >>> +             stream->meta.in_flight = false;
> >>> +     }
> >>>  }
> >>>
> >>>  static const struct vb2_ops uvc_queue_qops = {
> >>> diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> >>> index fc3536a4399f..f6b55b3a3308 100644
> >>> --- a/drivers/media/usb/uvc/uvc_video.c
> >>> +++ b/drivers/media/usb/uvc/uvc_video.c
> >>> @@ -1732,6 +1732,26 @@ static void uvc_video_encode_bulk(struct uvc_urb *uvc_urb,
> >>>       urb->transfer_buffer_length = stream->urb_size - len;
> >>>  }
> >>>
> >>> +static struct uvc_buffer *
> >>> +uvc_video_get_current_meta_buffer(struct uvc_streaming *stream)
> >>> +{
> >>> +     struct uvc_video_queue *queue = &stream->meta.queue;
> >>> +     struct uvc_buffer *buf;
> >>> +
> >>> +     buf = uvc_queue_get_current_buffer(queue);
> >>> +     if (!buf)
> >>> +             return NULL;
> >>> +
> >>> +     guard(spinlock_irqsave)(&stream->meta.irqlock);
> >>> +
> >>> +     if (stream->meta.in_flight)
> >>> +             return NULL;
> >>> +
> >>> +     stream->meta.in_flight = true;
> >>> +
> >>> +     return buf;
> >>> +}
> >>> +
> >>>  static void uvc_video_complete(struct urb *urb)
> >>>  {
> >>>       struct uvc_urb *uvc_urb = urb->context;
> >>> @@ -1767,7 +1787,7 @@ static void uvc_video_complete(struct urb *urb)
> >>>       buf = uvc_queue_get_current_buffer(queue);
> >>>
> >>>       if (vb2_qmeta)
> >>> -             buf_meta = uvc_queue_get_current_buffer(qmeta);
> >>> +             buf_meta = uvc_video_get_current_meta_buffer(stream);
> >>>
> >>>       /* Re-initialise the URB async work. */
> >>>       uvc_urb->async_operations = 0;
> >>> @@ -1778,6 +1798,12 @@ static void uvc_video_complete(struct urb *urb)
> >>>        */
> >>>       stream->decode(uvc_urb, buf, buf_meta);
> >>>
> >>> +     if (buf_meta) {
> >>> +             scoped_guard(spinlock_irqsave, &stream->meta.irqlock) {
> >>> +                     stream->meta.in_flight = false;
> >>> +             }
> >>> +     }
> >>> +
> >>>       /* If no async work is needed, resubmit the URB immediately. */
> >>>       if (!uvc_urb->async_operations) {
> >>>               ret = usb_submit_urb(uvc_urb->urb, GFP_ATOMIC);
> >>> @@ -2330,6 +2356,8 @@ int uvc_video_init(struct uvc_streaming *stream)
> >>>       for_each_uvc_urb(uvc_urb, stream)
> >>>               INIT_WORK(&uvc_urb->work, uvc_video_copy_data_work);
> >>>
> >>> +     spin_lock_init(&stream->meta.irqlock);
> >>> +
> >>>       return 0;
> >>>  }
> >>>
> >>> diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> >>> index b6bcee4a222f..6f1a3381d392 100644
> >>> --- a/drivers/media/usb/uvc/uvcvideo.h
> >>> +++ b/drivers/media/usb/uvc/uvcvideo.h
> >>> @@ -484,6 +484,8 @@ struct uvc_streaming {
> >>>               struct uvc_video_queue queue;
> >>>               u32 format;
> >>>               u32 buffersize;
> >>> +             bool in_flight;
> >>> +             spinlock_t irqlock; /* Protects in_flight. */
> >>>       } meta;
> >>>
> >>>       /* Context data used by the bulk completion handler. */
> >>>
> >>
> >
> >
>


-- 
Ricardo Ribalda
