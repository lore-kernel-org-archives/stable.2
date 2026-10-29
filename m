Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793279833;
	b=GKy519fiFX0T2SbxlVXgfb7o2yWYNfvSdhfm5oqKkNaJHu/Afykvu8/b3YamQoh93sG8
	 xRPAVe/O0iTk+XuLgUJAY7kSzqwuVJD0hK0JaskiNmAogi+mvABoFp8bP8cB5CrFhsSTS
	 afNRTgcNoz+JKFJUUd+jIQLC/lk8P+gUYTuRxnMq0Y8LLZdVGUIkmfvH7BMsdpR80J9ta
	 OgxKGEsgMJvP/kJJFfPjcHGeNzLG4/uWqZgmrTZDkY7TFq11iDHU8W2TKQQ7P+LAKvdgf
	 GC/gGuD0NJkLYgK182a77t36pQaLfymQEO2dOR7YBirJlhzRGWJIqmYuZNk8t13vGxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793279833;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=JRA+EBscIjB3Wf85Kdsp3ZllP4NjhEMks6pJspoVgFI=;
	b=a7sO/J761e2dBKojgOIprNlkO5lmtWhnZoQ1vc2jxl65lMgi2zVKf+GkZ0r2BGiXk9Mp
	 6c81BT+DC2feT/s0vE+eMaMM/vkXmcFLVolYgHoGzuCQenFk5SpWJI4zdOr7IwycLW8Uw
	 4VqiY/NdaCTEJ98YL+8dA0bfgK5uV2NzIsVuNLA+earkP6CHWBVENs8MCUu59PQmQR9L1
	 Nb7rbfQizQwpET1Q6UazO7RnDOY5m/SqwaGgVvTkgzcDkXb7YEO/3qsAsEsoNtIPBwfyl
	 UhbHAs3vqYlr+NRz8OiKWD5L25r5ufcWJEE5a4DwZPQK5AvIfmKqrn87nLDLYkICu1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ExxhoTgL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BF4606A320
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 13:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ExxhoTgL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A03A51F01829;
	Thu, 29 Oct 2026 13:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793279833;
	bh=JRA+EBscIjB3Wf85Kdsp3ZllP4NjhEMks6pJspoVgFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ExxhoTgLpmardw03fYqQ5Z99pOOg/9EAf9OCNy5IikWuNrxOwziwwMHkyQVfLkB8e
	 sMzz0mutTiCjvLQoDVRf098zOXBcYIFzKeEtegeOIRrRxv5orNNGPegzkhjdfoZJC1
	 /gAMFi2JSfCWG2LXfQ5EAHCGJY1yfFPmHsKvuHaE0Y/CUHe2z6j1Mz6L0cKItab5S7
	 ZwqCTD2Qy9UrXj7q1MjE9mdA8HFWbcFJZn9h3xdU8PHdI8qH/53okMpOnQuPVgNCu8
	 besGbjfbWqJvlZMND2HOyHx+USOJ/tUzdAyH4SLjOp9EN2Ydz3dU82NTDCzxsGS9ci
	 hcfDaDdOB+LSw==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.ams.internal (Postfix) with ESMTP id 4A423198003A;
	Thu, 29 Oct 2026 09:17:09 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 29 Oct 2026 09:17:11 -0400
X-ME-Sender: <xms:VEfjaiBdtk8eSqQZZC_siWUNjp2XkmnUYdgaj_pO0fwEO7m7hQs9cw>
    <xme:VEfjas8tPX1HCuciZcBjCntcbHreNpgolp2GChr-f4BKtzxEk8d1FBsFUejZbGQkA
    OuR06tY5PjhdvrZ0XjtW24VnSOn5h004S36m3veDe3entpZ2FSRV8IM>
X-ME-Received: <xmr:VEfjarC-xtsABZe4qugdnyGgA8JROjkZxr1Liqcf_I5F6ZpseHmNL6d-zj4>
X-ME-Proxy-Cause: dmFkZTG2EVxsiXqZOd32Nkq2kAun5pY6dWfNhhCiR95p6LBReaqvq03sPl8TN9erfkk0z1
    KTntpfrqVGeL9x1bmG/wkYLrULDdbe73UgZsxUYteqXu1qb0r7PB55VdGOox5cUZ8co7/u
    dZbZ+V6ErfeNzekxowVgsvUXTTLpyn1piwccOyRtMMzxlCZuo0WPOsQWlntSkDidJIMQOv
    M6pCN+bMHlsgaa39ZsrwapEieXGuHAHcOWGc5Xhy0nxxCCPOwgRQYpCME/wA2YaTZmhDqi
    4EI4t32GKL0L2I+7TH+Z4hmIQymqAMCSwo/Eo6zjbX7Z0/2jj2hpmJ+TCsn8bdUzJkaNMO
    NCOMRe0lPsiH+E7VCC1pn/jknH5q21qyXXvkMF8BvXyNlwqi8BXYHqrbSYz/p+kTM8ppnc
    Glxuv07CuB9+LYt8gGuoZ8+RyNP+ugGlrw8bUKCJxfD1iA+n/nbk0fl84/DHo7JF7OJSL/
    azpUfXoZIrzopbX6exR9zJfgSx/M+Pmb9BdzqThL04B/Me6eoaNpqmsqarnS1hSCcvP4Ko
    dWs8Swn0FcYhOmmn7GISdaF5jIHXSOukDmxJyK2yDIP4JnbymtkEZAMjs1EMZZIIFZieew
    GOaKtvWvMdRwmDdQ2BrXWWW3bcgwJxHRQ8J1XCaToGBh8UV/zjIuwFKJ6DrA
X-ME-Proxy: <xmx:VEfjauunaaMeRiuKnHXbsJmtOYDrSpyOKPD_sZ91W3zgIVDdz9W_GA>
    <xmx:VEfjarEZNQ-xtc-qWG5wZA7FreBVZRVlal7OLQ2HM6ZcNhqEY7Gb9A>
    <xmx:VEfjap_9pXFINOd-m61pulQfv17tnFFdF-8FxB6GVj0zSQFmfG9cNg>
    <xmx:VEfjahO835ydd3R2iOG1LVa_p0gwkiasQ3O0Wqv_cXxfCxMiJnTn-A>
    <xmx:VEfjavjM0W98gr5mnFSzoc1pt3ZiuXwUD3I6pRrj-E6pcUAlkgjqXSB3>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 09:17:07 -0400 (EDT)
Date: Thu, 29 Oct 2026 13:17:06 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [PATCH 0/2] mm/cma: accept memory of CMA areas reserved with
 memblock_reserve()
Message-ID: <auNE2XEGreHRKoPO@thinkstation>
References: <20261029-cma-multi-v1-0-2cbced8b5cb7@kernel.org>
 <auM6lKGAeUI26jCj@thinkstation>
 <auM-tYrdV4TJgJ6K@kernel.org>
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
In-Reply-To: <auM-tYrdV4TJgJ6K@kernel.org>

On Thu, Oct 29, 2026 at 02:40:21PM +0200, Mike Rapoport wrote:
> On Thu, Oct 29, 2026 at 12:27:23PM +0000, Kiryl Shutsemau wrote:
> > On Thu, Oct 29, 2026 at 12:18:36PM +0200, Mike Rapoport (Microsoft) wrote:
> > > Pages of allocated CMA areas are released to the buddy allocator with
> > > __free_pages(), which does not check for unaccepted memory.
> > > 
> > > This usually works because memblock accepts the memory it allocates.
> > > 
> > > However, multi-range CMA areas, used by hugetlb_cma, and fixed CMA areas
> > > requested with cma=<size>@<base> are reserved with memblock_reserve() and
> > > their memory is never accepted.
> > 
> > It feels like memblock_reserve() abuse, no?
> > 
> > crashkernel=size@base already uses memblock_phys_alloc_range() for this.
> > Should the fixed and multi-range CMA paths go through the allocation API
> > as well.
> 
> Fixed path already has the range, why would it use allocation APIs?

Having the range doesn't make it a reservation. Both paths take free
memory for the kernel's use, which is an allocation, and an allocation
has to be accepted. memblock_reserve() is for memory that is already in
use: kernel image, initrd, firmware tables. Using it for allocations
leaves acceptance to every caller, and both CMA paths missed it.

If memblock_phys_alloc_range() is the wrong tool, let's add a
memblock_*alloc*() helper that takes the exact range and does the reserve
plus memblock_prep_allocation(), the way memblock_alloc_hugetlb() finishes
its own search. There is no search, so the multi-range path doesn't get
slower, and accept_memory() stays inside memblock.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
