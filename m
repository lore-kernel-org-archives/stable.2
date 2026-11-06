Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793989923;
	b=lASB9a5HgABftoVWI0sAke+QqladooA4mKTrFbdw7hmZmZPZAm1LyXgAaCt/LySBtzpY
	 CO2MWQJRq0M6/iTGD3RHtkapCnKoKBl0fcNqy4eYiag6woRpu3zE+QMdD2cn8we8Ece0E
	 4wP0ZJxD+CZXfCTJrGKTKFzYGsaAfYbldvvCDr5+WBzRqvqXgrkVwnABHk5CA780fIN+G
	 eH1UqBOeTQp7s0VHjxk7VVgK0LhFpYBTaFR2/YKgmXsliSGG4cTCEslfs2MQHxPJDwnYn
	 Xn52EhkvUqdAjWkSBk34DfgR2ZxNBsbyEtzZe+0wUi8rL8xCXC0l8BtWlxgX+eBWXSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793989923;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=uBrjyKSzbHrbtx5cf0dEuUjCPybe2lMOg8DMZ1oB1tE=;
	b=5oPNnrW/PTo59m6xpVIREMbxkCYtEx5lsGyr4Kjmzt5JJOTKoO4SNRWfJyUAyjvjUUog
	 DvTGRBAvp5gsmD5leLT9/6mFme9oQ/2ezQXYxGcDQEPpe9mbGX+3MLuV87gFMafFCbbHa
	 C0zzFRre3Ftr7CvV9stfRgcovdAtdFrX0wFRmy3jQ8625HdKyhrCPXZrW4U7hCCAmDemi
	 dXRdsjmHes2KCeHFYdFc2jj//9HtHCmKmmFuIuQtsVlezzDNwNXaFop7rfdwyxoz3xWEh
	 QhX9S+QzGUBQn2M91tFIW8EPSpDlXNBglIXszxEX0Rk5Z7IL6A+0PAK7s+tLM85vrRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MwDhGopL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDCC606A336;
	Fri,  6 Nov 2026 18:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MwDhGopL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 960801F008A4;
	Fri,  6 Nov 2026 18:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793989922;
	bh=uBrjyKSzbHrbtx5cf0dEuUjCPybe2lMOg8DMZ1oB1tE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MwDhGopL84aYi58k4eax08ilU5Hjp/JbbFV0Xhp0FZjdNTPWKhY2M7b0anBTZAdOj
	 LG3MGJ3Cjea6TDgBNBnibAWo+Xw0bgNpLXJU86hTXH72+qTydK1snLm5iIxX8FObZq
	 UxMsEshQMLmOYnSduGXoHeFUFCR61M5Mo/cN8IQgJWkx8JGu2RQg/qySFtXUYxrFwG
	 cxmPo6kOMVXpb+nQKtlQkknrQPf2ZkCexw8OtT5usQNs2kWks6jrrlBxwfLftBiFdM
	 olUGq28DCzlgjvPkwyBHZw1C979PM48Vmmck+Q+ThdNEXbDktkLwMMYDS00it4hXCF
	 rfcd7npkaYcPw==
From: Oliver Upton <oupton@kernel.org>
To: kvmarm@lists.linux.dev
Cc: Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Wei-Lin Chang <weilin.chang@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Oliver Upton <oupton@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 7/8] KVM: arm64: nv: Enforce sysreg visibility before evaulating guest traps
Date: Fri,  6 Nov 2026 10:31:53 -0800
Message-ID: <20261106183154.3590825-8-oupton@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261106183154.3590825-1-oupton@kernel.org>
References: <20261106183154.3590825-1-oupton@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Not all sysregs / system instructions can be described by FGUs. Of
these, there are some which may be not implemented for the VM (e.g. MTE
cache maintenance instructions) yet intersect with valid trap bits for
the VM (HCR_EL2.TPCP).

This is annoying to deal with since most of our UNDEF infrastructure is
built around traps being RESx for unimplemented features. Test the
visibility of the sys_reg_desc to avoid injecting traps for non-existent
system registers into the guest hypervisor.

Cc: stable@vger.kernel.org
Fixes: a7484c80e5ca ("KVM: arm64: Allow userspace to request KVM_ARM_VCPU_EL2*")
Signed-off-by: Oliver Upton <oupton@kernel.org>
---
 arch/arm64/kvm/emulate-nested.c | 24 +++++++++++++++++++++---
 arch/arm64/kvm/sys_regs.c       | 18 ++++++++++--------
 arch/arm64/kvm/sys_regs.h       |  4 +++-
 3 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/kvm/emulate-nested.c b/arch/arm64/kvm/emulate-nested.c
index d04ac5203454..46dc658b041b 100644
--- a/arch/arm64/kvm/emulate-nested.c
+++ b/arch/arm64/kvm/emulate-nested.c
@@ -2546,12 +2546,13 @@ static bool check_fgt_bit(struct kvm_vcpu *vcpu, enum vcpu_sysreg sr,
 	return !(kvm_get_sysreg_res0(kvm, sr) & BIT(tc.bit));
 }
 
-bool triage_sysreg_trap(struct kvm_vcpu *vcpu, int *sr_index)
+bool triage_sysreg_trap(struct kvm_vcpu *vcpu, const struct sys_reg_desc **r)
 {
 	enum vcpu_sysreg fgtreg;
 	union trap_config tc;
 	enum trap_behaviour b;
 	bool is_read;
+	int sr_index;
 	u32 sysreg;
 	u64 esr;
 
@@ -2559,6 +2560,7 @@ bool triage_sysreg_trap(struct kvm_vcpu *vcpu, int *sr_index)
 	sysreg = esr_sys64_to_sysreg(esr);
 	is_read = (esr & ESR_ELx_SYS64_ISS_DIR_MASK) == ESR_ELx_SYS64_ISS_DIR_READ;
 
+	*r = NULL;
 	tc = get_trap_config(sysreg);
 
 	/*
@@ -2569,6 +2571,11 @@ bool triage_sysreg_trap(struct kvm_vcpu *vcpu, int *sr_index)
 	if (!tc.val)
 		goto local;
 
+	if (tc.sri) {
+		sr_index = tc.sri - 1;
+		*r = kvm_sys_reg_idx_to_desc(esr_sys64_to_sysreg(esr), sr_index);
+	}
+
 	/*
 	 * If a sysreg can be trapped using a FGT, first check whether we
 	 * trap for the purpose of forbidding the feature. In that case,
@@ -2595,6 +2602,18 @@ bool triage_sysreg_trap(struct kvm_vcpu *vcpu, int *sr_index)
 	if (is_hyp_ctxt(vcpu) && !vcpu_is_host_el0(vcpu))
 		goto local;
 
+	/*
+	 * Certain sysregs and system instructions could be UNDEF for the VM
+	 * but lack a corresponding FGU description and intersect with a valid
+	 * trap bit for the VM. Test the visibility the sysreg (if we have a
+	 * sys_reg_desc) before determining the effects of the guest
+	 * hypervisor's traps.
+	 */
+	if (*r && sysreg_guest_hidden(vcpu, *r)) {
+		kvm_inject_undefined(vcpu);
+		return true;
+	}
+
 	switch ((enum fgt_group_id)tc.fgt) {
 	case __NO_FGT_GROUP__:
 		break;
@@ -2666,7 +2685,7 @@ bool triage_sysreg_trap(struct kvm_vcpu *vcpu, int *sr_index)
 		goto inject;
 
 local:
-	if (!tc.sri) {
+	if (!(*r)) {
 		struct sys_reg_params params;
 
 		params = esr_sys64_to_params(esr);
@@ -2697,7 +2716,6 @@ bool triage_sysreg_trap(struct kvm_vcpu *vcpu, int *sr_index)
 		return true;
 	}
 
-	*sr_index = tc.sri - 1;
 	return false;
 
 inject:
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 7f7a197a9ad6..7c8277de0494 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -5407,6 +5407,15 @@ void kvm_reset_sys_regs(struct kvm_vcpu *vcpu)
 		kvm_make_request(KVM_REQ_RELOAD_PMU, vcpu);
 }
 
+const struct sys_reg_desc *kvm_sys_reg_idx_to_desc(u32 encoding, int sr_idx)
+{
+	/* System registers have Op0=={2,3}, as per DDI487 J.a C5.1.2 */
+	if (sys_reg_Op0(encoding) == 2 || sys_reg_Op0(encoding) == 3)
+		return &sys_reg_descs[sr_idx];
+	else
+		return &sys_insn_descs[sr_idx];
+}
+
 /**
  * kvm_handle_sys_reg -- handles a system instruction or mrs/msr instruction
  *			 trap on a guest execution
@@ -5418,22 +5427,15 @@ int kvm_handle_sys_reg(struct kvm_vcpu *vcpu)
 	struct sys_reg_params params;
 	unsigned long esr = kvm_vcpu_get_esr(vcpu);
 	int Rt = kvm_vcpu_sys_get_rt(vcpu);
-	int sr_idx;
 
 	trace_kvm_handle_sys_reg(esr);
 
-	if (triage_sysreg_trap(vcpu, &sr_idx))
+	if (triage_sysreg_trap(vcpu, &desc))
 		return 1;
 
 	params = esr_sys64_to_params(esr);
 	params.regval = vcpu_get_reg(vcpu, Rt);
 
-	/* System registers have Op0=={2,3}, as per DDI487 J.a C5.1.2 */
-	if (params.Op0 == 2 || params.Op0 == 3)
-		desc = &sys_reg_descs[sr_idx];
-	else
-		desc = &sys_insn_descs[sr_idx];
-
 	perform_access(vcpu, &params, desc);
 
 	/* Read from system register? */
diff --git a/arch/arm64/kvm/sys_regs.h b/arch/arm64/kvm/sys_regs.h
index 50214271b24a..d8ae21578665 100644
--- a/arch/arm64/kvm/sys_regs.h
+++ b/arch/arm64/kvm/sys_regs.h
@@ -263,10 +263,12 @@ int kvm_sys_reg_get_user(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg,
 int kvm_sys_reg_set_user(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg,
 			 const struct sys_reg_desc table[], unsigned int num);
 
-bool triage_sysreg_trap(struct kvm_vcpu *vcpu, int *sr_index);
+bool triage_sysreg_trap(struct kvm_vcpu *vcpu, const struct sys_reg_desc **r);
 
 int kvm_vcpu_finalize_sys_regs(struct kvm_vcpu *vcpu);
 
+const struct sys_reg_desc *kvm_sys_reg_idx_to_desc(u32 encoding, int sr_idx);
+
 #define AA32(_x)	.aarch32_map = AA32_##_x
 #define Op0(_x) 	.Op0 = _x
 #define Op1(_x) 	.Op1 = _x
-- 
2.47.3

