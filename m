Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCEB3F327F
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 09:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785920844; cv=none; b=TtyKzLuY3BINuNQOr5ELhTrKo++TSH3e6rdf4KGm4S+aeNtg0X0dOiIxJun90rFylBciDePCUukn5EcYARQa8b5AAdbK0PRjAYVAYm1zamjf+nzY1GTKYupdWop3ALA+lmo6chMBTGM/4MisoIbW34tasdLeRadcR9M7GbhqECw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785920844; c=relaxed/simple;
	bh=KupNdHNfcQGrLNLHhhBOVqFjxKhhIIQj/Vocvo11CXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fQ4Dhx6kGlgqxofqurs/ggvg1S8ixUqmCJ0ElhsTNmIKlDL7vPVWnWwUieHwTff+7kUtAhcZo/5pchiDLmskhL8NebgXUGIuhE/H3E6gbBi80J6gSRnYA3yfkWVfQs+691SrEdviKvdhFtIWUaKX3Nqtr00X6vMhrv/FfHLZvh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iBdhs7jU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iBdhs7jU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 536EF1F000E9;
	Wed,  5 Aug 2026 09:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785920842;
	bh=n6j+r2aySq3vbagzG6uXiIoHKnNOhVDFA/2TCxgRiS0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=iBdhs7jUQaHuD4S0GiReJEJbIqkaUBKtt7iV461bZhDSVS24pXpFDQazjk6hUJNZU
	 a3/vHMxqwTi6TSXMWvlmCKEaZpI+MDD+su2F6wyYH9BCDj9NUJcFnb+KElhOVS17Wg
	 yQ8jUnmcYvQo4DuXxZmvEU0SYCsMDGdXIYxK2LUxrmQyVzqYvacOIlCb89UJNflFhb
	 HQwNu6HU+f5lSVKhOu9/EhcPnDfyl+5nBXXQiMbRaO2prRQV8w5H2klhbHC5hGRsR3
	 jQkDNqRpfkZf7TVSTVW9uqIch8DCeFz4KRHDtf40QbQNHSiVC08Bjc4TnrwHsYPOMI
	 JyykHZjJ2P86A==
Message-ID: <dbdb0f70-669b-4c68-a9cf-89d30c20f12f@kernel.org>
Date: Wed, 5 Aug 2026 11:07:18 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/memory-failure: fix concurrent access issue in
 min_order_for_split()
To: dayou5941@163.com, akpm@linux-foundation.org, ljs@kernel.org
Cc: ziy@nvidia.com, linux-mm@kvack.org, liyouhong <liyouhong@kylinos.cn>,
 Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
References: <20260805072625.2437636-1-dayou5941@163.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260805072625.2437636-1-dayou5941@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/5/26 09:26, dayou5941@163.com wrote:
> From: liyouhong <liyouhong@kylinos.cn>
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

I recall that a mapping can get freed after truncating the last folio.

But Lorenzo had some cocnerns about the validity of the report, so I'll let him reply.

> 
> Fixes: 689b8986776c ("mm/memory-failure: improve large block size folio handling")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260803060001.800638-1-dayou5941@163.com
> Cc: stable@vger.kernel.org
> Signed-off-by: liyouhong <liyouhong@kylinos.cn>
> ---
> v2:
> - Dropped the approach of caching folio->mapping inside min_order_for_split() in favor of adding the folio lock at the callers.
> - Added VM_WARN_ON_ONCE_FOLIO() in min_order_for_split().
> - Updated the commit message to clarify that the real issue is the callers not holding the folio lock, rather than a TOCTOU race.
> v1: https://lore.kernel.org/all/20260804035828.2684059-1-dayou5941@163.com/
> 
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

We already grab the page lock in try_to_split_thp_page(). I think these
needs a serious cleanup.

While at it, we can fix the missing put_page() in case new_order != 0 in
soft_offline_in_use_page() ...

So i think we really should do the following:


From 58c4ccbb04e13c4c14ef7a94f4b44f8901183081 Mon Sep 17 00:00:00 2001
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 5 Aug 2026 11:01:46 +0200
Subject: [PATCH] tmp

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/memory-failure.c | 46 +++++++++++++++------------------------------
 1 file changed, 15 insertions(+), 31 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index aaf14608b30e2..de97a7a36764d 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1705,26 +1705,6 @@ static int identify_page_state(unsigned long pfn, struct page *p,
 	return page_action(ps, p, pfn);
 }
 
-/*
- * When 'release' is 'false', it means that if thp split has failed,
- * there is still more to do, hence the page refcount we took earlier
- * is still needed.
- */
-static int try_to_split_thp_page(struct page *page, unsigned int new_order,
-		bool release)
-{
-	int ret;
-
-	lock_page(page);
-	ret = split_huge_page_to_order(page, new_order);
-	unlock_page(page);
-
-	if (ret && release)
-		put_page(page);
-
-	return ret;
-}
-
 static void unmap_and_kill(struct list_head *to_kill, unsigned long pfn,
 		struct address_space *mapping, pgoff_t index, int flags)
 {
@@ -2509,7 +2489,6 @@ int memory_failure(unsigned long pfn, int flags)
 	folio_unlock(folio);
 
 	if (folio_test_large(folio)) {
-		const int new_order = min_order_for_split(folio);
 		int err;
 
 		/*
@@ -2526,24 +2505,24 @@ int memory_failure(unsigned long pfn, int flags)
 		 * page is a valid handlable page.
 		 */
 		folio_set_has_hwpoisoned(folio);
-		err = try_to_split_thp_page(p, new_order, /* release= */ false);
+
+		lock_page(p);
+		err = split_huge_page_to_order(p, min_order_for_split(folio));
+		unlock_page(p);
 		/*
 		 * If splitting a folio to order-0 fails, kill the process.
 		 * Split the folio regardless to minimize unusable pages.
 		 * Because the memory failure code cannot handle large
 		 * folios, this split is always treated as if it failed.
 		 */
-		if (err || new_order) {
-			/* get folio again in case the original one is split */
-			folio = page_folio(p);
+		folio = page_folio(p);
+		if (folio_test_large(folio)) {
 			res = -EHWPOISON;
 			kill_procs_now(p, pfn, flags, folio);
 			put_page(p);
 			action_result(pfn, MF_MSG_UNSPLIT_THP, MF_FAILED);
 			goto unlock_mutex;
 		}
-		VM_BUG_ON_PAGE(!page_count(p), p);
-		folio = page_folio(p);
 	}
 
 	/*
@@ -2862,8 +2841,7 @@ static int soft_offline_in_use_page(struct page *page)
 	};
 
 	if (!huge && folio_test_large(folio)) {
-		const int new_order = min_order_for_split(folio);
-
+		lock_page(page);
 		/*
 		 * If new_order (target split order) is not 0, do not split the
 		 * folio at all to retain the still accessible large folio.
@@ -2871,8 +2849,14 @@ static int soft_offline_in_use_page(struct page *page)
 		 * preferred, split it to non-zero new_order like it is done in
 		 * memory_failure().
 		 */
-		if (new_order || try_to_split_thp_page(page, /* new_order= */ 0,
-						       /* release= */ true)) {
+		if (!min_order_for_split(folio))
+			ret = split_huge_page_to_order(page, 0);
+		else
+			ret = -EBUSY;
+		unlock_page(page);
+
+		if (ret) {
+			put_page(page);
 			pr_info("%#lx: thp split failed\n", pfn);
 			return -EBUSY;
 		}
-- 
2.43.0


Likely some more cleanups on top are possible.

-- 
Cheers,

David
