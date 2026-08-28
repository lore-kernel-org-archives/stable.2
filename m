Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039B140DB48;
	Fri, 28 Aug 2026 10:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787912199; cv=none; b=Ndw0QnY33mi7LkiwJ9U20eWi+D95HfeNuPxLNpvHUMGnBA5XTD5IoqmBrXu6wRF6Hss1hg1xnDfjHcm8/UA7MQ+y4fq8dZGHBG8PlpYLfKV7c53lFAdih3HXnPig/C5V34uB1PHVSr9y9LXTcTAIo72a8veMe101aEdWvFLQLjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787912199; c=relaxed/simple;
	bh=C0tTE/2Ia3MyGbewArTi5zv6UkbgfGLgB9YNSk9B0aI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mPbgjeZyI2RFxZXgv/sNNDJ8KFj7BBMnfBPUJ1oUkwDqYPU7uyyhI5hzGWqdTSDc93hzmklxnvnfbRDR75FEc2V6m6rSRD/G+0mh4ts+tU+K8CoYZCja4ZJMHeMlc8Tj4gWwF868iXSTxUQCOUfrhgIbFTJBAAnevIGkFo4rRmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8RMXenG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8RMXenG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E8DB1F00A3A;
	Fri, 28 Aug 2026 10:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787912197;
	bh=IDNDGA/QN1kZCKHpcgE6g/Ng+sRR0OCsnBMk8IBkH5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=j8RMXenGB2gQNPG3vT/Qlw2fo1sD9YsGDD10XoJp1SaLD1SSldoNOenju912vj/Lv
	 y1HyOofWWmaPRUzhIwpzPSOq7Oe/qrwot5ZPEX5WCRroefzcv4ohqeg7Nv2Rs9JyfU
	 YDYC16GL+YNCD8HSkdg3C+/++c1liSLjowwnRbRpYVW5tMx3XC5MckHsmr8vk70QjZ
	 arXPoXFuRacQoEUnQ8zVh8N77xIpCM+PUNcC/nny5be4zJlytCRVimDK/o6ylN80wm
	 OX+0Wn0lRplLq4PO229v6TpN3ae9ocpUg+FXi3YmMLWcGAu9IolQVHgR4bh7Rondf/
	 alBQie2IXPt4Q==
Date: Fri, 28 Aug 2026 11:16:32 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Kunwu Chan <kunwu.chan@gmail.com>
Cc: akpm@linux-foundation.org, liam@infradead.org, vbabka@kernel.org, 
	jannh@google.com, pfalcato@suse.de, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/mremap: fix locked_vm accounting for MREMAP_DONTUNMAP
Message-ID: <apFa2eTBzBP0RPeb@gremlin>
References: <20260828094823.594279-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828094823.594279-1-kunwu.chan@linux.dev>

On Fri, Aug 28, 2026 at 05:48:22PM +0800, Kunwu Chan wrote:
> From: Kunwu Chan <kunwu.chan@gmail.com>
>
> When mremap() is called with MREMAP_DONTUNMAP on a locked VMA,
> vrm_stat_account() increments mm->locked_vm for the new VMA while the
> source VMA is still marked VM_LOCKED.
>
> For a normal mremap(), the source VMA is subsequently unmapped and the
> munmap path decrements mm->locked_vm, balancing this accounting.
>
> With MREMAP_DONTUNMAP, the source VMA is left in place and
> dontunmap_complete() clears VMA_LOCKED_MASK.  When the source VMA is
> subsequently unmapped, VMA_LOCKED_BIT is already clear, so the munmap
> path does not undo the increment from vrm_stat_account().  This leaves
> mm->locked_vm over-accounted.
>
> Undo the locked_vm increment in dontunmap_complete() before clearing
> VMA_LOCKED_MASK.  MREMAP_DONTUNMAP requires old_len == new_len, and
> only VMA_LOCKED_BIT is checked to match the accounting performed by
> vrm_stat_account().

Hmm I don't love this approach.

>
> Fixes: b714ccb02a76 ("mm/mremap: complete refactor of move_vma()")

Are you certain that my rework patch was what introduced it?

> Cc: stable@vger.kernel.org
> Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>

In general while the patch doesn't seem super AI-y I do see a sudden upswing in
patches from you in 2026 so I do have to ask whether LLMs were used? If so
please follow https://docs.kernel.org/process/coding-assistants.html

(I hate having to say these things but hey, it's 2026, so.)

I'm kind of inclined to do a fix myself a different way here.

Given it's going to be a backported patch and you're relatively new to mm, I
feel like this is the safer route, sorry about that.

Happy to add a Reported-by/Closes for this however.

> ---
>  mm/mremap.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/mm/mremap.c b/mm/mremap.c
> index e8df5cdb0ac..37ea5ee1986 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -1334,6 +1334,14 @@ static void dontunmap_complete(struct vma_remap_struct *vrm,
>  	unsigned long old_start = vrm->vma->vm_start;
>  	unsigned long old_end = vrm->vma->vm_end;
>
> +	/*
> +	 * vrm_stat_account() accounted the new VMA while the source VMA
> +	 * was still locked.  Since DONTUNMAP leaves the source VMA in
> +	 * place after clearing VMA_LOCKED_MASK, undo that accounting here.
> +	 */
> +	if (vma_test(vrm->vma, VMA_LOCKED_BIT))
> +		vrm->vma->vm_mm->locked_vm -= vrm->old_len >> PAGE_SHIFT;
> +

I don't love this as an approach in general.

As above, I think I will address this slightly differently.

>  	/* We always clear VMA_LOCKED[ONFAULT]_BIT on the old VMA. */
>  	vma_clear_flags_mask(vrm->vma, VMA_LOCKED_MASK);
>
> @@ -1343,8 +1351,6 @@ static void dontunmap_complete(struct vma_remap_struct *vrm,
>  	 */
>  	if (new_vma != vrm->vma && start == old_start && end == old_end)
>  		unlink_anon_vmas(vrm->vma);
> -
> -	/* Because we won't unmap we don't need to touch locked_vm. */
>  }
>
>  static unsigned long move_vma(struct vma_remap_struct *vrm)
> --
> 2.43.0
>

--
Cheers, Lorenzo
