Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793306409;
	b=vwWVZRXq4h8UvAY2DXm+x6woFrAfvEW8l3Dj54JpfKe111lwlI+tGpEL+S6OyVplyxNQ
	 y8gzcu/x3l/QAe7WtSnuOFtuUFylYtHk5QJcS+bB4+VkFBnxGlBDM2OVR7HCf+PaEimYt
	 EgmkL+FBnvMwR5WYO4Yu/R/wMruQb0MN1MeQ4mbaLypS4NpL4YPa14R1EN75TMLM+ZvMO
	 0L7YVNEja+oylTpq9QP5UL3FAbO8qAjMsLQ1Zzve/fbxKtQsIVbBvDxWRmGyXrHnGe1+M
	 NpvIuYEk/0qgNqYWptF8w7g6RfDsQclAk8fRpCCVVtokJt0iHtjbI21e1POAdjKNEYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793306409;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=FUMlocCCR3FNPkXe9l59Im2VqUBDzK2bwkLLReRcpPc=;
	b=htYOaE9sfopb+Krf1WYBeXQZcvxtP+5U55A6UKZqIjKRi8WjdocGgIcsqnq083uDefrF
	 t35swoAXUt+/LMlM74Bstrcd9oODJza0SeI4LO+xt15vfeLOEjSmWh0FZxcMqRfh/Mq+V
	 3/X7wZ6/fd2TYz7SY5VTASQyvM2x5NscAXXId7pbVqBq+6KvUky980VYMwhYkJK3m8IjL
	 mxO4/15ujbfWNuHgjNvxSSO4Wk2EZ6xdWYAcqn/tXQGLKb3ymCq7zPz8y0B702T+H/yRh
	 woHSS3l3sjBZ3YyTtSe7CyqZqmWvm6KQSN1DfXUbeb7lohvzozQnYGpmAg9S9tYGKEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iUNGuoc0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391FA606A31C;
	Thu, 29 Oct 2026 20:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iUNGuoc0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C01EC1F01825;
	Thu, 29 Oct 2026 20:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793306409;
	bh=FUMlocCCR3FNPkXe9l59Im2VqUBDzK2bwkLLReRcpPc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=iUNGuoc0WeakiHgmDXnhuPlSghajcP6iyTr2aD2FuFZ51pYroFUry3bk8JUaMuEA3
	 XXcNDCVFvoALkSqrqd4c4ihHA2LGsPX/upOgvPJuWvhrp+8/2zaa0PLUJuKsN/8plW
	 9iGLRa5wuxHYdpBgli4Hpi+HHP6EIxJmTlApX431kJFtoeZ0B1B1M0Zp4gzk9TElJz
	 VP0ojaFjbHD+kB+2kggTzsPRUHMqSoFzPO0brdXePjOTplmQj3LV3C4wd16dRHjz6d
	 LfhgkMqYVhJp4fw1eMSl1gAQOa6lfEyik4W4IucHpl8YgrOAayJWXboJOwGq83GAdS
	 y6H9j/Ymf33KA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 29 Oct 2026 21:33:22 +0100
Subject: [PATCH v2 27/47] mm/mmu_gather: fix flushing ranges with 4 GiB or
 larger
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-fixes_core-v2-27-a64ce7f83abb@kernel.org>
References: <20261029-fixes_core-v2-0-a64ce7f83abb@kernel.org>
In-Reply-To: <20261029-fixes_core-v2-0-a64ce7f83abb@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
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
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, 
 Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
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
 Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2091; i=david@kernel.org;
 h=from:subject:message-id; bh=QH73tRoFq91DTzVscInadBQ8PK5Px8G2ighCsSz8YrU=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIer23f+WLDDxbu6impZza76Sw7pvh0S2eDTcz8nSb2D
 zL3qncc6ChlYRDjYJAVU2QJCr5v8PLlutpqNz5mmDmsTCBDGLg4BWAizaYM/905uFk2VqfFhrmz
 XVlbZVP9L0C+ZDrvTsdXQa7Hvk8vSmL4p10dqrF9woXJN66x3TSeKXedRyrsAptEvgMXa+HZI8n
 PuAE=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

From: Josef Bacik <josef@toxicpanda.com>

__tlb_adjust_range() takes the size of the range which has to be flushed
as an unsigned int. Its callers, tlb_flush_{pte,pmd,pud,p4d}_range(), get
and pass an unsigned long. Consequently, a range that is 4 GiB or larger
gets truncated, possibly to 0.

On arm64 with hugetlb, a 64k kernel can have 16 GiB hugetlb folios
mapped contiguously at the PMD level and flush them when unmapping, and a
16k kernel can flush 64 GiB PUDs through tlb_unshare_pmd_ptdesc(). So
at least these two scenarios are affected.

Fix it by flushing the proper range instead of the truncated one by
properly using "unsigned long" for range_size.

Fix generated by an LLM and sent by Josef Bacik in private.

Fixes: b528e4b6405b ("mm/hugetlb: add tlb_remove_hugetlb_entry for handling hugetlb pages")
Fixes: 8ce720d5bd91 ("mm/hugetlb: fix excessive IPI broadcasts when unsharing PMD tables using mmu_gather")
Cc: stable@vger.kernel.org
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
[ david: use two-tab indent, simplify description ]
Reviewed-by: Qi Zheng <qi.zheng@linux.dev>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Dev Jain <dev.jain@arm.com>
Reviewed-by: Muchun Song <muchun.song@linux.dev>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 include/asm-generic/tlb.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index fbe1114e9a44..3f4a180b48f3 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -350,8 +350,7 @@ struct mmu_gather {
 void tlb_flush_mmu(struct mmu_gather *tlb);
 
 static inline void __tlb_adjust_range(struct mmu_gather *tlb,
-				      unsigned long address,
-				      unsigned int range_size)
+		unsigned long address, unsigned long range_size)
 {
 	tlb->start = min(tlb->start, address);
 	tlb->end = max(tlb->end, address + range_size);

-- 
2.43.0

