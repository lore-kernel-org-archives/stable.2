Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCD23FD15F
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 09:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782724717; cv=none; b=ZXfZGgBK6ICJI3Na5IjrzWrWIkZbyN42VEuSyN/84A70vW2sHJCzCrnCvmA8rJDx+0vVMAGmM/95cMIPqw+LXeg3DJt43z/rQ+rlj2RAa4EyANjh6qpFHvGNYtEeCv00/ofA6GxRqi3C19SW3ZaFeNiNa5al/EoqFnmreeCzMjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782724717; c=relaxed/simple;
	bh=VXGReo7ab2OKkmaZ2FbFu+urBDyiDuPMgysRMWQylX4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L5Cy5cNy1F/iTrmMq05YeCJu8r3OoaCOzG91SIActQ0wSBWPlM7Ct+A4brbHzAEVJ2A2gcOyg7lMoj3rdmuH/npopfXY0ipArFl9IGD5FyCuZ3yblhEdeZOmlD47VhYIwR2iYCbbOosrQ0F/DV0ZUZnJ1EBib33tV34g4xoqF6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LzGQnWFG; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LzGQnWFG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782724715; x=1814260715;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=VXGReo7ab2OKkmaZ2FbFu+urBDyiDuPMgysRMWQylX4=;
  b=LzGQnWFG7JWyJo3kF0FhzdIX4CkARFxvkLWXa4AmdM1AbDRo8rHAlHTG
   r2Ic0f7jpMZ4jsGI4AiIbJ7Vzmf+EfuIBVQIQsWn7mrOwJoPC3UmBv6UA
   wIh44pkc4VeGaca16WUna7qezj70AV5+mw890VksXK8dy0K6gKG3RaJTl
   UmdZQO4kS4ImoKZsrOlzyxSrAGferxax4tT9MyLtGBm/nngNHbsoDud22
   YeoEV/WxvReqc6++s2aZHtMsmmQORWpBvqHiMdW/oG750lopiXQVQkRnA
   HWheF1v20tB785mdWzctY3NPTjB5npGAxy4fgZdYTYfG8R3yBkbtRIMea
   A==;
X-CSE-ConnectionGUID: 8ANAt4KWQW+B+CewKhA2BA==
X-CSE-MsgGUID: sGJGXI+iQkG4UEX41vUfVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11831"; a="100843501"
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; 
   d="scan'208";a="100843501"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 02:18:34 -0700
X-CSE-ConnectionGUID: vtOm/KE8TVmRwlS0kMDFBQ==
X-CSE-MsgGUID: d3KR/EcUTDGWL8yaFbOGrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; 
   d="scan'208";a="253812014"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO [10.245.245.28]) ([10.245.245.28])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 02:18:32 -0700
Message-ID: <a034ee3637d8e2b849759b3935992f6d195ab52d.camel@linux.intel.com>
Subject: Re: [PATCH] drm/ttm: Fix UAF on dma-buf attach failure for sg BOs
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Nitin Gote <nitin.r.gote@intel.com>, intel-xe@lists.freedesktop.org
Cc: stable@vger.kernel.org, Christian Konig <christian.koenig@amd.com>, 
 Matthew Auld <matthew.auld@intel.com>
Date: Mon, 29 Jun 2026 11:18:16 +0200
In-Reply-To: <20260625055734.2831607-2-nitin.r.gote@intel.com>
References: <20260625055734.2831607-2-nitin.r.gote@intel.com>
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

On Thu, 2026-06-25 at 11:27 +0530, Nitin Gote wrote:
> When a dma-buf importer creates a ttm_bo_type_sg BO with bo-
> >base.resv
> pointing at the exporter's dma_buf->resv and dma_buf_dynamic_attach()
> fails, no dma_buf reference is held. The exporter can be freed before
> the delayed_delete worker calls dma_resv_lock(bo->base.resv), causing
> a
> use-after-free:
>=20
> =C2=A0 Oops: general protection fault, probably for non-canonical address
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x6b6b6b6b6b6b6b9c
> =C2=A0 Workqueue: ttm ttm_bo_delayed_delete [ttm]
> =C2=A0 RIP: 0010:mutex_can_spin_on_owner+0x3f/0xc0
>=20
> ttm_bo_individualize_resv() skips the resv swap for all sg BOs to
> keep
> the shared resv available for delayed_delete to release the dma-buf
> mapping. A BO whose attach never succeeded has no mapping to release,
> yet it keeps bo->base.resv pointing at the exporter resv that
> delayed_delete later locks once the exporter is gone.
>=20
> Fix this by checking bo->base.import_attach, which is only set after
> successful dma_buf_dynamic_attach(). Failed imports now individualize
> normally, so delayed_delete operates on the BO's private _resv. The
> exporter remains alive during individualize as it runs synchronously
> in ttm_bo_release(), while the gem_prime_import caller still holds
> its dma_buf reference.

I think since the bo is published on the LRU, a LRU walk can still grab
a bo reference before the prime_import caller calls put(). So this
doesn't necessarily hold?

>=20
> Closes:
> https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8023
> Fixes: d99fbd9aab62 ("drm/ttm: Always take the bo delayed cleanup
> path for imported bos")
> Cc: stable@vger.kernel.org=C2=A0# v6.8+
> Cc: Thomas Hellstrom <thomas.hellstrom@linux.intel.com>
> Cc: Christian Konig <christian.koenig@amd.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Assisted-by: GitHub_Copilot:claude-sonnet-4.6
> Signed-off-by: Nitin Gote <nitin.r.gote@intel.com>
> ---
> v3:
> - Dropped the xe-side reordering approach since importer_priv must be
> =C2=A0 valid when dma_buf_dynamic_attach() publishes the attachment.
> - Per Christian's suggestion on the v1 thread, keyed the check on
> =C2=A0 import_attach rather than removing the sg guard entirely.
> - Exporter lifetime: individualize runs synchronously inside
> =C2=A0 ttm_bo_release(), called from drm_gem_object_put() in the
> =C2=A0 gem_prime_import error path while drm_gem_prime_fd_to_handle()
> =C2=A0 still holds its dma_buf reference.
> - Fixes both xe and amdgpu in a single TTM patch.
>=20
> =C2=A0drivers/gpu/drm/ttm/ttm_bo.c | 24 +++++++++++++++---------
> =C2=A01 file changed, 15 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c
> b/drivers/gpu/drm/ttm/ttm_bo.c
> index bcd76f6bb7f0..bf8eaec0e9ca 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> @@ -196,6 +196,14 @@ static int ttm_bo_individualize_resv(struct
> ttm_buffer_object *bo)
> =C2=A0	if (bo->base.resv =3D=3D &bo->base._resv)
> =C2=A0		return 0;
> =C2=A0
> +	/*
> +	 * Successfully imported sg BOs need the shared resv for
> dma-buf
> +	 * cleanup. Failed imports have no attachment or mapping and
> can
> +	 * use the private _resv.
> +	 */
> +	if (bo->type =3D=3D ttm_bo_type_sg && bo->base.import_attach)
> +		return 0;
> +

You would still need to copy the current fences to _resv here, because
otherwise, the object can be premaurely released. It's considered idle
when the fences attached to _resv have all signaled. So this needs to
be moved below the fence duplication below.

Thanks,
Thomas



> =C2=A0	BUG_ON(!dma_resv_trylock(&bo->base._resv));
> =C2=A0
> =C2=A0	r =3D dma_resv_copy_fences(&bo->base._resv, bo->base.resv);
> @@ -203,15 +211,13 @@ static int ttm_bo_individualize_resv(struct
> ttm_buffer_object *bo)
> =C2=A0	if (r)
> =C2=A0		return r;
> =C2=A0
> -	if (bo->type !=3D ttm_bo_type_sg) {
> -		/* This works because the BO is about to be
> destroyed and nobody
> -		 * reference it any more. The only tricky case is
> the trylock on
> -		 * the resv object while holding the lru_lock.
> -		 */
> -		spin_lock(&bo->bdev->lru_lock);
> -		bo->base.resv =3D &bo->base._resv;
> -		spin_unlock(&bo->bdev->lru_lock);
> -	}
> +	/* This works because the BO is about to be destroyed and
> nobody
> +	 * references it any more. The only tricky case is the
> trylock on
> +	 * the resv object while holding the lru_lock.
> +	 */
> +	spin_lock(&bo->bdev->lru_lock);
> +	bo->base.resv =3D &bo->base._resv;
> +	spin_unlock(&bo->bdev->lru_lock);
> =C2=A0
> =C2=A0	return r;
> =C2=A0}
