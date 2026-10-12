Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19B949B20E;
	Mon, 12 Oct 2026 15:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791818548; cv=none; b=P6FKdj5q3zFIZWA/1pJzUTilZEEwD7M3XxpT+N1IiYyBHlJMHTsTaM2rT7lLfZxjmNvN65L07sx8B9HZ7k85IP5USTaBvDMqT5+vIxNOk//Vii7cW2gK+HfIx7CL9OTeXSnc/DaLJD+4KrjJD2dX432I76efxIvQwUWBaE3zcCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791818548; c=relaxed/simple;
	bh=DY9Z3vR67SXGOfe53KXX42gzFyTktBRsStC3sWA0VCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cCsFkgneVE/slHLdxvTQwkV5d96RgsJeklq6a+pMe9tKwGoY7OKGMWU3hV685mSY0FyMm+NRjAZKxzhPA4+E0s2TWWwMRUoWcxZIZVOhJtDVl+8fAD7J++WhGEqkhB0QBS4LIuaFeEpH7nTqjfJowzvHwcR+Sq4BWizpXUi6C2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IhvFY7Na; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IhvFY7Na"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87FF01F0089C;
	Mon, 12 Oct 2026 15:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791818546;
	bh=+Hl7JhwHL6QZRyn/5JpMAadGxR10kpDMUmsBVHSxWuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IhvFY7NaCyskeu05X+aLMX9HkouW/N/AnO9Zs8otqIRZixbmqRO2BuBo8w05ZD6nr
	 WJRZ3iCk1bveU2hU3ZlJSq/af1nWy9ksW0euhl3liA26QdJzXslkxBYBeC040mAmOM
	 9Fp0vXCAitJLJLPD87orxoZIupHoZkBND7GKoztd14FOTtahelazj+wWjMSJQBQQh7
	 u9JNGgmTIG7F8qfvMIRII8zXi/i7h/ICdnQNgCIwZwmV+hNSeLZcN13t3Mbs90A1nr
	 Z+9pxp3UMPQab0fcnR7DgsY7WMHO27D2oaCIICZvUF/yGrGA2Ig8w4Q/Ibwe/5bGVc
	 w+9slFmOe3iEg==
Date: Mon, 12 Oct 2026 16:22:19 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Rik van Riel <riel@surriel.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>, Lance Yang <lance.yang@linux.dev>, 
	Kyle Zeng <kylebot@openai.com>, stable@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/rmap: don't discard lazyfree THPs at PMD level
Message-ID: <asz2domYFnTe2owf@gremlin>
References: <20261009-lazyfree-stable-fix-v1-1-70997958ef8d@nvidia.com>
 <asy445BYRhcsGDE9@gremlin>
 <8B17F897-40BE-4834-8078-949DA951B46F@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8B17F897-40BE-4834-8078-949DA951B46F@nvidia.com>

On Mon, Oct 12, 2026 at 10:33:34AM -0400, Zi Yan wrote:
> > Looking at the code:
> >
> > <anon_vma lock>
> > [reclaim]
> > < PMD lock >
> > -> try_to_unmap_one()
> >     -> unmap_huge_pmd_locked()
> >       -> __discard_anon_folio_pmd_locked()
> >         [ clears PMD entry ]
>
> The PMD becomes pmd_none().

Yup.

>
> > 	...
>
> There are two readers making decisions based on “pmd_none()” locklessly:
>
> 1. munmap case is via zap_pmd_range() in mm/memory.c: it skips pmd_none(),
> so the above folio is not zapped;

Yup I get at that below.

It also doesn't serialise on the PMD lock as a result.

That's really key isn't it?

		if (pmd_is_huge(*pmd)) { 				<- returns false
			if (next - addr != HPAGE_PMD_SIZE)
				__split_huge_pmd(vma, pmd, addr, false);
			else if (zap_huge_pmd(tlb, vma, pmd, addr)) {	<- doesn't lock the PMD
				addr = next;
				continue;
			}

So it skips it and nothing happens to the PMD nor is there any serialisation
between unmap_huge_pmd_locked() and this code.

try_to_unmap_one() will be called under the PMD lock because of this In
page_vma_mapped_walk(), I believe:

bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
{
	...
		if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
		    (pmd_trans_huge(pmde) || pmd_is_migration_entry(pmde) ||
		    pmd_is_device_private_entry(pmde))) {
			pvmw->ptl = pmd_lock(mm, pvmw->pmd);
			...
			if (likely(pmd_trans_huge(pmde))) {
				...
				return true;
			}
			...
		}
	...
}

>
> 2. MREMAP_DONTUNMAP case is via move_page_tables() in mm/mremap.c calls
> get_old_pmd(): get_old_pmd() returns NULL for pmd_none(),
> so move_page_tables() skips the above folio.

move_page_tables() is called for _all_ mremap() operations. So the same issue
would occur across mremap().

That bit isn't special to MREMAP_DONTUNMAP.

>
> > 	[ reinstates PMD entry later ]
>
>
> 1. for munmap, unmap_region() calls free_pgtables(). In free_pmd_range(),
> the restored PMD is treated as pmd_bad() and cleared. And the folio’s
> rmap is not removed.

Yup I got to that point below :)

>
> 2. for meremap, dontunmap_complete() unlinks anon_vma but the source VMA
> still maps the folio.

Well, only if the set_pmd_at() managed to reinstall it AND the PUD page table
that mapped it still exists.

That set pmd could also UAF on the PMD page table in theory couldn't it?

It's all really horrible.

>
> >
> > Concurrent munmap():
> >
> > <mmap write lock, downgraded to mmap read lock later>
> > do_vmi_align_munmap()
> >   -> vms_complete_munmap_vmas()
> >     -> vms_clear_ptes()
> >       -> unmap_region()
> >         -> unmap_vmas() < zaps > <----- EDIT: the real issue, see below
> > 	-> free_pgtables()
> > 	   -> unlink_anon_vmas()
> > 	     -> < anon_vma lock taken! >
> > 	   ... clears down page tables (no rmap lock) ...
> >
> > Is the issue actually the zapping in unmap_vmas(), which doesn't seem to be
> > protected by rmap lock at all, meaning that _that_ can happen with
> > concurrent munmap()?
>
> No. zap and rmap walkers are serialized by PTL. The reason is described above.
>

Well, no, that's not quite right AFAICT - as above the PMD PTL _is not taken_
because the PMD entry is cleared.

So the serialisation that would otherwise exist between the try_to_unmap_one()
and zap_pmd_range() doesn't happen.

> >
> > So unmap_vmas() doesn't correctly populate the mmu_gather struct for the
> > range, meaning that the underlying page isn't freed and the refcount,
> > mapcount etc. are all left as they were?
>
> Yes to the underlying page isn’t freed.

The refcount and mapcount etc. would be correct? I think the refcount would be
such that it permanently leaks and the mapcount would be incorrect or only
accidentally correct?

>
> >
> > MREMAP_DONTUNMAP seems a bit of a bizarre callout, but I suppose it is the
> > other case in which (under certain, likely, circumstances
> > e.g. non-partial/self-merging remap) an unlink_anon_vmas()'s call is done.
> >
> > With normal mremap() that'd happen via an unmap of the original VMA.
> >
> >> rmap walk uses the freed anon_vma.
> >>
> >> Using an invalidated PMD instead of a cleared one requires additional arch
> >> code fixes. Instead, disable the PMD level discard of lazyfree THPs, as
> >> before commit 735ecdfaf4e8 ("mm/vmscan: avoid split lazyfree THP during
> >> shrink_folio_list()").
> >
> > Again it feels like this commit message assumes a bunch of information that
> > isn't presented here.
>
> 1. SPARC has thp_pte_count-- in its pmdp_invalidate(), but set_pmd_at()
> does not add it back, since the code assumes pmdp_invalidate() is only
> used in THP splitting code.
>
> 2. GUP-fast accepts an invalidate PMD on s390, risk, loongarch. They
> need to fix it to prevent GUP-fast from succeeding for this new
> pmdp_invalidate().

Thanks that's useful to know! And ugh.

They seem like they are existing bugs effectively in pmdp_invalidate()? Or stuff
that we would want to fix anyway I guess?

In general the point of all the above discussion is to encourage a commit
message that conveys this information clearly.

When I read the patch first there was a lot of 'huh' and that's a sign that the
commit msg doesn't say enough.

> >> diff --git a/mm/rmap.c b/mm/rmap.c
> >> index 805db93fe0428..1131b76bbbc28 100644
> >> --- a/mm/rmap.c
> >> +++ b/mm/rmap.c
> >> @@ -2275,17 +2275,6 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
> >>  		}
> >>
> >>  		if (!pvmw.pte) {
> >> -			if (folio_test_lazyfree(folio)) {
> >> -				if (unmap_huge_pmd_locked(vma, pvmw.address, pvmw.pmd, folio))
> >
> > This is the only caller of unmap_huge_pmd_locked(), making that and
> > __discard_anon_folio_pmd_locked() dead code, shouldn't we remove all of it?
> >
> > Otherwise we're leaving dead code around.
>
> 1) it keeps the backport small, 2) I am going to restore the function and
> this reduce the code churn.
>
> I can remove the dead code if you think that is better.

No, if you plan to reinstate it (soon!) then that's fine, but please
explain that you're intentionally doing that in the commit message please!

--
Cheers, Lorenzo
