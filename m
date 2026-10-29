Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793284850;
	b=ryyo7/Gd0jy1Qaxz3je1lWdpBANgatwix9p/8VuVSRFrr59ptdpznzXy9dWka5DQy3IZ
	 +3mIgkDTgmqn7w+TgZ821U7c4DOTMXIrk+Stl/vS+liNhfQKE3GTngpNUGIGkyYgG0RC1
	 jB56dusgwhs5wOHpGAHvritIy/aEV1cri1AAjkzqc9lQ2AFxxl0fKSEyp5V3RFwFF2mEp
	 OIKQLIcP+wolgFJi1GYBWNTcM2kL+t6drPLEqG1OmZr3WutI1HkBwh2K4qmWnV5XflbtG
	 X1bQ0FU2ZzRQ7d0/fay+On2FZopP8pdPL/QtR6rWS8386AX246Vgi264Cm2kWhoXqdA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793284850;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=UpLR92yvazEzYcMkjgQMdu/DL7UIZCfUmYSsebhADbI=;
	b=G0hR8TwoHmao9Mx8jdmQ6E4DkFasW9szwivdWbBtz9xAkEW56J9G27eiKCkpapQktTm1
	 4Pos427TnzyBbNFEydhAZRROJV+nVtE7ogMtodiPUYT3PyvBxqDMC0Y0htLQEjs2dvkmM
	 KZqEzORCsJ93whvA4933gEXKLV/Vf3ZqCCEk1MDyImTSR4QqrwxT7H7wFfDtl6t5uj7RV
	 uB7LsbbSIrkjZQ1LYp4TMwE5pflFGm6dxDVT8kDxspaWRboJSEOkEDXBUCZoGLeUGalgo
	 +7OCpMf4f2KAMXSPLLQqlcf4gwrgMIWMD5j05oiCFMZ/9iS36mCFjzmcUArFpVniZtw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=raspberrypi.com;
	spf=pass smtp.mailfrom=raspberrypi.com;
	dkim=pass header.d=raspberrypi.com header.i=@raspberrypi.com header.a=rsa-sha256 header.s=google header.b="Xb/1Iab+";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.47
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49469606A31D
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 14:40:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49469606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=raspberrypi.com header.i=@raspberrypi.com header.a=rsa-sha256 header.s=google header.b=Xb/1Iab+
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-483c607ccb4so1208657fac.0
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 07:40:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793284843; cv=none;
        d=google.com; s=arc-20260327;
        b=SAiY50DkkigCFMYLfakcxQccMegVOW2/nQ+o7E53TlRkcL7r/XrLpIxMA76tJBpUVZ
         fypSb9jsceflVyQdz123f+UVlh4nU36zK//4jA3cYjgc/hrOd1gHvAu5xt1JAZGf/9b6
         bn9AS9tUG4z09mG8UFXz3W95D+eD8nnZbzveHa3xIiLWhFUk1JND31kU46+3JhNvKthE
         Rb2wRr82pzb3HvwfB0Z/mVgOC+TuzMoU4CVV8fWz+ILJljxuVGIbGjpGTcuteukzlDKt
         /E1n6U3ipAbDwAOqqhR8/gkYL+ew2pO/5vk4WVB04+SXuDVnn7hky/JIAFDmhZfXE+HW
         bLQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UpLR92yvazEzYcMkjgQMdu/DL7UIZCfUmYSsebhADbI=;
        fh=XnQboBIQgNOXIOtCku2sdwZreOozNK7rrR9X4WB0c0E=;
        b=QVs9U6m8SXZPm00ghH9D04Lu5IA4dA+PfNrEQ0J141b1upk7TJIgz6mD1Ta89z0EIS
         wCfhIKmAWL0qViiRlEdf3DPfpMi6rdNgJ/cjQw6l8MuzEKILrUG9cRqAHPfzWPa7vvc9
         YIZIymZ0w7wmwlY4XNAtYgv6jMbZI3xTKjzXIX4YHjTOD9Bw5UCPmuSwcnZ8osfh020W
         FKYX5fvGIsHZKDkZrb7rdfggIPyQEDnnDxf4asF9JRAVqERq3iQibR+XAp+zvUnBrBi4
         m0ePQllm7EkJa9E+bvTPu2J9H1QqsKLg8iYoNuEq50lnKo6cegXhi6E/bLr8O3JIPKKc
         k89g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1793284843; x=1793889643; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UpLR92yvazEzYcMkjgQMdu/DL7UIZCfUmYSsebhADbI=;
        b=Xb/1Iab+QgqcujhXdJyn6dLqo8XyrBoDPSjoAB0wuGBJ/YQNDYb8yzKZrbJaDUkzP1
         kg49UF4YKogpBfbzxaKgDYeSkhMxcaLWNfNSnD3SU2PnUuEjhHHvt3PzUKyMb9dHmfTQ
         ktQBOMnFeutICvOi6pY2MY3RIwvyW5i0TjbbqNQtRM3uHxnx3pGglwVg5kkOFvUrEd5H
         w7E+nq/sMVn+AqJ+J5wIEi8wEkJtLNa9Dys9Goflj6y8AC30dOnm1UtoXSxVwsmrs9Fa
         o7LSPlCveVaLcbgfv3a9B7zGkBaIdRvz5xj4mNqiHjCBJzAjV5j3UV/pfqDJoTA6v3qn
         HFgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793284843; x=1793889643;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UpLR92yvazEzYcMkjgQMdu/DL7UIZCfUmYSsebhADbI=;
        b=0Kn7GBi6V4S+WcdZ6AFPoBGFUcy1UPA6EszltKgw2JDb2bYKfRkzxAx27DcuK0pSyn
         d/R2l/pajLWuotYOBwO3qcFJ1o7SsrIU57iDL1/JHTyHw5QgJJVVAbjPfZrKzDgqNmbZ
         g1xFqU9R+iJWErD8fhSXZ425SxPAAIBhYMWleyiujN0rdjyIZHrKlMA7hrwIS4/ayjHK
         +8Tt2r79UDI4p47WR0lj7+ho3tacD5WLXIKbKILtv94OoQpQx1CiATZh0t+zsJ6+SBn2
         spF5plzgsKJDlZzlsLcbVMqo1a4UAOpAm30W+s/gbQDYeGSEYwLGvg0Us2g+JVdxYaBB
         U4PQ==
X-Forwarded-Encrypted: i=1; AKwUvBwtvtk7h/KWfpEK/6znaEDHrps37PVKOMxE7b1McOiZ4tnw/emxP0T4J0tN6csIcbrPHYrp0ts=@vger.kernel.org
X-Gm-Message-State: AFq9FYI/lHxMzVKmm59D4U1BU9Sl4yAH2ldI3KFASDRqKDp90vXAgfRg
	6CBz7FOkQvkUutl6wW567s0kwQ7x9xmubMTwHXW+c9VRx3R7NDcgHRfrr1M5YQNRxDcZQsSoIlO
	cyQ8559J/m4ysTGbtUJY8LZ+xBRzjV5mgxpj9KKrTFw==
X-Gm-Gg: AYBFou3u2xjxQ2uf8MQn0dMKQnVst2U8jyoLsvkOCNcEvqxvlE4v/1+Q0+1gvNhYW3Q
	NXVMhtodyMW/fDcKq3ej7EP3F5tA5SKEBeEqO93XZqulmxw9ZZJa1+T9w0KUV0tognu4GrzKFu6
	jqsQYp36RXhFh0LPMisXR2BIBX5Qk0GNilyixEBKJ2/SYaKSrqSFKyvtHgs/NkDa5uMpl1WppZe
	qlzHxUs4mFLpZxOOV0xaHwnLtw/ja58iCw6LK8aGiFixsjr6YqdZuinLDuwm084580ON8QhuIQG
	fNHP7r9Wd6V2MoUoHffDfGMjfeL3WfK+jAMfZTgbeB77qNVItH61j9KiCHr8YJQnu1QHb533mt4
	IeDKNaYh8tskqHCgR5Mju5itWQdJmXF68U4Kj0hNBbydbIqOyCHvt6uP44c2mYeblxXmcFxSdVL
	eLkb1PS3C0KwXV8K0ZxjkSLSppE3EGdYAhwOU+fqqAWiie5t34E9g0qNTW4BH9kZD3ytWJjWVrd
	GE=
X-Received: by 2002:a05:6870:1408:b0:4a8:5c86:20bd with SMTP id
 586e51a60fabf-4a8bb5a3fe0mr4334153fac.14.1793284843148; Thu, 29 Oct 2026
 07:40:43 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261014-ov9282-fixes-v2-0-3bb376d8b1a9@linux.dev> <20261014-ov9282-fixes-v2-2-3bb376d8b1a9@linux.dev>
In-Reply-To: <20261014-ov9282-fixes-v2-2-3bb376d8b1a9@linux.dev>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Thu, 29 Oct 2026 14:40:26 +0000
X-Gm-Features: AclHuK9aWEHtDyHMrF09cYcyP1s_VnFKtV14syxMLcpu9Ygt6KIgxBSI2jLY9YI
Message-ID: <CAPY8ntCKPLt9zfBRemqG=nuwUBB2gcO7bO_4Zk6TfwB0nzP=tQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] media: i2c: ov9282: fix pixel rate and line time calculation
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
> The OV9282_PIXEL_RATE_8BIT is calculated incorrectly from the
> OV9282_LINK_FREQ. The hardware scales the pixel rate by changing the
> multiplier from 0x50 (for 10 bit) to 0x60 (for 8 bit). Resulting in a
> x1.2 factor.
>
> The current OV9282_PIXEL_RATE_8BIT calculation scales from /10
> (for 10 bit) to /8 (for 8 bit). This results in a x1.25 factor.
>
> As all the inputs to the pixel rate calculation are constant in this
> driver also define the OV9282_PIXEL_RATE_{8,10}BIT as constants.
> Additionally introduce a new function to calculate the current
> line time in nanoseconds and use it in ov9282_exposure_to_us().
>
> Kudos to Dave Stevenson for pointing me into the right direction!
>
> Link: https://lore.kernel.org/linux-media/CAPY8ntBaSHjztuSLTOtv9KYvEbmcbi=
nSMJ78ZDg+0sZg-1fz3Q@mail.gmail.com/
> Fixes: df60764ea5210 ("media: i2c: ov9282: dynamic flash_duration maximum=
")
> Fixes: 43ac0cac18f41 ("media: i2c: ov9282: Add support for 8bit readout")
> Cc: stable@vger.kernel.org
> Signed-off-by: Richard Leitner <richard.leitner@linux.dev>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/media/i2c/ov9282.c | 50 +++++++++++++++++++++++++++++++++-------=
------
>  1 file changed, 36 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/media/i2c/ov9282.c b/drivers/media/i2c/ov9282.c
> index c10b2e205834e..5907f57b34523 100644
> --- a/drivers/media/i2c/ov9282.c
> +++ b/drivers/media/i2c/ov9282.c
> @@ -10,10 +10,12 @@
>  #include <linux/delay.h>
>  #include <linux/i2c.h>
>  #include <linux/math.h>
> +#include <linux/math64.h>
>  #include <linux/module.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/time64.h>
>
>  #include <media/v4l2-cci.h>
>  #include <media/v4l2-ctrls.h>
> @@ -111,11 +113,14 @@
>  #define OV9282_LINK_FREQ       400000000
>  #define OV9282_NUM_DATA_LANES  2
>
> -/* Pixel rate */
> -#define OV9282_PIXEL_RATE_10BIT                (OV9282_LINK_FREQ * 2 * \
> -                                        OV9282_NUM_DATA_LANES / 10)
> -#define OV9282_PIXEL_RATE_8BIT         (OV9282_LINK_FREQ * 2 * \
> -                                        OV9282_NUM_DATA_LANES / 8)
> +/*
> + * Pixel rate: Derived from the PLL2 clock tree.
> + * For 10 bit it's exactly the same as the sample PLL configuration.
> + * For 8 bit the PLL2 multiplier (REG_PLL_CTRL_0D) is changed 0x50 -> 0x=
60,
> + * which results in x1.2 and therefore 160 MHz x 1.2 =3D 192 MHz.
> + */
> +#define OV9282_PIXEL_RATE_10BIT        160000000
> +#define OV9282_PIXEL_RATE_8BIT 192000000
>
>  /*
>   * OV9282 native and active pixel array size.
> @@ -472,6 +477,32 @@ static inline struct ov9282 *to_ov9282(struct v4l2_s=
ubdev *subdev)
>         return container_of(subdev, struct ov9282, sd);
>  }
>
> +/**
> + * ov9282_line_time_ns() - Calculate duration of one sensor line.
> + * @ov9282: pointer to ov9282 device
> + *
> + * Return: line time in nanoseconds.
> + */
> +static u32 ov9282_line_time_ns(struct ov9282 *ov9282)
> +{
> +       u64 hts =3D ov9282->cur_mode->width + ov9282->hblank_ctrl->val;
> +
> +       return div_u64(hts * NSEC_PER_SEC, *ov9282->pixel_rate->p_cur.p_s=
64);
> +}
> +
> +/**
> + * ov9282_exposure_to_us() - Convert an exposure register value to micro=
seconds
> + * @ov9282: pointer to ov9282 device
> + * @exposure: exposure register value to convert
> + *
> + * Return: microsecond representation of the given exposure register val=
ue.
> + */
> +static u32 ov9282_exposure_to_us(struct ov9282 *ov9282, u32 exposure)
> +{
> +       return div_u64((u64)exposure * ov9282_line_time_ns(ov9282),
> +                      NSEC_PER_USEC);
> +}
> +
>  /**
>   * ov9282_update_controls() - Update control ranges based on streaming m=
ode
>   * @ov9282: pointer to ov9282 device
> @@ -510,15 +541,6 @@ static int ov9282_update_controls(struct ov9282 *ov9=
282,
>                                         mode->vblank_max, 1, mode->vblank=
);
>  }
>
> -static u32 ov9282_exposure_to_us(struct ov9282 *ov9282, u32 exposure)
> -{
> -       /* calculate exposure time in =C2=B5s */
> -       u32 frame_width =3D ov9282->cur_mode->width + ov9282->hblank_ctrl=
->val;
> -       u32 trow_us =3D frame_width / (ov9282->pixel_rate->val / 1000000U=
L);
> -
> -       return exposure * trow_us;
> -}
> -
>  /**
>   * ov9282_update_exp_gain() - Set updated exposure and gain
>   * @ov9282: pointer to ov9282 device
>
> --
> 2.53.0
>
>
