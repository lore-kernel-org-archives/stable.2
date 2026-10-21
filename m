Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792554131;
	b=x3+Z+HDP9TWpZyrioFoasyBlLtytGH7Mg5RsX/AHv4LOUANqBWSt4yD9YYsosaIcXDq8
	 bGCmJkhHnAlIOdYR7ywQkAbUUwxEosg/X8BR0iP6+Ufkn1quT1iaf7HaWh5aUA1TfBryo
	 HzF6xGYVawjkm0KoFORiN+PcyeXlab6S5slr2DMy3NvDDsBk5pcvalvde9LPH2deXqRoe
	 J3/xxdQ8nJdCvjQi1ihXkEDqR3bdtz5n1gaZ3thbb/vReXNbl897f9hbx2mv8ewRxUFPy
	 pbruLkOMbsiG8xSSIrK94fauHf892fMcFSNC6QOtRXHoIWLNmJ7eFaqDj21ekEu7b5w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792554131;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=IeaSzkQDMTFDSwIXhXuKa6PQEsom42E15utOhKCt/2A=;
	b=4JvCeTK5n+CIO3fm035atOLonL392o+29NhX6QCJBAM+blw2Vv4lcv3uJ0aUVfFgR9qE
	 Q00fLDzFX3zrONEPG/tgKoSNvgcP0RJ/oslGx9W/iRd/G7gIfd9sajyCoqch4+zbnQzqM
	 x3XmBI7ODXFxlby9KvEq1fVNtli9Ykn54SnDi/WPrYah9sF5zyUoyQ4meP7uXmuPwV1k2
	 AYV3XSNfdGnt6q9PpEKGFmvmfOm9wz/SpKf/zbfjmGOYY8Gf+IAEA6iVrG17wIUGXFBs1
	 l9eDbVLhy9oUDTiKNZ92g3ZDzhVW44/vXI7mxzhgQwv1e76mLALjJHlDwSaKQG2/PmA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fdr8XTCc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D96F606A31C
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 03:42:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D96F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fdr8XTCc
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b1aa27963eso1898663a12.1
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 20:42:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792554129; cv=none;
        d=google.com; s=arc-20260327;
        b=ZBTjfLO67zqylJnzI6bjxhOFkgK/VviOoSOMAzKni1SMblRizCBBxCCULilafQ5Rix
         wDeX3OLrp12SC1RUkL74Fpvj9WiWS2K7ox5hYjZCpuAdB9wYBgC8qUBf4BUA17jbj1GA
         afYOJASQ8bBebu++MbANd1ovhO4qvNkSigK5r2LdVPAYVY4Tt6gR8tPKMuXGhFkt4OdR
         3fcIbH5SqLv51pjOihmOiekmaU0AWgEch9tJmpKMehHwV2DwzmyDaxLaxhOVPKElOJ56
         Z7IRQvBMDO2wQbJNVYCdEb2vMWuikgQW1lC3beZHV1ouFNXqqsLtQElo2uczJI0LyOaU
         puTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IeaSzkQDMTFDSwIXhXuKa6PQEsom42E15utOhKCt/2A=;
        fh=0wluJ0TInwGEsl7Mi989KiQ+a/4u+1gfLutjr2gHozY=;
        b=LlMVpt8KNQgaeMeCduTHLrFHeSOt7emxU3uspPXt9uouTbX9uw4IKSjRryI2zrCz9X
         C9Gw0AsytOzy6qly1ViSF3Vb0HDKTFLMyUICE/CaB828nIifgndPrKGJt+l4L4IdOrLi
         3w/mtxns/bV9YEsnDvprbuvuAOuZB2AuCW4qmzzDApOT9tRSD0yHiP0cKOMpUduIAoaK
         Kc8w7V+x+UKzkEzd/WHaUpXpjXmJ8T6fbMNgNTtaTpoRu+DT+I2WihtqOT1UEyqDk7XK
         Wzz8UC6mTmiZ+f3VToD9OslHH2MFmxLvoqa2u8E1CaQpFNwcicerJ0QUob1X4PHqq9yj
         p8Uw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792554129; x=1793158929; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IeaSzkQDMTFDSwIXhXuKa6PQEsom42E15utOhKCt/2A=;
        b=fdr8XTCclouSuGw09TYrAEEcJg7A9xLzXplGn13seFUteBNT8XQ2Jk7tXT33UG0p7F
         KbYa0QRdgodG1q9KC/l0eEVYt4PTAnmeMVpAh5sjtUezx5yNBAdGu5X9D+iOQjhx/cea
         WjLE+AaCkdceQw+O2VEtr4HDo//UuLNyZ7YD/awC3DDR9bDxOw8Tgt31uhiVcOan2LV0
         slHIWfuC9e09mby/ct081rD9UsBugdBk7RQVhXI9cKXDvdwnhRT2pbQqlKTA9McJIlCk
         1+7tPkezzJ/rorluB2FbqOxU3YB5t/SkE0Sh+2uEq44j04pnvieK5fryQD5/QkPeUZi6
         QrUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792554129; x=1793158929;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IeaSzkQDMTFDSwIXhXuKa6PQEsom42E15utOhKCt/2A=;
        b=nEazoZPqZFxOGO2slP+U7O9LAVkq+xkT2Qt648reBEZu3C9j6UJ2hQwQT+WYlFJ7vp
         /M8krmfJ0AZcHwJb+n4GCbq9SF9INIu0kI69EWIJNlk/IhR715V3T2SGeHrGtQ5PAQ1/
         ONRIWRofJq2ed+OniEUYkHWtemIoHx0K9NgkYjaPh0qej+KQUiHqN8hipi/ppJj7n5I7
         MJQitjWjo6oAY1aO5U/PiEBzm2XZXrfaWFKpkfAdGlGrmlrW2F3WQpmZs1dk9G0yNnkh
         IhWmee0Xgvafqb/FPVLce8GOuWyP7NNJLk93IctIhaorznsIsy4dCmb7jdTIntsZbNIB
         YEXg==
X-Forwarded-Encrypted: i=1; AKwUvBwQwHLq1FfmyavqECh55BDM+LPFstCCcWvOkZmIoI82C+Bc3FJkV+6oATxWdzii4op5ZwUQM9M=@vger.kernel.org
X-Gm-Message-State: AFq9FYJM8SfwtQF6JO7pT2iy25l2EC2E1CCUuO7r/grFEH6rwGifjjUS
	uHUJq9clCuEun++fPyeEUd5uEu8ckTqsm+dgV8+WzyGC7Xfp3yY15GC70vq0Lo7+uh+kDtsNbV3
	LLg4QpJV850LsTwa0A1mpNCN+///uygY=
X-Gm-Gg: AYBFou3AvSy2aYd7D/GXSlNgX4z2kcLSCzZm0cnmx5344KCNazpk+mkDZ0IMa/auhCp
	9lm+d/df1HNy1cUjflrcJYe7TZs/mN79+OpQ1v0NJwPOSssinhTuM4Q4Tn9qBz6AUaamoeov0jH
	YvBWGNxWwlLIGA7Ur2W2U17Fw2AzeHtXK4cwNuNcjBDCVBGNBvdRYkcaeW0pFSaeDBbzzHbRBtX
	KiKJyq2FpwQAHaw5zTA0IsEecyCNQ7wHSoI3hFlub2ZT+icn3A2l6Z10pKdaFJD26MHHPrDS+Oc
	NHILxKkJ9is1UmNKi8S6tfgn3JBsMwIAgvk+lu8GdBeFuIlkFVcZJucVoxXKIcwObVkeD3giDDi
	fwJ7+KR6cPUuPcivhfBlsIcGDvqNo6fn89CtBWN54
X-Received: by 2002:a17:907:9723:b0:c29:4b57:503e with SMTP id
 a640c23a62f3a-c46791a894bmr80209666b.1.1792554129390; Tue, 20 Oct 2026
 20:42:09 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261016025352.230535-1-meatuni001@gmail.com> <29c3e4a2-9d6a-60cf-d06d-85152a40a703@linux.intel.com>
In-Reply-To: <29c3e4a2-9d6a-60cf-d06d-85152a40a703@linux.intel.com>
From: Muhammad Bilal <meatuni001@gmail.com>
Date: Wed, 21 Oct 2026 08:41:57 +0500
X-Gm-Features: AclHuK-ireUCJptFa_FX8V4hNSMKN72Ng1R0P-ZWBFx4NRNhVt-8-KKpzPkwUPg
Message-ID: <CADqcGBkV4iE_0j6usv6TvV3K9XGUa0L9J-ebUkTLsB0NBYzTHA@mail.gmail.com>
Subject: Re: [PATCH v6] platform/x86: hp-bioscfg: fix heap OOB in hp_enforce_single_line_input()
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Jorge Lopez <jorge.lopez2@hp.com>, Hans de Goede <hansg@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ilpo,

> Why use n variant?
strnlen() keeps the read within count, which is the size of buf as far
as this helper knows, so it does not depend on the caller NUL
terminating the buffer. Both current callers pass a kstrdup() copy, so
strlen() works too. I can switch to it in v7 if you prefer.

Thanks
Muhammad

On Wed, Oct 21, 2026 at 2:19=E2=80=AFAM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Fri, 16 Oct 2026, Muhammad Bilal wrote:
>
> > The input is copied with kstrdup(), which stops at the first NUL, but
> > the full write size is passed to hp_enforce_single_line_input(). With
> > an embedded NUL the helper reads, and can write one byte, past the
> > copy. Return -EINVAL if the input contains a NUL.
> >
> > Tested on HP EliteBook 840 G2 (Fedora 44, Linux 7.2.8): writing "A\0"
> > followed by 4093 bytes of "B" to current_password 100 times returns
> > -EINVAL every time, without reading into the heap.
> >
> > Fixes: a34fc329b189 ("platform/x86: hp-bioscfg: bioscfg")
> > Cc: stable@vger.kernel.org
> > Suggested-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
> > ---
> > Changes in v6:
> >  - Return -EINVAL on embedded NUL instead of limiting the scan (Ilpo)
> >
> > v5: https://lore.kernel.org/all/20261007134711.473857-1-meatuni001@gmai=
l.com/
> >
> >  drivers/platform/x86/hp/hp-bioscfg/bioscfg.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c b/drivers/pla=
tform/x86/hp/hp-bioscfg/bioscfg.c
> > index 876fc35d035b..e306bd8b1e72 100644
> > --- a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
> > +++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
> > @@ -162,6 +162,10 @@ int hp_enforce_single_line_input(char *buf, size_t=
 count)
> >  {
> >       char *p;
> >
> > +     /* buf is a string, so a NUL before count is invalid input */
> > +     if (strnlen(buf, count) < count)
>
> Why use n variant?
>
> > +             return -EINVAL;
> > +
> >       p =3D memchr(buf, '\n', count);
> >
> >       if (p =3D=3D buf + count - 1)
> >
> > base-commit: 8667bd30fd033295b3038ce374c551d1059538ba
> >
>
> --
>  i.
