Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794520897;
	b=SaIz2jZImyo30b0I8oWX4zf9FffIJEPDvudCDQty7nf7nCh7U9hvsCvoulJpW+AxD3m9
	 0YpfKy0GWF8KATQlZC8JXJXlRU1lIvXALuYvlc/7ddc6Uf7Dhh233ZqXEgDmghBkpKmRJ
	 YerBkVfbDX6TtlIUjLRO/vXysR7ZTKw96c9rlg6f1w8yMBU3eUDVAvKPWnut9E4m2GZ2C
	 iqQtBon8WKLo4xN+fmj99UcFJdyTWiZ5PXVml8wO+ki2D0PIz55vcICs+3cMXfkyLD8RG
	 duMCwGJdMdhnprnVwIJKho0qSNX7kAvDy+exyiZT5IBGD4qP6dvF8ToMV11LpRKXbqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794520897;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=nYAvoSz1A76P7GMxxUw4ni69cJw2k++GQ4cfCIGFRUU=;
	b=061GI6Z5HG6ZvFjc6h3uozJ0QEoXxQowozijeP3ifgV3ccv6XrZ0GqtZ+MAkjSlS4DkT
	 Hll1KQT4JCYx09psidh0TW4K61Kwmjog8j+7cG9nydYfTXgsLocUGDB1rKERH0N+3OYI9
	 /pp7bM08JjSCrB+KCqiRQt3QXx+3m5b0LIPjehwktDfZ1c01ZLDwcqES1LF29gW803Qsb
	 eriAP1U1F71iSoLl/G/ydFziRewItMDu10eTAn+C5tq7tArl/mSldtjg/UMKir+oCxyVU
	 OreomlQxYmzDCP38QSiAO/I8cqm+NNp1gEP6n3aoD/1imvhkg1ytYXAPM+WkyD+KEpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Apt7oOvV;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FC5606A31C;
	Thu, 12 Nov 2026 22:01:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79FC5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Apt7oOvV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nYAvoSz1A76P7GMxxUw4ni69cJw2k++GQ4cfCIGFRUU=; b=Apt7oOvVaHX4TicoqGSGBkX1xh
	BHtbNZyS50r5CpIeV3U1BsRvrpzJqArlV/4d0yz+S8HnDMPjS0XZC54MSwtmNxRT2HJfnvPsww+4C
	suCFcgRwSliM8e9YVKk8u+N+3YEW5Rd/w8b3oCsOSKnvA6M8C4bz6jDQsFZ884Pk1nwvwsI1A2N3n
	f+xrWkbK7qPUP+JmYRq45tq8YFBKDQRduspc6JARQPWlHSv+j52wx5eVS/gOg1H7347fjZmjN7ln4
	bOBI+JbeYHPsd96SzSym3Sc+NB/D6Hl6L7poxSBh9DBshwpDfDAjzepc6pTJbxbLIcdWsmj9ezIf8
	V5iVBaWQ==;
Received: from [38.23.173.23] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRcrQ-0000000B8jr-0gBG;
	Thu, 12 Nov 2026 22:01:36 +0000
Date: Thu, 12 Nov 2026 17:01:34 -0500
From: "Liam R. Howlett" <liam@infradead.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Li Jinyue <jinyue.li@linux.alibaba.com>
Subject: Re: [PATCH] mm/vma: update VMA iterator state on error in new VMA
 merge
Message-ID: <gp4huj53rndmngvzajdfelalmh5gkhzqv73t2v6rotmr37hgpb@g4a33cixtylu>
References: <20261027-fix-new-merge-bug-v1-1-7023a787e6b9@kernel.org>
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
In-Reply-To: <20261027-fix-new-merge-bug-v1-1-7023a787e6b9@kernel.org>

On 26/10/27 11:25AM, Lorenzo Stoakes (ARM) wrote:

I'm a bit late on this one..

> Commit cacded5e42b9 ("mm: avoid using vma_merge() for new VMAs") shared
> code between vma_merge_new_range() and vma_expand().
> 
> However in doing so, it failed to correctly restore the VMA iterator when
> vma_expand() errors out.
> 
> This is a problem when the immediately preceding VMA is mergeable and
> vmg->just_expand isn't specified, at which point the VMA iterator is moved
> to the previous VMA.
> 
> (Note that vmg->just_expand is a special case for brk(), where the
> iterator will already be positioned at the VMA to be expanded.)
> 
> Resolve things by restoring the VMA iterator on error. Use
> vma_iter_next_range() to do this, so it will correctly stop on the gap
> after the previous VMA, rather than skip to the next VMA after it (this is
> a new VMA merge, so is being applied at a gap).
> 
> To isolate the error handling, return early when a merge isn't
> possible (what the vmg->target check was doing before), then handle the
> merge success/failure case explicitly.
> 
> While here, update vma_expand() to jump to the nomem case when
> dup_anon_vma() fails, so vmg->state is correctly updated.
> 
> This doesn't impact anything in practice, but is the correct course and
> since it's part of the error path that this patch addresses, it makes sense
> to update it also.
> 
> Users are very unlikely to have observed the issue this patch addresses in
> practice, as it is near-impossible to fail an allocation for an anon_vma,
> but a process under memory pressure that receives a fatal signal could
> trigger it.
> 
> This issue was originally reported by Li Jinyue for which I am grateful. He
> indicated this was uncovered by a private syzkaller instance.
> 
> Fixes: cacded5e42b9 ("mm: avoid using vma_merge() for new VMAs")
> Cc: stable@vger.kernel.org
> Reported-by: Li Jinyue <jinyue.li@linux.alibaba.com>
> Closes: https://lore.kernel.org/all/20261025093921.1011927-1-jinyue.li@linux.alibaba.com/
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  mm/vma.c | 28 ++++++++++++++++++----------
>  1 file changed, 18 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/vma.c b/mm/vma.c
> index af8e65ada23b..d416ba58eb4c 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -1141,6 +1141,7 @@ struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg)
>  	struct vm_area_struct *next = vmg->next;
>  	unsigned long end = vmg->end;
>  	bool can_merge_left, can_merge_right;
> +	bool move_iter_back = false;

The name move_iter_back is a bit confusing because you use it to move it
to the next entry.  I get what you mean, move it back to where it was, not
go to prev, but the name is a bit off when used to go to the next entry.

reposition_iter, maybe?

>  
>  	mmap_assert_write_locked(vmg->mm);
>  	VM_WARN_ON_VMG(vmg->middle, vmg);
> @@ -1182,23 +1183,30 @@ struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg)
>  			vmg->end = end;
>  
>  		/* In expand-only case we are already positioned at prev. */
> -		if (!vmg->just_expand) {
> -			/* Equivalent to going to the previous range. */
> -			vma_prev(vmg->vmi);
> -		}
> +		if (!vmg->just_expand)
> +			move_iter_back = true;
>  	}
>  
> +	if (!can_merge_left && !can_merge_right)
> +		return NULL;
> +
> +	if (move_iter_back)
> +		vma_prev(vmg->vmi);
> +
>  	/*
>  	 * Now try to expand adjacent VMA(s). This takes care of removing the
>  	 * following VMA if we have VMAs on both sides.
>  	 */
> -	if (vmg->target && !vma_expand(vmg)) {
> -		khugepaged_enter_vma(vmg->target, vmg->vm_flags);
> -		vmg->state = VMA_MERGE_SUCCESS;
> -		return vmg->target;
> +	if (vma_expand(vmg)) {
> +		/* Error occurred, restore iterator. */
> +		if (move_iter_back)
> +			vma_iter_next_range(vmg->vmi);
> +		return NULL;
>  	}
>  
> -	return NULL;
> +	khugepaged_enter_vma(vmg->target, vmg->vm_flags);
> +	vmg->state = VMA_MERGE_SUCCESS;
> +	return vmg->target;
>  }
>  
>  /*
> @@ -1288,7 +1296,7 @@ int vma_expand(struct vma_merge_struct *vmg)
>  	if (!ret && vmg->copied_from)
>  		ret = dup_anon_vma(target, vmg->copied_from, &anon_dup);
>  	if (ret)
> -		return ret;
> +		goto nomem;
>  
>  	if (remove_next) {
>  		vma_start_write(next);
> 
> ---
> base-commit: 1eb36316305767b54fac2cd40b88b3499791bdf2
> change-id: 20261027-fix-new-merge-bug-71c2200d40fb
> 
> Cheers,
> -- 
> Lorenzo Stoakes (ARM) <ljs@kernel.org>
> 
