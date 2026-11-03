Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702954;
	b=yY9LoBXmCJwhRLGPBZIWzvEXdtIUouySMGN6Hed36bAnIzFuH/FnXQK0B0h5dh7QmPGY
	 w2xydI8wDtLKPKiYfa83dtRKzDKoOpws7iUVQUeJ8JQrK6f9aP3p+tEWfFhzM2D4JQ896
	 +e8oBr+PXoYH56MVAfTPSdbHZsgay4W5bH6t/nkJNWjOlj3pHXCiy+d+cikj75laOXd7Y
	 B+0dStDL+uAcW2H2+2DUcbM2UQSsyBSO/7ioCgYqGqqtTnvAPsDuUwHjwF5UMM4kN/c8p
	 ExGIaw+TquCxAb8v4YDto4ThexUj9GP6F4+pQyQ2ipuH39E9DDue6HfDCfwymmcMY0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702954;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=sn9U2ObGxsBVI2V7plt+qBCJ+syS6s6USf+HPG9H5yY=;
	b=VD/EUWfiwdm7HEcPV/jg98gLdm/hT7UC86BjLpwcj/zII1wUzM45o3twU/VGjz1G6w/K
	 Dyl7zuPleZPKxuezgCQY3wvS08AA7sC1der9K2woIFWObT3sk557e+vLqYnG64PsR7iWS
	 5OFQ2htmXA0HN4ojkdK2Jxa/SKVOc0EjE0ZphMKm6bmA+BoSLt1PUuiAt/ypOSQg0zwDT
	 jOhwxMn5aIF9s+UXz2JiMqyrd5/70l2JsCG8OGNPlpqrkOCZu7LvRE4R65w5O6RnenxF1
	 2tE9lpVPxkPRUfeXQJMoeZLCtDNJ3tFlano2d7N8Mt4nGDgBNOq25R9RzIwnfo4deWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=PxqJjDdu;
	arc=none smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4466071501
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 10:49:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C4466071501
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=PxqJjDdu
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-88cfa501c5cso1437127b3a.3
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 02:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793702953; x=1794307753; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sn9U2ObGxsBVI2V7plt+qBCJ+syS6s6USf+HPG9H5yY=;
        b=PxqJjDduGbLn2oiBadfJxW3m4isWbDvjOFJX8qv7MHKvrmqTrO2ahWuS60jE2VWwmm
         JkbjkI0bvLU4jXXPVYGScsNspANulTFT6Ei/l7tnxTqQJOBQHVSlOLxNwuNv0Iy6hILy
         BAAmni9+q/ASrSmaryZLZy+8cFhI04XhKL3lo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793702953; x=1794307753;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sn9U2ObGxsBVI2V7plt+qBCJ+syS6s6USf+HPG9H5yY=;
        b=MKoF2eSDhlo5jxi5gqQ+EWQjLOSuxw5E1N++3IMXTc2wkKPK/FLny7mmqjTnbG1VjK
         htfHfyadMPCULZP+oKb7D9jSl+r03jvbmfIjMwBeNh3RtJAJNmwYDTQ+ggCsVMiX5Nl5
         rOxKQiCqwMKFpVGjWNsiYwC0hai3GANKZXREinwl+shaCrVmuo0ZstmlFfDKRCjiX+JK
         TEcg5udwRpHgC/k5PQLAZymcWUa/71BRY95pnrNyR1cdMAOdV41Sl6JCYo4t7I0wAiWs
         IR11HVUitKla7JsuQCT1yi2DPeVIzXkc0g8cOGAW3AXygFoSfy3dMA+1DhkTEIfbeYnS
         TOug==
X-Forwarded-Encrypted: i=1; AKwUvBy8FrWcNEISDA6ukbsYbWue4TOArDbjJa4QIl8yt74ZcoGAsreJq066xXtyyLgvfKMzomgebYQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+iBm7acIKZ88Pe0+LKgCvViv08kz9N93kwsw5sDQ6pLwpIcwwG
	5KFYmahCN1dtNtGIOaehWzOshPcI+0NPO/RRqb9eFGvx7DrWhcxKk92ex0IGXhQZY27qdiN1QBD
	Bov0oBywL
X-Gm-Gg: AYBFou0Ah/2hWN+lfmleOPP+a6mbMtl9E/eK1kZu1gjhYlteB7vBvL7Vg+N6Muh1nEL
	244YbyD+La6F+4Uaq1P1K4KFVWRxrHM4fkuTUep6m46LXK0TOPaUontFNE81xdFpFwldjdVfyuZ
	bMmJBBEVz1+JEvbLs20jvL8muBHMxm7WaiuAojS+W/iXoU0+cU5ityjdCfb9p6lyspIyehhc7ic
	in86qFz5Ygedp82qSd5mTDx7FZEK3mHChXFEkuzEB7PpoWmx/spTFwMsKgDon+hCPY7OZl5wg5b
	+EpP73FMLzCmp/O6PWZwUO7iyvqhTmkzlG6ZY4CapknKIFNw4snwT5BVSKonVEW5Iz3NAtUgFlU
	A9NdxQk6qD7NLIDPfc740O8qDC/f8TaYAc6DaWkL9K7raeBqqpUL5JYhBSiEIRIR+lfGB+QA9NN
	x0U8XFoEyB4cdMaEC+s+k6oDKzQe94jj0IlLcQWij27pnwq2A32cwUCQrfO+qOaRRgon/mE2M0O
	UbiN6wdVRML5em0ZW05O+8CJfPaASVydggvYY3rgQf2eh6/dm1HNfxZmAQzN5j5CqYY5Ao5qkKy
	YeXF4xztyxCw0nJ7PWG7v9kceKBIo/vSnrxpcsxq63CTRtz5jb8G9Lr3arXZRrFK
X-Received: by 2002:a05:6a00:4b4f:b0:8a0:7c97:52a1 with SMTP id d2e1a72fcca58-8a9bffd5de5mr10524471b3a.48.1793702952721;
        Tue, 03 Nov 2026 02:49:12 -0800 (PST)
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com. [74.125.82.41])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aad9d03fa5sm3107810b3a.28.2026.11.03.02.49.11
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 02:49:11 -0800 (PST)
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-19305bcb72cso2967663c88.1
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 02:49:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBzDNxNljIbSXgVKptgC+XVgp21YjS63uYGgRN99LrTcQjsO0MlJbQizpIkJlymgcSTMr6oGpwA=@vger.kernel.org
X-Received: by 2002:a05:701b:4348:b0:19a:9a93:c9b2 with SMTP id
 a92af1059eb24-1ac5a0b8872mr19808473c88.13.1793702950522; Tue, 03 Nov 2026
 02:49:10 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102-vb2-mmap_lock-v1-1-fe550fe03ed8@chromium.org> <129153ba-7e5e-470d-86a7-78c346c03d6c@kernel.org>
In-Reply-To: <129153ba-7e5e-470d-86a7-78c346c03d6c@kernel.org>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 3 Nov 2026 11:48:56 +0100
X-Gmail-Original-Message-ID: <CANiDSCs0fkR4rWRphN2wCFj8cu+Xba4aAGjCNrzhaN=f0g2tAQ@mail.gmail.com>
X-Gm-Features: AclHuK_zfnWl5j6LtxXjut-id7HGG9gpHTqLQYxEO-efN2CHfwJKqkOEbwFfY_I
Message-ID: <CANiDSCs0fkR4rWRphN2wCFj8cu+Xba4aAGjCNrzhaN=f0g2tAQ@mail.gmail.com>
Subject: Re: [PATCH] media: videobuf2: publish buffers in bufs_bitmap under mmap_lock
To: Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: Tomasz Figa <tfiga@chromium.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil <hverkuil@kernel.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Hans

On Tue, 3 Nov 2026 at 09:50, Hans Verkuil <hverkuil+cisco@kernel.org> wrote:
>
> Hi Ricardo,
>
> Thank you for the patch, some comments below.
>
> On 02/11/2026 18:12, Ricardo Ribalda wrote:
> > vb2_mmap() only takes q->mmap_lock, not the main queue lock (q->lock).
> > To keep vb2_mmap() safe, newly allocated buffers must not become visible
> > in vb2_get_buffer() until they are fully initialized and q->mmap_lock is
> > held.
> >
> > Commit a286b0837e13 ("media: core: Add bitmap manage bufs array entries")
> > started setting q->bufs_bitmap inside __vb2_queue_alloc() before buffer
> > memory is allocated and without holding q->mmap_lock. As a result:
> >
> > - A concurrent mmap() can find a half-initialized buffer, and if buffer
> >   allocation or .buf_init() fails, __vb2_queue_alloc() frees that buffer
> >   without holding q->mmap_lock, causing a use-after-free in vb2_mmap().
> > - If fewer buffers are allocated than requested, they are already
> >   counted as active in q->bufs_bitmap before .queue_setup() checks
> >   whether the smaller count is acceptable.
> >
> > Fix this by keeping new buffers only in q->bufs[] during allocation and
> > setting their bits in q->bufs_bitmap under q->mmap_lock once allocation
> > and .queue_setup() succeed. Add a memory barrier pair on q->bufs_bitmap
> > so lockless vb2_get_buffer() readers also see fully initialized buffers,
> > and let __vb2_queue_free() read q->bufs[] directly when cleaning up
> > unexposed buffers.
> >
> > Fixes: a286b0837e13 ("media: core: Add bitmap manage bufs array entries")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> > This patch was generated by an LLM, but supervised and reviewed by a
> > human (not the most handsome human, but a human).
> > ---
> >  drivers/media/common/videobuf2/videobuf2-core.c | 97 +++++++++++++++++++------
> >  include/media/videobuf2-core.h                  | 13 +++-
> >  2 files changed, 85 insertions(+), 25 deletions(-)
> >
> > diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
> > index b0a6084f1757..185393078ce3 100644
> > --- a/drivers/media/common/videobuf2/videobuf2-core.c
> > +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> > @@ -427,19 +427,36 @@ static void init_buffer_cache_hints(struct vb2_queue *q, struct vb2_buffer *vb)
> >  }
> >
> >  /**
> > - * vb2_queue_add_buffer() - add a buffer to a queue
> > - * @q:       pointer to &struct vb2_queue with videobuf2 queue.
> > - * @vb:      pointer to &struct vb2_buffer to be added to the queue.
> > - * @index: index where add vb2_buffer in the queue
> > + * vb2_queue_add_buffers() - publish buffers staged by __vb2_queue_alloc()
> > + * @q:               pointer to &struct vb2_queue with videobuf2 queue.
> > + * @start:   index of the first buffer to publish.
> > + * @count:   number of buffers to publish.
> > + *
> > + * Set the @q->bufs_bitmap bits of the @count fully initialized buffers that
> > + * __vb2_queue_alloc() stored in @q->bufs[] starting at @start, which makes
> > + * them visible to vb2_get_buffer().
> >   */
> > -static void vb2_queue_add_buffer(struct vb2_queue *q, struct vb2_buffer *vb, unsigned int index)
> > +static void vb2_queue_add_buffers(struct vb2_queue *q, unsigned int start,
> > +                               unsigned int count)
> >  {
> > -     WARN_ON(index >= q->max_num_buffers || test_bit(index, q->bufs_bitmap) || vb->vb2_queue);
> > +     unsigned int i;
> > +
> > +     lockdep_assert_held(&q->mmap_lock);
> >
> > -     q->bufs[index] = vb;
> > -     vb->index = index;
> > -     vb->vb2_queue = q;
> > -     set_bit(index, q->bufs_bitmap);
> > +     /*
> > +      * Order the buffer initialization and the q->bufs[] stores done by
> > +      * __vb2_queue_alloc() before the bits that publish them. Pairs with
> > +      * test_bit_acquire() in vb2_get_buffer(), which is also called
> > +      * without q->lock or q->mmap_lock held, e.g. by vb2_find_buffer()
> > +      * from a mem2mem .device_run().
> > +      */
> > +     smp_mb__before_atomic();
>
> Move the memory barrier changes to a separate patch. I'm not at all certain these
> are needed. I noticed before that LLMs are very 'generous' with such things and
> I am not sure they know what they are doing.
>
> > +     for (i = start; i < start + count; i++) {
> > +             if (WARN_ON(i >= q->max_num_buffers || !q->bufs[i] ||
> > +                         test_bit(i, q->bufs_bitmap)))
> > +                     continue;
> > +             set_bit(i, q->bufs_bitmap);
> > +     }
>
> So if I understand it correctly, the root issue is that vb2_queue_add_buffer
> sets the bit in bufs_bitmap, even though __vb2_queue_alloc() might free it
> again.
>
> I think these changes are a bit too extensive. How about just dropping the
> set_bit from vb2_queue_add_buffer()? And at the end of the reqbufs/create_bufs
> function call bitmap_set() to update bufs_bitmap?
>
> >  }
> >
> >  /**
> > @@ -448,6 +465,8 @@ static void vb2_queue_add_buffer(struct vb2_queue *q, struct vb2_buffer *vb, uns
> >   */
> >  static void vb2_queue_remove_buffer(struct vb2_buffer *vb)
> >  {
> > +     lockdep_assert_held(&vb->vb2_queue->mmap_lock);
>
> It doesn't hurt to have these asserts. But put these in a separate patch please.
>
> > +
> >       clear_bit(vb->index, vb->vb2_queue->bufs_bitmap);
> >       vb->vb2_queue->bufs[vb->index] = NULL;
> >       vb->vb2_queue = NULL;
> > @@ -460,6 +479,11 @@ static void vb2_queue_remove_buffer(struct vb2_buffer *vb)
> >   * @first_index: index of the first created buffer, all newly allocated buffers
> >   *            have indices in the range [first_index..first_index+count-1]
> >   *
> > + * The allocated buffers are stored in q->bufs[] but not published in
> > + * q->bufs_bitmap: the caller must either publish them with
> > + * vb2_queue_add_buffers() or free them with __vb2_queue_free(), both under
> > + * q->mmap_lock.
> > + *
> >   * Returns the number of buffers successfully allocated.
> >   */
> >  static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
> > @@ -506,7 +530,9 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
> >               }
> >
> >               vb->state = VB2_BUF_STATE_DEQUEUED;
> > +             vb->vb2_queue = q;
> >               vb->num_planes = num_planes;
> > +             vb->index = index + buffer;
> >               vb->type = q->type;
> >               vb->memory = memory;
> >               init_buffer_cache_hints(q, vb);
> > @@ -515,7 +541,6 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
> >                       vb->planes[plane].min_length = plane_sizes[plane];
> >               }
> >
> > -             vb2_queue_add_buffer(q, vb, index++);
> >               call_void_bufop(q, init_buffer, vb);
> >
> >               /* Allocate video buffer memory for the MMAP type */
> > @@ -524,7 +549,6 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
> >                       if (ret) {
> >                               dprintk(q, 1, "failed allocating memory for buffer %d\n",
> >                                       buffer);
> > -                             vb2_queue_remove_buffer(vb);
> >                               kfree(vb);
> >                               break;
> >                       }
> > @@ -539,11 +563,20 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
> >                               dprintk(q, 1, "buffer %d %p initialization failed\n",
> >                                       buffer, vb);
> >                               __vb2_buf_mem_free(vb);
> > -                             vb2_queue_remove_buffer(vb);
> >                               kfree(vb);
> >                               break;
> >                       }
> >               }
> > +
> > +             /*
> > +              * Stage the initialized buffer in q->bufs[]; it becomes visible
> > +              * to vb2_get_buffer() only after vb2_queue_add_buffers() sets
> > +              * its bit in q->bufs_bitmap under q->mmap_lock.
> > +              */
> > +             WARN_ON(vb->index >= q->max_num_buffers ||
> > +                     q->bufs[vb->index] ||
> > +                     test_bit(vb->index, q->bufs_bitmap));
> > +             q->bufs[vb->index] = vb;
> >       }
> >
> >       dprintk(q, 3, "allocated %d buffers, %d plane(s) each\n",
> > @@ -562,7 +595,8 @@ static void __vb2_free_mem(struct vb2_queue *q, unsigned int start, unsigned int
> >       struct vb2_buffer *vb;
> >
> >       for (i = start; i < start + count; i++) {
> > -             vb = vb2_get_buffer(q, i);
> > +             /* See __vb2_queue_free() for why vb2_get_buffer() isn't used */
> > +             vb = q->bufs[i];
> >               if (!vb)
> >                       continue;
> >
> > @@ -580,6 +614,11 @@ static void __vb2_free_mem(struct vb2_queue *q, unsigned int start, unsigned int
> >   * __vb2_queue_free() - free @count buffers from @start index of the queue - video memory and
> >   * related information, if no buffers are left return the queue to an
> >   * uninitialized state. Might be called even if the queue has already been freed.
> > + *
> > + * Buffers are looked up directly in q->bufs[] instead of through
> > + * vb2_get_buffer() so that buffers staged by __vb2_queue_alloc() that were
> > + * never published in q->bufs_bitmap (because a later .queue_setup() call
> > + * rejected the allocated number of buffers) are freed as well.
> >   */
> >  static void __vb2_queue_free(struct vb2_queue *q, unsigned int start, unsigned int count)
> >  {
> > @@ -587,9 +626,19 @@ static void __vb2_queue_free(struct vb2_queue *q, unsigned int start, unsigned i
> >
> >       lockdep_assert_held(&q->mmap_lock);
> >
> > +     /*
> > +      * No buffers were ever allocated (e.g. REQBUFS(0) on a fresh queue),
> > +      * only the queue state needs to be reset.
> > +      */
> > +     if (!q->bufs) {
> > +             q->memory = VB2_MEMORY_UNKNOWN;
> > +             INIT_LIST_HEAD(&q->queued_list);
> > +             return;
> > +     }
>
> This change looks dubious. It doesn't appear to have anything to do with the actual
> change. If it is meant as an optimization, then I would just drop this: this situation
> almost never happens in practice, so it just adds code for no benefit.

It is not an optimization. now we do not call vb2_get_buffer(), whic
is doing the !q->bufs check.
I have droppend the q->memory and INIT_LIST_HEAD() to have the same
behaviour as now, but the check needs to stay.

>
> > +
> >       /* Call driver-provided cleanup function for each buffer, if provided */
> >       for (i = start; i < start + count; i++) {
> > -             struct vb2_buffer *vb = vb2_get_buffer(q, i);
> > +             struct vb2_buffer *vb = q->bufs[i];
> >
> >               if (vb && vb->planes[0].mem_priv)
> >                       call_void_vb_qop(vb, buf_cleanup, vb);
> > @@ -624,7 +673,7 @@ static void __vb2_queue_free(struct vb2_queue *q, unsigned int start, unsigned i
> >               q->cnt_unprepare_streaming = 0;
> >       }
> >       for (i = start; i < start + count; i++) {
> > -             struct vb2_buffer *vb = vb2_get_buffer(q, i);
> > +             struct vb2_buffer *vb = q->bufs[i];
> >               bool unbalanced;
> >
> >               if (!vb)
> > @@ -676,7 +725,7 @@ static void __vb2_queue_free(struct vb2_queue *q, unsigned int start, unsigned i
> >
> >       /* Free vb2 buffers */
> >       for (i = start; i < start + count; i++) {
> > -             struct vb2_buffer *vb = vb2_get_buffer(q, i);
> > +             struct vb2_buffer *vb = q->bufs[i];
> >
> >               if (!vb)
> >                       continue;
> > @@ -1000,14 +1049,16 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
> >
> >       if (ret < 0) {
> >               /*
> > -              * Note: __vb2_queue_free() will subtract 'allocated_buffers'
> > -              * from already queued buffers and it will reset q->memory to
> > +              * Note: the buffers allocated by __vb2_queue_alloc() were never
> > +              * published in q->bufs_bitmap, __vb2_queue_free() frees them
> > +              * straight from q->bufs[] and resets q->memory to
> >                * VB2_MEMORY_UNKNOWN.
> >                */
> >               __vb2_queue_free(q, first_index, allocated_buffers);
> >               mutex_unlock(&q->mmap_lock);
> >               return ret;
> >       }
> > +     vb2_queue_add_buffers(q, first_index, allocated_buffers);
> >       mutex_unlock(&q->mmap_lock);
> >
> >       /*
> > @@ -1125,14 +1176,16 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
> >
> >       if (ret < 0) {
> >               /*
> > -              * Note: __vb2_queue_free() will subtract 'allocated_buffers'
> > -              * from already queued buffers and it will reset q->memory to
> > -              * VB2_MEMORY_UNKNOWN.
> > +              * Note: the buffers allocated by __vb2_queue_alloc() were never
> > +              * published in q->bufs_bitmap, __vb2_queue_free() frees them
> > +              * straight from q->bufs[] and resets q->memory to
> > +              * VB2_MEMORY_UNKNOWN if no buffers are left.
> >                */
> >               __vb2_queue_free(q, *first_index, allocated_buffers);
> >               mutex_unlock(&q->mmap_lock);
> >               return -ENOMEM;
> >       }
> > +     vb2_queue_add_buffers(q, *first_index, allocated_buffers);
> >       mutex_unlock(&q->mmap_lock);
> >
> >       /*
> > diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
> > index 4b4f4c15c53a..0b32ac7bc8fc 100644
> > --- a/include/media/videobuf2-core.h
> > +++ b/include/media/videobuf2-core.h
> > @@ -565,8 +565,11 @@ struct vb2_buf_ops {
> >   * @memory:  current memory type used
> >   * @dma_dir: DMA mapping direction.
> >   * @bufs:    videobuf2 buffer structures. If it is non-NULL then
> > - *           bufs_bitmap is also non-NULL.
> > - * @bufs_bitmap: bitmap tracking whether each bufs[] entry is used
> > + *           bufs_bitmap is also non-NULL. __vb2_queue_alloc() fills in
> > + *           an entry before its bit is set in bufs_bitmap, so buffers
> > + *           must be looked up with vb2_get_buffer().
> > + * @bufs_bitmap: bitmap tracking which bufs[] entries hold a fully
> > + *           initialized buffer. Bits are set and cleared under @mmap_lock.
> >   * @max_num_buffers: upper limit of number of allocated/used buffers.
> >   *                If set to 0 v4l2 core will change it VB2_MAX_FRAME
> >   *                for backward compatibility.
> > @@ -1286,7 +1289,11 @@ static inline struct vb2_buffer *vb2_get_buffer(struct vb2_queue *q,
> >       if (index >= q->max_num_buffers)
> >               return NULL;
> >
> > -     if (test_bit(index, q->bufs_bitmap))
> > +     /*
> > +      * A set bit guarantees that the buffer is fully initialized, pairs
> > +      * with smp_mb__before_atomic() in vb2_queue_add_buffers().
> > +      */
> > +     if (test_bit_acquire(index, q->bufs_bitmap))
> >               return q->bufs[index];
> >       return NULL;
> >  }
>
> Regards,
>
>         Hans
>
> >
> > ---
> > base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> > change-id: 20261102-vb2-mmap_lock-959e0cc4edb3
> >
> > Best regards,
>


-- 
Ricardo Ribalda
