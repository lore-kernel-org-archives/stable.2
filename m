Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E58653CA72
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 12:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788870039; cv=none; b=evTMR+BcT9kpdEIVlNXLvHD7WvEHIhJmCasH8IQlREv1JmYaiFmbzPTRusptxmLjotpXc9h00IlB/oScgE2y/JwkfIf8sFBVvqIiEJEzwZ+xI1uuNT/NhySu9/Rf2PeF0lGvvtuAyxp9OQDTfuDMvjR019JdBOel5mBTxpm6tGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788870039; c=relaxed/simple;
	bh=ON+cgnrCURWPxceq01ffPNcXrdFPlxYE6TYqehw2AY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bswtzrkkorjqc54Q6gv+v16awWYnBI1h34wbYVMXB6EeZwuym9VGkS0cWJFcNvNgToKU0RYXEljgUWumWs1VxIF54esBRqUePKOiR254PnZUYzW83UxQUA2CWOFb+VbSQaSE23SklKIlRDlgR47ACl8eFs6TK1JlJ7R7FCfeyRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80AE61F00A3D;
	Tue,  8 Sep 2026 12:20:32 +0000 (UTC)
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Charlie Jenkins <charlie@rivosinc.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/5] entry: Inline syscall_exit_to_user_mode()
Date: Tue,  8 Sep 2026 08:20:26 -0400
Message-ID: <20260908122030.2052577-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090331-spouse-sprawl-968e@gregkh>
References: <2026090331-spouse-sprawl-968e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Charlie Jenkins <charlie@rivosinc.com>

[ Upstream commit e43b8bb56e537bfc8d9076793091e7679020fc9c ]

Similar to commit 221a164035fd ("entry: Move syscall_enter_from_user_mode()
to header file"), move syscall_exit_to_user_mode() to the header file as
well.

Testing was done with the byte-unixbench syscall benchmark (which calls
getpid) and QEMU. On riscv I measured a 7.09246% improvement, on x86 a
2.98843% improvement, on loongarch a 6.07954% improvement, and on s390 a
11.1328% improvement.

The Intel bot also reported "kernel test robot noticed a 1.9% improvement
of stress-ng.seek.ops_per_sec".

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Link: https://lore.kernel.org/all/20250320-riscv_optimize_entry-v6-4-63e187e26041@rivosinc.com
Link: https://lore.kernel.org/linux-riscv/202502051555.85ae6844-lkp@intel.com/
Stable-dep-of: 4a3591287fb7 ("entry: Fix seccomp bypass after ptrace with TSYNC")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/entry-common.h | 131 ++++++++++++++++++++++++++++--
 kernel/entry/common.c        | 149 +++--------------------------------
 2 files changed, 136 insertions(+), 144 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index d95ab85f96ba5..4533799c13cda 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -7,8 +7,14 @@
 #include <linux/syscalls.h>
 #include <linux/seccomp.h>
 #include <linux/sched.h>
+#include <linux/context_tracking.h>
+#include <linux/livepatch.h>
+#include <linux/resume_user_mode.h>
+#include <linux/tick.h>
+#include <linux/kmsan.h>
 
 #include <asm/entry-common.h>
+#include <asm/syscall.h>
 
 /*
  * Define dummy _TIF work flags if not defined by the architecture or for
@@ -98,7 +104,19 @@ static __always_inline void arch_enter_from_user_mode(struct pt_regs *regs) {}
  * done between establishing state and enabling interrupts. The caller must
  * enable interrupts before invoking syscall_enter_from_user_mode_work().
  */
-void enter_from_user_mode(struct pt_regs *regs);
+static __always_inline void enter_from_user_mode(struct pt_regs *regs)
+{
+	arch_enter_from_user_mode(regs);
+	lockdep_hardirqs_off(CALLER_ADDR0);
+
+	CT_WARN_ON(__ct_state() != CONTEXT_USER);
+	user_exit_irqoff();
+
+	instrumentation_begin();
+	kmsan_unpoison_entry_regs(regs);
+	trace_hardirqs_off_finish();
+	instrumentation_end();
+}
 
 /**
  * syscall_enter_from_user_mode_prepare - Establish state and enable interrupts
@@ -117,6 +135,9 @@ void enter_from_user_mode(struct pt_regs *regs);
  */
 void syscall_enter_from_user_mode_prepare(struct pt_regs *regs);
 
+long syscall_trace_enter(struct pt_regs *regs, long syscall,
+			 unsigned long work);
+
 /**
  * syscall_enter_from_user_mode_work - Check and handle work before invoking
  *				       a syscall
@@ -140,7 +161,15 @@ void syscall_enter_from_user_mode_prepare(struct pt_regs *regs);
  *     ptrace_report_syscall_entry(), __secure_computing(), trace_sys_enter()
  *  2) Invocation of audit_syscall_entry()
  */
-long syscall_enter_from_user_mode_work(struct pt_regs *regs, long syscall);
+static __always_inline long syscall_enter_from_user_mode_work(struct pt_regs *regs, long syscall)
+{
+	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
+
+	if (work & SYSCALL_WORK_ENTER)
+		syscall = syscall_trace_enter(regs, syscall, work);
+
+	return syscall;
+}
 
 /**
  * syscall_enter_from_user_mode - Establish state and check and handle work
@@ -159,7 +188,19 @@ long syscall_enter_from_user_mode_work(struct pt_regs *regs, long syscall);
  * Returns: The original or a modified syscall number. See
  * syscall_enter_from_user_mode_work() for further explanation.
  */
-long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall);
+static __always_inline long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall)
+{
+	long ret;
+
+	enter_from_user_mode(regs);
+
+	instrumentation_begin();
+	local_irq_enable();
+	ret = syscall_enter_from_user_mode_work(regs, syscall);
+	instrumentation_end();
+
+	return ret;
+}
 
 /**
  * local_irq_enable_exit_to_user - Exit to user variant of local_irq_enable()
@@ -258,6 +299,44 @@ static __always_inline void arch_exit_to_user_mode(void) { }
  */
 void arch_do_signal_or_restart(struct pt_regs *regs);
 
+/**
+ * exit_to_user_mode_loop - do any pending work before leaving to user space
+ */
+unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
+				     unsigned long ti_work);
+
+/**
+ * exit_to_user_mode_prepare - call exit_to_user_mode_loop() if required
+ * @regs:	Pointer to pt_regs on entry stack
+ *
+ * 1) check that interrupts are disabled
+ * 2) call tick_nohz_user_enter_prepare()
+ * 3) call exit_to_user_mode_loop() if any flags from
+ *    EXIT_TO_USER_MODE_WORK are set
+ * 4) check that interrupts are still disabled
+ */
+static __always_inline void exit_to_user_mode_prepare(struct pt_regs *regs)
+{
+	unsigned long ti_work;
+
+	lockdep_assert_irqs_disabled();
+
+	/* Flush pending rcuog wakeup before the last need_resched() check */
+	tick_nohz_user_enter_prepare();
+
+	ti_work = read_thread_flags();
+	if (unlikely(ti_work & EXIT_TO_USER_MODE_WORK))
+		ti_work = exit_to_user_mode_loop(regs, ti_work);
+
+	arch_exit_to_user_mode_prepare(regs, ti_work);
+
+	/* Ensure that the address limit is intact and no locks are held */
+	addr_limit_user_check();
+	kmap_assert_nomap();
+	lockdep_assert_irqs_disabled();
+	lockdep_sys_exit();
+}
+
 /**
  * exit_to_user_mode - Fixup state when exiting to user mode
  *
@@ -276,7 +355,26 @@ void arch_do_signal_or_restart(struct pt_regs *regs);
  * non-instrumentable.
  * The caller has to invoke syscall_exit_to_user_mode_work() before this.
  */
-void exit_to_user_mode(void);
+static __always_inline void exit_to_user_mode(void)
+{
+	instrumentation_begin();
+	trace_hardirqs_on_prepare();
+	lockdep_hardirqs_on_prepare();
+	instrumentation_end();
+
+	user_enter_irqoff();
+	arch_exit_to_user_mode();
+	lockdep_hardirqs_on(CALLER_ADDR0);
+}
+
+/**
+ * syscall_exit_work - Handle work before returning to user mode
+ * @regs:	Pointer to current pt_regs
+ * @work:	Current thread syscall work
+ *
+ * Do one-time syscall specific work.
+ */
+void syscall_exit_work(struct pt_regs *regs, unsigned long work);
 
 /**
  * syscall_exit_to_user_mode_work - Handle work before returning to user mode
@@ -291,7 +389,30 @@ void exit_to_user_mode(void);
  * make the final state transitions. Interrupts must stay disabled between
  * return from this function and the invocation of exit_to_user_mode().
  */
-void syscall_exit_to_user_mode_work(struct pt_regs *regs);
+static __always_inline void syscall_exit_to_user_mode_work(struct pt_regs *regs)
+{
+	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
+	unsigned long nr = syscall_get_nr(current, regs);
+
+	CT_WARN_ON(ct_state() != CONTEXT_KERNEL);
+
+	if (IS_ENABLED(CONFIG_PROVE_LOCKING)) {
+		if (WARN(irqs_disabled(), "syscall %lu left IRQs disabled", nr))
+			local_irq_enable();
+	}
+
+	rseq_syscall(regs);
+
+	/*
+	 * Do one-time syscall specific work. If these work items are
+	 * enabled, we want to run them exactly once per syscall exit with
+	 * interrupts enabled.
+	 */
+	if (unlikely(work & SYSCALL_WORK_EXIT))
+		syscall_exit_work(regs, work);
+	local_irq_disable_exit_to_user();
+	exit_to_user_mode_prepare(regs);
+}
 
 /**
  * syscall_exit_to_user_mode - Handle work before returning to user mode
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index ccf2b1e1b40be..4d890cf9a7c83 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -15,26 +15,6 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/syscalls.h>
 
-/* See comment for enter_from_user_mode() in entry-common.h */
-static __always_inline void __enter_from_user_mode(struct pt_regs *regs)
-{
-	arch_enter_from_user_mode(regs);
-	lockdep_hardirqs_off(CALLER_ADDR0);
-
-	CT_WARN_ON(__ct_state() != CONTEXT_USER);
-	user_exit_irqoff();
-
-	instrumentation_begin();
-	kmsan_unpoison_entry_regs(regs);
-	trace_hardirqs_off_finish();
-	instrumentation_end();
-}
-
-void noinstr enter_from_user_mode(struct pt_regs *regs)
-{
-	__enter_from_user_mode(regs);
-}
-
 static inline void syscall_enter_audit(struct pt_regs *regs, long syscall)
 {
 	if (unlikely(audit_context())) {
@@ -45,8 +25,8 @@ static inline void syscall_enter_audit(struct pt_regs *regs, long syscall)
 	}
 }
 
-static long syscall_trace_enter(struct pt_regs *regs, long syscall,
-				unsigned long work)
+long syscall_trace_enter(struct pt_regs *regs, long syscall,
+			 unsigned long work)
 {
 	long ret = 0;
 
@@ -91,67 +71,19 @@ static long syscall_trace_enter(struct pt_regs *regs, long syscall,
 	return ret ? : syscall;
 }
 
-static __always_inline long
-__syscall_enter_from_user_work(struct pt_regs *regs, long syscall)
-{
-	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
-
-	if (work & SYSCALL_WORK_ENTER)
-		syscall = syscall_trace_enter(regs, syscall, work);
-
-	return syscall;
-}
-
-long syscall_enter_from_user_mode_work(struct pt_regs *regs, long syscall)
-{
-	return __syscall_enter_from_user_work(regs, syscall);
-}
-
-noinstr long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall)
-{
-	long ret;
-
-	__enter_from_user_mode(regs);
-
-	instrumentation_begin();
-	local_irq_enable();
-	ret = __syscall_enter_from_user_work(regs, syscall);
-	instrumentation_end();
-
-	return ret;
-}
-
 noinstr void syscall_enter_from_user_mode_prepare(struct pt_regs *regs)
 {
-	__enter_from_user_mode(regs);
+	enter_from_user_mode(regs);
 	instrumentation_begin();
 	local_irq_enable();
 	instrumentation_end();
 }
 
-/* See comment for exit_to_user_mode() in entry-common.h */
-static __always_inline void __exit_to_user_mode(void)
-{
-	instrumentation_begin();
-	trace_hardirqs_on_prepare();
-	lockdep_hardirqs_on_prepare();
-	instrumentation_end();
-
-	user_enter_irqoff();
-	arch_exit_to_user_mode();
-	lockdep_hardirqs_on(CALLER_ADDR0);
-}
-
-void noinstr exit_to_user_mode(void)
-{
-	__exit_to_user_mode();
-}
-
 /* Workaround to allow gradual conversion of architecture code */
 void __weak arch_do_signal_or_restart(struct pt_regs *regs) { }
 
-static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
-					    unsigned long ti_work)
+__always_inline unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
+					     unsigned long ti_work)
 {
 	/*
 	 * Before returning to user space ensure that all pending work
@@ -196,28 +128,6 @@ static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
 	return ti_work;
 }
 
-static void exit_to_user_mode_prepare(struct pt_regs *regs)
-{
-	unsigned long ti_work;
-
-	lockdep_assert_irqs_disabled();
-
-	/* Flush pending rcuog wakeup before the last need_resched() check */
-	tick_nohz_user_enter_prepare();
-
-	ti_work = read_thread_flags();
-	if (unlikely(ti_work & EXIT_TO_USER_MODE_WORK))
-		ti_work = exit_to_user_mode_loop(regs, ti_work);
-
-	arch_exit_to_user_mode_prepare(regs, ti_work);
-
-	/* Ensure that the address limit is intact and no locks are held */
-	addr_limit_user_check();
-	kmap_assert_nomap();
-	lockdep_assert_irqs_disabled();
-	lockdep_sys_exit();
-}
-
 /*
  * If SYSCALL_EMU is set, then the only reason to report is when
  * SINGLESTEP is set (i.e. PTRACE_SYSEMU_SINGLESTEP).  This syscall
@@ -231,7 +141,7 @@ static inline bool report_single_step(unsigned long work)
 	return work & SYSCALL_WORK_SYSCALL_EXIT_TRAP;
 }
 
-static void syscall_exit_work(struct pt_regs *regs, unsigned long work)
+void syscall_exit_work(struct pt_regs *regs, unsigned long work)
 {
 	bool step;
 
@@ -258,56 +168,17 @@ static void syscall_exit_work(struct pt_regs *regs, unsigned long work)
 		ptrace_report_syscall_exit(regs, step);
 }
 
-/*
- * Syscall specific exit to user mode preparation. Runs with interrupts
- * enabled.
- */
-static void syscall_exit_to_user_mode_prepare(struct pt_regs *regs)
-{
-	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
-	unsigned long nr = syscall_get_nr(current, regs);
-
-	CT_WARN_ON(ct_state() != CONTEXT_KERNEL);
-
-	if (IS_ENABLED(CONFIG_PROVE_LOCKING)) {
-		if (WARN(irqs_disabled(), "syscall %lu left IRQs disabled", nr))
-			local_irq_enable();
-	}
-
-	rseq_syscall(regs);
-
-	/*
-	 * Do one-time syscall specific work. If these work items are
-	 * enabled, we want to run them exactly once per syscall exit with
-	 * interrupts enabled.
-	 */
-	if (unlikely(work & SYSCALL_WORK_EXIT))
-		syscall_exit_work(regs, work);
-}
-
-static __always_inline void __syscall_exit_to_user_mode_work(struct pt_regs *regs)
-{
-	syscall_exit_to_user_mode_prepare(regs);
-	local_irq_disable_exit_to_user();
-	exit_to_user_mode_prepare(regs);
-}
-
-void syscall_exit_to_user_mode_work(struct pt_regs *regs)
-{
-	__syscall_exit_to_user_mode_work(regs);
-}
-
 __visible noinstr void syscall_exit_to_user_mode(struct pt_regs *regs)
 {
 	instrumentation_begin();
-	__syscall_exit_to_user_mode_work(regs);
+	syscall_exit_to_user_mode_work(regs);
 	instrumentation_end();
-	__exit_to_user_mode();
+	exit_to_user_mode();
 }
 
 noinstr void irqentry_enter_from_user_mode(struct pt_regs *regs)
 {
-	__enter_from_user_mode(regs);
+	enter_from_user_mode(regs);
 }
 
 noinstr void irqentry_exit_to_user_mode(struct pt_regs *regs)
@@ -315,7 +186,7 @@ noinstr void irqentry_exit_to_user_mode(struct pt_regs *regs)
 	instrumentation_begin();
 	exit_to_user_mode_prepare(regs);
 	instrumentation_end();
-	__exit_to_user_mode();
+	exit_to_user_mode();
 }
 
 noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
-- 
2.53.0

