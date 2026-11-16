Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794844019;
	b=1bjn/wwxHSmXa2xazqyzH3Bm9YjItXgZiqoLfReZBZjocs/Qxk9bH+8CRYxYkRYBkdbj
	 jkgKqIIgijg4dF+ZbXxR26B5W7OhDa1u/irheAXt/j2ckS1ljLP/7bauwS2a5b2QKQP/a
	 EUEUJ/YA94Hv60bxdCNlcWgt/BxfJCAK84AzJW0unyXxAr6YqQtJBitarF9meEITqPGfG
	 fmSZWEUPCqavpTNoZ8zpTYCHPDmnPorh/N675gvaI1j2jPmQYPE2GQRSb7lgS0hprZvgC
	 65jm4zHc3INGb7rYmQaLBsIaPKN3R40ve87krLyoSJwoiE+sbs+/9FCVoxHFLfduzAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794844019;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=f0uElAV1NvKu0ZyMFHxeUG860eoK8aGVGyT8VR+T67Y=;
	b=LHvQIOLcBE2wQoUT9i3Hxho+0JOwh0nKHYRC4jZ8p4PQGlyr5hVmo3XwTsseI3Na5byB
	 GiGcFuGiUb3Hr+g7CFeyQNWoL4y214Wddwrp+rgdghuRSfNqtwyrZpmyucd6EXKzanFR/
	 AVugBNHLQZ0Y6Dq1NdP0ne+8UIOqCdVSgnWgqcz8jweDvBqa78hqSJLhc6UMfCnEVbmfP
	 r18ild0oUAn8QcQLUUJWm7n47Yn0ukj2mpS63Fc8KQrbEf9iyMP5Cz/vg1Xn4CRBbGNq/
	 mHy8c2QUFQtX7n4ORQjrAYxjWipEMcLVq1Y7HN8bbUoTSUworjr/Mhn+/+YPVXAgOEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k9EFhRVC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7DA606A881;
	Mon, 16 Nov 2026 15:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k9EFhRVC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C19E31F000C4;
	Mon, 16 Nov 2026 15:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794844019;
	bh=f0uElAV1NvKu0ZyMFHxeUG860eoK8aGVGyT8VR+T67Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=k9EFhRVCzCfcnffZdkuJZogTdgJRJu/ey5dgGOWDFuZz+pg2opk7vf1J/7XjdvNlL
	 FgDSvPGP96+a7H8NxW+UdZhmP3SOFRkpdEU2FhzKaNmAIF4g0QD1JZQR/w9PMWGDDz
	 pJ+55b41SuSDypTZmj0sMYHMitgnUSfZrHdCmOLnzaGcAhPQJvuc3V8i9tg/XKs9yH
	 eUhb54z/N7uhUmVofEctqQHxi7r+DpSpexGjPD704xRrWUA3Iv+bC6EeoUj8AeywWG
	 rPVw1hO6pHy5UIDxOCyN0UdIqZN6Ts+QTyaS7YPQK1IL08QYBqHLdHmE0Vr1cdTQjP
	 h4xZOAyLTBeJg==
Date: Mon, 16 Nov 2026 15:46:54 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "Liam R. Howlett" <liam@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Li Jinyue <jinyue.li@linux.alibaba.com>
Subject: Re: [PATCH] mm/vma: update VMA iterator state on error in new VMA
 merge
Message-ID: <avskacTjLUyz4D_c@gremlin>
References: <20261027-fix-new-merge-bug-v1-1-7023a787e6b9@kernel.org>
 <gp4huj53rndmngvzajdfelalmh5gkhzqv73t2v6rotmr37hgpb@g4a33cixtylu>
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
In-Reply-To: <gp4huj53rndmngvzajdfelalmh5gkhzqv73t2v6rotmr37hgpb@g4a33cixtylu>

On Thu, Nov 12, 2026 at 05:01:34PM -0500, Liam R. Howlett wrote:
> On 26/10/27 11:25AM, Lorenzo Stoakes (ARM) wrote:
>
> I'm a bit late on this one..
>
> > Commit cacded5e42b9 ("mm: avoid using vma_merge() for new VMAs") shared
> > code between vma_merge_new_range() and vma_expand().
> >
> > However in doing so, it failed to correctly restore the VMA iterator when
> > vma_expand() errors out.
> >
> > This is a problem when the immediately preceding VMA is mergeable and
> > vmg->just_expand isn't specified, at which point the VMA iterator is moved
> > to the previous VMA.
> >
> > (Note that vmg->just_expand is a special case for brk(), where the
> > iterator will already be positioned at the VMA to be expanded.)
> >
> > Resolve things by restoring the VMA iterator on error. Use
> > vma_iter_next_range() to do this, so it will correctly stop on the gap
> > after the previous VMA, rather than skip to the next VMA after it (this is
> > a new VMA merge, so is being applied at a gap).
> >
> > To isolate the error handling, return early when a merge isn't
> > possible (what the vmg->target check was doing before), then handle the
> > merge success/failure case explicitly.
> >
> > While here, update vma_expand() to jump to the nomem case when
> > dup_anon_vma() fails, so vmg->state is correctly updated.
> >
> > This doesn't impact anything in practice, but is the correct course and
> > since it's part of the error path that this patch addresses, it makes sense
> > to update it also.
> >
> > Users are very unlikely to have observed the issue this patch addresses in
> > practice, as it is near-impossible to fail an allocation for an anon_vma,
> > but a process under memory pressure that receives a fatal signal could
> > trigger it.
> >
> > This issue was originally reported by Li Jinyue for which I am grateful. He
> > indicated this was uncovered by a private syzkaller instance.
> >
> > Fixes: cacded5e42b9 ("mm: avoid using vma_merge() for new VMAs")
> > Cc: stable@vger.kernel.org
> > Reported-by: Li Jinyue <jinyue.li@linux.alibaba.com>
> > Closes: https://lore.kernel.org/all/20261025093921.1011927-1-jinyue.li@linux.alibaba.com/
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > ---
> >  mm/vma.c | 28 ++++++++++++++++++----------
> >  1 file changed, 18 insertions(+), 10 deletions(-)
> >
> > diff --git a/mm/vma.c b/mm/vma.c
> > index af8e65ada23b..d416ba58eb4c 100644
> > --- a/mm/vma.c
> > +++ b/mm/vma.c
> > @@ -1141,6 +1141,7 @@ struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg)
> >  	struct vm_area_struct *next = vmg->next;
> >  	unsigned long end = vmg->end;
> >  	bool can_merge_left, can_merge_right;
> > +	bool move_iter_back = false;
>
> The name move_iter_back is a bit confusing because you use it to move it
> to the next entry.  I get what you mean, move it back to where it was, not
> go to prev, but the name is a bit off when used to go to the next entry.
>
> reposition_iter, maybe?

Ahh too late this is merged :P

I think it's hard to get this quite right.

So in the first instance move_iter_back = do a vma_prev() i.e. literally move
the iterator backwards.

Then, if the iterator was moved back, we want to restore it on error, I hoped
that the comment would make that clear.

So it's just separating noting that it needs doing (move_iter_back = true) and
the actual action (vma_prev()) + the restore.

So I think arguably OK as-is? But could obviously also follow up if needed.

>
> >
> >  	mmap_assert_write_locked(vmg->mm);
> >  	VM_WARN_ON_VMG(vmg->middle, vmg);
> > @@ -1182,23 +1183,30 @@ struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg)
> >  			vmg->end = end;
> >
> >  		/* In expand-only case we are already positioned at prev. */
> > -		if (!vmg->just_expand) {
> > -			/* Equivalent to going to the previous range. */
> > -			vma_prev(vmg->vmi);
> > -		}
> > +		if (!vmg->just_expand)
> > +			move_iter_back = true;
> >  	}
> >
> > +	if (!can_merge_left && !can_merge_right)
> > +		return NULL;
> > +
> > +	if (move_iter_back)
> > +		vma_prev(vmg->vmi);
> > +
> >  	/*
> >  	 * Now try to expand adjacent VMA(s). This takes care of removing the
> >  	 * following VMA if we have VMAs on both sides.
> >  	 */
> > -	if (vmg->target && !vma_expand(vmg)) {
> > -		khugepaged_enter_vma(vmg->target, vmg->vm_flags);
> > -		vmg->state = VMA_MERGE_SUCCESS;
> > -		return vmg->target;
> > +	if (vma_expand(vmg)) {
> > +		/* Error occurred, restore iterator. */
> > +		if (move_iter_back)
> > +			vma_iter_next_range(vmg->vmi);
> > +		return NULL;
> >  	}
> >
> > -	return NULL;
> > +	khugepaged_enter_vma(vmg->target, vmg->vm_flags);
> > +	vmg->state = VMA_MERGE_SUCCESS;
> > +	return vmg->target;
> >  }
> >
> >  /*
> > @@ -1288,7 +1296,7 @@ int vma_expand(struct vma_merge_struct *vmg)
> >  	if (!ret && vmg->copied_from)
> >  		ret = dup_anon_vma(target, vmg->copied_from, &anon_dup);
> >  	if (ret)
> > -		return ret;
> > +		goto nomem;
> >
> >  	if (remove_next) {
> >  		vma_start_write(next);
> >
> > ---
> > base-commit: 1eb36316305767b54fac2cd40b88b3499791bdf2
> > change-id: 20261027-fix-new-merge-bug-71c2200d40fb
> >
> > Cheers,
> > --
> > Lorenzo Stoakes (ARM) <ljs@kernel.org>
> >

--
Cheers, Lorenzo
