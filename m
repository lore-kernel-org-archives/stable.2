Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA51430CE8;
	Thu, 30 Jul 2026 13:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785416979; cv=none; b=YLK4F4foh1GkaJbl6u4bIJehGSgIpMECqmhNQmM5iqd2UNrtIV3NRLnn4O71yWb9VKAaIxtCXUxGXeRv0W+/snVC+8AtKUT8ZR+D2EC6nlLI+AWdlzsR6RXweewgtJklJktXhimTnVyXfu7koQ2bF27iYgg/c9muO4tn+K6N9Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785416979; c=relaxed/simple;
	bh=bLueI+iND4rfNLFgH0wSpSzNKoBL0fiaG63acjSkI04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XmvIpfuEu99IPXtUI5sq3DPPnGrBhCauaD1CMCC5qnPOrsdazgNemvMkGNa/VpmEJt66nQhzJF9gFNjUk17M3e/XSRw82KXdY292I6GOQV0NLHpAkpr8X+R7c51q49+ZJhUFRCgkkxTreoPGsXv0hEn2gIUZlOH4n1Cf2GkrVbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oh0phniM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oh0phniM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7CE51F000E9;
	Thu, 30 Jul 2026 13:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785416977;
	bh=nF8RaaPGsgkbmp6APmxdP1QSXAEwh87b+GWYpDNFqnM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Oh0phniM4GRIkO92rMLKIQV1xWYsmqUahZgchMwwcb/ldPd6MZS/1k97f2ASMmxTb
	 /LwUKYLiyUUHVvKVnG1/64XLKGupTWEjFSwTISVuwbCUcb2GNCBpiZVne+EbCuXxmB
	 j3+yYBlN8pOiWhJxQugomvrW8vgVsOLvr4PwaNgxF5u1zqBTY6Dgk1yKl7SuJGugwH
	 lrKbBhuVkDzm42D1TltwGG4qIZD1SARTylrZ4jHdBbusRKZ44Ks5Q59M1KZAjwOBrn
	 47I5x7vmRA9mgfoCheIeQqAt/habxABQ5CV/zp7VILBnP4ZTRIR6ySLQ4pX41Fx6AL
	 3IklTXP/oKsxg==
Date: Thu, 30 Jul 2026 14:09:17 +0100
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
Subject: Re: [PATCH mm-hotfixes 2/2] mm/huge_memory: fix huge_zero_pfn race
Message-ID: <amtHMG4owrzXeLx0@lucifer>
References: <20260728-fix-refcounted-huge-zero-v1-0-3f261f5447b4@kernel.org>
 <20260728-fix-refcounted-huge-zero-v1-2-3f261f5447b4@kernel.org>
 <25d560df-6d7e-462a-a987-60a8695793ba@kernel.org>
 <amsch6HvEH5IJjfM@lucifer>
 <39b527d7-9c6e-4798-be9d-b834c8a3d2a0@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39b527d7-9c6e-4798-be9d-b834c8a3d2a0@kernel.org>

On Thu, Jul 30, 2026 at 02:10:23PM +0200, David Hildenbrand (Arm) wrote:
> On 7/30/26 11:55, Lorenzo Stoakes (ARM) wrote:
> > On Thu, Jul 30, 2026 at 11:22:09AM +0200, David Hildenbrand (Arm) wrote:
> >> [...]
> >>
> >>> So invariants are required - huge_zero_refcount MUST:
> >>>
> >>> * Only be set in the huge_zero_lock critical section to ensure
> >>>   serialisation of huge_zero_pfn, huge_zero_folio and huge_zero_refcount
> >>>   writes.
> >>>
> >>> * Be set non-zero only AFTER huge_zero_[pfn, folio] are set to valid values
> >>>   so installation of the huge zero folio on read page fault ensures
> >>>   concurrent is_huge_zero_*() calls correctly identify the huge zero folio.
> >>>
> >>> * Be set zero only BEFORE huge_zero_[pfn, folio] are set to NULL and ~0UL
> >>>   respectively, and atomically.
> >>>
> >>> Establish these by:
> >>>
> >>> * Only updating huge_zero_refcount in the huge_zero_lock critical section
> >>>   in get_huge_zero_folio() and shrink_huge_zero_folio_scan().
> >>
> >> That is imprecise. huge_zero_refcount is updated (incremented) outside of
> >> huge_zero_lock in get_huge_zero_folio().
> >
> > You're right.
> >
> > ->
> >
> > * Only setting huge_zero_refcount to zero or an absolute value in the
> >   huge_zero_lock critical section in get_huge_zero_folio() and
> >   shrink_huge_zero_folio_scan() and updating atomically elsewhere.
> >
> > Seems better?
>
> Yes, I guess the transition from/to 0 are the problematic bits. Everything else
> can just be lockless.

Yeah exactly. Also setting an absolute value in general is potentially
problematic.

>
> --
> Cheers,
>
> David

Cheers, Lorenzo
