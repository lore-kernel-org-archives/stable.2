Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794319963;
	b=rt2TM979t6cfJWp+oQ1YDLOPllVlf1sZNbAV5OZ1Gd+DS+8vR2QqZLlPYh1cMAoVVb8N
	 IvibE5cQdDf4EWHfj/YEnVfDY6+5tK3adWpogSHL/GvnuP0jkut4wEeaJMOIkNpGVdE02
	 ofAKAIctqdo5kcwhz70D5xMKCqSrEkopn/w1PjROwInduS473c2xzulSx/3qM6JUnPWDB
	 E/bXL78gTlyJBl9aJR6BPOmCBQvDbGzu4sx0GoZQ10BCQYoM22qUJ6517V5ummDWduTzs
	 UlQ47f6vviwpdGc2aWp0coQT+gpBXKqOrzniQTJHQsH8l2IE4FOgfN67HSUmLpV8S6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794319963;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=1GulGFhMi9XBU0Cv2GT0yx0lTEUgKTglxY+lL/xbMYA=;
	b=wOc9PRiHphIxp2j0Df/YA3dD44zNxMTpkXKv3dhGalBUr1mKezDhmIBJHVS8oTTifFsD
	 fTg7oRhoPT78U+XTB46aHbyl86C2K41lWSdwc1XKR1B35JEELThNpJObh5vW1sWx7eSoU
	 nsgauCf14aQ8Mo+TBfXP61SzhoYPIlhdF2rFvoa9eagnm/vh+2Bc+fh7uwo6aYDsN21uh
	 2+xYgDtDKtRYlQ03sw43XAx+VLIwFuh36LFuJ+xfMBO1B+urc/rSh2ydQPTSYOou2DZgJ
	 LKKNYf4MXddHAFe3ANksWTanCa9CbqmKR2psAjwX6BrhoB2ZR92vB6ZcdQYtrD30eKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=pGuJ1Hl8;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0248606A325;
	Tue, 10 Nov 2026 14:12:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0248606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=pGuJ1Hl8
Received: from ideasonboard.com (unknown [93.65.100.155])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id AF5E7C4A;
	Tue, 10 Nov 2026 15:10:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1794319818;
	bh=rVu4JJZ6/if5MnVIbP7ES8Ykchj/m79GGXbfUF39ZtQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pGuJ1Hl8YQadvMBXBhyLTt0yC5HWa6pONUzrJOTNG5kY3MlSzR+d1EUBRIqUYabxz
	 OVlnZf17Puf01iOHn669qsirMqd4v1eKHoSn8OYvN8kAGo8vp6xvqzYVkVqHAa4LdH
	 uWhaUpPNh86n0yKeqTCY2ohvei4Dds8CgIjFMNTU=
Date: Tue, 10 Nov 2026 15:12:38 +0100
From: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To: David CARLIER <devnexen@gmail.com>
Cc: Jacopo Mondi <jacopo.mondi@ideasonboard.com>, 
	Daniel Scally <dan.scally@ideasonboard.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Nayden Kanchev <nayden.kanchev@arm.com>, Hans Verkuil <hverkuil+cisco@kernel.org>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] media: mali-c55: Fix frame sequence numbers on
 dual-pipe hardware
Message-ID: <avMkYct3Ms2kwJ5a@zed>
References: <20260930174621.791831-1-devnexen@gmail.com>
 <avMX7TrGYCUl8c4C@zed>
 <CA+XhMqz--zg_rR8_TqziuPXLRDDP1Y1xcNV7WS9_004AfaBtuA@mail.gmail.com>
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
In-Reply-To: <CA+XhMqz--zg_rR8_TqziuPXLRDDP1Y1xcNV7WS9_004AfaBtuA@mail.gmail.com>

Hi David

On Tue, Nov 10, 2026 at 01:35:56PM +0000, David CARLIER wrote:
> Hi,
>
> On Tue, 10 Nov 2026 at 13:22, Jacopo Mondi <jacopo.mondi@ideasonboard.com>
> wrote:
>
> > Hi David
> >
> > On Wed, Sep 30, 2026 at 06:46:21PM +0100, David Carlier wrote:
> > > The single frame_sequence counter in struct mali_c55_isp is incremented
> > > in mali_c55_set_plane_done(), which runs once per completed buffer per
> > > capture device rather than once per frame. Hardware fitted with the
> > > downscale pipe always hits this: mali_c55_pipeline_ready() refuses to
> > > start the ISP unless both the full-resolution and the downscale queues
> > > are streaming, so the counter advances twice per frame.
> > >
> > > Each video node then reports sequence numbers 0, 2, 4, ..., which
> > > userspace reads as a dropped frame between every pair of frames, and the
> > > two pipes never number the same frame alike, contrary to
> >
> > Sorry to ask, this is not meant to be detrimental to the value of this
> > patch, but in these days I feel like I should ask:
> >
> > - is this an error found running the system with an FR/DS pipeline
> > - is this a report from an LLM
> >
>
> I honestly use LLM to find this issue.
> I paid attention however if the increment in mali_c55_set_plane_done()
> and above all mali_c55_pipeline_ready() requires the queues when
> MALI_C55_GPS_DS_PIPE_FITTED is set.

Thanks, as said in the previous reply, we know the current handling of
frame sequence is broken, which makes it easier for me to accept a
patch not tested on real hw.

Honestly, commit messages reporting such a precise analysis of an
issue suggest the patch comes from from a real device, not from
analysis, and I wonder if in 6 months, if we ever find an issue with
this patch we'll remember it hasn't actually been tested.

It's a general concern regarding the increasing amount of LLM
generated fixes which come from code analysis rather than actual
testing.

Usage of LLM is now not required to be disclosed, but I wonder if for
our own safety we shouldn't clearly say "This issue has been found by
an LLM inspecting the code and not tested on a device." on all these
automated patches.

>
> Cheers.
>
> >
> > Mostly I'm curious to know as I can't test on a system with a DS pipe
> > fitted, knowing you actually tested this would make me more confident
> > in accepting the patch
> >
> > > Documentation/admin-guide/media/mali-c55.rst. The V4L2_EVENT_FRAME_SYNC
> > > event and the statistics and parameters buffers only read the counter,
> > > so their sequence numbers stop identifying a frame too.
> > >
> > > Increment the counter once per frame, when the ISP start interrupt is
> > > handled, and stamp each capture buffer when mali_c55_set_next_buffer()
> > > programs it, as it is written out during the following frame. Stamping
> > > at completion would be off by one whenever DONE(n) and START(n+1) are
> > > handled in the same interrupt, since ISP_START is processed first. Hold
> > > the counter at UINT_MAX while the ISP is stopped, as the first buffers
> > > are programmed before it starts, so the first frame gets sequence zero.
> > >
> > > Fixes: d5f281f3dd29 ("media: mali-c55: Add Mali-C55 ISP driver")
> > > Cc: stable@vger.kernel.org
> > > Assisted-by: Claude:claude-opus-5
> > > Signed-off-by: David Carlier <devnexen@gmail.com>
> > > ---
> > > v2:
> > >  - Stamp the buffer sequence in mali_c55_set_next_buffer() instead of
> > >    at completion, which broke when START(n+1) and DONE(n) are handled
> > >    together (Jacopo)
> > >  - Reset the counter when the ISP stops instead of when it starts
> > >
> > > v1: https://lore.kernel.org/r/20260801205311.386692-1-devnexen@gmail.com
> > > ---
> > >  drivers/media/platform/arm/mali-c55/mali-c55-capture.c | 5 +++--
> > >  drivers/media/platform/arm/mali-c55/mali-c55-common.h  | 4 ++++
> > >  drivers/media/platform/arm/mali-c55/mali-c55-core.c    | 1 +
> > >  drivers/media/platform/arm/mali-c55/mali-c55-isp.c     | 3 ++-
> > >  4 files changed, 10 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/media/platform/arm/mali-c55/mali-c55-capture.c
> > b/drivers/media/platform/arm/mali-c55/mali-c55-capture.c
> > > index ff01553026fb..fa073ce4b2bd 100644
> > > --- a/drivers/media/platform/arm/mali-c55/mali-c55-capture.c
> > > +++ b/drivers/media/platform/arm/mali-c55/mali-c55-capture.c
> > > @@ -413,6 +413,9 @@ void mali_c55_set_next_buffer(struct
> > mali_c55_cap_dev *cap_dev)
> > >               return;
> > >       }
> > >
> > > +     /* The buffer is written out during the frame following this one.
> > */
> > > +     buf->vb.sequence = cap_dev->mali_c55->isp.frame_sequence + 1;
> > > +
> > >       pix_mp = &cap_dev->format.format;
> > >
> > >       mali_c55_cap_dev_update_bits(cap_dev, MALI_C55_REG_Y_WRITER_MODE,
> > > @@ -457,7 +460,6 @@ void mali_c55_set_next_buffer(struct
> > mali_c55_cap_dev *cap_dev)
> > >  void mali_c55_set_plane_done(struct mali_c55_cap_dev *cap_dev,
> > >                            enum mali_c55_planes plane)
> > >  {
> > > -     struct mali_c55_isp *isp = &cap_dev->mali_c55->isp;
> > >       struct mali_c55_buffer *buf;
> > >
> > >       scoped_guard(spinlock, &cap_dev->buffers.processing_lock) {
> > > @@ -476,7 +478,6 @@ void mali_c55_set_plane_done(struct mali_c55_cap_dev
> > *cap_dev,
> > >
> > >       /* If the other plane is also done... */
> > >       buf->vb.vb2_buf.timestamp = ktime_get_boottime_ns();
> > > -     buf->vb.sequence = isp->frame_sequence++;
> > >       vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_DONE);
> > >  }
> > >
> > > diff --git a/drivers/media/platform/arm/mali-c55/mali-c55-common.h
> > b/drivers/media/platform/arm/mali-c55/mali-c55-common.h
> > > index 13a3e9dc4243..50f2b7a85f62 100644
> > > --- a/drivers/media/platform/arm/mali-c55/mali-c55-common.h
> > > +++ b/drivers/media/platform/arm/mali-c55/mali-c55-common.h
> > > @@ -76,6 +76,10 @@ struct mali_c55_isp {
> > >       struct media_pad *remote_src;
> > >       /* Mutex to guard vb2 start/stop streaming */
> > >       struct mutex capture_lock;
> > > +     /*
> > > +      * Sequence of the frame being processed, incremented at SOF. Held
> > at
> > > +      * UINT_MAX while stopped so the first frame gets sequence 0.
> > > +      */
> > >       unsigned int frame_sequence;
> > >  };
> > >
> > > diff --git a/drivers/media/platform/arm/mali-c55/mali-c55-core.c
> > b/drivers/media/platform/arm/mali-c55/mali-c55-core.c
> > > index fb81141d1653..be562156b295 100644
> > > --- a/drivers/media/platform/arm/mali-c55/mali-c55-core.c
> > > +++ b/drivers/media/platform/arm/mali-c55/mali-c55-core.c
> > > @@ -573,6 +573,7 @@ static irqreturn_t mali_c55_isr(int irq, void
> > *context)
> > >       for_each_set_bit(i, &interrupt_status, MALI_C55_NUM_IRQ_BITS) {
> > >               switch (i) {
> > >               case MALI_C55_IRQ_ISP_START:
> > > +                     mali_c55->isp.frame_sequence++;
> > >                       mali_c55_isp_queue_event_sof(mali_c55);
> > >
> > >
> >  mali_c55_set_next_buffer(&mali_c55->cap_devs[MALI_C55_CAP_DEV_FR]);
> > > diff --git a/drivers/media/platform/arm/mali-c55/mali-c55-isp.c
> > b/drivers/media/platform/arm/mali-c55/mali-c55-isp.c
> > > index e128adf6ee37..dd3bce287a3d 100644
> > > --- a/drivers/media/platform/arm/mali-c55/mali-c55-isp.c
> > > +++ b/drivers/media/platform/arm/mali-c55/mali-c55-isp.c
> > > @@ -342,7 +342,6 @@ static int mali_c55_isp_enable_streams(struct
> > v4l2_subdev *sd,
> > >
> > >       src_sd = media_entity_to_v4l2_subdev(isp->remote_src->entity);
> > >
> > > -     isp->frame_sequence = 0;
> > >       ret = mali_c55_isp_start(mali_c55, state);
> > >       if (ret) {
> > >               dev_err(mali_c55->dev, "Failed to start ISP\n");
> > > @@ -380,6 +379,7 @@ static int mali_c55_isp_disable_streams(struct
> > v4l2_subdev *sd,
> > >       isp->remote_src = NULL;
> > >
> > >       mali_c55_isp_stop(mali_c55);
> > > +     isp->frame_sequence = UINT_MAX;
> > >
> > >       return 0;
> > >  }
> > > @@ -584,6 +584,7 @@ int mali_c55_register_isp(struct mali_c55 *mali_c55)
> > >       int ret;
> > >
> > >       isp->mali_c55 = mali_c55;
> > > +     isp->frame_sequence = UINT_MAX;
> >
> > The patch looks ok to me:
> > Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
> >
> > but I wish we could test it.
> >
> > Knowing the current frame counter stamping is broken already makes it
> > easier for me to collect this patch.
> >
> > >
> > >       v4l2_subdev_init(sd, &mali_c55_isp_ops);
> > >       sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE |
> > V4L2_SUBDEV_FL_HAS_EVENTS;
> > >
> > > base-commit: 95f76f51937fdfb0fc1e14cae606b1ef574a56f3
> > > --
> > > 2.55.0
> > >
> >
