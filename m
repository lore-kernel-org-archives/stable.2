Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794841653;
	b=XBvzYtdKssrH+xlPYv6Hin+v2zDqpuMu/nR4dE1bgyRMZCxct1ATNwuKs+3FZwi6/beZ
	 ERQWjnM0LR7kWSNe6NQB/EZZmFAM/nOYj2FaqCs1bXtQzg1PlFII45gbnYuAr7QLS4usj
	 XlbPtRaCiLmJIMakK/tul/uEiXd+CySJWhOfCCLqvZqdj/Gs7jc6E2kfZsnjS4foYQnHn
	 kvkIvstImHixH1zLZ0smCxb6kUMTrOp22WoV5KJIUVK4SDXQFThS6zzFWFiBeN5Rygcvk
	 Md5HwkN4U1DohgzV5w4HyEC1zsm3sFec0C0IUGnpzKXlzwaZ9bvoSq/vsHOl5TukxHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794841653;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=0QD0cZDtrkR3rLOoBjHXBbjLwcVi1FoKhT6W4AU5zZQ=;
	b=tjIemgL3MCYjYYBxSrDH9W6eZe/xfJNT1+34N9NTutbXCFD8IRSRz/3ava8+9sOjhHf9
	 wpyTAQNSsOyA6/mpF3pyqvipxN2sdznkapcRS/8qlVxz+Lml/26rNRilx/UxUQugg8ArU
	 m8GtFyF+Yr7AvLnR8XaZqguFJDPxxn0J5G+nLQnbZfG0E8pcXgCneS3sGaaIskPewnTEk
	 fJ/PTPGTkjH8PYAmanmrKn9nKL0awNTK5RlMAdnbnkuz+H9RT8qKw9UQ+Qvnmgf+JVpbQ
	 TTDwQHscNHqs5QAnNLWLeBY9RNs13Q9GI5mg5q+bH/529B/xB9BS4njVH7XG7CKy5zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lDJze0Vl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF026606A32C;
	Mon, 16 Nov 2026 15:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lDJze0Vl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EF421F000C4;
	Mon, 16 Nov 2026 15:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794841653;
	bh=0QD0cZDtrkR3rLOoBjHXBbjLwcVi1FoKhT6W4AU5zZQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=lDJze0Vlbcx2eI74aKzEKn3KdIydzUfHMgoquUwTd1TIfaHSoBe4IUcA8Q/Ji2wGx
	 vNp5ihS9PBvh+TrfzNxZ+wsc2SQyq/Meu2xMk2XXFeocT0Msokui/0QltUAAgwy6C/
	 IzbJlS4fQ5eo2ZlMlp7HMTGDG/oJRHExa0fZuae76wNsCukjWGfE5eoeBD9M258zEH
	 wAsR5dqz3416tpYEZ9L2EyvtrJeRGhJks+x6+1ma3dAhNJF7QGvlWKihEwst2r61C3
	 VcLlAhpXDlaXAFAuX7WPzc46yuI4zmex34ot50jrBtEa/2cioFCf41wC12ND/waBta
	 +RxPsW3jWFfBg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Mon, 16 Nov 2026 16:06:59 +0100
Subject: [PATCH v2 2/2] mm/huge_memory: flush dirty file PMDs before
 removing rmap
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
Message-Id: <20261116-dirty_file_pmd-v2-2-571883053174@kernel.org>
References: <20261116-dirty_file_pmd-v2-0-571883053174@kernel.org>
In-Reply-To: <20261116-dirty_file_pmd-v2-0-571883053174@kernel.org>
To: Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, 
 Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, 
 Johannes Weiner <hannes@cmpxchg.org>, Hugh Dickins <hughd@google.com>, 
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>, 
 Ross Zwisler <zwisler@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, "David Hildenbrand (Arm)" <david@kernel.org>, 
 stable@vger.kernel.org, Chris Mason <mason@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7977; i=david@kernel.org;
 h=from:subject:message-id; bh=e1ViBoVjr5NiC44orqqaZsOgVGlVMLZ0SYLciR+I1cE=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLJ+y0hPXpmnL9fb0Tx9W/Sha173Xfc9nlEVvr/fQz72c
 1Iv55rqjlIWBjEOBlkxRZag4PsGL1+uq61242OGmcPKBDKEgYtTACainM/IcLp807aAq1qzi39p
 TO/64svCr3XGd8uBRSuYuHYcDRJL+8/wz/bMatebSZ7vJISCvnd+cP0ov/6JcLOIdUMK6zfnKKf
 7nAA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

Unmapping a file PMD can lose concurrent stores when it races with
writeback. zap_huge_pmd() removes rmap and drops the PMD lock before the
gather flushes the TLB. Writeback can then clean the folio while another
thread can still write through a stale writable TLB entry. Those stores
do not fault and dirty the folio again. Filesystem DAX has the same
problem with its dirty tags.

Commit 5df397dec7c4 ("mm: delay page_remove_rmap() until after the TLB
has been flushed") fixed the same race for PTEs by adding delayed rmap
removal to the mmu_gather infrastructure. The PMD path still removes
rmap before flushing.

Flush the TLB under the PMD lock before removing rmap for dirty file
PMDs. Skip the early flush at address-space teardown, when no users
remain, and for mappings without writeback, including shmem and device
DAX.

Use tlb_can_delay_rmap() to share the PTE path's architecture checks.
On s390, clearing the entry already handles TLB synchronization, and
__tlb_remove_page_size() immediately drops the mapping reference, so
rmap must be removed first. Make the predicate side-effect-free and set
the gather's delayed_rmap flag when an entry is actually queued for
delayed rmap removal.

Queue the folio before the early flush, while the gather still has a
valid range. Keep batching references and drain a full batch only after
dropping the PMD lock. The early flush resets the gather's TLB state,
so draining the batch does not flush that range again.

Although writing to files through mmap is generally discouraged,
unmapping such mappings may become slower: each dirty file PMD now
requires a TLB flush under the PMD lock. Future work should properly
extend the delayed-rmap machinery to PMDs and hold the PMD spinlock
across multiple entries, so their TLB invalidations and rmap removals
can be batched.

Fixes: 4b4bb46d00b3 ("dax: clear dirty entry tags on cache flush")
Cc: stable@vger.kernel.org
Reported-by: Kiryl Shutsemau <kas@kernel.org>
Closes: https://lore.kernel.org/linux-mm/aoWw_iKEDLjKL2jr@thinkstation/
Reported-by: Chris Mason <mason@kernel.org>
Link: https://git.kernel.org/linus/5df397dec7c4c08c23bd14f162f1228836faa4ce
Suggested-by: Lance Yang <lance.yang@linux.dev>
Suggested-by: Usama Arif <usama.arif@linux.dev>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 include/asm-generic/tlb.h | 10 +++-------
 mm/huge_memory.c          | 39 +++++++++++++++++++++++++++++++--------
 mm/memory.c               |  2 +-
 mm/mmu_gather.c           |  2 ++
 4 files changed, 37 insertions(+), 16 deletions(-)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index cb087315b4e72..b318e3e9e66a8 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -249,11 +249,7 @@ extern bool __tlb_remove_page_size(struct mmu_gather *tlb, struct page *page, in
 bool __tlb_remove_folio_pages(struct mmu_gather *tlb, struct page *page,
 		unsigned int nr_pages, bool delay_rmap);
 
-/*
- * This both sets 'delayed_rmap', and returns true. It would be an inline
- * function, except we define it before the 'struct mmu_gather'.
- */
-#define tlb_delay_rmap(tlb) (((tlb)->delayed_rmap = 1), true)
+#define tlb_can_delay_rmap() (true)
 extern void tlb_flush_rmaps(struct mmu_gather *tlb, struct vm_area_struct *vma);
 
 #endif
@@ -263,8 +259,8 @@ extern void tlb_flush_rmaps(struct mmu_gather *tlb, struct vm_area_struct *vma);
  * delay anything. That is used on S390, which flushes remote
  * TLBs synchronously.
  */
-#ifndef tlb_delay_rmap
-#define tlb_delay_rmap(tlb) (false)
+#ifndef tlb_can_delay_rmap
+#define tlb_can_delay_rmap() (false)
 static inline void tlb_flush_rmaps(struct mmu_gather *tlb, struct vm_area_struct *vma) { }
 #endif
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 7791872f14af7..79d400ea9553d 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2508,10 +2508,12 @@ static inline void zap_deposited_table(struct mm_struct *mm, pmd_t *pmd)
 	mm_dec_nr_ptes(mm);
 }
 
-static void zap_huge_pmd_folio(struct mm_struct *mm, struct vm_area_struct *vma,
-		pmd_t pmdval, struct folio *folio, bool is_present)
+static void zap_huge_pmd_folio(struct mmu_gather *tlb, struct vm_area_struct *vma,
+		pmd_t pmdval, struct folio *folio, bool is_present, bool *force_flush)
 {
 	const bool is_device_private = pmd_is_device_private_entry(pmdval);
+	struct mm_struct *mm = tlb->mm;
+	bool delay_rmap = false;
 
 	if (folio_test_anon(folio)) {
 		add_mm_counter(mm, MM_ANONPAGES, -HPAGE_PMD_NR);
@@ -2519,23 +2521,42 @@ static void zap_huge_pmd_folio(struct mm_struct *mm, struct vm_area_struct *vma,
 		add_mm_counter(mm, mm_counter_file(folio),
 			       -HPAGE_PMD_NR);
 
-		if (is_present && pmd_dirty(pmdval))
+		if (is_present && pmd_dirty(pmdval)) {
 			folio_mark_dirty(folio);
+			/*
+			 * Remove rmap after the TLB flush if stale TLB entries
+			 * could still be used to write to a mapping that
+			 * supports writeback.
+			 */
+			if (!tlb->fullmm && vma->vm_file &&
+			    mapping_can_writeback(vma->vm_file->f_mapping))
+				delay_rmap = tlb_can_delay_rmap();
+		}
 		if (is_present && pmd_young(pmdval) &&
 		    likely(vma_has_recency(vma)))
 			folio_mark_accessed(folio);
 	}
 
+	if (!is_present && !is_device_private)
+		return;
+
 	/*
 	 * Present and device private folios are rmappable. Remove the
 	 * rmap after transferring young+dirty to the folio.
 	 */
-	if (is_present || is_device_private)
+	if (!delay_rmap)
 		folio_remove_rmap_pmd(folio, &folio->page, vma);
 
-	/* Device private folios are pinned. */
+	/* Device private folios are pinned and don't need a TLB flush. */
 	if (is_device_private)
 		folio_put(folio);
+	else if (__tlb_remove_page_size(tlb, &folio->page, HPAGE_PMD_SIZE))
+		*force_flush = true;
+
+	if (delay_rmap) {
+		tlb_flush_mmu_tlbonly(tlb);
+		folio_remove_rmap_pmd(folio, &folio->page, vma);
+	}
 }
 
 static struct folio *normal_or_softleaf_folio_pmd(struct vm_area_struct *vma,
@@ -2573,6 +2594,7 @@ bool zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	struct mm_struct *mm = tlb->mm;
 	struct folio *folio = NULL;
 	bool is_present = false;
+	bool force_flush = false;
 	bool has_deposit;
 	spinlock_t *ptl;
 	pmd_t orig_pmd;
@@ -2597,13 +2619,14 @@ bool zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	folio = normal_or_softleaf_folio_pmd(vma, addr, orig_pmd, is_present);
 	has_deposit = vma_has_deposited_pgtable(vma);
 	if (folio)
-		zap_huge_pmd_folio(mm, vma, orig_pmd, folio, is_present);
+		zap_huge_pmd_folio(tlb, vma, orig_pmd, folio, is_present,
+				   &force_flush);
 	if (has_deposit)
 		zap_deposited_table(mm, pmd);
 
 	spin_unlock(ptl);
-	if (is_present && folio)
-		tlb_remove_page_size(tlb, &folio->page, HPAGE_PMD_SIZE);
+	if (force_flush)
+		tlb_flush_mmu(tlb);
 	return true;
 }
 
diff --git a/mm/memory.c b/mm/memory.c
index 7f019afc35ca0..cd954afb146f4 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1757,7 +1757,7 @@ static __always_inline void zap_present_folio_ptes(struct mmu_gather *tlb,
 		ptent = get_and_clear_full_ptes(mm, addr, pte, nr, tlb->fullmm);
 		if (pte_dirty(ptent)) {
 			folio_mark_dirty(folio);
-			if (tlb_delay_rmap(tlb)) {
+			if (tlb_can_delay_rmap()) {
 				delay_rmap = true;
 				*force_flush = true;
 			}
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index c022aeb7c84d0..fc547be33a919 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -169,6 +169,8 @@ static bool __tlb_remove_folio_pages_size(struct mmu_gather *tlb,
 	struct mmu_gather_batch *batch;
 
 	VM_BUG_ON(!tlb->end);
+	if (delay_rmap)
+		tlb->delayed_rmap = 1;
 
 #ifdef CONFIG_MMU_GATHER_PAGE_SIZE
 	VM_WARN_ON(tlb->page_size != page_size);

-- 
2.56.1

