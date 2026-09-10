Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C13B1F2B8D
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 00:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788999358; cv=pass; b=QuizWW+y+2Bzw5RaDW07U/QkXJAfWSXxi8Ur/VqRlypYrpJjotvFMC9LFbMWBsWkdbn/IyE1P51cziPzRnlkLTYET5+mvw9W17POpEdtr3vG6z/OG4JaUKGWeq059oOklgE0ltyOcV0atLSA+wN5Nyl9xr7VuU7yEEiygzie7R8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788999358; c=relaxed/simple;
	bh=pUXe9tdY/xidEsS7z54mE74UBbWpWJ3gJkslB8Y4YN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pf/yuxJ6c0118faqQGzjhu7ZkDBjh+Ko9qsxMlGel79prRp8AIkUUUa/QSeIZSQ8fWbDSF7XAzutfgCAZ+kbGr7hqiu4e8JvkMNQvy0zrEbBPWXgS2GRrY6f0++6HedEPi2zvLkriMWIMMci8yGb/gmX2TgOtn8n2IBoT1xpnNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fireburn.co.uk; spf=none smtp.mailfrom=fireburn.co.uk; dkim=pass (2048-bit key) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b=O7/qIt+p; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fireburn.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fireburn.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="O7/qIt+p"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-66cf1f9965dso5540647d50.1
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 17:15:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788999351; cv=none;
        d=google.com; s=arc-20260327;
        b=fiVMUUPF32hEybUCvlPIq7Cjf0NTV5RlOG7reKnsoeGv6+ID4b0yVziIYncdZB7zgw
         16clE6GqfJHdtBG+SDU0hrc13r9ybfPnhft16IQXsg4amVGpiUN71uG7uqXVvDz5MpjJ
         LlMRHHhou/iUaSjWn8sRwSReKWHDEgImRa2/Z5ZcI/D3K3xU76XnPEELT3Zb1AIYB3qe
         lVozH4PLODhlCM1oFK1pmXTQObZOPUDUzHAK4fUzS3IADMU87frt++t9z9F3dfTwxiWB
         2uVe0KBTQVXQnHiLgRmLZoXe/NLsvdq1cxEcdle9SXznsYiWtfx7eyk9I8Bd9/hoC9J5
         s5aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FvfvgvsvTpdSimDtmvjd17d26cDmGGfX/zCh5Oy0Suw=;
        fh=1jenXw5OzxWVRnlS663fueDDBc6PNPTeUN3bAC3zK3E=;
        b=doFYAcQaUtIE0dNKkoTqINa0OadcVC7MqKL9OhECX0JfzS6u/vjclb1Nqpd6F2uCp/
         W2BQYvRiJWslVqqqsoQiptW9M44iizqOWVCW0wjuRolMzHzLBjKinSdallNcSul79Lzd
         M4BcCAxtLZTgjxKpUi3tRJi0Dilinfy1y+O05EWz25gDp1YFLifnUqwdN68JvP3C9tPQ
         kEhfFgyYmBLb2CrdO5TXk3l4lUU34Phb/3xvm7RkR6WtdIe4uyHiTBwW1P9R/e3C8B0S
         j9KJBBdsePAHLaBp2bd5QDRea5XXCvXUF1Fi807Riv6pHo2B/C4DNsCXwcgb8F71IXiI
         3k0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1788999351; x=1789604151; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FvfvgvsvTpdSimDtmvjd17d26cDmGGfX/zCh5Oy0Suw=;
        b=O7/qIt+ppctmCouSZtuEsqk80fl2KiSCRvUhCEwQ9k2w3Wx7vhlqP2pP7sQWkcLzxp
         HantIXs9Netx2ZRa1+S148XgcCju3QlEhr+hnKHrAiKVzsPliL9tj+nXUe7UDLZwc4ts
         /zTZ1mtGQ7MSWJGXoqVvUU7sEyOY4+b0sY3nRStd+sAO6kl476YqDp8csbeU4acEF6JE
         eFFBrDD9ewMKeH01iJtVxcNZBhyKMiM6Di84ZCniVDoul9fJeXhDJE9Hafd7vaGdQmio
         /lfo9MO3CLA1AvgzAwq/FSw0gXdPd9USwO8VL228IHjA6zrgj2jdWMEuL78Kh7qSo8wM
         Xhvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788999351; x=1789604151;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FvfvgvsvTpdSimDtmvjd17d26cDmGGfX/zCh5Oy0Suw=;
        b=mSNBjOGhawYMyOexRBKPsXNk/aiX8DCBV1BQ/myDaTrImmJCsm7YQS1YebMJD2bN7K
         JRh+8TyR4t0goNKby/wPa1SH5wZu8QKQaGEm/FVA54AbNtrFj9e57IJZMTRSqSyhB1d1
         Nx7BqAcyULGW2dB4MmstQlcxLJM91LLOXRIp2x3rM0vC0VH4TiargE/qAwhh5n0LT4LD
         4sSOuqHn/0l45HZOBP082M0nbgAle9lF1+3ybHgUmbpVL2u/2e4GhNVdHQV2uJoGHash
         qkbHJZuJIawxeHHK3yGCvrPcNHBzlgkgQLRDV3MsTQAV+YuK1vY0o77YtyeDtcMNnte2
         00vA==
X-Forwarded-Encrypted: i=1; AKwUvBy17ALbfdYOY33LuGW4PZZF2r2FS9O0aCNpOW54t0U6npvv10zxJuUoE78Sl0hiZflSMglpu5k=@vger.kernel.org
X-Gm-Message-State: AFuF++mTYdY7uDRlc3asx8vB7Mp08yrG2R9LE2KW9ums5zfY1WFnbhqS
	yKKFK+fJPLmiVVmxw5wiGGqfXjlz2UrXUkXCraIO0et/pDZt3uIr2eBAdqSygVkif9mHVgn3nkD
	6SB3jaMFF6ZmXfrSRA7A9HTqM2byepgk2MXkeB/6s
X-Gm-Gg: AYBFou3Y3rtRwCUeiexCiyfxAUQB99Mf1upZLZ09B2CdqrPe4CXMnV6VWMPpNOfHHK8
	TC4m9f37SuTSgw0BFKLT8qKr+NNJTWAEIrt3o938EDiwxfFMYIR++8NbokrFOYwJU9qWx9JcRIL
	bWo9JALpNDTjYdO7+racwpdsBKv2dhrQ6jBGl2wrhjC/hK7hozJb/jKHaeHvDslv9ZrY2kfQYgN
	3/xS3Srmp6n9ZoK0uHNO07zxmPKODBvUCz55rjoghCwUxs4IK5e61oTNL9LLkfeIRPoeiHVgEeD
	ortbmbUNkQqG+1AQs0NI+dhrk+VMrnbDp2B+MrnFPtKQvrmZRO88S5DGq2cmhtQENBy918+3XRy
	2PdcqpCS92kOZ/COQ56QauPsuDnjxRWHT+ycbtHZrZYQ/Hw==
X-Received: by 2002:a05:690e:2006:b0:66f:c1bc:4035 with SMTP id
 956f58d0204a3-66fc1bc4670mr8352460d50.98.1788999351127; Wed, 09 Sep 2026
 17:15:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909020854.58462-1-mike@fireburn.co.uk> <20260909094609.1541-1-mike@fireburn.co.uk>
 <e63d8ae9-f102-424f-88a5-0fd6837d79d4@amd.com>
In-Reply-To: <e63d8ae9-f102-424f-88a5-0fd6837d79d4@amd.com>
From: Mike Lothian <mike@fireburn.co.uk>
Date: Thu, 10 Sep 2026 01:15:39 +0100
X-Gm-Features: AcwNN1XQBCK9-NYAn3J4DkDrAeUXfHy9OxsiStI2D5iE6i7vvIKZ7yAdxs_R1EA
Message-ID: <CAHbf0-HAGCLcH2ryR6dgaTwMEjOgqbFFnzMUge-s1LZtjTohjA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: don't migrate a dma-buf into VRAM while
 runtime suspended
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
	kevinyang.wang@amd.com, dri-devel@lists.freedesktop.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 9 Sept 2026 at 13:46, Christian K=C3=B6nig <christian.koenig@amd.co=
m> wrote:
>
> On 9/9/26 11:46, Mike Lothian wrote:
> > amdgpu_dma_buf_map() adds VRAM to the allowed domains for a peer2peer
> > attachment, so ttm_bo_validate() can migrate the buffer from GTT into
> > VRAM.  While the exporting device is runtime suspended its SDMA rings
> > are down and the move fails:
> >
> >   amdgpu: Move buffer fallback to memcpy unavailable
> >
> > An importer on a second GPU reaches this holding no runtime PM
> > reference on the exporter, e.g. a compositor on the APU submitting a
> > frame that references a buffer exported by an idle dGPU:
> >
> >   amdgpu_cs_ioctl -> amdgpu_cs_parser_bos -> amdgpu_cs_bo_validate
> >     -> ttm_bo_validate -> amdgpu_bo_move -> dma_buf_map_attachment
> >       -> amdgpu_dma_buf_map -> ttm_bo_validate -> amdgpu_bo_move
> >
> > Only migrate into VRAM while holding the exporter awake.
> > pm_runtime_get_if_active() takes a reference only when the device is
> > already active and never resumes it, so it cannot deadlock against the
> > reservation held across these callbacks.  That deadlock is why
> > commit 030631e97b20 ("drm/amdgpu: revert "take runtime pm reference
> > when we attach a buffer" v2") removed the pm_runtime_get_sync() from
> > the attach callback.
> >
> > If the device is suspended or suspending the buffer stays in GTT, which
> > remains accessible while the GPU is powered down.  A negative return
> > means runtime PM is disabled, so the device cannot suspend and VRAM
> > stays usable.
>
> That is a good catch, but your bug explanation as well as the solution st=
ill look a bit questionable to me.
> > Fixes: 030631e97b20 ("drm/amdgpu: revert "take runtime pm reference whe=
n we attach a buffer" v2")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
> > Assisted-by: Claude:Opus-5 [Claude Code]
> > ---
> >
> > v2: hold the exporter with pm_runtime_get_if_active() across the
> >     validate instead of testing adev->mman.buffer_funcs_enabled.  The
> >     v1 check was racy - the device could suspend between the test and
> >     ttm_bo_validate(), so amdgpu_bo_move() could still see the rings
> >     torn down.  Reported by Sashiko AI review.
> >
> > Is this the failure that commit c52feb436539 ("drm/amdgpu: Disable
> > runtime PM for externally attached dGPUs") was working around?  That
> > commit explains how to detect external attachment but not what breaks,
> > so I can't tell which.
> >
> > If it is the same thing, could the pci_is_thunderbolt_attached() ||
> > dev_is_removable() check there be narrowed or dropped on top of this,
> > so eGPU users keep runtime PM?
> >
> > I can't test that here: this box hits the bug by missing that check.
> > The dGPU is on an oculink port off a native AMD root port, so
> > pci_is_thunderbolt_attached() is false, dev_is_removable() is empty,
> > and runtime PM stays enabled.
> >
> > Reproduced on a HawkPoint APU [1002:1900] driving the display with a
> > Navi 48 [Radeon AI PRO R9700] [1002:7551] on oculink for render
> > offload.  Without the patch kwin_wayland hits the call chain above
> > within a minute of the dGPU autosuspending and the desktop stops
> > repainting until it resumes.
>
> That sounds like there is also a bug in kwin as well.
>
> The GPU can only go into suspend when the rendering application closes it=
 driver connection and that usually only happens when it terminates

Not any more. amdgpu_driver_open_kms() does pm_runtime_get_sync() on
entry and pm_runtime_put_autosuspend() at the pm_put: label on every
path including success, so an open fd holds no reference.
amdgpu_driver_postclose_kms() is the same shape. I see the dGPU
autosuspend with the client's render node still open

> So question is here why is kwin still having that imported DMA-buf as nec=
essary resource for the rendering?

Because it is the content of a mapped window. kwin composites on the
APU and samples the buffer the client rendered on the dGPU. In 6.7.5
EglDisplay::importBufferAsImage() (src/opengl/egldisplay.cpp:395)
caches the EGLImage per GraphicsBuffer and drops it when the buffer is
destroyed, so the attach happens once, not per frame. The client can
then idle for minutes with the window still on screen

> But we still need to fix this properly in the kernel anyway to avoid havi=
ng a deny of service.
>
> >
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 16 ++++++++++++++--
> >  1 file changed, 14 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_dma_buf.c
> > index b33c300e26e2..c89846f266d3 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> > @@ -43,6 +43,7 @@
> >  #include <linux/dma-buf.h>
> >  #include <linux/dma-fence-array.h>
> >  #include <linux/pci-p2pdma.h>
> > +#include <linux/pm_runtime.h>
> >
> >  static const struct dma_buf_attach_ops amdgpu_dma_buf_attach_ops;
> >
> > @@ -189,14 +190,25 @@ static struct sg_table *amdgpu_dma_buf_map(struct=
 dma_buf_attachment *attach,
> >               /* move buffer into GTT or VRAM */
> >               struct ttm_operation_ctx ctx =3D { false, false };
> >               unsigned int domains =3D AMDGPU_GEM_DOMAIN_GTT;
> > +             int pm_ref =3D 0;
> >
> >               if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM &&
> >                   attach->peer2peer) {
> > -                     bo->flags |=3D AMDGPU_GEM_CREATE_CPU_ACCESS_REQUI=
RED;
> > -                     domains |=3D AMDGPU_GEM_DOMAIN_VRAM;
> > +                     /*
> > +                      * Only migrate into VRAM while the exporter is h=
eld
> > +                      * awake.  A negative return means runtime PM is
> > +                      * disabled, so it cannot suspend either.
> > +                      */
>
> Setting AMDGPU_GEM_DOMAIN_VRAM doesn't automatically migrate the BO, it j=
ust sets this as possible placement.

Not on this path. amdgpu_bo_placement_from_domain() marks GTT
TTM_PL_FLAG_FALLBACK when preferred_domains has VRAM and we are not an
APU, which is exactly when amdgpu_dma_buf_map() adds VRAM.
ttm_resource_compatible() skips fallback placements when not evicting,
so a BO in GTT is not compatible and ttm_bo_validate() migrates it

A WARN_ONCE on the failing branch gives old=3DTTM_PL_TT new=3DTTM_PL_VRAM
with amdgpu_dma_buf_map -> ttm_bo_validate -> amdgpu_bo_move in the
backtrace

> BO migration is only triggered if the BO is swapped out or similar. What =
most likely happens instead is that we suspend while something is still ong=
oing.
>
> But anyway the problem goes deeper than just the amdgpu_dma_buf_map() cal=
lback.
>
> We have picked up pinning DMA-buf to VRAM for RDMA without ODP (e.g. exac=
tly the feature I mention in the commit message of c52feb436539), but faile=
d to correctly fix the PM handling.
>
> So we really need to call pm_runtime_get_if_active() in amdgpu_dma_buf_at=
tach() and fail to let some other driver attach if the device is already su=
spended.

Happy to do that. Which behaviour do you want when it returns 0?

Failing the attach breaks render offload. The attachment lives as long
as the buffer, so a client allocating a new one while the dGPU is idle
gets a failed import and kwin has no texture for that window

Holding the reference until detach keeps offload working, but pins the
dGPU awake for as long as any of its buffers are imported, which in
practice is the whole session

Note the importer here is amdgpu on both ends, so "some other driver"
would not cover this case

Cheers

Mike

> Regards,
> Christian.
>
> > +                     pm_ref =3D pm_runtime_get_if_active(adev_to_drm(a=
dev)->dev);
> > +                     if (pm_ref) {
> > +                             bo->flags |=3D AMDGPU_GEM_CREATE_CPU_ACCE=
SS_REQUIRED;
> > +                             domains |=3D AMDGPU_GEM_DOMAIN_VRAM;
> > +                     }
> >               }
> >               amdgpu_bo_placement_from_domain(bo, domains);
> >               r =3D ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> > +             if (pm_ref > 0)
> > +                     pm_runtime_put_autosuspend(adev_to_drm(adev)->dev=
);
> >               if (r)
> >                       return ERR_PTR(r);
> >       }
>
