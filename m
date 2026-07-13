Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F2C2E8E09;
	Mon, 13 Jul 2026 15:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783958085; cv=none; b=At2c/XaZn4U2CR8R431rZXWLrmBsMCpNEF1Jxtj3KzqLyc1BpFCKvfIi05W70BzRmh0Fsxx78tRSxDmWeymxqx86U5ZGKj651CObuW4q60Sq/dZ4pGmi/YkXIm/dkJOR4IlUOD0lXhldeJSHocO5bvKG2RYeIswx3wQ+rP0nyT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783958085; c=relaxed/simple;
	bh=FIvZPUpWGsIv0UoOrLlTzIJJwkqp4TjN3YKw+0UH+Ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CipA4LQZ7AL3+74cNxVR1OvlL882Xf2NFwgkd8wjk+k1tdAHiKRiscj+VHccHYZ4viggkAzGjN/8jDSqSnIJ3QoyiaJI25u3wLXFyZdbu8jm1NsmS1qTMKRuIskHmvHID2GLcER6Va8A9raVNCSp2nkos3infdj1ZwIXE152r6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Al/31Rtk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Al/31Rtk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 921121F000E9;
	Mon, 13 Jul 2026 15:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783958084;
	bh=p66T0NncB+5raKUdPRksLr/+xBC+Njc5g/o72Yk49hk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Al/31Rtku4yM52tR3QNXE4FDvk8JrNQ/OKqQIR4Gw42mq/+wRDTRFDbNaOZZ/J0Ip
	 trE67THHLLKgw/9c8lLgl464jvRdo9Rl39bWVfDs5f2/ak+l7gLCmCCUBBwO2ClV5o
	 6Ms7uhjv+c/jAxAxLV580cW8rMBI8KCxWpjcE8LSXkzLAVZ6JTo/kQ26KBFoeEciHc
	 PjkuemTz3G+8ug2nkEZR51GUlnv5Nlj9ldK7NfTVawcO/klBlFSV3Ci6mWxMbRt5u8
	 Daa4BcwmyolvmBxOiDE3shvuqoBVrT3L6NKlAB1AcrrsoTpNU5EMJx2ZirPE9YvmcR
	 mGpeXGLtXYYKw==
Date: Mon, 13 Jul 2026 16:54:27 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Kiryl Shutsemau <kas@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Uladzislau Rezki <urezki@gmail.com>, Toshi Kani <toshi.kani@hpe.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Dev Jain <dev.jain@arm.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	David Carlier <devnexen@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org, 
	syzbot+fd95a72470f5a44e464c@syzkaller.appspotmail.com
Subject: Re: [PATCH mm-hotfixes v2 0/4] mm: fix UAF caused by race between
 ptdump and vmap pgtable freeing
Message-ID: <alTq4V50767L-s5H@lucifer>
References: <20260712-series-vmap-race-fix-v2-0-ad134cc3a12a@kernel.org>
 <alTn7NguEW_4bodu@thinkstation>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alTn7NguEW_4bodu@thinkstation>

On Mon, Jul 13, 2026 at 02:32:09PM +0100, Kiryl Shutsemau wrote:
> On Sun, Jul 12, 2026 at 11:42:23AM +0100, Lorenzo Stoakes wrote:
> > This series addresses the issue by having the vmap huge promotion
> > logic acquire the mmap read lock while both setting the huge page
> > table entry and freeing the prior leaf page table.
>
> Hi Lorenzo,
>
> Before we settle on the mmap lock scheme, have you considered handling
> this the way GUP-fast handles page table freeing -- RCU-defer the free
> and make ptdump a lockless walker?

Overall I like the idea of eventually moving this to _all_ being
RCU-free-able :)

BUT... I don't like it as a fix for this bug that has to be backported.

I think there's a lot of subtleties to worry about and I don't want to
worry about having to maintain tht as a backport.

But also, we have an unfortunate situation with ptdump where it also walks
userland ranges on x86 (and ranges for efi_mm on both x86 and arm64).

And for userland ranges you have to have the mmap write lock to exclude a
downgraded mmap read lock munmap() operation (which gives rise to the weird
inversion you mention).

So the walker still has to take the write lock in this case.

I spoke a bit about it overall at [0].

We already have this mmap lock convention as a requirement for kernel
ranges, and it was being violated by CPA and vmalloc.

So I'd prefer we keep this as the proximate fix to solve the bug here, and
then revisit this later (alongside moving to RCU page table freeing
_overall_, though one doesn't have to block the other).

I believe Suren is looking at this (and I'm happy to look if Suren is tied
up with other things also!)

>
> The locking here is inverted from what one would normally expect
> (walker takes the write lock, mutators take read locks, mutators safe
> against each other only by range ownership). It works, but it is

Yeah :) this is a direct result of the munmap() thing mentioned above
(because ptdump can read non-kernel ranges).

Because you _have_ to take the mmap write lock there, so you _may as well_
exclude with a read lock and then get to do an mmap read trylock as an
added bonus on vmap huge page promotion.

> subtle, it is what produced the arm64 deadlock and the ifdeffery, and
> it depends on every current and future freeing site remembering the
> rule -- patch 3 exists because two walkers did not fit the scheme.

Well everybody who does things with shared resources should be aware of
locking requirements.

>
> The free side looks cheap: kernel page table freeing already funnels
> through pagetable_free_kernel(), which already has a deferred path
> (used for IOMMU SVA). Adding a grace period there -- synchronize_rcu()
> in the worker, amortized over the batch -- covers every freeing site
> by construction.

Well I did want to say btw that CPA doesn't actually mark the page tables
as kernel, was going to chase up with something on that when I got a chance
:)

synchronize_rcu() is a very bug hammer, you can just use call_rcu() (and
the ptdesc already has an rcu_head I think).


>
> On the walk side, nothing on the ptdump path can sleep -- the pagewalk
> core only allocates for install_pte ops, kernel PTE level uses
> pte_offset_kernel(), and the arch note_page() implementations are
> seq_printf()/printk() into a preallocated buffer. So the walk could run
> under rcu_read_lock() as is. The real work is bounding the read-side
> sections: a full walk can take dozens of seconds on a KASAN kernel per
> the comment in mm/ptdump.c, so it would need to drop RCU and
> cond_resched() periodically, re-descending from the top. Note we
> currently hold the init_mm mmap write lock across those same dozens of
> seconds, and this series makes that load-bearing: during a long walk
> every promotion trylock fails, silently degrading vmalloc to small
> pages, and CPA collapse blocks.
>

Yeah it all sucks, but you're really making my point that this is better to
revisit and consider carefully rather than doing as a fix.

> That would give us: no inverted locking, no arm64 deadlock possibility
> (your patch 4 stands on its own), the patch 3 walkers covered
> structurally rather than by locking init_mm as well, and ptdump
> invisible to production paths.
>
> Given the live UAF, this could also be a follow-up rather than a
> respin. But I would like to hear whether you see a fatal flaw in the
> approach first.

Yes - as above obviously I'd definitely prefer to defer this to a
follow-up.

The main concern for ptdump is properly slicing its walk to avoid
RCU stalls.

Keeping in mind that vmap can (in theory) span PUDs and even P4Ds it
becomes a bit tricky.

But also I worry about whether the entries in the page table will actually
be valid at the point the walker reads them.

For vmap/CPA pretty much yes they are, but if something was to actually
unmap them in future then that might no longer be the case. RCU will only
guarantee that the page tables stick around, not that they contain anything
valid.

In userland a lot of this is solved already by the leaf page table entry's
PTL.

Kernel page tables are a bit of a weird case, because mostly we solve
things through exclusive owners, ptdump being the weirdo outlier.

Anyway TL;DR is that - I think we need to be careful and think this through
and make changes across the board for all kernel page table users and
update the page walkers.

I'm happy to spin up an RFC for this when I get a moment :)

But in general I'd like us to solve the problem as a whole across the
kernel for both userland and kernel page table allocations, ideally!

>
> --
>   Kiryl Shutsemau / Kirill A. Shutemov

Cheers, Lorenzo
