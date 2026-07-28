Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A891DB13A;
	Tue, 28 Jul 2026 15:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785252032; cv=none; b=WrzgM/TNdqNsfqBQtKqPC9zpV5SHUQwVReWDnZNNuTrtNDabirZi6zy/euXSnToUWO0MdOzAHkDW0KYmJi2NDmjClrtBfljApZRUk59uY+A5ta0242+OA+Zia2FL2boJdP1v0ktzdOJ+YBo5Wxk0e7FVv3qiMbRl7mMMCpGsKgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785252032; c=relaxed/simple;
	bh=7U7h5kwSeNJAXhWw+RPeXtCc3did/HbsffGA7Z+3nt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GBgqmzmu8AS0xFatJHd1y3g5Wpu60KmcseUDKoluwXdBEm/HMDaVu6NKmTOKE/wVunYkz0YlktYbgZdSjpnqeRy12MMxQWU+CQakwtecwzVr/yjSwrh7yjCJxAXljZ5oYIILpGjfANqmvM+0GQYT+qaL9F3jEKAc9usV1nzITlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHXtPkLt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHXtPkLt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA5191F000E9;
	Tue, 28 Jul 2026 15:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785252030;
	bh=Pcgm/0NVuLY1iQXWdMHTbgGTyBAUcx9voeT3GqTNrW4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nHXtPkLtRmjx3crBgajbkLZxNsA3m9uMCmmk+Zu1hXmHK+jqcSxKDyV8K2wEAn4ov
	 xAp4WJNCsT0bhLjmjM2bXP7jm36ow4Eez3+MwNxAabUGON2Ufr8GJ2fTQrTn4fM+PF
	 F2WRQZOsY7x8E5Gy4NkWKM1kXL/jUwoU3O/nmGJqaFskSIXPkooguA+E3Q6RPPrLJQ
	 ujd9oq3RqgGlSx9+LgrKyiPEIdHFc49+JhTl3UBJVbbO5EyeHdiyEQzge9D57ztibD
	 84Nd1+6QnDSM9g9sdyIoH5XrQdZnT8ObHMTB8lL1zvJ/aZlpBCRxbylGzEUz6Z1ubB
	 oyLbO8Xi/+Xzw==
Date: Tue, 28 Jul 2026 16:20:10 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mike Rapoport <rppt@kernel.org>, Dave Hansen <dave.hansen@intel.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	David CARLIER <devnexen@gmail.com>, David Hildenbrand <david@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, Juergen Gross <jgross@suse.com>, 
	Kevin Tian <kevin.tian@intel.com>, Kiryl Shutsemau <kas@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@kernel.org>, 
	Toshi Kani <toshi.kani@hpe.com>, Vishal Moola <vishal.moola@gmail.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Will Deacon <will@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 1/5] x86/mm/pat: introcude cpa_lock() and cpa_unlock()
Message-ID: <amjHQtTRKKkxdaWC@lucifer>
References: <20260728-cpa-fixes-v1-0-2ed2352300b3@kernel.org>
 <20260728-cpa-fixes-v1-1-2ed2352300b3@kernel.org>
 <20260728142108.GW751831@noisy.programming.kicks-ass.net>
 <adfffb36-9943-4af7-a0ee-0e762e47fa11@intel.com>
 <20260728143135.GG651302@noisy.programming.kicks-ass.net>
 <amjAxhL-IeeJITEv@kernel.org>
 <20260728145528.GI651302@noisy.programming.kicks-ass.net>
 <20260728150126.GC921102@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728150126.GC921102@noisy.programming.kicks-ass.net>

On Tue, Jul 28, 2026 at 05:01:26PM +0200, Peter Zijlstra wrote:
> On Tue, Jul 28, 2026 at 04:55:28PM +0200, Peter Zijlstra wrote:
> > On Tue, Jul 28, 2026 at 05:46:30PM +0300, Mike Rapoport wrote:
> > > On Tue, Jul 28, 2026 at 04:31:35PM +0200, Peter Zijlstra wrote:
> > > > On Tue, Jul 28, 2026 at 07:30:27AM -0700, Dave Hansen wrote:
> > > > > On 7/28/26 07:21, Peter Zijlstra wrote:
> > > > > > There was already a patch merged that removed the shole debug_pagealloc
> > > > > > exception. Is that not better?
> > > > >
> > > > > As I'm scanning through email this morning, there's another issue that
> > > > > popped up with that patch. It's causing hangs on boot.
> > > > >
> > > > > It's looking like debug pagealloc not taking the lock is actually
> > > > > functional, not an optimization. Although, I hesitate to say
> > > > > "functional" and would prefer to use much less nice words to describe it.
> > > >
> > > > Yeah, lets figure out why that is before we retain this wart ;-)
> > >
> > > As Lorenzo said:
> > >
> > >   __kernel_map_pages() can be called from irq context:
> > >
> > >   < GFP_ATOMIC context >
> > >   kfree() or whatever
> > >   -> ...
> > >   -> __free_pages_prepare()
> > >   -> debug_pagealloc_unmap_pages()
> > >   -> __kernel_map_pages()
> > >   -> __change_page_attr_set_clr()
> > >   -> cpa_lock
> > >
> >
> > The TLBI hack in __kernel_map_pages() makes me wonder how any of this is
> > correct to begin with. That comment isn't helping.
> >
>
> Also, the 'atomic context' usage hereabout seems confused. In particular
> the issue is with IRQ-disabled context, they are not the same thing.

I mean yeah the IRQs being off is the issue with holding the lock over an IPI, a
softirq allocating GFP_ATOMIC won't be a problem for that, but I think all the
conclusions are still the same.

>
> This confusion is seen in the existing comments in __set_pages_{p,np}()
> and in this patch series. It needs fixing.
