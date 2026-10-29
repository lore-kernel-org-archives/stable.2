Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793285020;
	b=gvUYW93vLXP2S92GfBhV4BXsgPpkyQorTVbVMXU7D6n6InxsTZiECmKRZatP1Nr+ml9E
	 qpSlDXweETvyTuXoFMoWvBypAEpbdHYLNs1qDjGL7YhQZpupXauzU9GM6NRqApF1J0TQ0
	 DNrkm5/SeJ2kh+k8DulMWJrxDjxOKRJ6YrXUn+6FCG9y/IwO/jBzkhePMteY7CHccH1L+
	 HWkGH+/clgyFQM/l0rg4I9ekrZ6rJjwuUkSgO+QgUakhB6UDrs5L/KY2RSi1/P0in3Pm6
	 8ySrDT17+VR1B6x1X/kLBvsnwIi/ZGHwp4xFQZCuqqiNZLTV6txqlWeRaJBwdCQx1rQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793285020;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Z145znUTSRyPKtFzUaXDyFLwmD4HnEY3Xx0IIr8udHg=;
	b=FT0qMgWJjCbEBIt8f76qlBsP4uvnxRtrj+WuPpXLlCOhF9HVR4OeE2k/TZ0WYSzsFoNN
	 NaimVbn26GR+bma7lFKRUYkOYGxOK6kZLU124bMYJR7nshMmLs6oe8nFDXq6nSraCA2YI
	 yoAp4LZb9ZgqIxtr7iakvUdFCgSgFsuZRd+YYuXE3XDDwBL4NgzaJhPymt2OhnI0qxEql
	 9aCkkdPKVqOXZxMoOVqzR/VH82pS64c2oJBjSH48hL5g/CFAf7JHoicQwAtVfn6c3XBME
	 tPxQu5dRDci5PsKTlQX99Z4CslIHf8bPRg6MXdHIeLHwkZA9wiNkGsDdkSyUCeU2shQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=raspberrypi.com;
	spf=pass smtp.mailfrom=raspberrypi.com;
	dkim=pass header.d=raspberrypi.com header.i=@raspberrypi.com header.a=rsa-sha256 header.s=google header.b=LGEsOJ3Q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.179
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096DA606A31F
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 14:43:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 096DA606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=raspberrypi.com header.i=@raspberrypi.com header.a=rsa-sha256 header.s=google header.b=LGEsOJ3Q
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-4af173320f9so1562774b6e.2
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 07:43:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793285019; cv=none;
        d=google.com; s=arc-20260327;
        b=Q8i8gv0wkzXScW3aT7WtnssfpKjQ/yKz33cZZpexgQU8C8P9UAAqPu9e41oKJjI2w5
         85/9S4sIsYmoe1v306gXTqGd92bKzpDaGWSoSXXg8LcrGf3UQnk3hLfXwuxTN+c0AzmR
         VqIkgIDY6HSsF4auLUZMRxPp5Pnqn474WzN2dB0fiLUgopM0d/aqOVnFk6s6APhwDgTr
         bcHHJ6pVgdHqqFs9Xh5f2y81HBh31HhjS4t9+s6s1A2ocXhXT9SYYZOsnmu7mt+J26UK
         eZVAMt1VJnFVnyXrUvwdS1JatLaefrZSb8DDKVMgtZOKNZQOyaO6Y8Z0OIuSHIR66RPa
         K/Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z145znUTSRyPKtFzUaXDyFLwmD4HnEY3Xx0IIr8udHg=;
        fh=gKnSn2QOXcMmbeCZulcOUL2Zjs5nQyzS6j4Jho+DGww=;
        b=Jm0HKHKNwEAYuXBYIkVG+mDHk6v42mnKCo7+PiYYJuHXYPprnId0Rz8JwSuC4Np7Ns
         FXLIjPsaXQtFRiVIxWcbKdx/YfCi8j/+GZOjeUrFeKo6YPg7yqF8J7ghOXBd2MbJGhjA
         8lTPu/0OtyOAjV1WvPZRL1g5CPai5u7pgqo9KwymvI/1e8hxiP6IYMBaZfEJuS+3dluB
         9LaY0dFlMz/rGmbA8ajumoZz+J1SuRsuTCc/jdr4m33W2jmezdweAtvvfzaSc93uDqzZ
         h9dvvQrfBVxqfRzLmaEnShZkAEKID/tc4tXyrhr99M1qyRn8+5wDODUmlIMVZzG9Tsef
         M5fw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1793285019; x=1793889819; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Z145znUTSRyPKtFzUaXDyFLwmD4HnEY3Xx0IIr8udHg=;
        b=LGEsOJ3QYduacOrB/GeiIi+kGiHmrU2C3iF7B1awE1Dxal4fLPMbrVAp2a4cqhHbxx
         Xjef6gflgHBeMfGxI+ZqH/fGiW2/JLFtbN3eH5AhqNtDtN3FWNE539F6uKXq1WX+QjId
         T420BEGt3MfUYC1T5Dyal3j6uqFetxosTOYAbTHyJpDZVWtW+pC9phgVaH/xNEcPhpYP
         Re+V3KI0CiQWZ6ZnvsA1LnNL82fpeTK8EN1dj+wfdiuX6S+Zh8GHua7/Yoe8FTZoEJgL
         ic23LAiArCbcF2OGAR61ZMazg864Uy46AWwsA6BhFi39En3yWkJyj7NLVY/NHU+cx62c
         rSYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793285019; x=1793889819;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z145znUTSRyPKtFzUaXDyFLwmD4HnEY3Xx0IIr8udHg=;
        b=R3B/hahJzN2HI3QCy7Hyhr3bT63J4XFFK9dUYAF2kTI3iWHBNFUGxbLyRIxOZBAZqP
         j0i3YQlKQUzpSULi5+hrx0L+nlkUbIQFI46Q4vsQuH+qs+RYkX3JY0oaiZcoZMWFeUV1
         OYiPotS/xvcFdH3NO3PIj88wG4v0ltic1AvYwuCFb9hZNSnyxkvxbgEohg6n0oVw9x5W
         VfBqnlYvmFAUAJrk+OYBNjyX5ALr3s90HSdXXB++5Iu1dS6Rj0Xo1u52cQab3rCpx3Az
         JNRhUipjpokstGKsT7ku58coBZlwkXxQFZlLeRG/JOVspw+fv5b07iqdXtjaH/vbfqbU
         ACTg==
X-Forwarded-Encrypted: i=1; AKwUvBxWRqkZauA78/oHuKGXVE7KbFzIDteqAoxPLp4wh/5v7heMEZO456G3LIr990AovFbZz34iRx8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKxpj8a0vld9i9VOKZQTM6e4xlUjKtJQtVtqHaRllzZZIoGOmJO
	qfoW6zz3JOj7EN8E46AY4/8clpJFAV4tGb1KE7giyabormbm2HLBQpsYKvvJ449MnDapuyhZ7tE
	GfZC4D/YGgGtHTRjudppgSSQOzsGSKw05jJlLknCNdQ==
X-Gm-Gg: AYBFou0Ko8YiF6NGHJ6+YQKH6smZnxJJSpYX1KIVuVr7HlsV3XAYiUmT50XrJl9FLjd
	U797dP8R83lVkFRcFW+u3qt4N6EglvLFJlA39/QjNrJZ3EBWQioR3tBqtvxtaRLVrqWhqEJzLmI
	ioWVJqDKxRLLrQEA74Ia6V0OkpPRyAB0y2e1G5i9Jfg9VpuP3BzhsqEsT4il6eGmRtPj7l6TwCY
	oRni+Ynh83FKODbgllF9etKHYv0PqSEhjpPWDk1GMHLoMo4F9dt2QmmIYw6AKegO8YXzcQULcsB
	+l3vE1huppRBjrNjM241vOH1QKh0L0Di7kb6WIMCkwsdQ6CkFbonWWbFlD89tb9VISWhrU4ngPd
	C73FXGMee27LLR/NfTeHwDV8VF4eaDYjhCQd3GmJmYbO1gH6yngSs4euTOuE+33ZPBYsrmnueyI
	LEmFae8WaTDJM0vgQ2lMB1lQOFbzv6cSsSvOwaH35+1q5yt3FqRE0kig==
X-Received: by 2002:a05:6808:16a8:b0:4c1:5614:acab with SMTP id
 5614622812f47-56382d81203mr3829523b6e.37.1793285018819; Thu, 29 Oct 2026
 07:43:38 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261014-ov9282-fixes-v2-0-3bb376d8b1a9@linux.dev> <20261014-ov9282-fixes-v2-3-3bb376d8b1a9@linux.dev>
In-Reply-To: <20261014-ov9282-fixes-v2-3-3bb376d8b1a9@linux.dev>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Thu, 29 Oct 2026 14:43:22 +0000
X-Gm-Features: AclHuK8HEINmU3r1FVIqsPNHE0UWIKCBJ0QrPdQvofVLfeWv7-01NAJbHLdiNlE
Message-ID: <CAPY8ntCP80YX7mkOVhjXhOSaZ_EFW-JKP=GBjrQYu1ciBQusew@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] media: i2c: ov9282: fix flash duration to/from
 microseconds conversion
To: Richard Leitner <richard.leitner@linux.dev>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Daniele Alessandrelli <daniele.alessandrelli@gmail.com>, 
	"Paul J. Murphy" <paul.j.murphy@intel.com>, Martina Krasteva <martinax.krasteva@intel.com>, 
	Hans Verkuil <hverkuil+cisco@kernel.org>, "Bryan O'Donoghue" <bod@kernel.org>, 
	Jacopo Mondi <jacopo@jmondi.org>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
	Gyula Kelemen <gyula.kelemen@advasolutions.com>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 14 Oct 2026 at 07:49, Richard Leitner <richard.leitner@linux.dev> w=
rote:
>
> Currently the flash duration is converted to/from microseconds using a
> fixed OV9282_STROBE_SPAN_FACTOR constant. This is inaccurate as it was
> found that the "step width of shift and span" (which is not documented
> further in the datasheet) scales with the line, so the span is counted
> in lines. This was verified by comparing the stobe pulses measured on
> the camera module against the calculated line times.
>
> As this is the same conversion as for the exposure: rename those function=
s
> to a more generic ov9282_us_to_lines/ov9282_lines_to_us and use them also
> for the flash/strobe duration.
>
> Fixes: b95d8058a2786 ("media: i2c: ov9282: implement try_ctrl for strobe_=
duration")
> Cc: stable@vger.kernel.org
> Signed-off-by: Richard Leitner <richard.leitner@linux.dev>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/media/i2c/ov9282.c | 65 +++++++++++++++++-----------------------=
------
>  1 file changed, 24 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/media/i2c/ov9282.c b/drivers/media/i2c/ov9282.c
> index 5907f57b34523..e2a1f875160b9 100644
> --- a/drivers/media/i2c/ov9282.c
> +++ b/drivers/media/i2c/ov9282.c
> @@ -136,8 +136,6 @@
>  #define OV9282_REG_MIN         0x00
>  #define OV9282_REG_MAX         0xfffff
>
> -#define OV9282_STROBE_SPAN_FACTOR      192
> -
>  static const char * const ov9282_supply_names[] =3D {
>         "avdd",         /* Analog power */
>         "dovdd",        /* Digital I/O power */
> @@ -491,18 +489,31 @@ static u32 ov9282_line_time_ns(struct ov9282 *ov928=
2)
>  }
>
>  /**
> - * ov9282_exposure_to_us() - Convert an exposure register value to micro=
seconds
> + * ov9282_lines_to_us() - Convert a number of lines to microseconds
>   * @ov9282: pointer to ov9282 device
> - * @exposure: exposure register value to convert
> + * @lines: line count to convert
>   *
> - * Return: microsecond representation of the given exposure register val=
ue.
> + * Return: microsecond representation of the given line count.
>   */
> -static u32 ov9282_exposure_to_us(struct ov9282 *ov9282, u32 exposure)
> +static u32 ov9282_lines_to_us(struct ov9282 *ov9282, u32 lines)
>  {
> -       return div_u64((u64)exposure * ov9282_line_time_ns(ov9282),
> +       return div_u64((u64)lines * ov9282_line_time_ns(ov9282),
>                        NSEC_PER_USEC);
>  }
>
> +/**
> + * ov9282_us_to_lines() - Convert =C2=B5s to line count
> + * @ov9282: pointer to ov9282 device
> + * @duration: microseconds value to convert
> + *
> + * Return: number of lines fitting into the given duration
> + */
> +static u32 ov9282_us_to_lines(struct ov9282 *ov9282, u32 duration)
> +{
> +       return DIV_ROUND_UP((u64)duration * NSEC_PER_USEC,
> +                           ov9282_line_time_ns(ov9282));
> +}
> +
>  /**
>   * ov9282_update_controls() - Update control ranges based on streaming m=
ode
>   * @ov9282: pointer to ov9282 device
> @@ -551,7 +562,7 @@ static int ov9282_update_controls(struct ov9282 *ov92=
82,
>   */
>  static int ov9282_update_exp_gain(struct ov9282 *ov9282, u32 exposure, u=
32 gain)
>  {
> -       u32 exposure_us =3D ov9282_exposure_to_us(ov9282, exposure);
> +       u32 exposure_us =3D ov9282_lines_to_us(ov9282, exposure);
>         int ret, ret_hold;
>
>         dev_dbg(ov9282->dev, "Set exp %u (~%u us), analog gain %u",
> @@ -579,34 +590,6 @@ static int ov9282_update_exp_gain(struct ov9282 *ov9=
282, u32 exposure, u32 gain)
>         return ret ? ret : ret_hold;
>  }
>
> -static u32 ov9282_us_to_flash_duration(struct ov9282 *ov9282, u32 value)
> -{
> -       /*
> -        * Calculate "strobe_frame_span" increments from a given value (=
=C2=B5s).
> -        * This is quite tricky as "The step width of shift and span is
> -        * programmable under system clock domain.", but it's not documen=
ted
> -        * how to program this step width (at least in the datasheet avai=
lable
> -        * to the author at time of writing).
> -        * The formula below is interpolated from different modes/framera=
tes
> -        * and should work quite well for most settings.
> -        */
> -       u32 frame_width =3D ov9282->cur_mode->width + ov9282->hblank_ctrl=
->val;
> -
> -       return value * OV9282_STROBE_SPAN_FACTOR / frame_width;
> -}
> -
> -static u32 ov9282_flash_duration_to_us(struct ov9282 *ov9282, u32 value)
> -{
> -       /*
> -        * Calculate back to microseconds from "strobe_frame_span" increm=
ents.
> -        * As the calculation in ov9282_us_to_flash_duration uses an inte=
ger
> -        * divison round up here.
> -        */
> -       u32 frame_width =3D ov9282->cur_mode->width + ov9282->hblank_ctrl=
->val;
> -
> -       return DIV_ROUND_UP(value * frame_width, OV9282_STROBE_SPAN_FACTO=
R);
> -}
> -
>  static int ov9282_set_ctrl(struct v4l2_ctrl *ctrl)
>  {
>         struct ov9282 *ov9282 =3D
> @@ -672,7 +655,7 @@ static int ov9282_set_ctrl(struct v4l2_ctrl *ctrl)
>                 break;
>         case V4L2_CID_FLASH_DURATION:
>                 ret =3D cci_write(ov9282->regmap, OV9282_REG_STROBE_FRAME=
_SPAN,
> -                               ov9282_us_to_flash_duration(ov9282, ctrl-=
>val), NULL);
> +                               ov9282_us_to_lines(ov9282, ctrl->val), NU=
LL);
>                 break;
>         default:
>                 dev_err(ov9282->dev, "Invalid control %d", ctrl->id);
> @@ -691,11 +674,11 @@ static int ov9282_try_ctrl(struct v4l2_ctrl *ctrl)
>
>         if (ctrl->id =3D=3D V4L2_CID_FLASH_DURATION) {
>                 u32 us =3D ctrl->val;
> -               u32 fd =3D ov9282_us_to_flash_duration(ov9282, us);
> +               u32 fd =3D ov9282_us_to_lines(ov9282, us);
>
>                 /* get nearest strobe_duration value */
> -               u32 us0 =3D ov9282_flash_duration_to_us(ov9282, fd);
> -               u32 us1 =3D ov9282_flash_duration_to_us(ov9282, fd + 1);
> +               u32 us0 =3D ov9282_lines_to_us(ov9282, fd);
> +               u32 us1 =3D ov9282_lines_to_us(ov9282, fd + 1);
>
>                 if (abs(us1 - us) < abs(us - us0))
>                         ctrl->val =3D us1;
> @@ -1277,7 +1260,7 @@ static int ov9282_init_controls(struct ov9282 *ov92=
82)
>         v4l2_ctrl_new_std(ctrl_hdlr, &ov9282_ctrl_ops,
>                           V4L2_CID_FLASH_STROBE_OE, 0, 1, 1, 0);
>
> -       exposure_us =3D ov9282_exposure_to_us(ov9282, OV9282_EXPOSURE_DEF=
AULT);
> +       exposure_us =3D ov9282_lines_to_us(ov9282, OV9282_EXPOSURE_DEFAUL=
T);
>         ov9282->flash_duration =3D
>                 v4l2_ctrl_new_std(ctrl_hdlr, &ov9282_ctrl_ops,
>                                   V4L2_CID_FLASH_DURATION, 0, exposure_us=
, 1,
>
> --
> 2.53.0
>
>
