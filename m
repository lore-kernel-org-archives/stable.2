Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F71531AEA
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 12:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788870036; cv=none; b=D7yrzB/mQizr8UDUkfqNsbB47QpngIR1yV/4V83Zx02jbc5lP5EPAXD0yd12RzDiogO7BaZ9ilqkXyOTnOk4TLyi3xZ5wyHnvrRnNnFkj5JrWrzPC5sIKbyA+LBFTo8zLLqqL2UKAofQ8JeKmVl8IlEkw71fOLzIcVBdehZPiGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788870036; c=relaxed/simple;
	bh=/aqlR6BhrKhhhc0Pu5ZTISKj7eG3LFwzftDuAmL+YEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SmzlcumCsOZNzhWNKaZuv+Qa1ZGgJTzaX1w8waMdscKSJqwiC/R7whccAYH9xv5dMNPKF69Kfot6t9SFgCnIfW9nCZCJznPc/DRWk4KSNjG1KlqeD4f2nhtOU/b4hNpHK1ma6oi1g7ZKMKfNF63kKsYN16KilKaaLtQmXH1knB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EeR68fnX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EeR68fnX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B5941F00AC4;
	Tue,  8 Sep 2026 12:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788870031;
	bh=PVzQYXOSvRUT/oyR+BIoo5i6ln4nIVSvyi7G3t6cze0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EeR68fnX581ugGusaqtU5fMhrp/tfSUo+zWJUxF56/9HRUMmJvDQ7Qd1GudtjB0o0
	 56eUwn6AIIUabx+roDvFe57MWAoA2YFBhg1fv+atlzqOtUIjSHbHeCNHVCuAsuwMKv
	 aqJCLRSfsuyioHDFbbagkH5/0p/XJoi590DaKmAqFmx560pGTYj49a4d/QkYl4fR9R
	 1dWzii6s1SU7LGqJrlFMHyrAgQPTT99xWUP1yV1vb0u9PhRmzyzYO7ATJJCJg8kpHA
	 Oz6ieeDYtFMPqdJB/lYddC1hSLiN/pwQHk1keiqMb7Rj3oxQnTLSaoQ06NJnEOQo2n
	 K2oH2B4fdD+/Q==
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
Subject: [PATCH 5.15.y 2/4] context_tracking: Rename context_tracking_user_enter/exit() to user_enter/exit_callable()
Date: Tue,  8 Sep 2026 08:20:24 -0400
Message-ID: <20260908122026.2052281-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908122026.2052281-1-sashal@kernel.org>
References: <2026090325-ardently-jaybird-f824@gregkh>
 <20260908122026.2052281-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frederic Weisbecker <frederic@kernel.org>

[ Upstream commit f163f0302ab69722c052519f4014814bf10026a9 ]

context_tracking_user_enter() and context_tracking_user_exit() are
ASM callable versions of user_enter() and user_exit() for architectures
that didn't manage to check the context tracking static key from ASM.
Change those function names to better reflect their purpose.

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

[ sashal: Reduced backport -- upstream f163f0302ab69 touches 6 file(s), this
  backport carries 7. Not backported here:
  arch/xtensa/kernel/entry.S
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 7e8ee82e69fd ("ARM: 9477/1: Disable broken eBPF JIT on the Risc PC")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/Kconfig                     |  8 ++++++++
 arch/arm/Kconfig                 |  2 +-
 arch/arm/kernel/entry-header.S   |  8 ++++----
 arch/csky/kernel/entry.S         |  4 ++--
 arch/riscv/kernel/entry.S        |  6 +++---
 include/linux/context_tracking.h |  4 ++--
 kernel/context_tracking.c        | 28 +++++++++++++++++-----------
 7 files changed, 37 insertions(+), 23 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 69e3743206330..e09674419c066 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -781,6 +781,14 @@ config HAVE_CONTEXT_TRACKING
 	  protected inside rcu_irq_enter/rcu_irq_exit() but preemption or signal
 	  handling on irq exit still need to be protected.
 
+config HAVE_CONTEXT_TRACKING_USER
+	bool
+	select HAVE_CONTEXT_TRACKING
+	help
+	  Provide the user-transition context tracking capability name used by
+	  newer kernels while retaining the stable kernel's context tracking
+	  implementation.
+
 config HAVE_CONTEXT_TRACKING_OFFSTACK
 	bool
 	help
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 74357ce8967b4..a0d6aefa0fab0 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -81,7 +81,7 @@ config ARM
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if ARM_LPAE
 	select HAVE_ARM_SMCCC if CPU_V7
 	select HAVE_EBPF_JIT if !CPU_ENDIAN_BE32
-	select HAVE_CONTEXT_TRACKING
+	select HAVE_CONTEXT_TRACKING_USER
 	select HAVE_C_RECORDMCOUNT
 	select HAVE_DEBUG_KMEMLEAK if !XIP_KERNEL
 	select HAVE_DMA_CONTIGUOUS if MMU
diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
index 40db0f9188b69..6d103d61c2994 100644
--- a/arch/arm/kernel/entry-header.S
+++ b/arch/arm/kernel/entry-header.S
@@ -356,10 +356,10 @@
 #ifdef CONFIG_CONTEXT_TRACKING
 	.if	\save
 	stmdb   sp!, {r0-r3, ip, lr}
-	bl	context_tracking_user_exit
+	bl	user_exit_callable
 	ldmia	sp!, {r0-r3, ip, lr}
 	.else
-	bl	context_tracking_user_exit
+	bl	user_exit_callable
 	.endif
 #endif
 	.endm
@@ -368,10 +368,10 @@
 #ifdef CONFIG_CONTEXT_TRACKING
 	.if	\save
 	stmdb   sp!, {r0-r3, ip, lr}
-	bl	context_tracking_user_enter
+	bl	user_enter_callable
 	ldmia	sp!, {r0-r3, ip, lr}
 	.else
-	bl	context_tracking_user_enter
+	bl	user_enter_callable
 	.endif
 #endif
 	.endm
diff --git a/arch/csky/kernel/entry.S b/arch/csky/kernel/entry.S
index 00e3c8ebf9b86..6d7dc0f037ffe 100644
--- a/arch/csky/kernel/entry.S
+++ b/arch/csky/kernel/entry.S
@@ -23,7 +23,7 @@
 	mfcr	a0, epsr
 	btsti	a0, 31
 	bt	1f
-	jbsr	context_tracking_user_exit
+	jbsr	user_exit_callable
 	ldw	a0, (sp, LSAVE_A0)
 	ldw	a1, (sp, LSAVE_A1)
 	ldw	a2, (sp, LSAVE_A2)
@@ -160,7 +160,7 @@ ret_from_exception:
 	cmpnei	r10, 0
 	bt	exit_work
 #ifdef CONFIG_CONTEXT_TRACKING
-	jbsr	context_tracking_user_enter
+	jbsr	user_enter_callable
 #endif
 1:
 #ifdef CONFIG_PREEMPTION
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 851c967c49ccd..0ffcde78f88ec 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -112,11 +112,11 @@ _save_context:
 #endif
 
 #ifdef CONFIG_CONTEXT_TRACKING
-	/* If previous state is in user mode, call context_tracking_user_exit. */
+	/* If previous state is in user mode, call user_exit_callable(). */
 	li   a0, SR_PP
 	and a0, s1, a0
 	bnez a0, skip_context_tracking
-	call context_tracking_user_exit
+	call user_exit_callable
 skip_context_tracking:
 #endif
 
@@ -254,7 +254,7 @@ resume_userspace:
 	bnez s1, work_pending
 
 #ifdef CONFIG_CONTEXT_TRACKING
-	call context_tracking_user_enter
+	call user_enter_callable
 #endif
 
 	/* Save unwound kernel stack pointer in thread_info */
diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index 4d7fced3a39fd..c96f194eff136 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -19,8 +19,8 @@ extern void __context_tracking_exit(enum ctx_state state);
 
 extern void context_tracking_enter(enum ctx_state state);
 extern void context_tracking_exit(enum ctx_state state);
-extern void context_tracking_user_enter(void);
-extern void context_tracking_user_exit(void);
+extern void user_enter_callable(void);
+extern void user_exit_callable(void);
 
 static inline void user_enter(void)
 {
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index 3082332f64765..58e42213bf12f 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -134,19 +134,22 @@ void context_tracking_enter(enum ctx_state state)
 NOKPROBE_SYMBOL(context_tracking_enter);
 EXPORT_SYMBOL_GPL(context_tracking_enter);
 
-/*
- * OBSOLETE:
- * This function should be noinstr but it unsafely calls local_irq_restore(),
- * involving illegal RCU uses through tracing and lockdep.
+/**
+ * user_enter_callable() - Unfortunate ASM callable version of user_enter() for
+ *			   archs that didn't manage to check the context tracking
+ *			   static key from low level code.
+ *
+ * This OBSOLETE function should be noinstr but it unsafely calls
+ * local_irq_restore(), involving illegal RCU uses through tracing and lockdep.
  * This is unlikely to be fixed as this function is obsolete. The preferred
  * way is to call user_enter_irqoff(). It should be the arch entry code
  * responsibility to call into context tracking with IRQs disabled.
  */
-void context_tracking_user_enter(void)
+void user_enter_callable(void)
 {
 	user_enter();
 }
-NOKPROBE_SYMBOL(context_tracking_user_enter);
+NOKPROBE_SYMBOL(user_enter_callable);
 
 /**
  * context_tracking_exit - Inform the context tracking that the CPU is
@@ -208,19 +211,22 @@ void context_tracking_exit(enum ctx_state state)
 NOKPROBE_SYMBOL(context_tracking_exit);
 EXPORT_SYMBOL_GPL(context_tracking_exit);
 
-/*
- * OBSOLETE:
- * This function should be noinstr but it unsafely calls local_irq_save(),
+/**
+ * user_exit_callable() - Unfortunate ASM callable version of user_exit() for
+ *			  archs that didn't manage to check the context tracking
+ *			  static key from low level code.
+ *
+ * This OBSOLETE function should be noinstr but it unsafely calls local_irq_save(),
  * involving illegal RCU uses through tracing and lockdep. This is unlikely
  * to be fixed as this function is obsolete. The preferred way is to call
  * user_exit_irqoff(). It should be the arch entry code responsibility to
  * call into context tracking with IRQs disabled.
  */
-void context_tracking_user_exit(void)
+void user_exit_callable(void)
 {
 	user_exit();
 }
-NOKPROBE_SYMBOL(context_tracking_user_exit);
+NOKPROBE_SYMBOL(user_exit_callable);
 
 void __init context_tracking_cpu_set(int cpu)
 {
-- 
2.53.0

