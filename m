Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7113E4A2E3B
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 13:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789999082; cv=none; b=Ds7BC1aONneJRuIZEcKdB0Fa49bRUIbyjzuJUiQRs3NllWgZ5OUWDa6Jmpt1uCEDLOPusTVUtUCAyyXbZw3nPsH/w2cZpglCoN8p4ZWk+8OS8dB5B7s2FzbTzLcXsAaL/kM0L1MR/nKzuId+/8u9+eL8AYgSMrNpJ6D2+mNYO10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789999082; c=relaxed/simple;
	bh=X4CIZgjHO+2VErvGmXm3RXicCWQqYRcidFvptKdOGZQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tDr2bHeYQnoLWRAzQZW1Q9ZFiO/Azsc/f/Iu4qV+uxtiahmCH3LQhURsOKKzb3xe+IwstdVH8rM1xVXM6iVZblcl4FOgf5U9ys9//btzGmbGyMWOJd0jgTqg2q13+e1Y+pDGulik9Gb+mfwGvmthj90wNqz5sXW0rwtz1CM93CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZXq9tdu7; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZXq9tdu7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789999079; x=1821535079;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=X4CIZgjHO+2VErvGmXm3RXicCWQqYRcidFvptKdOGZQ=;
  b=ZXq9tdu7fOPLyqdnoZttRvtzPrOTGayCh2ckggw2nZVbePZXQnCvJ2aK
   sr7tG3cw0BahpnWUzugk0KP4uL1rkR2e4tStfY+TbEkVcxgPUq6++WL5G
   i8w+h5fPs1cjZ2vt/pfe/pRELgQyIkf6etZ7eNbE21ZaXF6yLNeQkCq7D
   dw2qhRFUw6+wNsFAS3BJJ4eWjpppMLVlC1/P4ugUlSNk7Vw81s8iQw/2Y
   d/Upork3oiVMDXPoiuAivZIKdlYJSULneODVNrRJBj2R5oDUESEJK7a7G
   N8jsjZapiOUgP+lBjL8YmrzNlzYiktkEy4nbGreA0KiqAUPMCY5f910eM
   w==;
X-CSE-ConnectionGUID: fo1R+z5sTpO91/7HU3pyGw==
X-CSE-MsgGUID: M8AcBlR1S1m5VZE05HlIYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="90379514"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="90379514"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 06:57:58 -0700
X-CSE-ConnectionGUID: nqRK0NXaTM2/w38HemOK1A==
X-CSE-MsgGUID: qeLthCnqTnyTD5B7vyXXzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="272824849"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO [10.245.244.155]) ([10.245.244.155])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 06:57:56 -0700
Message-ID: <49da6f28a4ba582d32ac6cdccd6dea65d75eefbf.camel@linux.intel.com>
Subject: Re: [PATCH v2] drm/xe: Limit sg segment size to PAGE_SIZE on Xen PV
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Szymon =?UTF-8?Q?Aceda=C5=84ski?= <accek@invisiblethingslab.com>, 
	intel-xe@lists.freedesktop.org
Cc: matthew.brost@intel.com, rodrigo.vivi@intel.com, 
	maarten.lankhorst@linux.intel.com, hch@lst.de, bob.beckett@collabora.com, 
	dri-devel@lists.freedesktop.org, marmarek@invisiblethingslab.com, 
	xen-devel@lists.xenproject.org, stable@vger.kernel.org
Date: Mon, 21 Sep 2026 15:57:49 +0200
In-Reply-To: <20260916173030.3223833-1-accek@invisiblethingslab.com>
References: <20260916173030.3223833-1-accek@invisiblethingslab.com>
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

On Wed, 2026-09-16 at 19:30 +0200, Szymon Aceda=C5=84ski wrote:
> Fix display corruption on Xen PV dom0, where DMA buffers are not
> guaranteed machine-contiguous, in which case bounce buffering kicks
> in, breaking xe's memory coherency assumptions.
>=20
> Apply the same workaround i915 carries in i915_sg_segment_size()
> since
> commit 78a07fe777c4 ("drm/i915: stop abusing swiotlb_max_segment").
>=20
> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel
> GPUs")
> Reported-by: Marek Marczykowski-G=C3=B3recki
> <marmarek@invisiblethingslab.com>
> Closes:
> https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8382
> Link: https://lore.kernel.org/xen-devel/aYtznP_tT6xNPwf-@mail-itl/
> Link:
> https://lore.kernel.org/all/20221020110308.1582518-1-hch@lst.de/=C2=A0#
> i915 counterpart
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Robert Beckett <bob.beckett@collabora.com>
> Cc: stable@vger.kernel.org=C2=A0# v6.8+
> Signed-off-by: Szymon Aceda=C5=84ski <accek@invisiblethingslab.com>
> ---
> v2:
> =C2=A0- Imperative language in the commit message (Thomas Hellstr=C3=B6m)
> =C2=A0- CC the authors of the original i915 workaround (Thomas Hellstr=C3=
=B6m)

Reviewed-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>


>=20
> =C2=A0drivers/gpu/drm/xe/xe_bo.h | 19 +++++++++++++++++++
> =C2=A01 file changed, 19 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/xe/xe_bo.h b/drivers/gpu/drm/xe/xe_bo.h
> index 290ca62..341fa93 100644
> --- a/drivers/gpu/drm/xe/xe_bo.h
> +++ b/drivers/gpu/drm/xe/xe_bo.h
> @@ -9,6 +9,8 @@
> =C2=A0#include <drm/drm_prime.h>
> =C2=A0#include <drm/ttm/ttm_tt.h>
> =C2=A0
> +#include <xen/xen.h>
> +
> =C2=A0#include "xe_bo_types.h"
> =C2=A0#include "xe_ggtt.h"
> =C2=A0#include "xe_macros.h"
> @@ -574,6 +576,23 @@ static inline unsigned int
> xe_sg_segment_size(struct device *dev)
> =C2=A0	struct scatterlist __maybe_unused sg;
> =C2=A0	size_t max =3D BIT_ULL(sizeof(sg.length) * 8) - 1;
> =C2=A0
> +	/*
> +	 * For Xen PV guests pages aren't contiguous in DMA
> (machine) address
> +	 * space.=C2=A0 The DMA API takes care of that both in
> dma_alloc_* (by
> +	 * calling into the hypervisor to make the pages contiguous)
> and in
> +	 * dma_map_* (by bounce buffering).=C2=A0 But xe (like i915, see
> commit
> +	 * 78a07fe777c4) ignores the coherency aspects of the DMA
> API and thus
> +	 * can't cope with bounce buffering actually happening, so
> add a hack
> +	 * here to force small allocations and mappings when running
> in PV
> +	 * mode on Xen.
> +	 *
> +	 * Note this will still break if bounce buffering is
> required for other
> +	 * reasons, like confidential computing hypervisors or PCIe
> root ports
> +	 * with addressing limitations.
> +	 */
> +	if (xen_pv_domain())
> +		return PAGE_SIZE;
> +
> =C2=A0	max =3D min_t(size_t, max, dma_max_mapping_size(dev));
> =C2=A0
> =C2=A0	/*
>=20
> base-commit: baafc300cd079a5210c1e70e5ea3d93518e40b38
