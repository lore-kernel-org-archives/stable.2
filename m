Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.141
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793503081;
	b=C05Fyy+UXkoP2JAHzNCARxlLPCYIaneCwaGlxE00pMtiOwHNxctDh8j9czUl1edVNIzZ
	 Q0JVdtgph8fIQzjCezASl4CU6RTp0flTOLBfPzxh/CWpB8anghv5vAXjdFgf4wyNaG8g0
	 ihydvPS9ppZsrAjx+Zibgu98XUYfLzokBqE4uXkZJk35qMRrbEC6xxqMKh6fzmVhZAu3w
	 24QJ62I+KiHVRNQWDWOu5TaWTVg9H0lo4J0o5Eeif9MRKc5mOlSr1nzkNns9qc/4jnpSw
	 fMyWq3Cph5NogLxJgTS69Ai6+ToHRjWtfggQrD7kv5G6E8jiKsjlOYem1dpudDxKFyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793503081;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Z6x5MIctxHa9/j/zlx7zweNCYHHtp8racH88QViVO7E=;
	b=EjrZpp3eFuBUcXz7JlgeVrjipCVMM9mF/5nGO2hmUORJy8PN3sZmEJl2UcdwZgO9D9A3
	 UkHeBfVMOCPhnwf08tLQs/MUHyGRmmRMP8LjYRKtd4oEzmrMoFmMQCmAO2YmoJTUC3yNx
	 Fj7/MZeJ5rdtKfYgszDtks1+uTuY90uPMayvSsKf85JHA9PNrP9eqUix5FISWeYAxUu3t
	 KX2HCfvxuy1rB/haucqqT1Wm/6j1vfDsZklvd6PkgHgQ/HyWRt3CgU5h2pVkMtl/vSeTa
	 9JfSqVrdI6C+3cifF6psnSDavvshg3mGJDKBOKbtVoFRzKSSkYz9E1N6uYjRcozuFLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="p/Q4ETTt";
	arc=none smtp.remote-ip=95.215.58.141
Received: from mta1.migadu.com (out-141.mta1.migadu.com [95.215.58.141])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FDB606A329
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 03:18:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41FDB606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=p/Q4ETTt
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=VqvV8qpM4mS5SY0ZFKzHPcZcEDmnWQFJ4Ho78vSEfFk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793503078; v=1; x=1794107878;
 b=p/Q4ETTtIC16vjBAdv8+ISuTf0FXF9cgntxqj25Zl5aIfG1jL2F0WbNloasy9A7EoIVpIFOr
 OxNrtrDS+/8yGvz1wt4ceJoaCmPzh5TpOQQ1e5tJ/a9TBWUPDyrRr4BKmkx4z9zaG7vrKKwqfCV
 BxONu9cspI2Vmlgf0XZ8Mkzo=
X-Envelope-To: stable@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 83615b79e9b3fb35;
	Sun, 01 Nov 2026 03:17:57 +0000
X-Mizu-Trace-ID: 83615b79e9b3fb35
X-Migadu-Flow: FLOW_OUT
Date: Sun, 1 Nov 2026 11:17:50 +0800
From: Baoquan He <baoquan.he@linux.dev>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>,
	Barry Song <baohua@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>,
	Lance Yang <lance.yang@linux.dev>, Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry@kernel.org>, Alistair Popple <apopple@nvidia.com>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>,
	Minchan Kim <minchan@kernel.org>,
	Muchun Song <muchun.song@linux.dev>, Xu Xin <xu.xin@linux.dev>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Chris Li <chrisl@kernel.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Youngjun Park <youngjun.park@lge.com>,
	Gregory Price <gourry@gourry.net>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-cxl@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
	stable@vger.kernel.org, Muhammad Usama Anjum <usama.anjum@arm.com>,
	SJ Park <sj@kernel.org>
Subject: Re: [PATCH v3 01/47] mm/mglru: don't use stack pointers when walking
 PUD and PMD tables
Message-ID: <auavXi5A57dM-_Nf@bogon>
References: <20261031-fixes_core-v3-0-d6437171ecc3@kernel.org>
 <20261031-fixes_core-v3-1-d6437171ecc3@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261031-fixes_core-v3-1-d6437171ecc3@kernel.org>

On 10/31/26 at 10:39am, David Hildenbrand (Arm) wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> MGLRU passes stack copies of page-table entries in walk_pud_range() and
> walk_pmd_range() when walking to the next level. These copies can become
> stale when khugepaged or MADV_DONTNEED (CONFIG_PT_RECLAIM) removes a PTE
> table concurrently.
> 
> This pattern dates back to commit bd74fdaea146 ("mm: multi-gen LRU:
> support page table walks"). Likely, earlier locking masked the latent
> bug. Later changes exposed it: commit 1d65b771bc08 ("mm/khugepaged:
> retract_page_tables() without mmap or vma lock") allowed concurrent
> retraction, and commit cf4a65539c13 ("memcg-v1: no need for memcg locking
> for MGLRU") dropped the walker's outer RCU protection.
> 
> The fix is simple, so just fix the original commit so we don't have to
> speculate. To fix it, pass the actual PMD/PUD pointers. This restores the
> RCU-protected lookup and validation against the live PMD. Note that the PUD
> handling is required as well to handle folded page tables correctly in all
> cases.
> 
> Fix generated by an LLM and sent by Josef Bacik in private.
> 
> [ david: handle walk_pud_range() as well, clarify+simplify description,
>          adjust Fixes: ]
> 
> Fixes: bd74fdaea146 ("mm: multi-gen LRU: support page table walks")
> Cc: stable@vger.kernel.org
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Reviewed-by: Rik van Riel <riel@surriel.com>
> Reviewed-by: Qi Zheng <qi.zheng@linux.dev>
> Reviewed-by: Dev Jain <dev.jain@arm.com>
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Reviewed-by: Kairui Song <kasong@tencent.com>
> Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
> Reviewed-by: Harry Yoo (Meta) <harry@kernel.org>
> Reviewed-by: Barry Song <baohua@kernel.org>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Reviewed-by: SJ Park <sj@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  mm/vmscan.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

LGTM,

Reviewed-by: Baoquan He <baoquan.he@linux.dev>

> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 9959ca158ce83..6a1af9b92349f 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -3911,7 +3911,7 @@ static void walk_pmd_range(pud_t *pud, unsigned long start, unsigned long end,
>  
>  		walk->mm_stats[MM_NONLEAF_FOUND]++;
>  
> -		if (!walk_pte_range(&val, addr, next, args))
> +		if (!walk_pte_range(pmd + i, addr, next, args))
>  			continue;
>  
>  		walk->mm_stats[MM_NONLEAF_ADDED]++;
> @@ -3947,7 +3947,7 @@ static int walk_pud_range(p4d_t *p4d, unsigned long start, unsigned long end,
>  		if (!pud_present(val) || WARN_ON_ONCE(pud_leaf(val)))
>  			continue;
>  
> -		walk_pmd_range(&val, addr, next, args);
> +		walk_pmd_range(pud + i, addr, next, args);
>  
>  		if (need_resched() || walk->batched >= MAX_LRU_BATCH) {
>  			end = (addr | ~PUD_MASK) + 1;
> 
> -- 
> 2.43.0
> 
