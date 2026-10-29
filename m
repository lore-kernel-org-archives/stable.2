Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793306615;
	b=Z3gerjrBXQ+hCCQSItdBAJ4+0C8w52QYFO71YqDzhYbIyEPwqiBP3AGG6KHsaaQ8UOZj
	 bohMTNQ0lKqw4Qr7t/zVs48iUCJ6XxfJXPdkp0czR9kxNDOmx4O8q1xWbRkrRTZsk7RgZ
	 XnQhxezcO0ZoJqHQS0Y+vZQQzkCklr4Y4ockCiMSh0UnsVjSb27rfykQsw2xgSNsXERd7
	 nVkASdGRHXigmcwg5WEmpRQOxZ5H5jnnQic047LD5FEKEOTIGSamVqcpxFPn0kEVh+Lse
	 iYVBuPwV5xxBuo5VTvSKoRnRi0sWJqq0hQb9e7SK5ic4RTsbjizWKTuR4DNICxMfzrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793306615;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=JCGDeBNuzR12866Js92jwOMlnJeTWdD3ulZ1D1a102s=;
	b=dvhKewe/hYDFxuN1pnwF+LtLI/mcOkIXAaIrsGliZ7DSAI4IZFkCeQQmZGvt8hp5LW96
	 hUdkgLDimLFdLZEcoqbV3/dRhq50Ui972pSPRey59OIXgstD0uElEd2Jrz+fRSuZTa4u1
	 2oiVn5XsSatpK+9O0JHuYzNeF6pyaA/L/PfLYaE4EtCiuvfODNu2RolLRYSeabH3vqhJQ
	 gvmqVdP2q9QiePJPi9eCh4hF7zCNnf5X6TotGIrR9ZRcWm1lNMcjy153AXJlv/Wd5EYqB
	 sP6kxJTsUuTOy/2pH555IPGbqJX6Aoj6amT8sSHQ497r/88QnyEflfOQoorooLfYPaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lEPz6EZy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED726606A31F;
	Thu, 29 Oct 2026 20:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lEPz6EZy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E291F01824;
	Thu, 29 Oct 2026 20:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793306614;
	bh=JCGDeBNuzR12866Js92jwOMlnJeTWdD3ulZ1D1a102s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=lEPz6EZyPvflT7DSH8GG2dOmnZWSALDbGJEfW9oIQ0Ja1whAgdew/+Flp07TBzswS
	 aTxzf7ZIJXBdhN5o4JY2owZeoTmxrPJC//nEIdFF/LaYSjJI7ND0BTH/kTLvwE5ndg
	 ijmZrHFv5CST1RhXa/UxR/KGhTDHZcJgF0G73sisjJg6UwDjgBy1gKzgwChEHWR2Qn
	 9m8/Boa8fgXAnzMeIqCsoXa5qGL+PmbC9GaKcAxUU6Ed2X0HM9L23XfZBAGNV0qNkT
	 6DAXo4j2+y1qkCST4xGODzSUdp8ILrRBenThllhaK2yb1QaIbzrPuHjNprhtcSohcD
	 aKYpIC9+HOBQQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 29 Oct 2026 21:33:36 +0100
Subject: [PATCH v2 41/47] mm/ksm: check large swap-cache folios before
 mapping them
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
Message-Id: <20261029-fixes_core-v2-41-a64ce7f83abb@kernel.org>
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
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5751; i=david@kernel.org;
 h=from:subject:message-id; bh=fs7fiwhPYFrwtM3uOP0Y88aK1IYwtFxH3G5oC54R2BM=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIer+1UX8SRonjcV+LD1LNtqxbVqIZMD8pbrDbFoaGvM
 U949xaLjlIWBjEOBlkxRZag4PsGL1+uq61242OGmcPKBDKEgYtTACZy3pmRoXvCt13CJkq/Xxmm
 1Ais6J864ZOk+NM5BYGxDXdcF3zr+szwP+jKw2N7VW6+EhL4pHjx/OK0ffwzO+QPOh0+cZbnqfv
 JO0wA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

From: Chris Mason <mason@kernel.org>

KSM folios are always small, but their shared swap slots can be read
back as part of a large folio in the swap cache. ksm_might_need_to_copy()
skips large folios, so another process can map a page with an incompatible
anon_vma or page index. Reverse mapping then cannot find the new
mapping, preventing migration or reclaim.

Apply the same compatibility checks to large folios as to small ones.
Pass the page corresponding to the swap entry and copy only that page
when necessary. In do_swap_page()'s copy path, decrement only that slot's
swap count, because the source swap-cache folio can now be large.

Fix generated by an LLM and sent by Chris Mason in private.

Fixes: f1879e8a0c60 ("mm, swap: never bypass the swap cache even for SWP_SYNCHRONOUS_IO")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 include/linux/ksm.h |  6 +++---
 mm/ksm.c            | 22 ++++++++++++----------
 mm/memory.c         |  5 +++--
 mm/swapfile.c       |  3 ++-
 4 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index d39d0d5483a2..a0d358a1feb6 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -91,8 +91,8 @@ static inline void ksm_exit(struct mm_struct *mm)
  * We'd like to make this conditional on vma->vm_flags & VM_MERGEABLE,
  * but what if the vma was unmerged while the page was swapped out?
  */
-struct folio *ksm_might_need_to_copy(struct folio *folio,
-			struct vm_area_struct *vma, unsigned long addr);
+struct folio *ksm_might_need_to_copy(struct folio *folio, struct page *page,
+		struct vm_area_struct *vma, unsigned long addr);
 
 void rmap_walk_ksm(struct folio *folio, struct rmap_walk_control *rwc);
 void folio_migrate_ksm(struct folio *newfolio, struct folio *folio);
@@ -145,7 +145,7 @@ static inline int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
 }
 
 static inline struct folio *ksm_might_need_to_copy(struct folio *folio,
-			struct vm_area_struct *vma, unsigned long addr)
+		struct page *page, struct vm_area_struct *vma, unsigned long addr)
 {
 	return folio;
 }
diff --git a/mm/ksm.c b/mm/ksm.c
index e050b1bdf810..e95f6b672360 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -3138,19 +3138,20 @@ void __ksm_exit(struct mm_struct *mm)
 }
 
 static bool folio_anon_rmap_compatible(const struct folio *folio,
-		struct vm_area_struct *vma, unsigned long addr)
+		const struct page *page, struct vm_area_struct *vma,
+		unsigned long addr)
 {
 	const struct anon_vma *anon_vma = folio_anon_vma(folio);
 	struct anon_vma_chain *avc;
 
 	VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
-	VM_WARN_ON_ONCE_FOLIO(folio_test_large(folio), folio);
+	VM_WARN_ON_ONCE_FOLIO(page_folio(page) != folio, folio);
 	VM_WARN_ON_ONCE_FOLIO(folio_test_ksm(folio), folio);
 	vma_assert_stabilised(vma);
 
 	if (!anon_vma)
 		return true;
-	if (folio->index != linear_anon_page_index(vma, addr))
+	if (page_pgoff(folio, page) != linear_anon_page_index(vma, addr))
 		return false;
 
 	/*
@@ -3167,20 +3168,21 @@ static bool folio_anon_rmap_compatible(const struct folio *folio,
 	return false;
 }
 
-struct folio *ksm_might_need_to_copy(struct folio *folio,
-			struct vm_area_struct *vma, unsigned long addr)
+struct folio *ksm_might_need_to_copy(struct folio *folio, struct page *page,
+		struct vm_area_struct *vma, unsigned long addr)
 {
-	struct page *page = folio_page(folio, 0);
 	struct folio *new_folio;
 
-	if (folio_test_large(folio))
-		return folio;
-
+	/*
+	 * A KSM folio is small, but the slot that it left behind can be swapped
+	 * in as a part of a large folio by one of the processes that shared it.
+	 * So test, and copy, the page of the slot.
+	 */
 	if (folio_test_ksm(folio)) {
 		if (folio_stable_node(folio) &&
 		    !(ksm_run & KSM_RUN_UNMERGE))
 			return folio;	/* no need to copy it */
-	} else if (folio_anon_rmap_compatible(folio, vma, addr)) {
+	} else if (folio_anon_rmap_compatible(folio, page, vma, addr)) {
 		return folio;		/* still no need to copy it */
 	}
 	if (PageHWPoison(page))
diff --git a/mm/memory.c b/mm/memory.c
index 77d4bbf444bc..91836d217d25 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5096,7 +5096,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	 * folio->index of non-ksm folios would be nonlinear inside the
 	 * anon VMA -- the ksm flag is lost on actual swapout.
 	 */
-	folio = ksm_might_need_to_copy(folio, vma, vmf->address);
+	folio = ksm_might_need_to_copy(folio, page, vma, vmf->address);
 	if (unlikely(!folio)) {
 		ret = VM_FAULT_OOM;
 		folio = swapcache;
@@ -5278,7 +5278,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	if (unlikely(folio != swapcache)) {
 		folio_add_new_anon_rmap(folio, vma, address, RMAP_EXCLUSIVE);
 		folio_add_lru_vma(folio, vma);
-		folio_put_swap(swapcache, NULL);
+		folio_put_swap(swapcache,
+			       folio_file_page(swapcache, swp_offset(entry)));
 	} else if (!folio_test_anon(folio)) {
 		/*
 		 * We currently only expect !anon folios that are fully
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 254ce86fa923..71ef9e2efb3a 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2514,7 +2514,8 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 		return 0;
 
 	swapcache = folio;
-	folio = ksm_might_need_to_copy(folio, vma, addr);
+	folio = ksm_might_need_to_copy(folio,
+				       folio_file_page(folio, swp_offset(entry)), vma, addr);
 	if (unlikely(!folio))
 		return -ENOMEM;
 	else if (unlikely(folio == ERR_PTR(-EHWPOISON))) {

-- 
2.43.0

