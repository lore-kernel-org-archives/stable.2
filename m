Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4553CB2E5;
	Mon, 22 Jun 2026 16:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782144671; cv=none; b=AinxrPvc+vB7YN6d2kkibugSDxiWtBlKSEwgqB1Tfe1CXhmu9TIgAAA7rI9aFBypMLiG/RoyihuLNb+kxuJG6PsfAHVrjYLBvVSd7eHfqGugKE88jVeE8ZtbaoqZkMDq9Z48be9uR6bHlr0Ra8FNAvZqLjkn9z3bE5sEHnRYHIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782144671; c=relaxed/simple;
	bh=sDTcRIo3FP/93Kk3+oaY7jv+la+FNZ83dBD9MIW6RPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kSCt67V9hZFrCgMfO4+5Gkl3GlR8bmgceUsbN6VpmnHzQNmMZe8H6qV44H6PnXZkaQjIRhRXO/MXUQQgwPaAIn4noaD0phTQrMMaSMOBeqa10b9JUk4CXlRplojCTtlNJLWXaxfxYaTHJplDlvXSFh4p6zmoyn87IgdAYKCkT2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQOiN8sX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQOiN8sX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A1D1F000E9;
	Mon, 22 Jun 2026 16:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782144669;
	bh=YV5QzOQ/E9P2Ro+ab3mma+QwYmwAGYI0yZQ28i65vpA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mQOiN8sXcaacTPR80jbZvLqhW9i5FH7SSG+DZq1bLlgoXaBg/dSYfMs7olULErObb
	 VhvmvSEg1g4c4PlfuAU9jLRMW7Ipn/HfeW+Hrh/5wFnsSRpL/ZNw2gkHHKMJefGkkn
	 3HqOWy/N/cSceHmgLadCpls43df+mnikRPbCeyJqJwpJzIqpPqSP/OrH+TbPI366AF
	 UCgB1lwByTn1EturoSVdoFbWBMYso6LpQn9p55RgPYIh7UBK2ohHi6n9h9clMSjqUz
	 SI5BKleq3X+lY96okaCzNevEPz8wxwyucwC+gmtT5tAdlaGnS8W1Fz/2obXBbFFNrl
	 mCd3P75J7I7pQ==
Date: Mon, 22 Jun 2026 17:11:02 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: akpm@linux-foundation.org, david@kernel.org, riel@surriel.com, 
	liam@infradead.org, vbabka@kernel.org, harry@kernel.org, jannh@google.com, 
	sj@kernel.org, ziy@nvidia.com, balbirs@nvidia.com, linux-mm@kvack.org, 
	stable@vger.kernel.org, Lance Yang <lance.yang@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_vma_mapped: revalidate and do proper check
 before return device-private pmd
Message-ID: <ajld6RKK02Vi-LxM@lucifer>
References: <20260622130651.23359-1-richard.weiyang@gmail.com>
 <ajk0N3Aekapljaoh@lucifer>
 <20260622142102.pcmr5pftshj5lvju@master>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622142102.pcmr5pftshj5lvju@master>

On Mon, Jun 22, 2026 at 02:21:02PM +0000, Wei Yang wrote:
> On Mon, Jun 22, 2026 at 02:46:40PM +0100, Lorenzo Stoakes wrote:
> >+cc Lance, linux-kernel
> >
> >Your subject line is 83 characters long and is way too detailed how about 'fix
> >device-private PMD handling'?
> >
>
> Got it.
>
> >You forgot to include linux-kernel@vger.kernel.org on the mail, lore seems to be
> >a bit broken atm but in general it's helpful to include that.
>
> Got it.
>
> So usually we send a patch to both linux-mm and linux-kernel? If so, I
> remember is later actions.

Yeah it's better for dealing with kvack going wrong etc. :)

>
> >
> >Also is useful to make this [PATCH mm-hotfixes] to make it really clear it's
> >intended as a hotfix.
> >
>
> Got it.
>
> >Some commit msg language nits:
> >
> >On Mon, Jun 22, 2026 at 01:06:51PM +0000, Wei Yang wrote:
> >> For pmd_trans_huge() and pmd_is_migration_entry(), we does following
> >> before return the pmd entry:
> >
> >Sounds better as:
> >
> >	For PMD entries that satisfy pmd_trans_huge() or pmd_is_migration_entry(), we
> >	perform the following actions:
> >
>
> Sure.
>
> >>
> >>   * re-validate pmd entry after PTL
> >>   * check PVMW_MIGRATION
> >>   * check_pmd()
> >>   * handle on pte level if split under us
> >>
> >> But for device-private pmd, we just return after pmd_lock().
> >
> >->
> >
> >	However, for device-private PMD entries, we simply acquire the PMD lock
> >	and return.
> >
>
> Sure.
>
> >Also can you please give some justification here as to why all this also applies
> >to device-private PMD? Right now it sounds hand wavey.
> >
>
> I thought below paragraph explain it. Not sure what justification is preferred.

Something about device private PMDs splitting the same way THP ones do, in the
pmd_is_device_private_entry() branch of __split_huge_pmd_locked().

>
> >> If a softleaf entry is present, e.g. device-private pmd, the existing
> >> code simply acquires the PMD lock and returns success even if
> >> PVMW_MIGRATION is set (indicating a migration entry is sought), meaning
> >> that the caller can incorrectly interpret the entry as something it is
> >> not, causing data corruption.
> >
> >This is repetitive, you already mentioned device-private PMD, you already
> >mentioned that it simply acquires the PMD lock.
> >
>
> Ah, I copied your suggestion from [1]. Hope I don't misunderstand it.
>
> [1]: https://lore.kernel.org/linux-mm/ajUXNjRMraKb6k2n@lucifer/

Sure, thanks but in context with the above ends up being a bit repetitive.

>
> >You should talk about what issue it caused and why:
> >
> >	This is particularly problematic when PVMW_MIGRATION is set (meaning a
> >	migration entry is sought), as it causes a device-private PMD entry to
> >	be returned with a different data layout, causing memory corruption.
> >
>
> This looks good. I would take this one, if you prefer.

Sure, thanks!

>
> >>
> >> This patch fixes commit 65edfda6f3f2 ("mm/rmap: extend rmap and migration
> >> support device-private entries") by following the same pattern as
> >> pmd_trans_huge() and pmd_is_migration_entry() for device private entry.
> >
> >This is pretty useless. We see what patch it fixes in the Fixes tag, and you're
> >just repeating things you said above, I'd drop it.
> >
>
> Got it.
>
> >> Fixes: 65edfda6f3f2 ("mm/rmap: extend rmap and migration support device-private entries")
> >> Cc: <stable@vger.kernel.org>
> >> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> >> Suggested-by: David Hildenbrand <david@kernel.org>
> >> Cc: David Hildenbrand <david@kernel.org>
> >> Cc: Balbir Singh <balbirs@nvidia.com>
> >> Cc: SeongJae Park <sj@kernel.org>
> >> Cc: Zi Yan <ziy@nvidia.com>
> >> Cc: Lorenzo Stoakes <ljs@kernel.org>
> >>
> >> ---
> >> v3:
> >>   * remove cleanup part, only fix the issue for device-private entry
> >>   * refine user effect description based on Lorenzo's suggestion
> >> v2: https://lore.kernel.org/all/20260616063436.20455-1-richard.weiyang@gmail.com/T/#u
> >>   * specify the possible error case of current code and user visible effect
> >>   * besides fix, cleanup the pmd entry handling based on David's suggestion
> >>
> >> v1: https://lore.kernel.org/linux-mm/20260508013728.21285-1-richard.weiyang@gmail.com/
> >> ---
> >>  mm/page_vma_mapped.c | 32 ++++++++++++++++++++++----------
> >>  1 file changed, 22 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> >> index 2ccbabfb2cc1..8de3c6b82df6 100644
> >> --- a/mm/page_vma_mapped.c
> >> +++ b/mm/page_vma_mapped.c
> >> @@ -270,21 +270,33 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
> >>  			spin_unlock(pvmw->ptl);
> >>  			pvmw->ptl = NULL;
> >>  		} else if (!pmd_present(pmde)) {
> >> -			const softleaf_t entry = softleaf_from_pmd(pmde);
> >> +			softleaf_t entry = softleaf_from_pmd(pmde);
> >>
> >>  			if (softleaf_is_device_private(entry)) {
> >>  				pvmw->ptl = pmd_lock(mm, pvmw->pmd);
> >> -				return true;
> >> -			}
> >>
> >> -			if ((pvmw->flags & PVMW_SYNC) &&
> >> -			    thp_vma_suitable_order(vma, pvmw->address,
> >> -						   PMD_ORDER) &&
> >> -			    (pvmw->nr_pages >= HPAGE_PMD_NR))
> >> -				sync_with_folio_pmd_zap(mm, pvmw->pmd);
> >> +				entry = softleaf_from_pmd(*pvmw->pmd);
> >>
> >> -			step_forward(pvmw, PMD_SIZE);
> >> -			continue;
> >> +				if (softleaf_is_device_private(entry)) {
> >
> >This is all very horrible. You have an example of how pmde is re-got in the
> >pmd_trans_huge() branch and pmd_is_device_private_entry() exists...
> >
> >We can just make this another branch and do the re-check more neatly.
> >
>
> I plan to keep the change small, but yeah it is ugly.
>
> >I enclose a patch that does that (untested, please check).
> >
> >
> >> +					if (pvmw->flags & PVMW_MIGRATION)
> >> +						return not_found(pvmw);
> >> +					if (!check_pmd(softleaf_to_pfn(entry), pvmw))
> >> +						return not_found(pvmw);
> >> +					return true;
> >> +				}
> >> +				/* device-private pmd was split under us: handle on pte level */
> >> +				spin_unlock(pvmw->ptl);
> >> +				pvmw->ptl = NULL;
> >> +			} else {
> >> +				if ((pvmw->flags & PVMW_SYNC) &&
> >> +				    thp_vma_suitable_order(vma, pvmw->address,
> >> +							   PMD_ORDER) &&
> >> +				    (pvmw->nr_pages >= HPAGE_PMD_NR))
> >> +					sync_with_folio_pmd_zap(mm, pvmw->pmd);
> >> +
> >> +				step_forward(pvmw, PMD_SIZE);
> >> +				continue;
> >> +			}
> >>  		}
> >>  		if (!map_pte(pvmw, &pmde, &ptl)) {
> >>  			if (!pvmw->pte)
> >> --
> >> 2.34.1
> >>
> >
> >Thanks, Lorenzo
> >
> >----8<----
> >>From e6a3c1c782714ed831c4d46a14bb99226423bf59 Mon Sep 17 00:00:00 2001
> >From: Wei Yang <richard.weiyang@gmail.com>
> >Date: Mon, 22 Jun 2026 13:06:51 +0000
> >Subject: [PATCH] refactored
> >
> >Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
> >---
> > mm/page_vma_mapped.c | 20 +++++++++++++++-----
> > 1 file changed, 15 insertions(+), 5 deletions(-)
> >
> >diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> >index 2ccbabfb2cc1..17dff8aab9f9 100644
> >--- a/mm/page_vma_mapped.c
> >+++ b/mm/page_vma_mapped.c
> >@@ -269,14 +269,24 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
> > 			/* THP pmd was split under us: handle on pte level */
> > 			spin_unlock(pvmw->ptl);
> > 			pvmw->ptl = NULL;
> >-		} else if (!pmd_present(pmde)) {
> >-			const softleaf_t entry = softleaf_from_pmd(pmde);
> >+		} else if (pmd_is_device_private_entry(pmde)) {
> >+			softleaf_t entry;
> >+
> >+			pvmw->ptl = pmd_lock(mm, pvmw->pmd);
> >+			pmde = *pvmw->pmd;
> >+			entry = softleaf_from_pmd(pmde);
> >
> >-			if (softleaf_is_device_private(entry)) {
> >-				pvmw->ptl = pmd_lock(mm, pvmw->pmd);
> >+			if (likely(softleaf_is_device_private(entry))) {
> >+				if (pvmw->flags & PVMW_MIGRATION)
> >+					return not_found(pvmw);
> >+				if (!check_pmd(softleaf_to_pfn(entry), pvmw))
> >+					return not_found(pvmw);
> > 				return true;
> > 			}
> >-
> >+			/* device-private pmd was split under us: handle on pte level */
> >+			spin_unlock(pvmw->ptl);
> >+			pvmw->ptl = NULL;
> >+		} else if (!pmd_present(pmde)) {
> > 			if ((pvmw->flags & PVMW_SYNC) &&
> > 			    thp_vma_suitable_order(vma, pvmw->address,
> > 						   PMD_ORDER) &&
> >--
> >2.54.0
>
> If we prefer this way, I will check and take it.

Yeah, feel free to go ahead + use it :)

>
> --
> Wei Yang
> Help you, Help me

Thanks, Lorenzo
