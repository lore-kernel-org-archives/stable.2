Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00E23E4101;
	Wed, 23 Sep 2026 17:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790185621; cv=none; b=JpoBBCXl7NooicbnXTVxu+3pdyB4bZwFTLt+ocKZX20Sbro6uVTjjrahcAqBRmTcdtikQSma2B+uQQupGR0pyfIaWAfXjTeXNWs2SJTOdJAC1sNrgq7PLP2J3yyLFcN+6wGsOybbdGxJiE+Eeyrtbpozu5JH0cUMnj285BdfSl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790185621; c=relaxed/simple;
	bh=CNgHjP/DfpBaZsuxBCjqFqQRHKSt6Ce3YtFeYKzwlns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ts8h+owip2lU6FcaJbjy1Gp3AjJ/Moe8OvM3lAiZqCIEj3sYyZ+2jU64Shj6B0hNEZqlx21Ky8O1WgC8D7MxOPsfpRRnJ+TilWeG8EVdgF3Wnf62LB5BurNxYhscTUkTeo7mbZ8a42cjboze6Z5Jd5p8B/nzAylnp2EP4npMrtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZN5RbPdk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZN5RbPdk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23F9D1F000FF;
	Wed, 23 Sep 2026 17:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790185619;
	bh=lumxCHSfeWvkTjSL62YAFITk4CTnl2QQ4sojIU6xQcM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZN5RbPdkzmv7OkLuqlbDa+AhkQM07KBgjT1HVrvWkqecfImZMSDootdgSQEfoaZ49
	 liAWYiZvU178eXhSqpQmxHnm+Cy9xSACjxNpY+MzA8BRWa7PAq4K8IWb6jTn6n+JGU
	 jJRMbr1a7dxlSiEaiHS6BUFA9Tdt0ucnD+2Rsqu1eMbGN8HeaDCN8on3yrtB2LJOAE
	 3h59FsevGR6GRGVkAip/WuSz7prKgp0EAKoAp+qcOvW6Hp7/Q9FkcQvYH/SUGDD/Zd
	 2LF3KbxL1afRsHoUQLuIzNvsn1gHhul+ZihnliDRQrMd0L/lxb4wJdlTNtlmcHjw2+
	 kBECXBRG3o+xQ==
Date: Wed, 23 Sep 2026 18:46:54 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>
Cc: Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/vma: predicate setting mmap_prepare VMA fields on new
 vma alloc
Message-ID: <arQQXfnt7cw-tRzR@gremlin>
References: <20260923-fix-mmap-prepare-overwrite-v1-1-3b3f1bfcdf5e@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923-fix-mmap-prepare-overwrite-v1-1-3b3f1bfcdf5e@kernel.org>

On Wed, Sep 23, 2026 at 06:45:41PM +0100, Lorenzo Stoakes (ARM) wrote:
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

Instantly noticed a typo when I hit send (ugh).

'derive state for the tree' should be 'derive state from the file'. It's late :)

>
> Fixes: c84bf6dd2b83 ("mm: introduce new .mmap_prepare() file callback")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
> Note that this is cc: stable to account for any possible back-ports that could
> break it (unlikely) or out-of-tree modules which might be affected.
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
> --
> Lorenzo Stoakes (ARM) <ljs@kernel.org>
>

--
Cheers, Lorenzo
