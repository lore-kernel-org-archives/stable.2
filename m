Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793459349;
	b=ZoXhxKm3TpqynGaKQdEdIqmpa521jLySUsVusiG22S9tt7HivDdBzqA4U1MLI7NIE+Bg
	 3VBz3rOK/mVMW13/KYvsDrJNS4e2vzfdWlzdnuugnJXBhdbdKOAeeh3CyCwNgnnTOtlzf
	 BJg7k4ROobUAy8e2eRH0BMFaPogHSJFesNLc9txXnnsxiyyH8TdwkEbKhvTRQMRRSqoVK
	 T8KE4VmFJbyCXS3L4LUhlUe1YU3gtXRI1BaY27nuV5H5kx9wq42MBPG2iroKFm/aQQA8Q
	 iKjBpbweM4EhlNI3dktAjpgKtTLDoQjudNATeT4FMDihKvgd4fDEBXYx+iFkHLkZCvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793459349;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=KEiiDSLjjFPAJPMOepk6Di3HsdgbKPWIFvft4zsU7q0=;
	b=k6Wp4CL9CIaVHHaoNGFXXNuJpsltMqEiuTQgqKsEwNsdIaCbUNRNQNcT+go0JlHWZqnN
	 um4SVB5FYQ8WU7OBCNsdaxAx0MP7QKr6TAKAubYD+VCoxuikD1s0CimiP5qcqvgOO2Wib
	 LbRuFAZR+2AJQptZDnVOlSVxLSt36VZYIp7AEdpE2YKvgrrLZSnrcCPJ+iRDERiNB2cn/
	 G3IvcOn3/ZMRyVNmZGdcqB7s6KTtUeVqDsmvYkLUFuWSKJTf+A5Ij+0X9OIbXG2/PuDWP
	 QTz7xNILiZTjvrXV/I8CEB+ZiLOqb9i8T2k/UIAel45NzVb7qArzCoBLgW8VOM7r0nQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VKfhZrgx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C0B606A31A;
	Sat, 31 Oct 2026 15:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VKfhZrgx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1D721F000C1;
	Sat, 31 Oct 2026 15:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793459348;
	bh=KEiiDSLjjFPAJPMOepk6Di3HsdgbKPWIFvft4zsU7q0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VKfhZrgxSWRq3VCoZ2mexfnQLDoTPcegmBRky1wljKL0NKPaHvdHk8fwKTIhzKzVH
	 WjwTBfRmzvbxD3MZsOysy6VznpiJ1P7puPzzBMlqIFM10Lx5Ksx4zSTKJTrxEFfrzi
	 6o7jUhey0ae+Ak+T7VrJDEhgExO7PhyXQZ6CgEWnJeW/t/qz6odxfbrVDuakAXg8/B
	 cXCu5Ch6CqrP0RDbvG4lhDhVspX96BD3sd0dKEVa0bk3+TXxpPZMCZVJCUJEwuapzp
	 DSAxMSeJQJcvzq0wyodPzjKUE+f4qEP+DEEerYIbst1v9K4Bc8RXgjHxhLwAOCtKyO
	 5NdkpWUinG0dQ==
Date: Sat, 31 Oct 2026 17:09:02 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Tal Zussman <tz2294@columbia.edu>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] userfaultfd: clear uffd state in child PTEs if uffd is
 released during fork
Message-ID: <auYEjnY0LrwjbL5T@kernel.org>
References: <20261031-uffd-prot-bits-fork-event-v1-1-3572921c2111@kernel.org>
 <20261031145835.960656-1-tz2294@columbia.edu>
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
In-Reply-To: <20261031145835.960656-1-tz2294@columbia.edu>

On Sat, Oct 31, 2026 at 10:58:35AM -0400, Tal Zussman wrote:
> On Sat, Oct 31, 2026 at 02:35:05PM +0200, Mike Rapoport (Microsoft) wrote:
> > With UFFD_FEATURE_EVENT_FORK the userfaultfd context is duplicated for the
> > child process, the child VMAs are registered with the new context, and uffd
> > protection state from the parent PTEs is copied into the child.
> >
> > If the parent's userfaultfd is released before the fork event is read,
> > userfaultfd_release_new() resets the VMA flags but keeps uffd state in the
> > child PTEs.
> >
> > This leaves the child's VMAs in an inconsistent state: they are not
> > registered with userfaultfd but their mappings carry uffd protection state.
> >
> > If the child registers the range with userfaultfd again, the stale state
> > turns into protection the child never asked for.
> >
> > When a write fault makes such a PTE writable without copying the page, the
> > uffd bit remains set and page_table_check_pte_flags() warns about it.
> >
> > Split resolving of the uffd PTE state out of userfaultfd_clear_vma() and
> > call it from userfaultfd_release_new() before resetting the VMA.
> >
> > Fixes: f369b07c8614 ("mm/uffd: reset write protection when unregister with wp-mode")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> 
> Hi Mike,
> 
> I managed to trigger a warning without this patch too by using an
> mprotect(PROT_READ | PROT_WRITE) in the child with CONFIG_PAGE_TABLE_CHECK:
> 
>   WARNING: mm/page_table_check.c:202 at __page_table_check_ptes_set+0x181/0x2f0
>   Call Trace:
>    change_pte_range+0x1ef7/0x29b0
>    change_protection+0xd2b/0x1560
>    mprotect_fixup+0x4cb/0x1040
>    do_mprotect_pkey+0x7c2/0xac0
>    __x64_sys_mprotect+0x78/0xc0
> 
> No warning with the patch, so:
> 
> Reviewed-by: Tal Zussman <tz2294@columbia.edu>
> Tested-by: Tal Zussman <tz2294@columbia.edu>
> 
> With a couple comments about comments below.
> 
> > ---
> >  mm/userfaultfd.c | 43 ++++++++++++++++++++++++++-----------------
> >  1 file changed, 26 insertions(+), 17 deletions(-)
> >
> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > index 3b71712edab4c..2c11ac5dad3d5 100644
> > --- a/mm/userfaultfd.c
> > +++ b/mm/userfaultfd.c
> > @@ -2220,6 +2220,28 @@ static void userfaultfd_reset_ctx(struct vm_area_struct *vma)
> >  	userfaultfd_set_ctx(vma, NULL, 0);
> >  }
> >  
> 
> I think uffd is woefully under-commented considering how many edge cases and
> races are associated with it... so how about the following instead:
> 
> /*
>  * Clear uffd state from a WP or RWP range: the uffd bit, WP markers and
>  * RWP PAGE_NONE entries. Call this before dropping the registration, as it
>  * needs the VMA flags to know what to resolve.
>  */

Yeah, I'll add it to v2, thanks!
 
> > +/* Clear the uffd bit and/or restore protnone PTEs */
> > +static void userfaultfd_clear_ptes(struct vm_area_struct *vma,
> > +		unsigned long start, unsigned long end)
> > +{
> > +	unsigned int mm_cp_flags = 0;
> > +	struct mmu_gather tlb;
> > +
> > +	if (!userfaultfd_protected(vma))
> > +		return;
> > +
> > +	if (userfaultfd_wp(vma))
> > +		mm_cp_flags |= MM_CP_UFFD_WP_RESOLVE;
> > +	if (userfaultfd_rwp(vma))
> > +		mm_cp_flags |= MM_CP_UFFD_RWP_RESOLVE;
> > +	if (vma_wants_manual_pte_write_upgrade(vma))
> > +		mm_cp_flags |= MM_CP_TRY_CHANGE_WRITABLE;
> > +
> > +	tlb_gather_mmu(&tlb, vma->vm_mm);
> > +	change_protection(&tlb, vma, start, end, mm_cp_flags);
> > +	tlb_finish_mmu(&tlb);
> > +}
> 
> I think it may also be helpful to comment the fork release path that
> triggers this bug for clarity, so how about the below on top? Happy to send
> it separately.

Let's make it a separate patch, it's not really a part of the fix and it's
not needed for backport IMO.
 
> That ewq->msg.arg.reserved.reserved1 at the end is horrific too... I'll send
> a patch to clean that up.
> 
> ---8<---
> From: Tal Zussman <tz2294@columbia.edu>
> Subject: [PATCH] mm/userfaultfd: comment the fork event release path
> 
> Document what userfaultfd_reset_ctx() expects from its callers, and why
> the fork event release path has to unregister the child.
> 
> Link: https://lore.kernel.org/lkml/20261031-uffd-prot-bits-fork-event-v1-1-3572921c2111@kernel.org/
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> ---
>  mm/userfaultfd.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 3b71712edab4..249f3b4444ab 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -2215,6 +2215,13 @@ static void userfaultfd_set_ctx(struct vm_area_struct *vma,
>  				 (vma->vm_flags & ~__VM_UFFD_FLAGS) | vm_flags);
>  }
>  
> +/*
> + * Drops the registration from the VMA.
> + *
> + * Page tables are left alone. Callers must make sure no uffd state is
> + * left behind in them, either by calling userfaultfd_clear_ptes() first
> + * or because none was ever installed in the range.
> + */
>  static void userfaultfd_reset_ctx(struct vm_area_struct *vma)
>  {
>  	userfaultfd_set_ctx(vma, NULL, 0);
> @@ -2997,6 +3004,10 @@ static void userfaultfd_event_wait_completion(struct userfaultfd_ctx *ctx,
>  		set_current_state(TASK_KILLABLE);
>  		if (ewq->msg.event == 0)
>  			break;
> +		/*
> +		 * The fd is gone or we are being killed, so the event
> +		 * will never be read.
> +		 */
>  		if (READ_ONCE(ctx->released) ||
>  		    fatal_signal_pending(current)) {
>  			/*
> @@ -3009,6 +3020,10 @@ static void userfaultfd_event_wait_completion(struct userfaultfd_ctx *ctx,
>  			if (ewq->msg.event == UFFD_EVENT_FORK) {
>  				struct userfaultfd_ctx *new;
>  
> +				/*
> +				 * Nobody will get an fd for the new context,
> +				 * so unregister the child.
> +				 */
>  				new = (struct userfaultfd_ctx *)
>  					(unsigned long)
>  					ewq->msg.arg.reserved.reserved1;
> -- 
> 2.39.5
> 

-- 
Sincerely yours,
Mike.
