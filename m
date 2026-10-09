Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B37536894D;
	Fri,  9 Oct 2026 22:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.30.2.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791584407; cv=none; b=a9tR0bv5SqF7JY57AAREEboSKEmObOdIHzCYWRgWbLFdZ0jMmS/BnkNBzL86risAODF+QIx4uLXIzdfxCYKhzH6ArHRMOZfBUtVsTvVE6DBqt755HV051v2dH1y85jCj4CwYmFW223iLstfjOxyyL6BDu4alGHCnbNXtANU0Wdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791584407; c=relaxed/simple;
	bh=oNXrreZBveeKDBL/UvLU2TmMs2wzwUyCUb05h0d9L24=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V8VXLhusjnBcJrAEkSclwhGZjW6zWn20eGtkZh3YOJi9M/0kA/DVloDnY6783WnDv6ST5wq9q3bLt9F6TX8FnuZy2AFgpiutjqvzQuFfq+9DfvyLSO8+zzXqZIQD8tYgDGqSH6zQ9WsL7N1WgxuawsAf2FWi5Ksupy+E/wy0yaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu; spf=pass smtp.mailfrom=csail.mit.edu; arc=none smtp.client-ip=128.30.2.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csail.mit.edu
Received: from escalante.csail.mit.edu ([128.52.128.198])
	by outgoing2021.csail.mit.edu with esmtp (Exim 4.95)
	(envelope-from <nickolai@csail.mit.edu>)
	id 1xFIwX-003EyK-L5;
	Fri, 09 Oct 2026 18:19:57 -0400
From: Nickolai Zeldovich <nickolai@csail.mit.edu>
To: linux-riscv@lists.infradead.org
Cc: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Nickolai Zeldovich <nickolai@csail.mit.edu>
Subject: [PATCH] riscv: Fix icache flush being skipped for a second mm mapping an exec folio
Date: Fri,  9 Oct 2026 18:19:57 -0400
Message-ID: <20261009221957.760606-1-nickolai@csail.mit.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 01261e24cfab ("riscv: Only flush the mm icache when
setting an exec pte"), flush_icache_pte() flushes only the icache of
the harts that run the faulting mm (with a deferred fence.i for the
harts it migrates to later), but it still sets the folio-wide
PG_dcache_clean bit. The bit is then read as "no hart holds stale
instructions for this folio", which a per-mm flush does not establish.

So when a folio that was written through the page cache is mapped
executable first by mm A on hart X and then by a different mm B on a
hart Y outside A's cpumask, B gets no flush on Y and executes whatever
Y's icache still holds for those physical lines, e.g. the page's
previous contents. Before that commit, flush_icache_all() covered this
case.

Reproducer: a parent pinned to hart 0 and a child pinned to hart 3
share a file. The parent writes text "T1" with write(2), the child
mmap()s it PROT_EXEC and runs it (priming hart 3's icache with T1),
then unmaps it. The parent writes text "T2", maps it executable and
runs it (per-mm flush of hart 0 only, bit set). The child maps the
file executable again and runs it: no flush on hart 3, and the child
executes T1. On a StarFive JH7110 (VisionFive 2, non-coherent icache)
running v7.3-rc6, 149 of 150 iterations over three hart pairs execute
stale instructions. A control run that executes fence.i in the child
before the last mapping gets 0 of 50.

Keep the per-mm flush and make the skip decision per mm instead:
count the flushes that set the bit in a global generation, and let
every mm remember the generation of its own last flush taken in
flush_icache_pte(). An mm whose generation lags cannot trust any bit
set since, so it flushes its own harts once (local fence.i, IPIs only
to the harts currently running it, deferred fence.i for the rest) and
catches up. No global flush is issued, nothing happens while no new
executable folio is written, and the cost is bounded by one
flush_icache_mm() per mm per generation bump.

With the fix the reproducer executes 0 of 150 stale iterations on the
same board. The function-call IPI counters stay at a few hundred per
hart for the whole boot plus 200 iterations, i.e. the IPI savings of
the per-mm flush are kept.

Tested on the JH7110 with v7.3-rc6 and this patch; not tested on
32-bit. The bug does not reproduce under QEMU TCG, which invalidates
translated code on page writes.

Fixes: 01261e24cfab ("riscv: Only flush the mm icache when setting an exec pte")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Nickolai Zeldovich <nickolai@csail.mit.edu>
---
 arch/riscv/include/asm/mmu.h         |  2 ++
 arch/riscv/include/asm/mmu_context.h |  1 +
 arch/riscv/mm/cacheflush.c           | 20 ++++++++++++++++++++
 3 files changed, 23 insertions(+)

diff --git a/arch/riscv/include/asm/mmu.h b/arch/riscv/include/asm/mmu.h
index cf8e6eac77d5..e0e7a310151c 100644
--- a/arch/riscv/include/asm/mmu.h
+++ b/arch/riscv/include/asm/mmu.h
@@ -21,6 +21,8 @@ typedef struct {
 	cpumask_t icache_stale_mask;
 	/* Force local icache flush on all migrations. */
 	bool force_icache_flush;
+	/* icache_folio_gen at this mm's last flush in flush_icache_pte(). */
+	u64 icache_gen;
 #endif
 #ifdef CONFIG_BINFMT_ELF_FDPIC
 	unsigned long exec_fdpic_loadmap;
diff --git a/arch/riscv/include/asm/mmu_context.h b/arch/riscv/include/asm/mmu_context.h
index dbf27a78df6c..cc0f7f65ec8b 100644
--- a/arch/riscv/include/asm/mmu_context.h
+++ b/arch/riscv/include/asm/mmu_context.h
@@ -32,6 +32,7 @@ static inline int init_new_context(struct task_struct *tsk,
 {
 #ifdef CONFIG_MMU
 	atomic_long_set(&mm->context.id, 0);
+	mm->context.icache_gen = 0;
 #endif
 	if (IS_ENABLED(CONFIG_RISCV_ISA_SUPM))
 		clear_bit(MM_CONTEXT_LOCK_PMLEN, &mm->context.flags);
diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
index f8ead7cb7c7d..880c210dbfec 100644
--- a/arch/riscv/mm/cacheflush.c
+++ b/arch/riscv/mm/cacheflush.c
@@ -97,13 +97,33 @@ void flush_icache_mm(struct mm_struct *mm, bool local)
 #endif /* CONFIG_SMP */
 
 #ifdef CONFIG_MMU
+/*
+ * PG_dcache_clean is folio-wide, but flush_icache_mm() only reaches the
+ * harts of one mm.  Count the flushes that set the bit; an mm whose
+ * generation lags cannot trust a bit set since its own last flush, so it
+ * flushes its harts once before relying on it.
+ */
+static atomic64_t icache_folio_gen = ATOMIC64_INIT(0);
+
 void flush_icache_pte(struct mm_struct *mm, pte_t pte)
 {
 	struct folio *folio = page_folio(pte_page(pte));
+	u64 gen;
 
 	if (!test_bit(PG_dcache_clean, &folio->flags.f)) {
+		gen = atomic64_inc_return(&icache_folio_gen);
 		flush_icache_mm(mm, false);
+		WRITE_ONCE(mm->context.icache_gen, gen);
 		set_bit(PG_dcache_clean, &folio->flags.f);
+		return;
+	}
+
+	/* Pairs with the fully ordered atomic64_inc_return() above. */
+	smp_rmb();
+	gen = atomic64_read(&icache_folio_gen);
+	if (unlikely(READ_ONCE(mm->context.icache_gen) != gen)) {
+		flush_icache_mm(mm, false);
+		WRITE_ONCE(mm->context.icache_gen, gen);
 	}
 }
 #endif /* CONFIG_MMU */
-- 
2.56.0

