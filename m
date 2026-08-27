Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295D23E49DD;
	Thu, 27 Aug 2026 08:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787819545; cv=none; b=ZsdDT/1WdOrFMJxrldA7RnM+iChMX1w8EmPaL86VkuGlNLc0nfIYzUFb9cM5qPZvfjIOwkl8XpPCR+mVWrAZxafbgn3sIZhcuvK3vrtzaduX73t89bZ4hZLSSXmyZaPHXQ8AbdOiGTWSM/viBEKnr/iN+VHNoZcu8dfxwaxPxuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787819545; c=relaxed/simple;
	bh=M21bck+NFEu8xKeBdD9HbU118hBwm+qcHuPDkVTy+50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PXnzXrLk7qRebMb9T871v/+vLCS/hA5SI83CQQhCJrACuJpOrYHM20kRv6qtNCSWaJfAsnifbaNXWY/RjMrkxy6C8RgP09SHZ7dopSygR6JZ7xJ0Dypc7StpDMsTQV4uEHy1QbyYv9CHVzLX8VFMSOUnko/oOiMXtRLREQS242c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSzghWaD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSzghWaD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C6181F000E9;
	Thu, 27 Aug 2026 08:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787819541;
	bh=ukRIzjVW3PJew+TIHS6IrkoYjfe4R4pVLgU+bG3uWL0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=HSzghWaDE8ySlLE8IXAL3A7zR55UAstoOY8K5pk/GrZfGVcuGZRHCy8t5WuZTZDu2
	 bzz5DUYMQrmdpgSQBxKADa7P59Ak/qukYQsjkJx2xN9G/HxlK1SgvITEy66G2nFS4E
	 fV/PSNxw/mqa5me1sGrPDFc3pOdaskXANHHlr8ZWFvlwoUPSnkng8IY4szbMEusVrH
	 XsAiDBBi9Ss4dxXAYIjX/s0YELdSLfp0V8FZOCyLTd7C6Taw/WqkXgqNbuYOPmDZRu
	 HhOq1zGzjTqN4zLYtNMyJt5aYGQwGjB4AL7LVDvgoyGApjsHw4pLiCmsUsPuNo0e6a
	 x/sU2NVOlFwXQ==
Message-ID: <34fa1a4d-e5fb-4e27-a53b-b57b96be3f8c@kernel.org>
Date: Thu, 27 Aug 2026 10:32:15 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/mremap: reset unfaulted VMA page offset for
 MREMAP_DONTUNMAP
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <liam@infradead.org>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Li Xinhai <lixinhai.lxh@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 syzbot+f12658786a4153df5113@syzkaller.appspotmail.com, stable@vger.kernel.org
References: <20260825-fix-mremap-dontunmap-pgoff-v1-1-39a40b2c98b3@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Content-Language: en-US
In-Reply-To: <20260825-fix-mremap-dontunmap-pgoff-v1-1-39a40b2c98b3@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/25/26 9:55 AM, Lorenzo Stoakes (ARM) wrote:
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
> This is because a VMA may have been faulted in, mremap()'d (causing a delta
> between its page offset and vma->vm_start >> PAGE_SHIFT), and then
> mremap()'d again with MREMAP_DONTUNMAP resulting in the unfaulting.
> 
> This condition is a violation of a fundamental assumption in mm, but now
> also triggers an assert in assert_sane_pgoff() which explicitly checks for
> this condition.

Oof. So what's the worst thing that could happen before the assert was
added? We'd use the "unfaulted" state to allow a merge, but the wrong
pgoff could mess up the result of the merge somehow?

> Correct it by resetting the VMA's page offset at the point of completing
> the MREMAP_DONTUNMAP operation.
> 
> Reported-by: syzbot+f12658786a4153df5113@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/6a87853b.ae6ddae5.3da009.0023.GAE@google.com/
> Fixes: 1583aa278f5f ("mm: mremap: unlink anon_vmas when mremap with MREMAP_DONTUNMAP success")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

> ---
>  mm/mremap.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/mremap.c b/mm/mremap.c
> index e8df5cdb0ac9..2b4b523a86b8 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -1331,18 +1331,30 @@ static void dontunmap_complete(struct vma_remap_struct *vrm,
>  {
>  	unsigned long start = vrm->addr;
>  	unsigned long end = vrm->addr + vrm->old_len;
> -	unsigned long old_start = vrm->vma->vm_start;
> -	unsigned long old_end = vrm->vma->vm_end;
> +	struct vm_area_struct *vma = vrm->vma;
> +	unsigned long old_start = vma->vm_start;
> +	unsigned long old_end = vma->vm_end;
>  
>  	/* We always clear VMA_LOCKED[ONFAULT]_BIT on the old VMA. */
> -	vma_clear_flags_mask(vrm->vma, VMA_LOCKED_MASK);
> +	vma_clear_flags_mask(vma, VMA_LOCKED_MASK);
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
> +		vma_set_anon_pgoff(vma, pgoff_unfaulted);
> +		if (vma_is_anonymous(vma) && !vma->vm_file)
> +			vma_set_pgoff(vma, pgoff_unfaulted);
> +	}
>  
>  	/* Because we won't unmap we don't need to touch locked_vm. */
>  }
> 
> ---
> base-commit: efecab401cb15fd3bb9bc05990609acb6b267ff2
> change-id: 20260824-fix-mremap-dontunmap-pgoff-a687134e995e
> 
> Best regards,

