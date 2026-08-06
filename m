Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25A4388E63;
	Thu,  6 Aug 2026 17:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786037558; cv=none; b=EKGJHmutWIheENme0hB/KJ/nxyTyicOhsVGloZe+m+Xh1EhDJf5vRaygKA7+vngWqQQB1oCI8bVFvj5cNaL0QCGcspiZZq75M5EUvST3/ijZFUkR+1VrW0ZP9Wy8dC/Q5DhDnqxZvMjcSCNE88/LZrHJ+LI0jTsFx8JK5cspMYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786037558; c=relaxed/simple;
	bh=0x9OoI37Ffrtr9dFqDsZGzme17IMsoShoejuShec+UU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sxs4a0+nbNf3QWOPLG4rJFJjXlt+BycliGzxEcjiD43CgbFjHVa563TtuU/g/bVnwr1Kn+mRRYTVZoPbTYYO8GyUOLSnhpEKTnl4+e2jVnhfL4HzJMIu855xj4jL+FvkVM95tGlyDyyOPDuTkYhgO4wOWR4/oscbziLUbZoGKpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=etEiHatt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="etEiHatt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CABEC1F000E9;
	Thu,  6 Aug 2026 17:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786037556;
	bh=udy+Vvpu913GlaWU/7dPqIF8Yx82N0Fncl4iMUPJINQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=etEiHattEbaJuLnToZIFUAyWDeIPKIBKgcEVCAdhRl+6LuZltdvDVDse1y0aTWOhw
	 AhvmqnQg0JtmfmuX7cGsX4kb3f+ZPFARZRY0lvcH8qDlNlYHxcYLiB+OAzSIhcV4y9
	 wvXr2uJkcaTNfRQfdRFgr5nt8nxbb/wWhxNNSOmE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.1.181
Date: Thu,  6 Aug 2026 19:32:11 +0200
Message-ID: <2026080611-acts-crook-b693@gregkh>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026080611-conceal-wind-93c0@gregkh>
References: <2026080611-conceal-wind-93c0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index ea4eefa148dc..001fca49a962 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 1
-SUBLEVEL = 180
+SUBLEVEL = 181
 EXTRAVERSION =
 NAME = Curry Ramen
 
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 4f5968810450..bd7868a56800 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -966,6 +966,8 @@ SYM_CODE_START_LOCAL(paranoid_entry)
 	IBRS_ENTER save_reg=%r15
 	UNTRAIN_RET
 
+	HANDLE_INTR_SAFERET 8(%rsp)
+
 	RET
 SYM_CODE_END(paranoid_entry)
 
@@ -1070,6 +1072,9 @@ SYM_CODE_START_LOCAL(error_entry)
 	movl	%ecx, %eax			/* zero extend */
 	cmpq	%rax, RIP+8(%rsp)
 	je	.Lbstep_iret
+
+	HANDLE_INTR_SAFERET 8(%rsp)
+
 	cmpq	$.Lgs_change, RIP+8(%rsp)
 	jne	.Lerror_entry_done_lfence
 
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 818a5913f219..93e8db6f1ffc 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -87,6 +87,50 @@
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
@@ -201,6 +245,14 @@
 #endif
 .endm
 
+.macro HANDLE_INTR_SAFERET pt_regs
+#ifdef CONFIG_MITIGATION_SRSO
+	ALTERNATIVE_2 "", \
+	__stringify(__HANDLE_INTR_SAFERET(srso_safe_ret, \pt_regs)), X86_FEATURE_SRSO, \
+	__stringify(__HANDLE_INTR_SAFERET(srso_alias_safe_ret, \pt_regs)), X86_FEATURE_SRSO_ALIAS
+#endif
+.endm
+
 /*
  * Macro to execute VERW insns that mitigate transient data sampling
  * attacks such as MDS or TSA. On affected systems a microcode update
@@ -480,6 +532,10 @@ static __always_inline void x86_idle_clear_cpu_buffers(void)
 		x86_clear_cpu_buffers();
 }
 
+void srso_safe_ret(void);
+void srso_alias_safe_ret(void);
+void handle_interrupted_saferet(struct pt_regs *regs);
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_X86_NOSPEC_BRANCH_H_ */
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index a0b362ac50a1..501db29d1ca0 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -3398,3 +3398,42 @@ ssize_t cpu_show_vmscape(struct device *dev, struct device_attribute *attr, char
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
index e42661500094..03ea0273d7b4 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -115,10 +115,24 @@ __EXPORT_THUNK(srso_alias_untrain_ret)
 #endif
 
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
 
@@ -234,8 +248,14 @@ SYM_START(srso_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
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
