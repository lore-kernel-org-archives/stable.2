Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA85A3A5452
	for <stable@vger.kernel.org>; Thu, 13 Aug 2026 11:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786620713; cv=pass; b=pRbb3sMPjrWvquvM4qkROUbLEIzb23rvkVaL6w7RFVsduqQ1OJdnA1vbgnQU2E9vnlvUCkcuFEaxdxaPjjOphSK3IrAKBpTMaFV12syScmu+zry2usYbanFxyKVXDL0Z+fN6a59V+t8ZUsyy68nvXGyUQqzm3J7pD5QRmPLMa+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786620713; c=relaxed/simple;
	bh=MT/2tmGMhh09voamgXY3Cimo1subFeymstrJFGTsuiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l5CmYIbWkhbWSRiHaHIEBkKSWKAt5dhPADOyV+czffYNOfzoAPoA6ff82i3DJD5otld0Hvug/FmhmiVxN9IJ7hk4sPmhDLGhwt+oepparfrxZBtV8OTC7hpSDgrM3DWvysabRaeOH1PnBNEkuGF/LhkMukNN4ZivTjbAjY4GWg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QTJAF7I7; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTJAF7I7"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-80c5cb9a888so21962877b3.3
        for <stable@vger.kernel.org>; Thu, 13 Aug 2026 04:31:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786620711; cv=none;
        d=google.com; s=arc-20260327;
        b=ccV8iKVx0Dn9x6NVpwoBEow+qom8Q9OeLPZhHRRbcjw7WeE/rVVA4U2RM8HIhm5Ooc
         8aS4m0MGb5pNbmubyrTjMwHc1W2aij/EC4a4hkbbjm4jAKI2bCyoSoJgcselYwYtdWcL
         Q3D84ObZ7EitcbOVfkG+POnhStvReob+6StFNGRx4aUZ7pUgeFEo1R9EcNuBspbvvF+6
         kidyKrGXqgWdQfnUi0VFu1CguAI3FpXVrrQ4l08VToUfyou3iXwIYGKD5yBMdki1iz1g
         8DDTGDghAaErXpXbkFWwW10fhLdGSYTplIxV7r6h4fIwsSk4Vdjy5AylAej8Xm9j+L0I
         +fSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tia08duuH2NBzcDa5W6CuiLGU5uz5B2OAbtc8rVP8as=;
        fh=3z9Z4Z9Skr4Ci7NH1ssbLjl1l3H5sGNG18mWlESuPJE=;
        b=occyjnxHkSxdK/ebtFlk8S3maz3oVtAyDU8us1sJJBRP45ckFvusGnDAXSrRDS3QSM
         YdsubhbRh3ioBk3GlX6KRNr2RJeWPXvZ3T5tz+4cfHPSPdKZud/9mHRGAYgoA+zQ5sXF
         VZWMugKGPyK+aZu7zqFzsPPwqp+Jg+m0NfRSJ8CuZ+B6YDSwN2Djos4BxVDVhO2Fe0zO
         pxW6/DTtxhIHA6rrfKFAgb+AX0WSghgRJy/brB0PrVBBem1+JlPMwHFfwt8jaF8gErCq
         HtsDTQ/A69enPHyTTdh+WJMiBFvB9AOLlQG99j20q9BNzln5h9TTQvOc/b5AJ+XjAevv
         r6TA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786620711; x=1787225511; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tia08duuH2NBzcDa5W6CuiLGU5uz5B2OAbtc8rVP8as=;
        b=QTJAF7I7EXKJbINqMRbHgz5PXGi8NbngtyqemWBkmCn40BC/qhDPk4XBSNj5pMMlwr
         k24SjgdIIlAaFc/a8h5f8/U5QR6aC4M4t1apF6s2GmDgUjAVOL1+oq5j8coWUyfpbj0b
         ZwtEYzzPk+wmWxe/3dx0RoWpNRt1falKUqKrFXVm5bApIXzpVOe4tt/XL6f4ntTPsTGx
         wUgWS8M+/N26c4zm291+qyYTBSmKfSYe6bC/w2UG9uhBHIOHHnSw5sm1bYHcRozuzh9G
         wtNbERbeZZvd49e8TXwz7IwlK8MCNL5dX8ZuImStXVSYtkeZKwQVL3S5BfA/U9rq7dtE
         n9oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786620711; x=1787225511;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tia08duuH2NBzcDa5W6CuiLGU5uz5B2OAbtc8rVP8as=;
        b=kCOatNlqcgTrCGBq0RbhXg8sOx6Iy1SYAiGFm4hkZjusdSm+kSSBybzgS3R/01xMyo
         IET9AmqbDG7ofJTxW6vJhIWf+2Mt9nBwGsfSw3Q/6BfB+8mWZI+EKbD7PUFmTKcSCo/o
         LQGqOgaA+mHM6fANlH+rSda4k2Yx8Z07dqtXHTkKk+jszj2omLFO9wFKA5t973xZvX3Y
         mvTY+fYzKJXWPVjMDtriDe8owgED6HVk5QSD4HNUHIvq0Vts2E0elBWrAFwn5HRYX7Ci
         MVdrAgWDyizY34K/GdmdI9ZKCo6BjeKuyJ8aP1xvmNGcj9+S/9Urc+6nR0lLdpJQnjhv
         L2tA==
X-Forwarded-Encrypted: i=1; AHgh+RoKi2Eu1GMu3foF7PRP1HNQE+lLnoxQBFAV6vfqsqO5z2TBI8pP/7JGIvpxYKsq/4O46u+60d0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxquwfCTmCOQysfdyuvJy5wGz39oTQeZHpj1dO8FnOp/BK6Lawf
	lY/AI9Bg2KIBC+q+YMl99dhG6poUrMtuxhL6Il9zzS2oHoopTX7jvGsAbrQTILcQO3LIaFBubB7
	ZkJfVF9CPirE66tugZPmO/JPmzVIgQa0=
X-Gm-Gg: AR+sD13wgSaLuFwyTTvMuXlhc+XYXLBON2DqEO4QgjyLqWaJst2gFDl7pMIPuXtpvFh
	N7+aeV/mCycplliFta/BdIYfg99j29JZtNtrtAwjyvRwOaaTjIB2wuGshB0uYi+Egh1h8jJK57k
	tAU03jCiC0v4In86Do6f/ExoTvPHYtplMLkKPR/Fbl0hHjdI13FmdzMQNkn0IcyHLWStgCHNJz1
	QtwJBSKNb1UDcDvsC4E67R/nZrKme/kauHY6XuM7CvvEVQUm/j9JejvHBiG8r6Si7gPnw6x9jIS
	ZJwIPW4W5QJTQldd6fQ5KlPQB3qAcX05kleVGZcJWoqKC61pWfb8gDsPWYite237BQjscJyYYNR
	8
X-Received: by 2002:a05:690c:6288:b0:833:4ca4:f3d7 with SMTP id
 00721157ae682-83475d60c58mr25625387b3.29.1786620710489; Thu, 13 Aug 2026
 04:31:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727111534.729615-1-congnt264@gmail.com> <2026081240-shanty-prepay-648e@gregkh>
In-Reply-To: <2026081240-shanty-prepay-648e@gregkh>
From: =?UTF-8?B?Tmd1eeG7hW4gQ8O0bmc=?= <congnt264@gmail.com>
Date: Thu, 13 Aug 2026 18:31:39 +0700
X-Gm-Features: AUfX_mzGbGbCLUqw5yGVABFLcGDzOMeEoke6_vKzwWhrkgvCIpYRKRc2ZgE3fTs
Message-ID: <CAJpJ=Gufo_0aKSGPr6rH7C+b6N+VdCzakAL_Zatb_Vp5ejdHJA@mail.gmail.com>
Subject: Re: [PATCH] staging: vme_user: fix flush_image leak in tsi148 bridge
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Martyn Welch <martyn@welchs.me.uk>, Hao-Qun Huang <alvinhuang0603@gmail.com>, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 7:25=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jul 27, 2026 at 06:15:34PM +0700, Cong Nguyen wrote:
> > When error checking is enabled (err_chk=3D1), tsi148_probe() allocates =
an
> > extra master window resource, tsi148_device->flush_image, which is used
> > to flush posted writes by reading back over the VME bus. Unlike the
> > regular master windows, this resource is not linked into
> > tsi148_bridge->master_resources.
> >
> > Because it is not on any resource list, it is freed neither by the prob=
e
> > error path (which only walks the master_resources list) nor by
> > tsi148_remove(), so it is leaked whenever err_chk is set and either
> > probe fails after the allocation or the device is unbound / the module
> > is unloaded.
> >
> > Free flush_image in both the probe error path and tsi148_remove(). This
> > is safe when err_chk is disabled: tsi148_device is allocated with
> > kzalloc() so flush_image is NULL and kfree(NULL) is a no-op.
> >
> > Fixes: d22b8ed9a3b0 ("Staging: vme: add Tundra TSI148 VME-PCI Bridge dr=
iver")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Cong Nguyen <congnt264@gmail.com>
> > ---
> >  drivers/staging/vme_user/vme_tsi148.c | 3 +++
> >  1 file changed, 3 insertions(+)
>
> How was this found and tested?

Code inspection: flush_image is allocated in tsi148_probe() (when
err_chk is set) but never added to master_resources, while both the
probe error path and tsi148_remove() only free windows on that list.
Build-tested only; I have no TSI148 hardware.

>
> Did you forget an Assisted-by: tag?

Yes, sorry -- found with AI assistance and I missed the tag. I'll send a
v2 adding:
Assisted-by: Claude:claude-opus-4

>
> thanks,
>
> greg k-h

Thanks,
Cong
