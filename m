Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFFD56B85B
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 19:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790711268; cv=none; b=XwwicuzTLBvUdgs+J/JIlqo6b7voaTHEnTuesAs9q3MseTWHx0vrjlx6MsvdgUY/gz1yt5XbZ2SkCHWkgERMqyKIHjn2JDxMTTzSywIeKhWsENr/jeshkuX5kXts7Pk8Z/6M+jU/unXrYokXvP79GCMAcWlm2tqSMKNBVoVKK3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790711268; c=relaxed/simple;
	bh=ypVqVrJNq6lishZ/Tos8TLnJfxTQfnCCcr4wy7foiis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=os78J3r3fAY6PB5QtyxwhtkllchplCK1R7m+VIbnM1wUoYJe03SQSWWIqCrJGvbkfnAGVLKLAOJ48wKVT0F0duJxflI8PAVWTG7FjculpG7d1KjFGOEiKEwy44+1Fcdt5lM70ujCaSFfIonwsHCb54V/CzlRlDUHwtmuuFZJX1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LNCI7nx/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNCI7nx/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E1771F000FF;
	Tue, 29 Sep 2026 19:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790711265;
	bh=Udhc6akT050Xxlb/ptSnbpDhHpbBbbw7fjXqUbecomg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LNCI7nx/1mGlx9FCNNT/b3BEDqeuyMNe/+P5QXVeFDRjInWi2JIMApVeD6qa/o7lh
	 JwOYDsmBxgJc5tEvnQky9I0NsxbGElUqaLAzgMvDQ9Ky58blBvR6WKbYgtP54gvzKK
	 umfSxOq0uHEI1Es850pxumOvYwp89E6V9r5Fvxl2F0fAMjMOCbBjcuoJOWHTFbv0ko
	 AdX9BTNthJhIxljzA+88L2OWeTX3qkHinfTuqg4qVhNSatuPB3Tdmfp7t1vnJUzw5e
	 jbXvSYLwvwRtSwZIj3+Z2n92HHyCNCbPIXW+j2B1JaLG7tyPVWijQwAcfHUKMtYEdz
	 X6jxCFLQDrgrA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] mm: hugetlb: Add huge page size param to huge_ptep_get_and_clear()
Date: Tue, 29 Sep 2026 15:47:41 -0400
Message-ID: <20260929194742.835805-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092931-carat-unheard-5a1d@gregkh>
References: <2026092931-carat-unheard-5a1d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ryan Roberts <ryan.roberts@arm.com>

[ Upstream commit 02410ac72ac3707936c07ede66e94360d0d65319 ]

In order to fix a bug, arm64 needs to be told the size of the huge page
for which the huge_pte is being cleared in huge_ptep_get_and_clear().
Provide for this by adding an `unsigned long sz` parameter to the
function. This follows the same pattern as huge_pte_clear() and
set_huge_pte_at().

This commit makes the required interface modifications to the core mm as
well as all arches that implement this function (arm64, loongarch, mips,
parisc, powerpc, riscv, s390, sparc). The actual arm64 bug will be fixed
in a separate commit.

Cc: stable@vger.kernel.org
Fixes: 66b3923a1a0f ("arm64: hugetlb: add support for PTE contiguous bit")
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com> # riscv
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
Acked-by: Alexander Gordeev <agordeev@linux.ibm.com> # s390
Link: https://lore.kernel.org/r/20250226120656.2400136-2-ryan.roberts@arm.com
Signed-off-by: Will Deacon <will@kernel.org>

[6.1 dependency adaptation for 39c0ceedd54557bdc1542de08d22b2ed33e534e4]

Keep the huge_ptep_get_and_clear() size argument and update the existing
6.1 implementations and callers. Drop the RISC-V overrides and arm64
protection-helper hunks: those functions do not exist in this tree.
Extend s390's existing function directly instead of adding a wrapper.

The target also requires the set_huge_pte_at() size argument and the
mm/address arguments to huge_ptep_get(). Include the relevant interface
preparation from 935d4f0c6dc8 and e6c0c03245b1, adapting all callers to 6.1.
Preserve existing architecture behavior and add no functions. In
particular, extend s390 and sparc setters directly, pass sizes from their
existing callers, and pass the actual byte size in the powerpc 8xx early
mapping path as corrected by 7ea981070fd9. Adapt the older migration wait
and GUP helpers instead of importing their newer upstream replacements.

Prepare damon_hugetlb_mkold() with the existing folio APIs (as in
6b7cea90c82e) so the target patch applies without context changes. Allow
its notifier call when CONFIG_MMU_NOTIFIER is disabled by aliasing
mmu_notifier_clear_young to the existing no-op clear_flush_young stub;
this avoids adding a function. The target's atomic clear/restore fix
and new DAMON helper remain for the target commit itself.

[ sashal: Reduced backport -- upstream 02410ac72ac37 touches 16 file(s), this
  backport carries 35. Not backported here:
  arch/riscv/include/asm/hugetlb.h
  arch/riscv/mm/hugetlbpage.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 39c0ceedd545 ("mm/damon/vaddr: avoid hw-driven pte updates during damon_hugetlb_mkold()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/include/asm/hugetlb-3level.h         |   4 +-
 arch/arm64/include/asm/hugetlb.h              |   8 +-
 arch/arm64/mm/hugetlbpage.c                   |   8 +-
 arch/loongarch/include/asm/hugetlb.h          |   6 +-
 arch/mips/include/asm/hugetlb.h               |   6 +-
 arch/parisc/include/asm/hugetlb.h             |   4 +-
 arch/parisc/mm/hugetlbpage.c                  |   4 +-
 arch/powerpc/include/asm/hugetlb.h            |   6 +-
 .../include/asm/nohash/32/hugetlb-8xx.h       |   3 +-
 arch/powerpc/mm/book3s64/hugetlbpage.c        |   5 +-
 arch/powerpc/mm/book3s64/radix_hugetlbpage.c  |   3 +-
 arch/powerpc/mm/nohash/8xx.c                  |   4 +-
 arch/powerpc/mm/pgtable.c                     |   3 +-
 arch/s390/include/asm/hugetlb.h               |  25 +++--
 arch/s390/mm/hugetlbpage.c                    |  10 +-
 arch/sparc/include/asm/hugetlb.h              |  13 ++-
 arch/sparc/mm/hugetlbpage.c                   |   4 +-
 fs/hugetlbfs/inode.c                          |   2 +-
 fs/proc/task_mmu.c                            |   4 +-
 fs/userfaultfd.c                              |   2 +-
 include/asm-generic/hugetlb.h                 |   6 +-
 include/linux/hugetlb.h                       |  10 +-
 include/linux/mmu_notifier.h                  |   2 +
 include/linux/swapops.h                       |  12 ++-
 mm/damon/vaddr.c                              |  21 ++--
 mm/gup.c                                      |   2 +-
 mm/hmm.c                                      |   2 +-
 mm/hugetlb.c                                  | 101 +++++++++---------
 mm/memory-failure.c                           |   2 +-
 mm/mempolicy.c                                |   2 +-
 mm/migrate.c                                  |  17 +--
 mm/mincore.c                                  |   2 +-
 mm/rmap.c                                     |  23 +++-
 mm/userfaultfd.c                              |   2 +-
 mm/vmalloc.c                                  |   2 +-
 35 files changed, 192 insertions(+), 138 deletions(-)

diff --git a/arch/arm/include/asm/hugetlb-3level.h b/arch/arm/include/asm/hugetlb-3level.h
index a30be55057939..3c6375e27b47c 100644
--- a/arch/arm/include/asm/hugetlb-3level.h
+++ b/arch/arm/include/asm/hugetlb-3level.h
@@ -13,12 +13,12 @@
 
 /*
  * If our huge pte is non-zero then mark the valid bit.
- * This allows pte_present(huge_ptep_get(ptep)) to return true for non-zero
+ * This allows pte_present(huge_ptep_get(mm, addr, ptep)) to return true for non-zero
  * ptes.
  * (The valid bit is automatically cleared by set_pte_at for PROT_NONE ptes).
  */
 #define __HAVE_ARCH_HUGE_PTEP_GET
-static inline pte_t huge_ptep_get(pte_t *ptep)
+static inline pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
 	pte_t retval = *ptep;
 	if (pte_val(retval))
diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
index d20f5da2d76fa..5bd7da90dd315 100644
--- a/arch/arm64/include/asm/hugetlb.h
+++ b/arch/arm64/include/asm/hugetlb.h
@@ -27,14 +27,14 @@ pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags);
 #define arch_make_huge_pte arch_make_huge_pte
 #define __HAVE_ARCH_HUGE_SET_HUGE_PTE_AT
 extern void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
-			    pte_t *ptep, pte_t pte);
+			    pte_t *ptep, pte_t pte, unsigned long sz);
 #define __HAVE_ARCH_HUGE_PTEP_SET_ACCESS_FLAGS
 extern int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 				      unsigned long addr, pte_t *ptep,
 				      pte_t pte, int dirty);
 #define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
-extern pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
-				     unsigned long addr, pte_t *ptep);
+extern pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
+				     pte_t *ptep, unsigned long sz);
 #define __HAVE_ARCH_HUGE_PTEP_SET_WRPROTECT
 extern void huge_ptep_set_wrprotect(struct mm_struct *mm,
 				    unsigned long addr, pte_t *ptep);
@@ -45,7 +45,7 @@ extern pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 extern void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
 			   pte_t *ptep, unsigned long sz);
 #define __HAVE_ARCH_HUGE_PTEP_GET
-extern pte_t huge_ptep_get(pte_t *ptep);
+extern pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep);
 
 void __init arm64_hugetlb_cma_reserve(void);
 
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 79f0d2a776885..717879e6e1ad8 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -148,7 +148,7 @@ static inline int num_contig_ptes(unsigned long size, size_t *pgsize)
 	return contig_ptes;
 }
 
-pte_t huge_ptep_get(pte_t *ptep)
+pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
 	int ncontig, i;
 	size_t pgsize;
@@ -249,7 +249,7 @@ static inline struct folio *hugetlb_swap_entry_to_folio(swp_entry_t entry)
 }
 
 void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
-			    pte_t *ptep, pte_t pte)
+			    pte_t *ptep, pte_t pte, unsigned long sz)
 {
 	size_t pgsize;
 	int i;
@@ -421,8 +421,8 @@ void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
 		pte_clear(mm, addr, ptep);
 }
 
-pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
-			      unsigned long addr, pte_t *ptep)
+pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
+			      pte_t *ptep, unsigned long sz)
 {
 	int ncontig;
 	size_t pgsize;
diff --git a/arch/loongarch/include/asm/hugetlb.h b/arch/loongarch/include/asm/hugetlb.h
index 427b487fbfd65..7b88eda0ac7e8 100644
--- a/arch/loongarch/include/asm/hugetlb.h
+++ b/arch/loongarch/include/asm/hugetlb.h
@@ -41,7 +41,8 @@ static inline void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
 
 #define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
 static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
-					    unsigned long addr, pte_t *ptep)
+					    unsigned long addr, pte_t *ptep,
+					    unsigned long sz)
 {
 	pte_t clear;
 	pte_t pte = *ptep;
@@ -56,8 +57,9 @@ static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 					  unsigned long addr, pte_t *ptep)
 {
 	pte_t pte;
+	unsigned long sz = huge_page_size(hstate_vma(vma));
 
-	pte = huge_ptep_get_and_clear(vma->vm_mm, addr, ptep);
+	pte = huge_ptep_get_and_clear(vma->vm_mm, addr, ptep, sz);
 	flush_tlb_page(vma, addr);
 	return pte;
 }
diff --git a/arch/mips/include/asm/hugetlb.h b/arch/mips/include/asm/hugetlb.h
index fd69c88085542..00ee3c0366305 100644
--- a/arch/mips/include/asm/hugetlb.h
+++ b/arch/mips/include/asm/hugetlb.h
@@ -32,7 +32,8 @@ static inline int prepare_hugepage_range(struct file *file,
 
 #define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
 static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
-					    unsigned long addr, pte_t *ptep)
+					    unsigned long addr, pte_t *ptep,
+					    unsigned long sz)
 {
 	pte_t clear;
 	pte_t pte = *ptep;
@@ -47,13 +48,14 @@ static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 					  unsigned long addr, pte_t *ptep)
 {
 	pte_t pte;
+	unsigned long sz = huge_page_size(hstate_vma(vma));
 
 	/*
 	 * clear the huge pte entry firstly, so that the other smp threads will
 	 * not get old pte entry after finishing flush_tlb_page and before
 	 * setting new huge pte entry
 	 */
-	pte = huge_ptep_get_and_clear(vma->vm_mm, addr, ptep);
+	pte = huge_ptep_get_and_clear(vma->vm_mm, addr, ptep, sz);
 	flush_tlb_page(vma, addr);
 	return pte;
 }
diff --git a/arch/parisc/include/asm/hugetlb.h b/arch/parisc/include/asm/hugetlb.h
index f7f078c2872c4..f7a91411dcc95 100644
--- a/arch/parisc/include/asm/hugetlb.h
+++ b/arch/parisc/include/asm/hugetlb.h
@@ -6,11 +6,11 @@
 
 #define __HAVE_ARCH_HUGE_SET_HUGE_PTE_AT
 void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
-		     pte_t *ptep, pte_t pte);
+		     pte_t *ptep, pte_t pte, unsigned long sz);
 
 #define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
 pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
-			      pte_t *ptep);
+			      pte_t *ptep, unsigned long sz);
 
 /*
  * If the arch doesn't supply something else, assume that hugepage
diff --git a/arch/parisc/mm/hugetlbpage.c b/arch/parisc/mm/hugetlbpage.c
index d1d3990b83f65..27c38c2ce301e 100644
--- a/arch/parisc/mm/hugetlbpage.c
+++ b/arch/parisc/mm/hugetlbpage.c
@@ -140,14 +140,14 @@ static void __set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 }
 
 void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
-		     pte_t *ptep, pte_t entry)
+		     pte_t *ptep, pte_t entry, unsigned long sz)
 {
 	__set_huge_pte_at(mm, addr, ptep, entry);
 }
 
 
 pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
-			      pte_t *ptep)
+			      pte_t *ptep, unsigned long sz)
 {
 	pte_t entry;
 
diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
index 8d8f4909ae1a4..167c66c4e9ea7 100644
--- a/arch/powerpc/include/asm/hugetlb.h
+++ b/arch/powerpc/include/asm/hugetlb.h
@@ -46,7 +46,8 @@ void hugetlb_free_pgd_range(struct mmu_gather *tlb, unsigned long addr,
 
 #define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
 static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
-					    unsigned long addr, pte_t *ptep)
+					    unsigned long addr, pte_t *ptep,
+					    unsigned long sz)
 {
 	return __pte(pte_update(mm, addr, ptep, ~0UL, 0, 1));
 }
@@ -56,8 +57,9 @@ static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 					  unsigned long addr, pte_t *ptep)
 {
 	pte_t pte;
+	unsigned long sz = huge_page_size(hstate_vma(vma));
 
-	pte = huge_ptep_get_and_clear(vma->vm_mm, addr, ptep);
+	pte = huge_ptep_get_and_clear(vma->vm_mm, addr, ptep, sz);
 	flush_hugetlb_page(vma, addr);
 	return pte;
 }
diff --git a/arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h b/arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h
index de092b04ee1a1..92df40c6cc6b5 100644
--- a/arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h
@@ -46,7 +46,8 @@ static inline int check_and_get_huge_psize(int shift)
 }
 
 #define __HAVE_ARCH_HUGE_SET_HUGE_PTE_AT
-void set_huge_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep, pte_t pte);
+void set_huge_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
+		     pte_t pte, unsigned long sz);
 
 #define __HAVE_ARCH_HUGE_PTE_CLEAR
 static inline void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
diff --git a/arch/powerpc/mm/book3s64/hugetlbpage.c b/arch/powerpc/mm/book3s64/hugetlbpage.c
index 3bc0eb21b2a00..5a2e512e96db6 100644
--- a/arch/powerpc/mm/book3s64/hugetlbpage.c
+++ b/arch/powerpc/mm/book3s64/hugetlbpage.c
@@ -143,11 +143,14 @@ pte_t huge_ptep_modify_prot_start(struct vm_area_struct *vma,
 void huge_ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long addr,
 				  pte_t *ptep, pte_t old_pte, pte_t pte)
 {
+	unsigned long psize;
 
 	if (radix_enabled())
 		return radix__huge_ptep_modify_prot_commit(vma, addr, ptep,
 							   old_pte, pte);
-	set_huge_pte_at(vma->vm_mm, addr, ptep, pte);
+
+	psize = huge_page_size(hstate_vma(vma));
+	set_huge_pte_at(vma->vm_mm, addr, ptep, pte, psize);
 }
 
 void __init hugetlbpage_init_defaultsize(void)
diff --git a/arch/powerpc/mm/book3s64/radix_hugetlbpage.c b/arch/powerpc/mm/book3s64/radix_hugetlbpage.c
index 5e3195568525b..5c04fd2b0afd9 100644
--- a/arch/powerpc/mm/book3s64/radix_hugetlbpage.c
+++ b/arch/powerpc/mm/book3s64/radix_hugetlbpage.c
@@ -46,6 +46,7 @@ void radix__huge_ptep_modify_prot_commit(struct vm_area_struct *vma,
 					 pte_t old_pte, pte_t pte)
 {
 	struct mm_struct *mm = vma->vm_mm;
+	unsigned long psize = huge_page_size(hstate_vma(vma));
 
 	/*
 	 * POWER9 NMMU must flush the TLB after clearing the PTE before
@@ -57,5 +58,5 @@ void radix__huge_ptep_modify_prot_commit(struct vm_area_struct *vma,
 	    atomic_read(&mm->context.copros) > 0)
 		radix__flush_hugetlb_page(vma, addr);
 
-	set_huge_pte_at(vma->vm_mm, addr, ptep, pte);
+	set_huge_pte_at(vma->vm_mm, addr, ptep, pte, psize);
 }
diff --git a/arch/powerpc/mm/nohash/8xx.c b/arch/powerpc/mm/nohash/8xx.c
index 52f24fda2d5f6..a947dff35d651 100644
--- a/arch/powerpc/mm/nohash/8xx.c
+++ b/arch/powerpc/mm/nohash/8xx.c
@@ -91,7 +91,9 @@ static int __ref __early_map_kernel_hugepage(unsigned long va, phys_addr_t pa,
 	if (new && WARN_ON(pte_present(*ptep) && pgprot_val(prot)))
 		return -EINVAL;
 
-	set_huge_pte_at(&init_mm, va, ptep, pte_mkhuge(pfn_pte(pa >> PAGE_SHIFT, prot)));
+	set_huge_pte_at(&init_mm, va, ptep,
+			pte_mkhuge(pfn_pte(pa >> PAGE_SHIFT, prot)),
+			1UL << mmu_psize_to_shift(psize));
 
 	return 0;
 }
diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index cb2dcdb18f8ec..389f88434bc97 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -279,7 +279,8 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 }
 
 #if defined(CONFIG_PPC_8xx)
-void set_huge_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep, pte_t pte)
+void set_huge_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
+		     pte_t pte, unsigned long sz)
 {
 	pmd_t *pmd = pmd_off(mm, addr);
 	pte_basic_t val;
diff --git a/arch/s390/include/asm/hugetlb.h b/arch/s390/include/asm/hugetlb.h
index ccdbccfde148c..f07a98e8c68cb 100644
--- a/arch/s390/include/asm/hugetlb.h
+++ b/arch/s390/include/asm/hugetlb.h
@@ -16,10 +16,10 @@
 #define hugepages_supported()			(MACHINE_HAS_EDAT1)
 
 void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
-		     pte_t *ptep, pte_t pte);
-pte_t huge_ptep_get(pte_t *ptep);
-pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
-			      unsigned long addr, pte_t *ptep);
+		     pte_t *ptep, pte_t pte, unsigned long sz);
+pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep);
+pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
+			      pte_t *ptep, unsigned long sz);
 
 /*
  * If the arch doesn't supply something else, assume that hugepage
@@ -55,17 +55,20 @@ static inline void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
 static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 					  unsigned long address, pte_t *ptep)
 {
-	return huge_ptep_get_and_clear(vma->vm_mm, address, ptep);
+	return huge_ptep_get_and_clear(vma->vm_mm, address, ptep,
+				       huge_page_size(hstate_vma(vma)));
 }
 
 static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 					     unsigned long addr, pte_t *ptep,
 					     pte_t pte, int dirty)
 {
-	int changed = !pte_same(huge_ptep_get(ptep), pte);
+	int changed = !pte_same(huge_ptep_get(vma->vm_mm, addr, ptep), pte);
 	if (changed) {
-		huge_ptep_get_and_clear(vma->vm_mm, addr, ptep);
-		set_huge_pte_at(vma->vm_mm, addr, ptep, pte);
+		huge_ptep_get_and_clear(vma->vm_mm, addr, ptep,
+					huge_page_size(hstate_vma(vma)));
+		set_huge_pte_at(vma->vm_mm, addr, ptep, pte,
+				huge_page_size(hstate_vma(vma)));
 	}
 	return changed;
 }
@@ -73,8 +76,10 @@ static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
 					   unsigned long addr, pte_t *ptep)
 {
-	pte_t pte = huge_ptep_get_and_clear(mm, addr, ptep);
-	set_huge_pte_at(mm, addr, ptep, pte_wrprotect(pte));
+	unsigned long sz = (pte_val(*ptep) & _REGION_ENTRY_TYPE_MASK) ==
+			   _REGION_ENTRY_TYPE_R3 ? PUD_SIZE : PMD_SIZE;
+	pte_t pte = huge_ptep_get_and_clear(mm, addr, ptep, sz);
+	set_huge_pte_at(mm, addr, ptep, pte_wrprotect(pte), sz);
 }
 
 static inline pte_t mk_huge_pte(struct page *page, pgprot_t pgprot)
diff --git a/arch/s390/mm/hugetlbpage.c b/arch/s390/mm/hugetlbpage.c
index 33ef6790114ab..4da510931fd59 100644
--- a/arch/s390/mm/hugetlbpage.c
+++ b/arch/s390/mm/hugetlbpage.c
@@ -143,7 +143,7 @@ static void clear_huge_pte_skeys(struct mm_struct *mm, unsigned long rste)
 }
 
 void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
-		     pte_t *ptep, pte_t pte)
+		     pte_t *ptep, pte_t pte, unsigned long sz)
 {
 	unsigned long rste;
 
@@ -163,15 +163,15 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 	set_pte(ptep, __pte(rste));
 }
 
-pte_t huge_ptep_get(pte_t *ptep)
+pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
 	return __rste_to_pte(pte_val(*ptep));
 }
 
-pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
-			      unsigned long addr, pte_t *ptep)
+pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
+			      pte_t *ptep, unsigned long sz)
 {
-	pte_t pte = huge_ptep_get(ptep);
+	pte_t pte = huge_ptep_get(mm, addr, ptep);
 	pmd_t *pmdp = (pmd_t *) ptep;
 	pud_t *pudp = (pud_t *) ptep;
 
diff --git a/arch/sparc/include/asm/hugetlb.h b/arch/sparc/include/asm/hugetlb.h
index 0a26cca24232c..d987e9677fb5c 100644
--- a/arch/sparc/include/asm/hugetlb.h
+++ b/arch/sparc/include/asm/hugetlb.h
@@ -14,11 +14,11 @@ extern struct pud_huge_patch_entry __pud_huge_patch, __pud_huge_patch_end;
 
 #define __HAVE_ARCH_HUGE_SET_HUGE_PTE_AT
 void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
-		     pte_t *ptep, pte_t pte);
+		     pte_t *ptep, pte_t pte, unsigned long sz);
 
 #define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
 pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
-			      pte_t *ptep);
+			      pte_t *ptep, unsigned long sz);
 
 #define __HAVE_ARCH_HUGE_PTEP_CLEAR_FLUSH
 static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
@@ -32,7 +32,11 @@ static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
 					   unsigned long addr, pte_t *ptep)
 {
 	pte_t old_pte = *ptep;
-	set_huge_pte_at(mm, addr, ptep, pte_wrprotect(old_pte));
+	unsigned long sz = pte_leaf_size(old_pte);
+
+	if (sz == REAL_HPAGE_SIZE)
+		sz = HPAGE_SIZE;
+	set_huge_pte_at(mm, addr, ptep, pte_wrprotect(old_pte), sz);
 }
 
 #define __HAVE_ARCH_HUGE_PTEP_SET_ACCESS_FLAGS
@@ -42,7 +46,8 @@ static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 {
 	int changed = !pte_same(*ptep, pte);
 	if (changed) {
-		set_huge_pte_at(vma->vm_mm, addr, ptep, pte);
+		set_huge_pte_at(vma->vm_mm, addr, ptep, pte,
+				huge_page_size(hstate_vma(vma)));
 		flush_tlb_page(vma, addr);
 	}
 	return changed;
diff --git a/arch/sparc/mm/hugetlbpage.c b/arch/sparc/mm/hugetlbpage.c
index 0c9711aad5aa7..2cba38be6d20f 100644
--- a/arch/sparc/mm/hugetlbpage.c
+++ b/arch/sparc/mm/hugetlbpage.c
@@ -349,7 +349,7 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
 }
 
 void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
-		     pte_t *ptep, pte_t entry)
+		     pte_t *ptep, pte_t entry, unsigned long sz)
 {
 	unsigned int nptes, orig_shift, shift;
 	unsigned long i, size;
@@ -385,7 +385,7 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 }
 
 pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
-			      pte_t *ptep)
+			      pte_t *ptep, unsigned long sz)
 {
 	unsigned int i, nptes, orig_shift, shift;
 	unsigned long size;
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 3faad73c74ab2..0923c04287709 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -405,7 +405,7 @@ static bool hugetlb_vma_maps_page(struct vm_area_struct *vma,
 	if (!ptep)
 		return false;
 
-	pte = huge_ptep_get(ptep);
+	pte = huge_ptep_get(vma->vm_mm, addr, ptep);
 	if (huge_pte_none(pte) || !pte_present(pte))
 		return false;
 
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 484886cdd272c..f09569ec830b3 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1574,7 +1574,7 @@ static int pagemap_hugetlb_range(pte_t *ptep, unsigned long hmask,
 	if (vma->vm_flags & VM_SOFTDIRTY)
 		flags |= PM_SOFT_DIRTY;
 
-	pte = huge_ptep_get(ptep);
+	pte = huge_ptep_get(walk->mm, addr, ptep);
 	if (pte_present(pte)) {
 		struct page *page = pte_page(pte);
 
@@ -1898,7 +1898,7 @@ static int gather_pte_stats(pmd_t *pmd, unsigned long addr,
 static int gather_hugetlb_stats(pte_t *pte, unsigned long hmask,
 		unsigned long addr, unsigned long end, struct mm_walk *walk)
 {
-	pte_t huge_pte = huge_ptep_get(pte);
+	pte_t huge_pte = huge_ptep_get(walk->mm, addr, pte);
 	struct numa_maps *md;
 	struct page *page;
 
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 6ebee2b3a5a83..577825b963b17 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -264,7 +264,7 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
 		goto out;
 
 	ret = false;
-	pte = huge_ptep_get(ptep);
+	pte = huge_ptep_get(mm, address, ptep);
 
 	/*
 	 * Lockless access: we're in a wait_event so it's ok if it
diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
index a57d667addd2e..72a19b9244027 100644
--- a/include/asm-generic/hugetlb.h
+++ b/include/asm-generic/hugetlb.h
@@ -69,7 +69,7 @@ static inline void hugetlb_free_pgd_range(struct mmu_gather *tlb,
 
 #ifndef __HAVE_ARCH_HUGE_SET_HUGE_PTE_AT
 static inline void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
-		pte_t *ptep, pte_t pte)
+		pte_t *ptep, pte_t pte, unsigned long sz)
 {
 	set_pte_at(mm, addr, ptep, pte);
 }
@@ -77,7 +77,7 @@ static inline void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 
 #ifndef __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
 static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
-		unsigned long addr, pte_t *ptep)
+		unsigned long addr, pte_t *ptep, unsigned long sz)
 {
 	return ptep_get_and_clear(mm, addr, ptep);
 }
@@ -144,7 +144,7 @@ static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 #endif
 
 #ifndef __HAVE_ARCH_HUGE_PTEP_GET
-static inline pte_t huge_ptep_get(pte_t *ptep)
+static inline pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
 	return ptep_get(ptep);
 }
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 6b78a0f457d95..264864495dc2a 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -1011,7 +1011,9 @@ static inline void hugetlb_count_sub(long l, struct mm_struct *mm)
 static inline pte_t huge_ptep_modify_prot_start(struct vm_area_struct *vma,
 						unsigned long addr, pte_t *ptep)
 {
-	return huge_ptep_get_and_clear(vma->vm_mm, addr, ptep);
+	unsigned long psize = huge_page_size(hstate_vma(vma));
+
+	return huge_ptep_get_and_clear(vma->vm_mm, addr, ptep, psize);
 }
 #endif
 
@@ -1021,7 +1023,9 @@ static inline void huge_ptep_modify_prot_commit(struct vm_area_struct *vma,
 						unsigned long addr, pte_t *ptep,
 						pte_t old_pte, pte_t pte)
 {
-	set_huge_pte_at(vma->vm_mm, addr, ptep, pte);
+	unsigned long psize = huge_page_size(hstate_vma(vma));
+
+	set_huge_pte_at(vma->vm_mm, addr, ptep, pte, psize);
 }
 #endif
 
@@ -1206,7 +1210,7 @@ static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 }
 
 static inline void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
-				   pte_t *ptep, pte_t pte)
+				   pte_t *ptep, pte_t pte, unsigned long sz)
 {
 }
 
diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index d6c06e1402771..d15d5852783ae 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -732,6 +732,8 @@ static inline void mmu_notifier_subscriptions_destroy(struct mm_struct *mm)
 {
 }
 
+#define mmu_notifier_clear_young mmu_notifier_clear_flush_young
+
 #define mmu_notifier_range_update_to_read_only(r) false
 
 #define ptep_clear_flush_young_notify ptep_clear_flush_young
diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index 7de89a03b72e7..865935a8833be 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -347,8 +347,10 @@ extern void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
 extern void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
 					unsigned long address);
 #ifdef CONFIG_HUGETLB_PAGE
-extern void __migration_entry_wait_huge(pte_t *ptep, spinlock_t *ptl);
-extern void migration_entry_wait_huge(struct vm_area_struct *vma, pte_t *pte);
+extern void __migration_entry_wait_huge(struct mm_struct *mm, unsigned long addr,
+					pte_t *ptep, spinlock_t *ptl);
+extern void migration_entry_wait_huge(struct vm_area_struct *vma,
+				      unsigned long addr, pte_t *pte);
 #endif	/* CONFIG_HUGETLB_PAGE */
 #else  /* CONFIG_MIGRATION */
 static inline swp_entry_t make_readable_migration_entry(pgoff_t offset)
@@ -376,8 +378,10 @@ static inline void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
 static inline void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
 					 unsigned long address) { }
 #ifdef CONFIG_HUGETLB_PAGE
-static inline void __migration_entry_wait_huge(pte_t *ptep, spinlock_t *ptl) { }
-static inline void migration_entry_wait_huge(struct vm_area_struct *vma, pte_t *pte) { }
+static inline void __migration_entry_wait_huge(struct mm_struct *mm, unsigned long addr,
+					pte_t *ptep, spinlock_t *ptl) { }
+static inline void migration_entry_wait_huge(struct vm_area_struct *vma,
+				      unsigned long addr, pte_t *pte) { }
 #endif	/* CONFIG_HUGETLB_PAGE */
 static inline int is_writable_migration_entry(swp_entry_t entry)
 {
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 4aa89347d754d..59d3a634aa412 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -336,28 +336,27 @@ static void damon_hugetlb_mkold(pte_t *pte, struct mm_struct *mm,
 				struct vm_area_struct *vma, unsigned long addr)
 {
 	bool referenced = false;
-	pte_t entry = huge_ptep_get(pte);
-	struct page *page = pte_page(entry);
+	pte_t entry = huge_ptep_get(mm, addr, pte);
+	struct folio *folio = pfn_folio(pte_pfn(entry));
+	unsigned long psize = huge_page_size(hstate_vma(vma));
 
-	get_page(page);
+	folio_get(folio);
 
 	if (pte_young(entry)) {
 		referenced = true;
 		entry = pte_mkold(entry);
-		set_huge_pte_at(mm, addr, pte, entry);
+		set_huge_pte_at(mm, addr, pte, entry, psize);
 	}
 
-#ifdef CONFIG_MMU_NOTIFIER
 	if (mmu_notifier_clear_young(mm, addr,
 				     addr + huge_page_size(hstate_vma(vma))))
 		referenced = true;
-#endif /* CONFIG_MMU_NOTIFIER */
 
 	if (referenced)
-		set_page_young(page);
+		folio_set_young(folio);
 
-	set_page_idle(page);
-	put_page(page);
+	folio_set_idle(folio);
+	folio_put(folio);
 }
 
 static int damon_mkold_hugetlb_entry(pte_t *pte, unsigned long hmask,
@@ -369,7 +368,7 @@ static int damon_mkold_hugetlb_entry(pte_t *pte, unsigned long hmask,
 	pte_t entry;
 
 	ptl = huge_pte_lock(h, walk->mm, pte);
-	entry = huge_ptep_get(pte);
+	entry = huge_ptep_get(walk->mm, addr, pte);
 	if (!pte_present(entry))
 		goto out;
 
@@ -492,7 +491,7 @@ static int damon_young_hugetlb_entry(pte_t *pte, unsigned long hmask,
 	pte_t entry;
 
 	ptl = huge_pte_lock(h, walk->mm, pte);
-	entry = huge_ptep_get(pte);
+	entry = huge_ptep_get(walk->mm, addr, pte);
 	if (!pte_present(entry))
 		goto out;
 
diff --git a/mm/gup.c b/mm/gup.c
index 72e01b8311d7c..7f74f1223e8b9 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2662,7 +2662,7 @@ static int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
 	if (pte_end < end)
 		end = pte_end;
 
-	pte = huge_ptep_get(ptep);
+	pte = huge_ptep_get(current->mm, addr, ptep);
 
 	if (!pte_access_permitted(pte, flags & FOLL_WRITE))
 		return 0;
diff --git a/mm/hmm.c b/mm/hmm.c
index 2cb3626fd1034..9737bd676179b 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -484,7 +484,7 @@ static int hmm_vma_walk_hugetlb_entry(pte_t *pte, unsigned long hmask,
 	pte_t entry;
 
 	ptl = huge_pte_lock(hstate_vma(vma), walk->mm, pte);
-	entry = huge_ptep_get(pte);
+	entry = huge_ptep_get(walk->mm, addr, pte);
 
 	i = (start - range->start) >> PAGE_SHIFT;
 	pfn_req_flags = range->hmm_pfns[i];
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index bfcb936084e85..b6aa612355134 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4998,7 +4998,7 @@ static void set_huge_ptep_writable(struct vm_area_struct *vma,
 {
 	pte_t entry;
 
-	entry = huge_pte_mkwrite(huge_pte_mkdirty(huge_ptep_get(ptep)));
+	entry = huge_pte_mkwrite(huge_pte_mkdirty(huge_ptep_get(vma->vm_mm, address, ptep)));
 	if (huge_ptep_set_access_flags(vma, address, ptep, entry, 1))
 		update_mmu_cache(vma, address, ptep);
 }
@@ -5035,7 +5035,8 @@ hugetlb_install_page(struct vm_area_struct *vma, pte_t *ptep, unsigned long addr
 {
 	__SetPageUptodate(new_page);
 	hugepage_add_new_anon_rmap(new_page, vma, addr);
-	set_huge_pte_at(vma->vm_mm, addr, ptep, make_huge_pte(vma, new_page, 1));
+	set_huge_pte_at(vma->vm_mm, addr, ptep, make_huge_pte(vma, new_page, 1),
+			huge_page_size(hstate_vma(vma)));
 	hugetlb_count_add(pages_per_huge_page(hstate_vma(vma)), vma->vm_mm);
 	ClearHPageRestoreReserve(new_page);
 	SetHPageMigratable(new_page);
@@ -5098,7 +5099,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 		dst_ptl = huge_pte_lock(h, dst, dst_pte);
 		src_ptl = huge_pte_lockptr(h, src, src_pte);
 		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
-		entry = huge_ptep_get(src_pte);
+		entry = huge_ptep_get(src, addr, src_pte);
 again:
 		if (huge_pte_none(entry)) {
 			/*
@@ -5112,7 +5113,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 			 * hugetlb_change_protection() leaves it untouched, so
 			 * there is nothing to clear for the child.
 			 */
-			set_huge_pte_at(dst, addr, dst_pte, entry);
+			set_huge_pte_at(dst, addr, dst_pte, entry, sz);
 		} else if (unlikely(is_hugetlb_entry_migration(entry))) {
 			swp_entry_t swp_entry = pte_to_swp_entry(entry);
 			bool uffd_wp = pte_swp_uffd_wp(entry);
@@ -5127,20 +5128,20 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 				entry = swp_entry_to_pte(swp_entry);
 				if (userfaultfd_wp(src_vma) && uffd_wp)
 					entry = pte_swp_mkuffd_wp(entry);
-				set_huge_pte_at(src, addr, src_pte, entry);
+				set_huge_pte_at(src, addr, src_pte, entry, sz);
 			}
 			if (!userfaultfd_wp(dst_vma))
 				entry = pte_swp_clear_uffd_wp(entry);
-			set_huge_pte_at(dst, addr, dst_pte, entry);
+			set_huge_pte_at(dst, addr, dst_pte, entry, sz);
 		} else if (unlikely(is_pte_marker(entry))) {
 			/*
 			 * We copy the pte marker only if the dst vma has
 			 * uffd-wp enabled.
 			 */
 			if (userfaultfd_wp(dst_vma))
-				set_huge_pte_at(dst, addr, dst_pte, entry);
+				set_huge_pte_at(dst, addr, dst_pte, entry, sz);
 		} else {
-			entry = huge_ptep_get(src_pte);
+			entry = huge_ptep_get(src, addr, src_pte);
 			ptepage = pte_page(entry);
 			get_page(ptepage);
 
@@ -5178,7 +5179,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 				dst_ptl = huge_pte_lock(h, dst, dst_pte);
 				src_ptl = huge_pte_lockptr(h, src, src_pte);
 				spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
-				entry = huge_ptep_get(src_pte);
+				entry = huge_ptep_get(src, addr, src_pte);
 				if (!pte_same(src_pte_old, entry)) {
 					restore_reserve_on_error(h, dst_vma, addr,
 								new);
@@ -5204,7 +5205,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 				entry = huge_pte_wrprotect(entry);
 			}
 
-			set_huge_pte_at(dst, addr, dst_pte, entry);
+			set_huge_pte_at(dst, addr, dst_pte, entry, sz);
 			hugetlb_count_add(npages, dst);
 		}
 		spin_unlock(src_ptl);
@@ -5222,7 +5223,8 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 }
 
 static void move_huge_pte(struct vm_area_struct *vma, unsigned long old_addr,
-			  unsigned long new_addr, pte_t *src_pte, pte_t *dst_pte)
+			  unsigned long new_addr, pte_t *src_pte, pte_t *dst_pte,
+			  unsigned long sz)
 {
 	struct hstate *h = hstate_vma(vma);
 	struct mm_struct *mm = vma->vm_mm;
@@ -5239,8 +5241,8 @@ static void move_huge_pte(struct vm_area_struct *vma, unsigned long old_addr,
 	if (src_ptl != dst_ptl)
 		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
 
-	pte = huge_ptep_get_and_clear(mm, old_addr, src_pte);
-	set_huge_pte_at(mm, new_addr, dst_pte, pte);
+	pte = huge_ptep_get_and_clear(mm, old_addr, src_pte, sz);
+	set_huge_pte_at(mm, new_addr, dst_pte, pte, sz);
 
 	if (src_ptl != dst_ptl)
 		spin_unlock(src_ptl);
@@ -5284,7 +5286,7 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
 			new_addr |= last_addr_mask;
 			continue;
 		}
-		if (huge_pte_none(huge_ptep_get(src_pte)))
+		if (huge_pte_none(huge_ptep_get(mm, old_addr, src_pte)))
 			continue;
 
 		if (huge_pmd_unshare(&tlb, vma, old_addr, src_pte)) {
@@ -5297,7 +5299,7 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
 		if (!dst_pte)
 			break;
 
-		move_huge_pte(vma, old_addr, new_addr, src_pte, dst_pte);
+		move_huge_pte(vma, old_addr, new_addr, src_pte, dst_pte, sz);
 		tlb_remove_huge_tlb_entry(h, &tlb, src_pte, old_addr);
 	}
 
@@ -5361,7 +5363,7 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
 			continue;
 		}
 
-		pte = huge_ptep_get(ptep);
+		pte = huge_ptep_get(mm, address, ptep);
 		if (huge_pte_none(pte)) {
 			spin_unlock(ptl);
 			continue;
@@ -5382,7 +5384,7 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
 			if (pte_swp_uffd_wp_any(pte) &&
 			    !(zap_flags & ZAP_FLAG_DROP_MARKER))
 				set_huge_pte_at(mm, address, ptep,
-						make_pte_marker(PTE_MARKER_UFFD_WP));
+						make_pte_marker(PTE_MARKER_UFFD_WP), sz);
 			else
 #endif
 				huge_pte_clear(mm, address, ptep, sz);
@@ -5409,7 +5411,7 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
 			set_vma_resv_flags(vma, HPAGE_RESV_UNMAPPED);
 		}
 
-		pte = huge_ptep_get_and_clear(mm, address, ptep);
+		pte = huge_ptep_get_and_clear(mm, address, ptep, sz);
 		tlb_remove_huge_tlb_entry(h, tlb, ptep, address);
 		if (huge_pte_dirty(pte))
 			set_page_dirty(page);
@@ -5418,7 +5420,7 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
 		if (huge_pte_uffd_wp(pte) &&
 		    !(zap_flags & ZAP_FLAG_DROP_MARKER))
 			set_huge_pte_at(mm, address, ptep,
-					make_pte_marker(PTE_MARKER_UFFD_WP));
+					make_pte_marker(PTE_MARKER_UFFD_WP), sz);
 #endif
 		hugetlb_count_sub(pages_per_huge_page(h), mm);
 		page_remove_rmap(page, vma, true);
@@ -5543,7 +5545,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 		       struct page *pagecache_page, spinlock_t *ptl)
 {
 	const bool unshare = flags & FAULT_FLAG_UNSHARE;
-	pte_t pte = huge_ptep_get(ptep);
+	pte_t pte = huge_ptep_get(mm, address, ptep);
 	struct hstate *h = hstate_vma(vma);
 	struct page *old_page, *new_page;
 	int outside_reserve = 0;
@@ -5658,7 +5660,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 			spin_lock(ptl);
 			ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
 			if (likely(ptep &&
-				   pte_same(huge_ptep_get(ptep), pte)))
+				   pte_same(huge_ptep_get(mm, address, ptep), pte)))
 				goto retry_avoidcopy;
 			/*
 			 * race occurs while re-acquiring page table
@@ -5695,7 +5697,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 	 */
 	spin_lock(ptl);
 	ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
-	if (likely(ptep && pte_same(huge_ptep_get(ptep), pte))) {
+	if (likely(ptep && pte_same(huge_ptep_get(mm, address, ptep), pte))) {
 		ClearHPageRestoreReserve(new_page);
 
 		/* Break COW or unshare */
@@ -5704,7 +5706,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 		page_remove_rmap(old_page, vma, true);
 		hugepage_add_new_anon_rmap(new_page, vma, haddr);
 		set_huge_pte_at(mm, haddr, ptep,
-				make_huge_pte(vma, new_page, !unshare));
+				make_huge_pte(vma, new_page, !unshare), huge_page_size(h));
 		SetHPageMigratable(new_page);
 		/* Make the old page be freed below */
 		new_page = old_page;
@@ -5816,14 +5818,14 @@ static inline vm_fault_t hugetlb_handle_userfault(struct vm_area_struct *vma,
  * Recheck pte with pgtable lock.  Returns true if pte didn't change, or
  * false if pte changed or is changing.
  */
-static bool hugetlb_pte_stable(struct hstate *h, struct mm_struct *mm,
+static bool hugetlb_pte_stable(struct hstate *h, struct mm_struct *mm, unsigned long addr,
 			       pte_t *ptep, pte_t old_pte)
 {
 	spinlock_t *ptl;
 	bool same;
 
 	ptl = huge_pte_lock(h, mm, ptep);
-	same = pte_same(huge_ptep_get(ptep), old_pte);
+	same = pte_same(huge_ptep_get(mm, addr, ptep), old_pte);
 	spin_unlock(ptl);
 
 	return same;
@@ -5887,7 +5889,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 			 * never happen on the page after UFFDIO_COPY has
 			 * correctly installed the page and returned.
 			 */
-			if (!hugetlb_pte_stable(h, mm, ptep, old_pte)) {
+			if (!hugetlb_pte_stable(h, mm, haddr, ptep, old_pte)) {
 				ret = 0;
 				goto out;
 			}
@@ -5911,7 +5913,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 			 * here.  Before returning error, get ptl and make
 			 * sure there really is no pte entry.
 			 */
-			if (hugetlb_pte_stable(h, mm, ptep, old_pte))
+			if (hugetlb_pte_stable(h, mm, haddr, ptep, old_pte))
 				ret = vmf_error(PTR_ERR(page));
 			else
 				ret = 0;
@@ -5961,7 +5963,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 			unlock_page(page);
 			put_page(page);
 			/* See comment in userfaultfd_missing() block above */
-			if (!hugetlb_pte_stable(h, mm, ptep, old_pte)) {
+			if (!hugetlb_pte_stable(h, mm, haddr, ptep, old_pte)) {
 				ret = 0;
 				goto out;
 			}
@@ -5989,7 +5991,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	ptl = huge_pte_lock(h, mm, ptep);
 	ret = 0;
 	/* If pte changed from under us, retry */
-	if (!pte_same(huge_ptep_get(ptep), old_pte))
+	if (!pte_same(huge_ptep_get(mm, haddr, ptep), old_pte))
 		goto backout;
 
 	if (anon_rmap) {
@@ -6005,7 +6007,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	 */
 	if (unlikely(pte_marker_uffd_wp(old_pte)))
 		new_pte = huge_pte_wrprotect(huge_pte_mkuffd_wp(new_pte));
-	set_huge_pte_at(mm, haddr, ptep, new_pte);
+	set_huge_pte_at(mm, haddr, ptep, new_pte, huge_page_size(h));
 
 	hugetlb_count_add(pages_per_huge_page(h), mm);
 	if ((flags & FAULT_FLAG_WRITE) && !(vma->vm_flags & VM_SHARED)) {
@@ -6086,9 +6088,9 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		 * OK as we are only making decisions based on content and
 		 * not actually modifying content here.
 		 */
-		entry = huge_ptep_get(ptep);
+		entry = huge_ptep_get(mm, haddr, ptep);
 		if (unlikely(is_hugetlb_entry_migration(entry))) {
-			migration_entry_wait_huge(vma, ptep);
+			migration_entry_wait_huge(vma, haddr, ptep);
 			return 0;
 		} else if (unlikely(is_hugetlb_entry_hwpoisoned(entry)))
 			return VM_FAULT_HWPOISON_LARGE |
@@ -6122,7 +6124,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		return VM_FAULT_OOM;
 	}
 
-	entry = huge_ptep_get(ptep);
+	entry = huge_ptep_get(mm, haddr, ptep);
 	/* PTE markers should be handled the same way as none pte */
 	if (huge_pte_none_mostly(entry))
 		/*
@@ -6166,11 +6168,11 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	ptl = huge_pte_lock(h, mm, ptep);
 
 	/* Check for a racing update before calling hugetlb_wp() */
-	if (unlikely(!pte_same(entry, huge_ptep_get(ptep))))
+	if (unlikely(!pte_same(entry, huge_ptep_get(mm, haddr, ptep))))
 		goto out_ptl;
 
 	/* Handle userfault-wp first, before trying to lock more pages */
-	if (userfaultfd_wp(vma) && huge_pte_uffd_wp(huge_ptep_get(ptep)) &&
+	if (userfaultfd_wp(vma) && huge_pte_uffd_wp(huge_ptep_get(mm, haddr, ptep)) &&
 	    (flags & FAULT_FLAG_WRITE) && !huge_pte_write(entry)) {
 		struct vm_fault vmf = {
 			.vma = vma,
@@ -6379,7 +6381,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	 * page backing it, then access the page.
 	 */
 	ret = -EEXIST;
-	if (!huge_pte_none_mostly(huge_ptep_get(dst_pte)))
+	if (!huge_pte_none_mostly(huge_ptep_get(dst_mm, dst_addr, dst_pte)))
 		goto out_release_unlock;
 
 	if (page_in_pagecache) {
@@ -6411,7 +6413,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	if (wp_copy)
 		_dst_pte = huge_pte_mkuffd_wp(_dst_pte);
 
-	set_huge_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
+	set_huge_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte, huge_page_size(h));
 
 	hugetlb_count_add(pages_per_huge_page(h), dst_mm);
 
@@ -6452,10 +6454,10 @@ static void record_subpages_vmas(struct page *page, struct vm_area_struct *vma,
 	}
 }
 
-static inline bool __follow_hugetlb_must_fault(unsigned int flags, pte_t *pte,
-					       bool *unshare)
+static inline bool __follow_hugetlb_must_fault(struct mm_struct *mm,
+		unsigned long addr, unsigned int flags, pte_t *pte, bool *unshare)
 {
-	pte_t pteval = huge_ptep_get(pte);
+	pte_t pteval = huge_ptep_get(mm, addr, pte);
 
 	*unshare = false;
 	if (is_swap_pte(pteval))
@@ -6509,7 +6511,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 				      huge_page_size(h));
 		if (pte)
 			ptl = huge_pte_lock(h, mm, pte);
-		absent = !pte || huge_pte_none(huge_ptep_get(pte));
+		absent = !pte || huge_pte_none(huge_ptep_get(mm, vaddr, pte));
 
 		/*
 		 * When coredumping, it suits get_dump_page if we just return
@@ -6537,7 +6539,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 		 * directly from any kind of swap entries.
 		 */
 		if (absent ||
-		    __follow_hugetlb_must_fault(flags, pte, &unshare)) {
+		    __follow_hugetlb_must_fault(mm, vaddr, flags, pte, &unshare)) {
 			vm_fault_t ret;
 			unsigned int fault_flags = 0;
 
@@ -6586,7 +6588,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 		}
 
 		pfn_offset = (vaddr & ~huge_page_mask(h)) >> PAGE_SHIFT;
-		page = pte_page(huge_ptep_get(pte));
+		page = pte_page(huge_ptep_get(mm, vaddr, pte));
 
 		VM_BUG_ON_PAGE((flags & FOLL_PIN) && PageAnon(page) &&
 			       !PageAnonExclusive(page), page);
@@ -6714,7 +6716,7 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
 			address |= last_addr_mask;
 			continue;
 		}
-		pte = huge_ptep_get(ptep);
+		pte = huge_ptep_get(mm, address, ptep);
 		if (unlikely(is_hugetlb_entry_hwpoisoned(pte))) {
 			/* Nothing to do. */
 		} else if (unlikely(is_hugetlb_entry_migration(pte))) {
@@ -6738,7 +6740,7 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
 			else if (uffd_wp_resolve)
 				newpte = pte_swp_clear_uffd_wp(newpte);
 			if (!pte_same(pte, newpte))
-				set_huge_pte_at(mm, address, ptep, newpte);
+				set_huge_pte_at(mm, address, ptep, newpte, psize);
 		} else if (unlikely(is_pte_marker(pte))) {
 			/* No other markers apply for now. */
 			WARN_ON_ONCE(!pte_marker_uffd_wp(pte));
@@ -6764,7 +6766,8 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
 			if (unlikely(uffd_wp))
 				/* Safe to modify directly (none->non-present). */
 				set_huge_pte_at(mm, address, ptep,
-						make_pte_marker(PTE_MARKER_UFFD_WP));
+						make_pte_marker(PTE_MARKER_UFFD_WP),
+						psize);
 		}
 		spin_unlock(ptl);
 
@@ -7368,7 +7371,7 @@ follow_huge_pmd_pte(struct vm_area_struct *vma, unsigned long address, int flags
 		return NULL;
 
 	ptl = huge_pte_lock(h, mm, ptep);
-	pte = huge_ptep_get(ptep);
+	pte = huge_ptep_get(mm, address, ptep);
 	if (pte_present(pte)) {
 		page = pte_page(pte) +
 			((address & ~huge_page_mask(h)) >> PAGE_SHIFT);
@@ -7387,7 +7390,7 @@ follow_huge_pmd_pte(struct vm_area_struct *vma, unsigned long address, int flags
 	} else {
 		if (is_hugetlb_entry_migration(pte)) {
 			spin_unlock(ptl);
-			__migration_entry_wait_huge(ptep, ptl);
+			__migration_entry_wait_huge(mm, address, ptep, ptl);
 			goto retry;
 		}
 		/*
@@ -7415,7 +7418,7 @@ follow_huge_pud(struct mm_struct *mm, unsigned long address,
 	ptl = huge_pte_lock(hstate_sizelog(PUD_SHIFT), mm, (pte_t *)pud);
 	if (!pud_huge(*pud))
 		goto out;
-	pte = huge_ptep_get((pte_t *)pud);
+	pte = huge_ptep_get(mm, address, (pte_t *)pud);
 	if (pte_present(pte)) {
 		page = pud_page(*pud) + ((address & ~PUD_MASK) >> PAGE_SHIFT);
 		if (WARN_ON_ONCE(!try_grab_page(page, flags))) {
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 776a37ae4eb69..5314c8e52f703 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -721,7 +721,7 @@ static int hwpoison_hugetlb_range(pte_t *ptep, unsigned long hmask,
 			    struct mm_walk *walk)
 {
 	struct hwp_walk *hwp = walk->private;
-	pte_t pte = huge_ptep_get(ptep);
+	pte_t pte = huge_ptep_get(walk->mm, addr, ptep);
 	struct hstate *h = hstate_vma(walk->vma);
 
 	return check_hwpoisoned_entry(pte, addr, huge_page_shift(h),
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 518adfe4ad85b..ec0c0667fa9b5 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -567,7 +567,7 @@ static int queue_pages_hugetlb(pte_t *pte, unsigned long hmask,
 	pte_t entry;
 
 	ptl = huge_pte_lock(hstate_vma(walk->vma), walk->mm, pte);
-	entry = huge_ptep_get(pte);
+	entry = huge_ptep_get(walk->mm, addr, pte);
 	if (!pte_present(entry))
 		goto unlock;
 	page = pte_page(entry);
diff --git a/mm/migrate.c b/mm/migrate.c
index 161ab6e2713d2..bac8c364e392f 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -237,7 +237,9 @@ static bool remove_migration_pte(struct folio *folio,
 
 #ifdef CONFIG_HUGETLB_PAGE
 		if (folio_test_hugetlb(folio)) {
-			unsigned int shift = huge_page_shift(hstate_vma(vma));
+			struct hstate *h = hstate_vma(vma);
+			unsigned int shift = huge_page_shift(h);
+			unsigned long psize = huge_page_size(h);
 
 			pte = pte_mkhuge(pte);
 			pte = arch_make_huge_pte(pte, shift, vma->vm_flags);
@@ -246,7 +248,8 @@ static bool remove_migration_pte(struct folio *folio,
 						       rmap_flags);
 			else
 				page_dup_file_rmap(new, true);
-			set_huge_pte_at(vma->vm_mm, pvmw.address, pvmw.pte, pte);
+			set_huge_pte_at(vma->vm_mm, pvmw.address, pvmw.pte, pte,
+					psize);
 		} else
 #endif
 		{
@@ -322,12 +325,13 @@ void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
 }
 
 #ifdef CONFIG_HUGETLB_PAGE
-void __migration_entry_wait_huge(pte_t *ptep, spinlock_t *ptl)
+void __migration_entry_wait_huge(struct mm_struct *mm, unsigned long addr,
+					pte_t *ptep, spinlock_t *ptl)
 {
 	pte_t pte;
 
 	spin_lock(ptl);
-	pte = huge_ptep_get(ptep);
+	pte = huge_ptep_get(mm, addr, ptep);
 
 	if (unlikely(!is_hugetlb_entry_migration(pte)))
 		spin_unlock(ptl);
@@ -335,11 +339,12 @@ void __migration_entry_wait_huge(pte_t *ptep, spinlock_t *ptl)
 		migration_entry_wait_on_locked(pte_to_swp_entry(pte), NULL, ptl);
 }
 
-void migration_entry_wait_huge(struct vm_area_struct *vma, pte_t *pte)
+void migration_entry_wait_huge(struct vm_area_struct *vma,
+				      unsigned long addr, pte_t *pte)
 {
 	spinlock_t *ptl = huge_pte_lockptr(hstate_vma(vma), vma->vm_mm, pte);
 
-	__migration_entry_wait_huge(pte, ptl);
+	__migration_entry_wait_huge(vma->vm_mm, addr, pte, ptl);
 }
 #endif
 
diff --git a/mm/mincore.c b/mm/mincore.c
index 47e89cf37062e..f726b01fbc9a0 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -33,7 +33,7 @@ static int mincore_hugetlb(pte_t *pte, unsigned long hmask, unsigned long addr,
 	 * Hugepages under user process are always in RAM and never
 	 * swapped out, but theoretically it needs to be checked.
 	 */
-	present = pte && !huge_pte_none_mostly(huge_ptep_get(pte));
+	present = pte && !huge_pte_none_mostly(huge_ptep_get(walk->mm, addr, pte));
 	for (; addr != end; vec++, addr += PAGE_SIZE)
 		*vec = present;
 	walk->private = vec;
diff --git a/mm/rmap.c b/mm/rmap.c
index 886000da89a6f..b696d41e5d7d0 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1477,6 +1477,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 	bool anon_exclusive, ret = true;
 	struct mmu_notifier_range range;
 	enum ttu_flags flags = (enum ttu_flags)(long)arg;
+	unsigned long hsz = 0;
 
 	/*
 	 * When racing against e.g. zap_pte_range() on another cpu,
@@ -1508,6 +1509,9 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 		 */
 		adjust_range_if_pmd_sharing_possible(vma, &range.start,
 						     &range.end);
+
+		/* We need the huge page size for set_huge_pte_at() */
+		hsz = huge_page_size(hstate_vma(vma));
 	}
 	mmu_notifier_invalidate_range_start(&range);
 
@@ -1626,7 +1630,8 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			pteval = swp_entry_to_pte(make_hwpoison_entry(subpage));
 			if (folio_test_hugetlb(folio)) {
 				hugetlb_count_sub(folio_nr_pages(folio), mm);
-				set_huge_pte_at(mm, address, pvmw.pte, pteval);
+				set_huge_pte_at(mm, address, pvmw.pte, pteval,
+						hsz);
 			} else {
 				dec_mm_counter(mm, mm_counter(&folio->page));
 				set_pte_at(mm, address, pvmw.pte, pteval);
@@ -1847,6 +1852,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 	bool anon_exclusive, ret = true;
 	struct mmu_notifier_range range;
 	enum ttu_flags flags = (enum ttu_flags)(long)arg;
+	unsigned long hsz = 0;
 
 	/*
 	 * When racing against e.g. zap_pte_range() on another cpu,
@@ -1882,6 +1888,9 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 		 */
 		adjust_range_if_pmd_sharing_possible(vma, &range.start,
 						     &range.end);
+
+		/* We need the huge page size for set_huge_pte_at() */
+		hsz = huge_page_size(hstate_vma(vma));
 	}
 	mmu_notifier_invalidate_range_start(&range);
 
@@ -2032,7 +2041,8 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 			pteval = swp_entry_to_pte(make_hwpoison_entry(subpage));
 			if (folio_test_hugetlb(folio)) {
 				hugetlb_count_sub(folio_nr_pages(folio), mm);
-				set_huge_pte_at(mm, address, pvmw.pte, pteval);
+				set_huge_pte_at(mm, address, pvmw.pte, pteval,
+						hsz);
 			} else {
 				dec_mm_counter(mm, mm_counter(&folio->page));
 				set_pte_at(mm, address, pvmw.pte, pteval);
@@ -2059,7 +2069,8 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 
 			if (arch_unmap_one(mm, vma, address, pteval) < 0) {
 				if (folio_test_hugetlb(folio))
-					set_huge_pte_at(mm, address, pvmw.pte, pteval);
+					set_huge_pte_at(mm, address, pvmw.pte,
+							pteval, hsz);
 				else
 					set_pte_at(mm, address, pvmw.pte, pteval);
 				ret = false;
@@ -2073,7 +2084,8 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 			if (anon_exclusive &&
 			    page_try_share_anon_rmap(subpage)) {
 				if (folio_test_hugetlb(folio))
-					set_huge_pte_at(mm, address, pvmw.pte, pteval);
+					set_huge_pte_at(mm, address, pvmw.pte,
+							pteval, hsz);
 				else
 					set_pte_at(mm, address, pvmw.pte, pteval);
 				ret = false;
@@ -2105,7 +2117,8 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 			if (pte_uffd_wp(pteval))
 				swp_pte = pte_swp_mkuffd_wp(swp_pte);
 			if (folio_test_hugetlb(folio))
-				set_huge_pte_at(mm, address, pvmw.pte, swp_pte);
+				set_huge_pte_at(mm, address, pvmw.pte, swp_pte,
+						hsz);
 			else
 				set_pte_at(mm, address, pvmw.pte, swp_pte);
 			trace_set_migration_pte(address, pte_val(swp_pte),
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 992a0a16846f7..1d5133c30e358 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -417,7 +417,7 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 		}
 
 		if (mode != MCOPY_ATOMIC_CONTINUE &&
-		    !huge_pte_none_mostly(huge_ptep_get(dst_pte))) {
+		    !huge_pte_none_mostly(huge_ptep_get(dst_mm, dst_addr, dst_pte))) {
 			err = -EEXIST;
 			hugetlb_vma_unlock_read(dst_vma);
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 6c8a9b748db17..47c41a3b308fa 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -119,7 +119,7 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 			pte_t entry = pfn_pte(pfn, prot);
 
 			entry = arch_make_huge_pte(entry, ilog2(size), 0);
-			set_huge_pte_at(&init_mm, addr, pte, entry);
+			set_huge_pte_at(&init_mm, addr, pte, entry, size);
 			pfn += PFN_DOWN(size);
 			continue;
 		}
-- 
2.53.0

