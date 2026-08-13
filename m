Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C3A3368B1
	for <stable@vger.kernel.org>; Thu, 13 Aug 2026 02:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786587062; cv=pass; b=iJCNUUdsznQmK5FzGxJFOqzceHnyvDPUJzkbN0tQHJtxCtk5rmFTCuBZ/FeBxfEwr1jm6qnFQdfg7Z1BkPsV4ycHU0n8KZPJu5CcTOsBOCE0MPiv6aGtGWH7ZCB5qy6B6qZED53/pqWTdqG26ZEmTepEmoOvSWVnLHlBxRu8klE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786587062; c=relaxed/simple;
	bh=Z+xXgpO3nU29arDHV7L61e9MB3/gcZ9uWTzHeo7w0Pg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SgyvN+I6IoO5h/8im3FXJTJEpaTFl4YCikJweDZmTSJcgVKCZTPOEe5dD2oJRK/uJnG/b+3iNgNxGtxWxZ647NYk+1z8P8Fm9zE45wL31pZ3zn+UFCcaaICTKSJq/BzEnnvSFtDSXLZ01NQs4twsKVCuEf6Cuam3O5uKJ1hjbSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MWfVbEGY; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWfVbEGY"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-8228ed0081fso25526767b3.2
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 19:11:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786587060; cv=none;
        d=google.com; s=arc-20260327;
        b=muWvCUQYVVGpRf4HQWXDJD7CsOP4sQRktypPQIPtiH4HFN5cbAc7KsGpoGQeNGCoQR
         ZaPG3B38xfKddia1ErNDFt6FxkWQYBflVgqNCcbBTkMuI0DQBKC+50o6YZgKBb+EmvSC
         L7mXZrv/dcbJWe1+hU9eeRGhhcF8Ar+keH/NqpXFIi4iiv5eI+PTGbBvgbtJClGSmx4Y
         7l6meFSrtnzWDC8oAHD9ln3t81hSe/4cft99wAjVTdjtcaXuGtojyuCEHBxIkbKF527U
         TW6eqRrQ7GhZhIaGvo9AT6GVFRHHUtWin9xyiI7uiEHzgTYFm6BU71SpquJ4FRdgwrOF
         DUBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9Rp5SLXgfrCQhmh0UUbqTofIr9miP1ABO7B+OUhWdvU=;
        fh=UYWpjxCPt9RMdSFZsvjQDtEQ0a3m0D9HX72oh34o97w=;
        b=iqxMPkI5ewDRCi6KszT64TMzPi0ohkkTkWAp+WtLsxnedaDxAzLXU1qVWiNMQyleLo
         nfuvIJwe5tpNnsG+dhexQfaCN+LoJxPnEoOjwN0V88EFoU3OtjHM1QBuvAwUpBt7gVx7
         of6b09udIAEwONEmGkNykLRjFwCLHg8KaRBqxB9t6jDlkTtjHNGGCGfGiCIu4HsDAUf8
         kg3lvATd/w63mHutCUDyzT38gUzACLdmr7Qygr6Zb5dVFZiTU1zPLZLvGPnE5QGoyKLZ
         7zq0ScLlUsFsdsiGx8ONRAEYcqtIqMEsQ+VWmX0/llBjLQwn880D+0mR1A5FpeUwXyJ9
         AC5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786587060; x=1787191860; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9Rp5SLXgfrCQhmh0UUbqTofIr9miP1ABO7B+OUhWdvU=;
        b=MWfVbEGYmZgt3G9RSl7r4jZU+u4N6V+X2tmpgvrlpcq7Gd3o6s+BMtJg6Wg7yhxp2C
         KjoMkstTHDnz+ohMxcnkJMldz56pq/GEVF4omQwamIbofMIQAgsqjlElti1WkQ5fhkb9
         doEULeK2et8/xAZe5t0rHMdy5XSvD8QskX4Yk2ev/yQsl1UhmUycwdzmQ1cY7OrbpTbB
         N5qk1BvbVl2jiz6WPhgzVc1SLgpa9U7ky5B5mgd+xtzlRh9MdAdeV6MtHrjTUhv/0qwQ
         nWZxEB4UN6zcrSExWrkHk8skkxzElN1p37m7abzpF98IO+jdCubpMCxCKCynarNdWIpn
         4Tvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786587060; x=1787191860;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9Rp5SLXgfrCQhmh0UUbqTofIr9miP1ABO7B+OUhWdvU=;
        b=U3nqXtmejbDyzttM0b6FRkDswzlaj7H9MDjHtLlLWvMkzzkOFffzUZe5Svgb156vad
         68TZUmBhGc+fLA/C9iliiKrykAcfx5P3GYMNsZmTnL19F3AI1sdqjq/CQ3QJjiboaJv8
         4C3WNJWwW6MtOpHUspYtxkb1IgfXas8xhZgCxx7fSUvs/O/ynYqLqxlRxG4FZGPSEe+5
         SYnRWDtuVTsaIIWrX6ZA9WoGKw90e1Avq48xg9Qbgkr0gZjGBDTQ8QPcUh4Dj7JBL+x6
         BdeR1uUPqJ4JmRSZ7YirJRPDHAbeUrzn8mQQvo0F+4OdUeWkRDDYkjQ6k+A2i+86GVma
         gTAA==
X-Forwarded-Encrypted: i=1; AHgh+RqPsWdF0CIp8bvOdBp5tZQwXINoXhCbnQBygK5k2+ZkmxWIAFvLok/nxfatgfZN+C/yxG/NrSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXEfbvl194C0DYPr1L8WOOuzQQIi6QCV0ZtnjvraNAHJf5xv7w
	1flgkuxdRFhDfSbLU7ycSvnimv9tdngHkcHjEqesrYutQaeFKCJ7FswuTvoUMrUpKItJCuKicae
	Gyd9wCTeLKjbr01zlVywyAV/8T1gRHEo=
X-Gm-Gg: AR+sD137eII30GBTMJwhZfMhKBWpZoG16EJIjQ93VxrtTfizEJZu/rowO/tnE8yngVz
	QEKgAyiYOl1+ugTB2Bwil6bVDE1UUh9UaI3T31uUr+R6cmJMDl9M7W65K6NGLMspxFJzpxib2+z
	MspWVkiRfxR47UDgf3Z5wyzDOZJC5tlB63V5p4mckgSsnm/2faGp3IduP9U67plZFipQ2JbZNIK
	M9kz6ACeaAyqvcY9GIi2USMTnUmSs7D3SBzxsp/iBLMKtCPAZByCKzWAafuodzib5TAjJ6tDNPu
	rTGtrjZkwFhVo7RdZ91OItLUOGjuO1mN6ZX/mthXh4LyAn1EogFnWlGMNJU=
X-Received: by 2002:a05:690c:4382:b0:81e:6cd1:5322 with SMTP id
 00721157ae682-8347410554cmr9789827b3.20.1786587060367; Wed, 12 Aug 2026
 19:11:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260808135025.2872956-1-lgs201920130244@gmail.com> <anx91vwww0TMjLn8@sobremesa>
In-Reply-To: <anx91vwww0TMjLn8@sobremesa>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Thu, 13 Aug 2026 10:10:49 +0800
X-Gm-Features: AUfX_mxdPMQKUM5spWc1_tbZcR93BbRrOrNtf5zkfvwbqCalbIw3eawOEzoR4Pw
Message-ID: <CANUHTR9Xneqaa7FvdKmwuBfKiBuj2nE+nOXOxuR_cJYjExiemQ@mail.gmail.com>
Subject: Re: [PATCH] drm/panfrost: fix autosuspend cleanup during teardown
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, Rob Herring <robh@kernel.org>, 
	Steven Price <steven.price@arm.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt <eric@anholt.net>, 
	"Marty E. Plummer" <hanetzer@startmail.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Adrian,

On Wed, 12 Aug 2026 at 22:35, Adri=C3=A1n Larumbe
<adrian.larumbe@collabora.com> wrote:
>
> Hi Guangshuo,
>
> Recently I've been working on a patch series that addresses PM refcnt imb=
alances in Panfrost.
> One of the fixes introduces devm_pm_runtime_enable(), so manually calling=
 pm_runtime_dont_use_autosuspend()
> is no longer necessary like you mentioned in the commit message.
>
> However, there might be a point in using it during device teardown and pr=
obe error just like Panthor does,
> becasue it doesn't make sense to postpone suspension when the device is g=
oing away.
>
> Anyway, you can have a look at it here:
> https://lore.kernel.org/r/20260811-claude-fixes-v5-0-3d692c9e98c2@collabo=
ra.com
>
> I was thinking, I'll let you know when I've v6 ready and then you could r=
ebase this patch onto it
> before I submit the series to the ML so that I can send them all together=
?
>
> Kind Regards,
> Adrian
>
> On 08.08.2026 21:50, Guangshuo Li wrote:
> > panfrost_probe() calls pm_runtime_use_autosuspend(), but neither the
> > probe error path nor panfrost_remove() calls the matching
> > pm_runtime_dont_use_autosuspend() during teardown.
> >
> > If the autosuspend delay is set to a negative value while autosuspend
> > is enabled, the runtime PM core increments usage_count to prevent
> > runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
> > during teardown, this reference is not dropped.
> >
> > The documentation for pm_runtime_use_autosuspend() also notes that it
> > is important to undo it with pm_runtime_dont_use_autosuspend() at
> > driver exit time, unless runtime PM was initially enabled with
> > devm_pm_runtime_enable().
> >
> > Add the missing pm_runtime_dont_use_autosuspend() calls to both the
> > probe failure and device removal paths.
> >
> > This issue was found by manual code inspection.
> >
> > Fixes: f3ba91228e8e ("drm/panfrost: Add initial panfrost driver")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
> >  drivers/gpu/drm/panfrost/panfrost_drv.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/=
panfrost/panfrost_drv.c
> > index 784e36d72c2b..007dcba62e62 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> > @@ -1011,6 +1011,7 @@ static int panfrost_probe(struct platform_device =
*pdev)
> >  err_out2:
> >       drm_dev_unregister(&pfdev->base);
> >  err_out1:
> > +     pm_runtime_dont_use_autosuspend(pfdev->base.dev);
> >       pm_runtime_disable(pfdev->base.dev);
> >       panfrost_device_fini(pfdev);
> >       pm_runtime_set_suspended(pfdev->base.dev);
> > @@ -1025,6 +1026,7 @@ static void panfrost_remove(struct platform_devic=
e *pdev)
> >       drm_dev_unregister(&pfdev->base);
> >       panfrost_gem_shrinker_cleanup(&pfdev->base);
> >
> > +     pm_runtime_dont_use_autosuspend(pfdev->base.dev);
> >       pm_runtime_get_sync(pfdev->base.dev);
> >       pm_runtime_disable(pfdev->base.dev);
> >       panfrost_device_fini(pfdev);
> > --
> > 2.43.0
>
> Adrian Larumbe

Sure, I=E2=80=99d be glad to do that. Please let me know when v6 is ready, =
and
I=E2=80=99ll rebase my patch on top of it.

Best regards,
Guangshuo
