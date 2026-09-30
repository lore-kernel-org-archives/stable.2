Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B70B51D522
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 21:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790803501; cv=none; b=jOc1VUph4fAM6HnEmP6meWFmffqraZL+8wwKDxFpvFJN6L1pEiv9upQRO3aKrhYgD/U/TimbW/bf3P5o33EMNZMhj4fT9Vop4vOB7m4zWXYXvoeG7dv4YN7+0iyUyVC7pvYeW2yJU6ReRdAlIXcDbZjEiRCkkF4Et7hSVxOYWWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790803501; c=relaxed/simple;
	bh=PXycBrhsvA7/06QWVXxKZD3IqmBfXtdEM/7I33PISRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KDHBYkICP6px1ZOLX+CmgkOV1TAvM+5YBXo4EkbHBsEsYHUayor5R5+K8ndg3PywFlutREZ8SY1qasNd+5r4SahCGwnfw1kMMX6Fvj/xu3jqtnJXa9ZQg1SpMpwG5rNaqOTywJF+QxexSWS7Y6lJdLwugwgCd+E5t+SWWdUo6dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/H+D5lR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/H+D5lR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F4061F000FF;
	Wed, 30 Sep 2026 21:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790803499;
	bh=y82Y/yVoc/HJvguYZNCmWhAF+c+L50OM4Jc3Md8osss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e/H+D5lRhr2nscHxBfkTo27wOpPNmgSJH0lzo2+ZW7tuTOIg8W7wzqE1rlZF17LMk
	 ixCMAIngnVla+05Yf0OgP674cefO7vgLbjZ9FNlNxlDAC+hGW/5fu96mc9HjaJHJAn
	 hYs9ME5EEzrDz18PIuFh+u34iyJK3oOBLGW4MJs8lbOQPVOmd/n6HJrFOiLgTr4EeX
	 0MoUUE38P+r01ze27fS9KMyyWspqX1sQoYHCjPjL0vrNl217bUVx0ezMi3PbNdAxSV
	 dFAh8oH6m0GNkmd93roAx1lEflgSyeUL63VId/ppWerA8ogRW8yTt81Kt87xzbD6Q/
	 GfCTzjcKG9mPg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] KVM: x86: Add static calls for nested virtualization ops
Date: Wed, 30 Sep 2026 17:24:56 -0400
Message-ID: <20260930212457.3174359-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092940-tractor-spiritual-64e5@gregkh>
References: <2026092940-tractor-spiritual-64e5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit 4b9819a50674dd40d176033f9ea2e23a70889dc6 ]

Use static calls to invoke nested virtualization ops, as many of the calls
are in relatively hot paths when L2 is active, e.g. checking for events,
and because there's no reason not use static calls these days.

Opportunistically use a RET0 static call for get_evmcs_version() instead
of manually checking for a non-NULL vendor hook.

Link: https://patch.msgid.link/20260630202828.440724-3-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>

[6.1 dependency adaptation for c1214f293d77]

Keep only the get_nested_state_pages static call needed by the target.
Declare and define that call directly, and initialize it in the existing
kvm_ops_update() instead of adding kvm_nested_ops_update(). Drop the other
call conversions and the nested-op list: this stable tree lacks the newer
nested enablement, GPA translation, and Hyper-V TLB-flush interfaces.

Fold in the prerequisites needed for the unmodified target to cherry-pick:
- Re-pend failed GET_NESTED_STATE_PAGES requests, as in 10180a277549.
- Rename the existing nested_svm_vmrun_msrpm() helper to
  nested_svm_merge_msrpm(), taking a kvm_vcpu pointer, and update both
  callers without changing the bitmap merge logic.
- Adapt the field relocation from 3d4470d71fbf (Yosry Ahmed): move
  nested_run_pending from both vendor structs into kvm_vcpu_arch and
  update every access. Preserve this branch's boolean state semantics.
  This supplies the context for the target's VMX error-handling hunk.

No functions are added. The target's error-reporting changes are left
for the target commit.

[ sashal: Reduced backport -- upstream 4b9819a50674d touches 7 file(s), this
  backport carries 8. Not backported here:
  arch/x86/include/asm/kvm-x86-nested-ops.h
  arch/x86/kvm/hyperv.c
  arch/x86/kvm/mmu.h
  arch/x86/kvm/mmu/paging_tmpl.h
  arch/x86/kvm/x86.h
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: c1214f293d77 ("KVM: x86: Fill kvm_run exit fields in common get_nested_state_pages() error paths")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/kvm_host.h | 14 +++++++++++
 arch/x86/kvm/svm/nested.c       | 21 +++++++++--------
 arch/x86/kvm/svm/svm.c          | 14 +++++------
 arch/x86/kvm/svm/svm.h          |  4 ----
 arch/x86/kvm/vmx/nested.c       | 42 ++++++++++++++++-----------------
 arch/x86/kvm/vmx/vmx.c          | 14 +++++------
 arch/x86/kvm/vmx/vmx.h          |  3 ---
 arch/x86/kvm/x86.c              |  9 ++++++-
 8 files changed, 68 insertions(+), 53 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 31395c43416dd..d828d1ced2aa4 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -937,6 +937,15 @@ struct kvm_vcpu_arch {
 	 */
 	bool pdptrs_from_userspace;
 
+	/*
+	 * Set if an emulated nested VM-Enter to L2 is pending completion.  KVM
+	 * must not synthesize a VM-Exit to L1 before entering L2, as VM-Exits
+	 * can only occur at instruction boundaries.  The only exception is
+	 * VMX's "notify" exits, which exist in large part to break the CPU out
+	 * of infinite ucode loops, but can corrupt vCPU state in the process!
+	 */
+	bool nested_run_pending;
+
 #if IS_ENABLED(CONFIG_HYPERV)
 	hpa_t hv_root_tdp;
 #endif
@@ -1693,6 +1702,11 @@ extern struct kvm_x86_ops kvm_x86_ops;
 #define KVM_X86_OP_OPTIONAL_RET0 KVM_X86_OP
 #include <asm/kvm-x86-ops.h>
 
+#define kvm_nested_call(func) static_call(kvm_x86_nested_##func)
+
+DECLARE_STATIC_CALL(kvm_x86_nested_get_nested_state_pages,
+		    *(((struct kvm_x86_nested_ops *)0)->get_nested_state_pages));
+
 int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops);
 void kvm_x86_vendor_exit(void);
 
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 6a4a0d15d4a34..1984df18802ae 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -183,8 +183,9 @@ void recalc_intercepts(struct vcpu_svm *svm)
  * is optimized in that it only merges the parts where KVM MSR permission bitmap
  * may contain zero bits.
  */
-static bool nested_svm_vmrun_msrpm(struct vcpu_svm *svm)
+static bool nested_svm_merge_msrpm(struct kvm_vcpu *vcpu)
 {
+	struct vcpu_svm *svm = to_svm(vcpu);
 	struct hv_vmcb_enlightenments *hve = &svm->nested.ctl.hv_enlightenments;
 	int i;
 
@@ -864,16 +865,16 @@ int nested_svm_vmrun(struct kvm_vcpu *vcpu)
 	if (!npt_enabled)
 		vmcb01->save.cr3 = kvm_read_cr3(vcpu);
 
-	svm->nested.nested_run_pending = 1;
+	vcpu->arch.nested_run_pending = 1;
 
 	if (enter_svm_guest_mode(vcpu, vmcb12_gpa, vmcb12, true))
 		goto out_exit_err;
 
-	if (nested_svm_vmrun_msrpm(svm))
+	if (nested_svm_merge_msrpm(vcpu))
 		goto out;
 
 out_exit_err:
-	svm->nested.nested_run_pending = 0;
+	vcpu->arch.nested_run_pending = 0;
 
 	svm->vmcb->control.exit_code    = SVM_EXIT_ERR;
 	svm->vmcb->control.exit_code_hi = -1u;
@@ -946,7 +947,7 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
 	/* Exit Guest-Mode */
 	leave_guest_mode(vcpu);
 	svm->nested.vmcb12_gpa = 0;
-	WARN_ON_ONCE(svm->nested.nested_run_pending);
+	WARN_ON_ONCE(vcpu->arch.nested_run_pending);
 
 	kvm_clear_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
 
@@ -1160,7 +1161,7 @@ void svm_leave_nested(struct kvm_vcpu *vcpu)
 	struct vcpu_svm *svm = to_svm(vcpu);
 
 	if (is_guest_mode(vcpu)) {
-		svm->nested.nested_run_pending = 0;
+		vcpu->arch.nested_run_pending = 0;
 		svm->nested.vmcb12_gpa = INVALID_GPA;
 
 		leave_guest_mode(vcpu);
@@ -1356,7 +1357,7 @@ static int svm_check_nested_events(struct kvm_vcpu *vcpu)
 	 * previously injected event, the pending exception occurred while said
 	 * event was being delivered and thus needs to be handled.
 	 */
-	bool block_nested_exceptions = svm->nested.nested_run_pending;
+	bool block_nested_exceptions = vcpu->arch.nested_run_pending;
 	/*
 	 * New events (not exceptions) are only recognized at instruction
 	 * boundaries.  If an event needs reinjection, then KVM is handling a
@@ -1523,7 +1524,7 @@ static int svm_get_nested_state(struct kvm_vcpu *vcpu,
 		kvm_state.size += KVM_STATE_NESTED_SVM_VMCB_SIZE;
 		kvm_state.flags |= KVM_STATE_NESTED_GUEST_MODE;
 
-		if (svm->nested.nested_run_pending)
+		if (vcpu->arch.nested_run_pending)
 			kvm_state.flags |= KVM_STATE_NESTED_RUN_PENDING;
 	}
 
@@ -1662,7 +1663,7 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 
 	svm_set_gif(svm, !!(kvm_state->flags & KVM_STATE_NESTED_GIF_SET));
 
-	svm->nested.nested_run_pending =
+	vcpu->arch.nested_run_pending =
 		!!(kvm_state->flags & KVM_STATE_NESTED_RUN_PENDING);
 
 	svm->nested.vmcb12_gpa = kvm_state->hdr.svm.vmcb_pa;
@@ -1721,7 +1722,7 @@ static bool svm_get_nested_state_pages(struct kvm_vcpu *vcpu)
 		if (CC(!load_pdptrs(vcpu, vcpu->arch.cr3)))
 			return false;
 
-	if (!nested_svm_vmrun_msrpm(svm)) {
+	if (!nested_svm_merge_msrpm(vcpu)) {
 		vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
 		vcpu->run->internal.suberror =
 			KVM_INTERNAL_ERROR_EMULATION;
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 88979fefaa284..369dfa11de767 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2961,7 +2961,7 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 		 *
 		 * For nested:
 		 * The handling of the MSR bitmap for L2 guests is done in
-		 * nested_svm_vmrun_msrpm.
+		 * nested_svm_merge_msrpm.
 		 * We update the L1 MSR bit as well since it will end up
 		 * touching the MSR anyway now.
 		 */
@@ -3650,7 +3650,7 @@ bool svm_nmi_blocked(struct kvm_vcpu *vcpu)
 static int svm_nmi_allowed(struct kvm_vcpu *vcpu, bool for_injection)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
-	if (svm->nested.nested_run_pending)
+	if (vcpu->arch.nested_run_pending)
 		return -EBUSY;
 
 	if (svm_nmi_blocked(vcpu))
@@ -3712,7 +3712,7 @@ static int svm_interrupt_allowed(struct kvm_vcpu *vcpu, bool for_injection)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
-	if (svm->nested.nested_run_pending)
+	if (vcpu->arch.nested_run_pending)
 		return -EBUSY;
 
 	if (svm_interrupt_blocked(vcpu))
@@ -4127,11 +4127,11 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 		nested_sync_control_from_vmcb02(svm);
 
 		/* Track VMRUNs that have made past consistency checking */
-		if (svm->nested.nested_run_pending &&
+		if (vcpu->arch.nested_run_pending &&
 		    svm->vmcb->control.exit_code != SVM_EXIT_ERR)
                         ++vcpu->stat.nested_run;
 
-		svm->nested.nested_run_pending = 0;
+		vcpu->arch.nested_run_pending = 0;
 	}
 
 	svm->vmcb->control.tlb_ctl = TLB_CONTROL_DO_NOTHING;
@@ -4510,7 +4510,7 @@ bool svm_smi_blocked(struct kvm_vcpu *vcpu)
 static int svm_smi_allowed(struct kvm_vcpu *vcpu, bool for_injection)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
-	if (svm->nested.nested_run_pending)
+	if (vcpu->arch.nested_run_pending)
 		return -EBUSY;
 
 	if (svm_smi_blocked(vcpu))
@@ -4624,7 +4624,7 @@ static int svm_leave_smm(struct kvm_vcpu *vcpu, const char *smstate)
 	if (ret)
 		goto unmap_save;
 
-	svm->nested.nested_run_pending = 1;
+	vcpu->arch.nested_run_pending = 1;
 
 unmap_save:
 	kvm_vcpu_unmap(vcpu, &map_save, true);
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index f9f0e79f2f408..7dcb2f20ced69 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -169,10 +169,6 @@ struct svm_nested_state {
 	/* These are the merged vectors */
 	u32 *msrpm;
 
-	/* A VMRUN has started but has not yet been performed, so
-	 * we cannot inject a nested vmexit yet.  */
-	bool nested_run_pending;
-
 	/* cache for control fields of the guest */
 	struct vmcb_ctrl_area_cached ctl;
 
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 7febe4f2ee06f..e853dd7daf75b 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -2133,7 +2133,7 @@ static void vmx_start_preemption_timer(struct kvm_vcpu *vcpu,
 
 static u64 nested_vmx_calc_efer(struct vcpu_vmx *vmx, struct vmcs12 *vmcs12)
 {
-	if (vmx->nested.nested_run_pending &&
+	if (vmx->vcpu.arch.nested_run_pending &&
 	    (vmcs12->vm_entry_controls & VM_ENTRY_LOAD_IA32_EFER))
 		return vmcs12->guest_ia32_efer;
 	else if (vmcs12->vm_entry_controls & VM_ENTRY_IA32E_MODE)
@@ -2379,7 +2379,7 @@ static void prepare_vmcs02_early(struct vcpu_vmx *vmx, struct loaded_vmcs *vmcs0
 	/*
 	 * Interrupt/Exception Fields
 	 */
-	if (vmx->nested.nested_run_pending) {
+	if (vmx->vcpu.arch.nested_run_pending) {
 		vmcs_write32(VM_ENTRY_INTR_INFO_FIELD,
 			     vmcs12->vm_entry_intr_info_field);
 		vmcs_write32(VM_ENTRY_EXCEPTION_ERROR_CODE,
@@ -2460,7 +2460,7 @@ static void prepare_vmcs02_rare(struct vcpu_vmx *vmx, struct vmcs12 *vmcs12)
 			vmcs_write64(GUEST_PDPTR3, vmcs12->guest_pdptr3);
 		}
 
-		if (kvm_mpx_supported() && vmx->nested.nested_run_pending &&
+		if (kvm_mpx_supported() && vmx->vcpu.arch.nested_run_pending &&
 		    (vmcs12->vm_entry_controls & VM_ENTRY_LOAD_BNDCFGS))
 			vmcs_write64(GUEST_BNDCFGS, vmcs12->guest_bndcfgs);
 	}
@@ -2540,7 +2540,7 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
 			  HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP1);
 	}
 
-	if (vmx->nested.nested_run_pending &&
+	if (vcpu->arch.nested_run_pending &&
 	    (vmcs12->vm_entry_controls & VM_ENTRY_LOAD_DEBUG_CONTROLS)) {
 		kvm_set_dr(vcpu, 7, vmcs12->guest_dr7);
 		vmx_guest_debugctl_write(vcpu, vmcs12->guest_ia32_debugctl &
@@ -2549,7 +2549,7 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
 		kvm_set_dr(vcpu, 7, vcpu->arch.dr7);
 		vmx_guest_debugctl_write(vcpu, vmx->nested.pre_vmenter_debugctl);
 	}
-	if (kvm_mpx_supported() && (!vmx->nested.nested_run_pending ||
+	if (kvm_mpx_supported() && (!vcpu->arch.nested_run_pending ||
 	    !(vmcs12->vm_entry_controls & VM_ENTRY_LOAD_BNDCFGS)))
 		vmcs_write64(GUEST_BNDCFGS, vmx->nested.pre_vmenter_bndcfgs);
 	vmx_set_rflags(vcpu, vmcs12->guest_rflags);
@@ -2562,7 +2562,7 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
 	vcpu->arch.cr0_guest_owned_bits &= ~vmcs12->cr0_guest_host_mask;
 	vmcs_writel(CR0_GUEST_HOST_MASK, ~vcpu->arch.cr0_guest_owned_bits);
 
-	if (vmx->nested.nested_run_pending &&
+	if (vcpu->arch.nested_run_pending &&
 	    (vmcs12->vm_entry_controls & VM_ENTRY_LOAD_IA32_PAT)) {
 		vmcs_write64(GUEST_IA32_PAT, vmcs12->guest_ia32_pat);
 		vcpu->arch.pat = vmcs12->guest_ia32_pat;
@@ -3068,7 +3068,7 @@ static int nested_vmx_check_guest_state(struct kvm_vcpu *vcpu,
 	 *   to bit 8 (LME) if bit 31 in the CR0 field (corresponding to
 	 *   CR0.PG) is 1.
 	 */
-	if (to_vmx(vcpu)->nested.nested_run_pending &&
+	if (vcpu->arch.nested_run_pending &&
 	    (vmcs12->vm_entry_controls & VM_ENTRY_LOAD_IA32_EFER)) {
 		if (CC(!kvm_valid_efer(vcpu, vmcs12->guest_ia32_efer)) ||
 		    CC(ia32e != !!(vmcs12->guest_ia32_efer & EFER_LMA)) ||
@@ -3413,11 +3413,11 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
 	if (!evaluate_pending_interrupts)
 		evaluate_pending_interrupts |= kvm_apic_has_pending_init_or_sipi(vcpu);
 
-	if (!vmx->nested.nested_run_pending ||
+	if (!vcpu->arch.nested_run_pending ||
 	    !(vmcs12->vm_entry_controls & VM_ENTRY_LOAD_DEBUG_CONTROLS))
 		vmx->nested.pre_vmenter_debugctl = vmx_guest_debugctl_read();
 	if (kvm_mpx_supported() &&
-	    (!vmx->nested.nested_run_pending ||
+	    (!vcpu->arch.nested_run_pending ||
 	     !(vmcs12->vm_entry_controls & VM_ENTRY_LOAD_BNDCFGS)))
 		vmx->nested.pre_vmenter_bndcfgs = vmcs_read64(GUEST_BNDCFGS);
 
@@ -3630,7 +3630,7 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch)
 	 * We're finally done with prerequisite checking, and can start with
 	 * the nested entry.
 	 */
-	vmx->nested.nested_run_pending = 1;
+	vcpu->arch.nested_run_pending = 1;
 	vmx->nested.has_preemption_timer_deadline = false;
 	status = nested_vmx_enter_non_root_mode(vcpu, true);
 	if (unlikely(status != NVMX_VMENTRY_SUCCESS))
@@ -3670,12 +3670,12 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch)
 		    !nested_cpu_has(vmcs12, CPU_BASED_NMI_WINDOW_EXITING) &&
 		    !(nested_cpu_has(vmcs12, CPU_BASED_INTR_WINDOW_EXITING) &&
 		      (vmcs12->guest_rflags & X86_EFLAGS_IF))) {
-			vmx->nested.nested_run_pending = 0;
+			vcpu->arch.nested_run_pending = 0;
 			return kvm_emulate_halt_noskip(vcpu);
 		}
 		break;
 	case GUEST_ACTIVITY_WAIT_SIPI:
-		vmx->nested.nested_run_pending = 0;
+		vcpu->arch.nested_run_pending = 0;
 		vcpu->arch.mp_state = KVM_MP_STATE_INIT_RECEIVED;
 		break;
 	default:
@@ -3685,7 +3685,7 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch)
 	return 1;
 
 vmentry_failed:
-	vmx->nested.nested_run_pending = 0;
+	vcpu->arch.nested_run_pending = 0;
 	if (status == NVMX_VMENTRY_KVM_INTERNAL_ERROR)
 		return 0;
 	if (status == NVMX_VMENTRY_VMEXIT)
@@ -4103,7 +4103,7 @@ static int vmx_check_nested_events(struct kvm_vcpu *vcpu)
 	 * previously injected event, the pending exception occurred while said
 	 * event was being delivered and thus needs to be handled.
 	 */
-	bool block_nested_exceptions = vmx->nested.nested_run_pending;
+	bool block_nested_exceptions = vcpu->arch.nested_run_pending;
 	/*
 	 * New events (not exceptions) are only recognized at instruction
 	 * boundaries.  If an event needs reinjection, then KVM is handling a
@@ -4400,7 +4400,7 @@ static void sync_vmcs02_to_vmcs12(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12)
 
 	if (nested_cpu_has_preemption_timer(vmcs12) &&
 	    vmcs12->vm_exit_controls & VM_EXIT_SAVE_VMX_PREEMPTION_TIMER &&
-	    !vmx->nested.nested_run_pending)
+	    !vcpu->arch.nested_run_pending)
 		vmcs12->vmx_preemption_timer_value =
 			vmx_get_preemption_timer_value(vcpu);
 
@@ -4782,7 +4782,7 @@ void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 vm_exit_reason,
 	vmx->nested.mtf_pending = false;
 
 	/* trying to cancel vmlaunch/vmresume is a bug */
-	WARN_ON_ONCE(vmx->nested.nested_run_pending);
+	WARN_ON_ONCE(vcpu->arch.nested_run_pending);
 
 	if (kvm_check_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu)) {
 		/*
@@ -6415,7 +6415,7 @@ bool nested_vmx_reflect_vmexit(struct kvm_vcpu *vcpu)
 	unsigned long exit_qual;
 	u32 exit_intr_info;
 
-	WARN_ON_ONCE(vmx->nested.nested_run_pending);
+	WARN_ON_ONCE(vcpu->arch.nested_run_pending);
 
 	/*
 	 * Late nested VM-Fail shares the same flow as nested VM-Exit since KVM
@@ -6511,7 +6511,7 @@ static int vmx_get_nested_state(struct kvm_vcpu *vcpu,
 		if (is_guest_mode(vcpu)) {
 			kvm_state.flags |= KVM_STATE_NESTED_GUEST_MODE;
 
-			if (vmx->nested.nested_run_pending)
+			if (vcpu->arch.nested_run_pending)
 				kvm_state.flags |= KVM_STATE_NESTED_RUN_PENDING;
 
 			if (vmx->nested.mtf_pending)
@@ -6586,7 +6586,7 @@ static int vmx_get_nested_state(struct kvm_vcpu *vcpu,
 void vmx_leave_nested(struct kvm_vcpu *vcpu)
 {
 	if (is_guest_mode(vcpu)) {
-		to_vmx(vcpu)->nested.nested_run_pending = 0;
+		vcpu->arch.nested_run_pending = 0;
 		nested_vmx_vmexit(vcpu, -1, 0, 0);
 	}
 	free_nested(vcpu);
@@ -6720,7 +6720,7 @@ static int vmx_set_nested_state(struct kvm_vcpu *vcpu,
 	if (!(kvm_state->flags & KVM_STATE_NESTED_GUEST_MODE))
 		return 0;
 
-	vmx->nested.nested_run_pending =
+	vcpu->arch.nested_run_pending =
 		!!(kvm_state->flags & KVM_STATE_NESTED_RUN_PENDING);
 
 	vmx->nested.mtf_pending =
@@ -6772,7 +6772,7 @@ static int vmx_set_nested_state(struct kvm_vcpu *vcpu,
 	return 0;
 
 error_guest_mode:
-	vmx->nested.nested_run_pending = 0;
+	vcpu->arch.nested_run_pending = 0;
 	return ret;
 }
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index cc10bde20d451..c2b7c43c457f5 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4979,7 +4979,7 @@ bool vmx_nmi_blocked(struct kvm_vcpu *vcpu)
 
 static int vmx_nmi_allowed(struct kvm_vcpu *vcpu, bool for_injection)
 {
-	if (to_vmx(vcpu)->nested.nested_run_pending)
+	if (vcpu->arch.nested_run_pending)
 		return -EBUSY;
 
 	/* An NMI must not be injected into L2 if it's supposed to VM-Exit.  */
@@ -5006,7 +5006,7 @@ bool vmx_interrupt_blocked(struct kvm_vcpu *vcpu)
 
 static int vmx_interrupt_allowed(struct kvm_vcpu *vcpu, bool for_injection)
 {
-	if (to_vmx(vcpu)->nested.nested_run_pending)
+	if (vcpu->arch.nested_run_pending)
 		return -EBUSY;
 
        /*
@@ -6375,7 +6375,7 @@ static int __vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
 	 * invalid guest state should never happen as that means KVM knowingly
 	 * allowed a nested VM-Enter with an invalid vmcs12.  More below.
 	 */
-	if (KVM_BUG_ON(vmx->nested.nested_run_pending, vcpu->kvm))
+	if (KVM_BUG_ON(vcpu->arch.nested_run_pending, vcpu->kvm))
 		return -EIO;
 
 	if (is_guest_mode(vcpu)) {
@@ -7327,11 +7327,11 @@ static fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 		 * Track VMLAUNCH/VMRESUME that have made past guest state
 		 * checking.
 		 */
-		if (vmx->nested.nested_run_pending &&
+		if (vcpu->arch.nested_run_pending &&
 		    !vmx->exit_reason.failed_vmentry)
 			++vcpu->stat.nested_run;
 
-		vmx->nested.nested_run_pending = 0;
+		vcpu->arch.nested_run_pending = 0;
 	}
 
 	vmx->idt_vectoring_info = 0;
@@ -8067,7 +8067,7 @@ static void vmx_setup_mce(struct kvm_vcpu *vcpu)
 static int vmx_smi_allowed(struct kvm_vcpu *vcpu, bool for_injection)
 {
 	/* we need a nested vmexit to enter SMM, postpone if run is pending */
-	if (to_vmx(vcpu)->nested.nested_run_pending)
+	if (vcpu->arch.nested_run_pending)
 		return -EBUSY;
 	return !is_smm(vcpu);
 }
@@ -8108,7 +8108,7 @@ static int vmx_leave_smm(struct kvm_vcpu *vcpu, const char *smstate)
 		if (ret)
 			return ret;
 
-		vmx->nested.nested_run_pending = 1;
+		vcpu->arch.nested_run_pending = 1;
 		vmx->nested.smm.guest_mode = false;
 	}
 	return 0;
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 59c304dd51e65..0fe8da2b398ca 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -198,9 +198,6 @@ struct nested_vmx {
 	 */
 	bool enlightened_vmcs_enabled;
 
-	/* L2 must run next, and mustn't decide to exit to L1. */
-	bool nested_run_pending;
-
 	/* Pending MTF VM-exit into L1.  */
 	bool mtf_pending;
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ffbf532baf7cd..75c3347db920c 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -140,6 +140,9 @@ struct kvm_x86_ops kvm_x86_ops __read_mostly;
 EXPORT_STATIC_CALL_GPL(kvm_x86_get_cs_db_l_bits);
 EXPORT_STATIC_CALL_GPL(kvm_x86_cache_reg);
 
+DEFINE_STATIC_CALL_NULL(kvm_x86_nested_get_nested_state_pages,
+		       *(((struct kvm_x86_nested_ops *)0)->get_nested_state_pages));
+
 static bool __read_mostly ignore_msrs = 0;
 module_param(ignore_msrs, bool, S_IRUGO | S_IWUSR);
 
@@ -10655,7 +10658,8 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 			goto out;
 		}
 		if (kvm_check_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu)) {
-			if (unlikely(!kvm_x86_ops.nested_ops->get_nested_state_pages(vcpu))) {
+			if (unlikely(!kvm_nested_call(get_nested_state_pages)(vcpu))) {
+				kvm_make_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
 				r = 0;
 				goto out;
 			}
@@ -12429,6 +12433,9 @@ static inline void kvm_ops_update(struct kvm_x86_init_ops *ops)
 #include <asm/kvm-x86-ops.h>
 #undef __KVM_X86_OP
 
+	static_call_update(kvm_x86_nested_get_nested_state_pages,
+			   kvm_x86_ops.nested_ops->get_nested_state_pages);
+
 	kvm_pmu_ops_update(ops->pmu_ops);
 }
 
-- 
2.53.0

