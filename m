Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EBF51DE1B
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 17:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790789652; cv=none; b=LdJxrLOdCGdVzi9YP3zgADtW8TTW/8SE0+iISFNeCJUCmLJgZbHVfhramTzXdFnFpD/Ms7kqeV4GCJuufsopJoyhBR13UkoBSTPJ4Ci1GUXG5CgHnh+6ANcCrt4YQt9kWmSlYNW0QCamvvSVe3Knhkmga8DtKd6lU/UqsIbXk0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790789652; c=relaxed/simple;
	bh=Rj2FEF7huHj2eWpHZcvNvLL5PgLvZovslYy5rCU9Enk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qOhvkRioZEz5qillBVE8bXNp0+DdV0rBumcMy2kpHeMbNDD1ZLpTg547XR1W891SJ+jGQCvdXELQvQA1EwxeUPg7M/ek4yerjOtsDZbAPBQs5iq1+07CBGa55bEc6lMWxzDJeYPIhbSkJtVa1S4Y16A7eYKbvPJAzMOn8F/kfGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWnl/ivM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWnl/ivM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C30AC1F0089B;
	Wed, 30 Sep 2026 17:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790789650;
	bh=8X5wJOyN1tqZRHaRlNUfrTs4mBwGJzEdvBT9sN2xlY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PWnl/ivMe7XC3wsshccIqTVNP/PTdJlvFuH0WCS8A3IVwuvUMcxR9u5PP6J3CO1wE
	 qeFxZcYJKoQ6TeWwK8iHcRl2sGtMcQ0vPtOql/AkqNLrLm6DpX/9Fa1qiPfwVGc5JC
	 O6qNFjkkXzqok976O00hRIycYRqmlmUOzwMQFYi5AL6VdwijumL5DzdBZlf5Z1BrLs
	 sz0APHo3h/1ChWFr+FUKL2SAnmzUxZwCFROE5jKST2s7L+P4d5XnsDn66JZ/e4e53u
	 j5pM4SjxQ46iesKQaLIIJpUxu5GBl+YW5sz0t1KGKZUnfFBKLYDz80FFlkZqxDK9mS
	 tu20kvD5+TKjA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/5] KVM: x86: Add static calls for nested virtualization ops
Date: Wed, 30 Sep 2026 13:34:04 -0400
Message-ID: <20260930173405.3642305-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930173405.3642305-1-sashal@kernel.org>
References: <2026092946-ahoy-spring-2e69@gregkh>
 <20260930173405.3642305-1-sashal@kernel.org>
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

Adapt the static-call conversion to the 6.12 interfaces.  Keep the
existing kvm_x86_vendor_init()/exit() declarations and the !reinject
exception-interception guard.  Leave mmu.h unchanged and omit the
translate_nested_gpa static call, since this tree uses a direct MMU
helper rather than a nested-ops hook.

Initialize the nested static calls inside the existing kvm_ops_update()
instead of adding kvm_nested_ops_update().  Do not import the newer XSS,
EFER, or mirrored-TDP helpers from the conflict context.  No functions
are added.

This retains the get_nested_state_pages static-call site expected by
10180a277549, allowing that fix to apply without modification.

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
index 07ec92c9b8a4d..29a7335ad2049 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1905,6 +1905,14 @@ extern struct kvm_x86_ops kvm_x86_ops;
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
index 58807c3b60fa1..d394d0575c167 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2414,7 +2414,7 @@ static int kvm_hv_hypercall_complete(struct kvm_vcpu *vcpu, u64 result)
 	ret = kvm_skip_emulated_instruction(vcpu);
 
 	if (tlb_lock_count)
-		kvm_x86_ops.nested_ops->hv_inject_synthetic_vmexit_post_tlb_flush(vcpu);
+		kvm_nested_call(hv_inject_synthetic_vmexit_post_tlb_flush)(vcpu);
 
 	return ret;
 }
@@ -2798,9 +2798,8 @@ int kvm_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
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
index ce467bc3383c9..2566fc9937a06 100644
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
index 6e3261b98403d..3de85c103637c 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -157,6 +157,13 @@ bool __read_mostly report_ignored_msrs = true;
 module_param(report_ignored_msrs, bool, 0644);
 EXPORT_SYMBOL_GPL(report_ignored_msrs);
 
+#define KVM_X86_NESTED_OP(func)							\
+	DEFINE_STATIC_CALL_NULL(kvm_x86_nested_##func,				\
+				*(((struct kvm_x86_nested_ops *)0)->func));
+#define KVM_X86_NESTED_OP_OPTIONAL KVM_X86_NESTED_OP
+#define KVM_X86_NESTED_OP_OPTIONAL_RET0 KVM_X86_NESTED_OP
+#include <asm/kvm-x86-nested-ops.h>
+
 unsigned int min_timer_period_us = 200;
 module_param(min_timer_period_us, uint, 0644);
 
@@ -840,7 +847,7 @@ static void kvm_multiple_exception(struct kvm_vcpu *vcpu,
 	 * injected the exception, in which case it's exempt from interception.
 	 */
 	if (!reinject && is_guest_mode(vcpu) &&
-	    kvm_x86_ops.nested_ops->is_exception_vmexit(vcpu, nr, error_code)) {
+	    kvm_nested_call(is_exception_vmexit)(vcpu, nr, error_code)) {
 		kvm_queue_exception_vmexit(vcpu, nr, has_error, error_code,
 					   has_payload, payload);
 		return;
@@ -4765,7 +4772,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		break;
 	case KVM_CAP_NESTED_STATE:
 		r = kvm_x86_ops.nested_ops->enabled ?
-			kvm_x86_ops.nested_ops->get_state(NULL, NULL, 0) : 0;
+			kvm_nested_call(get_state)(NULL, NULL, 0) : 0;
 		break;
 #ifdef CONFIG_KVM_HYPERV
 	case KVM_CAP_HYPERV_DIRECT_TLBFLUSH:
@@ -5850,7 +5857,7 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
 			if (!kvm_x86_ops.nested_ops->enabled ||
 			    !kvm_x86_ops.nested_ops->enable_evmcs)
 				return -ENOTTY;
-			r = kvm_x86_ops.nested_ops->enable_evmcs(vcpu, &vmcs_version);
+			r = kvm_nested_call(enable_evmcs)(vcpu, &vmcs_version);
 			if (!r) {
 				user_ptr = (void __user *)(uintptr_t)cap->args[0];
 				if (copy_to_user(user_ptr, &vmcs_version,
@@ -6220,8 +6227,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		if (get_user(user_data_size, &user_kvm_nested_state->size))
 			break;
 
-		r = kvm_x86_ops.nested_ops->get_state(vcpu, user_kvm_nested_state,
-						     user_data_size);
+		r = kvm_nested_call(get_state)(vcpu, user_kvm_nested_state, user_data_size);
 		if (r < 0)
 			break;
 
@@ -6265,7 +6271,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 			break;
 
 		idx = srcu_read_lock(&vcpu->kvm->srcu);
-		r = kvm_x86_ops.nested_ops->set_state(vcpu, user_kvm_nested_state, &kvm_state);
+		r = kvm_nested_call(set_state)(vcpu, user_kvm_nested_state, &kvm_state);
 		srcu_read_unlock(&vcpu->kvm->srcu, idx);
 		break;
 	}
@@ -9702,6 +9708,8 @@ static struct notifier_block pvclock_gtod_notifier = {
 
 static inline void kvm_ops_update(struct kvm_x86_init_ops *ops)
 {
+	const struct kvm_x86_nested_ops *nested_ops = ops->runtime_ops->nested_ops;
+
 	memcpy(&kvm_x86_ops, ops->runtime_ops, sizeof(kvm_x86_ops));
 
 #define __KVM_X86_OP(func) \
@@ -9715,6 +9723,17 @@ static inline void kvm_ops_update(struct kvm_x86_init_ops *ops)
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
 
@@ -10279,11 +10298,11 @@ static void update_cr8_intercept(struct kvm_vcpu *vcpu)
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
@@ -10523,9 +10542,7 @@ static int kvm_check_and_inject_events(struct kvm_vcpu *vcpu,
 			kvm_x86_call(enable_irq_window)(vcpu);
 	}
 
-	if (is_guest_mode(vcpu) &&
-	    kvm_x86_ops.nested_ops->has_events &&
-	    kvm_x86_ops.nested_ops->has_events(vcpu, true))
+	if (is_guest_mode(vcpu) && kvm_nested_call(has_events)(vcpu, true))
 		*req_immediate_exit = true;
 
 	/*
@@ -10809,7 +10826,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		}
 
 		if (kvm_check_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu)) {
-			if (unlikely(!kvm_x86_ops.nested_ops->get_nested_state_pages(vcpu))) {
+			if (unlikely(!kvm_nested_call(get_nested_state_pages)(vcpu))) {
 				r = 0;
 				goto out;
 			}
@@ -10861,7 +10878,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		}
 		if (kvm_test_request(KVM_REQ_TRIPLE_FAULT, vcpu)) {
 			if (is_guest_mode(vcpu))
-				kvm_x86_ops.nested_ops->triple_fault(vcpu);
+				kvm_nested_call(triple_fault)(vcpu);
 
 			if (kvm_check_request(KVM_REQ_TRIPLE_FAULT, vcpu)) {
 				vcpu->run->exit_reason = KVM_EXIT_SHUTDOWN;
@@ -11262,9 +11279,7 @@ static bool kvm_vcpu_has_events(struct kvm_vcpu *vcpu)
 	if (kvm_hv_has_stimer_pending(vcpu))
 		return true;
 
-	if (is_guest_mode(vcpu) &&
-	    kvm_x86_ops.nested_ops->has_events &&
-	    kvm_x86_ops.nested_ops->has_events(vcpu, false))
+	if (is_guest_mode(vcpu) && kvm_nested_call(has_events)(vcpu, false))
 		return true;
 
 	if (kvm_xen_has_pending_events(vcpu))
@@ -11661,8 +11676,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
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
index 69145d116aa09..0b9762f550739 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -116,7 +116,7 @@ int kvm_check_nested_events(struct kvm_vcpu *vcpu);
 /* Forcibly leave the nested mode in cases like a vCPU reset */
 static inline void kvm_leave_nested(struct kvm_vcpu *vcpu)
 {
-	kvm_x86_ops.nested_ops->leave_nested(vcpu);
+	kvm_nested_call(leave_nested)(vcpu);
 }
 
 static inline bool kvm_vcpu_has_run(struct kvm_vcpu *vcpu)
-- 
2.53.0

