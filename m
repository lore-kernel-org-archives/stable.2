Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793306247;
	b=PqJi8E60H1iHWpyhFINYuP0iX+2Vvm8WTsi5gGn8RsvNXKS0JShYQZmwQA62dxgsfzey
	 8Pf3K8tx1mcgOzofKX80+PU9C01ltLDDvHwvu3ZC3ECeGUVJnCjrYvJbxYkGU2gasZwue
	 5QzWeobhISqgk85VstAov9KsH83jtXVhapscAJM3PXE3BJiTukh+MEScewFGZM2jf1iJK
	 GQx2MvUHDmHedZw+cRRgyLE16C2BlBYwRh4goP2fNgDUWkaRmyAh1OMMQ2iqn4jvO1DW7
	 ZHfuWKb++hMjTMRMBK2d23tDRIYLwKlYNui+nm+0U8WD373OXE1oPB6191TOc9W5qFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793306247;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=234gD00LbP/Qk5j9zzqqy4STm6BqPfRIm1wBmbH9iNI=;
	b=uuPU5O+czXfWougKNzaU+nWtHkTG9UO1T4ftQqjL5X7/QVUtj1tNOZASQyavOWB/Tdrh
	 yIa9YMevGvQ3mDeo01I6kD5UHELyHh1FMbN9IaD/6TVjKmD568bZgTxK4ZuSHUBEcMdWy
	 LsrKlotjwUEnxC/+Xq6K/rHBvg2KnDjsVjJjKxBcsEG+IUdIZe1Pa+PUvkOXH3TeOP3QC
	 r4s62C7qLjJgr6oJ8fdxSPm1TyTmAsIzAyIGve1qhzR8smTRBbUwDmeQq4yeHGPW+/0iN
	 pSWbcSOReoJ11DKJbJSFznKQk51xciww6/ViP9e6f3sPstfO/kIV/uNgMpRSX0ylP3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=edeLt9zS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CADC606A322;
	Thu, 29 Oct 2026 20:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=edeLt9zS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75EB11F01816;
	Thu, 29 Oct 2026 20:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793306246;
	bh=234gD00LbP/Qk5j9zzqqy4STm6BqPfRIm1wBmbH9iNI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=edeLt9zS7/wt/9hnNB2ETmthM71RS43pg/tv3+Z3wip3JVZEmnW2zTc7BWQycloNy
	 eiIxLdX2AHK+EIcGUho5VTaK6l3mGn1X0zTJHt1HL5v9rCLaz+t973Eeuf6OOZpwZq
	 tzpjQ6ahggUdoqQsqXxoW/WHIIkOV547zpUK6vVcyeinMHiK9ttzsEiW87eUaXbGYB
	 nnyFsqJECi9wQRjroEq+7Q5o/UeBBVUs5gLJ9jm2YeNOiFcd8EkUI59EM8WsoTFPNk
	 7toOVO78y+mRJVbYNeCeT6CcidBYrIzM+V4Q0SmKtYGNSa+6jYaaKFXHRob2/z8Y/b
	 AxJkCxCEB1CXw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 29 Oct 2026 21:33:11 +0100
Subject: [PATCH v2 16/47] mm/khugepaged: fix PMD table lock leak in
 try_collapse_pte_mapped_thp()
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
Message-Id: <20261029-fixes_core-v2-16-a64ce7f83abb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2386; i=david@kernel.org;
 h=from:subject:message-id; bh=+GceeJLIEkYM45yBBgdZk6QP/zPFquzOdoh39+pg3EQ=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIer23bNeP0wWvJS/X6pHY8L0u7YrDU4cqVVPcHeybd3
 /DS7Vcsd0cpC4MYB4OsmCJLUPB9g5cv19VWu/Exw8xhZQIZwsDFKQATuV/CyHAx7CXX1+3Hj39y
 +TlL3JavOKg2cNKBuSrRv73q1jxe/4yf4a/Uz9D1Sdue6uUISi9b0CaQFe5uEnz6z6rLxwJNO+Y
 3svEDAA==
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

From: Josef Bacik <josef@toxicpanda.com>

For a private mapping with userfaultfd, try_collapse_pte_mapped_thp()
takes the PMD table lock before it maps the page table for the second time.
If that (pte_offset_map_rw_nolock) fails, because the page table vanished
in the meantime due to concurrent page table reclaim, it leaves through
the abort label, where the PMD table lock is unlocked if it differs from
PTE table lock.

In case the PMD table lock and the PTE table lock match, which is the
case without CONFIG_SPLIT_PTE_PTLOCKS after pte_offset_map_rw_nolock()
failed, we miss to unlock the PMD table.

To fix it, forget the PTE table lock when we unmap+unlock the PTE table.

Fix generated by an LLM and sent by Josef Bacik in private.

Fixes: 6375e95f381e ("mm: pgtable: reclaim empty PTE page in madvise(MADV_DONTNEED)")
Cc: stable@vger.kernel.org
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
[ david: move the ptl = NULL handling; rewrite description, drop wrong comments ]
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/khugepaged.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index f53c50507c83..04d9bb21ff52 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1904,7 +1904,7 @@ static enum scan_result try_collapse_pte_mapped_thp(struct mm_struct *mm, unsign
 
 	result = SCAN_FAIL;
 	start_pte = pte_offset_map_lock(mm, pmd, haddr, &ptl);
-	if (!start_pte)		/* mmap_lock + page lock should prevent this */
+	if (!start_pte)
 		goto drop_folio;
 
 	/* step 1: check all mapped PTEs are to the right huge page */
@@ -1935,6 +1935,7 @@ static enum scan_result try_collapse_pte_mapped_thp(struct mm_struct *mm, unsign
 	}
 
 	pte_unmap_unlock(start_pte, ptl);
+	ptl = NULL;
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm,
 				haddr, haddr + HPAGE_PMD_SIZE);
 	mmu_notifier_invalidate_range_start(&range);
@@ -1952,7 +1953,7 @@ static enum scan_result try_collapse_pte_mapped_thp(struct mm_struct *mm, unsign
 		pml = pmd_lock(mm, pmd);
 
 	start_pte = pte_offset_map_rw_nolock(mm, pmd, haddr, &pgt_pmd, &ptl);
-	if (!start_pte)		/* mmap_lock + page lock should prevent this */
+	if (!start_pte)
 		goto abort;
 	if (!pml)
 		spin_lock(ptl);

-- 
2.43.0

