Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAFA23ABBF;
	Tue, 13 Oct 2026 09:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791883845; cv=none; b=Ro0WHpw+J/DMOw4A3ErlrkKGXZERu1oU93l/1qnDW060X1E2GHil/w9FBIrWmnrGbXjkj+3AqYqTQG5CRMAsMpnC3OiQTUK+c9PwTL3NNY2s2owTj345GGbX1QrUcJgqn9Gop41ZF9p8npnvB6LRHomwOu5QIrdXbv2nEt3AFfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791883845; c=relaxed/simple;
	bh=iQy3zVnbluN2KJGjJ0s/IVJ7Cbz/6lovy1SbuMmgvbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cf0mkctRKdbIRZaGzm5uP4PYpZ5C6bWgVhhZqa6u51GQvXeJI5RaYWPKnrYgptELGocaQ1IagE/lobHfJFmTwoesN7B0TKVaduYK97ni/h3O+ke/sMWPf4TfR6scMr2UZpfD+0UdeRIzvO9d/fUTcjcet0zNdVE29lHxIlAtZnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mihHl0rN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mihHl0rN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31AA61F000FF;
	Tue, 13 Oct 2026 09:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791883844;
	bh=GDCBsEYoZUsLsXk6wyffkPfdwkrEP+ByhgCH/FzXMM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mihHl0rNLCQg4W0s0+z1en8+7AJqOHOYrKKJKz5IhLlWBh/WFVyTbeSQjkYoIVSzt
	 DGPTrHwtRRyDPBfIaEcFHjYmdI9jiru9Fxn6+uf2Fg3fjT5HSDPt1gvNul1q3TwYl4
	 I7Oeat+WqwQguzZL/k3f5B0O2N10bHH4poIAs2B5oxBRQTxPbNdopI0BoH6kenivHs
	 6n0br9igd382Ry5UeEOmzq6VovM50w6O4ULlzX2G2Ubxn/ahH/pFLWqkEBX+PnDLhY
	 nZ11PYfc9VBqj2iBPNUVlwOq1CvyCOPPJ5AomYRjP4Nk7omM6k+IILv674Q4Xl2REy
	 LS/CIKh05DgiA==
Date: Tue, 13 Oct 2026 10:30:37 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Rik van Riel <riel@surriel.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>, Lance Yang <lance.yang@linux.dev>, 
	Kyle Zeng <kylebot@openai.com>, stable@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/rmap: don't discard lazyfree THPs at PMD level
Message-ID: <as36Kesa_k70jOva@gremlin>
References: <20261012-lazyfree-stable-fix-v2-1-6387d6e30063@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012-lazyfree-stable-fix-v2-1-6387d6e30063@nvidia.com>

On Mon, Oct 12, 2026 at 10:20:16PM -0400, Zi Yan wrote:
> __discard_anon_folio_pmd_locked() clears a lazyfree THP's PMD before it
> determines whether the folio can be discarded, and restores it if the folio
> is dirty or has extra references. It is done under only the PMD lock and
> the anon_vma read lock inside try_to_unmap_one() and no mmap lock is held.
> The temporarily none PMD causes UAF.
>
> A parallel munmap() or mremap() is supposed to serialize with it on the PMD
> lock, but zap_pmd_range() (called by munmap()) and move_page_tables()
> (called by mremap()) do not take the lock when they see the temporarily
> none PMD and skip the PMD. There is no more page table walk after the none
> PMD is restored:
>
> - munmap(): free_pgtables() waits in unlink_anon_vmas() for the anon_vma
>   lock, then free_pmd_range() drops the restored PMD as bad without
>   removing the rmap, so the folio keeps a stale mapcount.
>
> - whole-VMA MREMAP_DONTUNMAP: dontunmap_complete() unlinks the source VMA
>   from its anon_vma while the restored PMD still maps the folio.
>
> - plain mremap(): the THP is not moved but unmapped, so the THP's data is
>   lost.
>
> In the first two cases, the folio stays mapped, but no VMA that maps it is
> linked to its anon_vma. When the anon_vma is freed, it is still reachable
> when one rmap walks the folio. Racing lazyfree reclaim against
> MREMAP_DONTUNMAP as an unprivileged user reproduces a KASAN use-after-free
> in folio_lock_anon_vma_read() as reported in the Closes link.
>
> One solution is to use an invalidated PMD instead of a cleared one until
> the discard is committed, but it needs arch fixes first.
> 1. GUP-fast still follows an invalidated PMD on riscv, LoongArch and s390.
> 2. sparc64 miscounts thp_pte_count when an invalidated PMD is set again or
>    cleared.
>
> To keep the fix simple for backport, stop discarding lazyfree THPs at PMD
> level instead. try_to_unmap_one() splits the PMD and discards the folio at
> PTE level.
>
> unmap_huge_pmd_locked() and __discard_anon_folio_pmd_locked() are left in
> place, unused, to minimize this fix for backport and the invalidated PMD
> approach is planned as a follow-up series to use them again.
>

Amazing, thanks for that! All LGTM.

> Fixes: 735ecdfaf4e8 ("mm/vmscan: avoid split lazyfree THP during shrink_folio_list()")
> Reported-by: Kyle Zeng <kylebot@openai.com>
> Closes: https://lore.kernel.org/r/20261009165214.40212-2-kylebot@openai.com
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Reviewed-by: Kyle Zeng <kylebot@openai.com>
> Reviewed-by: Lance Yang <lance.yang@linux.dev>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
> The proposed fix[1] requires additional arch code fixes[2]. Disable it
> first for stable fix. The function will be re-enabled along with arch code
> fixes.
>
> Link: https://lore.kernel.org/all/20261009165214.40212-2-kylebot@openai.com/ [1]
> Link: https://lore.kernel.org/all/DM0II2QHWWS1.2RXEJXC8S0101@nvidia.com/ [2]
> ---
> Changes in v2:
> 1. added more details on how UAF can happen.
> 2. provides more details on why the invalidated PMD approach is not used.
> 3. explained why unmap_huge_pmd_locked() and
>    __discard_anon_folio_pmd_locked() are left unused.
> - Link to v1: https://patch.msgid.link/20261009-lazyfree-stable-fix-v1-1-70997958ef8d@nvidia.com
> ---
>  mm/rmap.c | 11 -----------
>  1 file changed, 11 deletions(-)
>
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 805db93fe0428..1131b76bbbc28 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -2275,17 +2275,6 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>  		}
>
>  		if (!pvmw.pte) {
> -			if (folio_test_lazyfree(folio)) {
> -				if (unmap_huge_pmd_locked(vma, pvmw.address, pvmw.pmd, folio))
> -					goto walk_done;
> -				/*
> -				 * unmap_huge_pmd_locked has either already marked
> -				 * the folio as swap-backed or decided to retain it
> -				 * due to GUP or speculative references.
> -				 */
> -				goto walk_abort;
> -			}
> -
>  			if (flags & TTU_SPLIT_HUGE_PMD) {
>  				/*
>  				 * We temporarily have to drop the PTL and
>
> ---
> base-commit: 8b38ed9ab5b09c8ba168cbcc49524e9b380ee5c4
> change-id: 20261009-lazyfree-stable-fix-67712b2049dd
>
> Best regards,
> --
> Yan, Zi
>

--
Cheers, Lorenzo
