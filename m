Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794420834;
	b=SYeQVT2z6vxmpk5El6aocua9FYin0EYg1fQKonhWN0EcXRh+j2hchM2XRKea/onzOViC
	 aTJGjUbYKbZypJSwFhNmKgvKfSsL+XM/Z/HQ8zdewHVr9DXiRgl3es2L2gMDvQvIpqzMr
	 JfIGbHYz/V4JgSlZZRYjDYiVd0zg1TG6kzr9AUUBBErdboAdF25kZygI6B55b/EvHyqXJ
	 iJNe9g5Cfi8LYCEjJtE/QXqTk+dfiZ5yLby7OZhca/j3wGJXUe0Y2cLzFra8cCauOzELm
	 ALebhZmaGGhCuJHr6ZR61/j/ULvDu0lTU7RUV03lEI6lGTz8XlTfQ31o1wkpHM0Bukg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794420834;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=le/PdQ2RVcW3L2Xjvx1W8ztmu0b2B8aepR0NzsH4PNg=;
	b=cqoaRclVsmueNyXs1md15ITa/yP2meGAos0FHAkSb77HItIhMhLVa/seXwHUtlB45VLO
	 aeLQZ5demSqFVFZAR61kNl5G8KPDQdd5Nx90/otrDVzfom9u/ch5WKm7x5BuhISu9cDaz
	 K/Nefb50GEJPIMIAORaAxZ2hX6pmNG8INI2QZ1nZHsaiV7NT4Zp4wkwHifKDFJ1Lb6ZNj
	 7QmoM/xOOLsRejxqvpormy+ssesUqX7eCWHhJSjit5K/Gd5dEWCHdQUSEk6on3gbkuwSp
	 4Un8a3vFIs/X3VPPYBUZKo3mNxtU8j1yCWVMDo2nyP41GVyA/aCS2yp6BWH0QeKiS8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h99N1wDH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367F8606CB16
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 18:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h99N1wDH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FAAE1F00A09;
	Wed, 11 Nov 2026 18:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794420834;
	bh=le/PdQ2RVcW3L2Xjvx1W8ztmu0b2B8aepR0NzsH4PNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h99N1wDHxWJlWKOJ8o8wXhVaTfiLSrouItQKiavpENKozAKduUjwpPXanG9JgMMvs
	 4TgczBDpJh7om/tudKj/h08+pXtyFAc7V4uvWuFBXBEfzA7kLLfmeziEwGZt9rtq+g
	 DM1ZQqqTaGbjl4niASzC/KggtTf8ZkcY+avs3zmRej3ooOZXD1q9DrLJz5GUnVeAvg
	 asLCKTaGvs1dhUDxTq9FhFEYRfztsn4T20bMP/S+c2wu2G3Gyvr6prsM4HDh8c3P9Y
	 jZ5N031ud7+BakMIG/rBzAEu9wSyYLQvLAtbvkLpqjEhDb+sru7IJTcZz5rQM7tmWG
	 fwb4Rx7kr2gqQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Magnus Lindholm <linmag7@gmail.com>,
	Ivan Kokshaysky <ink@unseen.parts>,
	Matoro Mahri <matoro_mailinglist_kernel@matoro.tk>,
	Michael Cree <mcree@orcon.net.nz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/4] alpha: fix user-space corruption during memory compaction
Date: Wed, 11 Nov 2026 13:13:49 -0500
Message-ID: <20261111181340.3748826-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111181340.3748826-1-sashal@kernel.org>
References: <20261107062501-failed-5.10-fe221b7b2d3e@kernel.org>
 <20261111181340.3748826-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Magnus Lindholm <linmag7@gmail.com>

[ Upstream commit dd5712f3379cfe760267cdd28ff957d9ab4e51c7 ]

Alpha systems can suffer sporadic user-space crashes and heap
corruption when memory compaction is enabled.

Symptoms include SIGSEGV, glibc allocator failures (e.g. "unaligned
tcache chunk"), and compiler internal errors. The failures disappear
when compaction is disabled or when using global TLB invalidation.

The root cause is insufficient TLB shootdown during page migration.
Alpha relies on ASN-based MM context rollover for instruction cache
coherency, but this alone is not sufficient to prevent stale data or
instruction translations from surviving migration.

Fix this by introducing a migration-specific helper that combines:
  - MM context invalidation (ASN rollover),
  - immediate per-CPU TLB invalidation (TBI),
  - synchronous cross-CPU shootdown when required.

The helper is used only by migration/compaction paths to avoid changing
global TLB semantics.

Additionally, update flush_tlb_other(), pte_clear(), to use
READ_ONCE()/WRITE_ONCE() for correct SMP memory ordering.

This fixes observed crashes on both UP and SMP Alpha systems.

Reviewed-by: Ivan Kokshaysky <ink@unseen.parts>
Tested-by: Matoro Mahri <matoro_mailinglist_kernel@matoro.tk>
Tested-by: Michael Cree <mcree@orcon.net.nz>
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
Link: https://lore.kernel.org/r/20260102173603.18247-2-linmag7@gmail.com
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>

Retain NUMA support and omit the unavailable page-table-check hooks.
Also omit the post-rendezvous clearing of remote MMU contexts. Each
CPU has already updated its own slot, and clearing it remotely can
hide a live address space from the subsequent shootdown checks.

Stable-dep-of: fe221b7b2d3e ("alpha: do not skip TLB shootdown IPIs for kthread-borrowed mms")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/alpha/include/asm/pgtable.h  | 31 +++++++++-
 arch/alpha/include/asm/tlbflush.h |  4 +-
 arch/alpha/mm/Makefile            |  2 +-
 arch/alpha/mm/tlbflush.c          | 96 +++++++++++++++++++++++++++++++
 4 files changed, 130 insertions(+), 3 deletions(-)
 create mode 100644 arch/alpha/mm/tlbflush.c

diff --git a/arch/alpha/include/asm/pgtable.h b/arch/alpha/include/asm/pgtable.h
index 1cffeda415a44..3efde81a2bd7d 100644
--- a/arch/alpha/include/asm/pgtable.h
+++ b/arch/alpha/include/asm/pgtable.h
@@ -230,6 +230,9 @@ extern inline void pud_set(pud_t * pudp, pmd_t * pmdp)
 { pud_val(*pudp) = _PAGE_TABLE | ((((unsigned long) pmdp) - PAGE_OFFSET) << (32-PAGE_SHIFT)); }
 
 
+extern void migrate_flush_tlb_page(struct vm_area_struct *vma,
+					unsigned long addr);
+
 extern inline unsigned long
 pmd_page_vaddr(pmd_t pmd)
 {
@@ -250,7 +253,7 @@ extern inline int pte_none(pte_t pte)		{ return !pte_val(pte); }
 extern inline int pte_present(pte_t pte)	{ return pte_val(pte) & _PAGE_VALID; }
 extern inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
-	pte_val(*ptep) = 0;
+	WRITE_ONCE(pte_val(*ptep), 0);
 }
 
 extern inline int pmd_none(pmd_t pmd)		{ return !pmd_val(pmd); }
@@ -312,6 +315,32 @@ extern inline pte_t * pte_offset_kernel(pmd_t * dir, unsigned long address)
 
 extern pgd_t swapper_pg_dir[1024];
 
+#ifdef CONFIG_COMPACTION
+#define __HAVE_ARCH_PTEP_GET_AND_CLEAR
+
+static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
+					unsigned long address,
+					pte_t *ptep)
+{
+	pte_t pte = READ_ONCE(*ptep);
+
+	pte_clear(mm, address, ptep);
+	return pte;
+}
+
+#define __HAVE_ARCH_PTEP_CLEAR_FLUSH
+
+static inline pte_t ptep_clear_flush(struct vm_area_struct *vma,
+				unsigned long addr, pte_t *ptep)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	pte_t pte = ptep_get_and_clear(mm, addr, ptep);
+
+	migrate_flush_tlb_page(vma, addr);
+	return pte;
+}
+
+#endif
 /*
  * The Alpha doesn't have any external MMU info:  the kernel page
  * tables contain all the necessary information.
diff --git a/arch/alpha/include/asm/tlbflush.h b/arch/alpha/include/asm/tlbflush.h
index 64ea0f130cd57..d79d225da6c76 100644
--- a/arch/alpha/include/asm/tlbflush.h
+++ b/arch/alpha/include/asm/tlbflush.h
@@ -91,7 +91,9 @@ flush_tlb_other(struct mm_struct *mm)
 	unsigned long *mmc = &mm->context[smp_processor_id()];
 	/* Check it's not zero first to avoid cacheline ping pong
 	   when possible.  */
-	if (*mmc) *mmc = 0;
+
+	if (READ_ONCE(*mmc))
+		WRITE_ONCE(*mmc, 0);
 }
 
 #ifndef CONFIG_SMP
diff --git a/arch/alpha/mm/Makefile b/arch/alpha/mm/Makefile
index 09fea7216efdf..ec5c5c5efb6e9 100644
--- a/arch/alpha/mm/Makefile
+++ b/arch/alpha/mm/Makefile
@@ -3,6 +3,6 @@
 # Makefile for the linux alpha-specific parts of the memory manager.
 #
 
-obj-y	:= init.o fault.o
+obj-y	:= init.o fault.o tlbflush.o
 
 obj-$(CONFIG_DISCONTIGMEM) += numa.o
diff --git a/arch/alpha/mm/tlbflush.c b/arch/alpha/mm/tlbflush.c
new file mode 100644
index 0000000000000..239c72b8a7412
--- /dev/null
+++ b/arch/alpha/mm/tlbflush.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Alpha TLB shootdown helpers
+ *
+ * Copyright (C) 2025 Magnus Lindholm <linmag7@gmail.com>
+ *
+ * Alpha-specific TLB flush helpers that cannot be expressed purely
+ * as inline functions.
+ *
+ * These helpers provide combined MM context handling (ASN rollover)
+ * and immediate TLB invalidation for page migration and memory
+ * compaction paths, where lazy shootdowns are insufficient.
+ */
+
+#include <linux/mm.h>
+#include <linux/smp.h>
+#include <linux/sched.h>
+#include <asm/tlbflush.h>
+#include <asm/pal.h>
+#include <asm/mmu_context.h>
+
+#define asn_locked() (cpu_data[smp_processor_id()].asn_lock)
+
+/*
+ * Migration/compaction helper: combine mm context (ASN) handling with an
+ * immediate per-page TLB invalidate and (for exec) an instruction barrier.
+ *
+ * This mirrors the SMP combined IPI handler semantics, but runs locally on UP.
+ */
+#ifndef CONFIG_SMP
+void migrate_flush_tlb_page(struct vm_area_struct *vma,
+					   unsigned long addr)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	int tbi_type = (vma->vm_flags & VM_EXEC) ? 3 : 2;
+
+	/*
+	 * First do the mm-context side:
+	 * If we're currently running this mm, reload a fresh context ASN.
+	 * Otherwise, mark context invalid.
+	 *
+	 * On UP, this is mostly about matching the SMP semantics and ensuring
+	 * exec/i-cache tagging assumptions hold when compaction migrates pages.
+	 */
+	if (mm == current->active_mm)
+		flush_tlb_current(mm);
+	else
+		flush_tlb_other(mm);
+
+	/*
+	 * Then do the immediate translation kill for this VA.
+	 * For exec mappings, order instruction fetch after invalidation.
+	 */
+	tbi(tbi_type, addr);
+}
+
+#else
+struct tlb_mm_and_addr {
+	struct mm_struct *mm;
+	unsigned long addr;
+	int tbi_type;	/* 2 = DTB, 3 = ITB+DTB */
+};
+
+static void ipi_flush_mm_and_page(void *x)
+{
+	struct tlb_mm_and_addr *d = x;
+
+	/* Part 1: mm context side (Alpha uses ASN/context as a key mechanism). */
+	if (d->mm == current->active_mm && !asn_locked())
+		__load_new_mm_context(d->mm);
+	else
+		flush_tlb_other(d->mm);
+
+	/* Part 2: immediate per-VA invalidation on this CPU. */
+	tbi(d->tbi_type, d->addr);
+}
+
+void migrate_flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	struct tlb_mm_and_addr d = {
+		.mm = mm,
+		.addr = addr,
+		.tbi_type = (vma->vm_flags & VM_EXEC) ? 3 : 2,
+	};
+
+	/*
+	 * One synchronous rendezvous: every CPU runs ipi_flush_mm_and_page().
+	 * This is the "combined" version of flush_tlb_mm + per-page invalidate.
+	 */
+	preempt_disable();
+	on_each_cpu(ipi_flush_mm_and_page, &d, 1);
+	preempt_enable();
+}
+
+#endif
-- 
2.53.0

