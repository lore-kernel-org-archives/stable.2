Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792625704;
	b=lthu0tORBAB6j38iY2AJNS/mkLoHy6MVBGZzsa5fpkDGXWQHLOR6xK5eZXUvKlq/n8FX
	 ldFnnI2aTsbdS31NNsy8+ObgOqja3zbKXKGAh99ozC9oK/sBR27okJj7P1FrrtwdndoGU
	 wAbXBnCyU2A8S1XQdjpdfWJ4u+/likOqZwkcX2r+8XKaie5jBX/OzZ1x1u6KeOAXyUKNt
	 JQwL0pne/MYKyOhHRjRK2BORMqJKn7oM6F0mS4BgGnyTbziGfEir+xnHW9WciQqBGInXx
	 iGmmAUN4sNpZsaAOSfZvlgXAIyN767J7LU2m8JUEoCiaqmJR+f8klf0m66xDH+0SG1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792625704;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=DEOUCmLCD5QmSlPVT91FgaQC8nC2swbBcRqpaDjjQfI=;
	b=L8TlgQWUghtoL2e4fcWBISEB1ifkzqZlNrkKTQJsWY/ZrxPXZDomc8C+4grdzHIXOq2Q
	 CydYgFbrASYRk1kBdfT0CgeQnLNj4j7BdVR6/pXoEe7L5JMwklyHqSVE5+3wgniSBs/ei
	 X/DPVmvyt5UE1AbCKu7U7kdtlGI5r1v0u3+zuDVzKhJWJqMl+85/0Foc7a/HSFo1N0uYn
	 tEmKszJc/j2sXeOeXcaQA3O1Lq2SF8PI8dUDPZqjGXrQ2gWXSzWsLh6YP8GnIWsD4Vchk
	 LaDFQQsH922DJ0Gl1sNDUEqniIHsIDpYsLCsjBQnUtLife1lohTGyVaWeaVmL/GTVOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hYOuMxLC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50BA606A320;
	Wed, 21 Oct 2026 23:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hYOuMxLC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1136D1F000C5;
	Wed, 21 Oct 2026 23:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792625703;
	bh=DEOUCmLCD5QmSlPVT91FgaQC8nC2swbBcRqpaDjjQfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hYOuMxLCYjqvimZsnFLqsnr3/JOHhHgPWYktNKOG+xa58rA/PdajZ93TkVMaAE9u/
	 z9wRqTy3u+ueUpn1AjkmWnuIiREYvygff12YHIlpDGJRkBqLF2CGRhYj0ncj+oXmNl
	 LzcvebJMEjfbpM6b2VaBVlQ83xSjdC2YAEbS5eRPaPpZUkKOoXSr3nQWGM2ot83rwK
	 GCFlL0IW+gillXAiO0AeOMcgiiiDbPU/aLiP08fQbq5A9ulC3iRYnDI0B4NnGt4Gy/
	 MTaybh72CKj1z5smIElrxh74E0jVGtMDfTVB5XQwIVDbB1sOrh76/0j6SgpLB0VS5Q
	 D0NkMloHM9pzw==
From: Imre Kaloz <kaloz@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org,
	Stian Halseth <stian@itx.no>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: [PATCH v3 3/4] sparc64: flush vmalloc ranges from the D-cache on map and unmap
Date: Thu, 22 Oct 2026 01:33:39 +0200
Message-ID: <55b4691ea87be7f4a679197bc2ec35b81b45d233.1792609488.git.kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1792609488.git.kaloz@kernel.org>
References: <cover.1792609488.git.kaloz@kernel.org>
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
init_IRQ() sets up the cross-call mondo blocks. The vmemmap has no
aliases to flush, so skip addresses outside vmalloc and module space.
Now that xcall_deliver() leaves the trap block alone when there is no
target CPU, this check only saves pointless flushes. Stable kernels
lack that change and need the check, since without it
flush_dcache_all()'s cross call from sparse_init() would write starting
at physical address 0.

Link: https://github.com/sparclinux/issues/issues/29#issuecomment-5041121375
Closes: https://github.com/sparclinux/issues/issues/29
Cc: stable@vger.kernel.org # requires "sparc64: flush only the aliased page, not its whole folio"
Tested-by: Stian Halseth <stian@itx.no> # Sun Fire V240, SPARC T4-1
Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Signed-off-by: Imre Kaloz <kaloz@kernel.org>
---
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
index 6681f5263865..ed6900b5d562 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -924,6 +924,7 @@ extern unsigned long xcall_kgdb_capture;
 
 #ifdef DCACHE_ALIASING_POSSIBLE
 extern unsigned long xcall_flush_dcache_page_cheetah;
+extern unsigned long xcall_flush_dcache_all;
 #endif
 extern unsigned long xcall_flush_dcache_page_spitfire;
 
@@ -1034,6 +1035,23 @@ void flush_dcache_page_all(struct mm_struct *mm, struct page *page)
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
index 8d01aab43cc3..d1f94b8d6312 100644
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
 #endif /* !CONFIG_SMP */
 
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

