Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D4D4D98EB
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 15:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790781017; cv=none; b=bZbeEjvaAtw3ZY6o8OxA34gs+8jEQc4CK2VTMj6w9FYPXKaNv1VAz/PesgEuZ6ZUGR06E9qi7CE72sdqEhNNpJFnlR1CwxPoluMu+sCfFoO9gp9AIf72L3g8GvYYkt8XH+qiUYYrD6L1O3ru+n7HnRjsw0Ak2d7T2zpGB8waovw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790781017; c=relaxed/simple;
	bh=rCTMeZ9W5dpY/+fihrO44FKW6zIeLUiBFdASSrqqAt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tc9IZT1bEUW79RJcqIBV3szFWlJikbxri2Ce5FzS4UK6I57bQEfX5KGVqHjEB+CLGs7UcW24i2bhbzFq1I3Rmw9b7K4fhfFi1OmI5kG6ZfnpKiUDYCCb3sASCllvuAI2XP2xvscesMDzA36LwaRpG5dHMa0GpUtfW6ITMme4jUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OWK1aLLO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OWK1aLLO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34E021F0089A;
	Wed, 30 Sep 2026 15:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790781001;
	bh=IutPqpdQbTU1oZ84b1X+uyTJaE353dHofQ8hR/eir9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OWK1aLLOAdbQ5+pUIQOzxfS5RIlfzGQhu6KqirhWda+/jlhtgwJsta+3DEOMCEM+A
	 CXtAiSTqmH4ufsgs9eE3D/zkUDu/qVEtYgGvZTCi26WUqegcz5s4zM4JOfkqDvjLhP
	 fldZ0E7tnbLLq8frb3esWkYEGmMnUPCde0yT/Y189iu1z9PNcd03JuEllr9UXbqMIv
	 3gEBf14dYmOvaRRFIgx/HXUScWV92SMJeX21K2hiBsmx2bFnku065ODfR2RsuVG/2P
	 QytIoxzWr6FSvW8ZcnOM2p1s03gmBqlxzUG+M7FDjNl3Jn9WAhKG8gEPJ0jWsQUJmM
	 vncfCdCrEqEag==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 4/5] KVM: x86: Add static calls for nested virtualization ops
Date: Wed, 30 Sep 2026 11:09:56 -0400
Message-ID: <20260930150957.2359214-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930150957.2359214-1-sashal@kernel.org>
References: <2026092945-breath-candle-8e2c@gregkh>
 <20260930150957.2359214-1-sashal@kernel.org>
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

[ Backport to 6.18: retain the vendor init/exit declarations and the
  existing direct translate_nested_gpa() implementation.  Omit the
  translate_nested_gpa static-call entry because this tree has no such
  nested-ops member.  Initialize the nested static calls inside the
  existing kvm_ops_update() instead of adding a helper function; do not
  import the unrelated kvm_setup_efer_caps() context.  This preserves
  the get_nested_state_pages call site required by 10180a277549. ]

[ sashal: Reduced backport -- upstream 4b9819a50674d touches 7 file(s), this
  backport carries 6. Not backported here:
  arch/x86/kvm/mmu.h
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 10180a277549 ("KVM: x86: Re-pend GET_NESTED_STATE_PAGES if getting said pages fails")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/kvm-x86-nested-ops.h | 35 ++++++++++++++++
 arch/x86/include/asm/kvm_host.h           |  8 ++++
 arch/x86/kvm/hyperv.c                     |  7 ++--
 arch/x86/kvm/mmu/paging_tmpl.h            |  2 +-
 arch/x86/kvm/x86.c                        | 50 +++++++++++++++--------
 arch/x86/kvm/x86.h                        |  2 +-
 6 files changed, 80 insertions(+), 24 deletions(-)
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
index 20df39a5318f2..b2cf3431e2598 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2009,6 +2009,14 @@ extern struct kvm_x86_ops kvm_x86_ops;
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
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 91d38d709d8a7..2ada9af819a58 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -139,6 +139,13 @@ struct kvm_x86_ops kvm_x86_ops __read_mostly;
 EXPORT_STATIC_CALL_GPL(kvm_x86_get_cs_db_l_bits);
 EXPORT_STATIC_CALL_GPL(kvm_x86_cache_reg);
 
+#define KVM_X86_NESTED_OP(func)							\
+	DEFINE_STATIC_CALL_NULL(kvm_x86_nested_##func,				\
+				*(((struct kvm_x86_nested_ops *)0)->func));
+#define KVM_X86_NESTED_OP_OPTIONAL KVM_X86_NESTED_OP
+#define KVM_X86_NESTED_OP_OPTIONAL_RET0 KVM_X86_NESTED_OP
+#include <asm/kvm-x86-nested-ops.h>
+
 static bool __read_mostly ignore_msrs = 0;
 module_param(ignore_msrs, bool, 0644);
 
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
@@ -10690,7 +10707,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		}
 
 		if (kvm_check_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu)) {
-			if (unlikely(!kvm_x86_ops.nested_ops->get_nested_state_pages(vcpu))) {
+			if (unlikely(!kvm_nested_call(get_nested_state_pages)(vcpu))) {
 				r = 0;
 				goto out;
 			}
@@ -10742,7 +10759,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		}
 		if (kvm_test_request(KVM_REQ_TRIPLE_FAULT, vcpu)) {
 			if (is_guest_mode(vcpu))
-				kvm_x86_ops.nested_ops->triple_fault(vcpu);
+				kvm_nested_call(triple_fault)(vcpu);
 
 			if (kvm_check_request(KVM_REQ_TRIPLE_FAULT, vcpu)) {
 				vcpu->run->exit_reason = KVM_EXIT_SHUTDOWN;
@@ -11144,9 +11161,7 @@ bool kvm_vcpu_has_events(struct kvm_vcpu *vcpu)
 	if (kvm_hv_has_stimer_pending(vcpu))
 		return true;
 
-	if (is_guest_mode(vcpu) &&
-	    kvm_x86_ops.nested_ops->has_events &&
-	    kvm_x86_ops.nested_ops->has_events(vcpu, false))
+	if (is_guest_mode(vcpu) && kvm_nested_call(has_events)(vcpu, false))
 		return true;
 
 	if (kvm_xen_has_pending_events(vcpu))
@@ -11564,8 +11579,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
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

