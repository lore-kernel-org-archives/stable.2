Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AC944A3E6;
	Fri,  7 Aug 2026 06:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786083609; cv=none; b=nnGX8UO/+pzG4HC8zOR20k118aXOE2/0avai57vJL4uMF2XZTPcion7c0adf7bIuNjGzudvTzljdP5xLnTUJTWFVXyJuJE6vWPTyqAJvAxHpDyyRY9jORkMVUoPxbJXCJkJggSkTH3ynBysK2VAbDvUbIeO0lszet5YT3S4Qqyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786083609; c=relaxed/simple;
	bh=1Wxg/4UzOZWLlN4ewe8SQ01rA6Fn1PZnDTM1stZd/Cg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r4AxcdCEg8JPFF0djkebKn7/8lxZJjeWHlgtb7F+bXTsssh8wG8yTjtoIenDpmK2vAAX10lI3bE5o8tVeSWXI7CKj/+/WIDdMX3t7aNQCNdv0j8PBluyhGZEUOd3gzovLtfKDl6AOsl6Hf2HJEbfo/+pSY6Pqsjv/cidkCmiyVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RJhU0ENG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RJhU0ENG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDA3C1F000E9;
	Fri,  7 Aug 2026 06:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786083607;
	bh=NIh1zqK5x1NaxBFC4N5dGLOJtBeUId6ybYkiqp43jWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RJhU0ENGP6N6Kxq/ORXfHVgR7bA8Zg6k8Ql3Gvg3mQLCOIpUuvbGOfeKNSAz6SfM+
	 ga2/e7rdAz1nIjKyEaapAwS0JZsLzs+xV98X/jlrlYtSTAFFD5ZIKHbOQwubxsSwpV
	 7qZYakaJybEOPUBzxzZDJCKlmvR4rXTWoVIYsZCM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.1.182
Date: Fri,  7 Aug 2026 08:19:43 +0200
Message-ID: <2026080743-reissue-sasquatch-f032@gregkh>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026080743-whacking-goon-ca2c@gregkh>
References: <2026080743-whacking-goon-ca2c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 001fca49a962..a8d0a4d5fdc3 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 1
-SUBLEVEL = 181
+SUBLEVEL = 182
 EXTRAVERSION =
 NAME = Curry Ramen
 
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 93e8db6f1ffc..6a0071b560f9 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -87,50 +87,6 @@
 	add	$(BITS_PER_LONG/8), %_ASM_SP;		\
 	lfence;
 
-/*
- * Helper for detecting if an interrupt occurred at an unsafe location within
- * Safe-RET.  If Safe-RET is interrupted after the CALL or LEA the RSB may get
- * poisoned by the interrupt handler.
- *
- * The Safe-RET sequence is:
- *
- * CALL
- * LEA 8(%RSP), %RSP
- * RET
- *
- * The two CMPs below check whether RIP points to after the CALL or after the
- * LEA.
- *
- * The LFENCE below is to address this particular speculation case:
- *
- * 1. Userspace runs and poisons the BTB around the safe-RET routine
- *
- * 2. Userspace triggers some kind of exception
- *
- * 3. Kernel executes error_entry() and mis-speculates the branch into thinking
- *    it actually came from kernel space
- *
- * 4. The kernel then further mis-speculates that the exception occurred due
- *    to an interrupted safe-RET
- *
- * 5. The handle_interrupted_saferet() routine speculatively executes and
- *    speculatively does a safe-RET. But this is unsafe since it was never
- *    untrained.
- *
- * The LFENCE fixes this by ensuring step 5 is never reached speculatively.
- * Note that this LFENCE only occurs if safe-RET was actually interrupted (so
- * it's outside of the normal path).
- */
-#define __HANDLE_INTR_SAFERET(name, pt_regs)		\
-	cmpq	$(name), RIP+pt_regs;			\
-	jb	1f;					\
-	cmpq	$(name)+5, RIP+pt_regs;			\
-	ja	1f;					\
-	lfence;						\
-	leaq	pt_regs, %rdi;				\
-	call	handle_interrupted_saferet;		\
-	1:
-
 #ifdef __ASSEMBLY__
 
 /*
@@ -246,10 +202,10 @@
 .endm
 
 .macro HANDLE_INTR_SAFERET pt_regs
-#ifdef CONFIG_MITIGATION_SRSO
-	ALTERNATIVE_2 "", \
-	__stringify(__HANDLE_INTR_SAFERET(srso_safe_ret, \pt_regs)), X86_FEATURE_SRSO, \
-	__stringify(__HANDLE_INTR_SAFERET(srso_alias_safe_ret, \pt_regs)), X86_FEATURE_SRSO_ALIAS
+#ifdef CONFIG_CPU_SRSO
+	ALTERNATIVE_2 "",							\
+		      "call __handle_intr_saferet", X86_FEATURE_SRSO,		\
+		      "call __handle_intr_saferet_alias", X86_FEATURE_SRSO_ALIAS
 #endif
 .endm
 
@@ -332,6 +288,11 @@ extern void srso_alias_untrain_ret(void);
 extern void entry_untrain_ret(void);
 extern void entry_ibpb(void);
 
+struct pt_regs;
+void srso_safe_ret(void);
+void srso_alias_safe_ret(void);
+void handle_interrupted_saferet(struct pt_regs *regs);
+
 #ifdef CONFIG_X86_64
 extern void clear_bhb_loop(void);
 #endif
@@ -532,10 +493,6 @@ static __always_inline void x86_idle_clear_cpu_buffers(void)
 		x86_clear_cpu_buffers();
 }
 
-void srso_safe_ret(void);
-void srso_alias_safe_ret(void);
-void handle_interrupted_saferet(struct pt_regs *regs);
-
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_X86_NOSPEC_BRANCH_H_ */
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 501db29d1ca0..3af97b509792 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -3399,7 +3399,7 @@ ssize_t cpu_show_vmscape(struct device *dev, struct device_attribute *attr, char
 }
 #endif
 
-#ifdef CONFIG_MITIGATION_SRSO
+#ifdef CONFIG_CPU_SRSO
 /*
  * Called during exception/interrupt entry if interrupted during the
  * safe-RET sequence.  The safe-RET sequence consists of 3 instructions:
@@ -3422,8 +3422,8 @@ void noinstr handle_interrupted_saferet(struct pt_regs *regs)
 
 	if (rip == (unsigned long) srso_safe_ret ||
 	    rip == (unsigned long) srso_alias_safe_ret) {
-	    /* Modify stack pointer as if LEA executed: */
-	    regs->sp += 8;
+		/* Modify stack pointer as if LEA executed: */
+		regs->sp += 8;
 	}
 
 	/*
@@ -3436,4 +3436,4 @@ void noinstr handle_interrupted_saferet(struct pt_regs *regs)
 	/* 2. Pop rIP off the stack: */
 	regs->sp += 8;
 }
-#endif /* CONFIG_MITIGATION_SRSO */
+#endif /* CONFIG_CPU_SRSO */
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 03ea0273d7b4..245273a39417 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -7,6 +7,7 @@
 #include <asm/alternative.h>
 #include <asm/export.h>
 #include <asm/nospec-branch.h>
+#include <asm/ptrace-abi.h>
 #include <asm/unwind_hints.h>
 #include <asm/frame.h>
 #include <asm/nops.h>
@@ -118,7 +119,7 @@ SYM_START(srso_alias_safe_ret, SYM_L_GLOBAL, SYM_A_NONE)
 
 	/*
 	 * Tell objtool that those are not function pointers referenced by
-	 * __HANDLE_INTR_SAFERET(). Below too.
+	 * __handle_intr_saferet() / __handle_intr_saferet_alias(). Below too.
 	 */
 	ANNOTATE_NOENDBR
 
@@ -136,6 +137,64 @@ SYM_START(srso_alias_safe_ret, SYM_L_GLOBAL, SYM_A_NONE)
 	int3
 SYM_FUNC_END(srso_alias_safe_ret)
 
+#ifdef CONFIG_CPU_SRSO
+	.pushsection .noinstr.text, "ax"
+
+/*
+ * Out-of-line helpers for HANDLE_INTR_SAFERET.
+ *
+ * Called via ALTERNATIVE_2 from paranoid_entry / error_entry. There is one
+ * entry per SRSO variant so that each only checks its own Safe-RET range,
+ * mirroring the upstream per-feature ALTERNATIVE_2:
+ *
+ *   X86_FEATURE_SRSO       -> __handle_intr_saferet       (srso_safe_ret)
+ *   X86_FEATURE_SRSO_ALIAS -> __handle_intr_saferet_alias (srso_alias_safe_ret)
+ *
+ * If the interrupted RIP falls within the 5-byte Safe-RET sequence, emulate
+ * the remainder of the sequence by calling handle_interrupted_saferet().
+ *
+ * Stack layout on entry (CALL pushed return address):
+ *   pt_regs base at 16(%rsp), RIP field at RIP+16(%rsp)
+ *   (RIP is the pt_regs RIP offset (128) from <asm/ptrace-abi.h>; +16 = 8 for
+ *    pt_regs base at 8(%rsp) at the call site + 8 for the CALL return address)
+ *
+ * The pt_regs pointer is loaded into %rdi *before* FRAME_BEGIN so the 16(%rsp)
+ * offset does not depend on CONFIG_FRAME_POINTER (which would push %rbp and
+ * shift %rsp). FRAME_BEGIN/FRAME_END set up a frame pointer so the call to
+ * handle_interrupted_saferet() does not trip objtool's frame-pointer check on
+ * CONFIG_FRAME_POINTER builds; both are no-ops otherwise.
+ *
+ * Both entries are emitted from one macro: @safe_ret is the label at the start
+ * of the 5-byte Safe-RET sequence whose range the interrupted RIP is tested
+ * against; \@ yields a unique local label per macro instantiation.
+ */
+.macro HANDLE_INTR_SAFERET_FN name safe_ret
+SYM_FUNC_START(\name)
+	UNWIND_HINT_FUNC
+
+	/* Load pt_regs pointer before FRAME_BEGIN adjusts %rsp. */
+	leaq	16(%rsp), %rdi
+	FRAME_BEGIN
+
+	/* Check range: [\safe_ret, \safe_ret + 5] */
+	cmpq	$\safe_ret, RIP(%rdi)
+	jb	.Ldone_\@
+	cmpq	$\safe_ret + 5, RIP(%rdi)
+	ja	.Ldone_\@
+	lfence
+	call	handle_interrupted_saferet
+.Ldone_\@:
+	FRAME_END
+	RET
+SYM_FUNC_END(\name)
+.endm
+
+HANDLE_INTR_SAFERET_FN __handle_intr_saferet	   srso_safe_ret
+HANDLE_INTR_SAFERET_FN __handle_intr_saferet_alias srso_alias_safe_ret
+
+	.popsection
+#endif /* CONFIG_CPU_SRSO */
+
 	.section .text..__x86.return_thunk
 
 SYM_CODE_START(srso_alias_return_thunk)
