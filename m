Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3EA175A85;
	Mon, 12 Oct 2026 10:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791799762; cv=none; b=V7Cug2rvBSXDaFxtkt4dXVEPkroMUF0qthJFYT2c6q/LVQM11arAoaXfuBGzsyswaGj0ldIS8c6bK23ZQxYx7d186krHSQsSOskxYYrIBitdQz28IbKlI8b32UuBIbK5k0ix9iB4Eba5frHmA+KdrrYJzSXozEWyJUiOR5cfPcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791799762; c=relaxed/simple;
	bh=Vh0ONsnFhz56K9MUNI7x9kRmPCMCtUyLVYjL1Hllvsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nRfQv+cdk4nWl06i4NvvdK6hrpD9D3cduG/GYXkLV3t0928cOl/W3K5hQ2tivxNIkVW15HElBq94QhTdJB+TApD+Im5wHGTnmJCZZOLGD2VbCD6L1P7hDEF2SBapkenNNRY5tVNkUMij8y127tpDk1QLSRrKcEGQwvWAXc7KtsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJrnAQ1y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJrnAQ1y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 264041F0089B;
	Mon, 12 Oct 2026 10:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791799752;
	bh=SHxz+apKE2hMTml72NAExf/QEULl2SZWmz8dKLG+u1c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=nJrnAQ1yhxtMBG44ZNjv1H1OdQEHQj6Tb3C+lAHtIhaV2h8jNYInA4ake/qXooMSz
	 LU1J/Mo30EGj2iYo+8htzhcOQPH00kbXyEFAZlj8XXBxVn5DoOxhqsMtfWg0enSNYS
	 PCnpzoPNoxuc4eQ7NipBRw7MaX4nrMCNrkBDTvA71D2/UmrV0ABJDUm7YXAKDUiu7l
	 cQeE02ugsBcBGUW4hQeB/i1v+MMa8ps/OQPoNDOh/NI/FAOyUfqbnPHHTZFWLIaCpE
	 y0Hypz5mbIHBhVRc2bbYCeOyuWNPNIuIj9edgDR7ojCIfSpMw0oe1s7M8ScIQmmMJf
	 nFeoLXU8PmDcw==
Message-ID: <42087cd7-473e-40a7-ae63-3c841c615c8f@kernel.org>
Date: Mon, 12 Oct 2026 12:09:07 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/madvise: keep the hardware dirty bit in MADV_COLD's
 THP path
To: samarth.colleges@gmail.com, akpm@linux-foundation.org,
 liam@infradead.org, ljs@kernel.org
Cc: vbabka@kernel.org, jannh@google.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261011132227.413217-1-samarth.colleges@gmail.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261011132227.413217-1-samarth.colleges@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/11/26 15:22, samarth.colleges@gmail.com wrote:
> From: Samarth Narang <samarth.colleges@gmail.com>
> 
> For a young, PMD-mapped THP, madvise_cold_or_pageout_pte_range() handles
> MADV_COLD by reading orig_pmd = *pmd, calling pmdp_invalidate(),
> discarding its return value, and writing back pmd_mkold(orig_pmd):
> 
> 	if (!pageout && pmd_young(orig_pmd)) {
> 		pmdp_invalidate(vma, addr, pmd);
> 		orig_pmd = pmd_mkold(orig_pmd);
> 		set_pmd_at(mm, addr, pmd, orig_pmd);
> 		tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
> 	}
> 
> pmdp_invalidate() atomically clears the present bit and returns the PMD
> as it was in the page table at that instant.  A store from another CPU
> that lands after orig_pmd is read but before the invalidate sets the
> hardware dirty bit in the live entry.  Because the written-back value is
> derived from the stale orig_pmd, that dirty bit is erased.
> 
> If the THP had been marked lazyfree (MADV_FREE), reclaim later finds a
> clean PMD and a clean folio and discards it rather than swapping it out
> (__discard_anon_folio_pmd_locked()).  The store is then silently lost: a
> subsequent read returns stale/zero data, although the MADV_FREE contract
> is that a write after the advice call cancels the free.
> 
> pmdp_invalidate() returns the pre-invalidate entry precisely so callers
> can carry the accessed/dirty bits hardware may have set concurrently
> (d52605d7cb30).  change_huge_pmd() and set_pmd_migration_entry()
> (8a8683ad9ba4) already do this; the MADV_COLD path does not.  Rebuild
> orig_pmd from the returned entry.
> 
> Reproduced unprivileged on x86-64: a 2 MiB anon THP is marked MADV_FREE,
> then MADV_COLD races a store from another CPU, then MADV_PAGEOUT; the
> stored byte reads back zero.  On current mainline built and booted under
> KVM, the race lost 131 of 8000 stores before this patch and 0 of 8000
> after; a store-before-COLD control and a MADV_NORMAL control lose none.
> 
> Fixes: 9c276cc65a58 ("mm: introduce MADV_COLD")
> Cc: stable@vger.kernel.org
> Signed-off-by: Samarth Narang <samarth.colleges@gmail.com>
> ---
>  mm/madvise.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -426,8 +426,14 @@
>  		}
>  
>  		if (!pageout && pmd_young(orig_pmd)) {
> -			pmdp_invalidate(vma, addr, pmd);
> -			orig_pmd = pmd_mkold(orig_pmd);
> +			/*
> +			 * Rebuild from the entry pmdp_invalidate() exchanged
> +			 * out, not from orig_pmd: hardware may have set the
> +			 * dirty bit since orig_pmd was read, and a MADV_FREE'd
> +			 * (lazyfree) THP whose dirty bit is lost is discarded
> +			 * by reclaim, silently dropping the store.
> +			 */
> +			orig_pmd = pmd_mkold(pmdp_invalidate(vma, addr, pmd));

Okay, you are saying we can lose the dirty bit that could get set concurrently.
And if we did an MADV_FREE before, we might not detect that the content was changed.


I suspect this found through the help of an LLM and not an actual use case in
practice?

Using MADV_COLD following MADV_FREE sounds odd at thirst. In particular, when
having MADV_COLD race with actual access.

On the PTE path we use clear_young_dirty_ptes(CYDP_CLEAR_YOUNG) which achieves
the same through ptep_test_and_clear_young().


... where we also just do a

pte = ptep_get(ptep);
set_pte_at(vma->vm_mm, address, ptep, pte_mkold(pte));

in the generic variant and rely on the per-arch variant to do the right thing.

Which makes me wonder whether we should actually have per-architecture PMD
helpers for that purpose?


-- 
Cheers,

David
