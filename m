Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC263101B2
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 13:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788874230; cv=none; b=EouBpS1doU9fIexAsLAElUEyv+SQmFDvrv1vUAQaZqZqqq3f4cCRg7T0lBeNMIPsapDvVw2QZ1k+6n8uEoxscHfuyIpWb0Ou72lR4x5nZNHd2toJvt8hDu3d8KWF62i9hUTA33979x/4V1vJKb9c0vDZpkE113DsTumx6Ok2LkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788874230; c=relaxed/simple;
	bh=XKRs+6TCi738ukl0Gn5Yifdz9gzbQGgs1tb8pUqnNPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V1IZ3OUN4LFWWb2HBnrjiIjNkX79LHHsfrhaO3QvyaD+Ur0lnHtJwdruNPZNxlc0Dao5RdZojbRd2Pn7s4U/8B5hbbfLKlOYStvMDvPKd4V5+AsrFM12NNhE2FJbarZM7kv8wYsN9ximP2J0aFbq1W1oVDcS0f10ub5+d1//pk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E9CA1F00A3A;
	Tue,  8 Sep 2026 13:30:07 +0000 (UTC)
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Uladzislau Rezki <uladzislau.rezki@sony.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Xiongfeng Wang <wangxiongfeng2@huawei.com>,
	Yu Liao <liaoyu15@huawei.com>,
	Phil Auld <pauld@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Alex Belits <abelits@marvell.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Nicolas Saenz Julienne <nsaenzju@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 4/5] context_tracking: Split user tracking Kconfig
Date: Tue,  8 Sep 2026 09:29:55 -0400
Message-ID: <20260908132958.2312212-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908132958.2312212-1-sashal@kernel.org>
References: <2026090326-curtsy-rocket-6c6d@gregkh>
 <20260908132958.2312212-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frederic Weisbecker <frederic@kernel.org>

[ Upstream commit 24a9c54182b3758801b8ca6c8c237cc2ff654732 ]

Context tracking is going to be used not only to track user transitions
but also idle/IRQs/NMIs. The user tracking part will then become a
separate feature. Prepare Kconfig for that.

[ frederic: Apply Max Filippov feedback. ]

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Uladzislau Rezki <uladzislau.rezki@sony.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc: Yu Liao <liaoyu15@huawei.com>
Cc: Phil Auld <pauld@redhat.com>
Cc: Paul Gortmaker<paul.gortmaker@windriver.com>
Cc: Alex Belits <abelits@marvell.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
Tested-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>

[ sashal: Reduced backport -- upstream 24a9c54182b37 touches 25 file(s), this
  backport carries 23. Not backported here:
  arch/loongarch/Kconfig
  arch/xtensa/Kconfig
  arch/xtensa/kernel/entry.S
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 7e8ee82e69fd ("ARM: 9477/1: Disable broken eBPF JIT on the Risc PC")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../time/context-tracking/arch-support.txt    |  6 ++--
 arch/Kconfig                                  |  2 +-
 arch/arm/Kconfig                              |  2 +-
 arch/arm/kernel/entry-common.S                |  4 +--
 arch/arm/kernel/entry-header.S                |  4 +--
 arch/arm64/Kconfig                            |  2 +-
 arch/arm64/kernel/entry.S                     |  4 +--
 arch/csky/Kconfig                             |  2 +-
 arch/csky/kernel/entry.S                      |  4 +--
 arch/mips/Kconfig                             |  2 +-
 arch/powerpc/Kconfig                          |  2 +-
 arch/powerpc/include/asm/context_tracking.h   |  2 +-
 arch/riscv/Kconfig                            |  2 +-
 arch/riscv/kernel/entry.S                     |  6 ++--
 arch/sparc/Kconfig                            |  2 +-
 arch/sparc/kernel/rtrap_64.S                  |  2 +-
 arch/x86/Kconfig                              |  2 +-
 include/linux/context_tracking.h              |  8 ++---
 include/linux/context_tracking_state.h        |  4 +--
 init/Kconfig                                  |  4 +--
 kernel/context_tracking.c                     |  6 +++-
 kernel/sched/core.c                           |  2 +-
 kernel/time/Kconfig                           | 31 ++++++++++++-------
 23 files changed, 59 insertions(+), 46 deletions(-)

diff --git a/Documentation/features/time/context-tracking/arch-support.txt b/Documentation/features/time/context-tracking/arch-support.txt
index 266c81e8a721d..c2bad5394e2a8 100644
--- a/Documentation/features/time/context-tracking/arch-support.txt
+++ b/Documentation/features/time/context-tracking/arch-support.txt
@@ -1,7 +1,7 @@
 #
-# Feature name:          context-tracking
-#         Kconfig:       HAVE_CONTEXT_TRACKING
-#         description:   arch supports context tracking for NO_HZ_FULL
+# Feature name:          user-context-tracking
+#         Kconfig:       HAVE_CONTEXT_TRACKING_USER
+#         description:   arch supports user context tracking for NO_HZ_FULL
 #
     -----------------------
     |         arch |status|
diff --git a/arch/Kconfig b/arch/Kconfig
index 72e4cef062aca..ec88647bb77f6 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -634,7 +634,7 @@ config HAVE_ARCH_WITHIN_STACK_FRAMES
 	  and similar) by implementing an inline arch_within_stack_frames(),
 	  which is used by CONFIG_HARDENED_USERCOPY.
 
-config HAVE_CONTEXT_TRACKING
+config HAVE_CONTEXT_TRACKING_USER
 	bool
 	help
 	  Provide kernel/user boundaries probes necessary for subsystems
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 05fc9c6ee8c5b..5a37758349f0d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -76,7 +76,7 @@ config ARM
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARM_SMCCC if CPU_V7
 	select HAVE_EBPF_JIT if !CPU_ENDIAN_BE32
-	select HAVE_CONTEXT_TRACKING
+	select HAVE_CONTEXT_TRACKING_USER
 	select HAVE_C_RECORDMCOUNT
 	select HAVE_DEBUG_KMEMLEAK if !XIP_KERNEL
 	select HAVE_DMA_CONTIGUOUS if MMU
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 9b3c737575e91..bb64766c6cea2 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -26,7 +26,7 @@
 #include "entry-header.S"
 
 saved_psr	.req	r8
-#if defined(CONFIG_TRACE_IRQFLAGS) || defined(CONFIG_CONTEXT_TRACKING)
+#if defined(CONFIG_TRACE_IRQFLAGS) || defined(CONFIG_CONTEXT_TRACKING_USER)
 saved_pc	.req	r9
 #define TRACE(x...) x
 #else
@@ -36,7 +36,7 @@ saved_pc	.req	lr
 
 	.section .entry.text,"ax",%progbits
 	.align	5
-#if !(IS_ENABLED(CONFIG_TRACE_IRQFLAGS) || IS_ENABLED(CONFIG_CONTEXT_TRACKING) || \
+#if !(IS_ENABLED(CONFIG_TRACE_IRQFLAGS) || IS_ENABLED(CONFIG_CONTEXT_TRACKING_USER) || \
 	IS_ENABLED(CONFIG_DEBUG_RSEQ))
 /*
  * This is the fast syscall return path.  We do as little as possible here,
diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
index 6d103d61c2994..9b6ab720bd79e 100644
--- a/arch/arm/kernel/entry-header.S
+++ b/arch/arm/kernel/entry-header.S
@@ -353,7 +353,7 @@
  * between user and kernel mode.
  */
 	.macro ct_user_exit, save = 1
-#ifdef CONFIG_CONTEXT_TRACKING
+#ifdef CONFIG_CONTEXT_TRACKING_USER
 	.if	\save
 	stmdb   sp!, {r0-r3, ip, lr}
 	bl	user_exit_callable
@@ -365,7 +365,7 @@
 	.endm
 
 	.macro ct_user_enter, save = 1
-#ifdef CONFIG_CONTEXT_TRACKING
+#ifdef CONFIG_CONTEXT_TRACKING_USER
 	.if	\save
 	stmdb   sp!, {r0-r3, ip, lr}
 	bl	user_enter_callable
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 15182435b7a4f..aa775eacd2ea3 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -152,7 +152,7 @@ config ARM64
 	select HAVE_C_RECORDMCOUNT
 	select HAVE_CMPXCHG_DOUBLE
 	select HAVE_CMPXCHG_LOCAL
-	select HAVE_CONTEXT_TRACKING
+	select HAVE_CONTEXT_TRACKING_USER
 	select HAVE_DEBUG_BUGVERBOSE
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DMA_CONTIGUOUS
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 020a455824bed..e58de4270d7f5 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -34,13 +34,13 @@
  * user and kernel mode.
  */
 	.macro user_exit_irqoff
-#if defined(CONFIG_CONTEXT_TRACKING) || defined(CONFIG_TRACE_IRQFLAGS)
+#if defined(CONFIG_CONTEXT_TRACKING_USER) || defined(CONFIG_TRACE_IRQFLAGS)
 	bl	enter_from_user_mode
 #endif
 	.endm
 
 	.macro user_enter_irqoff
-#if defined(CONFIG_CONTEXT_TRACKING) || defined(CONFIG_TRACE_IRQFLAGS)
+#if defined(CONFIG_CONTEXT_TRACKING_USER) || defined(CONFIG_TRACE_IRQFLAGS)
 	bl	exit_to_user_mode
 #endif
 	.endm
diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 7bf0a617e94c3..1318a7b13c1d1 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -41,7 +41,7 @@ config CSKY
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_MMAP_RND_BITS
 	select HAVE_ARCH_SECCOMP_FILTER
-	select HAVE_CONTEXT_TRACKING
+	select HAVE_CONTEXT_TRACKING_USER
 	select HAVE_VIRT_CPU_ACCOUNTING_GEN
 	select HAVE_DEBUG_BUGVERBOSE
 	select HAVE_DYNAMIC_FTRACE
diff --git a/arch/csky/kernel/entry.S b/arch/csky/kernel/entry.S
index a4a5b8a8c21c8..4c23b45f595bc 100644
--- a/arch/csky/kernel/entry.S
+++ b/arch/csky/kernel/entry.S
@@ -24,7 +24,7 @@
 .endm
 
 .macro	context_tracking
-#ifdef CONFIG_CONTEXT_TRACKING
+#ifdef CONFIG_CONTEXT_TRACKING_USER
 	mfcr	a0, epsr
 	btsti	a0, 31
 	bt	1f
@@ -257,7 +257,7 @@ ret_from_exception:
 	and	r10, r9
 	cmpnei	r10, 0
 	bt	exit_work
-#ifdef CONFIG_CONTEXT_TRACKING
+#ifdef CONFIG_CONTEXT_TRACKING_USER
 	jbsr	user_enter_callable
 #endif
 1:
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 57839f63074f7..22a9471a307a6 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -51,7 +51,7 @@ config MIPS
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if CPU_SUPPORTS_HUGEPAGES
 	select HAVE_ASM_MODVERSIONS
 	select HAVE_CBPF_JIT if !64BIT && !CPU_MICROMIPS
-	select HAVE_CONTEXT_TRACKING
+	select HAVE_CONTEXT_TRACKING_USER
 	select HAVE_TIF_NOHZ
 	select HAVE_C_RECORDMCOUNT
 	select HAVE_DEBUG_KMEMLEAK
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 78dd6be8b31dd..41db957c684b2 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -193,7 +193,7 @@ config PPC
 	select HAVE_CBPF_JIT			if !PPC64
 	select HAVE_STACKPROTECTOR		if PPC64 && $(cc-option,-mstack-protector-guard=tls -mstack-protector-guard-reg=r13)
 	select HAVE_STACKPROTECTOR		if PPC32 && $(cc-option,-mstack-protector-guard=tls -mstack-protector-guard-reg=r2)
-	select HAVE_CONTEXT_TRACKING		if PPC64
+	select HAVE_CONTEXT_TRACKING_USER	if PPC64
 	select HAVE_TIF_NOHZ			if PPC64
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DEBUG_STACKOVERFLOW
diff --git a/arch/powerpc/include/asm/context_tracking.h b/arch/powerpc/include/asm/context_tracking.h
index f2682b28b0502..4b63931c49e0e 100644
--- a/arch/powerpc/include/asm/context_tracking.h
+++ b/arch/powerpc/include/asm/context_tracking.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_POWERPC_CONTEXT_TRACKING_H
 #define _ASM_POWERPC_CONTEXT_TRACKING_H
 
-#ifdef CONFIG_CONTEXT_TRACKING
+#ifdef CONFIG_CONTEXT_TRACKING_USER
 #define SCHEDULE_USER bl	schedule_user
 #else
 #define SCHEDULE_USER bl	schedule
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 57753b477ea29..c8640379609ca 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -62,7 +62,7 @@ config RISCV
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ASM_MODVERSIONS
-	select HAVE_CONTEXT_TRACKING
+	select HAVE_CONTEXT_TRACKING_USER
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DMA_CONTIGUOUS if MMU
 	select HAVE_EBPF_JIT if MMU
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index f24256bb23a1b..88b5404dba360 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -101,7 +101,7 @@ _save_context:
 	call __trace_hardirqs_off
 #endif
 
-#ifdef CONFIG_CONTEXT_TRACKING
+#ifdef CONFIG_CONTEXT_TRACKING_USER
 	/* If previous state is in user mode, call user_exit_callable(). */
 	li   a0, SR_PP
 	and a0, s1, a0
@@ -164,7 +164,7 @@ handle_syscall:
 	 */
 	csrs CSR_STATUS, SR_IE
 #endif
-#if defined(CONFIG_TRACE_IRQFLAGS) || defined(CONFIG_CONTEXT_TRACKING)
+#if defined(CONFIG_TRACE_IRQFLAGS) || defined(CONFIG_CONTEXT_TRACKING_USER)
 	/* Recover a0 - a7 for system calls */
 	REG_L a0, PT_A0(sp)
 	REG_L a1, PT_A1(sp)
@@ -239,7 +239,7 @@ resume_userspace:
 	andi s1, s0, _TIF_WORK_MASK
 	bnez s1, work_pending
 
-#ifdef CONFIG_CONTEXT_TRACKING
+#ifdef CONFIG_CONTEXT_TRACKING_USER
 	call user_enter_callable
 #endif
 
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 7e2ce4c8d6571..2b779317e8416 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -74,7 +74,7 @@ config SPARC64
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_SYSCALL_TRACEPOINTS
-	select HAVE_CONTEXT_TRACKING
+	select HAVE_CONTEXT_TRACKING_USER
 	select HAVE_TIF_NOHZ
 	select HAVE_DEBUG_KMEMLEAK
 	select IOMMU_HELPER
diff --git a/arch/sparc/kernel/rtrap_64.S b/arch/sparc/kernel/rtrap_64.S
index c5fd4b450d9b6..eef102765a7e2 100644
--- a/arch/sparc/kernel/rtrap_64.S
+++ b/arch/sparc/kernel/rtrap_64.S
@@ -15,7 +15,7 @@
 #include <asm/visasm.h>
 #include <asm/processor.h>
 
-#ifdef CONFIG_CONTEXT_TRACKING
+#ifdef CONFIG_CONTEXT_TRACKING_USER
 # define SCHEDULE_USER schedule_user
 #else
 # define SCHEDULE_USER schedule
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 43e5bc827f488..30fb6a54f5f19 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -165,7 +165,7 @@ config X86
 	select HAVE_ASM_MODVERSIONS
 	select HAVE_CMPXCHG_DOUBLE
 	select HAVE_CMPXCHG_LOCAL
-	select HAVE_CONTEXT_TRACKING		if X86_64
+	select HAVE_CONTEXT_TRACKING_USER	if X86_64
 	select HAVE_C_RECORDMCOUNT
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DMA_CONTIGUOUS
diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index d9aaff00011d3..f03b5dfd855ae 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -10,7 +10,7 @@
 #include <asm/ptrace.h>
 
 
-#ifdef CONFIG_CONTEXT_TRACKING
+#ifdef CONFIG_CONTEXT_TRACKING_USER
 extern void ct_cpu_track_user(int cpu);
 
 /* Called with interrupts disabled.  */
@@ -90,15 +90,15 @@ static inline void user_exit_irqoff(void) { }
 static inline enum ctx_state exception_enter(void) { return 0; }
 static inline void exception_exit(enum ctx_state prev_ctx) { }
 static inline enum ctx_state ct_state(void) { return CONTEXT_DISABLED; }
-#endif /* !CONFIG_CONTEXT_TRACKING */
+#endif /* !CONFIG_CONTEXT_TRACKING_USER */
 
 #define CT_WARN_ON(cond) WARN_ON(context_tracking_enabled() && (cond))
 
-#ifdef CONFIG_CONTEXT_TRACKING_FORCE
+#ifdef CONFIG_CONTEXT_TRACKING_USER_FORCE
 extern void context_tracking_init(void);
 #else
 static inline void context_tracking_init(void) { }
-#endif /* CONFIG_CONTEXT_TRACKING_FORCE */
+#endif /* CONFIG_CONTEXT_TRACKING_USER_FORCE */
 
 
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING_GEN
diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index 65a60d3313b00..64dbbb8803788 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -22,7 +22,7 @@ struct context_tracking {
 	} state;
 };
 
-#ifdef CONFIG_CONTEXT_TRACKING
+#ifdef CONFIG_CONTEXT_TRACKING_USER
 extern struct static_key_false context_tracking_key;
 DECLARE_PER_CPU(struct context_tracking, context_tracking);
 
@@ -50,6 +50,6 @@ static inline bool context_tracking_in_user(void) { return false; }
 static inline bool context_tracking_enabled(void) { return false; }
 static inline bool context_tracking_enabled_cpu(int cpu) { return false; }
 static inline bool context_tracking_enabled_this_cpu(void) { return false; }
-#endif /* CONFIG_CONTEXT_TRACKING */
+#endif /* CONFIG_CONTEXT_TRACKING_USER */
 
 #endif
diff --git a/init/Kconfig b/init/Kconfig
index a6a4eaec73c88..d4ebcc067cd17 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -489,11 +489,11 @@ config VIRT_CPU_ACCOUNTING_NATIVE
 
 config VIRT_CPU_ACCOUNTING_GEN
 	bool "Full dynticks CPU time accounting"
-	depends on HAVE_CONTEXT_TRACKING
+	depends on HAVE_CONTEXT_TRACKING_USER
 	depends on HAVE_VIRT_CPU_ACCOUNTING_GEN
 	depends on GENERIC_CLOCKEVENTS
 	select VIRT_CPU_ACCOUNTING
-	select CONTEXT_TRACKING
+	select CONTEXT_TRACKING_USER
 	help
 	  Select this option to enable task and CPU time accounting on full
 	  dynticks systems. This accounting is implemented by watching every
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index 762eb23ac2244..beeff8f21a44e 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -22,6 +22,8 @@
 #include <linux/export.h>
 #include <linux/kprobes.h>
 
+#ifdef CONFIG_CONTEXT_TRACKING_USER
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/context_tracking.h>
 
@@ -252,7 +254,7 @@ void __init ct_cpu_track_user(int cpu)
 	initialized = true;
 }
 
-#ifdef CONFIG_CONTEXT_TRACKING_FORCE
+#ifdef CONFIG_CONTEXT_TRACKING_USER_FORCE
 void __init context_tracking_init(void)
 {
 	int cpu;
@@ -261,3 +263,5 @@ void __init context_tracking_init(void)
 		ct_cpu_track_user(cpu);
 }
 #endif
+
+#endif /* #ifdef CONFIG_CONTEXT_TRACKING_USER */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index bcb313b1e1fd3..86c82505dae7b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4654,7 +4654,7 @@ void __sched schedule_idle(void)
 	} while (need_resched());
 }
 
-#ifdef CONFIG_CONTEXT_TRACKING
+#ifdef CONFIG_CONTEXT_TRACKING_USER
 asmlinkage __visible void __sched schedule_user(void)
 {
 	/*
diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
index a09b1d61df6a5..ed5edf702f1e1 100644
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -61,6 +61,9 @@ config POSIX_CPU_TIMERS_TASK_WORK
 	bool
 	default y if POSIX_TIMERS && HAVE_POSIX_CPU_TIMERS_TASK_WORK
 
+config CONTEXT_TRACKING
+	bool
+
 if GENERIC_CLOCKEVENTS
 menu "Timers subsystem"
 
@@ -102,7 +105,7 @@ config NO_HZ_FULL
 	depends on !ARCH_USES_GETTIMEOFFSET && GENERIC_CLOCKEVENTS
 	# We need at least one periodic CPU for timekeeping
 	depends on SMP
-	depends on HAVE_CONTEXT_TRACKING
+	depends on HAVE_CONTEXT_TRACKING_USER
 	# VIRT_CPU_ACCOUNTING_GEN dependency
 	depends on HAVE_VIRT_CPU_ACCOUNTING_GEN
 	select NO_HZ_COMMON
@@ -127,31 +130,37 @@ config NO_HZ_FULL
 
 endchoice
 
-config CONTEXT_TRACKING
-       bool
+config CONTEXT_TRACKING_USER
+	bool
+	depends on HAVE_CONTEXT_TRACKING_USER
+	select CONTEXT_TRACKING
+	help
+	  Track transitions between kernel and user on behalf of RCU and
+	  tickless cputime accounting. The former case relies on context
+	  tracking to enter/exit RCU extended quiescent states.
 
-config CONTEXT_TRACKING_FORCE
-	bool "Force context tracking"
-	depends on CONTEXT_TRACKING
+config CONTEXT_TRACKING_USER_FORCE
+	bool "Force user context tracking"
+	depends on CONTEXT_TRACKING_USER
 	default y if !NO_HZ_FULL
 	help
 	  The major pre-requirement for full dynticks to work is to
-	  support the context tracking subsystem. But there are also
+	  support the user context tracking subsystem. But there are also
 	  other dependencies to provide in order to make the full
 	  dynticks working.
 
 	  This option stands for testing when an arch implements the
-	  context tracking backend but doesn't yet fullfill all the
+	  user context tracking backend but doesn't yet fullfill all the
 	  requirements to make the full dynticks feature working.
 	  Without the full dynticks, there is no way to test the support
-	  for context tracking and the subsystems that rely on it: RCU
+	  for user context tracking and the subsystems that rely on it: RCU
 	  userspace extended quiescent state and tickless cputime
 	  accounting. This option copes with the absence of the full
-	  dynticks subsystem by forcing the context tracking on all
+	  dynticks subsystem by forcing the user context tracking on all
 	  CPUs in the system.
 
 	  Say Y only if you're working on the development of an
-	  architecture backend for the context tracking.
+	  architecture backend for the user context tracking.
 
 	  Say N otherwise, this option brings an overhead that you
 	  don't want in production.
-- 
2.53.0

