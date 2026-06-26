Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A4C2C11FA;
	Fri, 26 Jun 2026 03:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782443891; cv=none; b=gXeCIlhjjFwykA/Z3bHDDvSNRaDSUpvfgtvOXiKFTvqhTAY8UUf3VG06iBFjj4UGpJKAIST07d1nQpOjP7oZtaJivBs4kL8Jyl3wL3thyQqf4Wg1Xan9GePzslNvN5jIAfQxrUtAcSyydUyrJnZ7z+biehF3WIgwApALeH1yezM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782443891; c=relaxed/simple;
	bh=SIrzBechw8pC861FiUBjGRdVk/FO+vaHDtpa4S4PW+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pRE3TuV37FLqT30pwvjB7SyYUhsSLqlshSIPbQRvs3zn1Q6BSfcbuS8VQr18VlPQq7lRL8glS3Wrm4NBe6NXMqRlT8LCGDi0znu+XABBAOKy3OpxPN22bI/QQ28Kwj0G51cj1yUzdUyDGGpaIXTI8okbbmhFeSOcaQ9me++kNeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oeeeVHxT; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oeeeVHxT"
Message-ID: <f8516534-3b18-4988-b384-251225755285@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782443886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OZJmc3takRDK7jQCyQNoqz4XYBQ54vYpzBE2NdGeia8=;
	b=oeeeVHxTM1sDNbDtkvWfeWlWL81Q3QugP8nzSEd8pZBSgXF1GGvz6loEWo07SGCgjDI1dn
	zvkkgZVmV6zYGwHGOd53ypDtk5qJPYupHaWIx+YDFcl2/mIZyVDBjyKowQNpbf/CCz7YP6
	VfhfTscE5s4qRXV3XgaRUnsRxJx/L4c=
Date: Fri, 26 Jun 2026 11:17:05 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/5] mm/rmap: use huge_ptep_get() in try_to_unmap_one()
To: Dev Jain <dev.jain@arm.com>
Cc: riel@surriel.com, vbabka@kernel.org, harry@kernel.org, jannh@google.com,
 lance.yang@linux.dev, kas@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, rcampbell@nvidia.com, apopple@nvidia.com,
 ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com,
 rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net,
 ying.huang@linux.alibaba.com, mel@csn.ul.ie, nao.horiguchi@gmail.com,
 ak@linux.intel.com, j-nomura@ce.jp.nec.com, pfalcato@suse.de,
 dave.hansen@intel.com, tglx@kernel.org, jpoimboe@kernel.org,
 ryan.roberts@arm.com, anshuman.khandual@arm.com, stable@vger.kernel.org,
 osalvador@suse.de, akpm@linux-foundation.org, ljs@kernel.org,
 david@kernel.org, liam@infradead.org
References: <20260625112955.3254283-1-dev.jain@arm.com>
 <20260625112955.3254283-2-dev.jain@arm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20260625112955.3254283-2-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2026/6/25 19:29, Dev Jain wrote:
> try_to_unmap_one() handles hugetlb folios when memory failure needs
> to replace a poisoned hugetlb mapping with a hwpoison entry. In that
> case page_vma_mapped_walk() returns the pte pointer to the hugetlb folio
> in pvmw.pte, but the code reads it with ptep_get().
>
> On arches which provide their own huge_ptep_get() to dereference a huge
> pte pointer, accessing via ptep_get() would cause pte_pfn(), pte_present()
> etc to misbehave.
>
> It is not clear whether this has a trivially visible effect to userspace.
>
> Just use huge_ptep_get() for dereferencing a huge pte pointer.
>
> Fixes: c7ab0d2fdc84 ("mm: convert try_to_unmap_one() to use page_vma_mapped_walk()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
>   include/linux/hugetlb.h |  3 +++
>   mm/rmap.c               | 16 ++++++++++------
>   2 files changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 2abaf99321e90..fdb7bdf7645c5 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -1261,6 +1261,9 @@ static inline void hugetlb_count_sub(long l, struct mm_struct *mm)
>   {
>   }
>   
> +pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr,
> +		    pte_t *ptep);

Thanks so much for the fix! I'm curious, though: why do we
need to add a separate declaration for this function here?

Thanks,
Muchun

> +
>   static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
>   					  unsigned long addr, pte_t *ptep)
>   {
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 1c77d5dc06e9f..aa8a254efaecc 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -2095,11 +2095,16 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>   		/* Unexpected PMD-mapped THP? */
>   		VM_BUG_ON_FOLIO(!pvmw.pte, folio);
>   
> -		/*
> -		 * Handle PFN swap PTEs, such as device-exclusive ones, that
> -		 * actually map pages.
> -		 */
> -		pteval = ptep_get(pvmw.pte);
> +		address = pvmw.address;
> +		if (folio_test_hugetlb(folio)) {
> +			pteval = huge_ptep_get(mm, address, pvmw.pte);
> +		} else {
> +			/*
> +			 * Handle PFN swap PTEs, such as device-exclusive ones,
> +			 * that actually map pages.
> +			 */
> +			pteval = ptep_get(pvmw.pte);
> +		}
>   		if (likely(pte_present(pteval))) {
>   			pfn = pte_pfn(pteval);
>   		} else {
> @@ -2110,7 +2115,6 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>   		}
>   
>   		subpage = folio_page(folio, pfn - folio_pfn(folio));
> -		address = pvmw.address;
>   		anon_exclusive = folio_test_anon(folio) &&
>   				 PageAnonExclusive(subpage);
>   

