Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF2E3C0624;
	Sun, 27 Sep 2026 10:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790506606; cv=none; b=cf1CNNA11D2LpJFmBmul69vqA2cPqnAhu3LBiQy3RvZVtAyxBx9dm8avFJdRe7rfJHbezpiwzl7SIudeSnfzhZHkUNfsz8wn43D8XhnfE3dA74iZs+GpmHiMaaqp+D6HoykIy+joChfPLP+P/uxDY0jbkzXoIPbycgC22P2mocE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790506606; c=relaxed/simple;
	bh=rkrhifrPA3SL8Hsvj6Y4wu3rJ77VGKbz04oPVhUI9fw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XhTouEsskROBrnVgYlPoPEXSC1noxrK8Xdw/g08R/NBe8QUtYgDNu0l19DB1LhP144xk8k2PbCXfSxNt2RKrfZB75VjWKLKcjQlJewtvTo0zAFW4kef9BZ1ag73vWGU2hUcaFS/izBKHiqdK6aFvdZ4hmOmp5vaz+KohOhVdCVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P69jVzBd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P69jVzBd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F0AD1F00893;
	Sun, 27 Sep 2026 10:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790506605;
	bh=9VYE0oBNqh0JaQf274SozsUSidXXZOp4ocOP4ZEFjR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P69jVzBd4s3gldUIW5YktjwafqVNHLsGhQyxpwXr9cmcdsIMlhfS34zAY/VVmPdDj
	 7CHaCz5hiSSRJmmqjdQ5F3a+L5kdBTaldOGMBQgL7sr7n+24lMbEL8eWgcriewrIlD
	 U00z4ZuF39ycs3EuyYLH6Z5FYMiBfROcD+KO2V2SC/r5IPqSv4ZnshGszM30PvWshW
	 sMnQquKZxjpoJAy3BIsOt1blPntg9InRgvvLSZ+++bnX0R1EMx2dst+Tyrty/B3JTn
	 LR6+lMygj/fRV0ngdLi//qpdpXwB1SpEXQkG+tu8S1t7svZNY1UxLWLDwnvNl44gnu
	 m4g7F80cF1tuQ==
From: Imre Kaloz <kaloz@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] sparc64: flush only the aliased page, not its whole folio
Date: Sun, 27 Sep 2026 12:55:38 +0200
Message-ID: <20260927105539.8742-2-kaloz@kernel.org>
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

Since the conversion to folios, move_pte() and tlb_batch_add() flush the
D-cache of every page in the folio a single PTE maps.  Both run once per
PTE, so moving or unmapping a range backed by a large folio flushes each
of its pages once for every PTE of that folio, and each page flush is a
cross-call to all other online CPUs.

Only the page the PTE maps can hold lines at the old colour, so flush
just that page, as before the conversion.  flush_dcache_folio_all() has
no other users and becomes flush_dcache_page_all() again.

On SMP QEMU guests, apt rebuilding its caches through mremap() triggers
RCU stalls and soft lockups in move_pte().

Fixes: 1a10a44dfc1d ("sparc64: implement the new page table range API")
Cc: stable@vger.kernel.org
Signed-off-by: Imre Kaloz <kaloz@kernel.org>
---
 arch/sparc/include/asm/cacheflush_64.h |  3 +--
 arch/sparc/include/asm/pgtable_64.h    |  7 +++++--
 arch/sparc/kernel/smp_64.c             | 24 +++++++++++++-----------
 arch/sparc/mm/init_64.c                | 22 ++++++++++++++++++++++
 arch/sparc/mm/tlb.c                    |  2 +-
 5 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/arch/sparc/include/asm/cacheflush_64.h b/arch/sparc/include/asm/cacheflush_64.h
index 06092572c045..02c969417e7b 100644
--- a/arch/sparc/include/asm/cacheflush_64.h
+++ b/arch/sparc/include/asm/cacheflush_64.h
@@ -38,11 +38,10 @@ void __flush_dcache_page(void *addr, int flush_icache);
 void flush_dcache_folio_impl(struct folio *folio);
 #ifdef CONFIG_SMP
 void smp_flush_dcache_folio_impl(struct folio *folio, int cpu);
-void flush_dcache_folio_all(struct mm_struct *mm, struct folio *folio);
 #else
 #define smp_flush_dcache_folio_impl(folio, cpu) flush_dcache_folio_impl(folio)
-#define flush_dcache_folio_all(mm, folio) flush_dcache_folio_impl(folio)
 #endif
+void flush_dcache_page_all(struct mm_struct *mm, struct page *page);
 
 void __flush_dcache_range(unsigned long start, unsigned long end);
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 0837ebbc5dce..6712eac4baf1 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -946,6 +946,9 @@ static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
 	set_pte_at((mm), (addr), (ptep), __pte(0UL))
 
 #ifdef DCACHE_ALIASING_POSSIBLE
+/* Without pte_batch_hint(), move_ptes() calls this once per PTE, so
+ * only the page this PTE maps can have lines at the old colour.
+ */
 #define __HAVE_ARCH_MOVE_PTE
 #define move_pte(pte, old_addr, new_addr)				\
 ({									\
@@ -955,8 +958,8 @@ static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
 									\
 		if (pfn_valid(this_pfn) &&				\
 		    (((old_addr) ^ (new_addr)) & (1 << 13)))		\
-			flush_dcache_folio_all(current->mm,		\
-				page_folio(pfn_to_page(this_pfn)));	\
+			flush_dcache_page_all(current->mm,		\
+					      pfn_to_page(this_pfn));	\
 	}								\
 	newpte;								\
 })
diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index 371460e34484..18b6145da591 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -982,8 +982,9 @@ void smp_flush_dcache_folio_impl(struct folio *folio, int cpu)
 	put_cpu();
 }
 
-void flush_dcache_folio_all(struct mm_struct *mm, struct folio *folio)
+void flush_dcache_page_all(struct mm_struct *mm, struct page *page)
 {
+	struct folio *folio = page_folio(page);
 	void *pg_addr;
 	u64 data0;
 
@@ -996,7 +997,7 @@ void flush_dcache_folio_all(struct mm_struct *mm, struct folio *folio)
 	atomic_inc(&dcpage_flushes);
 #endif
 	data0 = 0;
-	pg_addr = folio_address(folio);
+	pg_addr = page_address(page);
 	if (tlb_type == spitfire) {
 		data0 = ((u64)&xcall_flush_dcache_page_spitfire);
 		if (folio_flush_mapping(folio) != NULL)
@@ -1007,18 +1008,19 @@ void flush_dcache_folio_all(struct mm_struct *mm, struct folio *folio)
 #endif
 	}
 	if (data0) {
-		unsigned int i, nr = folio_nr_pages(folio);
-
-		for (i = 0; i < nr; i++) {
-			xcall_deliver(data0, __pa(pg_addr),
-				      (u64) pg_addr, cpu_online_mask);
+		xcall_deliver(data0, __pa(pg_addr),
+			      (u64)pg_addr, cpu_online_mask);
 #ifdef CONFIG_DEBUG_DCFLUSH
-			atomic_inc(&dcpage_flushes_xcall);
+		atomic_inc(&dcpage_flushes_xcall);
 #endif
-			pg_addr += PAGE_SIZE;
-		}
 	}
-	__local_flush_dcache_folio(folio);
+#ifdef DCACHE_ALIASING_POSSIBLE
+	__flush_dcache_page(pg_addr,
+			    tlb_type == spitfire && folio_flush_mapping(folio));
+#else
+	if (tlb_type == spitfire && folio_flush_mapping(folio))
+		__flush_icache_page(__pa(pg_addr));
+#endif
 
 	preempt_enable();
 }
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 103db4683b16..8792e5d92517 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -214,6 +214,28 @@ inline void flush_dcache_folio_impl(struct folio *folio)
 #endif
 }
 
+#ifndef CONFIG_SMP
+void flush_dcache_page_all(struct mm_struct *mm, struct page *page)
+{
+	struct folio *folio = page_folio(page);
+
+	if (tlb_type == hypervisor)
+		return;
+
+#ifdef CONFIG_DEBUG_DCFLUSH
+	atomic_inc(&dcpage_flushes);
+#endif
+
+#ifdef DCACHE_ALIASING_POSSIBLE
+	__flush_dcache_page(page_address(page),
+			    tlb_type == spitfire && folio_flush_mapping(folio));
+#else
+	if (tlb_type == spitfire && folio_flush_mapping(folio))
+		__flush_icache_page(page_to_phys(page));
+#endif
+}
+#endif
+
 #define PG_dcache_dirty		PG_arch_1
 #define PG_dcache_cpu_shift	32UL
 #define PG_dcache_cpu_mask	\
diff --git a/arch/sparc/mm/tlb.c b/arch/sparc/mm/tlb.c
index 6d9dd5eb1328..1221814ca0e1 100644
--- a/arch/sparc/mm/tlb.c
+++ b/arch/sparc/mm/tlb.c
@@ -144,7 +144,7 @@ void tlb_batch_add(struct mm_struct *mm, unsigned long vaddr,
 
 		paddr = (unsigned long) page_address(page);
 		if ((paddr ^ vaddr) & (1 << 13))
-			flush_dcache_folio_all(mm, folio);
+			flush_dcache_page_all(mm, page);
 	}
 
 no_cache_flush:
-- 
2.47.3

