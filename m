Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741223B388E;
	Thu,  6 Aug 2026 01:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785980669; cv=none; b=dPXyMsJynqa6dKMXC0+BlW0I1QMk00u8G+BgSV/pBPakyGKZNvWZ3jdkaPhm/0VtBOLVaOUs6iV6sTwtt4nVPEuSVzmFOpdbd1c0pC3JUtKMb3ALZAKyj3IMYCCFT1S6TCw1x2bU2bgc6B6jUBUg1p2Xt3HU4Kg9SJJrkQKnxYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785980669; c=relaxed/simple;
	bh=pDaGWIotUHeRiXYu0XdKs+QqVC4kZvyDhZ5Jr9ZyZfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U1xeDaz6x1KegIFowcLHBbZvNU3dhZpOW+D9JfAf5ZBuwRftpAtloRbpqPc7LOZCBk0ZRzAnltKeJJ6qOAa53j6CjeKBLBRxL93b7A1nY2fEETboBEK5cZl4u3ET2jO6Mh5zI4nJNp8jrICw/4TOBam1H70sTk1gzRe5FKUEp2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tPmaKzje; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tPmaKzje"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=700hBB8fgPfgmlwOv52ySx8FJ3F1nBRAqSnKAZkhhtk=; b=tPmaKzjejjgGfLmDw0JXVoRZLC
	X4/CpTOO73xqWvvd/Z7wPGg9nbL5kJtMnIDn0+GhzjJ1oofnsTrL8rfjfB7nEYU5o9OpNVdWvlZO0
	YUyfV7ZgaG3D3Go2bGY49Ru9dHS8LSkvdfZa2pvFKYVjA9eVFC+u/UN2yGaILj3to7a1KA8Ry2AHX
	plUEsKu+G9Y9QcotAWLEAg4mm2I0Nc4v2aRUsYXkVqQeLKk4CAD6T+vkd5yxGDeYgivkHno6I5vcb
	08hoKa2obb1XPzwY8WvC+54mYJEMces1eYFaA/cCVuJ3wIYvAfy3/GEtj7PAbs1LTmlFhrpI49kus
	a823YRTA==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrn9W-00000005str-3Ftr;
	Thu, 06 Aug 2026 01:44:10 +0000
Date: Thu, 6 Aug 2026 02:44:10 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	Peter Xu <peterx@redhat.com>, David Hildenbrand <david@kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Zi Yan <ziy@nvidia.com>,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/huge_memory: let special huge VMAs bypass the THP
 policy check
Message-ID: <anPm6vGNeDxLFIkJ@casper.infradead.org>
References: <20260805055544.1568534-1-clg@redhat.com>
 <anL-NZkNMSSxN0YN@lucifer>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anL-NZkNMSSxN0YN@lucifer>

On Wed, Aug 05, 2026 at 11:41:46AM +0100, Lorenzo Stoakes (ARM) wrote:
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index abc65d608c23..5fa01364f089 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -111,6 +111,34 @@ static bool vma_is_special_huge(const struct vm_area_struct *vma)
>  	return vma_test_any(vma, VMA_PFNMAP_BIT, VMA_MIXEDMAP_BIT);
>  }
> 
> +static bool should_obey_thp_file_tunables(const struct vm_area_struct *vma,
> +					  bool forced_collapse)
> +{
> +	if (forced_collapse)
> +		return false;
> +	VM_WARN_ON_ONCE(vma_is_anonymous(vma));
> +	/* Huge PFN mappings allocate no folios so the policy doesn't apply. */
> +	if (vma_test(vma, VMA_PFNMAP_BIT) && vma->vm_ops->huge_fault)
> +		return false;
> +	return true;
> +}
> +
> +static bool can_thp_collapse_file(const struct vm_area_struct *vma,
> +		vm_flags_t vm_flags, bool forced_collapse)
> +{
> +	/* Override THP tunables? */
> +	if (!should_obey_thp_file_tunables(vma, forced_collapse))
> +		return true;
> +	/* THP=always? */
> +	if (hugepage_global_always())
> +		return true;
> +	/* THP=madvise? */
> +	if (!hugepage_global_enabled())
> +		return false;
> +	/* Has VMA had madvise(..., MADV_HUGEPAGE) applied to it? */
> +	return vm_flags & VM_HUGEPAGE;
> +}
> +
>  unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
>  					 vm_flags_t vm_flags,
>  					 enum tva_type type,
> @@ -188,9 +216,7 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
>  		 * Enforce THP collapse requirements as necessary. Anonymous vmas
>  		 * were already handled in thp_vma_allowable_orders().
>  		 */
> -		if (!forced_collapse &&
> -		    (!hugepage_global_enabled() || (!(vm_flags & VM_HUGEPAGE) &&
> -						    !hugepage_global_always())))
> +		if (!can_thp_collapse_file(vma, vm_flags, forced_collapse))
>  			return 0;
> 
>  		/*

I think 'thp_' in all of this is confusing.  DAX isn't THPs.  PFNMAPs
aren't THPa.  There's other reasons to implement huge_fault that aren't
THPs.  Can we rename all of this to drop the 'thp_' string, starting
with thp_vma_allowable_order()?
