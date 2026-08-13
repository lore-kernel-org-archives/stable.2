Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41133EDE63
	for <stable@vger.kernel.org>; Thu, 13 Aug 2026 18:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786645593; cv=pass; b=RrVK5q14UjDFGWlSK30VzxDI+H97CnM297LBJ0CRKuMHGROgNCwBUm43Kafnd7yeBUEvV2Rg/YBYf9HeWp8tLQvGTWHyfVlgGgcTGg6VNqcnw+wfjyMqdrowMhSNOfu4mgbiyQig0xlKA3YfoqeliDx/4E7mXaBvTLaQuvebjno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786645593; c=relaxed/simple;
	bh=87JwDWQez5Ug020gSKJOkZpB3FrxgUlC2+ytZMWzHP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uv03CK+4rLC0pC/9gLjFmo2AEYnR33Vt47OtjKVdqMJms9Ab4VAddsrswtYowwkTydjNSV/nazLUrXd/nWLcVE5CfsiMKytONWsJCgez2bVb+Lz0Dkh+M56kkLyw/QeG5PH0MbsS4/JMHTT8/nAl9KMWbAPClXtTv+zESR/zrso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tlh6pCOJ; arc=pass smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tlh6pCOJ"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-9349ad9c857so21196085a.1
        for <stable@vger.kernel.org>; Thu, 13 Aug 2026 11:26:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786645591; cv=none;
        d=google.com; s=arc-20260327;
        b=pPKg+pMU+59HWHKOCGFcR4oJr+k0j7HjnBjXbHD/LZbyxx5413jWuYMJpwpKvG5Mez
         dsFmdjvzPBMmqQKYJqhFbUG7ZP3l9SjaBGEanglgmbbvIeiXL5U0BPxpOpGUG/bksh3Z
         8dhVqcNcz1zU1rcW0ASLaDbmSwU/aKw6i98np9oRY5GsNUQZ2vDBzvOrKsfvcjnaWpUw
         inG1FHP+ht24CaffhWDKZ18iVc8/fnryiGIOwn/RDR5jnL0QS8Z/x0OmCu+picrt9UlN
         t4IwZliI8itgLne3er1ogb46wZx5DZRp8L/tAYPhDndyc97Kvl0utZGE/r013dVC31gO
         EBhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3GdkHDTH1pSo8fy2lfq+SzZj1fBJy47v0jj+oNnZRWc=;
        fh=65/T5jre3tmV9E3PvoHAzUVmTbQF+cn+0B/dlLvdCIQ=;
        b=GxUMAgScjSOKRxm8hbR4dl/WIkwkVukdi/s81dH3ZpSaOdVr8D2BUh3we6+xZlpw/E
         iv1Mq1wOMDoAr7BsrDru8wVo6h7y0OOQIPfcAzWUcxl9Jg3j6a0usCV0kzAzM9p3xM5d
         IvZNUyxE+WtOf0Gc9S2m87abtieepHNGaon89CSKfJx06iswr9XB+v+MPu3cvONP3+MX
         9CtxXLNwCDHh+BnT2uuXeex4Qoe8g8wMGwZQvqY3VMlceGWeyYEO/wSr3+6S3zh9qJHQ
         DVYpd9pn1ovKOG4eke33MxFlthkEtupK6ejsCsKNWF2t+8cUj4lu2WthAJyprCXH6F2v
         /+yg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786645591; x=1787250391; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3GdkHDTH1pSo8fy2lfq+SzZj1fBJy47v0jj+oNnZRWc=;
        b=Tlh6pCOJecJbhBrKCY9zlRuAFVhVs1dPSt+z9EZVTqbroyATZjAKFn3/A/7yFaSUeT
         OGdWF7aRQBmkLsCSaPHBuZaZTDNOhyskm0W6PoEYRfbV+d0lXRLrY48Aytp60CMJaxD6
         MjqxP6jsolmYZcemKVlSFo+r/VAaHfenAYTcL5kdtccEZ/6k1SdABfK2v/iaCHKetARW
         bruFEaO9TMlNuxYKh0ZcjlSyDHCbOyUtCIt0KpIH+gmjIPcyB6BA3MXP1A19tL40SFrz
         1bmKN7uSk4AWFcegyJLx0BtkZWOQGPbPE4ruF5cE/OH/UuL7sfok6dth+pDl8Iu94ORe
         Za8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786645591; x=1787250391;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3GdkHDTH1pSo8fy2lfq+SzZj1fBJy47v0jj+oNnZRWc=;
        b=Sl2WCiOzRnv6Qz3uiNFMU+8T676fGdQXGneSnMwXI9DtC5lZG+0maAFU4R+6Ba9cBy
         m6yz2YebYeHIu80NaVAJ+Ej2dgjjYNDtYuI1pkPpBiKSbna2Pw98yZ+gvesPLiD2T20r
         H4r/d7fMl7myvSWgKrSjpYcUoycJ9ib+CmlJ6vNAADfiIi1r0hgUqLXV4US9lEJxzmQQ
         p6ZXmzv5LN3917Inw2OaQHWIMsPKr6v1ExHcf3OK7DIC4POK+UD9au1E/9/FQr/VEqXx
         wtRU4TVHevWi6mBHYIm29g7wUZUfY9c+miYXqFoaykxyCowQ1o2wH9GS+f18Hf+eMm8+
         HAbw==
X-Forwarded-Encrypted: i=1; AHgh+RrdiX4mljqhCI2lC26stGFxOWxVKBQSGp61GPZQiZszR+m5sDuEhWAk5PW1gy0dJkhXt8g51Dk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi+Fo4AhuR78zc739p98MeYMiICySC6+EXGaIFxdmPYyQc+bNV
	z26u0dKrQH5PBifXIBUga347STY5OtZDP6DfSdcc2TvvalegXb6Sq+2pMwG9Dobcr711aMkPlIL
	VdraWnoVpHvegSRfJJ5HQfnuwPuBSDMI=
X-Gm-Gg: AR+sD139F5bnE5pnisNxzLWjwHy3qUsrrTAXgvQSBqnlf5pqXGDDB2tjgBnrdkMz2qk
	TG/SAwucEcyoCcjwFPZec4leb8D70l+Lr1g5w624G3FrH1SbuhUaeoQLBPHcRAS4O9g86s8YS/U
	0nRxQWEb5U+FpLR1+4FXq/4iTcJbcevQLF/ZIf9lhp+tzRl1H3qX49Veb9ruEv2KSd34GII/af5
	K0xIloS2SrNkVXxlp9qmokG7kkw8511rGTNVyh1qoBz8ZasawM9SwiQX/75f7N4HOhDcm3y1sut
	gTqs0qcOIU9zRP2++ME/umWbgBp5uxnNgBzqxauKBGkX7Sl9LEHCgN4s+tQHodNMyI0A5aTY9Z4
	Nng==
X-Received: by 2002:a05:620a:a40a:10b0:936:b8ea:3366 with SMTP id
 af79cd13be357-936bf853467mr676498585a.4.1786645590872; Thu, 13 Aug 2026
 11:26:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813170959.22073-1-zhitaevakh@gmail.com> <20f0d0e6-c551-4982-9820-68169039e504@amd.com>
In-Reply-To: <20f0d0e6-c551-4982-9820-68169039e504@amd.com>
From: =?UTF-8?B?0JDRhdC80LXQtCDQltC40YLQsNC10LI=?= <zhitaevakh@gmail.com>
Date: Thu, 13 Aug 2026 23:26:19 +0500
X-Gm-Features: AUfX_mw-38zlBHu8TWWHByMsk7m551ieF-G2AoUNDG7_Z167QTQz5WAyx6YmL4E
Message-ID: <CAGJKGUzjqofpXFQqv=hwg4schv3NaZth9974NLfmwYJLG04C-g@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Scale custom brightness curve from full range
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, harry.wentland@amd.com, sunpeng.li@amd.com, 
	siqueira@igalia.com, alexander.deucher@amd.com, christian.koenig@amd.com, 
	airlied@gmail.com, simona@ffwll.ch, alex.hung@amd.com, roman.li@amd.com, 
	stable@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes, this is still needed.

f1b5d8f9cc54 fixes the advertised max_brightness mismatch by restoring
the full userspace range [0..max].

The issue fixed by this patch is different: the custom brightness curve
input is still normalized by (max - min). On panels with a non-zero PWM
minimum, valid userspace requests near the top of the [0..max] range can
therefore produce a curve input above 255.

On my panel, min=3D3084 and max=3D65535. Without this patch, requests above
the upper boundary caused the backlight to drop dark; with this patch,
the full range maps into [0..255] and the issue no longer reproduces.

I also tested with the f1b5d8f9cc54 semantics present, so the regression
is still present without this change.


=D1=87=D1=82, 13 =D0=B0=D0=B2=D0=B3. 2026=E2=80=AF=D0=B3. =D0=B2 22:45, Mar=
io Limonciello <mario.limonciello@amd.com>:
>
>
>
> On 8/13/26 12:09, Akhmed Zhitaev wrote:
> > Custom brightness curves use an 8-bit input signal.  After exporting th=
e
> > full PWM range to userspace, the curve normalizer still divides request=
s
> > by the physical PWM span.  On panels with a nonzero minimum PWM level,
> > this can produce a curve input greater than 255 and send an invalid
> > backlight level to DC.
> >
> > Scale the userspace [0..max] range to the curve's [0..255] range
> > instead.  This retains the full advertised range and keeps the reverse
> > readback conversion unchanged.
> >
> > Fixes: 8dbd72cb7900 ("drm/amd/display: Export full brightness range to =
userspace")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Akhmed Zhitaev <zhitaevakh@gmail.com>
> > ---
> >   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/driver=
s/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index 40d82a3ee..533c69f0b 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -5131,10 +5131,10 @@ static int get_brightness_range(const struct am=
dgpu_dm_backlight_caps *caps,
> >       return 1;
> >   }
> >
> > -/* Rescale from [min..max] to [0..AMDGPU_MAX_BL_LEVEL] */
> > -static inline u32 scale_input_to_fw(int min, int max, u64 input)
> > +/* Rescale userspace [0..max] to the firmware curve's [0..255]. */
> > +static inline u32 scale_input_to_fw(int max, u64 input)
> >   {
> > -     return DIV_ROUND_CLOSEST_ULL(input * AMDGPU_MAX_BL_LEVEL, max - m=
in);
> > +     return DIV_ROUND_CLOSEST_ULL(input * AMDGPU_MAX_BL_LEVEL, max);
> >   }
> >
> >   /* Rescale from [0..AMDGPU_MAX_BL_LEVEL] to [min..max] */
> > @@ -5147,7 +5147,7 @@ static void convert_custom_brightness(const struc=
t amdgpu_dm_backlight_caps *cap
> >                                     unsigned int min, unsigned int max,
> >                                     uint32_t *user_brightness)
> >   {
> > -     u32 brightness =3D scale_input_to_fw(min, max, *user_brightness);
> > +     u32 brightness =3D scale_input_to_fw(max, *user_brightness);
> >       u8 lower_signal, upper_signal, upper_lum, lower_lum, lum;
> >       int left, right;
> >
>
> Is this still needed with
>
> "drm/amd/display: Fix backlight max_brightness to match exported range"
>
> https://github.com/torvalds/linux/commit/f1b5d8f9cc54ae8a2567ac126867ae48=
8e1bf625
