Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795805906;
	b=f7U20rDtaIEt9ZSkZQrVw7zVr7tYn6ytwxP6uj0NsLiVeX9t1qqHHQ/sDt3E2j8cmjxQ
	 qO4uduoDUmy4HpQEDABpcy/OiX0/Y+Yy48P2aTMo+a2ALuucoTxBA6dEL+tZqwRoydkzu
	 XnFownEmghcltcO5b/TEBTcrhxJddLksSWV6fw9zYM1BEKKsHm8X7x1FtV89iJEQSW7uT
	 PHoo4jNzAVKMxBLHZe/jQoopO4B9qGPCEsXsMsImRSurCLucmxJk5VxCVIZZebsE1BbsI
	 ZTI3axjUGe4yvwpgrNqkeUxK+5rwjjOoLB9TiSHr+jZa/X96oYWwQIXZq2S4+uNEpPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795805906;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MfSMwXSAWBd4ItZsKrFa1iXIKNYRq7JCuBaisKgh7Hs=;
	b=i11IbIUVrc/ZYopA9af2wqVh6dZmCio89peLuAwO5sJgsHIu5kYVq+3VVtmhJ1ZrnZgD
	 AUkcBUWlfMcCXDMlm+aEziF+OrbGdx2LQ+YVxjr5K4OZ8ga8D2mAyvvGgyfME0lDiQ2LZ
	 Zkh8lZuSD1hzdB9ol66HVyRW5p4A4xkfIWvNWzI0BSqyesN74TnMYM52jQRp0QnJgPkp1
	 T+pt9RGkOisMyCBv1ec6xtZivQ/Gbo5BxxMn6RUQvsgx0RLefgWxbtN3yfPC9VqjndqJl
	 RbEPJS1FswTlWG4BZtFzY6/PFX5X4ZL7fC6sHkjnl8TKyNE6r/83PR7wOc9CdouFuPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=OPlFvYzz;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481F9606A33F;
	Fri, 27 Nov 2026 18:58:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 481F9606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=OPlFvYzz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1795805904;
	bh=MfSMwXSAWBd4ItZsKrFa1iXIKNYRq7JCuBaisKgh7Hs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OPlFvYzzl3RmkV8UMP+tCuHl/Mi7Vj3h4K72V4BBi8JAUkJj+qnDr5SZL0md5zT1X
	 e2vF0H7dHrA2TeAUNQHK6xQupxtCFdsspq4XbF13ymRy3qwaLR8JtCEIxM/H9G8RUQ
	 R7gfEP3HPdhLkJJnZOYVhbGdO4Sa7srSKOjtG8sjJIjzfa9yidQk4oVIIse5sEpW9a
	 xVCjB00i08USYHQnXLG4/PMm8EqYubua7yhlvBswwNcO3J9UfDVnOjMz2lEvFZQLXx
	 ezW6PVhhstByCqxnPj/yyVepBgZFqvHDyxSZ0AmOkah+JpXhpXyXF1vuOMOEI94hUc
	 2CJ5Wo4650h6w==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jbjNw4MTyzXWx;
	Fri, 27 Nov 2026 13:58:24 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 08/16] LoongArch: membarrier: Add full memory barrier in switch_mm()
Date: Fri, 27 Nov 2026 13:58:13 -0500
Message-ID: <20261127185822.158216-9-mathieu.desnoyers@efficios.com>
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

LoongArch has no dedicated barrier. It used to get it from
spin_unlock() in finish_lock_switch(), which was a full barrier
("dbar 0").

This is no longer true. Commit e031a5f3f1ed ("LoongArch: Support dbar
with different hints") made smp_store_release() an ordering barrier
("dbar 0b10010"). It does not order a previous store with a following
load. That commit kept a full barrier in queued_spin_unlock(). Commit
9c68ece8b2a5 ("LoongArch: Define the __io_aw() hook as mmiowb()") then
removed it.

Nothing else is a full barrier on a switch between two user
processes. switch_mm_irqs_off() writes CSRs and sets a bit in the mm
cpumask with a plain "amor". finish_task() uses smp_store_release().

The LoongArch manual lists the instructions which order memory
accesses: DBAR, IBAR, the AM*_DB instructions and LL/SC pairs. A CSR
write and ERTN are not among them.

This was found by reading the code and the architecture manual. On
Loongson-3A6000 or newer, a thread which is scheduled in would run
user-space code without the barrier which membarrier promised to the
caller. User-space would see a memory ordering failure: the caller of
an expedited membarrier command would miss a recent store of that
thread. Older processors treat every dbar hint as "dbar 0" and are not
affected.

Do as powerpc and riscv: add membarrier_arch_switch_mm() and call it
from switch_mm_irqs_off() when the mm changes. It issues smp_mb()
only when the next mm registered for an expedited command.

Compile-tested only.

Fixes: 9c68ece8b2a5 ("LoongArch: Define the __io_aw() hook as mmiowb()")
Cc: stable@vger.kernel.org
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 arch/loongarch/Kconfig                   |  1 +
 arch/loongarch/include/asm/membarrier.h  | 33 ++++++++++++++++++++++++
 arch/loongarch/include/asm/mmu_context.h |  4 +++
 3 files changed, 38 insertions(+)
 create mode 100644 arch/loongarch/include/asm/membarrier.h

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index b5ed4881d3c0..be6e7545d646 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -22,6 +22,7 @@ config LOONGARCH
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_KERNEL_FPU_SUPPORT if 64BIT && CPU_HAS_FPU
+	select ARCH_HAS_MEMBARRIER_CALLBACKS
 	select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PREEMPT_LAZY
diff --git a/arch/loongarch/include/asm/membarrier.h b/arch/loongarch/include/asm/membarrier.h
new file mode 100644
index 000000000000..1789f878821f
--- /dev/null
+++ b/arch/loongarch/include/asm/membarrier.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _ASM_LOONGARCH_MEMBARRIER_H
+#define _ASM_LOONGARCH_MEMBARRIER_H
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
+	 * smp_store_release() are ordering barriers ("dbar 0b10010"):
+	 * they do not order a previous store with a following load.
+	 */
+	smp_mb();
+}
+
+#endif /* _ASM_LOONGARCH_MEMBARRIER_H */
diff --git a/arch/loongarch/include/asm/mmu_context.h b/arch/loongarch/include/asm/mmu_context.h
index 304363bd3935..dba62dd7a131 100644
--- a/arch/loongarch/include/asm/mmu_context.h
+++ b/arch/loongarch/include/asm/mmu_context.h
@@ -9,6 +9,7 @@
 
 #include <linux/errno.h>
 #include <linux/sched.h>
+#include <linux/sched/mm.h>
 #include <linux/mm_types.h>
 #include <linux/smp.h>
 #include <linux/slab.h>
@@ -91,6 +92,9 @@ static inline void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *
 	bool need_flush = false;
 	unsigned int cpu = smp_processor_id();
 
+	if (prev != next)
+		membarrier_arch_switch_mm(prev, next, tsk);
+
 	/* Check if our ASID is of an older version and thus invalid */
 	if (!asid_valid(next, cpu))
 		get_new_mmu_context(next, cpu, &need_flush);
-- 
2.47.3

