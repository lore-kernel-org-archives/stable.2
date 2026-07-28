Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9B230C146;
	Tue, 28 Jul 2026 15:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785252834; cv=none; b=hPNxF34oCXNdR6KYYyj8IBdmG/3Z0YDyl5qPmtKrel+ct064yZj+kTQWVrJKfHEf0297jZh+rKinJkTsSCM2Yj+m9JpZCD03AJ+SqsOi34GM6BFspSf8wZ+1PLmcE3WgT1E8Rkt6s44q6iROxZonVIctLmgSDqAtBLoczVsBgoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785252834; c=relaxed/simple;
	bh=zQIwOSKn/0R8Y2guuiO/EQFjFuK6aMrhavXHWbZlyhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bu3Qy8vuAdBSJ4B08z+WKNItH3FzJieBDc8VeamvxeeUlcXLDsxQnqbhwEQTR3BIMRPA78LUItYEyEWR026GgwpH/HNHjPdxvOHAKyJ5H1SllG1ax3+CjrAoRm9+6tj98eATfgNkLPkZGULyi5vMjDhqYvnfr2wTTJ5bfkXseqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZR7XTAvt; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZR7XTAvt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MtI8BjVNz9fvIWLLabGAXhTyjAUw+ny5VCHWBMfAP7U=; b=ZR7XTAvtNIKJro36JxE/8l5Q/W
	ReI+Qiwt7PsTt2gjKRFN+94VxnT4QcNzzua3897tbbBK2zoDqEElZSnqusWc70POKhKhprFcGTNel
	J2sUYUxGJAlwLorD5mn+tYu+56aQUqbZpxu3dhCYYZ8pNYNCHs42fILaFYFNMHG8B71NmI7hFnLUd
	3FMIbQlnGUw6or7BLKSbHdVRtXp2cacvktYZFtfsB6ZLR6NRE/Ww4KeGKcd3/39EpDCsALZVL8P4W
	03P8v3ZO3dhnkJHv1fe24ssYJX/CLUcU6wNX4smqEXCVYrj7WjL9XaT5srV1LsLj+wgcalmaoKbbM
	ZA0j0ndQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wojoM-0000000DaEn-0Vwv;
	Tue, 28 Jul 2026 15:33:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A12183004AB; Tue, 28 Jul 2026 17:33:41 +0200 (CEST)
Date: Tue, 28 Jul 2026 17:33:41 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
	David CARLIER <devnexen@gmail.com>,
	David Hildenbrand <david@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Juergen Gross <jgross@suse.com>, Kevin Tian <kevin.tian@intel.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
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
Message-ID: <20260728153341.GY751831@noisy.programming.kicks-ass.net>
References: <20260728-cpa-fixes-v1-0-2ed2352300b3@kernel.org>
 <20260728-cpa-fixes-v1-1-2ed2352300b3@kernel.org>
 <20260728142108.GW751831@noisy.programming.kicks-ass.net>
 <adfffb36-9943-4af7-a0ee-0e762e47fa11@intel.com>
 <20260728143135.GG651302@noisy.programming.kicks-ass.net>
 <amjAxhL-IeeJITEv@kernel.org>
 <20260728145528.GI651302@noisy.programming.kicks-ass.net>
 <20260728150126.GC921102@noisy.programming.kicks-ass.net>
 <amjHQtTRKKkxdaWC@lucifer>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amjHQtTRKKkxdaWC@lucifer>

On Tue, Jul 28, 2026 at 04:20:10PM +0100, Lorenzo Stoakes (ARM) wrote:
> On Tue, Jul 28, 2026 at 05:01:26PM +0200, Peter Zijlstra wrote:
> > On Tue, Jul 28, 2026 at 04:55:28PM +0200, Peter Zijlstra wrote:
> > > On Tue, Jul 28, 2026 at 05:46:30PM +0300, Mike Rapoport wrote:
> > > > On Tue, Jul 28, 2026 at 04:31:35PM +0200, Peter Zijlstra wrote:
> > > > > On Tue, Jul 28, 2026 at 07:30:27AM -0700, Dave Hansen wrote:
> > > > > > On 7/28/26 07:21, Peter Zijlstra wrote:
> > > > > > > There was already a patch merged that removed the shole debug_pagealloc
> > > > > > > exception. Is that not better?
> > > > > >
> > > > > > As I'm scanning through email this morning, there's another issue that
> > > > > > popped up with that patch. It's causing hangs on boot.
> > > > > >
> > > > > > It's looking like debug pagealloc not taking the lock is actually
> > > > > > functional, not an optimization. Although, I hesitate to say
> > > > > > "functional" and would prefer to use much less nice words to describe it.
> > > > >
> > > > > Yeah, lets figure out why that is before we retain this wart ;-)
> > > >
> > > > As Lorenzo said:
> > > >
> > > >   __kernel_map_pages() can be called from irq context:
> > > >
> > > >   < GFP_ATOMIC context >
> > > >   kfree() or whatever
> > > >   -> ...
> > > >   -> __free_pages_prepare()
> > > >   -> debug_pagealloc_unmap_pages()
> > > >   -> __kernel_map_pages()
> > > >   -> __change_page_attr_set_clr()
> > > >   -> cpa_lock
> > > >
> > >
> > > The TLBI hack in __kernel_map_pages() makes me wonder how any of this is
> > > correct to begin with. That comment isn't helping.
> > >
> >
> > Also, the 'atomic context' usage hereabout seems confused. In particular
> > the issue is with IRQ-disabled context, they are not the same thing.
> 
> I mean yeah the IRQs being off is the issue with holding the lock over an IPI, a
> softirq allocating GFP_ATOMIC won't be a problem for that, but I think all the
> conclusions are still the same.

preempt_disable() is an 'atomic context', but does not present the
problem.

Anyway, yes not saying the conclusions are wrong, just that the wording
is confusing at heck.
