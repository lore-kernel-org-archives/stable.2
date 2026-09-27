Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4D4378D8E;
	Sun, 27 Sep 2026 10:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790506609; cv=none; b=eFkP8wZq+S4at1u4fJpxst1ialSvDRf2kjeKC3ys1mw+n9C3+ykpurWQfpCTqqm59KcYE0/WZKUBtAICQF3SBZhZoPsidwGKibI6K37qd4XDIBkL74lv3l9bebcmBvtQex3enC7MkQE2u2ndn48HcGuU8+7oprQcfdVKF5547hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790506609; c=relaxed/simple;
	bh=OAzxT29uoSvbM035RY7ILxnsThEP7XtsMFj7aOIEaR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QlePLO/jVTRD5jrKKyQLuQUsAw222iEXfAx1KAV9I7WCIk9B7P9BaSSCtUDjX6XQTC6UT4F4SIVqF4rImwpNZk2UlH9/dnpcohxcWo3yuw8kzWl4lQ9shTPfoSNwZo+if71w8EM0w8vgB9EFkZ1efMK7WS590lIgwqppbEFxFrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kEvCKRvU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kEvCKRvU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A06061F000FF;
	Sun, 27 Sep 2026 10:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790506607;
	bh=OSrrDI89B0hgmx1IijQZkQqpjghtmOE99vmb2/x/rDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kEvCKRvUFSU82Zho5SahpJX4RzZrKavjZcT6OBNABFOjeBBBxCTXu6kF3T4gdhpne
	 VIEXt4rxxjtU17Y6sM9RivMstWMHDFoZPx+tUx7XUU1T0yMlVlc/HmjNWyzQhwcPeW
	 5NsdJABf9TTFU6QGQVRjW3akf9S2jdJwtL26sdGFK/JpNUN/8bf0IAT6Q2Q3WwicmW
	 MRu1HPeErqBW0M7CrZjj7qIaVPEPRqp7O1jh8bh+T6qx2hTOQ2exU02nn3c19X/A7u
	 9zdvi07ZHVwo5PMzc/YtrVPkVLMQPbl9/guKdHCysoab1mNZNAEw6Wpg71/PXrxkjy
	 Rbw0nJHPsvqIg==
From: Imre Kaloz <kaloz@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nsafran1217 <54966414+nsafran1217@users.noreply.github.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] sparc64: flush vmalloc ranges from the D-cache on map and unmap
Date: Sun, 27 Sep 2026 12:55:39 +0200
Message-ID: <20260927105539.8742-3-kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260927105539.8742-1-kaloz@kernel.org>
References: <20260927105539.8742-1-kaloz@kernel.org>
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

Link: https://github.com/sparclinux/issues/issues/29#issuecomment-5041121375
Closes: https://github.com/sparclinux/issues/issues/29
Suggested-by: nsafran1217 <54966414+nsafran1217@users.noreply.github.com>
Cc: stable@vger.kernel.org
Signed-off-by: Imre Kaloz <kaloz@kernel.org>
---

Notes:
    No Fixes: tag: flush_cache_vmap/vunmap have been no-ops on
    sparc64 since the file was introduced, before the git
    history.

 arch/sparc/include/asm/cacheflush_64.h |  6 ++--
 arch/sparc/kernel/smp_64.c             | 18 +++++++++++
 arch/sparc/mm/init_64.c                | 42 ++++++++++++++++++++++++++
 arch/sparc/mm/ultra.S                  | 25 +++++++++++++++
 4 files changed, 89 insertions(+), 2 deletions(-)

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
index 8792e5d92517..462338d875cd 100644
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
@@ -3072,6 +3084,36 @@ arch_initcall(report_memory);
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
+	if (tlb_type == hypervisor)
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

