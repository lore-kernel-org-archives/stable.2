Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792468414;
	b=KVVxVaSRGcuXVaikcF40KBdpM8axJTYFTFDMOQcbxEp17jaqBJ+9pubcJ3W/lkt7/lFe
	 yOMN22CUB9NXElh8WEntsIn/gihKdMzdbrY7wWcDqaafscNSPDz3B3P6yj6svil8yfDDq
	 f+X1DyJuSKzGjN28ZyPt7nblw5ZXhjVuGnWJJgZOW1ajNRIvNpwpAJAIMZwmV05jlyng2
	 GuPUmYgrf3J1lBTrq2JDEuxmJVs9vvvcfXFnqvjySm+abMsYeEnV6+4Seal6RxMbxHlYY
	 YPaiyA3rDk90W9K3OToXZ9u7cysme/VyuAbBwsSsTD08OL1bUf7Qtd+A++9X3luPV8w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792468414;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=B8x7QIi4yGr+7efbbM83ajwXkFKzE+lcxp1Y5FQsBMY=;
	b=lkhAW72L/0HG5pge4Ypf/3PqTMxdKpmx9J5Kr0BUQ2QDJNn4JZjxSg5D0I35VE6fZHRj
	 GBL4YUAe83MLCO5rF24v4dMoWr6fNlkFkIXdkb/eAdeq+2yTYf13vevIfkRvRd6jMFw0E
	 F0cOu1eqPMjCXynvsy7u9GLNB2nk6NE/YDZ+ydXrWJI9nNp0/4r9LVk1hr3SovKsGLGgO
	 Y64k/Q09a+mzTvMfm3JXCeMmx+Onzum2WRaHiDF7AH1HwTJg1/0TRm+tFtdkZewcYBPeX
	 cvbj58OxUXuanD1zDZZX1abH95CtFqrjvy3eTvsexvRVHEqhUJvoc3u9UZ3hpD1jMcg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="E/1d89xz";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.45
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18A7606A31B
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 03:53:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E18A7606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=E/1d89xz
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-9908346255fso129035241.1
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 20:53:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792468413; cv=none;
        d=google.com; s=arc-20260327;
        b=nYs8m52Xh1DOqgY+9JiFVa+2aEhj9JoRzxhcgfsI7DcecZSXeOOki74woQWhzC3L+z
         8wvuaFlFZxPNxSPKSwHDJPaxtuNAdL/todUoyuDSu6cCbUVeWVxlBpgKTPxXhcvCAqY8
         6W+bnrsxMDAZYC/juuBF7EGbDRxlebZbPM7UY+rK/HFHMp+hNuPoCIk0YuyJ4qE9TxMF
         WzGhHNv6M4i7159qmg0pO/5/YqWMWcw+8e0KIYyT0vIXdIQLF8lFXX77f5OA9Xem45Dl
         HvVXxG2S5VdHGDgZHZJPcxaZQqBwLgFZIMawWic8b+UsxYtBMw4YHYSmc5mSSwHimOGF
         wOPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature;
        bh=B8x7QIi4yGr+7efbbM83ajwXkFKzE+lcxp1Y5FQsBMY=;
        fh=I7V98FNWI3z4qttAkoFYOxNFKrnMlTZbOE1I79Owe4s=;
        b=goHVFrhOsdHvIDGC4vwARgm5tOn2xG04O2edME74EliyexNszlcGQabMyeuKniwdcI
         WrNtFEOVWdk83cr2wnbBZHYow9/hggjREAix44xIGXpKGOZtkswF8zYzUSALGXwMFR7m
         ZDc6HCklox18cbkMDvvUvU5I9qQt6A8Sp1G4W4hoRNmtie/PMNLHKr0cqk8/vblna9QZ
         I4ZsCFaXBasXLDeGfhLnbhicvLkz46FD5C0XjlB6atlDX7IAAZl6HVsDMRTkOo0Ytnan
         +47k3SP4Gj3Noh7szNS89ob3ex0JNlUV7Mbn5WjYc4msJ6gYZTZWPn+9Wi1lzSQkz8Xk
         fIyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792468413; x=1793073213; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=B8x7QIi4yGr+7efbbM83ajwXkFKzE+lcxp1Y5FQsBMY=;
        b=E/1d89xzJd3uN6v8JmRj0qc1lnhhREM+ULZHcPaOOMv6guII5/oSZCYJ4nLHNRI8I7
         GNSQB1akrERgKLxg9Lj8dsWGPizgqaWAQ+ClxdZKJ/Q/qk9FLaimQXifDqypOtleo5OE
         X3+6WDdOVOZ/MtTaTgUvNS1iS87Yp7H1tWIN2pGduCTt0Zdvrd7E57QNBEtrXrouW+do
         STmVpeWqtzdMCO6QjTVRdgszrMyE9oLvw6gXQcQE4hmJzMOPJ14khsagqj6iKZnCQUnz
         1NwMQiwJZBVr3tNFp7pkmeUJWr2v7MWzwibVnNvXmPIJIpVyP3HG4jqm4UIN99TnXA1T
         Boqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792468413; x=1793073213;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=B8x7QIi4yGr+7efbbM83ajwXkFKzE+lcxp1Y5FQsBMY=;
        b=nJWyspd7Xcl13wgyfPaty2qz9iFCagCN0W4cxQtCiqpyvL35oOXsHTn0bMbRGY/pLr
         Cv9f6/7DzKZSd6SQY1CgltW02yC0tTzNdfNkvlKMPF5+Jn0D/wANRapiOwh+KUWZvVe7
         UsAf+6zfardyPZhX/2diV0+HbTUNtoBLetZuzE8yeoF2D6fr4a0eM8+p/y/ItSdPOC3O
         IGqHdy51q9z/5tcy4F8efIZ70kjylO2aBcV6zeeemWfIiAnm44QR1vtbJjUPiCUQDwzq
         +IVyTc/1j0lH+zSUkUQGiOLseJScOarZZyjRCoFw0kMmSlEIlke9gJO9ndkHINYbTr9c
         KuFg==
X-Forwarded-Encrypted: i=1; AKwUvBws3tRE/wqwwx1Vh+hVu2Nljyltag7/ZojUVu6JPzLGItPvlKoPX0sKaLecFrf0rr0KSSdlW4w=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ9lajT77Xp1tVIePIUX3CG+wSYGX1IyQEIcRoPD+eAHUnHJJyo
	mD/8vmpZw78mhO5YB0LxF4Hxrtd5T5FT0owmf2B6ENpSef8dffGmzbVrj6eMNjd4IH+YE5ga+KB
	lOoGwAu4dSs/kvn/mrW5FGj6s82JyOSw=
X-Gm-Gg: AYBFou1IXU2mkFPXkPFtY7pCklBzx9bDglClVGa0MkNyjNMjmbu8+oNsd3KWNblhJEQ
	wq+vkb5WJ+XbBSL66KLPwACy+Cm/BVRjaIua+6ONeQPdOigtx1ViGuyCUnnuVal3ZCediC1YWNI
	GT+hBNnJ8uWSoTFCjhaBD9MFo0s6VnGDCxZpjIDEqL10OLgHmr7TAkaxA+0L7IRjvxJ8I6/uh8B
	+lJhy/1tnH/agGedgUTHve292iPS0I/i694W4oqIYM4DkL75M9nh8yDLPlj3r/KJe3qMLH8PgGh
	654MoEQ3D6/c5i74R+zdIuJQG4cq0Fvg9iaiU18TACo6J06Sgv87yoQ6FkELnfKZslWb
X-Received: by 2002:a05:6102:8645:10b0:7a9:e680:efd5 with SMTP id
 ada2fe7eead31-7cc7bca6de0mr171865137.28.1792468412768; Mon, 19 Oct 2026
 20:53:32 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 19 Oct 2026 20:53:32 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 19 Oct 2026 22:45:49 -0500
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <9a1b8caa-c260-469d-8b0b-6a2ca29226d0@collabora.com>
References: <20261018-fix-imx415-vblank-exposure-sync-20261018-v1-1-920383f39185@gmail.com>
 <9a1b8caa-c260-469d-8b0b-6a2ca29226d0@collabora.com>
From: Iron Berrington <berringtoni36@gmail.com>
Date: Mon, 19 Oct 2026 20:53:32 -0700
X-Gm-Features: AclHuK9XNMAuACY9V_8Ap8NkrnCzm4l0f59JyBZIo7KA_7HpUs6PKGbdATumTtQ
Message-ID: <CAF2O-sNE3bKxuZrYvkBJ=-4sgSrPanzbKfcHJ0kVgFqwn0G9Sg@mail.gmail.com>
Subject: Re: [PATCH] media: i2c: imx415: Use target vblank to calculate vmax
 in s_ctrl
To: Michael Riesch <michael.riesch@collabora.com>
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Michael, hi Dave,

Thank you both for reviewing the patch and for the Reviewed-by tags.

Best regards,
Wenqiang


On Mon, 19 Oct 2026 22:04:36 +0200, Michael Riesch
<michael.riesch@collabora.com> wrote:
> Hi Wenqiang,
>
> Thanks for the patch!
>
> On 10/18/26 14:54, Wenqiang Zhao via B4 Relay wrote:
> > From: Wenqiang Zhao <berringtoni36@gmail.com>
> >
> > When setting V4L2_CID_VBLANK, imx415_s_ctrl() writes the new frame length
> > (format->height + ctrl->val) to the IMX415_VMAX register, and then falls
> > through to case V4L2_CID_EXPOSURE to update the electronic shutter register
> > (IMX415_SHR0 = vmax - exposure) so that exposure is preserved across frame
> > rate changes.
> >
> > However, in case V4L2_CID_EXPOSURE, vmax is calculated as:
> >     vmax = format->height + sensor->vblank->cur.val;
> >
> > Within the V4L2 control framework, sensor->vblank->cur.val holds the
> > committed old vertical blanking value, which is not updated to the new
> > value until s_ctrl() returns 0. Consequently, when VBLANK changes, vmax
> > is calculated from the stale vblank value:
> > - If VBLANK increases, SHR0 is computed using the smaller old VMAX, causing
> >   the actual hardware exposure (VMAX - SHR0) to jump by the blanking delta.
> > - If VBLANK decreases, SHR0 is computed using the larger old VMAX, causing
> >   the actual hardware exposure to drop by the blanking delta.
> > - Additionally, ctrl->val is clamped against the stale vmax limit.
> >
> > Fix this by using sensor->vblank->val instead of sensor->vblank->cur.val,
> > which holds the target vertical blanking value currently being applied.
> > When setting V4L2_CID_EXPOSURE directly, sensor->vblank->val equals the
> > current vblank, keeping behavior unchanged.
> >
> > Fixes: 3bcae55ab96a ("media: i2c: imx415: Add read/write control of VBLANK")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Wenqiang Zhao <berringtoni36@gmail.com>
>
> LGTM!
>
> Reviewed-by: Michael Riesch <michael.riesch@collabora.com>
>
> Best regards,
> Michael
>
> > ---
> >  drivers/media/i2c/imx415.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/media/i2c/imx415.c b/drivers/media/i2c/imx415.c
> > index c3b22b238..e5aa741fc 100644
> > --- a/drivers/media/i2c/imx415.c
> > +++ b/drivers/media/i2c/imx415.c
> > @@ -729,7 +729,7 @@ static int imx415_s_ctrl(struct v4l2_ctrl *ctrl)
> >  		fallthrough;
> >  	case V4L2_CID_EXPOSURE:
> >  		/* clamp the exposure value to VMAX. */
> > -		vmax = format->height + sensor->vblank->cur.val;
> > +		vmax = format->height + sensor->vblank->val;
> >  		ctrl->val = min_t(int, ctrl->val, vmax);
> >  		ret = cci_write(sensor->regmap, IMX415_SHR0,
> >  				vmax - ctrl->val, NULL);
> >
> > ---
> > base-commit: a5ebb76233b79db01e82e061173cb73c6d2b5c6b
> > change-id: 20261018-fix-imx415-vblank-exposure-sync-20261018-967b008cf3fb
> >
> > Best regards,
> > --
> > Wenqiang Zhao <berringtoni36@gmail.com>
> >
> >
