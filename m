Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793820088;
	b=r4HBF4xLKpk+V8Kudx7eL9hh465rumPygtci0knxave9jxOZQhrP6lUj9ae2qFhBAB+L
	 Hcwrslt3ElAAfFGtg3FcQijFCNSqxsgwJIU4tLIRkg/oxhYiZZxDytnAZVhCpNKUyk/YD
	 htoU6AAg9Htim7oD+ViXyiGKL2fMETdHDMcoUQZyti6zDwPWOMJqalasWfml3qbxsEfeW
	 btrWtvbMW+LvI/E2Q2aNc8Q4/P5a6/Tmn9nmA4NS2SYD++5w0hE6nZGTaTYiZv0UV+J8n
	 AikSco/esMgYEhW5jG4M9aLpc54+uma1yzr6vT4JKGxytbpl/Pguf7iEd9unbiMfDwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793820088;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=uBrjyKSzbHrbtx5cf0dEuUjCPybe2lMOg8DMZ1oB1tE=;
	b=swRLAipeKOtiVS3p0JMKyU8C14RmC5x2HiRrA+QwTr8VhRixXbgJgGX+y4HEtAPTN6XU
	 LeSb1xjgMMgs9lQhtnaExaumfzc1kq4utLi7j0ysLnlIgWc03Hvzc5Hm8UuhScjcuWHYA
	 T3b40J34adJpSCKi0VzQJ+Myz6vnd1LHBu5UYOJ9mLo0yzfxJtniFKDQNcKFv7o8KkBFB
	 QCsnlE99u/jxR2WGaB2CTvu3Gv3G1cl27tKplwJtxbnRZgU4YyyqeIHyK0JmELEbmo/2P
	 Dt9u6Nr7tuCbq0pquVYX7odKZ7V3XOherKGYJO/mSN/aKGzcFqnUCy0gi+hnS6JPolw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BhKb7mNe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5840D606A87B;
	Wed,  4 Nov 2026 19:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BhKb7mNe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23A181F00A15;
	Wed,  4 Nov 2026 19:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793820088;
	bh=uBrjyKSzbHrbtx5cf0dEuUjCPybe2lMOg8DMZ1oB1tE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BhKb7mNemEs1CZupJBi7fsLzyV/vmJ+xFTelKfuaugtPQ1en4LXM2nrxtfEaL1Qea
	 Ijk/VnTIKENiqsHBmJmspxYS7q1F92EOmV+8zQeiAg2F5XnLfv3rYSDSpSBvQUwOpt
	 K3cJkZw0f6n9BVIFoZ8Tzafw2T7wpgqM8bJPFbWIJMZVNFhU8A8eekOGaQxOwlNRB5
	 GPP7czddJsxtRgjRGnoSbDqmPtlLEsypeETOtHF4tkUN5WjqlS/u/JvEl3WZPIwAT4
	 5GV4bkl5oFVJSnPVVM5IXchPsEoXQHgFm9aKDRAOTnpasTWxhjAublDGNgTjz6DieR
	 FlxdxqR1l0pMQ==
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
Subject: [PATCH 7/8] KVM: arm64: nv: Enforce sysreg visibility before evaulating guest traps
Date: Wed,  4 Nov 2026 11:21:23 -0800
Message-ID: <20261104192124.3932743-8-oupton@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261104192124.3932743-1-oupton@kernel.org>
References: <20261104192124.3932743-1-oupton@kernel.org>
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

