Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B493CD8CC
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 09:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789120229; cv=none; b=lXAFCKQQ7FKTs4p/850pyYdMtZx0vqCV9VZe+jPzc7BSqoaVAv5LYJTKO23G09ULpiuAITWIc1mnvgMJiqZlkgs8bkwFTjBD/cn4Y4IFOGygRHZlfAJipBn+cKX0FrhOaqrLgbYp1Yng79X8u58pjavYaNyVrAeeXjOSags79qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789120229; c=relaxed/simple;
	bh=rVL01TaLnHW8H0LCfH4GlcuzzMETN90ScixHjfFy8eU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tf9jwdFrje70jH+dpngJYqN9kBM20XPzIkMXWXDxUheujLRYnM9t4uPvhCK3xTL7yzb4I7ycuSkVVkkOCjAkDfaeYrB9R3pezGAMiIQ9leSPeY3DI5W/ekG0Prqy/VZaAiSLPFczZKluyna0JYkJglZ4aiKAufa/9OlNLM4qqOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iea/XOMi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iea/XOMi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F27751F000FF;
	Fri, 11 Sep 2026 09:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789120227;
	bh=g0gNaoHVfHS+EGasX+iXi3FtntjGw2Az+l6/nMQ1Ir0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Iea/XOMirGsaC5jpXPOyEEHA++1Bsi0geiDk5Af2E40+LuTayOPTIRuK+RD465jlW
	 hJhzksLXBpu3q38RAH/0xVDB1LFaB3wt6KNnrZN7tEcKMWXqb4XTk59pvZ9n1gexIT
	 HQvjr6pih/tCz7dgaXdlDsbWnhIOej26X8HoYTqoCU+5Ds9ZoaVtWZ1cJCC5fga+KB
	 gxe1W210M8FIl+jWsYjIKesN3oc5UQ3Db8Nv+KtQQQQ5gFTXhaUw0DQcW5v0D4uphS
	 PeNiXLC3ETYwsK4JMbd/aqT9RqAJKlWsZMIVRzw/iqD6D4beoXbPBrzRDvQmSGQQPC
	 TCI3c8KWqtQSQ==
Date: Fri, 11 Sep 2026 10:50:23 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, 
	syzbot+f12658786a4153df5113@syzkaller.appspotmail.com, "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, 
	Kunwu Chan <kunwu.chan@gmail.com>, Pedro Falcato <pfalcato@suse.de>, Jann Horn <jannh@google.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Li Xinhai <lixinhai.lxh@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.18.y] mm/mremap: reset unfaulted VMA page offset for
 MREMAP_DONTUNMAP
Message-ID: <aqPO1_UkomLmDeIO@gremlin>
References: <2026090956-species-gyration-6377@gregkh>
 <20260911012356.4072187-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260911012356.4072187-1-sashal@kernel.org>

On Thu, Sep 10, 2026 at 09:23:56PM -0400, Sasha Levin wrote:
> From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
>
> [ Upstream commit 35b0fb391b0df57383bc15985bb769f4555c97ba ]
>
> Uniquely an mremap() invocation using the MREMAP_DONTUNMAP flag can reset
> a faulted VMA into an unfaulted one.
>
> It does so after the page tables have been moved to the copied VMA with
> MREMAP_DONTUNMAP leaving the old VMA in place which is naturally unfaulted
> as the page tables it had are no longer present.
>
> However, in doing so, it violates the invariant that the anonymous page
> offset of an unfaulted VMA is vma->vm_start >> PAGE_SHIFT.
>
> This is because a VMA may have been faulted in, mremap()'d (causing a
> delta between its page offset and vma->vm_start >> PAGE_SHIFT), and then
> mremap()'d again with MREMAP_DONTUNMAP resulting in the unfaulting.
>
> This condition is a violation of a fundamental assumption in mm, but now
> also triggers an assert in assert_sane_pgoff() which explicitly checks for
> this condition.
>
> Correct it by resetting the VMA's page offset at the point of completing
> the MREMAP_DONTUNMAP operation.
>
> Link: https://lore.kernel.org/20260825-fix-mremap-dontunmap-pgoff-v1-1-39a40b2c98b3@kernel.org
> Fixes: 1583aa278f5f ("mm: mremap: unlink anon_vmas when mremap with MREMAP_DONTUNMAP success")
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Reported-by: syzbot+f12658786a4153df5113@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/6a87853b.ae6ddae5.3da009.0023.GAE@google.com/
> Tested-by: syzbot+f12658786a4153df5113@syzkaller.appspotmail.com
> Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> Cc: Jann Horn <jannh@google.com>
> Cc: Liam R. Howlett <liam@infradead.org>
> Cc: Li Xinhai <lixinhai.lxh@gmail.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> [ adapted VMA page-offset helpers to use the branch’s single vm_pgoff field. ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>

LGTM thanks!

> ---
>  mm/mremap.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 419a0ea0a8708..bdf63ffaad3d5 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -1247,18 +1247,29 @@ static void dontunmap_complete(struct vma_remap_struct *vrm,
>  {
>  	unsigned long start = vrm->addr;
>  	unsigned long end = vrm->addr + vrm->old_len;
> -	unsigned long old_start = vrm->vma->vm_start;
> -	unsigned long old_end = vrm->vma->vm_end;
> +	struct vm_area_struct *vma = vrm->vma;
> +	unsigned long old_start = vma->vm_start;
> +	unsigned long old_end = vma->vm_end;
>
>  	/* We always clear VM_LOCKED[ONFAULT] on the old VMA. */
> -	vm_flags_clear(vrm->vma, VM_LOCKED_MASK);
> +	vm_flags_clear(vma, VM_LOCKED_MASK);
>
>  	/*
>  	 * anon_vma links of the old vma is no longer needed after its page
>  	 * table has been moved.
>  	 */
> -	if (new_vma != vrm->vma && start == old_start && end == old_end)
> -		unlink_anon_vmas(vrm->vma);
> +	if (new_vma != vma && start == old_start && end == old_end) {
> +		const pgoff_t pgoff_unfaulted = vma->vm_start >> PAGE_SHIFT;
> +
> +		unlink_anon_vmas(vma);
> +		/*
> +		 * The VMA is now unfaulted and it is an invariant that
> +		 * unfaulted anonymous VMAs have page offset equal to
> +		 * vma->vm_start >> PAGE_SHIFT.
> +		 */
> +		if (vma_is_anonymous(vma) && !vma->vm_file)
> +			vma->vm_pgoff = pgoff_unfaulted;
> +	}
>
>  	/* Because we won't unmap we don't need to touch locked_vm. */
>  }
> --
> 2.53.0
>

--
Cheers, Lorenzo
