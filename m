Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E4A399CFC
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 03:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790132812; cv=pass; b=tifDOL3mYxmPI+4bRkSqOybdVl/aL5k0S1waVhu0U/1AV1C38godqQ3iv1qzc5olHG8csIeSQZJGbebxwp3NqZsFTLb/IXgu6bgUJw9lqdZlbX3ch2eDJ8m3w33fPnu7kPuSqZgviA4qAooDmSVaXSj56tw03QVVyO65Sc6YmNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790132812; c=relaxed/simple;
	bh=vT5rt2ey3w3svwWjeKYR1sh8KkF6JvEusbX1aNDa9pk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mQTvlIuyN9Q4doVZCmhd1jaFAS4lfwoZ6KJmtDrzNFuwyttm7dQALU6rSBaopKZOMK9iUpHOy18l3htykXfeqg177WKp6skKjy760E44yAahJqoV4OsM54VpTQxY0b0FajKCt+dcvewggqHDJpTWjTKIWQzs0NUJWsDnziMT7OM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tkqdbz1W; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tkqdbz1W"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-530e8c6fb80so76591cf.1
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 20:06:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790132808; cv=none;
        d=google.com; s=arc-20260327;
        b=N0s6Y9Q+GOhM6c1IE0D/YlmO4OI0elh1PLtOUQWXfIdI3WrFqfP+8Jdxwbxf1ZdYMq
         0+/NgFyjbtMNGVdGA58wJ0EC4RyRaweSP/iH0BJ/sHQZon89hWa1A7wZx88/tMYzLsfj
         qwaFfMaSNhGsv8i5zsrCJjg8x1wcPEp98hBq1JS9sKX9KjgHfxguAwchDa4gbZUZ5aLB
         sRAYKe/lsvS/fxy+DG/IBk14b1AmQlKZ4GRKH+0o+sTvcMQtSKVxL1Z3vOdjES2j2XnB
         qWZZNSU8LrRJ2NVRUReUQtk5pCV4FNw94Rlltjk4Wy2ffJk3t7jr7N71XybM7MfKuDL2
         76QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IRPbOIjea7YnALS382sxDJV2rr4g7+7CjsUb6DjUGDY=;
        fh=08mHzfxkC3aG2yiacCCUOGgPP9wkH5JWu9mJc9k/aAg=;
        b=dtvoTruoEcs+djAoYsrqFAU3cMh/twpF2TTcsHPfBvelwUVHI8I5KkUojcmLxh1NIm
         fxW2W3yjTZMKzEqTvLliMDzeHzBOnjvN51SrzL+eNnjkP1rG5s0uwYBNRRuzn6sP6ZHo
         En6sWNpydZOOHMNVmXTUx1H/TOVMhaMYFrMeXUnKRKgoVCY7l5eiU/vy8j+5Lok9W7kJ
         Ya8gjp8yBqum8TS85RTORRHwNoU+8xK8UOp29eobYtlgYSU0RdkZCpl2JmkanIo0582+
         srH5e1JiGoaYjC3+k9ElDXm3O+CvCa+NkJex3SZx6GMAE+DsebE04Fol5O1dQUVrphzC
         lNiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790132808; x=1790737608; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IRPbOIjea7YnALS382sxDJV2rr4g7+7CjsUb6DjUGDY=;
        b=tkqdbz1WTh9MLZMRkwL/260pmn7Fk+2Ky3gh9XgMW/pQdnn8Qi8tZe1JrA0UAdd8if
         AqWNe+jJqpg6YfGhr6gzYK9be11OZXLGBgO+qDqS9xvaXtiohnywhDqNrR9juqksshG6
         DK/eHo1eu4aO4OK3kMIDXRrGT75jOcAU5IqZOsxHCgNiwJ+OoSrNC895Pj1THG2xtqfX
         lOtAM+3N4GwohyfYVPhrWC93snePHqnvZW2OAuN6t24Rw2TvLXLwYHCB400pr0CBcsRq
         0/2lTpP0X2FIwZhs7Zfbx1IlsiaXbT9L8YoLoEqdErjUYsq02SJg6+Sy9cu25JXweDUr
         /Uow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790132808; x=1790737608;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IRPbOIjea7YnALS382sxDJV2rr4g7+7CjsUb6DjUGDY=;
        b=sBUe81nBc7xo895D0Vm8V5FZf0PpXIS9NfuGs783wtXHuSVVFSQdsH5qaMCyVU0UZs
         c5w9ysDAh52cXXWsUmILu6WKHCaxmbFikUCwPSQcaTeXr49nE0Gl2gaoQn+ODcQZRHRo
         F8TuzNIa9zhup9DxObqYLRsbhdf5J1EN6IKTcsp8qjPgWj4ZrY0RfdroQZbNYNz7RJ4E
         AgxH4VB+TnjP0ZhsVrZNqBlDIpwqWdT8Gq5ad4AJiPgV/gkUWtxr9azfZsWKqg4wHtD5
         rg5sd2rreLB4uG6jCcnJxAQchj7n24lzYCvMEMHxehwEZFxZpZn2CkG2GxnLcupF4XgX
         09gQ==
X-Forwarded-Encrypted: i=1; AKwUvByI/nEjJBfcNf/tR4Z7f2VWng1mjMadl/ZqLJ60cbMMVwGldrCAs4xV2+1Rtfp0bNP5l3t2MrA=@vger.kernel.org
X-Gm-Message-State: AFuF++nctAHv0ysZACrYhl20OX7DZSI9ZSAihJGExV4uVFQxUVkryMK1
	4TL6qgzseFRcweVn7laU+Jcq8C83aKMTeSkLCC6AsxpeJjn55hDupy9vdiOraStBWvVfzmkDGTR
	SGtKRP/XFTeG9Wx+pVKgk+AOrzrE2V+DlzGLMmP1c
X-Gm-Gg: AYBFou0nhYgCcP612YAA4flPZ6yxfcvdBqvrkge8IAYOOboGFW9lL/1qBTLxgN+jIDn
	p0gYiUVQ4xZyWg6GDp5JCUa0DTQ2uNh7FRfasYXgbcEjiC4ak0REcCeHBc5KgROnzEoDy2vgIjy
	GOOXoRtR4XvJdyyQbQBDIHyP6hbwNIwQQyclkrMvso0DchRGvY1oKrRCeViLLWUtCDHVouIYHQB
	0olEveZuKT0rGqqHCunY3FXRDpwZ5M5lJmZm4BoRgXG3QZJuNNWEKxITIBTqui41Bhr0aR7dRxg
	OUyj3j6yeVyEafSKrPZeXD3sSl1GdUCiNRVTyF9P7NoCpE8KOipqqOPxQZFmIVjT
X-Received: by 2002:ac8:5d92:0:b0:532:8423:1e78 with SMTP id
 d75a77b69052e-532ef021d33mr4455851cf.10.1790132807938; Tue, 22 Sep 2026
 20:06:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922023541.51532-1-hao.ge@linux.dev>
In-Reply-To: <20260922023541.51532-1-hao.ge@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 22 Sep 2026 20:06:35 -0700
X-Gm-Features: AclHuK_Ckf9BkzjT2yz5Z9Ieaus86uHwwpQxqkJxhDMBAS12Kru5JUofGg3dI-k
Message-ID: <CAJuCfpEFxn6peTwkE=orOuhSBchmuziYK1Xt75iwJo59rqYUQA@mail.gmail.com>
Subject: Re: [PATCH] netfs: Fix missing alloc tagging of direct mempool allocations
To: Hao Ge <hao.ge@linux.dev>
Cc: David Howells <dhowells@redhat.com>, Paulo Alcantara <pc@manguebit.org>, 
	"Christian Brauner (Amutable)" <brauner@kernel.org>, netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Erhard Furtner <erhard_f@mailbox.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 7:37=E2=80=AFPM Hao Ge <hao.ge@linux.dev> wrote:
>
> Commit 1d78d56c43ef ("netfs: Fix folio_queue ENOMEM in writeback by
> adding a mempool") added a mempool for the folio_queues and made the
> request, subrequest and folio_queue allocations distinguish between
> writeback and everything else.  Writeback is part of memory reclaim
> and must not fail due to ENOMEM, so it allocates under GFP_NOFS
> through mempool_alloc(), which may dip into the pool's reserve and,
> if that runs empty, wait for elements to be returned.  The
> GFP_KERNEL paths, which can return -ENOMEM to their callers, invoke
> the pool's ->alloc() callback directly instead.
>
> The direct call, however, skips the alloc_hooks() wrapper that the
> mempool_alloc() macro provides.  The pool callbacks, mempool_alloc_slab()
> and mempool_kmalloc(), call kmem_cache_alloc_noprof() and kmalloc_noprof(=
)
> and rely on current->alloc_tag having been set by the caller.  With
> CONFIG_MEM_ALLOC_PROFILING_DEBUG=3Dy this leads to
>
>     current->alloc_tag not set
>     WARNING: ./include/linux/alloc_tag.h:161 at __alloc_tagging_slab_allo=
c_hook
>     alloc_tag was not set
>     WARNING: ./include/linux/alloc_tag.h:166 at __alloc_tagging_slab_free=
_hook
>
> at allocation and free time respectively, as reported when reading
> files on a CIFS mount.  The allocations are also missing from
> /proc/allocinfo.
>
> Wrap the direct ->alloc() invocations in alloc_hooks() with the new
> netfs_mempool_alloc_noreserve() helper.  The GFP_KERNEL paths keep their
> failable allocation semantics, they just get tagged now.
>
> Fixes: 1d78d56c43ef ("netfs: Fix folio_queue ENOMEM in writeback by addin=
g a mempool")
> Reported-by: Erhard Furtner <erhard_f@mailbox.org>
> Closes: https://lore.kernel.org/all/0b004319-9ef7-437c-a4dd-174d6a9a83db@=
mailbox.org/
> Tested-by: Erhard Furtner <erhard_f@mailbox.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> ---
>  fs/netfs/internal.h       | 3 +++
>  fs/netfs/objects.c        | 4 ++--
>  fs/netfs/rolling_buffer.c | 2 +-
>  3 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
> index c79c8e69d60c..08ba7f0ebff0 100644
> --- a/fs/netfs/internal.h
> +++ b/fs/netfs/internal.h
> @@ -45,6 +45,9 @@ extern mempool_t netfs_request_pool;
>  extern mempool_t netfs_subrequest_pool;
>  extern mempool_t netfs_folioq_pool;
>
> +#define netfs_mempool_alloc_noreserve(_pool, _gfp)                      =
       \
> +       alloc_hooks((_pool)->alloc(_gfp, (_pool)->pool_data))

I think this macro should reside in include/linux/mempool.h and not be
netfs-specific. Something like:

#define mempool_alloc_noreserve(_pool, _gfp)                             \
       alloc_hooks((_pool)->alloc(_gfp, (_pool)->pool_data))

> +
>  #ifdef CONFIG_PROC_FS
>  static inline void netfs_proc_add_rreq(struct netfs_io_request *rreq)
>  {
> diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
> index 7f6a3e912602..0b509c93d4af 100644
> --- a/fs/netfs/objects.c
> +++ b/fs/netfs/objects.c
> @@ -34,7 +34,7 @@ struct netfs_io_request *netfs_alloc_request(struct add=
ress_space *mapping,
>
>                 rreq =3D mempool_alloc(mempool, gfp);
>         } else {
> -               rreq =3D mempool->alloc(gfp, mempool->pool_data);
> +               rreq =3D netfs_mempool_alloc_noreserve(mempool, gfp);
>                 if (!rreq)
>                         return ERR_PTR(-ENOMEM);
>         }
> @@ -214,7 +214,7 @@ struct netfs_io_subrequest *netfs_alloc_subrequest(st=
ruct netfs_io_request *rreq
>         struct kmem_cache *cache =3D mempool->pool_data;
>
>         if (rreq->gfp =3D=3D GFP_KERNEL)
> -               subreq =3D mempool->alloc(rreq->gfp, mempool->pool_data);
> +               subreq =3D netfs_mempool_alloc_noreserve(mempool, rreq->g=
fp);
>         else
>                 subreq =3D mempool_alloc(mempool, rreq->gfp);
>         if (!subreq)
> diff --git a/fs/netfs/rolling_buffer.c b/fs/netfs/rolling_buffer.c
> index 424e77a9a109..54867ceaa205 100644
> --- a/fs/netfs/rolling_buffer.c
> +++ b/fs/netfs/rolling_buffer.c
> @@ -29,7 +29,7 @@ struct folio_queue *netfs_folioq_alloc(unsigned int rre=
q_id, gfp_t gfp,
>         struct folio_queue *fq;
>
>         if (gfp =3D=3D GFP_KERNEL)
> -               fq =3D netfs_folioq_pool.alloc(gfp, netfs_folioq_pool.poo=
l_data);
> +               fq =3D netfs_mempool_alloc_noreserve(&netfs_folioq_pool, =
gfp);
>         else
>                 fq =3D mempool_alloc(&netfs_folioq_pool, gfp);
>         if (fq) {
> --
> 2.25.1
>
>
