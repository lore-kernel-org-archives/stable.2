Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E843E3D91
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 08:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780562426; cv=none; b=ClKvh9AIBYlVViDzJRdW2SXbc6CIoov6U9cxCmAbs+3XKIc9s7TdJ1i8dRhG7ReROFBMDw5Ei0ysexjj5HWv1ynE3u+V4FIAr1bavmNTbevkWI4hxRV/hay6LD8S3TJmroqR+6UpISj4nslWdNGMjdUDu+zWN9P29cF0mWxATtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780562426; c=relaxed/simple;
	bh=J3th54ObtR036VE3l+/0K6AXCcZF67l+ewUUS6kjgr4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=iVIHE0Fdvct37zsQ3GTfgsVCTkMJqaNXSzV+k9fEEtetVNjwbc/gUu9ccwWyluPxWuUYD2+NxSvWcjX0LiRtyFFNI8lbbs07gfu5e3AsnaCfjqM6lhRFbBwC2HzugwV6VEBi710h6KHrwTwQXzuJbgjG65NmdMYZ3trPrzf3gG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ydcKpBKG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ydcKpBKG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3837A1F0089D;
	Thu,  4 Jun 2026 08:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780562418;
	bh=TMrseDLjEt4GbDl22g8RuiAb/DOdI6gf7S0YG/mWxpw=;
	h=Subject:To:Cc:From:Date;
	b=ydcKpBKGO+A8XUbZ7ZN0DCgoxK/KhLKw2SGjA1mtCvlwL77JqscQl7Vyew8pTzpUs
	 eZQfM7QcecPbHdweH0emT4ymFOVKPQOcyuWCa1PrrMdKa/iXsIVjYHwggFeEmccehK
	 A0ErEzL4ibY/hQ/X5XAJVfMZfKMBb9aD+D6hpoqc=
Subject: FAILED: patch "[PATCH] KVM: arm64: Correctly cap ZCR_EL2 provided by a guest" failed to apply to 6.12-stable tree
To: broonie@kernel.org,maz@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 04 Jun 2026 10:39:22 +0200
Message-ID: <2026060422-octane-choice-dba0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 83726330748981372bde86ed5411d7b306612991
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026060422-octane-choice-dba0@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 83726330748981372bde86ed5411d7b306612991 Mon Sep 17 00:00:00 2001
From: Mark Brown <broonie@kernel.org>
Date: Fri, 29 May 2026 00:01:44 +0100
Subject: [PATCH] KVM: arm64: Correctly cap ZCR_EL2 provided by a guest
 hypervisor

ZCR_EL2 can be updated by a VHE guest hypervisor either using ZCR_EL2
(which traps) or ZCR_EL1 (which does not trap). KVM handles both in
different way:

- on ZCR_EL2 trap, ZCR_EL2.LEN is immediately capped at the VM's own
  VL limit. This has the potential to break existing SW that relies
  on the full LEN field to be stateful.

- on ZCR_EL1 access, we do absolutely nothing.

On restoring the SVE context for an L2 guest, we directly restore the
guest hypervisor's view of ZCR_EL2 into the physical ZCR_EL2. If the
guest's view of the register was updated using the ZCR_EL2 accessor,
the value has already been sanitised (with the caveat mentioned above).

But if the guest used ZCR_EL1, the raw value is written into the HW,
and the L2 guest can now access VLs that it shouldn't.

Fix all the above by moving the VL capping to the restore points,
ensuring that:

- the HW is always programmed with a capped value, irrespective of
  the accessor being used,

- the ZCR_EL2.LEN field is always completely stateful, irrespective
  of the accessor being used.

Additionally, move ZCR_EL2 to be a sanitised register, ensuring that
only the LEN field is actually stateful. This requires some creative
construction of the RES0 mask, as the sysreg generation script does
not yet generate RAZ/WI fields.

Fixes: b3d29a823099 ("KVM: arm64: nv: Handle ZCR_EL2 traps")
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260529-kvm-arm64-fix-zcr-len-nv-v2-1-86cad51992bd@kernel.org
[maz: rewrote commit message, tidy up access_zcr_el2()]
Signed-off-by: Marc Zyngier <maz@kernel.org>

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 65eead8362e0..a49042bfa801 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -511,7 +511,6 @@ enum vcpu_sysreg {
 	ACTLR_EL2,	/* Auxiliary Control Register (EL2) */
 	CPTR_EL2,	/* Architectural Feature Trap Register (EL2) */
 	HACR_EL2,	/* Hypervisor Auxiliary Control Register */
-	ZCR_EL2,	/* SVE Control Register (EL2) */
 	TTBR0_EL2,	/* Translation Table Base Register 0 (EL2) */
 	TTBR1_EL2,	/* Translation Table Base Register 1 (EL2) */
 	TCR_EL2,	/* Translation Control Register (EL2) */
@@ -543,6 +542,7 @@ enum vcpu_sysreg {
 	SCTLR2_EL2,	/* System Control Register 2 (EL2) */
 	MDCR_EL2,	/* Monitor Debug Configuration Register (EL2) */
 	CNTHCTL_EL2,	/* Counter-timer Hypervisor Control register */
+	ZCR_EL2,	/* SVE Control Register (EL2) */
 
 	/* Any VNCR-capable reg goes after this point */
 	MARKER(__VNCR_START__),
diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index bf0eb5e43427..320cd45d49c5 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -462,11 +462,13 @@ static inline bool kvm_hyp_handle_mops(struct kvm_vcpu *vcpu, u64 *exit_code)
 
 static inline void __hyp_sve_restore_guest(struct kvm_vcpu *vcpu)
 {
+	u64 zcr_el2 = vcpu_sve_max_vq(vcpu) - 1;
+
 	/*
 	 * The vCPU's saved SVE state layout always matches the max VL of the
 	 * vCPU. Start off with the max VL so we can load the SVE state.
 	 */
-	sve_cond_update_zcr_vq(vcpu_sve_max_vq(vcpu) - 1, SYS_ZCR_EL2);
+	sve_cond_update_zcr_vq(zcr_el2, SYS_ZCR_EL2);
 	__sve_restore_state(vcpu_sve_pffr(vcpu),
 			    &vcpu->arch.ctxt.fp_regs.fpsr,
 			    true);
@@ -476,8 +478,10 @@ static inline void __hyp_sve_restore_guest(struct kvm_vcpu *vcpu)
 	 * nested guest, as the guest hypervisor could select a smaller VL. Slap
 	 * that into hardware before wrapping up.
 	 */
-	if (is_nested_ctxt(vcpu))
-		sve_cond_update_zcr_vq(__vcpu_sys_reg(vcpu, ZCR_EL2), SYS_ZCR_EL2);
+	if (is_nested_ctxt(vcpu)) {
+		zcr_el2 = min(zcr_el2, __vcpu_sys_reg(vcpu, ZCR_EL2));
+		sve_cond_update_zcr_vq(zcr_el2, SYS_ZCR_EL2);
+	}
 
 	write_sysreg_el1(__vcpu_sys_reg(vcpu, vcpu_sve_zcr_elx(vcpu)), SYS_ZCR);
 }
@@ -501,11 +505,11 @@ static inline void fpsimd_lazy_switch_to_guest(struct kvm_vcpu *vcpu)
 		return;
 
 	if (vcpu_has_sve(vcpu)) {
+		zcr_el2 = vcpu_sve_max_vq(vcpu) - 1;
+
 		/* A guest hypervisor may restrict the effective max VL. */
 		if (is_nested_ctxt(vcpu))
-			zcr_el2 = __vcpu_sys_reg(vcpu, ZCR_EL2);
-		else
-			zcr_el2 = vcpu_sve_max_vq(vcpu) - 1;
+			zcr_el2 = min(zcr_el2, __vcpu_sys_reg(vcpu, ZCR_EL2));
 
 		write_sysreg_el2(zcr_el2, SYS_ZCR);
 
diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index 883b6c1008fb..38f672e94087 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -1834,6 +1834,11 @@ int kvm_init_nv_sysregs(struct kvm_vcpu *vcpu)
 	resx.res1 = VNCR_EL2_RES1;
 	set_sysreg_masks(kvm, VNCR_EL2, resx);
 
+	/* ZCR_EL2 - bits 8:4 are RAZ/WI so treat them as RES0 */
+	resx.res0 = ZCR_ELx_RES0 | GENMASK_ULL(8, 4);
+	resx.res1 = ZCR_ELx_RES1;
+	set_sysreg_masks(kvm, ZCR_EL2, resx);
+
 out:
 	for (enum vcpu_sysreg sr = __SANITISED_REG_START__; sr < NR_SYS_REGS; sr++)
 		__vcpu_rmw_sys_reg(vcpu, sr, |=, 0);
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 148fc3400ea8..fa5c93c7a135 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -2862,21 +2862,16 @@ static bool access_zcr_el2(struct kvm_vcpu *vcpu,
 			   struct sys_reg_params *p,
 			   const struct sys_reg_desc *r)
 {
-	unsigned int vq;
-
 	if (guest_hyp_sve_traps_enabled(vcpu)) {
 		kvm_inject_nested_sve_trap(vcpu);
 		return false;
 	}
 
-	if (!p->is_write) {
+	if (!p->is_write)
 		p->regval = __vcpu_sys_reg(vcpu, ZCR_EL2);
-		return true;
-	}
+	else
+		__vcpu_assign_sys_reg(vcpu, ZCR_EL2, p->regval);
 
-	vq = SYS_FIELD_GET(ZCR_ELx, LEN, p->regval) + 1;
-	vq = min(vq, vcpu_sve_max_vq(vcpu));
-	__vcpu_assign_sys_reg(vcpu, ZCR_EL2, vq - 1);
 	return true;
 }
 

