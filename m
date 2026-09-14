Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B23D479889
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 14:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789395130; cv=pass; b=oHarFjzL59W1olz+2F9DO7FILTB78ZY5zeuB8T+aa/2WyJrxeGjA2jvAKg1ND67NFMj8zGfj4LnyyNWE2fSO9JXBmRUljnU+C6AFDDFc2TfP9z3NeAnRunI43p/EA0ms+CsDAwyn/dagl0shFAD6Empu6wPpJuPHkavHfgw/nQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789395130; c=relaxed/simple;
	bh=4pN0CDodMfXA+VKJHtdvsSb+s2gvOb7Y/l6K97ztPgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h4JEaM/84+XbH1eqh7ni5sTBORF6xi/0YEwlX3wOameRoNVEWVpiU81VlVd0foWtthnaFvfoQxyp+I7SUf36Sl0Z1JZAPYo/OJKGywqsWl48S7mlFjKiYKKgPBMaPxbAPLQnb24ou7vbww4JL8X7G9mjMmSIPnFh3hBsAYFQrGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A972dTKv; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A972dTKv"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1ab17a810so146281a12.0
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 07:12:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789395116; cv=none;
        d=google.com; s=arc-20260327;
        b=ECRne97tMEWfFfmE7pTyc7nhjSJFyopF7sDVVBUGVANdRhIRQVYz285bg9dG+yxQt9
         ydByvNNVDzf5w97321Lr7r5lb6HvP7jx/HLSdsnRfBUlP0sAI+MI3l4w+TBBndEaKcBt
         ZE89VpfXGczCy47xjPQ+dwrpCYTXY2ALY0Foh/uvPkDjJbn0WfrNu/VWLCYvmYJ7UFSc
         SUOm8rIq4vW3h8OiOW1iKJcsqD+E/jcatGgbdcNE44rzameKC2gnBr3t6kdxtJkKlumt
         NFhfK/4s3vV8WV55B46xuSvNOLG5o5qwCP5+TI2ld0IfWuvKtvRilbVCrakNsbbBdd8e
         RO8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4rj/r25LyFLXL2H83H1Ljh+5fD7NhfkZssLHdM2663E=;
        fh=U8asxnXqmpIslzX+fIn/8NrX8/BaOUMFXqR9GlKW1aM=;
        b=bDSOZeaFVTfulJGllKNdWH7XcP2HXr0Sb9/uKTclckhw4H+QdZLpTBE3aDHzbaB3LG
         wRkZsBkLGIctswC4XdY8WnbaVIwDwrxai5ruDKKGv84Pq/v/A6XCC7uTKswCjA6sVzTZ
         xawHn0E9PpxGkykxcs3dCJpFHOOHHBrQMwizobw90xRyRfen2GamMywIgEuF4E41ad+Z
         e8ejhcVt0J4317Nyj9IuAmDtiyUj9BY1wU1QV6VQ4+uwVSFQnwQWnyve0HMVcq2339iq
         LbLtKUMWhjGNDi421CuCZNo3RR+MO9hMfSO2x1T/Cz4VFMT4SrZdRaCpxiKIy0PRAKzs
         KdqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789395116; x=1789999916; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4rj/r25LyFLXL2H83H1Ljh+5fD7NhfkZssLHdM2663E=;
        b=A972dTKv3Ad0bHaGP9Do8u4335ZmKhs7+vJsOl1/1JoyuTN9CuIGEUdaZBNBXzeVhC
         1vVY0IM1M/Qh51H3xCULj3bxCwVFcp1Yo90myIDkUwvjbXbH/CEtpPT+zerU+PYy2rLw
         oQgQ6FyO+wb3LoTtrsowrsLb7T1W1pneX0s/KoQL0JI0qahjzo2aPCmzHNFhCs0/8r8b
         kOhodnGpur9TWxMRHIRk203aT6H662Ey2tn324FNATdxQY6nbRh0c1NL7jOA45TcnNCp
         UxuqGaLVDe4ih9yw2T1XZU5HvoxvJiDuHOsYAAEZiMXTen+aPcyDqG1WWgzwOibpE7fl
         UJtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789395116; x=1789999916;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4rj/r25LyFLXL2H83H1Ljh+5fD7NhfkZssLHdM2663E=;
        b=RstzMknIHSGKHAUTvNeKUWNf0u03zleMCTZMdIn0WuoJIcUOTTFIAg0AdxvV+JYB7p
         e7e8J8stBaAF9+5KyeEr59mbrXiXSOXcyItktZSS1L2eZeb5l32StAuQcZyu6vFtOD2E
         5+Sy4wkCx86IT+o6upn3mCxcarnrwV3zX6+cSFtC90zQDJtl/AY3NMqFHMNW27wI8TiZ
         Rf6dGMXuJKHSXDJvzK757TpQmA3p1jbRV7d3YFiNBcB5LBAvGM/MjJPryXSMiSIw2jaf
         W4tlnRBSFmvOfaCQ7puBMGwndJIWxjJRwmBvh2Z6Mk59YUhcTtEbf1ta+98Rpj8h+Ld0
         MNlw==
X-Forwarded-Encrypted: i=1; AKwUvBzA8DbRRCs0IFYlUnE5isBpKcUvWl+cqWYLalLomPnVqO0NSJKBEi6XTyw0z7itCwDTxpqxZlk=@vger.kernel.org
X-Gm-Message-State: AFuF++lxSKMBAD7qqFXuSjaY+sInFsGiLuNcTSb3ooZ4YUN8d/sE9rSn
	56ZzoK3+ItsNlc9aQrv//YzyliNvOw4RcbCNutwIBejXApkm3vCS1xJv5N8P0G+rgXmex9g+tBM
	NXwvracq+mkFl8jc1A/qSbZi/gjEaAok=
X-Gm-Gg: AYBFou0YyoHPY2dGuPng/dcOnjKvtEErPA6gw62s+KEUNBI8MUr+aBEoTQUrwYu69B8
	BnYi1DtR8La6dXc59zrs+mNcGkjWAmrga7KeJ1nyASa8bd+eDXXh8QL7aN7E3E1V0YNWIO6xODT
	/LBZPoR39nPDDNWgNayV8a+J3p84Vz4gdT0GRb3b5992eLpqavM21zKelzq7Z9AfKxnpb1K9psn
	G8xWJ/iXR9Z1+s1EUInjWJB3fvAOUd3A0fFpLlf8V0ZPtXoPE1Djfcx95qj72x2QLRXKlYnMEi9
	5O+aGudcIx3tz+UB6iKoOUfQpMybh7RnNgbT4ZJwjP5adF6x0mzz22wL6KWYtCvohG9qqtmRXFV
	/XaKIbDR7AAVmvfGb//GsnLDd05ufWADXqFjR78/tPg==
X-Received: by 2002:a17:90b:390f:b0:38e:76f8:fcbb with SMTP id
 98e67ed59e1d1-39dec1aa1cbmr3754762a91.4.1789395116294; Mon, 14 Sep 2026
 07:11:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <358a518d-1490-40ba-bbe3-7f3696c1d696@amd.com> <20260911183825.935140-1-mike@fireburn.co.uk>
 <afb6cf0f-ca0b-4fb9-b7f7-2355ed45386c@amd.com>
In-Reply-To: <afb6cf0f-ca0b-4fb9-b7f7-2355ed45386c@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 14 Sep 2026 10:11:44 -0400
X-Gm-Features: AcwNN1VTuk_e5gAg5i1SrKs6UFcqZjBHCJ6WW0AE0n88d1R64cVdkQO01fkBy4Y
Message-ID: <CADnq5_Ngcrfh4m5fHs4R-S8kRHVf-9qT1_wPwBcV6OsXfigDrA@mail.gmail.com>
Subject: Re: [PATCH v3] drm/amdgpu: hold a runtime PM reference for P2P
 dma-buf attachments
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Mike Lothian <mike@fireburn.co.uk>, amd-gfx@lists.freedesktop.org, 
	alexander.deucher@amd.com, kevinyang.wang@amd.com, 
	dri-devel@lists.freedesktop.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

On Mon, Sep 14, 2026 at 6:51=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 9/11/26 20:38, Mike Lothian wrote:
> > amdgpu_dma_buf_map() adds VRAM to the allowed domains for a peer2peer
> > attachment.  GTT is only a fallback placement when VRAM is preferred, s=
o
> > ttm_bo_validate() migrates the buffer from GTT into VRAM.  While the
> > exporting device is runtime suspended its SDMA rings are down and the
> > move fails:
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
> > Pinning a dma-buf into VRAM has the same requirement, which
> > commit 030631e97b20 ("drm/amdgpu: revert "take runtime pm reference
> > when we attach a buffer" v2") called out as the one case that would
> > need the reference back.
> >
> > Take it in attach and drop it in detach.  pm_runtime_get_if_active()
> > never resumes the device, so it cannot deadlock against the reservation
> > taken during resume, which is why the old pm_runtime_get_sync() had to
> > go.  If the device is not active, clear peer2peer instead: the buffer
> > then stays in GTT, which remains accessible while the GPU is powered
> > down.
> >
> > Fixes: 030631e97b20 ("drm/amdgpu: revert "take runtime pm reference whe=
n we attach a buffer" v2")
> > Cc: stable@vger.kernel.org
> > Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
> > Assisted-by: Claude:Opus-5 [Claude Code]
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> >
> > v3: take the reference in attach and drop it in detach, clearing
> >     peer2peer when the device is not active, as suggested by Christian.
> >     v2 only covered amdgpu_dma_buf_map() and left VRAM pinning exposed.
> > v2: use pm_runtime_get_if_active() instead of testing
> >     adev->mman.buffer_funcs_enabled, which was racy against a
> >     concurrent suspend.  Reported by Sashiko AI review.
> >
> > Reproduced on a HawkPoint APU [1002:1900] driving the display with a
> > Navi 48 [Radeon AI PRO R9700] [1002:7551] on oculink for render
> > offload.  Without the patch kwin_wayland hits the call chain above
> > within a minute of the dGPU autosuspending and the desktop stops
> > repainting until it resumes.
> >
> > Tested with v3: Chromium rendering on the dGPU and composited by kwin
> > 6.7.5 for five minutes, then closed.  The dGPU stayed active while the
> > window was on screen and suspended six seconds after Chromium exited,
> > with no fallback errors or runtime PM usage count underflows.  After
> > an hour of yuzu render offload the dGPU also suspended once yuzu
> > exited.
> >
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 39 ++++++++++++++++++++-
> >  1 file changed, 38 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_dma_buf.c
> > index b33c300e26e2..fae695c3e531 100644
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
> > @@ -100,15 +101,50 @@ static int amdgpu_dma_buf_attach(struct dma_buf *=
dmabuf,
> >           pci_p2pdma_distance(adev->pdev, attach->dev, false) < 0)
> >               attach->peer2peer =3D false;
> >
> > +     /*
> > +      * P2P access needs the exporter awake for the lifetime of the
> > +      * attachment.  pm_runtime_get_if_active() never resumes the devi=
ce,
> > +      * so it cannot deadlock against the reservation taken during res=
ume.
> > +      * A negative return means runtime PM is disabled and the device
> > +      * cannot suspend, in which case the put in detach is a no-op.
> > +      */
> > +     if (attach->peer2peer &&
> > +         !pm_runtime_get_if_active(adev_to_drm(adev)->dev))
> > +             attach->peer2peer =3D false;
> > +
> >       r =3D dma_resv_lock(bo->tbo.base.resv, NULL);
> >       if (r)
> > -             return r;
> > +             goto err_pm_put;
> >
> >       amdgpu_vm_bo_update_shared(bo);
> >
> >       dma_resv_unlock(bo->tbo.base.resv);
> >
> >       return 0;
> > +
> > +err_pm_put:
> > +     if (attach->peer2peer)
> > +             pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> > +     return r;
> > +}
> > +
> > +/**
> > + * amdgpu_dma_buf_detach - &dma_buf_ops.detach implementation
> > + *
> > + * @dmabuf: DMA-buf where we remove the attachment from
> > + * @attach: the attachment to remove
> > + *
> > + * Drop the runtime PM reference taken in amdgpu_dma_buf_attach().
> > + */
> > +static void amdgpu_dma_buf_detach(struct dma_buf *dmabuf,
> > +                               struct dma_buf_attachment *attach)
> > +{
> > +     struct drm_gem_object *obj =3D dmabuf->priv;
> > +     struct amdgpu_bo *bo =3D gem_to_amdgpu_bo(obj);
> > +     struct amdgpu_device *adev =3D amdgpu_ttm_adev(bo->tbo.bdev);
> > +
> > +     if (attach->peer2peer)
> > +             pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> >  }
> >
> >  /**
> > @@ -350,6 +386,7 @@ static void amdgpu_dma_buf_vunmap(struct dma_buf *d=
ma_buf, struct iosys_map *map
> >
> >  const struct dma_buf_ops amdgpu_dmabuf_ops =3D {
> >       .attach =3D amdgpu_dma_buf_attach,
> > +     .detach =3D amdgpu_dma_buf_detach,
> >       .pin =3D amdgpu_dma_buf_pin,
> >       .unpin =3D amdgpu_dma_buf_unpin,
> >       .map_dma_buf =3D amdgpu_dma_buf_map,
>
