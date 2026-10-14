Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331BE1D9A66;
	Wed, 14 Oct 2026 06:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791957771; cv=none; b=SxNSqAowursnQH+gZNLRRlEB0HSso/PwqKl6ubAbOWTdoZG9lkYmFP7Hk1Npwj8jmO3cMqZf7xz6+fxvS4CFg2BJkxNU7aPU2zM4+e+t4g29SDZ1EIbasdz5hhmst1p1nfcZAKYeIJ8QE6gKEHR0V6AP0HbwU1RD9XhKhGhs+C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791957771; c=relaxed/simple;
	bh=apB+CCNmmj5PykOfXdfLni7NehzQcXSALn7GneS2rG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UdEMIvChlAeqd0iqF9MYQtJRWNybLyyV/gujOI36VU788Q1JlGQuMGn6uMBDgL2nrC0wMnNCFrmBGlvY+NbtfKNt2EVtZHdP1+nbJ+IDkIpBj16KjiRBOun4gTrzeLeBUoAwR1OReSNPWFFjGB4LJrepUI8EwQo0MMbO6H331w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=reh3EPjm; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="reh3EPjm"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1791957765; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=9BIscm2cTTBNlc9P4KV7eUnjnf4F0Y6UQu2TU1+hhSQ=;
	b=reh3EPjmmP0ATGMx3tdU85PVBPkJA2d9P5dQXJuumoYd0q/MPh+0P7KwswuD3Ik6yrCPdw2zs8sxRDjwrcE7zPbJ7jDZlpb27EWsOSyTxI66EZwrd3P+3sUu4/0D98r8TWy/dreT17pawSvrgaLbMOpYWuIyvHe+8RDo9wS7HKw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0XCo3AyK_1791957763;
Received: from 30.74.144.153(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0XCo3AyK_1791957763 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 14 Oct 2026 14:02:44 +0800
Message-ID: <5848db18-9de3-437b-9967-162ced4f8cb9@linux.alibaba.com>
Date: Wed, 14 Oct 2026 14:02:43 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: fix address wraparound when scanning large folio PTEs
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Ying Huang <huang.ying.caritas@gmail.com>,
 Barry Song <baohua@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Chuanhua Han <hanchuanhua@oppo.com>, Kiryl Shutsemau <kas@kernel.org>,
 Kyle Zeng <kylebot@openai.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261013-folio_pte_scan_range-v1-1-c50dc30bf6ad@kernel.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20261013-folio_pte_scan_range-v1-1-c50dc30bf6ad@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/13/26 8:30 PM, David Hildenbrand (Arm) wrote:
> numa_rebuild_large_mapping() and do_swap_page() can be tricked into
> generating an address wraparound, crashing the kernel. All that's required
> is to map a tail page of a large folio close enough to the start/end of
> the address space to e.g., make
> 
> 	unsigned long addr_start = addr - (nr << PAGE_SHIFT);
> 
> to wrap around.
> 
> Let's fix it by providing a better helper, folio_pte_scan_range(), that
> takes care of staying within VMA and page table boundaries while
> handling possible wraparounds.
> 
> Reported-by: Kyle Zeng <kylebot@openai.com>
> Fixes: d2136d749d76 ("mm: support multi-size THP numa balancing")
> Fixes: 508758960b8d ("mm: swap: entirely map large folios found in swapcache")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---

Thanks for the fix.

>   mm/memory.c | 43 +++++++++++++++++++++++++++++--------------
>   1 file changed, 29 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 1f5d5f7d39cd2..a3823010aa981 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4933,6 +4933,27 @@ static void check_swap_exclusive(struct folio *folio, swp_entry_t entry,
>   	} while (--nr_pages);
>   }
>   
> +/*
> + * Get the address range in which a folio might be mapped, assuming its pages
> + * are mapped consecutively and the folio page at the given idx is mapped at
> + * the given address.
> + */
> +static void folio_pte_scan_range(const struct folio *folio,
> +		const struct vm_area_struct *vma, unsigned long addr,
> +		unsigned long idx, unsigned long *start, unsigned long *end)
> +{
> +	/* Stay within the page table and VMA boundaries. */
> +	const unsigned long pmd_start = addr & PMD_MASK;
> +	const unsigned long pmd_end = pmd_start + PMD_SIZE;
> +	const unsigned long lower = max(pmd_start, vma->vm_start);
> +	const unsigned long upper = min(pmd_end - 1, vma->vm_end - 1) + 1;

I also agree with Barry and Lorenzo's suggestion to use the more 
readable pmd_addr_end() helper. With Lorenzo's comments addressed, feel 
free to add:
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
