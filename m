Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2914749E0
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 16:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784738681; cv=pass; b=rIz5cXB94dIzD272q8U6/ge7BFhB5twRA8NbmDaYIrN9rAQxxKnljwEfH4D9VyepMZ2C5FpwepvRElEWgesq1R14BVmq1/fADdPZ5TjCfpZl/JhP0iGkeCLyl56XfcF6CDBrP5v3mEOx+VIFMPYS28e6NR8LzRzVSflMqCmZz+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784738681; c=relaxed/simple;
	bh=agpySzLyBCV4DwQacO7vuQYsD+B0oU5/L2jkF1isuuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SOgY++UI2FT5uWTb925GiRy8I8ZlZYVhzIrnOUx2MNoRuyvE9Bv23rN05ig/Lauq60rWdPrO1Go75bcD4gwquC4gWAn8tiocJrG8OtCMtjLxDpN+HjpnwN2BDFxPyCgtZSFtKd16Ewj87ekBXGS946KkK7Hkvbw2QNjo907kZoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eYLH2ZPN; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYLH2ZPN"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6689f36ae56so438050d50.3
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 09:44:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784738669; cv=none;
        d=google.com; s=arc-20260327;
        b=QJ/saDZAfaymkefb3rw+fSCdZ/31DN4pNmrzNEuHAUgbpw1BtmGk1RvrnjG+uFRTZY
         4Bq6JuFsxbqYzmKDl0iVT3SwIl0FXPhadAxKoaRa244OktWJoEx28u1B2jNndddhtBPD
         Iq9IG0JcVD3/urcjhqUNdX4wbfEq8pIIJebQkQzXopfgTiA+M46NYDqdmlJK4MmK5Pms
         4vch6gYYsUVe9h0krw0rB2CtPDE9yUWOmC6pDmZA9Bf5rbyXI794waj1RjX1LnLB2oQT
         JCtFcZCnUxd5kfD/JORBO2lLPu9NYFFOYPO7kbZ7M46CNBpH5XdKbgZVDxgbAzOmNMfc
         S+1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6vCGv/RyeVFnoEW9tIkNt/ZBPJkW6RlvdlpEDoVrknM=;
        fh=HNslBg/B/irMnBdZol+Rx+xqPwGeHghUUAW86GmJC1w=;
        b=Q6fYDo8GwmQcw3u9e7v/AYbYZ9iV9W+IL++UPWSDo+KrR8oPYAVP+dRv6rql+F8Hhg
         3QY2QtTEz83IAO0DRkLC6f2y7utW7WxTvTJyx5MycVv5ZJgFH/WJphBuRI7YH9IC4gWl
         hiHeUKpjih81rmjw75BvvvHyYpwYCzMf0w1XzTfUprDIxfVw6fQlV/npdFRDbDmx/KJK
         yzQN7tFAJQkm8TFJT9ECfuwZ4PhoHiExxWfsgugebxnulOaVEARuXhO6a/8Uv21UjjtM
         p3u2hXem3HFCJXEedhViLm9VzqunOZkniKcxwEob8zA9p1CVoVNEn/WQKlfF8S7Hh9Bj
         fqAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784738669; x=1785343469; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6vCGv/RyeVFnoEW9tIkNt/ZBPJkW6RlvdlpEDoVrknM=;
        b=eYLH2ZPNx1mToTGuOS4MT+P3EQ6ipuplEs+vjoUrr7nHkLh4ICis5Hx5JnNJaJ9fzu
         fIY+7fQRRX0s+nFR5/h67876z6rmIzFLsG+VaL+2YMNd5Lv7We7ICMMgW1E9iyImagM9
         LTNfCVD7/PDeO35xROMgXyOZh/WgdJNDNY1RVQNV+6iCKo8sg4ZLtezxdBNgIMOoqC7K
         iJUEcp305HOwmd0aZwdg0plbRcQdSpVDhhcCpd72r5I3JJntZsloBgiwgq88YXzhoyPp
         5lsNU5XCowVWqQ/6/7sFXbwgSRWaxzVGIFg907aPHQ1JOcuNtGGHNQz9Gb33F2RaP7vw
         TPqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784738669; x=1785343469;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6vCGv/RyeVFnoEW9tIkNt/ZBPJkW6RlvdlpEDoVrknM=;
        b=h4DGFkwtEbFZatzno/MMBNkOdemcH7Z02jtDN6fZgzpJExsA0rbgOomVSL4oPCPcD0
         UvBqyp5DlhQ6dxabfB7vxFU4ARjXZpX/dOpqxGyeiRaYrJq3ttQPUF70fBFYXL7W3bFE
         8pPB3DoGFAe/+NwIuvK+Kw3xpM2PIM28oJXyKakP4uI1JuavijgJv5rVx00k/gwJUo1D
         iMyQuZiegp9S/1w2n5q0MrEq39kWyLn776nzkURtvryjvxjtqp4FldzRTrTMW1a/ysk+
         uhSMTj+lwGn2gs3DeReimfMQxkv/CGcpVXpNLRndA1nVzJQ5I7sfpV5WvBRsZQUksn0m
         Gpfw==
X-Forwarded-Encrypted: i=1; AHgh+RqjIcnafiumWfKTSwdnTN4FdRkzj37fvf6Z38u2AFomdNrYob+Bmjg8fhB06StFRprktHHUgrs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe3NX5nnvFJVPVNsAniCGXcUnFExpq60PeeYpEJWTG66WoVeBj
	NeYYyiF95E7kgzyR7Uq3tcjnRewo9wYYk529S1/yWVnSAaHFh9pXFdKhTwH48NRfIxdFUp/kV99
	0pA+cvGr9IGT0VPaQ07K5Q5EfcCM0PN0=
X-Gm-Gg: AR+sD12rPLJyp5dIN5Q/UJ7EdCxr1AE6GlkW/AoctpDfEveTEquh2gGI2HY5WwHaCAS
	j+NkNx2xTSgNiRuWdnWU+EIrxpB81UHbM7xMuLVJQr1D3WjDNZcFraCLj9qYdkzuSgT2sdpYM8G
	fFgTgVPzyU91O9DL1vwEuSNzQ698QehwH/wSw9ShR2zEo1oFY2VGfJTcUEdj+oB9AmEbX5lOlDQ
	iriI+usKj5kOX6aT3z9okp5BR+BtCv8ClKFFg+JF2vcKi11SYDXVpK5QqDE+Uv7fmQDnHhenskA
	oncLua5F2plTGy8xIc33a77dWJU=
X-Received: by 2002:a53:a6d0:0:b0:667:e2e1:4c with SMTP id 956f58d0204a3-6683bb03e7bmr4142068d50.2.1784738668720;
 Wed, 22 Jul 2026 09:44:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722154802.3760046-1-johnfoushee@gmail.com> <DS4PPFE901A304F30C76A6DDF48BDAAE920E3C12@DS4PPFE901A304F.namprd11.prod.outlook.com>
In-Reply-To: <DS4PPFE901A304F30C76A6DDF48BDAAE920E3C12@DS4PPFE901A304F.namprd11.prod.outlook.com>
From: John Foushee <johnfoushee@gmail.com>
Date: Wed, 22 Jul 2026 09:44:16 -0700
X-Gm-Features: AUfX_mwNuDWTzYcYl8OndK4uZQVeNS7dreLBBMCpSlV4-VUHUR7Lah18YjNHuuI
Message-ID: <CAGsDCxQ30bUzMbzSigA-o55zX=vzyeP91g38ZDvzJftppp17uA@mail.gmail.com>
Subject: Re: [PATCH] drm/i915/backlight: allow hybrid pin-enable + AUX
 brightness panels
To: "Kandpal, Suraj" <suraj.kandpal@intel.com>
Cc: "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, 
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Jani Nikula <jani.nikula@linux.intel.com>, 
	"Vivi, Rodrigo" <rodrigo.vivi@intel.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Hi John this fix has been already floated, reviewed and merged some days
> ago to drm-intel-next.
>
> https://patchwork.freedesktop.org/series/170522/

Thanks, glad it's fixed, and happy to see the same conclusion; please
disregard my patch.

For the record: independently root-caused and tested the same change on a
Google Pixel Slate (nocturne, Tianma Y156ZAN02.0: advertises
BRIGHTNESS_AUX_SET_CAP without AUX_ENABLE_CAP, ignores PWM for brightness,
and resets the AUX brightness register on every panel power cycle, so it
resumes from suspend to a permanently black screen without this fix). With
the equivalent change on 7.1.4 the panel's AUX brightness register is
restored across suspend/resume and full-range brightness control works,
so feel free to count that as a

Tested-by: John Foushee <johnfoushee@gmail.com>

for commit 7d594b24 on real affected hardware.

One question: the regression (ed8be780bdbc upstream / 102d44b3a8fa in
mainline) is present in the shipping 7.1.x stable series, but 7d594b24
doesn't carry Cc: stable. Will the Fixes: tag be enough for it to be picked
up for 7.1.x/7.2.x, or should it be nominated to stable explicitly?
Affected devices are unusable after any suspend without it, so a backport
would matter to users on current stable kernels.

Diagnosis details, DPCD dumps and EDID, if useful:
https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/16679

Thanks,
John


On Wed, Jul 22, 2026 at 9:22=E2=80=AFAM Kandpal, Suraj <suraj.kandpal@intel=
.com> wrote:
>
>
> > Subject: [PATCH] drm/i915/backlight: allow hybrid pin-enable + AUX brig=
htness
> > panels
> >
> > Commit 102d44b3a8fa ("drm/i915/backlight: Fix VESA backlight possible c=
heck
> > condition") restricted the VESA backlight path to fully AUX-based panel=
s
> > (enable and adjustment both via AUX), on the grounds that the hybrid
> > configurations are not currently supported.
> >
> > The hybrid pin-enable + AUX-adjustment configuration is however already
> > handled: intel_dp_aux_vesa_enable_backlight() falls back to the PWM fun=
cs
> > for enable when info.aux_enable is unset, and
> > drm_edp_backlight_init() supports aux_set without aux_enable.
> >
> > At least one panel requires this configuration to work at all: the Tian=
ma
> > Y156ZAN02.0 in the Google Pixel Slate (nocturne) advertises
> > DP_EDP_BACKLIGHT_BRIGHTNESS_AUX_SET_CAP but not
> > DP_EDP_BACKLIGHT_AUX_ENABLE_CAP (DP_EDP_GENERAL_CAP_1 =3D 0xfb,
> > DP_EDP_BACKLIGHT_ADJUSTMENT_CAP =3D 0xff). The panel ignores the PWM
> > pin for brightness adjustment, and resets its AUX brightness register
> > (DP_EDP_BACKLIGHT_BRIGHTNESS_MSB/LSB) to 0 whenever panel power is
> > cycled. With the PWM backlight funcs selected, the panel comes back bla=
ck
> > after every suspend/resume or DPMS off/on cycle while all driver-visibl=
e state
> > (link training, PPS, PWM duty) looks healthy.
> > Firmware rewrites the register at boot, which masks the problem until t=
he first
> > runtime panel power cycle.
> >
> > Allow the hybrid configuration by requiring only AUX brightness adjustm=
ent
> > capability; backlight enable keeps using the pin/PWM path via the exist=
ing
> > fallback.
> >
> > Tested on the Google Pixel Slate (KBL-Y) on 7.1.4: i915 now selects the=
 VESA
> > AUX backlight interface, the panel's AUX brightness register is restore=
d across
> > suspend/resume, and brightness control works over the full range where =
it
> > previously had no effect.
> >
> > Fixes: 102d44b3a8fa ("drm/i915/backlight: Fix VESA backlight possible c=
heck
> > condition")
> > Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/16679
> > Cc: stable@vger.kernel.org
> > Cc: Suraj Kandpal <suraj.kandpal@intel.com>
> > Signed-off-by: John Foushee <johnfoushee@gmail.com>
>
> Hi John this fix has been already floated, reviewed and merged some days =
ago to drm-intel-next.
>
> https://patchwork.freedesktop.org/series/170522/
>
> Regards,
> Suraj Kandpal
>
> > ---
> >  .../gpu/drm/i915/display/intel_dp_aux_backlight.c    | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> > b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> > index 7a6c07f..a5c03c3 100644
> > --- a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> > +++ b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> > @@ -616,11 +616,15 @@ check_if_vesa_backlight_possible(struct intel_dp
> > *intel_dp)
> >       u8 bit_min, bit_max;
> >
> >       /*
> > -      * Since we only support Fully AUX Based VESA Backlight interface=
 make
> > sure
> > -      * backlight enable is possible via AUX along with backlight adju=
stment
> > +      * Brightness adjustment must be possible via AUX. Backlight *ena=
ble*
> > +      * may come either via AUX (DP_EDP_BACKLIGHT_AUX_ENABLE_CAP)
> > or via the
> > +      * BL_ENABLE pin, which the VESA backlight code already supports =
by
> > +      * falling back to the PWM funcs for enable when aux_enable is no=
t set.
> > +      * Some panels (e.g. Tianma Y156ZAN02.0 in the Google Pixel Slate=
)
> > +      * support only that hybrid configuration and ignore the PWM pin =
for
> > +      * brightness adjustment.
> >        */
> > -     if (!(intel_dp->edp_dpcd[1] & DP_EDP_BACKLIGHT_AUX_ENABLE_CAP
> > &&
> > -           intel_dp->edp_dpcd[2] &
> > DP_EDP_BACKLIGHT_BRIGHTNESS_AUX_SET_CAP))
> > +     if (!(intel_dp->edp_dpcd[2] &
> > +DP_EDP_BACKLIGHT_BRIGHTNESS_AUX_SET_CAP))
> >               return false;
> >
> >       ret =3D drm_dp_dpcd_read_byte(&intel_dp->aux,
> > DP_EDP_PWMGEN_BIT_COUNT_CAP_MIN, &bit_min);
> > --
> > 2.47.3
>


--=20

@foush
