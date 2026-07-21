Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9494548AE20;
	Tue, 21 Jul 2026 12:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784635266; cv=none; b=lOqsTtQFOoAplpuDQBw8ggGwVMCYu3p2H/D3gvUyNDw3riREuPdJAKbQKPHkvR8mibc7bvRRBrw1CX9Y6vvJV0dx6trVaZRvBXndiTA8pUpGzubbbeq2mB8IkE/8wPXXZSgjk6E2vKLdWrYFJobWHmqq/bdR6aq8ue2u8FM1ZGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784635266; c=relaxed/simple;
	bh=5XIKQnZ9opHJEwvD0dLMnBqSTBDPCPOWWPyJ5Trj2VM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d88R7CS1nVHum9ylinoJ4oa/CbtnjMQBHP2U5AAjRodtxWdTmZEv5IeMYTaPlDQgZMz9wcA+eWoZ6nTofyZXNSIPGuEmFTJFlakWycuCakW1ONroMaj6miW/QMyKtBqBYRRhDi7tu7Ap2NKR6qBzyuQwteh1yPPYNIVTem/r7uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bgWWDECm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bgWWDECm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D848D1F00A3A;
	Tue, 21 Jul 2026 12:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784635265;
	bh=5XIKQnZ9opHJEwvD0dLMnBqSTBDPCPOWWPyJ5Trj2VM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bgWWDECmRNILlRghGfTo7PFAwy3rtWmPtf0AQfcSd4kE3u/9Agf5gZw1CuOmb6GjH
	 JoJ8HUGlqiko8ii2JVoiptpIzGvaj4MZnNZ4Xp/6ZtmOxln54UHl/SqxzVhCiAsKXA
	 CmU0+Vw4ucvBmsQiZn8DUCeI8BCa0kB9tSuVPR6V3xLaqyJPdQHuUSMt/XoDpFxoGf
	 Zx3SwxyuIPPEhhnrhWt/HcvrF1cYUJxQFhVD8FFM5VKCn2SB/mvo4ztkkUnogQ3wiD
	 2ihDsexCWYf00RwWyMuyBd8AQzR4bsSMIFCUJrLAK47RxUg49jBRp0SfLtp5rLHr8Y
	 2XHjiLOChAUKw==
Date: Tue, 21 Jul 2026 13:00:46 +0100
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
Message-ID: <al9b5uE-ep9ADtLt@lucifer>
References: <20260720-fix-cpa-kernel-pagetables-v1-1-0766e782cefe@kernel.org>
 <al5-fDRStgU6gjk6@fedora>
 <al5_Le9QlD4zlt25@fedora>
 <al8hE_ded6qyWiDv@lucifer>
 <al8_xx_99BjAUn5A@fedora>
 <al9BpTu2ma8GpiPW@lucifer>
 <al9KzIhKXa3PCMqa@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <al9KzIhKXa3PCMqa@kernel.org>

On Tue, Jul 21, 2026 at 01:32:44PM +0300, Mike Rapoport wrote:
> On Tue, Jul 21, 2026 at 10:58:50AM +0100, Lorenzo Stoakes (ARM) wrote:
> > On Tue, Jul 21, 2026 at 02:45:43AM -0700, Vishal Moola wrote:
> > > >
> > > > Well some kernel page tables are still allocated without ctor (early allocated
> > > > direct map for isntance), and if you did pagetable_dtor_free() it
> > > > unconditionally calls pagetable_dtor().
>
> TBH, I cannot think of a scenario when page tables allocated at boot would
> be collapsed. But surely, checking the page type is safer just in case.

Yeah nor can to be honest, anything that could be made large in the direct map
would already be large right?

But it's 'just in case' somebody did something dumb :) Later can maybe make it a
WARN_ON(). But just to fix the proximate issue for now.

>
> > > > The ptlock_free() and __folio_clear_pgtable() there would be harmelss (no locks
> > > > assigned for kernel page table, and if PG_table never set clearing it is a noop)
> > > > but the lruvec_stat_sub_folio() would cause an unbalanced decrement of
> > > > nr_page_table_pages.
> > >
> > > Gotcha, thanks for the explanation :)
> >
> > No worries, this is subtle stuff with lots of weird gotchas and stuff we need to
> > improve... I seem to have fallen down an unexpected rabbit hole with these fixes
> > :)
> >
> > >
> > > > It sucks, but until everything is updated to call the ctor we have to do it this
> > > > way :>)
> > >
> > > Yeah that makes sense. Although I'd rather see the condition as:
> > > if(PageTable(ptdesc_page(...)))
> > >
> > > We really shouldn't be calling ptdesc_folio() anywhere anymore.
> >
> > I think better for a follow up since the code already uses ptdesc all over the
> > place (fundamental to the approach really, keeping a list of page tables etc.)
> > and this is a fix that needs backporting.
>
> I agree with Vishal that it's better to use page type rather than folio
> type. And it's the same for backporting ;-)

Ah sorry misunderstood, you mean straight up PageTable(ptdesc_page()), I thought
Vishal was saying we shouldn't be directly referencing ptdesc's at all (which
would be the rework).

I guess definitionally page tables are never folios. I lazily went with what I
saw elsewhere, my bad :)

Will respin!


>
> > Cheers, Lorenzo
>
> --
> Sincerely yours,
> Mike.

Cheers, Lorenzo
