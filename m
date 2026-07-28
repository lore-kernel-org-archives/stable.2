Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1863B27CCE0;
	Tue, 28 Jul 2026 15:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785252630; cv=none; b=qy0RHP16b/B6wayApDe2uugrsD1rByeUkYJfr/171cQdRF3Y8516CKquM4za5pEwOQPbUakPg0gro5C+cxzOrRmVoYLEVoiP+pz4JSaKZpTkTNXO65HFxmggubSS9Ffe4jsJR+rGrstt9Aei3BiRLCEW1MtVlpPNnSQCkkT8Avg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785252630; c=relaxed/simple;
	bh=sO5Pv1iRhsqXxuYeMrdc1yBQyFxx8+ir+5YKkJYcOyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oAdsCMe5JDssxR8AvA7JhZqLjM3bovo+j/vN8me9vDfcz4DpvbatimWTT5eYp3/Hu4QT0+esnhzt/5a6oZSqoMBLIEdPPNPIVtD7XPmzcPRsLNm8HKu7XNNqSiGmkc7tezcCoj7s3L8QYzZ1UTpmEuRPTE9nE5wUZzAPHirhrZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=C+NTxpFk; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C+NTxpFk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=r7a5jh4qeutPWij5dNaVnpBg8RmqFNiNHJXuQhNtjlI=; b=C+NTxpFk6RN70FEbbxxwCZACaE
	NKD0at/vSUIsbpF17jcNDIGkoYlGuJ5AWosQJ5EsVCZzWRFdtA3DJjcI8TBsWu2ja0A5VXsuxXbub
	LALrm0td7goVArnlPrHF6uiJmB32+SwGMdvQ0uqbN7hKgP3yhzLnVXvFiCy1NtgRBSbynF3/G/Jih
	JfAaHU0zd+25WVu9GnQQrsRy59s+M+tXRxEoS218dvjt82ncwTM+I8mpYTQjfJqt+ZoqU9um2Zxjt
	w5fbVe1PqoU22ZVBALqCI7H3jD4gCH1gYbx6hl6iIEkz9w+9nOo58UMDNYA+ZGPEd0EZVMsKLz+Pz
	S32mj23w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wojl3-000000054s3-1WyI;
	Tue, 28 Jul 2026 15:30:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8F4AE3004AB; Tue, 28 Jul 2026 17:30:15 +0200 (CEST)
Date: Tue, 28 Jul 2026 17:30:15 +0200
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
Message-ID: <20260728153015.GD921102@noisy.programming.kicks-ass.net>
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

So in particular the from IRQ-disabled context thing seems to be
clearing the 'present' bit. Not doing a full TLBI on that would allow
other CPUs to still access the page, resulting a lack of faults.

I suppose that is a non-fatal case. It makes the debug code less robust
than it wants to be, but no malfunction.

But debug_page_alloc_map_pages() as used from post_alloc_hook() for a
GFP_ATOMIC alloc would result in not propagating the present bit,
resulting in concurrent faults. And I'm not immediately seeing a fixup
for that in the fault handler.

Hmm, perhaps spurious_kernel_fault() handles it, after all, it would not
actually observe !present anymore when reading the PTE, its just a stale
TLB entry at that point.

Hmmm...
