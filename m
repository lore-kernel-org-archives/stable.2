Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A523239E9A0;
	Sat, 18 Jul 2026 14:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784384931; cv=none; b=DRXbF8BECmBiB3btUNgzgEFXpYVPd2sZVObywqmIBwLna5xCQse/SRRAarVHYBdLlqNvh8Cek3dkNxBUz/6+4hZD6sBWvJcuTMK9rGr0J1P5ofWDOvsRwbDnU/9Ts1v3vMyKkfrB3Fn/3Uaifs4Dsmvo12T7XIo7C0CsyvI65tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784384931; c=relaxed/simple;
	bh=PSH4iDVFx2Itvpei4l98ecK7Nhv5FQUl77JqT7HK8dE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pwZ9vVTxsZmbGLekOotEcMuQpTwFt3vYVQ1WYFBzTGpDEVVxue+MIf2m91VffE7/LFFMcI2GNM/5ctwnuNDRA9Ur7OkHW7bpm1LD3mdKa2KPXZ5WtCHqWH1DgSb/DY8qXhpKpidy8i0rqMeRuqJ4jlTXWdusfwLYxIqJgLR+NTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e2Uj07DO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2Uj07DO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E7DD1F000E9;
	Sat, 18 Jul 2026 14:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784384925;
	bh=cN4SFoY/tZY29HdeZMDLAXwiTzxCSnJElqCY0zELtGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=e2Uj07DOjH/TQ82jaKLRrQ0tj27mcvpntC4p3PJATIngsRHYlFU3X3lofLYviPBbs
	 u5SyLmqiWfPcoz5tpuccs2N0KK12Od0OysNEMnnoYf6Ykh6Sy5OFYiUIoom5d8w5U1
	 GUGdRFnntCxA4dVhZGQx7NjUHixCXMFqML9lUABHYf1QbdQYTkuwl6x0rdGQOsQoN+
	 MrdDSuVD6+gdakknmWXozFPIxdXvFolH0Ka3+st04WOm7vqEifB/e5avrrzrslKj/h
	 jZXYC+c+KKbCZ+E03rv7Y58wu4KoW0RstJn2j3yEL01YMhErUicAUA+uvQy8a78y/K
	 pl0KFFOHijohQ==
Date: Sat, 18 Jul 2026 15:28:25 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	David Hildenbrand <david@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Uladzislau Rezki <urezki@gmail.com>, Toshi Kani <toshi.kani@hpe.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Dev Jain <dev.jain@arm.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, David Carlier <devnexen@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	"Denis V. Lunev" <den@virtuozzo.com>, stable@vger.kernel.org
Subject: Re: [PATCH mm-hotfixes v5 3/5] x86/mm/pat: acquire init_mm read lock
 on attribute change to avoid UAF
Message-ID: <aluLf-2NcDKylRP_@lucifer>
References: <20260717-series-vmap-race-fix-v5-0-606a0ac6d3e5@kernel.org>
 <20260717-series-vmap-race-fix-v5-3-606a0ac6d3e5@kernel.org>
 <altbeuTZ0HCz_7HS@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <altbeuTZ0HCz_7HS@kernel.org>

On Sat, Jul 18, 2026 at 01:54:50PM +0300, Mike Rapoport wrote:
> On Fri, Jul 17, 2026 at 06:30:09PM +0100, Lorenzo Stoakes (ARM) wrote:
> > A previous commit protected us against races between ptdump and CPA
> > collapse, however one still exists between attribute changes and collapse
> > as reported by Denis V. Lunev (linked).
> >
> > When an attribute change arises, a lockless page table walker obtains a PTE
> > entry, which is later written to via set_pte_atomic():
> >
> > ...
> > -> change_page_attr_set_clr()
> > -> __change_page_attr_set_clr()
> > -> __change_page_attr()
> > 	-> _lookup_address_cpa()
> > 	-> lookup_address_in_pgd_attr()
> > 	-> [ lockless page table walker ]
> > -> set_pte_atomic()
> >
> > There is nothing preventing a concurrent CPA collapse which can free the
> > PTE that was retrieved here, resulting in a use-after-free.
> >
> > With the mmap write lock taken on init_mm over CPA collapse, we can now
> > resolve this race by acquiring an mmap read lock on init_mm over
> > __change_page_attr_set_clr().
> >
> > This locks across the whole operation over which the walk and the PTE entry
> > write occurs, solving the race.
> >
> > It is safe to do this here, as no spinlocks are held upon entry to
> > __change_page_attr_set_clr().
> >
> > The CPA_COLLAPSE flag is only set by set_memory_rox(), which exclusively
> > operates upon vmalloc ranges, and on x86 only within the module mapping
> > space.
> >
> > This is important, because some callers directly invoke
> > __change_page_attr_set_clr(), bypassing this lock. However, none of these
> > operate within the module mapping space.
> >
> > * cpa_process_alias() - a recursive helper called by
> >   __change_page_attr_set_clr().
> > * __set_memory_enc_pgtable() - operates on the direct mapping and (via
> >   __vmbus_establish_gpadl()) the vmalloc mapping space.
> > * __set_pages_[n]p() - called by set_direct_map_[invalid, default,
> >   valid]_noflush(), __kernel_map_pages() - operates on the direct map.
> > * kernel_[un]map_pages_in_pgd() - operates on EFI ranges.
> >
> > This work is based upon Denis V. Lunev's excellent analysis of the bug with
> > gratitude.
> >
> > Link: https://lore.kernel.org/all/20260626163213.2284080-1-den@openvz.org/
> > Fixes: 41d88484c71c ("x86/mm/pat: restore large ROX pages after fragmentation")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > ---
> >  arch/x86/mm/pat/set_memory.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> > index d1e63f7d267f..301fb9e77d91 100644
> > --- a/arch/x86/mm/pat/set_memory.c
> > +++ b/arch/x86/mm/pat/set_memory.c
> > @@ -2122,7 +2122,9 @@ static int change_page_attr_set_clr(unsigned long *addr, int numpages,
> >  	cpa.curpage = 0;
> >  	cpa.force_split = force_split;
> >
> > -	ret = __change_page_attr_set_clr(&cpa, 1);
> > +	/* Avoid race with concurrent CPA collapse. */
> > +	scoped_guard(mmap_read_lock, &init_mm)
> > +		ret = __change_page_attr_set_clr(&cpa, 1);
>
> There's a small issue with this. debug_pagealloc_unmap_pages() ends up here
> and since it's called from __free_pages() it can be in an atomic context.

Not the case - the callstack is:

debug_pagealloc_unmap_pages()
-> __kernel_map_pages()
-> __set_pages_[n]p()
-> __change_page_attr_set_clr()

So it calls __change_page_attr_set_clr() not change_page_addr_set_clr()
and doesn't hit this code.

As per the commit msg, it (and all the other bare
__change_page_attr_set_clr() callers) do not hit ranges that can be
collapsed so the race doesn't exist there.

Also the CPA_NO_CHECK_ALIAS flag is set, meaning there's no weird aliasing
recursion via cpa_process_alias() (which in any case, also calls
__change_page_attr_set_clr() directly anyway).

>
> >
> >  	/*
> >  	 * Check whether we really changed something:
> >
> > --
> > 2.55.0
> >
>
> --
> Sincerely yours,
> Mike.

Thanks, Lorenzo
