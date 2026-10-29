Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793286221;
	b=GjZmTzBoR+dCKdobHoiq4zloImk7L/k0Ryw3ZixdKDKRQpkdDZh4Ora04AHheSC6wcNM
	 c2neCtzC1/d4yeLtf58nziJaF1JxqitkHpxU+bt6lkCBZFnp+ZaXJea33YxuH9CAnzqtR
	 88KOwPj34f6E0GKXJP2Z5Lj85HaidCukGAPZCLNqCSNFwgxFegHgviHAmIzFbTXo5tlgH
	 UueoF/aM+gzxbhEkaOxF08d/HY/StCD6l56BElh1xeKTORLWI5D/1wqAU1emyM1Tzx/fU
	 pbygHICUFODTcxq/ErG0T6GbmY0YzT2dv4xwItfsCX/vBruUW6y1W2dMltIPqxGWh9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793286221;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=c6CEhYs14U8U+JezWPAfQbVngV7jbZT+JjXbmGtNusc=;
	b=vk2oKSVV2lDgwd/gych6j62opb/c6SlneEADdDVCgEpiL0liJHARnZB5CRN+05XnqujO
	 N/+1w6wyEuK/3QFLOp+W+0BeE5moKHChoNMVMmzviQlRdRUHK8kmzdzLg6T7Dz2ljn8nE
	 rKKEysqSJJa7RKU3WLT0ohsB4KzcM7japg/lY4Nn22i9JQpM+3iq7rLfibUpGztUpvNsZ
	 aO6U2COWqhmbUaDgNniLAVsfMKB/U2io9tsJ+rWdszF8MJH6zHsRt5cR41U8YF85j+4Zd
	 n+7yGMCcP8/7EbJgxTT/O8aeBPInLY6FuaUXOAonW6NAODigqo958JecV6jCUpqHPFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K87jbF3Q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A04606A31C;
	Thu, 29 Oct 2026 15:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K87jbF3Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A3821F01825;
	Thu, 29 Oct 2026 15:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793286220;
	bh=c6CEhYs14U8U+JezWPAfQbVngV7jbZT+JjXbmGtNusc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K87jbF3QgksMsvFlmThw/QGWsaljNclLuymOMt5wEkDnh8/EuqdfHKvslVlKVhA2S
	 eoyjkAX5BvgXvitcfznNi5xc/1kfcK8AInIiJfMi7D8i37m66Slhydl8sbMOmNSkcc
	 LF7jlLR4keBh/OD0Gzc0tBj9s67TsE8uZHxKbFOipg4oNdW4zj35JydofE93ABUEYu
	 SdGyW9vCE4YDt7jxl+uNCLL/6MQLfZvFOOn2VEv5fqTxq8i9/EJdvcYJmgTA2oJ5EZ
	 5WRyxneY/AC/P4kdebYsNu3M0BqstmK0vC/WJ5VDmqMbNnhaHHTZvrSbW5bMZZUvwk
	 8a/Q2Au4OT6Zg==
Date: Thu, 29 Oct 2026 17:03:33 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Kiryl Shutsemau <kas@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>, Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [PATCH 0/2] mm/cma: accept memory of CMA areas reserved with
 memblock_reserve()
Message-ID: <auNgRT19droHmv3Y@kernel.org>
References: <20261029-cma-multi-v1-0-2cbced8b5cb7@kernel.org>
 <auM6lKGAeUI26jCj@thinkstation>
 <auM-tYrdV4TJgJ6K@kernel.org>
 <auNE2XEGreHRKoPO@thinkstation>
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
In-Reply-To: <auNE2XEGreHRKoPO@thinkstation>

On Thu, Oct 29, 2026 at 01:17:06PM +0000, Kiryl Shutsemau wrote:
> On Thu, Oct 29, 2026 at 02:40:21PM +0200, Mike Rapoport wrote:
> > On Thu, Oct 29, 2026 at 12:27:23PM +0000, Kiryl Shutsemau wrote:
> > > On Thu, Oct 29, 2026 at 12:18:36PM +0200, Mike Rapoport (Microsoft) wrote:
> > > > Pages of allocated CMA areas are released to the buddy allocator with
> > > > __free_pages(), which does not check for unaccepted memory.
> > > > 
> > > > This usually works because memblock accepts the memory it allocates.
> > > > 
> > > > However, multi-range CMA areas, used by hugetlb_cma, and fixed CMA areas
> > > > requested with cma=<size>@<base> are reserved with memblock_reserve() and
> > > > their memory is never accepted.
> > > 
> > > It feels like memblock_reserve() abuse, no?
> > > 
> > > crashkernel=size@base already uses memblock_phys_alloc_range() for this.
> > > Should the fixed and multi-range CMA paths go through the allocation API
> > > as well.
> > 
> > Fixed path already has the range, why would it use allocation APIs?
> 
> Having the range doesn't make it a reservation. Both paths take free
> memory for the kernel's use, which is an allocation, and an allocation
> has to be accepted. memblock_reserve() is for memory that is already in
> use: kernel image, initrd, firmware tables. Using it for allocations
> leaves acceptance to every caller, and both CMA paths missed it.

memblock_reserve() predates any allocation APIs and it is used to say "I
know this memory is free, I'm taking it". So memory acceptance should have
take it into account.

> If memblock_phys_alloc_range() is the wrong tool, let's add a
> memblock_*alloc*() helper that takes the exact range and does the reserve
> plus memblock_prep_allocation(), the way memblock_alloc_hugetlb() finishes
> its own search. There is no search, so the multi-range path doesn't get
> slower, and accept_memory() stays inside memblock.

A new helper that does reserve and accept makes sense, but let's do it on
top and also audit other callers of memblock_reserve(). I believe we may
also hit some curious corner cases with memmap=, although this is less
likely.

These two are really simple and easily backportable and I don't see an
issue with calling accept_memory in low level cma code.

cma_declare_contiguous_multi() has other issues and I'm reworking it right
now. But again, that does not mean a simple addition of accept_memory to
CMA contradicts it.
 
> -- 
>   Kiryl Shutsemau / Kirill A. Shutemov

-- 
Sincerely yours,
Mike.
