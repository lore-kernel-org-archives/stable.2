Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202DF360EF2;
	Tue, 14 Jul 2026 16:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784046052; cv=none; b=Q175IGYfdFVkDXIYmE4f2DCQlmwzJm+oR2adCfRni3+AdPqKejp2Lw8ZLPhqGAjJoWAjg0mDQqbO4JZP1VSYPLxCLsmy4QcjZO1ypxWl74qx2KDGM5G5FnGk5lqqou0DkHtjI2wkbozDRXc4gGzb1b17o2jhr8f+MVE5vbMEMPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784046052; c=relaxed/simple;
	bh=SUyUQrgy2yWNm9tM/EcU7HxX1xhhYMI4KEsnz3S2+8k=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=lGrqnHIlvm8KtUlEOuhP1lhJr+AFLTTBCe5WkhR3UM0VmUOd9FIiewRsEYm+DiP4jWbbG9LFbd0eb3RB0kJiA77oifhl4doE6vCdC1RPEtN28lBafMRDhRzzMzG6RU+IYqMRWBnOOZG7t1MD/Lp0jsDTs6IJc8AObM01zwZk2pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kuHZfKis; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kuHZfKis"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2568A1F000E9;
	Tue, 14 Jul 2026 16:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784046051;
	bh=3bS/S6koA4Jxx17fNiWxR1Ope7iKRUf0fhgm/1SQfJs=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=kuHZfKisQYi6/6IIe03EHfuYkzdWZ9lBBSqYr+XNliC0MCr3Z/SWkFbj0E4KSs0wi
	 lXn4uHkQMT+ygO//Qn5855VedTDtQk1Mr7f09vHeKfF6ibnOxhlg2mJ62peFap3Tme
	 5uc0BjOF/wJMI4A/1LyhtgxipaJGcf7HEU2XRzF3IAhQPGudLQC/Lk+YB8qkhOusRA
	 PUCAOLq68H7TwyJqtxUPl2OARAXiA85uta2tWvZOe63a5I02/lDkqFFPKliCZzG77o
	 4sXyMHNP4Tl0F7Wxa6a4X9kncQbPZgvmv678KAfJwjC0HE3VU1P+UxRujIJRSjt50R
	 cqchA+BNxzskw==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH mm-hotfixes v2 0/4] mm: fix UAF caused by race between
 ptdump and vmap pgtable freeing
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Kiryl Shutsemau <kas@kernel.org>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Suren Baghdasaryan <surenb@google.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Shakeel Butt <shakeel.butt@linux.dev>, David Hildenbrand <david@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
 Uladzislau Rezki <urezki@gmail.com>, Toshi Kani <toshi.kani@hpe.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Dev Jain <dev.jain@arm.com>, 
 Ryan Roberts <ryan.roberts@arm.com>, David Carlier <devnexen@gmail.com>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org, 
 syzbot+fd95a72470f5a44e464c@syzkaller.appspotmail.com
In-Reply-To: <alUNiWcygLd4rqBo@thinkstation>
References: <20260712-series-vmap-race-fix-v2-0-ad134cc3a12a@kernel.org>
 <alTn7NguEW_4bodu@thinkstation> <alTq4V50767L-s5H@lucifer>
 <alUNiWcygLd4rqBo@thinkstation>
Date: Tue, 14 Jul 2026 17:20:29 +0100
Message-Id: <178404602957.85099.8935151447302412515.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9287; i=ljs@kernel.org;
 h=from:subject:message-id; bh=SUyUQrgy2yWNm9tM/EcU7HxX1xhhYMI4KEsnz3S2+8k=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLLCEs8bbplyYPOEPyuivvDqeljNOh6xKGPvhdjyI8UTw
 yJ/lenO7ChlYRDjYpAVU2R5/kV8f5BI2LzOC/5uMHNYmUCGMHBxCsBErG4wMjzfdl1jirdrws6j
 bPFbbik1SiufPOLLwqFnwDv/YletbB0jQ9MC6+/ds5N2KLCmhNbqzBGZJ9u4wCFGLGX9I2t95l1
 7OQE=
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

On 2026-07-13 17:32 +0100, Kiryl Shutsemau wrote:
> On Mon, Jul 13, 2026 at 04:54:27PM +0100, Lorenzo Stoakes (ARM) wrote:
> > On Mon, Jul 13, 2026 at 02:32:09PM +0100, Kiryl Shutsemau wrote:
> > > On Sun, Jul 12, 2026 at 11:42:23AM +0100, Lorenzo Stoakes wrote:
> > > > This series addresses the issue by having the vmap huge promotion
> > > > logic acquire the mmap read lock while both setting the huge page
> > > > table entry and freeing the prior leaf page table.
> > >
> > > Hi Lorenzo,
> > >
> > > Before we settle on the mmap lock scheme, have you considered handling
> > > this the way GUP-fast handles page table freeing -- RCU-defer the free
> > > and make ptdump a lockless walker?
> >
> > Overall I like the idea of eventually moving this to _all_ being
> > RCU-free-able :)
> >
> > BUT... I don't like it as a fix for this bug that has to be backported.
> >
> > I think there's a lot of subtleties to worry about and I don't want to
> > worry about having to maintain tht as a backport.
> >
> > But also, we have an unfortunate situation with ptdump where it also walks
> > userland ranges on x86 (and ranges for efi_mm on both x86 and arm64).
> >
> > And for userland ranges you have to have the mmap write lock to exclude a
> > downgraded mmap read lock munmap() operation (which gives rise to the weird
> > inversion you mention).
> >
> > So the walker still has to take the write lock in this case.
>
> I think the userland side is fixable too.
>
> My first thought was to walk only VMA-backed ranges, which would make
> the mmap read lock sufficient: munmap() detaches VMAs under the write
> lock before downgrading, and free_pgtables() only frees tables
> exclusively covering the detached range.

Right, but some architectures have non-VMA ranges in userland (yuck), and
ptdump is the only case where we really do this. It sucks really.

I'm not sure if it's ok to just stop outputting this information.

But as you say, we don't actually have to worry about this if we're RCU
freeing.

>
> But that is an unnecessary limitation on MMU_GATHER_RCU_TABLE_FREE
> architectures -- which is every architecture with generic ptdump
> support. There, user page table freeing is already RCU-deferred; it is

The arches are powerpc, s390, arm64, x86 and riscv and indeed all set
MMU_GATHER_RCU_TABLE_FREE.

But it's more complicated than that unfortunately. As per mmu_gather.c -
'Semi RCU freeing of the page directories'.

And MMU_GATHER_RCU_TABLE_FREE != RCU page table freeing.

You can see the complexity in Qi's commit 718b13861d22 ("x86: mm: free page
table pages by RCU instead of semi RCU").

Basically you need the IRQs disabled to get the semi-RCU behaviour and to
be able to safely traverse page tables that way.

So with CONFIG_PT_RECLAIM you're safe to RCU traverse PTEs only.

Looking at the Kconfig entry:

config PT_RECLAIM
	def_bool y
	depends on MMU_GATHER_RCU_TABLE_FREE && !HAVE_ARCH_TLB_REMOVE_TABLE

And indeed, we fall back to just freeing PTE page tables immediately
(relying on IPI sync) if it's not set:

#ifdef CONFIG_PT_RECLAIM
static inline void __tlb_remove_table_one_rcu(struct rcu_head *head)
{
	struct ptdesc *ptdesc;

	ptdesc = container_of(head, struct ptdesc, pt_rcu_head);
	__tlb_remove_table(ptdesc);
}

static inline void __tlb_remove_table_one(void *table)
{
	struct ptdesc *ptdesc;

	ptdesc = table;
	call_rcu(&ptdesc->pt_rcu_head, __tlb_remove_table_one_rcu);
}
#else
static inline void __tlb_remove_table_one(void *table)
{
	tlb_remove_table_sync_rcu();
	__tlb_remove_table(table);
}
#endif /* CONFIG_PT_RECLAIM */

HAVE_ARCH_TLB_REMOVE_TABLE is set for powerpc, which also enables PTDUMP :)
and that's because it actually tracks multiple PTE page tables together as
a fragment.

So in general - it's unfortunately not so easy, and we can't just rely on
RCU.

Obviously the above is moreso about userland mappings, but it suggests that
_just_ removing page tables under RCU isn't sufficient here.

You'd also need a lockless ptdump walker to carefully handle the weird edge
cases as per pmdp_get_lockless() and ptep_get_lockless(), which the kernel
page table wlakers not currently using.

In the case of kernel page tables we can just always RCU defer page table
freeing (having audited all callers to make sure nobody's freeing them in a
broken way).

But I wonder how the PPC fragment page tables stuff would interact with
that, it's something that'd need to be audited.


> what GUP-fast relies on to walk user page tables blindly with no mmap
> lock. khugepaged retracting PTE tables under the pmd lock is likewise
> covered by pte_free_defer().

See above.

>
> So the downgraded munmap() teardown you mention is already safe to race
> with -- for a walker inside an RCU read-side section. The write lock is
> only needed today because ptdump walks outside of one, so the deferred
> freeing does nothing for it.

Yup.

>
> That would make the end state: the whole of ptdump -- userland, efi_mm
> and kernel ranges -- walks under RCU with no mmap lock taken at all,
> and the kernel-side freeing conversion we discussed is the only
> missing piece.

Yes the ideal situation is that we don't have to worry about an mmap or VMA
lock at all and can stabilise on RCU only.

Well only for ptdump.



>
> > I spoke a bit about it overall at [0].
>
> I think you forgot to paste [0] :)

Yeah sorry! It's kinda immaterial now anyway :P as we're discussing in
detail here.


>
> > We already have this mmap lock convention as a requirement for kernel
> > ranges, and it was being violated by CPA and vmalloc.
> >
> > So I'd prefer we keep this as the proximate fix to solve the bug here, and
> > then revisit this later (alongside moving to RCU page table freeing
> > _overall_, though one doesn't have to block the other).
>
> No argument, let's do it as a follow-up.
>
> I will give the current patchset a proper review.

Thanks!

>
> > > The free side looks cheap: kernel page table freeing already funnels
> > > through pagetable_free_kernel(), which already has a deferred path
> > > (used for IOMMU SVA). Adding a grace period there -- synchronize_rcu()
> > > in the worker, amortized over the batch -- covers every freeing site
> > > by construction.
> >
> > Well I did want to say btw that CPA doesn't actually mark the page tables
> > as kernel, was going to chase up with something on that when I got a chance
> > :)
>
> You are right. CPA allocates the split tables with bare
> pagetable_alloc(), so ptdesc_test_kernel() is false and collapse frees
> them via __pagetable_free() directly. Note this also means they skip
> the IOMMU SVA KVA invalidation that ASYNC_KERNEL_PGTABLE_FREE is there
> for -- that looks like a bug today, independent of ptdump.

Yeah it is, I'll send a patch.

>
> >
> > synchronize_rcu() is a very bug hammer, you can just use call_rcu() (and
> > the ptdesc already has an rcu_head I think).
>
> Sure, call_rcu().
>
> > Keeping in mind that vmap can (in theory) span PUDs and even P4Ds it
> > becomes a bit tricky.
>
> Since the walker only reads, I think it is enough to re-descend from
> the pgd with fresh READ_ONCE() at each level after dropping RCU --
> whatever level got promoted in the meantime, we see either the new leaf
> or the old table. But agreed this is the part that needs the most care.

There could be torn writes observed that would need careful revalidation
checks though couldn't there potentially?

See e.g. contpte_ptep_get_lockless() and pmdp_get_lockless() if
CONFIG_GUP_GET_PXX_LOW_HIGH.

And things are complicated in kernel code obviously by the fact you have no
PTL guarantees anymore.

And OK maybe we can prove the huge promotion case is OK, this assumes that
we won't in future free kernel page tables under some other
circumstances... :)

I'm not saying it's not doable though, just that we have to be _very
careful_ how we do it if we're going to try to do this under RCU!

>
> >
> > But also I worry about whether the entries in the page table will actually
> > be valid at the point the walker reads them.
> >
> > For vmap/CPA pretty much yes they are, but if something was to actually
> > unmap them in future then that might no longer be the case. RCU will only
> > guarantee that the page tables stick around, not that they contain anything
> > valid.
>
> For a walker that only reads, I don't think staleness is a problem as
> long as frees are RCU-deferred: the walker can only reach a table via
> an entry it read within its RCU section, and freeing requires unlinking
> that entry first, so the grace period covers any walker that saw the
> old pointer. Stale leaf contents are harmless for a dumper. It does
> become a problem for anything that dereferences through leaf entries --
> agreed that the general case needs more care than ptdump does.

Well I wonder about torn writes actually, you'd need to be careful about
revalidating in the walk.

>
> --
>   Kiryl Shutsemau / Kirill A. Shutemov
>

In general Ithink all the problems are ultimately solveable, they're just
fiddly :)

Cheers, Lorenzo

