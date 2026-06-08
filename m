Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775AA2F39B4;
	Mon,  8 Jun 2026 13:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780925651; cv=none; b=oMarO+uawJaRKfb1hf6Ax4ZN5+IeLFU9y/UFPQQ603NQ3rAnKsc20E0pak3nn68gTLT3AEiWHbEdhdFAug97zFTwOKgELdVKfjl/mbU/tc9D03Gat1MZbtqaEqY/gVISZVL5E7JByMGB1YM7na7YBSowEJvpoU2xvhdtD3pblDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780925651; c=relaxed/simple;
	bh=1nar5slmwkYmhwnjVnep6RKpTRHv53IZexyVowGKpUk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FCf+9Uzr5ys6oMRULiSIIjCFh0aE178mpDpA0NeDizwvOsUKEs8+OH8k7d7JD/dYTf7fCue86bzC90KF1xPG+0PiBkDJkDoADKnX+VJKx7TRwVaSq6PE9Vwx1Am8w3pLN+xhykDM8bs85rLZfvV4Gl5M1P8+JU5PHxR6cf7jGQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QDg4TR/7; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QDg4TR/7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780925650; x=1812461650;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=1nar5slmwkYmhwnjVnep6RKpTRHv53IZexyVowGKpUk=;
  b=QDg4TR/7qYWqqlVZkorDMdWlnp+WbZl3ria+kzYVqg2WLJVoIgnusruw
   3b39ZsXLiB/X4KRr2w3Q38OGvpKwSg/rcwRRY9eU/V48Qjzh5tAmzfnlp
   IpLKGeKm8C4Cl6Elam3eewHcXV9L5UlwjoQAnSI8Sn/ZJd5aGlDBn21jj
   bUcHzMv6d7A6vj5V84dX3HL3qW7C5NDLXgwWP0ztqK+/s7b788GfOjA8N
   T394DvC4qOGN7+PpVdROe44aeBj5YdL2gNudszzE2oHLRmon+kcC6HYJU
   kgpJ7egGK7Tzl5g3O0mPoUy8bLLvYCKvGxkInimX4Ph7rQh3pXotNgSMm
   w==;
X-CSE-ConnectionGUID: n0Su/wIPSK2aS8IujS1G6g==
X-CSE-MsgGUID: w0FQ2Y8NTrWwjMczRZ6Dlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="92225571"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="92225571"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 06:34:10 -0700
X-CSE-ConnectionGUID: BM69GM+yQi+lOD0QOp7AAw==
X-CSE-MsgGUID: W6QaT/75T4mmg3JL3uRX/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="269256397"
Received: from amilburn-desk.amilburn-desk (HELO [10.245.244.188]) ([10.245.244.188])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 06:34:07 -0700
Message-ID: <5a260c89c766018f00790f0d1a62405a8698b3fb.camel@linux.intel.com>
Subject: Re: [PATCH] drm/xe: fix refcount leak in xe_range_fence_insert()
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Wentao Liang <vulab@iscas.ac.cn>, matthew.brost@intel.com, 
	rodrigo.vivi@intel.com, airlied@gmail.com, simona@ffwll.ch
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Mon, 08 Jun 2026 15:34:05 +0200
In-Reply-To: <20260608061540.121355-1-vulab@iscas.ac.cn>
References: <20260608061540.121355-1-vulab@iscas.ac.cn>
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

On Mon, 2026-06-08 at 06:15 +0000, Wentao Liang wrote:
> xe_range_fence_insert() acquires a reference on fence via
> dma_fence_get() and stores it in rfence->fence.=C2=A0 It then calls
> dma_fence_add_callback() and handles two cases: when the callback
> is successfully registered (err =3D=3D 0) the fence is transferred to
> the tree for later cleanup; when the fence is already signaled
> (err =3D=3D -ENOENT) it manually drops the extra reference with
> dma_fence_put(fence).
>=20
> However, dma_fence_add_callback() can fail with other errors
> (e.g. -EINVAL) and in that case the code falls through to the free:
> label without releasing the acquired reference, leaking it.
>=20
> Fix the leak by adding an else branch that calls dma_fence_put()
> before jumping to free: for any error other than -ENOENT.

In practice this can't happen since other errors require a missing
fence or ops.

But OTOH let's future-proof it.

>=20
> Cc: stable@vger.kernel.org
> Fixes: 845f64bdbfc9 ("drm/xe: Introduce a range-fence utility")
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Reviewed-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>

Will merge when it has passed CI.

Thanks,
Thomas


> ---
> =C2=A0drivers/gpu/drm/xe/xe_range_fence.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/xe/xe_range_fence.c
> b/drivers/gpu/drm/xe/xe_range_fence.c
> index 372378e89e98..3d8fa194a7b0 100644
> --- a/drivers/gpu/drm/xe/xe_range_fence.c
> +++ b/drivers/gpu/drm/xe/xe_range_fence.c
> @@ -77,6 +77,8 @@ int xe_range_fence_insert(struct
> xe_range_fence_tree *tree,
> =C2=A0	} else if (err =3D=3D 0) {
> =C2=A0		xe_range_fence_tree_insert(rfence, &tree->root);
> =C2=A0		return 0;
> +	} else {
> +		dma_fence_put(fence);
> =C2=A0	}
> =C2=A0
> =C2=A0free:
