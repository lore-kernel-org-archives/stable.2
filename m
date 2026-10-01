Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E2A2E7F39
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 00:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790815596; cv=none; b=DUAz+0e/DuzOujWKDSqNL3AQ65yoLZbMyctLg5GuCRVIDd/MF9DOJoVbuPMHBVxwiqN0XjZAy2fR8fUcZLPm/fgJYMhv3xQ2uZWZlpE/Hmw+ENjgknsnI3ZulTnh0TMvbQfmUo/1BNhPIUxdxd0rmNCq0QCCoB/IpcdozRPdL2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790815596; c=relaxed/simple;
	bh=uy57e3hkRc4dMrAXdpE1jxr3CgzNmuL+gjRqjzXNxSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=czmskdeZZGp3jJ6U4H0XaRrLXyGrpLp6sTmZUzls9Za6sUOQT1Fd3hD70En4faFKV130vN/csv5nYXc0W518cx9CaWm4pHFKELBuK5IcAb+mrIzAbKjcoXlrhmR1rK96UbzTLM2wXniwvMh60ZtOPTzEh2Bsyw5X+PLsJ0usi+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZnHeSa2N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZnHeSa2N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03A5A1F00898;
	Thu,  1 Oct 2026 00:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790815594;
	bh=4RjAhv5Qu85qUeb3ICwH+q/dzYzq9Yxtlcy47Uu8mT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZnHeSa2N3MRj88NIrKb21DlSrVBhXpGrZcInT+rfithtLjHykMJUsUZXm6Peb1Ki2
	 KtaVXUBMNH/rnOeMKPVEVljTrSqCJlQZKazwxBP+j2ds4qE7jDgSHKUDI4KMWuWtgc
	 1E5oDaxjekcxm2NjcWdDnqgTAFecFzLikOfdkTkd4mAS1h9a6uhjCKbZ4eFZ1wtHAU
	 2NCq4VE7KARJI3WILnufB3ATkmVBs9QhAOJjk30haDlRGzBBCIAukhoQ/WAVDw3TtK
	 fb2IYGkV+rNNnqsAa6KXUfl0MdmBjW13nY/3Y79/mQf41KJL0kUhKJWYvLj6XkB049
	 uFYKD6bEFC/Bg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] KVM: x86: Add static calls for nested virtualization ops
Date: Wed, 30 Sep 2026 20:46:31 -0400
Message-ID: <20261001004632.2232201-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092940-distress-hardship-4b3d@gregkh>
References: <2026092940-distress-hardship-4b3d@gregkh>
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

[5.15 dependency adaptation for c1214f293d77:
Keep only the get_nested_state_pages static call and initialize it in the
existing kvm_ops_static_call_update().  Drop the other call conversions,
including hooks and helpers absent from 5.15; add no new functions.

Include the request re-pend from commit 10180a277549 ("KVM: x86: Re-pend
GET_NESTED_STATE_PAGES if getting said pages fails"). Failed loads are
retried, supplying the target's common error-path prerequisite.
Both vendors already clear the request when leaving nested mode here.

Rename the existing SVM MSRPM merge helper and pass struct kvm_vcpu, as
expected by the target, without changing its bitmap-merging behavior.
Move VMX's nested_run_pending flag to kvm_vcpu_arch and update every VMX
reference, preserving the flag's lifetime and leaving SVM's flag alone.
These preparations let the unmodified target cherry-pick without conflicts
while retaining all of the target's error-reporting changes for that
commit.]

[ sashal: Reduced backport -- upstream 4b9819a50674d touches 7 file(s), this
  backport carries 6. Not backported here:
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
 arch/x86/include/asm/kvm_host.h | 11 ++++++++
 arch/x86/kvm/svm/nested.c       |  7 ++---
 arch/x86/kvm/vmx/nested.c       | 48 ++++++++++++++++-----------------
 arch/x86/kvm/vmx/vmx.c          | 14 +++++-----
 arch/x86/kvm/vmx/vmx.h          |  3 ---
 arch/x86/kvm/x86.c              |  6 ++++-
 6 files changed, 51 insertions(+), 38 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 710c9c87cdf2e..85b69557157fd 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -728,6 +728,9 @@ struct kvm_vcpu_arch {
 		u8 nr;
 	} interrupt;
 
+	/* VMX: L2 must run next, and must not decide to exit to L1. */
+	bool nested_run_pending;
+
 	int halt_request; /* real mode on Intel only */
 
 	int cpuid_nent;
@@ -1542,12 +1545,20 @@ extern struct kvm_x86_ops kvm_x86_ops;
 #define KVM_X86_OP_NULL KVM_X86_OP
 #include <asm/kvm-x86-ops.h>
 
+#define kvm_nested_call(func) static_call(kvm_x86_nested_##func)
+
+DECLARE_STATIC_CALL(kvm_x86_nested_get_nested_state_pages,
+		    *(((struct kvm_x86_nested_ops *)0)->get_nested_state_pages));
+
 static inline void kvm_ops_static_call_update(void)
 {
 #define KVM_X86_OP(func) \
 	static_call_update(kvm_x86_##func, kvm_x86_ops.func);
 #define KVM_X86_OP_NULL KVM_X86_OP
 #include <asm/kvm-x86-ops.h>
+
+	static_call_update(kvm_x86_nested_get_nested_state_pages,
+			   kvm_x86_ops.nested_ops->get_nested_state_pages);
 }
 
 #define __KVM_HAVE_ARCH_VM_ALLOC
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 189084b317470..08f30b5ebe30f 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -200,13 +200,14 @@ static void copy_vmcb_control_area(struct vmcb_control_area *dst,
 	dst->pause_filter_thresh  = from->pause_filter_thresh;
 }
 
-static bool nested_svm_vmrun_msrpm(struct vcpu_svm *svm)
+static bool nested_svm_merge_msrpm(struct kvm_vcpu *vcpu)
 {
 	/*
 	 * This function merges the msr permission bitmaps of kvm and the
 	 * nested vmcb. It is optimized in that it only merges the parts where
 	 * the kvm msr permission bitmap may contain zero bits
 	 */
+	struct vcpu_svm *svm = to_svm(vcpu);
 	int i;
 
 	if (!(vmcb_is_intercept(&svm->nested.ctl, INTERCEPT_MSR_PROT)))
@@ -697,7 +698,7 @@ int nested_svm_vmrun(struct kvm_vcpu *vcpu)
 	if (enter_svm_guest_mode(vcpu, vmcb12_gpa, vmcb12, true))
 		goto out_exit_err;
 
-	if (nested_svm_vmrun_msrpm(svm))
+	if (nested_svm_merge_msrpm(vcpu))
 		goto out;
 
 out_exit_err:
@@ -1438,7 +1439,7 @@ static bool svm_get_nested_state_pages(struct kvm_vcpu *vcpu)
 		if (CC(!load_pdptrs(vcpu, vcpu->arch.walk_mmu, vcpu->arch.cr3)))
 			return false;
 
-	if (!nested_svm_vmrun_msrpm(svm)) {
+	if (!nested_svm_merge_msrpm(vcpu)) {
 		vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
 		vcpu->run->internal.suberror =
 			KVM_INTERNAL_ERROR_EMULATION;
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 3249454c6f777..1b87dded131dc 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -482,7 +482,7 @@ static void vmx_inject_page_fault_nested(struct kvm_vcpu *vcpu,
 	WARN_ON(!is_guest_mode(vcpu));
 
 	if (nested_vmx_is_page_fault_vmexit(vmcs12, fault->error_code) &&
-		!to_vmx(vcpu)->nested.nested_run_pending) {
+		!vcpu->arch.nested_run_pending) {
 		vmcs12->vm_exit_intr_error_code = fault->error_code;
 		nested_vmx_vmexit(vcpu, EXIT_REASON_EXCEPTION_NMI,
 				  PF_VECTOR | INTR_TYPE_HARD_EXCEPTION |
@@ -2130,7 +2130,7 @@ static void vmx_start_preemption_timer(struct kvm_vcpu *vcpu,
 
 static u64 nested_vmx_calc_efer(struct vcpu_vmx *vmx, struct vmcs12 *vmcs12)
 {
-	if (vmx->nested.nested_run_pending &&
+	if (vmx->vcpu.arch.nested_run_pending &&
 	    (vmcs12->vm_entry_controls & VM_ENTRY_LOAD_IA32_EFER))
 		return vmcs12->guest_ia32_efer;
 	else if (vmcs12->vm_entry_controls & VM_ENTRY_IA32E_MODE)
@@ -2371,7 +2371,7 @@ static void prepare_vmcs02_early(struct vcpu_vmx *vmx, struct loaded_vmcs *vmcs0
 	/*
 	 * Interrupt/Exception Fields
 	 */
-	if (vmx->nested.nested_run_pending) {
+	if (vmx->vcpu.arch.nested_run_pending) {
 		vmcs_write32(VM_ENTRY_INTR_INFO_FIELD,
 			     vmcs12->vm_entry_intr_info_field);
 		vmcs_write32(VM_ENTRY_EXCEPTION_ERROR_CODE,
@@ -2452,7 +2452,7 @@ static void prepare_vmcs02_rare(struct vcpu_vmx *vmx, struct vmcs12 *vmcs12)
 			vmcs_write64(GUEST_PDPTR3, vmcs12->guest_pdptr3);
 		}
 
-		if (kvm_mpx_supported() && vmx->nested.nested_run_pending &&
+		if (kvm_mpx_supported() && vmx->vcpu.arch.nested_run_pending &&
 		    (vmcs12->vm_entry_controls & VM_ENTRY_LOAD_BNDCFGS))
 			vmcs_write64(GUEST_BNDCFGS, vmcs12->guest_bndcfgs);
 	}
@@ -2532,7 +2532,7 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
 			  HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP1);
 	}
 
-	if (vmx->nested.nested_run_pending &&
+	if (vcpu->arch.nested_run_pending &&
 	    (vmcs12->vm_entry_controls & VM_ENTRY_LOAD_DEBUG_CONTROLS)) {
 		kvm_set_dr(vcpu, 7, vmcs12->guest_dr7);
 		vmcs_write64(GUEST_IA32_DEBUGCTL, vmcs12->guest_ia32_debugctl);
@@ -2540,7 +2540,7 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
 		kvm_set_dr(vcpu, 7, vcpu->arch.dr7);
 		vmcs_write64(GUEST_IA32_DEBUGCTL, vmx->nested.vmcs01_debugctl);
 	}
-	if (kvm_mpx_supported() && (!vmx->nested.nested_run_pending ||
+	if (kvm_mpx_supported() && (!vcpu->arch.nested_run_pending ||
 	    !(vmcs12->vm_entry_controls & VM_ENTRY_LOAD_BNDCFGS)))
 		vmcs_write64(GUEST_BNDCFGS, vmx->nested.vmcs01_guest_bndcfgs);
 	vmx_set_rflags(vcpu, vmcs12->guest_rflags);
@@ -2553,7 +2553,7 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
 	vcpu->arch.cr0_guest_owned_bits &= ~vmcs12->cr0_guest_host_mask;
 	vmcs_writel(CR0_GUEST_HOST_MASK, ~vcpu->arch.cr0_guest_owned_bits);
 
-	if (vmx->nested.nested_run_pending &&
+	if (vcpu->arch.nested_run_pending &&
 	    (vmcs12->vm_entry_controls & VM_ENTRY_LOAD_IA32_PAT)) {
 		vmcs_write64(GUEST_IA32_PAT, vmcs12->guest_ia32_pat);
 		vcpu->arch.pat = vmcs12->guest_ia32_pat;
@@ -3057,7 +3057,7 @@ static int nested_vmx_check_guest_state(struct kvm_vcpu *vcpu,
 	 *   to bit 8 (LME) if bit 31 in the CR0 field (corresponding to
 	 *   CR0.PG) is 1.
 	 */
-	if (to_vmx(vcpu)->nested.nested_run_pending &&
+	if (vcpu->arch.nested_run_pending &&
 	    (vmcs12->vm_entry_controls & VM_ENTRY_LOAD_IA32_EFER)) {
 		if (CC(!kvm_valid_efer(vcpu, vmcs12->guest_ia32_efer)) ||
 		    CC(ia32e != !!(vmcs12->guest_ia32_efer & EFER_LMA)) ||
@@ -3403,11 +3403,11 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
 	if (likely(!evaluate_pending_interrupts) && kvm_vcpu_apicv_active(vcpu))
 		evaluate_pending_interrupts |= vmx_has_apicv_interrupt(vcpu);
 
-	if (!vmx->nested.nested_run_pending ||
+	if (!vcpu->arch.nested_run_pending ||
 	    !(vmcs12->vm_entry_controls & VM_ENTRY_LOAD_DEBUG_CONTROLS))
 		vmx->nested.vmcs01_debugctl = vmcs_read64(GUEST_IA32_DEBUGCTL);
 	if (kvm_mpx_supported() &&
-	    (!vmx->nested.nested_run_pending ||
+	    (!vcpu->arch.nested_run_pending ||
 	     !(vmcs12->vm_entry_controls & VM_ENTRY_LOAD_BNDCFGS)))
 		vmx->nested.vmcs01_guest_bndcfgs = vmcs_read64(GUEST_BNDCFGS);
 
@@ -3625,7 +3625,7 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch)
 	 * We're finally done with prerequisite checking, and can start with
 	 * the nested entry.
 	 */
-	vmx->nested.nested_run_pending = 1;
+	vcpu->arch.nested_run_pending = 1;
 	vmx->nested.has_preemption_timer_deadline = false;
 	status = nested_vmx_enter_non_root_mode(vcpu, true);
 	if (unlikely(status != NVMX_VMENTRY_SUCCESS))
@@ -3665,12 +3665,12 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch)
 		    !nested_cpu_has(vmcs12, CPU_BASED_NMI_WINDOW_EXITING) &&
 		    !(nested_cpu_has(vmcs12, CPU_BASED_INTR_WINDOW_EXITING) &&
 		      (vmcs12->guest_rflags & X86_EFLAGS_IF))) {
-			vmx->nested.nested_run_pending = 0;
+			vcpu->arch.nested_run_pending = 0;
 			return kvm_vcpu_halt(vcpu);
 		}
 		break;
 	case GUEST_ACTIVITY_WAIT_SIPI:
-		vmx->nested.nested_run_pending = 0;
+		vcpu->arch.nested_run_pending = 0;
 		vcpu->arch.mp_state = KVM_MP_STATE_INIT_RECEIVED;
 		break;
 	default:
@@ -3680,7 +3680,7 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch)
 	return 1;
 
 vmentry_failed:
-	vmx->nested.nested_run_pending = 0;
+	vcpu->arch.nested_run_pending = 0;
 	if (status == NVMX_VMENTRY_KVM_INTERNAL_ERROR)
 		return 0;
 	if (status == NVMX_VMENTRY_VMEXIT)
@@ -3927,7 +3927,7 @@ static int vmx_check_nested_events(struct kvm_vcpu *vcpu)
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	unsigned long exit_qual;
 	bool block_nested_events =
-	    vmx->nested.nested_run_pending || kvm_event_needs_reinjection(vcpu);
+	    vcpu->arch.nested_run_pending || kvm_event_needs_reinjection(vcpu);
 	bool mtf_pending = vmx->nested.mtf_pending;
 	struct kvm_lapic *apic = vcpu->arch.apic;
 
@@ -3971,7 +3971,7 @@ static int vmx_check_nested_events(struct kvm_vcpu *vcpu)
 	 */
 
 	if (vcpu->arch.exception.pending && !vmx_pending_dbg_trap(vcpu)) {
-		if (vmx->nested.nested_run_pending)
+		if (vcpu->arch.nested_run_pending)
 			return -EBUSY;
 		if (!nested_vmx_check_exception(vcpu, &exit_qual))
 			goto no_vmexit;
@@ -3988,7 +3988,7 @@ static int vmx_check_nested_events(struct kvm_vcpu *vcpu)
 	}
 
 	if (vcpu->arch.exception.pending) {
-		if (vmx->nested.nested_run_pending)
+		if (vcpu->arch.nested_run_pending)
 			return -EBUSY;
 		if (!nested_vmx_check_exception(vcpu, &exit_qual))
 			goto no_vmexit;
@@ -4209,7 +4209,7 @@ static void sync_vmcs02_to_vmcs12(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12)
 
 	if (nested_cpu_has_preemption_timer(vmcs12) &&
 	    vmcs12->vm_exit_controls & VM_EXIT_SAVE_VMX_PREEMPTION_TIMER &&
-	    !vmx->nested.nested_run_pending)
+	    !vcpu->arch.nested_run_pending)
 		vmcs12->vmx_preemption_timer_value =
 			vmx_get_preemption_timer_value(vcpu);
 
@@ -4579,7 +4579,7 @@ void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 vm_exit_reason,
 	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
 
 	/* trying to cancel vmlaunch/vmresume is a bug */
-	WARN_ON_ONCE(vmx->nested.nested_run_pending);
+	WARN_ON_ONCE(vcpu->arch.nested_run_pending);
 
 	if (kvm_check_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu)) {
 		/*
@@ -6192,7 +6192,7 @@ bool nested_vmx_reflect_vmexit(struct kvm_vcpu *vcpu)
 	unsigned long exit_qual;
 	u32 exit_intr_info;
 
-	WARN_ON_ONCE(vmx->nested.nested_run_pending);
+	WARN_ON_ONCE(vcpu->arch.nested_run_pending);
 
 	/*
 	 * Late nested VM-Fail shares the same flow as nested VM-Exit since KVM
@@ -6288,7 +6288,7 @@ static int vmx_get_nested_state(struct kvm_vcpu *vcpu,
 		if (is_guest_mode(vcpu)) {
 			kvm_state.flags |= KVM_STATE_NESTED_GUEST_MODE;
 
-			if (vmx->nested.nested_run_pending)
+			if (vcpu->arch.nested_run_pending)
 				kvm_state.flags |= KVM_STATE_NESTED_RUN_PENDING;
 
 			if (vmx->nested.mtf_pending)
@@ -6363,7 +6363,7 @@ static int vmx_get_nested_state(struct kvm_vcpu *vcpu,
 void vmx_leave_nested(struct kvm_vcpu *vcpu)
 {
 	if (is_guest_mode(vcpu)) {
-		to_vmx(vcpu)->nested.nested_run_pending = 0;
+		vcpu->arch.nested_run_pending = 0;
 		nested_vmx_vmexit(vcpu, -1, 0, 0);
 	}
 	free_nested(vcpu);
@@ -6497,7 +6497,7 @@ static int vmx_set_nested_state(struct kvm_vcpu *vcpu,
 	if (!(kvm_state->flags & KVM_STATE_NESTED_GUEST_MODE))
 		return 0;
 
-	vmx->nested.nested_run_pending =
+	vcpu->arch.nested_run_pending =
 		!!(kvm_state->flags & KVM_STATE_NESTED_RUN_PENDING);
 
 	vmx->nested.mtf_pending =
@@ -6545,7 +6545,7 @@ static int vmx_set_nested_state(struct kvm_vcpu *vcpu,
 	return 0;
 
 error_guest_mode:
-	vmx->nested.nested_run_pending = 0;
+	vcpu->arch.nested_run_pending = 0;
 	return ret;
 }
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 244b67601bce7..651dc9eeffad7 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4701,7 +4701,7 @@ bool vmx_nmi_blocked(struct kvm_vcpu *vcpu)
 
 static int vmx_nmi_allowed(struct kvm_vcpu *vcpu, bool for_injection)
 {
-	if (to_vmx(vcpu)->nested.nested_run_pending)
+	if (vcpu->arch.nested_run_pending)
 		return -EBUSY;
 
 	/* An NMI must not be injected into L2 if it's supposed to VM-Exit.  */
@@ -4728,7 +4728,7 @@ bool vmx_interrupt_blocked(struct kvm_vcpu *vcpu)
 
 static int vmx_interrupt_allowed(struct kvm_vcpu *vcpu, bool for_injection)
 {
-	if (to_vmx(vcpu)->nested.nested_run_pending)
+	if (vcpu->arch.nested_run_pending)
 		return -EBUSY;
 
        /*
@@ -6029,7 +6029,7 @@ static int __vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
 	 * invalid guest state should never happen as that means KVM knowingly
 	 * allowed a nested VM-Enter with an invalid vmcs12.  More below.
 	 */
-	if (KVM_BUG_ON(vmx->nested.nested_run_pending, vcpu->kvm))
+	if (KVM_BUG_ON(vcpu->arch.nested_run_pending, vcpu->kvm))
 		return -EIO;
 
 	if (is_guest_mode(vcpu)) {
@@ -6915,11 +6915,11 @@ static fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu)
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
@@ -7666,7 +7666,7 @@ static void vmx_setup_mce(struct kvm_vcpu *vcpu)
 static int vmx_smi_allowed(struct kvm_vcpu *vcpu, bool for_injection)
 {
 	/* we need a nested vmexit to enter SMM, postpone if run is pending */
-	if (to_vmx(vcpu)->nested.nested_run_pending)
+	if (vcpu->arch.nested_run_pending)
 		return -EBUSY;
 	return !is_smm(vcpu);
 }
@@ -7700,7 +7700,7 @@ static int vmx_leave_smm(struct kvm_vcpu *vcpu, const char *smstate)
 		if (ret)
 			return ret;
 
-		vmx->nested.nested_run_pending = 1;
+		vcpu->arch.nested_run_pending = 1;
 		vmx->nested.smm.guest_mode = false;
 	}
 	return 0;
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 9842f6833929a..1117113d6d7d6 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -186,9 +186,6 @@ struct nested_vmx {
 	 */
 	bool enlightened_vmcs_enabled;
 
-	/* L2 must run next, and mustn't decide to exit to L1. */
-	bool nested_run_pending;
-
 	/* Pending MTF VM-exit into L1.  */
 	bool mtf_pending;
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index bbfc8ccf4fcd9..aa459fb327682 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -132,6 +132,9 @@ EXPORT_STATIC_CALL_GPL(kvm_x86_get_cs_db_l_bits);
 EXPORT_STATIC_CALL_GPL(kvm_x86_cache_reg);
 EXPORT_STATIC_CALL_GPL(kvm_x86_tlb_flush_current);
 
+DEFINE_STATIC_CALL_NULL(kvm_x86_nested_get_nested_state_pages,
+		       *(((struct kvm_x86_nested_ops *)0)->get_nested_state_pages));
+
 static bool __read_mostly ignore_msrs = 0;
 module_param(ignore_msrs, bool, S_IRUGO | S_IWUSR);
 
@@ -9775,7 +9778,8 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 			goto out;
 		}
 		if (kvm_check_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu)) {
-			if (unlikely(!kvm_x86_ops.nested_ops->get_nested_state_pages(vcpu))) {
+			if (unlikely(!kvm_nested_call(get_nested_state_pages)(vcpu))) {
+				kvm_make_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
 				r = 0;
 				goto out;
 			}
-- 
2.53.0

