Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667CD548556
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 13:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788874233; cv=none; b=NGRJtiax4YVBj43avebalvourfuNTZQ26Y4TAk9yLc8LOJzWdqaonYMaSnZygQtLqBTpUPBhzyZx64DpAGlMAXY3r1cmMy98JRG+ZunfFVNo7sVxv6pxR2UKeMpFaagPdA72NbCFvVFp011MV7fyCqLzvSQoTuf7nYff/oxZgsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788874233; c=relaxed/simple;
	bh=83cZ2K3Fx4PjoarWkFQVdLf31yQOwZBcoVpxS80hW/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=onD1NLWHschz2O/Qn/7QmXGSh4AQAOLnai5mkO3Za5P0vOVmn2qvDqVRkN5yJpHWT1DGnTMhba/kD886RZKRJDcJ62Fs+R6jZf2b+8RAdibKrEnHoyNpb0Th/deC3sHvQ6OuZiDKtjKNEm9YeCsChmo/ERGwLhtr0K5jgFQgddU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 796701F00ADB;
	Tue,  8 Sep 2026 13:30:03 +0000 (UTC)
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
Subject: [PATCH 5.10.y 2/5] context_tracking: Rename context_tracking_user_enter/exit() to user_enter/exit_callable()
Date: Tue,  8 Sep 2026 09:29:53 -0400
Message-ID: <20260908132958.2312212-2-sashal@kernel.org>
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
  backport carries 5. Not backported here:
  arch/xtensa/kernel/entry.S
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 7e8ee82e69fd ("ARM: 9477/1: Disable broken eBPF JIT on the Risc PC")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/kernel/entry-header.S   |  8 ++++----
 arch/csky/kernel/entry.S         |  4 ++--
 arch/riscv/kernel/entry.S        |  6 +++---
 include/linux/context_tracking.h |  4 ++--
 kernel/context_tracking.c        | 28 +++++++++++++++++-----------
 5 files changed, 28 insertions(+), 22 deletions(-)

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
index 5a5cabd076e16..a4a5b8a8c21c8 100644
--- a/arch/csky/kernel/entry.S
+++ b/arch/csky/kernel/entry.S
@@ -28,7 +28,7 @@
 	mfcr	a0, epsr
 	btsti	a0, 31
 	bt	1f
-	jbsr	context_tracking_user_exit
+	jbsr	user_exit_callable
 	ldw	a0, (sp, LSAVE_A0)
 	ldw	a1, (sp, LSAVE_A1)
 	ldw	a2, (sp, LSAVE_A2)
@@ -258,7 +258,7 @@ ret_from_exception:
 	cmpnei	r10, 0
 	bt	exit_work
 #ifdef CONFIG_CONTEXT_TRACKING
-	jbsr	context_tracking_user_enter
+	jbsr	user_enter_callable
 #endif
 1:
 #ifdef CONFIG_PREEMPTION
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 5214c578a6023..f24256bb23a1b 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -102,11 +102,11 @@ _save_context:
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
 
@@ -240,7 +240,7 @@ resume_userspace:
 	bnez s1, work_pending
 
 #ifdef CONFIG_CONTEXT_TRACKING
-	call context_tracking_user_enter
+	call user_enter_callable
 #endif
 
 	/* Save unwound kernel stack pointer in thread_info */
diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index f5d127a5d819b..ef7875dbcaa4f 100644
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

