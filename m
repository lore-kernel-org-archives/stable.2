Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793032006;
	b=PI5NE7ovyxc7/anbOvNdUbFv23QFkEY5ai0RVonE340ujNy3ihNT5LctjxuVGmCbbgUK
	 uMWIsGJXUxc2Rr2Qfk2yRhByqa56/zVnlqQ6Qv0y1Lh6+t1LwsOzM67zOKS8ML1njP59U
	 NBGBXYeHMz/s6dJVKK0aCRW0PPazDS5ZrAZ8Ytr+O8QyL5AH7cqJT7ygqwX+WoxjEhPs3
	 a0QxCfSl5ZsuAIPQOtTx9e4BBeS1vMtwANrmPSiypzH+NAGetSSCbwoz1/78SAZy5Azdz
	 tshDVrAAgkbbuVbPzoCUcQt5YzVjn6g9lLGooXLxu0zBZTMo6odEe7bUA1AFnS0cCew==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793032006;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=lW187BX7pvnv89/fgKm/N1OWRtkvU+9tvFLWWwcKajk=;
	b=vwbSwp+Ry/gIkVvBlhybaIAjjJx4S+KMZDPYX/whoH/YRY7TJgxJDNFwgxHrjhcYZ7Si
	 v2gmNA1/LZqBs7KTGqx6l7A28PT0P2ewtHC0Du+dAaqFclvnHYzr5J/T/SwOs3YaZLT77
	 oEoxs1V6X5eLIlL6c4xlUkonmx5L/1QwIRsDdWlOL+XJkC4i/3vqS1OZlw8ZWAOKv1RRm
	 EZ8BXe2XT6QCgiv2a9bOW6UQSMwj3NxxSIiiPI/MFos/rWPGRSHwPbGLWTCSK1k5mEBIe
	 3KOM3O6NE/5S3SgyPnumi499h6RCh2OkdGYVE2LQxs9pwX45Df6eSClDfRpu4guRW1w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MUOvYbUG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A3A606A31D
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 16:26:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80A3A606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MUOvYbUG
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b1dae0febeso4543956a12.2
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 09:26:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793032004; cv=none;
        d=google.com; s=arc-20260327;
        b=SrhX8ruZPrtwtZ/f1tVjThskDpukv69QNnZO24DFWvzl0LPnc5jDnqAjnLvMzzVr4k
         Zsq9kYCmd9amrEGPZq0jq0jfLsDmyAcOPo3TDq9UTZJiLtAzcwGz64vtZvJKbkuzbFJK
         FoHxu3gaVcIhrqBJVYBbHVItaTF5qKKVlyVwbaQOchFSNDwWjCUGfp7pUYe4sKzGZZKC
         Y4PdusH7rFTXtGH/sbkiVQ7RDGK/NbagtAfzAjpvN+Lh/oE9rJXQmCVZjNSmrMhvB1Di
         UI/+jsR0tgVzyV9/e8qxECXHElzG6WizcFjsK9KudemnWaSAegs+B8EE6GkLTsvtBZIK
         zJ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lW187BX7pvnv89/fgKm/N1OWRtkvU+9tvFLWWwcKajk=;
        fh=8JBz7JS6L4QmVQphvruQswMQNHpQImmllvY+BjIW86g=;
        b=oVDkhAvYR0NuCPvPVZIEmrtNtowoOyroicsAqKOisrKZoDtrVHcHQdcTV+lOu4MMj8
         ixgSeY6lHJoBgKXlo3TPlYMc12nZeOPWWZApR0ov3g2pS5sU9pafqpkGq/uZO0+bCS6N
         E/3nVjwLSIvX5FRCFJLWWW/E0M7hrXWSu5zfX8BRjq2XpxIXs9iZDEo3XBSfc0R2gT9S
         hQfO3vnm6wuKv8GYmajupP0w0CN2QsSz81BvzFGjMK+s27UYu+FYdt6rr1CPW8tF6emY
         vHkVUTOULLj4fmVobn5L/F0+Fqz8EAaidYyUScpDdKdFVrlWqgxqNYJRSVEleMw8ijrB
         +77Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793032004; x=1793636804; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lW187BX7pvnv89/fgKm/N1OWRtkvU+9tvFLWWwcKajk=;
        b=MUOvYbUGJvLRY+4ozSTJAEYhkO+CViDCgDR/3HRZ2ZWklhcxdU68sVei8SZjibc+9J
         J/ZNuFm8p9TkB2fxCuz3OVOlpf2qJp2bkWOYL6xSqXJ86bQpdYp+2R+NuOF3onvlTqMA
         Je20QgRQFsAlFNpoRVlKQx/997AKY43XUf9v7WKQD5FKqoZM//oU3SRUwQG2FwMcct48
         FPWtM84uU9h6uUcStZ5/AMLizASUvfEq+/F9MQT9uXBPbHezFapVQJANiRTyQ1zgykLO
         +TstMVO6d3IdV6JbtXoZLedXzaQgSP4HKjde5q+zJ2c8iK3D6Wtb0C/VG7RPtmcKiKA+
         ejWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793032004; x=1793636804;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lW187BX7pvnv89/fgKm/N1OWRtkvU+9tvFLWWwcKajk=;
        b=GJzaN/tXAsUSWmcn9qjQd9JxU2MEOEHjnWZl2Vf9Xz+A1+uBA4kdZH38QY9dArbBgX
         ryXSYwoY1YctI5l5/y5/yD7p7+gmvtaTL3Py300bxCXpoZNsQ5g6/Fjin8Ok6UhN0yco
         pb4/A8OgAWVrLkaqIDeY0FbqOeQlOr3vJt9dvpqFAG0yAqHl/ZpjRgQcln6ZLOi81uy0
         kcL3dCPEwPEQubRyx11WWqCEcER4tEaMrWF/3aBz6wou21JfmgZISSz/jT0Yh/gLk7za
         sHd9Vo8MGEfy8iOqCm2MYMf4lBJnago1P3EGQ3RNjmg4V7u3owxcScR7extEv4DqpVdq
         YC6A==
X-Forwarded-Encrypted: i=1; AKwUvBxYZP7cptcp399DpzTE6md0WNm18w0jGustgxWri6ozr4jRLYss2VILfuwiE4ge6G5AvEmPmFM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLfbDnmbE7IZ2zYSYumiyodZpR/OSJq5RwRS0tnYWhiof+PtrGc
	3lBjAeYvzl/69im+Kp/zc9K8KGY2TYvjCk4z1dW1UhxZPBPnFkMTHBMnGbOukRhweX9AB/DJYnD
	fo4U5NWNGdQJy7tYgo25EQg2X66+FfKk=
X-Gm-Gg: AYBFou2myEUPVxriNmiVVG4wPPTucjEq8Oydqe8on6SZcTDqlSNXSXPJv7A2wz/D7UC
	IHHdQGzKYvuWTMgr+rx6LXhMp08Yw1aqGF1dMIUY8SSOEIrN/905zXRCYeyjAEAcAvvy/l1UOBy
	PV0bHyLiD8o+jKrr5MbeBLak+5eakKOI1hnWkL87VuVXx214ikjKOruufvWFeyaGnwZ+vGEQB/L
	MnPMTKkTOCwGZtSNxM9TOUkpELbupD13IpuniAVXeV5zZLLaWaAZjhKjiCbxUo/ZjcnxvGyOw3l
	PQxVejLQ2QWOAV9K6xB10zUnkOi5jmt2Oqo4DaMLBFe17w2ZD5qa2YmstQb3mf7VoJUG/fqf5Ux
	QfChuQlZJOqUPVS7SU0+LMWAVKn0Ic6RQSmAjd9h0LADrwvIwrsFSGChMZwRQ40BS3psC5g==
X-Received: by 2002:a17:907:961a:b0:c44:14d:d95d with SMTP id
 a640c23a62f3a-c46bde35b78mr860710466b.23.1793032003455; Mon, 26 Oct 2026
 09:26:43 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026154604.579823-2-bestswngs@gmail.com> <2f8371e4-ea8c-45d4-8a42-e1a616915b61@gmx.de>
In-Reply-To: <2f8371e4-ea8c-45d4-8a42-e1a616915b61@gmx.de>
From: Weiming Shi <bestswngs@gmail.com>
Date: Mon, 26 Oct 2026 09:26:07 -0700
X-Gm-Features: AclHuK8xJMkjzycsM_PGDEWxDNP3nAsGNewoI6y1CFU9ObUj4hzqU8eQ9FVmawY
Message-ID: <CANgPUi1WDS4aK9+7LO+O4D1JDvGd3isWVWps_W-ocD_fT39HAQ@mail.gmail.com>
Subject: Re: [PATCH v2] fbdev: vfb: Validate framebuffer geometry and memory size
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, co+b0df61d49532b2ee@bugs.sh, 
	Xiang Mei <xmei5@asu.edu>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Helge Deller <deller@gmx.de> =E4=BA=8E2026=E5=B9=B410=E6=9C=8826=E6=97=A5=
=E5=91=A8=E4=B8=80 09:06=E5=86=99=E9=81=93=EF=BC=9A
>
> On 10/26/26 16:46, Weiming Shi wrote:
> > FBIOPUT_VSCREENINFO can supply a virtual width large enough to
> > overflow get_line_length()'s int multiplication and bypass the
> > video-memory limit, allowing fbcon to write past the framebuffer. The
> > offset additions can also wrap, while an excessive videomemorysize
> > module parameter can be truncated when PAGE_ALIGN() is assigned to
> > unsigned int.
> >
> > Limit virtual geometry and offsets to 8192 x 8192 and cap video
> > memory at 512 MiB, keeping the stride, framebuffer-size, and generic
> > fbdev drawing calculations within their destination types.
> >
> > KASAN reports:
> >
> >    BUG: KASAN: vmalloc-out-of-bounds in sys_fillrect
> >      drivers/video/fbdev/core/sysfillrect.c:24
> >    Write of size 8 at addr ffa0000001671000 by task poc/198
> >    sys_fillrect
> >      drivers/video/fbdev/core/sysfillrect.c:24
> >    bit_clear_margins
> >      drivers/video/fbdev/core/bitblit.c:247
> >    fbcon_clear_margins.constprop.0
> >      drivers/video/fbdev/core/fbcon.c:1410
> >    fbcon_switch
> >      drivers/video/fbdev/core/fbcon.c:2261
> >    redraw_screen
> >      drivers/tty/vt/vt.c:994
> >    fbcon_modechanged
> >      drivers/video/fbdev/core/fbcon.c:2693
> >    fbcon_update_vcs
> >      drivers/video/fbdev/core/fbcon.c:2732
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Reported-by: <co+b0df61d49532b2ee@bugs.sh>
> > Suggested-by: Helge Deller <deller@gmx.de>
> > Assisted-by: LLM
> > Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> > ---
> > Changes in v2:
> > - Limit virtual geometry and offsets to 8192 x 8192. This retains 8K mo=
de
> >    support while bounding all generic fbdev drawing calculations.
> > - Cap videomemorysize at 512 MiB.
> > - Keep the existing arithmetic types now that all inputs are bounded.
> >
> >   drivers/video/fbdev/vfb.c | 17 ++++++++++++++++-
> >   1 file changed, 16 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/video/fbdev/vfb.c b/drivers/video/fbdev/vfb.c
> > index de137b2bd..de40ba8c3 100644
> > --- a/drivers/video/fbdev/vfb.c
> > +++ b/drivers/video/fbdev/vfb.c
> > @@ -31,6 +31,9 @@
> >        */
> >
> >   #define VIDEOMEMSIZE        (1*1024*1024)   /* 1 MB */
> > +#define MAX_VIDEOMEMSIZE     (512 * 1024 * 1024)
> > +#define MAX_XRES             8192
> > +#define MAX_YRES             8192
> >
> >   static void *videomemory;
> >   static u_long videomemorysize =3D VIDEOMEMSIZE;
> > @@ -159,6 +162,14 @@ static int vfb_check_var(struct fb_var_screeninfo =
*var,
> >       else
> >               return -EINVAL;
> >
> > +     if (var->xres_virtual > MAX_XRES ||
> > +         var->yres_virtual > MAX_YRES)
> > +             return -EINVAL;
> > +
> > +     if (var->xoffset > MAX_XRES - var->xres ||
> > +         var->yoffset > MAX_YRES - var->yres)
> > +             return -EINVAL;
>
> Instead of returning EINVAL, I wonder if we could simply
> cap the resolutions at MAX_XRES/MAX_YRES?
>
>
> > +
> >       if (var->xres_virtual < var->xoffset + var->xres)
> >               var->xres_virtual =3D var->xoffset + var->xres;
> >       if (var->yres_virtual < var->yoffset + var->yres)
> > @@ -434,9 +445,13 @@ static int __init vfb_setup(char *options)
> >   static int vfb_probe(struct platform_device *dev)
> >   {
> >       struct fb_info *info;
> > -     unsigned int size =3D PAGE_ALIGN(videomemorysize);
> > +     unsigned int size;
> >       int retval =3D -ENOMEM;
> >
>
> and here maybe
>         videomemorysize =3D min(videomemorysize, MAX_VIDEOMEMSIZE);
>
> that way the driver loads even if the provided too big value?
>
> Helge
> > +     if (videomemorysize > MAX_VIDEOMEMSIZE)
> > +             return -EINVAL;
> > +     size =3D PAGE_ALIGN(videomemorysize);
>
>

Yes, that makes sense. I'll cap the geometry and videomemorysize as
suggested and send a v3.
