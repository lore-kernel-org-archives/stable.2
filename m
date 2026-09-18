Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA34E377AA0
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 04:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789704993; cv=pass; b=nMGXSD02VtxSmn+ogQOTeK01R3OAJDnYtp6MScmhIGtERM7rrXWCPIkp0glweM30PpuNb+0MlcAc5GACvZAZEas1y9A/GKrXAiceHz622ycCStxJzt8u63cAT77pX4nRvJM5A3Mcu/g9tfW+BxUD/Or+NF0AUafc/EbkdYMLcCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789704993; c=relaxed/simple;
	bh=Ru2OV2CffCL9NpSNIMTei8TR1QcXxODWTos4dcRwWHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T4hdMD7jTCv73cl40xqTuZl7nebu+/CiXh82jRT2SemV6rx86pWSswfi0tcGEiJkBz+oJncW33Hhhbfq3NCsGt2Hw4jdq2Z0FUqoMkdmQorbW6facB4vv4TOIN+I+DLKxaHsS1XK2McfUmRj5HdxhuKtuEpn8xaX4wZk7w3NoIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=M5jSN6CV; arc=pass smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M5jSN6CV"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66e4ab201ebso284579d50.3
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 21:16:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789704989; cv=none;
        d=google.com; s=arc-20260327;
        b=ImrC9PdH6LeY512jQW41j+hb+2VqYANP8wLULgE/dGCMhIvnorqUkH6hPG1Ivm2Duu
         8rWJPHddQgnQjCH0SbMlHs0TGvTFyeZlTBZJ2JoEUjEbQ6M3pdu2XZJw8xrDiDsC4LXT
         LtZIynVmg4o0kkL5XH7UgNq6wnG3+NZpigVWB6VAUUZvpwwzda3WZaDO27ZdTBzMIZzD
         ZmFXox/Pkcpb2XGbmUBtOHC6vSnBrXGwmvYil8jBnNs/jWOwPlpGR3qqSXWHCFMrxyDR
         Bl5qs03f4UXVFLkI+aYR7WvVIdt4Q+IDAmuQKfYhkgk9r4LtyPr2urB0U8/roGs+PH77
         MiRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g5DKEYyvWEAWVKejXJm1cVbz3X+KIz29ykH7P6jopns=;
        fh=J9R73Wb6Z20dcDa9dfSMwQbYsWtTuV+rXehq3ydZMwQ=;
        b=hCzS1XdzG7Ym817LwwSh0nNndCuE6UECZMVzGB+AbAXnfBmqJguhkb/5UxgQVHh/Wr
         JLEZZ+SFT++b7dH1ueQrd4rp5Xg+7w+NNV8d0qBDTISh/CuZULqalLHN1GfXjB7iCd5W
         FAzBQQSwD/XaLH78uVSpYPh+qp+En6giKHUMJ9ObDXLGGjIDkEQvRQyAZEUE+ElD46lQ
         CpvskOvjWnHFVvPnOiwXPGCPzwAzEG+TOZDc/NdihEK5Kimo5AJEMSUeKynwqM9bOFA1
         sAp4Z/voo2qz1hqBHEkOKAE16SSL/TiSp29+6EMYRg0YkqXBMotGAwHjQv9BVVvnytgF
         1/cw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1789704989; x=1790309789; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=g5DKEYyvWEAWVKejXJm1cVbz3X+KIz29ykH7P6jopns=;
        b=M5jSN6CVQwtcaWLE5zehzEUl3mQl7m/M7NbwZ+Ne9nQLUPG+OjhBEdOOrgDPUEc95J
         Q2Y9hm9AH08NwIm6pgnN3RTbSEYDmnUdeVDuxmMTAGZP6HkevuIFeXihB/PAd2/HiTtO
         VM9wYA80eOkSLKEDrjcvTAzaB8S1OOOzB3Y9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789704989; x=1790309789;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g5DKEYyvWEAWVKejXJm1cVbz3X+KIz29ykH7P6jopns=;
        b=wKPcQERU0RU+MkXVjsCYJ+HdjOPa1TW4MOMAnLWh918vkYxL6L6lGPiDijnCqO52CW
         uokSPqVHxOy7uuyjHd1eEbHZI4oqA3PlJI/LFcunfXQEi07Kv0p5n6o8J8M0AgsYGKHn
         PjR+5HcofecRLefrBXdRGvac+pOhOC1V11JjOnQc4o1DdeQ4VCRK02J591/TB3sdT54a
         1gbq/FVqZpmdUGGbepsrhpVSlEfmW39BCPUjxKPH4bebaPocwReRLSufwBG9PgtG6gDW
         5HJGV+gWg+uObaeoS5BshKCcqBi9CJXxJV4qLPgpqxgxfy3QXoJIh4J2wAT43Y8XISKM
         YSMw==
X-Forwarded-Encrypted: i=1; AKwUvBywBZbhbT7xv3mWqBgdKaDTYVk89h5deye9l1uqJs9Lb/lZOtGE9ThmAtneVLBus7FVzPFs46A=@vger.kernel.org
X-Gm-Message-State: AFuF++nAyaXIQ/1ZLXtM/B3zZnU9MCIT2OHXS3AjQT/semRZciTIJRBS
	tpmzccRFOWoaaBEEvw27kpzAocup2LXzjulEHgBN4amtDg3j7Ykzbi3iHS8w+vcBWgjeVj23va/
	L3WrXeYIzu4c2VVYOvau9MRM8RW9ABBnZt7ki7MAu
X-Gm-Gg: AYBFou0oqLkyxpAMknKTZH0VKEmdc6cWM+lmHPQm5C4GPPoUGsNjyq9cxkDGTahpCXo
	jZVne55NPE8D6sCWvex55To6Mqtde17yAqFCfaE1I9q55Nql8T0hqnZG6VeEqjpkCq4u/9lWeeZ
	ac80+3dl5dJ1ljzSD0ynCemQH3HWFeNZR3YQXaTHx5Hv99Ej2u0/Hw+y5lbnjZ4OeIiUSFdQpaq
	PDPZULhGJmoMJq519CQBHoduotGbxRVhGZWJ+JOoZViI4p9fslSdVhuKPEHMAvfLxEb18fXzbkB
	o29qeaF67MYt9Q7TbGAol6xSVGy5iDwqkui8pMKwdB0siBZiIFM9oU2o2Nd7BQIlsqQiE6yrZQZ
	gbeNxGVvR1Q==
X-Received: by 2002:a05:690e:809:10b0:671:3141:3832 with SMTP id
 956f58d0204a3-6717fc76ff0mr285169d50.4.1789704988719; Thu, 17 Sep 2026
 21:16:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916033327.3054126-1-wenst@chromium.org> <20260916033327.3054126-2-wenst@chromium.org>
 <f6ace486-70d8-4e81-89cb-e9d55ad9ac8b@suse.de>
In-Reply-To: <f6ace486-70d8-4e81-89cb-e9d55ad9ac8b@suse.de>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 18 Sep 2026 12:16:17 +0800
X-Gm-Features: AcwNN1UR3eVFLoBD9oF0TIdnuDNIVRYA94Woweb8vmhnl_ZgpInsWYdL86x54Xk
Message-ID: <CAGXv+5ErgWVNtnRiW+QA7+Mzh=W_Y+HGL_iRa1fOaXCYSoAwMA@mail.gmail.com>
Subject: Re: [PATCH RFT v2 1/5] drm: Split framebuffer pixel offset
 calculation from drm_fb_dma_get_gem_addr()
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Liu Ying <victor.liu@nxp.com>, Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, 
	Lucas Stach <l.stach@pengutronix.de>, Chen-Yu Tsai <wens@kernel.org>, 
	Jernej Skrabec <jernej@kernel.org>, Samuel Holland <samuel@sholland.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, linux-sunxi@lists.linux.dev, 
	imx@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 11:20=E2=80=AFPM Thomas Zimmermann <tzimmermann@sus=
e.de> wrote:
>
> Hi
>
> Am 16.09.26 um 05:33 schrieb Chen-Yu Tsai:
> > Currently drm_fb_dma_get_gem_addr() calculates the offset into the
> > framebuffer memory for the framebuffer's unclipped source coordinates,
> > adds that to the framebuffer's backing storage, and returns the result.
> >
> > We are about to add a variant that uses the clipped source coordinates,
> > so there is already some reuse of code. However, calculating the data
> > offset for a given pixel is not specific to the DMA FB helpers. The
> > offset is only related to the framebuffer.
> >
> > Split out the offset calculation into a new framebuffer helper so that
> > non-DMA users can also reuse the same code.
> >
> > Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
> > Cc: <stable@vger.kernel.org> # dependency for next patch
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> > Changes since v1:
> > - New patch
> > ---
> >   drivers/gpu/drm/drm_fb_dma_helper.c | 28 ++----------------
> >   drivers/gpu/drm/drm_framebuffer.c   | 45 ++++++++++++++++++++++++++++=
+
> >   include/drm/drm_framebuffer.h       |  3 ++
> >   3 files changed, 51 insertions(+), 25 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_fb_dma_helper.c b/drivers/gpu/drm/drm_=
fb_dma_helper.c
> > index fd71969d2fb1..ab0f37d8a5ff 100644
> > --- a/drivers/gpu/drm/drm_fb_dma_helper.c
> > +++ b/drivers/gpu/drm/drm_fb_dma_helper.c
> > @@ -75,36 +75,14 @@ dma_addr_t drm_fb_dma_get_gem_addr(struct drm_frame=
buffer *fb,
> >                                  unsigned int plane)
> >   {
> >       struct drm_gem_dma_object *obj;
> > -     dma_addr_t dma_addr;
> > -     u8 h_div =3D 1, v_div =3D 1;
> > -     u32 block_w =3D drm_format_info_block_width(fb->format, plane);
> > -     u32 block_h =3D drm_format_info_block_height(fb->format, plane);
> > -     u32 block_size =3D fb->format->char_per_block[plane];
> > -     u32 sample_x;
> > -     u32 sample_y;
> > -     u32 block_start_y;
> > -     u32 num_hblocks;
> >
> >       obj =3D drm_fb_dma_get_gem_obj(fb, plane);
> >       if (!obj)
> >               return 0;
> >
> > -     dma_addr =3D obj->dma_addr + fb->offsets[plane];
> > -
> > -     if (plane > 0) {
> > -             h_div =3D fb->format->hsub;
> > -             v_div =3D fb->format->vsub;
> > -     }
> > -
> > -     sample_x =3D (state->src_x >> 16) / h_div;
> > -     sample_y =3D (state->src_y >> 16) / v_div;
> > -     block_start_y =3D (sample_y / block_h) * block_h;
> > -     num_hblocks =3D sample_x / block_w;
> > -
> > -     dma_addr +=3D fb->pitches[plane] * block_start_y;
> > -     dma_addr +=3D block_size * num_hblocks;
> > -
> > -     return dma_addr;
> > +     return obj->dma_addr + drm_framebuffer_get_block_offset(fb, plane=
,
> > +                                                             state->sr=
c_x >> 16,
> > +                                                             state->sr=
c_y >> 16);
> >   }
> >   EXPORT_SYMBOL_GPL(drm_fb_dma_get_gem_addr);
> >
> > diff --git a/drivers/gpu/drm/drm_framebuffer.c b/drivers/gpu/drm/drm_fr=
amebuffer.c
> > index d32aceb6ca9b..9e1231162047 100644
> > --- a/drivers/gpu/drm/drm_framebuffer.c
> > +++ b/drivers/gpu/drm/drm_framebuffer.c
> > @@ -1208,6 +1208,51 @@ void drm_framebuffer_print_info(struct drm_print=
er *p, unsigned int indent,
> >       }
> >   }
> >
> > +/**
> > + * drm_framebuffer_get_block_offset() - Get offset to start of pixel b=
lock for
> > + * the given framebuffer and coordinates.
> > + * @fb: The framebuffer
> > + * @plane: Which plane
> > + * @x: x coordinate for pixel
> > + * @y: y coordinate for pixel
> > + *
> > + * This function will usually be called from the PLANE callback functi=
ons,
> > + * or from one of the helpers that calculates the framebuffer's DMA ad=
dress.
> > + *
> > + * Return: offset from start of framebuffer to start of pixel block
> > + */
> > +u32 drm_framebuffer_get_block_offset(struct drm_framebuffer *fb, unsig=
ned int plane,
> > +                                  unsigned int x, unsigned int y)
>
> Better use u64 as return type.

To avoid overflow? Not sure who would use crazy large framebuffers, but
doesn't hurt to play it safe.

> > +{
> > +     u8 h_div =3D 1, v_div =3D 1;
> > +     u32 block_w =3D drm_format_info_block_width(fb->format, plane);
> > +     u32 block_h =3D drm_format_info_block_height(fb->format, plane);
> > +     u32 block_size =3D fb->format->char_per_block[plane];
> > +     u32 sample_x;
> > +     u32 sample_y;
> > +     u32 block_start_y;
> > +     u32 num_hblocks;
> > +     u32 offset;
> > +
> > +     offset =3D fb->offsets[plane];
> > +
> > +     if (plane > 0) {
> > +             h_div =3D fb->format->hsub;
> > +             v_div =3D fb->format->vsub;
> > +     }
> > +
> > +     sample_x =3D x / h_div;
> > +     sample_y =3D y / v_div;
> > +     block_start_y =3D (sample_y / block_h) * block_h;
> > +     num_hblocks =3D sample_x / block_w;
> > +
> > +     offset +=3D fb->pitches[plane] * block_start_y;
> > +     offset +=3D block_size * num_hblocks;
>
> User space controls the values in fb->offsets and fb->pitches.  I'm not
> sure how well they have been validated already at this point. Did you
> investigate this?

It wouldn't be worse than before, since this changes is purely code movemen=
t.

There are minimal sanity checks done by drm_internal_framebuffer_create()
in framebuffer_check(), such as offset overflow or pitch size too small,
but that's about it. It would be up to individual drivers to perform more
checks that match their hardware limitations.

What sort of issues are you thinking about?


ChenYu

> Best regards
> Thomas
>
>
> > +
> > +     return offset;
> > +}
> > +EXPORT_SYMBOL(drm_framebuffer_get_block_offset);
> > +
> >   #ifdef CONFIG_DEBUG_FS
> >   static int drm_framebuffer_info(struct seq_file *m, void *data)
> >   {
> > diff --git a/include/drm/drm_framebuffer.h b/include/drm/drm_framebuffe=
r.h
> > index 38b24fc8978d..c07aea1cc59f 100644
> > --- a/include/drm/drm_framebuffer.h
> > +++ b/include/drm/drm_framebuffer.h
> > @@ -220,6 +220,9 @@ void drm_framebuffer_remove(struct drm_framebuffer =
*fb);
> >   void drm_framebuffer_cleanup(struct drm_framebuffer *fb);
> >   void drm_framebuffer_unregister_private(struct drm_framebuffer *fb);
> >
> > +u32 drm_framebuffer_get_block_offset(struct drm_framebuffer *fb, unsig=
ned int plane,
> > +                                  unsigned int x, unsigned int y);
> > +
> >   /**
> >    * drm_framebuffer_get - acquire a framebuffer reference
> >    * @fb: DRM framebuffer
>
> --
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstr. 146, 90461 N=C3=BCrnberg, Germany, www.suse.com
> GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG N=C3=BCrnberg)
>
>
