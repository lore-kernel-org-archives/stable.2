Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB61A4915BC
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 09:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791452972; cv=pass; b=aHWsWD1ghRGUN92YsZdlCS85Gm1ZJV6vtmiryad8W+hxR00Y8jiTVYuJCs+fa9zv0/ahUvro+asZNULUSnW5WjahwRe1AmHUEbif7ViUvu6s+iRoKlF0TEYgwE8UIb5VFKIC/S4ITpGzGLU8Y7+WLeW1+a9jhctU/0c7PSn9yDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791452972; c=relaxed/simple;
	bh=vEZgv7JK3r58apMj6G4CCusnT47q0kpOsAxCp9RUDrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jR1PX+r8W+A4C7qFSbixy7mRoE/x947yTA7qufAaGy0bH9bDi+iMWzjemkhboEaaXSECr4QTq0IUjKp/tJdFTFnry05DN9d3F2kXI+Ebn7D0Nr5TQAHsezSgUEOsAw5HoJR48zOglvI8o56g8lx6+fYqy5qc9A85Ii88lRXRfo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mMxzqsxv; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMxzqsxv"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c2e7131b94eso30413666b.1
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 02:49:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791452969; cv=none;
        d=google.com; s=arc-20260327;
        b=k5mpmaFTW1KX5+LIalCdOQDvYnLrDXj8nXIXtuGgE2sr3ftqIJej1BlJr2hSKf/j++
         MS28szY2jekjD9FhC2JrrU32UVN4IFqt7VK3ztrEc3rLNS79I+7X8tjjnTVb0YIljAWo
         ysnHZmeDBOJ7Gma1ZWz4cq8wSax0l07PmSd7wW8bqDPeiyFjVCgDSLiR62Z1VzS4FBN8
         yjCXbZ7q6WGcqMfG+iANuQOu9o3CrbnnYiK9w3vUBQqWFdXwIq2JlQbtyN7z+fwGlSNP
         tb8PBAgR/NGyusPWLCQIysGidBrj7unznelLgYUN2bDoXp+l/0EqZZh5d2ukCa7UJG9Q
         qcHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kFul20M1kAj6OL6A2UXelET2OX/eEgeEYys9+x/QKks=;
        fh=4O0+BM/S6U2/QvXQHF0z8a1iSiTzrM+nYSfNGk8PDUg=;
        b=PPGmel84m9SqXUzER+p6h1djHPd1RNOPN4XuT1ZespwUfVqg15PGaIJk4zrA08Tp5H
         gFVk4dvFegu/Yt5ISAFLAS0uo9Ha0yLNMw+atsDBzvW1PruE8TgzHoxAa7b7h6AqsTUM
         8EDIkWOkyC7M+5+9KAp5c6sOvfPaEmcm/fK+r+jLMvIwUWunIFjddAe2YWaqEpshC8ok
         +l8y9ahyOrMkA/+vVo7DItHPfbera3UHcVt06+bRSINvxolruQG5a9JVFMc1RR036ng/
         Tm6NnAMPR3DdVWuMKGwE8+qdCstl8t9W/LnANiRi3UsPEbLncdV82uaFhNLX+dfMz4GA
         vvYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791452969; x=1792057769; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kFul20M1kAj6OL6A2UXelET2OX/eEgeEYys9+x/QKks=;
        b=mMxzqsxvuND3P9uUelkNQ4CeNnjfi9LON+/RQJFDHYkDoDV0BKxrcSY3uq8zuN9DH7
         wjsRprnWQ3fDRsCoOsrsgZyJo+cw5cmIBic+uWVkhsi8dDi44DiurMIzvufBiXS36oPI
         38VjkrMJLQnYchWC7CXWRESZNW0wIhmeVvVKqmfPSVSVgAYsyE4RGvvigfHPD99vsPcH
         ukZ6Jq7krgi3e40Dm2OD5f8lEH7FLZKmhT4i3VKeZ4eWtBZP/qJwxZO+DZPooxikiK7n
         VB7R6CNpKdaJrhA+nJXWrEKbS3om6d0vQcG25NK7wFh/xNIkyFPJZ5mLNqFX/P2ogLDe
         p75g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791452969; x=1792057769;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kFul20M1kAj6OL6A2UXelET2OX/eEgeEYys9+x/QKks=;
        b=R/oQg6oCWI8mViI78ISj9d02aRidfinTVm8gTfc2zTKJ8Orc/QSCW3IIi261nSF0ZD
         rXOhZaCgCQkDgrGPjlymHTfK6ThzdKB5xnE6XifGQDKARJNU/kArbq+EUVJLO8rB/QLt
         BdLk0lBrpFCkzKHoRZGztuQ/2tstuhvKsFygZN4/nJo7A5+BjxT0H0+u5sukc9ml9omB
         5GUVsu/OVt2IBeupTrNXnnvMqyNykqgjuey8h7S4Fh9Wgxz+MNEMZN02XdlrEdrfsR/5
         dQbmeAm/OqJfY29KUwkcKJfoAzoy8kNUpycETSq4loHErcBTqYUDcZ5q/IcOY4mBNgeF
         jihw==
X-Forwarded-Encrypted: i=1; AKwUvBzvLungeug18dmHxxsrFPSfmll8iiQ9lllQfUBMuqW5yIqlzJ+lvFfGX2kyuxHDaPE6NfuzcvI=@vger.kernel.org
X-Gm-Message-State: AFuF++m8o4Yl9fi3UpgZh0Mb3T4Cq4rNwOPDQtYJQlAgrfNDj2d5V8EN
	jX8VhYVaiiBhzUUoqiuWGahnd6uPFC1I5sPNo9Zco5QzPycuqFLPBK7xoX2c/V5n9sE35Yn9wSE
	EQO6CYnKptOC0r2DZLqfWP9zLrDLMcvQ=
X-Gm-Gg: AYBFou2/Qmb8yPszSqYktE2aHFQy+KLTDvBXHIpQqyZlAfkHgyl1RuBW32NOvRiGefT
	YaKaUrb4Z5XtDx8n77L+8/kyqdMZDMMDeCcrY7Ga/ENx+tmMM5O2UunUClrBlwgXl6+OhzjopaH
	X3ffK6DE4MYUk+87QJrek3ARw8I474gfgPbOnAHtq1ed35avJfiSXOuNyVoMG2cHU78rhsXvcr5
	hz+tuiQE086vKZLIryJjGSMyODC1C2pa6sXPjlygBTfnN8n52Wer/5klmBGsST59tVTWtsHSu+V
	OkzLi6lmQjMsYhlYqRbnCTyvz8BL1DOKKlFYfLoFDicZAMxJiKVK0Q==
X-Received: by 2002:a17:907:7245:b0:c25:f7dc:2dc with SMTP id
 a640c23a62f3a-c3191dec364mr163121366b.29.1791452968781; Thu, 08 Oct 2026
 02:49:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007200345.417281-1-jfisher84@gmail.com> <e14295dd-c78e-4604-ba38-5a03c8ffa7c4@amd.com>
In-Reply-To: <e14295dd-c78e-4604-ba38-5a03c8ffa7c4@amd.com>
From: John Fisher <jfisher84@gmail.com>
Date: Thu, 8 Oct 2026 22:49:17 +1300
X-Gm-Features: AclHuK-uPsqmYPJBD7A5pjJcEwjLsuclLYCy70EmQi7g3sP-Mv8C_pd3-bIpL0E
Message-ID: <CAC7wNSAWKwwkKat=rGpVQPXMdp7vLERs8X7wE=LdmBX1bL8O4Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: wait for pending page table updates before
 switching a VM to CPU updates
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
	dri-devel@lists.freedesktop.org, stable@vger.kernel.org, 
	Prike Liang <Prike.Liang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ok understood. Uninterruptible with no return value check.

Which fence should it wait on, though?

The jobs that race here are the PD/PT clears from the render node's
open, and as far as I can see their fences only end up as BOOKKEEP
fences on the root PD:
amdgpu_vm_pt_clear() commits with a NULL fence, so they never reach
vm->last_update.
Nothing else sets vm->last_update between amdgpu_vm_init() and
ACQUIRE_VM either: amdgpu_seq64_map() goes through
amdgpu_vm_bo_update(), which puts its fence in bo_va->last_pt_update
because the seq64 BO is not always valid; amdgpu_map_static_csa() only
maps; and the PDEs of the new tables stay on vm->kernel.needs_update.
So at this point vm->last_update is still the stub, and a
dma_fence_wait(vm->last_update, false) here would not close the race.

I think maybe two other ways to wait for the VM's own updates:

1. Have amdgpu_vm_pt_clear() commit with &vm->last_update instead of
NULL, and dma_fence_wait(vm->last_update, false) here before it is
dropped. The clears all go through vm->delayed, so the last one covers
the earlier ones.
2. Keep the clears as they are and wait here only for the fences on
the root PD whose owner is AMDGPU_FENCE_OWNER_VM (exporting
amdgpu_sync_get_owner() or adding a small helper to amdgpu_sync.c).


Which would you prefer, or did you have something else in mind?

I'll send a v2 once I've rerun the tests on it.

Thanks,
John


On Thu, 8 Oct 2026 at 21:13, Christian K=C3=B6nig <christian.koenig@amd.com=
> wrote:
>
> On 10/7/26 22:03, John Fisher wrote:
> > amdgpu_vm_make_compute() switches a VM from SDMA to CPU page table
> > updates when a KFD process acquires it. It syncs "with the last SDMA
> > update/clear" through amdgpu_bo_sync_wait() on the root PD, but that
> > walks the reservation with DMA_RESV_USAGE_READ, and the VM's own page
> > table jobs (the root clear from amdgpu_vm_init(), and the PD/PT clears
> > and the seq64 mapping from the render node's open) are added by
> > amdgpu_vm_sdma_commit() with DMA_RESV_USAGE_BOOKKEEP. The CPU path's ow=
n
> > waits (amdgpu_vm_cpu_update(), amdgpu_bo_kmap()) use
> > DMA_RESV_USAGE_KERNEL. None of them waits for a clear that is still
> > queued.
> >
> > When one is, the CPU writes the first entries of the new compute VM (th=
e
> > KFD trap handler's TBA/TMA page at AMDGPU_VA_RESERVED_TRAP_START, mappe=
d
> > during ACQUIRE_VM) into a page directory the SDMA then clears. The
> > entries are gone, the handler's page is unmapped, and the first wave
> > save of any queue of the process faults in the SQC instruction fetch at
> > the handler's address (GCVM_L2_PROTECTION_FAULT_STATUS 0x008012B1,
> > PERMISSION_FAULTS 0xb). The MES then fails REMOVE_QUEUE and SUSPEND, an=
d
> > the device takes a MODE1 reset with VRAM lost on 7.2.9; on 7.3-rc6 the
> > queue is reset instead.
> >
> > The window is the time between the render node's open and ACQUIRE_VM.
> > ROCr spends milliseconds there and is practically never hit; a minimal
> > KFD client that opens the render node and acquires the VM at once is hi=
t
> > most of the time. On a Radeon AI PRO R9700 (gfx1201, Resizable BAR, so
> > vm_update_mode defaults to CPU updates for compute VMs), a wave reading
> > the trap handler's page right after queue creation found it unmapped in
> > 8 of 12 runs; a 5 ms sleep between the open and ACQUIRE_VM made that 0
> > of 9, and the same sleep after queue creation instead 3 of 3.
> >
> > The wait covered these jobs until commit 926c79ad6ecd ("drm/amdgpu:
> > promote the implicit sync to the dependent read fences") narrowed
> > amdgpu_sync_resv() from DMA_RESV_USAGE_BOOKKEEP to DMA_RESV_USAGE_READ;
> > the VM's page table jobs have been added with BOOKKEEP since commit
> > 4247084057cf ("drm/amdgpu: use DMA_RESV_USAGE_BOOKKEEP v2"), so from
> > v6.16 on the sync in amdgpu_vm_make_compute() waits for nothing of
> > them.
> >
> > Wait for every fence on the root PD's reservation before switching the
> > update functions. With this the same client reads the handler 10 of 10
> > times, 8 busy queues on the 4 compute slots complete in 5 of 5 runs
> > (1 of 6 before), and two processes with 8 queues each complete together=
,
> > with no fault.
> >
> > Fixes: 926c79ad6ecd ("drm/amdgpu: promote the implicit sync to the depe=
ndent read fences")
> > Cc: stable@vger.kernel.org # v6.16+
> > Cc: Prike Liang <Prike.Liang@amd.com>
> > Signed-off-by: John Fisher <jfisher84@gmail.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 17 +++++++++++++----
> >  1 file changed, 13 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_vm.c
> > index 29187fabc..8d0c03a40 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > @@ -2736,11 +2736,20 @@ int amdgpu_vm_make_compute(struct amdgpu_device=
 *adev, struct amdgpu_vm *vm)
> >                   "CPU update of VM recommended only for large BAR syst=
em\n");
> >
> >         if (vm->use_cpu_for_update) {
> > -               /* Sync with last SDMA update/clear before switching to=
 CPU */
> > -               r =3D amdgpu_bo_sync_wait(vm->root.bo,
> > -                                       AMDGPU_FENCE_OWNER_UNDEFINED, t=
rue);
> > -               if (r)
> > +               /*
> > +                * Sync with the last SDMA update/clear before switchin=
g to CPU
> > +                * updates. The VM's own page table updates are tracked=
 with
> > +                * DMA_RESV_USAGE_BOOKKEEP on the root PD, which
> > +                * amdgpu_bo_sync_wait() does not wait for: a clear of =
a PD still
> > +                * pending here lands after the CPU has written its ent=
ries.
>
> That comment is a bit superfluous, it describes the what and not the why.
>
> Just keep the "Sync with last SDMA update/clear before switching to CPU" =
or maybe change to "Sync with the last async SDMA update".
>
> > +                */
> > +               long t =3D dma_resv_wait_timeout(vm->root.bo->tbo.base.=
resv,
> > +                                              DMA_RESV_USAGE_BOOKKEEP,=
 true,
> > +                                              MAX_SCHEDULE_TIMEOUT);
>
> That is quite suboptimal, we don't want to wait for the BOOKKEEP fences h=
ere. And drop the return value checking and wait uninterruptible.
>
> Regards,
> Christian.
>
> > +               if (t < 0) {
> > +                       r =3D t;
> >                         goto unreserve_bo;
> > +               }
> >
> >                 vm->update_funcs =3D &amdgpu_vm_cpu_funcs;
> >                 r =3D amdgpu_vm_pt_map_tables(adev, vm);
> > --
> > 2.55.0
> >
>
