Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517D14FDE70
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 15:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790782790; cv=none; b=Sx8thrsbGlfG9UYWTKHD2vkTRF87Xwctp4Ew1Ev+v56odX8o9o/07aTm4ou2FXn+FijUBWV2wWK1K+mjXpvVQAts4n0BIn/NeFf1UyR5b4pk+jQYOTrZDMyq+Xu9i/7rNjs0mSdZTEOzGMm3Jj3EmlZnXpez2Tr6sauRxPtY8EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790782790; c=relaxed/simple;
	bh=0VQ1YY1b6lxe+E2XjfBjGE4djuWOfkfEBF7kfMcQtxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dVhfe9VqNsxlf2aw7s9icUBJ/WcCJ47r5keUH2iaZ8mBdsvxOHkgzSbcUqnU20dxdQNpLw6DjfOzp9BdU/Dx99EWCfNnMXVaNPLxRy8e3PCnMKULR2jDAGxxCRjLiOFyWJCC6gOBITo/5GpwBIMFsQXTcqF+w34ebrjO5kTUgeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/55FNfG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/55FNfG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1802C1F00898;
	Wed, 30 Sep 2026 15:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790782778;
	bh=towmNZwuX2igo45SdPrgNgIRVC3TUhP/oDluTldmwgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O/55FNfGlIDstFzKN2Hfd40dv3r+Hccf79WyZvCnAfZ9n312Rpcb7Fb2+Db1las1m
	 smSXel11W5WsLqo9j09GJF4rJ/CH5SiH0+ps/GESI7J35lLrCkb0xtsuhOBX7VvWhT
	 3wtUT4wMts2pD4Ox/XyxD6KPckBycZSUIJh6NNHgcvIwKqXCGaoIfG16oV+e+QoSU8
	 4IpGTKBLZ6geE3I/wvw7tlKbJH9uS0otPSwo8ZG7oQcSLkIPrhGCU1+kBJAiDfMWda
	 fIoFuNxUx1WKkS1s1VBoW6smXA99y2BY93xSblDgJJDonwhhUZcPfBSvrt+26zW95z
	 lgEb9hrXKx2rQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/4] KVM: x86: Add static calls for nested virtualization ops
Date: Wed, 30 Sep 2026 11:39:33 -0400
Message-ID: <20260930153934.2895211-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930153934.2895211-1-sashal@kernel.org>
References: <2026092938-celibate-sarcastic-e56f@gregkh>
 <20260930153934.2895211-1-sashal@kernel.org>
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

Backport to 6.18 as a dependency of c1214f293d77:

- Preserve the vendor init/exit declarations and the direct nested GPA
  translation path.  This tree has no translate_nested_gpa nested op.
- Initialize nested static calls inside the existing kvm_ops_update(),
  avoiding new helper functions and the unrelated EFER setup refactoring.
- Fold in the boolean nested_run_pending relocation from 3d4470d71fbf7,
  preserving the stable SVM control and error paths.  The target expects
  this flag in kvm_vcpu_arch in its VMX entry-failure hunk.
- Fold in the request requeue from 10180a2775493, which is context for the
  target's common error path and prevents retrying L2 with stale pages.
- Brace the existing SVM PDPTR reload condition to match target context.

These preparations let the unmodified target apply cleanly without adding
functions or importing unrelated upstream refactoring.

[ sashal: Reduced backport -- upstream 4b9819a50674d touches 7 file(s), this
  backport carries 12. Not backported here:
  arch/x86/kvm/mmu.h
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: c1214f293d77 ("KVM: x86: Fill kvm_run exit fields in common get_nested_state_pages() error paths")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/kvm-x86-nested-ops.h | 35 ++++++++++++++++
 arch/x86/include/asm/kvm_host.h           | 17 ++++++++
 arch/x86/kvm/hyperv.c                     |  7 ++--
 arch/x86/kvm/mmu/paging_tmpl.h            |  2 +-
 arch/x86/kvm/svm/nested.c                 | 21 +++++-----
 arch/x86/kvm/svm/svm.c                    | 16 +++----
 arch/x86/kvm/svm/svm.h                    |  4 --
 arch/x86/kvm/vmx/nested.c                 | 46 ++++++++++----------
 arch/x86/kvm/vmx/vmx.c                    | 16 +++----
 arch/x86/kvm/vmx/vmx.h                    |  3 --
 arch/x86/kvm/x86.c                        | 51 +++++++++++++++--------
 arch/x86/kvm/x86.h                        |  2 +-
 12 files changed, 140 insertions(+), 80 deletions(-)
 create mode 100644 arch/x86/include/asm/kvm-x86-nested-ops.h

diff --git a/arch/x86/include/asm/kvm-x86-nested-ops.h b/arch/x86/include/asm/kvm-x86-nested-ops.h
new file mode 100644
index 0000000000000..66360aa440c4b
--- /dev/null
+++ b/arch/x86/include/asm/kvm-x86-nested-ops.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#if !defined(KVM_X86_NESTED_OP) || \
+    !defined(KVM_X86_NESTED_OP_OPTIONAL) || \
+    !defined(KVM_X86_NESTED_OP_OPTIONAL_RET0)
+#error Missing one or more KVM_X86_NESTED_OP #defines
+#else
+/*
+ * KVM_X86_NESTED_OP() and KVM_X86_NESTED_OP_OPTIONAL() are used to help
+ * generate both DECLARE/DEFINE_STATIC_CALL() invocations and
+ * "static_call_update()" calls.
+ *
+ * KVM_X86_NESTED_OP_OPTIONAL() can be used for those functions that can have
+ * a NULL definition.  KVM_X86_NESTED_OP_OPTIONAL_RET0() can be used likewise
+ * to make a definition optional, but in this case the default will
+ * be __static_call_return0.
+ */
+KVM_X86_NESTED_OP(leave_nested)
+KVM_X86_NESTED_OP(is_exception_vmexit)
+KVM_X86_NESTED_OP(check_events)
+KVM_X86_NESTED_OP_OPTIONAL_RET0(has_events)
+KVM_X86_NESTED_OP(triple_fault)
+KVM_X86_NESTED_OP(get_state)
+KVM_X86_NESTED_OP(set_state)
+KVM_X86_NESTED_OP(get_nested_state_pages)
+KVM_X86_NESTED_OP_OPTIONAL_RET0(write_log_dirty)
+#ifdef CONFIG_KVM_HYPERV
+KVM_X86_NESTED_OP_OPTIONAL(enable_evmcs)
+KVM_X86_NESTED_OP_OPTIONAL_RET0(get_evmcs_version)
+KVM_X86_NESTED_OP(hv_inject_synthetic_vmexit_post_tlb_flush)
+#endif
+#endif
+
+#undef KVM_X86_NESTED_OP
+#undef KVM_X86_NESTED_OP_OPTIONAL
+#undef KVM_X86_NESTED_OP_OPTIONAL_RET0
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 5202b0a708807..77d1984581033 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1089,6 +1089,15 @@ struct kvm_vcpu_arch {
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
@@ -2009,6 +2018,14 @@ extern struct kvm_x86_ops kvm_x86_ops;
 #define KVM_X86_OP_OPTIONAL_RET0 KVM_X86_OP
 #include <asm/kvm-x86-ops.h>
 
+#define kvm_nested_call(func) static_call(kvm_x86_nested_##func)
+
+#define KVM_X86_NESTED_OP(func) \
+	DECLARE_STATIC_CALL(kvm_x86_nested_##func, *(((struct kvm_x86_nested_ops *)0)->func));
+#define KVM_X86_NESTED_OP_OPTIONAL KVM_X86_NESTED_OP
+#define KVM_X86_NESTED_OP_OPTIONAL_RET0 KVM_X86_NESTED_OP
+#include <asm/kvm-x86-nested-ops.h>
+
 int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops);
 void kvm_x86_vendor_exit(void);
 
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 4753d084e2567..56325ba9ef367 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2415,7 +2415,7 @@ static int kvm_hv_hypercall_complete(struct kvm_vcpu *vcpu, u64 result)
 	ret = kvm_skip_emulated_instruction(vcpu);
 
 	if (tlb_lock_count)
-		kvm_x86_ops.nested_ops->hv_inject_synthetic_vmexit_post_tlb_flush(vcpu);
+		kvm_nested_call(hv_inject_synthetic_vmexit_post_tlb_flush)(vcpu);
 
 	return ret;
 }
@@ -2799,9 +2799,8 @@ int kvm_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
 	};
 	int i, nent = ARRAY_SIZE(cpuid_entries);
 
-	if (kvm_x86_ops.nested_ops->enabled &&
-	    kvm_x86_ops.nested_ops->get_evmcs_version)
-		evmcs_ver = kvm_x86_ops.nested_ops->get_evmcs_version(vcpu);
+	if (kvm_x86_ops.nested_ops->enabled)
+		evmcs_ver = kvm_nested_call(get_evmcs_version)(vcpu);
 
 	if (cpuid->nent < nent)
 		return -E2BIG;
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index af220c9c8ab8d..6e2ce54a13b31 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -222,7 +222,7 @@ static int FNAME(update_accessed_dirty_bits)(struct kvm_vcpu *vcpu,
 				!(pte & PT_GUEST_DIRTY_MASK)) {
 			trace_kvm_mmu_set_dirty_bit(table_gfn, index, sizeof(pte));
 #if PTTYPE == PTTYPE_EPT
-			if (kvm_x86_ops.nested_ops->write_log_dirty(vcpu, addr))
+			if (kvm_nested_call(write_log_dirty)(vcpu, addr))
 				return -EINVAL;
 #endif
 			pte |= PT_GUEST_DIRTY_MASK;
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 66b8955a1658e..c765ea1dff69c 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -838,7 +838,7 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
 	 * the CPU and/or KVM and should be used regardless of L1's support.
 	 */
 	if (guest_cpu_cap_has(vcpu, X86_FEATURE_NRIPS) ||
-	    !svm->nested.nested_run_pending)
+	    !vcpu->arch.nested_run_pending)
 		vmcb02->control.next_rip = svm->nested.ctl.next_rip;
 
 	svm->nmi_l1_to_l2 = is_evtinj_nmi(vmcb02->control.event_inj);
@@ -850,7 +850,7 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
 	if (is_evtinj_soft(vmcb02->control.event_inj)) {
 		svm->soft_int_injected = true;
 		if (guest_cpu_cap_has(vcpu, X86_FEATURE_NRIPS) ||
-		    !svm->nested.nested_run_pending)
+		    !vcpu->arch.nested_run_pending)
 			svm->soft_int_next_rip = svm->nested.ctl.next_rip;
 	}
 
@@ -1023,7 +1023,7 @@ int nested_svm_vmrun(struct kvm_vcpu *vcpu)
 	if (!npt_enabled)
 		vmcb01->save.cr3 = kvm_read_cr3(vcpu);
 
-	svm->nested.nested_run_pending = 1;
+	vcpu->arch.nested_run_pending = 1;
 
 	if (enter_svm_guest_mode(vcpu, vmcb12_gpa, vmcb12, true))
 		goto out_exit_err;
@@ -1032,7 +1032,7 @@ int nested_svm_vmrun(struct kvm_vcpu *vcpu)
 		goto out;
 
 out_exit_err:
-	svm->nested.nested_run_pending = 0;
+	vcpu->arch.nested_run_pending = 0;
 
 	svm->vmcb->control.exit_code    = SVM_EXIT_ERR;
 	svm->vmcb->control.exit_code_hi = -1u;
@@ -1177,7 +1177,7 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
 	/* Exit Guest-Mode */
 	leave_guest_mode(vcpu);
 	svm->nested.vmcb12_gpa = 0;
-	WARN_ON_ONCE(svm->nested.nested_run_pending);
+	WARN_ON_ONCE(vcpu->arch.nested_run_pending);
 
 	kvm_clear_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
 
@@ -1387,7 +1387,7 @@ void svm_leave_nested(struct kvm_vcpu *vcpu)
 	struct vcpu_svm *svm = to_svm(vcpu);
 
 	if (is_guest_mode(vcpu)) {
-		svm->nested.nested_run_pending = 0;
+		vcpu->arch.nested_run_pending = 0;
 		svm->nested.vmcb12_gpa = INVALID_GPA;
 
 		leave_guest_mode(vcpu);
@@ -1583,7 +1583,7 @@ static int svm_check_nested_events(struct kvm_vcpu *vcpu)
 	 * previously injected event, the pending exception occurred while said
 	 * event was being delivered and thus needs to be handled.
 	 */
-	bool block_nested_exceptions = svm->nested.nested_run_pending;
+	bool block_nested_exceptions = vcpu->arch.nested_run_pending;
 	/*
 	 * New events (not exceptions) are only recognized at instruction
 	 * boundaries.  If an event needs reinjection, then KVM is handling a
@@ -1758,7 +1758,7 @@ static int svm_get_nested_state(struct kvm_vcpu *vcpu,
 		kvm_state.size += KVM_STATE_NESTED_SVM_VMCB_SIZE;
 		kvm_state.flags |= KVM_STATE_NESTED_GUEST_MODE;
 
-		if (svm->nested.nested_run_pending)
+		if (vcpu->arch.nested_run_pending)
 			kvm_state.flags |= KVM_STATE_NESTED_RUN_PENDING;
 	}
 
@@ -1895,7 +1895,7 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 
 	svm_set_gif(svm, !!(kvm_state->flags & KVM_STATE_NESTED_GIF_SET));
 
-	svm->nested.nested_run_pending =
+	vcpu->arch.nested_run_pending =
 		!!(kvm_state->flags & KVM_STATE_NESTED_RUN_PENDING);
 
 	svm->nested.vmcb12_gpa = kvm_state->hdr.svm.vmcb_pa;
@@ -1943,7 +1943,7 @@ static bool svm_get_nested_state_pages(struct kvm_vcpu *vcpu)
 		return true;
 
 	if (!vcpu->arch.pdptrs_from_userspace &&
-	    !nested_npt_enabled(to_svm(vcpu)) && is_pae_paging(vcpu))
+	    !nested_npt_enabled(to_svm(vcpu)) && is_pae_paging(vcpu)) {
 		/*
 		 * Reload the guest's PDPTRs since after a migration
 		 * the guest CR3 might be restored prior to setting the nested
@@ -1951,6 +1951,7 @@ static bool svm_get_nested_state_pages(struct kvm_vcpu *vcpu)
 		 */
 		if (CC(!load_pdptrs(vcpu, vcpu->arch.cr3)))
 			return false;
+	}
 
 	if (!nested_svm_merge_msrpm(vcpu)) {
 		vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index e3daa6e57192d..f687df75f775c 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3721,7 +3721,7 @@ static void svm_fixup_nested_rips(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
-	if (!is_guest_mode(vcpu) || !svm->nested.nested_run_pending)
+	if (!is_guest_mode(vcpu) || !vcpu->arch.nested_run_pending)
 		return;
 
 	/*
@@ -3869,7 +3869,7 @@ bool svm_nmi_blocked(struct kvm_vcpu *vcpu)
 static int svm_nmi_allowed(struct kvm_vcpu *vcpu, bool for_injection)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
-	if (svm->nested.nested_run_pending)
+	if (vcpu->arch.nested_run_pending)
 		return -EBUSY;
 
 	if (svm_nmi_blocked(vcpu))
@@ -3911,7 +3911,7 @@ static int svm_interrupt_allowed(struct kvm_vcpu *vcpu, bool for_injection)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
-	if (svm->nested.nested_run_pending)
+	if (vcpu->arch.nested_run_pending)
 		return -EBUSY;
 
 	if (svm_interrupt_blocked(vcpu))
@@ -4116,7 +4116,7 @@ static void svm_complete_soft_interrupt(struct kvm_vcpu *vcpu, u8 vector,
 	 * the soft int and will reinject it via the standard injection flow,
 	 * and so KVM needs to grab the state from the pending nested VMRUN.
 	 */
-	if (is_guest_mode(vcpu) && svm->nested.nested_run_pending)
+	if (is_guest_mode(vcpu) && vcpu->arch.nested_run_pending)
 		svm_set_nested_run_soft_int_state(vcpu);
 
 	/*
@@ -4417,11 +4417,11 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
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
@@ -4780,7 +4780,7 @@ bool svm_smi_blocked(struct kvm_vcpu *vcpu)
 static int svm_smi_allowed(struct kvm_vcpu *vcpu, bool for_injection)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
-	if (svm->nested.nested_run_pending)
+	if (vcpu->arch.nested_run_pending)
 		return -EBUSY;
 
 	if (svm_smi_blocked(vcpu))
@@ -4902,7 +4902,7 @@ static int svm_leave_smm(struct kvm_vcpu *vcpu, const union kvm_smram *smram)
 	if (ret)
 		goto unmap_save;
 
-	svm->nested.nested_run_pending = 1;
+	vcpu->arch.nested_run_pending = 1;
 
 unmap_save:
 	kvm_vcpu_unmap(vcpu, &map_save);
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 85f64d9ebe59a..a213aae517b28 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -199,10 +199,6 @@ struct svm_nested_state {
 	 */
 	void *msrpm;
 
-	/* A VMRUN has started but has not yet been performed, so
-	 * we cannot inject a nested vmexit yet.  */
-	bool nested_run_pending;
-
 	/* cache for control fields of the guest */
 	struct vmcb_ctrl_area_cached ctl;
 
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index bc5aa7456aac9..cb44ae23728b3 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -2284,7 +2284,7 @@ static void vmx_start_preemption_timer(struct kvm_vcpu *vcpu,
 
 static u64 nested_vmx_calc_efer(struct vcpu_vmx *vmx, struct vmcs12 *vmcs12)
 {
-	if (vmx->nested.nested_run_pending &&
+	if (vmx->vcpu.arch.nested_run_pending &&
 	    (vmcs12->vm_entry_controls & VM_ENTRY_LOAD_IA32_EFER))
 		return vmcs12->guest_ia32_efer;
 	else if (vmcs12->vm_entry_controls & VM_ENTRY_IA32E_MODE)
@@ -2534,7 +2534,7 @@ static void prepare_vmcs02_early(struct vcpu_vmx *vmx, struct loaded_vmcs *vmcs0
 	/*
 	 * Interrupt/Exception Fields
 	 */
-	if (vmx->nested.nested_run_pending) {
+	if (vmx->vcpu.arch.nested_run_pending) {
 		vmcs_write32(VM_ENTRY_INTR_INFO_FIELD,
 			     vmcs12->vm_entry_intr_info_field);
 		vmcs_write32(VM_ENTRY_EXCEPTION_ERROR_CODE,
@@ -2642,7 +2642,7 @@ static void prepare_vmcs02_rare(struct vcpu_vmx *vmx, struct vmcs12 *vmcs12)
 			vmcs_write64(GUEST_PDPTR3, vmcs12->guest_pdptr3);
 		}
 
-		if (kvm_mpx_supported() && vmx->nested.nested_run_pending &&
+		if (kvm_mpx_supported() && vmx->vcpu.arch.nested_run_pending &&
 		    (vmcs12->vm_entry_controls & VM_ENTRY_LOAD_BNDCFGS))
 			vmcs_write64(GUEST_BNDCFGS, vmcs12->guest_bndcfgs);
 	}
@@ -2726,7 +2726,7 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
 			!(evmcs->hv_clean_fields & HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP1);
 	}
 
-	if (vmx->nested.nested_run_pending &&
+	if (vcpu->arch.nested_run_pending &&
 	    (vmcs12->vm_entry_controls & VM_ENTRY_LOAD_DEBUG_CONTROLS)) {
 		kvm_set_dr(vcpu, 7, vmcs12->guest_dr7);
 		vmx_guest_debugctl_write(vcpu, vmcs12->guest_ia32_debugctl &
@@ -2736,13 +2736,13 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
 		vmx_guest_debugctl_write(vcpu, vmx->nested.pre_vmenter_debugctl);
 	}
 
-	if (!vmx->nested.nested_run_pending ||
+	if (!vcpu->arch.nested_run_pending ||
 	    !(vmcs12->vm_entry_controls & VM_ENTRY_LOAD_CET_STATE))
 		vmcs_write_cet_state(vcpu, vmx->nested.pre_vmenter_s_cet,
 				     vmx->nested.pre_vmenter_ssp,
 				     vmx->nested.pre_vmenter_ssp_tbl);
 
-	if (kvm_mpx_supported() && (!vmx->nested.nested_run_pending ||
+	if (kvm_mpx_supported() && (!vcpu->arch.nested_run_pending ||
 	    !(vmcs12->vm_entry_controls & VM_ENTRY_LOAD_BNDCFGS)))
 		vmcs_write64(GUEST_BNDCFGS, vmx->nested.pre_vmenter_bndcfgs);
 	vmx_set_rflags(vcpu, vmcs12->guest_rflags);
@@ -2755,7 +2755,7 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
 	vcpu->arch.cr0_guest_owned_bits &= ~vmcs12->cr0_guest_host_mask;
 	vmcs_writel(CR0_GUEST_HOST_MASK, ~vcpu->arch.cr0_guest_owned_bits);
 
-	if (vmx->nested.nested_run_pending &&
+	if (vcpu->arch.nested_run_pending &&
 	    (vmcs12->vm_entry_controls & VM_ENTRY_LOAD_IA32_PAT)) {
 		vmcs_write64(GUEST_IA32_PAT, vmcs12->guest_ia32_pat);
 		vcpu->arch.pat = vmcs12->guest_ia32_pat;
@@ -3321,7 +3321,7 @@ static int nested_vmx_check_guest_state(struct kvm_vcpu *vcpu,
 	 *   to bit 8 (LME) if bit 31 in the CR0 field (corresponding to
 	 *   CR0.PG) is 1.
 	 */
-	if (to_vmx(vcpu)->nested.nested_run_pending &&
+	if (vcpu->arch.nested_run_pending &&
 	    (vmcs12->vm_entry_controls & VM_ENTRY_LOAD_IA32_EFER)) {
 		if (CC(!kvm_valid_efer(vcpu, vmcs12->guest_ia32_efer)) ||
 		    CC(ia32e != !!(vmcs12->guest_ia32_efer & EFER_LMA)) ||
@@ -3677,15 +3677,15 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
 
 	kvm_service_local_tlb_flush_requests(vcpu);
 
-	if (!vmx->nested.nested_run_pending ||
+	if (!vcpu->arch.nested_run_pending ||
 	    !(vmcs12->vm_entry_controls & VM_ENTRY_LOAD_DEBUG_CONTROLS))
 		vmx->nested.pre_vmenter_debugctl = vmx_guest_debugctl_read();
 	if (kvm_mpx_supported() &&
-	    (!vmx->nested.nested_run_pending ||
+	    (!vcpu->arch.nested_run_pending ||
 	     !(vmcs12->vm_entry_controls & VM_ENTRY_LOAD_BNDCFGS)))
 		vmx->nested.pre_vmenter_bndcfgs = vmcs_read64(GUEST_BNDCFGS);
 
-	if (!vmx->nested.nested_run_pending ||
+	if (!vcpu->arch.nested_run_pending ||
 	    !(vmcs12->vm_entry_controls & VM_ENTRY_LOAD_CET_STATE))
 		vmcs_read_cet_state(vcpu, &vmx->nested.pre_vmenter_s_cet,
 				    &vmx->nested.pre_vmenter_ssp,
@@ -3908,7 +3908,7 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch)
 	 * We're finally done with prerequisite checking, and can start with
 	 * the nested entry.
 	 */
-	vmx->nested.nested_run_pending = 1;
+	vcpu->arch.nested_run_pending = 1;
 	vmx->nested.has_preemption_timer_deadline = false;
 	status = nested_vmx_enter_non_root_mode(vcpu, true);
 	if (unlikely(status != NVMX_VMENTRY_SUCCESS))
@@ -3940,12 +3940,12 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch)
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
 		kvm_set_mp_state(vcpu, KVM_MP_STATE_INIT_RECEIVED);
 		break;
 	default:
@@ -3955,7 +3955,7 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch)
 	return 1;
 
 vmentry_failed:
-	vmx->nested.nested_run_pending = 0;
+	vcpu->arch.nested_run_pending = 0;
 	if (status == NVMX_VMENTRY_KVM_INTERNAL_ERROR)
 		return 0;
 	if (status == NVMX_VMENTRY_VMEXIT)
@@ -4373,7 +4373,7 @@ static int vmx_check_nested_events(struct kvm_vcpu *vcpu)
 	 * previously injected event, the pending exception occurred while said
 	 * event was being delivered and thus needs to be handled.
 	 */
-	bool block_nested_exceptions = vmx->nested.nested_run_pending;
+	bool block_nested_exceptions = vcpu->arch.nested_run_pending;
 	/*
 	 * Events that don't require injection, i.e. that are virtualized by
 	 * hardware, aren't blocked by a pending VM-Enter as KVM doesn't need
@@ -4742,7 +4742,7 @@ static void sync_vmcs02_to_vmcs12(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12)
 
 	if (nested_cpu_has_preemption_timer(vmcs12) &&
 	    vmcs12->vm_exit_controls & VM_EXIT_SAVE_VMX_PREEMPTION_TIMER &&
-	    !vmx->nested.nested_run_pending)
+	    !vcpu->arch.nested_run_pending)
 		vmcs12->vmx_preemption_timer_value =
 			vmx_get_preemption_timer_value(vcpu);
 
@@ -5141,7 +5141,7 @@ void __nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 vm_exit_reason,
 	vmx->nested.mtf_pending = false;
 
 	/* trying to cancel vmlaunch/vmresume is a bug */
-	WARN_ON_ONCE(vmx->nested.nested_run_pending);
+	WARN_ON_ONCE(vcpu->arch.nested_run_pending);
 
 	/* Note, "checking" the request also clears the request. */
 	if (kvm_check_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu)) {
@@ -6787,7 +6787,7 @@ bool nested_vmx_reflect_vmexit(struct kvm_vcpu *vcpu)
 	unsigned long exit_qual;
 	u32 exit_intr_info;
 
-	WARN_ON_ONCE(vmx->nested.nested_run_pending);
+	WARN_ON_ONCE(vcpu->arch.nested_run_pending);
 
 	/*
 	 * Late nested VM-Fail shares the same flow as nested VM-Exit since KVM
@@ -6883,7 +6883,7 @@ static int vmx_get_nested_state(struct kvm_vcpu *vcpu,
 		if (is_guest_mode(vcpu)) {
 			kvm_state.flags |= KVM_STATE_NESTED_GUEST_MODE;
 
-			if (vmx->nested.nested_run_pending)
+			if (vcpu->arch.nested_run_pending)
 				kvm_state.flags |= KVM_STATE_NESTED_RUN_PENDING;
 
 			if (vmx->nested.mtf_pending)
@@ -6958,7 +6958,7 @@ static int vmx_get_nested_state(struct kvm_vcpu *vcpu,
 void vmx_leave_nested(struct kvm_vcpu *vcpu)
 {
 	if (is_guest_mode(vcpu)) {
-		to_vmx(vcpu)->nested.nested_run_pending = 0;
+		vcpu->arch.nested_run_pending = 0;
 		nested_vmx_vmexit(vcpu, -1, 0, 0);
 	}
 	free_nested(vcpu);
@@ -7095,7 +7095,7 @@ static int vmx_set_nested_state(struct kvm_vcpu *vcpu,
 	if (!(kvm_state->flags & KVM_STATE_NESTED_GUEST_MODE))
 		return 0;
 
-	vmx->nested.nested_run_pending =
+	vcpu->arch.nested_run_pending =
 		!!(kvm_state->flags & KVM_STATE_NESTED_RUN_PENDING);
 
 	vmx->nested.mtf_pending =
@@ -7147,7 +7147,7 @@ static int vmx_set_nested_state(struct kvm_vcpu *vcpu,
 	return 0;
 
 error_guest_mode:
-	vmx->nested.nested_run_pending = 0;
+	vcpu->arch.nested_run_pending = 0;
 	return ret;
 }
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 5bae3d5ce6eec..c36c0589cbca1 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5038,7 +5038,7 @@ bool vmx_nmi_blocked(struct kvm_vcpu *vcpu)
 
 int vmx_nmi_allowed(struct kvm_vcpu *vcpu, bool for_injection)
 {
-	if (to_vmx(vcpu)->nested.nested_run_pending)
+	if (vcpu->arch.nested_run_pending)
 		return -EBUSY;
 
 	/* An NMI must not be injected into L2 if it's supposed to VM-Exit.  */
@@ -5065,7 +5065,7 @@ bool vmx_interrupt_blocked(struct kvm_vcpu *vcpu)
 
 int vmx_interrupt_allowed(struct kvm_vcpu *vcpu, bool for_injection)
 {
-	if (to_vmx(vcpu)->nested.nested_run_pending)
+	if (vcpu->arch.nested_run_pending)
 		return -EBUSY;
 
 	/*
@@ -5830,7 +5830,7 @@ static bool vmx_unhandleable_emulation_required(struct kvm_vcpu *vcpu)
 	 * only reachable if userspace modifies L2 guest state after KVM has
 	 * performed the nested VM-Enter consistency checks.
 	 */
-	if (vmx->nested.nested_run_pending)
+	if (vcpu->arch.nested_run_pending)
 		return true;
 
 	/*
@@ -6508,7 +6508,7 @@ static int __vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
 	 * invalid guest state should never happen as that means KVM knowingly
 	 * allowed a nested VM-Enter with an invalid vmcs12.  More below.
 	 */
-	if (KVM_BUG_ON(vmx->nested.nested_run_pending, vcpu->kvm))
+	if (KVM_BUG_ON(vcpu->arch.nested_run_pending, vcpu->kvm))
 		return -EIO;
 
 	if (is_guest_mode(vcpu)) {
@@ -7500,11 +7500,11 @@ fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 		 * Track VMLAUNCH/VMRESUME that have made past guest state
 		 * checking.
 		 */
-		if (vmx->nested.nested_run_pending &&
+		if (vcpu->arch.nested_run_pending &&
 		    !vmx_get_exit_reason(vcpu).failed_vmentry)
 			++vcpu->stat.nested_run;
 
-		vmx->nested.nested_run_pending = 0;
+		vcpu->arch.nested_run_pending = 0;
 	}
 
 	if (unlikely(vmx->fail))
@@ -8263,7 +8263,7 @@ void vmx_setup_mce(struct kvm_vcpu *vcpu)
 int vmx_smi_allowed(struct kvm_vcpu *vcpu, bool for_injection)
 {
 	/* we need a nested vmexit to enter SMM, postpone if run is pending */
-	if (to_vmx(vcpu)->nested.nested_run_pending)
+	if (vcpu->arch.nested_run_pending)
 		return -EBUSY;
 	return !is_smm(vcpu);
 }
@@ -8304,7 +8304,7 @@ int vmx_leave_smm(struct kvm_vcpu *vcpu, const union kvm_smram *smram)
 		if (ret)
 			return ret;
 
-		vmx->nested.nested_run_pending = 1;
+		vcpu->arch.nested_run_pending = 1;
 		vmx->nested.smm.guest_mode = false;
 	}
 	return 0;
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index ea93121029f91..a6b0be1afdc37 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -144,9 +144,6 @@ struct nested_vmx {
 	 */
 	bool enlightened_vmcs_enabled;
 
-	/* L2 must run next, and mustn't decide to exit to L1. */
-	bool nested_run_pending;
-
 	/* Pending MTF VM-exit into L1.  */
 	bool mtf_pending;
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 91d38d709d8a7..69d48df5d1d89 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -146,6 +146,13 @@ bool __read_mostly report_ignored_msrs = true;
 module_param(report_ignored_msrs, bool, 0644);
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(report_ignored_msrs);
 
+#define KVM_X86_NESTED_OP(func)							\
+	DEFINE_STATIC_CALL_NULL(kvm_x86_nested_##func,				\
+				*(((struct kvm_x86_nested_ops *)0)->func));
+#define KVM_X86_NESTED_OP_OPTIONAL KVM_X86_NESTED_OP
+#define KVM_X86_NESTED_OP_OPTIONAL_RET0 KVM_X86_NESTED_OP
+#include <asm/kvm-x86-nested-ops.h>
+
 unsigned int min_timer_period_us = 200;
 module_param(min_timer_period_us, uint, 0644);
 
@@ -836,7 +843,7 @@ static void kvm_multiple_exception(struct kvm_vcpu *vcpu, unsigned int nr,
 	 * wants to intercept the exception.
 	 */
 	if (is_guest_mode(vcpu) &&
-	    kvm_x86_ops.nested_ops->is_exception_vmexit(vcpu, nr, error_code)) {
+	    kvm_nested_call(is_exception_vmexit)(vcpu, nr, error_code)) {
 		kvm_queue_exception_vmexit(vcpu, nr, has_error, error_code,
 					   has_payload, payload);
 		return;
@@ -4605,7 +4612,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		break;
 	case KVM_CAP_NESTED_STATE:
 		r = kvm_x86_ops.nested_ops->enabled ?
-			kvm_x86_ops.nested_ops->get_state(NULL, NULL, 0) : 0;
+			kvm_nested_call(get_state)(NULL, NULL, 0) : 0;
 		break;
 #ifdef CONFIG_KVM_HYPERV
 	case KVM_CAP_HYPERV_DIRECT_TLBFLUSH:
@@ -5654,7 +5661,7 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
 			if (!kvm_x86_ops.nested_ops->enabled ||
 			    !kvm_x86_ops.nested_ops->enable_evmcs)
 				return -ENOTTY;
-			r = kvm_x86_ops.nested_ops->enable_evmcs(vcpu, &vmcs_version);
+			r = kvm_nested_call(enable_evmcs)(vcpu, &vmcs_version);
 			if (!r) {
 				user_ptr = (void __user *)(uintptr_t)cap->args[0];
 				if (copy_to_user(user_ptr, &vmcs_version,
@@ -6160,8 +6167,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		if (get_user(user_data_size, &user_kvm_nested_state->size))
 			break;
 
-		r = kvm_x86_ops.nested_ops->get_state(vcpu, user_kvm_nested_state,
-						     user_data_size);
+		r = kvm_nested_call(get_state)(vcpu, user_kvm_nested_state, user_data_size);
 		if (r < 0)
 			break;
 
@@ -6205,7 +6211,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 			break;
 
 		idx = srcu_read_lock(&vcpu->kvm->srcu);
-		r = kvm_x86_ops.nested_ops->set_state(vcpu, user_kvm_nested_state, &kvm_state);
+		r = kvm_nested_call(set_state)(vcpu, user_kvm_nested_state, &kvm_state);
 		srcu_read_unlock(&vcpu->kvm->srcu, idx);
 		break;
 	}
@@ -9602,6 +9608,8 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_setup_xss_caps);
 
 static inline void kvm_ops_update(struct kvm_x86_init_ops *ops)
 {
+	const struct kvm_x86_nested_ops *nested_ops = ops->runtime_ops->nested_ops;
+
 	memcpy(&kvm_x86_ops, ops->runtime_ops, sizeof(kvm_x86_ops));
 
 #define __KVM_X86_OP(func) \
@@ -9615,6 +9623,17 @@ static inline void kvm_ops_update(struct kvm_x86_init_ops *ops)
 #include <asm/kvm-x86-ops.h>
 #undef __KVM_X86_OP
 
+#define __KVM_X86_NESTED_OP(func) \
+	static_call_update(kvm_x86_nested_##func, nested_ops->func);
+#define KVM_X86_NESTED_OP(func) \
+	WARN_ON(!nested_ops->func); __KVM_X86_NESTED_OP(func)
+#define KVM_X86_NESTED_OP_OPTIONAL __KVM_X86_NESTED_OP
+#define KVM_X86_NESTED_OP_OPTIONAL_RET0(func) \
+	static_call_update(kvm_x86_nested_##func, (void *)nested_ops->func ? : \
+						  (void *)__static_call_return0);
+#include <asm/kvm-x86-nested-ops.h>
+#undef __KVM_X86_NESTED_OP
+
 	kvm_pmu_ops_update(ops->pmu_ops);
 }
 
@@ -10157,11 +10176,11 @@ static void post_kvm_run_save(struct kvm_vcpu *vcpu)
 int kvm_check_nested_events(struct kvm_vcpu *vcpu)
 {
 	if (kvm_test_request(KVM_REQ_TRIPLE_FAULT, vcpu)) {
-		kvm_x86_ops.nested_ops->triple_fault(vcpu);
+		kvm_nested_call(triple_fault)(vcpu);
 		return 1;
 	}
 
-	return kvm_x86_ops.nested_ops->check_events(vcpu);
+	return kvm_nested_call(check_events)(vcpu);
 }
 
 static void kvm_inject_exception(struct kvm_vcpu *vcpu)
@@ -10401,9 +10420,7 @@ static int kvm_check_and_inject_events(struct kvm_vcpu *vcpu,
 			kvm_x86_call(enable_irq_window)(vcpu);
 	}
 
-	if (is_guest_mode(vcpu) &&
-	    kvm_x86_ops.nested_ops->has_events &&
-	    kvm_x86_ops.nested_ops->has_events(vcpu, true))
+	if (is_guest_mode(vcpu) && kvm_nested_call(has_events)(vcpu, true))
 		*req_immediate_exit = true;
 
 	/*
@@ -10690,7 +10707,8 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		}
 
 		if (kvm_check_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu)) {
-			if (unlikely(!kvm_x86_ops.nested_ops->get_nested_state_pages(vcpu))) {
+			if (unlikely(!kvm_nested_call(get_nested_state_pages)(vcpu))) {
+				kvm_make_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
 				r = 0;
 				goto out;
 			}
@@ -10742,7 +10760,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		}
 		if (kvm_test_request(KVM_REQ_TRIPLE_FAULT, vcpu)) {
 			if (is_guest_mode(vcpu))
-				kvm_x86_ops.nested_ops->triple_fault(vcpu);
+				kvm_nested_call(triple_fault)(vcpu);
 
 			if (kvm_check_request(KVM_REQ_TRIPLE_FAULT, vcpu)) {
 				vcpu->run->exit_reason = KVM_EXIT_SHUTDOWN;
@@ -11144,9 +11162,7 @@ bool kvm_vcpu_has_events(struct kvm_vcpu *vcpu)
 	if (kvm_hv_has_stimer_pending(vcpu))
 		return true;
 
-	if (is_guest_mode(vcpu) &&
-	    kvm_x86_ops.nested_ops->has_events &&
-	    kvm_x86_ops.nested_ops->has_events(vcpu, false))
+	if (is_guest_mode(vcpu) && kvm_nested_call(has_events)(vcpu, false))
 		return true;
 
 	if (kvm_xen_has_pending_events(vcpu))
@@ -11564,8 +11580,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 	 * a pending VM-Exit if L1 wants to intercept the exception.
 	 */
 	if (vcpu->arch.exception_from_userspace && is_guest_mode(vcpu) &&
-	    kvm_x86_ops.nested_ops->is_exception_vmexit(vcpu, ex->vector,
-							ex->error_code)) {
+	    kvm_nested_call(is_exception_vmexit)(vcpu, ex->vector, ex->error_code)) {
 		kvm_queue_exception_vmexit(vcpu, ex->vector,
 					   ex->has_error_code, ex->error_code,
 					   ex->has_payload, ex->payload);
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index f4cd73a074903..6eddad77ab7ce 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -165,7 +165,7 @@ int kvm_check_nested_events(struct kvm_vcpu *vcpu);
 /* Forcibly leave the nested mode in cases like a vCPU reset */
 static inline void kvm_leave_nested(struct kvm_vcpu *vcpu)
 {
-	kvm_x86_ops.nested_ops->leave_nested(vcpu);
+	kvm_nested_call(leave_nested)(vcpu);
 }
 
 /*
-- 
2.53.0

