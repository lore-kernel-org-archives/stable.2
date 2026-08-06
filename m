Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F056396D25;
	Thu,  6 Aug 2026 14:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786025004; cv=none; b=EAId/sNb8ML/R0Qg5qy2WUYdDmo9qA9evN0tloBYQnZbXzABjqKRY3rCBdFEmC+fiSBTmiZryeF0oYJtc1WFiVTocwyF7Nxiw+wjpF30vCmNHZt5oqCds1QeE3z7ZoDU4wGFWmZr9LIAKYfZ53tkFNEwd+6yfPrSuabT+u9iq3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786025004; c=relaxed/simple;
	bh=rzUFh7PWiGTwF83COgIGLdhlwLhhYtW0gw3EUnRkSqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i4dHZY9CGhKPakXor7s1YHnRqsDhKhFBUB0CBWXChzjyUAL978iUCFRVZryZqmliHbwyslYSxBH1rY+1vbKVOPR4Xp0SCYtwYSJlENVYyuTfTemya8cPP0aPL450hBsmtAdSZsf6LqCpALF9O4z4vRkrwrhX1E9oFzoS66AWOBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLyCODtq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLyCODtq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CD901F000E9;
	Thu,  6 Aug 2026 14:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786025000;
	bh=AcbUps+PJOKEs9ZAZx9T9otuJttHDUts9Bt8Cges3S8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eLyCODtqlzXwrcAeO8d9T/YueAUfY2dFDeHy2nYTsKalnVBNyZlAI7UN3H8sf49E+
	 AlMgYpq6Y0tUuTaS/lxnhW8ds0NU8wmIfEn/NNGcpGLtT4Uf/I1ebeQa2i0hijhMQC
	 gilaCdqouNEsxYRVNRsU7of55JH6z2RFJm4XcCH7AzuIwmPDZQeSXJZGly7V2Db3WR
	 PUGymMQsPMFwBvnklDGWQMitYiqW0aP98GFO14OCJ5yrDBzjqgltbdyj6JK3WYwEuK
	 OIsVSKJkxjMo8OrGRa35s0+vdtdfNuZUgS0KH7BzJrwRewjw8ER1W3DTEQ+pIaZrcQ
	 R+uAM4Ek/EGfg==
Date: Thu, 6 Aug 2026 15:03:01 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Wei Yang <richard.weiyang@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, 
	Li Youhong <liyouhong@kylinos.cn>, stable@vger.kernel.org
Subject: Re: [PATCH] mm/memory-failure: fix folio refcount leak and
 min_order_for_split() locking
Message-ID: <anRv8ngsyOjkgOHM@lucifer>
References: <20260806-try_to_split_thp_page-v1-1-a259e3387e38@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806-try_to_split_thp_page-v1-1-a259e3387e38@kernel.org>

On Thu, Aug 06, 2026 at 01:14:38PM +0200, David Hildenbrand (Arm) wrote:
> hwpoison code can end up calling min_order_for_split() without holding
> the folio lock. There isn't really something that would prevent
> concurrent folio split. Consequently folio->mapping can get set to
> NULL after checking for "!folio->mapping", and if the compiler
> reloads folio->mapping, mapping_min_folio_order() would try to
> dereference NULL.
>
> While very unlikely to happen in practice, let's just enforce that
> min_order_for_split() is called with the folio lock held. We can
> significantly cleanup the calling hwpoison code, and just get rid
> of try_to_split_thp_page() to hold the folio lock for a bit longer.
>
> Just work on folios now, which further cleans up the code. We just
> have to be careful about doing the page_folio() after splitting, which
> we have to do already either way. Do not change the way we split for
> now, this needs more thought and should be done separately.
>
> Cleaning this up we fix another issue: in soft_offline_in_use_page(), we
> would currently have leaked a folio reference.

Yikes...

>
> In folio_split(), document and assert that we need the folio lock.

You mean min_order_for_split()?

> Drop the questionable VM_BUG_ON_PAGE(!page_count(p), p) check entirely.
>
> The folio->mapping problem was identified by Sashiko, and Li Youhong
> reported it by sending a proposal fix.
>
> This likely does not really warrant CCing stable, but I expect little
> conflicts when doing the backport, so let's just CC stable because of
> the refcount leak.
>
> Reported-by: Li Youhong <liyouhong@kylinos.cn>
> Closes: https://lore.kernel.org/r/20260804035828.2684059-1-dayou5941@163.com
> Fixes: 689b8986776c ("mm/memory-failure: improve large block size folio handling")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

A typo above and a nit below about a comment but otherwise LGTM so:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
> v4 of the last fixing attempts:
>
> https://lore.kernel.org/r/20260806031958.677935-1-dayou5941@163.com
> ---
>  mm/huge_memory.c    |  4 ++++
>  mm/memory-failure.c | 56 ++++++++++++++++++-----------------------------------
>  2 files changed, 23 insertions(+), 37 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 9b1f3b24f7e0d..a00df56a68b57 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -4362,10 +4362,14 @@ int folio_split(struct folio *folio, unsigned int new_order,
>   * If a file-backed folio is truncated, 0 will be returned. Any subsequent
>   * split attempt should get -EBUSY from split checking code.
>   *
> + * Context: @folio must be locked.
> + *
>   * Return: @folio's minimum order for split
>   */
>  unsigned int min_order_for_split(struct folio *folio)
>  {
> +	VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
> +
>  	if (folio_test_anon(folio))
>  		return 0;
>
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index aaf14608b30e2..f4f3f1fc9eaff 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1705,26 +1705,6 @@ static int identify_page_state(unsigned long pfn, struct page *p,
>  	return page_action(ps, p, pfn);
>  }
>
> -/*
> - * When 'release' is 'false', it means that if thp split has failed,
> - * there is still more to do, hence the page refcount we took earlier
> - * is still needed.
> - */
> -static int try_to_split_thp_page(struct page *page, unsigned int new_order,
> -		bool release)
> -{
> -	int ret;
> -
> -	lock_page(page);
> -	ret = split_huge_page_to_order(page, new_order);
> -	unlock_page(page);
> -
> -	if (ret && release)
> -		put_page(page);
> -
> -	return ret;
> -}
> -
>  static void unmap_and_kill(struct list_head *to_kill, unsigned long pfn,
>  		struct address_space *mapping, pgoff_t index, int flags)
>  {
> @@ -2509,9 +2489,6 @@ int memory_failure(unsigned long pfn, int flags)
>  	folio_unlock(folio);
>
>  	if (folio_test_large(folio)) {
> -		const int new_order = min_order_for_split(folio);
> -		int err;
> -
>  		/*
>  		 * The flag must be set after the refcount is bumped
>  		 * otherwise it may race with THP split.
> @@ -2526,24 +2503,25 @@ int memory_failure(unsigned long pfn, int flags)
>  		 * page is a valid handlable page.
>  		 */
>  		folio_set_has_hwpoisoned(folio);
> -		err = try_to_split_thp_page(p, new_order, /* release= */ false);
> +
> +		folio_lock(folio);
> +		split_huge_page_to_order(p, min_order_for_split(folio));
> +		folio = page_folio(p);
> +		folio_unlock(folio);
> +
>  		/*
>  		 * If splitting a folio to order-0 fails, kill the process.
>  		 * Split the folio regardless to minimize unusable pages.
>  		 * Because the memory failure code cannot handle large
>  		 * folios, this split is always treated as if it failed.
>  		 */
> -		if (err || new_order) {
> -			/* get folio again in case the original one is split */
> -			folio = page_folio(p);
> +		if (folio_test_large(folio)) {
>  			res = -EHWPOISON;
>  			kill_procs_now(p, pfn, flags, folio);
> -			put_page(p);
> +			folio_put(folio);
>  			action_result(pfn, MF_MSG_UNSPLIT_THP, MF_FAILED);
>  			goto unlock_mutex;
>  		}
> -		VM_BUG_ON_PAGE(!page_count(p), p);
> -		folio = page_folio(p);
>  	}
>
>  	/*
> @@ -2861,9 +2839,8 @@ static int soft_offline_in_use_page(struct page *page)
>  		.reason = MR_MEMORY_FAILURE,
>  	};
>
> +	folio_lock(folio);
>  	if (!huge && folio_test_large(folio)) {
> -		const int new_order = min_order_for_split(folio);
> -
>  		/*
>  		 * If new_order (target split order) is not 0, do not split the
>  		 * folio at all to retain the still accessible large folio.
> @@ -2871,15 +2848,20 @@ static int soft_offline_in_use_page(struct page *page)
>  		 * preferred, split it to non-zero new_order like it is done in
>  		 * memory_failure().
>  		 */

This comment is:

		/*
		 * If new_order (target split order) is not 0, do not split the
		 * folio at all to retain the still accessible large folio.
		 * NOTE: if minimizing the number of soft offline pages is
		 * preferred, split it to non-zero new_order like it is done in
		 * memory_failure().
		 */

Which references 'new_order' twice - probably need to update this.

> -		if (new_order || try_to_split_thp_page(page, /* new_order= */ 0,
> -						       /* release= */ true)) {
> +		if (!min_order_for_split(folio))
> +			ret = split_huge_page_to_order(page, 0) ? -EBUSY : 0;
> +		else
> +			ret = -EBUSY;
> +		folio = page_folio(page);
> +
> +		if (ret) {
> +			folio_unlock(folio);
> +			folio_put(folio);

Wow, incredible that we had a refcount leak here for ages and didn't know. Ugh
what a mess this hw posion crap is!

>  			pr_info("%#lx: thp split failed\n", pfn);
> -			return -EBUSY;
> +			return ret;
>  		}
> -		folio = page_folio(page);
>  	}
>
> -	folio_lock(folio);
>  	if (!huge)
>  		folio_wait_writeback(folio);
>  	if (PageHWPoison(page)) {
>
> ---
>
> base-commit: e5492213654050379e78ec6f9acfd6c9fe00f334
>
> change-id: 20260806-try_to_split_thp_page-a359f4d8c90f
>
> --
>
> Cheers,
>
> David
>

--
Cheers, Lorenzo
