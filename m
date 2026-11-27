Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795805907;
	b=QKrqrx9yPVNx4T7jmBwvp279cATFxWHWc4ainDv/i9sPn78PXx7m+csdZnP/jaObCOta
	 Fjg3WplsZMtEeAqRthr2t83iRPA+BUuGFF+IkbnmRf2AVWSsIktzP5nt4Ckw7l8K/kGPu
	 dDsQw1XoSkGSISbzhanmK3HpxovDy9OMBIhs6kS9gql7EvZ76+iTByqE+gDDUNr40I76E
	 Zn1dF3dUQRsfSJKWn4hlEFHfyrkje9asW8q7+hyb79Pv5kPbGoBAYFwFMZzBQZEZvDEU6
	 4sQCMVhD2T7mRM1FzEegtUXtTE6ob1HtCnHWJHTm3bM9OnYZLrVCExH65ScDy7Sd8dQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795805907;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WJKqb9lbHcL4EmdzdUnYQ7GHUDciH6wBpPPSXp/2ZaA=;
	b=rlEpL+3bBdzoH61X3CkNJNjSS5wSxgk7GIcQGWuJ7e8SwdCg7hPy9ZjmHz5cDBLZvZgh
	 w6icq3LpCLiGVt0LDY04SEHS8y42i8+JlZ0PuIOuhhyhLAgQlt9BWNnei6JKJXVfAb/6a
	 Oop/ZL0QyI9oV9iX2tO3s92O6eR7Xw/2xKASE5DePdCfJvC+6gtbn7i1jy0Te4eKB3WQ3
	 PkaOey5pMe0Ea08qIqR45d09qz/YHAAfYsuWiIykawjkETG7EdrpQnPGxn+AyoPGFNqq7
	 S5XvHc56nEWXHKQzOIgWde1K+fGrB6bwqaEP16kIMbNfAxJETqeN8DnbRsxbXwfiAsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=vM+4BJa0;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFA2606A699;
	Fri, 27 Nov 2026 18:58:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEFA2606A699
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=vM+4BJa0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1795805904;
	bh=WJKqb9lbHcL4EmdzdUnYQ7GHUDciH6wBpPPSXp/2ZaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vM+4BJa0IXxhOEjNMnoaK0yrLGfroaMjK+73E8nvuQzh1T038N4Q6RQRo71UN6WbY
	 Z5lh1/iGHMEo92AO0EKNdbVuDTtd/id2K2wCC47ds6I+g7g/b6ZOWYO5UGqRFJ+tPA
	 WNVEdNCF/ltr1HRzu6Ev8gn0IBYE3IK0wqU4imHqP+PofOadRXGWX2BJvjhyg6BgTB
	 O/xekds9NRnux3qZNm8zm8MfjKp3ItMGRuQjvs/wguUpIc9Aj4fp+RAUZmLVFcb8Ve
	 5WWgb/3coHwC+LVt3hSQh7SSX6FPxakR+syJ7d2oIY0zlcPvzlZOghx0CnFoyj6FSA
	 ZW17HYle2emzg==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jbjNw5DLlzXWy;
	Fri, 27 Nov 2026 13:58:24 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	John David Anglin <dave.anglin@bell.net>,
	linux-parisc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 09/16] parisc: membarrier: Add full memory barrier in switch_mm()
Date: Fri, 27 Nov 2026 13:58:14 -0500
Message-ID: <20261127185822.158216-10-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261127185822.158216-1-mathieu.desnoyers@efficios.com>
References: <20261127185822.158216-1-mathieu.desnoyers@efficios.com>
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

The expedited membarrier commands need a full memory barrier after
the scheduler stores to rq->curr, before the CPU returns to
user-space. membarrier() skips the IPI to a CPU which it sees running
another mm. This barrier orders the user-space accesses of the
incoming thread after that check. See scenario (A) in
kernel/sched/membarrier.c.

parisc has no dedicated barrier. It used to get it from
smp_store_release() in finish_task() and from spin_unlock() in
finish_lock_switch(). The first one issued a SYNC instruction. The
second one issued an LDCW instruction, which is strongly ordered.

Both are ordered stores since v5.9:

 - commit 157e9afcc4fa ("Revert "parisc: Revert "Release spinlocks
   using ordered store"""),
 - commit e96ebd589deb ("parisc: Implement __smp_store_release and
   __smp_load_acquire barriers").

Linux runs with the PSW O bit clear. The PA-RISC 2.0 architecture
then allows plain loads and stores to be weakly ordered. It orders an
ordered store before a following ordered load, not before a following
plain load. So an ordered store is not a full barrier.

Nothing else is a full barrier on a switch between two user
processes. switch_mm_irqs_off() only writes control and space
registers.

The PA-RISC 2.0 manual lists the strongly ordered accesses: I/O
space, pages with the TLB U-bit set, LDCW, LDCD, the TLB purges and
SYNC. MTCTL, MTSP and RFI are not among them.

This was found by reading the code and the architecture manual. On a
PA-RISC 2.0 SMP machine, a thread which is scheduled in would run
user-space code without the promised barrier. User-space would see a
memory ordering failure: the caller of an expedited membarrier command
would miss a recent store of that thread. PA-RISC 1.1 is strongly
ordered and not affected.

Do as powerpc and riscv: add membarrier_arch_switch_mm() and call it
from switch_mm_irqs_off() when the mm changes. It issues smp_mb()
only when the next mm registered for an expedited command.

Compile-tested only.

Fixes: 157e9afcc4fa ("Revert "parisc: Revert "Release spinlocks using ordered store""")
Fixes: e96ebd589deb ("parisc: Implement __smp_store_release and __smp_load_acquire barriers")
Cc: stable@vger.kernel.org
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 arch/parisc/Kconfig                   |  1 +
 arch/parisc/include/asm/membarrier.h  | 33 +++++++++++++++++++++++++++
 arch/parisc/include/asm/mmu_context.h |  2 ++
 3 files changed, 36 insertions(+)
 create mode 100644 arch/parisc/include/asm/membarrier.h

diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index 77f67028ad89..3d6b4cc8d6a5 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -13,6 +13,7 @@ config PARISC
 	select ARCH_HAS_DMA_ALLOC if PA11
 	select ARCH_HAS_DMA_OPS
 	select ARCH_HAS_ELF_RANDOMIZE
+	select ARCH_HAS_MEMBARRIER_CALLBACKS
 	select ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_HAS_STRICT_MODULE_RWX
 	select ARCH_HAS_UBSAN
diff --git a/arch/parisc/include/asm/membarrier.h b/arch/parisc/include/asm/membarrier.h
new file mode 100644
index 000000000000..822dcadaf9bb
--- /dev/null
+++ b/arch/parisc/include/asm/membarrier.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _ASM_PARISC_MEMBARRIER_H
+#define _ASM_PARISC_MEMBARRIER_H
+
+static inline void membarrier_arch_switch_mm(struct mm_struct *prev,
+					     struct mm_struct *next,
+					     struct task_struct *tsk)
+{
+	/*
+	 * Only need the full barrier when switching between processes.
+	 * Barrier when switching from kernel to userspace is not
+	 * required here, given that it is implied by mmdrop(). Barrier
+	 * when switching from userspace to kernel is not needed after
+	 * store to rq->curr.
+	 */
+	if (IS_ENABLED(CONFIG_SMP) &&
+	    likely(!(atomic_read(&next->membarrier_state) &
+		     (MEMBARRIER_STATE_PRIVATE_EXPEDITED |
+		      MEMBARRIER_STATE_GLOBAL_EXPEDITED))))
+		return;
+
+	/*
+	 * The membarrier system call requires a full memory barrier
+	 * after storing to rq->curr, before going back to user-space.
+	 *
+	 * Nothing else provides it on this path. spin_unlock() and
+	 * smp_store_release() are ordered stores. PA-RISC 2.0 does not
+	 * order an ordered store with a following weakly ordered load.
+	 */
+	smp_mb();
+}
+
+#endif /* _ASM_PARISC_MEMBARRIER_H */
diff --git a/arch/parisc/include/asm/mmu_context.h b/arch/parisc/include/asm/mmu_context.h
index c9187fe836a3..42ff1b9444f1 100644
--- a/arch/parisc/include/asm/mmu_context.h
+++ b/arch/parisc/include/asm/mmu_context.h
@@ -4,6 +4,7 @@
 
 #include <linux/mm.h>
 #include <linux/sched.h>
+#include <linux/sched/mm.h>
 #include <linux/atomic.h>
 #include <linux/spinlock.h>
 #include <asm-generic/mm_hooks.h>
@@ -51,6 +52,7 @@ static inline void switch_mm_irqs_off(struct mm_struct *prev,
 		struct mm_struct *next, struct task_struct *tsk)
 {
 	if (prev != next) {
+		membarrier_arch_switch_mm(prev, next, tsk);
 #ifdef CONFIG_TLB_PTLOCK
 		/* put physical address of page_table_lock in cr28 (tr4)
 		   for TLB faults */
-- 
2.47.3

