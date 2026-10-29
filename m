Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793276401;
	b=YkIfFL4rT3vAl+Ia6HwV3xz6A7XWrsZ8EOokkTUT8KAlxIcoHI6XQdsPNAwXw3gBLlfy
	 tc8DMD4afJfzD5e/zcmXQnDNe+uGQyb3Hj7uTkFKI3P1D28hCBpOBEYFpvrDAiKLgdzJX
	 9lUXQDg2Rd5WPOwzJQFSgvG+QRm3DinyfgVZzAmUB9zF5XV+wesYzgVv89S9wdH0mDKkh
	 rulkRgxOTBYAkJ7Kz5G63tavC00+uJ/L5lpmO+0hb9xoOS33J+QuCNEpwntevufZ9CWB1
	 L3ijm2aAzR8iwMb3tK0T2htb0Py+uC6R7vAkNPdcH9nrBKef5VGC+Z8Wz/sgU63CiSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793276401;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=3gESRXwpoweyr0cm+satiqXh4JmHP5qxA2OIhTI1lmM=;
	b=XvrIjRH4xzfmCQV1wWiAK/FhPBCbdTMXzTjcWCkSZd6FU0djreYfumq14PXvh80tVr2O
	 fS4ClHwAZoe13JviPxooz0fuqE/DgzNyndmuNTTqiBn2z82RYtvmnCUr5r/zf3S3R9Hwu
	 u0Me9Brxm4X3gGnwL5yDj3Acvqryp1g7uUfL9R8kTOBatrmZX37GeQs3SAFduBqomHSow
	 0WpV1qn3m4g87rP8EYABZaAlyA8OTJGXcriMjdNBuX2aq9818tHWIZUselRgl9euPSLbG
	 8/ZLwpC8eFUfuJG0pUs6EGH6+pmboHkzxNPd35I65Z9J3OPN7J4Ft4EHXUTOkhCVZQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RiohXsBn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAFD606A31A;
	Thu, 29 Oct 2026 12:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RiohXsBn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 868951F01825;
	Thu, 29 Oct 2026 12:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793276400;
	bh=3gESRXwpoweyr0cm+satiqXh4JmHP5qxA2OIhTI1lmM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RiohXsBnJlLT7tXhp1+CPkAKj9f9s2yejzY0UNAw7u2R9VLKbB3S0S0gsWNgOc8Ct
	 dyqsZ/gwKDcgSH1IqYh5nh4xdu8wJtONfpBiFjFSD0jvyFbBnlhsq6JHnvRf6RZV+Q
	 0pepzCfT/HEy38cjcE0+f9+8DwFVSuOe/5eWC/PdJj9KE2HCTT0YHagX6+r64QNMVO
	 mAKjgVCDFQ9Fwq2mzC9NsocLkNSzzgs1svNuAdoPLTaNhoYDZOaL+Uk6bBeF3/aUXO
	 jkiDvSyt5/a3UUUZeiSD/YDtIJAymxtQOwWP0jPE3fKXa1rIwx9HM7OfkXFbsQ4/U9
	 WPTunT/VQvhTg==
Date: Thu, 29 Oct 2026 14:19:53 +0200
From: Mike Rapoport <rppt@kernel.org>
To: "Gupta, Pankaj" <pankaj.gupta@amd.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Kiryl Shutsemau <kas@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>, Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/cma: accept memory of multi-range CMA areas
Message-ID: <auM56dTOXCb70vzz@kernel.org>
References: <20261029-cma-multi-v1-0-2cbced8b5cb7@kernel.org>
 <20261029-cma-multi-v1-1-2cbced8b5cb7@kernel.org>
 <a25827d8-83ee-4e05-8c55-4e6ca8a498ad@amd.com>
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
In-Reply-To: <a25827d8-83ee-4e05-8c55-4e6ca8a498ad@amd.com>

On Thu, Oct 29, 2026 at 11:52:53AM +0100, Gupta, Pankaj wrote:
> 
> > On systems with unaccepted memory, memblock allocations accept the
> > allocated range, but when cma_declare_contiguous_multi() uses open coded
> > allocation of multiple ranges, it reserves them with memblock_reserve()
> > and they are never accepted.
> > 
> > These pages are released to the buddy allocator by cma_activate_area()
> > with __free_pages() that does not check for unaccepted memory, so the
> > first access to such a page in a TDX or SEV-SNP guest is fatal.
> > 
> > Accept the memory of each range when it is reserved.
> 
> Fix looks correct to me.
> 
> Any easy way to reproduce and test on SEV SNP?

I think running a VM with 16G or ram on a single node and with

hugetlb_cma=8G memmap=2M\$0x2ffe00000 init_on_free=1
 
in the kernel command line will do the trick.

> Thanks,
> 
> Pankaj
> 
> > 
> > Fixes: c009da4258f9 ("mm, cma: support multiple contiguous ranges, if requested")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > ---
> >   mm/cma.c | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/mm/cma.c b/mm/cma.c
> > index a10ea37a261da..0035efb1130a5 100644
> > --- a/mm/cma.c
> > +++ b/mm/cma.c
> > @@ -678,6 +678,8 @@ int __init cma_declare_contiguous_multi(phys_addr_t total_size,
> >   			break;
> >   		}
> > +		accept_memory(mlp->base, size);
> > +
> >   		pr_debug("created region %d: %016llx - %016llx\n",
> >   		    nr, (u64)mlp->base, (u64)mlp->base + size);
> >   		cmrp = &cma->ranges[nr++];
> > 

-- 
Sincerely yours,
Mike.
