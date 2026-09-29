Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B26C3AE1A6
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 07:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790668577; cv=none; b=CxNHApDFiHWsYAfSZgnhJ5sxZOSsk+9h6zTKBSqOltzVBVRi6QwODIH60dVoo+m9bc0d3H9JXiHxiZ0dFs5tQ3hy19g01Mm0od1T5WOCuR7WeXq26e11kc/N7Eeq1FtoKTcOM3H2nx/aIlYer/BnOxeq1TAFK8T4g4qxGDvudHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790668577; c=relaxed/simple;
	bh=lfKAiMHySQQh9MJ5LldYc5OFG/NXgjxM7qsge5clLfU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u0V2kUs4JrzGhMgapaDQHTKJ41zKKVt7niTj76ndZKaCAeOg8gcmHaS4HNTBOLBsbJYR3AD+KWrDfl4fGHOwKKFxoCebUm4a2R1IOfAAUVIHip6kccvHQs5sN1EphyhC2Smukla+wBtMvi7L2bmKz0aIzdfKcjmcPtZROH3b9Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A9Q6qVCf; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A9Q6qVCf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790668575; x=1822204575;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=lfKAiMHySQQh9MJ5LldYc5OFG/NXgjxM7qsge5clLfU=;
  b=A9Q6qVCfa6QcL0iNsw74/LLI8B40n2IE+ZdV1/q17cKlaam0l1GI2yyD
   VzWs9PGjhEp3PlbOcwN5GYgIoAmsmIH65FdxJRVIhccDAyOqvJM+qowz6
   krc+wDCGLuF/tR9F4AFGpHyfQZi1w1zYRvsb9dptfQlZiA1fz8X0hmxYj
   leaudP7MpqHF0Vqg4mkmvTVjixKeFYQafaoQT5v+VKbkHWnEs1kYIfJob
   ef2V6kSYteM1APmt3X22BQsiiRZSnOuHXVZknoWVl6Mu3USpQ4x3Tgm8O
   0orjSaZxwaEigIVGW6ibY8JEipF2Hm502DAO9ToAweXQY1HMJUM3cm/tD
   Q==;
X-CSE-ConnectionGUID: jgE4xFzUQaaLi08TGPMT2A==
X-CSE-MsgGUID: VOXSuqh0RnCe3EjMppvQNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="90144554"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="90144554"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 00:56:15 -0700
X-CSE-ConnectionGUID: TEqlxpfBTKCSibfsiSC0Zg==
X-CSE-MsgGUID: k+Zf64QdSCa8/JTbcVZ0kQ==
X-ExtLoop1: 1
Received: from abityuts-desk1.ger.corp.intel.com (HELO [10.245.244.222]) ([10.245.244.222])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 00:56:13 -0700
Message-ID: <70ae41bf314d518215dda1f062b609f3dfac73e4.camel@linux.intel.com>
Subject: Re: [PATCH 1/2] drm/xe/dma-buf: keep non-p2p imported buffers in
 system memory
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Matthew Brost <matthew.brost@intel.com>, Matthew Auld
	 <matthew.auld@intel.com>
Cc: intel-xe@lists.freedesktop.org, stable@vger.kernel.org
Date: Tue, 29 Sep 2026 09:56:10 +0200
In-Reply-To: <arrjupxa6R+ehYK5@gsse-cloud1.jf.intel.com>
References: <20260928164820.1237049-4-matthew.auld@intel.com>
	 <20260928164820.1237049-5-matthew.auld@intel.com>
	 <arrjupxa6R+ehYK5@gsse-cloud1.jf.intel.com>
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

On Mon, 2026-09-28 at 15:01 -0700, Matthew Brost wrote:
> On Mon, Sep 28, 2026 at 05:48:22PM +0100, Matthew Auld wrote:
> > When an exported buffer is mapped by a foreign device lacking peer-
> > to-peer
> > DMA support (such as an integrated GPU for display offload),
> > xe_dma_buf_map() migrates the buffer to XE_PL_TT so that system
> > memory
> > pages can be accessed by the importer.
> >=20
> > However, since commit 5c87fee3c96c ("drm/xe: Attempt to bring bos
> > back to
> > VRAM after eviction"), XE_PL_TT is marked with TTM_PL_FLAG_FALLBACK
> > in
> > the buffer's placement. When DMABUF_MOVE_NOTIFY was enabled by
> > default
> > (meaning dynamic attachments are no longer pinned on map), the next
> > xe_bo_validate() during render submission sees TT as a fallback
> > placement
> > and attempts to migrate the buffer back to VRAM.
> >=20
> > On the next frame, the foreign importer accesses the buffer,
> > requiring
> > another migration to TT, resulting in a continuous ping-pong
> > between
> > VRAM and system memory every frame and causing severe rendering
> > performance
> > degradations.
> >=20
> > To fix this, introduce xe_bo_migrate_tt_sticky() which records a
> > temporary sticky placement in XE_PL_TT on successful migration.
> > Subsequent
> > validations use this sticky placement to keep the buffer in system
> > memory
> > until the non-p2p attachment is detached or memory pressure forces
> > a
> > fallback to the default placement.
> >=20
> > User is reporting what looks to be exactly this, with horrible
> > performance when DMABUF_MOVE_NOTIFY was enabled by default.
> >=20
>=20
> The patch looks functionally correct but couldn't we just clear
> TTM_PL_FLAG_FALLBACK in xe_bo_migrate for certain callers? Then
> restore
> it in other places?
>=20
> Matt

Hi,

I recommended Matt to use a separate placement because the TTM flags
are hints anyway, I think, and code becomes easier to understand if we
make this more explicit. But that was just my opinion.

But anyway I see there are a couple of places we migrate where we might
need to adjust the current behaviour accordingly:

* We have migration to TT for dma-buf CPU access.
* We have migration to TT for atomic access, and then implicit
assumptions that it will be migrated to VRAM again for GPU access, I
suppose.
* We have prefetch back to VRAM.
* In what situations do we want to make eviction to TT sticky?
* If we remove stickyness, should we trigger a rebind?

This is some serious technical debt we have. We probably want to put
together a design document on this, but for the time being we need to
make sure we fix that imminent dma-buf bouncing problem.

/Thomas


>=20
> > Assisted-by: LLM
> > Link:
> > https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/9415
> > Fixes: 5c87fee3c96c ("drm/xe: Attempt to bring bos back to VRAM
> > after eviction")
> > Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> > Cc: <stable@vger.kernel.org> # v6.12+
> > Cc: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> > Cc: Matthew Brost <matthew.brost@intel.com>
> > ---
> > =C2=A0drivers/gpu/drm/xe/xe_bo.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
59
> > ++++++++++++++++++++++++++++++--
> > =C2=A0drivers/gpu/drm/xe/xe_bo.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 3 ++
> > =C2=A0drivers/gpu/drm/xe/xe_bo_types.h |=C2=A0 4 +++
> > =C2=A0drivers/gpu/drm/xe/xe_dma_buf.c=C2=A0 | 16 ++++++++-
> > =C2=A04 files changed, 79 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/xe/xe_bo.c
> > b/drivers/gpu/drm/xe/xe_bo.c
> > index 6921b6967330..1c1eab0a7434 100644
> > --- a/drivers/gpu/drm/xe/xe_bo.c
> > +++ b/drivers/gpu/drm/xe/xe_bo.c
> > @@ -3324,6 +3324,9 @@ int xe_bo_validate(struct xe_bo *bo, struct
> > xe_vm *vm, bool allow_res_evict,
> > =C2=A0		.no_wait_gpu =3D false,
> > =C2=A0		.gfp_retry_mayfail =3D true,
> > =C2=A0	};
> > +	struct ttm_placement *placement =3D bo-
> > >sticky_placement.num_placement ?
> > +					=C2=A0 &bo->sticky_placement :
> > +					=C2=A0 &bo->placement;
> > =C2=A0	int ret;
> > =C2=A0
> > =C2=A0	if (xe_bo_is_pinned(bo))
> > @@ -3340,7 +3343,12 @@ int xe_bo_validate(struct xe_bo *bo, struct
> > xe_vm *vm, bool allow_res_evict,
> > =C2=A0	xe_vm_set_validating(vm, allow_res_evict);
> > =C2=A0	trace_xe_bo_validate(bo);
> > =C2=A0	xe_validation_assert_exec(xe_bo_device(bo), exec, &bo-
> > >ttm.base);
> > -	ret =3D ttm_bo_validate(&bo->ttm, &bo->placement, &ctx);
> > +	ret =3D ttm_bo_validate(&bo->ttm, placement, &ctx);
> > +	if (ret && ret !=3D -EINTR && ret !=3D -ERESTARTSYS &&
> > +	=C2=A0=C2=A0=C2=A0 bo->sticky_placement.num_placement) {
> > +		xe_bo_reset_sticky_placement(bo);
> > +		ret =3D ttm_bo_validate(&bo->ttm, &bo->placement,
> > &ctx);
> > +	}
> > =C2=A0	xe_vm_clear_validating(vm, allow_res_evict);
> > =C2=A0
> > =C2=A0	return ret;
> > @@ -3891,6 +3899,7 @@ int xe_bo_migrate(struct xe_bo *bo, u32
> > mem_type, struct ttm_operation_ctx *tctx
> > =C2=A0	};
> > =C2=A0	struct ttm_placement placement;
> > =C2=A0	struct ttm_place requested;
> > +	int ret;
> > =C2=A0
> > =C2=A0	xe_bo_assert_held(bo);
> > =C2=A0	tctx =3D tctx ? tctx : &ctx;
> > @@ -3922,7 +3931,53 @@ int xe_bo_migrate(struct xe_bo *bo, u32
> > mem_type, struct ttm_operation_ctx *tctx
> > =C2=A0
> > =C2=A0	if (!tctx->no_wait_gpu)
> > =C2=A0		xe_validation_assert_exec(xe_bo_device(bo), exec,
> > &bo->ttm.base);
> > -	return ttm_bo_validate(&bo->ttm, &placement, tctx);
> > +	ret =3D ttm_bo_validate(&bo->ttm, &placement, tctx);
> > +	if (!ret)
> > +		xe_bo_reset_sticky_placement(bo);
> > +	return ret;
> > +}
> > +
> > +/**
> > + * xe_bo_migrate_tt_sticky - Migrate an object to TT and record
> > its placement as sticky
> > + * @bo: The buffer object to migrate.
> > + * @tctx: The ttm_operation_ctx to use for migration, or NULL for
> > default.
> > + * @exec: The drm_exec transaction to use for exhaustive eviction.
> > + *
> > + * Like xe_bo_migrate() to XE_PL_TT, but on success records the
> > resulting placement
> > + * so that subsequent validations try to keep the object in TT
> > instead of falling
> > + * back to the default placement. The stickiness is removed if
> > validation falls
> > + * back to the default placement (e.g. under memory pressure), on
> > any non-sticky
> > + * migration, or via an explicit call to
> > xe_bo_reset_sticky_placement().
> > + *
> > + * Return: 0 on success. Negative error code on failure.
> > + */
> > +int xe_bo_migrate_tt_sticky(struct xe_bo *bo,
> > +			=C2=A0=C2=A0=C2=A0 struct ttm_operation_ctx *tctx,
> > +			=C2=A0=C2=A0=C2=A0 struct drm_exec *exec)
> > +{
> > +	int ret;
> > +
> > +	ret =3D xe_bo_migrate(bo, XE_PL_TT, tctx, exec);
> > +	if (!ret) {
> > +		xe_place_from_ttm_type(XE_PL_TT, &bo-
> > >sticky_place);
> > +		bo->sticky_placement =3D (struct ttm_placement){
> > +			.num_placement =3D 1,
> > +			.placement =3D &bo->sticky_place,
> > +		};
> > +	}
> > +	return ret;
> > +}
> > +
> > +/**
> > + * xe_bo_reset_sticky_placement - Reset sticky placement for an
> > object
> > + * @bo: The buffer object whose sticky placement should be
> > cleared.
> > + *
> > + * Clear any sticky placement recorded by
> > xe_bo_migrate_tt_sticky(),
> > + * returning subsequent validations to the default placement.
> > + */
> > +void xe_bo_reset_sticky_placement(struct xe_bo *bo)
> > +{
> > +	bo->sticky_placement.num_placement =3D 0;
> > =C2=A0}
> > =C2=A0
> > =C2=A0/**
> > diff --git a/drivers/gpu/drm/xe/xe_bo.h
> > b/drivers/gpu/drm/xe/xe_bo.h
> > index 861b1be231de..7327628070f2 100644
> > --- a/drivers/gpu/drm/xe/xe_bo.h
> > +++ b/drivers/gpu/drm/xe/xe_bo.h
> > @@ -434,6 +434,9 @@ bool xe_bo_can_migrate(struct xe_bo *bo, u32
> > mem_type);
> > =C2=A0
> > =C2=A0int xe_bo_migrate(struct xe_bo *bo, u32 mem_type, struct
> > ttm_operation_ctx *ctc,
> > =C2=A0		=C2=A0 struct drm_exec *exec);
> > +int xe_bo_migrate_tt_sticky(struct xe_bo *bo, struct
> > ttm_operation_ctx *ctc,
> > +			=C2=A0=C2=A0=C2=A0 struct drm_exec *exec);
> > +void xe_bo_reset_sticky_placement(struct xe_bo *bo);
> > =C2=A0int xe_bo_evict(struct xe_bo *bo, struct drm_exec *exec);
> > =C2=A0
> > =C2=A0int xe_bo_evict_pinned(struct xe_bo *bo);
> > diff --git a/drivers/gpu/drm/xe/xe_bo_types.h
> > b/drivers/gpu/drm/xe/xe_bo_types.h
> > index 8ec4a01a0092..253a1dba55a7 100644
> > --- a/drivers/gpu/drm/xe/xe_bo_types.h
> > +++ b/drivers/gpu/drm/xe/xe_bo_types.h
> > @@ -56,6 +56,10 @@ struct xe_bo {
> > =C2=A0	struct ttm_place placements[XE_BO_MAX_PLACEMENTS];
> > =C2=A0	/** @placement: current placement for this BO */
> > =C2=A0	struct ttm_placement placement;
> > +	/** @sticky_placement: target placement from forced
> > migration */
> > +	struct ttm_placement sticky_placement;
> > +	/** @sticky_place: place for sticky_placement */
> > +	struct ttm_place sticky_place;
> > =C2=A0	/** @ggtt_node: Array of GGTT nodes if this BO is mapped
> > in the GGTTs */
> > =C2=A0	struct xe_ggtt_node *ggtt_node[XE_MAX_TILES_PER_DEVICE];
> > =C2=A0	/** @vmap: iosys map of this buffer */
> > diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c
> > b/drivers/gpu/drm/xe/xe_dma_buf.c
> > index 6a85b292dee7..b973579a69b8 100644
> > --- a/drivers/gpu/drm/xe/xe_dma_buf.c
> > +++ b/drivers/gpu/drm/xe/xe_dma_buf.c
> > @@ -59,6 +59,20 @@ static void xe_dma_buf_detach(struct dma_buf
> > *dmabuf,
> > =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct dma_buf_attachment *atta=
ch)
> > =C2=A0{
> > =C2=A0	struct drm_gem_object *obj =3D attach->dmabuf->priv;
> > +	struct xe_bo *bo =3D gem_to_xe_bo(obj);
> > +	bool has_non_p2p =3D false;
> > +	struct dma_buf_attachment *a;
> > +
> > +	dma_resv_lock(dmabuf->resv, NULL);
> > +	list_for_each_entry(a, &dmabuf->attachments, node) {
> > +		if (!a->peer2peer) {
> > +			has_non_p2p =3D true;
> > +			break;
> > +		}
> > +	}
> > +	if (!has_non_p2p)
> > +		xe_bo_reset_sticky_placement(bo);
> > +	dma_resv_unlock(dmabuf->resv);
> > =C2=A0
> > =C2=A0	xe_pm_runtime_put(to_xe_device(obj->dev));
> > =C2=A0}
> > @@ -129,7 +143,7 @@ static struct sg_table *xe_dma_buf_map(struct
> > dma_buf_attachment *attach,
> > =C2=A0
> > =C2=A0	if (!xe_bo_is_pinned(bo)) {
> > =C2=A0		if (!attach->peer2peer)
> > -			r =3D xe_bo_migrate(bo, XE_PL_TT, NULL,
> > exec);
> > +			r =3D xe_bo_migrate_tt_sticky(bo, NULL,
> > exec);
> > =C2=A0		else
> > =C2=A0			r =3D xe_bo_validate(bo, NULL, false, exec);
> > =C2=A0		if (r)
> > --=20
> > 2.55.0
> >=20
