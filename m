Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A57388390
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 09:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789119724; cv=none; b=mxsDC/cWimp1YaZGlv9q7P7HG6sxsAapkMs0StYSfeFq0XPqHvU0c04Mz8brlpWprqPUfhE8Kz8VWT7lq8PodeIS3socaWRt0s1zK+BZ66W037HG4ACJn91F21T0Us4YCzUyjk/ixBggRKe7WV0ZqdnL0Mdn1S5vE/Fk37u1o+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789119724; c=relaxed/simple;
	bh=o1y/z7Ku1dnGsg/17HxtmbCVjwmdCErA7P+qsmdg0TY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TeCQfAW+h3cUGNLp4nz4SUgDqy+hooLsSGYnzgBqESVVYNs5bi1eSNw8mPbLR03jrh5lYzam/67RlQ1dziMnMAIpjOxpIMfqY55+Pbi7ZLeScApEZ6mERKh3ze2U3DVqCrY/JVuAVJ9X0lTx/7crSUPoh+ZZV4X2KXY2ZNA6ruE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IP9YRKLn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IP9YRKLn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 812691F000FF;
	Fri, 11 Sep 2026 09:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789119722;
	bh=0yZtW6BeJcEiWxOumhdHsf42XF2Wb8UaCY0cfQFl3wM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IP9YRKLnvrdKRc+IrCzaW61+fEZ12Dter+rQSq953lFRPf26q7bxZKrgXPe08/YvA
	 S9RbWkrckCFETNn3/l4iFryi5fca1lxIw6F7pIEGrAL01GbUVtjqeETrL5eW47hWRc
	 cmeuklxV+CTO1qmkdubGt2bBf3hs1aumldaUdPhfXwFI+MQhob/ZJBJ/9B4YJfA2nI
	 1NgCoxK8P19/SekcGUpNjV06dSGJmGSbbHmaMKcgRVlc4ILOZyFPS+Wix4btkgUaMP
	 Ms4w9pAmz+Odu/ls+vQOaJ49mrgdnTRkpNiXHEFLrUpg11ISYNsRjskBvNWcnv4l6G
	 1kc8VG5Fnbzjw==
Date: Fri, 11 Sep 2026 10:41:56 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, 
	syzbot+f12658786a4153df5113@syzkaller.appspotmail.com, "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, 
	Kunwu Chan <kunwu.chan@gmail.com>, Pedro Falcato <pfalcato@suse.de>, Jann Horn <jannh@google.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Li Xinhai <lixinhai.lxh@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.12.y] mm/mremap: reset unfaulted VMA page offset for
 MREMAP_DONTUNMAP
Message-ID: <aqPMx3Tf-pC7iu7b@gremlin>
References: <2026090957-prideful-repulsive-38a0@gregkh>
 <20260911021410.42929-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911021410.42929-1-sashal@kernel.org>

On Thu, Sep 10, 2026 at 10:14:10PM -0400, Sasha Levin wrote:
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

LGTM thanks!

> ---
>  mm/mremap.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 12af89b4342a7..9685ea816fde1 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -811,8 +811,18 @@ static unsigned long move_vma(struct vm_area_struct *vma,
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
