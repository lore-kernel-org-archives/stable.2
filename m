Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794905731;
	b=FsLyKHD03oQMv+C6e8mN0W77wb5OwDJA48Rpm4wyEio+g/KsM/QaOWUu8kttTGtJdnAx
	 qg2jzf2DiDn+Y1gZUEhGntHaL+aV7+5IOw32G6ksgD7/6I7N5r1qDEoeiqdaC3OmB+NBx
	 Cr+3OcBPFGo5g3WerQRkczli17pX9g4p4sIx+dawQG8EZL2QjFwaBk8ntiw09HKr4jZJt
	 8yu/i0lqrkTruXhm+FTg0XPa+NGix14/IjdEuRWO6BhPDuIYUCO+yggXkc9incnW/ljf0
	 6b0++q03/GBtd5o8AImvvZZ2pFoS4ezLXNEjw5OcG/X6HeunKCl76pWsGP21+fMgT2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794905731;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=pgVcSU/aMeCi5WR+Zma/r75YD6kHKzmWW1H5YA8II4I=;
	b=deKszOFrLOJyQOnZQ+U/UHJ607XX4jbpesC9QWB0qRtiY8Abc4eTd7pwgk7gjsuj9Hes
	 IGoPH8kEoPTPVRDXYcRWferrApBQs+pAIswMx4X/uA+lQJiISrbeyzTgsGDtaxMJq2IoM
	 75WGz7VrOaNdOjXgtZ/1ITJQR83l0KKlWuw1K2UNpJPf7tVyS67PzJoBadGww/2g4urmO
	 a3IFFA48vpJ3019mXyJ9+MiRCwo/nV5DHc/h7ZsMpE06r3nV1z/dXjGt8/zHuGNnx+Uw3
	 aL3u1ycme+++o9Uft3K1TmDaV0IhmNU7/9UDfsUJafFyve1ODRs47yi0F82yKWoMkYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NXnP4h9Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AF2606A31C;
	Tue, 17 Nov 2026 08:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NXnP4h9Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F33DE1F000C5;
	Tue, 17 Nov 2026 08:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794905730;
	bh=pgVcSU/aMeCi5WR+Zma/r75YD6kHKzmWW1H5YA8II4I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=NXnP4h9ZLKQp/yv6xp8Mq9D29fzGPwE702aI7YzNPbW/8XFGVjeccsbLKyQdVCQbg
	 Xay7x1IUmBsXEAaRsiPz8hf5s31kSQ1F6We01HCjZZnDtur0imYDCbQNLIhcGbffyZ
	 red3cbtSe2MaJL0bCPaTO30y56VaW8yFJJWOVcL/8V6i7+iRz5NEGMQw2GgNhK3Pjx
	 fZA9RwTdqgNIWaz7NUzuRf+wGAgZ2ALAWawfZORE/x1HsdlXebiUp6XNKq3VaHmbyt
	 NZA3nEf3FCQlJEzXRJywxptCD6y5bUhpSdV17eXe5nPg1SKVjp2QI9gCdrb91idWoT
	 KXvOzWKxg7PeQ==
Message-ID: <c7c8ba0f-49ff-4b22-bd24-20fc394b1e36@kernel.org>
Date: Tue, 17 Nov 2026 09:55:24 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/memory: mark unshare copies dirty to fix MADV_FREE
 data loss
To: Daniel Wade <danjwade95@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 stable@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20261116111245.28871-1-danjwade95@gmail.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261116111245.28871-1-danjwade95@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/16/26 12:12, Daniel Wade wrote:
> MADV_FREE in one process can make reclaim free an anonymous page that
> another process still maps and never gave up, which then reads zeroes.
> It happens with a page copied by an unshare fault and shared by a later
> fork().

Thanks for the report.

> 
> MADV_FREE and lazyfree reclaim rely on an unwritten rule: an anonymous
> folio whose content a mapping still needs has a dirty PTE in that
> mapping, PG_dirty set, or a swap cache entry. madvise_free_pte_range()
> only checks for other mappers on a folio that is already dirty or in the
> swap cache. Any other folio it covers is marked lazyfree once the
> caller's PTEs are clean, even when other processes map it, and
> try_to_unmap_one() then drops those clean PTEs and frees the folio.
> 
> The copy wp_page_copy() makes for FAULT_FLAG_UNSHARE breaks the rule:
> pte_mkdirty() is applied only for write faults, so the copy has a clean
> PTE, no PG_dirty and no swap cache entry. Unshare faults come from R/O
> pins on non-exclusive anonymous pages, for example process_vm_readv() on
> a page shared with a child, or KSM unmerging one. If the process forks
> after the pin is gone, MADV_FREE in either process frees the page under
> the other.
> 
> Mark the copy dirty with folio_set_dirty(), as ksm_might_need_to_copy()
> does for its copy. pte_mkdirty() is not suitable: on x86 it also sets the
> soft-dirty bit, which this path carries over from the old PTE.
> 
> Side effect: smaps and numa_maps now count an unshare copy as

numa_maps does not show any such data. Did you mean smaps_rollup ?

> Private_Dirty or Shared_Dirty rather than _Clean. The PTE is unchanged.
> 
> Fixes: c89357e27f20 ("mm: support GUP-triggered unsharing of anonymous pages")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daniel Wade <danjwade95@gmail.com>
> ---
> Tested on mainline b3dfbde62cf1; mm/memory.c and mm/madvise.c are identical
> in v7.4-rc3. x86-64, KASAN and PROVE_LOCKING, 2 vCPUs under KVM, no swap,
> as uid 65534, with only this patch applied.
> 
> The test gives an unshare copy to a child, has the parent MADV_FREE it and
> a control page it alone maps, then waits for reclaim.
> - without: "test page in the child (unshare copy): present 0, 4096 of 4096
>   bytes wrong"; an ordinary shared page freed the same way stays intact.
> - with: the child's page is intact, the control page still discarded.
> Same two results on v6.12.117, there with folio_set_dirty() placed earlier
> in the same function. No KASAN or lockdep report in any run.
> 
> Two other ways to reach the same state are known and unchanged here:
> khugepaged collapse to a sub-PMD folio in a non-writable VMA (covered by
> "mm/khugepaged: mark a collapsed mTHP dirty"), and a swap-cache-skipping
> read fault in the stable trees that still skip it. Checking for other
> mappers in madvise_free_pte_range() covers all three and passed the same
> tests, but changes MADV_FREE for every shared clean page.
> 
>  mm/memory.c |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index ec3d9d99ccee..49f6dc92c020 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4130,6 +4130,14 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
>  		entry = folio_mk_pte(new_folio, vma->vm_page_prot);
>  		entry = pte_sw_mkyoung(entry);
>  		if (unlikely(unshare)) {
> +			/*
> +			 * The PTE stays clean, and pte_mkdirty() would also
> +			 * set soft-dirty, which is carried over below. Mark
> +			 * the folio dirty instead: MADV_FREE and lazyfree
> +			 * reclaim may drop a clean anon folio that has no
> +			 * swap entry, even one others still map.
> +			 */
> +			folio_set_dirty(new_folio);
>  			if (pte_soft_dirty(vmf->orig_pte))
>  				entry = pte_mksoft_dirty(entry);
>  			if (pte_uffd(vmf->orig_pte)) {

We should always prefer setting the pte dirty, not the folio, as the latter
needs atomics. If that sets the soft-dirty bit, we can clear that if
required, So something cheaper would be:

diff --git a/mm/memory.c b/mm/memory.c
index ec3d9d99ccee2..22106e016da91 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4130,8 +4130,16 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
                entry = folio_mk_pte(new_folio, vma->vm_page_prot);
                entry = pte_sw_mkyoung(entry);
                if (unlikely(unshare)) {
+                       entry = pte_mkdirty(entry);
                        if (pte_soft_dirty(vmf->orig_pte))
                                entry = pte_mksoft_dirty(entry);
+                       else
+                               entry = pte_clear_soft_dirty(entry);
                        if (pte_uffd(vmf->orig_pte)) {
                                entry = pte_mkuffd(entry);
                                if (userfaultfd_rwp(vma))

That would be acceptable as a quick fix.


But I am wondering which rule we actually want to follow in the future.

folio_add_new_anon_rmap() always sets __folio_set_swapbacked().

In vmscan, we run into

if (folio_test_anon(folio) && folio_test_swapbacked(folio) &&
    !folio_test_swapcache(folio)) {

	...
	folio_mark_dirty(folio);
}

That's what traditionally meant: even if the pte+folio is not dirty, we will dirty it once during
reclaim.

So if we go down the path here, that means, any pte has to be dirty when it starts in a process.
I think we mostly follow that logic already.

But the real problem is that MADV_FREE messes with that logic as it operates on shared folios. I
don't think it should have ever done that.

A more future proof solution would be to only allow MADV_FREE if we are the exclusive folio owner, checked under
folio lock. In madvise_free_huge_pmd() we almost do the correct thing: we would just have to recheck under
folio lock.


So something less shaky in the future could be:

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index eb913acb03b74..020bee9b47e93 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2437,15 +2437,19 @@ bool madvise_free_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	if (folio_is_zone_device(folio))
 		goto out;
 
+	if (folio_maybe_mapped_shared(folio))
+		goto out;
+	if (!folio_trylock(folio))
+		goto out;
+
 	/*
 	 * If other processes are mapping this folio, we couldn't discard
 	 * the folio unless they all do MADV_FREE so let's skip the folio.
 	 */
-	if (folio_maybe_mapped_shared(folio))
-		goto out;
-
-	if (!folio_trylock(folio))
+	if (folio_maybe_mapped_shared(folio) || folio_test_swapcache(folio)) {
+		folio_unlock(folio);
 		goto out;
+	}
 
 	/*
 	 * If user want to discard part-pages of THP, split it so MADV_FREE
diff --git a/mm/madvise.c b/mm/madvise.c
index 0214efd2a014f..9be519a72e856 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -753,38 +753,37 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 			}
 		}
 
-		if (folio_test_swapcache(folio) || folio_test_dirty(folio)) {
-			if (!folio_trylock(folio))
-				continue;
-			/*
-			 * KSM folios can gain new mappings at any time, so we must
-			 * not clear their dirty flag.
-			 */
-			if (folio_test_ksm(folio)) {
-				folio_unlock(folio);
-				continue;
-			}
-
-			/*
-			 * If we have a large folio at this point, we know it is
-			 * fully mapped so if its mapcount is the same as its
-			 * number of pages, it must be exclusive.
-			 */
-			if (folio_mapcount(folio) != folio_nr_pages(folio)) {
-				folio_unlock(folio);
-				continue;
-			}
+		if (folio_mapcount(folio) != folio_nr_pages(folio))
+			continue;
+		if (!folio_trylock(folio))
+			continue;
+		/*
+		 * KSM folios can gain new mappings at any time, so we must
+		 * not clear their dirty flag.
+		 */
+		if (folio_test_ksm(folio)) {
+			folio_unlock(folio);
+			continue;
+		}
 
-			if (folio_test_swapcache(folio) &&
-			    !folio_free_swap(folio)) {
-				folio_unlock(folio);
-				continue;
-			}
+		/*
+		 * If we have a large folio at this point, we know it is
+		 * fully mapped so if its mapcount is the same as its
+		 * number of pages, it must be exclusive.
+		 */
+		if (folio_mapcount(folio) != folio_nr_pages(folio)) {
+			folio_unlock(folio);
+			continue;
+		}
 
-			folio_clear_dirty(folio);
+		if (folio_test_swapcache(folio) && !folio_free_swap(folio)) {
 			folio_unlock(folio);
+			continue;
 		}
 
+		folio_clear_dirty(folio);
+		folio_unlock(folio);
+
 		if (pte_young(ptent) || pte_dirty(ptent)) {
 			clear_young_dirty_ptes(vma, addr, pte, nr, cydp_flags);
 			tlb_remove_tlb_entries(tlb, pte, nr, addr);


But that means that folios we cannot trylock cannot be marked lazyfree. Well, the PTE path
would now match the PMD path.

-- 
Cheers,

David
