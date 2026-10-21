Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792625701;
	b=cwCLrXVfPMRqPOeOpygo0G7bciGqQacAcU0hgwPLkKP/01VuTk0o2keK+7xMCSRenQlg
	 tzgkFhv0VsgZj9c5v0HCCMr0AfSv2iOwyeyqUuxh09o4xE6M+UmZjS2UdUH+l1s8pQKbh
	 JGrZa058nwDpMnB7wKOJe4a9eeIatlIsBVuk5ZEhXCR4dgjVQagK1epNK1Hrrqi8UpmhM
	 U5AQVD7riPYY87nwTOksazCKxh7+alLchaBgcxX47lreIdyXoPjjollM92DSeRLlCWHYO
	 mEmjVWWCNXUgHo8tKEPdWUABOBOaeAyHu8N0M0Ltw2bH3BVsf1IeLrvDTRWYoPv8Yiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792625701;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=G0OKI6y4OhutfG+XdOF4GNKLKTZK5pihXdnNjvnUK40=;
	b=W+chWul2Dh98ZY5HoiKn0S/emRfm0lbhD3YQVzTlBLMTUPEalDyggITFGGOZW69KR6aq
	 9g5+p5ivexRxi/uS6Jz4rcpElneNy1h4TeojgiwnMlCH0wrTUSEGiABt1XOF3EvUd7lx7
	 nAExDaG2BpubpQimQDWN+PUgg9flF/TdsXujYp7kO/AbwM/NnPxcwHNH8FAqB31M6OBfe
	 JPJWM+tRvMHcZUaQIR8+zKJepxZtWCk9IG5C8c44x4AJANwz48GoFUXWGmaUM8ilh1yBa
	 jhonKKJr9G2nwnrIsp4Ibjo/YwtoYhMQ2TESDHAzFSHkpvi4SnpjFJv8i0FTgBzf6lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ThKu98bL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099AB606A319;
	Wed, 21 Oct 2026 23:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ThKu98bL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF8201F000C1;
	Wed, 21 Oct 2026 23:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792625700;
	bh=G0OKI6y4OhutfG+XdOF4GNKLKTZK5pihXdnNjvnUK40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ThKu98bL5Hm9KlQ+BnEeF+JKlx2Uc32JqxYiXn5wjG8ZjvRH9jmi/psE9vWvAzn6/
	 rgVR35xjDQjQJ952FtrRHOcxnR1yqHn/TUXUPb4dYAIBSUEvGxhN2u3pyRsGpRV0j9
	 tjFVrXK2w3oU+Wtocx851k41H4dXrtXP9ejMZrohWHqLuanjw7gAWls3gVjXc/1W39
	 fp0Bzwt4TLLyN6exLax28bZQ+4GTCC/yHu/ju6DSQhQUBM20rzYMmw8su8sYZawMUk
	 oVHgzgJIrMJatjIiHJ9FQ8FmIxT66w7yP79YH0OVIlZe+ltM2eN95Mo0qhBk+6VkZ1
	 pkLtrRLNzKfHg==
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
Subject: [PATCH v3 2/4] sparc64: flush only the aliased page, not its whole folio
Date: Thu, 22 Oct 2026 01:33:38 +0200
Message-ID: <65ae69ec96f854a010ef8407144958cc290a1bf2.1792609488.git.kaloz@kernel.org>
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

Since the conversion to folios, move_pte() and tlb_batch_add() flushed
the D-cache of every page in the folio a PTE maps. Both are called once
per PTE, so a range backed by a large folio had each of its pages
flushed once per PTE of that folio. On SMP, each page flush on Spitfire
and Cheetah is a cross-call to all other online CPUs.

Flush only the page the PTE maps instead, as before the conversion.
Both callers see the PTEs of a range one at a time, so every page of
the range still gets its own flush. flush_dcache_folio_all() has no
other users and is turned back into flush_dcache_page_all().

On a Sun Fire V240, an mremap() that moves the 1024 PTEs of a large
folio to the other colour took 7.3 s, about a million redundant page
flushes.

Fixes: 1a10a44dfc1d ("sparc64: implement the new page table range API")
Cc: stable@vger.kernel.org
Tested-by: Stian Halseth <stian@itx.no> # Sun Fire V240, SPARC T4-1
Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Signed-off-by: Imre Kaloz <kaloz@kernel.org>
---
 arch/sparc/include/asm/cacheflush_64.h |  3 +--
 arch/sparc/include/asm/pgtable_64.h    |  8 ++++++--
 arch/sparc/kernel/smp_64.c             | 24 +++++++++++++-----------
 arch/sparc/mm/init_64.c                | 22 ++++++++++++++++++++++
 arch/sparc/mm/tlb.c                    |  2 +-
 5 files changed, 43 insertions(+), 16 deletions(-)

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
index 0837ebbc5dce..1430489b9ac5 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -946,6 +946,10 @@ static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
 	set_pte_at((mm), (addr), (ptep), __pte(0UL))
 
 #ifdef DCACHE_ALIASING_POSSIBLE
+/* This flushes only the page the PTE maps, so it relies on move_ptes()
+ * calling it for one PTE at a time, which the default pte_batch_hint()
+ * guarantees.
+ */
 #define __HAVE_ARCH_MOVE_PTE
 #define move_pte(pte, old_addr, new_addr)				\
 ({									\
@@ -955,8 +959,8 @@ static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
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
index 4240c129c5fe..6681f5263865 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -991,8 +991,9 @@ void smp_flush_dcache_folio_impl(struct folio *folio, int cpu)
 	put_cpu();
 }
 
-void flush_dcache_folio_all(struct mm_struct *mm, struct folio *folio)
+void flush_dcache_page_all(struct mm_struct *mm, struct page *page)
 {
+	struct folio *folio = page_folio(page);
 	void *pg_addr;
 	u64 data0;
 
@@ -1005,7 +1006,7 @@ void flush_dcache_folio_all(struct mm_struct *mm, struct folio *folio)
 	atomic_inc(&dcpage_flushes);
 #endif
 	data0 = 0;
-	pg_addr = folio_address(folio);
+	pg_addr = page_address(page);
 	if (tlb_type == spitfire) {
 		data0 = ((u64)&xcall_flush_dcache_page_spitfire);
 		if (folio_flush_mapping(folio) != NULL)
@@ -1016,18 +1017,19 @@ void flush_dcache_folio_all(struct mm_struct *mm, struct folio *folio)
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
index 103db4683b16..8d01aab43cc3 100644
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
+#endif /* !CONFIG_SMP */
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

