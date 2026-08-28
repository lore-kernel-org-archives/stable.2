Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8741B2AE7A;
	Fri, 28 Aug 2026 00:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787876540; cv=none; b=A0pzIuA3MtGDG7YBJ1EYIOiEZt6FGJXd6VKwb4rxN1itL6EqfT7RSCKDqHzKKARL8aWt638tuUhupASk2hEJEfYi/ZtkFpi/Pt7kOkHI+IpkeNSd8WnWJOOvGHuNiViluLbH6cOPZN/HXpo+kW4NQIvhUrvDIkEBWwNeBKRCYfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787876540; c=relaxed/simple;
	bh=GsCY0/mgkP6ZiqiIqH+Jk2bSk3UtTuADAya67mpycIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TQFxDALB3Fb5hTmdf74LGap0GDTZOC4SMCgiINukr4S8yhLdXcA0LOe8APINDmdTcwDJ1UwWejvG/YQMB1u26p365ZXxefQn9OFNp0uvEQoyJFozkrgkcENR5/mCKrCEvorcctnGJ6iIVvnO2gxkFPZdRmS5x6PfnhKKqtMcdmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Esu5YeSZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Esu5YeSZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B511F000E9;
	Fri, 28 Aug 2026 00:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787876539;
	bh=uuq5TYRcr4zdL+6SIrH3ElNXfBDv1DRk+u7g+8PVaIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Esu5YeSZSNMWD9tBCB8DahS8k8M9uqUSF5bWl3RuhQKyrW/PTxWvALeZxk/QiIJA7
	 dZcm28dZW0IuSJKS3UniMrmUvEkrZtD06Fz+uw6dnV0Wb9OOssMzvRLwi3ehtI4PL+
	 KSEe+MxE40XZnFyBcb3dlPQvBv35/2kTqJUUy4imkkpf/UGnkkPlNvZ3DrK4AjtWjl
	 Nmg7vjm4DOG5somXIcNo2QbAYYbQX3a1ZdYHOPBiBBpH6H6CjJcTbKmGH95CKe0CwC
	 ZMHnKr/ONgrLy1woPLtV/lCmbnF2jTy11iDBMHDOHrO5ioIGtdNXiGrh7vResI7Rag
	 LdmKd3XSZI6HA==
From: SJ Park <sj@kernel.org>
To: Nathan Gao <zcgao@amazon.com>
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	baolin.wang@linux.alibaba.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/damon: use a page-aligned sampling address
Date: Thu, 27 Aug 2026 17:22:11 -0700
Message-ID: <20260828002211.61987-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260827193821.46115-1-zcgao@amazon.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Nathan,

On Thu, 27 Aug 2026 12:38:21 -0700 Nathan Gao <zcgao@amazon.com> wrote:

> __damon_va_prepare_access_check() picks a random byte address within the
> region and stores it in r->sampling_addr. There are two users of
> r->sampling_addr in vaddr.c that pass it into a page table walk, and
> both use it as the address of a page.
> 
>   damon_va_mkold(mm, r->sampling_addr)
>     damon_va_walk_page_range(mm, addr, addr + 1)
>       damon_mkold_pmd_entry()
>         damon_ptep_mkold(pte, vma, addr)
>           ptep_test_and_clear_young(vma, addr, pte)
>           mmu_notifier_clear_young(mm, addr, addr + PAGE_SIZE)
> 
>   damon_va_young(mm, r->sampling_addr, &folio_sz)
>     damon_va_walk_page_range(mm, addr, addr + 1)
>       damon_young_pmd_entry()
>         ptep_get(pte)
>         mmu_notifier_test_young(walk->mm, addr)
> 
> test_and_clear_young_ptes(), which backs ptep_test_and_clear_young() on
> arm64, documents @addr as "Address the first page is mapped at".
> 
> For arm64, before commit 6f0e1142173a ("arm64: mm: support batch
> clearing of the young flag for large folios"),

The @addr documentation is also introduced by this commit.  This commit is
authored at 2026-02-09.

> the contpte helper walked
> exactly CONT_PTES entries from the aligned-down page table pointer and
> used @addr only to pass down to each entry, so an unaligned value was
> harmless:
> 
>         ptep = contpte_align_down(ptep);
>         addr = ALIGN_DOWN(addr, CONT_PTE_SIZE);
>         for (i = 0; i < CONT_PTES; i++, ptep++, addr += PAGE_SIZE)

So, there was no issue before the commit.

> 
> Now the range to walk is derived from @addr instead: end = addr +
> nr * PAGE_SIZE, rounded up to CONT_PTE_SIZE. For a sample in the last
> page of a contpte block, the sub-page offset puts end just past the
> block boundary, so the round-up lands a whole block further and the
> walk clears PTE_AF in CONT_PTES entries beyond the sampled block. Seen
> on an arm64 guest running the DAMON selftests as random slab and page
> table corruption.

Thank you for sharing the finding with us!

> 
> Align the sampled address down to a page boundary. It is the address of
> the page to sample, so this matches its intended meaning and fixes both
> users in vaddr.c.

This indeed sounds like can fix the issue to me.  However, was it a clear rule
that we should pass only contepte-aligned addrss to
ptep_test_and_clear_young()?  And is DAMON the only ptep_test_and_clear_young()
caller that is mistakenly passing the unaligned address?

If not, it might make sense to make contpte_test_and_clear_young_ptes() support
unaligned adress again in my opinion.  May I ask your opinion, Baolin?

> 
> Fixes: 3f49584b262c ("mm/damon: implement primitives for the virtual memory address spaces")

I think 6f0e1142173a ("arm64: mm: support batch clearing of the young flag for
large folios") would be mroe correct 'Fixes:', if there was no issue before the
commit.

> Cc: s6f0e1142173a ("arm64: mm: support batch
> clearing of the young flag for large folios"),table@vger.kernel.org
> Signed-off-by: Nathan Gao <zcgao@amazon.com>
> ---
>  mm/damon/vaddr.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index 2c1c1952c008d..e26e426a56af2 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -360,7 +360,8 @@ static void __damon_va_prepare_access_check(struct mm_struct *mm,
>  					struct damon_region *r,
>  					struct damon_ctx *ctx)
>  {
> -	r->sampling_addr = damon_rand(ctx, r->ar.start, r->ar.end);
> +	r->sampling_addr = PAGE_ALIGN_DOWN(damon_rand(ctx, r->ar.start,
> +						      r->ar.end));

If we need to have the fix in DAMON, this kind of change would be needed.

However, what happens if the address is backed by large folios?

Before the commit 6f0e1142173a, also, it was aligning to CONT_PTE_SIZE.  Should
we do same?

Also, I think we should pass aligned address to only the functions that
require alignement.  Making the alignment to the sampling address in general
sounds too much to me.  Particularly, we are working on supporting new page
access check primitives other than PTE Accessed bit, like AMd IBS.  In the
case, we might support <PAGE_SIZE granularity monitoring.  Aligning sampling
address in general will make it more complicated.

>  
>  	damon_va_mkold(mm, r->sampling_addr);
>  }
> -- 
> 2.50.1


Thanks,
SJ
