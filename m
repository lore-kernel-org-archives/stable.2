Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795599025;
	b=gTfD0stjeywJeyqQN9ZeXMKNMX52p/f8doHIfSm98jS1ScGhw4/f+A1OCwSIVCh9WIdP
	 iRQP8+S/fRF6hdEfZ5gtYVF3g9bh2p1RZgM+insWc8r9MRL2wpp8C3zxFjNU6nX+8inmi
	 iiMnEmM8XHVFM8C1mHDKx8pMYsQWtKb0Lyo5E/2GtdPVhxv5aHwo+Ws91lMntEeof5COl
	 ul7Vr6a9AEA8knHmTGknZHJZoMcXWzvHWliq8Oj3e3ZMIHKsKKGbRIfBNoN3h/PUB/osZ
	 bpq3R8NSjEEQPkRrIDtjUynY+gPgOcR1qDpZMkg9s4vvb/tyYbMWy3oaBXI+CDLw3BQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795599025;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Organization:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=JKxh88F6dRiIcXdkH+/FSpX9Lkgq5tvH4g/JyFUkNuY=;
	b=U1t3T7G4jvD2a80Sk74rzElxOcwDXy7RDJhcl26PG/hIFmp5Ntm+eTVg7I3MWOMfLWwB
	 yZvvp/GZDOvhpfFKsEHRP55uemjQa3OlRC7WOpID385LmNHjYYtvneMyf2DwU/tIZl+Po
	 UaJ3TSaloL9QKtq+LpwY/dvfwNNOk0k0GRZfCnFCbyVZpvgUjbXVWQHeO+yt0KTC2reed
	 dnDiq0w6or1Rg4ZE66IN9pUrnEnDnZtOribXEhn8bAiZicb4UEUCLkXg+ERn5wo2njnyE
	 KpEfS6VFXKGLC2XmHXHFqz9dpxDlVwVDnCuWgH3b6zCVkfM0KWbewZsnOzT8MxTOdaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="V1cbHs/8";
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B63606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 09:30:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67B63606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=V1cbHs/8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795599025; x=1827135025;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=vPbcWRXjk1j1FDWa+zwyp6LEy+c61CsZ1Bm18ReOA08=;
  b=V1cbHs/8iboHzWXdpUTKmmzCOsTOL9f4aNZ3JesLFXd15O0qxl5Eiw5g
   oNvqVE4KcvMKwJ8gOGZT9+KheufeQcuswLlHIWefUpk/ccs5Dee7S0q+K
   I3qo61lQeYvrdzGCg1w+ln6RC53kBZmS0qn0hEF3bl2afeRPVPvb4MoZ2
   EoMSUxfQDeHpY2AgAEwFqSAhEAkH3vSo3maFnGy2yi+4Zk65LUY41jxzM
   Ca8q9dQwHwbYhevPfc6rUPw83qyiA9MoDDpmuIYKUfHJcO90pVeg6OG6W
   5pufQtrxKhRtIIVfSAJgc8T3hhzpmJ44svzFXnTHCD5FzoeYZyJHRvn/K
   A==;
X-CSE-ConnectionGUID: 7N6pvzBTROCZ29NYu0Qf7w==
X-CSE-MsgGUID: 4uu5JVslTIm/vuJfOY78lg==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4530794"
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="4530794"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 01:30:23 -0800
X-CSE-ConnectionGUID: 9DX7M7rMSvuNzkVuLATd4w==
X-CSE-MsgGUID: 3ry8CE2ZQtiwRqhFQltQvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="11942339"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO [10.245.244.62]) ([10.245.244.62])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 01:30:06 -0800
Message-ID: <0fd01434a65f928fe6799e7c7193d6ff9191805f.camel@linux.intel.com>
Subject: Re: [PATCH] drm/ttm: Destroy the ttm_tt in ttm_bo_move_null() when
 it's no longer needed
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Matthew Brost <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, Natalie Vock <nat@pixelcluster.dev>, 
 Arun Pravin <arunpravin.paneerselvam@amd.com>, Matthew Auld
 <matthew.auld@intel.com>, 	dri-devel@lists.freedesktop.org,
 stable@vger.kernel.org
Date: Wed, 25 Nov 2026 10:30:03 +0100
In-Reply-To: <awXrVdQKNToiLtmE@gsse-cloud1.jf.intel.com>
References: <20261124190954.47690-1-thomas.hellstrom@linux.intel.com>
	 <awXrVdQKNToiLtmE@gsse-cloud1.jf.intel.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-2.fc43) 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, 2026-11-24 at 11:53 -0800, Matthew Brost wrote:
> On Tue, Nov 24, 2026 at 08:09:54PM +0100, Thomas Hellstr=C3=B6m wrote:
> > The xe kmd uses ttm_bo_move_null() when moving an unpopulated bo to
> > VRAM. In that case the bo may still carry a ttm_tt that was created
>=20
> I'm wondering if other drivers which use TTM + support VRAM (amdgpu,
> Nouveau) have a similar problem or this really just an issue in Xe.

IIRC there's no other driver that takes this path to deferred memory.
From my understanding, AMD takes the route over TT, actually populating
the ttm_tt first.

/Thomas


>=20
> Either way I think this is safe and correct for any driver.
>=20
> > for its deferred placement, and it is left dangling on a bo whose
> > new
> > resource doesn't use a ttm_tt.
> >=20
> > Make ttm_bo_move_null() destroy the bo's ttm_tt when @new_mem is
> > NULL
> > or its memory type manager doesn't use a ttm_tt.
> >=20
> > ttm_bo_tt_destroy() is internal to TTM and not exported. Rather
> > than
> > exporting it, move ttm_bo_move_null() out to ttm_bo_util.c and
> > export that instead.
> >=20
> > Patch and commit message was drafted using an LLM.
> >=20
> > Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel
> > GPUs")
> > Cc: Natalie Vock <nat@pixelcluster.dev>
> > Cc: Arun Pravin <arunpravin.paneerselvam@amd.com>
> > Cc: Matthew Auld <matthew.auld@intel.com>
> > Cc: Matthew Brost <matthew.brost@intel.com>
>=20
> Reviewed-by: Matthew Brost <matthew.brost@intel.com>
>=20
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: <stable@vger.kernel.org> # v6.8+
> > Signed-off-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> > ---
> > =C2=A0drivers/gpu/drm/ttm/ttm_bo_util.c | 20 ++++++++++++++++++++
> > =C2=A0include/drm/ttm/ttm_bo.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 15 ++-------------
> > =C2=A02 files changed, 22 insertions(+), 13 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c
> > b/drivers/gpu/drm/ttm/ttm_bo_util.c
> > index f9458a4d5a09..7f3459db596a 100644
> > --- a/drivers/gpu/drm/ttm/ttm_bo_util.c
> > +++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
> > @@ -202,6 +202,26 @@ int ttm_bo_move_memcpy(struct
> > ttm_buffer_object *bo,
> > =C2=A0}
> > =C2=A0EXPORT_SYMBOL(ttm_bo_move_memcpy);
> > =C2=A0
> > +/**
> > + * ttm_bo_move_null() - assign memory for a buffer object.
> > + * @bo: The bo to assign the memory to.
> > + * @new_mem: The memory to be assigned, or NULL.
> > + *
> > + * Free the current resource of @bo and assign @new_mem to it. If
> > @new_mem is
> > + * NULL or its memory type manager doesn't use a &struct ttm_tt,
> > the bo's
> > + * &struct ttm_tt, if any, is unpopulated and destroyed.
> > + */
> > +void ttm_bo_move_null(struct ttm_buffer_object *bo,
> > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ttm_resource *new_mem)
> > +{
> > +	if (!new_mem || !ttm_manager_type(bo->bdev, new_mem-
> > >mem_type)->use_tt)
> > +		ttm_bo_tt_destroy(bo);
> > +
> > +	ttm_resource_free(bo, &bo->resource);
> > +	ttm_bo_assign_mem(bo, new_mem);
> > +}
> > +EXPORT_SYMBOL(ttm_bo_move_null);
> > +
> > =C2=A0static void ttm_transfered_destroy(struct ttm_buffer_object *bo)
> > =C2=A0{
> > =C2=A0	struct ttm_transfer_obj *fbo;
> > diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
> > index 32791c4db2a9..d525e04893ed 100644
> > --- a/include/drm/ttm/ttm_bo.h
> > +++ b/include/drm/ttm/ttm_bo.h
> > @@ -356,19 +356,8 @@ static inline void ttm_bo_assign_mem(struct
> > ttm_buffer_object *bo,
> > =C2=A0	bo->resource =3D new_mem;
> > =C2=A0}
> > =C2=A0
> > -/**
> > - * ttm_bo_move_null - assign memory for a buffer object.
> > - * @bo: The bo to assign the memory to
> > - * @new_mem: The memory to be assigned.
> > - *
> > - * Assign the memory from new_mem to the memory of the buffer
> > object bo.
> > - */
> > -static inline void ttm_bo_move_null(struct ttm_buffer_object *bo,
> > -				=C2=A0=C2=A0=C2=A0 struct ttm_resource *new_mem)
> > -{
> > -	ttm_resource_free(bo, &bo->resource);
> > -	ttm_bo_assign_mem(bo, new_mem);
> > -}
> > +void ttm_bo_move_null(struct ttm_buffer_object *bo,
> > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ttm_resource *new_mem);
> > =C2=A0
> > =C2=A0/**
> > =C2=A0 * ttm_bo_unreserve
> > --=20
> > 2.56.1
> >=20
