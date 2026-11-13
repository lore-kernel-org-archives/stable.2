Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794604687;
	b=DNBjqxR6kan9tOj1bI1QXUpCVe7x24q+zHj6qqk/H/x+IyfWEzwrftAvW5NAco6zaFKA
	 ZD/Q5ss3HCX4TUQ27HmK8rpTsb6JkSxfHxyEiMO+fQfgC5H8rs9CzrzYmkQcHQRLGmmhy
	 FwkH9hVDGXWDS/1/qjLw3WkH40J7GqXRaEEJ1VqSCbPFvySvkDxElK92wd3hiCVvTKTzz
	 rUDURGUCoqOfltLmj9fOuhZKfu2Zp1dUheyrhlCn9fotA7S5Hrscz6DLUQVvE9tCr+xCc
	 Hon7v70OkihSTD4W7PfrmFYi0gI7Q/Yjf+lH+EmN0JYx7fGmab3PHL8lMXA6Pxx10xQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794604687;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=TI669XTmYP7FbcAC88TL2XD6yh6R2SK28TzCrSk5RdA=;
	b=S0XF7g1YBV0z3bEV1xVYLD5QKLvp2KcfIGrD+cz63j3wWRbZKqWqQbAIV1ogW0JJJPfs
	 A1iPJcrALvAuV5K9+dZZfOdGBPYTgoUyHI83bawh1nCt2fg7jpVmQfhHFvgxAE3Tjz6Dy
	 ai6VNw5rnMTiXddi59OdXtPQO1pOJg5RedGVtGMf2D6CrIyxZZ/u8EvRXD0YBnlUG4utT
	 NhB5iiBgKBv9g1u8eXUu1hMlI6q4Ap1KMxwH0dp/uBjxyJDh4TGbR6azFnEdJq8r/vXtc
	 laiKHlPsrT+LtxddvrGRM62XkmjciDjm0hlgsGANLWtzqLPpf/bqnQ+hfFIx02C55BA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CA5BO0L8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F52606A32E;
	Fri, 13 Nov 2026 21:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CA5BO0L8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E0BE1F000C6;
	Fri, 13 Nov 2026 21:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794604686;
	bh=TI669XTmYP7FbcAC88TL2XD6yh6R2SK28TzCrSk5RdA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CA5BO0L8AuZJgiguVAwnoShvwd2dDWCM4Smhq2jprJ2ZQf5ZGyzU1ewh/5Tjb3q20
	 k7IOtFLsKXE8IlRHoj4LB4HODq8+Efee2OEhZqxBuwMRE+WiCzgQLybkuj40BM9lGN
	 s3VzfvS2uSEeJtJBTYzVyo1aO62ZeMQcdDPTLif83E70x/itvgTwF1+1xb2zRrQ3yp
	 lFgi7F7pfcEQ2nmkmQGI3D/H1hyiBstL2qqGOHA0x81fDfKHIZoP+9m992+RV3fNNW
	 lmuaN0sBGsx6+IhqPPixS9D+q32mVi6H7fuQNvRe1t4ECiLW0saKF17LcPvwIcUAkF
	 N0RCQRFabjEHw==
Date: Fri, 13 Nov 2026 21:18:00 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Tal Zussman <tz2294@columbia.edu>, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/madvise: zap markers from guard regions
Message-ID: <avd8-uVPf6BSqwEQ@gremlin>
References: <20261113-disallow-uffd-guard-install-v2-1-9d0063c70542@kernel.org>
 <f8b0f20d-90dd-496d-97e9-9a232124e3e0@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8b0f20d-90dd-496d-97e9-9a232124e3e0@kernel.org>

On Fri, Nov 13, 2026 at 10:10:49PM +0100, David Hildenbrand (Arm) wrote:
> On 11/13/26 22:04, Lorenzo Stoakes (ARM) wrote:
> > In order to establish guard regions, guard markers are installed in the
> > page tables of a mapped VMA.
> >
> > However, problems arise when one tries to combine this with registering a
> > VMA for userfaultfd, as such operations may themselves need to install page
> > table markers such as uffd-wp.
> >
> > When the installation is attempted the guard marker prevents these markers
> > being applied, which can lead to unexpected results (especially if the
> > guard regions are later removed.)
> >
> > This is especially problematic because guard region installation causes the
> > regions to be zapped first, meaning that the removal of userfaultfd-tracked
> > ranges will not be logged in this case.
> >
> > Additionally, the uffd-wp page table marker will be propagated regardless
> > for file-backed mappings as the zap being performed does not clear these
> > markers.
> >
> > This is problematic, as it can cause repeated failure to install guard
> > markers resulting in an infinite loop.
> >
> > Therefore, update guard region installation to invoke the zap with the
> > ZAP_FLAG_DROP_MARKER flag applied.
> >
> > Both before and after this change, uffd remove events will not trigger on
> > guard region installation, nor will write protect state be propagated after
> > guard region removal.
> >
> > This makes sense as conceptually, guard regions mark a part of a VMA as
> > effectively unmapped at the page table level, and removing the markers is
> > like mapping the VMA again, over which operation uffd markers would in any
> > case be lost.
> >
> > A survey of open source users indicates nobody is relying on installing
> > guard regions in uffd-armed VMAs. Software including glibc, android,
> > tcmalloc and CRIU were checked.
> >
> > This change means that any already established guard regions are removed on
> > zap. These will be overwritten with the newly installed guard markers on
> > success.
> >
> > However, if this fails for some reason (fatal signal likely the only
> > reasonable cause), guard regions may remain removed, and concurrent faults
> > may succeed in the interim in the range.
> >
> > Since the installation failing guarantees nothing about the range being
> > installed into, and since success overwrites with guard markers, this isn't
> > an issue.
> >
> > Since MADV_DONTNEED does something similar, abstract the zapping to
> > zap_range() and call it from both places.
> >
> > Fixes: f807123d578d ("mm: allow guard regions in file-backed and read-only mappings")
> > Reported-by: Tal Zussman <tz2294@columbia.edu>
> > Closes: https://lore.kernel.org/all/20261111-uffd-state-fixes-v1-9-00713d368976@columbia.edu/
> > Closes: https://lore.kernel.org/all/20261111-uffd-state-fixes-v1-10-00713d368976@columbia.edu/
> > Closes: https://lore.kernel.org/all/20261111-uffd-state-fixes-v1-11-00713d368976@columbia.edu/
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > ---
> > v2:
> > * Updated to just zap everything as per David + Tal.
> >
> > v1:
> > https://lore.kernel.org/r/20261112-disallow-uffd-guard-install-v1-1-bcf8b1aaa72e@kernel.org
> > ---
> >  mm/madvise.c | 28 +++++++++++++++++++---------
> >  1 file changed, 19 insertions(+), 9 deletions(-)
> >
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index 0214efd2a014..4f7728583207 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -850,6 +850,19 @@ static int madvise_free_single_vma(struct madvise_behavior *madv_behavior)
> >  	return 0;
> >  }
> >
> > +static void zap_range(struct madvise_behavior *madv_behavior,
> > +		      zap_flags_t flags)
>
> Two ... ;) But maybe it's consistent like that in the file, didn't check.

I'm a bit exhausted, can you or Andrew just fix up whitespace like this on
application?

It'll be easier when I have the VMA tree.

>
> > +{
> > +	const struct madvise_behavior_range *range = &madv_behavior->range;
> > +	struct zap_details details = {
> > +		.reclaim_pt = true,
> > +		.zap_flags = flags,
> > +	};
> > +
> > +	zap_vma_range_batched(madv_behavior->tlb, madv_behavior->vma,
> > +			      range->start, range->end - range->start, &details);
> > +}
> > +
> >  /*
> >   * Application no longer needs these pages.  If the pages are dirty,
> >   * it's OK to just throw them away.  The app will be more careful about
> > @@ -872,13 +885,7 @@ static int madvise_free_single_vma(struct madvise_behavior *madv_behavior)
> >  static long madvise_dontneed_single_vma(struct madvise_behavior *madv_behavior)
> >
> >  {
> > -	struct madvise_behavior_range *range = &madv_behavior->range;
> > -	struct zap_details details = {
> > -		.reclaim_pt = true,
> > -	};
> > -
> > -	zap_vma_range_batched(madv_behavior->tlb, madv_behavior->vma,
> > -			      range->start, range->end - range->start, &details);
> > +	zap_range(madv_behavior, 0);
> >  	return 0;
> >  }
> >
> > @@ -1217,9 +1224,11 @@ static long madvise_guard_install(struct madvise_behavior *madv_behavior)
> >
> >  		/*
> >  		 * OK some of the range have non-guard pages mapped, zap
> > -		 * them. This leaves existing guard pages in place.
> > +		 * them. This also drops any PTE markers in the range,
> > +		 * including existing guard markers, which we reinstall on
> > +		 * the next attempt.
> >  		 */
> > -		zap_vma_range(vma, range->start, range->end - range->start);
> > +		zap_range(madv_behavior, ZAP_FLAG_DROP_MARKER);
> >  	}
> >
> >  	/*
> > @@ -1845,6 +1854,7 @@ static bool madvise_batch_tlb_flush(int behavior)
> >  	case MADV_DONTNEED:
> >  	case MADV_DONTNEED_LOCKED:
> >  	case MADV_FREE:
> > +	case MADV_GUARD_INSTALL:
>
> Huh why that change? Not spelled out above.

It's just the established way madvise interacts with TLB maintenance.

Anything that uses madv_behaviour->tlb has to return true here so
madvise_init_tlb() and madvise_finish_tlb() do the right thing.

(I didn't really want to spell out something that's just a code convention
in the commit message, esp. when I get feedback about the messages being
too long...)

>
> Apart from that LGTM.
>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo
