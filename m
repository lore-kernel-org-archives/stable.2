Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793173941;
	b=LeXvswjqMz/+7eYAx4tKEjncyItjiaqCMS003QtIGBhObreTRbZi2y1LWzc9iHnxWZwL
	 Ew8GaPNHukLaFAn6A+LDG1hS1nI0Y5UJdfGNV3CqbF7CIP6X8qWSheQWs8IVS5M0mLeSh
	 W4fOxCfnnBvwy9lekJUt1vqgQvz587kv/Qmr28h3iN4oa8mhV7O3vKgNQ+ogDDII3ztAt
	 S6Lf0Y6o5Dcr1SkIqRnsMtc9N68pTLcYHKLHfTJ2sm6aM4SYsOmDKI+qlpP7pT3BDUiS5
	 ttYao102JpoTWuKXhbI2eTpmYIZX1FmL9G0fu7jRUmN1EgxEbABlYYFwrxSenVGNS3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793173941;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=C2MebSDm+AGzraIelTihisR4wHMyVkbMMbZmgrZJ7WY=;
	b=LPkyzcTZcQti5CbA4YgBzLxmPv2ZQfXLXEYRu790di0RlUz5TZJcF7Y5/vWIRh7jjOkM
	 ufbgoWocLZr6LmnwIn7dxeLFUhS1OygNC0a6MHHbwuOQfvpgASaLFhdIfA45+5ZSydUTR
	 9rXddrwd/w5GVMZEO77diVGFdyqxFPWuBKuGM3qtOTqpZPd1B8z230IIB08iw0PweaAmd
	 ykTOYepb1oPbDeUaLf6uUjuOnhet2aGXFDUcWt9ujz9YH28xiB7nClipJPKBiMCrh5itW
	 Dt+JbiQgnAQ2b8zu1PSCq7Wog9/TpJQt2EzmgIa+lh7/bO5eGAqlh+9H+cIZ1aQuAHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=qAO7tgcE;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A45E606A31D;
	Wed, 28 Oct 2026 07:52:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A45E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=qAO7tgcE
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09F282ECB;
	Wed, 28 Oct 2026 00:52:16 -0700 (PDT)
Received: from [10.163.164.200] (unknown [10.163.164.200])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 046D23F673;
	Wed, 28 Oct 2026 00:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793173939; bh=wGe8fo0LsEeNmyXuE7t5RJoQX1lGKJltqCDxnR+anGM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qAO7tgcEvyo0Q3H3HaTM1nwzy8/QBeW1tnF4JOXa8qF71VXcIH8niSLEX8yBfM9DY
	 y3XuPsTISI5OiWjvg0v6LudaMoMHfe0T+fQRVNRKQDaWP3kjmosTINe/S2/q5eMvvF
	 XylgVFbGPVK2/y+rwaLieJ3EjGQdsqqHDKUNnM9o=
Message-ID: <e32a19c4-76c4-40ba-83a4-781333af7b0a@arm.com>
Date: Wed, 28 Oct 2026 13:21:55 +0530
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/46] mm/rmap: handle device-exclusive entries in
 folio_referenced_one()
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>,
 Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>,
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>,
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
 Baoquan He <baoquan.he@linux.dev>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>,
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>,
 Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Usama Arif <usama.arif@linux.dev>,
 Kiryl Shutsemau <kas@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
 Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>,
 Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>,
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>,
 Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>,
 Nhat Pham <nphamcs@gmail.com>, Youngjun Park <youngjun.park@lge.com>,
 Gregory Price <gourry@gourry.net>, Joshua Hahn <joshua.hahnjy@gmail.com>,
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>,
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org,
 stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-9-6f74bec9a5bb@kernel.org>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20261027-fixes_core-v1-9-6f74bec9a5bb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 27/10/26 4:47 am, David Hildenbrand (Arm) wrote:
> page_vma_mapped_walk() can return non-present device-exclusive entries,
> but folio_referenced_one() passes them to PTE young-bit accessors that
> require present PTEs.
> 
> We must neither call clear_flush_young_ptes_notify() nor
> folio_pte_batch() with non-present entries. For example, clearing the
> young bit on non-present PTEs can corrupt the entry: on arm64
> PTE_AF overlaps the swap type, so clearing it turns a device-exclusive
> entry into an ordinary swap entry.
> 
> folio_pte_batch() will VM_WARN_ON_FOLIO.
> 
> Apply the same approach as the previous fixes to e.g., damon_ptep_mkold():
> treat these entries as old from the CPU's perspective and obtain their
> young state through the MMU notifier.
> 
> Skip PTE batching and MGLRU look-around for non-present entries, and
> don't modify non-present PTEs.
> 
> Fixes: b756a3b5e7ea ("mm: device exclusive memory access")
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Cc: stable@vger.kernel.org
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---

Reviewed-by: Dev Jain <dev.jain@arm.com>

But nit below.


>  mm/rmap.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 1131b76bbbc28..0faef46806e5c 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -924,6 +924,7 @@ static bool folio_referenced_one(struct folio *folio,
>  	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, address, 0);
>  	int ptes = 0, referenced = 0;
>  	unsigned int nr;
> +	pte_t pteval;
>  
>  	while (page_vma_mapped_walk(&pvmw)) {
>  		address = pvmw.address;
> @@ -968,10 +969,12 @@ static bool folio_referenced_one(struct folio *folio,
>  			return false;
>  		}
>  
> -		if (pvmw.pte && folio_test_large(folio)) {
> +		if (pvmw.pte)
> +			pteval = ptep_get(pvmw.pte);
> +
> +		if (pvmw.pte && pte_present(pteval) && folio_test_large(folio)) {
>  			const unsigned long end_addr = pmd_addr_end(address, vma->vm_end);
>  			const unsigned int max_nr = (end_addr - address) >> PAGE_SHIFT;
> -			pte_t pteval = ptep_get(pvmw.pte);
>  
>  			nr = folio_pte_batch(folio, pvmw.pte, pteval, max_nr);
>  		}
> @@ -981,11 +984,23 @@ static bool folio_referenced_one(struct folio *folio,
>  		 * are. —they could be on active/inactive lists or on MGLRU. So the
>  		 * simplest approach is to disable this look-around optimization.
>  		 */
> -		if (lru_gen_enabled() && !lru_gen_switching() && pvmw.pte) {
> +		if (lru_gen_enabled() && !lru_gen_switching() && pvmw.pte &&
> +		    pte_present(pteval)) {
>  			if (lru_gen_look_around(&pvmw, nr))
>  				referenced++;
>  		} else if (pvmw.pte) {
> -			if (clear_flush_young_ptes_notify(vma, address, pvmw.pte, nr))
> +			bool young = false;
> +
> +			/*
> +			 * PFN swap PTEs, such as device-exclusive ones, that

You mean "PFN softleaf PTEs"? Better expressed as "softleaf PTEs embedding a PFN" ...


> +			 * actually map pages are "old" from a CPU perspective.
> +			 * The MMU notifier takes care of any device aspects.
> +			 */
> +			if (pte_present(pteval))
> +				young = clear_flush_young_ptes(vma, address, pvmw.pte, nr);
> +			young |= mmu_notifier_clear_flush_young(vma->vm_mm, address,
> +								address + nr * PAGE_SIZE);
> +			if (young)
>  				referenced++;
>  		} else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
>  			if (pmdp_clear_flush_young_notify(vma, address,
> 

