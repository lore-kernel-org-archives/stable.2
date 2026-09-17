Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DE34A3F07
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 21:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789680965; cv=none; b=suFP9aLPykmwfbXYVWWLyEXvfJNSxdBr+AJT1p29qJqni8Fy2D9uCN74Lc/w9yqqrwGsjX4+10G1roATyuRXkJ0Zi3f1BJ2XioTQ1W5PJCnL/mwwY1hkY3meHnT4O5f4CdQpZ9hi7lMdQrrMn06WWahvqOSSIQCAiBxvasTxAfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789680965; c=relaxed/simple;
	bh=52AsRwXMoovtJKh7XNiBOhqI0uOHeCsLkfsr9QJ6bao=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F4ZG/305kzEkQCiXSl2PjPREH60jW1rvsQaue5bLTlswturV3JFx5ripmLNDsBCRSdq+/JP/ySRwwtSQ8VvqqeWvXBn+DkokVjmJHdjXmeSsAz2vi4MV40CgD49LV96QzCRNwsK2O9A6ZFIXF7bEwfPYKpm/j70zFKyMHatDmkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dBug+zQi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=N6phB7Hh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dBug+zQi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="N6phB7Hh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789680962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GPQYwNrXtzx5wg61th1A6MtnGzGLpKWbnnt0jGgdHkE=;
	b=dBug+zQiW8R2QOCvk/iEDSnMLm6V0thpyulnCVq6Hlvs7+Bce5PPhOQUYqdUsJnOwVRKla
	2njQjlT5lLDgyu/k8ooOecepYd244sBIoopJJxPuWRvN3liUZYOGyi5NKiA8YVjuw8GMfC
	sTBTyqbVY03r2g8BG9ikdpPgz18s4u8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-lN0aT-4yPEqDDQuJOL1hBQ-1; Thu, 17 Sep 2026 17:36:01 -0400
X-MC-Unique: lN0aT-4yPEqDDQuJOL1hBQ-1
X-Mimecast-MFC-AGG-ID: lN0aT-4yPEqDDQuJOL1hBQ_1789680961
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-90ce8ad8002so3021426d6.2
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 14:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789680961; x=1790285761; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=GPQYwNrXtzx5wg61th1A6MtnGzGLpKWbnnt0jGgdHkE=;
        b=N6phB7Hh7FZHjZ1ZUTDJuzGZh1aDKXQHzdbFAEJSAdGVk/XlgHtq/xuymoWvFJBS6D
         IM3aeg0s2ZXOwF7llZ2GPbipc1jPhjOoEkapu2H19Z3TLbaapRu0ewn/ZaHwydT23sAO
         fJdGwEObbp3G2tuj//L7+IU1rKqIOnv1RUKOKf3Qa+ltS1cqxh2FuDK+qY5LCd0DpvJE
         r3F5zakIU0zgBtFuHvNUVibtImEABd/itkNdbF516/ZRHiTXp1WxUWq58TaVtdlzxe8q
         rrIb2NX9etSDzIMmzYcTE/kdBxR0HKht1zv7DBoE75rZl8t9Qqiiu1rU+Bpz8sPtmGat
         5YYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789680961; x=1790285761;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GPQYwNrXtzx5wg61th1A6MtnGzGLpKWbnnt0jGgdHkE=;
        b=xTKqLW2H9lYn1HyM+gOzSR3vWGFkxNeyYBAyJ1DuRNMZYGq32FnNghR6bwIujOi10M
         6XipbH7toOutNXmbT/2LpPUj8bQt06ZlstHQrXzkbEnofRyfsJRIf2onJV8f2w1ua/GP
         uRQvrQWKNp9daWaaLiRSl0z8Va7SVgj+VbLrvPH+mTbAAEvK+WBH+n72nfFaru0hi3fc
         YDkYbBlAZxhAKOX3n5ip/jMKOZPtxePpNj0TL2k/29lgwLUZPik6PpagVcGMzYBxXRq7
         dkoAtIpxZaYsBMO5npi0DXDDd6NtWQFwCnm9U2BMte7AC1lEOqiist4ufF8ZRQmg2b9C
         vr+Q==
X-Forwarded-Encrypted: i=1; AKwUvByXSwqYWZd0w9n+JeC9MeFe0Teib/KXVnd+5w0yiK5jeOMcuqXe8UXFtHd95HbFWu6QY5MvN3k=@vger.kernel.org
X-Gm-Message-State: AFuF++kiMpVmAajzfFwBMoqy8Y9TVyg/j7v/wSsHzl64vkcPR5kJf1Of
	AB4zvf5UUhuCP3ADwdgwGM1BMWATaaVoYLPkIeQl8zNAuz8jDL9lmlmV+A6AyPL8ti3oSDAR/Y8
	82Ez1RSrxFa+Tz1U2ZhoKEBr4sdnu39X6CdVmYe/Dp8fV0hrJZHtk5sXyTA==
X-Gm-Gg: AYBFou2gIfEQ6HF+SEW7uAZFFMybrbzT3OybnlmrUByIVj9YnT9+fm5/YPKuqeV7p2u
	Eh8QuWpGFRh1+WFhbahxDlukHRet77NKnc6jRVB6hP1DxkLpJ6bPbupHcwCs3zf4CcRCK8zCmDy
	rqqsVhRIBPxX2pj3UDuHdMbhVVDErn9PTeupozDGN4ZgSWv3IomZZfA73LkQqKg80rG/3IKHjjA
	Nz383Mz2gdoCEXByYalHM/5QeJegML64GzjN0kW5llSFxbaaz4ZMpR/lHra73ZevD5h4QDYkGVR
	vEgkzrIS4vuVYshUqZg5BJYd7Ok3QBRRlYzP211rwB2bwIx7VuddIdIqJL/bDbpDgohxoV92
X-Received: by 2002:a0c:fa46:0:b0:912:428a:8bb2 with SMTP id 6a1803df08f44-91254b57120mr8659276d6.19.1789680960565;
        Thu, 17 Sep 2026 14:36:00 -0700 (PDT)
X-Received: by 2002:a0c:fa46:0:b0:912:428a:8bb2 with SMTP id 6a1803df08f44-91254b57120mr8659126d6.19.1789680960046;
        Thu, 17 Sep 2026 14:36:00 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91252cd9fc8sm7298096d6.38.2026.09.17.14.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 14:35:59 -0700 (PDT)
Message-ID: <c0c9f4af21a0918f1198cc929820c01c1190f5b6.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau/uvmm: fix UAF in nouveau_uvmm_sm when BO is
 in TTM_PL_SYSTEM
From: lyude@redhat.com
To: Peiyang He <peiyang_he@smail.nju.edu.cn>, dakr@kernel.org
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, airlied@redhat.com
Date: Thu, 17 Sep 2026 17:35:57 -0400
In-Reply-To: <0D77BEC410CE0129+20260907052204.1431488-1-peiyang_he@smail.nju.edu.cn>
References: 
	<0D77BEC410CE0129+20260907052204.1431488-1-peiyang_he@smail.nju.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Reviewed-by: Lyude Paul <lyude@redhat.com>

Will push to drm-misc-fixes in just a moment

On Mon, 2026-09-07 at 13:22 +0800, Peiyang He wrote:
> nouveau_uvmm_sm() calls op_map(), which passes bo->resource through
> nouveau_mem() to nouveau_uvma_map(). nouveau_uvmm_vmm_map() then
> reads
> mem->mem.type.
>=20
> But this is only valid when bo->resource is backed by struct
> nouveau_mem,
> as is the case for VRAM and TT resources. If the BO is left in
> TTM_PL_SYSTEM, bo->resource is only a struct ttm_resource. Treating
> it
> as struct nouveau_mem makes the mem->mem.type read past the end of
> the
> resource, causing a KASAN: slab-use-after-free Read in
> nouveau_uvmm_sm
> report:
>=20
> BUG: KASAN: slab-use-after-free in nouveau_uvmm_vmm_map
> drivers/gpu/drm/nouveau/nouveau_uvmm.c:152 [inline]
> BUG: KASAN: slab-use-after-free in nouveau_uvma_map
> drivers/gpu/drm/nouveau/nouveau_uvmm.c:199 [inline]
> BUG: KASAN: slab-use-after-free in op_map
> drivers/gpu/drm/nouveau/nouveau_uvmm.c:849 [inline]
> BUG: KASAN: slab-use-after-free in
> nouveau_uvmm_sm.constprop.0+0x6ab/0x900
> drivers/gpu/drm/nouveau/nouveau_uvmm.c:903
> Read of size 1 at addr ffff888127d3e3a0 by task kworker/0:1/11
>=20
> CPU: 0 UID: 0 PID: 11 Comm: kworker/0:1 Not tainted 7.2.0 #5
> PREEMPT(lazy)=20
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-
> debian-1.16.3-2 04/01/2014
> Workqueue: nouveau_sched_wq_2224 drm_sched_run_job_work
> Call Trace:
> =C2=A0<TASK>
> =C2=A0__dump_stack lib/dump_stack.c:94 [inline]
> =C2=A0dump_stack_lvl+0x95/0xe0 lib/dump_stack.c:120
> =C2=A0print_address_description mm/kasan/report.c:378 [inline]
> =C2=A0print_report+0xcb/0x5a0 mm/kasan/report.c:482
> =C2=A0kasan_report+0xca/0x100 mm/kasan/report.c:595
> =C2=A0nouveau_uvmm_vmm_map drivers/gpu/drm/nouveau/nouveau_uvmm.c:152
> [inline]
> =C2=A0nouveau_uvma_map drivers/gpu/drm/nouveau/nouveau_uvmm.c:199 [inline=
]
> =C2=A0op_map drivers/gpu/drm/nouveau/nouveau_uvmm.c:849 [inline]
> =C2=A0nouveau_uvmm_sm.constprop.0+0x6ab/0x900
> drivers/gpu/drm/nouveau/nouveau_uvmm.c:903
> =C2=A0nouveau_uvmm_sm_unmap drivers/gpu/drm/nouveau/nouveau_uvmm.c:932
> [inline]
> =C2=A0nouveau_uvmm_bind_job_run+0xd6/0x250
> drivers/gpu/drm/nouveau/nouveau_uvmm.c:1532
> =C2=A0nouveau_job_run drivers/gpu/drm/nouveau/nouveau_sched.c:350 [inline=
]
> =C2=A0nouveau_sched_run_job+0x62/0xd0
> drivers/gpu/drm/nouveau/nouveau_sched.c:364
> =C2=A0drm_sched_run_job_work+0x356/0xa10
> drivers/gpu/drm/scheduler/sched_main.c:1061
> =C2=A0process_one_work+0x8a5/0x1900 kernel/workqueue.c:3322
> =C2=A0process_scheduled_works kernel/workqueue.c:3405 [inline]
> =C2=A0worker_thread+0x5dd/0xd80 kernel/workqueue.c:3486
> =C2=A0kthread+0x31d/0x420 kernel/kthread.c:436
> =C2=A0ret_from_fork+0x662/0x940 arch/x86/kernel/process.c:158
> =C2=A0ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> =C2=A0</TASK>
>=20
> Allocated by task 2224 on cpu 0 at 66.550027s:
> =C2=A0kasan_save_stack+0x24/0x50 mm/kasan/common.c:57
> =C2=A0kasan_save_track+0x17/0x60 mm/kasan/common.c:78
> =C2=A0poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
> =C2=A0__kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:415
> =C2=A0kasan_kmalloc include/linux/kasan.h:263 [inline]
> =C2=A0__do_kmalloc_node mm/slub.c:5334 [inline]
> =C2=A0__kmalloc_noprof+0x304/0x7c0 mm/slub.c:5359
> =C2=A0_kmalloc_noprof include/linux/slab.h:992 [inline]
> =C2=A0dma_resv_list_alloc+0x27/0x90 drivers/dma-buf/dma-resv.c:106
> =C2=A0dma_resv_reserve_fences+0x60e/0xa30 drivers/dma-buf/dma-resv.c:205
> =C2=A0ttm_bo_alloc_resource+0x12c/0xbd0 drivers/gpu/drm/ttm/ttm_bo.c:721
> =C2=A0ttm_bo_validate+0x1bc/0x4a0 drivers/gpu/drm/ttm/ttm_bo.c:856
> =C2=A0ttm_bo_init_reserved+0x2c3/0x570 drivers/gpu/drm/ttm/ttm_bo.c:970
> =C2=A0nouveau_bo_init+0x159/0x2c0 drivers/gpu/drm/nouveau/nouveau_bo.c:35=
9
> =C2=A0nouveau_gem_new+0x234/0x5f0
> drivers/gpu/drm/nouveau/nouveau_gem.c:272
> =C2=A0nouveau_gem_ioctl_new+0x1eb/0x420
> drivers/gpu/drm/nouveau/nouveau_gem.c:352
> =C2=A0drm_ioctl_kernel+0x192/0x350 drivers/gpu/drm/drm_ioctl.c:817
> =C2=A0drm_ioctl+0x4f8/0xb40 drivers/gpu/drm/drm_ioctl.c:914
> =C2=A0nouveau_drm_ioctl+0xea/0x2c0
> drivers/gpu/drm/nouveau/nouveau_drm.c:1338
> =C2=A0vfs_ioctl fs/ioctl.c:51 [inline]
> =C2=A0__do_sys_ioctl fs/ioctl.c:597 [inline]
> =C2=A0__se_sys_ioctl fs/ioctl.c:583 [inline]
> =C2=A0__x64_sys_ioctl+0x180/0x1d0 fs/ioctl.c:583
> =C2=A0do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> =C2=A0do_syscall_64+0x115/0x690 arch/x86/entry/syscall_64.c:94
> =C2=A0entry_SYSCALL_64_after_hwframe+0x77/0x7f
>=20
> Freed by task 2223 on cpu 0 at 66.554063s:
> =C2=A0kasan_save_stack+0x24/0x50 mm/kasan/common.c:57
> =C2=A0kasan_save_track+0x17/0x60 mm/kasan/common.c:78
> =C2=A0kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:584
> =C2=A0poison_slab_object mm/kasan/common.c:253 [inline]
> =C2=A0__kasan_slab_free+0x61/0x80 mm/kasan/common.c:285
> =C2=A0kasan_slab_free include/linux/kasan.h:235 [inline]
> =C2=A0slab_free_hook mm/slub.c:2677 [inline]
> =C2=A0__rcu_free_sheaf_prepare+0xb6/0x2e0 mm/slub.c:2928
> =C2=A0rcu_free_sheaf+0x1b/0x120 mm/slub.c:5978
> =C2=A0rcu_do_batch kernel/rcu/tree.c:2645 [inline]
> =C2=A0rcu_core+0x521/0x1490 kernel/rcu/tree.c:2897
> =C2=A0handle_softirqs+0x1b1/0x8a0 kernel/softirq.c:622
> =C2=A0__do_softirq kernel/softirq.c:656 [inline]
> =C2=A0invoke_softirq kernel/softirq.c:496 [inline]
> =C2=A0__irq_exit_rcu+0x137/0x1c0 kernel/softirq.c:735
> =C2=A0irq_exit_rcu+0x9/0x20 kernel/softirq.c:752
> =C2=A0instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062
> [inline]
> =C2=A0sysvec_apic_timer_interrupt+0x70/0x80
> arch/x86/kernel/apic/apic.c:1062
> =C2=A0asm_sysvec_apic_timer_interrupt+0x1a/0x20
> arch/x86/include/asm/idtentry.h:674
>=20
> The buggy address belongs to the object at ffff888127d3e380
> =C2=A0which belongs to the cache kmalloc-96 of size 96
> The buggy address is located 32 bytes inside of
> =C2=A0freed 96-byte region [ffff888127d3e380, ffff888127d3e3e0)
>=20
> The buggy address belongs to the physical page:
> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0
> pfn:0x127d3e
> flags: 0x200000000000000(node=3D0|zone=3D2)
> page_type: f5(slab)
> raw: 0200000000000000 ffff888100041280 dead000000000122
> 0000000000000000
> raw: 0000000000000000 0000000000200020 00000000f5000000
> 0000000000000000
> page dumped because: kasan: bad access detected
>=20
> Memory state around the buggy address:
> =C2=A0ffff888127d3e280: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
> =C2=A0ffff888127d3e300: 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc
> > ffff888127d3e380: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
> =C2=A0ffff888127d3e400: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
> =C2=A0ffff888127d3e480: 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc
>=20
> Fix by resetting the placement to the BO's valid domains before
> calling nouveau_bo_validate(), matching the handling in
> nouveau_uvmm_bo_validate(), so map jobs do not run for SYSTEM
> resources;
> Reject BO that cannot reside in VRAM or GART;
> Also skip op_map() when the GPUVA has been invalidated, matching the
> handling in the unmap and remap paths.
>=20
> Found when fuzzing the nouveau driver with a modified Syzkaller.
>=20
> Fixes: b88baab82871 ("drm/nouveau: implement new VM_BIND uAPI")
> Cc: stable@vger.kernel.org
> Signed-off-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
> Assisted-by: Codex:gpt-5.5
> ---
> =C2=A0drivers/gpu/drm/nouveau/nouveau_uvmm.c | 13 +++++++++++--
> =C2=A01 file changed, 11 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> index fc125fd44a9b..2026fe6b48c6 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> @@ -846,6 +846,9 @@ op_map(struct nouveau_uvma *uvma)
> =C2=A0{
> =C2=A0	struct nouveau_bo *nvbo =3D nouveau_gem_object(uvma-
> >va.gem.obj);
> =C2=A0
> +	if (drm_gpuva_invalidated(&uvma->va))
> +		return;
> +
> =C2=A0	nouveau_uvma_map(uvma, nouveau_mem(nvbo->bo.resource));
> =C2=A0}
> =C2=A0
> @@ -1232,6 +1235,7 @@ bind_lock_validate(struct nouveau_job *job,
> struct drm_exec *exec,
> =C2=A0
> =C2=A0		drm_gpuva_for_each_op(va_op, op->ops) {
> =C2=A0			struct drm_gem_object *obj =3D
> op_gem_obj(va_op);
> +			struct nouveau_bo *nvbo;
> =C2=A0
> =C2=A0			if (unlikely(!obj))
> =C2=A0				continue;
> @@ -1246,8 +1250,13 @@ bind_lock_validate(struct nouveau_job *job,
> struct drm_exec *exec,
> =C2=A0			if (va_op->op =3D=3D DRM_GPUVA_OP_UNMAP)
> =C2=A0				continue;
> =C2=A0
> -			ret =3D
> nouveau_bo_validate(nouveau_gem_object(obj),
> -						=C2=A0 true, false);
> +			nvbo =3D nouveau_gem_object(obj);
> +			if (!(nvbo->valid_domains &
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (NOUVEAU_GEM_DOMAIN_VRAM |
> NOUVEAU_GEM_DOMAIN_GART)))
> +				return -EINVAL;
> +
> +			nouveau_bo_placement_set(nvbo, nvbo-
> >valid_domains, 0);
> +			ret =3D nouveau_bo_validate(nvbo, true,
> false);
> =C2=A0			if (ret)
> =C2=A0				return ret;
> =C2=A0		}
> =C2=A0	}
> =C2=A0

