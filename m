Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E0A2DEA6B
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 11:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781867096; cv=none; b=AkjyKzXmniuVw9nkkh3ufxTJHmJ+x7LgRk+Jyyiu5Q5JrripaS1k438hq5liqs3tR9uz24+QGycBcDKJJL6hwsg6N/qfAXAqxIKwBxsCefhV7GsDZuPBzBva+R1y39tG/n795H7ZxL8NOwhJWS+4oC7rUq6beSSo+KDk5QFkzLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781867096; c=relaxed/simple;
	bh=Vd5jpHF14JbYaTreg20wGczTbFQp28O1ZPoLa6Cs8mY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJwcElW4PRow9GhAAylYzeUni1RnOyfhFqc7/HxmlGbf1VTopjIPt6/BxS1Kf7qOYcipstWVj3PFP+I44bsKn43op7tbvIY6/AJ0J20FN8Yo0O4GLFCrudAzbUwIeQeqOpkWnvnZqZMiZbrg3Yo5pKj+Kyvee1AmHENLi44SSPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NGvyJq1l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NGvyJq1l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 865A41F000E9;
	Fri, 19 Jun 2026 11:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781867094;
	bh=Oahfa4mOTeBScg/vkMnuvaXcHN8g7hfrDjLC4oiuCJ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NGvyJq1lThI1Hi53i6iHDf/UepbC9nbNUHUO01BCqbxMv3aLFKYqmAgJU5PzpbDnh
	 PqVVBFc1iprgtuXq/mZF4JwIz0z1sx5X1VWM+Gtq944f+us7zJo6WVNXeJrVz3EQVp
	 q/RMfbgBPTOVM5JxMWUni/N8jkaynXAIHs/1q5vwX24fHS7JLcCSAnFBut31Y5LPsk
	 /Lefw6QMa3/OHsspld4dy4AuwwEDnL2LiwZ3+KZJbDfd6N08M76yHuMxYQJSXxxFYG
	 Htvdpx3cbXgYlVC4UVyvI5OmYpQiOoAgBMyXeIQOavS+HVIdqb3Au74vNbBCZIMYdq
	 XxMrlW/YWFTnw==
Date: Fri, 19 Jun 2026 12:04:47 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org, 
	riel@surriel.com, liam@infradead.org, vbabka@kernel.org, harry@kernel.org, 
	jannh@google.com, balbirs@nvidia.com, ziy@nvidia.com, sj@kernel.org, 
	linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [Patch v2] mm/page_vma_mapped: revalidate and do proper check
 before return device-private pmd
Message-ID: <ajUiEs3ZzbgJc0v2@lucifer>
References: <20260616063436.20455-1-richard.weiyang@gmail.com>
 <ajUXNjRMraKb6k2n@lucifer>
 <5e7f7fe5-221a-4fca-aa76-297ae19eb80d@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e7f7fe5-221a-4fca-aa76-297ae19eb80d@kernel.org>

On Fri, Jun 19, 2026 at 12:48:26PM +0200, David Hildenbrand (Arm) wrote:
> On 6/19/26 12:44, Lorenzo Stoakes wrote:
> > -cc wrong email
> >
> > On Tue, Jun 16, 2026 at 06:34:36AM +0000, Wei Yang wrote:
> >> For pmd_trans_huge() and pmd_is_migration_entry(), we does following
> >> before return the pmd entry:
> >>
> >>   * re-validate pmd entry after PTL
> >>   * check PVMW_MIGRATION
> >>   * check_pmd()
> >>   * handle on pte level if split under us
> >>
> >> But for device-private pmd, we just return after pmd_lock().
> >>
> >> This may return improper entry, e.g. if we are looking for a migration
> >> entry, device-private entry could still be returned, which leads to data
> >> corruption.
> >
> > I don't thik this is quite clear?
> >
> > How about:
> >
> > 	If a softleaf entry is present, the existing code simply acquires the
> > 	PMD lock and returns success even if PVMW_MIGRATION is set (indicating a
> > 	migration entry is sought), meaning that the caller can incorrectly
> > 	interpret the entry as something it is not, causing data corruption.
> >
> >>
> >> This patch fixes commit 65edfda6f3f2 ("mm/rmap: extend rmap and migration
> >> support device-private entries") by following the same pattern as
> >> pmd_trans_huge() and pmd_is_migration_entry() for device private entry.
> >>
> >> While at it, it cleanups the pmd entry handling in page_vma_mapped_walk().
> >>
> >>   * Instead of handling trans huge/migration entry/device private entry
> >>     in a mixed manner, we put each case into its own if condition and
> >>     handle with the same pattern.
> >>   * Also we grab PTL and make sure pmd is not changed under us after
> >>     above check instead of do the check with PTL hold.
> >>   * restart the process if pmd is changed under us
> >
> > You're doing quite a bit for a fix and you're putting it all in one place.
> >
> > How about do the fix as 1 patch, and then cleanups as other ones? It helps with
> > review too :)
> >
> > It's a general rule of thumb that if you do more than one of moving, refactoring
> > or changing code, to do them as separate patches so a reviewer/somebody
> > bisecting can clearly separate each.
> >
> > Also PLEASE do not add new functionality (this lock recheck) in a fixes
> > patch. We'll end up backporting new logic that way.
> >
> > Make the fixes bit _minimal_.
>
> To be fair, I asked for this
>
> https://lore.kernel.org/all/2d48ef0d-1110-4a9d-adcb-f701a1ce2cfa@kernel.org/
>
> But given that Wei mostly used my quick draft without properly checking the
> implications, yeah, let's fix it first separately.

Ack yeah sorry I mean I agree that it needs cleanup just has to be done in the
right way which clearly I think we agree on :)

>
> I can then follow up with a proper cleanup.

Thanks!

>
> >
> > I think in general Andrew prefers separate fixes patches so I'd just make the
> > _minimal_ change that fixes this for the backport, and the cleanup stuff as a
> > separate series.
> >
>
> The issue is that the existing handling is just crap, and to fix it, we're
> adding more crap. But yeah, let's add more crap first before we clean it up
> properly.

I couldn't agree more and to be clear - I hate how this is right now.

But I think for the fix we have to wade in the crap first then clean it up
afterwards... :)

>
>
> --
> Cheers,
>
> David

Cheers, Lorenzo
