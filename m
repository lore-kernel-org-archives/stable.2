Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12C33BE650;
	Sun, 27 Sep 2026 20:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790542482; cv=none; b=t6ceOdJz8RpVs+0O+WbY/xQCKZhqoBsuj4RBhnAQfend1Huj2OY0k0BCzEqU7YwsopYZBxlotiX4dLR+cLqF36+0/MkaAqtWys8xgNEkSgb+CI1MnpEc6M957x/LmIOZa2aIPCr55hKIJJL+OgGnCfUUYUR8WEHB/x6Gtx/Whds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790542482; c=relaxed/simple;
	bh=U3EfVxxdtcPFUFIB5Q/ewTULVlR4LEoHRJwGIWgsTCs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=kxiFKwmo2j+rGsDXO76tY4Gqeod6nATBEi8+tIe8yxkeidBGMMPSW1vLzljsCG5x0+41A22uFRIr7N7cRPSlwlD77ee2sgoo2wCKL6IhS+bvIhAIY8TpjGbIYxWb7w2d5vN1lFEaF2yLlEUnEHTsxXRhdD2yAcAeBWkiM7TR8Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=i6dKcdAM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="i6dKcdAM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 112A81F000FF;
	Sun, 27 Sep 2026 20:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1790542480;
	bh=wezweqQqot1s/EhJa+Q8aOJlMWPiVKjcS+oT7p1UAYs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=i6dKcdAMiqAgmpOl0EbfWmlKPvQQ/8TRbP8UEKnJN4TGjxlCgajWk7053GgOcx/Fu
	 IMdCKOG7soO6PIDFHc79lxiu0GVPJ8hlOBUzRUtQ8ArJu4Js62nF6CY+lxUQXQPGbs
	 fbbAW0/NLNvVPW5GDG5BEkcqH+Djx8Ji/1m+Wwng=
Date: Sun, 27 Sep 2026 13:54:39 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Cc: rppt@kernel.org, peterx@redhat.com, surenb@google.com,
 aarcange@redhat.com, david@kernel.org, ljs@kernel.org, liam@infradead.org,
 vbabka@kernel.org, mhocko@suse.com, shuah@kernel.org, kirill@shutemov.name,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] userfaultfd: clear the inherited uffd bit in
 move_swap_pte()
Message-Id: <20260927135439.094d75bc42414879a6e21c79@linux-foundation.org>
In-Reply-To: <20260926124145.2878520-2-donggeunyoo.kernel@gmail.com>
References: <20260926124145.2878520-1-donggeunyoo.kernel@gmail.com>
	<20260926124145.2878520-2-donggeunyoo.kernel@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 26 Sep 2026 21:41:44 +0900 Donggeun Yoo <donggeunyoo.kernel@gmail.com> wrote:

> UFFDIO_MOVE on a swapped-out page installs the source PTE at the
> destination unchanged, so a uffd bit set on a write-protected or
> RWP-protected source lands in a destination VMA that was never
> registered for either.  Nothing clears it there, and userspace sees:
> 
>  - /proc/<pid>/pagemap reports the page as uffd-tracked (bit 57), both
>    while it is swapped out and after it is faulted back in.
>  - MADV_COLLAPSE fails with EINVAL on a range containing it, because the
>    collapse scan bails on a swap entry with the uffd bit set.
>  - With CONFIG_PAGE_TABLE_CHECK, faulting the page in warns.
>    do_swap_page() carries the bit into the present PTE and, since the
>    destination isn't WP-registered, also makes it writable:
> 
>    WARNING: mm/page_table_check.c:202 at __page_table_check_ptes_set+0x185/0x1e0
>    Call Trace:
>     set_ptes+0x67/0xc0
>     do_swap_page+0x990/0xfe0
>     __handle_mm_fault+0x7d0/0xeb0
>     handle_mm_fault+0x9c/0x250
>     do_user_addr_fault+0x207/0x650
>     exc_page_fault+0x65/0x150
>     asm_exc_page_fault+0x26/0x30
> 
> Reaching it takes UFFDIO_MOVE out of a WP- or RWP-protected area into
> one that isn't, on a page that is swapped out at the time.  It hasn't
> been seen in practice.
> 
> A resident page doesn't carry the bit, because move_present_ptes() builds
> the destination PTE from dst_vma->vm_page_prot.  Clear it on the moved
> swap entry as well, then re-arm it if the destination is RWP-registered.
> 
> The WP case has been there since v6.8, where UFFDIO_MOVE was added.

Thanks.  This is triggerable by unprivileged userspace, so can
reviewers please prioritize.

> Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> Cc: <stable@vger.kernel.org>

This should be whizzed into 7.3-rcX pretty promptly.

It's not really appropriate to give the selftest such treatment - I'm
never really sure how to handle that.  I guess I'll keep things as you
presented them - both for current -rc, [1/2] gets backported, [2/2]
does not.

> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -1449,6 +1449,7 @@ static int move_swap_pte(struct mm_struct *mm, struct vm_area_struct *dst_vma,
>  	orig_src_pte = ptep_get_and_clear(mm, src_addr, src_pte);
>  	if (pgtable_supports_soft_dirty())
>  		orig_src_pte = pte_swp_mksoft_dirty(orig_src_pte);
> +	orig_src_pte = pte_swp_clear_uffd(orig_src_pte);
>  	/* Re-arm RWP on the moved swap entry if dst_vma is RWP-registered. */
>  	if (userfaultfd_rwp(dst_vma))
>  		orig_src_pte = pte_swp_mkuffd(orig_src_pte);
> -- 
> 2.53.0
