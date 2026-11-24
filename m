Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795515770;
	b=kQcfwnloDTfZs01mKxQthCYQEaF+/2rIsfYIsP6bnE439vQU1nNYT6o4tMq4B1ZRqAo9
	 vQmJXRsrNAUsxsnI+acQNlbadzpC7topCcB2R5CkVDXyxN14EH1YSZRtuOIu7wps5UbL6
	 31/TDHNkDd5ECcfQfNTKzgS9sIJIx4ZbRjJUKBBh8EJWPLhqYgSS2K62i6zAaP1ufP8cK
	 5Y7O7O82XZbp/ZGdAUz5EU7RMO6WOwf4MZ2pz9DAiuTsAhLgX1Padq7M7By6EyNnUinjT
	 vkDRX3kAruovdq2g3L60xdYiKlVKJ05+kSZ+MA0xfprJpufceNUYfHt6Wfhxzz31g4g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795515770;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ejx0Vx6mlT/oh5f9iEeflN8sMqKcxSOCTfvOWvcm4hc=;
	b=dpo81jjQY4jrNvH1RR9JhD/s/zevoBhNDD3Amc6V9Eiu4Q1EW0IPSg9fB7S+cf1OgfEf
	 gQwRvsDyopU/J8Q3dCfGEBfLpio0dbWy18AKvAMrxJdlb6VK1p+y3SCnb6upx5LBrCjlN
	 e+RZOixfdjNv+ZIdCQNNdhZN693JPe9iktwKipbQi3ie/kWLn87hXPmdvzV35pupllTfv
	 aX1Zc30fNY7g1mckjqXZPqkp9nTk1gc+nXyZxojIaY8dyYz/mPdV+uSBRrx80uru++K8t
	 mgAJDiBfzVrsayaOnTUcp7lDG/DhSN4Cp8f2BaSp0vsS2dFz7qUdschTez0sVy4/cEQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Bm9BA46j;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.52
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EC6606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 10:22:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17EC6606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Bm9BA46j
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-67c24619b19so3446754d50.2
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 02:22:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795515768; cv=none;
        d=google.com; s=arc-20260327;
        b=b7hAdZScIx+wdruD1vx/yJyM2VEeuq2aVSLdIkgaJWKe+MpUwk1amXXwO+Yp05SCdb
         5SqELCF61PXx//9Xpdyh350EYK9OD1upTkvKVAXkpjKgyHwQwaYSATI7wfOd6gg1FfDn
         bs9Ma6MC8VI1nM30jMOMfXA/puz8Gd31Lev8hEYttr+4jO0f6ykeLCxeSABtBhKWDUze
         JaqHpBFt4slFkCm8ndGhcjEcYjgmCpChZhli4eWESj5rot+K7L4lTWc/ubAsiTCkBgnm
         gkeop1uipet60sMGihmvh1zYE7u/6dDBXk2FqKo8POMfasMbmcvQQ+Vd8BIeN8RZNQBL
         pb8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ejx0Vx6mlT/oh5f9iEeflN8sMqKcxSOCTfvOWvcm4hc=;
        fh=BG1GL7+rHCphMXQuMZzoxrIdR6bl9ZLCqp2biwv7OmU=;
        b=bESKjfDoC92wwkI+exDM1rGvdgkMvVZPziAkUM9EevWJY3oMI4zcYAatCC2cFW7IjD
         BD4b6PCvvq4JlGP4XXas5tNnAXH/fxdYeTgwhEagjQgFlxlPB45N9l7e0pLFuGZ7N5O/
         5Xwd4OTGwzGBtrMXLmlDO4fy5LbOBdkjMIJYop171rf9ycUG1GQpsg3RoNjEXxZWTY1d
         P6hK6+9Och5ma49z3IM8W6mLwAxkgChCEULWh8gdY5JwJujk+/Hvs/FA/UV04XYB4ozx
         jDahILSYOP5Oe9BMulq7a2xFDKFnPDprBgHWJ23eYYdf9hyUpndWlumnPICzgE3hOAYR
         0HKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795515768; x=1796120568; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ejx0Vx6mlT/oh5f9iEeflN8sMqKcxSOCTfvOWvcm4hc=;
        b=Bm9BA46jg0az0SQSgSx6vZdjy/b9Gb3NDHMH9kCWaawFTBeRUTP5Q97RgijmT4chfE
         5q/7h1CwDlDX9jRehZ2/Vvd28U6TvZvSdu1ak7T0KwtrQgGPjyHWRGYgfFVROXgzVjOH
         Nolqbt68eY3TDImPYngjsV/+G5qRlGqk8FC0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795515768; x=1796120568;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ejx0Vx6mlT/oh5f9iEeflN8sMqKcxSOCTfvOWvcm4hc=;
        b=fC/w5jeggiOwnbN+TO7tHn0cv58Ud+ra0xghm4wVoDdzcs+rFEXQNluKbkN4YEcmVn
         yt5jhNbUnfKZZ85Ui8espcVSpGlp6jQrNfVML9NZcWn7um5MVMvPvZnGCbNerH0d1hIq
         czi4PpojkjArI4a9hGKJeHiFQom1LoBcEtUZX0fKnUlxY7vMewKQ8bv1izqGu94BLbSi
         9MVeNmT4amRoro7RuzKjjU4Bm/Ulgwir/Koaz63wyPoUIvIKCk4zvPrDHiBzW5d2xIk+
         LpOrMIq0PJtwvlJ5fTQ6V8cRvVXjt7EQEx9OC2CfvOlvzRf9bNEpqnd/3EFR1obsaInt
         nQew==
X-Forwarded-Encrypted: i=1; AL+hErGxwuSghfkDy2sI652po5rk1TlHBk1ls0BIfnEQwTQm7t+tW/RuCxz88a3l/PtHbbeDGUrDhqI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8SdL2WjOvQ5BCKeBeP5JZsNGMmpCjh7l+uGiLFH2Hzt8KcJbII
	s+K5r1yDp/LXeFqvf/6MIQBwenVLczfG6wIxx2oi54fgeilfmi77whae2l1/49jjkT8LOhgLzzE
	RPeni1UIBUeW4YCpb+AE+Sd8E/VQqSt+u20r3QQvB
X-Gm-Gg: AZFdTZeKPDYNOZA4/OdfsT32FxML0MxWHpEsQ2cT519qE8bWa2+Hgs1N5pq/X29ljDX
	3wS3ETATDP35rj1b/yv92fSB/lE5MAoQ6xMw+lF843ilz6RXTpyFvDnyiEWJliOn0fb0Is+bOxz
	luuxZXfLl45ZjqSDUzfNP7PMy9WFn0KAUmqJWUQYpyHYVhSPNN6nX/A+Ldy5tAiDK+3Bpm2mwO/
	GVG8DXBkZ5U1vnI1MX5qB+6mv8fxhBVWUI+49c0va6YnyvOF13SEMSiFB45ICVeXjrozWYZQO20
	hUa7HikFxYxQ38sfsCICZXIgiiZdtNzMpZ1QKkwuXpEcG9uwVN2S/EhTHiU8FQ9rO62VsKTHP36
	psyNabfNmXPinYM36ktaK7+Sd8m4XgaIJ32422h7wcu/Wzxpt+NA1nbObS2MYnDQZvew=
X-Received: by 2002:a05:690c:6e8c:b0:8a8:7e5a:dc2f with SMTP id
 00721157ae682-8b5204440fdmr67264947b3.12.1795515768163; Tue, 24 Nov 2026
 02:22:48 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261124074041.115251-1-wenst@chromium.org> <20261124074041.115251-3-wenst@chromium.org>
 <19cd5949-05dc-4107-bd2b-d8ad1e2332eb@suse.de>
In-Reply-To: <19cd5949-05dc-4107-bd2b-d8ad1e2332eb@suse.de>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 24 Nov 2026 18:22:37 +0800
X-Gm-Features: Aa3M54pNfcesZWo4EiEVJfs9QKzf9OEio3h9s-Qk4g3wBzB4RP2yK5vRHxNLzEQ
Message-ID: <CAGXv+5HSV7MJ96qTcOp+JaKWtmmYYWAmDROrT18pZ9PztNCJ-g@mail.gmail.com>
Subject: Re: [PATCH RFT v3 2/5] drm/fb-dma-helper: Add drm_fb_dma_get_gem_clipped_addr()
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

On Tue, Nov 24, 2026 at 3:57=E2=80=AFPM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:
>
> Hi
>
> Am 24.11.26 um 08:39 schrieb Chen-Yu Tsai:
> > drm_fb_dma_get_gem_addr() returns the DMA address to the "unclipped"
> > framebuffer. However some display drivers want the "clipped" framebuffe=
r
> > instead, as they are also using the clipped coordinates to program the
> > hardware.
> >
> > Some of these drivers are open-coding drm_fb_dma_get_gem_addr() with
> > the source coordinates replaced, while others have been incorrectly
> > converted to using drm_fb_dma_get_gem_addr(), which would end up
> > causing incorrect parts of the framebuffer to be displayed if it were
> > somehow clipped.
> >
> > Add drm_fb_dma_get_gem_clipped_addr(), a "clipped" version of
> > drm_fb_dma_get_gem_addr() for these drivers to use.
> >
> > Cc: <stable@vger.kernel.org> # dependency for next patch
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> > Changes since v1:
> > - Use new drm_framebuffer_get_block_offset() helper
> > ---
> >   drivers/gpu/drm/drm_fb_dma_helper.c | 37 +++++++++++++++++++++++++---=
-
> >   include/drm/drm_fb_dma_helper.h     |  4 ++++
> >   2 files changed, 37 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_fb_dma_helper.c b/drivers/gpu/drm/drm_=
fb_dma_helper.c
> > index ab0f37d8a5ff..0aaf4926db4e 100644
> > --- a/drivers/gpu/drm/drm_fb_dma_helper.c
> > +++ b/drivers/gpu/drm/drm_fb_dma_helper.c
> > @@ -60,15 +60,16 @@ struct drm_gem_dma_object *drm_fb_dma_get_gem_obj(s=
truct drm_framebuffer *fb,
> >   EXPORT_SYMBOL_GPL(drm_fb_dma_get_gem_obj);
> >
> >   /**
> > - * drm_fb_dma_get_gem_addr() - Get DMA (bus) address for framebuffer, =
for pixel
> > - * formats where values are grouped in blocks this will get you the be=
ginning of
> > - * the block
> > + * drm_fb_dma_get_gem_addr() - Get DMA (bus) address for unclipped fra=
mebuffer,
> > + * for pixel formats where values are grouped in blocks this will get =
you the
> > + * beginning of the block
> >    * @fb: The framebuffer
> >    * @state: Which state of drm plane
> >    * @plane: Which plane
> > - * Return the DMA GEM address for given framebuffer.
> >    *
> >    * This function will usually be called from the PLANE callback funct=
ions.
> > + *
> > + * Return: GEM DMA address for given framebuffer, unclipped.
> >    */
> >   dma_addr_t drm_fb_dma_get_gem_addr(struct drm_framebuffer *fb,
> >                                  struct drm_plane_state *state,
> > @@ -86,6 +87,34 @@ dma_addr_t drm_fb_dma_get_gem_addr(struct drm_frameb=
uffer *fb,
> >   }
> >   EXPORT_SYMBOL_GPL(drm_fb_dma_get_gem_addr);
> >
> > +/**
> > + * drm_fb_dma_get_gem_clipped_addr() - Get DMA (bus) address for clipp=
ed
> > + * framebuffer, for pixel formats where values are grouped in blocks t=
his
> > + * will get you the beginning of the block
> > + * @fb: The framebuffer
> > + * @state: Which state of drm plane
> > + * @plane: Which plane
> > + *
> > + * This function will usually be called from the PLANE callback functi=
ons.
>
> You should mention what clipping means in this context. It's not obvious
> what it's clipping against. Or maybe point to other docs that explain it.

What about:

/**
 * drm_fb_dma_get_gem_clipped_addr() - Get DMA (bus) address for the start
 * of the visible (CRTC-clipped) part of the framebuffer
 * @fb: The framebuffer
 * @state: Which state of drm plane
 * @plane: Which plane
 *
 * A plane may be positioned partially off-screen, in which case it gets
 * clipped to the visible CRTC area by drm_atomic_helper_check_plane_state(=
)
 * (populating the clipped coordinates in &drm_plane_state.src and
 * &drm_plane_state.dst). For example, if a plane extends past the left or
 * top edge of the screen, only its right and/or bottom portion is visible.
 * Drivers whose hardware cannot clip by itself (i.e. accept negative
 * destination coordinates) should use this helper instead of
 * drm_fb_dma_get_gem_addr() so scanout starts from the visible portion of
 * the framebuffer.
 *
 * For pixel formats where values are grouped in blocks, this returns the
 * beginning of the block.
 *
 * This function will usually be called from the PLANE callback functions.
 *
 * Return: GEM DMA address for the visible part of the framebuffer.
 */

> > + *
> > + * Return: GEM DMA address for given framebuffer, clipped.
> > + */
> > +dma_addr_t drm_fb_dma_get_gem_clipped_addr(struct drm_framebuffer *fb,
> > +                                        struct drm_plane_state *state,
> > +                                        unsigned int plane)
> > +{
> > +     struct drm_gem_dma_object *obj;
> > +
> > +     obj =3D drm_fb_dma_get_gem_obj(fb, plane);
> > +     if (!obj)
> > +             return 0;
> > +
> > +     return obj->dma_addr + drm_framebuffer_get_block_offset(fb, plane=
,
> > +                                                             state->sr=
c.x1 >> 16,
> > +                                                             state->sr=
c.y1 >> 16);
>
> I had to look several times to spot the difference to the regular

I suppose I should add a comment to make the difference more visible:

    /* Use clipped source coordinates state->src.[xy]1 instead ->src_[xy] *=
/

> helper. In any case
>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

If the changes above are acceptable to you I'll send out a new version
with your tag kept.


Thanks
ChenYu
