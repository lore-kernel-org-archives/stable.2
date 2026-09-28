Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072114BE424;
	Mon, 28 Sep 2026 13:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790601733; cv=none; b=eDlbXTeSJl6BLKuq+YeMBfeYermKSE8upCuB3cXaZmOwptc6kHAJytmlviPe2+EUOcKLZsBvxyAyJcNXtrltouDObaex53cPyRbHTsx+qg8GQjETM7PewXfsZRvpmlSAEWT/qTfzais/fh7ZXutPPMuhUv9TzOiQcziSQuhgQsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790601733; c=relaxed/simple;
	bh=fiSr2CurFUF2BEDZCJ0+kLSrqGv7tTF3hIrACQAfctI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EYvnB3zJ7Q9eIb3xPgiJPD5MOErEpLFRWN9zmduwIPexR3FaaqWmI8Y/O397EZQeQ7L4k5QXYZO4wHO85ZrouZPBIhV3tRz4uCEYx48NiZnZb3CRVIfzZFVeBcd1qh7ComFdAVj4QTMaxe320KZVCnAmMlYc8icxGqnwWC4t1NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHpAHYcn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHpAHYcn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E44BE1F000FF;
	Mon, 28 Sep 2026 13:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790601731;
	bh=YgxiOouyDIcVtIkvJV+4mIm0kZ7zolQYdXWab1VZqUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZHpAHYcndcEZu8BSJSjp5O1bDar72ICptvsb9rE20DDfYoxOMWydTylADv6a25H+a
	 j7AyKg+QhtsAFhdfIMdQU6HSt5hixP2HJW3jba0LLeEgZwd9eFeRuWUszzb68BDky2
	 JBrtSMl1PYue+RG3o0wetIBken3nVnEARBrgUK2fLizOT9qqygbWCSl8wtye3vAgi/
	 kTGi6vNnN5DmscdUxQIR55qNXYKFKIYXoZMAgmxpoanNrIRhrQRUQBiFp7K2hnU4wx
	 HVrCxnHGAr8w3K4/JUkE2niLrVqb2T42o5El6OaxbBs1ie4PnlNTO6r+YjQh18Mat9
	 R/R69t1ivu1mA==
From: Imre Kaloz <kaloz@kernel.org>
To: Andreas Larsson <andreas@gaisler.com>,
	"David S. Miller" <davem@davemloft.net>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nsafran1217 <54966414+nsafran1217@users.noreply.github.com>,
	stable@vger.kernel.org,
	Stian Halseth <stian@itx.no>
Subject: [PATCH v2 2/2] sparc64: flush vmalloc ranges from the D-cache on map and unmap
Date: Mon, 28 Sep 2026 15:21:02 +0200
Message-ID: <20260928132102.1707-3-kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260928132102.1707-1-kaloz@kernel.org>
References: <20260928132102.1707-1-kaloz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The L1 D-cache of Spitfire and Cheetah is indexed with VA bit 13, but
flush_cache_vmap() and flush_cache_vunmap() are no-ops. Lines loaded
through a vmalloc address survive the unmap, and once the page is
written through the other colour, e.g. zeroed through the linear
mapping, a later mapping of the old colour reads stale data. Anonymous
user pages arrive the same way, as tlb_batch_add() does not flush them.
On UltraSPARC III this corrupts BPF programs and module data.

Flush each page on every CPU on map and unmap, or the whole D-cache in
one cross call once the range exceeds its size.

flush_cache_vmap() also runs on the vmemmap, from sparse_init() before
init_IRQ() sets up the cross-call mondo blocks; with the mondo block PA
still zero, flush_dcache_all()'s cross-call lands on physical address 0
instead. The vmemmap has no aliases to flush, so skip addresses outside
vmalloc and module space.

Link: https://github.com/sparclinux/issues/issues/29#issuecomment-5041121375
Closes: https://github.com/sparclinux/issues/issues/29
Suggested-by: nsafran1217 <54966414+nsafran1217@users.noreply.github.com>
Cc: stable@vger.kernel.org
Tested-by: Stian Halseth <stian@itx.no> # Sun Fire V240, SPARC T4-1
Signed-off-by: Imre Kaloz <kaloz@kernel.org>
---
v2: skip the flush outside vmalloc/module space, since
    flush_cache_vmap() also runs on the vmemmap during sparse_init()
    before cross-calls are set up (Stian Halseth); picked up his
    Tested-by.

 arch/sparc/include/asm/cacheflush_64.h |  6 ++--
 arch/sparc/kernel/smp_64.c             | 18 +++++++++++
 arch/sparc/mm/init_64.c                | 43 ++++++++++++++++++++++++++
 arch/sparc/mm/ultra.S                  | 25 +++++++++++++++
 4 files changed, 90 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/include/asm/cacheflush_64.h b/arch/sparc/include/asm/cacheflush_64.h
index 02c969417e7b..54a2d37008e6 100644
--- a/arch/sparc/include/asm/cacheflush_64.h
+++ b/arch/sparc/include/asm/cacheflush_64.h
@@ -42,6 +42,8 @@ void smp_flush_dcache_folio_impl(struct folio *folio, int cpu);
 #define smp_flush_dcache_folio_impl(folio, cpu) flush_dcache_folio_impl(folio)
 #endif
 void flush_dcache_page_all(struct mm_struct *mm, struct page *page);
+void __flush_dcache_all(unsigned long size, unsigned long line_size);
+void flush_dcache_all(void);
 
 void __flush_dcache_range(unsigned long start, unsigned long end);
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
@@ -73,9 +75,9 @@ void flush_ptrace_access(struct vm_area_struct *, struct page *,
 #define flush_dcache_mmap_lock(mapping)		do { } while (0)
 #define flush_dcache_mmap_unlock(mapping)	do { } while (0)
 
-#define flush_cache_vmap(start, end)		do { } while (0)
+void flush_cache_vmap(unsigned long start, unsigned long end);
 #define flush_cache_vmap_early(start, end)	do { } while (0)
-#define flush_cache_vunmap(start, end)		do { } while (0)
+#define flush_cache_vunmap(start, end)		flush_cache_vmap(start, end)
 
 #endif /* !__ASSEMBLER__ */
 
diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index 18b6145da591..bebfc44241b3 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -915,6 +915,7 @@ extern unsigned long xcall_kgdb_capture;
 
 #ifdef DCACHE_ALIASING_POSSIBLE
 extern unsigned long xcall_flush_dcache_page_cheetah;
+extern unsigned long xcall_flush_dcache_all;
 #endif
 extern unsigned long xcall_flush_dcache_page_spitfire;
 
@@ -1025,6 +1026,23 @@ void flush_dcache_page_all(struct mm_struct *mm, struct page *page)
 	preempt_enable();
 }
 
+#ifdef DCACHE_ALIASING_POSSIBLE
+void flush_dcache_all(void)
+{
+	unsigned long size, line_size;
+
+	if (tlb_type == hypervisor)
+		return;
+
+	preempt_disable();
+	size = local_cpu_data().dcache_size;
+	line_size = local_cpu_data().dcache_line_size;
+	smp_cross_call(&xcall_flush_dcache_all, 0, size, line_size);
+	__flush_dcache_all(size, line_size);
+	preempt_enable();
+}
+#endif
+
 #ifdef CONFIG_KGDB
 void kgdb_roundup_cpus(void)
 {
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 8792e5d92517..3e2096545e52 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -27,6 +27,7 @@
 #include <linux/percpu.h>
 #include <linux/mmzone.h>
 #include <linux/gfp.h>
+#include <linux/vmalloc.h>
 
 #include <asm/head.h>
 #include <asm/page.h>
@@ -234,6 +235,17 @@ void flush_dcache_page_all(struct mm_struct *mm, struct page *page)
 		__flush_icache_page(page_to_phys(page));
 #endif
 }
+
+#ifdef DCACHE_ALIASING_POSSIBLE
+void flush_dcache_all(void)
+{
+	if (tlb_type == hypervisor)
+		return;
+
+	__flush_dcache_all(local_cpu_data().dcache_size,
+			   local_cpu_data().dcache_line_size);
+}
+#endif
 #endif
 
 #define PG_dcache_dirty		PG_arch_1
@@ -3072,6 +3084,37 @@ arch_initcall(report_memory);
 #define do_flush_tlb_kernel_range	__flush_tlb_kernel_range
 #endif
 
+/*
+ * The L1 D-cache is indexed with VA bit 13, so lines loaded through a
+ * vmalloc address outlive the mapping.  Stores through a mapping of the
+ * other colour do not update them, and a later load through their colour
+ * returns stale data.  Flush at unmap so vmalloc's lines do not follow
+ * the page back to the allocator, and at map time since anonymous user
+ * pages are freed without a flush (see tlb_batch_add()).  Past the
+ * D-cache size, one whole-cache flush is cheaper than a cross call per
+ * page.
+ */
+void flush_cache_vmap(unsigned long start, unsigned long end)
+{
+#ifdef DCACHE_ALIASING_POSSIBLE
+	/* The vmemmap has no aliases and is mapped before cross calls work. */
+	if (tlb_type == hypervisor || !is_vmalloc_or_module_addr((void *)start))
+		return;
+
+	if (end - start > cpu_data(raw_smp_processor_id()).dcache_size) {
+		flush_dcache_all();
+		return;
+	}
+
+	for (; start < end; start += PAGE_SIZE) {
+		struct page *page = vmalloc_to_page((void *)start);
+
+		if (page)
+			flush_dcache_page_all(NULL, page);
+	}
+#endif
+}
+
 void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 {
 	if (start < HI_OBP_ADDRESS && end > LOW_OBP_ADDRESS) {
diff --git a/arch/sparc/mm/ultra.S b/arch/sparc/mm/ultra.S
index 70e658d107e0..ff190670a235 100644
--- a/arch/sparc/mm/ultra.S
+++ b/arch/sparc/mm/ultra.S
@@ -242,6 +242,20 @@ __flush_dcache_page:	/* %o0=kaddr, %o1=flush_icache */
 	retl
 	 nop
 
+	/* Zeroing every D-cache tag invalidates the whole cache on
+	 * Spitfire and Cheetah alike.
+	 */
+	.align		32
+	.globl		__flush_dcache_all
+__flush_dcache_all:	/* %o0=D-cache size, %o1=D-cache line size */
+1:	subcc		%o0, %o1, %o0
+	stxa		%g0, [%o0] ASI_DCACHE_TAG
+	membar		#Sync
+	bne,pt		%icc, 1b
+	 nop
+	retl
+	 nop
+
 #endif /* DCACHE_ALIASING_POSSIBLE */
 
 	.previous
@@ -801,6 +815,17 @@ xcall_flush_dcache_page_cheetah: /* %g1 == physical page address */
 	 nop
 	retry
 	nop
+
+	.align		32
+	.globl		xcall_flush_dcache_all
+xcall_flush_dcache_all: /* %g1 == D-cache size, %g7 == D-cache line size */
+1:	subcc		%g1, %g7, %g1
+	stxa		%g0, [%g1] ASI_DCACHE_TAG
+	membar		#Sync
+	bne,pt		%icc, 1b
+	 nop
+	retry
+	nop
 #endif /* DCACHE_ALIASING_POSSIBLE */
 
 	.globl		xcall_flush_dcache_page_spitfire
-- 
2.47.3

