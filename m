Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C83451068
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 11:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780484846; cv=none; b=CeaYC0oPlnKah7BCLnaUtJvsUkpw+ZxOzjLR9laYD55KAuCz7QQrhTWZe8KxwpgsfV4K7DDndazWNAejtSOThWVNvs14FqzwoR2dNGUDVgfJ4FJADaM138dNCwntsS7QJi9Hb+CiDRAfTnSpn37Zg/OcyHTy17VcXH1Tb4a3fF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780484846; c=relaxed/simple;
	bh=qa4VWLyM71X55NxZ3evXCeAaoPLBf970s6cxNH2+MMg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ta/0BELGF97KJisnVRAfdseLu6TTvUQCioq4p6JxsHJP9RRqvHCm3uCqtse2MlG12bRwKXxADdSqCtXUAW5UNgH97F+VIWBPuhA/zxGnNPAQ320sp1QfBD9D/Ud+eY3On44N0qpz4NU0SAilEljwNN0caCo0e/WaO7kYncdQHdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=SBTUMAmJ; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="SBTUMAmJ"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F153732E4;
	Wed,  3 Jun 2026 04:07:16 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 267A43F86F;
	Wed,  3 Jun 2026 04:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780484841; bh=qa4VWLyM71X55NxZ3evXCeAaoPLBf970s6cxNH2+MMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SBTUMAmJz+64Q63njBa6QiDooAIUT6IYzCmiFkogHI7+emPxr3ueIP8osYtTeDH+x
	 zNEFE3LLOs9qr+DI05ICyMtf1h9F1qpDNTlO+Wux2tlL7dXVGNd+q488RrIbtihyXg
	 MM/GM6rqawPoJuol05ypMdxJJ7rWP92NortHe92Q=
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev
Cc: broonie@kernel.org,
	catalin.marinas@arm.com,
	james.morse@arm.com,
	mark.rutland@arm.com,
	maz@kernel.org,
	oupton@kernel.org,
	stable@vger.kernel.org,
	tabba@google.com,
	vladimir.murzin@arm.com,
	will@kernel.org
Subject: [PATCH v4 19/20] arm64: fpsimd: Move SME save/restore inline
Date: Wed,  3 Jun 2026 12:06:29 +0100
Message-Id: <20260603110630.1027435-20-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260603110630.1027435-1-mark.rutland@arm.com>
References: <20260603110630.1027435-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the SVE register save/restore sequences are written in
out-of-line assembly routines. While this works, it's somewhat painful:

* For KVM to use the sequences, portions of the logic will need to be
  duplicated in KVM hyp code. While the common logic can be shared in
  assembly macros, this is very likely to lead to unnecessary divergence
  and be a maintenance burden.

* For historical reasons, the assembly macros take some register
  arguments as numerical indices (e.g. "sme_save_za 0, x2, 12" uses x0, x1, and
  x12), which is simply confusing.

* Address generation and control flow are far clearer in C than in
  assembly.

* The assembly sequences can't be instrumented, and so it's harder than
  necessary to catch memory safety issues.

To handle the above, move the SME register save/restore sequences
to inline assembly.

Neither GCC nor LLVM instrument memory arguments to inline assembly, so
explicit instrumentation is added in the same manner as other assembly
routines. This instrumentation is implicitly disabled by Kbuild for nVHE
hyp code.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Fuad Tabba <tabba@google.com>
Cc: James Morse <james.morse@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oupton@kernel.org>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/fpsimd.h       | 106 +++++++++++++++++++++++++-
 arch/arm64/include/asm/fpsimdmacros.h |  76 ------------------
 arch/arm64/kernel/Makefile            |   2 +-
 arch/arm64/kernel/entry-fpsimd.S      |  48 ------------
 4 files changed, 104 insertions(+), 128 deletions(-)
 delete mode 100644 arch/arm64/kernel/entry-fpsimd.S

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 9dfe53204ebfb..a67d5774e6728 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -356,9 +356,6 @@ static inline void sve_flush_live(void)
 	);
 }
 
-extern void sme_save_state(struct arm64_sme_state *state, int zt);
-extern void sme_load_state(const struct arm64_sme_state *state, int zt);
-
 struct arm64_cpu_capabilities;
 extern void cpu_enable_fpsimd(const struct arm64_cpu_capabilities *__unused);
 extern void cpu_enable_sve(const struct arm64_cpu_capabilities *__unused);
@@ -638,6 +635,106 @@ static inline size_t __sme_state_size(unsigned int sme_vl)
 	return size;
 }
 
+static inline void __sme_save_za(struct arm64_sme_state *state, unsigned long svl)
+{
+	/*
+	 * The <Wv> argument to LDR/STR (array vector) can only encode W12-W15.
+	 * The "Ucj" constraint exists for this, but is only supported by GCC
+	 * 14.1.0+ and LLVM 18.1.0+.
+	 */
+	register unsigned int v asm ("w12");
+
+	instrument_write(state, svl * svl);
+	for (v = 0; v < svl; v++) {
+		void *pav = (void *)state + v * svl;
+
+		asm volatile(
+		__SME_PREAMBLE
+		"	str	za[%w[v], #0], [%[pav]]\n"
+		:
+		: [v] "r" (v),
+		  [pav] "r" (pav)
+		: "memory"
+		);
+	}
+}
+
+static inline void __sme_load_za(const struct arm64_sme_state *state, unsigned long svl)
+{
+	/* See comment in __sme_save_za */
+	register unsigned int v asm ("w12");
+
+	instrument_read(state, svl * svl);
+	for (v = 0; v < svl; v++) {
+		void *pav = (void *)state + v * svl;
+
+		asm volatile(
+		__SME_PREAMBLE
+		"	ldr	za[%w[v], #0], [%[pav]]\n"
+		:
+		: [v] "r" (v),
+		  [pav] "r" (pav)
+		: "memory"
+		);
+	}
+}
+
+static inline void __sme_save_zt(struct arm64_sme_state *state, unsigned long svl)
+{
+	void *pzt = (void *)state + svl * svl;
+
+	instrument_write(pzt, 64);
+	asm volatile(
+	__DEFINE_ASM_GPR_NUMS
+	/*
+	 * STR ZT0, [<Xn|SP>]
+	 * Supported by binutils 2.41+.
+	 * Supported by LLVM 16+
+	 */
+	"	.inst	0xe13f8000 | ((.L__gpr_num_%[pzt]) << 5)\n"
+	:
+	: [pzt] "r" (pzt)
+	: "memory"
+	);
+}
+
+static inline void __sme_load_zt(const struct arm64_sme_state *state, unsigned long svl)
+{
+	void *pzt = (void *)state + svl * svl;
+
+	instrument_read(pzt, 64);
+	asm volatile(
+	__DEFINE_ASM_GPR_NUMS
+	/*
+	 * LDR ZT0, [<Xn|SP>]
+	 * Supported by binutils 2.41+.
+	 * Supported by LLVM 16+
+	 */
+	"	.inst	0xe11f8000 | ((.L__gpr_num_%[pzt]) << 5)\n"
+	:
+	: [pzt] "r" (pzt)
+	: "memory"
+	);
+}
+
+static inline void sme_save_state(struct arm64_sme_state *state, bool zt)
+{
+	unsigned long svl = sme_get_vl();
+
+	__sme_save_za(state, svl);
+	if (zt)
+		__sme_save_zt(state, svl);
+}
+
+static inline void sme_load_state(const struct arm64_sme_state *state, bool zt)
+{
+	unsigned long svl = sme_get_vl();
+
+	__sme_load_za(state, svl);
+	if (zt)
+		__sme_load_zt(state, svl);
+}
+
 /*
  * Return how many bytes of memory are required to store the full SME
  * specific state for task, given task's currently configured vector
@@ -694,6 +791,9 @@ static inline size_t sme_state_size(struct task_struct const *task)
 	return 0;
 }
 
+static inline void sme_save_state(struct arm64_sme_state *state, bool zt) { BUILD_BUG(); }
+static inline void sme_load_state(const struct arm64_sme_state *state, bool zt) { BUILD_BUG(); }
+
 static inline void sme_enter_from_user_mode(void) { }
 static inline void sme_exit_to_user_mode(void) { }
 
diff --git a/arch/arm64/include/asm/fpsimdmacros.h b/arch/arm64/include/asm/fpsimdmacros.h
index 9e352b5c6b764..a763fd03ffef3 100644
--- a/arch/arm64/include/asm/fpsimdmacros.h
+++ b/arch/arm64/include/asm/fpsimdmacros.h
@@ -40,60 +40,6 @@
 	.endif
 .endm
 
-/* Deprecated macros for SME instructions */
-
-/* RDSVL X\nx, #\imm */
-.macro _sme_rdsvl nx, imm
-	.arch_extension sme
-	rdsvl x\nx, #\imm
-.endm
-
-/*
- * STR (vector from ZA array):
- *	STR ZA[W\nw, #\offset], [X\nxbase, #\offset, MUL VL]
- */
-.macro _sme_str_zav nw, nxbase, offset=0
-	.arch_extension sme
-	str	za[w\nw, #\offset], [x\nxbase, #\offset, MUL VL]
-.endm
-
-/*
- * LDR (vector to ZA array):
- *	LDR ZA[w\nw, #\offset], [X\nxbase, #\offset, MUL VL]
- */
-.macro _sme_ldr_zav nw, nxbase, offset=0
-	.arch_extension sme
-	ldr	za[w\nw, #\offset], [x\nxbase, #\offset, MUL VL]
-.endm
-
-/*
- * SME2 instruction encodings for older assemblers.
- * Supported by binutils 2.41+.
- * Supported by LLVM 16+
- */
-
-/*
- * LDR (ZT0)
- *
- *	LDR ZT0, nx
- */
-.macro _ldr_zt nx
-	_check_general_reg \nx
-	.inst	0xe11f8000	\
-		 | (\nx << 5)
-.endm
-
-/*
- * STR (ZT0)
- *
- *	STR ZT0, nx
- */
-.macro _str_zt nx
-	_check_general_reg \nx
-	.inst	0xe13f8000		\
-		| (\nx << 5)
-.endm
-
 .macro __for from:req, to:req
 	.if (\from) == (\to)
 		_for__body %\from
@@ -116,25 +62,3 @@
 
 	.purgem _for__body
 .endm
-
-.macro sme_save_za nxbase, xvl, nw
-	mov	w\nw, #0
-
-423:
-	_sme_str_zav \nw, \nxbase
-	add	x\nxbase, x\nxbase, \xvl
-	add	x\nw, x\nw, #1
-	cmp	\xvl, x\nw
-	bne	423b
-.endm
-
-.macro sme_load_za nxbase, xvl, nw
-	mov	w\nw, #0
-
-423:
-	_sme_ldr_zav \nw, \nxbase
-	add	x\nxbase, x\nxbase, \xvl
-	add	x\nw, x\nw, #1
-	cmp	\xvl, x\nw
-	bne	423b
-.endm
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 74b76bb704523..d2690c3ec5288 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -27,7 +27,7 @@ KCOV_INSTRUMENT_idle.o := n
 
 # Object file lists.
 obj-y			:= debug-monitors.o entry.o irq.o fpsimd.o		\
-			   entry-common.o entry-fpsimd.o process.o ptrace.o	\
+			   entry-common.o process.o ptrace.o			\
 			   setup.o signal.o sys.o stacktrace.o time.o traps.o	\
 			   io.o vdso.o hyp-stub.o psci.o cpu_ops.o		\
 			   return_address.o cpuinfo.o cpu_errata.o		\
diff --git a/arch/arm64/kernel/entry-fpsimd.S b/arch/arm64/kernel/entry-fpsimd.S
deleted file mode 100644
index 2a4755113b99a..0000000000000
--- a/arch/arm64/kernel/entry-fpsimd.S
+++ /dev/null
@@ -1,48 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * FP/SIMD state saving and restoring
- *
- * Copyright (C) 2012 ARM Ltd.
- * Author: Catalin Marinas <catalin.marinas@arm.com>
- */
-
-#include <linux/linkage.h>
-
-#include <asm/assembler.h>
-#include <asm/fpsimdmacros.h>
-
-#ifdef CONFIG_ARM64_SME
-
-/*
- * Save the ZA and ZT state
- *
- * x0 - pointer to buffer for state
- * w1 - number of ZT registers to save
- */
-SYM_FUNC_START(sme_save_state)
-	_sme_rdsvl	2, 1		// x2 = VL/8
-	sme_save_za 0, x2, 12		// Leaves x0 pointing to the end of ZA
-
-	cbz	w1, 1f
-	_str_zt 0
-1:
-	ret
-SYM_FUNC_END(sme_save_state)
-
-/*
- * Load the ZA and ZT state
- *
- * x0 - pointer to buffer for state
- * w1 - number of ZT registers to save
- */
-SYM_FUNC_START(sme_load_state)
-	_sme_rdsvl	2, 1		// x2 = VL/8
-	sme_load_za 0, x2, 12		// Leaves x0 pointing to the end of ZA
-
-	cbz	w1, 1f
-	_ldr_zt 0
-1:
-	ret
-SYM_FUNC_END(sme_load_state)
-
-#endif /* CONFIG_ARM64_SME */
-- 
2.30.2

