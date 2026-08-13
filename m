Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04D91F8691;
	Thu, 13 Aug 2026 01:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786586114; cv=none; b=Ye6d4UMGbAa5qgpp0wwCWymW2ArqhmGrr1p4WbfGJN/j9PNJwtDLuTZ/tsx9uPJDBP0LS7AUevEAZNawNwDJc9NuzbB4l9a136s+pkBt/ak7o8/TTtlonIBrtYXGKQz/fcW+7XDysvgdgbx2P6NR1GUAi5CX3na2i+yQUzUpqmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786586114; c=relaxed/simple;
	bh=sUCeUiO6Q7z0SNf+EqD6YG4WyM5r4hpLqPzZ+CuS9mA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ez9KdT6GX6w6w7ApJAUXg/ad6IDk6HP7gF4DnkIkCkH6laPNKW5Rcw0zKatqwdKq2X3bdKDPWxfu0ikILKV5Vojk3uLAHAcps2VTEPmIom1c4lS7tWLdQn+/lwoEB7qFQsJxCp37DkXOIUfN8ilgIKT0YmkuD/koxoGJvf8kk/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fxAZiqWM; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fxAZiqWM"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786586101; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=HWTr9GGWou2wILH7gAUz4fVjSCuDbXDcFYOAh+gtggk=;
	b=fxAZiqWMoYuhwgjOaJL6Y7jwh+yJpuspMn25sjdY/6IevsusntDULFxOOH1OYsKm+AuMfcpHDaAIKT8V6YRv2graE/+XZHEbBrEOlWfaqdU0s6ni3citHHZt5o6sgFIfgETE1Ox8muDr6yBaW/Axk/LK8AALUZTOEj/ipBFucR4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=ying.huang@linux.alibaba.com;NM=1;PH=DS;RN=31;SR=0;TI=SMTPD_---0X8skf38_1786586080;
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0X8skf38_1786586080 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 13 Aug 2026 09:54:59 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Matthew Brost <matthew.brost@intel.com>
Cc: <intel-xe@lists.freedesktop.org>,  <dri-devel@lists.freedesktop.org>,
  <linux-mm@kvack.org>,  <linux-kernel@vger.kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  David Hildenbrand <david@kernel.org>,
  "Lorenzo Stoakes" <ljs@kernel.org>,  Zi Yan <ziy@nvidia.com>,  Baolin
 Wang <baolin.wang@linux.alibaba.com>,  "Liam R . Howlett"
 <liam@infradead.org>,  Nico Pache <nico.pache@linux.dev>,  Ryan Roberts
 <ryan.roberts@arm.com>,  "Dev Jain" <dev.jain@arm.com>,  Barry Song
 <baohua@kernel.org>,  Lance Yang <lance.yang@linux.dev>,  Usama Arif
 <usama.arif@linux.dev>,  Joshua Hahn <joshua.hahnjy@gmail.com>,  Rakie Kim
 <rakie.kim@sk.com>,  Byungchul Park <byungchul@sk.com>,  Gregory Price
 <gourry@gourry.net>,  Alistair Popple <apopple@nvidia.com>,  Balbir Singh
 <balbirs@nvidia.com>,  Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
  Thomas Zimmermann <tzimmermann@suse.de>,  David Airlie
 <airlied@gmail.com>,  Simona Vetter <simona@ffwll.ch>,  Thomas Hellstrm
 <thomas.hellstrom@linux.intel.com>,  Francois Dugast
 <francois.dugast@intel.com>,  <stable@vger.kernel.org>
Subject: Re: [PATCH v3 3/6] mm/migrate_device: Fix THP splitting of a CPU
 faulted device private folio
In-Reply-To: <an0CxFPPnvPWljyp@gsse-cloud1.jf.intel.com> (Matthew Brost's
	message of "Wed, 12 Aug 2026 16:33:24 -0700")
References: <20260805231041.3791771-1-matthew.brost@intel.com>
	<20260805231041.3791771-4-matthew.brost@intel.com>
	<87ik5in224.fsf@DESKTOP-5N7EMDA>
	<anopzF3Hk/RRh8kC@gsse-cloud1.jf.intel.com>
	<87cxvnn41l.fsf@DESKTOP-5N7EMDA>
	<an0CxFPPnvPWljyp@gsse-cloud1.jf.intel.com>
Date: Thu, 13 Aug 2026 09:54:39 +0800
Message-ID: <87bjb67pk0.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Matthew Brost <matthew.brost@intel.com> writes:

> On Wed, Aug 12, 2026 at 04:20:22PM +0800, Huang, Ying wrote:
>> Matthew Brost <matthew.brost@intel.com> writes:
>> 
>> > On Mon, Aug 10, 2026 at 10:26:27AM +0800, Huang, Ying wrote:
>> >> Hi, Matthew,
>> >> 
>> >> Matthew Brost <matthew.brost@intel.com> writes:
>> >> 
>> >> > When a CPU faults on a device private PMD and the device driver can only
>> >> > allocate order-0 destination folios, __migrate_device_pages() has to
>> >> > split the source THP via migrate_vma_split_unmapped_folio(). That path
>> >> > is broken in two independent ways when the fault is what triggered the
>> >> > migration.
>> >> >
>> >> > First, the split never succeeds. At the point folio_split_unmapped() is
>> >> > called the folio carries two references beyond the ones it is
>> >> > entitled to:
>> >> >
>> >> >   1 - taken by do_huge_pmd_device_private() for the duration of the
>> >> >       ->migrate_to_ram() callback
>> >> >   2 - taken by migrate_vma_collect_huge_pmd() when the folio was
>> >> >       collected
>> >> >
>> >> > (the mapping reference having been dropped by set_pmd_migration_entry()).
>> >> >
>> >> > folio_split_unmapped() requires folio_expected_ref_count(folio) ==
>> >> > folio_ref_count(folio) - 1, i.e. it tolerates exactly one caller
>> >> > reference. With both of the above held the check sees 2 against an
>> >> > expected 0 and returns -EAGAIN, so the migration is abandoned and the
>> >> > CPU fault makes no progress.
>> >> >
>> >> > The PTE-based split path does not have this problem:
>> >> > migrate_vma_split_folio() is called before any collect reference is
>> >> > taken and explicitly skips folio_get() for the fault folio, so the fault
>> >> > reference is the single caller reference the split expects.
>> >> >
>> >> > Fix it by dropping the fault reference across the split and re-taking it
>> >> > afterwards. do_huge_pmd_device_private() derives the fault page from the
>> >> > PMD entry, so it is always the head page of the folio and always ends up
>> >> > in the head folio of an uniform split to order 0; re-taking the
>> >> > reference on the folio therefore puts it back exactly where
>> >> > do_huge_pmd_device_private() will release it. The folio cannot be freed
>> >> > while the reference is dropped because the collect reference is still
>> >> > held.
>> >> >
>> >> > Second, the folio is split globally but the page tables were demoted
>> >> > only locally:
>> >> >
>> >> > 	split_huge_pmd_address(migrate->vma, addr, true);
>> >> > 	ret = folio_split_unmapped(folio, 0);
>> >> >
>> >> > migrate_device_unmap() unmaps via try_to_migrate(folio, 0), deliberately
>> >> > without TTU_SPLIT_HUGE_PMD, so every VMA that PMD maps the folio is left
>> >> > holding a PMD sized migration entry. A folio that was PMD mapped in more
>> >> > than one VMA -- after fork(), for example -- therefore keeps huge
>> >> > migration entries in all the other VMAs while only migrate->vma is
>> >> > demoted.
>> >> >
>> >> > folio_split_unmapped() does not notice: the folio is fully unmapped, so
>> >> > it only looks at the refcount and happily splits to order 0. The other
>> >> > VMAs are then left pointing a huge PMD at an order-0 folio, and
>> >> > migrate_vma_finalize() -> remove_migration_ptes() walks into it:
>> >> >
>> >> >   page dumped because: VM_BUG_ON_FOLIO(folio_test_hugetlb(folio) ||
>> >> >                                        !folio_test_pmd_mappable(folio))
>> >> >   kernel BUG at mm/migrate.c:368!
>> >> >   RIP: 0010:remove_migration_pte+0x56a/0x9b0
>> >> >   Call Trace:
>> >> >    rmap_walk_anon+0xfc/0x260
>> >> >    remove_migration_ptes+0x79/0xb0
>> >> >    __migrate_device_finalize+0x113/0x290
>> >> >    __drm_pagemap_migrate_to_ram+0x278/0x360 [drm_gpusvm_helper]
>> >> >    drm_pagemap_migrate_to_ram+0x5c/0x80 [drm_gpusvm_helper]
>> >> >    do_huge_pmd_device_private+0x160/0x280
>> >> 
>> >> Which is the branch your patchset based on?  I found that
>> >> drm_pagemap_migrate_populate_ram_pfn() in mm-everything-2026-08-08-07-08
>> >> still don't support fallback to single pages if THP allocation fails as
>> >> in the following comments,
>> >> 
>> >
>> > This entire series, on drm-tip (i.e., the 6 patches posted here [1]).
>> >
>> > [1] https://patchwork.freedesktop.org/series/171651/
>> 
>> Thanks!
>> 
>> >> 	/* TODO: Support fallback to single pages if THP allocation fails */
>> >> 
>> >> 
>> >> > Without CONFIG_DEBUG_VM the VM_BUG_ON_FOLIO() is compiled out and
>> >> > remove_migration_pmd() installs a huge PMD pointing at an order-0 page
>> >> > instead, along with add_mm_counter(mm, MM_ANONPAGES, HPAGE_PMD_NR). The
>> >> > victim mm then maps 2MB of address space onto a single 4K page, which
>> >> > shows up later as bad rss-counter state, leaked page tables and page
>> >> > allocator freelist corruption in unrelated processes.
>> >> >
>> >> > Note this second problem was latent before the refcount fix above: the
>> >> > split always failed, and the failed attempt left migrate->vma demoted,
>> >> > so the retried fault took the PTE path, where __folio_split() unmaps
>> >> > with TTU_SPLIT_HUGE_PMD and demotes every VMA.
>> >> >
>> >> > Fix it by walking the rmap and demoting every PMD sized migration entry
>> >> > mapping the folio before splitting it. Demote with freeze = false: entry
>> >> > creation in __split_huge_pmd_locked() is dispatched on
>> >> > pmd_is_migration_entry(), not on freeze, so a migration PMD becomes PTE
>> >> > sized migration entries either way, and freeze only controls a trailing
>> >> > put_page(). With freeze = false there is no refcount change at all,
>> >> > which makes the demotion idempotent across N VMAs.
>> >> >
>> >> > rmap_walk_control.anon_lock is deliberately left unset:
>> >> > folio_lock_anon_vma_read() depends on folio_mapped(), and the folio is
>> >> > already fully unmapped here. This mirrors remove_migration_ptes().
>> >> >
>> >> > Finally, refuse the split for a folio that is not anonymous. The rmap
>> >> > walk would otherwise reach a file backed VMA, where
>> >> > split_huge_pmd_address() zaps the PMD instead of demoting it.
>> >> >
>> >> > Fixes: 4265d67e405a ("mm/migrate_device: add THP splitting during migration")
>> >> > Cc: Andrew Morton <akpm@linux-foundation.org>
>> >> > Cc: David Hildenbrand <david@kernel.org>
>> >> > Cc: Lorenzo Stoakes <ljs@kernel.org>
>> >> > Cc: Zi Yan <ziy@nvidia.com>
>> >> > Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>> >> > Cc: Liam R. Howlett <liam@infradead.org>
>> >> > Cc: Nico Pache <nico.pache@linux.dev>
>> >> > Cc: Ryan Roberts <ryan.roberts@arm.com>
>> >> > Cc: Dev Jain <dev.jain@arm.com>
>> >> > Cc: Barry Song <baohua@kernel.org>
>> >> > Cc: Lance Yang <lance.yang@linux.dev>
>> >> > Cc: Usama Arif <usama.arif@linux.dev>
>> >> > Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
>> >> > Cc: Rakie Kim <rakie.kim@sk.com>
>> >> > Cc: Byungchul Park <byungchul@sk.com>
>> >> > Cc: Gregory Price <gourry@gourry.net>
>> >> > Cc: Ying Huang <ying.huang@linux.alibaba.com>
>> >> > Cc: Alistair Popple <apopple@nvidia.com>
>> >> > Cc: Balbir Singh <balbirs@nvidia.com>
>> >> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>> >> > Cc: Maxime Ripard <mripard@kernel.org>
>> >> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
>> >> > Cc: David Airlie <airlied@gmail.com>
>> >> > Cc: Simona Vetter <simona@ffwll.ch>
>> >> > Cc: Thomas Hellstrm <thomas.hellstrom@linux.intel.com>
>> >> > Cc: Francois Dugast <francois.dugast@intel.com>
>> >> > Cc: dri-devel@lists.freedesktop.org
>> >> > Cc: linux-mm@kvack.org
>> >> > Cc: linux-kernel@vger.kernel.org
>> >> > Cc: stable@vger.kernel.org
>> >> > Assisted-by: GitHub_Copilot:claude-opus-5
>> >> > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
>> >> > ---
>> >> >  mm/migrate_device.c | 98 ++++++++++++++++++++++++++++++++++++++++-----
>> >> >  1 file changed, 89 insertions(+), 9 deletions(-)
>> >> >
>> >> > diff --git a/mm/migrate_device.c b/mm/migrate_device.c
>> >> > index ae9027421b80..ae17bd516d24 100644
>> >> > --- a/mm/migrate_device.c
>> >> > +++ b/mm/migrate_device.c
>> >> > @@ -899,22 +899,104 @@ static int migrate_vma_insert_huge_pmd_page(struct migrate_vma *migrate,
>> >> >  	return 0;
>> >> >  }
>> >> >  
>> >> > +static bool migrate_vma_split_pmd_one(struct folio *folio,
>> >> > +				      struct vm_area_struct *vma,
>> >> > +				      unsigned long addr, void *arg)
>> >> > +{
>> >> > +	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, addr, PVMW_SYNC | PVMW_MIGRATION);
>> >> > +
>> >> > +	while (page_vma_mapped_walk(&pvmw)) {
>> >> > +		if (pvmw.pte)
>> >> > +			continue;
>> >> > +
>> >> > +		addr = pvmw.address;
>> >> > +		page_vma_mapped_walk_done(&pvmw);
>> >> > +
>> >> > +		/*
>> >> > +		 * Demote with freeze = false: the PMD already holds a
>> >> > +		 * migration entry, so __split_huge_pmd_locked() creates PTE
>> >> > +		 * sized migration entries from it and leaves the refcount
>> >> > +		 * alone. There is at most one PMD mapping @folio per VMA, so
>> >> > +		 * stop the walk here.
>> >> > +		 */
>> >> > +		split_huge_pmd_address(vma, addr, false);
>> >> > +		break;
>> >> > +	}
>> >> > +
>> >> > +	return true;
>> >> > +}
>> >> > +
>> >> > +/*
>> >> > + * Demote every PMD sized migration entry that maps @folio to PTE sized ones.
>> >> > + *
>> >> > + * migrate_device_unmap() unmaps with try_to_migrate(folio, 0), i.e. without
>> >> > + * TTU_SPLIT_HUGE_PMD, so a folio that was PMD mapped in several VMAs -- after
>> >> > + * fork(), for instance -- ends up with a PMD sized migration entry in every one
>> >> > + * of them. folio_split_unmapped() below does not care, it only looks at the
>> >> > + * refcount, so splitting the folio without demoting all of those first would
>> >> > + * leave the other VMAs pointing a huge PMD at what is now an order-0 folio.
>> >> > + * remove_migration_ptes() trips over that in migrate_vma_finalize().
>> >> > + */
>> >> > +static void migrate_vma_split_pmd_mappings(struct folio *folio)
>> >> > +{
>> >> > +	struct rmap_walk_control rwc = {
>> >> > +		.rmap_one = migrate_vma_split_pmd_one,
>> >> > +	};
>> >> > +
>> >> > +	/*
>> >> > +	 * Do not pass .anon_lock: folio_lock_anon_vma_read() requires
>> >> > +	 * folio_mapped(), and @folio is already fully unmapped here.
>> >> > +	 */
>> >> > +	rmap_walk(folio, &rwc);
>> >> > +}
>> >> > +
>> >> >  static int migrate_vma_split_unmapped_folio(struct migrate_vma *migrate,
>> >> > -					    unsigned long idx, unsigned long addr,
>> >> > +					    unsigned long idx,
>> >> >  					    struct folio *folio)
>> >> >  {
>> >> >  	unsigned long i;
>> >> >  	unsigned long pfn;
>> >> >  	unsigned long flags;
>> >> > +	bool fault_folio;
>> >> >  	int ret = 0;
>> >> >  
>> >> >  	/*
>> >> > -	 * take a reference, since split_huge_pmd_address() with freeze = true
>> >> > -	 * drops a reference at the end.
>> >> > +	 * migrate_vma_split_pmd_mappings() walks the rmap, and
>> >> > +	 * split_huge_pmd_address() zaps rather than demotes a PMD in a VMA that
>> >> > +	 * is not anonymous. migrate_vma_collect_huge_pmd() does not check the
>> >> > +	 * VMA type, so a file THP can reach here; the rest of the migrate_vma()
>> >> > +	 * machinery only supports anonymous memory anyway.
>> >> >  	 */
>> >> > -	folio_get(folio);
>> >> > -	split_huge_pmd_address(migrate->vma, addr, true);
>> >> > +	if (!folio_test_anon(folio))
>> >> > +		return -EINVAL;
>> >> > +
>> >> > +	/*
>> >> > +	 * A CPU fault on a device private PMD holds an extra reference on the
>> >> > +	 * folio, taken by do_huge_pmd_device_private(). folio_split_unmapped()
>> >> > +	 * only tolerates a single caller reference, so the split would always
>> >> > +	 * fail with -EAGAIN while this fault reference is held.
>> >> > +	 *
>> >> > +	 * do_huge_pmd_device_private() derives the fault page from the PMD
>> >> > +	 * entry, so it is always the head page of @folio, and therefore always
>> >> > +	 * ends up in the head folio after an uniform split to order 0. Drop
>> >> > +	 * the reference across the split and re-take it on the head folio
>> >> > +	 * afterwards, leaving the reference exactly where it is expected to be
>> >> > +	 * released.
>> >> > +	 *
>> >> > +	 * The folio cannot go away while the reference is dropped: the
>> >> > +	 * reference taken by migrate_vma_collect_huge_pmd() is still held.
>> >> > +	 */
>> >> > +	fault_folio = migrate->fault_page &&
>> >> > +		page_folio(migrate->fault_page) == folio;
>> >> > +
>> >> > +	migrate_vma_split_pmd_mappings(folio);
>> >> > +
>> >> > +	if (fault_folio)
>> >> > +		folio_put(folio);
>> >> >  	ret = folio_split_unmapped(folio, 0);
>> >> > +	if (fault_folio)
>> >> > +		folio_get(folio);
>> >> > +
>> >> 
>> >> Is it better to pass "extra_cnt" to folio_split_unmapped()?  This
>> >> follows the coding style of the other migrate functions better, like
>> >> that in __migrate_device_pages().
>> >> 
>> >
>> > That is an option. To be minimally invasive, I went this route. I also
>> > didn't know offhand what would happen if our head page had an extra
>> > reference and we then called folio_split_unmapped() with "extra_cnt", or
>> > how that would affect the reference counts of the newly split pages
>> > (i.e., whether we would need to adjust the reference counts of all split
>> > pages after folio_split_unmapped() returns). However, I could quickly
>> > reason that dropping the reference and then reacquiring it was
>> > functionally correct and safe.
>> 
>> This makes sense for me.  Thanks!
>> 
>> I have another question.  If we have to split the large folio when
>> migrating from device to ram, should we still migrate all pages of the
>> original large folio, or should we migrate only the faulting
>> normal-sized page of the original large folio instead?
>> 
>
> This is a choice made by the upper layers that call the migrate_vma_*
> functions and populate the migrate_vma arguments. In gpusvm/pagemap, we
> still migrate the entire 2 MB region of memory as 512 4 KB pages upon
> higher order failure, matching what we did prior to having 2 MB device
> pages.
> 
> The reasoning is that migrations are expensive due to the CPU overhead of
> migrate_vma_* and because GPU copies are issued, requiring larger transfer
> sizes to achieve the full bandwidth of the bus. For example, a 4 KB copy
> provides less than 1 GB/s of bandwidth regardless of PCIe speed, whereas
> a 2 MB copy can nearly reach the theoretical maximum bandwidth of PCIe.
> 
> Early in the development of gpusvm/pagemap, I had a knob that forced only
> single-page 4 KB faults and migrations, along with a test case that
> measured the fault time in user space for a 2 MB buffer. If I recall
> correctly, it was about 58 slower than batching 512 4 KB pages together
> into a single fault and migration on a low-end BMG part.
>
> So on higher order page allocation failure, the preference is still do
> the larger migration.

Got it!  Thanks for detailed explanation!

I think that another added complexity is that we need to split the 2MB
page table of the GPU side.

---
Best Regards,
Huang, Ying

> Matt
>
>> ---
>> Best Regards,
>> Huang, Ying
>> 
>> > Matt
>> >
>> >> >  	if (ret)
>> >> >  		return ret;
>> >> >  	migrate->src[idx] &= ~MIGRATE_PFN_COMPOUND;
>> >> > @@ -935,7 +1017,7 @@ static int migrate_vma_insert_huge_pmd_page(struct migrate_vma *migrate,
>> >> >  }
>> >> >  
>> >> >  static int migrate_vma_split_unmapped_folio(struct migrate_vma *migrate,
>> >> > -					    unsigned long idx, unsigned long addr,
>> >> > +					    unsigned long idx,
>> >> >  					    struct folio *folio)
>> >> >  {
>> >> >  	return 0;
>> >> > @@ -1103,7 +1185,6 @@ static void __migrate_device_pages(unsigned long *src_pfns,
>> >> >  	struct mmu_notifier_range range;
>> >> >  	unsigned long i, j;
>> >> >  	bool notified = false;
>> >> > -	unsigned long addr;
>> >> >  
>> >> >  	for (i = 0; i < npages; ) {
>> >> >  		struct page *newpage = migrate_pfn_to_page(dst_pfns[i]);
>> >> > @@ -1177,8 +1258,7 @@ static void __migrate_device_pages(unsigned long *src_pfns,
>> >> >  					goto next;
>> >> >  				}
>> >> >  				nr = 1 << folio_order(folio);
>> >> > -				addr = migrate->start + i * PAGE_SIZE;
>> >> > -				if (migrate_vma_split_unmapped_folio(migrate, i, addr, folio)) {
>> >> > +				if (migrate_vma_split_unmapped_folio(migrate, i, folio)) {
>> >> >  					src_pfns[i] &= ~(MIGRATE_PFN_MIGRATE |
>> >> >  							 MIGRATE_PFN_COMPOUND);
>> >> >  					goto next;
>> >> 
>> >> ---
>> >> Best Regards,
>> >> Huang, Ying
