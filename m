Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE067486B8E;
	Thu,  6 Aug 2026 17:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786037566; cv=none; b=YcV8KzvvqRYaMeO/1JJPghxJURhERkFM+TbqcR57CP7llggTskGTs9lPr8DORKKhVQ0ZlRRMAJFGUQOZdnd1m1HzpsCv0ZzO/wkubNZ93WQZ3GIjJl/4F+2PE6B38uuA4nJocK16PXT0PGltA0mTVCFnaVzUMLydmCkxfI+HSEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786037566; c=relaxed/simple;
	bh=h2rYxeyVUMGpZ2+HE0lARhBt6GTE6+7kpY+UjHyslMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kup6TgKK/ZCTWsOuIgrpiEJQnNgaZrZ0Fl8DevAmq7qFvJK0G2sihQh0E4IsS+Cv57584S68wuCRhl2aKhIJ2pwAxnoTII4XcNYCg2Whn/7Abe6NgjVCc9mDAP2oqSi7PD5JpYM1cng18EhJONGJKYnsp1Z7+totq7tgj/FqZRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0NPFaVwA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0NPFaVwA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E65631F000E9;
	Thu,  6 Aug 2026 17:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786037564;
	bh=I+ueffa3hX1LdO4884sCjKdubfuJGNtdB1xLGSmfwDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=0NPFaVwAfsDPqK2axu3R2CgLVDJ6Lx3GZNWn3LsJvMBvIf0hIKw+i0pzEn73pQ3B7
	 C2xPqD+im2hxxilTI8GQ1kIBFrbjq88zmyQIJJuPUO6O6a2IfPOEEqo+MAr8KbiALD
	 kxJHo30gZHu0s2jJ1ngGNaZRSlXqSeEr/yO2kfzE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.6.149
Date: Thu,  6 Aug 2026 19:32:18 +0200
Message-ID: <2026080618-daylong-ducky-c649@gregkh>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026080618-mulch-nullify-723f@gregkh>
References: <2026080618-mulch-nullify-723f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 62de0a92ea10..f64070d333e2 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 6
-SUBLEVEL = 148
+SUBLEVEL = 149
 EXTRAVERSION =
 NAME = Pinguïn Aangedreven
 
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 1f9e508ac075..3aee64b51921 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -976,6 +976,8 @@ SYM_CODE_START(paranoid_entry)
 	IBRS_ENTER save_reg=%r15
 	UNTRAIN_RET_FROM_CALL
 
+	HANDLE_INTR_SAFERET 8(%rsp)
+
 	RET
 SYM_CODE_END(paranoid_entry)
 
@@ -1078,6 +1080,11 @@ SYM_CODE_START(error_entry)
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
 
@@ -1096,7 +1103,6 @@ SYM_CODE_START(error_entry)
 	FENCE_SWAPGS_KERNEL_ENTRY
 	CALL_DEPTH_ACCOUNT
 	leaq	8(%rsp), %rax			/* return pt_regs pointer */
-	VALIDATE_UNRET_END
 	RET
 
 .Lbstep_iret:
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index c7d019b0ef4a..43a2daeef5ef 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -186,6 +186,50 @@
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
+ */
+#define __HANDLE_INTR_SAFERET(name, pt_regs)		\
+	cmpq	$(name), RIP+pt_regs;			\
+	jb	1f;					\
+	cmpq	$(name)+5, RIP+pt_regs;			\
+	ja	1f;					\
+	lfence;						\
+	leaq	pt_regs, %rdi;				\
+	call	handle_interrupted_saferet;		\
+	1:
+
 #ifdef __ASSEMBLY__
 
 /*
@@ -315,6 +359,14 @@
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
 #ifdef CONFIG_CALL_DEPTH_TRACKING
@@ -649,6 +701,10 @@ static __always_inline void x86_idle_clear_cpu_buffers(void)
 		x86_clear_cpu_buffers();
 }
 
+void srso_safe_ret(void);
+void srso_alias_safe_ret(void);
+void handle_interrupted_saferet(struct pt_regs *regs);
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_X86_NOSPEC_BRANCH_H_ */
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 32a27c19acde..bf57acd42186 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -3489,3 +3489,42 @@ ssize_t cpu_show_vmscape(struct device *dev, struct device_attribute *attr, char
 	return cpu_show_common(dev, attr, buf, X86_BUG_VMSCAPE);
 }
 #endif
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
index 91ce427d5af1..46404f46140e 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -161,10 +161,24 @@ __EXPORT_THUNK(srso_alias_untrain_ret)
 
 	.pushsection .text..__x86.rethunk_safe
 SYM_START(srso_alias_safe_ret, SYM_L_GLOBAL, SYM_A_NONE)
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
 
@@ -199,8 +213,14 @@ SYM_START(srso_untrain_ret, SYM_L_LOCAL, SYM_A_NONE)
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
