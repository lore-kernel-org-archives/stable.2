Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A668840B36E
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 10:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787221808; cv=none; b=Js4060I1mqjw45+ZEVGBfwXOlyEv3ft4IRESvugFwQLTBBKfBQvZbctQhYfb3F8iIncM0MM1fSTalazyY4MgjJi4jTqkQId3q7Dw+3pD/ENinLYr03CyLEVIoWEhSpzwPBOsF0/IAjkqX9XViuv33JaWpozamj8nzv55/E8qy20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787221808; c=relaxed/simple;
	bh=g3JRO9O7G2IJDN+8UQIFj94a5h1FQ3MFHRJ7R/0D4SY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sI7pwno074AvsIxHXjwoKCCUIxcVs6r2jtY7KoSqhk55EyT7TxGZUtM9DkDV9qz3olTVyOiutqRtNtxalsPUz5wvPABLt/R+uq7X0kQjPD1gBHVfkfqrXyoCWnFQOpaAi7sUrq5hKkM7axkBIv4rgweZuukEw67ZF27XvDqB4r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RYqrE7pS; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RYqrE7pS"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c15ca7a7ca9so233890766b.0
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 03:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1787221805; x=1787826605; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xgk0gcUij9t1Zktyfwo1OhttybzA3umgR6gVLSa3/4I=;
        b=RYqrE7pStp/5NyRQIbUnc2YMal+Ibmx2K28Nekk3nbJS7qfoc2QJCOa01xpIOuE+J3
         +MINjqN+5LT148EGKCKlG5tZFNNFZ7mLoKRDtHVsQcCHKK1rSQytrNyiDwM5qGOJbXFZ
         95dVO2Yt5jFkNLuf5RtsK6CsEDmd/e1jeEel8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787221805; x=1787826605;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Xgk0gcUij9t1Zktyfwo1OhttybzA3umgR6gVLSa3/4I=;
        b=cHqxQXD//D8FBsXRmJAAbk78we1gk3383Sq5duNrYXjjIiTW95oF/t42XIeMHigROe
         13qsc3tGWUmXezFfBZdjHpEY8dzPkkZWFYniTGGnr4dWd/DFxbhnY2QHGDfkiw5S58ZB
         hSmfG9/OUlUX+/F0fZ5mRkQyRqFjDSXqq9tG6K9TWSZYySBVLGXYjA+2lxK/q4zhGZ9T
         FWw14j1+w4pm7X/zGf5f0DWKyHANnVJ7GNNB8hELUrA5k507EJVLrV+bsAbkmL9Y7Irk
         vfVNhDX4Dsg15HmP4qxhKiPLpRmunaVf3Hc61xt536OhefHluNBS8xuqemRzjId1Lj6q
         RiJg==
X-Forwarded-Encrypted: i=1; AHgh+RrHhj73/7/si7S+X2VmHhaUZxI05TJbt+X3Wx0xvbKYMrYwV+Cfr8P23vtW8fOW0SeKV8fug9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXhlmWMEXmm8EDS1n6vqJJdglQm5exOf0I5jxCo4tpEbcjOLJD
	VgKju4eVe3RsQ1FLrJ5texC5lZU5/DjufF8WcFZzomZ7Dw5z1gXTC1iDWSLURJs5d8hceNHK3ha
	Ay1EjCA==
X-Gm-Gg: AR+sD109V8N9x3uZ2PLax5B72YfPG5YciNIbRTarW50PlDBYuxFHjy6w6rda/AwEEBD
	cfttJwllsMahQ2J7s+e+iXi2K6BvadZJX6OlbS8VzrCwhvNEQk0Rch43YjwicbykgEczu6UeS+A
	Qkizwpu6u2xkAGI7AvrhWzVGJT5noLMwOAdpjTNr9VVWwUq/KQ42VZD8GTE2Lk6VpcCRlY/crqs
	NxNh5jEXWlprXLzd9f3vJV5Q630LlAWHgBzJjUzd9WtUiH1E1dxKON9ai03U+Pgy6fB0DrdjtWA
	emR0V9N9qzusNBKPPqr5RU7ViSdzQLh2Mdtx/Bik3TqyV5LW+hxvtm+wAAgXDj2GC0WZH6GV21L
	ffj6OFHBCCSPAkLdTUolvCLIbFFcZXvEKIj3bChWnLg+3Iv7CwYKxy2jwO3x+hQWIodr16INJxB
	vYSIFi7gl6PRaI8bfF0GHk+gIspXYIfOy1T7aEXw/MkwB0KXOpXP4j1JX5hcVxj+rDFa1zz3YTV
	GM3T0307t4j69RaooP/mG41eA==
X-Received: by 2002:a17:907:c783:b0:c20:f871:1020 with SMTP id a640c23a62f3a-c242e1e8d81mr873096966b.19.1787221804997;
        Thu, 20 Aug 2026 03:30:04 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2459198cf2sm51864566b.40.2026.08.20.03.30.03
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 03:30:03 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c15ca7a7ca9so233887166b.0
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 03:30:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqmM2dScynhgWax+6Ne7xqg/b3p2yeUh7oFKfpJe/+THatBNKUvnAhPnb+fp/sCtjse3YhZroA=@vger.kernel.org
X-Received: by 2002:a17:906:fe42:b0:c21:9cf4:e1b0 with SMTP id
 a640c23a62f3a-c23f929e249mr793080966b.3.1787221802587; Thu, 20 Aug 2026
 03:30:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820095626.111196-1-natalie.klaus@runtimeverification.com> <20260820095626.111196-2-natalie.klaus@runtimeverification.com>
In-Reply-To: <20260820095626.111196-2-natalie.klaus@runtimeverification.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 20 Aug 2026 12:29:48 +0200
X-Gmail-Original-Message-ID: <CANiDSCtDyJsFrz7iBe8Yb8rPM=Tb1e1av9qGcNwE-C5nwFPfZw@mail.gmail.com>
X-Gm-Features: AcwNN1WOz4wySaVT8CaYdQaKGy6rC0J4crS2XKI6gD7IQwqmpusCzVh5-L3tA38
Message-ID: <CANiDSCtDyJsFrz7iBe8Yb8rPM=Tb1e1av9qGcNwE-C5nwFPfZw@mail.gmail.com>
Subject: Re: [PATCH 1/3] media: uvcvideo: Let uvc_parse_frame() report a
 skipped frame
To: Natasha Klaus <natalie.klaus@runtimeverification.com>
Cc: laurent.pinchart@ideasonboard.com, hansg@kernel.org, mchehab@kernel.org, 
	noambs2999@gmail.com, david.laight.linux@gmail.com, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Natasha

On Thu, 20 Aug 2026 at 11:56, Natasha Klaus
<natalie.klaus@runtimeverification.com> wrote:
>
> uvc_parse_frame() returns the descriptor length on success and a
> negative error code on failure, and uvc_parse_format() treats every
> negative value as fatal for the whole streaming interface. There is no
> way for the parser to say "this frame descriptor is unusable, but the
> rest of the format is fine".
>
> Change the return convention so it can. Return 0 on success and let the
> caller advance by buffer[0], which is the value the function returned
> anyway. Report a truncated descriptor with -ENODATA, which stays fatal,
> and leave every other negative value to mean "skip this frame descriptor
> and carry on with the next one".
>
> -ENODATA is currently the only error the function can return, so the
> skip path is unreachable until later patches add checks that use it. The
> one behavioural change is the truncated-descriptor diagnostic, which
> moves from uvc_dbg() to dev_warn() so a malformed descriptor is reported
> without the DESCR debug flag. That leaves the local alts variable
> unused, and the kernel builds -Wunused-variable as an error, so it goes
> too.
>
> Suggested-by: Ricardo Ribalda <ribalda@chromium.org>
> Link: https://lore.kernel.org/linux-media/CANiDSCue8yyiGubzbAybRqSUTTFuB=-Y2TZy6yvOx32SpAASWg@mail.gmail.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Natasha Klaus <natalie.klaus@runtimeverification.com>
> ---
> The Cc: stable line is present without a Fixes: tag because this patch is
> a prerequisite for 2/3 rather than a fix in its own right. Stable needs
> both or neither: backported alone, 2/3's -EINVAL would revert to meaning
> "discard the whole streaming interface".
>
>  drivers/media/usb/uvc/uvc_driver.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index e289cc71ba98..0cc0e351d139 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -230,7 +230,6 @@ static int uvc_parse_frame(struct uvc_device *dev,
>                            u32 **intervals, u8 ftype, int width_multiplier,
>                            const unsigned char *buffer, int buflen)
>  {
> -       struct usb_host_interface *alts = streaming->intf->cur_altsetting;
>         unsigned int maxIntervalIndex;
>         unsigned int interval;
>         unsigned int i, n;
> @@ -243,10 +242,10 @@ static int uvc_parse_frame(struct uvc_device *dev,
>         n = n ? n : 3;
>
>         if (buflen < 26 + 4 * n) {
> -               uvc_dbg(dev, DESCR,
> -                       "device %d videostreaming interface %d FRAME error\n",
> -                       dev->udev->devnum, alts->desc.bInterfaceNumber);
> -               return -EINVAL;
> +               dev_warn(&streaming->intf->dev,
> +                        "UVC non compliance: FRAME descriptor is %d bytes, expected at least %u.\n",
> +                        buflen, 26 + 4 * n);
> +               return -ENODATA;
>         }
>
>         frame->bFrameIndex = buffer[3];
> @@ -329,7 +328,7 @@ static int uvc_parse_frame(struct uvc_device *dev,
>
>         *intervals += n;
>
> -       return buffer[0];
> +       return 0;
>  }
>
>  static int uvc_parse_format(struct uvc_device *dev,
> @@ -492,11 +491,12 @@ static int uvc_parse_format(struct uvc_device *dev,
>                         ret = uvc_parse_frame(dev, streaming, format, frame,
>                                               intervals, ftype, width_multiplier,
>                                               buffer, buflen);
> -                       if (ret < 0)
> +                       if (!ret)
> +                               format->nframes++;
> +                       if (ret == -ENODATA)
>                                 return ret;

I know this is my proposal, but if you resubmit the series I think it
is more correct to swap the order (sorry about that):
 +                       if (ret == -ENODATA)
 +                                return ret;
 +                       if (!ret)
 +                               format->nframes++;

> -                       format->nframes++;
> -                       buflen -= ret;
> -                       buffer += ret;
> +                       buflen -= buffer[0];
> +                       buffer += buffer[0];
>                 }
>         }
>
> --
> 2.34.1
>
With that minor nitpick, regardless of whether you change it or not.

Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>

-- 
Ricardo Ribalda
