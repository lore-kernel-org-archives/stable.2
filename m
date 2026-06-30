Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF073EF649
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 10:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782814655; cv=none; b=iqtE3crbqrf3qa4wDn8airBya3MLSfnsuvtJfLXwQn1tf9mx0tUP8KJpJrYduvBR+ygRNSzDaX+G9gZaBKP4zNLqGEaOR/seM220oDLz5q0LEuGaHApvRbJkatf+TDlf7xcGhqj9nSHvxjru5P06RffeWiAuSAtGru27Wgogh8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782814655; c=relaxed/simple;
	bh=I1Qm67onnUx3+aBNG1G7KSZ0V2hHxDazuuRE58dDFu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b5GDPcdmLp+w1gYHDqbYDn5NqqlG2+SsUZFsNzg4fVdpUXhwNCCbKPYibJYkeJpQyNX4OYKC1z6ARqHwOO2O4fOFco9id7f1CsoXK0PgSzzljTZQr/lNVrCRgRk74J9tkfY543XCS+iY3gVHKNx/zIfB94trmaZrMHx3UqimE0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Xr8WVZjH; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xr8WVZjH"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6986578d8c0so3453624a12.1
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 03:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1782814649; x=1783419449; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Kenl4z+b5ADFgQxBu4DhaPDSzuS0lZBClA4yc0iErsI=;
        b=Xr8WVZjHA3tCMxVauIOvATJA4aQTuI0l8LQgTVGj3VIYhOMpqjOqhZ2l4hDnxhcAgc
         ztoz2qxif3/SwsdVJ0/aXpysxlNgilFpsWGyFIQhQFNdQ+wt0qU05ZdTLrDlTy75XMlV
         qb9k/DUhlLOv4613mHd+Q0Nr2m346xTl66f+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782814649; x=1783419449;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kenl4z+b5ADFgQxBu4DhaPDSzuS0lZBClA4yc0iErsI=;
        b=EK+P0cTWA/NdFJUPCKe3PabkE6Lz0OacyZw8UBSzEYY7oGdTxsHW8Ij/nEyzQO2HqZ
         hRdhwnCXHJnUnwU+4jF+m5Dc6aAgH3YWd46dM1NUD8g0qggMT4RoWXv14fi4R63X3X2B
         2QoEKMjWZbBkrEXcgd/6RmljHEpEpuFYQkyV6B6ekiv9N0eUzAYtcY95E9GwQUbdvEHo
         URYxcq5UyKduFWa5QYgcobw63UrazkCyKnz+xd4ldp3AQ6rNfmJilpeHY4NJ/60v/pam
         wESz6mfP2YiJ+SVHSfr8pLY59UzLKdwer+5FdLcwke+3FYU74MBi7UGTH+/CIPSc3smn
         IkbQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp3tapAeTLaLnlLUppzRYEEFkweD2G9ke3iQxFoznm0xoUJOJ5ZA3IU3g38LycvwpE2Bp0KhCk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyutbhpRMOojAAo2HmOWUnUCUbTKAdL65Gk/ZIUf39Z0zT5zKIe
	lg3Ytm1S5Q+5TcfaCU/ZpsW8XxiElebk50zgmpKNCThSRXXcufGY4hJlSBoM/3e3UNUj7ZV7EH0
	oiyhJcP2+
X-Gm-Gg: AfdE7cng06vrh+7VvgYThcZUbnC7720enPst1N86EV5N9LPKRuvGS9CIjk7Z3uArfGk
	fcYFKqMQjaEnVw8Q8ki8feLLnwBjpcZ8R1VjnQPc1ZMsL7ZSb91BCFqnJbjkWNCTBjdCNShf4/e
	R1GOGPanhscYH30J9qy0HkhpY+WNetwU/Y1yi+13Y+Jp7EiiV4oPG7MAqkzovyArWYc62vnJ0Q/
	SANDMXqwBwTiDYGGAJczarnvd0zuEAebZn7VKGJZrFvcbMj1UcwDeMfBxfhSPjKxwIMtccAa+rA
	O6zqDoMJzhkxLi0XuQMyGfrqD7Ep2GnRJ669PMhTjtsAdGa4NrkTX7UXA5n4LItSAKZxcVvPVNd
	Qd43FU3pTRCBpQansmO9KRib0Wj4PjLzBwpiiFR5nxRwLsioOUmUKUfjpOo83Np5r/Fsg9lF2II
	9DvfRjISG7wCG2/jVNOeETvQPOW7AzSjKlG5FvULf/G+Z6M0uKKVN6I4XDtM7C
X-Received: by 2002:a05:6402:350f:b0:698:52b4:c2c9 with SMTP id 4fb4d7f45d1cf-69879e0d835mr1394670a12.31.1782814648578;
        Tue, 30 Jun 2026 03:17:28 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6987c968201sm894665a12.24.2026.06.30.03.17.25
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 03:17:27 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c125c082ee2so232123466b.0
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 03:17:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rq/7LIlaxLeGQSDK02yTz2C/YyVc987R8tmKvBlfzUdbQwPZFDOFRJB7Dz/pBSZ5rRT3t6qrWA=@vger.kernel.org
X-Received: by 2002:a17:906:3b5a:b0:c11:fd32:33a2 with SMTP id
 a640c23a62f3a-c12872d677bmr95588266b.34.1782814644604; Tue, 30 Jun 2026
 03:17:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629-uvc-racemeta-v2-0-10e91d2afba0@chromium.org>
 <20260629-uvc-racemeta-v2-1-10e91d2afba0@chromium.org> <a0e4d412-f0bf-4415-9e4b-2c6347bf8c69@kernel.org>
In-Reply-To: <a0e4d412-f0bf-4415-9e4b-2c6347bf8c69@kernel.org>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 30 Jun 2026 12:17:11 +0200
X-Gmail-Original-Message-ID: <CANiDSCtv_ZmTWUzbuxuEy0JmLmFs2Wqj31O3neGZ4ee=p065-g@mail.gmail.com>
X-Gm-Features: AVVi8CcQvEIh8vdS6YSwyEb--6mLCsTlu9WGcgR5xhasRxc1tv3K3sQYopg7UBw
Message-ID: <CANiDSCtv_ZmTWUzbuxuEy0JmLmFs2Wqj31O3neGZ4ee=p065-g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] media: uvcvideo: Fix race condition for meta
 buffer list
To: Hans de Goede <hansg@kernel.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Hans,

Thanks for the prompt reply.

On Tue, 30 Jun 2026 at 11:47, Hans de Goede <hansg@kernel.org> wrote:
>
> Hi Ricardo,
>
> On 29-Jun-26 19:31, Ricardo Ribalda wrote:
> > queue->irqueue contains a list of the buffers owned by the driver. The
> > list is protected by queue->irqlock. uvc_queue_get_current_buffer()
> > returns a pointer to the current buffer in that list, but does not
> > remove the buffer from it. This can lead to race conditions.
> >
> > Inspecting the code, it seems that the candidate for such race is
> > uvc_queue_return_buffers(). For the capture queue, that function is
> > called with the device streamoff, so no race can occur. On the other
> > hand, the metadata queue, could trigger a race condition, because
> > stop_streaming can be called with the device in any streaming state.
> >
> > We can solve this issue introducing a flag, stream->meta.in_flight,
> > protected with a spinlock. When there is a buffer in flight that can
> > write into metadata the flag is raised, notifying the stop streaming
> > that it needs to wait.
> >
> > Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Closes: https://lore.kernel.org/linux-media/20250630141707.GG20333@pendragon.ideasonboard.com/
> > Cc: stable@vger.kernel.org
> > Fixes: 088ead255245 ("media: uvcvideo: Add a metadata device node")
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
>
> First of all thank you for looking into fixing this.
>
> I'm sorry, but this feels more like a band-aid then a proper fix.
>
> How about adding a started bool to struct uvc_streaming which gets
> set to 1 by uvc_video_start_streaming() and 0 by uvc_video_stop_streaming().
>
> And then call uvc_video_stop_streaming() from either
> uvc_stop_streaming_video() or uvc_stop_streaming_meta()
> depending on which one gets called first ?
>
> With a mutex protecting the started bool and being held
> over calling uvc_video_stop_streaming() ?
>
> So stop the actual hw streaming when either of the
> 2 possible /dev/video0 nodes gets its vb2_ops.stop_streaming
> callback called?
>
> And to this before draining the buffer queue.
>
> That seems cleaner then this approach?

Assuming /dev/video0 is the video node and /dev/video1 is the meta device.

Currently, we support something like:

1) yavta -c /dev/video0 &
2) yavta --capture=2 /dev/video1
3) yavta --capture=2 /dev/video1
4) kill %1


If I understood correctly, your proposal would cause the camera to
stop streaming when step 2 completes.

I think this risks breaking use cases.

As I see it, the issue is that the camera's live capture cycle is
controlled solely by video0. We need some kind of synchronization
mechanism with video1 if we do not want to change the behaviour and
risk breaking apps.

>
> Regards,
>
> Hans
>
> p.s.
>
> 1. It is tempting to also apply the same approach to
> vb2_ops.start_streaming, but allowing the meta queue to be
> the one to start streaming will likely cause issues. E.g.
> the streaming code assumes having a meta-queue active is
> optional, but not the other way around.
>
> TL;DR: vb2_ops.start_streaming should stay as is.
>
> 2. While looking into this I noticed that struct uvc_streaming
> already has an active member, but unless I'm missing something
> that ever only gets initialized to 0. So I think that can be
> dropped. (If you re-use this please change it to a bool, no
> need to have it atomic while protected by a mutex).

I will send a patch to fix this. Thanks for noticing :)

>
>
>
> > ---
> >  drivers/media/usb/uvc/uvc_queue.c | 14 ++++++++++++++
> >  drivers/media/usb/uvc/uvc_video.c | 30 +++++++++++++++++++++++++++++-
> >  drivers/media/usb/uvc/uvcvideo.h  |  2 ++
> >  3 files changed, 45 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_queue.c b/drivers/media/usb/uvc/uvc_queue.c
> > index 3c002c8f442f..af9dbfcf6f53 100644
> > --- a/drivers/media/usb/uvc/uvc_queue.c
> > +++ b/drivers/media/usb/uvc/uvc_queue.c
> > @@ -209,10 +209,24 @@ static void uvc_stop_streaming_video(struct vb2_queue *vq)
> >  static void uvc_stop_streaming_meta(struct vb2_queue *vq)
> >  {
> >       struct uvc_video_queue *queue = vb2_get_drv_priv(vq);
> > +     struct uvc_streaming *stream = queue->stream;
> >
> >       lockdep_assert_irqs_enabled();
> >
> > +     spin_lock_irq(&stream->meta.irqlock);
> > +     while (stream->meta.in_flight) {
> > +             spin_unlock_irq(&stream->meta.irqlock);
> > +             schedule();
> > +             spin_lock_irq(&stream->meta.irqlock);
> > +     }
> > +     stream->meta.in_flight = true;
> > +     spin_unlock_irq(&stream->meta.irqlock);
> > +
> >       uvc_queue_return_buffers(queue, UVC_BUF_STATE_ERROR);
> > +
> > +     scoped_guard(spinlock_irq, &stream->meta.irqlock) {
> > +             stream->meta.in_flight = false;
> > +     }
> >  }
> >
> >  static const struct vb2_ops uvc_queue_qops = {
> > diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> > index fc3536a4399f..f6b55b3a3308 100644
> > --- a/drivers/media/usb/uvc/uvc_video.c
> > +++ b/drivers/media/usb/uvc/uvc_video.c
> > @@ -1732,6 +1732,26 @@ static void uvc_video_encode_bulk(struct uvc_urb *uvc_urb,
> >       urb->transfer_buffer_length = stream->urb_size - len;
> >  }
> >
> > +static struct uvc_buffer *
> > +uvc_video_get_current_meta_buffer(struct uvc_streaming *stream)
> > +{
> > +     struct uvc_video_queue *queue = &stream->meta.queue;
> > +     struct uvc_buffer *buf;
> > +
> > +     buf = uvc_queue_get_current_buffer(queue);
> > +     if (!buf)
> > +             return NULL;
> > +
> > +     guard(spinlock_irqsave)(&stream->meta.irqlock);
> > +
> > +     if (stream->meta.in_flight)
> > +             return NULL;
> > +
> > +     stream->meta.in_flight = true;
> > +
> > +     return buf;
> > +}
> > +
> >  static void uvc_video_complete(struct urb *urb)
> >  {
> >       struct uvc_urb *uvc_urb = urb->context;
> > @@ -1767,7 +1787,7 @@ static void uvc_video_complete(struct urb *urb)
> >       buf = uvc_queue_get_current_buffer(queue);
> >
> >       if (vb2_qmeta)
> > -             buf_meta = uvc_queue_get_current_buffer(qmeta);
> > +             buf_meta = uvc_video_get_current_meta_buffer(stream);
> >
> >       /* Re-initialise the URB async work. */
> >       uvc_urb->async_operations = 0;
> > @@ -1778,6 +1798,12 @@ static void uvc_video_complete(struct urb *urb)
> >        */
> >       stream->decode(uvc_urb, buf, buf_meta);
> >
> > +     if (buf_meta) {
> > +             scoped_guard(spinlock_irqsave, &stream->meta.irqlock) {
> > +                     stream->meta.in_flight = false;
> > +             }
> > +     }
> > +
> >       /* If no async work is needed, resubmit the URB immediately. */
> >       if (!uvc_urb->async_operations) {
> >               ret = usb_submit_urb(uvc_urb->urb, GFP_ATOMIC);
> > @@ -2330,6 +2356,8 @@ int uvc_video_init(struct uvc_streaming *stream)
> >       for_each_uvc_urb(uvc_urb, stream)
> >               INIT_WORK(&uvc_urb->work, uvc_video_copy_data_work);
> >
> > +     spin_lock_init(&stream->meta.irqlock);
> > +
> >       return 0;
> >  }
> >
> > diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> > index b6bcee4a222f..6f1a3381d392 100644
> > --- a/drivers/media/usb/uvc/uvcvideo.h
> > +++ b/drivers/media/usb/uvc/uvcvideo.h
> > @@ -484,6 +484,8 @@ struct uvc_streaming {
> >               struct uvc_video_queue queue;
> >               u32 format;
> >               u32 buffersize;
> > +             bool in_flight;
> > +             spinlock_t irqlock; /* Protects in_flight. */
> >       } meta;
> >
> >       /* Context data used by the bulk completion handler. */
> >
>


-- 
Ricardo Ribalda
