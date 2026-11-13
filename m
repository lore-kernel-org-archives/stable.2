Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794575958;
	b=uexu3ip0bOmpHMJ5WAi6HlSYcLENdN44RNnUvPtO8C5XM2HBgTXUOZrsmASPfeuUfDPo
	 1a97UMO+ISRpMM6GrZz9MtNpQhUgI7Lyb8tH/7Hi7Sl6H8+fT9EHeszQWTQBMcGEGsTkv
	 z0uaT0w9+FwGVkzCIO2cG6CdUbZYbir5qLoWwgqfrppsdpzr2ZytObfmriOhbKUtYU5ce
	 wXlYDWZK2QitEm3x30yNnPYBC2s0IR4xXChxsoB+9TQ4wC5dqTSlAVs898FE4fD8n1OJK
	 1a8Nb7YkkVwj8Rw6UWcgklnEKjV/XYl8aP1/dFQBbT7xc6RLVbJgYQ4SGFtUN1w8cQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794575958;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WJKqb9lbHcL4EmdzdUnYQ7GHUDciH6wBpPPSXp/2ZaA=;
	b=LED6dsMiZsrf/lORBVpfcD6uCEuWHIVMMKQgIepKrKF+5tFJUM7zi/RZpy7aHA5lUjzb
	 +B9v8SgdqHzTiDfcE2mfOTntF4uOJaEYfQ+j8ZJrzuaKpOOeIgbxlTYPF28vmWxFsfqhg
	 3/7QIUqC1sJrwhK/AO4tuzr8UOvtBaUtEMsIacj/Lm0+A2iwCwihD2vzOrsOLmAMzkFIO
	 cIq6SL6AHI6IwX00eazKrfufgtjtX/6GD1HhNkFgZHQE3FhuiCRMoFnDfGFk/8Bbb1clp
	 ksFbu+MJCEZU6Qnp/F/axjcIWt2ZrbktT7EqHt92Mr4nS9h1bdU2F8v3DWtdIFABsLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=GeDgDgQk;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83DC60A263D;
	Fri, 13 Nov 2026 13:19:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A83DC60A263D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=GeDgDgQk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1794575950;
	bh=WJKqb9lbHcL4EmdzdUnYQ7GHUDciH6wBpPPSXp/2ZaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GeDgDgQkhR8H9wrXhxpw3EnCLN1j0ZFk8vSEPiUbspOyaGv/SrVqoNp4Q6LumzqwG
	 AAhagJzJ2QLF2eSBqqFbyZqT0vgWIPKDGr6xh+xBb8xBeLkHI83+xGvZt9qISZP7k5
	 j4QCTqmLkvyRbQlvJ0gEcXXZ9foq9oUddml5KAaUQRU/1VxtCkkeyC8fUY/3IEzSXH
	 PX+lbE9tbLLQFTKGEN8vUJUZHOZNDu0NxbddxuHnhs7K2m6509TENkc9D6SNl/CAvR
	 z1ZQuXfiM5ap5TcLM+C/ezNtxxiwsTkzpmwj+jGY+JAMcJx509VBQ8DgIHjdhnh1te
	 okrhdLYQjnMFA==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jQyWy5LwhzQ2k;
	Fri, 13 Nov 2026 08:19:10 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Michal Clapinski <mclapinski@google.com>,
	Andrei Vagin <avagin@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Aniket Gattani <aniketgattani@google.com>,
	linux-kselftest@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Gellermann <christian.gellermann@codasip.com>,
	Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>,
	Wei Yang <richard.weiyang@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>,
	John David Anglin <dave.anglin@bell.net>,
	linux-parisc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Guo Ren <guoren@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-csky@vger.kernel.org,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,
	linux-openrisc@vger.kernel.org,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-sh@vger.kernel.org,
	Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>,
	linux-arch@vger.kernel.org,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Andy Lutomirski <luto@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Andrea Parri <parri.andrea@gmail.com>,
	Boqun Feng <boqun@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	David Howells <dhowells@redhat.com>,
	Jade Alglave <j.alglave@ucl.ac.uk>,
	Luc Maranget <luc.maranget@inria.fr>,
	Akira Yokosawa <akiyks@gmail.com>,
	Daniel Lustig <dlustig@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	lkmm@lists.linux.dev,
	bpf@vger.kernel.org,
	Naveen N Rao <naveen@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [RFC PATCH 09/16] parisc: membarrier: Add full memory barrier in switch_mm()
Date: Fri, 13 Nov 2026 08:18:56 -0500
Message-Id: <20261113131903.157186-10-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261113131903.157186-1-mathieu.desnoyers@efficios.com>
References: <20261113131903.157186-1-mathieu.desnoyers@efficios.com>
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

