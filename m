Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com [74.125.224.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875E8306B0A
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 07:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789715236; cv=pass; b=VD5VXLLbTk8b2yR+FRZ66JLsqhjfUJawMszOeDNCKsC46HVofPqIrsSgpa0JmoRSvxPZSz8jOOhrm+pD1ZvbdKzf3StdWUbIYuSwwZLiGMKh8hC58kjgLbLZL744Jl4ih6z9RfwZEV+TZTU75h9o+KJwkz6kwT2jHG5PFSFq5dM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789715236; c=relaxed/simple;
	bh=hnGmBkKP9ldG990awhuRYySkLT6FFnTZIuKmIFeC1Lc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O1Kl8zyddVMnvjHqKBGnMrLA7yPlX/FwAEjsgN4hWjyBYF8eWixBSlhtJjILlSWPnokL0CxI1JIndY04MJ/hone5oSTGqws6ZYz7j3OJIxp/RpqhMGMynlRpa3qE25rZ1+VWBSfUa+bVYtmqimvJlQqhA5qGWY6T3PprgHnJpNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=W7L/qY3i; arc=pass smtp.client-ip=74.125.224.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W7L/qY3i"
Received: by mail-yx2-f40.google.com with SMTP id 956f58d0204a3-66e4aa8d881so444406d50.1
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 00:07:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789715223; cv=none;
        d=google.com; s=arc-20260327;
        b=P0x6J7eKxGFLEzsvgMQhKIz+nJgY5b249ZaOY3M4A2n8ZNTaJG6Eu9ob3ULJKIx4bq
         ACxdECPa6JbwMTunlqhtLQyKnWqCjtt+voJKQTHFYnL2Z7pCyhnJxkHig9CJcbGv37zu
         +B2T10d2oVZl+qUfYjPXhL2EekzJGpMuxx0AGyi2nz/o1E5+/qwUMkt/h5nGF7pc071T
         n1X0hEhyTOOSgjEebgYeGy2SRKIVJEjKTdwR2V4CP8IJQhSPPmQ66eKZqeO4zgJtf1l1
         ZF2ErLl5QKPe1B9+7Ovc+6FmgLxdiv144hbmI8/a7tVU/P4UUWFgIItdoLzIm5Ik3F9s
         9hCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZVTLUeibsWBPZCdD+qqGVF/fmQVK7DA4WjMhu8zs7u0=;
        fh=7QIbIqzr6UEoXbpQSe15A+Fkopt8dFsqLnuaCVlDMFI=;
        b=GNn5j2tvlk78q+LBlF1++duURUTymr3wj5S1kCzY+U/hfrrNJzqoADy9Hs+OzEhNoR
         uWeqPO9p5otts8WoTyn0uFqWrb4/LXRTLzFWX17b4B3neVv68TP/Yo8w2iMRAaTt0MPk
         7+rOj3+nScpacHr/s/xRuz+2+4Bf/ZhRfk6ZOtlOU3YK4VNuowRBgh+OP5IEwOHcWlRQ
         CdjUhlaVRZRWh0RdgBfJX00yH9gODxVYVzn9TY6dhDQBiAgdUz8rjmpAiXSXi3+LhBMa
         BPM/JxWZJ3HEqSWRCIrSjUsXIgvMLkZd9yelLIrLGBxK8ZU8WB3ww2ImgpPW49/IUgzz
         XfsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1789715223; x=1790320023; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZVTLUeibsWBPZCdD+qqGVF/fmQVK7DA4WjMhu8zs7u0=;
        b=W7L/qY3iVZGKZG7jNcwTW28H6Q1+7SThrqXfK7bEsxOXKyh9EWPvoQ+y0/NHrw8kbk
         vFy7TemY41yR7OL8DHmo54QJm4MuIhzyzx0lFeqkt7wZKMoS45aCiozScCPolRZYJqk9
         hwAAPm6vw7yGHgjLFRHqeYd0UgrZNEV4IoIVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789715223; x=1790320023;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZVTLUeibsWBPZCdD+qqGVF/fmQVK7DA4WjMhu8zs7u0=;
        b=dcw/u/1ew79fa0qNVPPJ1a2zrFG8pyUXfznFkDCJiND1hu2QGpfpprTG5MqLJjg6od
         VLqyO0t0QlSn8u1Rj5Ev5fjxYXtc7kee5HpRj2XlBIGpgyiWV5d7tiEqhOvdF21l5T6/
         97i0XfyBQ8wcTcPBaczM9eL8Y8m6CBCsF0ELxha95Jx8riA0nuvI2dzxYevmPoaQMHoR
         Ml5xno4W6SHz/MAYVZkMKBOzO4ZpSS0XVgCkQaU4VAh+mrVdWR0RMBD/3o25ZpGeloM8
         Vg5PsvjfXlinuufaFkyw2s8Onh/V/DXS3UyJPrnoMlE86tlTVvlu45Z4xJl5ukc5vZKa
         JD8A==
X-Forwarded-Encrypted: i=1; AKwUvBybqMliQM1e9lzUFGj71FTtid5v6tNe4JrCiwfOgMyKqTXP+m2RrbUatnNDZQDetztTwrcthIw=@vger.kernel.org
X-Gm-Message-State: AFuF++lgAT/QRhuGkpiuXUMFG/en/cKBKP2oHSVahFmZVg9oioySG7m7
	8TydBeSpvPFBIq9VDO0scmXtpOTykPjZwmXQevYwH7LLnEEYu6s44TLB9EAmR4IfIKqMOMIDE9S
	fjfQU6qtea53Yiz2VOlsjH+mdnBmutHL/MSFarFi0
X-Gm-Gg: AYBFou34N0JLRyAa20QrHdhBEiA1RL+YPzRul+yTrQIZiGwdvdvIlh2ju1rHMtXGqVP
	t+Bslk+DllpwcIsEChvWbNEPGlkEBajV7QkYza/IKRaneRoHu03cB++vg8uwpp1MDi2eFz/CcHP
	OEj02suOcIALznFVHy61/8YjQKpa5H8rZEFLWVe6sKma/2By5ZW5kJ42sY+gQp3MgjdVwNc544v
	vX1lqRx49cf/LGqdvTIDKZ01GHugmbRVkJpI3FPPinyzIuaPg5q9+tnnXP+7hlyawlgS9fnpx7i
	jI0UuF4ubFD+Z427yx5HOpqypq9ctkAPtbxF26yFIsu7hnkU7aM1PYTiDB/41DrbrGPHG9I32io
	3DdW5Q51SEQ==
X-Received: by 2002:a05:690e:c4d:b0:671:7b0:e5ce with SMTP id
 956f58d0204a3-6717fdf1073mr497902d50.75.1789715223118; Fri, 18 Sep 2026
 00:07:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916033327.3054126-1-wenst@chromium.org> <20260916033327.3054126-2-wenst@chromium.org>
 <f6ace486-70d8-4e81-89cb-e9d55ad9ac8b@suse.de> <CAGXv+5ErgWVNtnRiW+QA7+Mzh=W_Y+HGL_iRa1fOaXCYSoAwMA@mail.gmail.com>
 <f7fa4c4c-bc59-4822-94bb-6e9d68f8f0ca@suse.de>
In-Reply-To: <f7fa4c4c-bc59-4822-94bb-6e9d68f8f0ca@suse.de>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 18 Sep 2026 15:06:51 +0800
X-Gm-Features: AcwNN1VLg__gblp0p9qUFHinFpHutsjL-_8trTnXduaSEQp1OhTN0-X1tjhNQaU
Message-ID: <CAGXv+5GNjKxzHuBn28PbRtbFA1yuJ7h02xDpght4add3emuKJg@mail.gmail.com>
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

On Fri, Sep 18, 2026 at 2:41=E2=80=AFPM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:
>
> Hi
>
> Am 18.09.26 um 06:16 schrieb Chen-Yu Tsai:
> > On Thu, Sep 17, 2026 at 11:20=E2=80=AFPM Thomas Zimmermann <tzimmermann=
@suse.de> wrote:
> >> Hi
> >>
> >> Am 16.09.26 um 05:33 schrieb Chen-Yu Tsai:
> >>> Currently drm_fb_dma_get_gem_addr() calculates the offset into the
> >>> framebuffer memory for the framebuffer's unclipped source coordinates=
,
> >>> adds that to the framebuffer's backing storage, and returns the resul=
t.
> >>>
> >>> We are about to add a variant that uses the clipped source coordinate=
s,
> >>> so there is already some reuse of code. However, calculating the data
> >>> offset for a given pixel is not specific to the DMA FB helpers. The
> >>> offset is only related to the framebuffer.
> >>>
> >>> Split out the offset calculation into a new framebuffer helper so tha=
t
> >>> non-DMA users can also reuse the same code.
> >>>
> >>> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
> >>> Cc: <stable@vger.kernel.org> # dependency for next patch
> >>> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> >>> ---
> >>> Changes since v1:
> >>> - New patch
> >>> ---
> >>>    drivers/gpu/drm/drm_fb_dma_helper.c | 28 ++----------------
> >>>    drivers/gpu/drm/drm_framebuffer.c   | 45 +++++++++++++++++++++++++=
++++
> >>>    include/drm/drm_framebuffer.h       |  3 ++
> >>>    3 files changed, 51 insertions(+), 25 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/drm_fb_dma_helper.c b/drivers/gpu/drm/dr=
m_fb_dma_helper.c
> >>> index fd71969d2fb1..ab0f37d8a5ff 100644
> >>> --- a/drivers/gpu/drm/drm_fb_dma_helper.c
> >>> +++ b/drivers/gpu/drm/drm_fb_dma_helper.c
> >>> @@ -75,36 +75,14 @@ dma_addr_t drm_fb_dma_get_gem_addr(struct drm_fra=
mebuffer *fb,
> >>>                                   unsigned int plane)
> >>>    {
> >>>        struct drm_gem_dma_object *obj;
> >>> -     dma_addr_t dma_addr;
> >>> -     u8 h_div =3D 1, v_div =3D 1;
> >>> -     u32 block_w =3D drm_format_info_block_width(fb->format, plane);
> >>> -     u32 block_h =3D drm_format_info_block_height(fb->format, plane)=
;
> >>> -     u32 block_size =3D fb->format->char_per_block[plane];
> >>> -     u32 sample_x;
> >>> -     u32 sample_y;
> >>> -     u32 block_start_y;
> >>> -     u32 num_hblocks;
> >>>
> >>>        obj =3D drm_fb_dma_get_gem_obj(fb, plane);
> >>>        if (!obj)
> >>>                return 0;
> >>>
> >>> -     dma_addr =3D obj->dma_addr + fb->offsets[plane];
> >>> -
> >>> -     if (plane > 0) {
> >>> -             h_div =3D fb->format->hsub;
> >>> -             v_div =3D fb->format->vsub;
> >>> -     }
> >>> -
> >>> -     sample_x =3D (state->src_x >> 16) / h_div;
> >>> -     sample_y =3D (state->src_y >> 16) / v_div;
> >>> -     block_start_y =3D (sample_y / block_h) * block_h;
> >>> -     num_hblocks =3D sample_x / block_w;
> >>> -
> >>> -     dma_addr +=3D fb->pitches[plane] * block_start_y;
> >>> -     dma_addr +=3D block_size * num_hblocks;
> >>> -
> >>> -     return dma_addr;
> >>> +     return obj->dma_addr + drm_framebuffer_get_block_offset(fb, pla=
ne,
> >>> +                                                             state->=
src_x >> 16,
> >>> +                                                             state->=
src_y >> 16);
> >>>    }
> >>>    EXPORT_SYMBOL_GPL(drm_fb_dma_get_gem_addr);
> >>>
> >>> diff --git a/drivers/gpu/drm/drm_framebuffer.c b/drivers/gpu/drm/drm_=
framebuffer.c
> >>> index d32aceb6ca9b..9e1231162047 100644
> >>> --- a/drivers/gpu/drm/drm_framebuffer.c
> >>> +++ b/drivers/gpu/drm/drm_framebuffer.c
> >>> @@ -1208,6 +1208,51 @@ void drm_framebuffer_print_info(struct drm_pri=
nter *p, unsigned int indent,
> >>>        }
> >>>    }
> >>>
> >>> +/**
> >>> + * drm_framebuffer_get_block_offset() - Get offset to start of pixel=
 block for
> >>> + * the given framebuffer and coordinates.
> >>> + * @fb: The framebuffer
> >>> + * @plane: Which plane
> >>> + * @x: x coordinate for pixel
> >>> + * @y: y coordinate for pixel
> >>> + *
> >>> + * This function will usually be called from the PLANE callback func=
tions,
> >>> + * or from one of the helpers that calculates the framebuffer's DMA =
address.
> >>> + *
> >>> + * Return: offset from start of framebuffer to start of pixel block
> >>> + */
> >>> +u32 drm_framebuffer_get_block_offset(struct drm_framebuffer *fb, uns=
igned int plane,
> >>> +                                  unsigned int x, unsigned int y)
> >> Better use u64 as return type.
> > To avoid overflow? Not sure who would use crazy large framebuffers, but
> > doesn't hurt to play it safe.
>
> I'd be worried about a malicious user space that tries to access OOB.
>
> Apart from that, we use u64 for other framebuffer-related sizes like
> pitch calculations or dma addresses. Using u64 here would keep that
> consistent.

Indeed. It seemed weird that the helper originally used u32. Maybe it
was carried over from CMA on ARMv7, which predominantly only had
32-bit address space data busses?

>
> >
> >>> +{
> >>> +     u8 h_div =3D 1, v_div =3D 1;
> >>> +     u32 block_w =3D drm_format_info_block_width(fb->format, plane);
> >>> +     u32 block_h =3D drm_format_info_block_height(fb->format, plane)=
;
> >>> +     u32 block_size =3D fb->format->char_per_block[plane];
> >>> +     u32 sample_x;
> >>> +     u32 sample_y;
> >>> +     u32 block_start_y;
> >>> +     u32 num_hblocks;
> >>> +     u32 offset;
> >>> +
> >>> +     offset =3D fb->offsets[plane];
> >>> +
> >>> +     if (plane > 0) {
> >>> +             h_div =3D fb->format->hsub;
> >>> +             v_div =3D fb->format->vsub;
> >>> +     }
> >>> +
> >>> +     sample_x =3D x / h_div;
> >>> +     sample_y =3D y / v_div;
> >>> +     block_start_y =3D (sample_y / block_h) * block_h;
> >>> +     num_hblocks =3D sample_x / block_w;
> >>> +
> >>> +     offset +=3D fb->pitches[plane] * block_start_y;
> >>> +     offset +=3D block_size * num_hblocks;
> >> User space controls the values in fb->offsets and fb->pitches.  I'm no=
t
> >> sure how well they have been validated already at this point. Did you
> >> investigate this?
> > It wouldn't be worse than before, since this changes is purely code mov=
ement.
> >
> > There are minimal sanity checks done by drm_internal_framebuffer_create=
()
> > in framebuffer_check(), such as offset overflow or pitch size too small=
,
> > but that's about it. It would be up to individual drivers to perform mo=
re
> > checks that match their hardware limitations.
>
> Right, makes sense. Looking through the framebuffer validation, a
> buffer-size check could be done in framebuffer_check().  But that's
> another patch series.

That's further covered by drm_gem_fb_init_with_funcs(), which
drm_gem_fb_create*() goes into. I didn't check all the drivers that
implemented their own .fb_create callback though.

- rockchip uses the GEM FB helpers
- MSM reimplements the GEM FB helpers, but does have proper size checks
- nouveau has size checks
- omap has size checks

> >
> > What sort of issues are you thinking about?
>
> Again, I'm thinking of malicious user space that crafts these values to
> force an OOB access.

I think we're covered.


Thanks
ChenYu

> Best regards
> Thomas
>
>
> >
> >
> > ChenYu
> >
> >> Best regards
> >> Thomas
> >>
> >>
> >>> +
> >>> +     return offset;
> >>> +}
> >>> +EXPORT_SYMBOL(drm_framebuffer_get_block_offset);
> >>> +
> >>>    #ifdef CONFIG_DEBUG_FS
> >>>    static int drm_framebuffer_info(struct seq_file *m, void *data)
> >>>    {
> >>> diff --git a/include/drm/drm_framebuffer.h b/include/drm/drm_framebuf=
fer.h
> >>> index 38b24fc8978d..c07aea1cc59f 100644
> >>> --- a/include/drm/drm_framebuffer.h
> >>> +++ b/include/drm/drm_framebuffer.h
> >>> @@ -220,6 +220,9 @@ void drm_framebuffer_remove(struct drm_framebuffe=
r *fb);
> >>>    void drm_framebuffer_cleanup(struct drm_framebuffer *fb);
> >>>    void drm_framebuffer_unregister_private(struct drm_framebuffer *fb=
);
> >>>
> >>> +u32 drm_framebuffer_get_block_offset(struct drm_framebuffer *fb, uns=
igned int plane,
> >>> +                                  unsigned int x, unsigned int y);
> >>> +
> >>>    /**
> >>>     * drm_framebuffer_get - acquire a framebuffer reference
> >>>     * @fb: DRM framebuffer
> >> --
> >> --
> >> Thomas Zimmermann
> >> Graphics Driver Developer
> >> SUSE Software Solutions Germany GmbH
> >> Frankenstr. 146, 90461 N=C3=BCrnberg, Germany, www.suse.com
> >> GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG N=C3=BCrnberg)
> >>
> >>
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
