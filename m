Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DB6439F8F
	for <stable@vger.kernel.org>; Thu, 13 Aug 2026 20:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786654379; cv=none; b=uT8VtUG/MKVCcsd8I/LZExcCoE2D7V+CNhy1gcfkNjgMjbEwsljIEOGLy3JaFaCZdyyBO/d/O5OB8VUSbfZYg2O5oFSc+fm3i8DLoYnEb0b62Z7Z7LXp6bDXPHxABzeOolJutYU4fJl6XAeG/sVKl8ONnz145BuTo/zCd9hMLwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786654379; c=relaxed/simple;
	bh=YvOvKR30cP/m0cVMtk8jy1/sQaWDyEAB2J7fRPzdSJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P++6Y3AkSAVC/Fxn5+OAIb4pgD/1EVKmaqmq1GWa7Jv08R9C5L87mdZMRyg3ySyRq/Blbv9eYsGbgMeefObNk6zoXTAIjVZ2UEzqdYapseCoE7SUmVtUYp/WD7dS4ZnZ75VP7g00IRuOEIIOSw7pOoBScnMhNnzw9h6fyRtxZE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dfCoiR5a; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dfCoiR5a"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c20e70a0962so58970066b.2
        for <stable@vger.kernel.org>; Thu, 13 Aug 2026 13:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1786654372; x=1787259172; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QKG0huuOVMT2uJhSczfBBnWYxOx3sQqhXePb2p3rxzk=;
        b=dfCoiR5aqz2QH20h+i8QHojYXSXQ4+l0hT9FqtXrZG4y84RiB+hN0c1gY+QysctZdf
         LWPlN7uB1TVv6zBa/I4KTqs9uwLDZFozJUm0gULsIX5VorjUiC4+2DZwkM9QIWRRwuMo
         IJX9WNDh4RsLCg/dtCOVdAzzkbGc3DsM1dzxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786654372; x=1787259172;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QKG0huuOVMT2uJhSczfBBnWYxOx3sQqhXePb2p3rxzk=;
        b=ofFoWM+1lACb8NrL3cUpoUOFhCPehFCX1N5uZhWz/O/yoD2AYB1WMCLL6Mb68E1H4s
         s8pz1uUXRHf5hSde/lXgprOgT04RjDdD+sAO9MgX87OFUH+KvGKD2kQCWr/z1wVsQMuk
         TqC7ozUUhFpe/XGna89gcKvbGALNVsDkQ4xRNe/H0LhoO/Rn7LpV38WdgVDvtJbXWrt9
         qwJ9yJwNRbDtNGcbhD8wknqb8sYj0IwD26H80Ja9kRXAej2aeJsqG0WKOGoSq6dLk1tP
         CAF1i6UeK5ubDnVCWmxG9FrD7twZO/NgTO5xVzlg1l/j3CZqwb/0mMtF6klcF3ugIIJ/
         GfXg==
X-Forwarded-Encrypted: i=1; AHgh+RqYa6s2u7k32XsbfJ/W0iCF/MoWwmVzbhePXpR/+EE7/x7eP+tyKpmQeCN6Awfv8/foYKq6WyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRo0sT/aZJ1XHdKRjKEPHFDjFSKOaVWoLxIbX89O7HwOR7DjTZ
	rYJlrotlf1U8gIoXxGRz4fHGvb7GEziFrQAHh/XTx6SNfE/HphbjLHHdXaS5Qo94W76+H5oB86F
	NdM2yjw==
X-Gm-Gg: AR+sD1378H+NTAxrjVv1YV2PqhNJzE0+ZS5S9R2Xi5CBBm38wvBPL1XmaDPa8eud+gB
	lzJWkj92dY/I34Xr3oOCPnjCmDOfcN+JdYa+rA6O9WumuyvZ2kpjL77a7/EMp2CaLHUm4n82Pzk
	tG7FrOR+/tRrBmLip8rvsYWP3RKs3GCqKMKTadli1bJXPMLhj+HrExWRm4nEKspoIUpFdawnD3O
	qb3+mk4PRkifgZ20uMrIb1uh1ugmHAb+RPguNYBdfJkqCypZIVCtEIuLivtKUqTiSNc2B0AnD55
	7XLds0slPyhJ0lEw/68OjjtQx4cid3q9H/hhEIUXdKHGNW960NIN8jfjpGZOstbYvdzMBnlji1Y
	J05pBUUaLkUczCa/Defonn5GIht3DNaEcb78tlFarTI7BEuWQGC6YBGTuZ1alj0duvo15vMJj9Y
	RIqRri9qw+gQcSzyl4YFKoFqEFv2Hpe2e1GAwm9XmV+zTzdFafkCZkx4TDkF4tyyilThVU2jIEo
	K54r9/XAxLL/V0QTFuTvb4HoA==
X-Received: by 2002:a17:907:3d4d:b0:c16:3187:997e with SMTP id a640c23a62f3a-c2129a8c5f3mr46501466b.7.1786654372528;
        Thu, 13 Aug 2026 13:52:52 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2123858ca2sm28392566b.60.2026.08.13.13.52.51
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2026 13:52:51 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c20e70a0962so58966266b.2
        for <stable@vger.kernel.org>; Thu, 13 Aug 2026 13:52:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoEdY2oNkNbqRvKprjVewQhNoGudwyWlnUxAWH0G18U2m5B/rpCjgmPb/pBTuo6Hbmjqhrv4c8=@vger.kernel.org
X-Received: by 2002:a17:907:874f:b0:c21:167b:47f0 with SMTP id
 a640c23a62f3a-c2129a8508amr50889566b.2.1786654370710; Thu, 13 Aug 2026
 13:52:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <F0F008459FFA835D+20260813074632.2021311-1-raoxu@uniontech.com>
In-Reply-To: <F0F008459FFA835D+20260813074632.2021311-1-raoxu@uniontech.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 13 Aug 2026 22:52:38 +0200
X-Gmail-Original-Message-ID: <CANiDSCsguGSgvEkWTCWVEctHFYN3teRXS07OczJfumWzVqv4Qw@mail.gmail.com>
X-Gm-Features: AUfX_mxdIy5-HXGmurVL_I6Zb5p7z94joSTv9qPTZsylVv8sW9Fe3PFFjKqGIpQ
Message-ID: <CANiDSCsguGSgvEkWTCWVEctHFYN3teRXS07OczJfumWzVqv4Qw@mail.gmail.com>
Subject: Re: [PATCH] media: uvcvideo: preserve status URB interval on resubmit
To: raoxu <raoxu@uniontech.com>
Cc: laurent.pinchart@ideasonboard.com, hansg@kernel.org, mchehab@kernel.org, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Xu

Good catch :)

On Thu, 13 Aug 2026 at 09:48, raoxu <raoxu@uniontech.com> wrote:
>
> From: Xu Rao <raoxu@uniontech.com>
>
> usb_fill_int_urb() takes an endpoint interval value and stores the
> period expected by usb_submit_urb() in urb->interval. For high-speed
> and SuperSpeed interrupt endpoints, it converts the logarithmic
> descriptor encoding to the corresponding microframe period.
>
> The UVC status URB is initialized once in uvc_status_init(), including
> the UVC_QUIRK_STATUS_INTERVAL adjustment required by high-speed devices
> that report bInterval using the old full-speed convention. The first
> submission therefore carries the intended interval.
>
> Both status resubmit paths, however, overwrite urb->interval with the
> raw endpoint bInterval before submitting the same URB again. On
> high-speed and SuperSpeed devices this mixes the descriptor encoding
> with the already converted URB interval representation. For devices
> using UVC_QUIRK_STATUS_INTERVAL it also deterministically discards the
> quirk adjustment after the first status completion, making the
> workaround effective only for the initial submission.
>
> This has been easy to miss because the initial status submission is
> correct, full-speed interrupt endpoints do not have the same
> logarithmic encoding mismatch, and the status endpoint carries
> relatively infrequent control and streaming notifications rather than
> the video payload itself. The problem only appears after the status URB
> has completed and is resubmitted, and the externally visible effect
> also depends on how the host controller handles the resulting period.
>
> Do not restore bInterval when resubmitting the status URB. Reuse the
> interval established by usb_fill_int_urb() and usb_submit_urb(), which
> also preserves the quirk-adjusted value. No additional state or
> interval conversion is needed because the same URB is being reused.
>
> Fixes: c0efd232929c ("V4L/DVB (8145a): USB Video Class driver")
> Fixes: e5225c820c05 ("media: uvcvideo: Send a control event when a Control Change interrupt arrives")
> Cc: stable@vger.kernel.org
Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
> Signed-off-by: Xu Rao <raoxu@uniontech.com>
> ---
>  drivers/media/usb/uvc/uvc_ctrl.c   | 1 -
>  drivers/media/usb/uvc/uvc_status.c | 1 -
>  2 files changed, 2 deletions(-)
>
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index 3ca108b83f1d..6552f541aa0d 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -2196,7 +2196,6 @@ static void uvc_ctrl_status_event_work(struct work_struct *work)
>                 return;
>
>         /* Resubmit the URB. */
> -       w->urb->interval = dev->int_ep->desc.bInterval;
>         ret = usb_submit_urb(w->urb, GFP_KERNEL);
>         if (ret < 0)
>                 dev_err(&dev->intf->dev,
> diff --git a/drivers/media/usb/uvc/uvc_status.c b/drivers/media/usb/uvc/uvc_status.c
> index b632cf5e3fe9..680c6c7f4ad7 100644
> --- a/drivers/media/usb/uvc/uvc_status.c
> +++ b/drivers/media/usb/uvc/uvc_status.c
> @@ -245,7 +245,6 @@ static void uvc_status_complete(struct urb *urb)
>         }
>
>         /* Resubmit the URB. */
> -       urb->interval = dev->int_ep->desc.bInterval;
>         ret = usb_submit_urb(urb, GFP_ATOMIC);
>         if (ret < 0)
>                 dev_err(&dev->intf->dev,
> --
> 2.50.1
>
>


-- 
Ricardo Ribalda
