Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CC93FD121
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 09:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785922387; cv=none; b=mYp+F7uuWhGQvYcBtqgd5pcvreNcgsUXJuWsrhTP99HYxgK1s9u9uJwD/XJAr17bMd416zJ8yrkT54trDN1XdwDhqGu62RszrntoA2++pLbmHiTFr96u1ltgCp6t5dN5ITYWsneYuISU3WdipymFYZ0W9ac65rXmXLz3+awBEkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785922387; c=relaxed/simple;
	bh=7Pihs/sjwj0NosS6So1UXiL5gfG1RTniyq6UvPbh7Lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EP6LVoDDmAlnJQtSdNuuZih36rQ+BIufhsKsxDywKD/h935MQoTRopB0MXW9rYf80fL7RybPZj4I1/OjdwhYfl5/K22z0yykGlzFS9MJTlZwlh7HvPBybDe6dTvuYR8ShtgOwNdJoA5FLZ7TpLj/uVDZTM+ettFij5oTFoVFl/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TV3NVZ7u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TV3NVZ7u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FEFE1F00A3D;
	Wed,  5 Aug 2026 09:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785922382;
	bh=bNSPhkhNPtYmenXs8cu1O3USEwCw/cTE1SHV8zst2nE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TV3NVZ7uKlrVLrToMH2tDsWTEHRFY5dWnRdkGbjl5U35va7uDOisS+AFKKW8SyIwX
	 cuOt+FNdVWls4WRPl4MybnzUGH3lJL9Gl/UO2uIc3ESpQs2axolz7FsBaZ20aCNg4z
	 izQut7pCFWc9Kyt2ug3ZdxWypPGdOxHB35nNrmhQL0RwQC2ls59mSr8AoO9leu76vr
	 Meu09tg9W6HOwuotlY0zBG3yWlj8UF5PjGFd6myIOa1COB/DGr7ens+E2z2aa+ONeu
	 asAm3ROH9B26sg05DV9+mOJx2yHoE9pxJv2l9eJ2G4A8dpZ3x6yZ91B/9iZkiVBgs6
	 y1nXAajFDBt0Q==
Date: Wed, 5 Aug 2026 10:32:45 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: dayou5941@163.com
Cc: akpm@linux-foundation.org, david@kernel.org, ziy@nvidia.com, 
	linux-mm@kvack.org, Li Youhong <liyouhong@kylinos.cn>, 
	Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v3] mm/memory-failure: fix concurrent access issue in
 min_order_for_split()
Message-ID: <anMDGv1p05wKlMyq@lucifer>
References: <20260805084224.2597547-1-dayou5941@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805084224.2597547-1-dayou5941@163.com>

Please stop sending series so quickly :)

Leave at least a day between new revisions.

There's review on the v2 that is outstanding.

So engage in discussions there and wait until tomorrow before sending v4.

Thanks!

On Wed, Aug 05, 2026 at 04:42:24PM +0800, dayou5941@163.com wrote:
> From: Li Youhong <liyouhong@kylinos.cn>
>
> min_order_for_split() accesses folio->mapping without proper
> synchronization. While the compiler typically caches the value
> in a register making a NULL deref unlikely in practice, the
> real issue is that the callers in memory-failure.c do not hold
> the folio lock at the time of the call:
>
> - memory_failure() explicitly drops the folio lock before calling
>   min_order_for_split().
> - soft_offline_in_use_page() has not yet acquired the folio lock
>   when calling min_order_for_split().
>
> This means the value of folio->mapping may be modified by a
> truncate or invalidate operation while min_order_for_split() is
> executing, leading to a torn read or use of a stale mapping value.
>
> Fixes: 689b8986776c ("mm/memory-failure: improve large block size folio handling")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260803060001.800638-1-dayou5941@163.com
> Cc: stable@vger.kernel.org
> Signed-off-by: Li Youhong <liyouhong@kylinos.cn>
> ---
> v2:
> - Dropped the approach of caching folio->mapping inside min_order_for_split() in favor of adding the folio lock at the callers.
> - Added VM_WARN_ON_ONCE_FOLIO() in min_order_for_split().
> - Updated the commit message to clarify that the real issue is the callers not holding the folio lock, rather than a TOCTOU race.
>   v1: https://lore.kernel.org/all/20260804035828.2684059-1-dayou5941@163.com/
>
> v3:
> - Fix author name and Signed-off-by format as requested by Greg.
>   v2: https://lore.kernel.org/all/20260805072625.2437636-1-dayou5941@163.com/
> ---
>  mm/huge_memory.c    |  2 ++
>  mm/memory-failure.c | 12 ++++++++++--
>  2 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 58cabe6af33d..e3f16dadc1d4 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -4300,6 +4300,8 @@ int folio_split(struct folio *folio, unsigned int new_order,
>   */
>  unsigned int min_order_for_split(struct folio *folio)
>  {
> +	VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
> +
>  	if (folio_test_anon(folio))
>  		return 0;
>
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 3b1e6946821b..7391524b5046 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -2437,12 +2437,17 @@ int memory_failure(unsigned long pfn, int flags)
>  		res = -EOPNOTSUPP;
>  		goto unlock_mutex;
>  	}
> +
>  	folio_unlock(folio);
>
>  	if (folio_test_large(folio)) {
> -		const int new_order = min_order_for_split(folio);
> +		const int new_order;
>  		int err;
>
> +		folio_lock(folio);
> +		new_order = min_order_for_split(folio);
> +		folio_unlock(folio);
> +
>  		/*
>  		 * The flag must be set after the refcount is bumped
>  		 * otherwise it may race with THP split.
> @@ -2796,8 +2801,11 @@ static int soft_offline_in_use_page(struct page *page)
>  	};
>
>  	if (!huge && folio_test_large(folio)) {
> -		const int new_order = min_order_for_split(folio);
> +		const int new_order;
>
> +		folio_lock(folio);
> +		new_order = min_order_for_split(folio);
> +		folio_unlock(folio);
>  		/*
>  		 * If new_order (target split order) is not 0, do not split the
>  		 * folio at all to retain the still accessible large folio.
> --
> 2.25.1
>

--
Cheers, Lorenzo
