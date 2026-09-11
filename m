Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4C147253B
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 11:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789126271; cv=none; b=NPjIIsGsYJYm4B9lZgYUxigWBT45qdWskC6nmBRVue7cqRPQ7NSO+LpnwHeoKjtboVOFa6B13+8v6Y5MgjJf2XMbqIXi7Lk3YS5vmt6tslhezPyZmfwjMjCKdkgATp2wIHjghnrPLnZJd/eD14TEIZd89T8v0M7R+hfEJiveR3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789126271; c=relaxed/simple;
	bh=aXHZFKzp7KKHSROF+4hajymCQEQmPKOTDIaQcWssCCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cYnDGgDatNontIlHBDw0JtmWIEpUEaK622bhK5SeJ3xzqTtKt0trCzqRkqBnp2j96P8GHJ5Hxdrc50ovDbx861zdcD/bqlkN6gupsJ6/YNfuaxPDE2xhG+9PNJKv3krwrEaA7TCL2u7Qy84yKTD5UTEKM3tVtPpyHrBJBP/QV1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5MIA6cW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5MIA6cW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AFC81F00893;
	Fri, 11 Sep 2026 11:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789126241;
	bh=JLDguK72poQnyLr74+nBuVf1gdJYE8eUdstTAnsfiso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=D5MIA6cWvBHcujMU0GIM7hbsVAJhNLC14zLY/gzVLcF09zcQ2vLK0WxQiIsFUhqsA
	 Abz4Sm0itxb6znKOVH7oZBmssFDEwAvmPejeAJW4jAS70hKmhx0WJSpircKQAfxMtD
	 17uF4lOByn6FmAnE48MMkHA3Hh3lSgAzYS/cTJfOTVaBHzzZKr8BYCneeZ09O1HG6U
	 cHvZPXBzINILlzpp29lQ3K1DbObMNU+02d5Qf2mB9AtCHA4JP0yJI1JpnzxsMA5UVw
	 YuI6EBFr6a9dH1V/BcZE4RZjOiX+93lqV6vF6Cs8TcPzRl9Z5HZin3Y0orJEnhhSQg
	 IFnR2V6CL02lA==
Date: Fri, 11 Sep 2026 12:30:36 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, 
	syzbot+f12658786a4153df5113@syzkaller.appspotmail.com, "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, 
	Kunwu Chan <kunwu.chan@gmail.com>, Pedro Falcato <pfalcato@suse.de>, Jann Horn <jannh@google.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Li Xinhai <lixinhai.lxh@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.1.y] mm/mremap: reset unfaulted VMA page offset for
 MREMAP_DONTUNMAP
Message-ID: <aqPmVcALiV5DmxVj@gremlin>
References: <2026090958-velcro-gorgeous-9f6f@gregkh>
 <20260911104147.197495-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911104147.197495-1-sashal@kernel.org>

On Fri, Sep 11, 2026 at 06:41:47AM -0400, Sasha Levin wrote:
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
> [ adapted dontunmap_complete() changes to move_vma() using direct vm_pgoff assignment instead of unavailable helpers. ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>

LGTM, thanks!

> ---
>  mm/mremap.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 6ed28eeae5a84..7e39614d2e0e6 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -693,8 +693,18 @@ static unsigned long move_vma(struct vm_area_struct *vma,
>  		 * table has been moved.
>  		 */
>  		if (new_vma != vma && vma->vm_start == old_addr &&
> -			vma->vm_end == (old_addr + old_len))
> +			vma->vm_end == (old_addr + old_len)) {
> +			const pgoff_t pgoff_unfaulted = vma->vm_start >> PAGE_SHIFT;
> +
>  			unlink_anon_vmas(vma);
> +			/*
> +			 * The VMA is now unfaulted and it is an invariant that
> +			 * unfaulted anonymous VMAs have page offset equal to
> +			 * vma->vm_start >> PAGE_SHIFT.
> +			 */
> +			if (vma_is_anonymous(vma) && !vma->vm_file)
> +				vma->vm_pgoff = pgoff_unfaulted;
> +		}
>
>  		/* Because we won't unmap we don't need to touch locked_vm */
>  		return new_addr;
> --
> 2.53.0
>

--
Cheers, Lorenzo
