Received: from va-1-112.ptr.blmpb.com (va-1-112.ptr.blmpb.com [209.127.230.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A133AFCED
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 09:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791884210; cv=none; b=jtRQKoEpY9qRD8Qs8yr9pjnAW83ZlVHKYtLXj4Sc926eaKBrMiHChpqGNg9FhMZ0gJbNG3Bdo/PJaxwE+c++7derRSsy9sG3wkWcHFSj9zvSD4jCRhOMNXzPdk25XTdtC7a6v9V2AFU9xkh6AtwZdVSweRpsEgNi8GvsB8H31Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791884210; c=relaxed/simple;
	bh=KUkefJ5DSPePM5TbVf/Sx5ia3+ZnO/Cc4dPsCvg8ELw=;
	h=Cc:Message-Id:To:Content-Type:From:Subject:Mime-Version:Date; b=cL8vL/QGRrQBmbsDBuhQsCc3Ntt0hAzesssvBsVPV4wJ094siNNwqN5JfDt2Axru3kc2kEsc+8OT7Vr6Nvwi6E5RJRCcjtnWHAy74Gp705UpBnlp25EUDZNH2uSA5AzVdD+LzSaZvMIpRkcfFPIfBlkYnLPtkzyScJH7pXKBBUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=XGRBS94T; arc=none smtp.client-ip=209.127.230.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="XGRBS94T"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1791884197; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=q5NdZNxCSRtyhz8oP1rgzjW01hgyzNkTJZX8N4nqPNQ=;
 b=XGRBS94TmY46Hn603/DnhhmEXgyVPkvX4tC7bAOVK9VOHNksNJjY34o3k7rj06OdY58LaI
 tfwn7rEANPOr0XPQ/CkSC8xfz+kfv+8HyIPAlPfQrFKQfrCQFmX6U7wEaQHQqAam60vbqK
 85RXMuE16+5NcSj+z+ca7AAv6OHihzUp54zrsEw9Qaoux8Z+JLqu3GhLxGAxiJ6QvuuWUW
 DzIOvkPjh4p1OhjySjQaBTY8LdXX2C+Gf6UU6lH6aRNlOpRMUIZclk/OdqO7mo5dUyiQ4s
 5zezrjIrIyhDuK0zDCZla4+Iupv2nqD2X2BGzSjqIhkAv3M3sdxke99bRU3Zaw==
Cc: <ryan.roberts@arm.com>, <dev.jain@arm.com>, 
	<baolin.wang@linux.alibaba.com>, <lance.yang@linux.dev>, 
	<mark.rutland@arm.com>, <akpm@linux-foundation.org>, <david@kernel.org>, 
	<ljs@kernel.org>, <liam@infradead.org>, <vbabka@kernel.org>, 
	<rppt@kernel.org>, <surenb@google.com>, <mhocko@suse.com>, 
	<linux-arm-kernel@lists.infradead.org>, <linux-mm@kvack.org>, 
	<linux-kernel@vger.kernel.org>, "Zhao Gongyi" <zhaogongyi@bytedance.com>, 
	<stable@vger.kernel.org>
Message-Id: <20261013093600.54995-1-zhaogongyi@bytedance.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>
X-Lms-Return-Path: <lba+26acdfba0+a7bde7+vger.kernel.org+zhaogongyi@bytedance.com>
Content-Type: text/plain; charset=UTF-8
From: "Zhao Gongyi" <zhaogongyi@bytedance.com>
Subject: [PATCH] arm64/mm: restrict transparent contpte mappings to valid PTEs
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Zhao Gongyi <zhaogongyi@bytedance.com>
Date: Tue, 13 Oct 2026 17:36:00 +0800
Content-Transfer-Encoding: 7bit
X-Mailer: git-send-email 2.39.5 (Apple Git-154)

The transparent contpte layer treats PTE_CONT as software state: when a
PTE has PTE_CONT set, the contpte helpers may align the operation to a
CONT_PTE_SIZE block and operate on the whole block. That invariant only
makes sense for valid mappings. Explicit users such as hugetlb manage
their contiguous encodings separately.

contpte_set_ptes() currently sets PTE_CONT from alignment alone. Batched
set_ptes() users can therefore install present-invalid PTEs with
PTE_CONT set, for example mprotect(PROT_NONE), NUMA hinting through
modify_prot_commit_ptes(), fork() copying a PROT_NONE large folio, or a
PMD split installing PAGE_NONE PTEs.

This is not a hardware programming problem: invalid descriptors are not
translated, so the hardware ignores descriptor bits such as PTE_CONT. It
is a software-state problem. Some arm64 fast paths intentionally test
pte_cont() directly instead of pte_valid_cont(), for example commit
9970a9a27ffc ("arm64: mm: implement the architecture-specific
test_and_clear_young_ptes()"). Fixing the producer side preserves these
fast paths and covers all consumers.

In the observed failure, mprotect(PROT_NONE) installed a full
CONT_PTE_SIZE range of present-invalid PTEs with PTE_CONT set.
MADV_GUARD_INSTALL then zapped one PTE. The nr == 1 clear_full_ptes()
path only unfolds pte_valid_cont() entries, so the neighbouring
present-invalid entries kept PTE_CONT while the target entry became a
guard marker.

clear_refs_pte_range() then reached the marker through:

  ptep_test_and_clear_young()
  test_and_clear_young_ptes()
  contpte_test_and_clear_young_ptes()
  contpte_align_addr_ptep()
  __ptep_test_and_clear_young()

The marker changed from old_pte=0x00000000000047c0 to
new_pte=0x00000000000043c0 by clearing PTE_AF. For swap PTEs, bit 10 is
part of the swap type field, bits 6-10: 0x47c0 is SWP_PTE_MARKER with
offset 4, while 0x43c0 has type 15 and is decoded as an ordinary swap
entry. Zap later warned in swap_put_entries_direct() with a bad swap
entry.

This is triggerable by a user process against its own address space. On
systems running with panic_on_warn, the warning becomes a denial of
service.

Fix the root cause by making contpte_set_ptes() use the transparent
contpte encoding only for valid descriptors. After this change, the
transparent contpte layer preserves the invariant that pte_cont(pte)
implies pte_valid(pte), so fast consumers can keep using PTE_CONT as
sufficient evidence of a transparent contpte block.

Fixes: 4602e5757bcc ("arm64/mm: wire up PTE_CONT for user mappings")
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Gongyi <zhaogongyi@bytedance.com>
---
Validation on an arm64 QEMU/KVM KASAN setup with CONFIG_ARM64_4K_PAGES=y
and CONFIG_ARM64_CONTPTE=y, using an out-of-tree guard-region reproducer:

  populate a CONT_PTE_SIZE anonymous THP range
  mprotect(PROT_NONE) on the range
  MADV_GUARD_INSTALL on one PTE in that range
  write "1" to /proc/self/clear_refs
  restore access and remove the guard marker

  Unfixed kernel: failed in the first iteration, with 65 bad swap
                  messages and a WARNING in swap_put_entries_direct()
  This patch:     completed 100 iterations without warnings

Additional producer-side instrumentation confirmed the same invalid
batch state outside the mprotect reproducer:

  Unfixed fork():     copy_page_range() wrote out_cont=1
  Unfixed PMD split: split_huge_pmd_locked() wrote out_cont=1
  This patch:        both paths wrote out_cont=0

 arch/arm64/include/asm/pgtable.h | 5 ++++-
 arch/arm64/mm/contpte.c          | 7 +++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 6000905a2..d6246042b 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1650,7 +1650,10 @@ extern void modify_prot_commit_ptes(struct vm_area_struct *vma, unsigned long ad
 /*
  * The contpte APIs are used to transparently manage the contiguous bit in ptes
  * where it is possible and makes sense to do so. The PTE_CONT bit is considered
- * a private implementation detail of the public ptep API (see below).
+ * a private implementation detail of the public ptep API (see below). The
+ * transparent contpte layer maintains the invariant that pte_cont(pte) implies
+ * pte_valid(pte); explicit contiguous-encoding users such as hugetlb manage
+ * their entries separately.
  */
 extern void __contpte_try_fold(struct mm_struct *mm, unsigned long addr,
 				pte_t *ptep, pte_t pte);
diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
index 0acab179f..851fa2e44 100644
--- a/arch/arm64/mm/contpte.c
+++ b/arch/arm64/mm/contpte.c
@@ -463,6 +463,13 @@ void contpte_set_ptes(struct mm_struct *mm, unsigned long addr,
 	if (!mm_is_user(mm))
 		return __set_ptes(mm, addr, ptep, pte, nr);
 
+	/*
+	 * Keep the producer-side invariant documented in pgtable.h true even
+	 * if a direct caller passes an invalid descriptor with PTE_CONT set.
+	 */
+	if (!pte_valid(pte))
+		return __set_ptes(mm, addr, ptep, pte_mknoncont(pte), nr);
+
 	end = addr + (nr << PAGE_SHIFT);
 	pfn = pte_pfn(pte);
 	prot = pte_pgprot(pte);
-- 
2.39.5 (Apple Git-154)
