Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F82537AA7A
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 18:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791830901; cv=none; b=BNdnHCAHwofG28Umg7U36fbzT0bPpsPjZdaWRNEZSfeYAIucn7haRyP3X610LxIMa0AN0aRrP+EFafN5dhh1Ecy51BzaQEv/X8al3L0iTWsZTd2MRW/SXQ0IO+mdoRi1ILEAJx8tCkaZXTcyWQtDfPsjvcDGaJJoZis4aWJr+w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791830901; c=relaxed/simple;
	bh=wdvxvj8TpOhnbf187hLLlbq90wjOsqeAlF1OfjHvI+o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R3qSg8p90eJgjb1AjKChiIOwvgEty8O6cQTYlxBDfOR4BJvgcEkpRsja87sHu+NYDlXnZGj+9GmKkdbwdeLgs3VyQ8S7pMWSQLhv2F5IQWd5VpTEyTSPrbF87v0rpy4HC4ziegNdLxKpYbXPkN8DuxUU5Mry9SR0GqiIaw9o9EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jVRO7pyn; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jVRO7pyn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791830900; x=1823366900;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=wdvxvj8TpOhnbf187hLLlbq90wjOsqeAlF1OfjHvI+o=;
  b=jVRO7pynlE+lXAsgKaW8X0ab0LjtDbIiIRQQI/cjCWh5zSq0AdS8jB5Z
   z3P2AS5YD/Mr6R8xI9u1xTkDflnpAKHataZDuRjK2VyjBIBQqgwe+ALCe
   zYfOIJvilO0BOixv2tZgpFnWHOhxkp44JFPtgkS2obf6wY0VVvKzwDNfr
   pTpU+3jF0GHdcf4Y0YS12hevfFMkU4BG9lVRxjZ4u/ry6VXbkUstOy67k
   8Y7H6O81Zk0omoTAQV5QTMqZ5EmpQiYtVjPlAWyY05FPnAA81ZRWnFrRx
   ivVgVFkUtJD2zZrww8YloWKeWgjywIstCfIbBqK0dY/CYptrf6P8Z/Z3J
   A==;
X-CSE-ConnectionGUID: UE0OtbMpQa+3EVKJ7obGqA==
X-CSE-MsgGUID: KvQNTIOySz6zLL4AaHOF7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="449764"
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="449764"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 11:48:15 -0700
X-CSE-ConnectionGUID: kl/61gRdRpiLj9o/viwJLA==
X-CSE-MsgGUID: J6oTcnpVSKWEHYG8F3k9zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="1160677"
Received: from jkrzyszt-mobl2.ger.corp.intel.com ([10.245.246.47])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 11:48:13 -0700
Message-ID: <2360da488842dcc9dc4fcbf5f3d1d8bc3b57c20e.camel@linux.intel.com>
Subject: Re: [PATCH v7 2/6] drm/i915/gem: Count mapped pages in a folio
From: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To: Krzysztof Karas <krzysztof.karas@intel.com>, 
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: Andi Shyti <andi.shyti@linux.intel.com>, =?UTF-8?Q?Micha=C5=82?= Grzelak
	 <michal.grzelak@intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>,  Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, stable@vger.kernel.org
Date: Mon, 12 Oct 2026 20:48:10 +0200
In-Reply-To: <20261006095845.451212-3-krzysztof.karas@intel.com>
References: <20261006095845.451212-1-krzysztof.karas@intel.com>
	 <20261006095845.451212-3-krzysztof.karas@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Krzysztof,

This version finally looks good to me, however ...

On Tue, 2026-10-06 at 09:58 +0000, Krzysztof Karas wrote:
> Before addition of commit 029ae067431a
> ("drm/i915: Fix potential overflow of shmem scatterlist length")
> and after folios were introduced complete folios were always
> allocated, possibly overloading the scatterlist capacity which
> was never truly limited to PAGE_SIZE when requested via
> max_segment. The above commit addressed scatterlist overloading,
> but unintentionally disabled PAGE_SIZE as a valid max_segment
> value and failed to take care of remaining pages from folios
> above max_segment boundary.
> This created a state, where multitude of scatterlists were used
> for the same folio, but never counting enough of its pages to
> jump to the next folio.
>=20
> Furthermore, current do-while loop goes over the same folio
> multiple times, increasing the refcount each time, and breaks
> get/put symmetry: many shmem_read_folio_gfp() gets and only one
> put in i915_gem_object_put_pages_shmem() per folio.
>=20
> Track how many pages have already been counted in a folio and
> use that number as an offset on consecutive allocations from the
> same folio to ensure it is fully covered before reading next
> folio.
>=20
> Fixes: 029ae067431a ("drm/i915: Fix potential overflow of shmem scatterli=
st length")
> Cc: stable@vger.kernel.org
> Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/15816
> Assisted-by: LLM
> Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
> ---
> v7:
>  * Derive the page offset within the current folio from
>    next_pfn. (Janusz)
>  * Update next_pfn using that offset and clarify its role in
>    merging contiguous physical pages. (Andi)
>=20
>  drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 108 +++++++++++++---------
>  1 file changed, 63 insertions(+), 45 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/=
i915/gem/i915_gem_shmem.c
> index e35ee4bd456f..645da248e25d 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> @@ -70,7 +70,9 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915,=
 struct sg_table *st,
>  	unsigned int page_count; /* restricted by sg_alloc_table */
>  	unsigned long i;
>  	struct scatterlist *sg;
> -	unsigned long next_pfn =3D 0;	/* suppress gcc warning */
> +	/* suppress gcc warnings */
> +	unsigned long next_pfn =3D 0;

Why plural?  Why moved to a separate line?  Do we really need such
comments?  I'm not asking for dropping it, only not touching as not
related, unless no longer applicable after your changes.

> +	struct folio *folio;

However, if initialization of next_pfn is needed because its lack can still
trigger a gcc warning, shouldn't we now also initialize folio before first
use?

Thanks, =20
Janusz

>  	gfp_t noreclaim;
>  	int ret;
> =20
> @@ -104,7 +106,7 @@ int shmem_sg_alloc_table(struct drm_i915_private *i91=
5, struct sg_table *st,
>  	sg =3D st->sgl;
>  	st->nents =3D 0;
>  	for (i =3D 0; i < page_count; i++) {
> -		struct folio *folio;
> +		unsigned long folio_page_index;
>  		unsigned long nr_pages;
>  		const unsigned int shrink[] =3D {
>  			I915_SHRINK_BOUND | I915_SHRINK_UNBOUND,
> @@ -112,51 +114,61 @@ int shmem_sg_alloc_table(struct drm_i915_private *i=
915, struct sg_table *st,
>  		}, *s =3D shrink;
>  		gfp_t gfp =3D noreclaim;
> =20
> -		do {
> -			cond_resched();
> -			folio =3D shmem_read_folio_gfp(mapping, i, gfp);
> -			if (!IS_ERR(folio))
> -				break;
> -
> -			if (!*s) {
> -				ret =3D PTR_ERR(folio);
> -				goto err_sg;
> -			}
> -
> -			i915_gem_shrink(NULL, i915, 2 * page_count, NULL, *s++);
> -
> -			/*
> -			 * We've tried hard to allocate the memory by reaping
> -			 * our own buffer, now let the real VM do its job and
> -			 * go down in flames if truly OOM.
> -			 *
> -			 * However, since graphics tend to be disposable,
> -			 * defer the oom here by reporting the ENOMEM back
> -			 * to userspace.
> -			 */
> -			if (!*s) {
> -				/* reclaim and warn, but no oom */
> -				gfp =3D mapping_gfp_mask(mapping);
> +		if (!i || (next_pfn >=3D folio_pfn(folio) + folio_nr_pages(folio))) {
> +			/* Grab the next folio if we exhausted the current one. */
> +			do {
> +				cond_resched();
> +				folio =3D shmem_read_folio_gfp(mapping, i, gfp);
> +				folio_page_index =3D 0;
> +				if (!IS_ERR(folio))
> +					break;
> +
> +				if (!*s) {
> +					ret =3D PTR_ERR(folio);
> +					goto err_sg;
> +				}
> +
> +				i915_gem_shrink(NULL, i915, 2 * page_count, NULL, *s++);
> =20
>  				/*
> -				 * Our bo are always dirty and so we require
> -				 * kswapd to reclaim our pages (direct reclaim
> -				 * does not effectively begin pageout of our
> -				 * buffers on its own). However, direct reclaim
> -				 * only waits for kswapd when under allocation
> -				 * congestion. So as a result __GFP_RECLAIM is
> -				 * unreliable and fails to actually reclaim our
> -				 * dirty pages -- unless you try over and over
> -				 * again with !__GFP_NORETRY. However, we still
> -				 * want to fail this allocation rather than
> -				 * trigger the out-of-memory killer and for
> -				 * this we want __GFP_RETRY_MAYFAIL.
> +				 * We've tried hard to allocate the memory by reaping
> +				 * our own buffer, now let the real VM do its job and
> +				 * go down in flames if truly OOM.
> +				 *
> +				 * However, since graphics tend to be disposable,
> +				 * defer the oom here by reporting the ENOMEM back
> +				 * to userspace.
>  				 */
> -				gfp |=3D __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
> -			}
> -		} while (1);
> +				if (!*s) {
> +					/* reclaim and warn, but no oom */
> +					gfp =3D mapping_gfp_mask(mapping);
> +
> +					/*
> +					 * Our bo are always dirty and so we require
> +					 * kswapd to reclaim our pages (direct reclaim
> +					 * does not effectively begin pageout of our
> +					 * buffers on its own). However, direct reclaim
> +					 * only waits for kswapd when under allocation
> +					 * congestion. So as a result __GFP_RECLAIM is
> +					 * unreliable and fails to actually reclaim our
> +					 * dirty pages -- unless you try over and over
> +					 * again with !__GFP_NORETRY. However, we still
> +					 * want to fail this allocation rather than
> +					 * trigger the out-of-memory killer and for
> +					 * this we want __GFP_RETRY_MAYFAIL.
> +					 */
> +					gfp |=3D __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
> +				}
> +			} while (1);
> +		} else {
> +			/*
> +			 * Otherwise, we are still inside the same folio,
> +			 * so just update its page index.
> +			 */
> +			folio_page_index =3D next_pfn - folio_pfn(folio);
> +		}
> =20
> -		nr_pages =3D min3(folio_nr_pages(folio),
> +		nr_pages =3D min3(folio_nr_pages(folio) - folio_page_index,
>  				page_count - i, max_segment / PAGE_SIZE);
> =20
>  		if (!i ||
> @@ -166,13 +178,19 @@ int shmem_sg_alloc_table(struct drm_i915_private *i=
915, struct sg_table *st,
>  				sg =3D sg_next(sg);
> =20
>  			st->nents++;
> -			sg_set_folio(sg, folio, nr_pages * PAGE_SIZE, 0);
> +			sg_set_page(sg, folio_page(folio, folio_page_index),
> +				    nr_pages * PAGE_SIZE, 0);
>  		} else {
>  			nr_pages =3D min(nr_pages, (max_segment - sg->length) / PAGE_SIZE);
> =20
>  			sg->length +=3D nr_pages * PAGE_SIZE;
>  		}
> -		next_pfn =3D folio_pfn(folio) + nr_pages;
> +
> +		/*
> +		 * Store the next PFN, so contiguous physical pages
> +		 * can be merged into the same SG entry.
> +		 */
> +		next_pfn =3D folio_pfn(folio) + folio_page_index + nr_pages;
>  		i +=3D nr_pages - 1;
> =20
>  		/* Check that the i965g/gm workaround works. */
