Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D15B40E8D7
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 07:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788764453; cv=none; b=fnhJjmNMVzBzZw6FnuYTWrGgAbsFINkfz5YKFXNzwwb/CdPeYGqAbf7AP886ej1H9aDaxer1un3vG8RiR2PtXNARKkfSlT2EWO4Z8b0AUjLGE3SmskqRJRQKm8l5c5Fs1lcJFE6aBjvohW8bFi28QlpMhXjHXdlxWa/InEiK7Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788764453; c=relaxed/simple;
	bh=sLQ3SwAUUXRzuIZz/i1Gx4vixDbuAVR782D36s6FlvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ad6Ksiv2HtitY8rHiMdm6hfe7YcbqbiTFXn5SSa29Bp/xsrlGlhuwq+NVHYrPeFD+byULQB9/A0XSMzjzXwWwzvbVG1BlqxcpSzdpZ6eAheAI1Kteb4Iqf95/5rt2f0rSldAQxUSTYChQSnqMuhwj17RRez6dWo7RSYFCyDDS6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=C4Cx/ZjX; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C4Cx/ZjX"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38dfe910e9dso3489392a91.3
        for <stable@vger.kernel.org>; Mon, 07 Sep 2026 00:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1788764451; x=1789369251; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q5WskygW+ceCXuqHmaYkYH5iopbTLupaw7gvlN5zYQE=;
        b=C4Cx/ZjXgOFlwoT1pY9XlxfwhBPYkPXBUEs19NonQMfb/7j4gdJMw2uK3Q1I9KqoCq
         pjn+DA0iYjLAsXxG1MvU0u1JgCeDKt9Yq+u28QIyMtZO+MZHzegnAZWbjCr3UdiEtdEb
         1WObl3LrRcgjwAPDUerz0LxTobZpYZu4y1pDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788764451; x=1789369251;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=q5WskygW+ceCXuqHmaYkYH5iopbTLupaw7gvlN5zYQE=;
        b=Pv7/oN/DSJ9RkyxKshLcWMZtPOyd3yyWwZCJj1akuwnRgdfPi75Q/HGGY+lyqLvGYQ
         mHTNRFkNd7yjpJGIIGJNI01NKiZZxtWyhSJQ9J2k/eOoFMxXApt2l/AhphMjLiJqr276
         37N3a47Uix/rvrsO7aOrMsA1KJCUg7T6QjhSO+S6ZAaRPVbqGi5r4tEEAfxYO3RFDiOZ
         OelgSCgxF6oZeZX1giOoZ23Byd3gPtint5agmfD4DcutQLFXzwYCevtQm/e+xJfEg7VB
         tMvQXTOJolDO+jyr+Fs2rQ1HA3wJB89cqquSM5LuWreRU3AUyvlLkMH2d+wOs9A5ageN
         1RPA==
X-Forwarded-Encrypted: i=1; AKwUvByOnvVUQ9I25fDcE56xGB9fRC9iYdjMCZHBbnO/uLxU40L6szzL6XNPsqK4rfGKerQWFdpVGUE=@vger.kernel.org
X-Gm-Message-State: AFuF++lIgNctl6rggxVMUzGKzAuxAndUhwn9BMCfMu6yE6uS170TWfFV
	trotPP6T+5c5kYCaeMPDkPCqYdKLX46R/ADdijVTyCgrA9W4Zh4nnzvMc5075tO5RIpbglKNpMi
	ONBHwKw==
X-Gm-Gg: AYBFou1ib7UiN2oFCIKAtoVf4toFeEaGK7XOd5zLPvaqTtPZ8Ivk3l7CZTd7MpdSSgC
	365eSYxOdlmSNSLfl7YYEfLUxRqNsdTHWQmYHgp6N5q8UmXAcha66WMaK1wkna2jL3dU6RDzjm+
	Pw6wQU5wai2zVqJylgkKk/zlyPbm+GK3AaJ+xUs1ileZAn6DTDtq804CKvtORaomds4sPULmaWG
	3WOJ1hj4xIDE+FBLW/7OHC4vnbpinVEyXoJ7ApJgmxvaN7CcWwhPAen2c1K/O8IHxjCSWW9ZOCm
	5iKHxqai/sSJQ7BpNzSm8eAf3lT88UYs32X4Wi2NAig9IAUirYYhQqvyqvEklPWvPXJ0brWbP+G
	U6cUpVlAhpKCzqWboZxB2uS/W1NHElvKuP8qwVhD/vSi3s9qIkpCfCw7+U4yiaK31OTwWgNPiek
	UrYKvkQCHsI74pTAaL30WjuYbhYreZJoK02BW7n7NZXghzhwgt8Qil0igazua7i2cZRxg1vqBaV
	FmriywXKXvYBYQnFJ6Sa7tVr/uddw==
X-Received: by 2002:a17:90b:2687:b0:395:4290:46e0 with SMTP id 98e67ed59e1d1-39b2609f768mr36126017a91.5.1788764450269;
        Mon, 07 Sep 2026 00:00:50 -0700 (PDT)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com. [209.85.215.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b26127fddsm18425430a91.12.2026.09.07.00.00.49
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 00:00:49 -0700 (PDT)
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc1cc1b42b5so3307248a12.2
        for <stable@vger.kernel.org>; Mon, 07 Sep 2026 00:00:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy8jhs3CHiYJoqv95PdFFnokU7ftH6D8FVU8hqxKDPO+5v18wNV7K3h9/o8PMdWCxCvdre5eM4=@vger.kernel.org
X-Received: by 2002:a17:90b:1343:b0:38e:9eb2:9d43 with SMTP id
 98e67ed59e1d1-39b261b1bcfmr37283600a91.16.1788764448217; Mon, 07 Sep 2026
 00:00:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907062819.2519878-1-98lawweijie@gmail.com> <20260907062819.2519878-2-98lawweijie@gmail.com>
In-Reply-To: <20260907062819.2519878-2-98lawweijie@gmail.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 7 Sep 2026 09:00:35 +0200
X-Gmail-Original-Message-ID: <CANiDSCtypCfEoZbRvdT7EoJdd2G8yOVcvxBoS5LcE60UjFQx2g@mail.gmail.com>
X-Gm-Features: AcwNN1X7eNH4dgTPP7uE_95pl9LbXvmNZv7-4pX7KqzlKshUnu0bIwYnd8a9zmQ
Message-ID: <CANiDSCtypCfEoZbRvdT7EoJdd2G8yOVcvxBoS5LcE60UjFQx2g@mail.gmail.com>
Subject: Re: [PATCH 1/2] media: uvcvideo: Fix NULL deref on events for
 uninitialized controls
To: Wei Jie Law <98lawweijie@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans de Goede <hansg@kernel.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Wei

On Mon, 7 Sept 2026 at 08:34, Wei Jie Law <98lawweijie@gmail.com> wrote:
>
> A null-ptr-deref exists in v6.12.105 and upstream. KASAN crash log:
>
>   KASAN: null-ptr-deref in range [0x0000000000000080-0x0000000000000087]
>   Workqueue: events uvc_ctrl_status_event_work
>   RIP: 0010:uvc_ctrl_status_event+0x105/0x280
>    uvc_ctrl_status_event_work+0x82/0x240
>    process_one_work+0x66f/0x10b0

Could you provide more info on how you reproduced the error?

>
> XU controls are initialized lazily, on the first UVCIOC_CTRL_MAP or
> UVCIOC_CTRL_QUERY.  Until then ctrl->info is all zeroes, so
> info.mappings is not a valid list head, list_empty() returns false, and
> uvc_ctrl_status_event() walks it from a NULL next pointer.
>
> Fixes: e5225c820c05 ("media: uvcvideo: Send a control event when a Control Change interrupt arrives")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wei Jie Law <98lawweijie@gmail.com>
Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
> Assisted-by: Claude:claude-opus-5
> ---
>  drivers/media/usb/uvc/uvc_ctrl.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index 3ca108b83f1d..21802f9b1b61 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -2209,7 +2209,12 @@ bool uvc_ctrl_status_event_async(struct urb *urb, struct uvc_video_chain *chain,
>         struct uvc_device *dev = chain->dev;
>         struct uvc_ctrl_work *w = &dev->async_ctrl;
>
> -       if (list_empty(&ctrl->info.mappings))
> +       /*
> +        * An uninitialized control has a zeroed info struct, so its
> +        * mappings list head is not a list: list_empty() returns false
> +        * and the walk dereferences NULL.
> +        */
nit: I would not add the comment.
> +       if (!ctrl->initialized || list_empty(&ctrl->info.mappings))
>                 return false;
>
>         w->data = data;
> --
> 2.43.0
>
>


-- 
Ricardo Ribalda
