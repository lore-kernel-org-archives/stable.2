Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0EC1A9B46
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 18:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791396689; cv=none; b=dTAhmyVn1FHedW4ZZcmTffviM8149BIzEimlKFDLKJzrQcJCwPvXzVEZZ5oFjpmKT4CSUB67Wk5NxfAG7DjPPaOGxnriyJbcxZfAMIQUIzMLaa9wAfKhXLDTml+Mts8OM7yfl6Zy5CuDvineyos6CPq2aPGvL2yKncjv50/74xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791396689; c=relaxed/simple;
	bh=wbybB6XQnCgbrdFW2DEhJY+tMKf7uPiWbB6SwWnVD38=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YXtU1Tm8P4n5XPmbmKhtF9KJ7jC42TmRrCGXe9kfhqbNSYld2N4EeO3xBUkv1Uo6kRiVLKWsxn/eKWsl8MyQQH2S8nQSPcHPBq5zQ1eZn62Ff1zN741umKH61J8sXqkHZ4EcOQtY4FI6arzw+1vH3+9Zu4ZwUPFd1GIgr0csIfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T7i7o0FI; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T7i7o0FI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791396687; x=1822932687;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=wbybB6XQnCgbrdFW2DEhJY+tMKf7uPiWbB6SwWnVD38=;
  b=T7i7o0FIez02HkOd5p2ugoSX++WDucXbpgHR4toLjRetUY7+BFk6zjlF
   mIUnYzfnIJ9bkqwpZCM1sxK+SvbMmJsebA4JmCkOgLiC3MLiM0VFgHmKk
   XWpbn7gWtly1CxcWUWfX84e/5rWwei2S5z2d86Kq9pbqaKcWEj8BlFvvL
   A9MY1Bm2jZ7r3ibeLbC63L9u0ONXZxWVkQ6NlHMAHfnY8V9eDFZUJnUyB
   xp1Ewwokpk6HcWIdks8K3myj34pVDCOBbYf7WWaZszZmudO1WvHAd4TAU
   bN8tq4ge9LH1EBnFuK5O7Q4hRLLeCLc3dasoStU52lmtFMYdsf5OQnAaZ
   A==;
X-CSE-ConnectionGUID: HTQQZNn9Rsaab7GDpTKYzg==
X-CSE-MsgGUID: OeHwSRg5RYqybrLftV1A4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="53911"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="53911"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 11:11:26 -0700
X-CSE-ConnectionGUID: SUvQyQgBQ0+LSaZ6F3nuDg==
X-CSE-MsgGUID: rq8sMFvWT4qQiITf9xJOlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="285593295"
Received: from abityuts-desk1.ger.corp.intel.com (HELO [10.245.245.54]) ([10.245.245.54])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 11:11:25 -0700
Message-ID: <2c6a97ac21c5ef161dbac279f9b971f383b6b944.camel@linux.intel.com>
Subject: Re: [PATCH v2 3/3] drm/xe: skip p2p for suspected display buffers
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Matthew Auld <matthew.auld@intel.com>, intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>, stable@vger.kernel.org
Date: Wed, 07 Oct 2026 20:11:22 +0200
In-Reply-To: <20261007153605.1743626-8-matthew.auld@intel.com>
References: <20261007153605.1743626-5-matthew.auld@intel.com>
	 <20261007153605.1743626-8-matthew.auld@intel.com>
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

On Wed, 2026-10-07 at 16:36 +0100, Matthew Auld wrote:
> If p2p is allowed on the CPU (like on AMD), we currently permit p2p
> for
> all exported VRAM buffers. However, in some multi-GPU setups, like
> with
> prime rendering on a dgpu and scanout/compositor using the igpu, it
> looks like the exported dma-buf window buffer can in some cases end
> up
> using p2p.
>=20
> However, user is reporting a kernel regression where performance here
> massively tanks across many games/workloads, where it looks like on
> each
> frame, the igpu is reading/sampling from VRAM over pcie for the
> window
> buffer, since it uses p2p. p2p is currently more intended for dgpu <-
> >
> dgpu, and not so much display buffers with igpu <-> dgpu, at least
> for
> now.
>=20
> We don't currently have any hints to say "please use p2p for this
> buffer, or please don't", however we can use some heuristics to try
> to
> determine if this is likely a display buffer being exported to an
> igpu,
> which probably never intended for p2p:
>=20
> =C2=A01. FLAG_SCANOUT being set on the buffer. Window buffers usually get
> =C2=A0=C2=A0=C2=A0 tagged with this, but not always.
>=20
> =C2=A02. Importer being a PCI device with display, which is not xe driver=
.
>=20
> We also rely on the existing p2p Intel CPU whitelist to stop this
> happening on xe igpu. Currently p2p is only enabled for server CPUs,
> on
> Intel. We also limit the above to dual placement buffers.
>=20
> The original regression was bisected to commit 609fc8766d68 ("dma-
> buf:
> Always build with DMABUF_MOVE_NOTIFY"), however the behaviour was
> already present when enabling that knob, so this goes back even
> further.
>=20
> User has confirmed that along with the sticky dma-buf TT placement
> fix,
> to prevent ping-ponging, the performance is back to normal.
>=20

Actually, I think this needs to be fixed on the importer side. Until we
have some some user-space hints, I don't think the exporter should
second-guess. Most sane solution IMO is if igfx importers could just
not advertise pcie p2p support?

Thanks,
Thomas

> Assisted-by: LLM
> Closes:
> https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/9415
> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel
> GPUs")
> Cc: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: <stable@vger.kernel.org> # v6.12
> ---
> =C2=A0drivers/gpu/drm/xe/xe_bo.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 =
+-
> =C2=A0drivers/gpu/drm/xe/xe_bo.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 =
+
> =C2=A0drivers/gpu/drm/xe/xe_dma_buf.c | 63 +++++++++++++++++++++++++-----=
-
> --
> =C2=A03 files changed, 51 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> index 5065a7bac39c..e63437a261cb 100644
> --- a/drivers/gpu/drm/xe/xe_bo.c
> +++ b/drivers/gpu/drm/xe/xe_bo.c
> @@ -3658,7 +3658,7 @@ int xe_gem_create_ioctl(struct drm_device *dev,
> void *data,
> =C2=A0	 * Display scanout is always non-coherent with the CPU
> cache.
> =C2=A0	 */
> =C2=A0	if (args->flags & DRM_XE_GEM_CREATE_FLAG_SCANOUT)
> -		bo_flags |=3D XE_BO_FLAG_FORCE_WC;
> +		bo_flags |=3D XE_BO_FLAG_FORCE_WC |
> XE_BO_FLAG_SCANOUT;
> =C2=A0
> =C2=A0	if (args->flags & DRM_XE_GEM_CREATE_FLAG_NO_COMPRESSION) {
> =C2=A0		if (XE_IOCTL_DBG(xe, GRAPHICS_VER(xe) < 20))
> @@ -4228,6 +4228,7 @@ int xe_bo_dumb_create(struct drm_file
> *file_priv,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DRM_XE_GEM_CPU_CACHING_WC,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> XE_BO_FLAG_VRAM_IF_DGFX(xe_device_get_root_tile(xe)) |
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 XE_BO_FLAG_FORCE_WC |
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 XE_BO_FLAG_SCANOUT |
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 XE_BO_FLAG_NEEDS_CPU_ACCESS=
, NULL);
> =C2=A0	if (IS_ERR(bo))
> =C2=A0		return PTR_ERR(bo);
> diff --git a/drivers/gpu/drm/xe/xe_bo.h b/drivers/gpu/drm/xe/xe_bo.h
> index 1ddf3b6d4a9e..6965c2655731 100644
> --- a/drivers/gpu/drm/xe/xe_bo.h
> +++ b/drivers/gpu/drm/xe/xe_bo.h
> @@ -56,6 +56,7 @@
> =C2=A0#define XE_BO_FLAG_FORCE_USER_VRAM	BIT(25)
> =C2=A0#define XE_BO_FLAG_NO_COMPRESSION	BIT(26)
> =C2=A0#define XE_BO_FLAG_NEEDS_1G		BIT(27)
> +#define XE_BO_FLAG_SCANOUT		BIT(28)
> =C2=A0
> =C2=A0/* this one is trigger internally only */
> =C2=A0#define XE_BO_FLAG_INTERNAL_TEST	BIT(30)
> diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c
> b/drivers/gpu/drm/xe/xe_dma_buf.c
> index b973579a69b8..0a347f09cee4 100644
> --- a/drivers/gpu/drm/xe/xe_dma_buf.c
> +++ b/drivers/gpu/drm/xe/xe_dma_buf.c
> @@ -36,10 +36,40 @@ static void xe_ddebug_flip_bool(const struct
> _ddebug *desc, bool *flag)
> =C2=A0#define xe_dma_buf_p2p_debug_flip(flag) do { } while (0)
> =C2=A0#endif
> =C2=A0
> +static void xe_dma_buf_move_notify(struct dma_buf_attachment
> *attach)
> +{
> +	struct drm_gem_object *obj =3D attach->importer_priv;
> +	struct xe_bo *bo =3D gem_to_xe_bo(obj);
> +	struct drm_exec *exec =3D XE_VALIDATION_UNSUPPORTED;
> +
> +	XE_WARN_ON(xe_bo_evict(bo, exec));
> +}
> +
> +static const struct dma_buf_attach_ops xe_dma_buf_attach_ops =3D {
> +	.allow_peer2peer =3D true,
> +	.invalidate_mappings =3D xe_dma_buf_move_notify
> +};
> +
> +static struct pci_dev *xe_find_parent_pci_dev(struct device *dev)
> +{
> +	while (dev) {
> +		if (dev_is_pci(dev))
> +			return to_pci_dev(dev);
> +		dev =3D dev->parent;
> +	}
> +	return NULL;
> +}
> +
> +static bool xe_dma_buf_attach_is_xe_device(struct dma_buf_attachment
> *attach)
> +{
> +	return attach->importer_ops =3D=3D &xe_dma_buf_attach_ops;
> +}
> +
> =C2=A0static int xe_dma_buf_attach(struct dma_buf *dmabuf,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0 struct dma_buf_attachment *attach)
> =C2=A0{
> =C2=A0	struct drm_gem_object *obj =3D attach->dmabuf->priv;
> +	struct xe_bo *bo =3D gem_to_xe_bo(obj);
> =C2=A0	bool verbose_p2p_dist =3D drm_debug_enabled(DRM_UT_DRIVER);
> =C2=A0
> =C2=A0	xe_dma_buf_p2p_debug_flip(&verbose_p2p_dist);
> @@ -48,7 +78,24 @@ static int xe_dma_buf_attach(struct dma_buf
> *dmabuf,
> =C2=A0	=C2=A0=C2=A0=C2=A0 pci_p2pdma_distance(to_pci_dev(obj->dev->dev), =
attach-
> >dev, verbose_p2p_dist) < 0)
> =C2=A0		attach->peer2peer =3D false;
> =C2=A0
> -	if (!attach->peer2peer &&
> !xe_bo_can_migrate(gem_to_xe_bo(obj), XE_PL_TT))
> +	if (attach->peer2peer && xe_bo_can_migrate(bo, XE_PL_TT)) {
> +		struct pci_dev *client =3D
> xe_find_parent_pci_dev(attach->dev);
> +
> +		/*
> +		 * There are perf issues with using p2p with display
> buffers,
> +		 * like with igpu (compositor) <-> dgpu (exported
> p2p window
> +		 * buffer). Probably we need some actual userspace
> hints. We
> +		 * shouldn't really assume anything. Also, note that
> some of
> +		 * these buffers are not always tagged with SCANOUT.
> +		 */
> +		if (bo->flags & XE_BO_FLAG_SCANOUT)
> +			attach->peer2peer =3D false;
> +		else if (client && pci_is_display(client) &&
> +			 !xe_dma_buf_attach_is_xe_device(attach))
> +			attach->peer2peer =3D false;
> +	}
> +
> +	if (!attach->peer2peer && !xe_bo_can_migrate(bo, XE_PL_TT))
> =C2=A0		return -EOPNOTSUPP;
> =C2=A0
> =C2=A0	xe_pm_runtime_get(to_xe_device(obj->dev));
> @@ -349,20 +396,6 @@ xe_dma_buf_create_obj(struct drm_device *dev,
> struct dma_buf *dma_buf)
> =C2=A0	return ret ? ERR_PTR(ret) : &bo->ttm.base;
> =C2=A0}
> =C2=A0
> -static void xe_dma_buf_move_notify(struct dma_buf_attachment
> *attach)
> -{
> -	struct drm_gem_object *obj =3D attach->importer_priv;
> -	struct xe_bo *bo =3D gem_to_xe_bo(obj);
> -	struct drm_exec *exec =3D XE_VALIDATION_UNSUPPORTED;
> -
> -	XE_WARN_ON(xe_bo_evict(bo, exec));
> -}
> -
> -static const struct dma_buf_attach_ops xe_dma_buf_attach_ops =3D {
> -	.allow_peer2peer =3D true,
> -	.invalidate_mappings =3D xe_dma_buf_move_notify
> -};
> -
> =C2=A0#if IS_ENABLED(CONFIG_DRM_XE_KUNIT_TEST)
> =C2=A0
> =C2=A0struct dma_buf_test_params {
