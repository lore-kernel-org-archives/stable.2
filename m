Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4BC21B192
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 15:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783523896; cv=none; b=g12hucjLFR8B2bcGPEnBZUgEfFCHVMbNqhF0GjaIInrRkJUCXW/60fqfFx51p8pn7vKYy3abM2YH/QuU7idk/zWMPLi8aG9/uFhFacBCB7cP0JRvQQ8fOuQYCm192DzJX5p2ACLhPyzv07FHXHgYih/QOVHGo9BBeS+gdUh+vOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783523896; c=relaxed/simple;
	bh=H8v/NRHqdZ7121n28dcb9g2vGaJ/GORo4Z0EN4wChFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PM7VaNGp3PcDJaF0/w5nnGM7byq/HotJ94sF205zYsJ0pECSyCSCKY32nbbdjDrRcvoODMNthxKhIepbQTBss2IYhkG4ybpILrmCCzZdzPmsKe1pf+9fdXBwIXyzDeOOD7+7hPe269yarL+2ePA6vZmEXWxNnk3ljPDFfT6gJ4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Rdd44GTV; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Rdd44GTV"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c12a1a3cdb9so90008566b.0
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 08:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1783523892; x=1784128692; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tdrMFy/jEt5jrkgpI35n0yi23kbpoKeT5n3yCmjxUnU=;
        b=Rdd44GTVpyhvL1v7/q2fu958Mt6TQyFMrhht9QamgAAX5QDM7KHbQJI6fTHD86QBRT
         lAUPUvAuhFui/hntoLctuXbNQQ2sWpmAgnU7kNoFCISll4vcDIDFVUn/qcgVc7IVZK02
         zvM7czn5w7paN1B/fnNAGeklIUGhE92on8phk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783523892; x=1784128692;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tdrMFy/jEt5jrkgpI35n0yi23kbpoKeT5n3yCmjxUnU=;
        b=liYYo65jEcdIskt/fhYK+8h7Z0fJBq2zssQdckiGqTfM2x8JnBljOKW5agGk7sQsRk
         Pobab5iX8lBx9/Sh1xgvytCzheBsoXNwMW58WA1JxZs8SNXI3t6mSvUBGjaOXlihrWF+
         8pgSCFjtEVYNv2J8B8l3yrCPDHXrN3JUrel4qSIt2/1zXShlRx75M8a5Pt+W+32M5e5P
         8b5OD05ZI7t3J0UDPiX47HDwvn/HvA7DCtIF5sjhjScsNnk6FBsG5rJWGyOLFGGOC1ux
         Cly4ZEfXswGRByzHge7dff03wD10LGg4ZPfSvdWgqxJop9I4L235y0kp4rfpMiKxrJIf
         IAZg==
X-Forwarded-Encrypted: i=1; AHgh+Rrpk98kK7EyZxhs6EbP3MAeC4qD7gWTGW/byQ9LGFTswkw2HJD1dSuQIK+fWMKYZi8pxn+C8L8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc0yMuR8PY5yd9qyfOPU5eInIAv3nXXMtrwhF0XELcsNDTv+6r
	weIgTSKU8gqNSL4XAxVbt9SzyrLHT1TGYZD3a6JnBlKJUwNoZnIFfOMwGxonPNxQvFeVdFgqq8s
	VqnM6Hg==
X-Gm-Gg: AfdE7cncoAEkwXzjti+tCSM6a+fIlP8/D9Yk33HC8GKU/qWA1TVl9SYc36v2UfJSoMH
	qvVQ1SIJgEkTjYKA7GK2eAy4Zklwp4eCSOgpTwIKa09e6r1ts8fURtclyDKBgxx3Je/63H2sAEh
	Q+z/Vk+8/60hbzjiXDJwQYjgGWp/MdGhgkBuXbpRZKphJpw+nxGEIY33fhu3I70oo4PifGmIVLX
	fG38FLnIHgKPogS9lzQoUnYOcF6ByVukCDJVYvo//ULu3QXANkLudQsgkS/wcgt95Bo2+AjfSpf
	vVq6sseHcPFeHpSleV2McMNXa3hDln5ZLVBsFsOaVLN3I/VntZcK7tUFvUS05LYiBHJBSJ/pUmj
	HcY7JwkkoVYAfxXdgwpIRF2PqzqB6CN7EAo9S2eWObhOdSiJwL6PA7svK92vovE/w8AEfUonrC8
	320oXXX5jwTH7rkJAWnkjcQhcrmtowG10/U6r46/EQj2RjObWDLg==
X-Received: by 2002:a17:907:1c04:b0:c12:e178:9e96 with SMTP id a640c23a62f3a-c15cdeb92c5mr147364866b.14.1783523892330;
        Wed, 08 Jul 2026 08:18:12 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15d3859f69sm117335366b.27.2026.07.08.08.18.10
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 08:18:10 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-69a5ecbbfb2so1419956a12.2
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 08:18:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqgmomOryZk9/9FO3vL944AYFgbOeA0DMF5pxSaixhNBoiwe6sLgweWAjYk2OyTTMoI1rp2JlQ=@vger.kernel.org
X-Received: by 2002:a17:907:e153:b0:c12:61c5:c141 with SMTP id
 a640c23a62f3a-c15ce1180demr100718366b.53.1783523889597; Wed, 08 Jul 2026
 08:18:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629-uvc-racemeta-v2-0-10e91d2afba0@chromium.org>
 <20260629-uvc-racemeta-v2-1-10e91d2afba0@chromium.org> <a0e4d412-f0bf-4415-9e4b-2c6347bf8c69@kernel.org>
 <CANiDSCtv_ZmTWUzbuxuEy0JmLmFs2Wqj31O3neGZ4ee=p065-g@mail.gmail.com>
 <5327bf8c-270e-4650-8f44-6026dce36457@kernel.org> <CANiDSCskW6qhuGsDj2JN9UqAobAzqxEn7bKxVLZKEpEi0P9bWA@mail.gmail.com>
 <15b919c9-158a-45ca-8566-bf20447d397c@kernel.org> <CANiDSCuO5aEApqHxy6uqZheza7hgdOkH38sY5YhO_xAxSYAJbg@mail.gmail.com>
In-Reply-To: <CANiDSCuO5aEApqHxy6uqZheza7hgdOkH38sY5YhO_xAxSYAJbg@mail.gmail.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 8 Jul 2026 17:17:56 +0200
X-Gmail-Original-Message-ID: <CANiDSCsO9_VgQdb4_=cayf_jKdy6CCf=+VmJyBWrD0wwXGeXYA@mail.gmail.com>
X-Gm-Features: AVVi8CeS1jux9xKn1HjEeIbXjePrhV-PC1dyZBo-cSnSuXsrQSNSHp3Zf5PQ3JI
Message-ID: <CANiDSCsO9_VgQdb4_=cayf_jKdy6CCf=+VmJyBWrD0wwXGeXYA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] media: uvcvideo: Fix race condition for meta
 buffer list
To: Hans de Goede <hansg@kernel.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Ricardo :P

On Wed, 8 Jul 2026 at 12:57, Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> Hi Hans
>
> On Wed, 1 Jul 2026 at 17:30, Hans de Goede <hansg@kernel.org> wrote:
> >
> > Hi Ricardo,
> >
> > On 30-Jun-26 16:10, Ricardo Ribalda wrote:
> > > Hi Hans,
> > >
> > > On Tue, 30 Jun 2026 at 15:21, Hans de Goede <hansg@kernel.org> wrote:
> > >>
> > >> Hi Ricardo,
> > >>
> > >> On 30-Jun-26 12:17, Ricardo Ribalda wrote:
> > >>> Hi Hans,
> > >>>
> > >>> Thanks for the prompt reply.
> > >>>
> > >>> On Tue, 30 Jun 2026 at 11:47, Hans de Goede <hansg@kernel.org> wrote:
> > >>>>
> > >>>> Hi Ricardo,
> > >>>>
> > >>>> On 29-Jun-26 19:31, Ricardo Ribalda wrote:
> > >>>>> queue->irqueue contains a list of the buffers owned by the driver. The
> > >>>>> list is protected by queue->irqlock. uvc_queue_get_current_buffer()
> > >>>>> returns a pointer to the current buffer in that list, but does not
> > >>>>> remove the buffer from it. This can lead to race conditions.
> > >>>>>
> > >>>>> Inspecting the code, it seems that the candidate for such race is
> > >>>>> uvc_queue_return_buffers(). For the capture queue, that function is
> > >>>>> called with the device streamoff, so no race can occur. On the other
> > >>>>> hand, the metadata queue, could trigger a race condition, because
> > >>>>> stop_streaming can be called with the device in any streaming state.
> > >>>>>
> > >>>>> We can solve this issue introducing a flag, stream->meta.in_flight,
> > >>>>> protected with a spinlock. When there is a buffer in flight that can
> > >>>>> write into metadata the flag is raised, notifying the stop streaming
> > >>>>> that it needs to wait.
> > >>>>>
> > >>>>> Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > >>>>> Closes: https://lore.kernel.org/linux-media/20250630141707.GG20333@pendragon.ideasonboard.com/
> > >>>>> Cc: stable@vger.kernel.org
> > >>>>> Fixes: 088ead255245 ("media: uvcvideo: Add a metadata device node")
> > >>>>> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > >>>>
> > >>>> First of all thank you for looking into fixing this.
> > >>>>
> > >>>> I'm sorry, but this feels more like a band-aid then a proper fix.
> > >>>>
> > >>>> How about adding a started bool to struct uvc_streaming which gets
> > >>>> set to 1 by uvc_video_start_streaming() and 0 by uvc_video_stop_streaming().
> > >>>>
> > >>>> And then call uvc_video_stop_streaming() from either
> > >>>> uvc_stop_streaming_video() or uvc_stop_streaming_meta()
> > >>>> depending on which one gets called first ?
> > >>>>
> > >>>> With a mutex protecting the started bool and being held
> > >>>> over calling uvc_video_stop_streaming() ?
> > >>>>
> > >>>> So stop the actual hw streaming when either of the
> > >>>> 2 possible /dev/video0 nodes gets its vb2_ops.stop_streaming
> > >>>> callback called?
> > >>>>
> > >>>> And to this before draining the buffer queue.
> > >>>>
> > >>>> That seems cleaner then this approach?
> > >>>
> > >>> Assuming /dev/video0 is the video node and /dev/video1 is the meta device.
> > >>>
> > >>> Currently, we support something like:
> > >>>
> > >>> 1) yavta -c /dev/video0 &
> > >>> 2) yavta --capture=2 /dev/video1
> > >>> 3) yavta --capture=2 /dev/video1
> > >>> 4) kill %1
> > >>>
> > >>>
> > >>> If I understood correctly, your proposal would cause the camera to
> > >>> stop streaming when step 2 completes.
> > >>
> > >> Yes. But this very much feels like a case of:
> > >>
> > >> https://quotefancy.com/media/wallpaper/1600x900/5523002-Henny-Youngman-Quote-The-patient-says-Doctor-it-hurts-when-I-do.jpg
> > >
> > > We have a similar joke in Spanish:
> > > Doctor, doctor, it hurts here, here, here, here, here. What do I have?
> > > A broken finger :P
> > >
> > >>
> > >>> I think this risks breaking use cases.
> > >>
> > >> That would have to be some rather convoluted use-case.
> > >
> > > I believe we have a similar scheme to test the metadata node in
> > > ChromeOS... but we can change that.
> >
> > That seems unlikely? Either I would expect some app/lib/dameon to
> > do a quick test stream for a few frames at init time to determine metadata
> > support, in which case I would expect streaming on both queues to get
> > stopped after the quick test.
> >
> > Or testing is delayed till the first real start-streaming moment in which
> > case it makes no sense to stop + restart the metadata queue. What I guess
> > may happen is stopping the metadata queue when it does not generate any
> > data for a few frames, assuming there simply is no metadata support.
> >
> > Hmm, that might actually be a troublesome case.
> >
> > > My worry is the outside apps that we do not control.
> >
> > Ack, thinking more about this, this might be more likely then
> > I assumed in the non metadata available case, see above.
> >
> > So I'm no longer really convinced of my own proposal.
> >
> > >> IMHO the simplicity of fixing the race you're trying to fix is
> > >> worth the userspace regression risk (which I deem low).
> > >>
> > >> Worst case we revert the fix and go back to the drawing board.
> > >
> > > Are you concerned of this asymmetric behaviour, or do you think that it is fine?
> > >
> > > open /dev/video0 (streaming starts)
> > > open /dev/video1
> > > close /dev/video1 (streaming stops)
> > > open /dev/video1 (streaming still off)
> > >
> > >
> > > vs
> > >
> > > open /dev/video0 (streaming starts)
> > > open /dev/video1
> > > close /dev/video0 (streaming stops)
> > > open /dev/video0 (streaming resumes)
> >
> > That second one actually is broken already, we don't flush
> > the metadata queue on streaming stop on the regular queue, so
> > it will possibly contain a half-filled metadata buffer which
> > we then continue to append to with fresh metadata. So any
> > multi-packet metadata will get corrupted for the first frame
> > in the second stream start in that case.
>
> Luckily for us, it is currently "kind of" working.
>
> uvc_stop_streaming_video() -> uvc_video_stop_streaming() ->
> uvc_video_stop_transfer() -> usb_poison_urb()
>
> This usually (though I do not think always) forces an -ENOENT at the
> URBs callback:
>
> uvc_video_complete() -> uvc_queue_cancel(qmeta) -> uvc_queue_return_buffers()
>
> I will send a patch to explicitly call uvc_queue_return_buffers(qmeta)
> in uvc_stop_streaming_video() so we don't have to rely on this
> implicit behavior.
>
> But I have a question: Do we *really* need to call
> __uvc_queue_return_buffers() from uvc_queue_cancel() if it is properly
> handled in uvc_stop_streaming_video()?

Yes we do. Otherwise if userspace is locked in dqbuf and a usb error
happens, userspace will be locked forever.
Could we probably add a flag or something to avoid the 5x
__uvc_queue_return_buffers(), probably... but worth it? Nahhh


>
> A side effect of relying on the URB cancellation is that we end up
> performing one flush per URB, which is not really needed. For example:
>
> 41 (1) [-] none 176 5500 B 15166.417603 15166.449738 16.665 fps ts mono/SoE
> 42 (2) [-] none 177 5478 B 15166.477640 15166.509783 16.656 fps ts mono/SoE
> 43 (3) [-] none 178 5522 B 15166.537639 15166.569758 16.667 fps ts mono/SoE
> 44 (4) [E] none 0 0 B 0.000000 15166.599067 -0.000 fps ts mono/SoE
> 45 (5) [E] none 0 0 B 0.000000 15166.599115 0.000 fps ts mono/SoE
> 46 (6) [E] none 0 0 B 0.000000 15166.599125 0.000 fps ts mono/SoE
> 47 (7) [E] none 0 0 B 0.000000 15166.599133 0.000 fps ts mono/SoE
> 48 (0) [E] none 0 0 B 0.000000 15166.599141 0.000 fps ts mono/SoE
> 49 (1) [E] none 0 0 B 0.000000 15166.599148 0.000 fps ts mono/SoE
> 50 (2) [E] none 0 0 B 0.000000 15166.599157 0.000 fps ts mono/SoE
> 51 (3) [E] none 0 0 B 0.000000 15166.599167 0.000 fps ts mono/SoE
> 52 (4) [E] none 0 0 B 0.000000 15166.599177 0.000 fps ts mono/SoE
> 53 (5) [E] none 0 0 B 0.000000 15166.599187 0.000 fps ts mono/SoE
> 54 (6) [E] none 0 0 B 0.000000 15166.599197 0.000 fps ts mono/SoE
> 55 (7) [E] none 0 0 B 0.000000 15166.599224 0.000 fps ts mono/SoE
> 56 (0) [E] none 0 0 B 0.000000 15166.599234 0.000 fps ts mono/SoE
> 57 (1) [E] none 0 0 B 0.000000 15166.599243 0.000 fps ts mono/SoE
> 58 (2) [E] none 0 0 B 0.000000 15166.599253 0.000 fps ts mono/SoE
> 59 (3) [E] none 0 0 B 0.000000 15166.599261 0.000 fps ts mono/SoE
> 60 (4) [E] none 0 0 B 0.000000 15166.599269 0.000 fps ts mono/SoE
> 61 (5) [E] none 0 0 B 0.000000 15166.599278 0.000 fps ts mono/SoE
> 62 (6) [E] none 0 0 B 0.000000 15166.599462 0.000 fps ts mono/SoE
> 63 (7) [E] none 0 0 B 0.000000 15166.599485 0.000 fps ts mono/SoE
> 64 (0) [E] none 0 0 B 0.000000 15166.599497 0.000 fps ts mono/SoE
> 65 (1) [E] none 0 0 B 0.000000 15166.599510 0.000 fps ts mono/SoE
> 66 (2) [E] none 0 0 B 0.000000 15166.599521 0.000 fps ts mono/SoE
> 67 (3) [E] none 0 0 B 0.000000 15166.599528 0.000 fps ts mono/SoE
> 68 (4) [E] none 0 0 B 0.000000 15166.599538 0.000 fps ts mono/SoE
> 69 (5) [E] none 0 0 B 0.000000 15166.599548 0.000 fps ts mono/SoE
> 70 (6) [E] none 0 0 B 0.000000 15166.599557 0.000 fps ts mono/SoE
> 71 (7) [E] none 0 0 B 0.000000 15166.599567 0.000 fps ts mono/SoE
> 72 (0) [E] none 0 0 B 0.000000 15166.599576 0.000 fps ts mono/SoE
>
> >
> > In hindsight having the metadata queue be a fully independent
> > queue without clearly defining how start/stop on both queues
> > works and enforcing the defined behavior at the driver level
> > was a mistake.
> >
> > I'm starting to think that ideally we would simply flush both
> > queues on the stop on the regular node and not have a stop
> > queue-op on the metadata queue at all, but that is not possible
> > I'm afraid.
> >
> > So I think we do need something like this series +
> > flush metadata-queue on regular queue stop.
> >
> > I'll try to make some time to review this series as is, since
> > although the waiting solution still feels ugly it may be the
> > best we can do.
> >
> > Regards,
> >
> > Hans
> >
> >
> >
> >
> >
> > >
> > >
> > >>
> > >>> As I see it, the issue is that the camera's live capture cycle is
> > >>> controlled solely by video0. We need some kind of synchronization
> > >>> mechanism with video1 if we do not want to change the behaviour and
> > >>> risk breaking apps.
> > >>
> > >> IMHO for a device with multiple /dev/video# nodes it makes sense
> > >> to wait with actually starting streaming/DMA-engines until all
> > >> enabled queues are started and stop when the first queue is stopped.
> > >>
> > >> The problem with uvcvideo is that we do not know if the metadata
> > >> queue is going to get used at all. In hindsight we should maybe
> > >> have had some way for userspace to explictly enable/disable metadata
> > >> support.
> > >>
> > >> So we start as soon as the main video node is opened, still I think
> > >> that stopping as soon as one of the queues is stopped makes sense.
> > >>
> > >> Laurent, do you have any input here?
> > >>
> > >> Regards,
> > >>
> > >> Hans
> > >>
> > >>
> > >>
> > >>
> > >>>> p.s.
> > >>>>
> > >>>> 1. It is tempting to also apply the same approach to
> > >>>> vb2_ops.start_streaming, but allowing the meta queue to be
> > >>>> the one to start streaming will likely cause issues. E.g.
> > >>>> the streaming code assumes having a meta-queue active is
> > >>>> optional, but not the other way around.
> > >>>>
> > >>>> TL;DR: vb2_ops.start_streaming should stay as is.
> > >>>>
> > >>>> 2. While looking into this I noticed that struct uvc_streaming
> > >>>> already has an active member, but unless I'm missing something
> > >>>> that ever only gets initialized to 0. So I think that can be
> > >>>> dropped. (If you re-use this please change it to a bool, no
> > >>>> need to have it atomic while protected by a mutex).
> > >>>
> > >>> I will send a patch to fix this. Thanks for noticing :)
> > >>>
> > >>>>
> > >>>>
> > >>>>
> > >>>>> ---
> > >>>>>  drivers/media/usb/uvc/uvc_queue.c | 14 ++++++++++++++
> > >>>>>  drivers/media/usb/uvc/uvc_video.c | 30 +++++++++++++++++++++++++++++-
> > >>>>>  drivers/media/usb/uvc/uvcvideo.h  |  2 ++
> > >>>>>  3 files changed, 45 insertions(+), 1 deletion(-)
> > >>>>>
> > >>>>> diff --git a/drivers/media/usb/uvc/uvc_queue.c b/drivers/media/usb/uvc/uvc_queue.c
> > >>>>> index 3c002c8f442f..af9dbfcf6f53 100644
> > >>>>> --- a/drivers/media/usb/uvc/uvc_queue.c
> > >>>>> +++ b/drivers/media/usb/uvc/uvc_queue.c
> > >>>>> @@ -209,10 +209,24 @@ static void uvc_stop_streaming_video(struct vb2_queue *vq)
> > >>>>>  static void uvc_stop_streaming_meta(struct vb2_queue *vq)
> > >>>>>  {
> > >>>>>       struct uvc_video_queue *queue = vb2_get_drv_priv(vq);
> > >>>>> +     struct uvc_streaming *stream = queue->stream;
> > >>>>>
> > >>>>>       lockdep_assert_irqs_enabled();
> > >>>>>
> > >>>>> +     spin_lock_irq(&stream->meta.irqlock);
> > >>>>> +     while (stream->meta.in_flight) {
> > >>>>> +             spin_unlock_irq(&stream->meta.irqlock);
> > >>>>> +             schedule();
> > >>>>> +             spin_lock_irq(&stream->meta.irqlock);
> > >>>>> +     }
> > >>>>> +     stream->meta.in_flight = true;
> > >>>>> +     spin_unlock_irq(&stream->meta.irqlock);
> > >>>>> +
> > >>>>>       uvc_queue_return_buffers(queue, UVC_BUF_STATE_ERROR);
> > >>>>> +
> > >>>>> +     scoped_guard(spinlock_irq, &stream->meta.irqlock) {
> > >>>>> +             stream->meta.in_flight = false;
> > >>>>> +     }
> > >>>>>  }
> > >>>>>
> > >>>>>  static const struct vb2_ops uvc_queue_qops = {
> > >>>>> diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> > >>>>> index fc3536a4399f..f6b55b3a3308 100644
> > >>>>> --- a/drivers/media/usb/uvc/uvc_video.c
> > >>>>> +++ b/drivers/media/usb/uvc/uvc_video.c
> > >>>>> @@ -1732,6 +1732,26 @@ static void uvc_video_encode_bulk(struct uvc_urb *uvc_urb,
> > >>>>>       urb->transfer_buffer_length = stream->urb_size - len;
> > >>>>>  }
> > >>>>>
> > >>>>> +static struct uvc_buffer *
> > >>>>> +uvc_video_get_current_meta_buffer(struct uvc_streaming *stream)
> > >>>>> +{
> > >>>>> +     struct uvc_video_queue *queue = &stream->meta.queue;
> > >>>>> +     struct uvc_buffer *buf;
> > >>>>> +
> > >>>>> +     buf = uvc_queue_get_current_buffer(queue);
> > >>>>> +     if (!buf)
> > >>>>> +             return NULL;
> > >>>>> +
> > >>>>> +     guard(spinlock_irqsave)(&stream->meta.irqlock);
> > >>>>> +
> > >>>>> +     if (stream->meta.in_flight)
> > >>>>> +             return NULL;
> > >>>>> +
> > >>>>> +     stream->meta.in_flight = true;
> > >>>>> +
> > >>>>> +     return buf;
> > >>>>> +}
> > >>>>> +
> > >>>>>  static void uvc_video_complete(struct urb *urb)
> > >>>>>  {
> > >>>>>       struct uvc_urb *uvc_urb = urb->context;
> > >>>>> @@ -1767,7 +1787,7 @@ static void uvc_video_complete(struct urb *urb)
> > >>>>>       buf = uvc_queue_get_current_buffer(queue);
> > >>>>>
> > >>>>>       if (vb2_qmeta)
> > >>>>> -             buf_meta = uvc_queue_get_current_buffer(qmeta);
> > >>>>> +             buf_meta = uvc_video_get_current_meta_buffer(stream);
> > >>>>>
> > >>>>>       /* Re-initialise the URB async work. */
> > >>>>>       uvc_urb->async_operations = 0;
> > >>>>> @@ -1778,6 +1798,12 @@ static void uvc_video_complete(struct urb *urb)
> > >>>>>        */
> > >>>>>       stream->decode(uvc_urb, buf, buf_meta);
> > >>>>>
> > >>>>> +     if (buf_meta) {
> > >>>>> +             scoped_guard(spinlock_irqsave, &stream->meta.irqlock) {
> > >>>>> +                     stream->meta.in_flight = false;
> > >>>>> +             }
> > >>>>> +     }
> > >>>>> +
> > >>>>>       /* If no async work is needed, resubmit the URB immediately. */
> > >>>>>       if (!uvc_urb->async_operations) {
> > >>>>>               ret = usb_submit_urb(uvc_urb->urb, GFP_ATOMIC);
> > >>>>> @@ -2330,6 +2356,8 @@ int uvc_video_init(struct uvc_streaming *stream)
> > >>>>>       for_each_uvc_urb(uvc_urb, stream)
> > >>>>>               INIT_WORK(&uvc_urb->work, uvc_video_copy_data_work);
> > >>>>>
> > >>>>> +     spin_lock_init(&stream->meta.irqlock);
> > >>>>> +
> > >>>>>       return 0;
> > >>>>>  }
> > >>>>>
> > >>>>> diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> > >>>>> index b6bcee4a222f..6f1a3381d392 100644
> > >>>>> --- a/drivers/media/usb/uvc/uvcvideo.h
> > >>>>> +++ b/drivers/media/usb/uvc/uvcvideo.h
> > >>>>> @@ -484,6 +484,8 @@ struct uvc_streaming {
> > >>>>>               struct uvc_video_queue queue;
> > >>>>>               u32 format;
> > >>>>>               u32 buffersize;
> > >>>>> +             bool in_flight;
> > >>>>> +             spinlock_t irqlock; /* Protects in_flight. */
> > >>>>>       } meta;
> > >>>>>
> > >>>>>       /* Context data used by the bulk completion handler. */
> > >>>>>
> > >>>>
> > >>>
> > >>>
> > >>
> > >
> > >
> >
>
>
> --
> Ricardo Ribalda



-- 
Ricardo Ribalda
