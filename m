Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F9747F2D6;
	Wed,  1 Jul 2026 11:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782907069; cv=none; b=SZCSQq0iHbnFEUrq3j2UpwIXqHFsa0xVUghFWGf26qCGaHl6cfslHGAHfcAJjh93rTHrCyCm4A4k3OmOqxTlcj4NblD4LC07aI0QgBBkpbd30+/OXLOZ71+myDOSJ6KJ1sWtWZblSbQv4RNPzjPzpceeQRECKmMWJaWoPLXn1LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782907069; c=relaxed/simple;
	bh=0tp+7zcgSFtQPXo/HXnwjHM5gwirR7Xv/ZQ/pXHyyFY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mZvQcKFlqzP+IG7/drL2v2WwPGmNw5zgDWWKVtwW3qejVnhwQPlqTr/Q7WPEh3EfDU5C3RSPgjKKPHRIaV3fAL2a7PSwIcn3box/aMEbETkVsvfqsmFqvN1wj+AkpUiOhm+rsuxwBFmDwurtnptV8ZUU6ouphsz8xo1Osc+OBRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PBVOA/Ja; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PBVOA/Ja"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782907066; x=1814443066;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=0tp+7zcgSFtQPXo/HXnwjHM5gwirR7Xv/ZQ/pXHyyFY=;
  b=PBVOA/Jalt1Y6t7HJyMIQQV6YcCED/If84Pc92Wz2cGRzhO32jrBIy6o
   oXa7jLk2pNU1yyrvzc5Kvpe+Zcsv5JHSqRf0QeTMJgLRF6e4Cc+X4vyZO
   tf2AB0erYoKghv1qb1McuKxaeh/N0D45X4XzPIPYFLQ8gsobHF7BVp7Xq
   uUH6WiFDw6M0jajA/BVPBOh1ucXXexp9l8BF9wLRmxAYSQJp8INOvhb6M
   vvneqg8CeEg9haPYpUNL1UrW8/v+LwRLijhgG2yUKTaHEWViJBX53OC0l
   mOG75xznpu9T0rXbG8VLT0aNOfaJDQ/Hdyl3ejmDYVH9LGLcksmBPMTi4
   g==;
X-CSE-ConnectionGUID: rxFpfzGcTE2y9Sxixguq9w==
X-CSE-MsgGUID: FzN8hMxPTM26G0ECoDtgjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="87473377"
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; 
   d="scan'208";a="87473377"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 04:57:45 -0700
X-CSE-ConnectionGUID: OnZszanzTmCFLiGuL2vzrQ==
X-CSE-MsgGUID: 1UKXULCjQTGzTjjPWtXVOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; 
   d="scan'208";a="249899986"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO [10.245.244.120]) ([10.245.244.120])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 04:57:42 -0700
Message-ID: <d2558fc5240d47d08d6b7d35fdeeb50f9b78a292.camel@linux.intel.com>
Subject: Re: [PATCH] drm/ttm: Account for NULL pages in ttm_pool_backup
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Matthew Brost <matthew.brost@intel.com>, intel-xe@lists.freedesktop.org,
 	dri-devel@lists.freedesktop.org
Cc: Christian Koenig <christian.koenig@amd.com>, Huang Rui
 <ray.huang@amd.com>,  Matthew Auld <matthew.auld@intel.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard	
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
	 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Wed, 01 Jul 2026 13:57:28 +0200
In-Reply-To: <20260626074653.1326683-1-matthew.brost@intel.com>
References: <20260626074653.1326683-1-matthew.brost@intel.com>
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

Hi, Matt

On Fri, 2026-06-26 at 00:46 -0700, Matthew Brost wrote:
> Pages in ttm_pool_backup can be NULL, and set_pages_array_wb() cannot
> handle NULL entries. Switch to set_pages_wb() after checking for NULL
> pages.
>=20
> Fixes the following oops:
>=20
> Oops: general protection fault, kernel NULL pointer dereference 0x0:
> 0000 [#1] SMP NOPTI
> RIP: 0010:__cpa_process_fault+0xf8/0x770
> RSP: 0018:ffffc90000a87718 EFLAGS: 00010287
> RAX: 0000000000000000 RBX: ffffc90000a87868 RCX: 0000000000000000
> RDX: 0000000000001000 RSI: 0005088000000000 RDI: ffffffff827c5f34
> RBP: 0005088000000000 R08: ffffc90000a877cb R09: ffffc90000a877d0
> R10: 0000000000000000 R11: 000000000000001b R12: 000ffffffffff000
> R13: ffffc90000a87868 R14: ffffc90000a87868 R15: ffff88815b882ae0
> FS:=C2=A0 0000000000000000(0000) GS:ffff8884ec840000(0000)
> knlGS:0000000000000000
> CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f930b844000 CR3: 000000000262e003 CR4: 0000000008f70ef0
> PKRU: 55555554
> Call Trace:
> =C2=A0<TASK>
> =C2=A0__change_page_attr_set_clr+0x989/0xe90
> =C2=A0? __purge_vmap_area_lazy+0x6c/0x3a0
> =C2=A0? _vm_unmap_aliases+0x250/0x2a0
> =C2=A0set_pages_array_wb+0x7f/0x120
> =C2=A0ttm_pool_backup+0x4c9/0x5b0 [ttm]
> =C2=A0? dma_resv_wait_timeout+0x3b/0xf0
> =C2=A0ttm_tt_backup+0x32/0x60 [ttm]
> =C2=A0ttm_bo_shrink+0x66/0x110 [ttm]
> =C2=A0xe_bo_shrink_purge+0x12b/0x1b0 [xe]
> =C2=A0xe_bo_shrink+0xbb/0x270 [xe]
> =C2=A0__xe_shrinker_walk+0xf7/0x160 [xe]
> =C2=A0xe_shrinker_walk+0x9d/0xc0 [xe]
> =C2=A0xe_shrinker_scan+0x11f/0x210 [xe]
> =C2=A0do_shrink_slab+0x13b/0x270
> =C2=A0shrink_slab+0xf1/0x400
> =C2=A0shrink_node+0x352/0x8a0
> =C2=A0balance_pgdat+0x32c/0x700
> =C2=A0kswapd+0x205/0x2f0
> =C2=A0? __pfx_autoremove_wake_function+0x10/0x10
> =C2=A0? __pfx_kswapd+0x10/0x10
> =C2=A0kthread+0xd1/0x110
> =C2=A0? __pfx_kthread+0x10/0x10
> =C2=A0ret_from_fork+0x1b1/0x200
> =C2=A0? __pfx_kthread+0x10/0x10
> =C2=A0ret_from_fork_asm+0x1a/0x30
> =C2=A0</TASK>
>=20
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Huang Rui <ray.huang@amd.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> Cc: stable@vger.kernel.org
> Fixes: b63d715b8090 ("drm/ttm/pool, drm/ttm/tt: Provide a helper to
> shrink pages")
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> ---
> =C2=A0drivers/gpu/drm/ttm/ttm_pool.c | 49 +++++++++++++++++--------------=
-
> --
> =C2=A01 file changed, 24 insertions(+), 25 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c
> b/drivers/gpu/drm/ttm/ttm_pool.c
> index 682ae4f40424..ea14447411a6 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> @@ -1064,34 +1064,33 @@ long ttm_pool_backup(struct ttm_pool *pool,
> struct ttm_tt *tt,
> =C2=A0	=C2=A0=C2=A0=C2=A0 ttm_pool_uses_dma_alloc(pool) ||
> ttm_tt_is_backed_up(tt))
> =C2=A0		return -EBUSY;
> =C2=A0
> -#ifdef CONFIG_X86
> -	/* Anything returned to the system needs to be cached. */
> -	if (tt->caching !=3D ttm_cached)
> -		set_pages_array_wb(tt->pages, tt->num_pages);
> -#endif
> +	for (i =3D 0; i < tt->num_pages; i +=3D num_pages) {
> +		unsigned int order;
> =C2=A0
> -	if (tt->dma_address || flags->purge) {
> -		for (i =3D 0; i < tt->num_pages; i +=3D num_pages) {
> -			unsigned int order;
> +		page =3D tt->pages[i];
> +		if (unlikely(!page)) {
> +			num_pages =3D 1;
> +			continue;
> +		}
> =C2=A0
> -			page =3D tt->pages[i];
> -			if (unlikely(!page)) {
> -				num_pages =3D 1;
> -				continue;
> -			}
> +		order =3D ttm_pool_page_order(pool, page);
> +		num_pages =3D 1UL << order;
> =C2=A0
> -			order =3D ttm_pool_page_order(pool, page);
> -			num_pages =3D 1UL << order;
> -			if (tt->dma_address)
> -				ttm_pool_unmap(pool, tt-
> >dma_address[i],
> -					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 num_pages);
> -			if (flags->purge) {
> -				shrunken +=3D num_pages;
> -				page->private =3D 0;
> -				__free_pages_gpu_account(page,
> order, false);
> -				memset(tt->pages + i, 0,
> -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 num_pages * sizeof(*tt-
> >pages));
> -			}
> +#ifdef CONFIG_X86
> +		/* Anything returned to the system needs to be
> cached. */
> +		if (tt->caching !=3D ttm_cached)
> +			set_pages_wb(page, 1 << order);
> +#endif

As discussed otherwise, this causes one IPI per page when TLB flushing,
whereas set_pages_array_wb() causes one per array. IPIs are quite
costly, and
set_pages_array_wb() has been tailor-made to only issue one per array,
so we would want to call it on subarrays in case there are NULL
pointers and always call it in case there are no NULL pointers.

/Thomas


> +
> +		if (tt->dma_address)
> +			ttm_pool_unmap(pool, tt->dma_address[i],
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 num_pages);
> +		if (flags->purge) {
> +			shrunken +=3D num_pages;
> +			page->private =3D 0;
> +			__free_pages_gpu_account(page, order,
> false);
> +			memset(tt->pages + i, 0,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 num_pages * sizeof(*tt->pages));
> =C2=A0		}
> =C2=A0	}
> =C2=A0
