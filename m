Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10AF480978;
	Tue, 21 Jul 2026 12:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784635788; cv=none; b=qOcPkXQk5bE/X4guDdmit5GiuStGPfMpXe9j7Py+Tla03hCOGXNTzChDtFdS+FWbc+AFe5advzWH+eVbeR5V82NSJPC4l47y/RvLysVCLKWy0PPIlv1qrvkMaygaT1BnLOUjJqubMKG4HKvBhU4qu2BeYSHRRuns7phqvPxizdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784635788; c=relaxed/simple;
	bh=A7RpNfh6HhENIkWk/z+a/o2A0wzRVZZLzyn0aLn7sRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CxFp+G8G5j5c5h4By7i6M87LbmI1VRXroZEYJl7U7BCXDB8EDkFDk8i4agLH5DGU4agoa6U+1Bt3jzM8tKQ8wb4c1AtCtfQzxFOYgFnR+gFZsOIlTJW4+A1hDsqeb9ca8d8xTC+OaMQVox098FFipNHgRt/jBR4c3QL+LPU0NuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FCBchnQk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FCBchnQk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 328B31F000E9;
	Tue, 21 Jul 2026 12:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784635786;
	bh=+aU74TjwGAKlM1ykbFleIgZ0kqOSlolWT3M16XgHiR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FCBchnQktpU1hJI6VVEm3hDfoYdq9iEkrTct/AwFrdSPMeIM2JM9lcfnYGZvRazXy
	 a8/zEgTWzzu21EtZuE/yXLKIsr8+xmCSw8VQto9H55e/F7BOkcmdPrGKpFlnLdU6re
	 P5k4ZG9I+odTrG5rVGkxSNyesNhUmgrLt1GhgnhPRojWuMUoJrqjXdLb7V3XMqg5AD
	 TVSfO+pgPO/2Q2pQFDfTf/qYvPC89XKyTy1TvbKgp8UuJBe1ZqU0Pds2kZC0rvCNPJ
	 uFFsxHyaTsWjBb2HyzjjQXmE1nd7xxIcOhjwTfRrF7994SGksKawr0zsLyM2nHMz5D
	 hsUSrDxoKoW0g==
Date: Tue, 21 Jul 2026 13:09:27 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Vishal Moola <vishal.moola@gmail.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Kiryl Shutsemau <kas@kernel.org>, iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH] x86/mm/pat: allocate split page tables as kernel page
 tables
Message-ID: <al9hMyqpjd4l0Fql@lucifer>
References: <20260720-fix-cpa-kernel-pagetables-v1-1-0766e782cefe@kernel.org>
 <al5-fDRStgU6gjk6@fedora>
 <al5_Le9QlD4zlt25@fedora>
 <al8hE_ded6qyWiDv@lucifer>
 <al8_xx_99BjAUn5A@fedora>
 <al9BpTu2ma8GpiPW@lucifer>
 <al9KzIhKXa3PCMqa@kernel.org>
 <al9b5uE-ep9ADtLt@lucifer>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <al9b5uE-ep9ADtLt@lucifer>

On Tue, Jul 21, 2026 at 01:00:53PM +0100, Lorenzo Stoakes (ARM) wrote:
> On Tue, Jul 21, 2026 at 01:32:44PM +0300, Mike Rapoport wrote:
> > On Tue, Jul 21, 2026 at 10:58:50AM +0100, Lorenzo Stoakes (ARM) wrote:
> > > On Tue, Jul 21, 2026 at 02:45:43AM -0700, Vishal Moola wrote:
> > > > >
> > > > > Well some kernel page tables are still allocated without ctor (early allocated
> > > > > direct map for isntance), and if you did pagetable_dtor_free() it
> > > > > unconditionally calls pagetable_dtor().
> >
> > TBH, I cannot think of a scenario when page tables allocated at boot would
> > be collapsed. But surely, checking the page type is safer just in case.
>
> Yeah nor can to be honest, anything that could be made large in the direct map
> would already be large right?
>
> But it's 'just in case' somebody did something dumb :) Later can maybe make it a
> WARN_ON(). But just to fix the proximate issue for now.
>
> >
> > > > > The ptlock_free() and __folio_clear_pgtable() there would be harmelss (no locks
> > > > > assigned for kernel page table, and if PG_table never set clearing it is a noop)
> > > > > but the lruvec_stat_sub_folio() would cause an unbalanced decrement of
> > > > > nr_page_table_pages.
> > > >
> > > > Gotcha, thanks for the explanation :)
> > >
> > > No worries, this is subtle stuff with lots of weird gotchas and stuff we need to
> > > improve... I seem to have fallen down an unexpected rabbit hole with these fixes
> > > :)
> > >
> > > >
> > > > > It sucks, but until everything is updated to call the ctor we have to do it this
> > > > > way :>)
> > > >
> > > > Yeah that makes sense. Although I'd rather see the condition as:
> > > > if(PageTable(ptdesc_page(...)))
> > > >
> > > > We really shouldn't be calling ptdesc_folio() anywhere anymore.
> > >
> > > I think better for a follow up since the code already uses ptdesc all over the
> > > place (fundamental to the approach really, keeping a list of page tables etc.)
> > > and this is a fix that needs backporting.
> >
> > I agree with Vishal that it's better to use page type rather than folio
> > type. And it's the same for backporting ;-)
>
> Ah sorry misunderstood, you mean straight up PageTable(ptdesc_page()), I thought
> Vishal was saying we shouldn't be directly referencing ptdesc's at all (which
> would be the rework).
>
> I guess definitionally page tables are never folios. I lazily went with what I
> saw elsewhere, my bad :)

Ah yeah I remember now, i saw __pagetable_ctor() dealt with folios:

static inline void __pagetable_ctor(struct ptdesc *ptdesc)
{
	struct folio *folio = ptdesc_folio(ptdesc);

	__folio_set_pgtable(folio);
	lruvec_stat_add_folio(folio, NR_PAGETABLE);
}


And was like 'huh?' (surely definitionally they're _not_ folios) but went with
that on that basis.

Another place to clean up I guess? (that one _definitely_ is a follow up though
;)

>
> Will respin!
>
>
> >
> > > Cheers, Lorenzo
> >
> > --
> > Sincerely yours,
> > Mike.
>
> Cheers, Lorenzo

Cheers, Lorenzo
