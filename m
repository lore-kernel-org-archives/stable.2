Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86693905E7;
	Thu, 10 Sep 2026 07:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789024496; cv=none; b=NnEjfLFs/mFSWBqQdM5Q118doddZQDTvVIk8YgjwkHGrXNrHzk+oo1ul9GWkdJSVSkohyN/+uy/uctN6yHVA+5X80IL/rpIblPQzSrrlTRcgD2n+ZGpRVDDdX7KAOp0W5W1V/IkSS66F344XFCNygxG2jW5BHtcjid0i/IT4cMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789024496; c=relaxed/simple;
	bh=k4nyCBxi7fpuVu67lXrSDcu9nkhykGQULtMJku448KU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JDw9wJ8wgaedExdIAFZHaUPRgc40AC3unqnHwfDmSJDuEftgUGA0B77h0RUXGKWZluhaLcdoLSQiGuGdVJXYBZNGKNxdRDfjHdoz2n3VKdK52XGqWZvXsZFJdd7vThovwHjRFl8WNhyw8w72BPYvK5d9rk8FH/fO/7FaeVGhvBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WcPEcjQ+; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WcPEcjQ+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789024494; x=1820560494;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=k4nyCBxi7fpuVu67lXrSDcu9nkhykGQULtMJku448KU=;
  b=WcPEcjQ+PyP25RYRmEzyxeUBBOID27gNp04ZZaxf4HPHUniEOqWdo9aw
   D8mstrSHAONNueYRMf0PutRhIlh6uhW9ZsJwR25xSQJAPCQ38lJ2YzpLl
   pe98z2KBodlWJkjZLv/0oyo86sngHoF2I0q1WeS9AQvHVe8/U0OA3Agj1
   gh8SzlJIvNG/NJOvslBV4IqnG5bAft2oQBIa8LONu1zv5vU62iVabnFZ8
   ofiCUTt6dj2k5QXxUgZ8wLaHv/9FB7yMZnRxF17vWHCndXfTye2KezrAc
   GuKOO57Bbry639hc1+oaXDssZnCwTp72vqpNkCbhqhuFnf+qsRkm7eUfS
   A==;
X-CSE-ConnectionGUID: fAQgJ5UNTh++3wUYKCebVg==
X-CSE-MsgGUID: OItBRCc2Tr+JzWR8eIC4Nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="89481354"
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; 
   d="scan'208";a="89481354"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 00:14:53 -0700
X-CSE-ConnectionGUID: F0sv97FpTDe5+bnQSepLkA==
X-CSE-MsgGUID: +1GF7q62SVuRahHI+JQv4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; 
   d="scan'208";a="267260720"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.245.193]) ([10.245.245.193])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 00:14:50 -0700
Message-ID: <067e5ddc2268ae4678745a900108e93d0c6eeb74.camel@linux.intel.com>
Subject: Re: [PATCH] drm/ttm: fix swapped-out resources never leaving their
 bulk_move range
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Vadim Nikitushkin <bub4z0r@gmail.com>, christian.koenig@amd.com, 
	ray.huang@amd.com, matthew.auld@intel.com, matthew.brost@intel.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, skainsworth@gmail.com, alexander.deucher@amd.com, 
	bernardomagri21@gmail.com
Date: Thu, 10 Sep 2026 09:14:47 +0200
In-Reply-To: <20260909205028.13799-1-bub4z0r@gmail.com>
References: <20260909205028.13799-1-bub4z0r@gmail.com>
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

On Wed, 2026-09-09 at 23:50 +0300, Vadim Nikitushkin wrote:
> ttm_tt_swapout() returns the number of pages swapped out on success
> and
> a negative error code on failure; for a populated ttm it never
> returns
> zero. Commit b2ed01e7ad3d ("drm/ttm: Fix ttm_bo_swapout() infinite
> LRU
> walk on swapout failure") moved the bulk_move bookkeeping in
> ttm_bo_swapout_cb() under "if (!ret)", so the
> ttm_resource_del_bulk_move_unevictable() /
> ttm_resource_move_to_lru_tail()
> pair is now skipped on every successful swapout. The equivalent
> change
> for the shrinker in commit 1d59f36e95f7 ("drm/ttm: Fix
> ttm_bo_shrink()
> infinite LRU walk on backup failure") tests "lret > 0", which is what
> was intended here as well.
>=20
> Before b2ed01e7ad3d the resource was taken off the bulk_move before
> the
> swapout; since then a swapped-out resource stays inside its BO's
> bulk_move range (and on the manager LRU) although it is unevictable.
> When it is later freed or the BO leaves the bulk_move
> (ttm_resource_free(), ttm_bo_set_bulk_move() via amdgpu_vm_bo_del()),
> ttm_resource_del_bulk_move() skips it because of its
> !ttm_resource_unevictable() guard, so a range endpoint in pos->first
> /
> pos->last is left pointing at freed memory. The next
> ttm_lru_bulk_move_tail() or ttm_resource_add_bulk_move() on that
> cursor
> is a use-after-free, seen as the resv WARN in
> ttm_lru_bulk_move_add(),
> "list_del corruption" in ttm_resource_move_to_lru_tail() or a NULL
> dereference in ttm_resource_manager_next() -- minutes to hours after
> a
> hibernation, or at process exit / reboot following one. Samuel
> Ainsworth's analysis of drm/amd issue 5387 (see Link) identified the
> dangling cursor; the missing removal at swapout time is the reason it
> dangles.
>=20
> Testing the condition for success restores the removal. On an AMD
> Phoenix APU (ASUS UM3406GA, gfx1103) running suspend-then-hibernate
> on
> a 7.0.y stable kernel carrying the backport (Ubuntu 7.0.0-31) the bug
> crashed 5 of 18 hibernation cycles; a function profile of one
> hibernation showed 336 ttm_tt_swapout() calls and zero
> ttm_resource_del_bulk_move_unevictable() calls. With this change the
> removal happens for every swapped-out resource and 12 further cycles
> were clean.
>=20
> Fixes: b2ed01e7ad3d ("drm/ttm: Fix ttm_bo_swapout() infinite LRU walk
> on swapout failure")
> Cc: stable@vger.kernel.org=C2=A0# v7.1+
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5387
> Link:
> https://lore.kernel.org/dri-devel/CAHYiNPa6aVacJoLOje-qZ1GyYx-9p0tN4NuP8D=
_eSL+UJeevXw@mail.gmail.com/
> Signed-off-by: Vadim Nikitushkin <bub4z0r@gmail.com>

Nice catch.

This also explains why https://patchwork.freedesktop.org/series/170311/
appeared to fix the issue. But that series actually kept the resource
on the bulk sublist until someone bumped the LRU or removed it.

Reviewed-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>

> ---
> =C2=A0drivers/gpu/drm/ttm/ttm_bo.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c
> b/drivers/gpu/drm/ttm/ttm_bo.c
> index ef56c18..9b85b5f 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> @@ -1434,7 +1434,7 @@ ttm_bo_swapout_cb(struct ttm_lru_walk *walk,
> struct ttm_buffer_object *bo)
> =C2=A0
> =C2=A0	if (ttm_tt_is_populated(tt)) {
> =C2=A0		ret =3D ttm_tt_swapout(bdev, tt, swapout_walk-
> >gfp_flags);
> -		if (!ret) {
> +		if (ret > 0) {
> =C2=A0			spin_lock(&bdev->lru_lock);
> =C2=A0			ttm_resource_del_bulk_move_unevictable(bo-
> >resource, bo);
> =C2=A0			ttm_resource_move_to_lru_tail(bo->resource);
