Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793277629;
	b=IrhBTbCzDiq0lDe/w+4ZiHIdn0SHIAedME/UWNEk3is4KMYF5qLOBG5R4Jz+f2G6HLXe
	 68I9YpDNWbwcyqVFboJJ+Mt+wMFHrpxribSvreXzUMo0SmQ7TzoJv+U48hASI7AykY7ua
	 H8sA16u49m5CWYA7bWNXKNiGFi57eLj6451WgFWGXrKxyeis1tfT+Lsi2k+zkpkWrI4lv
	 3171hR87j98LhFTbaQdtqlRu7cja9xt8n3MQSk0aXrEM37U0IW1R21W8IP/GQdL0b13Sg
	 G4fD8tU3xhjcO7cUJOmlJ8TgsIC8WzYXmnqTkj3ZEHJIhfNWEUZB2Dz35dOZVRpdh3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793277629;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=t67BBHCIL7EUtyLOu8dUfk5JQITxnHbOVp7o6sR49Lo=;
	b=KwX4biG5ZJ+l5jLmvKBToywTBZWriQuqMVm1rgLT0H+N+/xn24yLWyuiiRzzYu0eoDHr
	 FH9Yt173+BlbNG/Xc6Cl1DOgJjqhhNVpR1jlV6wZoPsnpe4NBZhEztMQY8fvSKhA7mqmd
	 KM9Cf5Y8UemDc5GVNSZWJhwOuSY5cz6TjChQh5Ynu18PbvVvutA2zLNTmPsYViOhphiRg
	 OgHoUPAh+ZXwwjIdZc2EMqqgg+oykuyU9aicqC3ISXKQrCsYFlgVdSGxYQe3Xvywt6MVr
	 zx7wG1H0Cxnd5Ql5sZQVylWmE9LKFYDm0uzCyMtoYj3KG0o4ZGqYfvt20+E4QEZEdTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IVEKkSl3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3A6606A31F;
	Thu, 29 Oct 2026 12:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IVEKkSl3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 855EF1F01825;
	Thu, 29 Oct 2026 12:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793277629;
	bh=t67BBHCIL7EUtyLOu8dUfk5JQITxnHbOVp7o6sR49Lo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IVEKkSl3j5tFHHYE1LKR+DuBf1Oxx/j+z6NfrUWDYJAL0JfElidf9BkjOJyB6mVPo
	 pFhk1a/YMfxEAg6KV3sj3kKPJKcM9uSy/gdruoltaTJbYwYE5C8pi4E1oTn3NkWrLQ
	 Fqb1maQM2o8bsLge4vXKBwXTQk7DPPku3VcnYBJ1jR+JB39ACIEnOVnHoHdFeVnPrl
	 5p8TcKiBosyi5szeSBGV9s9LbAz6v2dmpQmXw2ibwd3mIjzqWKc3GK8SCgSUTV62TU
	 MdRPXoFeUsvqXnzMziwFlDTeRylZ8401H10h1d2H9VU8iISb/QDDsUzxHR4/9Jldiz
	 cM1hbX3q9rzFQ==
Date: Thu, 29 Oct 2026 14:40:21 +0200
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
Message-ID: <auM-tYrdV4TJgJ6K@kernel.org>
References: <20261029-cma-multi-v1-0-2cbced8b5cb7@kernel.org>
 <auM6lKGAeUI26jCj@thinkstation>
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
In-Reply-To: <auM6lKGAeUI26jCj@thinkstation>

On Thu, Oct 29, 2026 at 12:27:23PM +0000, Kiryl Shutsemau wrote:
> On Thu, Oct 29, 2026 at 12:18:36PM +0200, Mike Rapoport (Microsoft) wrote:
> > Pages of allocated CMA areas are released to the buddy allocator with
> > __free_pages(), which does not check for unaccepted memory.
> > 
> > This usually works because memblock accepts the memory it allocates.
> > 
> > However, multi-range CMA areas, used by hugetlb_cma, and fixed CMA areas
> > requested with cma=<size>@<base> are reserved with memblock_reserve() and
> > their memory is never accepted.
> 
> It feels like memblock_reserve() abuse, no?
> 
> crashkernel=size@base already uses memblock_phys_alloc_range() for this.
> Should the fixed and multi-range CMA paths go through the allocation API
> as well.

Fixed path already has the range, why would it use allocation APIs?

The multi-range could, but it will be several times slower and I believe
the intention was to avoid allocation APIs exactly because of that.

> -- 
>   Kiryl Shutsemau / Kirill A. Shutemov

-- 
Sincerely yours,
Mike.
