Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793198365;
	b=BXbbkP4y+qtdBXqGzfYjwppA/R1bogKl8dIMnuNPO6iZK3W6ZiXEqQ8mDkFaPuQGnniv
	 dTxKQ8EkFIkO2ltWX815t1XXZDd3F4ERCrXIfRoVzqbTFJ1Lz8xPIXXEFMBlliPf+Eo/p
	 eM6YENF569oKBPyMbbiV0pyrJd6c+UtH86HFNaYMR/+c5kacSYWb+sksOq5hHclNO0/ou
	 Q87YVLVh9tA419e8t9Ds15lIlGTCGR7YG3hpjzblwAiYib01/i9lHE2NX4RUUCCsdMjSO
	 S1ZmpqfHbcEA/c/g48PXslgSRYFtTpdJXIydCSej13tlpzESsKKFr03/0yDo3xcXTWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793198365;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=eCisLb2VRu0iADmHFVpreIQCwjhWOtNKh8jVGOYf+aI=;
	b=mwAuih+drqCMF/8YCu1KYyt5ue9C1Y4un1jDQo8wmLFm151EY5D2q6smzNbkA0xip5b5
	 BMYvVfoh02zkoSCnGGC9cZR+Y6+x/7tn5IWWB0RJtYRlxvWl58nmbdycisf2Rgwsqs2gg
	 vHVCjOhiJ+CTQ9UaOCiW8rG7gcgKz+J6YmzxyVoBaWpL/J7I79rUy7q9YK7LKuD+Wr/Pm
	 vv5EZ7euWOrUKo2/C6r1puTw58vd0zvByYb5RnXX7INySm3t2ctdbE1euuou/H+2LhJqP
	 ufxwV+DMyUz+r17i/IAVDzpJjDLaZ5yzrRThQTtyzTCOplSX6uMnngANN73e58wS2Pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZSkH9Agj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6D4606A321;
	Wed, 28 Oct 2026 14:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZSkH9Agj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E39C1F01825;
	Wed, 28 Oct 2026 14:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793198364;
	bh=eCisLb2VRu0iADmHFVpreIQCwjhWOtNKh8jVGOYf+aI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZSkH9Agjre8913zHh4b1HLO9CLoDWHGYpW+eB4gbdBiovVJe478t24Jn9yGHNxstR
	 NP3qWYlZcSww8LVEBJOay+6O1zVCQb6abwW/yWG4rGwnOdaZEGKWV9TWCiRcQCL1Iu
	 ZxCZ7HPgK+ObNzmXs5+bwip4YNAuEJerqJYRdb3ojfheEifO+CePt7FLeoKRUuWYt4
	 BV2heYqLTv8c1MrxPK5dWzc/kblnBlMKbNVu/dmqaJjvCzMsPCOO3YeB2DJSPpQJ1g
	 ninPoUCoeJstjgmxEhmJCf2v43wqA6MB5Aqf56sdir1SyzSj5+WAzPGa9MdivRK4kQ
	 asfMvotu/x3Og==
Date: Wed, 28 Oct 2026 15:39:16 +0100
From: "Oscar Salvador (SUSE)" <osalvador@kernel.org>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Frank van der Linden <fvdl@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, kernel-team@meta.com,
	linux-mm@kvack.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/hugetlb_vmemmap: map the shared tail page writable
Message-ID: <auIJFHg1haY5c937@localhost.localdomain>
References: <20261028132623.2560146-1-kirill@shutemov.name>
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
In-Reply-To: <20261028132623.2560146-1-kirill@shutemov.name>

On Wed, Oct 28, 2026 at 01:26:21PM +0000, Kiryl Shutsemau wrote:
> From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
> 
> page_ref_add_unless_zero() reads the refcount and then updates it with
> a cmpxchg.  A lockless get, such as a page cache lookup or a PFN
> scanner, can read a non-zero refcount from a page that is then freed
> and reused as a hugetlb tail page.  If HVO remaps its struct page to
> the shared tail page in between, the cmpxchg writes to read-only
> vmemmap:
> 
>     CPU0 (lockless get)               CPU1
>     c = atomic_read(&page->_refcount)
>                                       page freed
>                                       page allocated as a hugetlb tail
>                                       HVO remaps the struct page RO
>     try_cmpxchg(&page->_refcount, &c, c + 1)
>       -> write fault on read-only vmemmap
> 
> The refcount is zero by then and the compare fails, but a
> compare-and-swap instruction needs write access whether or not it
> succeeds.  The kernel oopses when hugetlb pages are allocated at
> runtime with HVO enabled while a lockless get races with it.
> 
> Commit bd225530a4c7 ("mm/hugetlb_vmemmap: fix race with speculative PFN
> walkers") closed the window with RCU on both sides.  The RCU was removed
> together with fake heads, on the wrong belief that it was only needed
> for them.
> 
> Map the shared tail page writable instead of restoring the RCU.  Every
> struct page on it is a tail with a zero refcount, so a late cmpxchg
> fails and leaves the page unchanged.  RCU would put rcu_read_lock()
> back around every get and synchronize_rcu() back into hugetlb
> allocation and freeing.
> 
> The cost is the protection against stray writes to tail struct pages.
> The shared page is shared by all hugetlb folios of the same order in
> the zone, so such a write now corrupts all of them instead of oopsing.
> 
> Bootmem folios optimized when the memmap is set up keep their tails
> read-only.  Nothing does a lockless get on them before hugetlb takes
> them over.
> 
> Fixes: 32c440d67e6c ("mm: drop fake head checks")
> Fixes: 01b1d0ffb6f7 ("hugetlb: remove VMEMMAP_SYNCHRONIZE_RCU")
> Reported-by: David Hildenbrand (Arm) <david@kernel.org>
> Closes: https://lore.kernel.org/r/ebc7bde1-f52e-4da8-b16f-822d6c0a4d74@kernel.org
> Cc: stable@vger.kernel.org
> Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

Reviewed-by: Oscar Salvador <osalvador@suse.de>



-- 
Oscar Salvador
SUSE Labs
