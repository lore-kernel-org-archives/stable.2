Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793260969;
	b=gIF+kCbPy5zPXnABFWGpUYCfdSB+4jlkpNkw2AKJgfqik6YLUGex7QVq8gOqzPPadNlZ
	 xeTntIhw2cu28wpUw3HhdSWMQM4e4MvG/LGxyaVW9dV/w6WML2A/fziioquOUGm1x4VYG
	 tGEq6P4sbPuIMQgAlHLdaLn2FJ1S8vo9ARnbAzIj2NFIGuhRRHvw/0mXL1RrZq0V8kuu7
	 sFJwTwzLUwtYZlaXLH3esoaY8Xyhitm1Hfy9OT1TSX+M5H8bIybS1waKIn35SSsXonZyY
	 BRbUxURF9TKRkP80Hfgsm30IIj41briBLCl+2UFXXFgvkuc8+lWoquonxi/vQE2dChQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793260969;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=k8apCcAMk8pZRsZxsH16Lc+5TIn4jIu/b15pYO6Z0Bs=;
	b=kozNmppJynsFZqDjh5MZ8SaMW1z12kykwK4Sebl6QafOXOdRhg9JpfLQ5KjXYzTmN2KN
	 FFnjBjXyRQUVXcE4LMQDxYLBkwGBZI8GN6YtpqdqeXl5hFMwJFy+jkUA99Wqsk6trHB6M
	 hFPdnj0auKTNXfkxOJgLaijvtrQ41OIoET5U+5tN4hKXa9FIWu3ikRpTq6RBiaNXh+YVD
	 8YKQqO7oVh8l5iVTrkDL3LfoRqwoQ8XvIFuP9HkkGewaXZ0eEvKCq5Zy46uIf3PRpADap
	 ogYtv/IJq/EL7yz+7HZU0cZ0+8AyePJ2uY7QtYJIuoRZDUr6e7EKCPnSR8KxkvXzaBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=iEbujbYC;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E6F606A31A;
	Thu, 29 Oct 2026 08:02:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72E6F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=iEbujbYC
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 30B0F15A1;
	Thu, 29 Oct 2026 01:02:44 -0700 (PDT)
Received: from [10.163.164.4] (unknown [10.163.164.4])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 385A33F7B4;
	Thu, 29 Oct 2026 01:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793260967; bh=ef9Fg1J+efa9K0lYaHXATY0/T5dH7yrFdYQc0z2MAV0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iEbujbYCswZ8RFK2+bOqH9GrXNfdspdEyeLWvgWq16i/7q0yxHJyjSKh5wRDFg8sA
	 90j56I5hjCTLgfRploz8x7UQzuMKPs6udMHmkEokQ81ilxBQr2532zpMPLliV7ataQ
	 ekLC1vjHF7zTz0euRAfdkqhMPZF/1uaGmanjmQX8=
Message-ID: <720a50ae-5828-450f-a7ee-a7107b884225@arm.com>
Date: Thu, 29 Oct 2026 13:32:23 +0530
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
Subject: Re: [PATCH 29/46] mm/mremap: use pudp_huge_get_and_clear() when
 moving huge PUDs
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
 linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, stable@vger.kernel.org
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-29-6f74bec9a5bb@kernel.org>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20261027-fixes_core-v1-29-6f74bec9a5bb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 27/10/26 4:47 am, David Hildenbrand (Arm) wrote:
> move_huge_pud() reads the old PUD and clears it in separate operations.
> Hardware accessed or dirty updates between those operations can be lost
> when the saved entry is installed at the new address.
> 
> The raw pud_clear() also bypasses page_table_check_pud_clear(), while
> set_pud_at() accounts for the destination mapping. This leaves the
> checker counts unbalanced for mappings tracked by page table checking.
> 
> To fix it, simply use pudp_huge_get_and_clear().
> 
> Fixes: 7d846db7d0e2 ("mm/mremap: convert huge PUD move to separate helper")
> Cc: stable@vger.kernel.org
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---

Reviewed-by: Dev Jain <dev.jain@arm.com>


>  mm/mremap.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 0d06d7f37f19a..16e736c72d9cb 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -509,8 +509,7 @@ static bool move_huge_pud(struct pagetable_move_control *pmc,
>  		spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
>  
>  	/* Clear the pud */
> -	pud = *old_pud;
> -	pud_clear(old_pud);
> +	pud = pudp_huge_get_and_clear(mm, pmc->old_addr, old_pud);
>  
>  	VM_BUG_ON(!pud_none(*new_pud));
>  
> 

