Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795420347;
	b=yuCk+jbhZDyNwWsJ3SqdrV3UXMgeyORofDmYy+4Bz93HcAVXPppCWae4Sd1RH0AiRMW8
	 wyqZ+rhC0hR+spw4vBhnuY5++DuQRbfLiEnsZGm/t27yNLdRKiQnC8X3BoEwfvA0JhPQJ
	 IW5+dwWMNpM8dNstZ9BrTAFzWCX7qpXxx5J51cU+TKlHZFbv1ZAMlVLEIwHCG+hNfOEBT
	 mTZwYWdb7l9qwJlG3WTx9txMf+SiLTPeigBfedk/sPZp92Xx3mnxDWQL9JZQOqH/HTTfg
	 0/CIVKG6f6QjjRpTVtmHidemD+R8Qrd6LkbQYAkpASif/Gi42IBlLRkEHc42vJYtLrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795420347;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=gPjBrUC4IIvbAeHFoPzSJVURfLd/Eu+uv7trnU32st0=;
	b=VYv6p5vOEblX/sT9zf1Sj41I6A3GSMKM6KCYK9VCPWK+6KPep43/elMBE/7DPHBHxJe7
	 b5UzcIS5Zs53tlKaLHzGO417YyK/+RjoNbkZCHF52hxd4U83dgLyGfjvNNr1vnfGI5P0m
	 FhBReJj00a/0VmTA4HvIKQC0HTazocf9z6hhpDSJNHNuh9lKgzvhNIOawHf+d1jOqJAkC
	 ATPbVDf1SJhuxmE/xmEZUTgg7V/aCpmkG3HEcdmSvYbj2WWJDBqWtU19qvMzj51Ld9Vk8
	 yUi25uBNJLtCYaICgEz5v1msWdpmLlst7wivVEmj99IELjANwx4wMSVaES+ss8BfF0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.221.181
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1B2606A697
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 07:52:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F1B2606A697
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5ece3ab2e91so946857e0c.2
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 23:52:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795420345; x=1796025145;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gPjBrUC4IIvbAeHFoPzSJVURfLd/Eu+uv7trnU32st0=;
        b=oj5wY6cJkwzsK34xav7cjng2SQKe3FF9vkwrRo5DAJssxGiGau6lf1OBpqWfTOkOjs
         8X8MMVX9JwcJ4lXntdA4oRNoaxUtVM2Z4HfFk4F9/w7E2ublV3kcWlMfwU8eJDKeuQhR
         QuLVFJ2x+DZmGUumhvpVZP8sTR/wYB/qUz5J8Zj04+pDCoMCb5AwFKDlYQqMEcVQR/DP
         MHoivzOI5sugmjtNcLS6UxYYBirHhHm4QzCtIcUTYhCqRKTFy1GSkebuPNCVDbagyiNZ
         qzJNMJV/o9v+guSTxqUdc8ibQkiL7VCVdFkwUR/hb3AHzngFVgNqezzSB4aMfCCc1MpA
         x1SA==
X-Forwarded-Encrypted: i=1; AL+hErGM9tzHfETPnTJylWhOUZRBIvlB74cWkspXSiRKumQmWnVRczlOfDWyw7XrhSqNbGdZoxa/cvk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/uel7qQCwvb3w/f1cdVYcj5IdLFTQGB1pAlJ3BS4FHbX/4+/3J
	zsGCbW2uU06WTFRKGkJ07yyk717Zz2VDO/3Z49z6NRawvlgpUPmnpLu+LXLRYB3U
X-Gm-Gg: AZFdTZdFVxzDxKU8a/dE6ZdZC2eezu30lcyYz1LYmv9qwhDbHgrR791UgKzgC0u6bvT
	wXllRpBPID9a3TBiO5M92P0hGYs9tvWt6KjR/azx228JsAsW/Zkh672v1Lt9dWJoFFf4K9xFFhR
	Oid8sXclXC5jiL/yCwmXo/IhqpsnrnUt0kREX3kXcho+RXzaXipV71OiXaNzdS5FO3VWODd5a0q
	pH49m6ktSjf5qQM0f4fGIrq3bPjlG2AIlc4FovxtnjbZkORIeYms1UutFeOtl3BgYCc69EK0L/Y
	5eWdNqjHo0V8jXCR5fARO1bYQF4m8n+8YVH8JOhzXcSWpnmjVX114QY+28yER3K1PWDEM1HAeui
	s1dhSETSy09ShtTJjTz5JaWHNqTMqwiOfR5+Lk6JmnRVzkZTjyzU4i3vUbrLlslyga9ahCic7FT
	1sYaqS442u+yidaUEFLJczNYc7zORpS477+8043IM/lW6PNQaiIefDyQLAMD4N5jZx2kCA1rrOM
	0SRDIEQ0u3KMV9xbXbGmTAVKlxiMWJjgjEPC5vysQ96mn0527UwULt25FD8azBJqM+z29KUS7/l
	AVoQhP3LQ3fHo09HB9dOGmQPwSAGyYJso0L9zS05WXwOYCmTwq+YA4M4+wZJWbwmxMQw0FnDwYa
	ZOj5eAp008yES
X-Received: by 2002:a05:6122:8cd:b0:5e9:731b:84f3 with SMTP id 71dfb90a1353d-5ee8af017b1mr4679077e0c.12.1795420345311;
        Sun, 22 Nov 2026 23:52:25 -0800 (PST)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee8b5a8fd3sm10044034e0c.8.2026.11.22.23.52.25
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2026 23:52:25 -0800 (PST)
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-7cc3eb09dd2so854923137.2
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 23:52:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGwuIcgKbGfUPMMwf0l8lHpzQ64C902zq0Hx4zxkiTaXn/eea2TdT3Kn639sKzgEC5J59OVTSo=@vger.kernel.org
X-Received: by 2002:a05:6102:c4b:b0:7cc:174b:f7bc with SMTP id
 ada2fe7eead31-7d7397267a8mr4285980137.15.1795420344893; Sun, 22 Nov 2026
 23:52:24 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120175413.176249-1-deller@gmx.de>
In-Reply-To: <20261120175413.176249-1-deller@gmx.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 23 Nov 2026 08:52:13 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWyrdpVKvs=8Q+B-Syo1ZdAJvfJXFv0qiNtR9z4VnwnBQ@mail.gmail.com>
X-Gm-Features: Aa3M54qOyxN021oFFusiAroXY34uRuwIJkT2Rviou6jBcd7wAahwXo5xPECEOBY
Message-ID: <CAMuHMdWyrdpVKvs=8Q+B-Syo1ZdAJvfJXFv0qiNtR9z4VnwnBQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] fbdev: radeonfb: reject a zero pixclock in radeonfb_check_var()
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Jianqiang Zou <jq.zou@outlook.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Helge, Jianqiang,

On Fri, 20 Nov 2026 at 18:54, Helge Deller <deller@gmx.de> wrote:
> From: Jianqiang Zou <jq.zou@outlook.com>
>
> radeonfb_set_par() derives the dot clock from the user supplied
> struct fb_var_screeninfo:
>
>         dotClock = 1000000000 / pixClock;
>
> where pixClock is copied from mode->pixclock.  A zero pixclock
> bypasses the existing validation and makes the kernel divide by zero
> in radeonfb_set_par().
>
> The driver does have a check for this: fb_validate_mode() returns
> -EINVAL when pixclock is 0, but radeon_match_mode() only calls it when
> the output has no scaler and an EDID-derived mode database is
> available:
>
>         if (has_rmx == 0 && rinfo->mon1_modedb)
>                 if (fb_validate_mode(...))
>                         return -EINVAL;
>
> mon1_modedb is only filled in when an EDID is read, so when no
> EDID-derived mode database is available the validation is skipped and
> the invalid mode reaches radeonfb_set_par().
>
> Reject a zero pixclock in radeonfb_check_var() before matching the
> mode.  fb_set_var() calls it on the FBIOPUT_VSCREENINFO path before
> ->fb_set_par(), so the invalid value is rejected before the mode is
> applied.  This is the same check other fbdev drivers use (i740fb,
> arkfb, s3fb).
>
> Reproduced on Linux 7.3.0 using a custom QEMU PCI stub device with
> vendor/device ID 1002:5955; no physical Radeon hardware was used.  A
> single FBIOPUT_VSCREENINFO with pixclock = 0 is enough to trigger the
> divide error.
>
> Signed-off-by: Jianqiang Zou <jq.zou@outlook.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Helge Deller <deller@gmx.de>

Thanks for your patch, which is now commit b3f1631d362539cf ("fbdev:
radeonfb: reject a zero pixclock in radeonfb_check_var()") in v7.4-rc4.


> --- a/drivers/video/fbdev/aty/radeon_base.c
> +++ b/drivers/video/fbdev/aty/radeon_base.c
> @@ -836,6 +836,9 @@ static int radeonfb_check_var (struct fb_var_screeninfo *var, struct fb_info *in
>          int nom, den;
>         unsigned int pitch;
>
> +       if (!var->pixclock)
> +               return -EINVAL;
> +

This violates fbdev API rounding rules:
  1. If a value doesn't fit, it must be rounded up by the driver,
  2. If a value is too large, -EINVAL must be returned.

>         if (radeon_match_mode(rinfo, &v, var))
>                 return -EINVAL;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
