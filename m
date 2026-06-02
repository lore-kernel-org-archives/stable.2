Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FF136683B
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 07:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780385204; cv=none; b=HVoL6EI2pKgq6aoij6cgIFmIg6RvEyNyYT25RRrprDIKYzbbTIweN/SZsGRjGEjETV7PH/iuufCdnnz13PwmNgrEY3rLDCZNovQ0PWn/QCNMj52bEEshHkBRxDMd9ohAQ+aUsgQxLIJdQWOjtOzWQjf4BJ4A7cg/E/2Q5huyysM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780385204; c=relaxed/simple;
	bh=lww/k4S/rDCe2g/lPxK8iJlS1INRNKuBuTnReTHVA3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U0bxCgwaQ9tRRmLWy839HFBPqhpxqKn2Tz9OII2Y/BgYL+lZXwLnAw747YKnfTFfUz1GT2Z5L4/REljJ+Bu2QY+8MEL9P0H+rY0Kwt8bpnOMPAPFN2v47o0nMFUQMeLrpRhxTIb3vsNYxBkkWyEd0ml75Dzz/RVjXm0dr92CxGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eDUSMZcU; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eDUSMZcU"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-bef47b1ac01so65254966b.2
        for <stable@vger.kernel.org>; Tue, 02 Jun 2026 00:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1780385200; x=1780990000; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rIJcYzfKNWvO4LbSTb+KowDs+YJ5wjm9TkOAb/K4D3M=;
        b=eDUSMZcUwEkg4Tu322leRNNzq+ZeAUcdhtiUHJZWR01W6lqH0MfVsEErmm4ab2Ey3l
         X/7sBCLiZPpRF5C/XXWSptHUK2QkpVcGlk66EcbioHaCffYu9WzTPNQqWVA6vCGdsawY
         VcRAeQV6U1TljX5CUOtiydA5ugexLm8pqoyas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780385200; x=1780990000;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rIJcYzfKNWvO4LbSTb+KowDs+YJ5wjm9TkOAb/K4D3M=;
        b=iLZ6F69LFqmD/utOoOrvl8x2YrHZS6J63IKkkDlpVwJGIbYiULBt0f8xqnotVKes86
         Kr6z0NiZnzJD/XjxW6y5id+cIhDcdVVoIOvu3QxSbb5C5KhUU7F7wC00b1gBHN0OxcHA
         Qp9rnp5roickWNl1e4wlto/au5J5fgHFDfKoflPArEhabKqbYcm95H95vXiuLupeQvhj
         hgz8iv97e08G6RwHlQ0VK5Sf9CdwvP4Db8MElhCcVuGLaJPcw9+FOXaeQyw00WUlRXRu
         tMh0TGbFGFmoY3rGTZ1STshZ+84WYhHxx2b7vTdqYh+0N4qSbuw7MwnYVDiLq4Bp/gHI
         IuUQ==
X-Forwarded-Encrypted: i=1; AFNElJ99k26enEvjeMcNEftLRsFPTztsUJfbKR8lUE7palNuld50vZC7wdoIuGus8ZBxHl7+JS5CQK8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2BbrheuBZlWTLhuFUWVNAf3jw6ITUZHu5tANPKb4wdOZ9jaqv
	BMNgvNohrIfBbwU8SH7jWf/fVgOfhSCRn1M2cRjPPIIn8UQZF+D7ZC4j7e59p+HhbhK0AJ8SLE/
	aY9ynpQ==
X-Gm-Gg: Acq92OEdD05k7v1N0ypg5SNAa7LZLD6cTC4HmnPjzJJwHpzmKIBHkEqQVJev28ImO03
	uMC3T08vcWbd+G4NXRQqVr1+n6xF5Z8xqMYm6WmXWMMqeIDx0agK+3c5Fc/miNRT3h9AjJ/pFMM
	VfIkPMzVBnQHwLiCjodOhSnlQzvIaZbOE0ec0m3SRdlEDx3MpMJvG2lpEVGCetAwgmo+59GhF66
	yQ8cYkBQFO1/SV+HJYboFVm051YAsUDwa3gNqnLFXVf6i/XEAue/uFgjwJgrnrvvnDHkwp318wg
	65TqeDi3pS4tMoCQ0zQ/FcfZpwns9sFLrb2rBFeHAA0DTIaWOp19yc29KAhoks4+6MNOJ3XoE3B
	/aQW/AwNvDQ4E/h6gTt2qUuH+0jDDI3yrfrvGm2PfAva5sELq/5Jm/kmkf0mHs/8x/EhebEob7v
	aKG0tasIaVAUjjHWMGeyzwZW3pEtLB+aU4iqjO0ywAxq8BchJX2myCgvs1qrNSqYMvD4NuVcc=
X-Received: by 2002:a17:907:2678:b0:bef:90af:6ff1 with SMTP id a640c23a62f3a-bef90af9ac9mr41947466b.31.1780385200432;
        Tue, 02 Jun 2026 00:26:40 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68ceb7ba814sm3050791a12.13.2026.06.02.00.26.38
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 00:26:39 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6877c719cb0so18077941a12.2
        for <stable@vger.kernel.org>; Tue, 02 Jun 2026 00:26:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+vi3QzeTPNaoiiqrlMakMe/yNl8RWdO0qCv49HDZNdGIT1bFabwOrWxvhXk1o3hnDb6jfR/9Q=@vger.kernel.org
X-Received: by 2002:a17:907:e143:b0:beb:7b50:3a7e with SMTP id
 a640c23a62f3a-beb7b50621cmr392521666b.45.1780385197985; Tue, 02 Jun 2026
 00:26:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260530160224.570625122@linuxfoundation.org> <20260530160231.873363839@linuxfoundation.org>
 <8cd2c0613f018690cba5ae76c4ab73da05118312.camel@decadent.org.uk>
In-Reply-To: <8cd2c0613f018690cba5ae76c4ab73da05118312.camel@decadent.org.uk>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 2 Jun 2026 09:26:25 +0200
X-Gmail-Original-Message-ID: <CANiDSCs7PXPQw=rHrM58766YdagnDyDNh92DEhcfis8TYrW1+A@mail.gmail.com>
X-Gm-Features: AVHnY4JSIWy-WoxOBFubbS8uyyq247CjKAuWnxAQPGSXvXaXvW97nNTsZ779qxM
Message-ID: <CANiDSCs7PXPQw=rHrM58766YdagnDyDNh92DEhcfis8TYrW1+A@mail.gmail.com>
Subject: Re: [PATCH 5.10 263/589] media: uvcvideo: Enable VB2_DMABUF for
 metadata stream
To: Ben Hutchings <ben@decadent.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Hans de Goede <johannes.goede@oss.qualcomm.com>, Hans Verkuil <hverkuil+cisco@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Ben

On Mon, 1 Jun 2026 at 19:37, Ben Hutchings <ben@decadent.org.uk> wrote:
>
> On Sat, 2026-05-30 at 18:02 +0200, Greg Kroah-Hartman wrote:
> > 5.10-stable review patch.  If anyone has any objections, please let me know.
> >
> > ------------------
> >
> > From: Ricardo Ribalda <ribalda@chromium.org>
> >
> > commit fbac03467e53d8d72e5099c03df26d9adae11416 upstream.
> >
> > The UVC driver has two video streams, one for the frames and another one
> > for the metadata. Both streams share most of the codebase, but only the
> > data stream declares support for DMABUF transfer mode.
> >
> > I have tried the DMABUF transfer mode with CONFIG_DMABUF_HEAPS_SYSTEM
> > and the frames looked correct.
> >
> > This patch announces the support for DMABUF for the metadata stream.
> > This is useful for apps/HALs that only want to support DMABUF.
>
> So this is a feature addition.
>
> And the uvcvideo driver has changed a lot since 5.10 (or even 6.1), so
> unless someone specifically tested that these older versions will also
> work with dmabuf I question whether this is worth the risk.

Just one note: The different transfer modes are implemented by vb2,
not by the driver, so changes in the driver should not affect this
specific change.

I have no specific use case for this change in 5.10. So I am fine if
it is not backported that far. But it should be very low risk (famous
last words)

>
> Ben.
>
> > Cc: stable@vger.kernel.org
> > Fixes: 088ead2552458 ("media: uvcvideo: Add a metadata device node")
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
> > Link: https://patch.msgid.link/20260309-uvc-metadata-dmabuf-v1-1-fc8b87bd29c5@chromium.org
> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/media/usb/uvc/uvc_queue.c |    3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > --- a/drivers/media/usb/uvc/uvc_queue.c
> > +++ b/drivers/media/usb/uvc/uvc_queue.c
> > @@ -222,7 +222,7 @@ int uvc_queue_init(struct uvc_video_queu
> >       int ret;
> >
> >       queue->queue.type = type;
> > -     queue->queue.io_modes = VB2_MMAP | VB2_USERPTR;
> > +     queue->queue.io_modes = VB2_MMAP | VB2_USERPTR | VB2_DMABUF;
> >       queue->queue.drv_priv = queue;
> >       queue->queue.buf_struct_size = sizeof(struct uvc_buffer);
> >       queue->queue.mem_ops = &vb2_vmalloc_memops;
> > @@ -235,7 +235,6 @@ int uvc_queue_init(struct uvc_video_queu
> >               queue->queue.ops = &uvc_meta_queue_qops;
> >               break;
> >       default:
> > -             queue->queue.io_modes |= VB2_DMABUF;
> >               queue->queue.ops = &uvc_queue_qops;
> >               break;
> >       }
> >
> >
>
> --
> Ben Hutchings
> The obvious mathematical breakthrough [to break modern encryption]
> would be development of an easy way to factor large prime numbers.
>                                                            - Bill Gates



-- 
Ricardo Ribalda
