Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793088408;
	b=d3A9uZVIgzLZy4dFoXnvzi4qIk3whrLAjbkvO2+TiJwuDV7cbO9aglPyk3NYSKhfTDcn
	 91cCEVNnt74TG9vQ7uZIEUToI8vswtOqwbCKOZHlZ/KgWWZp94gKTMtRbDfr4Rv/otEaK
	 7KJ7K0WKkFg+yPD7POKxBq4ahT3WcI1Zg9VZUuWh8iwa9NiBeFW3PD/Jhj37XbHTBaeWz
	 tp17LoLQvtzDBZqEWTWSLjP+qY/ZK6aO+23ZqezLSX+qcs4qqKF23nw/0X0qqrMxr3Au+
	 mUr5C85lTHOHUMd/oZIGGq9djdRuoGQVHHLO92S/EW7/j8RiB1A76Y9967YOfeKR3xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793088408;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=tGP0LjdymEX/O70OpFiXykL3tGWdkhpJkzQJ0xiHk2s=;
	b=Rv1xr7XP7BVLfVGrq1IXLf9U6Pt5INF/u8SgNBsIDXEH/C51cxHph4qbIeReE8iHZdwO
	 E4R/jiaGIKqTv1tCQwBHNJK+xjC5iTwbgqGSnpT/cQSFsS6+23/tocK4bpzS9HrjMI5zb
	 klm0kbHpnSJHNWFPX0h/1Lg7qBuQRekuaPnxcd8vTqu1oir2OiJlg+f3jWRwnqPUKQTt/
	 E4qP62WLWcB8JkLm+JsEgrfU8MPrvRAiUcDi8ridCgu5Cjo+FFt2Trm/grmWXDb2MB6b0
	 sBh9vmAHJtGkyHT86/0OKk2nuZScGbLF1EqeXfRGh4lzYd6+rPy3NGV/WoYo12Zbt+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BoIvLyS4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5006B606A31A;
	Tue, 27 Oct 2026 08:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BoIvLyS4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7669F1F01825;
	Tue, 27 Oct 2026 08:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793088408;
	bh=tGP0LjdymEX/O70OpFiXykL3tGWdkhpJkzQJ0xiHk2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BoIvLyS4BeMWr65hedSikSZ5vE8O9JRgtibUW/piTLatgtmus034g8LURA3R+gHJc
	 ydIDPqS/Oq7d7JsbwgaioD3d1cV8JjOomy7xzfXW42dsVa5rjkstyyKLDXODrEKei/
	 vB2Qwp8dvj5O3AKG6ZMVvpIywISsqf/obj5nk6KOVMT8qLApC1PN0PM0ZrjYBAf2Xu
	 5g6N2XtIXQ3TbybogpP04e5dcBVdBVy+cHCzH1jEUnk9T+8vtYavS1rB+QxhcGQdgH
	 FThLB2pNS03O7e0SOprSN4uGF5bozDM1GQt3OLElmNxQv6g/clWdchbL3nMOAmhEFL
	 j+r5zdUmZqxow==
Date: Tue, 27 Oct 2026 08:06:31 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Kairui Song <kasong@tencent.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Baoquan He <baoquan.he@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Hugh Dickins <hughd@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Minchan Kim <minchan@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Xu Xin <xu.xin@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Youngjun Park <youngjun.park@lge.com>, Gregory Price <gourry@gourry.net>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH 01/46] mm/mglru: don't use stack pointers when walking
 PUD and PMD tables
Message-ID: <auBbKP8UNI9talDL@gremlin>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-1-6f74bec9a5bb@kernel.org>
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
In-Reply-To: <20261027-fixes_core-v1-1-6f74bec9a5bb@kernel.org>

On Tue, Oct 27, 2026 at 12:17:21AM +0100, David Hildenbrand (Arm) wrote:
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
> Fixes: bd74fdaea146 ("mm: multi-gen LRU: support page table walks")
> Cc: stable@vger.kernel.org
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> [ david: handle walk_pud_range() as well, clarify+simplify description,
>          adjust Fixes: ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---

God, terrible. And why does MGLRU feel it needs its own independent page
walking mechanism?... the whole thing feels like NIH syndrome writ large.

Anyway, rant aside:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

>  mm/vmscan.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
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

--
Cheers, Lorenzo
