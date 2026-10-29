Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793286627;
	b=qBlgvgT3TJxvXaBGSSMhwkmu5eH1irnoQPqoO8gm+k4zIrbJC6zMiVLw0V/mv4qWLkJh
	 W90YE8r4V0ohXy30cOvVUap4aJXzCEksk+bzSjJdT4SnUpSCUna1V31Trrc9imiOuqA71
	 vKClHWGBTMDvDyoCF2ndZP6FmWyYD8vwCvTA/77TXhL6xeUsNxsVroWxq47YL1bJ3x2Ld
	 QtS2mt60JmZcVqmTlq8Z1t3x+jPiS1jpD+LIP1nviPoRGS32+BAHQMn32giHyxI/2PpU/
	 rWfUQ2eWZPGadS1DULtfwnpkEcXOqKLX2O9/IGipYsbN7Nls1gdGuznoAaufnpIwJ3A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793286627;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=2b3vVP1vEHIm/JW4JfzuulbZR3cusd4/fTQxKoNUz94=;
	b=Y62PGWcnuKGpPiUq9ByV93HWR4ZKwT+O2a5uAwzcfs2+nTsdsEPpy9WbBax2eRuksUv3
	 geNdn8MOwnUVDOur6ZIdsIzQGJPdvadnQyW3NZegQGmQOmr8nIU213e56y2VXppu1R/Z9
	 O/6lUIk1QwCdp4rSRcoq4BQt1PGyzXXI1kaJ+EAXyt2MSkeRG1S6EJPcT8039+YGkceuV
	 wfSXWNACqZ+TKXBfyGUIJ46iaf0pMxv0rO6yKYHjpaKt415TjMXVSpwM4nBVplEuT93ww
	 vGQIUxkmoGaVqfZ4dede4CouGy1NC/DkYQor92tr9TltKikhGJPc9HyCAtJHjWtEs9Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=raspberrypi.com;
	spf=pass smtp.mailfrom=raspberrypi.com;
	dkim=pass header.d=raspberrypi.com header.i=@raspberrypi.com header.a=rsa-sha256 header.s=google header.b=t0HEKi3J;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.54
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7F7606A31C
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 15:10:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D7F7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=raspberrypi.com header.i=@raspberrypi.com header.a=rsa-sha256 header.s=google header.b=t0HEKi3J
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-4a755bbe158so541623fac.0
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 08:10:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793286625; cv=none;
        d=google.com; s=arc-20260327;
        b=Ej2a6YEKVYIPvjdVwn6TXRUs1GxBzmnFY2ZSIuz5T/Fx7zAj1cCwHTYr7LAnRoFE6D
         v/0Bt6Cgf7/0HseeH8CmkAnJeBYhStQZPAxz+qL9h8uA1gpDuOg8dvliqxiyZHTENuTD
         1/zsaJrfMlPaDAyCkd8rtRsnMVmVmVrUhCDioZ952kZYnoFy0Aw5lnIDlIiXl5kmkSGI
         O0AQijjBgjJE7oD0akHZ2JBd86dwoXlwD+Kv85p4unRNJrjrzIKuL5ZC3t8kd5bWlsKq
         8AKBlpPuB80Zr7fpDWMQRjxs40NvqkEujkP3GBYet75AL9GeUvB+4pdNOB6NLgMA1p3m
         B8Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=2b3vVP1vEHIm/JW4JfzuulbZR3cusd4/fTQxKoNUz94=;
        fh=MxKuxcjp5zxcHuaL8mxsFc5x4QOAZ8rI0s1skq+Cpp8=;
        b=VJ0SCJ4ulzIGB9YKTstB3OpQfVjjLr0KZXxprIXYXEn7oTeoDShvWyMEc1oZbXIJwy
         nBbFv778WhpBs7ekNwl/pEeWight/G6lnT9nxEz+aA6fma20jzYZNZe0nePn2WFxHGW8
         fBQb6lk88x1i1/AuQ4zvkpge/c2qIJNKnexJ2hpVrSH/+xB1u+V5sSN35+1OZaR2451Z
         Qe9WLjY90ro0mRfCoJTZ/5Sb3XLomWJ1buiP+FaLyX5hgiuku0jwg4woI6jO8aFbDDN4
         IXRZB22nAq9G7hY2BwbUODiQQrzNY/oadGSSoGOZH2jWDSJnKda9JuZSicd+F42yrs57
         pqHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1793286625; x=1793891425; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2b3vVP1vEHIm/JW4JfzuulbZR3cusd4/fTQxKoNUz94=;
        b=t0HEKi3JEuYusOJQ2BlME+lteEzd9dpBkx0PYrvDTF6m0Gk0Q+n2i1EUE9nTUzuobE
         jgmDRB3BuFqDIcfk3pKSMf2ZVBNUYhnBJi4AQOlRU1v3BE8YfrL4dMUtUtwXzB/LkkKh
         W7hTXlaauGp2j3cYctzuHfnaObEhfhmydvxsoNvTEELOKG/xAuPZi8zu3cSrRxrthG9T
         avMlZ8RsvJk4iVIODKrTJFIFU/7bXBHJevI9/zHVtmfcpFhc6TuQMMeYsurZ/VZCOEbo
         gau2V+U2q/NGCK5o+dlwIHFTFBtIjsuOXnSt/D3Csq8dhKQoq2F4U0glozDN4haqHNSm
         PwoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793286625; x=1793891425;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2b3vVP1vEHIm/JW4JfzuulbZR3cusd4/fTQxKoNUz94=;
        b=rTPZ/gegWH4ybeQExEMOTnwOVvY6hn1P+sTRarkwxjqF31rRkgUsaguYx1+Yk/Gbnl
         L0DduPrkahg0ZlMRwINcYVfb01NtKGiNlzUyzEsP/jQAYcIv0uggIujuQ8svjdSgsbc+
         alzQOBni3JvU4LLh8wLW5ueyMB4jxPxecA1IfoN8qKTGB3lk9tu+mjVIQrLyjDhWq2x8
         +yH1qiOh+c0O+I2r6NElAqHPYXqxpfbsjtfxCDKieJVe3z6cfp0EMkPLwgOOAQfPK3xj
         cQnW05r00t37AvnhrcyG0jRdiar4bMR6bm+7hRFoHKnRhN9FleY6oIhLXteuP6uOufaE
         sDVw==
X-Forwarded-Encrypted: i=1; AKwUvByaTXZqKiGK0Npt1Cb8dbefnfpMcYeLgsrPthEIURzKeZj5xqNfcCSQ4aiHNz8OnFcTiVa+STM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJdCVSFm7ZVIxzStPj88qSUjIDx2syr2NtSCeAn0eLbEDP3Szla
	ajNFsTe1Ml+IvEfNdEW9Yfasz5Zsv5AzLsSXv1XqzvqbktWbg9Wt8GmB7f3gZReKeKOfLcqsVNn
	olIAM1EQSy5FHglmlGkCaRcqS6ekxFVj4uMMKMWYnOw==
X-Gm-Gg: AYBFou36mFXf3R0Gv653i8CsovVjKbf4uaVwfQ5dizlgfInnOV3mr9+QtM9zMchAJfH
	ZXd/0Uk1v1G7PvN4sle64p/AXka1EWWE554HkdA/D18Wv+pPuZfadA2nWwFDI7nqhGeh5N03kA6
	ntbhXuI/OBUKCrXh4tsIRAzy5DEw5NAnH5O+Ib7he71YScouZ1xyRAtzgpYI3aTzuBA5LWQpQbD
	eJUfZp5jvi6EwFyiim3odbRszPD11TGpdipjOFUmyvmHMn+69NdlZRcJeB8ybiCa6iup/iVGpVp
	Aw2+R8kmlADlITGvTm5VvH+e541B0//lcZo9P7C5jbkkYCleQ1UVetwq10QjNDWc5xmdKFspG8c
	A4zcqB2wINBnS6WvDtBXYhO8yREAwAqvmNdSdLJR/rQtgWlyO6uheVu/pxXigyjQnWBnjlx2/hr
	79TDkvQsMqClGlQq8BJzkV78y8TpQEUOa8gLbdrA2m0zl4+waxGIb7kA==
X-Received: by 2002:a05:6871:2102:b0:49e:33ff:6bda with SMTP id
 586e51a60fabf-4a8e06a7791mr1577014fac.16.1793286625298; Thu, 29 Oct 2026
 08:10:25 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261014-ov9282-fixes-v2-0-3bb376d8b1a9@linux.dev> <20261014-ov9282-fixes-v2-6-3bb376d8b1a9@linux.dev>
In-Reply-To: <20261014-ov9282-fixes-v2-6-3bb376d8b1a9@linux.dev>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Thu, 29 Oct 2026 15:10:09 +0000
X-Gm-Features: AclHuK-NCoRP1AFBwcEcpT9lZOpueGQS9GFk1YygW8gcMAFUBjXyhMvfoBBBJz0
Message-ID: <CAPY8ntC1G0Q=MFGkLNSC+bCq-iJh+estq1FeDgE7aV4UksyuyQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] media: i2c: ov9282: recalculate strobe span on
 HBLANK change
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
> When HBLANK changes the line time changes. This means the time base for
> the strobe duration calculation changed. This results in the v4l2
> strobe_duration control value and the strobe_span register value being
> out of sync.
>
> Fix this by recalculating the strobe_span register value on HBLANK
> writes using the currently configured strobe_duration. This results in
> the strobe_duration configured by userspace being kept, but the
> underlying register value being changed. To ensure the values are
> applied on the same frame guard the writes with OV9282_REG_HOLD.

Group hold will do what is intended, but if control updates from
userspace for eg gain and exposure generally get too widely spread
then, we've got much bigger problems.

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> Fixes: 84ec7597ae1af ("media: i2c: ov9282: add strobe_duration v4l2 control")
> Cc: stable@vger.kernel.org
> Signed-off-by: Richard Leitner <richard.leitner@linux.dev>
> ---
>  drivers/media/i2c/ov9282.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/media/i2c/ov9282.c b/drivers/media/i2c/ov9282.c
> index b48c959b9c908..5114fbf28a26c 100644
> --- a/drivers/media/i2c/ov9282.c
> +++ b/drivers/media/i2c/ov9282.c
> @@ -625,6 +625,7 @@ static int ov9282_set_ctrl(struct v4l2_ctrl *ctrl)
>         u32 exposure;
>         u32 lpfr;
>         int ret;
> +       int ret_hold;
>
>         switch (ctrl->id) {
>         case V4L2_CID_VBLANK:
> @@ -677,8 +678,14 @@ static int ov9282_set_ctrl(struct v4l2_ctrl *ctrl)
>                                       OV9282_FLIP_BIT, ctrl->val ? OV9282_FLIP_BIT : 0, NULL);
>                 break;
>         case V4L2_CID_HBLANK:
> -               ret = cci_write(ov9282->regmap, OV9282_REG_TIMING_HTS,
> -                               (ctrl->val + ov9282->cur_mode->width) >> 1, NULL);
> +               ret = cci_write(ov9282->regmap, OV9282_REG_HOLD, 0x01, NULL);
> +               cci_write(ov9282->regmap, OV9282_REG_TIMING_HTS,
> +                         (ctrl->val + ov9282->cur_mode->width) >> 1, &ret);
> +               cci_write(ov9282->regmap, OV9282_REG_STROBE_FRAME_SPAN,
> +                         ov9282_us_to_lines(ov9282, ov9282->flash_duration->cur.val),
> +                         &ret);
> +               ret_hold = cci_write(ov9282->regmap, OV9282_REG_HOLD, 0, NULL);
> +               ret = ret ? ret : ret_hold;
>                 break;
>         case V4L2_CID_FLASH_STROBE_OE:
>                 ret = cci_update_bits(ov9282->regmap, OV9282_REG_OUTPUT_ENABLE6,
>
> --
> 2.53.0
>
>
