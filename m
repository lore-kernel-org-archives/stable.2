Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793175985;
	b=I4bhuiILejRvF9p6o0olMdSeUVeLplgiSTKmmWjTmoSm1xShr6yt1meJrYQ8Yk9oeYjY
	 BpHIHsj2dpdyl3/7nloG1EzaDJd3RLVUG5DrHShDoARdo91XvEW9CJS1tTJ2i6mfQw1FY
	 JNY2i4nmksrUGjZMXjFlAopWhRZmvOdxBHs62r1NsMji+IwdhleW7iAILG5JljQKCb8MQ
	 HU2mwKGtSDvoIRql1niRjtHG9wzrzHSTXP71KOiw3p17QqxVn2Px9DqpRVnZVXDNutdu2
	 W+69ypwMbifw/6SbiyxU50mIdgfa0yvYMWgM2fVDuOH9sXwYaejnVqjkzS9POYuJmrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793175985;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=ZqxvUOYEnw6epSxNJkOsH/iPXoP3tG6fnt6qx+16CDI=;
	b=xR08YIlINIyx9n6iviYAr0GT0jyVNObbLlClWR1WUs43VQ/dmN5JoOW/Ff4gY0yLRR7/
	 yc7Z6deHY50vpEzbd2jT1wSfZmYi3GOCTHeoXQEJHWIexW5GIV4zx0ZEFUMXfJxU+h98D
	 qusKCNs5DKI66rERqh1ESUlw/cukSNeGdZ/TinR2JTqGK6vUioW9qnhbQdqBF1t3wNk+l
	 rs0a6vDFtj+HFYeyxTk+JqVI8c/Qu6ndlj+3omhG0m3GS+ws43sD2+Wk2/FBM7ltrnc5F
	 9WvItF2zWBNlf2RWvcb+gi4IpBqktue/19K+Ih6lYopAbTvZXPJVnamXHrY0se1M8uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=tK8FPKJ7;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E5E606A31D;
	Wed, 28 Oct 2026 08:26:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80E5E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=tK8FPKJ7
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 70C092ECB;
	Wed, 28 Oct 2026 01:26:19 -0700 (PDT)
Received: from [10.163.164.200] (unknown [10.163.164.200])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7FA7C3F7B4;
	Wed, 28 Oct 2026 01:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793175982; bh=/EbjTDVkdW0F57Y0gRKQi9v+oLhQOt+D3xEeKM70nII=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tK8FPKJ775LMj/HKo8mObMmx6qKh5HiYiCirC0X5N+Uj94ZXLcgBO0gJmsuhWRb4A
	 Le1KG8SJsaJkW/YAWbL9G7bsI6/KPkhwkETh7gUgwJbaEDX8Eg/t78/F2JU1nNSeDl
	 jDJpfCYMNVh0lVMDuVYpKwlU4CCZEtAy7DaSDSSM=
Message-ID: <50f426ea-7477-4fb4-a520-0d7fe4b84c37@arm.com>
Date: Wed, 28 Oct 2026 13:55:59 +0530
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
Subject: Re: [PATCH 14/46] mm/huge_memory: fix zapping migration entries for
 device-private THPs
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
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-14-6f74bec9a5bb@kernel.org>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20261027-fixes_core-v1-14-6f74bec9a5bb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 27/10/26 4:47 am, David Hildenbrand (Arm) wrote:
> From: Chris Mason <mason@kernel.org>
> 
> A PMD migration entry can refer to a device-private folio.
> zap_huge_pmd_folio() checks the folio type instead of the entry type,
> so it treats such a migration entry as a device-private entry.
> 
> Installing the migration entry already removed the reverse mapping and
> dropped the mapping reference. Zapping it must not repeat those
> operations. Concurrent MADV_DONTNEED during migration back to system
> memory can trigger this.
> 
> Check the PMD entry type using pmd_is_device_private_entry().
> 
> Fix generated by an LLM and sent by Chris Mason in private.
> 
> Fixes: 368076f52ebe ("mm/huge_memory: add device-private THP support to PMD operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ david: simplify description ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---

Matches zap_nonpresent_ptes.

Reviewed-by: Dev Jain <dev.jain@arm.com>


>  mm/huge_memory.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index eda020dd6e33f..1b50cc2b35351 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2493,7 +2493,7 @@ static inline void zap_deposited_table(struct mm_struct *mm, pmd_t *pmd)
>  static void zap_huge_pmd_folio(struct mm_struct *mm, struct vm_area_struct *vma,
>  		pmd_t pmdval, struct folio *folio, bool is_present)
>  {
> -	const bool is_device_private = folio_is_device_private(folio);
> +	const bool is_device_private = !is_present && pmd_is_device_private_entry(pmdval);
>  
>  	/* Transfer young+dirty while the folio is still mapped. */
>  	if (is_present && !folio_test_anon(folio)) {
> 

