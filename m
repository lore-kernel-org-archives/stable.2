Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793286167;
	b=pueZebAN7sfEgEe3sfjYa+6kJgpCVuKu57xw7wxBEizdPmhkSPMHDy+TxFMnzrMAJkTC
	 tfCg2ueGVhvu0KmXuWMaWKd3E/jI9g7d6SgBuwqeffoHcQOU+bXoC62WkKCMyF7k4Fqy4
	 qFWOvy2XuPuoLKSrGbjGD/9bkAsZxnJMalcT7Ab9+U+UzXNpOi1NsTbbI1qVTmSm0OEEw
	 4DYhsOtamrJY28UYdVkEeQE6SsG3/EyGfWgsC63OhQMaMC7JzDSqNOLZb6RYuyJFY6bs+
	 w2/EWT/40pUagsaYD+IEOx8iL3MgaHVQ12+KFmJKzTnaVItD8SGsfxteFdcQyLOV/SA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793286167;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=VBauCSbAO1bslF2MHSEVL1Kj61L1QueFoV/lHBHEYSQ=;
	b=TH1ToeZcmsHDeeNEx7vawd4f2e/LXpci9RAQhgCWfLj7G5x53284OPph+5DyfDsOYW1/
	 XoXHLiSA9oHUvKwUrNJ3NdWglvTKciLod6WaAXWtOUWtn/uus++UrBJ7Z9i5TPGVAM9SO
	 C9MKwzgYRz+6pDyC7baLgQr8XycjtJP4W6lD2pP6X7A8S7C4vOOEA2/5dnb0FcYSXn6Xx
	 DOhzbtLuOV5Cue3GiMRq4+AzE9U0SPHbc+MRCkXwr27gt6GFnhvmfpO446T2RpEpj09NL
	 KO3ES6QJJj7j3OckLm26+DmlHfQnztkN82eZsI9w+lMI33c5PQ0Gj6n2quPfVHCGJOQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=raspberrypi.com;
	spf=pass smtp.mailfrom=raspberrypi.com;
	dkim=pass header.d=raspberrypi.com header.i=@raspberrypi.com header.a=rsa-sha256 header.s=google header.b=kUptFaBE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.50
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DDD606A31A
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 15:02:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54DDD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=raspberrypi.com header.i=@raspberrypi.com header.a=rsa-sha256 header.s=google header.b=kUptFaBE
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-49de8ea072cso872184fac.3
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 08:02:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793286165; cv=none;
        d=google.com; s=arc-20260327;
        b=SOkCgq3vvLxe4YGLfyF70+r2cLAohrNmp/cnkkEqU+QKviKXoX+ggrx+THEtJhvQPD
         +jBIvOG2p1ZfYP2UnP7ab1wpvPT4cVqUaDsZLovw3Ax10QTTu2YOyFrPmeVF8rAfNaEa
         dBwVX3If+64SRgnuQQ5cM+NW8JQCcX2eYZ3SvUflrO30DKx6RY7Yav6i0nmPWLaf3MMO
         K7T/4PCOjo/FuTM1oMb2HepudspI4kzrl/DSGao6qAQdVY6sz13YC32xgG8Qp+xB/TII
         t0rfX0XXePwXHe1+7exhIQgy9QBEYB5hgJrdkpTND8ErdGbq3rsBnUP/z4pv1kXXDt7+
         3cgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=VBauCSbAO1bslF2MHSEVL1Kj61L1QueFoV/lHBHEYSQ=;
        fh=v7LU7pAh3BuTDFKjN8ZE/+O/V3h6+Fqo6aqeBACbPu0=;
        b=h4C8CUykGOB9jrEOEj5Z8NnOo9gkdqxgRd4uI98P17iDFrO+b0oJcV3n1RB1hrwROF
         URP9bpHzrxy/5eXQbddXQXLzN/TqJkqxfywogduFg+XZbQ2l1NQQO1HgqZ8LDvscv5y5
         fsU4rybIdmZi64w1nHw2Ose+y7K2vInEVYSXUbl6QkroURr3oXbw+QztK84gO2BVITHl
         N48CPZlGEaBrFZY3wBdI9fvsvzqrPkuQO+wLnlUI24j150tj2K6py7jygOi9jxKnxhX0
         YniMlEPwTGJiv/zHTXIqqzvvf8sk8QDeRwOI7jlds9W5ZNiCUmzN1oM4DLyEi6sty0dc
         vGTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1793286165; x=1793890965; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VBauCSbAO1bslF2MHSEVL1Kj61L1QueFoV/lHBHEYSQ=;
        b=kUptFaBExjtmignbdxt1LEDnztQBGVfbv/M45YWor7b4iidSbjXJeQadLYQ+Rs6f13
         UahaoMLT+piO8QQ+ypRM1Tr3MsYpi6glJ5p9YaSaFON4VaZRkpObl4vmnv7sns98U3rp
         XdolxfrwbkCywumJd+8B6mnNC5KkPOG4uNPhMCtxZF9yuFsQ0J32qEtj2PgmKqO9/Ydk
         osv5fWFDUjfHsooz1uYRX8gTTGCqePBInTcQk+peDAOWkvkjz8S2Xig+lZK0SNdFIEQs
         Zwdt9xNANFYfHMyYnK50RyMfvkGUj9bdJLJdu0KgD2KcY+D5SBI7hxUT6p2xUkZo0Y4S
         bo8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793286165; x=1793890965;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VBauCSbAO1bslF2MHSEVL1Kj61L1QueFoV/lHBHEYSQ=;
        b=yTt6DvkzZNUNOYzQRW8kuPmKN5ldlXS7Z0gew/q6kRjCVD4Rv1XJ7XTackca8qQvlW
         r2WDobjFjUEXJRf2SDNM6Jp3nf06BeOgvbtUG1lm978UvvkFTKX9dFMGAKAsnkQk0Hzt
         M4RTXxxx+iCJAvuN9+KQNE5qqlvAKHOnWEbRpSVkrWe79JMJsVZHRS1dhqLMhLUxERW/
         ZQoDWofx1mlWL4oMcl9f5STCBJGWnraWimIKD9+iN4XUr63pm6H36bKp8i8XF1TcJ7AW
         LLGCq18rhZPWGPn6GlEr5kJf0q6+7dmznokeuJc+BXqvsp6rVxB7l9uXmAvRYDtYNsXT
         2gBg==
X-Forwarded-Encrypted: i=1; AKwUvByR75iFKhOdA1Kn9IOuFNykt+JUj6pid/A0zlsCL22vQEZHImWr8LKwvTSHNQEW5nnDBi9DuEQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLyHdOm/hCb2e+hC6LdAAQkk39vqgCLHnhQRZld8kcW66sqp0fX
	qIQB+smde1UK+qoZzztrIOqfPucGhWDYEA5PHYi4UdV7R/Hf4lkWoIaWb9Iu+TPWJIFkZfXglFX
	D7CmocY5ELr6ahqC9otcPDhf8kdYKF/2DxUeruPcelw==
X-Gm-Gg: AYBFou1h4sYc46BbZf1USjU2uvvKCqiSikIyo2uSRD1Bqf2RV4g6I3ujtISEMtlUnuo
	ZcNejPQh6a2a57EQ3Z/wm3n180DNovMDNUTZz9tFvaJf7658wr3NcRaeJRZAFWgfMgz6lbaQdxb
	ZJDI303l7shYAAbtZKrAJJrjUXSYEp1C6atSVU8c6gy2C5Udb0MJjMFvzk3JPo/79AbfZey4eB5
	0Jt/TIzsJVc1xK+RGhvvH+mIT7cvIFLNPrIxsZYU+DDP+T+Hv3vMOrFk2xoPwiYe4Vu/5vFhC8G
	EE9VL5RfwjT2KjMIL0gOnayy1G2Zx2lrxpdHVekP5EvaK340x1/gnb2dbNmgibfA3n3nJku7E36
	OG3c//7mjWoUSA+drMDoncsGf1hF7zCUxeURnStRYoT3+8EYdUxMQ/4WMoPB7mSe/r3ZFcKghlM
	kA79q4KlneU28MjpFkABKwySgJhXWmXB2y0Pkn7xeo0YK2JiZGy94qApcry8TVoUrvGEOmULE1t
	F8=
X-Received: by 2002:a05:6871:2102:b0:486:a82a:a204 with SMTP id
 586e51a60fabf-4a8bb21dc71mr4339383fac.5.1793286164997; Thu, 29 Oct 2026
 08:02:44 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261014-ov9282-fixes-v2-0-3bb376d8b1a9@linux.dev> <20261014-ov9282-fixes-v2-5-3bb376d8b1a9@linux.dev>
In-Reply-To: <20261014-ov9282-fixes-v2-5-3bb376d8b1a9@linux.dev>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Thu, 29 Oct 2026 15:02:28 +0000
X-Gm-Features: AclHuK8voSOcP2Yc93--NhJD3VRIP_1eHNKLU2iJ4Kl10Q7R5Gjav4eSoB_tiWQ
Message-ID: <CAPY8ntDPj06a_fa+fJRUmn_8z2jxBXgFtf-PyHw7n34Qy9zeig@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] media: i2c: ov9282: add refresh of additional
 ranges on a mode change
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
> ov9282_update_controls() updates the pixel rate, hblank and vblank, but
> currently misses the exposure range and flash_duration, which are
> dependent on the frame height and therefore vblank.

This ends up being the opposite of my comment on v1 which claimed
"Both are dependent on the line time and therefore the pixel format."

exposure control range is dependent on height and vblank.
flash_duration control range is dependent on width and hblank.

Just omit the dependency comment.

With that:
Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> Refresh both, and commit cur_mode and code in ov9282_set_pad_format()
> before the call so the refresh and any nested s_ctrl see the incoming
> format.
>
> Fixes: 14ea315bbeb75 ("media: i2c: Add ov9282 camera sensor driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Richard Leitner <richard.leitner@linux.dev>
> ---
>  drivers/media/i2c/ov9282.c | 36 +++++++++++++++++++++++++++++++-----
>  1 file changed, 31 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/media/i2c/ov9282.c b/drivers/media/i2c/ov9282.c
> index e6920e18b7818..b48c959b9c908 100644
> --- a/drivers/media/i2c/ov9282.c
> +++ b/drivers/media/i2c/ov9282.c
> @@ -548,6 +548,7 @@ static int ov9282_update_controls(struct ov9282 *ov9282,
>  {
>         u32 hblank_min;
>         s64 pixel_rate;
> +       u32 lpfr;
>         int ret;
>
>         ret = __v4l2_ctrl_s_ctrl(ov9282->link_freq_ctrl, mode->link_freq_idx);
> @@ -568,8 +569,20 @@ static int ov9282_update_controls(struct ov9282 *ov9282,
>         if (ret)
>                 return ret;
>
> -       return __v4l2_ctrl_modify_range(ov9282->vblank_ctrl, mode->vblank_min,
> -                                       mode->vblank_max, 1, mode->vblank);
> +       ret = __v4l2_ctrl_modify_range(ov9282->vblank_ctrl, mode->vblank_min,
> +                                      mode->vblank_max, 1, mode->vblank);
> +       if (ret)
> +               return ret;
> +
> +       lpfr = ov9282->vblank_ctrl->val + mode->height;
> +       ret = __v4l2_ctrl_modify_range(ov9282->exp_ctrl, OV9282_EXPOSURE_MIN,
> +                                      lpfr - OV9282_EXPOSURE_OFFSET,
> +                                      OV9282_EXPOSURE_STEP,
> +                                      OV9282_EXPOSURE_DEFAULT);
> +       if (ret)
> +               return ret;
> +
> +       return ov9282_update_ctrl_flash_duration(ov9282);
>  }
>
>  /**
> @@ -832,10 +845,23 @@ static int ov9282_set_pad_format(struct v4l2_subdev *sd,
>                 framefmt = v4l2_subdev_state_get_format(sd_state, fmt->pad);
>                 *framefmt = fmt->format;
>         } else {
> +               const struct ov9282_mode *old_mode = ov9282->cur_mode;
> +               u32 old_code = ov9282->code;
> +
> +               /*
> +                * Commit before refreshing the ranges. ov9282_update_controls()
> +                * and the nested ov9282_set_ctrl() calls it triggers derive the
> +                * frame length and the line time from cur_mode and code, so
> +                * they have to describe the incoming format, not the outgoing
> +                * one.
> +                */
> +               ov9282->cur_mode = mode;
> +               ov9282->code = code;
> +
>                 ret = ov9282_update_controls(ov9282, mode, fmt);
> -               if (!ret) {
> -                       ov9282->cur_mode = mode;
> -                       ov9282->code = code;
> +               if (ret) {
> +                       ov9282->cur_mode = old_mode;
> +                       ov9282->code = old_code;
>                 }
>         }
>
>
> --
> 2.53.0
>
>
