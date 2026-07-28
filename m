Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7DF45D5C3;
	Tue, 28 Jul 2026 15:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785250903; cv=none; b=SJHBCNhx/ByV+YA0KeXO4VavTzOnqDYTIlSYsh7hNKXUjfnJLXuHkhqiqiRxfkq27Q4Op1zMu0s/un5dedpjGUMOY5FNfdwRV9Do5xVrQPO5M1c+mLKFyiy4OCLsYaBqbuc2+lzHoIbHcloiJsuaHZzPN/uvNU4BkxInAGjUtb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785250903; c=relaxed/simple;
	bh=SxuU7fRVPKFAFLRoWQeDka1R8XTKLhY4TX7ENPKSvbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iJLoe5kjYKJwJhL3WCZCEyOsCKDaRgoMezSYFvnkydGd1suurztqq/DXKFinAm4emKpukHNmechucjzRmspHzqnuo0pEOA6zQfVugN/gTM3RZJjqXuQKXge18nns4cFixL4VhGAYJqnochxDXOSwVBSp0wz6RbcQpLBRzV8rFHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sMNki/i/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sMNki/i/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=r1K0D4ZSgD2q3ahJtEpB5vFDqIt7gcOZKTtXOge/lvM=; b=sMNki/i/hYMtTFJnfP3WoUISe1
	J+1P1dHzs7xzYXowAl6xxBcQrK72Cwty9oM2zO4NwwTx3UBZhxuQ4WNMhmMrqhxTnVyC8rVU0QMxk
	y4l/2xEIdgaitprmBest0tDC8bLHOuFBSeNT7KLjgh8jvTQo/ck6XpMBg2nHBD0I0QASfVIMIQz/Z
	R8fzqOZ+NpKRa8jvkVqS4OeNWk/rwHU2jzssTHn7QDrExZhI4eJGXbRiw4MzGaiyDWrkJzefhb9vu
	gcdTUO8MaC9QIiP4HDbFy7fAHqZoh8+/vDHMXlzaoYpWIgCCdXMimSOiwDTzueDzoIsAsclYyoPBO
	e6jd75zA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wojJ8-0000000DW4s-3IaE;
	Tue, 28 Jul 2026 15:01:26 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5459C3004AB; Tue, 28 Jul 2026 17:01:26 +0200 (CEST)
Date: Tue, 28 Jul 2026 17:01:26 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
	David CARLIER <devnexen@gmail.com>,
	David Hildenbrand <david@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Juergen Gross <jgross@suse.com>, Kevin Tian <kevin.tian@intel.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Gleixner <tglx@kernel.org>, Toshi Kani <toshi.kani@hpe.com>,
	Vishal Moola <vishal.moola@gmail.com>,
	Vlastimil Babka <vbabka@kernel.org>, Will Deacon <will@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, stable@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 1/5] x86/mm/pat: introcude cpa_lock() and cpa_unlock()
Message-ID: <20260728150126.GC921102@noisy.programming.kicks-ass.net>
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

Also, the 'atomic context' usage hereabout seems confused. In particular
the issue is with IRQ-disabled context, they are not the same thing.

This confusion is seen in the existing comments in __set_pages_{p,np}()
and in this patch series. It needs fixing.
