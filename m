Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793439833;
	b=1LaGqzFcIZJybdQdXMP448ObCLAVK4x0/vSDDgK3JWN6dASYTAt35iGAIkDyNEAPfNJl
	 ECJUUZqrFgBBZT4NWbQnaRx3Lj7us3o0lkWp8mg/9e0Yr798IU0YxBReVYcfYvTYuaLwP
	 6JneFgtr21fHFMNdLLJKBBtTs5vB2cAKiOcloazdIQ/EPsWfDBRovk9CdLMSLFPmfQRaV
	 R4Tdrw7sOTL7bo3ofYCcUOnvK+NcYcRqkb3MCAVKRlkFSz5qTRHsv3rn7GcaKnk1jCFPy
	 heeQIAnGixoHcF+vgjUhPu9+KAJhqA3OrI21u1grMDAS+w5qSKfajeFKQAuEm4smPbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793439833;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=2OTaWQfXrVSggRAzexmllu+qraQW9cW0GF8zz7uZPRg=;
	b=LF21dh97Cs6wO0Y6qHse/4MGvPSdp5Tcq3FuWgnLMrq9XDBayqzqx+HO7WGuJtP4IUCq
	 U0sZDneATG1IxtrBgpjYmvazFvcHqyqtD55hLtlwhjSxC6L6AUM/t7ie0eWwCYWahgg9M
	 ehuZJ1Q2vq48OsIJbGS+5GgDxniw3Tlz3VWqLQ/ueUsi2+Lls0Is2c3Dp3cN4FEL/DnKP
	 NvJPUuarDrWjfPNoezpMGGw42j4gbabINc0FCChQ3CkaM7NwsI4vFf3T2SrnEgP2zRFZL
	 TwabwKyxcbPbVafU4cg6BZUv2Cys6qX7uWbqXFQzHuL+WQrAjF63dgmU6BXNcn3KyQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="KH4pI/do";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9504E606A320;
	Sat, 31 Oct 2026 09:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KH4pI/do
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E9571F000C1;
	Sat, 31 Oct 2026 09:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793439833;
	bh=2OTaWQfXrVSggRAzexmllu+qraQW9cW0GF8zz7uZPRg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KH4pI/doX3eDNZKP9hjfWDVBcMZhAxnMdgNnK8jB2wBHIOt4GUGM9QVUdga+4djCH
	 SFc3dVznI/InHvYr4kCKZLFFjjUrQbsxFdHYXO+EO8goAT+j8khfjWIlatlZxrGm0W
	 IFI0MElx2Iiquzr2GTcq4gWKVPHDWHXTZSWS6hSmKUsarRBLQhUnL0dypB/1HD0T2R
	 Dt3w/2XGVRPeOtZzVMVbMUJfmBsyJanHjWlRjcuBmP8T5R4e9rewjzLRNEoVGEeEml
	 tFIv5hVbeCSQYTjYNfa8efr44JBygWonSKu+nx5LWhhrtfkLmE8DkLZUerOI0jNTOR
	 yy8nZjGtdXSTQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sat, 31 Oct 2026 10:39:43 +0100
Subject: [PATCH v3 14/47] mm/huge_memory: fix zapping migration entries for
 device-private THPs
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
Message-Id: <20261031-fixes_core-v3-14-d6437171ecc3@kernel.org>
References: <20261031-fixes_core-v3-0-d6437171ecc3@kernel.org>
In-Reply-To: <20261031-fixes_core-v3-0-d6437171ecc3@kernel.org>
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
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1574; i=david@kernel.org;
 h=from:subject:message-id; bh=1U0L7v2f26iQXcRLRvM3iifHsSlAqIVV1y+RDTNyPAI=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLKebk/TCtvK7fRx+r1Lk869iYg97/LLXlvo8a2Y4sx0S
 5a825MjO0pZGMQ4GGTFFFmCgu8bvHy5rrbajY8ZZg4rE8gQBi5OAZjIyreMDLOet6xhTDvEoTVt
 dTzzieu10YJv+HUSgjpE024I+4QdqGRk+PzkTOLuUx5a+9x+MCTvNtjC8fIE5+I1d266vGOviHk
 3nxMA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

From: Chris Mason <mason@kernel.org>

A PMD migration entry can refer to a device-private folio.
zap_huge_pmd_folio() checks the folio type instead of the entry type,
so it treats such a migration entry as a device-private entry.

Installing the migration entry already removed the reverse mapping and
dropped the mapping reference. Zapping it must not repeat those
operations. Concurrent MADV_DONTNEED during migration back to system
memory can trigger this.

Check the PMD entry type using pmd_is_device_private_entry().

Fix generated by an LLM and sent by Chris Mason in private.

Fixes: 368076f52ebe ("mm/huge_memory: add device-private THP support to PMD operations")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
[ david: simplify description ]
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/huge_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 1d65c4f576f9c..0c6512b33db0e 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2493,7 +2493,7 @@ static inline void zap_deposited_table(struct mm_struct *mm, pmd_t *pmd)
 static void zap_huge_pmd_folio(struct mm_struct *mm, struct vm_area_struct *vma,
 		pmd_t pmdval, struct folio *folio, bool is_present)
 {
-	const bool is_device_private = folio_is_device_private(folio);
+	const bool is_device_private = pmd_is_device_private_entry(pmdval);
 
 	if (folio_test_anon(folio)) {
 		add_mm_counter(mm, MM_ANONPAGES, -HPAGE_PMD_NR);

-- 
2.43.0

