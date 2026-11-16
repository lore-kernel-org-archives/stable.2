Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794835432;
	b=lzGsY4C+gw+N6CHYuWlIQOFHhSTAX3fXrNrzQBlXT376sNiL/SZ8oJoeOr1acYkc5aQ+
	 JiSTs0TuBQTi/PxvlOFaUG9yNWBDYyYZuvXEcro1ByCMP7TiLsuqExV4kwPMKPQ4JY3jQ
	 /UZBzFogO0R9MSIRi8Z0V8y/t2mt3JXR0WHyzyGuVzkfKJE4CPhwaNKerhZ55FwUwugli
	 dhqlro95F/Y5HwFK+S7j4P77UX8G3EbUbp+iEuEcppJkTOHMPczXhEr17SyTLmtoVOlWB
	 lu032KAlXNtHgTq49y7W0LoGKUPeFn32/OJA4ogyTe6IqS3wF9fi3AkxwcDv91eAlAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794835432;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=fD5u8EDjljGCE0xDZ4fbiW3sWVh8TOsEBt4cumx8/T0=;
	b=NCBY5a6xzPQZmAaaRx8s0n6OwJPL5jcNhmU6OMPEcNrZY5WkKQSpFQY11KMTyBvKiVGP
	 3Kp2hVKsDfo0fSIKkSB48bsMUcwKVrmnzeCaEZelaInTpyGk819bLsqZkr9EdqKF65LLZ
	 WQvNYAc7sM4YoVffRICUU7VLqBl8ogmvsyaS65fOT7UVdJutqu/ZYsPsFL6Odo3xyl3nb
	 /bpiCueBVgCzXrij5MXEP8U/gvcdnw5jC1f2DPaerWj4ZkPj8Rl0oHvCA4nrF2l81ociG
	 JPLqUNJoMLhNhJdfliyGUmzWA77P5b3pCjUmeO7lVSBH7avPLpmAm771ANHdrt+HfYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=XT+RFfUf;
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B25B606A31C
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 13:23:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B25B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=XT+RFfUf
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8b2f59de176so3867609b3a.2
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 05:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794835431; x=1795440231; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fD5u8EDjljGCE0xDZ4fbiW3sWVh8TOsEBt4cumx8/T0=;
        b=XT+RFfUfprv27LWd5bMdJlkR5mDDJLua3R67x8JDpXNDTPB12x0S/PLhevtlJR92rB
         fJiHrcxc+XmXYOko9f17f0xJylL1yN67m/OrY1tsbt2mc+bFsME+zVTfgeChqFAbpv7H
         yOC5Z1/8c9Bq6zZRY6JIi981H34TqvQL24Nrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794835431; x=1795440231;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fD5u8EDjljGCE0xDZ4fbiW3sWVh8TOsEBt4cumx8/T0=;
        b=bhF0slE0elBqsc0OVyDNaeZJsc2ZVCFLnYxrlT6Ah8qXnfr1SbR8lZrqQzkoBeXyZJ
         spX5rwBxCJh9QkxXqYx/Wae9ap8ylnIedYDsxpH5ogOzzeU8kZvZLS2QId+8cMd8wxQv
         PrRLfI8AiYqN9BVyJHUXvUaD42wNE+7zeM6MM+jVYshfm80YAGurAzRyEfxPwE5TRuZe
         em0F0XhpnyMjp7NsXgatknVM0oFzE3RsbAqo7dyHd2MqjV98YFAoLvF0/kXnlrwduCfp
         rFRSZfWdFcSimS7SV7KnpkqfphmzB2w4dWIhVGlnrLCiKI3DROvdKazrizN2BXJ302Mk
         vrpg==
X-Forwarded-Encrypted: i=1; AL+hErFKugNqwK489nuenDet508OzbpWx46peY7dRw/nr9+izwFGOq54VpmpdeEybPozA/sYLxc4cP0=@vger.kernel.org
X-Gm-Message-State: APuU4Z91S9dQPXOc18ivhlBrCYx4HVBg3RqKXVkn8wRcS8hLgK1+y8xQ
	0ChKh4TVz0c599+XVK31Z5BT3K6pQT9+8mptWp6VWJP512EyCUZx82Yv0+O5i5t3HcwoLdzwr85
	8AQwX7TXK
X-Gm-Gg: AYBFou0mpFhVeTpMdNWcf8hwlLweeKo9OdhSkJshI2ZMJVy1wzR/uDMbC5xEgCcrLlM
	PkREFjEXfccQUJn/f7RhehHhzE14GkxYtGzQ41KG5aBclk9MLa1Pa1TXVYoPXDsEGC2f31Pk6/M
	imaeNsjTEv3IEIlXO3lavYvOZU1I4Hhv5PeGeTtvTBWtwuurGB4hPTX7YvhnsP+vsZ7L94Wb5sf
	pIamsEhqpEYsNoTKvlHsi2iIMC9FgBV5TwHn1sHeNV+WCv+JHoHXrbSsLrY+1aZihHLISl2mQ9E
	eaD5P1yo9uAbVRT5NBrv39rGnKBW/XJy6J767iQi/yTfZZqIXCVxhHX2b8aIWCdh+WlNvsdC2Qg
	vv4DAS++Ag0hBJorD5dmmyMWf2Un8Tvqi3Nu12Vm9DpBfCobut8tCxT2smm+XlPbSJ6iNGOBDOl
	wWaAeJvg0zxpYy//pA7wsfM/vpCUMNFJTgoDAX4R3ad8S7zxsINuO8uPTuoarZ6RIDCyoS4HnzH
	uE5s9wgNu138CLSeYJcRf/VkhjM7ovh+fgu9iG3yGXf9jLl0ApoFNX1PjU85EaPwSfn9H5pEVXZ
	bvQ42u0l/PmtB3NT2nGohkzVxIT19Zb1aR87OFOhB7giK8LuNyrl0IkOrhhu//8ibQ==
X-Received: by 2002:a05:6a00:2d1b:b0:89e:37b0:d1bc with SMTP id d2e1a72fcca58-8beb658dfa5mr10126552b3a.28.1794835431147;
        Mon, 16 Nov 2026 05:23:51 -0800 (PST)
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com. [74.125.82.48])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bfca804fbesm3023467b3a.28.2026.11.16.05.23.50
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 05:23:50 -0800 (PST)
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1b50a4bd2f3so3710276c88.1
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 05:23:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErG9kxChMT1YFnowce7hdgGeJ5TWWI/bbDAL0voelMv6b6gde25+0Io7HQkTifSDUrKqaTXQI38=@vger.kernel.org
X-Received: by 2002:a05:701a:cc91:10b0:1b5:2dce:1b6d with SMTP id
 a92af1059eb24-1b52dce1c17mr3055768c88.17.1794835429211; Mon, 16 Nov 2026
 05:23:49 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116-uvc-shortmeta-v1-0-487cfe42fa89@chromium.org>
 <20261116-uvc-shortmeta-v1-1-487cfe42fa89@chromium.org> <20261116130839.GA1714298@killaraus.ideasonboard.com>
In-Reply-To: <20261116130839.GA1714298@killaraus.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 16 Nov 2026 14:23:34 +0100
X-Gmail-Original-Message-ID: <CANiDSCsuPhCyeFWSBPWauECVHQ5A0ySMSqvC7UB6W9ZR4_+iAA@mail.gmail.com>
X-Gm-Features: AclHuK_Zhc9uC1guqtPyu4702nINbtLFRGaSTrUWoBHn2UUyYnjYXDCq7yKTSpg
Message-ID: <CANiDSCsuPhCyeFWSBPWauECVHQ5A0ySMSqvC7UB6W9ZR4_+iAA@mail.gmail.com>
Subject: Re: [PATCH 1/3] media: uvcvideo: Reject short metadata
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans de Goede <hansg@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sinan Turunc <enscrpt@pm.me>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Laurent


On Mon, 16 Nov 2026 at 14:08, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Mon, Nov 16, 2026 at 11:56:37AM +0000, Ricardo Ribalda wrote:
> > The UVC header has two bits saying whether the packet contains the
> > optional PTS or SCR fields.
> >
> > If the header says that those fields are there, but the header is not
> > big enough to hold them, there is something wrong going on and we could
> > read out of bounds.
>
> There are multiple checks scattered through the code for this already,
> some of them causing the whole data packet to be dropped, others just
> short-circuiting operations such as clock and stats updates. Did you ned
> see those ? It's getting too messy.

Yes I saw them :P.

I can move the tests to uvc_video_decode_start(). The question is what
we should do for non compliant cameras.

I would love to just drop the packet altogether (with a non compliance
warning), and if someone complains... we can add a quirk or some
heuristics.

Will send a v2


>
> > Mark the metadata as invalid and move on.
> >
> > Reported-by: Sinan Turunc <enscrpt@pm.me>
> > Closes: https://lore.kernel.org/linux-media/20261115121701.189-1-enscrpt@pm.me/
> > Fixes: 088ead255245 ("media: uvcvideo: Add a metadata device node")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/usb/uvc/uvc_video.c | 8 ++++++++
> >  drivers/media/usb/uvc/uvcvideo.h  | 1 +
> >  2 files changed, 9 insertions(+)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> > index a92a986ab714..9cc5d83acbc2 100644
> > --- a/drivers/media/usb/uvc/uvc_video.c
> > +++ b/drivers/media/usb/uvc/uvc_video.c
> > @@ -1487,6 +1487,14 @@ static void uvc_video_decode_meta(struct uvc_streaming *stream,
> >       if (has_scr)
> >               len_std += 6;
> >
> > +     if (length < len_std) {
> > +             uvc_warn_once(stream->dev, UVC_WARN_META_SHORT,
> > +                           "UVC non compliance: payload header length %u is shorter than expected %zu (flags 0x%02x).\n",
> > +                           length, len_std, mem[1]);
> > +             meta_buf->error = 1;
> > +             return;
> > +     }
> > +
> >       if (stream->meta.format == V4L2_META_FMT_UVC)
> >               length = len_std;
> >
> > diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> > index af8cef94ffff..59e23e55bc2e 100644
> > --- a/drivers/media/usb/uvc/uvcvideo.h
> > +++ b/drivers/media/usb/uvc/uvcvideo.h
> > @@ -661,6 +661,7 @@ static inline struct uvc_fh *to_uvc_fh(struct file *filp)
> >  #define UVC_WARN_PROBE_DEF   1
> >  #define UVC_WARN_XU_GET_RES  2
> >  #define UVC_WARN_QUERY_CTRL  3
> > +#define UVC_WARN_META_SHORT  4
> >
> >  extern unsigned int uvc_clock_param;
> >  extern unsigned int uvc_no_drop_param;
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda
