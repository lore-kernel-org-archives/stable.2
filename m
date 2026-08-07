Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4DF44E65A;
	Fri,  7 Aug 2026 06:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786083619; cv=none; b=Wv/MNN+90B9cjokNYTHC0By4+xk1uDFYCV5ZN89TYIVX7FeJh33HNlnfZBKJdOqPFunPBXBdt/lzaIqtKOSzlP0sC1ToHOti6aQzEKmG1CtZXpmVDq4k1TDmhcBDLTddSaFT59cD0Jb+NcLR5sATdumxrafT9R+PYWnVhWCcQ5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786083619; c=relaxed/simple;
	bh=DPVX1TvtXAh8d3hmldW5KAUdPyiv8qgqH0cBiVDYO3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZfXAmr1gBV/sXH4/6NkDdGdbjkHsKCZ5SUEsSrwX2DLVEKIvQQ/kWX/95Ky7l3pxXmrul8kZKHAQ2xOKafv0Y/GlMlgA61hoSK442bDBDkU7IKfrKJGsvTqngzFmTFFhq6gcFvuchmJLEu/2odgJFQvhT/V3o9WUxjSH8AidAKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OQESy+uX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OQESy+uX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BCC91F000E9;
	Fri,  7 Aug 2026 06:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786083617;
	bh=VYMAmXqPLHfxW+qTobP3qGWadJKhO3eMsEWdqrbYFJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OQESy+uXEVh3N87agYDBuTp+VCd89EGe9xy3ZtLsFVXNaQCNJaIoyFkPiYB9FxhCc
	 nJYHLMy/unmr9GU8ZcQ+JlFbPtyPlQZ5hLV1NspuXPpwKzgHHlhvlmgvZBuk7XZnck
	 f1XFNg8oITeW0LyQS/oHFcwHrteb86Pp5pP/kn64=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.12.102
Date: Fri,  7 Aug 2026 08:19:55 +0200
Message-ID: <2026080754-padded-direness-c6b4@gregkh>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026080754-sway-blurt-3855@gregkh>
References: <2026080754-sway-blurt-3855@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 45c45c42694d..115a476fefe8 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 12
-SUBLEVEL = 101
+SUBLEVEL = 102
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 9c6a110a52d4..5c27bca6a3e7 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -936,6 +936,8 @@ SYM_CODE_START(paranoid_entry)
 	IBRS_ENTER save_reg=%r15
 	UNTRAIN_RET_FROM_CALL
 
+	HANDLE_INTR_SAFERET 8(%rsp)
+
 	RET
 SYM_CODE_END(paranoid_entry)
 
@@ -1038,6 +1040,11 @@ SYM_CODE_START(error_entry)
 	movl	%ecx, %eax			/* zero extend */
 	cmpq	%rax, RIP+8(%rsp)
 	je	.Lbstep_iret
+
+	VALIDATE_UNRET_END
+
+	HANDLE_INTR_SAFERET 8(%rsp)
+
 	cmpq	$.Lgs_change, RIP+8(%rsp)
 	jne	.Lerror_entry_done_lfence
 
@@ -1056,7 +1063,6 @@ SYM_CODE_START(error_entry)
 	FENCE_SWAPGS_KERNEL_ENTRY
 	CALL_DEPTH_ACCOUNT
 	leaq	8(%rsp), %rax			/* return pt_regs pointer */
-	VALIDATE_UNRET_END
 	RET
 
 .Lbstep_iret:
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 2e0812a8ed77..ac6a67914b2d 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -177,6 +177,53 @@
 	add	$(BITS_PER_LONG/8), %_ASM_SP;		\
 	lfence;
 
+/*
+ * Helper for detecting if an interrupt occurred at an unsafe location within
+ * Safe-RET.  If Safe-RET is interrupted after the CALL or LEA the RSB may get
+ * poisoned by the interrupt handler.
+ *
+ * The Safe-RET sequence is:
+ *
+ * CALL
+ * LEA 8(%RSP), %RSP
+ * RET
+ *
+ * The two CMPs below check whether RIP points to after the CALL or after the
+ * LEA.
+ *
+ * The LFENCE below is to address this particular speculation case:
+ *
+ * 1. Userspace runs and poisons the BTB around the safe-RET routine
+ *
+ * 2. Userspace triggers some kind of exception
+ *
+ * 3. Kernel executes error_entry() and mis-speculates the branch into thinking
+ *    it actually came from kernel space
+ *
+ * 4. The kernel then further mis-speculates that the exception occurred due
+ *    to an interrupted safe-RET
+ *
+ * 5. The handle_interrupted_saferet() routine speculatively executes and
+ *    speculatively does a safe-RET. But this is unsafe since it was never
+ *    untrained.
+ *
+ * The LFENCE fixes this by ensuring step 5 is never reached speculatively.
+ * Note that this LFENCE only occurs if safe-RET was actually interrupted (so
+ * it's outside of the normal path).
+ *
+ * (The 128 below is RIP offset, used as a naked number here for ease of
+ * backporting).
+ */
+#define __HANDLE_INTR_SAFERET(name, pt_regs)		\
+	cmpq	$(name), 128+pt_regs;			\
+	jb	1f;					\
+	cmpq	$(name)+5, 128+pt_regs;			\
+	ja	1f;					\
+	lfence;						\
+	leaq	pt_regs, %rdi;				\
+	call	handle_interrupted_saferet;		\
+	1:
+
 #ifdef __ASSEMBLY__
 
 /*
@@ -306,6 +353,14 @@
 #define UNTRAIN_RET_FROM_CALL \
 	__UNTRAIN_RET X86_FEATURE_ENTRY_IBPB, __stringify(RESET_CALL_DEPTH_FROM_CALL)
 
+.macro HANDLE_INTR_SAFERET pt_regs
+#ifdef CONFIG_MITIGATION_SRSO
+	ALTERNATIVE_2 "", \
+	__stringify(__HANDLE_INTR_SAFERET(srso_safe_ret, \pt_regs)), X86_FEATURE_SRSO, \
+	__stringify(__HANDLE_INTR_SAFERET(srso_alias_safe_ret, \pt_regs)), X86_FEATURE_SRSO_ALIAS
+
+#endif
+.endm
 
 .macro CALL_DEPTH_ACCOUNT
 #ifdef CONFIG_MITIGATION_CALL_DEPTH_TRACKING
@@ -639,6 +694,10 @@ static __always_inline void x86_idle_clear_cpu_buffers(void)
 		x86_clear_cpu_buffers();
 }
 
+void srso_safe_ret(void);
+void srso_alias_safe_ret(void);
+void handle_interrupted_saferet(struct pt_regs *regs);
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_X86_NOSPEC_BRANCH_H_ */
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 12544fdcadd6..9a0abeaccd6f 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -3523,3 +3523,42 @@ void __warn_thunk(void)
 {
 	WARN_ONCE(1, "Unpatched return thunk in use. This should not happen!\n");
 }
+
+#ifdef CONFIG_MITIGATION_SRSO
+/*
+ * Called during exception/interrupt entry if interrupted during the
+ * safe-RET sequence.  The safe-RET sequence consists of 3 instructions:
+ *
+ *	CALL
+ *	LEA 8(%RSP), %RSP
+ *	RET
+ *
+ * An interrupt after the CALL or after the LEA could potentially lead
+ * to branch predictor poisoning and results in the sequence not being
+ * able to be safely resumed.
+ *
+ * Therefore, modify the regs state as if the remaining part of the
+ * safe-RET sequence executed so the interrupt returns back to the
+ * desired return target, instead of the to the safe-RET sequence.
+ */
+void noinstr handle_interrupted_saferet(struct pt_regs *regs)
+{
+	unsigned long rip = regs->ip;
+
+	if (rip == (unsigned long) srso_safe_ret ||
+	    rip == (unsigned long) srso_alias_safe_ret) {
+	    /* Modify stack pointer as if LEA executed: */
+	    regs->sp += 8;
+	}
+
+	/*
+	 * Adjust registers as if RET executed:
+	 *
+	 * 1. Read the return address off the stack and into rIP:
+	 */
+	regs->ip = *(unsigned long *)(regs->sp);
+
+	/* 2. Pop rIP off the stack: */
+	regs->sp += 8;
+}
+#endif /* CONFIG_MITIGATION_SRSO */
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 614fb9aee2ff..bc66ce29ccc8 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -168,10 +168,24 @@ __EXPORT_THUNK(srso_alias_untrain_ret)
 
 	.pushsection .text..__x86.rethunk_safe
 SYM_CODE_START_NOALIGN(srso_alias_safe_ret)
+
+	/*
+	 * Tell objtool that those are not function pointers referenced by
+	 * __HANDLE_INTR_SAFERET(). Below too.
+	 */
+	ANNOTATE_NOENDBR
+
+	/*
+	 * Safe-RET sequence. If you need to change it, adjust
+	 * handle_interrupted_saferet() too.
+	 */
 	lea 8(%_ASM_SP), %_ASM_SP
 	UNWIND_HINT_FUNC
+
+	ANNOTATE_NOENDBR
 	ANNOTATE_UNRET_SAFE
 	ret
+	/* End of Safe-RET sequence */
 	int3
 SYM_FUNC_END(srso_alias_safe_ret)
 
@@ -206,8 +220,14 @@ SYM_CODE_START_LOCAL_NOALIGN(srso_untrain_ret)
  * the stack.
  */
 SYM_INNER_LABEL(srso_safe_ret, SYM_L_GLOBAL)
+	/*
+	 * Safe-RET sequence. If you need to change it, adjust
+	 * handle_interrupted_saferet() too.
+	 */
 	lea 8(%_ASM_SP), %_ASM_SP
 	ret
+	/* End of Safe-RET sequence */
+
 	int3
 	int3
 	/* end of movabs */
