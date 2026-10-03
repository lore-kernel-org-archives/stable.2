Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47329425866;
	Sat,  3 Oct 2026 12:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791032215; cv=none; b=jpJy/4jW/wvzGf4S0T9giM3n0cUNZYrQhYJYCElI4wlzIOW7Kr6m+0bU3ENsbZGOCk7JO2vq0q8Z6LC/GEVgNAGijxAVBWUFPesDtFTPj0x/tX9xofCToRuWrVNxm1NfRFZ0GDxq6cAYVH7Xn0IKRUasYYOXmAu7xzrYX5jhm5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791032215; c=relaxed/simple;
	bh=WvqRQFA28jj1Nht/DOLWFrchZGB72gV3Zj2MhSehcJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pOF4O7uuo5L0LG1LKHT9fVDJsiupqlRGpHBeTcYMsu0ZLdAQZ4sd4+5+8zrAqMFDe1JRS0QqlfDC8jxgeAlmL/Qbm26A9bkJU3L9FC2KLDdSEpbsk81h/Wb2dmDvNw5GDlLsWhtxbgGyaT9ZuLB+2FTSST0Uy6kfyDBE7khO7uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=Dz87iVK0; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="Dz87iVK0"
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1791032205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mlXsUitQV5nWii1z+gqCuN8kP23Lakd0VYC3cvnHMZM=;
	b=Dz87iVK0Y/eY0M+4GVqCZYl3P29hPaJxkaQ/HepswMhoflHfmqs7FKXBhZJXFY0dvfTxr2
	pfMbPH5hYrHPJo+tR6/rsRkNPQPTHWoBr4d8b7enFL5ZGOz5m04YbkaY1lZDu2F3pj45HO
	afHO1NvwHL1SnUsVkpdFoI+K5gtzZrk=
To: Andreas Larsson <andreas@gaisler.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stian Halseth <stian@itx.no>,
	stable@vger.kernel.org
Subject: [PATCH 2/3] sparc64: flush the TLB on a spurious write fault
Date: Sat,  3 Oct 2026 14:56:24 +0200
Message-ID: <20261003125627.3419702-3-stian@itx.no>
In-Reply-To: <20261003125627.3419702-1-stian@itx.no>
References: <20261003125627.3419702-1-stian@itx.no>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a write faults although the PTE is already writable, the CPU holds
a stale translation and handle_pte_fault() calls
flush_tlb_fix_spurious_fault() to drop it; the THP path does the same
with the _pmd variant.  The generic definitions are flush_tlb_page() and
a no-op.  flush_tlb_page() is empty on sparc64, where the TLB is flushed
from set_pte_at() instead, so a thread that traps on a stale read-only
TLB entry retries the store against the same entry forever.  Under a
256-thread compile load on a SPARC M7 a thread was caught spinning for
25 minutes on one store.

Define both hooks: flush the TSB entry and demap the page on every CPU
of the mm.  A local demap is not enough, since sparc64 TLB entries are
tagged with the context and survive switch_mm(), so a stale entry on a
CPU the task has migrated away from is still live when it returns.

This predates git; before commit 61c77326d1df ("x86, mm: Avoid
unnecessary TLB flush") handle_pte_fault() called flush_tlb_page()
directly.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Link: https://github.com/sparclinux/issues/issues/108
Signed-off-by: Stian Halseth <stian@itx.no>
---
 arch/sparc/include/asm/tlbflush_64.h   |  10 ++++++++++
 arch/sparc/mm/tlb.c                    |  25 +++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/arch/sparc/include/asm/tlbflush_64.h b/arch/sparc/include/asm/tlbflush_64.h
--- a/arch/sparc/include/asm/tlbflush_64.h
+++ b/arch/sparc/include/asm/tlbflush_64.h
@@ -48,6 +48,16 @@
 void __flush_tlb_page(unsigned long context, unsigned long vaddr);
 void __flush_tlb_kernel_range(unsigned long start, unsigned long end);
 
+struct vm_area_struct;
+#define flush_tlb_fix_spurious_fault flush_tlb_fix_spurious_fault
+void flush_tlb_fix_spurious_fault(struct vm_area_struct *vma,
+				  unsigned long address, pte_t *ptep);
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#define flush_tlb_fix_spurious_fault_pmd flush_tlb_fix_spurious_fault_pmd
+void flush_tlb_fix_spurious_fault_pmd(struct vm_area_struct *vma,
+				      unsigned long address, pmd_t *pmdp);
+#endif
+
 #ifndef CONFIG_SMP
 
 static inline void global_flush_tlb_page(struct mm_struct *mm, unsigned long vaddr)
diff --git a/arch/sparc/mm/tlb.c b/arch/sparc/mm/tlb.c
--- a/arch/sparc/mm/tlb.c
+++ b/arch/sparc/mm/tlb.c
@@ -32,6 +32,31 @@
 	return changed;
 }
 
+/* Only base pages get here: hugetlb uses huge_ptep_set_access_flags() and
+ * THP the PMD variant below.
+ */
+void flush_tlb_fix_spurious_fault(struct vm_area_struct *vma,
+				  unsigned long address, pte_t *ptep)
+{
+	address &= PAGE_MASK;
+	flush_tsb_user_page(vma->vm_mm, address, PAGE_SHIFT);
+	global_flush_tlb_page(vma->vm_mm, address);
+}
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+void flush_tlb_fix_spurious_fault_pmd(struct vm_area_struct *vma,
+				      unsigned long address, pmd_t *pmdp)
+{
+	struct mm_struct *mm = vma->vm_mm;
+
+	address &= HPAGE_MASK;
+	flush_tsb_user_page(mm, address, REAL_HPAGE_SHIFT);
+	flush_tsb_user_page(mm, address + REAL_HPAGE_SIZE, REAL_HPAGE_SHIFT);
+	global_flush_tlb_page(mm, address);
+	global_flush_tlb_page(mm, address + REAL_HPAGE_SIZE);
+}
+#endif
+
 void flush_tlb_pending(void)
 {
 	struct tlb_batch *tb = &get_cpu_var(tlb_batch);
