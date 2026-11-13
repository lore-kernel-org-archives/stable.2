Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794536670;
	b=J8nya8R55zo6HYOYx7m5wQ5JiYEMTzMetGfP2MIa/hbQ1P4ytwTB0lVkXQj0GZlemT7G
	 YySNl4LtcbTFhBSR6yz7aPFwJTcMdP6cdvZM3ZcdY7LzmPcP9jt5QpLwqkDMgGWIvZS8s
	 EmTzGq7XkS9HjLsZLjL4lIuYFgybeHVUwbBs/vGC2+PaqPkz+teW0OhlpBlOUVTGnl5Fu
	 eRD90IQLFeOD7ls1L0mGHstdaYT9aO2EXH+LF/kdavz/lsVXWhyeEZVGkBcvdBh0X2p2n
	 OL6aJUGA+Hi/O5Z7C3ldvM5d8NgNIdZ1+Of5L4zUFPy4ucNJJzzZs9+NGXJBF7rDaPw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794536670;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=oWzMkP8XjVIWFgDnL4ZI/gXC/s+5pEfVFpM+tbO5lhY=;
	b=v0JG9eaV9SOiC14KpsXR1gaEW1dKCTeiJb9/HKH6JkBE2H5y8+YVoo5KXL2ugYG8ti+5
	 d+0rvvlZyArWdleiBw8Z++5nEZ2ycCN2606ukEFmPKuYZWv+eyM6ekBbWSdzQMUIM9MrL
	 ijwUUrrfsLRCAJw/KwLf0hpLTGlY7kVcRyXNeyarvXVLjv0bkk23YsDJXqddwukVomwTs
	 e5OALrSas+Qs99JUll56UWp1bLt7FRiI0etadUHqiJcsI4Kxe0IPAwFTU5SHHx5gCg89T
	 ypdj/wHX5i97P6LZ6xsrELnOdFJ+NjL12CmyXG24+4UI0mBbr3lwoSvNq0K8hLbXEhw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d5D1vjs7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.54
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657B0606A323
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 02:24:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 657B0606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d5D1vjs7
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-67be4f2f4d4so510433d50.2
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 18:24:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794536669; cv=none;
        d=google.com; s=arc-20260327;
        b=kOwFeBbHeHDBP3IwEjqxzYq2naKduqv8EQQgy1HVGpZBtCZ/4uHq94aJWBIG9tDV0q
         8X/NXfDAeWNCS9fqb3MVV5gEILxXVKcBXeFdsi3uyy2tEjNq1rI3p2PrY9T2kCRnYyF6
         3jqByUNI4yCAu9tqJ/DGdmFWXtKx2vad1pRcZBiVxjRxk7F+/NHNKvVGzctV9L0dsheM
         LjtEVdu70n0r9nb+QavSFN7F5bUiuoorhx5C3in9XuXAUZEWuIvv4WSgEyKmU1kezgtG
         Z9PDJM/HsusNjaL4lqJKiN4wmQ+G8FMJsKApKfl/6cDm5KlpqbFvluo4OAT5JiKiQnMb
         BF3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oWzMkP8XjVIWFgDnL4ZI/gXC/s+5pEfVFpM+tbO5lhY=;
        fh=qbPKtt74gM2Ee5cglCLF39RwCaG22o0Qs3s3jBpAQdo=;
        b=kKpjQvuCki+7YPQIFqqQWRzdm7d9eblidnP6ng7JE863rvz3v3uKTshCoayxmDjCzP
         wi+S012OpuU/0PYDhRdougrcPj30mYN14aRAeFidjfzlPEYwRTlew7S/8eO1hsD5ZQ3Y
         013dvkKR+ijfCTfZ/UK7cS5kuvbgd+xKjLP6/QbYaDd8PsyQKd8/xkIZg90nDp6GAdF1
         ZCnBXVWvPaFVICUxO5Cxmy1KdJELqOrp91ybgwaArPM4jH1cV+ItLDxbrrk/gfS3eDci
         tN4d4242m8Ptmhz+bmTtDhqijfr29qqHtafOiTBAQC7JRhgRECIrYg81A2mrkU3J9vZq
         EoDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794536669; x=1795141469; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oWzMkP8XjVIWFgDnL4ZI/gXC/s+5pEfVFpM+tbO5lhY=;
        b=d5D1vjs7Jz8QdYNqBjMzEWSxJ06A9SMH4V+GFb5Co2dhBfIskOV1IHerPJfHGsDDKN
         etKdZ92jEz0EEaKtG+aUg49jERiZCPJFsVUSfLjdNo1Mx3dJyY9nlxUo3tLg9ly2LL7k
         W8MWa2zHsdTc19Q299GW2y2TyN9Pjj4wLiaIvc2mo4Suzqc0Vi6EvW3eHfCH66BEoyBF
         oSHsc2OlVns0wXKRP3acZV9go7Knzju4Kg5UpcPYz/yHWpI5ONW/CInSiquGtCzr0SQd
         kNrydTPYRtIFVdozwUjsSI67bKE+SIgyi7OU8QVgMXbmZYZ4pZLt3A8vMZDYVKnFmSfP
         hqqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794536669; x=1795141469;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oWzMkP8XjVIWFgDnL4ZI/gXC/s+5pEfVFpM+tbO5lhY=;
        b=IYEnoeBiOUPHAmgzFYWcNgenLFhjDPup7fum70HyT9gQ/HOHndo0uO6hPVIhD1mPdK
         kfVomw7do96BACEOFJGAk3dXWeOLXmOSNeUe1BTRjXBxzOfAnHF/rIHeNMyCoQ2B0fFa
         hj54jP7qczsLiqhTsxsSrDm06zCFyD47MNRtdNsaQUqE1BwT7OB332iDSwd6aoBDkYmN
         US1WTybaqSR51hy8V77EzNNNsJiRd8BDxgWvQ4NvoSttUvf6ytcP5z/LtA3MtEpd0GGh
         zPjTXXSOHlwmRUiMGPWlxJ8Dy+qguiiRi5K3MyJnjxsP01j3okPfg3q3qW1WG2zRnOsE
         dUgA==
X-Forwarded-Encrypted: i=1; AL+hErGKUpgsf+kgyFR6DAdioBvUxPENr7KRK2Vv7gelN/KiVpcP59wntQdsoOCMZDdVAXvcMWzSguo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/f2w+yQ6keKt4f6vY+IxYeTKKejDIpyqtyL0sAdi6FHyKLQmFz
	0QhboxDInJ4YRfFVdKGpZFnSyIum1OWSJ0Kv+yOZrYhCVmu6HEugkD/ilP0n/TLVQK3g1p8y+tD
	K00ngwk/GywkcmZLc5q8THmKjZmv95MRpnKPQ
X-Gm-Gg: AYBFou2RotICLE0RB/AMy9GeqpfJQUFoC4JyGPJvscv5YbMDojmfQY1hl8BlcmSmHxQ
	R7Hag9Lod7HelG5oYHIPatVIml01J8Phm/74AOWqQTAy9TKgxF3V1tRByu6cS65CvV7KOGrFhda
	S1NAY/TSEcn1/0vIUjV3MRgvQkZg1RpannQN4WRKWXCbRQF41ttA2n35HS4vKm0/zuZS7pQKC8Z
	lajj26aHqiDd1c7PGnDof7mnQOAPluf9htLlt+YGXx1veYq7Ojnu0onjQiM4jG6u1Jlp7Mt+5d3
	f1NLrEeqw6qB1ANZTMDDRAN1njnEhfFj0tSICMys4L3JDOwpUy1Ey6+fPlxm+mRDLP0x1pbGcC9
	WsCgwuHYHQBP8BHXzLmU8oPD0b0iIOhaGrTT0tA==
X-Received: by 2002:a53:acd4:0:10b0:67b:fce3:45e8 with SMTP id
 956f58d0204a3-67d8978dbf7mr530380d50.94.1794536669230; Thu, 12 Nov 2026
 18:24:29 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261101073700.1261966-1-gye976@gmail.com>
In-Reply-To: <20261101073700.1261966-1-gye976@gmail.com>
From: Gyeyoung Baek <gye976@gmail.com>
Date: Fri, 13 Nov 2026 11:24:18 +0900
X-Gm-Features: AclHuK-uyrlffIoFjYHTKCRH3SK4kkMQorZdRDw1Xbvlm4EKkbd7IoOWYybBtis
Message-ID: <CAKbEznsZ+rFG+U3Et8rovZUPmpLWnoiB5CQPNMHGmMD9C3J9Sw@mail.gmail.com>
Subject: Re: [PATCH v2] accel/rocket: Fix drm_mm UAF on close vs in-flight job
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>
Cc: Jeff Hugo <jeff.hugo@oss.qualcomm.com>, Heiko Stuebner <heiko@sntech.de>, 
	Sidong Yang <sidong.yang@furiosa.ai>, dri-devel@lists.freedesktop.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Gentle ping.

This is hit frequently in testing whenever a process exits
with jobs still in flight.

On Sun, Nov 1, 2026 at 4:37=E2=80=AFPM Gyeyoung Baek <gye976@gmail.com> wro=
te:
>
> The drm_mm and its mutex live in rocket_file_priv, which
> rocket_postclose() frees on fd close.  But a BO held by an
> in-flight job is only freed after close, from the drm_sched
> free_job worker, and its destructor then accesses the already
> freed drm_mm and mutex.
>
>   BUG: KASAN: slab-use-after-free in __mutex_trylock_common+0x90/0x1e8
>   Workqueue: <NPU>.npu drm_sched_free_job_work [gpu_sched]
>   Call trace:
>     __mutex_lock
>     rocket_gem_bo_free
>     rocket_job_cleanup
>     rocket_job_free
>     drm_sched_free_job_work [gpu_sched]
>
> Move drm_mm and the mutex out of rocket_file_priv into the
> kref-managed rocket_iommu_domain (renamed to rocket_vm).  Their
> lifetime now matches the vm's: as long as a BO or job references
> the vm, the address-space state stays alive.
>
> Fixes: ed98261b4168 ("accel/rocket: Add a new driver for Rockchip's NPU")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
> ---
> Changes in v2:
> - Rebased on drm-misc-fixes and resent. No functional changes.
> - Link to v1: https://lore.kernel.org/r/20260426103758.1373137-1-gye976@g=
mail.com
>
>  drivers/accel/rocket/rocket_drv.c | 74 +++++++++++++++----------------
>  drivers/accel/rocket/rocket_drv.h | 13 +++---
>  drivers/accel/rocket/rocket_gem.c | 31 ++++++-------
>  drivers/accel/rocket/rocket_gem.h |  4 +-
>  drivers/accel/rocket/rocket_job.c |  6 +--
>  drivers/accel/rocket/rocket_job.h |  2 +-
>  6 files changed, 64 insertions(+), 66 deletions(-)
>
> diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/roc=
ket_drv.c
> index 5d7805c41dc..f58c15131dc 100644
> --- a/drivers/accel/rocket/rocket_drv.c
> +++ b/drivers/accel/rocket/rocket_drv.c
> @@ -26,46 +26,54 @@ static struct platform_device *drm_dev;
>  static struct rocket_device *rdev;
>
>  static void
> -rocket_iommu_domain_destroy(struct kref *kref)
> +rocket_vm_destroy(struct kref *kref)
>  {
> -       struct rocket_iommu_domain *domain =3D container_of(kref, struct =
rocket_iommu_domain, kref);
> +       struct rocket_vm *vm =3D container_of(kref, struct rocket_vm, kre=
f);
>
> -       iommu_domain_free(domain->domain);
> -       domain->domain =3D NULL;
> -       kfree(domain);
> +       drm_mm_takedown(&vm->mm);
> +       mutex_destroy(&vm->lock);
> +       iommu_domain_free(vm->domain);
> +       vm->domain =3D NULL;
> +       kfree(vm);
>  }
>
> -static struct rocket_iommu_domain*
> -rocket_iommu_domain_create(struct device *dev)
> +static struct rocket_vm *
> +rocket_vm_create(struct device *dev)
>  {
> -       struct rocket_iommu_domain *domain =3D kmalloc_obj(*domain);
> +       struct rocket_vm *vm =3D kmalloc_obj(*vm);
> +       u64 start, end;
>         void *err;
>
> -       if (!domain)
> +       if (!vm)
>                 return ERR_PTR(-ENOMEM);
>
> -       domain->domain =3D iommu_paging_domain_alloc(dev);
> -       if (IS_ERR(domain->domain)) {
> -               err =3D ERR_CAST(domain->domain);
> -               kfree(domain);
> +       vm->domain =3D iommu_paging_domain_alloc(dev);
> +       if (IS_ERR(vm->domain)) {
> +               err =3D ERR_CAST(vm->domain);
> +               kfree(vm);
>                 return err;
>         }
> -       kref_init(&domain->kref);
>
> -       return domain;
> +       start =3D vm->domain->geometry.aperture_start;
> +       end =3D vm->domain->geometry.aperture_end;
> +       drm_mm_init(&vm->mm, start, end - start + 1);
> +       mutex_init(&vm->lock);
> +       kref_init(&vm->kref);
> +
> +       return vm;
>  }
>
> -struct rocket_iommu_domain *
> -rocket_iommu_domain_get(struct rocket_file_priv *rocket_priv)
> +struct rocket_vm *
> +rocket_vm_get(struct rocket_file_priv *rocket_priv)
>  {
> -       kref_get(&rocket_priv->domain->kref);
> -       return rocket_priv->domain;
> +       kref_get(&rocket_priv->vm->kref);
> +       return rocket_priv->vm;
>  }
>
>  void
> -rocket_iommu_domain_put(struct rocket_iommu_domain *domain)
> +rocket_vm_put(struct rocket_vm *vm)
>  {
> -       kref_put(&domain->kref, rocket_iommu_domain_destroy);
> +       kref_put(&vm->kref, rocket_vm_destroy);
>  }
>
>  static int
> @@ -73,7 +81,6 @@ rocket_open(struct drm_device *dev, struct drm_file *fi=
le)
>  {
>         struct rocket_device *rdev =3D to_rocket_device(dev);
>         struct rocket_file_priv *rocket_priv;
> -       u64 start, end;
>         int ret;
>
>         if (!try_module_get(THIS_MODULE))
> @@ -86,29 +93,22 @@ rocket_open(struct drm_device *dev, struct drm_file *=
file)
>         }
>
>         rocket_priv->rdev =3D rdev;
> -       rocket_priv->domain =3D rocket_iommu_domain_create(rdev->cores[0]=
.dev);
> -       if (IS_ERR(rocket_priv->domain)) {
> -               ret =3D PTR_ERR(rocket_priv->domain);
> +       rocket_priv->vm =3D rocket_vm_create(rdev->cores[0].dev);
> +       if (IS_ERR(rocket_priv->vm)) {
> +               ret =3D PTR_ERR(rocket_priv->vm);
>                 goto err_free;
>         }
>
>         file->driver_priv =3D rocket_priv;
>
> -       start =3D rocket_priv->domain->domain->geometry.aperture_start;
> -       end =3D rocket_priv->domain->domain->geometry.aperture_end;
> -       drm_mm_init(&rocket_priv->mm, start, end - start + 1);
> -       mutex_init(&rocket_priv->mm_lock);
> -
>         ret =3D rocket_job_open(rocket_priv);
>         if (ret)
> -               goto err_mm_takedown;
> +               goto err_vm_put;
>
>         return 0;
>
> -err_mm_takedown:
> -       mutex_destroy(&rocket_priv->mm_lock);
> -       drm_mm_takedown(&rocket_priv->mm);
> -       rocket_iommu_domain_put(rocket_priv->domain);
> +err_vm_put:
> +       rocket_vm_put(rocket_priv->vm);
>  err_free:
>         kfree(rocket_priv);
>  err_put_mod:
> @@ -122,9 +122,7 @@ rocket_postclose(struct drm_device *dev, struct drm_f=
ile *file)
>         struct rocket_file_priv *rocket_priv =3D file->driver_priv;
>
>         rocket_job_close(rocket_priv);
> -       mutex_destroy(&rocket_priv->mm_lock);
> -       drm_mm_takedown(&rocket_priv->mm);
> -       rocket_iommu_domain_put(rocket_priv->domain);
> +       rocket_vm_put(rocket_priv->vm);
>         kfree(rocket_priv);
>         module_put(THIS_MODULE);
>  }
> diff --git a/drivers/accel/rocket/rocket_drv.h b/drivers/accel/rocket/roc=
ket_drv.h
> index 2c673bb99cc..2754f46f174 100644
> --- a/drivers/accel/rocket/rocket_drv.h
> +++ b/drivers/accel/rocket/rocket_drv.h
> @@ -11,22 +11,23 @@
>
>  extern const struct dev_pm_ops rocket_pm_ops;
>
> -struct rocket_iommu_domain {
> +struct rocket_vm {
>         struct iommu_domain *domain;
> +       struct drm_mm mm;
> +       /* protects @mm */
> +       struct mutex lock;
>         struct kref kref;
>  };
>
>  struct rocket_file_priv {
>         struct rocket_device *rdev;
>
> -       struct rocket_iommu_domain *domain;
> -       struct drm_mm mm;
> -       struct mutex mm_lock;
> +       struct rocket_vm *vm;
>
>         struct drm_sched_entity sched_entity;
>  };
>
> -struct rocket_iommu_domain *rocket_iommu_domain_get(struct rocket_file_p=
riv *rocket_priv);
> -void rocket_iommu_domain_put(struct rocket_iommu_domain *domain);
> +struct rocket_vm *rocket_vm_get(struct rocket_file_priv *rocket_priv);
> +void rocket_vm_put(struct rocket_vm *vm);
>
>  #endif
> diff --git a/drivers/accel/rocket/rocket_gem.c b/drivers/accel/rocket/roc=
ket_gem.c
> index a5fffa51ff3..057fd82e2a5 100644
> --- a/drivers/accel/rocket/rocket_gem.c
> +++ b/drivers/accel/rocket/rocket_gem.c
> @@ -14,20 +14,20 @@
>  static void rocket_gem_bo_free(struct drm_gem_object *obj)
>  {
>         struct rocket_gem_object *bo =3D to_rocket_bo(obj);
> -       struct rocket_file_priv *rocket_priv =3D bo->driver_priv;
> +       struct rocket_vm *vm =3D bo->vm;
>         size_t unmapped;
>
>         drm_WARN_ON(obj->dev, refcount_read(&bo->base.pages_use_count) > =
1);
>
> -       unmapped =3D iommu_unmap(bo->domain->domain, bo->mm.start, bo->si=
ze);
> +       unmapped =3D iommu_unmap(vm->domain, bo->mm.start, bo->size);
>         drm_WARN_ON(obj->dev, unmapped !=3D bo->size);
>
> -       mutex_lock(&rocket_priv->mm_lock);
> +       mutex_lock(&vm->lock);
>         drm_mm_remove_node(&bo->mm);
> -       mutex_unlock(&rocket_priv->mm_lock);
> +       mutex_unlock(&vm->lock);
>
> -       rocket_iommu_domain_put(bo->domain);
> -       bo->domain =3D NULL;
> +       rocket_vm_put(vm);
> +       bo->vm =3D NULL;
>
>         drm_gem_shmem_free(&bo->base);
>  }
> @@ -64,6 +64,7 @@ int rocket_ioctl_create_bo(struct drm_device *dev, void=
 *data, struct drm_file *
>         struct drm_gem_shmem_object *shmem_obj;
>         struct rocket_gem_object *rkt_obj;
>         struct drm_gem_object *gem_obj;
> +       struct rocket_vm *vm;
>         struct sg_table *sgt;
>         int ret;
>
> @@ -74,8 +75,8 @@ int rocket_ioctl_create_bo(struct drm_device *dev, void=
 *data, struct drm_file *
>         gem_obj =3D &shmem_obj->base;
>         rkt_obj =3D to_rocket_bo(gem_obj);
>
> -       rkt_obj->driver_priv =3D rocket_priv;
> -       rkt_obj->domain =3D rocket_iommu_domain_get(rocket_priv);
> +       vm =3D rocket_vm_get(rocket_priv);
> +       rkt_obj->vm =3D vm;
>         rkt_obj->size =3D args->size;
>         rkt_obj->offset =3D 0;
>
> @@ -85,15 +86,15 @@ int rocket_ioctl_create_bo(struct drm_device *dev, vo=
id *data, struct drm_file *
>                 goto err;
>         }
>
> -       mutex_lock(&rocket_priv->mm_lock);
> -       ret =3D drm_mm_insert_node_generic(&rocket_priv->mm, &rkt_obj->mm=
,
> +       mutex_lock(&vm->lock);
> +       ret =3D drm_mm_insert_node_generic(&vm->mm, &rkt_obj->mm,
>                                          rkt_obj->size, PAGE_SIZE,
>                                          0, 0);
> -       mutex_unlock(&rocket_priv->mm_lock);
> +       mutex_unlock(&vm->lock);
>         if (ret)
>                 goto err;
>
> -       ret =3D iommu_map_sgtable(rocket_priv->domain->domain,
> +       ret =3D iommu_map_sgtable(vm->domain,
>                                 rkt_obj->mm.start,
>                                 shmem_obj->sgt,
>                                 IOMMU_READ | IOMMU_WRITE);
> @@ -118,13 +119,13 @@ int rocket_ioctl_create_bo(struct drm_device *dev, =
void *data, struct drm_file *
>         return 0;
>
>  err_unmap:
> -       iommu_unmap(rocket_priv->domain->domain,
> +       iommu_unmap(vm->domain,
>                     rkt_obj->mm.start, rkt_obj->size);
>
>  err_remove_node:
> -       mutex_lock(&rocket_priv->mm_lock);
> +       mutex_lock(&vm->lock);
>         drm_mm_remove_node(&rkt_obj->mm);
> -       mutex_unlock(&rocket_priv->mm_lock);
> +       mutex_unlock(&vm->lock);
>
>  err:
>         drm_gem_shmem_object_free(gem_obj);
> diff --git a/drivers/accel/rocket/rocket_gem.h b/drivers/accel/rocket/roc=
ket_gem.h
> index 24043033450..e1fbbd8cf71 100644
> --- a/drivers/accel/rocket/rocket_gem.h
> +++ b/drivers/accel/rocket/rocket_gem.h
> @@ -9,9 +9,7 @@
>  struct rocket_gem_object {
>         struct drm_gem_shmem_object base;
>
> -       struct rocket_file_priv *driver_priv;
> -
> -       struct rocket_iommu_domain *domain;
> +       struct rocket_vm *vm;
>         struct drm_mm_node mm;
>         size_t size;
>         u32 offset;
> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index 4bc4f9c8ee4..0de56bb84e3 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -240,7 +240,7 @@ static void rocket_job_cleanup(struct kref *ref)
>                                                 refcount);
>         unsigned int i;
>
> -       rocket_iommu_domain_put(job->domain);
> +       rocket_vm_put(job->vm);
>
>         dma_fence_put(job->done_fence);
>         dma_fence_put(job->inference_done_fence);
> @@ -321,7 +321,7 @@ static struct dma_fence *rocket_job_run(struct drm_sc=
hed_job *sched_job)
>         if (ret < 0)
>                 goto err_put_fences;
>
> -       ret =3D iommu_attach_group(job->domain->domain, core->iommu_group=
);
> +       ret =3D iommu_attach_group(job->vm->domain, core->iommu_group);
>         if (ret < 0)
>                 goto err_put_pm;
>
> @@ -564,7 +564,7 @@ static int rocket_ioctl_submit_job(struct drm_device =
*dev, struct drm_file *file
>         kref_init(&rjob->refcount);
>
>         rjob->rdev =3D rdev;
> -       rjob->domain =3D rocket_iommu_domain_get(file_priv);
> +       rjob->vm =3D rocket_vm_get(file_priv);
>
>         ret =3D drm_sched_job_init(&rjob->base,
>                                  &file_priv->sched_entity,
> diff --git a/drivers/accel/rocket/rocket_job.h b/drivers/accel/rocket/roc=
ket_job.h
> index 4ae00feec3b..9373c3d0273 100644
> --- a/drivers/accel/rocket/rocket_job.h
> +++ b/drivers/accel/rocket/rocket_job.h
> @@ -36,7 +36,7 @@ struct rocket_job {
>         /* Fence to be signaled by IRQ handler when the job is complete. =
*/
>         struct dma_fence *done_fence;
>
> -       struct rocket_iommu_domain *domain;
> +       struct rocket_vm *vm;
>
>         struct kref refcount;
>  };
>
> base-commit: f00d7a241f846b053e89c0bb2285ef5988d4cafc
> --
> 2.43.0
>


--=20
Thanks,
Gyeyoung
