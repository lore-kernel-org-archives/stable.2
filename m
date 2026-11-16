Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794831942;
	b=Y/gXxgfkHDLid/hIqaL4lRBn0ZRw2XSfUZ5bx2VuS5MOx+6pcWGHTl3/2YzA3/1wyMbi
	 /NXuvkgGxZg4JMTKcvEUYGkt3ABbEYTfkT4rAkwuxIEftyExdWDRmpdjaX9/utF4QXGoj
	 QEsYpi1X4N9uSjIK6l3V55z4VvzYmuMGHdIWK00oflhS6qWU6GLWOd6a/ZVuVdt9M/IuG
	 vtG2xnTxbTFnoZ4NqBHl+A7ApL1ozPVu948Y4lu7BBPzme3YIr8RxiF9K4U6thJoEeFnX
	 aLBanc8Z2D7pACoeCANeFm9PgLFcFYYac/UMfk8x5ngfJ8oVWFClV9A915DlrJZwAyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794831942;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=gi79+XoXqFf6M+9FjBrV+lzhUeFwzDXDVGszwjQHllI=;
	b=iEEw9vLD2pZ0nUYhBEW0BIk4Tf3ZhVM01Zpk7eL/2A6jGUuFZfJQsvQj0DOwzKFfJthx
	 wt/A6NzgkWvYVaku1EARV1m8i8O/K+o+UmsrCfJ6nsUzQ1grBhtoeUZkj/o6akMjg3URk
	 VqR4mJ967RVxjGujgDb/fGtLIOZuCknQ4cPqM4M5CXYIPaTNFYidgO/3+BRjRR+HijZaF
	 /p7YUR27njZLEmncey8+DtSd/S9fPKN9NZ9CnNQjhwiSeCkQ1dTGI+3PL73PI5TqNjmk3
	 5OC+FNQiyhnLeC1bA0izn4kBvuv3ZbTMIujS5OSwdVk9+pnv1fwsRvN5DMklau9rrUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WQGjTdSh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1844606A31C;
	Mon, 16 Nov 2026 12:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WQGjTdSh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD05B1F000C4;
	Mon, 16 Nov 2026 12:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794831941;
	bh=gi79+XoXqFf6M+9FjBrV+lzhUeFwzDXDVGszwjQHllI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WQGjTdShVZ2NsQissioF3bSI6AIqPu7Xs7IOFqKbEZ1TwyZacX9rMt5ZpiwEzCmix
	 y+Dg0x1YTexZruLN+tn1SCgz2oGNhTXaqNv2aKejnnXP4gknnF5t9RSP+6+mY9LPQW
	 JnO+ruVKJZh8IV4kaC8rrw5mmjHrwMCmgSxfQSWd4enb/xVeNqvkor7vriHfxN9eUZ
	 mLc/G74OTOYACZxpxiBmwHBP/SSflVDcR9c+xwgFx4Be5YTGh5SpOFqF/pJ/XugtJf
	 OfwqRPinT/lp6tCGRkCG4nMsflb0uqBDHv+E29GdaPIFRqsKU2nqZdnPGZfLA+vvxy
	 1rIKIzTcM7zQw==
Date: Mon, 16 Nov 2026 12:25:32 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Arnd Bergmann <arnd@arndb.de>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>, 
	Ross Zwisler <zwisler@kernel.org>, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, Chris Mason <mason@kernel.org>
Subject: Re: [PATCH] mm/huge_memory: flush dirty file PMDs before removing
 rmap
Message-ID: <avrxOt_GyXLXNqtR@gremlin>
References: <20261113-dirty_file_pmd-v1-1-8c11f2a2e65f@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113-dirty_file_pmd-v1-1-8c11f2a2e65f@kernel.org>

On Fri, Nov 13, 2026 at 06:15:26PM +0100, David Hildenbrand (Arm) wrote:
> Unmapping a file PMD can lose concurrent stores when it races with
> writeback. zap_huge_pmd() removes rmap and drops the PMD lock before the
> gather flushes the TLB. Writeback can then clean the folio while another
> CPU can still write through a stale writable TLB entry. Those stores do
> not fault and dirty the folio again. Filesystem DAX has the same problem
> with its dirty tags.
>
> Commit 5df397dec7c4 ("mm: delay page_remove_rmap() until after the TLB
> has been flushed") fixed the same race for PTEs by adding delayed rmap
> removal to the mmu_gather infrastructure. The PMD path still removes
> rmap before flushing.
>
> Flush the TLB under the PMD lock before removing rmap for dirty file
> PMDs. Skip the early flush at address-space teardown, when no users
> remain, and for mappings without writeback, including shmem and device
> DAX.
>
> Use tlb_can_delay_rmap() to share the PTE path's architecture checks.
> On s390, clearing the entry already handles TLB synchronization, and
> __tlb_remove_page_size() immediately drops the mapping reference, so
> rmap must be removed first. UP cannot have concurrent stores from
> another CPU while holding the page table lock. Make the predicate
> side-effect-free and set the gather's delayed_rmap flag when an entry
> is actually queued for delayed rmap removal.
>
> Queue the folio before the early flush, while the gather still has a
> valid range. Keep batching references and drain a full batch only after
> dropping the PMD lock. The early flush resets the gather's TLB state,
> so draining the batch does not flush that range again.
>
> Although writing to files through mmap is generally discouraged,
> unmapping such mappings may become slower: each dirty file PMD now
> requires a TLB flush under the PMD lock. Future work should properly
> extend the delayed-rmap machinery to PMDs and hold the PMD spinlock
> across multiple entries, so their TLB invalidations and rmap removals
> can be batched.
>
> Fixes: 4b4bb46d00b3 ("dax: clear dirty entry tags on cache flush")
> Cc: stable@vger.kernel.org
> Reported-by: Kiryl Shutsemau <kas@kernel.org>
> Link: https://lore.kernel.org/linux-mm/aoWw_iKEDLjKL2jr@thinkstation/
> Reported-by: Chris Mason <mason@kernel.org>
> Suggested-by: Lance Yang <lance.yang@linux.dev>
> Suggested-by: Usama Arif <usama.arif@linux.dev>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  include/asm-generic/tlb.h | 10 +++-------
>  mm/huge_memory.c          | 38 ++++++++++++++++++++++++++++++--------
>  mm/memory.c               |  2 +-
>  mm/mmu_gather.c           |  2 ++
>  4 files changed, 36 insertions(+), 16 deletions(-)
>
> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
> index 4bba02fd5d543..2dcf4ce0de589 100644
> --- a/include/asm-generic/tlb.h
> +++ b/include/asm-generic/tlb.h
> @@ -250,11 +250,7 @@ bool __tlb_remove_folio_pages(struct mmu_gather *tlb, struct page *page,
>  		unsigned int nr_pages, bool delay_rmap);
>
>  #ifdef CONFIG_SMP
> -/*
> - * This both sets 'delayed_rmap', and returns true. It would be an inline
> - * function, except we define it before the 'struct mmu_gather'.
> - */
> -#define tlb_delay_rmap(tlb) (((tlb)->delayed_rmap = 1), true)
> +#define tlb_can_delay_rmap() (true)
>  extern void tlb_flush_rmaps(struct mmu_gather *tlb, struct vm_area_struct *vma);
>  #endif
>
> @@ -267,8 +263,8 @@ extern void tlb_flush_rmaps(struct mmu_gather *tlb, struct vm_area_struct *vma);
>   * remote TLBs to flush and is not preemptible due to this
>   * all happening under the page table lock.
>   */
> -#ifndef tlb_delay_rmap
> -#define tlb_delay_rmap(tlb) (false)
> +#ifndef tlb_can_delay_rmap
> +#define tlb_can_delay_rmap() (false)
>  static inline void tlb_flush_rmaps(struct mmu_gather *tlb, struct vm_area_struct *vma) { }
>  #endif
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 7791872f14af7..600a68a54ecf8 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2508,10 +2508,12 @@ static inline void zap_deposited_table(struct mm_struct *mm, pmd_t *pmd)
>  	mm_dec_nr_ptes(mm);
>  }
>
> -static void zap_huge_pmd_folio(struct mm_struct *mm, struct vm_area_struct *vma,
> -		pmd_t pmdval, struct folio *folio, bool is_present)
> +static void zap_huge_pmd_folio(struct mmu_gather *tlb, struct vm_area_struct *vma,
> +		pmd_t pmdval, struct folio *folio, bool is_present, bool *force_flush)
>  {
>  	const bool is_device_private = pmd_is_device_private_entry(pmdval);
> +	struct mm_struct *mm = tlb->mm;
> +	bool delay_rmap = false;
>
>  	if (folio_test_anon(folio)) {
>  		add_mm_counter(mm, MM_ANONPAGES, -HPAGE_PMD_NR);
> @@ -2519,23 +2521,41 @@ static void zap_huge_pmd_folio(struct mm_struct *mm, struct vm_area_struct *vma,
>  		add_mm_counter(mm, mm_counter_file(folio),
>  			       -HPAGE_PMD_NR);
>
> -		if (is_present && pmd_dirty(pmdval))
> +		if (is_present && pmd_dirty(pmdval)) {
>  			folio_mark_dirty(folio);
> +			/*
> +			 * Remove rmap after the TLB flush if other CPUs could
> +			 * still write to a mapping that supports writeback.
> +			 */
> +			if (!tlb->fullmm && vma->vm_file &&
> +			    mapping_can_writeback(vma->vm_file->f_mapping))
> +				delay_rmap = tlb_can_delay_rmap();

Claude flagged an issue here - for UP arches this is false, so
zap_huge_pmd_folio() doesn't flush under the PMD lock or defer the rmap removal.

However, generic mmu_gather still defers the TLB flush on UP, as before.

The commit message says:

	UP cannot have concurrent stores from another CPU while holding the
	page table lock.

But what about after the PTL is dropped? The TLB is still not flushed and
there's a cond_resched() in zap_pmd_range():

	do {
		...
		if (pmd_is_huge(*pmd)) {
			if (next - addr != HPAGE_PMD_SIZE)
				__split_huge_pmd(vma, pmd, addr, false);
			else if (zap_huge_pmd(tlb, vma, pmd, addr)) {
				addr = next;
				continue;
			}
			...
		} ...
		...
	} while (pmd++, cond_resched(), addr != end);

Before the TLB batch is eventually flushed.

It came up with this potential race:

thread A (zap)                 kworker               thread B (same mm)
zap_huge_pmd()
  pmdp_huge_get_and_clear_full()
  folio_mark_dirty()
  folio_remove_rmap_pmd()
  spin_unlock(ptl)
cond_resched()
                               folio_clear_dirty_for_io()
                                 folio_mkclean()
                                   !folio_mapped(), return 0
                               writes folio out
                                                     store through the stale
                                                     writable+dirty TLB entry,
                                                     no fault

Switching between the kworker and threads doesn't flush the TLB and fsdax is
also impacted

So the delta for the change would be to remove the #ifdef CONFIG_SMP block for
setting tlb_can_delay_rmap() to true and just let it sit in the #ifdef
CONFIG_MMU_GATHER_NO_GATHER block and be predicated on that alone.


> +		}
>  		if (is_present && pmd_young(pmdval) &&
>  		    likely(vma_has_recency(vma)))
>  			folio_mark_accessed(folio);
>  	}
>
> +	if (!is_present && !is_device_private)
> +		return;
> +
>  	/*
>  	 * Present and device private folios are rmappable. Remove the
>  	 * rmap after transferring young+dirty to the folio.
>  	 */
> -	if (is_present || is_device_private)
> +	if (!delay_rmap)
>  		folio_remove_rmap_pmd(folio, &folio->page, vma);
>
> -	/* Device private folios are pinned. */
> +	/* Device private folios are pinned and don't need a TLB flush. */
>  	if (is_device_private)
>  		folio_put(folio);
> +	else if (__tlb_remove_page_size(tlb, &folio->page, HPAGE_PMD_SIZE))
> +		*force_flush = true;
> +
> +	if (delay_rmap) {
> +		tlb_flush_mmu_tlbonly(tlb);
> +		folio_remove_rmap_pmd(folio, &folio->page, vma);
> +	}
>  }
>
>  static struct folio *normal_or_softleaf_folio_pmd(struct vm_area_struct *vma,
> @@ -2573,6 +2593,7 @@ bool zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  	struct mm_struct *mm = tlb->mm;
>  	struct folio *folio = NULL;
>  	bool is_present = false;
> +	bool force_flush = false;
>  	bool has_deposit;
>  	spinlock_t *ptl;
>  	pmd_t orig_pmd;
> @@ -2597,13 +2618,14 @@ bool zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  	folio = normal_or_softleaf_folio_pmd(vma, addr, orig_pmd, is_present);
>  	has_deposit = vma_has_deposited_pgtable(vma);
>  	if (folio)
> -		zap_huge_pmd_folio(mm, vma, orig_pmd, folio, is_present);
> +		zap_huge_pmd_folio(tlb, vma, orig_pmd, folio, is_present,
> +				   &force_flush);
>  	if (has_deposit)
>  		zap_deposited_table(mm, pmd);
>
>  	spin_unlock(ptl);
> -	if (is_present && folio)
> -		tlb_remove_page_size(tlb, &folio->page, HPAGE_PMD_SIZE);
> +	if (force_flush)
> +		tlb_flush_mmu(tlb);
>  	return true;
>  }
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 7f019afc35ca0..cd954afb146f4 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1757,7 +1757,7 @@ static __always_inline void zap_present_folio_ptes(struct mmu_gather *tlb,
>  		ptent = get_and_clear_full_ptes(mm, addr, pte, nr, tlb->fullmm);
>  		if (pte_dirty(ptent)) {
>  			folio_mark_dirty(folio);
> -			if (tlb_delay_rmap(tlb)) {
> +			if (tlb_can_delay_rmap()) {
>  				delay_rmap = true;
>  				*force_flush = true;
>  			}
> diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
> index e98397ac577c4..6a2d56970a552 100644
> --- a/mm/mmu_gather.c
> +++ b/mm/mmu_gather.c
> @@ -171,6 +171,8 @@ static bool __tlb_remove_folio_pages_size(struct mmu_gather *tlb,
>  	struct mmu_gather_batch *batch;
>
>  	VM_BUG_ON(!tlb->end);
> +	if (delay_rmap)
> +		tlb->delayed_rmap = 1;
>
>  #ifdef CONFIG_MMU_GATHER_PAGE_SIZE
>  	VM_WARN_ON(tlb->page_size != page_size);
>
> ---
>
> base-commit: 55c8a634fd238bc7e6e2c4010985192ae8163435
>
> change-id: 20261113-dirty_file_pmd-90e63640a593
>
> --
>
> Cheers,
>
> David
>

--
Cheers, Lorenzo
