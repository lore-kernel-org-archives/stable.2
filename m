Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E21025B09E
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 12:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786018060; cv=none; b=jIKkCEcJhAH1aCVVQVhtQAxDUvRWPmKtr/Jey8hFMmRh2Iv+pKRBylp1mLArwdI7omsS00K2e0gTZvdOer059xzDwoXhy6B18Bb8DqQZ0wLhu47pORS7AMbWhaaFTkHzYe5RvYyk+w0DxGbt8me6zSPPKt83cT/Kd4kWoL6QJG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786018060; c=relaxed/simple;
	bh=hl5shP1aOZeCCn+W6zkZbVOs5dHOCEP4sYq+vHAgHGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XRqJyDayMPCVoxSk6kEdKvlwrrgK2O5yYQwt9X7FPodxG/HxQPZ36sB8Hnuv8LyAPuRwsvwSCP0mJXuzJk5M7ftE245whvn3KINAJm7rQ2Jma6p48voymGqOF0+KM4Yd6N3FcAPwsWX1ShdBXRZtVB9zXS62NyAL3e+XU5FjHmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Q887c7pa; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Q887c7pa"
Message-ID: <563848c7-f9eb-45c6-af25-facf0fdc9b4b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786018046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=49BApBT44VNf2oHdmYMv0Gennxw3e9jZQmU5d15l048=;
	b=Q887c7paPBj+KusvSUNvM7sGK5rvi0S9in+Bbs+WZ12U2p/zKpimsZ81hiKXjkDAjwTslV
	QAfWevIcAwaPfUzSNVYbI1blcEFfWZh8Pju0hVKHeTwONRUbYaJp2UxEPF6mufz+YRYh7e
	64xhxmayFMud07+IDss37p9a17avry8=
Date: Thu, 6 Aug 2026 13:06:00 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm/memory-failure: fix folio refcount leak and
 min_order_for_split() locking
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi
 <nao.horiguchi@gmail.com>, Wei Yang <richard.weiyang@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Luis Chamberlain <mcgrof@kernel.org>, Li Youhong <liyouhong@kylinos.cn>,
 stable@vger.kernel.org
References: <20260806-try_to_split_thp_page-v1-1-a259e3387e38@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <20260806-try_to_split_thp_page-v1-1-a259e3387e38@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 06/08/2026 12:14, David Hildenbrand (Arm) wrote:
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
> 
> In folio_split(), document and assert that we need the folio lock.
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

Makes sense here, folio->mapping can become NULL after the `if (!folio->mapping)`
check if folio_lock() is not held.


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

Looks cleaner and preserves existing policy where with successful split to order 0,
you continue handling the individual page, but onl split failure, folio remains large and
you report the failure.

  
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


LGTM

Acked-by: Usama Arif <usama.arif@linux.dev>

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

