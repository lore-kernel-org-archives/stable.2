Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FEE4570E9;
	Thu, 15 Oct 2026 08:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792051814; cv=none; b=DS5pPHZnhHFTgVV31DvaG2PrOKvLyCi9KOMkGMBR/g4Oush9G3PjPn5jj+fs7dqPe1wYZuKczOE1Bs1d/V+tgJXNY+iRwfWEPHu20LV3N64nujiMMirN7fAnol0EbYANsDa68PeMWXZdb5ZcbSHpiqfC6nH4DdElBfmpTRj0XLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792051814; c=relaxed/simple;
	bh=N0KJjco2uBGWOg39Z4IE9grj6eA3NXsEsSdWeWukG94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ingc0SaheECS5Vawf5QQ43FF+yJGDZLacDwgQNHJDJIEteOpyN72YA8YD9PTwn3OVdiWzynjaDM407c9O6K8ie8fdsiYyEpVBCIp2R0NwLd8PXFT3kP49FgNKQ7QNP+/CY/iq8DchDeTcEDXlNtt5wqEX2X5YMlK9wOwKUEiGac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLA1R6w7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLA1R6w7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79FBD1F000C4;
	Thu, 15 Oct 2026 08:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792051811;
	bh=kWANQrIBt+o5Te9K+Cx4q+iilLxoAqyqlNJJibWJAUw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bLA1R6w7ZavorYN62P5qil0DosQzk1pbJRNUM6tiRIoWrGtDWk6W5nD0SalKwKr2/
	 ms/ID6/ryqzAt6lnJLkqufJHlmor4EDZogFhelj4cNRSxidzpBoCFF0Tz9zFmHkG/p
	 Fk0wGna58goiPOaWYuA8vd3LNlkp2keP3e6zQcW9NMXxGdiSIQchqDiwxNhR1vlWgX
	 5d7gfRyNhMYabni2VHceeqQqYImFVQSGkk3+yH+0VSc1YLQcc54U9ebvNg3nDQUiso
	 nM0ILsn1mTqtAytkcdiI5dEFvU0trYHQm4zDMFZR79Y208gbanKandvk/RfyjfqVkp
	 N8d/u8cdYRjcg==
Date: Thu, 15 Oct 2026 11:10:05 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Arnav Kansal <rnv@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Rohan Kumar <rohakum@google.com>
Subject: Re: [PATCH] mm/execmem: only free ROX cache vm_struct when fully
 unused
Message-ID: <atCKXeWnVAWvhSn0@kernel.org>
References: <20261014233058.1410692-1-rnv@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014233058.1410692-1-rnv@google.com>

On Wed, Oct 14, 2026 at 04:30:58PM -0700, Arnav Kansal wrote:
> execmem_cache_clean() currently uses:
> 
>     IS_ALIGNED(size, PMD_SIZE) && IS_ALIGNED(mas.index, PMD_SIZE)

This is not the case anymore:

https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/mm/execmem.c?id=569db54d8b7a4ec463a62c444de0d6f5f10e9dc1
 
> as a proxy to determine whether a free range in execmem_cache.free_areas
> spans an entire unused vm_struct that can be returned to vmalloc.
> 
> This heuristic is broken in both directions:
> 
> 1. Premature vfree() of multi-PMD vm_structs (Use-After-Free):
>    When execmem_cache_populate_alloc() services a request larger than
>    PMD_SIZE (for example, a module with > 6 MiB of .text),
>    alloc_size = round_up(size, PMD_SIZE) creates a single multi-PMD
>    vm_struct (e.g., 8 MiB) whose remaining tail space is handed out to
>    subsequent module allocations (e.g., kvm.ko). When a module inside
>    that vm_struct unloads and leaves a PMD_SIZE-aligned free sub-range
>    (such as a 2 MiB or 4 MiB chunk at the start of the 8 MiB vm_struct),
>    execmem_cache_clean() passes the IS_ALIGNED() check and calls
>    vfree(area), which unmaps and frees the entire enclosing multi-PMD
>    vm_struct while sibling modules are still live:
> 
>      BUG: unable to handle page fault for address: ffffffffc07dc030
>      #PF: supervisor instruction fetch in kernel mode
>      #PF: error_code(0x0010) - not-present page
>      PGD 2c33067 P4D 2c33067 PUD 2c35067 PMD 0
>      Oops: Oops: 0010 [#1] SMP NOPTI
>      RIP: 0010:dummy_exit+0x0/0xfd0 [tailm]
> 
> 2. Failure to reclaim fallback vm_structs:
>    After commit 3bd4e0ac61b2 ("execmem: add fallback for failures in
>    vmalloc(VM_ALLOW_HUGE_VMAP)") and commit 4afb85f5e359 ("mm: remove
>    PMD alignment constraint in execmem_vmalloc()"), ROX cache vm_structs
>    allocated via the base-page or exact-size fallback paths are only
>    PAGE_SIZE-aligned in address and/or size, so they never satisfy the
>    PMD_SIZE alignment check even when completely unused.
> 
> Because vmalloc allocations include a trailing guard page, separate
> vm_struct allocations can never coalesce into a single contiguous entry
> in execmem_cache.free_areas. Replace the PMD_SIZE alignment check with
> an explicit check that the free range starts at vm->addr and spans the
> entire get_vm_area_size(vm).
> 
> Fixes: 2e45474ab14f ("execmem: add support for cache of large ROX pages")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Co-developed-by: Rohan Kumar <rohakum@google.com>
> Signed-off-by: Rohan Kumar <rohakum@google.com>
> Signed-off-by: Arnav Kansal <rnv@google.com>
> ---
>  mm/execmem.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/execmem.c b/mm/execmem.c
> index 74a178a87e75..3a1da0498fe2 100644
> --- a/mm/execmem.c
> +++ b/mm/execmem.c
> @@ -166,11 +166,9 @@ static void execmem_cache_clean(struct work_struct *work)
>  	mutex_lock(mutex);
>  	mas_for_each(&mas, area, ULONG_MAX) {
>  		size_t size = mas_range_len(&mas);
> +		struct vm_struct *vm = find_vm_area(area);
>  
> -		if (IS_ALIGNED(size, PMD_SIZE) &&
> -		    IS_ALIGNED(mas.index, PMD_SIZE)) {
> -			struct vm_struct *vm = find_vm_area(area);
> -
> +		if (vm->addr == area && get_vm_area_size(vm) == size) {
>  			execmem_set_direct_map_valid(vm, true);
>  			mas_store_gfp(&mas, NULL, GFP_KERNEL);
>  			vfree(area);
> -- 
> 2.47.0

-- 
Sincerely yours,
Mike.
