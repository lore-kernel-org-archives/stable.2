Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FD23B0585
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 11:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788263232; cv=pass; b=cTsxJ3KVoVEssIroWCIdb+Ssv0XrNtVBFwQrHZE7+Bzk1GPKiV7RzRM1LlTARFnCHnUKwzpUuEsocQpTfT8PlbcWO/Z+Ez1dWjxgPVycJhd/Sr6XUJGSsk8CaRSB9O+mwkZT5axwiocwzAQSbo+wF6vvcM3OVvsCWeq++bmrX10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788263232; c=relaxed/simple;
	bh=WkEWz4mj8V/La5ibN5ZGxZHCQujl3YdUwyDFz4ro5gQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PAgQBG3rr1iwgCAPgkqns709pA96cXPrptF+jZZx3QqboV4jhUKpiEm8usxd7n8m4Ox5ASA50AblAeE61cPhKkTKgaDqpx6E/Jyb/2ck5g1TOBf0Y/5tZVg37pXymttcpefZWDM46EoJNHkl4mRTNMFEPJhZJc9HwM9ADvTRihk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rGQxFILE; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rGQxFILE"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6a623987d32so1214985a12.1
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 04:47:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788263229; cv=none;
        d=google.com; s=arc-20260327;
        b=f4spfycD5sgHlHF0/T1P/J0dSM/1Qv7+3scdzMwuy9gBLXfkVFVXVPkF9U9Etpmur+
         1+bZQEK9HUdXWlGB1clV56sM8sFZGzlzrxILXwZBmK0XWBckbFro7YfoA1TV/5MRNXZN
         D/uGz9+iTYPTSyUvbOZkgLFEQpY7WeVrjMPtHX4MHdvdhHh2/oPgYuHB24kADS1W7U90
         9/9DnijPb4KyWh5WSVL+IviEI1EztDQpW+wILn2fNxP1viUY1UfUtKgKaaDVZv3HPMva
         vSs+Dc6PujmHl6/BlQY9YrC1eTFzx12uYlgpILh1di+HzZBiFInXIjkOfoHDurt42O1P
         cfSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ai8hKQw9ceu4/718ljCxu801NyMv3a5qOhxDkpE5Xpg=;
        fh=c0ImoZPf65Y1EQA8f7AjDv/3axrGX1vUGc0FTe5850A=;
        b=gJSnbc/EijuV/lmQrehOzaXRLt8065uHjhLmgF/Yf2d2ClZtlJdB38kbbe02VyfpOP
         e27/cmQ5H7dRyLWe9EAscKr3082cRw2TFfCSNkbHVjSCJGNKF+FQepYdj8dMd15uHFl6
         NmV4///gg1lRjCshKk9+EaskQ7bXNgNxKakBSh8iGXl7dm4u8bPgka4+hrE601h2rmb1
         oCaWEEBYeenSy3o0UBMYUgbYPA+Osk6zir2QzqFnGc3LCz7bo+SAPQDTatbT8G8lHxCd
         oK1x4H7HmS5nboBBlN+HXMlrACjqGBoRGmhpt9wZ5+bse8UGI76ZoBcRFU9a3foyoVwp
         1L+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788263229; x=1788868029; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ai8hKQw9ceu4/718ljCxu801NyMv3a5qOhxDkpE5Xpg=;
        b=rGQxFILEJdbQkHMaTFcQ5RC6dFtu/XFoonkOt07PdOvZw49n0yMHmoLgPsqmmOSCTe
         JZd3TS/UhVxlTcczSSuST8qWQNYn8G1ef8aY/5eyHoAKXBlWZw5tJ4phIOWXXDjhFvPE
         bvNzjVhlZvbp+inQYeK+pnV0sggjieRbmTwa7jFyEN3rcBJnmC8NTbvRmO+O8aurTeJZ
         3mXu6mHne2qhJcfzPb+iPkenpWV0jNypVQeADVV6adcnhUczXi0GTGkfEBBJ6df/WlGn
         2upFAY700E0vTLgcJWGc/4hgdkoeGX2DhSy7q8bKpA9MvXxFCtNmawDv3QpE4i6mp3M7
         ohKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788263229; x=1788868029;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ai8hKQw9ceu4/718ljCxu801NyMv3a5qOhxDkpE5Xpg=;
        b=sWBy7Nms9Ohn8jBDzerEEhnLnOnEah4+ieIJAN1+JOmYSTkDETvd360MyLCX9HApEh
         HE2aAAodT9kMBqkAnKsGhaq88QEGJjOTSpcZ9cSC3GcYQhXdT3Cc+tg0sgzw0KzKA3il
         OriOHnhMkfegWxkpdm01iX+kX7ogjUH9aoNHQZRaCcfgvaHhtii+75guZT3hEdVA+i1w
         HlUtUHUpnJuOeSe/4kTQ2rHBgyNVQWxHXTWS03pI3OusVKoh9m0ZJiOkRiR5HjqBhblY
         kDbQPMXg9Fpeiq5zsg8QBd2Alcue8o23ghaUzKBm4VoU3dAthhNANj2V/78QRnq1zUqP
         aFQg==
X-Forwarded-Encrypted: i=1; AKwUvBxDLk2dSHRKj6rlqgpqhZ6fURw8e7ni5uPyjC1C610SlVcefPAJ43re3mnmkyczQVw/S9nTPH0=@vger.kernel.org
X-Gm-Message-State: AFuF++leR7uKVNhmOTtd1G4f0y9QvndwguIiIzsya3LowRvwjbV85mBS
	Nc+F1brX0o6x5qX8TB1Y1S3dgAXcsClkH/Gp/JEpX2DpRK85Si/vTTsQIPL3c6AqP5DAz0EgkQt
	+79J5FtXPaxJ37QWZgDMmI5HcwDX320A=
X-Gm-Gg: AYBFou3ISfiFX5FzCGzfAWA9iJwRj2sBD+6WE8GCDCDHL/vRBwgZ04CH70gmkDpMLEG
	0yvX2qbTtZXRgpNC0/W4orwNjgd9dUy8VrDXPi1zuqEtzhkYkkEhIuHAjFOl07fqBPZTC9/vFfx
	gspp9GMN0GEp015LhxB2ci8DcuozkCAIVvH69fc7Q8e9hZ5hK7W/RwxcXDSx0hy+DPptjF7sLhr
	fef7iH424JBh0S9jXygYiWh/ntn86YITyhfrYgIHbGOJYbOElwYgDefrfo7dQsialAu3v1v//aI
	InVfCKWhhot43ETytVfqijw+cQWCNBXlbxqNFxncJYPAyozX2ylvakrwnwpbSaxBFMbK/+Z4Wg4
	hj0uGdLSQRz79TFzoIMqGVr8N7vB5
X-Received: by 2002:a05:6402:20d4:20b0:6a6:35ca:af8f with SMTP id
 4fb4d7f45d1cf-6a635cab01emr9499959a12.16.1788263228730; Tue, 01 Sep 2026
 04:47:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728131050.37032-1-meatuni001@gmail.com> <2026090151-nutrient-clay-c53e@gregkh>
In-Reply-To: <2026090151-nutrient-clay-c53e@gregkh>
From: Muhammad Bilal <meatuni001@gmail.com>
Date: Tue, 1 Sep 2026 16:46:55 +0500
X-Gm-Features: AcwNN1V9ueymiP7ruql3Mjh2nKm8Knc4dBzDaOwVce9PaTuiK_XJMOgz4bU3x60
Message-ID: <CADqcGBkjYpLko0EF9BgyApg6LrhA+cR_Cbg5A=4AE81pN4rRSw@mail.gmail.com>
Subject: Re: [PATCH v3] staging: sm750fb: fix mono image source stride
 mismatch in lynxfb_ops_imageblit()
To: Greg KH <gregkh@linuxfoundation.org>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, 
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sent v4, rebased on current staging-testing and applies cleanly:

Link: https://lore.kernel.org/all/20260901113031.161610-1-meatuni001@gmail.=
com/

Thanks,
Bilal


On Tue, Sep 1, 2026 at 3:15=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Tue, Jul 28, 2026 at 06:10:50PM +0500, Muhammad Bilal wrote:
> > sm750_hw_imageblit() advances its monochrome source pointer by
> > src_delta per scanline, and computes the correct rounded-up stride
> > internally as:
> >
> >         bytes_per_scan =3D (width + start_bit + 7) / 8;
> >
> > Its only caller, lynxfb_ops_imageblit(), instead passed src_delta as
> > image->width >> 3. For widths not a multiple of 8 this under-counted
> > the stride, so the source pointer fell further behind the real
> > per-scanline layout on every line, corrupting the rendered image.
> >
> > Rather than just fixing the caller's calculation, remove src_delta
> > as a parameter entirely and have sm750_hw_imageblit() advance by the
> > bytes_per_scan it already computes for itself. There has only ever
> > been one caller, and that caller was passing an out-of-sync
> > derivative of the same width/start_bit values sm750_hw_imageblit()
> > already has, so keeping stride as a separate parameter served no
> > purpose beyond letting the two calculations drift apart, which is
> > exactly what happened here.
> >
> > Rounding up, rather than down, is the direction consistent with the
> > rest of the fbdev core: struct fb_image mono bitmap data (the same
> > image->data this driver receives) is walked elsewhere with byte
> > strides derived from a ceiling division of width by 8. The generic
> > mono bit iterator in drivers/video/fbdev/core/fb_imageblit.h advances
> > scanlines with "iter->data +=3D BITS_TO_BYTES(iter->width)", and
> > BITS_TO_BYTES() (include/linux/bitops.h) is a ceiling division.
> > sm750_hw_imageblit()'s own "(width + start_bit + 7) / 8" is that same
> > ceiling division with an added start_bit offset, so the caller's
> > ">> 3" (floor) was the one calculation out of step with how this data
> > layout is handled everywhere else.
> >
> > Found by code review of sm750_hw_imageblit()'s internal stride
> > calculation against what its only caller was passing in, and
> > confirmed with a clean -Werror build. I do not have this hardware,
> > so this has not been exercised at runtime on real sm750 silicon.
> >
> > Fixes: 81dee67e215b2 ("staging: sm750fb: add sm750 to staging")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
> > ---
> > v3: Added the version notes below, which Dan pointed out were
> >     missing from v2. Added Cc: stable@vger.kernel.org, flagged by
> >     Greg's patch-bot since the Fixes: tag targets an old (2015)
> >     commit. Added the rounding-direction justification Dan asked
> >     about, citing fb_imageblit.h's BITS_TO_BYTES() as the existing
> >     kernel-wide convention for this same struct fb_image layout.
> >     Moved the "no hardware" disclosure from an email reply into the
> >     commit message itself, per Dan's request.
> > v2: Added a Fixes tag. Moved the src_delta calculation into
> >     sm750_hw_imageblit() itself and dropped it as a parameter, per
> >     Dan Carpenter's review.
> >
> >  drivers/staging/sm750fb/sm750.c       | 2 +-
> >  drivers/staging/sm750fb/sm750.h       | 2 +-
> >  drivers/staging/sm750fb/sm750_accel.c | 6 ++----
> >  drivers/staging/sm750fb/sm750_accel.h | 4 +---
> >  4 files changed, 5 insertions(+), 9 deletions(-)
> >
>
> Does not apply to 7.3-rc1 :(
>
> Can you please rebase and resend?
>
> thanks,
> greg k-h
