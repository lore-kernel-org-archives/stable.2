Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789F248423C
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 13:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792158382; cv=pass; b=EuEVoPjwclKwzidLS0efE9xSSeDQCTGCBGErXjkS9tR/Wyb7a2pSrH6uab08oVNrlavYBj3dkqvZFxWza+wk1yRTHVS2+vQGYgAgmlLC3Jr0GcBlwClfISLE4Ad0WGB45XKk2W0BUSeVWHTTelczQ41uB91sZTxaRi/Dv/VLbc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792158382; c=relaxed/simple;
	bh=1sgmzuUyBT7OZ0YtGUgJ03cslqHuDTP12UQl8uibRfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ePnlyQGCDcLjZqxz/7dJ32fVi7DnyBForRJwYtN3L/73kJTI6s5sINuDOFlTaJW96Mu5JU8CPdzh+hBUJpuFlrgXX2mX2uAF7845UcMX48kvEDniDDp9zn9DXtLCx0DWUVowOe7oc+r231q2LbNXBD9N/LZ700rROXKRkk8uqOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UZCWVeQf; arc=pass smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZCWVeQf"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-33c30fcf33fso740477eec.1
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 06:46:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792158380; cv=none;
        d=google.com; s=arc-20260327;
        b=kdtTU2Bm07V9aI/arKL5gXe1x+jBnPM7F8nBQJnTRDCLKfnkWkCVmL03ayomxMuw+b
         HcvIosLuQmNsmdKDrr+pUqnQl0eD20/GQsuV0FPlQr/hUrXrBYE5v1XcAK7ecNavLGpY
         OIwJPbbyjypEoVUs3zCGsfg0IylNTek0Ebrl24mMZdn2kketTO87tF6MvUux4j82sRtr
         9Zb5CETYkOmLmImhE7HvYaJuxSlXWXEnCI43x+SfIJr17BISt9DJPkfriKR5BwIEBcmi
         VGBVoCWZVzSz8xURlErpIK/afcEpMctuq1qrBLjRUqjkwJNPuxjEKyC2wLui33xk7Ju2
         Yu9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IQwutrotEhcZFsSETctJaN2PlsZ4N4GXMfVQMj/m4xY=;
        fh=nBLFYYJ2xyDZ2+lkQdDq9q/13YjPTCBOzxZuzG2AVAQ=;
        b=LdAwzhNvEXZQjIQD7uriAUglqSfmGhLeeAozGiQ1naTT1P6FUQ+oaxB7vSxiT7mm3g
         htTBhioKy/s9PaR5J8vXkVgyaW3yaICINN11tRiIGZN/ZNb0oYxCu6QV6AfCxvTKBli/
         aATGzawDe0VBZb2LWU2I4zyYVV83+gVUj2Ipdss1WB+hzJsREEwQ3H7ecnsp8Nd0FRjJ
         /iF/HJzZlwQjdYxaz7/RfXzr8J5JnSTTAhzCt5rxUgwrO39O7PJViqRF4ISh0ycGF0rR
         DBxKggTQ6yGfr84gp+kV/Et3uc9h59jxhwG4xDo6AT5ItEawXb7f7DiDdHSNd2+rM3xL
         aVow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792158380; x=1792763180; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IQwutrotEhcZFsSETctJaN2PlsZ4N4GXMfVQMj/m4xY=;
        b=UZCWVeQfOfzz895rBNI7KvxqS+taXlwx0MKm8Q30kg8XclNJyk2EZjM03ePNg7Urji
         WT2PwF1/J57skQfzuflOTxt3ELMmJ84dATmHQ145dzFWBxYl1ia+FV3XRFxqIQrql6C3
         Iw5t31x77JLY5pnHocWEGCfi37uosTSFd/N/QEH9mSqcPJyFqQtKTBEuqnpweuCAJU3H
         Wbh1R3CRJ/d8soukerTgl7ZfZoolhRZ8i/xFKFuGgmGCVcMHKf1rCEnnvnSqEGXrqIc4
         FUobs8zwf9rRMTxdeg2wq5pDyIoPwuIph8aLoJDOzpT1U9VLLoV+WYAll08uEwBsxkSe
         E79A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792158380; x=1792763180;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IQwutrotEhcZFsSETctJaN2PlsZ4N4GXMfVQMj/m4xY=;
        b=1qsQ0wD383v77nPjNCNIP1s9Pn2uSZJ/Wcbt8fkh2PmW4tID/lAuluqyYwnFEWpTSi
         MuaKmaN/qy/wmJq2fDLZoGH99i7r5U4dB9dgLleG/nuqtdK+moe4Y6oH8vgDazYKiZzK
         vSIB+tcJB+baLd6uh/pJAnaqdqIjj8iMR6LqVqHJDaejSkZynhJL2/uKtWh5+eETdIlZ
         55RxOKrs0bjqhls0KQyUm9nrZbo3dODGeIRUtZwTn+9CsdiHKcLiMKFvXeoYfqCpZMW5
         E3t+7wPSbqtfibPGwHh1RkmvXTUeYOyqnTZBEeL2D7QTbxeHep02yFy+wc+fIuOSvfF0
         Ry3w==
X-Forwarded-Encrypted: i=1; AKwUvBywK+FxeyEJwavyK6p0fuAStH/88JtM2UwN9hGi/OcdpCndbKOKaO0H+ghoaDPGT58QylyM7T4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKc0LwHsSjqZVShvengk8XunUf7OSoG63OwRaj5j7ykKLFq8q0j
	9w31VKzRKV0+77k7IwCxDiETBr8/jx/1g7QBsNkCpUQNXyGJqvYh5R0DOlIwqv8eAGfbvzibV8F
	xjHYZWrO3eSTY/27ki22MmLAiVjm5VGw=
X-Gm-Gg: AYBFou3dEqfYnMsjqlYmsZSEXL69tXJPLybecOj34vZmMT8yHKawI428vZ8uat7Hlun
	GndAgV7UCZj8HriAi+WEt8IeETeAK34yMAS5ejlczjthsbceerA7+nYHfPmL1+KxYHiVgOaAFP6
	CpBabmWg8Rg8XEYGjlBiYFsfGZ9AOz6pNZgssg4sMQCArKHhLiQGHN09hG4/rCZk+9vBFb41eKc
	H96B5X72ktoT7JxbqxV5NE1dlB2Dkqjqwn+sH1+hx2GzbKtGZT/XLqjJjE0OLsS+EqNmi4MOyEz
	hI5bCO63UJ6edRReAWwrRsRFEf0PypIojzKq3f+yGpiqoZHoL8JsXs6dK9yhU2ktq52bG5LxBKe
	T4Shtj8VbRLkodUBlHn/rfy9lQZR6BbUPUtuhIqdFrw==
X-Received: by 2002:a05:701b:2910:b0:143:8212:a43 with SMTP id
 a92af1059eb24-185105a89e4mr14750c88.1.1792158380316; Fri, 16 Oct 2026
 06:46:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008204517.392180-1-jfisher84@gmail.com> <c64df6fa-6734-4c66-8f8b-52e5bd118cdb@amd.com>
 <CAC7wNSChWJ3nYY4GPT0Av+CDiudQ346hnxE_U0bfNLVvHdbozw@mail.gmail.com> <9114d572-62ef-4885-bb29-d40d37cf2d61@amd.com>
In-Reply-To: <9114d572-62ef-4885-bb29-d40d37cf2d61@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 16 Oct 2026 09:46:07 -0400
X-Gm-Features: AclHuK-ytFanZGwdBY-gJ2-dp39BXO2RIXTCCSoeyuE7yFl3Gs7bQgyaapbhsJQ
Message-ID: <CADnq5_PSd2q2AX0m3cQHr-jiJiSc=pUjV1H6UUKUJC=AaRGX6Q@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: wait for pending page table updates before
 switching a VM to CPU updates
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: John Fisher <jfisher84@gmail.com>, amd-gfx@lists.freedesktop.org, 
	alexander.deucher@amd.com, dri-devel@lists.freedesktop.org, 
	stable@vger.kernel.org, Prike Liang <Prike.Liang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

On Fri, Oct 16, 2026 at 5:11=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 10/16/26 05:25, John Fisher wrote:
> > Thanks Christian. Since I don't have commit access, I assume that if
> > all looks good the commit will be passed on to be applied?
>
> Alex usually picks those up after a few days and merges it into amd-stagi=
ng-drm-next.
>
> Regards,
> Christian.
>
> >
> > Thanks,
> > John
> >
> > On Fri, 9 Oct 2026 at 20:00, Christian K=C3=B6nig <christian.koenig@amd=
.com> wrote:
> >>
> >> On 10/8/26 22:45, John Fisher wrote:
> >>> amdgpu_vm_make_compute() switches a VM from SDMA to CPU page table
> >>> updates when a KFD process acquires it. It syncs "with the last SDMA
> >>> update/clear" through amdgpu_bo_sync_wait() on the root PD, but that
> >>> walks the reservation with DMA_RESV_USAGE_READ, and the clears of the
> >>> VM's page tables (the root PD from amdgpu_vm_init(), and the PDs/PTs
> >>> the seq64 mapping allocates at the render node's open) are added ther=
e
> >>> by amdgpu_vm_sdma_commit() with DMA_RESV_USAGE_BOOKKEEP only:
> >>> amdgpu_vm_pt_clear() commits them with a NULL fence, so they do not
> >>> reach vm->last_update. The CPU path's own waits (amdgpu_vm_cpu_update=
(),
> >>> amdgpu_bo_kmap()) use DMA_RESV_USAGE_KERNEL. None of them waits for a
> >>> clear that is still queued.
> >>>
> >>> When one is, the CPU writes the first entries of the new compute VM (=
the
> >>> KFD trap handler's TBA/TMA page at AMDGPU_VA_RESERVED_TRAP_START, map=
ped
> >>> during ACQUIRE_VM) into a page directory the SDMA then clears. The
> >>> entries are gone, the handler's page is unmapped, and the first wave
> >>> save of any queue of the process faults in the SQC instruction fetch =
at
> >>> the handler's address (GCVM_L2_PROTECTION_FAULT_STATUS 0x008012B1,
> >>> PERMISSION_FAULTS 0xb). The MES then fails REMOVE_QUEUE and SUSPEND, =
and
> >>> the device takes a MODE1 reset with VRAM lost on 7.2.9; on 7.3-rc6 th=
e
> >>> queue is reset instead.
> >>>
> >>> The window is the time between the render node's open and ACQUIRE_VM.
> >>> ROCr spends milliseconds there and is practically never hit; a minima=
l
> >>> KFD client that opens the render node and acquires the VM at once is =
hit
> >>> most of the time. On a Radeon AI PRO R9700 (gfx1201, Resizable BAR, s=
o
> >>> vm_update_mode defaults to CPU updates for compute VMs), a wave readi=
ng
> >>> the trap handler's page right after queue creation found it unmapped =
in
> >>> 8 of 12 runs; a 5 ms sleep between the open and ACQUIRE_VM made that =
0
> >>> of 9, and the same sleep after queue creation instead 3 of 3.
> >>>
> >>> The wait covered these jobs until commit 926c79ad6ecd ("drm/amdgpu:
> >>> promote the implicit sync to the dependent read fences") narrowed
> >>> amdgpu_sync_resv() from DMA_RESV_USAGE_BOOKKEEP to DMA_RESV_USAGE_REA=
D;
> >>> the VM's page table jobs have been added with BOOKKEEP since commit
> >>> 4247084057cf ("drm/amdgpu: use DMA_RESV_USAGE_BOOKKEEP v2"), so from
> >>> v6.16 on the sync in amdgpu_vm_make_compute() waits for nothing of
> >>> them.
> >>>
> >>> Record the clears in vm->last_update, as amdgpu_vm_update_pdes() does
> >>> with its updates, and wait for it, uninterruptibly, before switching =
the
> >>> update functions. The clears all go through vm->delayed, so the last =
one
> >>> covers the earlier ones; immediate clears are not recorded, as before=
.
> >>>
> >>> With this, on 7.3-rc6 and on 7.2.9, the same client reads the handler
> >>> 10 of 10 times, 8 busy queues on the 4 compute slots complete in 5 of=
 5
> >>> runs on 7.3-rc6 and 3 of 3 on 7.2.9 (1 of 6 before), 16 and 32 queues
> >>> complete on 7.3-rc6, and two processes with 8 queues each complete
> >>> together on both, with no fault.
> >>>
> >>> Fixes: 926c79ad6ecd ("drm/amdgpu: promote the implicit sync to the de=
pendent read fences")
> >>> Cc: stable@vger.kernel.org # v6.16+
> >>> Cc: Prike Liang <Prike.Liang@amd.com>
> >>> Signed-off-by: John Fisher <jfisher84@gmail.com>
> >>
> >> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> >>
> >>> ---
> >>> v2: wait for vm->last_update, in which amdgpu_vm_pt_clear() now recor=
ds
> >>>     the clears, instead of every BOOKKEEP fence on the root PD; wait
> >>>     uninterruptibly without checking the result; keep the original
> >>>     comment (Christian)
> >>> v1: https://lore.kernel.org/amd-gfx/20261007200345.417281-1-jfisher84=
@gmail.com/
> >>>
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 5 +----
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 2 +-
> >>>  2 files changed, 2 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_vm.c
> >>> index 29187fabc..757a037ed 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> >>> @@ -2737,10 +2737,7 @@ int amdgpu_vm_make_compute(struct amdgpu_devic=
e *adev, struct amdgpu_vm *vm)
> >>>
> >>>       if (vm->use_cpu_for_update) {
> >>>               /* Sync with last SDMA update/clear before switching to=
 CPU */
> >>> -             r =3D amdgpu_bo_sync_wait(vm->root.bo,
> >>> -                                     AMDGPU_FENCE_OWNER_UNDEFINED, t=
rue);
> >>> -             if (r)
> >>> -                     goto unreserve_bo;
> >>> +             dma_fence_wait(vm->last_update, false);
> >>>
> >>>               vm->update_funcs =3D &amdgpu_vm_cpu_funcs;
> >>>               r =3D amdgpu_vm_pt_map_tables(adev, vm);
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_vm_pt.c
> >>> index c03327f12..cdbc2e931 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> >>> @@ -427,7 +427,7 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev=
, struct amdgpu_vm *vm,
> >>>       if (r)
> >>>               goto exit;
> >>>
> >>> -     r =3D vm->update_funcs->commit(&params, NULL);
> >>> +     r =3D vm->update_funcs->commit(&params, &vm->last_update);
> >>>  exit:
> >>>       drm_dev_exit(idx);
> >>>       return r;
> >>
>
