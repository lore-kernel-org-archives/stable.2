Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67ABC425CC0;
	Fri,  2 Oct 2026 08:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790929124; cv=none; b=Y02QuEni5h8KGDGwDkojkJ57V5RL5rh8Mc1oMGpKfTZzZ/VoH/RQ25xw8wNi+owkKwcE4OXEoxJztyv3aMYzdEKXm/VKk/7MJ2iuksgnkowkqj3feo7VzYEB0z/7yoZ1BRLkBD/8IoFtMSgynarXwyFjHTEOstKzFIf1pyGJ9e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790929124; c=relaxed/simple;
	bh=CBS6JSjB0UZC8SssSvUKAHAc2GXcrOVu4GUnUPyBGhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QgNmycOFNauHcy+v3svnPtkCLBZ6iJ3XODGajsYyVdXD15HdPYhj3iRAyAdpUqoVQtFmsmmzb512OPBPiMM0pegk3uK+WzILzBZBWKrZ1kOqGtXxaU8wI5/N2/BuTHdPQa5xMAORiIs1g4DtdgjtmtALS4JWUuFbV8j/twl3Cq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UK6jrH00; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UK6jrH00"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 522631F000FF;
	Fri,  2 Oct 2026 08:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790929122;
	bh=sptNDyqmlXmK1/4meQkZ0Gk1mM5t6HWPSQC9jCl7kpg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UK6jrH00Df4LQaMV+8HKaLesemGA9Aso9iWdTe5PapieS2cOaA97os33M5D7hv2Vv
	 sTb/0j3Utjt8MgKBiwMMhel507fxJMLVL2gPjAclVQoypPvGvaSUBloiCHjVkSriYL
	 VVpOTrETRDRlEkEFSD5MdFx1t9X1wWcQtkqbRko93z6X4Esf5VHClDsnXQ2KdiIvH1
	 fHXciRk4vA+m8ixtC+m+Z1caDsWAf1oZb4PnJOQnh+2SUsLIWLZcELQo2UxjPYW1XA
	 2D3CX5FuJ5oz9i/ghNQAtHTaZEtpJ5DuGZvrHefxkn3m2D+0omTdL/vXYEMKKg8CiX
	 JrZPKBmQgiR5A==
Date: Fri, 2 Oct 2026 10:18:35 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Cc: akpm@linux-foundation.org, peterx@redhat.com, surenb@google.com,
	aarcange@redhat.com, david@kernel.org, ljs@kernel.org,
	liam@infradead.org, vbabka@kernel.org, mhocko@suse.com,
	shuah@kernel.org, kirill@shutemov.name, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] userfaultfd: clear the inherited uffd bit in
 move_swap_pte()
Message-ID: <ar9o2zVvUkMUxVzv@kernel.org>
References: <20260926124145.2878520-1-donggeunyoo.kernel@gmail.com>
 <20260926124145.2878520-2-donggeunyoo.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260926124145.2878520-2-donggeunyoo.kernel@gmail.com>

On Sat, Sep 26, 2026 at 09:41:44PM +0900, Donggeun Yoo wrote:
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
> 
> Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> Cc: <stable@vger.kernel.org>
> Assisted-by: LLM
> Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>


> ---
>  mm/userfaultfd.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 74f04c323c50f..f39f109f17989 100644
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
> 

-- 
Sincerely yours,
Mike.
