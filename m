Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C374657CC;
	Tue, 28 Jul 2026 15:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785250996; cv=none; b=f4xuxz+LTMdG4nYmrx/MzpiBCNPOEL5+gdQ2M0GTLxoTbGKnrfrr51QNMOwTtVEMd+w6fmlE2C6Z6pyGaxYQqYJ6GGPTz854FaGINMQ7jPwnQN53TwsV0RMwZie9f0wgdzP33DkdRLb1g7PVcZPUAt+PZEIqDNMze3o/V5We4J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785250996; c=relaxed/simple;
	bh=2N83pgTb9rWXLPNPZC4FlvkefVz3L8EuP76ymrB5nt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QfMz5lylajc8iFc+ytV985Djy0TraL1KzuJULRsQe0Ctc/aufkCPhjZWo/ekbI7dyEeVo2RvMR8g5ngbZvEsk8VCc9ypr5/kWkNIQHVmd5r5KX1rqZDhWOYP3m/4d3I9ChX5hKXUEbcdIG7J68776UUZ7R6g6lW9vZdB71lYbjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BsT11Mus; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BsT11Mus"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E3221F000E9;
	Tue, 28 Jul 2026 15:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785250994;
	bh=OZYCAEb0HM9rfGd3QRD8GMQog/bF2RXcJS7UIluiZL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BsT11Musj5q8C0iTcuGYFJ6t+D6ns5bM8zQlELONuV/VX/yrCA018Wh0N7Gwlznfd
	 aotiaq/I6OR8LKclH4M5+e4rAxmJyw3vUQECHwkeFMfQIQ/tFPlCTWglK3b/Tpzdww
	 +bRNamfIQhuehUPoKSWXhm/ZLQvVUAWtUFMzGr+dfkJUvNs5Ryut3TSr4HBqIqxCdV
	 45BanpsTI0eHKnIwuq5OGl4NbtzaGlFQdEx9DUFUydqVDv7DsG4XLVGAH0lz5LJISE
	 muvDh8wTByYOUEi4WYqtLE9IsNM7nj4Y4uHVDKRCrIrLpKMxJrdjaTi8nK3Kwr3pXt
	 8QQmczoQHS6GQ==
Date: Tue, 28 Jul 2026 16:02:54 +0100
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
Message-ID: <amjEJ8XcwOCAcxFJ@lucifer>
References: <20260728-cpa-fixes-v1-0-2ed2352300b3@kernel.org>
 <20260728-cpa-fixes-v1-1-2ed2352300b3@kernel.org>
 <20260728142108.GW751831@noisy.programming.kicks-ass.net>
 <adfffb36-9943-4af7-a0ee-0e762e47fa11@intel.com>
 <20260728143135.GG651302@noisy.programming.kicks-ass.net>
 <amjAxhL-IeeJITEv@kernel.org>
 <20260728145528.GI651302@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728145528.GI651302@noisy.programming.kicks-ass.net>

On Tue, Jul 28, 2026 at 04:55:28PM +0200, Peter Zijlstra wrote:
> On Tue, Jul 28, 2026 at 05:46:30PM +0300, Mike Rapoport wrote:
> > On Tue, Jul 28, 2026 at 04:31:35PM +0200, Peter Zijlstra wrote:
> > > On Tue, Jul 28, 2026 at 07:30:27AM -0700, Dave Hansen wrote:
> > > > On 7/28/26 07:21, Peter Zijlstra wrote:
> > > > > There was already a patch merged that removed the shole debug_pagealloc
> > > > > exception. Is that not better?
> > > >
> > > > As I'm scanning through email this morning, there's another issue that
> > > > popped up with that patch. It's causing hangs on boot.
> > > >
> > > > It's looking like debug pagealloc not taking the lock is actually
> > > > functional, not an optimization. Although, I hesitate to say
> > > > "functional" and would prefer to use much less nice words to describe it.
> > >
> > > Yeah, lets figure out why that is before we retain this wart ;-)
> >
> > As Lorenzo said:
> >
> >   __kernel_map_pages() can be called from irq context:
> >
> >   < GFP_ATOMIC context >
> >   kfree() or whatever
> >   -> ...
> >   -> __free_pages_prepare()
> >   -> debug_pagealloc_unmap_pages()
> >   -> __kernel_map_pages()
> >   -> __change_page_attr_set_clr()
> >   -> cpa_lock
> >
>
> The TLBI hack in __kernel_map_pages() makes me wonder how any of this is
> correct to begin with. That comment isn't helping.
>

I think there's probably more horror shows there, it's a case of put out the
most immediate fires, leave the probably remaining flaming trash pile for later
;)

I thought x86 allowing arbitrary mm ptdump walks was crazy enough but this debug
pagealloc stuff kinda pushes things further crazy-wise...
