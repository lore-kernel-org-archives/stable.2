Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BD830568B;
	Sun, 12 Jul 2026 08:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783844579; cv=none; b=KZ32p8MlwAxUx07JcTHPQV+mDLnEYdl+WtonQvd90QwV0Zb5sZBQWQ9wDC7dsYDxeNLWbXSt9ukeoH8AZOluHpQFb1l6o43LOr4CCRsF/auURlCP6avFsXBg2nshmYOejoZtyHyCCJB0Lm0yVCXms9U3dMvkDZmsuBmybtHEVqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783844579; c=relaxed/simple;
	bh=RPk4yWV+8ERDUBGX8Oy7NsAdunCsMmqwN+K6korSLUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DP+HI0gJ74EdCpnWZgmwAxY2nH39haWRufivAap1q6BE94tA+efWhVE/ioKPBVy5tK+sXuaXMfQCNGA+93UIML4SPUuZyeSd3i6rVnumdNscCY6tU6HRXT4+RjfTD5//Ixbpz/tR9ZosEo2CEVfpv2el2qaKPwfTxHB/jGKPOwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/6fldgy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/6fldgy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01DBF1F000E9;
	Sun, 12 Jul 2026 08:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783844577;
	bh=OLk/y8B3jkUZeJ2X+bXdA1Q0foPidFq8qmGJRfb7iKg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=V/6fldgyaCao4wFwvO4Zk3ZaURqqabllVwfzl6WAdo1GWpXOO3Elt2D91McU9TNJ/
	 HpASwPOXLu2LhMp/Aodz/6nEjVKn+a6qVc1b2zqMrLNSx/cFZyBi8O0TgIbUWtiS2x
	 tkHGmIzN2+1r4kSaXUnJc3f38PSUiUp7NvKNEhqGCmQwfvXHR9jDaSMzhD4ejP/MD2
	 F0tedNd3mC3fz8QMOA4HzTYeDk1eeWNRosTq1v5E2ts7pCI3gPyHpq1X5jUwqcCozf
	 P70Q0CuqEppPof5WQ+J0YgbB4iTVfZBvm2Xz8n8sM+6yAQYfSVyi5jY7eVWPBk6O7/
	 cUkFoADJyXsYg==
Date: Sun, 12 Jul 2026 09:22:42 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Dev Jain <dev.jain@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Uladzislau Rezki <urezki@gmail.com>, Toshi Kani <toshi.kani@hpe.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	David Carlier <devnexen@gmail.com>, Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org, 
	syzbot+fd95a72470f5a44e464c@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/2] mm/vmalloc: acquire init_mm read lock on huge vmap
 promotion
Message-ID: <alNM8tIxep2-PHAM@lucifer>
References: <20260710-series-vmap-race-fix-v1-0-5b3794c113fe@kernel.org>
 <20260710-series-vmap-race-fix-v1-1-5b3794c113fe@kernel.org>
 <d47ac961-4767-4ce4-9c75-f281beb24e42@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d47ac961-4767-4ce4-9c75-f281beb24e42@arm.com>

On Sun, Jul 12, 2026 at 01:13:12PM +0530, Dev Jain wrote:
>
>
> [-----]
>
> > We also define a guard class for mmap_read_trylock() so we can use
> > cleanup.h to make the scope handling cleaner in the implementation.
> >
>
> Will this cause backport problems, I think this scoped guard thingy is
> not that old?

I intentionally used it because it's the best way to solve this problem.

If there's any issue I'll fix them up in the stable backports myself.

I will likely resend this as a 4 patch series and just do the stable
backports manually anyway.

>
>
> > One wrinkle here is commit fa93b45fd397 ("arm64: Enable vmalloc-huge with
> > ptdump"), which addresses the issue for arm64 only by explicitly acquiring
> > the mmap read lock on kernel page table freeing should a concurrent ptdump
> > be in progress.
> >
> > This is problematic as vmap may acquire the mmap read lock prior to ptdump
> > attempting to acquire an mmap write lock, leading to a deadlock when the
> > mmap read lock is slept upon on page table freeing due to rwsem
> > anti-starvation.
> >
> > We work around this by predicating the mmap lock being taken on
> > !CONFIG_ARM64 for the time being.
> >
> > With this patch applied, a follow up will partially revert commit
> > fa93b45fd397 ("arm64: Enable vmalloc-huge with ptdump") and at that stage
> > remove the arm64 ifdeffery.
> >
> > We also update walk_page_range_debug() to assert the mmap write lock
> > unconditionally and update the comment here to reflect this change.
> >
> > The issue has existed as long as ptdump was available and vmap freed page
> > tables when promoting to a huge leaf entry, that is, since commit
> > b6bdb7517c3d ("mm/vmalloc: add interfaces to free unmapped page table") for
> > huge ioremap, and commit 121e6f3258fe ("mm/vmalloc: hugepage vmalloc
> > mappings") for huge vmalloc.
> >
> > Since the former is the earlier of the two we choose that for our Fixes
> > tag.
> >
> > This patch is based on work by David Carlier (linked), with gratitude!
> >
> > Fixes: b6bdb7517c3d ("mm/vmalloc: add interfaces to free unmapped page table")
> > Cc: <stable@vger.kernel.org>
> > Reported-by: syzbot+fd95a72470f5a44e464c@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/all/6a287988.39669fcc.33b062.00a0.GAE@google.com/T/
> > Link: https://lore.kernel.org/linux-mm/20260706203128.162335-1-devnexen@gmail.com/
> > Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
> > ---
> >  include/linux/mmap_lock.h |  1 +
> >  mm/pagewalk.c             | 22 +++++++++++----------
> >  mm/vmalloc.c              | 50 ++++++++++++++++++++++++++++++++++++++---------
> >  3 files changed, 54 insertions(+), 19 deletions(-)
> >
> > diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> > index 04b8f61ece5d..6b5c2390cc30 100644
> > --- a/include/linux/mmap_lock.h
> > +++ b/include/linux/mmap_lock.h
> > @@ -621,6 +621,7 @@ static inline void mmap_read_unlock(struct mm_struct *mm)
> >
> >  DEFINE_GUARD(mmap_read_lock, struct mm_struct *,
> >  	     mmap_read_lock(_T), mmap_read_unlock(_T))
> > +DEFINE_GUARD_COND(mmap_read_lock, _try, mmap_read_trylock(_T))
> >
> >  static inline void mmap_read_unlock_non_owner(struct mm_struct *mm)
> >  {
> > diff --git a/mm/pagewalk.c b/mm/pagewalk.c
> > index 3ae2586ff45b..bbcfd68d0907 100644
> > --- a/mm/pagewalk.c
> > +++ b/mm/pagewalk.c
> > @@ -678,6 +678,8 @@ int walk_kernel_page_table_range_lockless(unsigned long start, unsigned long end
> >   * will also not lock the PTEs for the pte_entry() callback.
> >   *
> >   * This is for debugging purposes ONLY.
> > + *
> > + * The mmap write lock must be held.
> >   */
> >  int walk_page_range_debug(struct mm_struct *mm, unsigned long start,
> >  			  unsigned long end, const struct mm_walk_ops *ops,
> > @@ -691,6 +693,16 @@ int walk_page_range_debug(struct mm_struct *mm, unsigned long start,
> >  		.no_vma		= true
> >  	};
> >
> > +	/*
> > +	 * When walking userland page tables, an mmap write lock must be held to
> > +	 * account for munmap() downgrading to an mmap read lock when tearing
> > +	 * down page tables.
> > +	 *
> > +	 * When walking kernel page tables, an mmap write lock must also be held
> > +	 * to account for page table freeing on vmap huge page mapping.
> > +	 */
> > +	mmap_assert_write_locked(mm);
> > +
> >  	/* For convenience, we allow traversal of kernel mappings. */
> >  	if (mm == &init_mm)
> >  		return walk_kernel_page_table_range(start, end, ops,
> > @@ -700,16 +712,6 @@ int walk_page_range_debug(struct mm_struct *mm, unsigned long start,
> >  	if (!check_ops_safe(ops))
> >  		return -EINVAL;
> >
> > -	/*
> > -	 * The mmap lock protects the page walker from changes to the page
> > -	 * tables during the walk.  However a read lock is insufficient to
> > -	 * protect those areas which don't have a VMA as munmap() detaches
> > -	 * the VMAs before downgrading to a read lock and actually tearing
> > -	 * down PTEs/page tables. In which case, the mmap write lock should
> > -	 * be held.
> > -	 */
> > -	mmap_assert_write_locked(mm);
> > -
> >  	return walk_pgd_range(start, end, &walk);
> >  }
> >
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 1afca3568b9b..9d0f1fdd6af3 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -43,6 +43,7 @@
> >  #include <asm/tlbflush.h>
> >  #include <asm/shmparam.h>
> >  #include <linux/page_owner.h>
> > +#include <linux/cleanup.h>
> >
> >  #define CREATE_TRACE_POINTS
> >  #include <trace/events/vmalloc.h>
> > @@ -158,10 +159,25 @@ static int vmap_try_huge_pmd(pmd_t *pmd, unsigned long addr, unsigned long end,
> >  	if (!IS_ALIGNED(phys_addr, PMD_SIZE))
> >  		return 0;
> >
> > -	if (pmd_present(*pmd) && !pmd_free_pte_page(pmd, addr))
> > -		return 0;
> > +	if (!pmd_present(*pmd))
> > +		return pmd_set_huge(pmd, phys_addr, prot);
> >
> > -	return pmd_set_huge(pmd, phys_addr, prot);
> > +	/*
> > +	 * Kernel page table walkers either walk ranges they own exclusively
> > +	 * using the mmap lock for mutual exclusion, or hold the mmap write lock
> > +	 * on init_mm (ptdump being the motivating case).
> > +	 *
> > +	 * Therefore, acquire the mmap read lock to prevent use-after-free when
> > +	 * freeing page tables.
> > +	 */
> > +#ifndef CONFIG_ARM64
> > +	scoped_cond_guard(mmap_read_lock_try, return 0, &init_mm)
> > +#endif
> > +	{
> > +		if (!pmd_free_pte_page(pmd, addr))
> > +			return 0;
> > +		return pmd_set_huge(pmd, phys_addr, prot);
> > +	}
> >  }
> >
> Note that we do not need to take the lock around pmd_set_huge - we don't
> care if ptdump observes a temporarily cleared pmd entry. So how about keeping
> this outside the guard block. Otherwise right now we have an inconsistency:
> for !pmd_present() we do pmd_set_huge() without locking, but for pmd_present()
> we do pmd_set_huge() with locking.

As I said in the commit message I'm intentionally taking the lock around all of
it so a concurrent ptdump sees either the leaf entry or the non-leaf entry.

By doing that we can easiliy avoid the situation where a ptdump gives you
inconsistent output and it makes more sense logically.

So this is the opposite of inconsistent - if !pmd_present() the ptdump may
observe the _genuine_ state of there not being an entry before. With
pmd_present() it either observes what was or what became, not something
inbetween :)

>
>

Thanks, Lorenzo
