Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604324;
	b=3CxRWxTFbsOYxl93OkFqBqjWtJiqRZBTmmZlofq0y0GGhwxBIfsltDZ0k8w/1kkDPZ5n
	 6e8tZoSIRUiCBSO4sa0rFmnLCqqm/tQ+lI4xQ9RoaZV2+qXBNwZN95T/tt5h7cRqVdqVg
	 2DoUYz2XP63ZRqJL+gQCM4d/d63TRdPMmtsuA565lKZrd5jdUE+rQhjWeSoYwDfBG8x1H
	 Ae+Bn+5w8NT33o0AT+3d6Ol1WfgFuSnH8QXvwCdFnGec0rJ5vurmpvkMsitrof7VsiO1M
	 3QHjMTPBe4QWFFt6L2KXf+6VWSmMRdPdC7Op0eViowKqPuNYMw0pEkO6p5MTdAh1LEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604324;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=FpzobxBA97ERHDZ10JHwpxS0fLfapgQK42Ay+O68OEA=;
	b=rkYQzkr/yQtyu0Kk2xNqIvQm9JmWli/Lq7xH8GS6ApLnv1LwKVA1tv4bWToHIIiX9zW4
	 ReQcGvdvmSuFqppkxo/X28JtSSDyySIo4czdziRUep94oZQ7hwwRgIRohqj+jAubqQBEH
	 iTd04mDju2lIr0HTQZB+HKzhgDjTWXj8ZBVFQ26w6OfTAY2/NKi2xGGBcFfR2zptDzvgM
	 vpO873IHZZ5DPrGDKY50EyyjcARHGwGlJ+HFhT2l/em/vNvqwOOjhsp84ewaz9+0jmRk6
	 IX6DaE+c7QxnnmlaosMoMiXtyo/Et4Gt2mHlJqBN+ExIVlJBDdRJEE0VnsG5IK/EU9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=gYzN4YGm;
	arc=none smtp.remote-ip=115.124.30.130
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F152B606A324;
	Mon,  2 Nov 2026 07:25:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F152B606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=gYzN4YGm
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793604317; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=FpzobxBA97ERHDZ10JHwpxS0fLfapgQK42Ay+O68OEA=;
	b=gYzN4YGms8SeNBqvZnLG2kLDm91HkCDUJvS2G17KX8cbyTWIPmtB6qXTs85Pkhvi+N0hO4AQlnhhP3S+gZBkkgBGNTQMwzaJU6X+clrXqPu9smWoC8VMbA5pBh3HTbvpa4rUSlMrCcRQMKHcu5AZAJeUrN35xE9UgEkaOoUWaXc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=66;SR=0;TI=SMTPD_---0XDv5rjy_1793604311;
Received: from 30.74.144.167(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0XDv5rjy_1793604311 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 02 Nov 2026 15:25:13 +0800
Message-ID: <17e9d4c6-6ea4-4c3f-986f-a3775c591da3@linux.alibaba.com>
Date: Mon, 2 Nov 2026 15:25:10 +0800
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
Subject: Re: [PATCH v3 17/47] mm/khugepaged: preserve dirty bits when
 collapsing PTE-mapped THPs
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>,
 Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>,
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>,
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
 Baoquan He <baoquan.he@linux.dev>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Kees Cook <kees@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 Hugh Dickins <hughd@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>,
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>,
 Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin
 <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>,
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
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org,
 Muhammad Usama Anjum <usama.anjum@arm.com>
References: <20261031-fixes_core-v3-0-d6437171ecc3@kernel.org>
 <20261031-fixes_core-v3-17-d6437171ecc3@kernel.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20261031-fixes_core-v3-17-d6437171ecc3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/31/26 5:39 PM, David Hildenbrand (Arm) wrote:
> From: Chris Mason <mason@kernel.org>
> 
> try_collapse_pte_mapped_thp() clears PTEs without transferring their dirty
> bits to the folio. A shmem read fault can map a clean folio writable, so
> a later store only dirties the PTE. Losing that dirty bit allows reclaim
> to discard modified data.
> 
> The assumption that regular files are read-only is also obsolete since
> commit 1b6444331bebb ("mm/khugepaged: enable clean pagecache folio collapse
> for writable files"). In any case, transferring PTE dirty bits to the folio
> when removing mappings (and while the folio is still mapped) is the right
> thing to do.
> 
> Use get_and_clear_ptes() to collect the dirty bits and mark the folio
> dirty before unmapping it. Update the comment.
> 
> This was reproduced with shmem using MADV_COLLAPSE followed by
> MADV_PAGEOUT.
> 
> Fix generated by an LLM and sent by Chris Mason in private.
> 
> Fixes: 27e1f8273113 ("khugepaged: enable collapse pmd for pte-mapped THP")
> Fixes: 1b6444331bebb ("mm/khugepaged: enable clean pagecache folio collapse for writable files")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ david: adjust comment; simplify description; cover file-thp as well ]
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
> Tested-by: Gregory Price (Meta) <gourry@gourry.net>
> Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
