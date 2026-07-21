Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48979372EE6;
	Tue, 21 Jul 2026 13:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784641904; cv=none; b=nM4+mR5NsU6I5cJKJcw+lpRDYTUHkr3qIZdRupN3XT+1NOF8b4ijv/imxqicx1/DzKmESvTWs7Ec5mpExOE37a0ZQmTulIAYedu24SHbeKy6t67XONuuxUMPw8TZN+Oy4+lhjTbZZi+KwyhRDVnqPTgQczewXryvPg3T77QYfuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784641904; c=relaxed/simple;
	bh=YGg9I8IgAemionPjoI/CQGVuJUDcg1hCRJQU5X7oAmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+r2h8EhJ1YXsPvYEpCW/x3ozdCBlldvrxDYgGU6jjO6ak1j1B6xtkw5soEnfnmAvoj40LDvpJjfSt+DuEY+R8LDCHsxRgMY81y+3AKilNhdkH8YrqCiO+E0S0TeLZuR2lY4BjwNpTQgKiVgPjQ/MPRPauA9U88RbnncS4hPb8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J7RZ/w8/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J7RZ/w8/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4EAB1F00A3A;
	Tue, 21 Jul 2026 13:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784641903;
	bh=Pvhzps5Tk8jvX4BviS4O6j3wBvkJmKKyvjZkkLOc2rg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=J7RZ/w8/5rFQ34nRZAhG0S3I7LkEUZgHnw7sx0w8dS/sJSmTbr4aizN0U3uNYgOQV
	 sk+G4vyEeLOSsf2PIJloJu7kGJqS/3E25KrpYk5r+YOSIqyCJRmfTxs1OIq1mkzONo
	 KabEJby3rR7jR5UX7RV8WVOEg0aPKQ0y4E3iB/HrcTmRmWsBssUnUjs1ayS052H4PV
	 HFk8hIxhrkAdtOnQVeC4Kxh/mqNLkxxMOmsOgWOnvy9S+FrDdo2gBNPhRP2M1PnHRu
	 NB+5r5JGvSlUOB6/drzEldF0d6B6O0jmOkNvmnDQJr2QgNJT+hpFzKtRtqlfAw2pBn
	 HTyEC6KvboqRQ==
Date: Tue, 21 Jul 2026 16:51:31 +0300
From: Mike Rapoport <rppt@kernel.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Vishal Moola <vishal.moola@gmail.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Kiryl Shutsemau <kas@kernel.org>,
	iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] x86/mm/pat: allocate split page tables as kernel page
 tables
Message-ID: <al95Y5aXof0ISEkI@kernel.org>
References: <20260720-fix-cpa-kernel-pagetables-v1-1-0766e782cefe@kernel.org>
 <al5-fDRStgU6gjk6@fedora>
 <al5_Le9QlD4zlt25@fedora>
 <al8hE_ded6qyWiDv@lucifer>
 <al8_xx_99BjAUn5A@fedora>
 <al9BpTu2ma8GpiPW@lucifer>
 <al9KzIhKXa3PCMqa@kernel.org>
 <al9b5uE-ep9ADtLt@lucifer>
 <al9hMyqpjd4l0Fql@lucifer>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <al9hMyqpjd4l0Fql@lucifer>

On Tue, Jul 21, 2026 at 01:09:27PM +0100, Lorenzo Stoakes (ARM) wrote:
> On Tue, Jul 21, 2026 at 01:00:53PM +0100, Lorenzo Stoakes (ARM) wrote:
> > On Tue, Jul 21, 2026 at 01:32:44PM +0300, Mike Rapoport wrote:
> > > On Tue, Jul 21, 2026 at 10:58:50AM +0100, Lorenzo Stoakes (ARM) wrote:
> > > > On Tue, Jul 21, 2026 at 02:45:43AM -0700, Vishal Moola wrote:
> > > > > >
> > > > > > Well some kernel page tables are still allocated without ctor (early allocated
> > > > > > direct map for isntance), and if you did pagetable_dtor_free() it
> > > > > > unconditionally calls pagetable_dtor().
> > >
> > > TBH, I cannot think of a scenario when page tables allocated at boot would
> > > be collapsed. But surely, checking the page type is safer just in case.
> >
> > Yeah nor can to be honest, anything that could be made large in the direct map
> > would already be large right?
> >
> > But it's 'just in case' somebody did something dumb :) Later can maybe make it a
> > WARN_ON(). But just to fix the proximate issue for now.
> >
> > >
> > > > > > The ptlock_free() and __folio_clear_pgtable() there would be harmelss (no locks
> > > > > > assigned for kernel page table, and if PG_table never set clearing it is a noop)
> > > > > > but the lruvec_stat_sub_folio() would cause an unbalanced decrement of
> > > > > > nr_page_table_pages.
> > > > >
> > > > > Gotcha, thanks for the explanation :)
> > > >
> > > > No worries, this is subtle stuff with lots of weird gotchas and stuff we need to
> > > > improve... I seem to have fallen down an unexpected rabbit hole with these fixes
> > > > :)
> > > >
> > > > >
> > > > > > It sucks, but until everything is updated to call the ctor we have to do it this
> > > > > > way :>)
> > > > >
> > > > > Yeah that makes sense. Although I'd rather see the condition as:
> > > > > if(PageTable(ptdesc_page(...)))
> > > > >
> > > > > We really shouldn't be calling ptdesc_folio() anywhere anymore.
> > > >
> > > > I think better for a follow up since the code already uses ptdesc all over the
> > > > place (fundamental to the approach really, keeping a list of page tables etc.)
> > > > and this is a fix that needs backporting.
> > >
> > > I agree with Vishal that it's better to use page type rather than folio
> > > type. And it's the same for backporting ;-)
> >
> > Ah sorry misunderstood, you mean straight up PageTable(ptdesc_page()), I thought
> > Vishal was saying we shouldn't be directly referencing ptdesc's at all (which
> > would be the rework).
> >
> > I guess definitionally page tables are never folios. I lazily went with what I
> > saw elsewhere, my bad :)
> 
> Ah yeah I remember now, i saw __pagetable_ctor() dealt with folios:
> 
> static inline void __pagetable_ctor(struct ptdesc *ptdesc)
> {
> 	struct folio *folio = ptdesc_folio(ptdesc);
> 
> 	__folio_set_pgtable(folio);
> 	lruvec_stat_add_folio(folio, NR_PAGETABLE);
> }
> 
> 
> And was like 'huh?' (surely definitionally they're _not_ folios) but went with
> that on that basis.

I wonder why setting the type is even in ctor rather than in allocation.
 
> Another place to clean up I guess? (that one _definitely_ is a follow up though
> ;)

Yep :)
 
> Cheers, Lorenzo

-- 
Sincerely yours,
Mike.
