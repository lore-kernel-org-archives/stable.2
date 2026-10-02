Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF40D3DDB0E
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 12:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790944850; cv=none; b=tNGWfsNTgwM2akA+yMV/cjDUglU1FrJA0Oe2uTdpgTJg1FB4fCucnv/qVF7YmZ73KQnX4lxWJdp82yBE6O+wdoWX0t9RgXxGI2p7lms6ZZ5h0TkdAsjmTolUIdE6OnFX9W6CpwmxBcSyBdwIUwRgMJ/VdfWWMN2DRMf+6JaD80A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790944850; c=relaxed/simple;
	bh=ckLSc2DOQUoZxFyhLHsNUj1PV9hfeiFmiswQyXqJOvk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t2629MvX4peaPHV9kzDIkAY3SZbH2TqHCn+atgPdmyDwjPynPEXXgooc3cna1844xfRg9eBPzJ1Wfg6sylReozLcDrUsQJkOK5/m0HLbZXuQVXvdHW6AFS+F416qyrQrnVFIzGvfEerKiFZwxrrAPXfzyGEImz403GmKT+KcQHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=coAh2c4c; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="coAh2c4c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790944848; x=1822480848;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=ckLSc2DOQUoZxFyhLHsNUj1PV9hfeiFmiswQyXqJOvk=;
  b=coAh2c4cUg07UYD3yBo/7MZCC01FohvuB5s+FeUvogiuYVBnFPBSq6NP
   Ah7f+5zNVo0cJNCfUxuGvwUv0Em2jtI0LE8w1dnf1eQ04RSvPBTzcFCWn
   l5vXZZLgDo2UZdtqZDaE6C0Q1W3kndMGC8NLjsgw/WhzL5nhalwFintjp
   7dIVcVK9bqusEGABVN+fvwryMzzcIJkT8MiPa0vMoY9kPzeSAdvNJVtSK
   0Vuo91NXn7IqKowJTlx7XpOUQxi1pJGjL6F1A/OF8cFMMdQjEAx7jbH4g
   n2AOnMjdz9spWM6nXLb28hyerqCyAWdEKBMov08HCtiCPYFdls8pRK87A
   w==;
X-CSE-ConnectionGUID: +D58boGrRV6xBK5juIZ5qg==
X-CSE-MsgGUID: 0R15EM+kQwaN2xhA+erafQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="108087930"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="108087930"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 05:40:47 -0700
X-CSE-ConnectionGUID: NLjwcf7OSEOdZjMeYgK5zA==
X-CSE-MsgGUID: /0gyLYx1Rly+bhlU0K8/6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="274049834"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO [10.245.244.200]) ([10.245.244.200])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 05:40:46 -0700
Message-ID: <6e68f6fd4e1b8e879b65f3746bf56cce434fdea4.camel@linux.intel.com>
Subject: Re: [PATCH 1/2] drm/xe/dma-buf: keep non-p2p imported buffers in
 system memory
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Matthew Auld <matthew.auld@intel.com>, intel-xe@lists.freedesktop.org
Cc: stable@vger.kernel.org, Matthew Brost <matthew.brost@intel.com>
Date: Fri, 02 Oct 2026 14:40:44 +0200
In-Reply-To: <20260928164820.1237049-5-matthew.auld@intel.com>
References: <20260928164820.1237049-4-matthew.auld@intel.com>
	 <20260928164820.1237049-5-matthew.auld@intel.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-2.fc43) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-09-28 at 17:48 +0100, Matthew Auld wrote:
> When an exported buffer is mapped by a foreign device lacking peer-
> to-peer
> DMA support (such as an integrated GPU for display offload),
> xe_dma_buf_map() migrates the buffer to XE_PL_TT so that system
> memory
> pages can be accessed by the importer.
>=20
> However, since commit 5c87fee3c96c ("drm/xe: Attempt to bring bos
> back to
> VRAM after eviction"), XE_PL_TT is marked with TTM_PL_FLAG_FALLBACK
> in
> the buffer's placement. When DMABUF_MOVE_NOTIFY was enabled by
> default
> (meaning dynamic attachments are no longer pinned on map), the next
> xe_bo_validate() during render submission sees TT as a fallback
> placement
> and attempts to migrate the buffer back to VRAM.
>=20
> On the next frame, the foreign importer accesses the buffer,
> requiring
> another migration to TT, resulting in a continuous ping-pong between
> VRAM and system memory every frame and causing severe rendering
> performance
> degradations.
>=20
> To fix this, introduce xe_bo_migrate_tt_sticky() which records a
> temporary sticky placement in XE_PL_TT on successful migration.
> Subsequent
> validations use this sticky placement to keep the buffer in system
> memory
> until the non-p2p attachment is detached or memory pressure forces a
> fallback to the default placement.
>=20
> User is reporting what looks to be exactly this, with horrible
> performance when DMABUF_MOVE_NOTIFY was enabled by default.
>=20
> Assisted-by: LLM
> Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/9415
> Fixes: 5c87fee3c96c ("drm/xe: Attempt to bring bos back to VRAM after
> eviction")
> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> Cc: <stable@vger.kernel.org> # v6.12+
> Cc: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>

Reviewed-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>

> ---
> =C2=A0drivers/gpu/drm/xe/xe_bo.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 59
> ++++++++++++++++++++++++++++++--
> =C2=A0drivers/gpu/drm/xe/xe_bo.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 3 ++
> =C2=A0drivers/gpu/drm/xe/xe_bo_types.h |=C2=A0 4 +++
> =C2=A0drivers/gpu/drm/xe/xe_dma_buf.c=C2=A0 | 16 ++++++++-
> =C2=A04 files changed, 79 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> index 6921b6967330..1c1eab0a7434 100644
> --- a/drivers/gpu/drm/xe/xe_bo.c
> +++ b/drivers/gpu/drm/xe/xe_bo.c
> @@ -3324,6 +3324,9 @@ int xe_bo_validate(struct xe_bo *bo, struct
> xe_vm *vm, bool allow_res_evict,
> =C2=A0		.no_wait_gpu =3D false,
> =C2=A0		.gfp_retry_mayfail =3D true,
> =C2=A0	};
> +	struct ttm_placement *placement =3D bo-
> >sticky_placement.num_placement ?
> +					=C2=A0 &bo->sticky_placement :
> +					=C2=A0 &bo->placement;
> =C2=A0	int ret;
> =C2=A0
> =C2=A0	if (xe_bo_is_pinned(bo))
> @@ -3340,7 +3343,12 @@ int xe_bo_validate(struct xe_bo *bo, struct
> xe_vm *vm, bool allow_res_evict,
> =C2=A0	xe_vm_set_validating(vm, allow_res_evict);
> =C2=A0	trace_xe_bo_validate(bo);
> =C2=A0	xe_validation_assert_exec(xe_bo_device(bo), exec, &bo-
> >ttm.base);
> -	ret =3D ttm_bo_validate(&bo->ttm, &bo->placement, &ctx);
> +	ret =3D ttm_bo_validate(&bo->ttm, placement, &ctx);
> +	if (ret && ret !=3D -EINTR && ret !=3D -ERESTARTSYS &&
> +	=C2=A0=C2=A0=C2=A0 bo->sticky_placement.num_placement) {
> +		xe_bo_reset_sticky_placement(bo);
> +		ret =3D ttm_bo_validate(&bo->ttm, &bo->placement,
> &ctx);
> +	}
> =C2=A0	xe_vm_clear_validating(vm, allow_res_evict);
> =C2=A0
> =C2=A0	return ret;
> @@ -3891,6 +3899,7 @@ int xe_bo_migrate(struct xe_bo *bo, u32
> mem_type, struct ttm_operation_ctx *tctx
> =C2=A0	};
> =C2=A0	struct ttm_placement placement;
> =C2=A0	struct ttm_place requested;
> +	int ret;
> =C2=A0
> =C2=A0	xe_bo_assert_held(bo);
> =C2=A0	tctx =3D tctx ? tctx : &ctx;
> @@ -3922,7 +3931,53 @@ int xe_bo_migrate(struct xe_bo *bo, u32
> mem_type, struct ttm_operation_ctx *tctx
> =C2=A0
> =C2=A0	if (!tctx->no_wait_gpu)
> =C2=A0		xe_validation_assert_exec(xe_bo_device(bo), exec,
> &bo->ttm.base);
> -	return ttm_bo_validate(&bo->ttm, &placement, tctx);
> +	ret =3D ttm_bo_validate(&bo->ttm, &placement, tctx);
> +	if (!ret)
> +		xe_bo_reset_sticky_placement(bo);
> +	return ret;
> +}
> +
> +/**
> + * xe_bo_migrate_tt_sticky - Migrate an object to TT and record its
> placement as sticky
> + * @bo: The buffer object to migrate.
> + * @tctx: The ttm_operation_ctx to use for migration, or NULL for
> default.
> + * @exec: The drm_exec transaction to use for exhaustive eviction.
> + *
> + * Like xe_bo_migrate() to XE_PL_TT, but on success records the
> resulting placement
> + * so that subsequent validations try to keep the object in TT
> instead of falling
> + * back to the default placement. The stickiness is removed if
> validation falls
> + * back to the default placement (e.g. under memory pressure), on
> any non-sticky
> + * migration, or via an explicit call to
> xe_bo_reset_sticky_placement().
> + *
> + * Return: 0 on success. Negative error code on failure.
> + */
> +int xe_bo_migrate_tt_sticky(struct xe_bo *bo,
> +			=C2=A0=C2=A0=C2=A0 struct ttm_operation_ctx *tctx,
> +			=C2=A0=C2=A0=C2=A0 struct drm_exec *exec)
> +{
> +	int ret;
> +
> +	ret =3D xe_bo_migrate(bo, XE_PL_TT, tctx, exec);
> +	if (!ret) {
> +		xe_place_from_ttm_type(XE_PL_TT, &bo->sticky_place);
> +		bo->sticky_placement =3D (struct ttm_placement){
> +			.num_placement =3D 1,
> +			.placement =3D &bo->sticky_place,
> +		};
> +	}
> +	return ret;
> +}
> +
> +/**
> + * xe_bo_reset_sticky_placement - Reset sticky placement for an
> object
> + * @bo: The buffer object whose sticky placement should be cleared.
> + *
> + * Clear any sticky placement recorded by xe_bo_migrate_tt_sticky(),
> + * returning subsequent validations to the default placement.
> + */
> +void xe_bo_reset_sticky_placement(struct xe_bo *bo)
> +{
> +	bo->sticky_placement.num_placement =3D 0;
> =C2=A0}
> =C2=A0
> =C2=A0/**
> diff --git a/drivers/gpu/drm/xe/xe_bo.h b/drivers/gpu/drm/xe/xe_bo.h
> index 861b1be231de..7327628070f2 100644
> --- a/drivers/gpu/drm/xe/xe_bo.h
> +++ b/drivers/gpu/drm/xe/xe_bo.h
> @@ -434,6 +434,9 @@ bool xe_bo_can_migrate(struct xe_bo *bo, u32
> mem_type);
> =C2=A0
> =C2=A0int xe_bo_migrate(struct xe_bo *bo, u32 mem_type, struct
> ttm_operation_ctx *ctc,
> =C2=A0		=C2=A0 struct drm_exec *exec);
> +int xe_bo_migrate_tt_sticky(struct xe_bo *bo, struct
> ttm_operation_ctx *ctc,
> +			=C2=A0=C2=A0=C2=A0 struct drm_exec *exec);
> +void xe_bo_reset_sticky_placement(struct xe_bo *bo);
> =C2=A0int xe_bo_evict(struct xe_bo *bo, struct drm_exec *exec);
> =C2=A0
> =C2=A0int xe_bo_evict_pinned(struct xe_bo *bo);
> diff --git a/drivers/gpu/drm/xe/xe_bo_types.h
> b/drivers/gpu/drm/xe/xe_bo_types.h
> index 8ec4a01a0092..253a1dba55a7 100644
> --- a/drivers/gpu/drm/xe/xe_bo_types.h
> +++ b/drivers/gpu/drm/xe/xe_bo_types.h
> @@ -56,6 +56,10 @@ struct xe_bo {
> =C2=A0	struct ttm_place placements[XE_BO_MAX_PLACEMENTS];
> =C2=A0	/** @placement: current placement for this BO */
> =C2=A0	struct ttm_placement placement;
> +	/** @sticky_placement: target placement from forced
> migration */
> +	struct ttm_placement sticky_placement;
> +	/** @sticky_place: place for sticky_placement */
> +	struct ttm_place sticky_place;
> =C2=A0	/** @ggtt_node: Array of GGTT nodes if this BO is mapped in
> the GGTTs */
> =C2=A0	struct xe_ggtt_node *ggtt_node[XE_MAX_TILES_PER_DEVICE];
> =C2=A0	/** @vmap: iosys map of this buffer */
> diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c
> b/drivers/gpu/drm/xe/xe_dma_buf.c
> index 6a85b292dee7..b973579a69b8 100644
> --- a/drivers/gpu/drm/xe/xe_dma_buf.c
> +++ b/drivers/gpu/drm/xe/xe_dma_buf.c
> @@ -59,6 +59,20 @@ static void xe_dma_buf_detach(struct dma_buf
> *dmabuf,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct dma_buf_attachment *attach=
)
> =C2=A0{
> =C2=A0	struct drm_gem_object *obj =3D attach->dmabuf->priv;
> +	struct xe_bo *bo =3D gem_to_xe_bo(obj);
> +	bool has_non_p2p =3D false;
> +	struct dma_buf_attachment *a;
> +
> +	dma_resv_lock(dmabuf->resv, NULL);
> +	list_for_each_entry(a, &dmabuf->attachments, node) {
> +		if (!a->peer2peer) {
> +			has_non_p2p =3D true;
> +			break;
> +		}
> +	}
> +	if (!has_non_p2p)
> +		xe_bo_reset_sticky_placement(bo);
> +	dma_resv_unlock(dmabuf->resv);
> =C2=A0
> =C2=A0	xe_pm_runtime_put(to_xe_device(obj->dev));
> =C2=A0}
> @@ -129,7 +143,7 @@ static struct sg_table *xe_dma_buf_map(struct
> dma_buf_attachment *attach,
> =C2=A0
> =C2=A0	if (!xe_bo_is_pinned(bo)) {
> =C2=A0		if (!attach->peer2peer)
> -			r =3D xe_bo_migrate(bo, XE_PL_TT, NULL, exec);
> +			r =3D xe_bo_migrate_tt_sticky(bo, NULL, exec);
> =C2=A0		else
> =C2=A0			r =3D xe_bo_validate(bo, NULL, false, exec);
> =C2=A0		if (r)
