Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7214837E5D7;
	Tue, 15 Sep 2026 04:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789447752; cv=none; b=uTjFmo6zp7uv4uqyedqqdI7bDCERvQ3+r/7QK0t207aJLVkqAFeRdxZHxgResEscSOHZ5XYMzZwIUZe9Yo6OOD+lAo0ZitW5uVJogL/k9dxVbmud/rlrXX8fPrwnET0VZv5XMJeK3Vf7+YgZ67q9AZGAOVgyE4198BPTBGv+ACw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789447752; c=relaxed/simple;
	bh=vdkCvwfXIzsD0cJPJGZ7snyCG8l/wtQ6Xc3k96wpsF4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=J1RRKxvAxSZI37M/iSB0uhdUmxd0zvKwGpiSlufnNUkFQjeoi80zdnSQcMkQ3vtA/w1+CaBO39/c8E/3G4M+f1lblS4XhraX0QBeGhcdJr91dWqxq+yGQ/Dbd2LrvJMjA/UyyYPFnb6so8e5LKWSi28YmXYUwdS3+tG+L3P4/qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Y1XOSA9m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Y1XOSA9m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72F641F000FF;
	Tue, 15 Sep 2026 04:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1789447751;
	bh=SBi1oH0/CTNATCkjFwhK+8zaxvaVE7CGcZmLnTYGtxo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Y1XOSA9m0nN9zLzax/SfzWcFsuLnMJKkYnksyk08t120nLnejZYf5YU5lNLBJWkHB
	 eTboNh/c/oQJHhNFJBFoXaPY5X3tRDxtwiwMY94sW+i8jtMoCiWgsfQV82syPf1Fsd
	 o32hT4L6yqA8zPT1Dl1pVl80dSp+UXQmqVu8VcJ4=
Date: Mon, 14 Sep 2026 21:49:10 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com, liam@infradead.org,
 ljs@kernel.org, vbabka@kernel.org, jannh@google.com, pfalcato@suse.de,
 peterx@redhat.com, jgg@ziepe.ca, david@kernel.org, sashiko-bot
 <sashiko-bot@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] proc/task_mmu: handle special PMDs in clear_refs and
 pagemap
Message-Id: <20260914214910.a22cfcdc250bfbb6b14edaf8@linux-foundation.org>
In-Reply-To: <20260912122822.3348978-1-gourry@gourry.net>
References: <20260912122822.3348978-1-gourry@gourry.net>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 12 Sep 2026 08:28:22 -0400 Gregory Price <gourry@gourry.net> wrote:

> mshv_vtl_low can install a special PMD from a PFN supplied in the mmap file
> offset.  That PFN need not have a memmap entry.  Reading /proc/PID/pagemap
> or writing /proc/PID/clear_refs for such a mapping oopses the kernel.
> 
> With a test driver mapping the PFN at the 1 TiB mark:
> 
>   echo 1 > /proc/self/clear_refs
> 
>   BUG: unable to handle page fault for address: fffffb5b80000008
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   RIP: 0010:clear_refs_pte_range+0xb1/0x1e0
>   Call Trace:
>    walk_pgd_range+0x50a/0xad0
>    __walk_page_range+0x6a/0x1d0
>    walk_page_range_mm_unsafe+0x193/0x230
>    clear_refs_write+0x18e/0x3f0
> 
>   pread(pagemap_fd, buf, 512 * 8, addr / PAGE_SIZE * 8)
> 
>   BUG: unable to handle page fault for address: fffff57840000008
>   RIP: 0010:pagemap_pmd_range+0x3cf/0x6b0
>   Call Trace:
>    walk_pgd_range+0x50a/0xad0
>    __walk_page_range+0x6a/0x1d0
>    walk_page_range_mm_unsafe+0x193/0x230
>    pagemap_read+0x1dc/0x350
> 
> clear_refs_pte_range() passes the PMD to pmd_folio(), while
> pagemap_pmd_range_thp() uses pmd_page() followed by page_folio().
> 
> Both paths assume the PFN has a struct page and dereference bad address.
> 
> Use vm_normal_folio_pmd() and vm_normal_page_pmd() so clear_refs skips
> folio operations and pagemap skips folio-derived flags for special PMDs.
> This matches the PTE paths, which already use vm_normal_folio() and
> vm_normal_page().
> 
> Fixes: 3c8e44c9b369 ("mm: mark special bits for huge pfn mappings when inject")
> Cc: <stable@vger.kernel.org> # v6.19+

Why cc:stable?  Is a crafted test driver the only way of hitting this?


> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1671,7 +1671,9 @@ static int clear_refs_pte_range(pmd_t *pmd, unsigned long addr,
>  		if (!pmd_present(*pmd))
>  			goto out;
>  
> -		folio = pmd_folio(*pmd);
> +		folio = vm_normal_folio_pmd(vma, addr, *pmd);
> +		if (!folio)
> +			goto out;
>  
>  		/* Clear accessed and referenced bits. */
>  		pmdp_test_and_clear_young(vma, addr, pmd);
> @@ -1991,7 +1993,7 @@ static int pagemap_pmd_range_thp(pmd_t *pmdp, unsigned long addr,
>  		goto populate_pagemap;
>  
>  	if (pmd_present(pmd)) {
> -		page = pmd_page(pmd);
> +		page = vm_normal_page_pmd(vma, addr, pmd);
>  
>  		flags |= PM_PRESENT;
>  		if (pmd_soft_dirty(pmd))

