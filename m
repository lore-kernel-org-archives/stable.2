Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B713AB47A;
	Mon, 31 Aug 2026 22:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.245.243.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788216649; cv=none; b=GniHaK4x8lFm2lA2qWFVvIU09dtLGn/fZO9SSq6w54Hj21SykbYw5y7xqkzNoQsmsOqQhC/wHAIoKGZFLVcQsiIXtznu/DD4sYyfNJzV7glAWhravGiDpRs5dOa4suMCw/y+s8t0Cotluf/U3VBM2z2yvrYhjBMpVkBbBaYtXRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788216649; c=relaxed/simple;
	bh=gl2v/1L+wcPN6rQpNNQTnjg23DaQiqz2K074ashyohI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WeFkkUnTh3TmZV5OmsyCiahQ4Wc7hmTK9aHdyFZ/jUnOoMhOX/2nC72wMtDJRwWlQkyfALpxMtpLv4qhoqmNlAq/Zyn2LlQSTMPwvj7tTjquXnTvd6aO2/rZO9dNvFqHZf9a/YQR9XmffcRI2vQlTbHurJwBMWp6asuBn3ZXkSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=qCilTKkm; arc=none smtp.client-ip=44.245.243.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="qCilTKkm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1788216646; x=1819752646;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F4AASk5pAsuqCt1k3uv39yeWLbs5DBs7DdYUaOL2uKk=;
  b=qCilTKkmnht7vOyp0bgGWOstnRsQwRGYzlbCJIVEZcbG5H54U8d1sy6x
   7lwO6YQSseNSC/vGq1FIQ2/GYFfpUj/7HY/VSP3bO8uDQfN6DrZIY78bR
   stoNYTFtWhLFmshNbuLqHipnANeHYtzaDtGDmeTDwCtZueS2Cu6tq4a+C
   BvTUAOXZ+lpFwBvZE3l6zYdqLwDoYwz6jCbHBVittuyNrWiuNLa4QDpty
   W9JGyD6MM7ZEaSD0tMaSWWWTD6wqj2zisiONj1uYgcE/knswnnlfrCZxO
   OIXanvSdrK3d9SCq1szspXnaXSFhHX6dBTweg65XnaR6Sm8EefYgY81HK
   w==;
X-CSE-ConnectionGUID: emM68SDdSm+SCPe6EuNcWA==
X-CSE-MsgGUID: yJqCWLVLREuX1wKcmHNf8A==
X-IronPort-AV: E=Sophos;i="6.25,254,1779148800"; 
   d="scan'208";a="26947124"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 22:50:45 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:10815]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.46.234:2525] with esmtp (Farcaster)
 id 8ef9c425-d43b-4df8-8b37-7b1ddf3e28ba; Mon, 31 Aug 2026 22:50:44 +0000 (UTC)
X-Farcaster-Flow-ID: 8ef9c425-d43b-4df8-8b37-7b1ddf3e28ba
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Mon, 31 Aug 2026 22:50:44 +0000
Received: from 6c7e67c92ceb.amazon.com (10.187.171.29) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46;
 Mon, 31 Aug 2026 22:50:44 +0000
From: Nathan Gao <zcgao@amazon.com>
To: <sj@kernel.org>
CC: <akpm@linux-foundation.org>, <baolin.wang@linux.alibaba.com>,
	<damon@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <stable@vger.kernel.org>, <zcgao@amazon.com>
Subject: Re: [PATCH] mm/damon: use a page-aligned sampling address
Date: Mon, 31 Aug 2026 15:50:32 -0700
Message-ID: <20260831225032.58045-1-zcgao@amazon.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260829015511.74221-1-sj@kernel.org>
References: <20260829015511.74221-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWB001.ant.amazon.com (10.13.139.152) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Fri, 28 Aug 2026 18:55:11 -0700 SJ Park <sj@kernel.org> wrote:

> On Fri, 28 Aug 2026 18:04:55 -0700 Nathan Gao <zcgao@amazon.com> wrote:
> 
> > Hi SJ,
> > 
> > Thanks for your review!
> > 
> > On Thu, 27 Aug 2026 17:22:11 -0700 SJ Park <sj@kernel.org> wrote:
> > 
> > > Hello Nathan,
> > > 
> > > On Thu, 27 Aug 2026 12:38:21 -0700 Nathan Gao <zcgao@amazon.com> wrote:
> > > 
> > > > __damon_va_prepare_access_check() picks a random byte address within the
> > > > region and stores it in r->sampling_addr. There are two users of
> > > > r->sampling_addr in vaddr.c that pass it into a page table walk, and
> > > > both use it as the address of a page.
> > > > 
> > > >   damon_va_mkold(mm, r->sampling_addr)
> > > >     damon_va_walk_page_range(mm, addr, addr + 1)
> > > >       damon_mkold_pmd_entry()
> > > >         damon_ptep_mkold(pte, vma, addr)
> > > >           ptep_test_and_clear_young(vma, addr, pte)
> > > >           mmu_notifier_clear_young(mm, addr, addr + PAGE_SIZE)
> > > > 
> > > >   damon_va_young(mm, r->sampling_addr, &folio_sz)
> > > >     damon_va_walk_page_range(mm, addr, addr + 1)
> > > >       damon_young_pmd_entry()
> > > >         ptep_get(pte)
> > > >         mmu_notifier_test_young(walk->mm, addr)
> > > > 
> > > > test_and_clear_young_ptes(), which backs ptep_test_and_clear_young() on
> > > > arm64, documents @addr as "Address the first page is mapped at".
> > > > 
> > > > For arm64, before commit 6f0e1142173a ("arm64: mm: support batch
> > > > clearing of the young flag for large folios"),
> > > 
> > > The @addr documentation is also introduced by this commit.  This commit is
> > > authored at 2026-02-09.
> 
> I was wrong.  The documentation was introduced by commit 6d7237dda44f ("mm: add
> a batched helper to clear the young flag for large folios"), which was authored
> by Baolin on 2026-03-06.
> 
> > > 
> > > > the contpte helper walked
> > > > exactly CONT_PTES entries from the aligned-down page table pointer and
> > > > used @addr only to pass down to each entry, so an unaligned value was
> > > > harmless:
> > > > 
> > > >         ptep = contpte_align_down(ptep);
> > > >         addr = ALIGN_DOWN(addr, CONT_PTE_SIZE);
> > > >         for (i = 0; i < CONT_PTES; i++, ptep++, addr += PAGE_SIZE)
> > > 
> > > So, there was no issue before the commit.
> > > 
> > 
> > Right. Before 6f0e1142173a, unaligned addresses were tolerated but I don't
> > think this is guaranteed.
> > 
> > > > 
> > > > Align the sampled address down to a page boundary. It is the address of
> > > > the page to sample, so this matches its intended meaning and fixes both
> > > > users in vaddr.c.
> > > 
> > > This indeed sounds like can fix the issue to me.  However, was it a clear rule
> > > that we should pass only contepte-aligned addrss to
> > > ptep_test_and_clear_young()?  And is DAMON the only ptep_test_and_clear_young()
> > > caller that is mistakenly passing the unaligned address?
> > > 
> > 
> > It is not spelled out as an explicit rule, but the documented "Address
> > the first page is mapped at" implies it,
> 
> You mean the comment on test_and_clear_young_ptes(), right?  But as I mentioned
> above, the comment was introduced by Baolin's patch that was authored on
> 2026-03-06.  I'd still appreciate Baolin's opinion.
> 

I think you are right. I shouldn't reference this and I dropped it in v2 commit
message. 

> > and these callers are using
> > aligned addresses:
> > 
> >  mm/page_idle.c: page_idle_clear_pte_refs_one()
> >  fs/proc/task_mmu.c: clear_refs_pte_range()
> > 
> > > If not, it might make sense to make contpte_test_and_clear_young_ptes() support
> > > unaligned adress again in my opinion.  May I ask your opinion, Baolin?
> > > 
> > > > 
> > > > Fixes: 3f49584b262c ("mm/damon: implement primitives for the virtual memory address spaces")
> > > 
> > > I think 6f0e1142173a ("arm64: mm: support batch clearing of the young flag for
> > > large folios") would be mroe correct 'Fixes:', if there was no issue before the
> > > commit.
> > > 
> > 
> > Will use that in v2.
> > 
> > > > -	r->sampling_addr = damon_rand(ctx, r->ar.start, r->ar.end);
> > > > +	r->sampling_addr = PAGE_ALIGN_DOWN(damon_rand(ctx, r->ar.start,
> > > > +						      r->ar.end));
> > > 
> > > If we need to have the fix in DAMON, this kind of change would be needed.
> > > 
> > > However, what happens if the address is backed by large folios?
> > > 
> > > Before the commit 6f0e1142173a, also, it was aligning to CONT_PTE_SIZE.  Should
> > > we do same?
> > 
> > Passing a page-aligned address restores the pre-6f0e1142173a behavior.
> > Before the change, the helper aligned ptep down to the block start and
> > walked a fixed CONT_PTES entries, regardless of addr.  After the
> > change, the walk covers [ALIGN_DOWN(addr, CONT_PTE_SIZE),
> > ALIGN(addr + nr * PAGE_SIZE, CONT_PTE_SIZE)).  With a sub-page offset,
> > addr + PAGE_SIZE lands just past the block boundary, so the round-up
> > extends the walk a whole block further.  With a page-aligned addr,
> > addr + PAGE_SIZE is at most the block end, so the round-up lands
> > exactly on the block end and the walk covers the same CONT_PTES
> > entries as before the commit.
> > 
> > We also can't align to CONT_PTE_SIZE in DAMON since it's defined only under
> > arch/arm64/:
> > 
> >   #define CONT_PTES		(1 << (CONT_PTE_SHIFT - PAGE_SHIFT))
> >   #define CONT_PTE_SIZE		(CONT_PTES * PAGE_SIZE)
> 
> DAMON cares only exactly the byte of the address, so I agree this would work
> for DAMON and be safe.  But, still the behavior is not exactly same to
> pre-6f0e1142173a, isn't it?  I'm not really sure if this is really the correct
> use of the function.  Again, I'd appreciate Baolin's comment.
> 

I'd appreciate Baolin's clarification as well here.


> > 
> > 
> > > Also, I think we should pass aligned address to only the functions that
> > > require alignement.  Making the alignment to the sampling address in general
> > > sounds too much to me.  Particularly, we are working on supporting new page
> > > access check primitives other than PTE Accessed bit, like AMd IBS.  In the
> > > case, we might support <PAGE_SIZE granularity monitoring.  Aligning sampling
> > > address in general will make it more complicated.
> > 
> > Makes sense. I will keep sampling_addr as is and align inside damon_va_mkold()
> > and damon_va_young() in v2.
> 
> Regardless of Baolin's comment, let's fix this issue.  So the v2 would be
> appreciated.  In the v2, could you also add more details about how the issue
> can be reproduced, and the user impact?  You mentioned you found memory
> corruption from DAMON selftets.  It would be nice if you could make it more
> detailed, such as what selftest reproduces the issue and what symptoms it
> showed you.

Added the crash stack trace and the impact to the v2 commit message:
https://lore.kernel.org/all/20260831221151.50561-1-zcgao@amazon.com/

> 
> Nevertheless I'm also wondering if supporting unaligned address again, like
> below also works.
> 
> '''
> --- a/arch/arm64/mm/contpte.c
> +++ b/arch/arm64/mm/contpte.c
> @@ -519,9 +519,12 @@ bool contpte_test_and_clear_young_ptes(struct vm_area_struct *vma,
>          * of the same large folio in a single VMA and a single page table.
>          */
> 
> -       unsigned long end = addr + nr * PAGE_SIZE;
> +       unsigned long end;
>         bool young = false;
> 
> +       ptep = contpte_align_down(ptep);
> +       addr = ALIGN_DOWN(addr, CONT_PTE_SIZE);
> +       end = addr + nr * PAGE_SIZE;
>         ptep = contpte_align_addr_ptep(&addr, &end, ptep, nr);
>         for (; addr != end; ptep++, addr += PAGE_SIZE)
>                 young |= __ptep_test_and_clear_young(vma, addr, ptep);
> '''
> 
> Nathan, what do you think?  If it makes sense to you, could you also test this?

I think this may introduce an issue for the case that nr > 1.  If the
address is in the middle of the block, an align like this would move it
to the beginning of the block, so the walk would cover the wrong entries.

> 
> 
> Thanks,
> SJ
> 
> [...]

Thanks,
Nathan

Sent using hkml (https://github.com/sjp38/hackermail)
