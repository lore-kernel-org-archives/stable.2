Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECD431E844;
	Sat, 29 Aug 2026 01:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.77.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787965506; cv=none; b=gQZOLkJUqxJCfRxtipV7LnWYKdyQAgyisnkzvWHnC5Qp5LMjUXBd7/4YLrfIog5lL4jU2uGrbmR1NsGwjZ/2jLKqDQXKYrfvJuyaTRGkb/VQOHQJl4CEueizRbEocfbZNgimPVGo8NU32HFXjImSJ+o7sx7evSOoUhcmGC1cP+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787965506; c=relaxed/simple;
	bh=noRaLKn3d8hkU/f2BlkUAVCZtnsrYifs5lbJRrRTCJA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EYCn86S7KgTaQtZZH0CuOaiiDBWBvEZqBexfV1tAOgota8flxRnuWS3pn8HJvbjPHlKNL9iwCsE8hlpgw8moAabKACrTjgOcp0UIezikO4PTRNCFIAsvj71LvviwoRkU5TnPfTTxfMM6No2KtPF8wjhHQJgiREPtAIMWUhL+nw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=VcEyAolK; arc=none smtp.client-ip=44.246.77.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="VcEyAolK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1787965505; x=1819501505;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AnDR6DMNIm8190T9Mj0ZWeFFqjC7wiMNtZlDelqgd7U=;
  b=VcEyAolKIB3y81QYBNQN+OoUr9dzNcIUsqIl9AwZcUcrOAfqKAXIOYY8
   7vVy0VuIOP004QOhayfAwW38MdlhyOF60UQFxp/y+ZJ5ta/6rnceDwbgM
   KCJARiiu5rNVz2euuqoDC5lTrl18zJxYhbZ1W2xMDnzMl8DilxOJl1Pex
   IiM/LRftIPK1wKufNipNRhvVFLdE/6cnPRPim8nVS8Mfs2NdN7TeZwwNc
   7W456h9A8rPNgQlG563Rb6Gx52m2Li/aSpwthxNy4XFDJ7rKOulvhPulh
   VuplP2SkagGbHjvSpp9DqgX8SUAnc1ILySxM4zyiX6+G0qF2hGhrDgSHI
   g==;
X-CSE-ConnectionGUID: l3w405B6Q3qTp7vJELniRA==
X-CSE-MsgGUID: XfIREu1fQeiEvPbPMsGFZQ==
X-IronPort-AV: E=Sophos;i="6.25,249,1779148800"; 
   d="scan'208";a="27259169"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2026 01:05:04 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:17926]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.30.13:2525] with esmtp (Farcaster)
 id b56c57eb-15a2-4d68-b802-e011e4869232; Sat, 29 Aug 2026 01:05:04 +0000 (UTC)
X-Farcaster-Flow-ID: b56c57eb-15a2-4d68-b802-e011e4869232
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Sat, 29 Aug 2026 01:05:04 +0000
Received: from 6c7e67c92ceb.amazon.com (10.187.170.21) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46;
 Sat, 29 Aug 2026 01:05:03 +0000
From: Nathan Gao <zcgao@amazon.com>
To: <sj@kernel.org>
CC: <akpm@linux-foundation.org>, <baolin.wang@linux.alibaba.com>,
	<damon@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <stable@vger.kernel.org>, <zcgao@amazon.com>
Subject: Re: [PATCH] mm/damon: use a page-aligned sampling address
Date: Fri, 28 Aug 2026 18:04:55 -0700
Message-ID: <20260829010455.28607-1-zcgao@amazon.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260828002211.61987-1-sj@kernel.org>
References: <20260828002211.61987-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWB001.ant.amazon.com (10.13.138.123) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Hi SJ,

Thanks for your review!

On Thu, 27 Aug 2026 17:22:11 -0700 SJ Park <sj@kernel.org> wrote:

> Hello Nathan,
> 
> On Thu, 27 Aug 2026 12:38:21 -0700 Nathan Gao <zcgao@amazon.com> wrote:
> 
> > __damon_va_prepare_access_check() picks a random byte address within the
> > region and stores it in r->sampling_addr. There are two users of
> > r->sampling_addr in vaddr.c that pass it into a page table walk, and
> > both use it as the address of a page.
> > 
> >   damon_va_mkold(mm, r->sampling_addr)
> >     damon_va_walk_page_range(mm, addr, addr + 1)
> >       damon_mkold_pmd_entry()
> >         damon_ptep_mkold(pte, vma, addr)
> >           ptep_test_and_clear_young(vma, addr, pte)
> >           mmu_notifier_clear_young(mm, addr, addr + PAGE_SIZE)
> > 
> >   damon_va_young(mm, r->sampling_addr, &folio_sz)
> >     damon_va_walk_page_range(mm, addr, addr + 1)
> >       damon_young_pmd_entry()
> >         ptep_get(pte)
> >         mmu_notifier_test_young(walk->mm, addr)
> > 
> > test_and_clear_young_ptes(), which backs ptep_test_and_clear_young() on
> > arm64, documents @addr as "Address the first page is mapped at".
> > 
> > For arm64, before commit 6f0e1142173a ("arm64: mm: support batch
> > clearing of the young flag for large folios"),
> 
> The @addr documentation is also introduced by this commit.  This commit is
> authored at 2026-02-09.
> 
> > the contpte helper walked
> > exactly CONT_PTES entries from the aligned-down page table pointer and
> > used @addr only to pass down to each entry, so an unaligned value was
> > harmless:
> > 
> >         ptep = contpte_align_down(ptep);
> >         addr = ALIGN_DOWN(addr, CONT_PTE_SIZE);
> >         for (i = 0; i < CONT_PTES; i++, ptep++, addr += PAGE_SIZE)
> 
> So, there was no issue before the commit.
> 

Right. Before 6f0e1142173a, unaligned addresses were tolerated but I don't
think this is guaranteed.

> > 
> > Align the sampled address down to a page boundary. It is the address of
> > the page to sample, so this matches its intended meaning and fixes both
> > users in vaddr.c.
> 
> This indeed sounds like can fix the issue to me.  However, was it a clear rule
> that we should pass only contepte-aligned addrss to
> ptep_test_and_clear_young()?  And is DAMON the only ptep_test_and_clear_young()
> caller that is mistakenly passing the unaligned address?
> 

It is not spelled out as an explicit rule, but the documented "Address
the first page is mapped at" implies it, and these callers are using
aligned addresses:

 mm/page_idle.c: page_idle_clear_pte_refs_one()
 fs/proc/task_mmu.c: clear_refs_pte_range()

> If not, it might make sense to make contpte_test_and_clear_young_ptes() support
> unaligned adress again in my opinion.  May I ask your opinion, Baolin?
> 
> > 
> > Fixes: 3f49584b262c ("mm/damon: implement primitives for the virtual memory address spaces")
> 
> I think 6f0e1142173a ("arm64: mm: support batch clearing of the young flag for
> large folios") would be mroe correct 'Fixes:', if there was no issue before the
> commit.
> 

Will use that in v2.

> > -	r->sampling_addr = damon_rand(ctx, r->ar.start, r->ar.end);
> > +	r->sampling_addr = PAGE_ALIGN_DOWN(damon_rand(ctx, r->ar.start,
> > +						      r->ar.end));
> 
> If we need to have the fix in DAMON, this kind of change would be needed.
> 
> However, what happens if the address is backed by large folios?
> 
> Before the commit 6f0e1142173a, also, it was aligning to CONT_PTE_SIZE.  Should
> we do same?

Passing a page-aligned address restores the pre-6f0e1142173a behavior.
Before the change, the helper aligned ptep down to the block start and
walked a fixed CONT_PTES entries, regardless of addr.  After the
change, the walk covers [ALIGN_DOWN(addr, CONT_PTE_SIZE),
ALIGN(addr + nr * PAGE_SIZE, CONT_PTE_SIZE)).  With a sub-page offset,
addr + PAGE_SIZE lands just past the block boundary, so the round-up
extends the walk a whole block further.  With a page-aligned addr,
addr + PAGE_SIZE is at most the block end, so the round-up lands
exactly on the block end and the walk covers the same CONT_PTES
entries as before the commit.

We also can't align to CONT_PTE_SIZE in DAMON since it's defined only under
arch/arm64/:

  #define CONT_PTES		(1 << (CONT_PTE_SHIFT - PAGE_SHIFT))
  #define CONT_PTE_SIZE		(CONT_PTES * PAGE_SIZE)


> Also, I think we should pass aligned address to only the functions that
> require alignement.  Making the alignment to the sampling address in general
> sounds too much to me.  Particularly, we are working on supporting new page
> access check primitives other than PTE Accessed bit, like AMd IBS.  In the
> case, we might support <PAGE_SIZE granularity monitoring.  Aligning sampling
> address in general will make it more complicated.

Makes sense. I will keep sampling_addr as is and align inside damon_va_mkold()
and damon_va_young() in v2.

Thanks,
Nathan
