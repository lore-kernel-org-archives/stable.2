Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E174508EB;
	Tue, 21 Jul 2026 10:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784629976; cv=none; b=UmFQXdI8BYY6mSY79H/sk8EJhY2oZpvRC53j542L4J2jwTwmY0KFkisNLWDDVyPpBq95WLZv+ec+G54P5Nk8KKqj6GGEQa0vypMXJfR4/cRiuBICPJ5rk7fTPXxx49EjLJTqVd+/Bv3FbLp53lymrDJIRfo4E3yjZI1IGYnUkVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784629976; c=relaxed/simple;
	bh=jkN5zvUVJMCMUwbhclhdZ1CqXTlXOySWqV5FoXfM4Ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=azyTi0xdkb2wd7ePicKVweZn8LpUTAb6Kbolpz2aVrv7pYuLsq8nz2jeG4CtPVxp2UxAR0wKAcVeKgWVYV0wEGHkrss8g9CQgo+pXvGVQSvVgNq9I4W2TdTzhp4BbJWyxEXNqqXmF/HiEdg2oow37Pi2+pHUA2Dv1PEA6RwDPlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IhA9VFRm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IhA9VFRm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17E511F000E9;
	Tue, 21 Jul 2026 10:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784629975;
	bh=mspC1fdG+pvm63GGOQ7/xTAnO2WjExN52IoSROfvj/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IhA9VFRm5IdbLL+pEstMzqMhkdBytj5LItEqDpa1Yq1SgODLuKNcDGyr3S7LyFhg0
	 I1tjMsit9yiuPWJquHM5hmxH7ZW89EasFRtXDDEXDQ24GNhR3Tj0h64K5WgpOUKs2E
	 ppTD3mLmWLCXMDQGXrBZ7kDNJBh7R+J60fex/Ps6JTXB0wMWRD6AemPEvh0E89nT47
	 g3B2vlw0SdP7IkE3EWCOE7Zny3Z8k6NCjiJ4P5/Hh7SjRTOf9NYb/t0OuL0MR+V3R+
	 Sg/8rD57YwRLfQENAOAd3xO1iXPQ44H1qLKink+8bEAqZJgYoEpsFZwEPKdPoTtlf7
	 Q28eR8c7qDh1g==
Date: Tue, 21 Jul 2026 13:32:44 +0300
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
Message-ID: <al9KzIhKXa3PCMqa@kernel.org>
References: <20260720-fix-cpa-kernel-pagetables-v1-1-0766e782cefe@kernel.org>
 <al5-fDRStgU6gjk6@fedora>
 <al5_Le9QlD4zlt25@fedora>
 <al8hE_ded6qyWiDv@lucifer>
 <al8_xx_99BjAUn5A@fedora>
 <al9BpTu2ma8GpiPW@lucifer>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <al9BpTu2ma8GpiPW@lucifer>

On Tue, Jul 21, 2026 at 10:58:50AM +0100, Lorenzo Stoakes (ARM) wrote:
> On Tue, Jul 21, 2026 at 02:45:43AM -0700, Vishal Moola wrote:
> > >
> > > Well some kernel page tables are still allocated without ctor (early allocated
> > > direct map for isntance), and if you did pagetable_dtor_free() it
> > > unconditionally calls pagetable_dtor().

TBH, I cannot think of a scenario when page tables allocated at boot would
be collapsed. But surely, checking the page type is safer just in case.

> > > The ptlock_free() and __folio_clear_pgtable() there would be harmelss (no locks
> > > assigned for kernel page table, and if PG_table never set clearing it is a noop)
> > > but the lruvec_stat_sub_folio() would cause an unbalanced decrement of
> > > nr_page_table_pages.
> >
> > Gotcha, thanks for the explanation :)
> 
> No worries, this is subtle stuff with lots of weird gotchas and stuff we need to
> improve... I seem to have fallen down an unexpected rabbit hole with these fixes
> :)
> 
> >
> > > It sucks, but until everything is updated to call the ctor we have to do it this
> > > way :>)
> >
> > Yeah that makes sense. Although I'd rather see the condition as:
> > if(PageTable(ptdesc_page(...)))
> >
> > We really shouldn't be calling ptdesc_folio() anywhere anymore.
> 
> I think better for a follow up since the code already uses ptdesc all over the
> place (fundamental to the approach really, keeping a list of page tables etc.)
> and this is a fix that needs backporting.

I agree with Vishal that it's better to use page type rather than folio
type. And it's the same for backporting ;-) 
 
> Cheers, Lorenzo

-- 
Sincerely yours,
Mike.
