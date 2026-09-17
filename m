Received: from flow-b1-smtp.messagingengine.com (flow-b1-smtp.messagingengine.com [202.12.124.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEAD4AE8D5
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 11:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789644343; cv=none; b=njsTqxPKC7mJs04B3ki1j4AvXkOG5MTZxO5Xuv+2gy3HfAKomacnYEvxPGvKdNXTpcqpj3GgphhFpIzfJ4l8kY+7fiaSbKspmHBXosg5L/0HHOoaNfykaw+ghqfgUa7CW8QfuKMIt+RaqKaaGcxaIdKM4xJIIKEVJiSnCc4B8iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789644343; c=relaxed/simple;
	bh=kifHC06CZ2nirbmjHbnLejHqyCUPH+WywfQaGCrbKqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=khDOWdgtZ8INXCLl5X6sTC2zrIOAeeHSIZXJULuHyDLkskxZlOC8fzbTYC9qRVt4P+Tz319sQvyVz8lNxJTG5sKmQxZHAz6L3CxIG0s7PgMFLBK/Vv2eKyajLwnE1zG/3N9GE90wpo50ZvKA+l+P/OSwEGvenWzR3Y26Iqana9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=PX4ouIyJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wVgFF4kp; arc=none smtp.client-ip=202.12.124.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="PX4ouIyJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wVgFF4kp"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailflow.stl.internal (Postfix) with ESMTP id B5B8A1300493;
	Thu, 17 Sep 2026 07:25:36 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Thu, 17 Sep 2026 07:25:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1789644336; x=1789651536; bh=4WyEpjHwro
	uKKlA6woYFAmn7bjWKvXqfrX22/LUIh/g=; b=PX4ouIyJz8Jnj14BTbuAEMer1P
	99D61bcx+FH+wQWfmi4Lcz+RCq76HJawxXBn/3yb0jgl/xoCXyhNjE4W8WPdl+b5
	MS3zGLO/ob9OI4QwLSK9JNHwiT2fT8nIyAcV98c6awtcCXEVFfmFq47y2vSJXzZ2
	3Ga5cbXoDNMvNpQGbFse4BkmUgI0SikQSUFlVIBtY97onhs471oxX6wMZgmfvif5
	DMMtOXLacu6F2Qk0haFdA9qOMtN0DRe2uAOBvFz5AJRoglAaqHhM9QEVkQjB+bBa
	TLqbwrtv5Dc80QBMeTHa65PcEKpf1j2/8jIrdj1gZ8tM/Q7+kzEf5e96WR2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789644336; x=1789651536; bh=4WyEpjHwrouKKlA6woYFAmn7bjWKvXqfrX2
	2/LUIh/g=; b=wVgFF4kp6Uprddv7n/idqVWy+WtB9ADY5QfpJFkgbvxsmkDHq9X
	j7PEdK7Gs96ivtXA3Z6h66mGrndHw8jTR5p18I8O4GHfY7cmGyT1oAU2WEZYEW5p
	F3NgerQHfmud4dvBlA8BxDUDoWfuckGrEdFm5MFhHUw6XxbUqHzM+0jUgwl9wNmf
	Tk/Z1J0CLRiUUgqPpb1cI1qaZ/Jy7jkkEsQkqGH7/x5ifJncaVQ/XEDXtLtbz4CF
	5XdGd6ZlDqgwIrmXY6WdgwwDt/OWyCBD14IaBvbTat8pSXBkl/JdAEvKnJ+yIBni
	9bDiom7dHfyI05P9Cih/23qko6PfgtfyWag==
X-ME-Sender: <xms:Lc6rauvrf13KLp2dEyi_NbXv1BuWjQxapkWN_ts8IJ3410XHMWQ0Fw>
    <xme:Lc6ratCm2G9l4VR2xBi9S_3l7FqFWrBKqCYZt_svUR4_aEV9PbyArWmtAZxVdAXJx
    dUZdN4rdV30eXgbDK907tHGEOQEV0iUcOQY5XWisf6sy5XAgd4>
X-ME-Received: <xmr:Lc6raoEgy_qi1008vv34EDEndE5_mxbZ_XsumJotj617gy0HbpWHG3-XQzZR>
X-ME-Proxy-Cause: dmFkZTGb91nlMSWjDuYt4/KY0QKXeMT4xwqS1pMayRxlhcu7GXT57CDoFdIK0oXf2tkeid
    Rim5JgRCA5uMVjMy9q9u4lwCiyXuUdPgQ41BrCnlCNxlNLFi86hM5SnZSIIGaOTezpeDCZ
    DoFILMO+Czj3cMbWY/rYo46dbGtI2xyDlyhxt+o1WXXFDD/9nraCipo2Av9z8qBBRcwKH0
    33Sp3fCXi8Yyf09fnNDGBHyZzvEj0hgbGLgQ0jVSFuYk4n1SYlAKokwQBRKnV3dK8h1iWs
    GwC7Y+AloWkWAUGazxwNqpD7J3tjOEs1o9oe6HH9oUtLACaMd1ESO++3v1AHOTNs2S3qrg
    P52CZKVLwhC8TuJYhFNnsEcP7hMfrHYIfZw9uNC1nmLrx4k1oxxv8kFXCsLOkGMKU9/em0
    78jrWGv6NqKSZh5oB35WgcXImLWC5Xis8B0RBqSj2vwbfWEUJ/IuRVyW+EkPAIY4HDxN87
    cEau7gVKczgLBrsqDYu7wSsQPuZ6SI0aXfaYopLJdOv+YpN8erqNQLT2ivdinwIDmcqncv
    Vu6HwW0Z6OJyIeHPIwXaaU0azCk6s+YFgTUF9x01tpzNczrHXwgTXO272v3A8lUvdvwWZH
    RETO0AEKS40BDFoRuuQMKcm30ZgGCF6DCuuRmoaS1dpwAiGXoVythlGv+MaQ
X-ME-Proxy: <xmx:Lc6rateMyBEDNXClG8hFMI01agzRH8E2EIzm3E-BgDyZZ1jKMApyVQ>
    <xmx:Lc6raoEZaKSOygzWPKgvtVmDNFUhh6immJcexGQXTN69yWlCYJ6hjA>
    <xmx:Lc6ranbevkrjEJtjXfoXTDOp57t2AEcoAL8Adw26987qJYw5E86skQ>
    <xmx:Lc6rarHMuchsvmBiADuPyuLdqDg3Uu2pUmbcifUl1sSF1ilLcOTJVQ>
    <xmx:MM6rauz_mWKKKrkQ3hlSCThO26CRaRWuT4qkQnLJ-XzfprGwyb_5X_Qu>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Sep 2026 07:25:31 -0400 (EDT)
Date: Thu, 17 Sep 2026 12:21:02 +0100
From: Greg KH <greg@kroah.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Alistair Popple <apopple@nvidia.com>,	Al Viro <viro@zeniv.linux.org.uk>,
 Arnd Bergmann <arnd@arndb.de>,	Axel Rasmussen <axelrasmussen@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,	Baoquan He <bhe@redhat.com>,
 Barry Song <baohua@kernel.org>,	Byungchul Park <byungchul@sk.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,	Chris Li <chrisl@kernel.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Christian Brauner <brauner@kernel.org>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>, Dev Jain <dev.jain@arm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Gregory Price <gourry@gourry.net>,	Heiko Carstens <hca@linux.ibm.com>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
	Jann Horn <jannh@google.com>, Janosch Frank <frankja@linux.ibm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Kairui Song <kasong@tencent.com>,	Kemeng Shi <shikemeng@huaweicloud.com>,
	Lance Yang <lance.yang@linux.dev>,	Leon Romanovsky <leon@kernel.org>,
	Liam Howlett <liam.howlett@oracle.com>,
	Mathew Brost <matthew.brost@intel.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Miaohe Lin <linmiaohe@huawei.com>, Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,	Muchun Song <muchun.song@linux.dev>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,	Nhat Pham <nphamcs@gmail.com>,
 Nico Pache <npache@redhat.com>,	Oscar Salvador <osalvador@suse.de>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,	Peter Xu <peterx@redhat.com>,
 Rakie Kim <rakie.kim@sk.com>,	Rik van Riel <riel@surriel.com>,
	Ryan Roberts <ryan.roberts@arm.com>, SeongJae Park <sj@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Sven Schnelle <svens@linux.ibm.com>,	Vasily Gorbik <gor@linux.ibm.com>,
 Wei Xu <weixugc@google.com>,	xu xin <xu.xin16@zte.com.cn>,
 Yuanchu Xie <yuanchu@google.com>,	Zi Yan <ziy@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.12.y 1/2] mm: avoid unnecessary use of is_swap_pmd()
Message-ID: <2026091757-engaged-predict-ef27@gregkh>
References: <2026090358-glandular-hardiness-9af2@gregkh>
 <20260904030233.2306854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904030233.2306854-1-sashal@kernel.org>

On Thu, Sep 03, 2026 at 11:02:32PM -0400, Sasha Levin wrote:
> From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> 
> [ Upstream commit aa62204cb680d8ff32497181fc9e0dac4956f7e5 ]
> 
> PMD 'non-swap' swap entries are currently used for PMD-level migration
> entries and device private entries.
> 
> To add to the confusion in this terminology we use is_swap_pmd() in an
> inconsistent way similar to how is_swap_pte() was being used - sometimes
> adopting the convention that !pmd_none(), !pmd_present() implies PMD 'swap'
> entry, sometimes not.
> 
> This patch handles the low-hanging fruit of cases where we can simply
> substitute other predicates for is_swap_pmd().
> 
> No functional change intended.
> 
> Link: https://lkml.kernel.org/r/8a1704b36a009c18032d5bea4cb68e71448fbbe5.1762812360.git.lorenzo.stoakes@oracle.com
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Axel Rasmussen <axelrasmussen@google.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Barry Song <baohua@kernel.org>
> Cc: Byungchul Park <byungchul@sk.com>
> Cc: Chengming Zhou <chengming.zhou@linux.dev>
> Cc: Chris Li <chrisl@kernel.org>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Dev Jain <dev.jain@arm.com>
> Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> Cc: Gregory Price <gourry@gourry.net>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: "Huang, Ying" <ying.huang@linux.alibaba.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Jann Horn <jannh@google.com>
> Cc: Janosch Frank <frankja@linux.ibm.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
> Cc: Kairui Song <kasong@tencent.com>
> Cc: Kemeng Shi <shikemeng@huaweicloud.com>
> Cc: Lance Yang <lance.yang@linux.dev>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: Liam Howlett <liam.howlett@oracle.com>
> Cc: Mathew Brost <matthew.brost@intel.com>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Miaohe Lin <linmiaohe@huawei.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Muchun Song <muchun.song@linux.dev>
> Cc: Naoya Horiguchi <nao.horiguchi@gmail.com>
> Cc: Nhat Pham <nphamcs@gmail.com>
> Cc: Nico Pache <npache@redhat.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Rakie Kim <rakie.kim@sk.com>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: SeongJae Park <sj@kernel.org>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Wei Xu <weixugc@google.com>
> Cc: xu xin <xu.xin16@zte.com.cn>
> Cc: Yuanchu Xie <yuanchu@google.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Stable-dep-of: 9be12ffa78cd ("mm/rmap: use huge_ptep_get() in try_to_migrate_one()")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/proc/task_mmu.c       |  15 ++++-
>  include/linux/mm_types.h |   3 +
>  include/linux/swapops.h  |  12 +++-
>  mm/huge_memory.c         |   4 +-
>  mm/memory.c              |  49 ++++++++-------
>  mm/page_table_check.c    |  12 ++--
>  mm/rmap.c                | 126 ++++++++++++++++-----------------------
>  7 files changed, 117 insertions(+), 104 deletions(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 44dc442b4f0e7..cfcf0daa1e626 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -860,10 +860,12 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
>  	bool present = false;
>  	struct folio *folio;
>  
> +	if (pmd_none(*pmd))
> +		return;
>  	if (pmd_present(*pmd)) {
>  		page = vm_normal_page_pmd(vma, addr, *pmd);
>  		present = true;
> -	} else if (unlikely(thp_migration_supported() && is_swap_pmd(*pmd))) {
> +	} else if (unlikely(thp_migration_supported())) {
>  		swp_entry_t entry = pmd_to_swp_entry(*pmd);
>  
>  		if (is_pfn_swap_entry(entry))
> @@ -1786,6 +1788,9 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
>  		if (vma->vm_flags & VM_SOFTDIRTY)
>  			flags |= PM_SOFT_DIRTY;
>  
> +		if (pmd_none(pmd))
> +			goto populate_pagemap;
> +
>  		if (pmd_present(pmd)) {
>  			page = pmd_page(pmd);
>  
> @@ -1798,7 +1803,7 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
>  				frame = pmd_pfn(pmd) + idx;
>  		}
>  #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
> -		else if (is_swap_pmd(pmd)) {
> +		else {
>  			swp_entry_t entry = pmd_to_swp_entry(pmd);
>  			unsigned long offset;
>  
> @@ -1826,6 +1831,7 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
>  				flags |= PM_FILE;
>  		}
>  
> +populate_pagemap:
>  		for (; addr != end; addr += PAGE_SIZE, idx++) {
>  			u64 cur_flags = flags;
>  			pagemap_entry_t pme;
> @@ -2172,6 +2178,9 @@ static unsigned long pagemap_thp_category(struct pagemap_scan_private *p,
>  {
>  	unsigned long categories = PAGE_IS_HUGE;
>  
> +	if (pmd_none(pmd))
> +		return categories;
> +
>  	if (pmd_present(pmd)) {
>  		struct page *page;
>  
> @@ -2189,7 +2198,7 @@ static unsigned long pagemap_thp_category(struct pagemap_scan_private *p,
>  			categories |= PAGE_IS_PFNZERO;
>  		if (pmd_soft_dirty(pmd))
>  			categories |= PAGE_IS_SOFT_DIRTY;
> -	} else if (is_swap_pmd(pmd)) {
> +	} else {
>  		swp_entry_t swp;
>  
>  		categories |= PAGE_IS_SWAPPED;
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 2113f7da182c6..ca4e4a1c2d0b9 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -283,6 +283,9 @@ typedef struct {
>  	unsigned long val;
>  } swp_entry_t;
>  
> +/* Transitional name used by newer MM fixes. */
> +typedef swp_entry_t softleaf_t;
> +
>  /**
>   * struct folio - Represents a contiguous set of bytes.
>   * @flags: Identical to the page flags.
> diff --git a/include/linux/swapops.h b/include/linux/swapops.h
> index d988ce9516510..d06bda5be5768 100644
> --- a/include/linux/swapops.h
> +++ b/include/linux/swapops.h
> @@ -139,6 +139,10 @@ static inline swp_entry_t pte_to_swp_entry(pte_t pte)
>  	return swp_entry(__swp_type(arch_entry), __swp_offset(arch_entry));
>  }
>  
> +/* Transitional softleaf spellings for the equivalent swap entry helpers. */
> +#define softleaf_from_pte(pte) pte_to_swp_entry(pte)
> +#define softleaf_to_pfn(entry) swp_offset_pfn(entry)
> +
>  /*
>   * Convert the arch-independent representation of a swp_entry_t into the
>   * arch-dependent pte representation.
> @@ -569,7 +573,13 @@ static inline pmd_t swp_entry_to_pmd(swp_entry_t entry)
>  
>  static inline int is_pmd_migration_entry(pmd_t pmd)
>  {
> -	return is_swap_pmd(pmd) && is_migration_entry(pmd_to_swp_entry(pmd));
> +	swp_entry_t entry;
> +
> +	if (pmd_present(pmd))
> +		return 0;
> +
> +	entry = pmd_to_swp_entry(pmd);
> +	return is_migration_entry(entry);
>  }
>  #else  /* CONFIG_ARCH_ENABLE_THP_MIGRATION */
>  static inline int set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 29cbe43b60a4f..6fc4e1fb88ae6 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2149,9 +2149,11 @@ static pmd_t move_soft_dirty_pmd(pmd_t pmd)
>  
>  static pmd_t clear_uffd_wp_pmd(pmd_t pmd)
>  {
> +	if (pmd_none(pmd))
> +		return pmd;
>  	if (pmd_present(pmd))
>  		pmd = pmd_clear_uffd_wp(pmd);
> -	else if (is_swap_pmd(pmd))
> +	else
>  		pmd = pmd_swp_clear_uffd_wp(pmd);
>  
>  	return pmd;
> diff --git a/mm/memory.c b/mm/memory.c
> index 359de59c39b1a..c493f18cfb3ab 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5901,34 +5901,39 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
>  	    thp_vma_allowable_order(vma, vm_flags,
>  				TVA_IN_PF | TVA_ENFORCE_SYSFS, PMD_ORDER)) {
>  		ret = create_huge_pmd(&vmf);
> -		if (!(ret & VM_FAULT_FALLBACK))
> +		if (ret & VM_FAULT_FALLBACK)
> +			goto fallback;
> +		else
>  			return ret;
> -	} else {
> -		vmf.orig_pmd = pmdp_get_lockless(vmf.pmd);
> +	}
>  
> -		if (unlikely(is_swap_pmd(vmf.orig_pmd))) {
> -			VM_BUG_ON(thp_migration_supported() &&
> -					  !is_pmd_migration_entry(vmf.orig_pmd));
> -			if (is_pmd_migration_entry(vmf.orig_pmd))
> -				pmd_migration_entry_wait(mm, vmf.pmd);
> -			return 0;
> -		}
> -		if (pmd_trans_huge(vmf.orig_pmd) || pmd_devmap(vmf.orig_pmd)) {
> -			if (pmd_protnone(vmf.orig_pmd) && vma_is_accessible(vma))
> -				return do_huge_pmd_numa_page(&vmf);
> +	vmf.orig_pmd = pmdp_get_lockless(vmf.pmd);
> +	if (pmd_none(vmf.orig_pmd))
> +		goto fallback;
>  
> -			if ((flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) &&
> -			    !pmd_write(vmf.orig_pmd)) {
> -				ret = wp_huge_pmd(&vmf);
> -				if (!(ret & VM_FAULT_FALLBACK))
> -					return ret;
> -			} else {
> -				huge_pmd_set_accessed(&vmf);
> -				return 0;
> -			}
> +	if (unlikely(!pmd_present(vmf.orig_pmd))) {
> +		VM_BUG_ON(thp_migration_supported() &&
> +				  !is_pmd_migration_entry(vmf.orig_pmd));
> +		if (is_pmd_migration_entry(vmf.orig_pmd))
> +			pmd_migration_entry_wait(mm, vmf.pmd);
> +		return 0;
> +	}
> +	if (pmd_trans_huge(vmf.orig_pmd) || pmd_devmap(vmf.orig_pmd)) {
> +		if (pmd_protnone(vmf.orig_pmd) && vma_is_accessible(vma))
> +			return do_huge_pmd_numa_page(&vmf);
> +
> +		if ((flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) &&
> +		    !pmd_write(vmf.orig_pmd)) {
> +			ret = wp_huge_pmd(&vmf);
> +			if (!(ret & VM_FAULT_FALLBACK))
> +				return ret;
> +		} else {
> +			huge_pmd_set_accessed(&vmf);
> +			return 0;
>  		}
>  	}
>  
> +fallback:
>  	return handle_pte_fault(&vmf);
>  }
>  
> diff --git a/mm/page_table_check.c b/mm/page_table_check.c
> index 509c6ef8de400..ee52927e9e66b 100644
> --- a/mm/page_table_check.c
> +++ b/mm/page_table_check.c
> @@ -228,10 +228,14 @@ EXPORT_SYMBOL(__page_table_check_ptes_set);
>  
>  static inline void page_table_check_pmd_flags(pmd_t pmd)
>  {
> -	if (pmd_present(pmd) && pmd_uffd_wp(pmd))
> -		WARN_ON_ONCE(pmd_write(pmd));
> -	else if (is_swap_pmd(pmd) && pmd_swp_uffd_wp(pmd))
> -		WARN_ON_ONCE(swap_cached_writable(pmd_to_swp_entry(pmd)));
> +	if (pmd_present(pmd)) {
> +		if (pmd_uffd_wp(pmd))
> +			WARN_ON_ONCE(pmd_write(pmd));
> +	} else if (pmd_swp_uffd_wp(pmd)) {
> +		swp_entry_t entry = pmd_to_swp_entry(pmd);
> +
> +		WARN_ON_ONCE(swap_cached_writable(entry));
> +	}
>  }
>  
>  void __page_table_check_pmd_set(struct mm_struct *mm, pmd_t *pmdp, pmd_t pmd)
> diff --git a/mm/rmap.c b/mm/rmap.c
> index ea9c6d540d498..36a2e0eb8be48 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -2001,9 +2001,9 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
>  {
>  	struct mm_struct *mm = vma->vm_mm;
>  	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, address, 0);
> +	bool anon_exclusive, writable, ret = true;
>  	pte_t pteval;
>  	struct page *subpage;
> -	bool anon_exclusive, ret = true;
>  	struct mmu_notifier_range range;
>  	enum ttu_flags flags = (enum ttu_flags)(long)arg;
>  	unsigned long pfn;
> @@ -2070,24 +2070,21 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
>  		/* Unexpected PMD-mapped THP? */
>  		VM_BUG_ON_FOLIO(!pvmw.pte, folio);
>  
> -		pfn = pte_pfn(ptep_get(pvmw.pte));
> -
> -		if (folio_is_zone_device(folio)) {
> -			/*
> -			 * Our PTE is a non-present device exclusive entry and
> -			 * calculating the subpage as for the common case would
> -			 * result in an invalid pointer.
> -			 *
> -			 * Since only PAGE_SIZE pages can currently be
> -			 * migrated, just set it to page. This will need to be
> -			 * changed when hugepage migrations to device private
> -			 * memory are supported.
> -			 */
> -			VM_BUG_ON_FOLIO(folio_nr_pages(folio) > 1, folio);
> -			subpage = &folio->page;
> +		/*
> +		 * Handle PFN swap PTEs, such as device-exclusive ones, that
> +		 * actually map pages.
> +		 */
> +		pteval = ptep_get(pvmw.pte);
> +		if (likely(pte_present(pteval))) {
> +			pfn = pte_pfn(pteval);
>  		} else {
> -			subpage = folio_page(folio, pfn - folio_pfn(folio));
> +			const softleaf_t entry = softleaf_from_pte(pteval);
> +
> +			pfn = softleaf_to_pfn(entry);
> +			VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
>  		}
> +
> +		subpage = folio_page(folio, pfn - folio_pfn(folio));
>  		address = pvmw.address;
>  		anon_exclusive = folio_test_anon(folio) &&
>  				 PageAnonExclusive(subpage);
> @@ -2141,7 +2138,10 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
>  			}
>  			/* Nuke the hugetlb page table entry */
>  			pteval = huge_ptep_clear_flush(vma, address, pvmw.pte);
> -		} else {
> +			if (pte_dirty(pteval))
> +				folio_mark_dirty(folio);
> +			writable = pte_write(pteval);
> +		} else if (likely(pte_present(pteval))) {
>  			flush_cache_page(vma, address, pfn);
>  			/* Nuke the page table entry. */
>  			if (should_defer_flush(mm, flags)) {
> @@ -2159,54 +2159,23 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
>  			} else {
>  				pteval = ptep_clear_flush(vma, address, pvmw.pte);
>  			}
> +			if (pte_dirty(pteval))
> +				folio_mark_dirty(folio);
> +			writable = pte_write(pteval);
> +		} else {
> +			pte_clear(mm, address, pvmw.pte);
> +			writable = is_writable_device_private_entry(pte_to_swp_entry(pteval));
>  		}
>  
> -		/* Set the dirty flag on the folio now the pte is gone. */
> -		if (pte_dirty(pteval))
> -			folio_mark_dirty(folio);
> +		VM_WARN_ON_FOLIO(writable && folio_test_anon(folio) &&
> +				!anon_exclusive, folio);
>  
>  		/* Update high watermark before we lower rss */
>  		update_hiwater_rss(mm);
>  
> -		if (folio_is_device_private(folio)) {
> -			unsigned long pfn = folio_pfn(folio);
> -			swp_entry_t entry;
> -			pte_t swp_pte;
> -
> -			if (anon_exclusive)
> -				WARN_ON_ONCE(folio_try_share_anon_rmap_pte(folio,
> -									   subpage));
> -
> -			/*
> -			 * Store the pfn of the page in a special migration
> -			 * pte. do_swap_page() will wait until the migration
> -			 * pte is removed and then restart fault handling.
> -			 */
> -			entry = pte_to_swp_entry(pteval);
> -			if (is_writable_device_private_entry(entry))
> -				entry = make_writable_migration_entry(pfn);
> -			else if (anon_exclusive)
> -				entry = make_readable_exclusive_migration_entry(pfn);
> -			else
> -				entry = make_readable_migration_entry(pfn);
> -			swp_pte = swp_entry_to_pte(entry);
> +		if (PageHWPoison(subpage)) {
> +			VM_WARN_ON_FOLIO(folio_is_device_private(folio), folio);
>  
> -			/*
> -			 * pteval maps a zone device page and is therefore
> -			 * a swap pte.
> -			 */
> -			if (pte_swp_soft_dirty(pteval))
> -				swp_pte = pte_swp_mksoft_dirty(swp_pte);
> -			if (pte_swp_uffd_wp(pteval))
> -				swp_pte = pte_swp_mkuffd_wp(swp_pte);
> -			set_pte_at(mm, pvmw.address, pvmw.pte, swp_pte);
> -			trace_set_migration_pte(pvmw.address, pte_val(swp_pte),
> -						folio_order(folio));
> -			/*
> -			 * No need to invalidate here it will synchronize on
> -			 * against the special swap migration pte.
> -			 */
> -		} else if (PageHWPoison(subpage)) {
>  			pteval = swp_entry_to_pte(make_hwpoison_entry(subpage));
>  			if (folio_test_hugetlb(folio)) {
>  				hugetlb_count_sub(folio_nr_pages(folio), mm);
> @@ -2216,8 +2185,8 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
>  				dec_mm_counter(mm, mm_counter(folio));
>  				set_pte_at(mm, address, pvmw.pte, pteval);
>  			}
> -
> -		} else if (pte_unused(pteval) && !userfaultfd_armed(vma)) {
> +		} else if (likely(pte_present(pteval)) && pte_unused(pteval) &&
> +			   !userfaultfd_armed(vma)) {
>  			/*
>  			 * The guest indicated that the page content is of no
>  			 * interest anymore. Simply discard the pte, vmscan
> @@ -2233,6 +2202,11 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
>  			swp_entry_t entry;
>  			pte_t swp_pte;
>  
> +			/*
> +			 * arch_unmap_one() is expected to be a NOP on
> +			 * architectures where we could have PFN swap PTEs,
> +			 * so we'll not check/care.
> +			 */
>  			if (arch_unmap_one(mm, vma, address, pteval) < 0) {
>  				if (folio_test_hugetlb(folio))
>  					set_huge_pte_at(mm, address, pvmw.pte,
> @@ -2243,8 +2217,6 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
>  				page_vma_mapped_walk_done(&pvmw);
>  				break;
>  			}
> -			VM_BUG_ON_PAGE(pte_write(pteval) && folio_test_anon(folio) &&
> -				       !anon_exclusive, subpage);
>  
>  			/* See folio_try_share_anon_rmap_pte(): clear PTE first. */
>  			if (folio_test_hugetlb(folio)) {
> @@ -2269,7 +2241,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
>  			 * pte. do_swap_page() will wait until the migration
>  			 * pte is removed and then restart fault handling.
>  			 */
> -			if (pte_write(pteval))
> +			if (writable)
>  				entry = make_writable_migration_entry(
>  							page_to_pfn(subpage));
>  			else if (anon_exclusive)
> @@ -2278,15 +2250,23 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
>  			else
>  				entry = make_readable_migration_entry(
>  							page_to_pfn(subpage));
> -			if (pte_young(pteval))
> -				entry = make_migration_entry_young(entry);
> -			if (pte_dirty(pteval))
> -				entry = make_migration_entry_dirty(entry);
> -			swp_pte = swp_entry_to_pte(entry);
> -			if (pte_soft_dirty(pteval))
> -				swp_pte = pte_swp_mksoft_dirty(swp_pte);
> -			if (pte_uffd_wp(pteval))
> -				swp_pte = pte_swp_mkuffd_wp(swp_pte);
> +			if (likely(pte_present(pteval))) {
> +				if (pte_young(pteval))
> +					entry = make_migration_entry_young(entry);
> +				if (pte_dirty(pteval))
> +					entry = make_migration_entry_dirty(entry);
> +				swp_pte = swp_entry_to_pte(entry);
> +				if (pte_soft_dirty(pteval))
> +					swp_pte = pte_swp_mksoft_dirty(swp_pte);
> +				if (pte_uffd_wp(pteval))
> +					swp_pte = pte_swp_mkuffd_wp(swp_pte);
> +			} else {
> +				swp_pte = swp_entry_to_pte(entry);
> +				if (pte_swp_soft_dirty(pteval))
> +					swp_pte = pte_swp_mksoft_dirty(swp_pte);
> +				if (pte_swp_uffd_wp(pteval))
> +					swp_pte = pte_swp_mkuffd_wp(swp_pte);
> +			}
>  			if (folio_test_hugetlb(folio))
>  				set_huge_pte_at(mm, address, pvmw.pte, swp_pte,
>  						hsz);
> -- 
> 2.53.0
> 
> 

does not apply :(
