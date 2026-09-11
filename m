Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACAA39B97B
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 09:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789119679; cv=none; b=p9oBPdNPtSfAGx23mZa55P9EU/eUZl7x90ThRrWCXFT8a3riTy5a2Iy0y4U/vpiLMGZQJHf0zFj5hl/evKNBpGWYgmI2svB0jvebOarX5igDtu/x7DZ9fOp0HUTIJ2fqPevmKEYvAc/RoB/yTyyCMyTU6pcVcKmHUoYuX5jPhRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789119679; c=relaxed/simple;
	bh=2+jczKteIHzJyYCYbP+WBeaOVn3I6zMgPlzs/cAd5+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dMLtBRl103GsEHOdSygTcEQd8RBRE/Jh0YgB/LFFJCsBuF8WIZgXrdCKRNna1lEGgQu1U76zRxDIDoN0d0sZ1hXHfuW7se6JNEQpvp3nwR7/CX4RCWSolESJudLEUyGe7UZ1YeNUf4s9+gcV3/RAz9SNo4n6r+/FRdVU9VKFRrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A61vDJzi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A61vDJzi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3F761F000FF;
	Fri, 11 Sep 2026 09:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789119677;
	bh=3k0OpGoq5QlyfuSaz4OOyxO3YKRUGvm5bQOF4Mkgy0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=A61vDJziBaia5kp0cwTJViPqTZ7H9Cu75hbja6lpVnR4I2e5pQRIEfY4A+qG6F6DP
	 g2WAP9eH88c4apWZm8HF162/+m9Xjv4JY7oLhPDX9TNs4dHO5d84J0t3w168bJfjHq
	 uWKLqIcqlXzRINsjatRkL7E8UB1SNiO4Kfe3zbf95kiCF9sUxnfM6LHDuKLZ82/Tn2
	 wqapHSJ2tv2sIyEW5Bs7yOONpcq2ezs/4iZ032LUpyat7nxllNCTJr5wj++4waiC/9
	 FoNu4mZx9pzwu7wqa9yeJVBM68LZ8uXpfg/j1dO4LnimVdCVSz2lbfzkBm6Efklnsi
	 cOJI3wf2nRgNw==
Date: Fri, 11 Sep 2026 10:41:12 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, 
	syzbot+f12658786a4153df5113@syzkaller.appspotmail.com, "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, 
	Kunwu Chan <kunwu.chan@gmail.com>, Pedro Falcato <pfalcato@suse.de>, Jann Horn <jannh@google.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Li Xinhai <lixinhai.lxh@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.6.y] mm/mremap: reset unfaulted VMA page offset for
 MREMAP_DONTUNMAP
Message-ID: <aqPMrf0-Wo_39sry@gremlin>
References: <2026090957-drearily-trickily-5875@gregkh>
 <20260911023102.76301-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911023102.76301-1-sashal@kernel.org>

On Thu, Sep 10, 2026 at 10:31:02PM -0400, Sasha Levin wrote:
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
> index d458ef218a372..d35f603c9738e 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -714,8 +714,18 @@ static unsigned long move_vma(struct vm_area_struct *vma,
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
