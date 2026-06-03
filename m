Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C980D44CF2E
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 11:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780484831; cv=none; b=mpQCSyoAJ4hjtGDS06lhHYQHMCl9bxEXt5YwyBuUUeeG3lG+rhOzuKeE69E06RbZ1Bo3sim8UKN/aAcu3IPoL7Os+YTh1lLvzQOuS/kUQr2XSGDSO0E1WBi5tvSzqfkG+z9Y4mAZ9M4B33OxfeDkhe/CSl5TRX4R7J0AsUb9RoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780484831; c=relaxed/simple;
	bh=xNHJ9PQ/4efqv59awU7DQNn/TP78+CypTKS6WME2oj0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eSgOL55hDqJY1n6DrCGpwoRlt0L4ATwTnjlCRz4pRV+jrhapeah9ZwGE+8PHd4YAEhLAl0DdjOjQM87iA4ghYW9+1VlMDJ6355rSmUVuBXLb4z1dtpepruJqNNzgSZF+32KuLDt3Eagu2ewkgrwkxoqirvMR3Yxux8ECaFXiXL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ZBhMF74V; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ZBhMF74V"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E7DC32E4;
	Wed,  3 Jun 2026 04:07:04 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A57B43F86F;
	Wed,  3 Jun 2026 04:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780484829; bh=xNHJ9PQ/4efqv59awU7DQNn/TP78+CypTKS6WME2oj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZBhMF74Vzh6APdocHPBQ5ra6LBuN+X19FRoyttJQDnglBQWDlOC73XuNnYx30O3z5
	 CQCqvLdwaUhoGA7BTnNtvuwDbmFtxIWZL5ND9xuupBBR0ZGMR3Gx8oOkTxtqgDMUQe
	 rR6VBXY/083nQbTJ5hqljuy6cw9E5R5rlbptTCB0=
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
Subject: [PATCH v4 13/20] arm64: fpsimd: Split FPSR/FPCR from SVE save/restore
Date: Wed,  3 Jun 2026 12:06:23 +0100
Message-Id: <20260603110630.1027435-14-mark.rutland@arm.com>
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

Regardless of whether the vector registers are saved in FPSIMD or SVE
format, we store FPSR and FPCR in user_fpsimd_state::{fpsr,fpcr}.

For historical reasons, the functions which save/restore SVE context
take a pointer to user_fpsimd_state::fpsr, and use this to access both
user_fpsimd_state::fpsr and user_fpsimd_state::fpcr. This is
unnecessarily fragile.

Move the save/restore of FPSR and FPCR into separate helper functions
which take a pointer to user_fpsimd_state. I've used read_sysreg_s() and
write_sysreg_s() as contemporary versions of LLVM will refuse to
directly assemble accesses to FPCR or FPSR unless the "fp" arch
extension is enabled.

For the moment, fpsimd_save_state() and fpsimd_load_state() are left
as-is with their own logic to save/restore FPSR and FPCR. This will be
unified in subsequent patches.

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
 arch/arm64/include/asm/fpsimd.h         | 17 ++++++++++++++---
 arch/arm64/include/asm/fpsimdmacros.h   | 13 ++-----------
 arch/arm64/include/asm/kvm_hyp.h        |  4 ++--
 arch/arm64/kernel/entry-fpsimd.S        | 10 ++++------
 arch/arm64/kernel/fpsimd.c              |  5 +++--
 arch/arm64/kvm/hyp/fpsimd.S             |  4 ++--
 arch/arm64/kvm/hyp/include/hyp/switch.h |  4 ++--
 arch/arm64/kvm/hyp/nvhe/hyp-main.c      |  5 +++--
 8 files changed, 32 insertions(+), 30 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 36cf528e64971..6fd5cdf5e5f17 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -74,6 +74,18 @@ static inline void cpacr_restore(unsigned long cpacr)
 
 struct task_struct;
 
+static inline void fpsimd_save_common(struct user_fpsimd_state *state)
+{
+	state->fpsr = read_sysreg_s(SYS_FPSR);
+	state->fpcr = read_sysreg_s(SYS_FPCR);
+}
+
+static inline void fpsimd_load_common(const struct user_fpsimd_state *state)
+{
+	write_sysreg_s(state->fpsr, SYS_FPSR);
+	write_sysreg_s(state->fpcr, SYS_FPCR);
+}
+
 extern void fpsimd_save_state(struct user_fpsimd_state *state);
 extern void fpsimd_load_state(struct user_fpsimd_state *state);
 
@@ -157,9 +169,8 @@ static inline unsigned int sve_get_vl(void)
 	return vl;
 }
 
-extern void sve_save_state(void *state, u32 *pfpsr, int save_ffr);
-extern void sve_load_state(void const *state, u32 const *pfpsr,
-			   int restore_ffr);
+extern void sve_save_state(void *state, int save_ffr);
+extern void sve_load_state(void const *state, int restore_ffr);
 extern void sve_flush_live(bool flush_ffr, unsigned long vq_minus_1);
 extern void sme_save_state(void *state, int zt);
 extern void sme_load_state(void const *state, int zt);
diff --git a/arch/arm64/include/asm/fpsimdmacros.h b/arch/arm64/include/asm/fpsimdmacros.h
index c724fcad7ee02..1f32e0967dcd3 100644
--- a/arch/arm64/include/asm/fpsimdmacros.h
+++ b/arch/arm64/include/asm/fpsimdmacros.h
@@ -236,7 +236,7 @@
 		_sve_wrffr	0
 .endm
 
-.macro sve_save nxbase, xpfpsr, save_ffr, nxtmp
+.macro sve_save nxbase, save_ffr
  _for n, 0, 31,	_sve_str_v	\n, \nxbase, \n - 34
  _for n, 0, 15,	_sve_str_p	\n, \nxbase, \n - 16
 		cbz		\save_ffr, 921f
@@ -247,24 +247,15 @@
 922:
 		_sve_str_p	0, \nxbase
 		_sve_ldr_p	0, \nxbase, -16
-		mrs		x\nxtmp, fpsr
-		str		w\nxtmp, [\xpfpsr]
-		mrs		x\nxtmp, fpcr
-		str		w\nxtmp, [\xpfpsr, #4]
 .endm
 
-.macro sve_load nxbase, xpfpsr, restore_ffr, nxtmp
+.macro sve_load nxbase, restore_ffr
  _for n, 0, 31,	_sve_ldr_v	\n, \nxbase, \n - 34
 		cbz		\restore_ffr, 921f
 		_sve_ldr_p	0, \nxbase
 		_sve_wrffr	0
 921:
  _for n, 0, 15,	_sve_ldr_p	\n, \nxbase, \n - 16
-
-		ldr		w\nxtmp, [\xpfpsr]
-		msr		fpsr, x\nxtmp
-		ldr		w\nxtmp, [\xpfpsr, #4]
-		msr		fpcr, x\nxtmp
 .endm
 
 .macro sme_save_za nxbase, xvl, nw
diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
index 8d06b62e7188c..0030cc1b52197 100644
--- a/arch/arm64/include/asm/kvm_hyp.h
+++ b/arch/arm64/include/asm/kvm_hyp.h
@@ -123,8 +123,8 @@ void __debug_restore_host_buffers_nvhe(struct kvm_vcpu *vcpu);
 
 void __fpsimd_save_state(struct user_fpsimd_state *fp_regs);
 void __fpsimd_restore_state(struct user_fpsimd_state *fp_regs);
-void __sve_save_state(void *sve_pffr, u32 *fpsr, int save_ffr);
-void __sve_restore_state(void *sve_pffr, u32 *fpsr, int restore_ffr);
+void __sve_save_state(void *sve, int save_ffr);
+void __sve_restore_state(void *sve, int restore_ffr);
 
 u64 __guest_enter(struct kvm_vcpu *vcpu);
 
diff --git a/arch/arm64/kernel/entry-fpsimd.S b/arch/arm64/kernel/entry-fpsimd.S
index a124c6d3766cf..1a581597037ca 100644
--- a/arch/arm64/kernel/entry-fpsimd.S
+++ b/arch/arm64/kernel/entry-fpsimd.S
@@ -37,11 +37,10 @@ SYM_FUNC_END(fpsimd_load_state)
  * Save the SVE state
  *
  * x0 - pointer to buffer for state
- * x1 - pointer to storage for FPSR
- * w2 - Save FFR if non-zero
+ * w1 - Save FFR if non-zero
  */
 SYM_FUNC_START(sve_save_state)
-	sve_save 0, x1, w2, 3
+	sve_save 0, w1
 	ret
 SYM_FUNC_END(sve_save_state)
 
@@ -49,11 +48,10 @@ SYM_FUNC_END(sve_save_state)
  * Load the SVE state
  *
  * x0 - pointer to buffer for state
- * x1 - pointer to storage for FPSR
- * w2 - Restore FFR if non-zero
+ * w1 - Restore FFR if non-zero
  */
 SYM_FUNC_START(sve_load_state)
-	sve_load 0, x1, w2, 4
+	sve_load 0, w1
 	ret
 SYM_FUNC_END(sve_load_state)
 
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 2578c2372c89e..9806fea8fea7c 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -426,8 +426,8 @@ static void task_fpsimd_load(void)
 	if (restore_sve_regs) {
 		WARN_ON_ONCE(current->thread.fp_type != FP_STATE_SVE);
 		sve_load_state(sve_pffr(&current->thread),
-			       &current->thread.uw.fpsimd_state.fpsr,
 			       restore_ffr);
+		fpsimd_load_common(&current->thread.uw.fpsimd_state);
 	} else {
 		WARN_ON_ONCE(current->thread.fp_type != FP_STATE_FPSIMD);
 		fpsimd_load_state(&current->thread.uw.fpsimd_state);
@@ -509,7 +509,8 @@ static void fpsimd_save_user_state(void)
 
 		sve_save_state((char *)last->sve_state +
 					sve_ffr_offset(vl),
-			       &last->st->fpsr, save_ffr);
+			       save_ffr);
+		fpsimd_save_common(last->st);
 		*last->fp_type = FP_STATE_SVE;
 	} else {
 		fpsimd_save_state(last->st);
diff --git a/arch/arm64/kvm/hyp/fpsimd.S b/arch/arm64/kvm/hyp/fpsimd.S
index 30507c50942eb..3d5b5e93ee5e0 100644
--- a/arch/arm64/kvm/hyp/fpsimd.S
+++ b/arch/arm64/kvm/hyp/fpsimd.S
@@ -21,11 +21,11 @@ SYM_FUNC_START(__fpsimd_restore_state)
 SYM_FUNC_END(__fpsimd_restore_state)
 
 SYM_FUNC_START(__sve_restore_state)
-	sve_load 0, x1, w2, 3
+	sve_load 0, w1
 	ret
 SYM_FUNC_END(__sve_restore_state)
 
 SYM_FUNC_START(__sve_save_state)
-	sve_save 0, x1, w2, 3
+	sve_save 0, w1
 	ret
 SYM_FUNC_END(__sve_save_state)
diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index 6512dd3f75ae4..eb76a863ebb84 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -468,8 +468,8 @@ static inline void __hyp_sve_restore_guest(struct kvm_vcpu *vcpu)
 	 */
 	sve_cond_update_zcr_vq(vcpu_sve_max_vq(vcpu) - 1, SYS_ZCR_EL2);
 	__sve_restore_state(vcpu_sve_pffr(vcpu),
-			    &vcpu->arch.ctxt.fp_regs.fpsr,
 			    true);
+	fpsimd_load_common(&vcpu->arch.ctxt.fp_regs);
 
 	/*
 	 * The effective VL for a VM could differ from the max VL when running a
@@ -490,8 +490,8 @@ static inline void __hyp_sve_save_host(void)
 	ctxt_sys_reg(hctxt, ZCR_EL1) = read_sysreg_el1(SYS_ZCR);
 	write_sysreg_s(sve_vq_from_vl(kvm_host_sve_max_vl) - 1, SYS_ZCR_EL2);
 	__sve_save_state(sve_regs + sve_ffr_offset(kvm_host_sve_max_vl),
-			 &hctxt->fp_regs.fpsr,
 			 true);
+	fpsimd_save_common(&hctxt->fp_regs);
 }
 
 static inline void fpsimd_lazy_switch_to_guest(struct kvm_vcpu *vcpu)
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 04a6d2e0ea73f..0be4577a67e7b 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -35,7 +35,8 @@ static void __hyp_sve_save_guest(struct kvm_vcpu *vcpu)
 	 * on the VL, so use a consistent (i.e., the maximum) guest VL.
 	 */
 	sve_cond_update_zcr_vq(vcpu_sve_max_vq(vcpu) - 1, SYS_ZCR_EL2);
-	__sve_save_state(vcpu_sve_pffr(vcpu), &vcpu->arch.ctxt.fp_regs.fpsr, true);
+	__sve_save_state(vcpu_sve_pffr(vcpu), true);
+	fpsimd_save_common(&vcpu->arch.ctxt.fp_regs);
 	write_sysreg_s(sve_vq_from_vl(kvm_host_sve_max_vl) - 1, SYS_ZCR_EL2);
 }
 
@@ -55,8 +56,8 @@ static void __hyp_sve_restore_host(void)
 	 */
 	write_sysreg_s(sve_vq_from_vl(kvm_host_sve_max_vl) - 1, SYS_ZCR_EL2);
 	__sve_restore_state(sve_regs + sve_ffr_offset(kvm_host_sve_max_vl),
-			    &hctxt->fp_regs.fpsr,
 			    true);
+	fpsimd_load_common(&hctxt->fp_regs);
 	write_sysreg_el1(ctxt_sys_reg(hctxt, ZCR_EL1), SYS_ZCR);
 }
 
-- 
2.30.2

