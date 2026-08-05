Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559A840EB96
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 09:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785923622; cv=none; b=rgFjPryah6KqneagWNzdJcY8UL+yBu+QafEmo0IOoiCkiR898nt+FlYnnGXMTiIK7bODRaHXLAdAfjo2ziBZ0S6aYLnDo03tmRlqE1Y4u9u9MWAhF6iOJ2TCtN7oAYDOkmre3J1+g55lACic1rc8PbQgXD/B+fDQzT4fyChvYtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785923622; c=relaxed/simple;
	bh=kMiOimVBAWf9uUOjQWAtga3JFxbHuwhz4Hc+QPnEPRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rcCDz0PUGwdkqCp6wKVFFoGER1SmSmxCkVPG33/iYUht+mUpFWHKJRrtknlwe/CaDseBT38AxQTBC//+P/53e+oNJtPjIclF7uM15NejFrlIqYuJaiaxdhyJw6GSX3HIt35YVgsm/5XKlOvv1qDKNChKoyJ026vE4w+HwnD7exQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eE2alzE8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eE2alzE8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C1801F000E9;
	Wed,  5 Aug 2026 09:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785923621;
	bh=YrolkhV9rXn9LK2kY9eNRk2qQzBqsb8tLQDxItBSKKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eE2alzE8E+jaqfmbu75Ge6evt57tPp6yYOKTlVM7K7QzERk/8WCh+Bc7tcKc1K6XT
	 QhmiVsBweuyarqsE8rQ+Hk9jg7/VPJsIGPC2Y/eWBNJqN2L4kR9m3PJe//c24+vEgN
	 QWuznqdhVCkLo+c439oSM/KiId8hbNm+NXDA6vep6b4ELngihEsbWJNddlVQTDxRG8
	 FbC0qCXhVOv93KQmZi5c5gyigAFDQKheeEpD4SzMkwGaH8ZRC9Edgc85w4OmJWpSaf
	 nCCM3W5Zi+gFmGMSvdJxz3bMGP2B6N9GROBEAFHcSeVcgUPi5V2xmpXSinh13Y6JKA
	 /sNOBAEW9XOWQ==
Date: Wed, 5 Aug 2026 10:53:24 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: =?utf-8?B?5p2O5L2R6bi/?= <dayou5941@163.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, 
	akpm@linux-foundation.org, ziy@nvidia.com, linux-mm@kvack.org, 
	liyouhong <liyouhong@kylinos.cn>, Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/memory-failure: fix concurrent access issue in
 min_order_for_split()
Message-ID: <anMHc8GfhnWnjJ1-@lucifer>
References: <20260805072625.2437636-1-dayou5941@163.com>
 <dbdb0f70-669b-4c68-a9cf-89d30c20f12f@kernel.org>
 <7dc76bc6.794a.19fd14ea780.Coremail.dayou5941@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7dc76bc6.794a.19fd14ea780.Coremail.dayou5941@163.com>

On Wed, Aug 05, 2026 at 05:43:40PM +0800, 李佑鸿  wrote:
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
> At 2026-08-05 17:07:18, "David Hildenbrand (Arm)" <david@kernel.org> wrote:
> >On 8/5/26 09:26, dayou5941@163.com wrote:
> >> From: liyouhong <liyouhong@kylinos.cn>
> >>
> >> min_order_for_split() accesses folio->mapping without proper
> >> synchronization. While the compiler typically caches the value
> >> in a register making a NULL deref unlikely in practice, the
> >> real issue is that the callers in memory-failure.c do not hold
> >> the folio lock at the time of the call:
> >>
> >> - memory_failure() explicitly drops the folio lock before calling
> >>   min_order_for_split().
> >> - soft_offline_in_use_page() has not yet acquired the folio lock
> >>   when calling min_order_for_split().
> >>
> >> This means the value of folio->mapping may be modified by a
> >> truncate or invalidate operation while min_order_for_split() is
> >> executing, leading to a torn read or use of a stale mapping value.
> >
> >I recall that a mapping can get freed after truncating the last folio.
> >
> >But Lorenzo had some cocnerns about the validity of the report, so I'll let him reply.
> >
> >>
> >> Fixes: 689b8986776c ("mm/memory-failure: improve large block size folio handling")
> >> Reported-by: Sashiko <sashiko-bot@kernel.org>
> >> Closes: https://sashiko.dev/#/patchset/20260803060001.800638-1-dayou5941@163.com
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: liyouhong <liyouhong@kylinos.cn>
> >> ---
> >> v2:
> >> - Dropped the approach of caching folio->mapping inside min_order_for_split() in favor of adding the folio lock at the callers.
> >> - Added VM_WARN_ON_ONCE_FOLIO() in min_order_for_split().
> >> - Updated the commit message to clarify that the real issue is the callers not holding the folio lock, rather than a TOCTOU race.
> >> v1: https://lore.kernel.org/all/20260804035828.2684059-1-dayou5941@163.com/
> >>
> >> ---
> >>  mm/huge_memory.c    |  2 ++
> >>  mm/memory-failure.c | 12 ++++++++++--
> >>  2 files changed, 12 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >> index 58cabe6af33d..e3f16dadc1d4 100644
> >> --- a/mm/huge_memory.c
> >> +++ b/mm/huge_memory.c
> >> @@ -4300,6 +4300,8 @@ int folio_split(struct folio *folio, unsigned int new_order,
> >>   */
> >>  unsigned int min_order_for_split(struct folio *folio)
> >>  {
> >> +	VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
> >> +
> >>  	if (folio_test_anon(folio))
> >>  		return 0;
> >>
> >> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> >> index 3b1e6946821b..7391524b5046 100644
> >> --- a/mm/memory-failure.c
> >> +++ b/mm/memory-failure.c
> >> @@ -2437,12 +2437,17 @@ int memory_failure(unsigned long pfn, int flags)
> >>  		res = -EOPNOTSUPP;
> >>  		goto unlock_mutex;
> >>  	}
> >> +
> >>  	folio_unlock(folio);
> >>
> >>  	if (folio_test_large(folio)) {
> >> -		const int new_order = min_order_for_split(folio);
> >> +		const int new_order;
> >>  		int err;
> >>
> >> +		folio_lock(folio);
> >> +		new_order = min_order_for_split(folio);
> >> +		folio_unlock(folio);
> >> +
> >>  		/*
> >>  		 * The flag must be set after the refcount is bumped
> >>  		 * otherwise it may race with THP split.
> >> @@ -2796,8 +2801,11 @@ static int soft_offline_in_use_page(struct page *page)
> >>  	};
> >>
> >>  	if (!huge && folio_test_large(folio)) {
> >> -		const int new_order = min_order_for_split(folio);
> >> +		const int new_order;
> >>
> >> +		folio_lock(folio);
> >> +		new_order = min_order_for_split(folio);
> >> +		folio_unlock(folio);
> >>  		/*
> >>  		 * If new_order (target split order) is not 0, do not split the
> >>  		 * folio at all to retain the still accessible large folio.
> >
> >We already grab the page lock in try_to_split_thp_page(). I think these
> >needs a serious cleanup.
> >
> >While at it, we can fix the missing put_page() in case new_order != 0 in
> >soft_offline_in_use_page() ...
> >
> >So i think we really should do the following:
> >
> >
> >From 58c4ccbb04e13c4c14ef7a94f4b44f8901183081 Mon Sep 17 00:00:00 2001
> >From: "David Hildenbrand (Arm)" <david@kernel.org>
> >Date: Wed, 5 Aug 2026 11:01:46 +0200
> >Subject: [PATCH] tmp
> >
> >Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> >---
> > mm/memory-failure.c | 46 +++++++++++++++------------------------------
> > 1 file changed, 15 insertions(+), 31 deletions(-)
> >
> >diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> >index aaf14608b30e2..de97a7a36764d 100644
> >--- a/mm/memory-failure.c
> >+++ b/mm/memory-failure.c
> >@@ -1705,26 +1705,6 @@ static int identify_page_state(unsigned long pfn, struct page *p,
> > 	return page_action(ps, p, pfn);
> > }
> >
> >-/*
> >- * When 'release' is 'false', it means that if thp split has failed,
> >- * there is still more to do, hence the page refcount we took earlier
> >- * is still needed.
> >- */
> >-static int try_to_split_thp_page(struct page *page, unsigned int new_order,
> >-		bool release)
> >-{
> >-	int ret;
> >-
> >-	lock_page(page);
> >-	ret = split_huge_page_to_order(page, new_order);
> >-	unlock_page(page);
> >-
> >-	if (ret && release)
> >-		put_page(page);
> >-
> >-	return ret;
> >-}
> >-
> > static void unmap_and_kill(struct list_head *to_kill, unsigned long pfn,
> > 		struct address_space *mapping, pgoff_t index, int flags)
> > {
> >@@ -2509,7 +2489,6 @@ int memory_failure(unsigned long pfn, int flags)
> > 	folio_unlock(folio);
> >
> > 	if (folio_test_large(folio)) {
> >-		const int new_order = min_order_for_split(folio);
> > 		int err;
> >
> > 		/*
> >@@ -2526,24 +2505,24 @@ int memory_failure(unsigned long pfn, int flags)
> > 		 * page is a valid handlable page.
> > 		 */
> > 		folio_set_has_hwpoisoned(folio);
> >-		err = try_to_split_thp_page(p, new_order, /* release= */ false);
> >+
> >+		lock_page(p);
> >+		err = split_huge_page_to_order(p, min_order_for_split(folio));
> >+		unlock_page(p);
> > 		/*
> > 		 * If splitting a folio to order-0 fails, kill the process.
> > 		 * Split the folio regardless to minimize unusable pages.
> > 		 * Because the memory failure code cannot handle large
> > 		 * folios, this split is always treated as if it failed.
> > 		 */
> >-		if (err || new_order) {
> >-			/* get folio again in case the original one is split */
> >-			folio = page_folio(p);
> >+		folio = page_folio(p);
> >+		if (folio_test_large(folio)) {
> > 			res = -EHWPOISON;
> > 			kill_procs_now(p, pfn, flags, folio);
> > 			put_page(p);
> > 			action_result(pfn, MF_MSG_UNSPLIT_THP, MF_FAILED);
> > 			goto unlock_mutex;
> > 		}
> >-		VM_BUG_ON_PAGE(!page_count(p), p);
> >-		folio = page_folio(p);
> > 	}
> >
> > 	/*
> >@@ -2862,8 +2841,7 @@ static int soft_offline_in_use_page(struct page *page)
> > 	};
> >
> > 	if (!huge && folio_test_large(folio)) {
> >-		const int new_order = min_order_for_split(folio);
> >-
> >+		lock_page(page);
> > 		/*
> > 		 * If new_order (target split order) is not 0, do not split the
> > 		 * folio at all to retain the still accessible large folio.
> >@@ -2871,8 +2849,14 @@ static int soft_offline_in_use_page(struct page *page)
> > 		 * preferred, split it to non-zero new_order like it is done in
> > 		 * memory_failure().
> > 		 */
> >-		if (new_order || try_to_split_thp_page(page, /* new_order= */ 0,
> >-						       /* release= */ true)) {
> >+		if (!min_order_for_split(folio))
> >+			ret = split_huge_page_to_order(page, 0);
> >+		else
> >+			ret = -EBUSY;
> >+		unlock_page(page);
> >+
> >+		if (ret) {
> >+			put_page(page);
> > 			pr_info("%#lx: thp split failed\n", pfn);
> > 			return -EBUSY;
> > 		}
> >--
> >2.43.0
> >
> >
> >Likely some more cleanups on top are possible.
>
> >
>
>
> Thanks David and Lorenzo for the detailed feedback.
>
> For v3 I plan to:

v4 you mean :) you already sent a v3 way too quick.

Please send this tomorrow, not today.

>
> 1. Take David's patch as the base, with his Signed-off-by preserved.

That's only if you added a Co-developed-by, David can indicate what he wants.

> 2. Add my VM_WARN_ON_ONCE_FOLIO() in min_order_for_split() as a
>    separate patch.

Yup.

> 3. Address Lorenzo's comment about returning ret directly in
>    soft_offline_in_use_page().

You should respond to review inline.

Just take take David's patch + the VM_WARN_ON_ONCE().

> 4. Fold my earlier standalone put_page() fix into this series
>    and mark it as superseded.
>    link：https://lore.kernel.org/all/20260804035356.2615408-1-dayou5941@163.com/

Not sure what folded means?

Again as above, just take David's patch + the VM_WARN_ON_ONCE().

> 5. Split the series logically if needed (e.g., one patch for
>    removing try_to_split_thp_page(), one for the lock fix, one
>    for the put_page() fix).

No because you'll create bisection hazards. Just 1 patch please.

>
> Please let me know if this plan looks reasonable or if you'd prefer
> a different approach.

As above.

--
Cheers, Lorenzo
