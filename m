Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D2D3321AA;
	Mon, 13 Jul 2026 16:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783960335; cv=none; b=pl8QkrbgxPcQ2M1pdownDqYTwjoe5FFUgsQ951GnilZao7zvPsGKYAL7hbGW8N0C9Hzr7AHBu97YjKhyO9uPx7lE1z99lM4XlGFonNMcv4IwvphCRR5zakbJVVRKMILqQ8RtxuHj1aMBCVufTBctfDyKmlb/1NQPKLPibXj9dt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783960335; c=relaxed/simple;
	bh=ogfZqnQIF/P8PR2+Co7hzg3gZxWTspM2MAWmMC+duMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UWVGN2zI/x+6K/ajOtssvEOQwHp9VZTlHwlZoU4hJQhMGzP755vYzJIS92069mS4qBqgcUT4WpJMLZcwjFcWcTX/0Q4KOC2fv3kAqFcacpKe66LR1a0ZBYjXt4fLyuSJFR/B8M+Zanl/js+FGkgjTJpwB/C7P4IRLYYTN1CwB10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U15L5Arr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U15L5Arr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390BD1F000E9;
	Mon, 13 Jul 2026 16:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783960334;
	bh=XO5F4pQ+uHUwJNwX9eNu6Me3Gfi6NA9rxgfZG/tLNj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=U15L5ArrhHpm2GIW7EynRvllR8PIQkes1RaZHjK2Sdkcthxo5agp+pMdyHwyU5bN9
	 MXEsmqjTY6phhCwrtXl2jP8H0v89idEK2ePmafspZQ6X1Pv9LBDDDlbtU+9qXGP9Hr
	 k7rHNd+cXyzXF0eeKCD5tHYskkfosyG5laH3PxLGvjnE+WmWY38XApLYPUIjGBKvPu
	 SGJWxq6GJFS1ZGkSyxsHwD6TxblMwfvYluUUrebIBrHZDLrBLdGCEWR7BSVc5ZexoL
	 +1DJW4ToOqXMoWlbNd+nIPdGFrFD9yHF9hzyMKWJ0u+Vc+Bk4vvOVAnd/SdNG9y7vl
	 tA9WwxA7VvTMw==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 67056F40252;
	Mon, 13 Jul 2026 12:32:12 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 13 Jul 2026 12:32:12 -0400
X-ME-Sender: <xms:DBNVakdTAH7A03y0PVsUFydyobOSVexxJSFqlFeaXN2gJuW21w9G-g>
    <xme:DBNVamq3e2f8o6fdaIqgkHcG5wn0i8Mo5PPwNmbm-cqI3yJ6s_0LsnH-PSKezPO_r
    rS71P2dADZq1uKOuziFaY3t6BMqI3GiybLmbUtfDNQWOwxOzZMaMuU>
X-ME-Received: <xmr:DBNVam_qkOSms9UlXYzdeQQfCJyepU29MkMP3HSjmhZK6Gw2vdrN_57JNMUNHg>
X-ME-Proxy-Cause: dmFkZTFq7auBfYltiyKJgfsKmtNrxbtFQPID/Ha/Lse5/6brVgWYZB5+s1G4w4NrQdjRlo
    S+9ZluVXTS0Mx8qv4yUojVg1/rEXTSXvInmMbAfYx0T1GWN4yTyFiK4MrwlsqiKhtualXn
    W9EKSMdhAS2RHbfypEfgho+96CGT6KW9+kcjqdU7cAp73Anek3JkyeYo0JzGt5C+anyzur
    xRxqjo2YlbJpkbLtJfh3tio8Vw1X4VMa7Q/BEm3quwxbg2Mt1IbwYOJhVfV+bjSxaxuNqw
    Z9WTROtWkq/gxmF7OGIOcKnkDVOiSMYI7yAwkjOFJvzGqkK4VsJJEdIw89xpz39LDTAKnR
    D/1MW8lIqw+Tw47z6Z1dy1q3aRmclnvSj8mZ/S2W5WHprDcMBXt5vkBBmyyR2uTEmlfhgN
    /9p25W5wlwyrRZwrbiQoXXyTJcK66yp6mCcgyZnMUxsyhHEuaXxN+6dWDoojCUw5i5EM3S
    CSWoXeam3rydYUAbhPgB/qYhB7YbRzEyDaYue7+ROqZ0g8HuEBsCy/jqB4qGjfXlkzrEJt
    BD9rN8il3ulOjy9oSwhvomtPaEMzT3DZ5o075tMAhOBZRJmRBcQoH4c7KXbhiuMerE2wgX
    eSPviL18pHUK7/M/mvmBrgkMJPwUi/UraqageBJ7L3SJep6hPeUykZ3EXsFw
X-ME-Proxy: <xmx:DBNVap-yUhFRI3GY-f0hINUiQDYxdT8yMa8up0rYkkj3fE9AlCbYGw>
    <xmx:DBNVagFU1EIHxdnNB-EwqO1fyV0dt7WFZ3_grIqCpowx966aa2GngQ>
    <xmx:DBNVaoflV0_VXGYAV9XBf8xTv8TLV1LUgzckvmPnY3_lIhXEdgfMWg>
    <xmx:DBNVavIWlmU-Em9Uflbr3BetO8FaVtw8-Qxcp5x6sLaWppodvhnMDA>
    <xmx:DBNVahpEobbyVz5NrCvkSki_p362I_vspPvZgl4OsK-IW5KwWY57aAo1>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 12:32:11 -0400 (EDT)
Date: Mon, 13 Jul 2026 17:32:10 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 	Suren Baghdasaryan <surenb@google.com>,
 "Liam R. Howlett" <liam@infradead.org>,
 	Vlastimil Babka <vbabka@kernel.org>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 	David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Michal Hocko <mhocko@suse.com>, 	Uladzislau Rezki <urezki@gmail.com>,
 Toshi Kani <toshi.kani@hpe.com>,
 	Dave Hansen <dave.hansen@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>,
 	Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@kernel.org>, 	Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 	"H. Peter Anvin" <hpa@zytor.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 	Will Deacon <will@kernel.org>, Dev Jain <dev.jain@arm.com>,
 Ryan Roberts <ryan.roberts@arm.com>, 	David Carlier <devnexen@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 	bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org,
 	syzbot+fd95a72470f5a44e464c@syzkaller.appspotmail.com
Subject: Re: [PATCH mm-hotfixes v2 0/4] mm: fix UAF caused by race between
 ptdump and vmap pgtable freeing
Message-ID: <alUNiWcygLd4rqBo@thinkstation>
References: <20260712-series-vmap-race-fix-v2-0-ad134cc3a12a@kernel.org>
 <alTn7NguEW_4bodu@thinkstation>
 <alTq4V50767L-s5H@lucifer>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alTq4V50767L-s5H@lucifer>

On Mon, Jul 13, 2026 at 04:54:27PM +0100, Lorenzo Stoakes (ARM) wrote:
> On Mon, Jul 13, 2026 at 02:32:09PM +0100, Kiryl Shutsemau wrote:
> > On Sun, Jul 12, 2026 at 11:42:23AM +0100, Lorenzo Stoakes wrote:
> > > This series addresses the issue by having the vmap huge promotion
> > > logic acquire the mmap read lock while both setting the huge page
> > > table entry and freeing the prior leaf page table.
> >
> > Hi Lorenzo,
> >
> > Before we settle on the mmap lock scheme, have you considered handling
> > this the way GUP-fast handles page table freeing -- RCU-defer the free
> > and make ptdump a lockless walker?
> 
> Overall I like the idea of eventually moving this to _all_ being
> RCU-free-able :)
> 
> BUT... I don't like it as a fix for this bug that has to be backported.
> 
> I think there's a lot of subtleties to worry about and I don't want to
> worry about having to maintain tht as a backport.
> 
> But also, we have an unfortunate situation with ptdump where it also walks
> userland ranges on x86 (and ranges for efi_mm on both x86 and arm64).
> 
> And for userland ranges you have to have the mmap write lock to exclude a
> downgraded mmap read lock munmap() operation (which gives rise to the weird
> inversion you mention).
> 
> So the walker still has to take the write lock in this case.

I think the userland side is fixable too.

My first thought was to walk only VMA-backed ranges, which would make
the mmap read lock sufficient: munmap() detaches VMAs under the write
lock before downgrading, and free_pgtables() only frees tables
exclusively covering the detached range.

But that is an unnecessary limitation on MMU_GATHER_RCU_TABLE_FREE
architectures -- which is every architecture with generic ptdump
support. There, user page table freeing is already RCU-deferred; it is
what GUP-fast relies on to walk user page tables blindly with no mmap
lock. khugepaged retracting PTE tables under the pmd lock is likewise
covered by pte_free_defer().

So the downgraded munmap() teardown you mention is already safe to race
with -- for a walker inside an RCU read-side section. The write lock is
only needed today because ptdump walks outside of one, so the deferred
freeing does nothing for it.

That would make the end state: the whole of ptdump -- userland, efi_mm
and kernel ranges -- walks under RCU with no mmap lock taken at all,
and the kernel-side freeing conversion we discussed is the only
missing piece.

> I spoke a bit about it overall at [0].

I think you forgot to paste [0] :)

> We already have this mmap lock convention as a requirement for kernel
> ranges, and it was being violated by CPA and vmalloc.
> 
> So I'd prefer we keep this as the proximate fix to solve the bug here, and
> then revisit this later (alongside moving to RCU page table freeing
> _overall_, though one doesn't have to block the other).

No argument, let's do it as a follow-up.

I will give the current patchset a proper review.

> > The free side looks cheap: kernel page table freeing already funnels
> > through pagetable_free_kernel(), which already has a deferred path
> > (used for IOMMU SVA). Adding a grace period there -- synchronize_rcu()
> > in the worker, amortized over the batch -- covers every freeing site
> > by construction.
> 
> Well I did want to say btw that CPA doesn't actually mark the page tables
> as kernel, was going to chase up with something on that when I got a chance
> :)

You are right. CPA allocates the split tables with bare
pagetable_alloc(), so ptdesc_test_kernel() is false and collapse frees
them via __pagetable_free() directly. Note this also means they skip
the IOMMU SVA KVA invalidation that ASYNC_KERNEL_PGTABLE_FREE is there
for -- that looks like a bug today, independent of ptdump.

> 
> synchronize_rcu() is a very bug hammer, you can just use call_rcu() (and
> the ptdesc already has an rcu_head I think).

Sure, call_rcu().

> Keeping in mind that vmap can (in theory) span PUDs and even P4Ds it
> becomes a bit tricky.

Since the walker only reads, I think it is enough to re-descend from
the pgd with fresh READ_ONCE() at each level after dropping RCU --
whatever level got promoted in the meantime, we see either the new leaf
or the old table. But agreed this is the part that needs the most care.

> 
> But also I worry about whether the entries in the page table will actually
> be valid at the point the walker reads them.
> 
> For vmap/CPA pretty much yes they are, but if something was to actually
> unmap them in future then that might no longer be the case. RCU will only
> guarantee that the page tables stick around, not that they contain anything
> valid.

For a walker that only reads, I don't think staleness is a problem as
long as frees are RCU-deferred: the walker can only reach a table via
an entry it read within its RCU section, and freeing requires unlinking
that entry first, so the grace period covers any walker that saw the
old pointer. Stale leaf contents are harmless for a dumper. It does
become a problem for anything that dereferences through leaf entries --
agreed that the general case needs more care than ptdump does.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
