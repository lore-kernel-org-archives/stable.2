Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793093013;
	b=EAjcppYe/RoP4s9XdpJEwGsqlRlUWKmawTl+ZKGhNhQMaThs2cHuBnPTWdl70l5AryLE
	 SWHjf6Lv2Oj7YT6i2TB9sr+we+vsc3Y3Gc5xkiPqVROlgBNGmiCt2zAp+J+Sitsif8WDq
	 3N/rXRzMxTBbyXtpXcPnimabYiVJ2ssmOimyCrgLtjKAsw49BFlQMdrwLFrU5YWuRVh5f
	 vYBZcxLulB5lo/T3fe7yCWsyddtgSpZdSnir+uL0AE5IPCWZLfS47ThAXujT5hvUNJys8
	 UJmcZARM8qLMyAFN0pcNesoBKWzP8O/SVYzDyD9e1S8tzxTYAvEMF4dLpYmhd1AECzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793093013;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=gKyZ8Btgv2m5r1QzOsn9naTI7JOU43dREIO8vvPdksk=;
	b=uaOFWQX9maxwUkbgV90mzT36M+9DzrSG2YsBLgtiZ8dJXF5sGYKk//jBEciKgPdBsKV2
	 qQ4bHIh41TVx4439w4+L3pBfYnWA5DPnaRpZYJjUUyr8J9oA+v1pUDogOCAJ6pANUEcxz
	 LAJIWjaN92wUfa5Y/tHDtnWsQE8+kd7hUfLQ+Q4ixQcNnk47qmeZFDyIP9R99BKbJ4zWc
	 MCLu7TRvnsun+lVzaffJy4cy4teS8KvS9iSAPvZO9NBHRii9obpi7rLPlyo6AOyebUTB7
	 fi0X97+srhrG/qHTxwaF3SHtKCSVH9uhAbniYnR73lV+pfrh+WZQLYSqf4yLTobMITw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RRIblIbn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8916606A31A;
	Tue, 27 Oct 2026 09:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RRIblIbn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C891B1F01825;
	Tue, 27 Oct 2026 09:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793093012;
	bh=gKyZ8Btgv2m5r1QzOsn9naTI7JOU43dREIO8vvPdksk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RRIblIbn2zLnU8Sr7/XSlAPM/1uYHmreLkJHjINQaRJOZvC9Sgpx42DrJf6dcQTQC
	 ya74iDcLD6vrow+ocCz0IReZYx0P1Q9NsVCfnovJb8AJLEC/y7eFeLPDmrSWxdwf/o
	 TksWubM3qOV6hJ2NxKiMMuWprf9uAh0CfC93xkb8BJ1+c+RRuIAFhPkXhr4omthO8q
	 f7xxqtEGJZKjUL6xCIL7yGA94ZBM9y8WqbzHraQifdUrB3+WWEq4dkNyC5l1Ja6A+i
	 a65v0Umr9leKkV34R9WoWIlBEKeGporP8FyFgIucxi1ALew3as/VXqSDuvgEofOLI8
	 FlmLdC2A7uqbA==
Date: Tue, 27 Oct 2026 09:23:15 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Kairui Song <kasong@tencent.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Baoquan He <baoquan.he@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Hugh Dickins <hughd@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Minchan Kim <minchan@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Xu Xin <xu.xin@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Youngjun Park <youngjun.park@lge.com>, Gregory Price <gourry@gourry.net>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, Chris Mason <mason@kernel.org>, 
	stable@vger.kernel.org
Subject: Re: [PATCH 37/46] mm: fix deadlock of mremap() against UFFDIO_MOVE
Message-ID: <auBtPQcZOSlj1E64@gremlin>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-37-6f74bec9a5bb@kernel.org>
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
In-Reply-To: <20261027-fixes_core-v1-37-6f74bec9a5bb@kernel.org>

On Tue, Oct 27, 2026 at 12:17:57AM +0100, David Hildenbrand (Arm) wrote:
> From: Chris Mason <mason@kernel.org>
>
> With per-VMA locks, UFFDIO_MOVE can run concurrently with mremap()
> on different VMAs in the same mm. Those VMAs can share page tables, so
> both operations can acquire the same pair of page-table locks.
>
> UFFDIO_MOVE orders the locks by address, while mremap() takes the source
> lock first. These conflicting orders can deadlock; mremap() holding
> mmap_lock for writing no longer helps.
>
> Move double_pt_lock() and double_pt_unlock() to mm/internal.h and use
> them for all page-table moves in mremap(). Preserve the source entry
> checks after acquiring both locks. Remove the comments claiming that
> exclusive mmap_lock makes lock ordering irrelevant.
>
> In move_ptes(), make sure to just recheck source and destination PMD
> after taking the locks and drop the overly-long comment.
>
> Fix generated by an LLM and sent by Chris Mason in private.
>
> Fixes: 867a43a34ff8 ("userfaultfd: use per-vma locks in userfaultfd operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ david: use new helpers consistently; simplify description and comments;
>          move_ptes() fixup ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

OK nice, reviewed off-list and this revision looks correct + covers all
cases, so:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  include/linux/userfaultfd_k.h |  2 -
>  mm/huge_memory.c              | 19 ++++------
>  mm/hugetlb.c                  | 14 ++-----
>  mm/internal.h                 | 28 ++++++++++++++
>  mm/mremap.c                   | 87 +++++++++++++++++--------------------------
>  mm/userfaultfd.c              | 27 --------------
>  6 files changed, 72 insertions(+), 105 deletions(-)
>
> diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> index a14b8a9ffb7b1..565e98f342dc8 100644
> --- a/include/linux/userfaultfd_k.h
> +++ b/include/linux/userfaultfd_k.h
> @@ -153,8 +153,6 @@ extern int mrwprotect_range(struct userfaultfd_ctx *ctx, unsigned long start,
>  			    unsigned long len, bool enable_rwp);
>
>  /* move_pages */
> -void double_pt_lock(spinlock_t *ptl1, spinlock_t *ptl2);
> -void double_pt_unlock(spinlock_t *ptl1, spinlock_t *ptl2);
>  int move_pages_huge_pmd(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd, pmd_t dst_pmdval,
>  			struct vm_area_struct *dst_vma,
>  			struct vm_area_struct *src_vma,
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 1b50cc2b35351..08e58cda7d37d 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2645,15 +2645,11 @@ bool move_huge_pmd(struct vm_area_struct *vma, unsigned long old_addr,
>  		return false;
>  	}
>
> -	/*
> -	 * We don't have to worry about the ordering of src and dst
> -	 * ptlocks because exclusive mmap_lock prevents deadlock.
> -	 */
> -	old_ptl = __pmd_trans_huge_lock(old_pmd, vma);
> -	if (old_ptl) {
> -		new_ptl = pmd_lockptr(mm, new_pmd);
> -		if (new_ptl != old_ptl)
> -			spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
> +	old_ptl = pmd_lockptr(mm, old_pmd);
> +	new_ptl = pmd_lockptr(mm, new_pmd);
> +
> +	double_pt_lock(old_ptl, new_ptl);
> +	if (likely(pmd_is_huge(*old_pmd))) {
>  		pmd = pmdp_huge_get_and_clear(mm, old_addr, old_pmd);
>  		if (pmd_present(pmd))
>  			force_flush = true;
> @@ -2682,11 +2678,10 @@ bool move_huge_pmd(struct vm_area_struct *vma, unsigned long old_addr,
>  		set_pmd_at(mm, new_addr, new_pmd, pmd);
>  		if (force_flush)
>  			flush_pmd_tlb_range(vma, old_addr, old_addr + PMD_SIZE);
> -		if (new_ptl != old_ptl)
> -			spin_unlock(new_ptl);
> -		spin_unlock(old_ptl);
> +		double_pt_unlock(old_ptl, new_ptl);
>  		return true;
>  	}
> +	double_pt_unlock(old_ptl, new_ptl);
>  	return false;
>  }
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index da5d04edf7c10..84141527fe73d 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5153,15 +5153,9 @@ static void move_huge_pte(struct vm_area_struct *vma, unsigned long old_addr,
>  	spinlock_t *src_ptl, *dst_ptl;
>  	pte_t pte;
>
> -	dst_ptl = huge_pte_lock(h, mm, dst_pte);
> +	dst_ptl = huge_pte_lockptr(h, mm, dst_pte);
>  	src_ptl = huge_pte_lockptr(h, mm, src_pte);
> -
> -	/*
> -	 * We don't have to worry about the ordering of src and dst ptlocks
> -	 * because exclusive mmap_lock (or the i_mmap_lock) prevents deadlock.
> -	 */
> -	if (src_ptl != dst_ptl)
> -		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
> +	double_pt_lock(dst_ptl, src_ptl);
>
>  	pte = huge_ptep_get_and_clear(mm, old_addr, src_pte, sz);
>
> @@ -5190,9 +5184,7 @@ static void move_huge_pte(struct vm_area_struct *vma, unsigned long old_addr,
>  		set_huge_pte_at(mm, new_addr, dst_pte, pte, sz);
>  	}
>
> -	if (src_ptl != dst_ptl)
> -		spin_unlock(src_ptl);
> -	spin_unlock(dst_ptl);
> +	double_pt_unlock(dst_ptl, src_ptl);
>  }
>
>  int move_hugetlb_page_tables(struct vm_area_struct *vma,
> diff --git a/mm/internal.h b/mm/internal.h
> index b1b0f29d2216e..7e4d88b2fb02c 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -619,6 +619,34 @@ static inline void force_page_cache_readahead(struct address_space *mapping,
>  	force_page_cache_ra(&ractl, nr_to_read);
>  }
>
> +/*
> + * Take two page table locks at the same level in address order such that
> + * we cannot deadlock.
> + */
> +static inline void double_pt_lock(spinlock_t *ptl1, spinlock_t *ptl2)
> +	__acquires(ptl1)
> +	__acquires(ptl2)
> +{
> +	if (ptl1 > ptl2)
> +		swap(ptl1, ptl2);
> +	spin_lock(ptl1);
> +	if (ptl1 != ptl2)
> +		spin_lock_nested(ptl2, SINGLE_DEPTH_NESTING);
> +	else
> +		__acquire(ptl2);
> +}
> +
> +static inline void double_pt_unlock(spinlock_t *ptl1, spinlock_t *ptl2)
> +	__releases(ptl1)
> +	__releases(ptl2)
> +{
> +	spin_unlock(ptl1);
> +	if (ptl1 != ptl2)
> +		spin_unlock(ptl2);
> +	else
> +		__release(ptl2);
> +}
> +
>  unsigned find_lock_entries(struct address_space *mapping, pgoff_t *start,
>  		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices);
>  unsigned find_get_entries(struct address_space *mapping, pgoff_t *start,
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 1237718848f5c..70b7264aa6bf5 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -202,7 +202,7 @@ static int move_ptes(struct pagetable_move_control *pmc,
>  	struct mm_struct *mm = vma->vm_mm;
>  	pte_t *old_ptep, *new_ptep;
>  	pte_t old_pte, pte;
> -	pmd_t dummy_pmdval;
> +	pmd_t old_pmdval, new_pmdval;
>  	spinlock_t *old_ptl, *new_ptl;
>  	bool force_flush = false;
>  	unsigned long old_addr = pmc->old_addr;
> @@ -234,31 +234,30 @@ static int move_ptes(struct pagetable_move_control *pmc,
>  	if (pmc->need_rmap_locks)
>  		take_rmap_locks(vma);
>
> -	/*
> -	 * We don't have to worry about the ordering of src and dst
> -	 * pte locks because exclusive mmap_lock prevents deadlock.
> -	 */
> -	old_ptep = pte_offset_map_lock(mm, old_pmd, old_addr, &old_ptl);
> +	old_ptep = pte_offset_map_rw_nolock(mm, old_pmd, old_addr, &old_pmdval,
> +					    &old_ptl);
>  	if (!old_ptep) {
>  		err = -EAGAIN;
>  		goto out;
>  	}
> -	/*
> -	 * Now new_pte is none, so collapse_scan_file() path can not find
> -	 * this by traversing file->f_mapping, so there is no concurrency with
> -	 * retract_page_tables(). In addition, we already hold the exclusive
> -	 * mmap_lock, so this new_pte page is stable, so there is no need to get
> -	 * pmdval and do pmd_same() check.
> -	 */
> -	new_ptep = pte_offset_map_rw_nolock(mm, new_pmd, new_addr, &dummy_pmdval,
> -					   &new_ptl);
> +	new_ptep = pte_offset_map_rw_nolock(mm, new_pmd, new_addr, &new_pmdval,
> +					    &new_ptl);
>  	if (!new_ptep) {
> -		pte_unmap_unlock(old_ptep, old_ptl);
> +		pte_unmap(old_ptep);
> +		err = -EAGAIN;
> +		goto out;
> +	}
> +
> +	double_pt_lock(old_ptl, new_ptl);
> +	if (unlikely(!pmd_same(old_pmdval, pmdp_get_lockless(old_pmd)) ||
> +		     !pmd_same(new_pmdval, pmdp_get_lockless(new_pmd)))) {
> +		double_pt_unlock(old_ptl, new_ptl);
> +		pte_unmap(new_ptep);
> +		pte_unmap(old_ptep);
>  		err = -EAGAIN;
>  		goto out;
>  	}
> -	if (new_ptl != old_ptl)
> -		spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
> +
>  	flush_tlb_batched_pending(vma->vm_mm);
>  	lazy_mmu_mode_enable();
>
> @@ -317,10 +316,9 @@ static int move_ptes(struct pagetable_move_control *pmc,
>  	lazy_mmu_mode_disable();
>  	if (force_flush)
>  		flush_tlb_range(vma, old_end - len, old_end);
> -	if (new_ptl != old_ptl)
> -		spin_unlock(new_ptl);
> +	double_pt_unlock(old_ptl, new_ptl);
>  	pte_unmap(new_ptep - 1);
> -	pte_unmap_unlock(old_ptep - 1, old_ptl);
> +	pte_unmap(old_ptep - 1);
>  out:
>  	if (pmc->need_rmap_locks)
>  		drop_rmap_locks(vma);
> @@ -395,14 +393,9 @@ static bool move_normal_pmd(struct pagetable_move_control *pmc,
>  	if (WARN_ON_ONCE(!pmd_none(*new_pmd)))
>  		return false;
>
> -	/*
> -	 * We don't have to worry about the ordering of src and dst
> -	 * ptlocks because exclusive mmap_lock prevents deadlock.
> -	 */
> -	old_ptl = pmd_lock(mm, old_pmd);
> +	old_ptl = pmd_lockptr(mm, old_pmd);
>  	new_ptl = pmd_lockptr(mm, new_pmd);
> -	if (new_ptl != old_ptl)
> -		spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
> +	double_pt_lock(old_ptl, new_ptl);
>
>  	pmd = *old_pmd;
>
> @@ -418,9 +411,7 @@ static bool move_normal_pmd(struct pagetable_move_control *pmc,
>  	pmd_populate(mm, new_pmd, pmd_pgtable(pmd));
>  	flush_tlb_range(vma, pmc->old_addr, pmc->old_addr + PMD_SIZE);
>  out_unlock:
> -	if (new_ptl != old_ptl)
> -		spin_unlock(new_ptl);
> -	spin_unlock(old_ptl);
> +	double_pt_unlock(old_ptl, new_ptl);
>
>  	return res;
>  }
> @@ -452,14 +443,10 @@ static bool move_normal_pud(struct pagetable_move_control *pmc,
>  	if (WARN_ON_ONCE(!pud_none(*new_pud)))
>  		return false;
>
> -	/*
> -	 * We don't have to worry about the ordering of src and dst
> -	 * ptlocks because exclusive mmap_lock prevents deadlock.
> -	 */
> -	old_ptl = pud_lock(mm, old_pud);
> +	old_ptl = pud_lockptr(mm, old_pud);
>  	new_ptl = pud_lockptr(mm, new_pud);
> -	if (new_ptl != old_ptl)
> -		spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
> +
> +	double_pt_lock(old_ptl, new_ptl);
>
>  	pud = *old_pud;
>  	if (unlikely(pud_none(pud)))
> @@ -473,9 +460,7 @@ static bool move_normal_pud(struct pagetable_move_control *pmc,
>  	pud_populate(mm, new_pud, pud_pgtable(pud));
>  	flush_tlb_range(vma, pmc->old_addr, pmc->old_addr + PUD_SIZE);
>  out_unlock:
> -	if (new_ptl != old_ptl)
> -		spin_unlock(new_ptl);
> -	spin_unlock(old_ptl);
> +	double_pt_unlock(old_ptl, new_ptl);
>
>  	return true;
>  }
> @@ -503,16 +488,14 @@ static bool move_huge_pud(struct pagetable_move_control *pmc,
>  	if (WARN_ON_ONCE(!pud_none(*new_pud)))
>  		return false;
>
> -	/*
> -	 * We don't have to worry about the ordering of src and dst
> -	 * ptlocks because exclusive mmap_lock prevents deadlock.
> -	 */
> -	old_ptl = __pud_trans_huge_lock(old_pud, vma);
> -	if (unlikely(!old_ptl))
> -		return false;
> +	old_ptl = pud_lockptr(mm, old_pud);
>  	new_ptl = pud_lockptr(mm, new_pud);
> -	if (new_ptl != old_ptl)
> -		spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
> +
> +	double_pt_lock(old_ptl, new_ptl);
> +	if (unlikely(!pud_trans_huge(*old_pud))) {
> +		double_pt_unlock(old_ptl, new_ptl);
> +		return false;
> +	}
>
>  	/* Clear the pud */
>  	pud = pudp_huge_get_and_clear(mm, pmc->old_addr, old_pud);
> @@ -523,9 +506,7 @@ static bool move_huge_pud(struct pagetable_move_control *pmc,
>  	/* mark soft_ditry when we add pud level soft dirty support */
>  	set_pud_at(mm, pmc->new_addr, new_pud, pud);
>  	flush_pud_tlb_range(vma, pmc->old_addr, pmc->old_addr + HPAGE_PUD_SIZE);
> -	if (new_ptl != old_ptl)
> -		spin_unlock(new_ptl);
> -	spin_unlock(old_ptl);
> +	double_pt_unlock(old_ptl, new_ptl);
>
>  	return true;
>  }
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 710e913c73bfa..76de84510340c 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -1206,33 +1206,6 @@ int mrwprotect_range(struct userfaultfd_ctx *ctx, unsigned long start,
>  	return 0;
>  }
>
> -void double_pt_lock(spinlock_t *ptl1,
> -		    spinlock_t *ptl2)
> -	__acquires(ptl1)
> -	__acquires(ptl2)
> -{
> -	if (ptl1 > ptl2)
> -		swap(ptl1, ptl2);
> -	/* lock in virtual address order to avoid lock inversion */
> -	spin_lock(ptl1);
> -	if (ptl1 != ptl2)
> -		spin_lock_nested(ptl2, SINGLE_DEPTH_NESTING);
> -	else
> -		__acquire(ptl2);
> -}
> -
> -void double_pt_unlock(spinlock_t *ptl1,
> -		      spinlock_t *ptl2)
> -	__releases(ptl1)
> -	__releases(ptl2)
> -{
> -	spin_unlock(ptl1);
> -	if (ptl1 != ptl2)
> -		spin_unlock(ptl2);
> -	else
> -		__release(ptl2);
> -}
> -
>  static inline bool is_pte_pages_stable(pte_t *dst_pte, pte_t *src_pte,
>  				       pte_t orig_dst_pte, pte_t orig_src_pte,
>  				       pmd_t *dst_pmd, pmd_t dst_pmdval)
>
> --
> 2.43.0
>

--
Cheers, Lorenzo
