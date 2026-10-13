Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6598E509EF5;
	Tue, 13 Oct 2026 14:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791901791; cv=none; b=a9eznp3E5e5EzAHdB51PFIxBX5zDG7hzf/5dyfioEgHmgDsp9WZFs53StkzVt1QBGx2Y7BXbcjqxRSVrIJ9msbG2chkybYK+Mt696Rgr7cWHnpJliH6S51XhMrRno3vvQZL196o2JON9hKUpdV2E9lZn0nPxGIscawWi2GXoteI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791901791; c=relaxed/simple;
	bh=MSi3PANfY4MjoDSvofvJf61AjnfTTXNg976PsOkYsso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=knKWfXSXeUm9RsI3iD70lXREimppq8saMg3ssMmle8UjTp7xDrP1NSAq6F5xvJsnRrluU+hjRCAWr6q4ViI3RTt9zzp+MvG7ebZzDm7HB7HK6Hosh+VCvC5GdO2D+WLGq29eTHiW+bjBH+/9SHPoEMo6k/Dez2Jo0aPEwQfek1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTGTGta3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTGTGta3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E121B1F000FF;
	Tue, 13 Oct 2026 14:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791901790;
	bh=MSi3PANfY4MjoDSvofvJf61AjnfTTXNg976PsOkYsso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WTGTGta3BaGB0P5FZtBi8DBd/bdJ0/0OvzJgJhTIcEoTdneroJIuBFUEE2Vmpzre5
	 FJWH0TdGlGepmeWzARjpUcjDnfOTp6NZQ4YG+ariJ6pQ0HTL43BsozIhF44XOxLr3h
	 T049eRNF3g48x6Kww3M6v6owS/9za3X96XfcWnZ1ES1EO1tHzITfCGaiEEm22y8Fq9
	 LNm+/6ragNInKh6AK8AY1P9hYJIrweDdGR9ikKPnV3VjNRjXM5SNFmkzCmOJOWIEHp
	 8BevgnbGVefcYMLyB5XK2V7xMhsVhmkp51syk15Ph0nBwaEbd/kbngaPZltNdtBFJE
	 gS9/KL3jEkSiQ==
Date: Tue, 13 Oct 2026 15:29:44 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Rik van Riel <riel@surriel.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>, Lance Yang <lance.yang@linux.dev>, 
	Kyle Zeng <kylebot@openai.com>, stable@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/rmap: don't discard lazyfree THPs at PMD level
Message-ID: <as49h2Zgs2wtkfmJ@gremlin>
References: <20261009-lazyfree-stable-fix-v1-1-70997958ef8d@nvidia.com>
 <asy445BYRhcsGDE9@gremlin>
 <8B17F897-40BE-4834-8078-949DA951B46F@nvidia.com>
 <asz2domYFnTe2owf@gremlin>
 <9CC1C4F0-1C73-4AA4-8D1C-28DB024E2221@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9CC1C4F0-1C73-4AA4-8D1C-28DB024E2221@nvidia.com>

On Mon, Oct 12, 2026 at 04:37:34PM -0400, Zi Yan wrote:
> On 12 Oct 2026, at 11:22, Lorenzo Stoakes (ARM) wrote:
>
> > On Mon, Oct 12, 2026 at 10:33:34AM -0400, Zi Yan wrote:

> > }
>
> Yes.
>
> My wording was not precise.
>
> zap_pmd_range() doesn’t take the PTL since it sees pmd_none(), while
> try_to_unmap_one() takes the PTL.

Yeah, this is nasty.

No wonder it took some AI analysis to find this :)

> > That bit isn't special to MREMAP_DONTUNMAP.
>
> Right.

But it is a 'very special' flag for mremap... :)

The # of bugs that thing has produced...

> > That set pmd could also UAF on the PMD page table in theory couldn't it?
>
> No, in __discard_anon_folio_pmd_locked(), the caller holds anon_vma read lock;
> when mremap() or munmap() calls free_pgtables() to get rid of page tables,
> they first call unlink_anon_vmas() and get blocked by the aforementioned read
> lock. set_pmd_at() is called while free_pgtables() is blocked, so no UAF here.

Ah ok thanks. Yeah the rmap lock is held throughout that.

Hey - when I eliminate the rmap lock things are going to be even more fun ;)

>
> >
> > It's all really horrible.
>
> And kills my brain.

Yeah this hurt my head too.

I actually (rare in 2026) only got AI to chime in late in my analysis, and while
it helped confirm/deny some stuff it wasn't even that helpful in avoiding the
head... f..un.

> >>> So unmap_vmas() doesn't correctly populate the mmu_gather struct for the
> >>> range, meaning that the underlying page isn't freed and the refcount,
> >>> mapcount etc. are all left as they were?
> >>
> >> Yes to the underlying page isn’t freed.
> >
> > The refcount and mapcount etc. would be correct? I think the refcount would be
> > such that it permanently leaks and the mapcount would be incorrect or only
> > accidentally correct?
>
> refcount and mapcount would be wrong in the munmap case. Both are correct
> in MREMAP_DONTUNMAP case, since the folio is still mapped in the source VMA
> but its anon_vma says it belongs to dst VMA. When dst VMA is unmapped,
> the anon_vma is freed, but the folio is still mapped and its ->mapping
> points to a freed anon_vma. A rmap code checking folio->mapping is a UAF.

OK I _think_ you can only have a destination that either has the same anon_vma
or is unfaulted (so gets given the source anon_vma) so yeah, the anon_vma is
still right but is pointing at the destination VMA, while still being mapped in
the source one :)))

MREMAP_DONTUNMAP really is the gift that keeps on giving.

> > They seem like they are existing bugs effectively in pmdp_invalidate()? Or stuff
> > that we would want to fix anyway I guess?
>
> SPARC’s thp_pte_count might cause other issues, since its code only considers
> huge pmd splitting. powerpc’s page table check might have an issue.

Such fun... lord.

> >> I can remove the dead code if you think that is better.
> >
> > No, if you plan to reinstate it (soon!) then that's fine, but please
> > explain that you're intentionally doing that in the commit message please!
>
> Sure. I will try to come up with a concise but comprehensive message to cover
> both the issue and why pmdp_invalidate() does not work itself.

Great thanks, I saw the v2 and it all LGTM!

--
Cheers, Lorenzo
