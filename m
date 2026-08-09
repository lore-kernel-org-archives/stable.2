Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EBC2C08D0
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 22:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786315448; cv=pass; b=Nm+6pO6C0KZoCnX/IbniCveA8xKaOdyP1uq0RX3HiIa2sUeF3mbSEgYidTAY2QsYz4jp0kqhRMJkC771JXPAmzzWLJA95GfAsJRtyjBKjoQvd3+XbxP1Sbb3TVreoQgarzVOvCaRIdHDEtQ4l0i/qVfD4QO4tUMqlH5vU67Heoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786315448; c=relaxed/simple;
	bh=yClXxy9zymvl1ITijTLT1hOKz2ATsoZesZQzHbCoaDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EuCj0/R5I+2BBgDlPrmqEjOQICYU1i0F1aguqlapPhL66yam4zuFRZeNy3XDOlOx2l0in6kgUkGqWQDFQuotQarWaZPL+FwSnyHsYNVKeroPxxPmcC1lkASehvijbEcovK0AOqK678dlUPVfinT9pSNx+vAo7T2enAIcqkWbu/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OZxTofa/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dvM8jQaL; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OZxTofa/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dvM8jQaL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786315445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UmqVXZ8uahzPyx1266WBfqTL4VwZVxprD5k6ycdBqMA=;
	b=OZxTofa/lxE1Qo0tL19ROJpZCwLSaFC+GJHFIRRnmJs/kMc1hhkLqbOm8k5UZnPPrGE3BE
	s7xnlBEPCZRzCnwtZflAmWztvYO53DS3gazo+V6n46U3YeqamMhAOg06PUhQibzPaAVUmy
	HTjNoJL5nK8ooH7YjiMvyeJMOn7tQ/0=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-28X3axDfNq2R0a1OjGLrQA-1; Sun, 09 Aug 2026 18:44:04 -0400
X-MC-Unique: 28X3axDfNq2R0a1OjGLrQA-1
X-Mimecast-MFC-AGG-ID: 28X3axDfNq2R0a1OjGLrQA_1786315443
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cb835525b13so1781488a12.1
        for <stable@vger.kernel.org>; Sun, 09 Aug 2026 15:44:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786315443; cv=none;
        d=google.com; s=arc-20260327;
        b=Bz3Et6hLMf3pmw1i+Lh7bGMyHuqnpwBYw5WwOpU75QcVqUeg80tKBzH7b5B0AxyPOo
         8uNZclLZplCp5lQAPUZM14bpaWtuogyqmnLdEPzjVVmhiQWz1Rki56hV1fzkCZdJ4W4q
         w/EIV2oP9Bfj4xLPlg2p2bUCZ9opUrhXdKOWD/mW57CDbatYRvd7SecYBwYsKoGClXTh
         yr44LlzMhwdfTLQMNXHN2GtrFRNzVHZJzGp7eYL7XixL11Ku2vXXoOJaDvrUmDf2YIDJ
         ipc8p7JJPYaAwntyXBl4HkU5FibbB2geKbY2G6VJ/JDjOODiHMowBPymoZi219cyjXYJ
         0OaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UmqVXZ8uahzPyx1266WBfqTL4VwZVxprD5k6ycdBqMA=;
        fh=UhOmR0Dy0L/tN8+YOGG8QQARNmrz599cIaihdqi9j4k=;
        b=e55dYnXj24HUA44f4vGAKdNT1NyadM5aHbLMrhbO+dT7W4JhRxu+gev7GEPaEMr4uv
         wRKNP6J/lGEgBEil9ag0K5nTFLtmVmVdhYxI40tILOgtDRMIBliwdZBRQCHQZh95oQAS
         YwYyZ28fMJpF7LjqICsBdDyVa6O70un2iL95UaHfWpt6BXr2907sMMPSAdc7Ky8kkWN+
         ABLkvhA8E/ScMHAuHDPvxjmT7pYq2Q+STv2eQWhiVIjSArLggAxhhO4n/00PEgWMfR7+
         adJ6Ae1SY8MPX2lV3+tyDe+/Q5/lK8U1gDmPmhIWvvGZiesR5KcqFq+oKlMnjZAG5Ld2
         4HUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786315443; x=1786920243; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UmqVXZ8uahzPyx1266WBfqTL4VwZVxprD5k6ycdBqMA=;
        b=dvM8jQaL/6bXS12x1fjga3AVy454rS4uBrFlfeZ2hcyULarFiP4fr4ohsYiLcSfegH
         AK698KCe6WawS9f6w41u60VnXQgBjV40hlXRhihSGTaU1xjjqXOpvj8rc6FeCHSOZMwO
         AEX9FqjcYak1i6/THDIbt5DmOipSYnN7qXszMlhgH7td0j4XjcEPzUNOAiSmkZxyuiuU
         HtmDSU9KRAlbmMBHg9XcBR1K80p4/yBVXfk278aVted7ZckwrzfGtT6/q7wgqlVlWflt
         2TlWAw5iyQYFB5VijNSnMXS0dVROr6TZFNQ1Oz3fygE0Wgfg+AbrI8QWKsvOCzTWA8Ex
         yffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786315443; x=1786920243;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UmqVXZ8uahzPyx1266WBfqTL4VwZVxprD5k6ycdBqMA=;
        b=kQb+bvjHt6u1e6m9OS20zHTCxwDjLaYT5Z3q2/A4/ZL8v3nv7iOdRGMwFXSMjQwwqM
         Jhx+BGQJ0DoX7IzuccJbMaRG4QGqRQsN4kKrWWvsjHaUrt6rmYyFx2EMXdXs/h+Eo87b
         Cl5eN4iPP4peaB9OpIY2ZkCZvMFmgrLAOYv2HhVOjaNcsv/GwVOWJX9YJ0mf5YnCOyqp
         0U+EHnemvj2V43NYpwPX7gsvjdTKhHPy37mMY/L3itf1+sNMOOQ2mwmAZL7L52soGqNy
         0VNfdU9CQEdUfI43rADXNgfq2UITqb63BYBjffpsMWM6Ju9hRj5ZgRooc9P0lHSfJYhN
         jtvw==
X-Forwarded-Encrypted: i=1; AHgh+RooT/ISjWfCQyYRrSlYy/pfbqIUdv4mjRGabmDRO74Qk8Vxhne8i/YU3p/aWvY6wOCot48lI0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrRCNrFHM9Jvc2bXSG6WbOevuPN2htkz+ISTVyUlMQ7UzFcg+U
	C1Fy9EeuB7C17rXfc2D8ljRjQDw/pfHDkqOPz7AW10OKQYnUV3KvGE4PX8iM6mTQBZVQuTFJ0/e
	cAmEQpwQZVxVosaducVtGR1x+GikWJgZGpMg3/kwaLCac2uBvskadnQUF2vHqiDqcl+kpm2C1xO
	7PjRNYTmz7I07Db3VsstHgC/vad5pwO0mF
X-Gm-Gg: AR+sD10CBNSy9hCWwdODDB62yShVEko2KeZYdhji7bHx/6GGgqu4eu/ISBKFXp3mNBl
	+BdlomvD5r4qZF5xtUu53utJZLbrJSZFozoBeFJxjXCjSyTeoJRXQcWgecEWa4FqpuSQ2eCA4IF
	6EItXilal3kfkWKd531yoz+9MOQsDQ1AXzalqwoZos9J1MCgnCtH71bUJEcWLb7wH32Z7GjJuUE
	1ckSgLEROLe9P5R
X-Received: by 2002:a05:6a21:99a3:b0:3b4:7b3d:179b with SMTP id adf61e73a8af0-3cbce751791mr16468972637.12.1786315442966;
        Sun, 09 Aug 2026 15:44:02 -0700 (PDT)
X-Received: by 2002:a05:6a21:99a3:b0:3b4:7b3d:179b with SMTP id
 adf61e73a8af0-3cbce751791mr16468925637.12.1786315442375; Sun, 09 Aug 2026
 15:44:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260808-nouveau-fixes-v1-0-c3ebdc17a89c@outlook.com> <20260808-nouveau-fixes-v1-1-c3ebdc17a89c@outlook.com>
In-Reply-To: <20260808-nouveau-fixes-v1-1-c3ebdc17a89c@outlook.com>
From: David Airlie <airlied@redhat.com>
Date: Mon, 10 Aug 2026 08:43:50 +1000
X-Gm-Features: AUfX_mz-ETmvSuEhXYjQJVDLUbKw4YbP9zK1G66hyeAQkHRWyBsRWGvM6OCpIUM
Message-ID: <CAMwc25qozGSRw8KKNzVhakH1jCNWsFS_z=mFn9hswxjdNNX0GA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/nouveau: bound sync and op counts in EXEC and VM_BIND
To: moonafterrain@outlook.com
Cc: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> From: Junrui Luo <moonafterrain@outlook.com>
>
> nouveau_exec_ucopy() and nouveau_uvmm_vm_bind_ucopy() pass user-supplied
> u32 counts to u_memcpya(). DRM_IOCTL_NOUVEAU_EXEC bounds only
> req->push_count against push_max, leaving req->wait_count and
> req->sig_count unchecked; DRM_IOCTL_NOUVEAU_VM_BIND bounds none of
> op_count, wait_count or sig_count. u_memcpya() itself only rejects
> multiplication overflow, which on 64-bit never triggers for a u32 count
> times a small element size.
>
> A wait_count of 0xffffffff therefore becomes a 64 GB vmemdup_user()
> request. Since vmemdup_user() allocates with GFP_USER and hence without
> __GFP_NOWARN, a size above INT_MAX trips the WARN_ON_ONCE() in
> __kvmalloc_node_noprof(); below that the kernel attempts an up to 2 GB
> vmalloc that GFP_USER also leaves uncharged to the caller's memcg. Both
> ioctls are DRM_RENDER_ALLOW, so any client holding a render node can
> issue this.
>
> Reject the oversized counts at the ioctl entry points, the way
> nouveau_gem_ioctl_pushbuf() and the existing push_count check already
> do, so that the client is told which limit it exceeded. Sync objects get
> NOUVEAU_MAX_SYNCS, matching both NOUVEAU_GEM_MAX_BUFFERS and the value
> xe settled on for the same field in DRM_XE_MAX_SYNCS. VM_BIND operations
> have no comparable semantic limit, so NOUVEAU_VM_BIND_MAX_OPS is set
> well above any batch size a client is expected to submit; it exists only
> to keep the copy-in allocation finite.
>
> Fixes: b88baab82871 ("drm/nouveau: implement new VM_BIND uAPI")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Assisted-by: Claude:claude-opus-5
> Cc: stable@vger.kernel.org
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>

Have you run a complete Vulkan CTS with NVK across this with no regressions?

I'm weary of those limits being too low, but I think the only app that
might push them beyond CTS would be Forza Horizon 5 or 6.

Dave.


> ---
>  drivers/gpu/drm/nouveau/nouveau_exec.c | 12 ++++++++++++
>  drivers/gpu/drm/nouveau/nouveau_uvmm.c | 18 ++++++++++++++++++
>  include/uapi/drm/nouveau_drm.h         | 18 ++++++++++++++++++
>  3 files changed, 48 insertions(+)
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_exec.c b/drivers/gpu/drm/nouveau/nouveau_exec.c
> index a08ab1cfea9b..7bdccbae53b1 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_exec.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_exec.c
> @@ -389,6 +389,18 @@ nouveau_exec_ioctl_exec(struct drm_device *dev,
>                 return nouveau_abi16_put(abi16, -EINVAL);
>         }
>
> +       if (unlikely(req->wait_count > NOUVEAU_MAX_SYNCS)) {
> +               NV_PRINTK(err, cli, "exec wait count exceeds limit: %d max %d\n",
> +                         req->wait_count, NOUVEAU_MAX_SYNCS);
> +               return nouveau_abi16_put(abi16, -EINVAL);
> +       }
> +
> +       if (unlikely(req->sig_count > NOUVEAU_MAX_SYNCS)) {
> +               NV_PRINTK(err, cli, "exec sig count exceeds limit: %d max %d\n",
> +                         req->sig_count, NOUVEAU_MAX_SYNCS);
> +               return nouveau_abi16_put(abi16, -EINVAL);
> +       }
> +
>         ret = nouveau_exec_ucopy(&args, req);
>         if (ret)
>                 goto out;
> diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> index f5e4756b4de4..bced1481674e 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> @@ -1807,6 +1807,24 @@ nouveau_uvmm_ioctl_vm_bind(struct drm_device *dev,
>         if (unlikely(!nouveau_cli_uvmm_locked(cli)))
>                 return -ENOSYS;
>
> +       if (unlikely(req->op_count > NOUVEAU_VM_BIND_MAX_OPS)) {
> +               NV_PRINTK(err, cli, "vm_bind op count exceeds limit: %d max %d\n",
> +                         req->op_count, NOUVEAU_VM_BIND_MAX_OPS);
> +               return -EINVAL;
> +       }
> +
> +       if (unlikely(req->wait_count > NOUVEAU_MAX_SYNCS)) {
> +               NV_PRINTK(err, cli, "vm_bind wait count exceeds limit: %d max %d\n",
> +                         req->wait_count, NOUVEAU_MAX_SYNCS);
> +               return -EINVAL;
> +       }
> +
> +       if (unlikely(req->sig_count > NOUVEAU_MAX_SYNCS)) {
> +               NV_PRINTK(err, cli, "vm_bind sig count exceeds limit: %d max %d\n",
> +                         req->sig_count, NOUVEAU_MAX_SYNCS);
> +               return -EINVAL;
> +       }
> +
>         ret = nouveau_uvmm_vm_bind_ucopy(&args, req);
>         if (ret)
>                 return ret;
> diff --git a/include/uapi/drm/nouveau_drm.h b/include/uapi/drm/nouveau_drm.h
> index 1fa82fa6af38..35ddf97ca873 100644
> --- a/include/uapi/drm/nouveau_drm.h
> +++ b/include/uapi/drm/nouveau_drm.h
> @@ -220,6 +220,14 @@ struct drm_nouveau_gem_cpu_fini {
>         __u32 handle;
>  };
>
> +/*
> + * NOUVEAU_MAX_SYNCS - maximum number of sync objects per ioctl
> + *
> + * The maximum value EXEC and VM_BIND accept in their wait_count and
> + * sig_count fields.
> + */
> +#define NOUVEAU_MAX_SYNCS 1024
> +
>  /**
>   * struct drm_nouveau_sync - sync object
>   *
> @@ -332,6 +340,16 @@ struct drm_nouveau_vm_bind_op {
>         __u64 range;
>  };
>
> +/*
> + * NOUVEAU_VM_BIND_MAX_OPS - maximum number of &drm_nouveau_vm_bind_ops
> + *
> + * The maximum value VM_BIND accepts in its op_count field. There is no
> + * semantic limit on the number of operations a bind may carry; this bound
> + * exists only to keep the copy-in allocation finite and is far above any
> + * batch size a client is expected to submit.
> + */
> +#define NOUVEAU_VM_BIND_MAX_OPS 65536
> +
>  /**
>   * struct drm_nouveau_vm_bind - structure for DRM_IOCTL_NOUVEAU_VM_BIND
>   */
>
> --
> 2.51.2
>
>

