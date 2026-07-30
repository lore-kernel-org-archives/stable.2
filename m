Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DE13D3337;
	Thu, 30 Jul 2026 09:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785402966; cv=none; b=FirJK7xmOepIlWynUkNRBW4o2Q4csyrXfCGHRO6JrOv0Z9OBQO0/fuXbo2YSRLd1envqC7i1A6OqnweDdyv0Ev3O1g7oMiD66+69aP5Hc66Pm7PzamPsX9p7CJOxoeE+7FgjCliSohjyroGFrAvSJG8Kgr22q4H+/69ZTbj3mcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785402966; c=relaxed/simple;
	bh=Bz6gqBZys13PKDunxTULuH7UZpx3kjE3gYICcLet1Uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nrRHiRq6pAk9ItfBWxT2sx2hucu1Hg70+DrCbu3vIuk17GQoB0Usbfqod8nrxSjpWJki1ZCyC0MsamCLGyQHHhd0vhB8tnaF4oUelEFOWOWfgfbJOgBd53NE0Vdo0hxLHiXl6bPddePmvEjjkBWMyt8lZP4Oa4zGwtq5bn8MIi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fVdEWTfJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fVdEWTfJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 185B91F000E9;
	Thu, 30 Jul 2026 09:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785402965;
	bh=Bz6gqBZys13PKDunxTULuH7UZpx3kjE3gYICcLet1Uw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fVdEWTfJVD/GakEcmYxJaNiudilKkG3cDUlakYPmzcgqsAxWrLwiEozNQsmDoJzC0
	 U9iGOSsDt7rDQP5RkxFsjX81Zwt1cjzc2iG4vE2tbSwxWZFrc3SPcV84EfbyybaFCM
	 MADr+ITHP7LeZlMYcwR8HBVjkIs5oq4fGbk7XucAEZ8LcwZRJgxSWPw3hmYmrxkIjs
	 c1yoTWiwtK3MGes9EOHp2rBRdMwq3qRJhhSk7h39QegKqYmomqqJ8GRr9v06kmy9Kd
	 /hQZ32/lW0Jn2A6Y/uLqKeWNsr5MRvw/LaVeHTdrIlo0XeZQiAMToh3jqfxQ6td8hr
	 PHqvvNi758Tig==
Date: Thu, 30 Jul 2026 10:15:45 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Pankaj Raghav <p.raghav@samsung.com>, 
	Hannes Reinecke <hare@suse.de>, Hugh Dickins <hughd@google.com>, Yang Shi <shy828301@gmail.com>, 
	Kiryl Shutsemau <kas@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Hengbin Zhang <uqbarz@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH mm-hotfixes 0/2] mm/huge_memory: fix huge_zero_pfn race
Message-ID: <amsUw6_DjKRg3gJq@lucifer>
References: <20260728-fix-refcounted-huge-zero-v1-0-3f261f5447b4@kernel.org>
 <f0e39f91-8dd1-4d9d-8d4e-da5d608a7148@kernel.org>
 <amm2GOFablLbBC4H@lucifer>
 <773a043f-e135-4050-9ca1-0b5190f03ec4@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <773a043f-e135-4050-9ca1-0b5190f03ec4@kernel.org>

On Thu, Jul 30, 2026 at 11:05:49AM +0200, David Hildenbrand (Arm) wrote:
> On 7/29/26 10:15, Lorenzo Stoakes (ARM) wrote:
> > On Tue, Jul 28, 2026 at 09:02:57PM +0200, David Hildenbrand (Arm) wrote:
> >> On 7/28/26 14:05, Lorenzo Stoakes (ARM) wrote:
> >>> There is a subtle race in the reference-counted huge_zero_folio
> >>> implementation.
> >>>
> >>> The fast path atomic logic fails to account for the fact that the
> >>> shrinker (which drops the final huge_zero_refcount pin) can overwrite
> >>> huge_zero_pfn with the ~0UL sentinel value in shrink_huge_zero_folio_scan()
> >>> after a racing get_huge_zero_folio() installed a valid value there.
> >>>
> >>> This results in huge_zero_folio being correctly set but huge_zero_pfn being
> >>> set incorrectly and thus is_huge_zero_pfn() and consequently
> >>> is_huge_zero_pmd() will misidentify the huge zero folio as being an
> >>> ordinary THP folio.
> >>>
> >>> This can result in the huge zero folio being split and otherwise treated
> >>> incorrectly.
> >>>
> >>> The solution to this is very subtle as there is an atomic fast path, and
> >>> thus ordering in weakly ordered architectures has to be treated very
> >>> carefully.
> >>>
> >>> As a result, this series first reworks the
> >>> CONFIG_PERSISTENT_HUGE_ZERO_FOLIO logic so it is separated from the
> >>> refcounted code in order to make the subsequent fix reasonably
> >>> understandable.
> >>
> >> For at least somewhat easier backports, can we reverse the order?
> >
> > Since I'm going to be doing the backports can we keep it the same? :)
>
> I enjoy reviewing small targeted fixes (also for backports), so I want to
> understand why patch #1 is required at this point.
...
> >
> > I can figure things out for < persistent huge stable kernels. It'll be manual
> > work either way.
> >
> > (It'd be good to get some review on the actual changes also :)
> Sure, will get to it, but I have limited capacity.
>
> And I have more capacity for small targeted fixes :P

The fix is small and targeted, it's 2/2.

>
> >> The spinlock+proper ordering should be possible without #1, or am I missing
> >> something important?
> >
> > It's possible but this way it's a lot easier to deal with and I'd rather keep
> > things consistent for stable kernels.
>
> "A lot easier to deal with", can you elaborate?
>
> The shrinker code never runs with the persistent huge zero folio. So that is not
> a concern.
>
> So it's about get_huge_zero_folio().
>
> But there, it's simply that concurrent races are impossible.
>
> Please enlighten me.
>

Rather than debating I'll just drop that and respin.

>
> --
> Cheers,
>
> David
