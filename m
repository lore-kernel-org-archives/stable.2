Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC034279EA
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 12:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783687530; cv=none; b=ibwd4iPXbWuakoBaRX++GU9oLtu2F83WVFfZRZyoga/iwIXC93Nepqeu8yMms9rVYWu6D21IIo4uL1RT4fg1ezMyIDvl64TjLV4aai1uQqifzCKzjKmdSZ8xEZikY7S9dTMI5EccCba3uUeeJW/PT6VxilW9OGZo06nrbtbbveU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783687530; c=relaxed/simple;
	bh=SiRxxfaKrEixWdVWrqPKMz9ASaj812XS3eMCabOJoz0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kbfwv6pvtZULk0/mPmou2bum9KY5suRwzfOOja+6bk3Yl3FvVD/J1V1crg9uCWJ4PGcIgV+fLBmxfe6/n9TDXrpxuH8oT7mq0qjwUWHdeE7a5vy7yQgIasCIIvQqowNIB1pIPYJOhccwK7DfEqX4gB3GXCimJfnsAN1GyNO7LCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bu5YzHf/; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bu5YzHf/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783687529; x=1815223529;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=SiRxxfaKrEixWdVWrqPKMz9ASaj812XS3eMCabOJoz0=;
  b=bu5YzHf/48FjlWO5H4RLcIsWQbKJ2l6IETyXFhVB0q4fITshISEgdE2v
   QiySc+eFWFGA76qnncZ9fVdY5Qx+MuqiKFSgPPWwFZHivaFyJLROaBZDQ
   d/dPelu+CP1/6lYHkH/S27Lt9AHU94iydxb3i0xhHjTsk/56dLfpUDEUa
   LUxd8OfSdLZf2ySNl7mqpP/FkkebBpfObXBN3Mb6Sv4HML2fTbx50fgAr
   493l02IwM5iV1yV1LsmvgE1xlQpOI1wkoZKv2MHY+PB3utbudsBFhDaoW
   BCA4dLBwCexyc706puH2/3CjNZGFDxOusow3DmFc9Gqn7z6ZsYUXghGUj
   A==;
X-CSE-ConnectionGUID: 4fJYjA5SQxG0Frq5vG9czA==
X-CSE-MsgGUID: /UwqhapiQIaaOhVDyWWkvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84354250"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84354250"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 05:45:28 -0700
X-CSE-ConnectionGUID: PU2WZrMWS/aci11mZ/1A2Q==
X-CSE-MsgGUID: yn/Bt1WwRcq1rvkwku7eoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="253147081"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO [10.245.244.151]) ([10.245.244.151])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 05:45:27 -0700
Message-ID: <5f6b7649d0bcc6bc37691708d985bdb558a66adb.camel@linux.intel.com>
Subject: Re: [PATCH] drm/xe: Hold a dma-buf reference for imported BOs
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Nitin Gote <nitin.r.gote@intel.com>, intel-xe@lists.freedesktop.org
Cc: stable@vger.kernel.org, Christian Konig <christian.koenig@amd.com>, 
 Matthew Auld <matthew.auld@intel.com>
Date: Fri, 10 Jul 2026 14:45:24 +0200
In-Reply-To: <20260710093726.43324-2-nitin.r.gote@intel.com>
References: <20260710093726.43324-2-nitin.r.gote@intel.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-07-10 at 15:07 +0530, Nitin Gote wrote:
> An imported dma-buf BO is created as a ttm_bo_type_sg BO whose
> reservation object is the exporter's dma_buf->resv. The importer,
> however, only takes a dma-buf reference after a successful
> dma_buf_dynamic_attach(). Until then nothing keeps the exporter
> alive,
> so if the exporter is freed while the BO still references its resv, a
> later access to that resv is a use-after-free:
>=20
> =C2=A0 Oops: general protection fault, probably for non-canonical address
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x6b6b6b6b6b6b6b9c
> =C2=A0 Workqueue: ttm ttm_bo_delayed_delete [ttm]
> =C2=A0 RIP: 0010:mutex_can_spin_on_owner+0x3f/0xc0
>=20
> This can be reached on two paths:
>=20
> =C2=A0- dma_buf_dynamic_attach() fails, or
> =C2=A0- ttm_bo_init_reserved() fails during BO creation.
>=20
> In both cases the BO already has bo->base.resv pointing at the
> exporter
> resv, and sg BOs are always torn down via ttm_bo_delayed_delete(),
> which
> locks bo->base.resv asynchronously - potentially after the exporter
> has
> been freed.
>=20
> Take the dma-buf reference in xe_bo_init_locked(), before
> ttm_bo_init_reserved(), so it also covers a creation failure there,
> and
> release it in xe_ttm_bo_destroy(). The reference is held for the
> whole
> BO lifetime, keeping the shared resv alive on every path.
>=20
> Closes:
> https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8023
> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel
> GPUs")
> Cc: stable@vger.kernel.org
> Cc: Thomas Hellstrom <thomas.hellstrom@linux.intel.com>
> Cc: Christian Konig <christian.koenig@amd.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Suggested-by: Thomas Hellstrom <thomas.hellstrom@linux.intel.com>
> Assisted-by: GitHub_Copilot:claude-sonnet-4.6
> Signed-off-by: Nitin Gote <nitin.r.gote@intel.com>
> ---
> Thank you Thomas for suggesting this simpler approach over the
> earlier
> TTM/LRU handling.
>=20
> v6:
> =C2=A0- Reworked the fix based on Thomas' suggestion. Instead of the TTM
> resv
> =C2=A0=C2=A0 individualization (v1-v5) plus the xe off-LRU/placement hand=
ling
> (v5),
> =C2=A0=C2=A0 just hold a dma-buf reference for the imported BO lifetime s=
o the
> =C2=A0=C2=A0 shared resv can never be freed while the BO still references=
 it.
> =C2=A0=C2=A0 Single xe patch, no TTM change. (Thomas)
> =C2=A0- Take the reference in xe_bo_init_locked() before
> ttm_bo_init_reserved()
> =C2=A0=C2=A0 so a TTM creation failure is covered too (Thomas).
> =C2=A0- Dropped the v5 series (drm/ttm + drm/xe off-LRU); the off-LRU
> approach
> =C2=A0=C2=A0 also regressed in CI BAT via ttm_bo_pipeline_gutting() creat=
ing a
> ghost
> =C2=A0=C2=A0 BO that outlived the exporter.
> =C2=A0=C2=A0 Link to v5: https://patchwork.freedesktop.org/series/169984/
> =C2=A0=C2=A0=20
> v5:
> =C2=A0- Add drm/xe patch to keep imported sg BOs off the LRU before attac=
h
> =C2=A0=C2=A0 succeeds; the TTM fix alone is not sufficient for xe if the =
BO is
> =C2=A0=C2=A0 already LRU-visible. (Thomas)
> =C2=A0=C2=A0 v4 patch:
> =C2=A0=C2=A0
> https://patchwork.freedesktop.org/patch/736663/?series=3D169129&rev=3D2
> =C2=A0 - Patch 1 (drm/ttm) carries Christian's Reviewed-by from v4.
>=20
> v4:
> =C2=A0- Moved import_attach check to after dma_resv_copy_fences() so
> fences
> =C2=A0=C2=A0 are copied before returning for successful imports (Thomas).
> =C2=A0- Removed exporter-alive claim from commit message (Thomas).
>=20
> v3:
> =C2=A0- Dropped the xe-side reordering approach since importer_priv must
> be
> =C2=A0=C2=A0 valid when dma_buf_dynamic_attach() publishes the attachment=
.
> =C2=A0- Per Christian's suggestion on the v1 thread, keyed the check on
> =C2=A0=C2=A0 import_attach rather than removing the sg guard entirely.
> =C2=A0- Fixes both xe and amdgpu in a single TTM patch.

We typically place the changelog above the ___ for xe, so it is kept in
the commit message. And in the reverse order so v3 comes first.

With that fixed,
Reviewed-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>


>=20
>=20
> =C2=A0drivers/gpu/drm/xe/xe_bo.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 24=
 ++++++++++++++++++++----
> =C2=A0drivers/gpu/drm/xe/xe_bo.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 3 ++-
> =C2=A0drivers/gpu/drm/xe/xe_bo_types.h |=C2=A0 2 ++
> =C2=A0drivers/gpu/drm/xe/xe_dma_buf.c=C2=A0 |=C2=A0 2 +-
> =C2=A04 files changed, 25 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> index 85e6d9a0f575..ae730bd6f4b2 100644
> --- a/drivers/gpu/drm/xe/xe_bo.c
> +++ b/drivers/gpu/drm/xe/xe_bo.c
> @@ -1349,7 +1349,7 @@ int xe_bo_notifier_prepare_pinned(struct xe_bo
> *bo)
> =C2=A0		backup =3D xe_bo_init_locked(xe, NULL, NULL, bo-
> >ttm.base.resv, NULL, xe_bo_size(bo),
> =C2=A0					=C2=A0=C2=A0
> DRM_XE_GEM_CPU_CACHING_WB, ttm_bo_type_kernel,
> =C2=A0					=C2=A0=C2=A0 XE_BO_FLAG_SYSTEM |
> XE_BO_FLAG_NEEDS_CPU_ACCESS |
> -					=C2=A0=C2=A0 XE_BO_FLAG_PINNED,
> &exec);
> +					=C2=A0=C2=A0 XE_BO_FLAG_PINNED, NULL,
> &exec);
> =C2=A0		if (IS_ERR(backup)) {
> =C2=A0			drm_exec_retry_on_contention(&exec);
> =C2=A0			ret =3D PTR_ERR(backup);
> @@ -1490,7 +1490,7 @@ int xe_bo_evict_pinned(struct xe_bo *bo)
> =C2=A0						=C2=A0=C2=A0 xe_bo_size(bo),
> =C2=A0						=C2=A0=C2=A0
> DRM_XE_GEM_CPU_CACHING_WB, ttm_bo_type_kernel,
> =C2=A0						=C2=A0=C2=A0 XE_BO_FLAG_SYSTEM
> | XE_BO_FLAG_NEEDS_CPU_ACCESS |
> -						=C2=A0=C2=A0
> XE_BO_FLAG_PINNED, &exec);
> +						=C2=A0=C2=A0
> XE_BO_FLAG_PINNED, NULL, &exec);
> =C2=A0			if (IS_ERR(backup)) {
> =C2=A0				drm_exec_retry_on_contention(&exec);
> =C2=A0				ret =3D PTR_ERR(backup);
> @@ -1826,6 +1826,8 @@ static void xe_ttm_bo_destroy(struct
> ttm_buffer_object *ttm_bo)
> =C2=A0
> =C2=A0	if (bo->ttm.base.import_attach)
> =C2=A0		drm_prime_gem_destroy(&bo->ttm.base, NULL);
> +	if (bo->dma_buf)
> +		dma_buf_put(bo->dma_buf);
> =C2=A0	drm_gem_object_release(&bo->ttm.base);
> =C2=A0
> =C2=A0	xe_assert(xe, list_empty(&ttm_bo->base.gpuva.list));
> @@ -2283,6 +2285,8 @@ void xe_bo_free(struct xe_bo *bo)
> =C2=A0 * @cpu_caching: The cpu caching used for system memory backing
> store.
> =C2=A0 * @type: The TTM buffer object type.
> =C2=A0 * @flags: XE_BO_FLAG_ flags.
> + * @dma_buf: The dma-buf to reference for the BO lifetime (imported
> BOs),
> + * or NULL.
> =C2=A0 * @exec: The drm_exec transaction to use for exhaustive eviction.
> =C2=A0 *
> =C2=A0 * Initialize or create an xe buffer object. On failure, any
> allocated buffer
> @@ -2294,7 +2298,8 @@ struct xe_bo *xe_bo_init_locked(struct
> xe_device *xe, struct xe_bo *bo,
> =C2=A0				struct xe_tile *tile, struct
> dma_resv *resv,
> =C2=A0				struct ttm_lru_bulk_move *bulk,
> size_t size,
> =C2=A0				u16 cpu_caching, enum ttm_bo_type
> type,
> -				u32 flags, struct drm_exec *exec)
> +				u32 flags, struct dma_buf *dma_buf,
> +				struct drm_exec *exec)
> =C2=A0{
> =C2=A0	struct ttm_operation_ctx ctx =3D {
> =C2=A0		.interruptible =3D true,
> @@ -2383,6 +2388,17 @@ struct xe_bo *xe_bo_init_locked(struct
> xe_device *xe, struct xe_bo *bo,
> =C2=A0	placement =3D (type =3D=3D ttm_bo_type_sg ||
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0 bo->flags & XE_BO_FLAG_DEFER_BACKING) ?
> &sys_placement :
> =C2=A0		&bo->placement;
> +
> +	/*
> +	 * For imported BOs, keep the exporter dma-buf alive for the
> BO
> +	 * lifetime. Taken before ttm_bo_init_reserved() to also
> cover a
> +	 * creation failure there. Released in xe_ttm_bo_destroy().
> +	 */
> +	if (dma_buf) {
> +		get_dma_buf(dma_buf);
> +		bo->dma_buf =3D dma_buf;
> +	}
> +
> =C2=A0	err =3D ttm_bo_init_reserved(&xe->ttm, &bo->ttm, type,
> =C2=A0				=C2=A0=C2=A0 placement, alignment,
> =C2=A0				=C2=A0=C2=A0 &ctx, NULL, resv,
> xe_ttm_bo_destroy);
> @@ -2500,7 +2516,7 @@ __xe_bo_create_locked(struct xe_device *xe,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vm && !xe_vm_in_fault_mode(=
vm) &&
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags & XE_BO_FLAG_USER ?
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &vm->lru_bulk_move : NULL, =
size,
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu_caching, type, flags, exec);
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu_caching, type, flags, NULL,
> exec);
> =C2=A0	if (IS_ERR(bo))
> =C2=A0		return bo;
> =C2=A0
> diff --git a/drivers/gpu/drm/xe/xe_bo.h b/drivers/gpu/drm/xe/xe_bo.h
> index 6340317f7d2e..7ae1d9ac0574 100644
> --- a/drivers/gpu/drm/xe/xe_bo.h
> +++ b/drivers/gpu/drm/xe/xe_bo.h
> @@ -118,7 +118,8 @@ struct xe_bo *xe_bo_init_locked(struct xe_device
> *xe, struct xe_bo *bo,
> =C2=A0				struct xe_tile *tile, struct
> dma_resv *resv,
> =C2=A0				struct ttm_lru_bulk_move *bulk,
> size_t size,
> =C2=A0				u16 cpu_caching, enum ttm_bo_type
> type,
> -				u32 flags, struct drm_exec *exec);
> +				u32 flags, struct dma_buf *dma_buf,
> +				struct drm_exec *exec);
> =C2=A0struct xe_bo *xe_bo_create_locked(struct xe_device *xe, struct
> xe_tile *tile,
> =C2=A0				=C2=A0 struct xe_vm *vm, size_t size,
> =C2=A0				=C2=A0 enum ttm_bo_type type, u32 flags,
> diff --git a/drivers/gpu/drm/xe/xe_bo_types.h
> b/drivers/gpu/drm/xe/xe_bo_types.h
> index fcc63ae3f455..e45f24301050 100644
> --- a/drivers/gpu/drm/xe/xe_bo_types.h
> +++ b/drivers/gpu/drm/xe/xe_bo_types.h
> @@ -36,6 +36,8 @@ struct xe_bo {
> =C2=A0	struct xe_bo *backup_obj;
> =C2=A0	/** @parent_obj: Ref to parent bo if this a backup_obj */
> =C2=A0	struct xe_bo *parent_obj;
> +	/** @dma_buf: Imported dma-buf ref to keep its resv alive.
> */
> +	struct dma_buf *dma_buf;
> =C2=A0	/** @flags: flags for this buffer object */
> =C2=A0	u32 flags;
> =C2=A0	/** @vm: VM this BO is attached to, for extobj this will be
> NULL */
> diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c
> b/drivers/gpu/drm/xe/xe_dma_buf.c
> index 8a920e58245c..bf0728838ead 100644
> --- a/drivers/gpu/drm/xe/xe_dma_buf.c
> +++ b/drivers/gpu/drm/xe/xe_dma_buf.c
> @@ -302,7 +302,7 @@ xe_dma_buf_create_obj(struct drm_device *dev,
> struct dma_buf *dma_buf)
> =C2=A0
> =C2=A0		bo =3D xe_bo_init_locked(xe, NULL, NULL, resv, NULL,
> dma_buf->size,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0, /* Will require 1way or
> 2way for vm_bind */
> -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ttm_bo_type_sg,
> XE_BO_FLAG_SYSTEM, &exec);
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ttm_bo_type_sg,
> XE_BO_FLAG_SYSTEM, dma_buf, &exec);
> =C2=A0		drm_exec_retry_on_contention(&exec);
> =C2=A0		if (IS_ERR(bo)) {
> =C2=A0			ret =3D PTR_ERR(bo);
