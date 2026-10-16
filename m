Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FBA283FC4
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 03:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792121141; cv=pass; b=Ql4dqGJAjxtJpKcgXFrVWK9WDp42D0LhKq5fxtBDXKyMGi6ZzcrqJs/ujE1lseW2ekb9rsKkj0aKC2Cv+nOEyIWA9DxP7xhzdsQIGR2FEz1NdGroQUDfpcVkfY0Om5ikxCuXtYhn5BCFDW+E/t/S561vNSV7bqJwtFLt4waUG1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792121141; c=relaxed/simple;
	bh=o0vPM3Nha12Ip1QuCW/phNil2jdjuN/CazWe6j2JO6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AA/etSh78iK7PGniNvVspotfk0q8Z0S4SJI7HLkZfOsrHOUT8VFUUwJsQnTpLfdMQbCJiHTiXitMcsV3Fwq8Qp37UASsskHLelx9fmYZxUvUjzfwjzKrMFfFO9xGnckLXZWRASrG5x+vXbiqEkgI32BcikBFEsJ09B8Nx8byWpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNL3HM59; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNL3HM59"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6a642495d81so7972531a12.2
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 20:25:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792121138; cv=none;
        d=google.com; s=arc-20260327;
        b=EYCXfMRpn6id0Lt7BynJWhS2mQ4ohsHP1L2Zpb6S832f4geZ9C1Az1pAaNoOYL2A5t
         I9wftfFRhyQ0BgMpvfoW/180vDCoUoqUxhyjIc4YmaO6TVQAe9SRr2yqdE53nyoqCItI
         Dhj0YznvnLx0giLe5CYqC7C+nGNoyqKBSckxdzbYLyRpyar0PXs0bDXPxmQ7UQziOBMa
         o3F/4us9OIWF5eLw4rNvbP2Argx/ZA5jf1KenavOJaJoBUHy60zprF0XAo0LwZN8EQ5V
         hQcGlMDoX/LDBjsVwbOZyZ9P53bhm3JIgZKiTtOW04eRvZmPYHms545K5PPpwRUPYyiU
         //TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LBTssoM2mFnFxVDtlPbTRlVraone7Ifm/DBSAnH2w7Q=;
        fh=xuguWl60LX90iR6RKcLM95i3tRbxhQLXRc9kLzZZpTA=;
        b=Cs8ySMw/gY81oG/r5uWkyLEibxuDoEPJYu+7wBT4bgXSMZrbrSuDMt4QDmXYlQN5rN
         2L74AWqgV0vUo2VRGnjMB5A9B6i+1DQ12PW8YqULra3gUjLn248l6e9v+l/ImLDL3q9T
         C2u2EvREXjM+oYqeXs0uibgL37QgMw7dvEplaer6ugBsaHS912p4D9QFwYwji8AIi0ec
         oWguIjn8TuK4rJPQGU210Qd43Ip/pGuxQV+cAc4zopPfQvEXOWZgJWWFV8W3wVBcxoCG
         tY5+fgTBy7CLXhUKJa86oijHkRB2JVLRtLWcsmINAax8VwXz4ZdckR7qtSnLgt3uVtep
         yKLw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792121138; x=1792725938; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LBTssoM2mFnFxVDtlPbTRlVraone7Ifm/DBSAnH2w7Q=;
        b=PNL3HM59/Hn/iCEK10zUz8RycHHPBKXQQGhfasGEZDdPmUlLqkEOHVxh9nkO5LGKLC
         y1UHbe+cP1tqojMkyxx5ipD6B2da3c76MSZ6AErsWITtf639RLg/tKRrNpyUr8H+8t9m
         AJ0inxDWL8tvTD3lcn5J+sVqsRC6/BUhNum7RCPWiYo3IBO883EPdeYxW949JxUDHsjw
         QMKU4CITwRyRPE51bRNxr8+nlQUpcbAUwJJodquY+OKVMjesRla8TrOj1RBpUdIBPdpx
         to719kATk1epy65TogyGh7Ks7LxiustM5p9FfRTTvaS1eAOj0UlpQ8auE34Ybo/7RHJ9
         alow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792121138; x=1792725938;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LBTssoM2mFnFxVDtlPbTRlVraone7Ifm/DBSAnH2w7Q=;
        b=ypBJl0dScnzdaijGMPf+xdyoG7ksJbTOPBwDtCyWwl+ymV/UFgNbSzuEWo5XTC5xy/
         hLQNikZHZCYTK6wgm+papBOn+8PprDVyd3K/WodcvnKM0058lvG4obqaBwMBJDlF9dbT
         D8+XpTTJTIkHc7AuVW2BagkRf6QU2HcVPZyoqkOYgsvVDefUPvYJ+DaXzTqCxRNMBPKm
         oYLieF3ylkIZZPf/KuedUsI3uxMwiUtuzg3C/7m4WED0bbGKHqOFeZzguavbb6tu2WbH
         fFyv94O2dqrRjwU1Cp9VFnsy5VZt93H1HSD15r7Lg7dKwpcJiAtRUdv2yYt6EaFk2z5D
         9ekQ==
X-Forwarded-Encrypted: i=1; AKwUvByOYfmOJaGFxRgzm5nsYgXA/h13ilJG7KstvE0TZjC2mIpB7Kt2enT4Rm4dae7js0PMfpK5QF0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJVnmw00JssXr1gSOFjkm5la6YvY4ezR9ECldnPCXrOrp3BOm+B
	iPI7s7Es5X3XnnWLo5us1utGV8i/zwtbCVCk5Qauoa5TRU9NXb+kK/Zu2TCmTSl0AYppe7Ri/1e
	e1suUOR3yPJhxO5bCwc8cYNr9FhIoIOU=
X-Gm-Gg: AYBFou2KPNGdeiE/+BLnQFrStKXomY9KQGC7GWrX14yKhphUeMNNeURBxC1nOXHxyb8
	6c7E8nZUaKCESg0uqmiFyfgsqhpvfgEJhQXJqA3eHjPaj/Odvv65KQj/exreqYZZi7swxj/bb8U
	Ni7MQwYGZJbG864zcSlAOT62GHs28OWnaRKTE1J5cxxl3BfHQJkfTFm+UkcFQzRVYMczOYVm/yJ
	1UEHKPE+wvrQHzG05sZhl8LGQHZChHo+vRAtFkmPAL3Ki7vSPzDwnzcsBPWYj7gpDuIv/+9syxn
	jQi9Yq8o0W+i2iJTmHHALH+bY9EipOdeqo9zBOpvBmjUFqPYgObcXWpLiipVxeWG
X-Received: by 2002:a05:6402:2788:b0:6aa:9866:551f with SMTP id
 4fb4d7f45d1cf-6b17c2d755cmr18289668a12.45.1792121137956; Thu, 15 Oct 2026
 20:25:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008204517.392180-1-jfisher84@gmail.com> <c64df6fa-6734-4c66-8f8b-52e5bd118cdb@amd.com>
In-Reply-To: <c64df6fa-6734-4c66-8f8b-52e5bd118cdb@amd.com>
From: John Fisher <jfisher84@gmail.com>
Date: Fri, 16 Oct 2026 16:25:26 +1300
X-Gm-Features: AclHuK8qA0Y5GArTBwCDOt3PjPocvVW2cHEUBULocqqscDY0UR0zbseYnJIw1eo
Message-ID: <CAC7wNSChWJ3nYY4GPT0Av+CDiudQ346hnxE_U0bfNLVvHdbozw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: wait for pending page table updates before
 switching a VM to CPU updates
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
	dri-devel@lists.freedesktop.org, stable@vger.kernel.org, 
	Prike Liang <Prike.Liang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Christian. Since I don't have commit access, I assume that if
all looks good the commit will be passed on to be applied?

Thanks,
John

On Fri, 9 Oct 2026 at 20:00, Christian K=C3=B6nig <christian.koenig@amd.com=
> wrote:
>
> On 10/8/26 22:45, John Fisher wrote:
> > amdgpu_vm_make_compute() switches a VM from SDMA to CPU page table
> > updates when a KFD process acquires it. It syncs "with the last SDMA
> > update/clear" through amdgpu_bo_sync_wait() on the root PD, but that
> > walks the reservation with DMA_RESV_USAGE_READ, and the clears of the
> > VM's page tables (the root PD from amdgpu_vm_init(), and the PDs/PTs
> > the seq64 mapping allocates at the render node's open) are added there
> > by amdgpu_vm_sdma_commit() with DMA_RESV_USAGE_BOOKKEEP only:
> > amdgpu_vm_pt_clear() commits them with a NULL fence, so they do not
> > reach vm->last_update. The CPU path's own waits (amdgpu_vm_cpu_update()=
,
> > amdgpu_bo_kmap()) use DMA_RESV_USAGE_KERNEL. None of them waits for a
> > clear that is still queued.
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
> > Record the clears in vm->last_update, as amdgpu_vm_update_pdes() does
> > with its updates, and wait for it, uninterruptibly, before switching th=
e
> > update functions. The clears all go through vm->delayed, so the last on=
e
> > covers the earlier ones; immediate clears are not recorded, as before.
> >
> > With this, on 7.3-rc6 and on 7.2.9, the same client reads the handler
> > 10 of 10 times, 8 busy queues on the 4 compute slots complete in 5 of 5
> > runs on 7.3-rc6 and 3 of 3 on 7.2.9 (1 of 6 before), 16 and 32 queues
> > complete on 7.3-rc6, and two processes with 8 queues each complete
> > together on both, with no fault.
> >
> > Fixes: 926c79ad6ecd ("drm/amdgpu: promote the implicit sync to the depe=
ndent read fences")
> > Cc: stable@vger.kernel.org # v6.16+
> > Cc: Prike Liang <Prike.Liang@amd.com>
> > Signed-off-by: John Fisher <jfisher84@gmail.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> > v2: wait for vm->last_update, in which amdgpu_vm_pt_clear() now records
> >     the clears, instead of every BOOKKEEP fence on the root PD; wait
> >     uninterruptibly without checking the result; keep the original
> >     comment (Christian)
> > v1: https://lore.kernel.org/amd-gfx/20261007200345.417281-1-jfisher84@g=
mail.com/
> >
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 5 +----
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 2 +-
> >  2 files changed, 2 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_vm.c
> > index 29187fabc..757a037ed 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > @@ -2737,10 +2737,7 @@ int amdgpu_vm_make_compute(struct amdgpu_device =
*adev, struct amdgpu_vm *vm)
> >
> >       if (vm->use_cpu_for_update) {
> >               /* Sync with last SDMA update/clear before switching to C=
PU */
> > -             r =3D amdgpu_bo_sync_wait(vm->root.bo,
> > -                                     AMDGPU_FENCE_OWNER_UNDEFINED, tru=
e);
> > -             if (r)
> > -                     goto unreserve_bo;
> > +             dma_fence_wait(vm->last_update, false);
> >
> >               vm->update_funcs =3D &amdgpu_vm_cpu_funcs;
> >               r =3D amdgpu_vm_pt_map_tables(adev, vm);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_vm_pt.c
> > index c03327f12..cdbc2e931 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> > @@ -427,7 +427,7 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, =
struct amdgpu_vm *vm,
> >       if (r)
> >               goto exit;
> >
> > -     r =3D vm->update_funcs->commit(&params, NULL);
> > +     r =3D vm->update_funcs->commit(&params, &vm->last_update);
> >  exit:
> >       drm_dev_exit(idx);
> >       return r;
>
