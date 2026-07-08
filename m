Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B3A43C057
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 12:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783514278; cv=none; b=HKkL1vygtIc2uYnKlWefeQw5ZQqR83Os0fuXHLUxfj3ZGR7iVAMNdzk3S4b6IZXnQjanOtw+rmmEOWJvVn101CjaV0zja+M69OLiJ+xLLQUWrfA8ZkGel2ttayqQhvW0tcPObVQYACoZGXQgxs6kM5ZSQsFirpArs8+t2nNt+f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783514278; c=relaxed/simple;
	bh=HmWZcnjkxjwGShMAnKpvXCWgZavbXkBjdSkiakMAU/Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tLG1btiF06DK6jM6xZDDth2F56R/NgD6kNE7LDXYukJGGALMQrmGKffli9UF4Vc6MgtqG6DM43ZMn6i3GtpxgGN+c+tfGPkd+lpDb9saO8D+qiFd37lEImwQEJdfrfJa63H43bPWQHJcR5DFz0pzhZ4s/EFRHSOMDKjqVxVLyU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g0JswxX7; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g0JswxX7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783514276; x=1815050276;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=HmWZcnjkxjwGShMAnKpvXCWgZavbXkBjdSkiakMAU/Q=;
  b=g0JswxX7r1MKOr1DYry6PfKbqTczOOTSSq9N4r+Q3laGsz90efCFymxm
   PKHQC8Jhz6COLnin9MSBlA22vvfDn1Ol8INtpm2cR02mBaNekSd5fSuIi
   8YgEdVWzV2VV9cCerv2ZKKRAibTsqGmzEQgO+FUYtxH3id2JkJgT0zUc+
   ACGSqPL/TbYGAQd1RVU5HqiX0s6mHb/LYPHHnjGfr5/f3aMqOEBdE4Anu
   s2nJW5AgblWDCqllFUYm6w+l/oQH20mNFynLnDC19QEm77I7vt3NJ6rpY
   sVeK6ocAWBJ/1AHICPCTj4Hwdnp9Tw6WSVhJD+6q4fa6EGldvR8IGQaN4
   g==;
X-CSE-ConnectionGUID: Pe5jl7/uR1S+F69YhIpxDw==
X-CSE-MsgGUID: aoST8LdoSIKqYdGzvykRHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="84231337"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="84231337"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 05:37:55 -0700
X-CSE-ConnectionGUID: WBSaY9xqSqCFIACNmCYwdw==
X-CSE-MsgGUID: jH2hvz0qSBqoZnPHGrYL4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="249831970"
Received: from vpanait-mobl.ger.corp.intel.com (HELO [10.245.245.113]) ([10.245.245.113])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 05:37:54 -0700
Message-ID: <df72ae4a41d526c3db1577532d13260bbe331869.camel@linux.intel.com>
Subject: Re: [PATCH v5 1/2] drm/ttm: Fix UAF on dma-buf attach failure for
 sg BOs
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Nitin Gote <nitin.r.gote@intel.com>, intel-xe@lists.freedesktop.org
Cc: stable@vger.kernel.org, Christian Konig <christian.koenig@amd.com>, 
 Matthew Auld <matthew.auld@intel.com>
Date: Wed, 08 Jul 2026 14:37:51 +0200
In-Reply-To: <20260708091512.205482-5-nitin.r.gote@intel.com>
References: <20260708091512.205482-4-nitin.r.gote@intel.com>
	 <20260708091512.205482-5-nitin.r.gote@intel.com>
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

Hi, Nitin,

On Wed, 2026-07-08 at 14:45 +0530, Nitin Gote wrote:
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
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Nitin Gote <nitin.r.gote@intel.com>

It seems you dropped the patch changelog?

Also the WARN_ON_ONCE() we discussed for last version?

/Thomas



> ---
> =C2=A0drivers/gpu/drm/ttm/ttm_bo.c | 24 +++++++++++++++---------
> =C2=A01 file changed, 15 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c
> b/drivers/gpu/drm/ttm/ttm_bo.c
> index 3980f376e3ba..f157e259dd5f 100644
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
