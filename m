Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73499374A12
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 19:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786563704; cv=pass; b=B3mY6N1l1ey7hraOjLNlHhB0SOoU2SeNz6W1Vsy/gAaBHNv1AQ6Qgy2sqBJECi0zO16iBXxy47XGlzQBOwD0uIyFvR0JPRB/DSgGZa8IYxHzfdmM4X9aslM+fDt+YPAT8U8SsUEvcbf5CqzJcFjB1kE/JPOXuUl0+qEPsKgdPVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786563704; c=relaxed/simple;
	bh=qFkapwlUeNkDTMk95pSQIT9bP2NrspHubiH7G7ZvmCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ooI9iejqxSPnxl45mGcCKm8TxXqnIczOn3dSq+Y5BT448R8u+aNNgmHRsHcOKHTdz3A45kHK2PrR+ufsHNTJUayTmlrOtKC4TH5dUST/T8iD0aDvmL0XxXkpCi6rxPSxyNSCoE3icXaTsgQWdoSkL7dizMmK3wE7YaZPE+HjONI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ba5mG3Rw; arc=pass smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ba5mG3Rw"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3856d4015e0so268597a91.2
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 12:41:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786563703; cv=none;
        d=google.com; s=arc-20260327;
        b=JhvtezLASM8A74FvaRZ/ot3EwH12Lm3p30ErvZZrmrqSU3b/Y45WJSLMS9RbpaH2Mt
         MZJpKIaqiLbZr5ctR4kh/tbTCkOeWZoAAKId+lJmxnYpcCCjNq7XhNe61bYXhXGvywHy
         tTz6HNbDBkG2ezEMRVmXeYi5AnFGw7RTbx+eBwJvY8ptwikojEARgveSOEG1/HQRf0xr
         sitRGHjB8fAMqiWyYgXaSXsgs0pbSHt0UG7RlPVR4+PLLAJXPAZ331EGUqWfGYEMZJhx
         P4hsNJphZZLBxKxUlfsEu2nyyf0tQYrcVEekZr9p/RXOum+tBIeyLdwRUHuBABSmIkik
         J9hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mks4PzP7z/JjESfLTgfrdXVg51XLNmx3p3liUgg7Kog=;
        fh=TCcObCg7cx5eYhJKw99OyK6B3S2CmFlGup4kTW16L4Q=;
        b=dyLSZY56ZBzOkCg7NXlrsfJLn2qE5FP4clvfIzXVbeFb5XEGIXzCVwNgKjoB1iK67h
         VI22uNfq/GzQh3k7MNA5j670GQbjKZKALGfTMM7kEZyPDFsIaSwrW8LWZxL+Kujm7PtV
         iraUsiYZULpWzVreqQ3CifXVs6uMB4ooQykKKH9+CcLUByZzb8VzzAAMERq9KDO88F+2
         j7+iBn/tyvaOaLIBBq4Uwaa8hacWf5cmfP2ymmnmgoi0u2LUtCZ+Fo8QFdIFp7pCrgTm
         s85PXAUkeP0m8vqzECowdUwi8Sw7dTFyKdOX8LKvvawUkZoHaCWRfTXwebCZ/YXojgra
         jk0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786563703; x=1787168503; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mks4PzP7z/JjESfLTgfrdXVg51XLNmx3p3liUgg7Kog=;
        b=Ba5mG3RwLWBuNgWDwh+BX1k3gY+7on48xfnpdp4LsGWOR3xUnduYI2rs6vLn1vqYrX
         cg+51l0FSMMGVLDGSEgwgNnJ2/obgKGkbXfsjgeCkbHaiTnPnob3R4vWpItA7ZqRldO1
         /D+N9BhwpO0wD/q0UZdngpMpQag/I+DeGS44yoW6DMNPpZeDWBzTXPnj0RhJEsYrWgIA
         jo8ZC/1N8Ge2UMSvFhiMOhOaQiqYeXW4Xfw0AadoHCCy6CeEL3lQALbGI6lOcFAKYIGO
         yAo8B9EficvQCSltWHRRylTylhzuKMhunmcR81oZAh3AS8P4ooJ0JDD/7DSTNuo6XfKz
         vO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786563703; x=1787168503;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mks4PzP7z/JjESfLTgfrdXVg51XLNmx3p3liUgg7Kog=;
        b=JWzPgpsUPzHM2L5A4W0RMsu9dJwBp7Vb1YgMGxJlW/XBD7EFl5XNqd1mOobnuc2dVQ
         Ht6QC0bfiyI533L6sUXEenYXoSYz5r9mKDLf4Kik/yTESmzKxV9OEGtxXWbtoM7E90L+
         rVlJRCR5EE5eWXHNTiH2sLpdrJtS0YUIr/Tm9w0cCyqAp1jnENE0d+EU6PCUb25eGbrm
         3GC1G+zgEzYfeK/AvhhVFc+hPiWCLVvaETRMSduh5aFmUWWPeciMxdTr9fdaC/XtOUXm
         lVuyZ7Yd/GKrJdm1wBW7BaQzhQbjvB412+tXaDFTFRig+nlPUSkAmdxYcLyYjAQsuP87
         z29Q==
X-Forwarded-Encrypted: i=1; AHgh+RpdSMgasFaW4Xdq1DzkWdZFPMWl1Bm4agc5aTw+XBzejMGtXbxbcj347c8HmIC5GHRbt0EVN6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAsfs74i271xmfbU2/QbnGOSIAM+e8I+ehq2MwInN+0lEqBNgH
	B9Z6kuvrVl+aDy0UYHrlAYwFJy0T1NWmzfsESM+EUOQVsg8P7olYpX5Ri5c/RV82tOg1pDaSSHr
	MZbndUmGHbsPsabdQBAvWrTaTuVodwsMrDg==
X-Gm-Gg: AR+sD11CLAmb2cl112HvRNvQbzYkM0Gw3NSmbb423s//hkbr8OdTsP2igbVY2p3OOZe
	Wdu8S9rwQauTA/sX1/BnfYnkEDlabrQ/ALxBEeTDKjR3BDYA7Xps6yBzkzv2r/jMM0p6dA+ysfu
	x5RWS/ZWewY7BmtBE55SeX6Lkar4PO17Nu5//J8tjwNOyd+Ygqjn4sE0Zbw6BNjFM3kqkLE9bjU
	ow2JWSL8c5t4uZYqnO/JfeHQdrJr7rGYwERCL0HHxU+DbmWSHo65/xA0De9T2+O3M/s5BgeeQ17
	hMUqGiwfCTTN91dQbLG+av+ZSzqilGLtrlIfaoD9Skj75NEFNA+Djdes1hRmOuv4Tuq2Joi9GjA
	NR7rJEgDL4U2+llPZEhxTMMP9KyXsGiZAXX4NUbRg+Q==
X-Received: by 2002:a17:90b:4a0a:b0:381:77cd:38ca with SMTP id
 98e67ed59e1d1-3931e305cbdmr422812a91.4.1786563702713; Wed, 12 Aug 2026
 12:41:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260808120934.2813010-1-lgs201920130244@gmail.com> <a5b4bb17-db2e-4bea-ae45-7bb3c5dfdf5a@kernel.org>
In-Reply-To: <a5b4bb17-db2e-4bea-ae45-7bb3c5dfdf5a@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 12 Aug 2026 15:41:31 -0400
X-Gm-Features: AUfX_mwe2SLWRO9VELEw_R4SIZIRE_5qbm3M11P1fljWz8oDoEOEenfY1vc_vKw
Message-ID: <CADnq5_N0MVecwbKSJa9d4UFzagNzQJ4=qxGvVGFfvzDBOSMaMg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix autosuspend cleanup during removal
To: Mario Limonciello <superm1@kernel.org>
Cc: Guangshuo Li <lgs201920130244@gmail.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	=?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, 
	Ivan Lipski <ivan.lipski@amd.com>, "Jesse.Zhang" <Jesse.Zhang@amd.com>, 
	Jammy Zhou <Jammy.Zhou@amd.com>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Did this ever land?  I don't see it in ASDN.

Alex

On Mon, Aug 10, 2026 at 10:35=E2=80=AFAM Mario Limonciello <superm1@kernel.=
org> wrote:
>
> On 8/8/26 07:09, Guangshuo Li wrote:
> > amdgpu_pci_probe() calls pm_runtime_use_autosuspend(), but
> > amdgpu_pci_remove() does not call the matching
> > pm_runtime_dont_use_autosuspend().
> >
> > If the autosuspend delay is set to a negative value while autosuspend
> > is enabled, the runtime PM core increments usage_count to prevent
> > runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
> > during teardown, this reference is not dropped and usage_count remains
> > unbalanced.
> >
> > The documentation for pm_runtime_use_autosuspend() also notes that it
> > is important to undo it with pm_runtime_dont_use_autosuspend() at
> > driver exit time, unless runtime PM was initially enabled with
> > devm_pm_runtime_enable().
> >
> > Add the missing pm_runtime_dont_use_autosuspend() call to the remove
> > path.
> >
> > This issue was found by manual code inspection.
> >
> > Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
>
> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
>
> Also applied to amd-staging-drm-next.
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_drv.c
> > index 1aed121f4ddb..e814701bc8fd 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > @@ -2548,6 +2548,7 @@ amdgpu_pci_remove(struct pci_dev *pdev)
> >       if (adev->pm.rpm_mode !=3D AMDGPU_RUNPM_NONE) {
> >               pm_runtime_get_sync(dev->dev);
> >               pm_runtime_forbid(dev->dev);
> > +             pm_runtime_dont_use_autosuspend(dev->dev);
> >       }
> >
> >       amdgpu_driver_unload_kms(dev);
>
