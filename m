Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F078E1FB1;
	Thu, 24 Sep 2026 07:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790234372; cv=none; b=uJJTYAiVn2GHZ2v7hHStbEKAOftetc3RXXZRQRmcsU1ijDKuMU6KsB/QfxCdOwoY8OAnKsb7BMgnd46TNSfB1oDxXFyuEsINl0ODZcP5IiAzHDfHL6qaNAtgD3yVZOBhK6DwOmkjX17NDgk7nOyx5yHq3XFr/U08GODech+JUQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790234372; c=relaxed/simple;
	bh=E05+bHXFCopTh54aMIB75+V6H9AcsfKr0sltighp1tA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QafvEVBhxuOJX8VoLrEAtic7FjtXcE5Neb4ukFZbAwiqQBdgb/ml8LtRmXv1ZofmDZb+NQ+qlsW8JfWzwqAn5vUxm4amAjMdLG1sYscZmJsHCJspxlgeIkI1Q8UaLeuh8WYCCYQWttOtOw43VpCp5SePA0Cc0ftmlLFYinyoRDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b4iXV3Na; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b4iXV3Na"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB2501F000FF;
	Thu, 24 Sep 2026 07:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790234370;
	bh=HRGpzjaTceiGt52QZ0R/rEbnbWW0z7ilUt0hAEkQ7UI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=b4iXV3NabyOxUcBPZ8lgAovkC6m2VuuSKldwe0olRSxe98ajOQgDN/wubgMNxfblC
	 DG06jdpCLXpNrYvcVcI+dZZACChVDXYmK7wITwUltHVKHWlavEfGXflk3uqbZcq2eS
	 HTrLyut3xvn0gueitiwmIZtGd5Sou6IvK0NSRcicaAWLu3orguL3ENfH7fe9PEMWWm
	 /lEADdsAFofMOWo3QvSz/XvZYt4zJXRTDfbXoj1xDlxk0nkfggUgxJTriNLZ5sKQY9
	 BbminPUgyo9WdKHRQ69iA7zv3YRLyCg46fUZdpwDV6AIzV/yzuzwgZYJehpnaLi0Az
	 dngTMEtU1HIog==
Message-ID: <a4bf1f96-787d-4c1e-9bef-52ab2be570ae@kernel.org>
Date: Thu, 24 Sep 2026 09:19:26 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/vma: predicate setting mmap_prepare VMA fields on new
 vma alloc
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <liam@infradead.org>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>
Cc: Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260923-fix-mmap-prepare-overwrite-v1-1-3b3f1bfcdf5e@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Content-Language: en-US
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <20260923-fix-mmap-prepare-overwrite-v1-1-3b3f1bfcdf5e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/23/26 19:45, Lorenzo Stoakes (ARM) wrote:
> It only makes sense to manipulate VMA fields if a new VMA was allocated,
> rather than merged.
> 
> VMA merging does not compare vm_ops or vm_private_data, so a merged VMA
> keeps its own, which is also what the legacy f_op->mmap path does since it
> never touches an existing VMA.
> 
> Currently, these fields will get overwritten by whatever state is
> established in the mmap_prepare hook, and if the VMA was merged,
> vm_ops->mapped will not have been called, so this could destructively clear
> existing state without replacing it with anything valid.
> 
> There is an implicit requirement that vm_private_data and vm_ops are
> fungible across VMAs which means that losing the 'new' state is
> fine.
> 
> However in this case the 'old' state is being overwritten by potentially
> invalid 'new' state, so this must be rectified.
> 
> Additionally constify have_mmap_prepare while here.
> 
> All existing in-tree users either derive state for the tree or are
> unmergeable due to VMA flags, so this has no direct impact.
> 
> Fixes: c84bf6dd2b83 ("mm: introduce new .mmap_prepare() file callback")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
> Note that this is cc: stable to account for any possible back-ports that could
> break it (unlikely)

Does it mean that patches are on the way to mainline that will break it, but
it's unlikely they will be backported? Or there are no such patches yet?
Just curious... if it's the first case then with the amount of random stuff
that goes to stable these days, I'd rather assume they could be backported
at some point :)

or out-of-tree modules which might be affected.

That is never a concern, and even suggesting it can bring hch's wrath ;)

Anyway,

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>


> ---
>  mm/vma.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/vma.c b/mm/vma.c
> index 9f0a0acf694a..6cde67883fb0 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -2849,7 +2849,7 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
>  {
>  	struct mm_struct *mm = current->mm;
>  	struct vm_area_struct *vma = NULL;
> -	bool have_mmap_prepare = file && file->f_op->mmap_prepare;
> +	const bool have_mmap_prepare = file && file->f_op->mmap_prepare;
>  	VMA_ITERATOR(vmi, mm, addr);
>  	const pgoff_t anon_pgoff = addr >> PAGE_SHIFT;
>  	MMAP_STATE(map, mm, &vmi, addr, len, pgoff, anon_pgoff, vma_flags, file);
> @@ -2892,7 +2892,7 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
>  		allocated_new = true;
>  	}
>  
> -	if (have_mmap_prepare)
> +	if (have_mmap_prepare && allocated_new)
>  		set_vma_user_defined_fields(vma, &map);
>  
>  	__mmap_complete(&map, vma);
> 
> ---
> base-commit: fe2ec83746e501645709761605c2464a44fd2929
> change-id: 20260923-fix-mmap-prepare-overwrite-6304d112a4c7
> 
> Best regards,

