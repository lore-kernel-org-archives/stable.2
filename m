Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563423A9D9F;
	Sat, 10 Oct 2026 15:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.30.2.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791647482; cv=none; b=URhh2Er4xgilLw/qP1yeg9iNVjyedMQjLdS9SYR00YGoqmDmXGE3KuKTw02cTHN9ZW8mUgDUf5GdqpVNVVPp7OLXKjeYOIQKm0+bWoCC+BupBX5EwBdI/3Dlej5a6POKnddEn/U0NHCDgDh6vyQ62xQtipolYlcn4u4WvDf/nOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791647482; c=relaxed/simple;
	bh=tZzRs13+CJksvRCfOzQ1hapjF2TyklaUq1YoJj4pFwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GhTXHP+0pwc+vBVx8W6IDpmldpoH0xBIuekrZBCCvXLh9hrg3tupSVA8QnJrcPhmsIQU2p3OqWGtIeGrLNWOydHgJpl36CbQjd7xPutVuJVyOfBfVJWpoRVS1PMi8B5+HRHx08YM2X13Wy4opJhl0CUuw0kKwarnsPiBZOXRH8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu; spf=pass smtp.mailfrom=csail.mit.edu; arc=none smtp.client-ip=128.30.2.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csail.mit.edu
Received: from escalante.csail.mit.edu ([128.52.128.198])
	by outgoing2021.csail.mit.edu with esmtp (Exim 4.95)
	(envelope-from <nickolai@csail.mit.edu>)
	id 1xFZLq-006Qu6-P8;
	Sat, 10 Oct 2026 11:51:10 -0400
From: Nickolai Zeldovich <nickolai@csail.mit.edu>
To: linux-riscv@lists.infradead.org
Cc: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	jszhang@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Nickolai Zeldovich <nickolai@csail.mit.edu>
Subject: [PATCH v3] riscv: Fix icache flush being skipped for a second mm mapping an exec folio
Date: Sat, 10 Oct 2026 11:51:10 -0400
Message-ID: <20261010155110.764010-1-nickolai@csail.mit.edu>
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

Reproducer:

  /* Build with the kernel's nolibc (after "make headers_install"):
   *   clang --target=riscv64-linux-gnu -Os -static -nostdlib -nostdinc \
   *     -I tools/include/nolibc -I usr/include -include nolibc.h \
   *     -o icache_repro repro.c
   * Usage: ./icache_repro <file> <hartA> <hartB> [iterations]
   */
  #define N 1000    /* li a0,0; N x addi a0,a0,v; ret: returns N*v */
  static unsigned int text[N + 2];
  static int fd;

  static void write_text(unsigned int v)
  {
      int i;

      text[0] = 0x00000513;
      for (i = 1; i <= N; i++)
          text[i] = 0x00050513 | (v << 20);
      text[N + 1] = 0x00008067;
      lseek(fd, 0, SEEK_SET);
      write(fd, text, sizeof(text));
  }

  static long run_text(void)
  {
      long (*f)(void) = mmap(NULL, 4096, PROT_READ | PROT_EXEC,
                     MAP_PRIVATE, fd, 0);
      long r = f();

      munmap(f, 4096);
      return r;
  }

  static void pin(const char *cpu)
  {
      unsigned long mask = 1UL << atoi(cpu);

      syscall(__NR_sched_setaffinity, 0, sizeof(mask), &mask);
  }

  int main(int argc, char **argv)
  {
      int p2c[2], c2p[2], i, stale = 0;
      int iters = argc > 4 ? atoi(argv[4]) : 50;
      long got;
      char c;

      fd = open(argv[1], O_RDWR | O_CREAT | O_TRUNC, 0755);
      pipe(p2c);
      pipe(c2p);
      pin(argv[2]);
      if (!fork()) {            /* child = mm B on hart B */
          close(p2c[1]);
          pin(argv[3]);
          while (read(p2c[0], &c, 1) == 1) {
              got = run_text();
              write(c2p[1], &got, sizeof(got));
          }
          _exit(0);
      }
      for (i = 0; i < iters; i++) {    /* parent = mm A on hart A */
          write_text(1);
          write(p2c[1], "", 1);    /* B runs T1: primes hart B */
          read(c2p[0], &got, sizeof(got));
          write_text(2);
          run_text();        /* A runs T2: flushes hart A, sets the bit */
          write(p2c[1], "", 1);    /* B runs again: no flush on hart B */
          read(c2p[0], &got, sizeof(got));
          stale += got != 2 * N;
      }
      close(p2c[1]);
      wait(NULL);
      printf("%d of %d iterations stale\n", stale, iters);
      return !!stale;
  }

The parent (mm A, hart A) and the child (mm B, hart B) share a file.
Each iteration: A writes text T1, B maps it executable and runs it
(priming hart B's icache with T1) and unmaps it; A writes text T2 and
maps and runs it (per-mm flush of hart A only, bit set); B maps and
runs it again, with no flush on hart B, and executes T1. On a StarFive
JH7110 (VisionFive 2, non-coherent icache) running v7.3-rc6, 148 of
150 iterations over three hart pairs (50 each on harts 0/3, 0/2 and
1/3) execute stale instructions.

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
hart for the whole boot plus the 150 iterations, i.e. the IPI savings
of the per-mm flush are kept.

The generation is kept per mm as an atomic64_t so that the field is
read and written atomically on 32-bit as well, and the whole mechanism
is compiled only with CONFIG_SMP and CONFIG_MMU: on a single hart
flush_icache_mm() is the local flush and the bug cannot occur, and
without an MMU there is no flush_icache_pte() and no second mapping of
a written page to begin with.

Tested on the JH7110 with v7.3-rc6 and this patch; not tested on
32-bit. The bug does not reproduce under QEMU TCG, which invalidates
translated code on page writes.

Fixes: 01261e24cfab ("riscv: Only flush the mm icache when setting an exec pte")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Nickolai Zeldovich <nickolai@csail.mit.edu>
---

Notes:
    v3: compile the generation logic only with CONFIG_SMP (on UP the bug cannot
        occur and flush_icache_mm() is the local flush) and CONFIG_MMU (the only
        user is flush_icache_pte()); keep the per-mm
        generation in an atomic64_t so it is read and written atomically on
        32-bit too; add the reproducer to the commit message (Jisheng Zhang).
    v2: move icache_gen out of the CONFIG_SMP block of mm_context_t; v1 did
        not build with CONFIG_SMP=n (kernel test robot).

 arch/riscv/include/asm/mmu.h         |  4 +++
 arch/riscv/include/asm/mmu_context.h |  3 +++
 arch/riscv/mm/cacheflush.c           | 38 ++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+)

diff --git a/arch/riscv/include/asm/mmu.h b/arch/riscv/include/asm/mmu.h
index cf8e6eac77d5..4eacf06f7d2a 100644
--- a/arch/riscv/include/asm/mmu.h
+++ b/arch/riscv/include/asm/mmu.h
@@ -21,6 +21,10 @@ typedef struct {
 	cpumask_t icache_stale_mask;
 	/* Force local icache flush on all migrations. */
 	bool force_icache_flush;
+#ifdef CONFIG_MMU
+	/* icache_folio_gen at this mm's last flush in flush_icache_pte(). */
+	atomic64_t icache_gen;
+#endif
 #endif
 #ifdef CONFIG_BINFMT_ELF_FDPIC
 	unsigned long exec_fdpic_loadmap;
diff --git a/arch/riscv/include/asm/mmu_context.h b/arch/riscv/include/asm/mmu_context.h
index dbf27a78df6c..909404fb250b 100644
--- a/arch/riscv/include/asm/mmu_context.h
+++ b/arch/riscv/include/asm/mmu_context.h
@@ -32,6 +32,9 @@ static inline int init_new_context(struct task_struct *tsk,
 {
 #ifdef CONFIG_MMU
 	atomic_long_set(&mm->context.id, 0);
+#ifdef CONFIG_SMP
+	atomic64_set(&mm->context.icache_gen, 0);
+#endif
 #endif
 	if (IS_ENABLED(CONFIG_RISCV_ISA_SUPM))
 		clear_bit(MM_CONTEXT_LOCK_PMLEN, &mm->context.flags);
diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
index f8ead7cb7c7d..00bfdb7c487c 100644
--- a/arch/riscv/mm/cacheflush.c
+++ b/arch/riscv/mm/cacheflush.c
@@ -97,13 +97,51 @@ void flush_icache_mm(struct mm_struct *mm, bool local)
 #endif /* CONFIG_SMP */
 
 #ifdef CONFIG_MMU
+#ifdef CONFIG_SMP
+/*
+ * PG_dcache_clean is folio-wide, but flush_icache_mm() only reaches the
+ * harts of one mm.  Count the flushes that set the bit; an mm whose
+ * generation lags cannot trust a bit set since its own last flush, so it
+ * flushes its harts once before relying on it.
+ */
+static atomic64_t icache_folio_gen = ATOMIC64_INIT(0);
+
+static u64 icache_gen_bump(void)
+{
+	return atomic64_inc_return(&icache_folio_gen);
+}
+
+static bool icache_gen_stale(struct mm_struct *mm, u64 *gen)
+{
+	/* Pairs with the fully ordered atomic64_inc_return() in icache_gen_bump(). */
+	smp_rmb();
+	*gen = atomic64_read(&icache_folio_gen);
+	return atomic64_read(&mm->context.icache_gen) != *gen;
+}
+
+static void icache_gen_set(struct mm_struct *mm, u64 gen)
+{
+	atomic64_set(&mm->context.icache_gen, gen);
+}
+#else
+static u64 icache_gen_bump(void) { return 0; }
+static bool icache_gen_stale(struct mm_struct *mm, u64 *gen) { return false; }
+static void icache_gen_set(struct mm_struct *mm, u64 gen) { }
+#endif
+
 void flush_icache_pte(struct mm_struct *mm, pte_t pte)
 {
 	struct folio *folio = page_folio(pte_page(pte));
+	u64 gen;
 
 	if (!test_bit(PG_dcache_clean, &folio->flags.f)) {
+		gen = icache_gen_bump();
 		flush_icache_mm(mm, false);
+		icache_gen_set(mm, gen);
 		set_bit(PG_dcache_clean, &folio->flags.f);
+	} else if (unlikely(icache_gen_stale(mm, &gen))) {
+		flush_icache_mm(mm, false);
+		icache_gen_set(mm, gen);
 	}
 }
 #endif /* CONFIG_MMU */

base-commit: af32da41b0327b9c6a37856ba82b6760d6c8d10e
-- 
2.55.0

