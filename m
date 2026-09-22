Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988CF3845D8;
	Tue, 22 Sep 2026 06:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790059523; cv=none; b=pkWo9jGnwDZR2WYIIZ5hWc5rn1IJiRDqe9xG73/36EUF+XNmDP6iOy5Qk5jZ8F4iKXRuDTg5Uh6PLQaLFPr3cxNf6SVWuuXAORoxH5Ste9ZJCOGAt/bzNgDYAjSJ91BcBED7XvgzU70E4pkpNXQHl7obbcx7obhbJ5mwEOgIw6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790059523; c=relaxed/simple;
	bh=Bic2HmDnu/3YfGTM3rft6/HYkuEdDJkgfkcSRjpKiCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/o+dL3qR1YR3gqcalwWD85JYlunPTETfRmaYYfQ7U0yUCZ/MriBIO1W/6+pW2BXHu7eI5eTSV+qCQAXoVsLKhQuMaU0RDmuHMVOWP6JTdfzOYXImaucm2etqxNKeqbwrwQbJfCVORlmPv07tH878EG10BWt+XFEdgLkXLG47Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UmGJvweB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UmGJvweB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D4A61F000FF;
	Tue, 22 Sep 2026 06:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790059520;
	bh=hoPyg2SIrsoK+SSMxG1vwxO63HiOF3XndXbQAp8ZbRQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UmGJvweBVxOynT7j+Gqjjm2LzYYprQN0fcyy6PM9Jb1M08HBX8oMVvM6eHS45dDk3
	 YjiexvypK1R1hGq/kuQSDFAG4oeJgoFBGJtrXuYY/NWABpZApQbkYA1ZbbC1Fp2T7P
	 Q59fw5+po2bmBQe6TXHUj338flIIT+uy6m8J1XRKZO2gnHmfybPWWHmlh+3/div+SU
	 KLaKZlxuuiZPzRp0TA8rNzI3KYp6G79u6WQgWyCgrE2TtlKTxOvNAmclkO2AuPTKdH
	 aEU+6Mf1PMJk+q7/hsNEgmBB+MXoZTBzNy8T3Pniths2Z0BM2B8wXHGfNsgKv0SE23
	 76fF0DV6A8x2w==
Date: Tue, 22 Sep 2026 09:45:12 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Cc: akpm@linux-foundation.org, peterx@redhat.com, surenb@google.com,
	aarcange@redhat.com, david@kernel.org, ljs@kernel.org,
	liam@infradead.org, vbabka@kernel.org, mhocko@suse.com,
	shuah@kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1 1/2] userfaultfd: clear the inherited uffd bit in
 move_swap_pte()
Message-ID: <arIj-DZ3BtxMEzLB@kernel.org>
References: <20260919004630.1159895-1-donggeunyoo.kernel@gmail.com>
 <20260919004630.1159895-2-donggeunyoo.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260919004630.1159895-2-donggeunyoo.kernel@gmail.com>

Hi,

On Sat, Sep 19, 2026 at 09:46:29AM +0900, Donggeun Yoo wrote:
> UFFDIO_MOVE on a swapped-out page installs the source PTE at the
> destination unchanged, so a uffd bit set on the source lands in a
> destination VMA that was never registered for write protection.  It is
> then permanent: the bit is dropped only by change_protection() under
> MM_CP_UFFD_{WP,RWP}_RESOLVE, which uffd_wp_range(), mrwprotect_range()
> and userfaultfd_clear_vma() issue only for a VMA registered in that
> mode.  pagemap reports the page as uffd-tracked, and MADV_COLLAPSE
> refuses the range while the bit is set, because collapse_scan_pmd() is
> strict about uffd on swap entries.
> 
> move_present_ptes() and move_zeropage_pte() build the destination PTE
> from dst_vma->vm_page_prot and arm RWP only when dst_vma asks for it, so
> the destination's own registration decides the result.  move_swap_pte()
> copies the source PTE instead and only ever sets the bit, never clears
> it, so one UFFDIO_MOVE behaves differently depending on whether the page
> happened to be resident.
> 
> Clear the uffd bit on the moved swap entry unless the destination is
> RWP-registered, as copy_nonpresent_pte() does where it installs a PTE
> into a destination that may not be armed.  A WP-registered destination
> stops inheriting the bit as well, which is already what it gets when the
> moved page is resident.

This is a hard-to-read wall of text :(

Tell your LLM to better split it into paragraph, not to list every involved
function and in general make it more to the point.
 
> Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
> ---
>  mm/userfaultfd.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 74f04c323c50..6495666c596b 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -1452,6 +1452,8 @@ static int move_swap_pte(struct mm_struct *mm, struct vm_area_struct *dst_vma,
>  	/* Re-arm RWP on the moved swap entry if dst_vma is RWP-registered. */
>  	if (userfaultfd_rwp(dst_vma))
>  		orig_src_pte = pte_swp_mkuffd(orig_src_pte);
> +	else
> +		orig_src_pte = pte_swp_clear_uffd(orig_src_pte);
>  	set_pte_at(mm, dst_addr, dst_pte, orig_src_pte);
>  	double_pt_unlock(dst_ptl, src_ptl);
>  
> -- 
> 2.53.0
> 

-- 
Sincerely yours,
Mike.
