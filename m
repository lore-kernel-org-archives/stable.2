Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793285690;
	b=kPWIop8bQ9eBuTHCsZDqhJbGeOfNjB91mXC2DLSbmnjkx1xKDHItxTbfsR0rlz6Mq72V
	 KgtIvZr/ZKmDrM9EUAQLRecmdFy61TaiHjJRxg8ZUslNtyLT09ZGsVL13+65L1n7V78PO
	 uwGibEwIBIThu2FWfK9WLz3jhBDmtTx4OOwXOVNr+oycRJ5iGVmXLDZxieF2ENOkdaRe8
	 GK4KylQ6x38Hi1MkGoUpOT1JUAC0NiZ7mTrgbEnyIQS1o+bt4wgtxG2hCF7zj4hb414qE
	 henIrd5yytriwJxBZbjEkwcS3QqKmFWv4ksFKswBp0WIswEPXJNiN2+bww8f2KICuAQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793285690;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=jZf3jjTodnM7qc1wo9plUNoH8ssRvL1DxBE038OooOQ=;
	b=cQVlixm3iI2oHNW+kwhQBZdUpnbQaibWL/J5r91m2jmpMXwAHUss6oMT/FlZpG/L0fKQ
	 /OLF7nW+gVd8MLfbtQKz+noKz7XbKhwVhM9aGXvKD0tPHKs80GJHxjtVZGGxORwzvXC96
	 KRaTc84NzNr5uP35e3XZhtyDwj+670a8/ky/T5cTeo7/hw1XYM+oNk70rcIMAgSpp7oqI
	 VFWJD+fqummM69CbzDjbANjE88bB5myZ7Wl1BZVg+q4P5JE7vtsqUQrzv0dayH7TGkjO4
	 +LoBx2N0VWhEnGd/e5Do/j5xPvvcfV9GOdmltoyOjdDVh35KLiFaHO2p75cTEqakJnA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=raspberrypi.com;
	spf=pass smtp.mailfrom=raspberrypi.com;
	dkim=pass header.d=raspberrypi.com header.i=@raspberrypi.com header.a=rsa-sha256 header.s=google header.b="Rlq737/y";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.45
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C59C606A31A
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 14:54:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C59C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=raspberrypi.com header.i=@raspberrypi.com header.a=rsa-sha256 header.s=google header.b=Rlq737/y
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-48ed0b68895so1275025fac.1
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 07:54:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793285688; cv=none;
        d=google.com; s=arc-20260327;
        b=hK6A1m7iY1nAO7Hi1w2UFywlbDbWxpBCJx/aRjGLFNd4g9yo2IonC7Hd0f/XD5SKZa
         gTkJ7bsGObV3m/2/7DcMhWsopg4w3Ap/7X2wjBKW+0LaEV0i+qUljR+JHOPTW5YUkeuN
         Te6HjoDD3kJ3s7jTFw30MVNvHN+qQaMWyBTTE/YAeshgQRw3zvKQB9idSr3arH40cEss
         NXWpR/MOHaP9PzNhlYxcbl9MA8QscdXBmcsGR5kUU+JKYllX/KB1k0cOdvZX77acwiF2
         dHBfJCXGMWmMcAAm6BIt7YpFaFl98oGAFqnFJDUagtbdGMWg06HXr0r0G4gYGF7m8u7J
         9tvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jZf3jjTodnM7qc1wo9plUNoH8ssRvL1DxBE038OooOQ=;
        fh=SJp9hWn3XUpZc7Cu9G1wI/auLAFuYWRAXXN0qJX7DOM=;
        b=GTi8jlCJ7Dr/E5wfNbJLLDnqBoAo+hXwOB9x73r8vyDvsrVyA5paTjDG+jT+F1ASlY
         5CFL1ZJ1B8Wwdgv2FwABEF1T4tyyxBefFA5GxK9sREU5YL1FLWxuEcPkHkCG/sDUG2+5
         EWoK+Br8CyemLpD88Km+S1BtcvwBUA14SbD98Ts3Hd11O0qP+xXfLj8SsO4reKfxHalM
         Yk9SIHJ+zf2mLiSjjgyOg6fF5nRnfatEZN95Vvzs+mrZ1CvSLIXWcYWaAZgIGtmTXfxp
         tw5sS7BJYg35q9Zz3W2VZk9V1URMpTgSFB074e6uV56j9ogyJ1eR8pOcZWeoQoT8Ehp/
         xWFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1793285688; x=1793890488; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jZf3jjTodnM7qc1wo9plUNoH8ssRvL1DxBE038OooOQ=;
        b=Rlq737/yw9y59C+5F9yht1LHNkLvTUU8EY9Zv4CqfWn8wkp+QpjKh1HxZwqlMBYdcG
         oZoJE304EjTAOTyhFCE66H6FE1ocYOxvW6c3bhkpbfg7yREaQVYPxA5IGfD0/NgNPzt+
         yjj9TB9S10m1ZBC8O+1hXmmGX9+gUCp9Z/xK0/OKxtkJ080+y9RAsBkSV07rvQANnrFg
         u2FmEnEjzgHLg59clH8eEzy0q5nqYpkkxTMgHSr0gM9uI/8ug+sMt7puTq1cWJNmkleD
         X/F9UyYNOZBkcUVa88DNEFcIEEknHraT1inWTX1+Yul+mgYNWdpjen+rGq3MOCdmW6ma
         H43g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793285688; x=1793890488;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jZf3jjTodnM7qc1wo9plUNoH8ssRvL1DxBE038OooOQ=;
        b=A2jsffGLqGiEdu8CoZ5pgxsksEcMA2pvGJrkdB1JoX+JEezEEB+uQyJ5ObPHfR3cnx
         0OiDkh2XwxSiDA/hhaUOUJb15J8psHkSbvOixNxY/UJRAR9a3wJdAFYa5HaYiU+2G0gF
         lekaNuuliv21MHdkdHWTPoODa8jOTyW+XqiDLO/Z15BAbFZXAg9SqoU13w1g4B6u7SJY
         oBo2QfO16XuKukf1vTQmQzxGJJciMbXZUka1buxcZOCe9ueMNl09z+ovjgAY7KiAYbub
         HkM+nDMht57rlJtV6+NvTG+CiNtZ2TV1BBcOPuN0JW3CMQKejYLVLycBZw3/9W1xGAh0
         uVKw==
X-Forwarded-Encrypted: i=1; AKwUvBw5n6aD5+c4dnPv1QClFcoebigj/y642/Y6cbMEPay4ntbiGKEAdyzkrKo1BaeqgExFdzbLjt8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJuXewerEuaLIodHF+cfdmUKZ4EgQLZZHQsWVwHKMC3BVdLcCNJ
	nqP7YnrWmxXtUWEdA7LMm1IHYyp6ukGWBah/8wMz336CQz2qoMEvJyJm8f6SZ+8MDCJlX5+6Esv
	xr/o8PCTvFSKVzqcueb33ZKVkpQmhJx6X4yqFmE1HnQ==
X-Gm-Gg: AYBFou1vIIT6x/nkF1O+X/QuSVOY3zqXuLrqxxy2VMmIpl5ljCGHSQhUPUl6u++XQW3
	ekXb/2s0DFxtBCxO1TJtbo7aMfk8dlisqg6mzZjBi0FjhqDAs6Yk5Y1JeDF2Wt8JjW+i8XeSu/U
	QXOSNn5H7jsC/NlhPhWhwODv3Frzp2lwACZgNVY6juexDTcD7Nmte+V8IrQTusctnhGMd5FCLj2
	9jGeTl3hgAKpYPuq6XuLIUhLN/thmIc43b7YxNCHzw2rSPUHVq1gONNEeGsw0bhdsgwFc+4VZgV
	VTTcnHIGEPzcMym38U6I7MGHdhMosDy8GaIapKFVkOsy23veMa+6WMEMSoPU8kf4HKwi0bly9jX
	HwuMBf+0UU9kjZl9lj/1QOWJv2sNtg9H/ydlxlStew4MgkXhGKePap2l/gj9VGbdWu9c+doBe4Z
	CYZiZqHOUCduGZnCNRX0Pogr+jeEgS12GX2GjtggdszFRLnplvO+p+Gw==
X-Received: by 2002:a05:6870:8a09:b0:47c:4f69:3f1f with SMTP id
 586e51a60fabf-4a8bb4595e8mr4158986fac.14.1793285688482; Thu, 29 Oct 2026
 07:54:48 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261014-ov9282-fixes-v2-0-3bb376d8b1a9@linux.dev> <20261014-ov9282-fixes-v2-4-3bb376d8b1a9@linux.dev>
In-Reply-To: <20261014-ov9282-fixes-v2-4-3bb376d8b1a9@linux.dev>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Thu, 29 Oct 2026 14:54:32 +0000
X-Gm-Features: AclHuK9PiAlyIOE9H6TgjFTZyWCGr5hpHVaWb1aHCZKckP8QEuz-8cMUmUpjv44
Message-ID: <CAPY8ntDNa8xuVRS6on=WoVghzJj_An3EydpEb=RwNDE1tmO9Kg@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] media: i2c: ov9282: fix flash duration range calculation
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

On Wed, 14 Oct 2026 at 07:49, Richard Leitner <richard.leitner@linux.dev> wrote:
>
> The flash_duration range calculation was broken. The maximum was
> calculated from the current exposure time. This limited the hardware
> without a strong reason. The minimum was fixed to 0, although the
> hardware treats register values 0 and 1 equally for the strobe_duration.
> The default value was never calculated from the raw register value to
> actual microseconds.
>
> Furthermore the flash_duration range update sat inside
> ov9282_update_exp_gain(), which ov9282_set_ctrl() only reaches after
> the pm_runtime_get_if_in_use() early return.

only reaches if pm_runtime_get_if_in_use() doesn't return early.

>  So with the sensor idle
> the range kept whatever value it had when it last streamed.
>
> Fix those issues by correctly calculating the values on line time changes
> (i.e. HBLANK updates) as this is the "time base" for the register value.
>
> The maximum is chosen to be S32_MAX microseconds. This was done to keep
> the code short and avoid additional back-and-forth conversions. As the
> hardware allows strobe durations from 1 up to U32_MAX line times, S32_MAX
> microseconds is always in this range. Line times for the supported
> modes, hblank values and pixel rates may vary between ~7.5 and ~205
> microseconds.
>
> Fixes: b95d8058a2786 ("media: i2c: ov9282: implement try_ctrl for strobe_duration")
> Fixes: df60764ea5210 ("media: i2c: ov9282: dynamic flash_duration maximum")
> Cc: stable@vger.kernel.org
> Signed-off-by: Richard Leitner <richard.leitner@linux.dev>
> ---
>  drivers/media/i2c/ov9282.c | 41 +++++++++++++++++++++++++++++++----------
>  1 file changed, 31 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/media/i2c/ov9282.c b/drivers/media/i2c/ov9282.c
> index e2a1f875160b9..e6920e18b7818 100644
> --- a/drivers/media/i2c/ov9282.c
> +++ b/drivers/media/i2c/ov9282.c
> @@ -514,6 +514,26 @@ static u32 ov9282_us_to_lines(struct ov9282 *ov9282, u32 duration)
>                             ov9282_line_time_ns(ov9282));
>  }
>
> +/**
> + * ov9282_update_ctrl_flash_duration() - Update flash_duration control range
> + * @ov9282: pointer to ov9282 device
> + *
> + * As the actual microseconds value of the flash_duration range (default,
> + * minimum, maximum) are dependent on the line time recalculate and apply them
> + * to the v4l2 property in this function.
> + *
> + * Return: 0 if successful, error code otherwise.
> + */
> +static int ov9282_update_ctrl_flash_duration(struct ov9282 *ov9282)
> +{
> +       u32 fd_min_us = ov9282_lines_to_us(ov9282, 1);
> +       u32 fd_def_us = ov9282_lines_to_us(ov9282,
> +                                          OV9282_STROBE_FRAME_SPAN_DEFAULT);
> +
> +       return __v4l2_ctrl_modify_range(ov9282->flash_duration, fd_min_us,
> +                                       S32_MAX, 1, fd_def_us);
> +}
> +
>  /**
>   * ov9282_update_controls() - Update control ranges based on streaming mode
>   * @ov9282: pointer to ov9282 device
> @@ -577,12 +597,6 @@ static int ov9282_update_exp_gain(struct ov9282 *ov9282, u32 exposure, u32 gain)
>                 goto error_release_group_hold;
>
>         ret = cci_write(ov9282->regmap, OV9282_REG_AGAIN, gain, NULL);
> -       if (ret)
> -               goto error_release_group_hold;
> -
> -       ret = __v4l2_ctrl_modify_range(ov9282->flash_duration,
> -                                      0, exposure_us, 1,
> -                                      OV9282_STROBE_FRAME_SPAN_DEFAULT);
>
>  error_release_group_hold:
>         ret_hold = cci_write(ov9282->regmap, OV9282_REG_HOLD, 0, NULL);
> @@ -616,6 +630,11 @@ static int ov9282_set_ctrl(struct v4l2_ctrl *ctrl)
>                 if (ret)
>                         return ret;
>                 break;
> +       case V4L2_CID_HBLANK:
> +               ret = ov9282_update_ctrl_flash_duration(ov9282);
> +               if (ret)
> +                       return ret;
> +               break;
>         }
>
>         /* Set controls only if sensor is in power on state */
> @@ -1190,8 +1209,9 @@ static int ov9282_init_controls(struct ov9282 *ov9282)
>         const struct ov9282_mode *mode = ov9282->cur_mode;
>         struct v4l2_fwnode_device_properties props;
>         u32 hblank_min;
> -       u32 exposure_us;
>         u32 lpfr;
> +       u32 fd_min;
> +       u32 fd_def;
>         int ret;
>
>         ret = v4l2_ctrl_handler_init(ctrl_hdlr, 12);
> @@ -1260,11 +1280,12 @@ static int ov9282_init_controls(struct ov9282 *ov9282)
>         v4l2_ctrl_new_std(ctrl_hdlr, &ov9282_ctrl_ops,
>                           V4L2_CID_FLASH_STROBE_OE, 0, 1, 1, 0);
>
> -       exposure_us = ov9282_lines_to_us(ov9282, OV9282_EXPOSURE_DEFAULT);
> +       fd_min = ov9282_lines_to_us(ov9282, 1);
> +       fd_def = ov9282_lines_to_us(ov9282, OV9282_STROBE_FRAME_SPAN_DEFAULT);
>         ov9282->flash_duration =
>                 v4l2_ctrl_new_std(ctrl_hdlr, &ov9282_ctrl_ops,
> -                                 V4L2_CID_FLASH_DURATION, 0, exposure_us, 1,
> -                                 OV9282_STROBE_FRAME_SPAN_DEFAULT);
> +                                 V4L2_CID_FLASH_DURATION, fd_min, S32_MAX, 1,
> +                                 fd_def);

Observation that this changes the default from
OV9282_STROBE_FRAME_SPAN_DEFAULT to ov9282_lines_to_us(ov9282,
OV9282_STROBE_FRAME_SPAN_DEFAULT);. I won't quibble over that though
as any sane user will be setting their desired duration.

Ideally with the commit text fixed:
Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

>
>         ret = v4l2_fwnode_device_parse(ov9282->dev, &props);
>         if (!ret) {
>
> --
> 2.53.0
>
>
