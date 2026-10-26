Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793025431;
	b=zy8fNJUrbVcaFrfUfD/tg5+hJQRBPlJZqcHfAITbkWcxKKqv2u/mrd0MzTBnB485qKpa
	 h0j+QRjRajWJ7IRgb+89lpLL4dekz9Gj0pRZuL3Sy+G3vVj8nE+vQvcruTDAo7F6/9cRq
	 rHQ81f+BX43KSHfRCBoOiapMotJrXTXowEs0i5K00KVC4dzA75nYUrz2sL/L+a0SJpJzT
	 DfB/Wyapf8Hl3SVq1/C/4Gmo1SGmillByytIkJp1/LOu5T3hvjpfpJxovQbbgGePV9maE
	 +kP106chfmOqj18Gb4oR89p0MPJILrH2SXoOeBGSpuOMC3n2IpvYAZSCVtjF9Bggrog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793025431;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=sl9wycySHELWIYxBYAxwb0s27UAcNsM0vqaNzM0OM3o=;
	b=iIaG2tDOfsk+2agTgZGIeis0ucfBebeuCTUyTs0PkrJrh9nXKkejjPpdOtoiiGdPw9GX
	 +wPNByPmmX0wxDyjuymraZtZOdhzI+c+Ns40pWm51u5XcqboxG1fUsDII4VkO9Gq0X/fV
	 s5TDlSPP7moUScQRD6JgkNLqRuW4vVheg+cEul+ZYU4fCBm3ynFQmRd/xSoWt18hJH1V7
	 Sdxkxnn9fhZb6SxuvmQl41Kni5GZwQrGJWay95tGZWBGwa/mzM6YUcjvn/XTtZ2nIi9sR
	 McZyt2MrYb9VlUqX8W1/7+ps9DHSz9VaytqiG9aMTyQFjExAKIygenefFmSNlTaFBAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Ka/7Sxsk";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0819606A31A;
	Mon, 26 Oct 2026 14:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ka/7Sxsk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA76F1F01825;
	Mon, 26 Oct 2026 14:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793025430;
	bh=sl9wycySHELWIYxBYAxwb0s27UAcNsM0vqaNzM0OM3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ka/7SxskYU2X8HL9aFrMsSmohChlAIIZ8CqxW5S8KxSfV/fmq5SxQPV1sJOqYwepk
	 61cs3TwGMcQOa7Ma1/IW9h7U5F67h9S4kMsQaaTaYkPDuvYpWyrnCbZaByHyM4gN9G
	 LFr9UBBC1GKpUxScLdzwZ1kqVkzNcseCy6PRhYemqbFTymHwK8dItOaB19+4lUisDU
	 1UkWga42Y1EU9ifGgERxGI3o5x+QT9zmNpRgYN40KcKFvD9v6NkDftUdA2Yoh2t1Wf
	 GJkmfyxuLbdXZRMtWVwp7vueyBAUxQBl35c7aVJE1qyA8/xKa3U5BMpLqJuMY7WFAJ
	 EL+YIbmiq6Mtg==
Date: Mon, 26 Oct 2026 14:37:05 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Ngoc Quy <ngocquy0700@gmail.com>
Cc: akpm@linux-foundation.org, liam@infradead.org, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] fs/proc/task_mmu: pin mm_users in do_pagemap_scan()
Message-ID: <at9jXXDoMLi3X2EF@gremlin>
References: <20261014095540.3261469-1-ngocquy0700@gmail.com>
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
In-Reply-To: <20261014095540.3261469-1-ngocquy0700@gmail.com>

On Wed, Oct 14, 2026 at 04:55:40PM +0700, Ngoc Quy wrote:
> The PAGEMAP_SCAN ioctl takes mmap_read_lock() on an mm obtained from
> /proc/<pid>/pagemap without holding a reference to mm_users.
>
> proc_mem_open() deliberately grabs only mm_count, so a consumer that

NIT: just say mmgrab() here. Its comment already explains the
mmget_not_zero() semantics.

> touches the address space has to call mmget_not_zero() first. Every
> other consumer in this file does -- m_start(), do_procmap_query(),
> show_smaps_rollup() and pagemap_read() -- but do_pagemap_scan() does
> not.
>
> Without that reference the target can reach exit_mmap() concurrently,
> and exit_mmap() calls unmap_vmas() while holding mmap_lock only for
> reading, which does not exclude the scanner. For ordinary VMAs this is
> harmless, as free_pgtables() and remove_vma() run afterwards under
> mmap_write_lock. A shared hugetlb VMA is different: __hugetlb_zap_end()
> frees the VMA's hugetlb_vma_lock inside the read-locked phase.
>
> walk_hugetlb_range() can therefore load vma->vm_private_data, have the
> lock freed underneath it, and then down_read() a freed rw_semaphore.
> The load happens before the freeing side clears the pointer, so this is
> a use-after-free and not a NULL dereference. Any unprivileged user can
> reach it with no huge pages configured, as hugetlb_reserve_pages()
> allocates the lock before the VM_NORESERVE early return.
>
> Pin mm_users across the scan, the way the other consumers do. mmput()
> from the exiting task can then no longer reach exit_mmap() while a walk
> is in progress.
>
> Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and optionally clear info about PTEs")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5

This is the old-format tag, but the tag is no longer required, so let's
just drop it.

Instead, write something under the --- about AI usage.

> Signed-off-by: Ngoc Quy <ngocquy0700@gmail.com>

LGTM so:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  fs/proc/task_mmu.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 5c54aebe2118..8825b01f5e38 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -3231,15 +3231,18 @@ static long do_pagemap_scan(struct mm_struct *mm, unsigned long uarg)
>  	size_t n_ranges_out = 0;
>  	int ret;
>
> +	if (!mm || !mmget_not_zero(mm))
> +		return -ESRCH;
> +
>  	ret = pagemap_scan_get_args(&p.arg, uarg);
>  	if (ret)
> -		return ret;
> +		goto out_mmput;
>
>  	p.masks_of_interest = p.arg.category_mask | p.arg.category_anyof_mask |
>  			      p.arg.return_mask;
>  	ret = pagemap_scan_init_bounce_buffer(&p);
>  	if (ret)
> -		return ret;
> +		goto out_mmput;
>
>  	for (walk_start = p.arg.start; walk_start < p.arg.end;
>  			walk_start = p.arg.walk_end) {
> @@ -3294,6 +3297,8 @@ static long do_pagemap_scan(struct mm_struct *mm, unsigned long uarg)
>  		ret = -EFAULT;
>
>  	kfree(p.vec_buf);
> +out_mmput:
> +	mmput(mm);
>  	return ret;
>  }
>
>
> base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
> --
> 2.53.0
>

--
Cheers, Lorenzo
