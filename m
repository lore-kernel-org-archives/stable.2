Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C9143DED4;
	Sat, 10 Oct 2026 11:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.30.2.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791632152; cv=none; b=nmMckzv/Y7N92hrhrSjxrb00ARDV4S0INzfjfJqOuY7DAyQkIdYHORYUCAEMYHOUO6NYT1jkdXz3zxzY/I/6Bx3WJnjrXErm36xisQxPcm31+Y8DIx1yLH2VG29s5dFiw8lQJp+PoNYN6S4kKI+j3Z4sAxt7W6tsWQr082J5Eng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791632152; c=relaxed/simple;
	bh=CN+SEydKJGRVb0h/yu3dlJNzUjVmrArfG2gLA9h74Xs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cQRrwfKoGIkW9qdqlzJNGMkJTMGq1U4A1QDUgWNOPvw3WIuBCnzZAQgyFY+uxgGLie8y6sTZi0WHMqJqSfxdUeAYdW6osI+iuED3oh2XQdVB1sjxjgWpFZhx4t4IqEGZ01tNdmou15UA3fMOtwmIB/upYr3KBqWhP09gunLSeeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu; spf=pass smtp.mailfrom=csail.mit.edu; arc=none smtp.client-ip=128.30.2.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csail.mit.edu
Received: from escalante.csail.mit.edu ([128.52.128.198])
	by outgoing2021.csail.mit.edu with esmtp (Exim 4.95)
	(envelope-from <nickolai@csail.mit.edu>)
	id 1xFVMV-005f7g-FD;
	Sat, 10 Oct 2026 07:35:35 -0400
From: Nickolai Zeldovich <nickolai@csail.mit.edu>
To: linux-riscv@lists.infradead.org
Cc: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Nickolai Zeldovich <nickolai@csail.mit.edu>
Subject: [PATCH v2] riscv: Fix icache flush being skipped for a second mm mapping an exec folio
Date: Sat, 10 Oct 2026 07:35:35 -0400
Message-ID: <20261010113535.763451-1-nickolai@csail.mit.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009221957.760606-1-nickolai@csail.mit.edu>
References: <20261009221957.760606-1-nickolai@csail.mit.edu>
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

Notes:
    v2: move icache_gen out of the CONFIG_SMP block of mm_context_t; v1 did
        not build with CONFIG_SMP=n (riscv allnoconfig and a randconfig),
        as reported by the kernel test robot <lkp@intel.com>.

 arch/riscv/include/asm/mmu.h         |  2 ++
 arch/riscv/include/asm/mmu_context.h |  1 +
 arch/riscv/mm/cacheflush.c           | 20 ++++++++++++++++++++
 3 files changed, 23 insertions(+)

diff --git a/arch/riscv/include/asm/mmu.h b/arch/riscv/include/asm/mmu.h
index cf8e6eac77d5..03348e36ea29 100644
--- a/arch/riscv/include/asm/mmu.h
+++ b/arch/riscv/include/asm/mmu.h
@@ -14,6 +14,8 @@ typedef struct {
 	unsigned long	end_brk;
 #else
 	atomic_long_t id;
+	/* icache_folio_gen at this mm's last flush in flush_icache_pte(). */
+	u64 icache_gen;
 #endif
 	void *vdso;
 #ifdef CONFIG_SMP
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

base-commit: af32da41b0327b9c6a37856ba82b6760d6c8d10e
-- 
2.56.0

