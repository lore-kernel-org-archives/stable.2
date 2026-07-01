Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093BD49251A
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 12:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782910769; cv=none; b=pkK+inRqcVhJp55ZfheyhyFi0ABQHTUpJQ8Zq4e/nV2QFdFF6+DCV9VNcaCCBcby2oTwvFibq5jEAsnlbdYHtgDbiVhuaAp7CgTxztRXOkpaQ6XRnUaBk7CjDZp/SiZZ9mxz542jOgEfgDVigvzCJk6YZdcJ0ZLWg5DyVdBNfzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782910769; c=relaxed/simple;
	bh=6fo20VRXrOdo58jE/al9Koqf8jb4GjjqmMEUtkJNTTw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DeTwSBe+mZXAMp4OBeZmMdTZBIuK3TS6A/ftGKicXtPKO3n1YVUG60JUqjLMHVTQi6ZXuqiGhI9HzkmUMVTrUCgdJ/j/zw4eTTp0OtZ9fM+qFweRxjaTI1forND/DK9mQfo49lNygDTBcWcwtjuSlC3A43a4VMBQ05gbo11pZzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KhOf2v+l; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KhOf2v+l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782910768; x=1814446768;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=6fo20VRXrOdo58jE/al9Koqf8jb4GjjqmMEUtkJNTTw=;
  b=KhOf2v+lEovDXU+oyk3NUrUNfqmAwwL7UWFhSnZosy4wh43tjLqc0dOs
   DytVSjQm0ss7HmFjo01ckYs5yEfaYGp3fbhjtNAk7YEV0zAPEkc9id3AM
   qhPRudiZWQbOxWJy2qsb1fWycB3CT/6K0gnoYiXTr0stVas6kjByIySK0
   LpHV7TdNknY0wbfb2JE0XjXJhBUPWW3UVTWbf0vHy4hUxpGlm1bKfvKnW
   yF64FylNvcKXsz7WI3Mhz2eG4oERdGbpAnQ0fusvLzapR/NPQy8QRzF+L
   8H4xhsg1HI+gL3NKKE8UtrGTozecUGd1ffNWU9k8n0jAxFYHkfPCCLLOf
   A==;
X-CSE-ConnectionGUID: l54GooZ0QAqdy85LaYoW4Q==
X-CSE-MsgGUID: 9NHtcjqzSQazsfApghpt0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="83729235"
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; 
   d="scan'208";a="83729235"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 05:59:28 -0700
X-CSE-ConnectionGUID: qXCQ/+SbQtmXd8eTMgVR6w==
X-CSE-MsgGUID: VjS26tDmQnC5MDfeHwtIwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; 
   d="scan'208";a="253210494"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO [10.245.244.120]) ([10.245.244.120])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 05:59:26 -0700
Message-ID: <dfed18b63a7b6cf164b3af7f65df8b4a1b9dbdf2.camel@linux.intel.com>
Subject: Re: [PATCH] drm/ttm: Fix UAF on dma-buf attach failure for sg BOs
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Nitin Gote <nitin.r.gote@intel.com>, intel-xe@lists.freedesktop.org
Cc: stable@vger.kernel.org, Christian Konig <christian.koenig@amd.com>, 
 Matthew Auld <matthew.auld@intel.com>
Date: Wed, 01 Jul 2026 14:59:24 +0200
In-Reply-To: <20260701062559.3731993-2-nitin.r.gote@intel.com>
References: <20260701062559.3731993-2-nitin.r.gote@intel.com>
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

Hi, Nitin

On Wed, 2026-07-01 at 11:56 +0530, Nitin Gote wrote:
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
> Fix this by checking bo->base.import_attach, which is set only after
> a
> successful attach. The check is placed after dma_resv_copy_fences()
> so
> successful imports still copy fences to _resv before returning,
> keeping
> the shared resv for delayed_delete. Failed imports fall through to
> swap
> resv to _resv, so delayed_delete never locks the stale exporter resv.
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
> Hi Thomas/Christian,
> Thank you for the review. Addressed the v3 review comments in this=20
> v4 version.
>=20
> v4:
> - Moved import_attach check to after dma_resv_copy_fences() so fences
> =C2=A0 are copied before returning for successful imports (Thomas).
> - Removed exporter-alive claim from commit message (Thomas).

That's not sufficient. What I meant was that this invalidates the
approach in its current form:

A			B
prime_import()	=09
exported_get();
exported_lock();
bo_create();		lru_walk():
attach_fail();		bo_get();
bo_put();	=09
exported_unlock();	bo_lock() // exporter_lock
exporter_put();	=09
exporter_free();=09
			bo_unlock(); //UAF
		=09
There is no guarantee that the exporter stays alive until
resv individualization happens.

/Thomas


>=20
> v3:
> - Dropped the xe-side reordering approach since importer_priv must be
> =C2=A0 valid when dma_buf_dynamic_attach() publishes the attachment.
> - Per Christian's suggestion on the v1 thread, keyed the check on
> =C2=A0 import_attach rather than removing the sg guard entirely.
> - Fixes both xe and amdgpu in a single TTM patch.
>=20
> =C2=A0drivers/gpu/drm/ttm/ttm_bo.c | 24 +++++++++++++++---------
> =C2=A01 file changed, 15 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c
> b/drivers/gpu/drm/ttm/ttm_bo.c
> index bcd76f6bb7f0..9b6341f69805 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> @@ -203,15 +203,21 @@ static int ttm_bo_individualize_resv(struct
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
