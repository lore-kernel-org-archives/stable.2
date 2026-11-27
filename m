Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795748259;
	b=xPsB8A+e9XiPLbW2FT8bo+GQKhXLAvSOjEWYSOQj2A/eiy/XeJB1HkNOg8jDS4YRe6NB
	 OTvSIgm6e1XHvTwEoceYYSa5aGyz2eACgFo97s+dc4cVPLzRNQE/4h05Zhy9Zx0P7Pyos
	 sUMFjhXkKOsx1kNOaah1C9fVE92pH9S3Kioa6s0NPVlVcDfUp/q2QBsTFzQ084+DCHrZA
	 phZ0efPD6FYHxx5FG8u3F6i6TSSrjLzrq+uMFVb2IXRRJIpK4qSq2QNtCnfUnWw14y3GM
	 +pDV8NAoxD4dheNyfZr3mpz4Mkk0PNJfcJESYMweDKhkBd4sexM9Pm/RdXM2jvHWvjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795748259;
	h=DMARC-Filter:X-UUID:X-CTIC-Tags:X-CID-P-RULE:X-CID-O-INFO:X-CID-INFO:
	 X-CID-META:X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=tg4qRfSFSCuwByGCIKkrRpncxEd/8U5VOu1pZIeOQpE=;
	b=F+BRb9JhdOM0c2EfjaXw8xY5L/27W7jwpl8wgsaBP5E02sue5jZFsaIjnFNQRikTtZ6r
	 ekyKOXKRKbuA2V81TyKkBU8zsRzFsIGbZnqWb9XElKSKsy7TRROFQbay1S8yfsxcdJALi
	 r3CBtRWjLf0vSB7+x9jhqvuwSXiZxERfj+VV5pE6cM1NsAVAdj/v2Pd/iwltV0nIskhgS
	 ADcd8X4N3bJBdfXZ3owu3nwdj+/nbe2p5yOT17G72bYzjnrrekJHijNo0kIc2I0KAp2n6
	 EDy/FhMXAI39nr8H2E/Mtt/p+5EmKCfQxABRsbbwbK4Xbr0k0XfscyCTlZp+7a2WkdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36BE606A31C;
	Fri, 27 Nov 2026 02:57:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F36BE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 465e87ceea0e11f19a56ed5b684f684d-20261127
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_TXT, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_MAILER_MTBG, HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER
	HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS
	HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NAME, IP_UNTRUSTED, SRC_UNTRUSTED
	IP_UNFAMILIAR, SRC_UNFAMILIAR, SA_TRUSTED, SA_EXISTED, SN_TRUSTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:fe400225-ab86-4ed8-86fc-c3217e05a7cc,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.19,REQID:fe400225-ab86-4ed8-86fc-c3217e05a7cc,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:7db8b62,CLOUDID:afe9f5a28457039939e8bb79c194937f,BulkI
	D:261127105729JSGRYN6M,BulkQuantity:0,SF:10|38|64|66|78|80|81|82|83|102|12
	7|153|841|865|898,TC:nil,Content:0|15|52|99,EDM:-3,IP:-2,URL:0,File:nil,RT
	:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP
	:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 465e87ceea0e11f19a56ed5b684f684d-20261127
X-User: lihongfu@kylinos.cn
Received: from [192.168.43.7] [(114.246.238.190)] by mailgw.kylinos.cn
	(envelope-from <lihongfu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 2003433835; Fri, 27 Nov 2026 10:57:25 +0800
Message-ID: <411be3f3-4b35-4bd2-bacc-af5596aa98b3@kylinos.cn>
Date: Fri, 27 Nov 2026 10:57:20 +0800
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
Subject: Re: [PATCH 05/21] mm/hugetlb: free surplus folios of other nodes on
 free
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jinmeng Zhou <jinmengzhou22@gmail.com>, Hongfu Li <lihongfu@kylinos.cn>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Mike Kravetz <mike.kravetz@oracle.com>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>, Hugh Dickins <hughd@google.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Dave Airlie
 <airlied@redhat.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Mike Rapoport <rppt@kernel.org>,
 Mel Gorman <mel@csn.ul.ie>, Dave McCracken <dave.mccracken@oracle.com>,
 Andy Whitcroft <apw@shadowen.org>, Adam Litke <agl@us.ibm.com>,
 Lorenzo Stoakes <ljs@kernel.org>, Rik van Riel <riel@surriel.com>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>,
 Lance Yang <lance.yang@linux.dev>, James Houghton <jthoughton@google.com>,
 Yang Shi <shy828301@gmail.com>, Suren Baghdasaryan <surenb@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Pedro Falcato <pfalcato@suse.de>,
 Gregory Price <gourry@gourry.net>, Zi Yan <ziy@nvidia.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Matthew Brost <matthew.brost@intel.com>, Byungchul Park <byungchul@sk.com>,
 Alistair Popple <apopple@nvidia.com>, Wanpeng Li
 <liwanp@linux.vnet.ibm.com>, Andi Kleen <ak@linux.intel.com>,
 Kenneth W Chen <kenneth.w.chen@intel.com>, Hugh Dickins <hugh@veritas.com>,
 Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>,
 Joern Engel <joern@logfs.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Michal Hocko <mhocko@suse.cz>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
 "Kirill A. Shutemov" <kirill@shutemov.name>,
 Sasha Levin <sasha.levin@oracle.com>, Guillaume Morin
 <guillaume@morinfr.org>, Wanpeng Li <liwp.linux@gmail.com>
Cc: linux-mm@kvack.org, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@osdl.org>, linux-doc@vger.kernel.org,
 stable@vger.kernel.org, Chris Mason <mason@kernel.org>,
 Hongfu Li <hongfu.li@linux.dev>
References: <20261125-hugetlb_fixes_2-v1-0-db27fd2f71a8@kernel.org>
 <20261125-hugetlb_fixes_2-v1-5-db27fd2f71a8@kernel.org>
From: Hongfu Li <lihongfu@kylinos.cn>
In-Reply-To: <20261125-hugetlb_fixes_2-v1-5-db27fd2f71a8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 11/26/26 06:33, David Hildenbrand (Arm) 写道:
> Surplus hugetlb folios are accounted per node, but reservations are
> global. When free_huge_folio() frees a hugetlb folio whose node doesn't
> have any surplus folios, we currently keep it as a free hugetlb folio.
>
> However, we might then have surplus folios on other nodes that are no
> longer required for the global reservations.
>
> This can be reproduced with two NUMA nodes, nr_hugepages=1 on node 0 and
> nr_overcommit_hugepages=1:
>
>   (1) Allocate the single hugetlb folio on node 0 from the pool.
>   (2) With MPOL_BIND to node 1, mmap(MAP_SHARED) a hugetlb memfd that
>       needs a single folio. This will reserve + allocate a surplus folio
>       on node 1.
>   (3) Free the folio from (1).
>   (4) With MPOL_BIND to node 0, fault in the folio of the memfd, which
>       consumes the reservation and allocates node 0's free folio, and
>       immediately punch a hole, freeing the folio without restoring the
>       reservation. Node 0 has no surplus folios, so the folio is kept.
>
> The pool ends up with a free surplus folio on node 1 that nobody
> reserved:
>
>    HugePages_Total:       2
>    HugePages_Free:        2
>    HugePages_Rsvd:        0
>    HugePages_Surp:        1
>
> Let's fix it by freeing a surplus folio of another node when
> free_huge_folio() keeps a folio whose node has no surplus folios, using
> the same rule as for the folio's own node: the free folios cover all
> reservations without it.
>
> With this fix, the surplus folio is already freed in (3), as the two
> free folios then exceed the single reservation, and we correctly end up
> with a single free folio on node 0 and no surplus folios.
>
> Note that the freed surplus folio might have been required by a task
> that was bound to that node. But we don't care about that: reservations
> are inherently not NUMA aware, and anybody who needs guarantees on
> specific nodes has to preallocate, like QEMU does, for example.
>
> This has low urgency.
>
> Fixes: 7893d1d505d5 ("hugetlb: Try to grow hugetlb pool for MAP_PRIVATE mappings")
> Cc: <stable@vger.kernel.org>
> Reported-by: Chris Mason <mason@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Tested-by: Hongfu Li <lihongfu@kylinos.cn>
Reviewed-by: Hongfu Li <lihongfu@kylinos.cn>

> ---
>   mm/hugetlb.c | 31 +++++++++++++++++++++++++------
>   1 file changed, 25 insertions(+), 6 deletions(-)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index c67f9bc3fa3bc..0f3db932266d7 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -142,6 +142,8 @@ static void hugetlb_unmap_range(struct mmu_gather *tlb,
>   				unsigned long end, struct folio *folio,
>   				zap_flags_t zap_flags);
>   static struct resv_map *vma_resv_map(struct vm_area_struct *vma);
> +static struct folio *remove_pool_hugetlb_folio(struct hstate *h,
> +		nodemask_t *nodes_allowed, bool acct_surplus);
>   
>   static inline bool subpool_is_free(struct hugepage_subpool *spool)
>   {
> @@ -1760,6 +1762,7 @@ void free_huge_folio(struct folio *folio)
>   	struct hstate *h = folio_hstate(folio);
>   	int nid = folio_nid(folio);
>   	struct hugepage_subpool *spool = hugetlb_folio_subpool(folio);
> +	struct folio *surplus_folio = NULL;
>   	bool restore_reserve;
>   	unsigned long flags;
>   
> @@ -1808,19 +1811,35 @@ void free_huge_folio(struct folio *folio)
>   		folio_clear_hugetlb_temporary(folio);
>   		spin_unlock_irqrestore(&hugetlb_lock, flags);
>   		update_and_free_hugetlb_folio(h, folio, true);
> +		return;
>   	} else if (h->surplus_huge_pages_node[nid] &&
>   		   h->free_huge_pages >= h->resv_huge_pages) {
>   		/* Free this surplus folio that is not required globally. */
>   		remove_hugetlb_folio(h, folio, true);
>   		spin_unlock_irqrestore(&hugetlb_lock, flags);
>   		update_and_free_hugetlb_folio(h, folio, true);
> -	} else {
> -		mod_node_page_state(folio_pgdat(folio), NR_HUGETLB,
> -				    -(long)pages_per_huge_page(h));
> -		arch_clear_hugetlb_flags(folio);
> -		enqueue_hugetlb_folio(h, folio);
> -		spin_unlock_irqrestore(&hugetlb_lock, flags);
> +		return;
>   	}
> +
> +	mod_node_page_state(folio_pgdat(folio), NR_HUGETLB,
> +			    -(long)pages_per_huge_page(h));
> +	arch_clear_hugetlb_flags(folio);
> +	enqueue_hugetlb_folio(h, folio);
> +
> +	/*
> +	 * This is not a surplus folio on this node, but we might have surplus
> +	 * folios on other nodes that are no longer required, as reservations
> +	 * are global and surplus folios are per node. So free another folio
> +	 * instead.
> +	 */
> +	if (h->surplus_huge_pages &&
> +	    h->free_huge_pages > h->resv_huge_pages)
> +		surplus_folio = remove_pool_hugetlb_folio(h, &node_states[N_MEMORY],
> +							  /* acct_surplus= */ true);
> +	spin_unlock_irqrestore(&hugetlb_lock, flags);
> +	/* We might be in atomic context, but freeing might need vmemmap pages. */
> +	if (surplus_folio)
> +		update_and_free_hugetlb_folio(h, surplus_folio, true);
>   }
>   
>   /*
>
-- 
Best regards,
Hongfu

