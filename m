Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDA1184540;
	Wed, 26 Aug 2026 15:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787758086; cv=none; b=nEpnHddOc0oOKZQ92OiC0A3aS9HEEDtPMUkQwz5pVuO3LX6WFunfpmwKLTsnjd9vyMJS270RrEThEhq6TRlq0y1IXHXNANi4hs/KRaCL3GTS1FxpPvme6XKQNb5VwN/pZMJjBWv+7oprNYLD1VQeAGsE9+K8T49cc01mMdr75BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787758086; c=relaxed/simple;
	bh=Ch9NdtJ4lt2NmqD363bK0fDFAzeeWkFcA86FtV1Ngnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MXAURbROM2Gpdlj726rQp7QfTO+uWcqU4jqu5feJjxu8Yj9o7UOlRLuy+K8rrBnlzkSPY9bR1pp/9z/VExxW0Hg0byUB+HBx3KuAJ7RS4eLKhDsDjmSRsVNXKad3v9n66Duxd5WQQnDy75DkbkL5+YF/TmcmWOLHu3oYO8wNYYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GsEYIDxR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GsEYIDxR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71AE41F000E9;
	Wed, 26 Aug 2026 15:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787758084;
	bh=6wXM8GEdeoqPJq30nYuopobVQoNsL83eAnMuGSZS4qk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GsEYIDxRBh9KRJYS/157X7JLxKfDW+BFX7dfNMBTq748OE3mxl2W8DTY4tZPHUPK5
	 gnhRfze/iY3wNJiDyJboLjz9ykD82R937fUz36SeVn9G/qHET1ZoyvazDvCACXY9nP
	 Ql5QsqU+F3HWBPQUv6t/VCkWFaEmh0QNF3lvgnRnuKBXvFTzVUf19gg9UKoeeEwCNa
	 FQ3ABSm+AS/XzFz58ZQSrD+9O+7+JbrpXO3eE7gxoWGrENpoX/2812y4/8C9McOPfc
	 2YQU6m50W02azt/ocCehp838SkAF49yTMB1vTQcXEwi1s6D6n/StMh5u1F6nruY1XZ
	 YnExIlmcgksJQ==
Date: Wed, 26 Aug 2026 16:27:58 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Kunwu Chan <kunwu.chan@gmail.com>
Cc: Kunwu Chan <kunwu.chan@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Li Xinhai <lixinhai.lxh@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	syzbot+f12658786a4153df5113@syzkaller.appspotmail.com, stable@vger.kernel.org
Subject: Re: [PATCH] mm/mremap: reset unfaulted VMA page offset for
 MREMAP_DONTUNMAP
Message-ID: <ao8F2ZO2GGvxIgcQ@gremlin>
References: <20260825-fix-mremap-dontunmap-pgoff-v1-1-39a40b2c98b3@kernel.org>
 <20260826151520.202465-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826151520.202465-1-kunwu.chan@linux.dev>

On Wed, Aug 26, 2026 at 11:15:18PM +0800, Kunwu Chan wrote:
> On Tue, 25 Aug 2026 08:55:26 +0100 "Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:
>
> > Uniquely an mremap() invocation using the MREMAP_DONTUNMAP flag can reset
> > a faulted VMA into an unfaulted one.
> >
> > It does so after the page tables have been moved to the copied VMA with
> > MREMAP_DONTUNMAP leaving the old VMA in place which is naturally unfaulted
> > as the page tables it had are no longer present.
> >
> > However, in doing so, it violates the invariant that the anonymous page
> > offset of an unfaulted VMA is vma->vm_start >> PAGE_SHIFT.
> >
> > This is because a VMA may have been faulted in, mremap()'d (causing a delta
> > between its page offset and vma->vm_start >> PAGE_SHIFT), and then
> > mremap()'d again with MREMAP_DONTUNMAP resulting in the unfaulting.
> >
> > This condition is a violation of a fundamental assumption in mm, but now
> > also triggers an assert in assert_sane_pgoff() which explicitly checks for
> > this condition.
> >
> > Correct it by resetting the VMA's page offset at the point of completing
> > the MREMAP_DONTUNMAP operation.
> >
> > Reported-by: syzbot+f12658786a4153df5113@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/all/6a87853b.ae6ddae5.3da009.0023.GAE@google.com/
> > Fixes: 1583aa278f5f ("mm: mremap: unlink anon_vmas when mremap with MREMAP_DONTUNMAP success")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > ---
> >  mm/mremap.c | 22 +++++++++++++++++-----
> >  1 file changed, 17 insertions(+), 5 deletions(-)
> >
> > diff --git a/mm/mremap.c b/mm/mremap.c
> > index e8df5cdb0ac9..2b4b523a86b8 100644
> > --- a/mm/mremap.c
> > +++ b/mm/mremap.c
> > @@ -1331,18 +1331,30 @@ static void dontunmap_complete(struct vma_remap_struct *vrm,
> >  {
> >  	unsigned long start = vrm->addr;
> >  	unsigned long end = vrm->addr + vrm->old_len;
> > -	unsigned long old_start = vrm->vma->vm_start;
> > -	unsigned long old_end = vrm->vma->vm_end;
> > +	struct vm_area_struct *vma = vrm->vma;
> > +	unsigned long old_start = vma->vm_start;
> > +	unsigned long old_end = vma->vm_end;
> >
> >  	/* We always clear VMA_LOCKED[ONFAULT]_BIT on the old VMA. */
> > -	vma_clear_flags_mask(vrm->vma, VMA_LOCKED_MASK);
> > +	vma_clear_flags_mask(vma, VMA_LOCKED_MASK);
> >
> >  	/*
> >  	 * anon_vma links of the old vma is no longer needed after its page
> >  	 * table has been moved.
> >  	 */
> > -	if (new_vma != vrm->vma && start == old_start && end == old_end)
> > -		unlink_anon_vmas(vrm->vma);
> > +	if (new_vma != vma && start == old_start && end == old_end) {
> > +		const pgoff_t pgoff_unfaulted = vma->vm_start >> PAGE_SHIFT;
> > +
> > +		unlink_anon_vmas(vma);
> > +		/*
> > +		 * The VMA is now unfaulted and it is an invariant that
> > +		 * unfaulted anonymous VMAs have page offset equal to
> > +		 * vma->vm_start >> PAGE_SHIFT.
> > +		 */
> > +		vma_set_anon_pgoff(vma, pgoff_unfaulted);
> > +		if (vma_is_anonymous(vma) && !vma->vm_file)
> > +			vma_set_pgoff(vma, pgoff_unfaulted);
>
>
> Hi Lorenzo,
>
> I think the fix makes sense. One thing I wanted to make sure
> I understand correctly is the distinction between anon_pgoff
> and vm_pgoff here.
> Is the intention that anon_pgoff should be reset when the
> VMA becomes unfaulted, while vm_pgoff should only be reset
> for a truly anonymous VMA, since it may retain file-offset
> semantics for VMAs with a vm_file?

Yes.

This is to account for both MAP_PRIVATE file-backed and pure anon. But to
keep everything consistent (+ simple) we always update anon pgoff for
everything.

>
> Thanks,
> KunWu
>
> > +	}
> >
> >  	/* Because we won't unmap we don't need to touch locked_vm. */
> >  }
> >
> > ---
> > base-commit: efecab401cb15fd3bb9bc05990609acb6b267ff2
> > change-id: 20260824-fix-mremap-dontunmap-pgoff-a687134e995e
> >
> > Best regards,
> > --
> > Lorenzo Stoakes (ARM) <ljs@kernel.org>
> >
> >
>

--
Cheers, Lorenzo
