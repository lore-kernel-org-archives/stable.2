Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7F8451068
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 11:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780484841; cv=none; b=iurp0GDdwaVyKVuCyQCmNVVgHE3GFs7tqBLFepna6hASMFGxteY53cAgAZ8lCT+jk3NjY/c3OcMEzA0KR8umuRj+G4LN8FVYj0JjcYiyo++Fvo3vhGLnu+jA3Uvmm8rW4NUCRXXT4BZCPRRHCtQB45PPXkoQZ/QjmyVQy4kJ1LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780484841; c=relaxed/simple;
	bh=MctucuE/RquyQ8rQzi4hVupkVDdJwy/MUYG/ridAbbo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pCc9sbQ7Sp2vMwFQZbfIFJevFM7yjKj1xh0xjZIiKhakRzNACXulXmYXvQGZyp9p30il5Vq6+B6nbPTi+Pl4vnzlqD57TO+DV+DzbEtmmOZClTmntZGb6Q+a6GrgCERWL5ZUjaa80f+8fKwjKcfIA0yfd/DD8KEtmMSc0cMaBQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=h4MbKR+m; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="h4MbKR+m"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CAC1C32E4;
	Wed,  3 Jun 2026 04:07:12 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F3E6A3F86F;
	Wed,  3 Jun 2026 04:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780484837; bh=MctucuE/RquyQ8rQzi4hVupkVDdJwy/MUYG/ridAbbo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h4MbKR+md+jVNKWTr2Udu2oUR9XEo5DCP0U5YdZNUVy64wNFozji7uueDRRIfgE9Y
	 TleiEup4O95REHLWXMe1Ot131zzLtVUughHrUK0srRDMoCWg9IK6ej6x/vB1DB9ZDu
	 w2Ev1r1XJ/T/pfTdekm5zSwAs6IBPasFOJ2uVwmU=
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
Subject: [PATCH v4 17/20] arm64: fpsimd: Move SVE save/restore inline
Date: Wed,  3 Jun 2026 12:06:27 +0100
Message-Id: <20260603110630.1027435-18-mark.rutland@arm.com>
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

* As KVM needs to be able to use the sequences in hyp code, separate
  assembly files are used for the regular kernel and KVM code. While the
  common logic is shared in assembly macros, this still requires some
  duplication, and has lead to some trivial divergence.

* As the SVE LDR/STR instrucitons have limited addressing modes, the
  assembly macros use an awkward pattern requiring negative offsets.
  This could be written more clearly with addresses being generated in C
  code.

* As the FFR does not always exist in streaming mode, some awkward
  conditional branching has been written in assembly which could be
  clearer in C (and would permit the compiler to optimize out
  unnecessary branches in some cases).

* For historical reasons, the assembly macros take some register
  arguments as numerical indices (e.g. "sve_save 0, x1" uses x0 and x1),
  which is simply confusing.

* For historical reasons, the SVE save/restore code and FPSIMD
  save/restore code have a distinct sequences for FPSR and FPCR. Ideally
  this logic would be shared.

* The assembly sequences can't be instrumented, and so it's harder than
  necessary to catch memory safety issues.

To handle the above, move the SVE register save/restore sequences
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
 arch/arm64/include/asm/fpsimd.h         | 119 +++++++++++++++++++++++-
 arch/arm64/include/asm/fpsimdmacros.h   |  61 ------------
 arch/arm64/include/asm/kvm_hyp.h        |   3 -
 arch/arm64/kernel/entry-fpsimd.S        |  22 -----
 arch/arm64/kvm/hyp/fpsimd.S             |  21 -----
 arch/arm64/kvm/hyp/include/hyp/switch.h |   4 +-
 arch/arm64/kvm/hyp/nvhe/Makefile        |   2 +-
 arch/arm64/kvm/hyp/nvhe/hyp-main.c      |   4 +-
 arch/arm64/kvm/hyp/vhe/Makefile         |   2 +-
 9 files changed, 123 insertions(+), 115 deletions(-)
 delete mode 100644 arch/arm64/kvm/hyp/fpsimd.S

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index fff6d54afd9fe..8f1b844f000fa 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -215,8 +215,123 @@ static inline unsigned int sve_get_vl(void)
 	return vl;
 }
 
-extern void sve_save_state(struct arm64_sve_state *state, int save_ffr);
-extern void sve_load_state(const struct arm64_sve_state *state, int restore_ffr);
+#define FOR_EACH_Z_REG(idx_str, asm_str)											\
+	"	.irp " idx_str ",0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31\n"	\
+	asm_str	"\n"														\
+	"	.endr\n"
+
+#define FOR_EACH_P_REG(idx_str, asm_str)											\
+	"	.irp " idx_str ",0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15\n"	\
+	asm_str	"\n"								\
+	"	.endr\n"
+
+static inline void __sve_save_z(struct arm64_sve_state *state, unsigned long vl)
+{
+	instrument_write(state, SVE_NUM_ZREGS * vl);
+	asm volatile(
+	__SVE_PREAMBLE
+	FOR_EACH_Z_REG("n", "str	z\\n, [%[zregs], #\\n, MUL VL]")
+	:
+	: [zregs] "r" (state)
+	: "memory"
+	);
+}
+
+static inline void __sve_load_z(const struct arm64_sve_state *state, unsigned long vl)
+{
+	instrument_read(state, SVE_NUM_ZREGS * vl);
+	asm volatile(
+	__SVE_PREAMBLE
+	FOR_EACH_Z_REG("n", "ldr	z\\n, [%[zregs], #\\n, MUL VL]")
+	:
+	: [zregs] "r" (state)
+	: "memory"
+	);
+}
+
+static inline void __sve_save_p(struct arm64_sve_state *state, unsigned long vl, bool ffr)
+{
+	void *pregs = (void *)state + SVE_NUM_ZREGS * vl;
+	unsigned long pl = vl / 8;
+	void *pffr = pregs + SVE_NUM_PREGS * pl;
+
+	instrument_write(pregs, SVE_NUM_PREGS * pl);
+	asm volatile(
+	__SVE_PREAMBLE
+	FOR_EACH_P_REG("n", "str	p\\n, [%[pregs], #\\n, MUL VL]\n")
+	:
+	: [pregs] "r" (pregs)
+	: "memory"
+	);
+
+	instrument_write(pffr, pl);
+	if (ffr) {
+		asm volatile(
+		__SVE_PREAMBLE
+		"	rdffr	p0.b\n"
+		"	str	p0, [%[pffr]]\n"
+		"	ldr	p0, [%[pregs]]\n"
+		:
+		: [pregs] "r" (pregs),
+		  [pffr] "r" (pffr)
+		: "memory"
+		);
+	} else {
+		asm volatile(
+		__SVE_PREAMBLE
+		"	pfalse	p0.b\n"
+		"	str	p0, [%[pffr]]\n"
+		"	ldr	p0, [%[pregs]]\n"
+		:
+		: [pregs] "r" (pregs),
+		  [pffr] "r" (pffr)
+		: "memory"
+		);
+	}
+}
+
+static inline void __sve_load_p(const struct arm64_sve_state *state, unsigned long vl, bool ffr)
+{
+	const void *pregs = (const void *)state + SVE_NUM_ZREGS * vl;
+	unsigned long pl = vl / 8;
+	const void *pffr = pregs + SVE_NUM_PREGS * pl;
+
+	if (ffr) {
+		instrument_read(pffr, pl);
+		asm volatile(
+		__SVE_PREAMBLE
+		"	ldr	p0, [%[pffr]]\n"
+		"	wrffr	p0.b\n"
+		:
+		: [pffr] "r" (pffr)
+		: "memory"
+		);
+	}
+
+	instrument_read(pregs, SVE_NUM_PREGS * pl);
+	asm volatile(
+	__SVE_PREAMBLE
+	FOR_EACH_P_REG("n", "ldr	p\\n, [%[pregs], #\\n, MUL VL]\n")
+	:
+	: [pregs] "r" (pregs)
+	: "memory"
+	);
+}
+
+static inline void sve_save_state(struct arm64_sve_state *state, bool ffr)
+{
+	unsigned long vl = sve_get_vl();
+	__sve_save_z(state, vl);
+	__sve_save_p(state, vl, ffr);
+}
+
+static inline void sve_load_state(const struct arm64_sve_state *state, bool ffr)
+{
+	unsigned long vl = sve_get_vl();
+	__sve_load_z(state, vl);
+	__sve_load_p(state, vl, ffr);
+}
+
 extern void sve_flush_live(bool flush_ffr, unsigned long vq_minus_1);
 extern void sme_save_state(struct arm64_sme_state *state, int zt);
 extern void sme_load_state(const struct arm64_sme_state *state, int zt);
diff --git a/arch/arm64/include/asm/fpsimdmacros.h b/arch/arm64/include/asm/fpsimdmacros.h
index e613dc94dc357..5f03fe51d0bff 100644
--- a/arch/arm64/include/asm/fpsimdmacros.h
+++ b/arch/arm64/include/asm/fpsimdmacros.h
@@ -42,36 +42,6 @@
 
 /* Deprecated macros for SVE instructions */
 
-/* STR (vector): STR Z\nz, [X\nxbase, #\offset, MUL VL] */
-.macro _sve_str_v nz, nxbase, offset=0
-	.arch_extension sve
-	str	z\nz, [X\nxbase, #\offset, MUL VL]
-.endm
-
-/* LDR (vector): LDR Z\nz, [X\nxbase, #\offset, MUL VL] */
-.macro _sve_ldr_v nz, nxbase, offset=0
-	.arch_extension sve
-	ldr	z\nz, [X\nxbase, #\offset, MUL VL]
-.endm
-
-/* STR (predicate): STR P\np, [X\nxbase, #\offset, MUL VL] */
-.macro _sve_str_p np, nxbase, offset=0
-	.arch_extension sve
-	str	p\np, [X\nxbase, #\offset, MUL VL]
-.endm
-
-/* LDR (predicate): LDR P\np, [X\nxbase, #\offset, MUL VL] */
-.macro _sve_ldr_p np, nxbase, offset=0
-	.arch_extension sve
-	ldr p\np, [x\nxbase, #\offset, MUL VL]
-.endm
-
-/* RDFFR (unpredicated): RDFFR P\np.B */
-.macro _sve_rdffr np
-	.arch_extension sve
-	rdffr p\np\().b
-.endm
-
 /* WRFFR P\np.B */
 .macro _sve_wrffr np
 	.arch_extension sve
@@ -177,37 +147,6 @@
 		_sve_wrffr	0
 .endm
 
-.macro _sve_pffr ptr
-	.arch_extension sve
-	addvl	\ptr, \ptr, #16
-	addvl	\ptr, \ptr, #16
-	addpl	\ptr, \ptr, #16
-.endm
-
-.macro sve_save nxbase, save_ffr
-		_sve_pffr	x\nxbase
- _for n, 0, 31,	_sve_str_v	\n, \nxbase, \n - 34
- _for n, 0, 15,	_sve_str_p	\n, \nxbase, \n - 16
-		cbz		\save_ffr, 921f
-		_sve_rdffr	0
-		b		922f
-921:
-		_sve_pfalse	0			// Zero out FFR
-922:
-		_sve_str_p	0, \nxbase
-		_sve_ldr_p	0, \nxbase, -16
-.endm
-
-.macro sve_load nxbase, restore_ffr
-		_sve_pffr	x\nxbase
- _for n, 0, 31,	_sve_ldr_v	\n, \nxbase, \n - 34
-		cbz		\restore_ffr, 921f
-		_sve_ldr_p	0, \nxbase
-		_sve_wrffr	0
-921:
- _for n, 0, 15,	_sve_ldr_p	\n, \nxbase, \n - 16
-.endm
-
 .macro sme_save_za nxbase, xvl, nw
 	mov	w\nw, #0
 
diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
index 190c256e34c03..ad19de1d0654f 100644
--- a/arch/arm64/include/asm/kvm_hyp.h
+++ b/arch/arm64/include/asm/kvm_hyp.h
@@ -121,9 +121,6 @@ void __debug_save_host_buffers_nvhe(struct kvm_vcpu *vcpu);
 void __debug_restore_host_buffers_nvhe(struct kvm_vcpu *vcpu);
 #endif
 
-void __sve_save_state(struct arm64_sve_state *sve, int save_ffr);
-void __sve_restore_state(struct arm64_sve_state *sve, int restore_ffr);
-
 u64 __guest_enter(struct kvm_vcpu *vcpu);
 
 bool kvm_host_psci_handler(struct kvm_cpu_context *host_ctxt, u32 func_id);
diff --git a/arch/arm64/kernel/entry-fpsimd.S b/arch/arm64/kernel/entry-fpsimd.S
index 66668bfca5ae8..f957536356255 100644
--- a/arch/arm64/kernel/entry-fpsimd.S
+++ b/arch/arm64/kernel/entry-fpsimd.S
@@ -13,28 +13,6 @@
 
 #ifdef CONFIG_ARM64_SVE
 
-/*
- * Save the SVE state
- *
- * x0 - pointer to buffer for state
- * w1 - Save FFR if non-zero
- */
-SYM_FUNC_START(sve_save_state)
-	sve_save 0, w1
-	ret
-SYM_FUNC_END(sve_save_state)
-
-/*
- * Load the SVE state
- *
- * x0 - pointer to buffer for state
- * w1 - Restore FFR if non-zero
- */
-SYM_FUNC_START(sve_load_state)
-	sve_load 0, w1
-	ret
-SYM_FUNC_END(sve_load_state)
-
 /*
  * Zero all SVE registers but the first 128-bits of each vector
  *
diff --git a/arch/arm64/kvm/hyp/fpsimd.S b/arch/arm64/kvm/hyp/fpsimd.S
deleted file mode 100644
index 00c56e31484a5..0000000000000
--- a/arch/arm64/kvm/hyp/fpsimd.S
+++ /dev/null
@@ -1,21 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) 2015 - ARM Ltd
- * Author: Marc Zyngier <marc.zyngier@arm.com>
- */
-
-#include <linux/linkage.h>
-
-#include <asm/fpsimdmacros.h>
-
-	.text
-
-SYM_FUNC_START(__sve_restore_state)
-	sve_load 0, w1
-	ret
-SYM_FUNC_END(__sve_restore_state)
-
-SYM_FUNC_START(__sve_save_state)
-	sve_save 0, w1
-	ret
-SYM_FUNC_END(__sve_save_state)
diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index ee366a536c77b..1f12c4ba295a4 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -467,7 +467,7 @@ static inline void __hyp_sve_restore_guest(struct kvm_vcpu *vcpu)
 	 * vCPU. Start off with the max VL so we can load the SVE state.
 	 */
 	sve_cond_update_zcr_vq(vcpu_sve_max_vq(vcpu) - 1, SYS_ZCR_EL2);
-	__sve_restore_state(kern_hyp_va(vcpu->arch.sve_state), true);
+	sve_load_state(kern_hyp_va(vcpu->arch.sve_state), true);
 	fpsimd_load_common(&vcpu->arch.ctxt.fp_regs);
 
 	/*
@@ -488,7 +488,7 @@ static inline void __hyp_sve_save_host(void)
 
 	ctxt_sys_reg(hctxt, ZCR_EL1) = read_sysreg_el1(SYS_ZCR);
 	write_sysreg_s(sve_vq_from_vl(kvm_host_sve_max_vl) - 1, SYS_ZCR_EL2);
-	__sve_save_state(sve_regs, true);
+	sve_save_state(sve_regs, true);
 	fpsimd_save_common(&hctxt->fp_regs);
 }
 
diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index 62cdfbff75625..f57450ebcb498 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -26,7 +26,7 @@ hyp-obj-y := timer-sr.o sysreg-sr.o debug-sr.o switch.o tlb.o hyp-init.o host.o
 	 hyp-main.o hyp-smp.o psci-relay.o early_alloc.o page_alloc.o \
 	 cache.o setup.o mm.o mem_protect.o sys_regs.o pkvm.o stacktrace.o ffa.o
 hyp-obj-y += ../vgic-v3-sr.o ../aarch32.o ../vgic-v2-cpuif-proxy.o ../entry.o \
-	 ../fpsimd.o ../hyp-entry.o ../exception.o ../pgtable.o ../vgic-v5-sr.o
+	 ../hyp-entry.o ../exception.o ../pgtable.o ../vgic-v5-sr.o
 hyp-obj-y += ../../../kernel/smccc-call.o
 hyp-obj-$(CONFIG_LIST_HARDENED) += list_debug.o
 hyp-obj-$(CONFIG_NVHE_EL2_TRACING) += clock.o trace.o events.o
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index b7d6faf07f71e..51dad35000f5a 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -35,7 +35,7 @@ static void __hyp_sve_save_guest(struct kvm_vcpu *vcpu)
 	 * on the VL, so use a consistent (i.e., the maximum) guest VL.
 	 */
 	sve_cond_update_zcr_vq(vcpu_sve_max_vq(vcpu) - 1, SYS_ZCR_EL2);
-	__sve_save_state(kern_hyp_va(vcpu->arch.sve_state), true);
+	sve_save_state(kern_hyp_va(vcpu->arch.sve_state), true);
 	fpsimd_save_common(&vcpu->arch.ctxt.fp_regs);
 	write_sysreg_s(sve_vq_from_vl(kvm_host_sve_max_vl) - 1, SYS_ZCR_EL2);
 }
@@ -55,7 +55,7 @@ static void __hyp_sve_restore_host(void)
 	 * need to be revisited.
 	 */
 	write_sysreg_s(sve_vq_from_vl(kvm_host_sve_max_vl) - 1, SYS_ZCR_EL2);
-	__sve_restore_state(sve_regs, true);
+	sve_load_state(sve_regs, true);
 	fpsimd_load_common(&hctxt->fp_regs);
 	write_sysreg_el1(ctxt_sys_reg(hctxt, ZCR_EL1), SYS_ZCR);
 }
diff --git a/arch/arm64/kvm/hyp/vhe/Makefile b/arch/arm64/kvm/hyp/vhe/Makefile
index 9695328bbd96e..d6b3475145c0e 100644
--- a/arch/arm64/kvm/hyp/vhe/Makefile
+++ b/arch/arm64/kvm/hyp/vhe/Makefile
@@ -10,4 +10,4 @@ CFLAGS_switch.o += -Wno-override-init
 
 obj-y := timer-sr.o sysreg-sr.o debug-sr.o switch.o tlb.o
 obj-y += ../vgic-v3-sr.o ../aarch32.o ../vgic-v2-cpuif-proxy.o ../entry.o \
-	 ../fpsimd.o ../hyp-entry.o ../exception.o ../vgic-v5-sr.o
+	 ../hyp-entry.o ../exception.o ../vgic-v5-sr.o
-- 
2.30.2

