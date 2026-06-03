Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3CF44CF2E
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 11:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780484833; cv=none; b=SFtlrE6Hx0tOQJM+87YoTHWEytBPW2mVd+2ki0MfVRwZS1CUxI4xvTO+NBMiTToRiqT8UYdzmyBHmXaEIYGl5HZCvmMo0I61GYnusFNfnULBknzBanro79AJyl/DtzMb8lthGq5IstXUsjXUKjCPrJqebtLxkrODgCwaKI/wPx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780484833; c=relaxed/simple;
	bh=DYBnAKp1/zW05PdVx3dPgQKKxTf7R0xzC+dnCRvd7ck=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HGX/jtrdJUDH7WrYtWmLBADvFdXhVM0TrTDZO20QjqS22Y7xfjVP0ScdwbJHzcrVxp2FJAhP0EgjhEIcz/GhT8TauAR7ubFL3IJPiAK5KK8025+wIigJt7moj8ksJpQQv1zuVE8FLnVT3cw/ZqEjisBaCpakMKJwk4B0Z/VjxLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=VhprA+x/; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="VhprA+x/"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 911DD49FB;
	Wed,  3 Jun 2026 04:07:06 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B91023F86F;
	Wed,  3 Jun 2026 04:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780484831; bh=DYBnAKp1/zW05PdVx3dPgQKKxTf7R0xzC+dnCRvd7ck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VhprA+x/fDrce2Tcz9whkJbF2W2pfeBcBCBNtP1x41ljPhKRu5+HR0bZzcC54A4WJ
	 kwwGNIHABitICyD3TaXZ1zWpPuue0084/APSDPpDmxMfaWqr8zJ4c1AUt7AnjfR+dE
	 OyOBo27bRalC8kD2If6R3BTaxQ/SiADG1MeC61dI=
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
Subject: [PATCH v4 14/20] arm64: fpsimd: Move fpsimd save/restore inline
Date: Wed,  3 Jun 2026 12:06:24 +0100
Message-Id: <20260603110630.1027435-15-mark.rutland@arm.com>
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

Currently the FPSIMD register save/restore sequences are written in
out-of-line assembly routines. While this works, it's somewhat painful:

* As KVM needs to be able to use the sequences in hyp code, separate
  assembly files are used for the regular kernel and KVM code. While the
  common logic is shared in assembly macros, this still requires some
  duplication, and has lead to some trivial divergence.

* For historical reasons, the assembly macros take some register
  arguments as numerical indices (e.g. "fpsimd_save x0, 8" uses x0 and
  x8), which is simply confusing.

* For historical reasons, the SVE save/restore code and FPSIMD
  save/restore code have distinct sequences for FPSR and FPCR. Ideally
  this logic would be shared.

* The assembly sequences can't be instrumented, and so it's harder than
  necessary to catch memory safety issues.

To handle the above, move the FPSIMD register save/restore sequences to
inline assembly, and share the FPSR+FPCR save/restore with SVE.

Neither GCC nor LLVM instrument memory arguments to inline assembly, so
explicit instrumentation is added in the same manner as other assembly
routines. This instrumentation is implicitly disabled by Kbuild for nVHE
hyp code.

I've used the SVE sequence for restoring FPCR, which uses an
unconditional write to FPCR, rather than the conditional write used by
the FPSIMD assembly sequence. I believe that in practice, this doesn't
matter to a real workload, and given it's possible for the mis-predicted
branch to cost more than the necessary micro-architectural
synchronization, I strongly suspect any performance impact is within the
noise.

Looking at the history, the FPSIMD assembly sequence was changed to use
a conditional write to FPCR since 2014 in commit:

  5959e25729a5 ("arm64: fpsimd: avoid restoring fpcr if the contents haven't change")

... as described in the commit message, this was based on an expectation
of implementation style, and was not based on benchmarking.

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
 arch/arm64/include/asm/fpsimd.h         | 68 ++++++++++++++++++++++++-
 arch/arm64/include/asm/fpsimdmacros.h   | 59 ---------------------
 arch/arm64/include/asm/kvm_hyp.h        |  2 -
 arch/arm64/kernel/entry-fpsimd.S        | 20 --------
 arch/arm64/kvm/hyp/fpsimd.S             | 10 ----
 arch/arm64/kvm/hyp/include/hyp/switch.h |  4 +-
 arch/arm64/kvm/hyp/nvhe/hyp-main.c      |  4 +-
 7 files changed, 70 insertions(+), 97 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 6fd5cdf5e5f17..19b373ad0ebf7 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -22,6 +22,8 @@
 #include <linux/stddef.h>
 #include <linux/types.h>
 
+#define __FPSIMD_PREAMBLE	".arch_extension fp\n" \
+				".arch_extension simd\n"
 #define __SVE_PREAMBLE		".arch_extension sve\n"
 #define __SME_PREAMBLE		".arch_extension sme\n"
 
@@ -86,8 +88,70 @@ static inline void fpsimd_load_common(const struct user_fpsimd_state *state)
 	write_sysreg_s(state->fpcr, SYS_FPCR);
 }
 
-extern void fpsimd_save_state(struct user_fpsimd_state *state);
-extern void fpsimd_load_state(struct user_fpsimd_state *state);
+static inline void fpsimd_save_vregs(struct user_fpsimd_state *state)
+{
+	instrument_write(state->vregs, sizeof(state->vregs));
+	asm volatile(
+	__FPSIMD_PREAMBLE
+	"	stp	q0,  q1,  [%[vregs], #16 * 0]\n"
+	"	stp	q2,  q3,  [%[vregs], #16 * 2]\n"
+	"	stp	q4,  q5,  [%[vregs], #16 * 4]\n"
+	"	stp	q6,  q7,  [%[vregs], #16 * 6]\n"
+	"	stp	q8,  q9,  [%[vregs], #16 * 8]\n"
+	"	stp	q10, q11, [%[vregs], #16 * 10]\n"
+	"	stp	q12, q13, [%[vregs], #16 * 12]\n"
+	"	stp	q14, q15, [%[vregs], #16 * 14]\n"
+	"	stp	q16, q17, [%[vregs], #16 * 16]\n"
+	"	stp	q18, q19, [%[vregs], #16 * 18]\n"
+	"	stp	q20, q21, [%[vregs], #16 * 20]\n"
+	"	stp	q22, q23, [%[vregs], #16 * 22]\n"
+	"	stp	q24, q25, [%[vregs], #16 * 24]\n"
+	"	stp	q26, q27, [%[vregs], #16 * 26]\n"
+	"	stp	q28, q29, [%[vregs], #16 * 28]\n"
+	"	stp	q30, q31, [%[vregs], #16 * 30]\n"
+	: "=Q" (state->vregs)
+	: [vregs] "r" (state->vregs)
+	);
+}
+
+static inline void fpsimd_load_vregs(const struct user_fpsimd_state *state)
+{
+	instrument_read(state->vregs, sizeof(state->vregs));
+	asm volatile(
+	__FPSIMD_PREAMBLE
+	"	ldp	q0,  q1,  [%[vregs], #16 * 0]\n"
+	"	ldp	q2,  q3,  [%[vregs], #16 * 2]\n"
+	"	ldp	q4,  q5,  [%[vregs], #16 * 4]\n"
+	"	ldp	q6,  q7,  [%[vregs], #16 * 6]\n"
+	"	ldp	q8,  q9,  [%[vregs], #16 * 8]\n"
+	"	ldp	q10, q11, [%[vregs], #16 * 10]\n"
+	"	ldp	q12, q13, [%[vregs], #16 * 12]\n"
+	"	ldp	q14, q15, [%[vregs], #16 * 14]\n"
+	"	ldp	q16, q17, [%[vregs], #16 * 16]\n"
+	"	ldp	q18, q19, [%[vregs], #16 * 18]\n"
+	"	ldp	q20, q21, [%[vregs], #16 * 20]\n"
+	"	ldp	q22, q23, [%[vregs], #16 * 22]\n"
+	"	ldp	q24, q25, [%[vregs], #16 * 24]\n"
+	"	ldp	q26, q27, [%[vregs], #16 * 26]\n"
+	"	ldp	q28, q29, [%[vregs], #16 * 28]\n"
+	"	ldp	q30, q31, [%[vregs], #16 * 30]\n"
+	:
+	: "Q" (state->vregs),
+	  [vregs] "r" (state->vregs)
+	);
+}
+
+static inline void fpsimd_save_state(struct user_fpsimd_state *state)
+{
+	fpsimd_save_vregs(state);
+	fpsimd_save_common(state);
+}
+
+static inline void fpsimd_load_state(const struct user_fpsimd_state *state)
+{
+	fpsimd_load_vregs(state);
+	fpsimd_load_common(state);
+}
 
 extern void fpsimd_thread_switch(struct task_struct *next);
 extern void fpsimd_flush_thread(void);
diff --git a/arch/arm64/include/asm/fpsimdmacros.h b/arch/arm64/include/asm/fpsimdmacros.h
index 1f32e0967dcd3..b486c6399bb4e 100644
--- a/arch/arm64/include/asm/fpsimdmacros.h
+++ b/arch/arm64/include/asm/fpsimdmacros.h
@@ -8,65 +8,6 @@
 
 #include <asm/assembler.h>
 
-.macro fpsimd_save state, tmpnr
-	stp	q0, q1, [\state, #16 * 0]
-	stp	q2, q3, [\state, #16 * 2]
-	stp	q4, q5, [\state, #16 * 4]
-	stp	q6, q7, [\state, #16 * 6]
-	stp	q8, q9, [\state, #16 * 8]
-	stp	q10, q11, [\state, #16 * 10]
-	stp	q12, q13, [\state, #16 * 12]
-	stp	q14, q15, [\state, #16 * 14]
-	stp	q16, q17, [\state, #16 * 16]
-	stp	q18, q19, [\state, #16 * 18]
-	stp	q20, q21, [\state, #16 * 20]
-	stp	q22, q23, [\state, #16 * 22]
-	stp	q24, q25, [\state, #16 * 24]
-	stp	q26, q27, [\state, #16 * 26]
-	stp	q28, q29, [\state, #16 * 28]
-	stp	q30, q31, [\state, #16 * 30]!
-	mrs	x\tmpnr, fpsr
-	str	w\tmpnr, [\state, #16 * 2]
-	mrs	x\tmpnr, fpcr
-	str	w\tmpnr, [\state, #16 * 2 + 4]
-.endm
-
-.macro fpsimd_restore_fpcr state, tmp
-	/*
-	 * Writes to fpcr may be self-synchronising, so avoid restoring
-	 * the register if it hasn't changed.
-	 */
-	mrs	\tmp, fpcr
-	cmp	\tmp, \state
-	b.eq	9999f
-	msr	fpcr, \state
-9999:
-.endm
-
-/* Clobbers \state */
-.macro fpsimd_restore state, tmpnr
-	ldp	q0, q1, [\state, #16 * 0]
-	ldp	q2, q3, [\state, #16 * 2]
-	ldp	q4, q5, [\state, #16 * 4]
-	ldp	q6, q7, [\state, #16 * 6]
-	ldp	q8, q9, [\state, #16 * 8]
-	ldp	q10, q11, [\state, #16 * 10]
-	ldp	q12, q13, [\state, #16 * 12]
-	ldp	q14, q15, [\state, #16 * 14]
-	ldp	q16, q17, [\state, #16 * 16]
-	ldp	q18, q19, [\state, #16 * 18]
-	ldp	q20, q21, [\state, #16 * 20]
-	ldp	q22, q23, [\state, #16 * 22]
-	ldp	q24, q25, [\state, #16 * 24]
-	ldp	q26, q27, [\state, #16 * 26]
-	ldp	q28, q29, [\state, #16 * 28]
-	ldp	q30, q31, [\state, #16 * 30]!
-	ldr	w\tmpnr, [\state, #16 * 2]
-	msr	fpsr, x\tmpnr
-	ldr	w\tmpnr, [\state, #16 * 2 + 4]
-	fpsimd_restore_fpcr x\tmpnr, \state
-.endm
-
 /* Sanity-check macros to help avoid encoding garbage instructions */
 
 .macro _check_general_reg nr
diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
index 0030cc1b52197..8c4602c8f4356 100644
--- a/arch/arm64/include/asm/kvm_hyp.h
+++ b/arch/arm64/include/asm/kvm_hyp.h
@@ -121,8 +121,6 @@ void __debug_save_host_buffers_nvhe(struct kvm_vcpu *vcpu);
 void __debug_restore_host_buffers_nvhe(struct kvm_vcpu *vcpu);
 #endif
 
-void __fpsimd_save_state(struct user_fpsimd_state *fp_regs);
-void __fpsimd_restore_state(struct user_fpsimd_state *fp_regs);
 void __sve_save_state(void *sve, int save_ffr);
 void __sve_restore_state(void *sve, int restore_ffr);
 
diff --git a/arch/arm64/kernel/entry-fpsimd.S b/arch/arm64/kernel/entry-fpsimd.S
index 1a581597037ca..66668bfca5ae8 100644
--- a/arch/arm64/kernel/entry-fpsimd.S
+++ b/arch/arm64/kernel/entry-fpsimd.S
@@ -11,26 +11,6 @@
 #include <asm/assembler.h>
 #include <asm/fpsimdmacros.h>
 
-/*
- * Save the FP registers.
- *
- * x0 - pointer to struct fpsimd_state
- */
-SYM_FUNC_START(fpsimd_save_state)
-	fpsimd_save x0, 8
-	ret
-SYM_FUNC_END(fpsimd_save_state)
-
-/*
- * Load the FP registers.
- *
- * x0 - pointer to struct fpsimd_state
- */
-SYM_FUNC_START(fpsimd_load_state)
-	fpsimd_restore x0, 8
-	ret
-SYM_FUNC_END(fpsimd_load_state)
-
 #ifdef CONFIG_ARM64_SVE
 
 /*
diff --git a/arch/arm64/kvm/hyp/fpsimd.S b/arch/arm64/kvm/hyp/fpsimd.S
index 3d5b5e93ee5e0..00c56e31484a5 100644
--- a/arch/arm64/kvm/hyp/fpsimd.S
+++ b/arch/arm64/kvm/hyp/fpsimd.S
@@ -10,16 +10,6 @@
 
 	.text
 
-SYM_FUNC_START(__fpsimd_save_state)
-	fpsimd_save	x0, 1
-	ret
-SYM_FUNC_END(__fpsimd_save_state)
-
-SYM_FUNC_START(__fpsimd_restore_state)
-	fpsimd_restore	x0, 1
-	ret
-SYM_FUNC_END(__fpsimd_restore_state)
-
 SYM_FUNC_START(__sve_restore_state)
 	sve_load 0, w1
 	ret
diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index eb76a863ebb84..aaa43554fd8e6 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -565,7 +565,7 @@ static void kvm_hyp_save_fpsimd_host(struct kvm_vcpu *vcpu)
 	if (system_supports_sve()) {
 		__hyp_sve_save_host();
 	} else {
-		__fpsimd_save_state(&hctxt->fp_regs);
+		fpsimd_save_state(&hctxt->fp_regs);
 	}
 
 	if (kvm_has_fpmr(kern_hyp_va(vcpu->kvm)))
@@ -625,7 +625,7 @@ static inline bool kvm_hyp_handle_fpsimd(struct kvm_vcpu *vcpu, u64 *exit_code)
 	if (sve_guest)
 		__hyp_sve_restore_guest(vcpu);
 	else
-		__fpsimd_restore_state(&vcpu->arch.ctxt.fp_regs);
+		fpsimd_load_state(&vcpu->arch.ctxt.fp_regs);
 
 	if (kvm_has_fpmr(kern_hyp_va(vcpu->kvm)))
 		write_sysreg_s(__vcpu_sys_reg(vcpu, FPMR), SYS_FPMR);
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 0be4577a67e7b..627762ed7327f 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -83,7 +83,7 @@ static void fpsimd_sve_sync(struct kvm_vcpu *vcpu)
 	if (vcpu_has_sve(vcpu))
 		__hyp_sve_save_guest(vcpu);
 	else
-		__fpsimd_save_state(&vcpu->arch.ctxt.fp_regs);
+		fpsimd_save_state(&vcpu->arch.ctxt.fp_regs);
 
 	has_fpmr = kvm_has_fpmr(kern_hyp_va(vcpu->kvm));
 	if (has_fpmr)
@@ -92,7 +92,7 @@ static void fpsimd_sve_sync(struct kvm_vcpu *vcpu)
 	if (system_supports_sve())
 		__hyp_sve_restore_host();
 	else
-		__fpsimd_restore_state(&hctxt->fp_regs);
+		fpsimd_load_state(&hctxt->fp_regs);
 
 	if (has_fpmr)
 		write_sysreg_s(ctxt_sys_reg(hctxt, FPMR), SYS_FPMR);
-- 
2.30.2

