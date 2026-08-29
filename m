Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289D21643B;
	Sat, 29 Aug 2026 01:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787968520; cv=none; b=X/vsK9/IpSYLApYwBrPxbpAHC78+RvModS0SG+RIho86qvQzGaQf3T4cm1/+lMZQRK7KtY4aPaY8/8f/VsZ5WETXOUz4+PJ99sfvaPKxeuZYp3LYwK3sLya2Rt8VKg9CSYzovjw97qOu7EeWNRnm0w7tcgfgVC6csCHjH4PcqrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787968520; c=relaxed/simple;
	bh=Tx6peCwq6LWddKFCzINod9VezXpbPUn4luF4f3Yzd7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QLOXevf+AsYJ+lb8jiemZk0y6Imm1VphJKnS+nwQI2R1oIT7abF5h/45agVrjYHDtPdCuJeZxX0OYKz1SqjXNNEBNK54V2UbAV/i4FbcO1h3ArdO9bJuVTMFHQOipU8ByNS8EPlWTsTIKDZSBOAgxLL3ZmdpserdkUN9u3kN1g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZGB1bkQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZGB1bkQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 681B81F000E9;
	Sat, 29 Aug 2026 01:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787968518;
	bh=bqsrIgE1vMZSFVutAeptIWgwiGFQSyUVPvdWjryJwx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PZGB1bkQAPezLN4UngIrermFUA4t75K1Hc/7NB6Lwhne5lHDBNfm+pH5K3af4KccM
	 +KYUewu/UttfS5UY5I6E5fttCivXAMb7FtQRzfU0Ao9rMn274VuC9gu32Ob255Tlez
	 noEj3NKap7EgNwqR+iNLoZVhwBDsxsPhtgolQr/ApvnLl/O1U/H16nPAf43WwOjTE8
	 ymVzs3dIDX83CIlUO7Kvzo44tBFK1pvsqPvrPWN+SByW7tEwBVkHvsEeCjQOKZaYZ9
	 KKLQ3y3OWsi7Pw1k9HDgyfwb1l8tEvg8HtYnY7fRgGxF4PIiYJ+C8K/PXCnMfvx2a0
	 qTHCTCc1pTIAg==
From: SJ Park <sj@kernel.org>
To: Nathan Gao <zcgao@amazon.com>
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	baolin.wang@linux.alibaba.com,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/damon: use a page-aligned sampling address
Date: Fri, 28 Aug 2026 18:55:11 -0700
Message-ID: <20260829015511.74221-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260829010455.28607-1-zcgao@amazon.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 28 Aug 2026 18:04:55 -0700 Nathan Gao <zcgao@amazon.com> wrote:

> Hi SJ,
> 
> Thanks for your review!
> 
> On Thu, 27 Aug 2026 17:22:11 -0700 SJ Park <sj@kernel.org> wrote:
> 
> > Hello Nathan,
> > 
> > On Thu, 27 Aug 2026 12:38:21 -0700 Nathan Gao <zcgao@amazon.com> wrote:
> > 
> > > __damon_va_prepare_access_check() picks a random byte address within the
> > > region and stores it in r->sampling_addr. There are two users of
> > > r->sampling_addr in vaddr.c that pass it into a page table walk, and
> > > both use it as the address of a page.
> > > 
> > >   damon_va_mkold(mm, r->sampling_addr)
> > >     damon_va_walk_page_range(mm, addr, addr + 1)
> > >       damon_mkold_pmd_entry()
> > >         damon_ptep_mkold(pte, vma, addr)
> > >           ptep_test_and_clear_young(vma, addr, pte)
> > >           mmu_notifier_clear_young(mm, addr, addr + PAGE_SIZE)
> > > 
> > >   damon_va_young(mm, r->sampling_addr, &folio_sz)
> > >     damon_va_walk_page_range(mm, addr, addr + 1)
> > >       damon_young_pmd_entry()
> > >         ptep_get(pte)
> > >         mmu_notifier_test_young(walk->mm, addr)
> > > 
> > > test_and_clear_young_ptes(), which backs ptep_test_and_clear_young() on
> > > arm64, documents @addr as "Address the first page is mapped at".
> > > 
> > > For arm64, before commit 6f0e1142173a ("arm64: mm: support batch
> > > clearing of the young flag for large folios"),
> > 
> > The @addr documentation is also introduced by this commit.  This commit is
> > authored at 2026-02-09.

I was wrong.  The documentation was introduced by commit 6d7237dda44f ("mm: add
a batched helper to clear the young flag for large folios"), which was authored
by Baolin on 2026-03-06.

> > 
> > > the contpte helper walked
> > > exactly CONT_PTES entries from the aligned-down page table pointer and
> > > used @addr only to pass down to each entry, so an unaligned value was
> > > harmless:
> > > 
> > >         ptep = contpte_align_down(ptep);
> > >         addr = ALIGN_DOWN(addr, CONT_PTE_SIZE);
> > >         for (i = 0; i < CONT_PTES; i++, ptep++, addr += PAGE_SIZE)
> > 
> > So, there was no issue before the commit.
> > 
> 
> Right. Before 6f0e1142173a, unaligned addresses were tolerated but I don't
> think this is guaranteed.
> 
> > > 
> > > Align the sampled address down to a page boundary. It is the address of
> > > the page to sample, so this matches its intended meaning and fixes both
> > > users in vaddr.c.
> > 
> > This indeed sounds like can fix the issue to me.  However, was it a clear rule
> > that we should pass only contepte-aligned addrss to
> > ptep_test_and_clear_young()?  And is DAMON the only ptep_test_and_clear_young()
> > caller that is mistakenly passing the unaligned address?
> > 
> 
> It is not spelled out as an explicit rule, but the documented "Address
> the first page is mapped at" implies it,

You mean the comment on test_and_clear_young_ptes(), right?  But as I mentioned
above, the comment was introduced by Baolin's patch that was authored on
2026-03-06.  I'd still appreciate Baolin's opinion.

> and these callers are using
> aligned addresses:
> 
>  mm/page_idle.c: page_idle_clear_pte_refs_one()
>  fs/proc/task_mmu.c: clear_refs_pte_range()
> 
> > If not, it might make sense to make contpte_test_and_clear_young_ptes() support
> > unaligned adress again in my opinion.  May I ask your opinion, Baolin?
> > 
> > > 
> > > Fixes: 3f49584b262c ("mm/damon: implement primitives for the virtual memory address spaces")
> > 
> > I think 6f0e1142173a ("arm64: mm: support batch clearing of the young flag for
> > large folios") would be mroe correct 'Fixes:', if there was no issue before the
> > commit.
> > 
> 
> Will use that in v2.
> 
> > > -	r->sampling_addr = damon_rand(ctx, r->ar.start, r->ar.end);
> > > +	r->sampling_addr = PAGE_ALIGN_DOWN(damon_rand(ctx, r->ar.start,
> > > +						      r->ar.end));
> > 
> > If we need to have the fix in DAMON, this kind of change would be needed.
> > 
> > However, what happens if the address is backed by large folios?
> > 
> > Before the commit 6f0e1142173a, also, it was aligning to CONT_PTE_SIZE.  Should
> > we do same?
> 
> Passing a page-aligned address restores the pre-6f0e1142173a behavior.
> Before the change, the helper aligned ptep down to the block start and
> walked a fixed CONT_PTES entries, regardless of addr.  After the
> change, the walk covers [ALIGN_DOWN(addr, CONT_PTE_SIZE),
> ALIGN(addr + nr * PAGE_SIZE, CONT_PTE_SIZE)).  With a sub-page offset,
> addr + PAGE_SIZE lands just past the block boundary, so the round-up
> extends the walk a whole block further.  With a page-aligned addr,
> addr + PAGE_SIZE is at most the block end, so the round-up lands
> exactly on the block end and the walk covers the same CONT_PTES
> entries as before the commit.
> 
> We also can't align to CONT_PTE_SIZE in DAMON since it's defined only under
> arch/arm64/:
> 
>   #define CONT_PTES		(1 << (CONT_PTE_SHIFT - PAGE_SHIFT))
>   #define CONT_PTE_SIZE		(CONT_PTES * PAGE_SIZE)

DAMON cares only exactly the byte of the address, so I agree this would work
for DAMON and be safe.  But, still the behavior is not exactly same to
pre-6f0e1142173a, isn't it?  I'm not really sure if this is really the correct
use of the function.  Again, I'd appreciate Baolin's comment.

> 
> 
> > Also, I think we should pass aligned address to only the functions that
> > require alignement.  Making the alignment to the sampling address in general
> > sounds too much to me.  Particularly, we are working on supporting new page
> > access check primitives other than PTE Accessed bit, like AMd IBS.  In the
> > case, we might support <PAGE_SIZE granularity monitoring.  Aligning sampling
> > address in general will make it more complicated.
> 
> Makes sense. I will keep sampling_addr as is and align inside damon_va_mkold()
> and damon_va_young() in v2.

Regardless of Baolin's comment, let's fix this issue.  So the v2 would be
appreciated.  In the v2, could you also add more details about how the issue
can be reproduced, and the user impact?  You mentioned you found memory
corruption from DAMON selftets.  It would be nice if you could make it more
detailed, such as what selftest reproduces the issue and what symptoms it
showed you.

Nevertheless I'm also wondering if supporting unaligned address again, like
below also works.

'''
--- a/arch/arm64/mm/contpte.c
+++ b/arch/arm64/mm/contpte.c
@@ -519,9 +519,12 @@ bool contpte_test_and_clear_young_ptes(struct vm_area_struct *vma,
         * of the same large folio in a single VMA and a single page table.
         */

-       unsigned long end = addr + nr * PAGE_SIZE;
+       unsigned long end;
        bool young = false;

+       ptep = contpte_align_down(ptep);
+       addr = ALIGN_DOWN(addr, CONT_PTE_SIZE);
+       end = addr + nr * PAGE_SIZE;
        ptep = contpte_align_addr_ptep(&addr, &end, ptep, nr);
        for (; addr != end; ptep++, addr += PAGE_SIZE)
                young |= __ptep_test_and_clear_young(vma, addr, ptep);
'''

Nathan, what do you think?  If it makes sense to you, could you also test this?


Thanks,
SJ

[...]
