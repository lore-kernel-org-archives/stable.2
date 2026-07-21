Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9693B3C05;
	Tue, 21 Jul 2026 09:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784627951; cv=none; b=HLk7hmyHDx+j22rGUKrfQlLn1U/JKBlvVlsVQe0KL3rENCZpJ0ONZUKSUrAm+iN9EFixg6QZwqXvW+6mHptO6ZWnl3IaNdjvlq9H8rJYBgrAMg7ZsuXiP62iwwprLi5tMZGH9GneERBSIgFe4m26YEit0VaoHU/vXmOm5osphUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784627951; c=relaxed/simple;
	bh=24umgfWSH54conZIi4nCqBgYGKRKOhDbeuxrNQYfshs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pdjhKU3EOu9I8sjAze5iAekSITbmdwwg/MqafyZytFNCmxt51x9+1G+FjCy5LzwPEbv22/z9GZSmAdS68GQh+b6wOctw8y/ymclYsweC8cfDt8luNKM7JK/yMpGBW6AtBezoUaWgAcJJ+fDnCFG6VryS6b+q9fi7g17IUGThl2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OljTjIb0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OljTjIb0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A4B91F00A3A;
	Tue, 21 Jul 2026 09:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784627949;
	bh=rSuHLrLwfaNy42BpXjgZBG/shiso5SfO21bFlZH+k3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OljTjIb02H2+0UEkEM9Gelvjk5FK6OJ8NNM0loQc5M+e31RKsrtxXdE2cF37uZSMT
	 4V8Dal1LoqhDOheR3/hNkgCw0p/Pkp/fTFMc0gaARJcHE5OJGEjfM7eXIh9YVQhYeM
	 kmhAQ1Ont7DrN1V2+3kJ0NU6sVMP23kJq/CWS2aY5hnNEq+Lc4bl1Qdf3/bxS2txf3
	 pymV/GS6A00p9YzRw5e0rOf6aDo2tiIBg5l+mQFGyMrTBkfE1ZxjvrPGPmn7znVKyU
	 GbhMz6GnxGMJqTOl35SQQLdqauKv1SV137Pky4KbbrHErEQLuCGspCs9QOUZh6dFwJ
	 BkyZkMFiBUnew==
Date: Tue, 21 Jul 2026 10:58:50 +0100
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
Message-ID: <al9BpTu2ma8GpiPW@lucifer>
References: <20260720-fix-cpa-kernel-pagetables-v1-1-0766e782cefe@kernel.org>
 <al5-fDRStgU6gjk6@fedora>
 <al5_Le9QlD4zlt25@fedora>
 <al8hE_ded6qyWiDv@lucifer>
 <al8_xx_99BjAUn5A@fedora>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <al8_xx_99BjAUn5A@fedora>

On Tue, Jul 21, 2026 at 02:45:43AM -0700, Vishal Moola wrote:
> On Tue, Jul 21, 2026 at 08:43:51AM +0100, Lorenzo Stoakes (ARM) wrote:
> > On Mon, Jul 20, 2026 at 01:03:57PM -0700, Vishal Moola wrote:
> > > On Mon, Jul 20, 2026 at 01:01:00PM -0700, Vishal Moola wrote:
> > > > On Mon, Jul 20, 2026 at 10:27:29AM +0100, Lorenzo Stoakes (ARM) wrote:
> > > > > When splitting a large page in CPA in __split_large_page() we allocate a
> > > > > PTE directly without going through the standard page table allocation
> > > > > routines such as pte_alloc_one_kernel().
> > > > >
> > > > > This means the page table constructor is never called nor is the page table
> > > > > marked as a kernel page table.
> > > > >
> > > > > The former results in the folio associated with the page table not being
> > > > > marked as a page table (__pagetable_ctor() is never called thus neither is
> > > > > __folio_set_pgtable()) nor are statistics updated to reflect
> > > > > it (lruvec_stat_add_folio() is never called).
> > > > >
> > > > > The latter issue of failing to mark the page table as a kernel page
> > > > > table (ptdesc_set_kernel() is never called) is far more problematic.
> > > > >
> > > > > Since commit 5ba2f0a15564 ("mm: introduce deferred freeing for kernel page
> > > > > tables") kernel page table freeing has been batched and since the
> > > > > subsequent commit e37d5a2d60a3 ("iommu/sva: invalidate stale IOTLB entries
> > > > > for kernel address space") IOTLB cache entries for kernel page tables have
> > > > > been invalidated upon being freed.
> > > > >
> > > > > Since split page tables are freed without this invalidation, the IOTLB can
> > > > > contain stale entries for them.
> > > > >
> > > > > Resolve the issue by using the ordinary PTE allocation API at split time.
> > > > >
> > > > > This results in these kernel page tables invoking a page table constructor,
> > > > > and thus requires a page table destructor.
> > > > >
> > > > > Since we cannot assume one is always present (early allocated direct map
> > > > > page tables are not marked as such), we conditionally call
> > > > > pagetable_dtor_free() if the PG_table folio flag for the ptdesc is set,
> > > > > otherwise we free the page table via pagetable_free().
> > > > >
> > > > > Regardless of which path is taken page tables marked as kernel page tables,
> > > > > which now includes split page tables, take the correct route through
> > > > > pagetable_free_kernel().
> > > > >
> > > > > There is a user-visible side effect in that split page tables will appear
> > > > > in nr_page_table_pages in /proc/vmstat (as do other kernel page tables
> > > > > allocated after early boot), however this is a positive change.
> > > > >
> > > > > This issue started being markedly problematic after commit
> > > > > 5ba2f0a15564 ("mm: introduce deferred freeing for kernel page tables") so
> > > > > choose this as the Fixes target.
> > > > >
> > > > > Fixes: 5ba2f0a15564 ("mm: introduce deferred freeing for kernel page tables")
> > > > > Cc: stable@vger.kernel.org
> > > > > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > > > > ---
> > > > >  arch/x86/mm/pat/set_memory.c | 21 ++++++++++++---------
> > > > >  1 file changed, 12 insertions(+), 9 deletions(-)
> > > > >
> > > > > diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> > > > > index 301fb9e77d91..a67ca33b9dd1 100644
> > > > > --- a/arch/x86/mm/pat/set_memory.c
> > > > > +++ b/arch/x86/mm/pat/set_memory.c
> > > > > @@ -439,7 +439,11 @@ static void __cpa_collapse_large_pages(struct cpa_data *cpa)
> > > > >
> > > > >  	list_for_each_entry_safe(ptdesc, tmp, &pgtables, pt_list) {
> > > > >  		list_del(&ptdesc->pt_list);
> > > > > -		pagetable_free(ptdesc);
> > > > > +
> > > > > +		if (folio_test_pgtable(ptdesc_folio(ptdesc)))
> > > > > +			pagetable_dtor_free(ptdesc);
> > > > > +		else
> > > > > +			pagetable_free(ptdesc);
> > > >
> > > > Lets not introduce more folio-ptdesc crossovers, we're trying to get
> > > > rid of them :)
> > > >
> > > > I believe pagetable_dtor_free() should do what you're looking for on its
> > > > own anyway.
> > >
> > > Actually, looking at it closer, maybe not because of the conditional
> > > portion? But that makes me think it might be better to just replace the
> > > ptdesc_clear_kernel() with pagetable_dtor() in the free function...
> >
> > Well some kernel page tables are still allocated without ctor (early allocated
> > direct map for isntance), and if you did pagetable_dtor_free() it
> > unconditionally calls pagetable_dtor().
> >
> > The ptlock_free() and __folio_clear_pgtable() there would be harmelss (no locks
> > assigned for kernel page table, and if PG_table never set clearing it is a noop)
> > but the lruvec_stat_sub_folio() would cause an unbalanced decrement of
> > nr_page_table_pages.
>
> Gotcha, thanks for the explanation :)

No worries, this is subtle stuff with lots of weird gotchas and stuff we need to
improve... I seem to have fallen down an unexpected rabbit hole with these fixes
:)

>
> > It sucks, but until everything is updated to call the ctor we have to do it this
> > way :>)
>
> Yeah that makes sense. Although I'd rather see the condition as:
> if(PageTable(ptdesc_page(...)))
>
> We really shouldn't be calling ptdesc_folio() anywhere anymore.

I think better for a follow up since the code already uses ptdesc all over the
place (fundamental to the approach really, keeping a list of page tables etc.)
and this is a fix that needs backporting.

The follow up be something that you could look at if you have time? :>)

Cheers, Lorenzo
