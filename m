Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F022AD2E;
	Tue, 21 Jul 2026 07:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784619852; cv=none; b=qB3fdSQZdgXEYMDmCqJwoVy2tFY44KUKtRAiTEUu2C2MnKnuDajc3mQUHeJxUR7/JTswr65AN3c3n/w1CCq53FEQV1WaIExJ39qc8ySa3HqOrcagFE/ozAbSVXsT52t9++UJPUAN28mVSaGWU3cJ37BuQIPMfWuT4wioCzE3uGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784619852; c=relaxed/simple;
	bh=P9+8o3CEmRiRW0R69M4PMmizB7JpG1wjznlS8R2G5wQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zujx0xaMrGrYtgeBtVpS2Yg3q7KkFmt5dPl1G3+lQZqAAc4wgDsP6vkVpfHC6eVpKeBIMWlj6eZqvR3HEd7tDUPkIhnqxSTVviLnufV1b9MxIDT+QL3x78qEXyG/2+DUhvnBu4Cj0IbN2FUXtDX0t3UpLeVQTVjbrqYBSzdmoMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ha9IS53O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ha9IS53O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E83491F000E9;
	Tue, 21 Jul 2026 07:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784619850;
	bh=rtFkn/mfMTIuYOWYRQFzEbxdk2PyFOEa96NYZZ89cn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ha9IS53OCz37rW2lp5eXzb0wUrip7zSDnqnZ989Svkz/RICacEJWMriB4qEXAuEWx
	 FQGmHuwGklOwD7GtieTS+QuDS5HTY52UVqf+5sSVrhelirehT+/EampviUu1taWD08
	 rQiw6RRDliszAEvWi9fNVDEzDFds/TudFWRymwY4WFasELLb5iGZ6Nue8TONB1j+1W
	 T2nBsJC9Ve8POYVJ4/0Mj5n0h6za1r+yTpq0EnIG+68oPpYMSPMcqMFSc5xrCywEud
	 2drX/ljX6usPah/mfJwJ+gjFZQ0YPhctgDCALycA1l32PBnV1J1LaNkstLFExwz0HV
	 HhcAXpT6XspBg==
Date: Tue, 21 Jul 2026 08:43:51 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Vishal Moola <vishal.moola@gmail.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Kiryl Shutsemau <kas@kernel.org>, iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH] x86/mm/pat: allocate split page tables as kernel page
 tables
Message-ID: <al8hE_ded6qyWiDv@lucifer>
References: <20260720-fix-cpa-kernel-pagetables-v1-1-0766e782cefe@kernel.org>
 <al5-fDRStgU6gjk6@fedora>
 <al5_Le9QlD4zlt25@fedora>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <al5_Le9QlD4zlt25@fedora>

On Mon, Jul 20, 2026 at 01:03:57PM -0700, Vishal Moola wrote:
> On Mon, Jul 20, 2026 at 01:01:00PM -0700, Vishal Moola wrote:
> > On Mon, Jul 20, 2026 at 10:27:29AM +0100, Lorenzo Stoakes (ARM) wrote:
> > > When splitting a large page in CPA in __split_large_page() we allocate a
> > > PTE directly without going through the standard page table allocation
> > > routines such as pte_alloc_one_kernel().
> > >
> > > This means the page table constructor is never called nor is the page table
> > > marked as a kernel page table.
> > >
> > > The former results in the folio associated with the page table not being
> > > marked as a page table (__pagetable_ctor() is never called thus neither is
> > > __folio_set_pgtable()) nor are statistics updated to reflect
> > > it (lruvec_stat_add_folio() is never called).
> > >
> > > The latter issue of failing to mark the page table as a kernel page
> > > table (ptdesc_set_kernel() is never called) is far more problematic.
> > >
> > > Since commit 5ba2f0a15564 ("mm: introduce deferred freeing for kernel page
> > > tables") kernel page table freeing has been batched and since the
> > > subsequent commit e37d5a2d60a3 ("iommu/sva: invalidate stale IOTLB entries
> > > for kernel address space") IOTLB cache entries for kernel page tables have
> > > been invalidated upon being freed.
> > >
> > > Since split page tables are freed without this invalidation, the IOTLB can
> > > contain stale entries for them.
> > >
> > > Resolve the issue by using the ordinary PTE allocation API at split time.
> > >
> > > This results in these kernel page tables invoking a page table constructor,
> > > and thus requires a page table destructor.
> > >
> > > Since we cannot assume one is always present (early allocated direct map
> > > page tables are not marked as such), we conditionally call
> > > pagetable_dtor_free() if the PG_table folio flag for the ptdesc is set,
> > > otherwise we free the page table via pagetable_free().
> > >
> > > Regardless of which path is taken page tables marked as kernel page tables,
> > > which now includes split page tables, take the correct route through
> > > pagetable_free_kernel().
> > >
> > > There is a user-visible side effect in that split page tables will appear
> > > in nr_page_table_pages in /proc/vmstat (as do other kernel page tables
> > > allocated after early boot), however this is a positive change.
> > >
> > > This issue started being markedly problematic after commit
> > > 5ba2f0a15564 ("mm: introduce deferred freeing for kernel page tables") so
> > > choose this as the Fixes target.
> > >
> > > Fixes: 5ba2f0a15564 ("mm: introduce deferred freeing for kernel page tables")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > > ---
> > >  arch/x86/mm/pat/set_memory.c | 21 ++++++++++++---------
> > >  1 file changed, 12 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> > > index 301fb9e77d91..a67ca33b9dd1 100644
> > > --- a/arch/x86/mm/pat/set_memory.c
> > > +++ b/arch/x86/mm/pat/set_memory.c
> > > @@ -439,7 +439,11 @@ static void __cpa_collapse_large_pages(struct cpa_data *cpa)
> > >
> > >  	list_for_each_entry_safe(ptdesc, tmp, &pgtables, pt_list) {
> > >  		list_del(&ptdesc->pt_list);
> > > -		pagetable_free(ptdesc);
> > > +
> > > +		if (folio_test_pgtable(ptdesc_folio(ptdesc)))
> > > +			pagetable_dtor_free(ptdesc);
> > > +		else
> > > +			pagetable_free(ptdesc);
> >
> > Lets not introduce more folio-ptdesc crossovers, we're trying to get
> > rid of them :)
> >
> > I believe pagetable_dtor_free() should do what you're looking for on its
> > own anyway.
>
> Actually, looking at it closer, maybe not because of the conditional
> portion? But that makes me think it might be better to just replace the
> ptdesc_clear_kernel() with pagetable_dtor() in the free function...

Well some kernel page tables are still allocated without ctor (early allocated
direct map for isntance), and if you did pagetable_dtor_free() it
unconditionally calls pagetable_dtor().

The ptlock_free() and __folio_clear_pgtable() there would be harmelss (no locks
assigned for kernel page table, and if PG_table never set clearing it is a noop)
but the lruvec_stat_sub_folio() would cause an unbalanced decrement of
nr_page_table_pages.

It sucks, but until everything is updated to call the ctor we have to do it this
way :>)

Cheers, Lorenzo
