Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1844F37DAA2;
	Thu, 27 Aug 2026 17:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787850329; cv=none; b=Fycigui5ZGXHA31lSgJFezbXPBERu2FZ1j/NSVXYJYsAOCecM2dxXeuIeShlSfMJW79miC30YY1n9NhWaWaGDtcLylgu3fZBTkAgaGxHjvWlPqJXv1OpiCtThqlGsrnoB1A6vrt5cb2k0gHov0yFB/HWdHg9DOunGIOuRhy2jLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787850329; c=relaxed/simple;
	bh=+T3fC1Z2Qq5LFKz9ewfhbuQrC7L3AbjxbqO8cXfLHbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uVJtE9PCNTJ5t8pMIHojjYdrePaDRTas+ugkSbWUVVU2uctN2Eeg6QJZ+uP/Zrn4rOKuPrp3sHpijEBKd4w8G8K3HqLFbNlcIkbT0jm2nQECxOHxQbGeujl7jLb0fsZEYwsVl+RWLbqRucXSeEfxZgPZaxQXGPGVoQQFLCTecQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TACTRK+I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TACTRK+I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D953C1F000E9;
	Thu, 27 Aug 2026 17:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787850327;
	bh=I1lufsy6Im7NFt6gh/akpxHBSyR/Rxm6eWceVNKlW2g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=TACTRK+IOCMglSMFUPOyndXcTKYnKOgh5FybKkMq9h/FnqoOsf9eibohXzbUoE6kI
	 U+Wk5sA6pKUcf/AmHtw8iWWcCDMPMSjPfikBDWpYsUEFq9xru871uaWIyNMdyfqLxL
	 nku5/C9TzWJM+SzPhRFKwtMfhiOZcK1YDPftnwG6+LxoCw6qRPCkoGAFSuWVSteog3
	 z+C0wenTac1qFktXGT5JHIBRsbhkgCl8tDM/UVsbmEKyMY+rCQOuzfkKdrQd4fPSsq
	 8+0U27G5Mt66hdxlP/t/3pk/MWFCTkUOJNnPZ4QVW+qXaY6FpMnmvrVSkAtyFZE5EM
	 61Sr2IH44g4ug==
Message-ID: <6d855beb-1d24-4a6e-ae62-ac9e05e358e5@kernel.org>
Date: Thu, 27 Aug 2026 19:05:21 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/mempolicy: use vm_normal_folio_pmd() in
 queue_folios_pmd()
To: Gregory Price <gourry@gourry.net>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
 akpm@linux-foundation.org, liam@infradead.org, ljs@kernel.org,
 vbabka@kernel.org, jannh@google.com, ziy@nvidia.com,
 matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
 byungchul@sk.com, ying.huang@linux.alibaba.com, apopple@nvidia.com,
 peterx@redhat.com, jgg@ziepe.ca, sashiko-bot <sashiko-bot@kernel.org>,
 stable@vger.kernel.org
References: <20260821144947.167382-1-gourry@gourry.net>
 <20260821144947.167382-2-gourry@gourry.net>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260821144947.167382-2-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/21/26 16:49, Gregory Price wrote:
> mmap a VM_PFNMAP region whose ->huge_fault installs a PMD through
> vmf_insert_pfn_pmd() - a vfio-pci MMIO BAR does this - then
> 
> 	mbind(p, len, MPOL_BIND, &mask, maxnode, MPOL_MF_STRICT);
> 
> With a stand-in module for the driver:
> 
>   BUG: unable to handle page fault for address: fffff96dc0000008
>   RIP: 0010:queue_folios_pte_range+0xaf/0x440
>    walk_pgd_range+0x52b/0xaf0
>    __walk_page_range+0x6a/0x1d0
>    walk_page_range_mm_unsafe+0x193/0x230
>    queue_pages_range+0x64/0xa0
>    do_mbind+0x25e/0x640
> 
> queue_folios_pmd(), inlined above, calls pmd_folio() on that PMD.  The pfn
> is raw MMIO with no memmap entry, so the folio lands in unpopulated
> vmemmap.  Neither guard stops the walk:
> 
>   walk_page_test()         skips VM_PFNMAP, but queue_pages_walk_ops
>                            supplies ->test_walk, so it never runs
>   queue_pages_test_walk()  honours vma_migratable(), but only while
>                            MPOL_MF_STRICT is clear
> 
> A VM_MIXEDMAP vma needs neither flag, being vma_migratable(), so plain
> mbind(MPOL_MF_MOVE) reaches this too - and there the bad folio carries on
> into migrate_folio_add() and folio_isolate_lru().  mshv_vtl_low is such a
> mapping.
> 
> Use vm_normal_folio_pmd() and skip on NULL, as the PTE loop in
> queue_folios_pte_range() already does with vm_normal_folio().  The huge
> zero PMD moves ahead of the lookup, since vm_normal_folio_pmd() returns
> NULL for it and its ACTION_CONTINUE would be lost.
> 
> mbind(MPOL_MF_STRICT) over a PMD mapped VM_PFNMAP region now returns 0
> rather than -EIO.  The PTE loop already returned 0 there.
> 
> Fixes: 3c8e44c9b369 ("mm: mark special bits for huge pfn mappings when inject")
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260817220810.1175596-1-gourry%40gourry.net
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
> ---
>  mm/mempolicy.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index f1aba551f9f1..85803c845965 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -650,7 +650,8 @@ static inline bool queue_folio_required(struct folio *folio,
>  	return node_isset(nid, *qp->nmask) == !(flags & MPOL_MF_INVERT);
>  }
>  
> -static void queue_folios_pmd(pmd_t *pmd, struct mm_walk *walk)
> +static void queue_folios_pmd(pmd_t *pmd, unsigned long addr,
> +			     struct mm_walk *walk)
>  {
>  	struct folio *folio;
>  	struct queue_pages *qp = walk->private;
> @@ -661,13 +662,15 @@ static void queue_folios_pmd(pmd_t *pmd, struct mm_walk *walk)
>  			qp->nr_failed++;
>  		return;
>  	}
> -	folio = pmd_folio(pmdval);
> -	if (folio_is_zone_device(folio))
> -		return;
> -	if (is_huge_zero_folio(folio)) {
> +	if (is_huge_zero_pmd(pmdval)) {
>  		walk->action = ACTION_CONTINUE;
>  		return;
>  	}
> +	folio = vm_normal_folio_pmd(walk->vma, addr, pmdval);
> +	if (!folio)
> +		return


I think this is best written as:

folio = vm_normal_folio_pmd(walk->vma, addr, pmdval);
if (!folio) {
	if (is_huge_zero_pmd(pmdval)) {
		walk->action = ACTION_CONTINUE;
		return;
	}
	return;
}
That way we minimize checks on the expected path.

Acked-by: David Hildenbrand (Arm) <david@kernel.org>

-- 
Cheers,

David
