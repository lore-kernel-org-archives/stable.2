Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6136B3BCD12
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 13:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790774000; cv=none; b=Wy3zQSLycUTc4BEDcgBTizobtr7DXjXF0sFYqwRB3AYyZQfalMik/VfwqcAb3EfgU9WHH9NcMmafONpcLp2ejcI5J45ZDhdbJ5vViTEo7swLHm4whgdTvF0ZXagWoh6CGESajs0fHG3rdxnHTvrbSA+NbEyG9GrnQpRvUZy1KXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790774000; c=relaxed/simple;
	bh=8MvDJv1BwTikTz1OhTQAMK/9gX2Aar5ZEvnF4MFTLMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d2qjYvtGgHJLEev4JlU9gt2MR5OUALc1JN1lVL041VpgxC932CU+oaZXKYVMK+hifk5C5IIHOs7y4KUtxe7TIFPhV/bAQBTnbLdJflMCVDnLv4aVgbv8y0n6XUHH3nNnTDPCmxa6/XD4Kp9+T5O3K/tHEewjzb0e+sQAP8jIP4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kD1kvEgY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kD1kvEgY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACD591F000FF;
	Wed, 30 Sep 2026 13:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790773983;
	bh=XHQqGmogSXrkNSTBGiwl/aFuLRU2+6R2c4J5nVOWgnQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kD1kvEgY0HbX7UDap1rMbf3ua7ycha7CZkxHcwcUqJZCyeVNpjf6vuc6TD5ZEzkIo
	 opC0lxDpAXU33bJW+iX/8Ev4Wv2i6bSD2GMsy4QLeffaob8IldToWkqgeTm4dJVPY1
	 ll90Q2PpHsxzuQ4HhuSznZ4Vy89Opj8p3dDBGZi03M1kpfBvYQj4eXxr4igdRIQiIY
	 5FeW/FOaavpLWl1lEB5px63HfsP5by1Bk2TK6zhh0LnNxhccdmipHUbKdNdprlqMGg
	 1K7WrViGMjvPCR52iNX4vVOyPIM9WqsIrZP9+KMjhI+HqyJER8wAl1RLWnXbwguJVg
	 E09ZkDOrI2KhA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 7/8] KVM: x86: Add static calls for nested virtualization ops
Date: Wed, 30 Sep 2026 09:12:54 -0400
Message-ID: <20260930131256.1728861-7-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930131256.1728861-1-sashal@kernel.org>
References: <2026092945-unzip-pluck-7c40@gregkh>
 <20260930131256.1728861-1-sashal@kernel.org>
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

Backport notes:
Preserve the stable tree's kvm_x86_vendor_init()/exit() declarations and
ignore_msrs/report_ignored_msrs module parameters at the conflicting
insertion points. Initialize nested static calls in the existing
kvm_ops_update() instead of adding kvm_nested_ops_update(), preserving the
same mandatory, optional, and return-zero hook behavior without adding a
function. Keep the get_nested_state_pages call conversion so target
10180a277549339020b08000206092c07e0bff5a applies unchanged.

Stable-dep-of: 10180a277549 ("KVM: x86: Re-pend GET_NESTED_STATE_PAGES if getting said pages fails")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/kvm-x86-nested-ops.h | 36 ++++++++++++++++
 arch/x86/include/asm/kvm_host.h           |  8 ++++
 arch/x86/kvm/hyperv.c                     |  7 ++--
 arch/x86/kvm/mmu.h                        |  5 +--
 arch/x86/kvm/mmu/paging_tmpl.h            |  2 +-
 arch/x86/kvm/x86.c                        | 50 +++++++++++++++--------
 arch/x86/kvm/x86.h                        |  2 +-
 7 files changed, 83 insertions(+), 27 deletions(-)
 create mode 100644 arch/x86/include/asm/kvm-x86-nested-ops.h

diff --git a/arch/x86/include/asm/kvm-x86-nested-ops.h b/arch/x86/include/asm/kvm-x86-nested-ops.h
new file mode 100644
index 0000000000000..4b1be5bcecaa4
--- /dev/null
+++ b/arch/x86/include/asm/kvm-x86-nested-ops.h
@@ -0,0 +1,36 @@
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
+KVM_X86_NESTED_OP(translate_nested_gpa)
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
index 559a377664743..4ce42f2acb258 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2077,6 +2077,14 @@ extern struct kvm_x86_ops kvm_x86_ops;
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
index 00915958c7e2f..ddbd35ed255ba 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2419,7 +2419,7 @@ static int kvm_hv_hypercall_complete(struct kvm_vcpu *vcpu, u64 result)
 	ret = kvm_skip_emulated_instruction(vcpu);
 
 	if (tlb_lock_count)
-		kvm_x86_ops.nested_ops->hv_inject_synthetic_vmexit_post_tlb_flush(vcpu);
+		kvm_nested_call(hv_inject_synthetic_vmexit_post_tlb_flush)(vcpu);
 
 	return ret;
 }
@@ -2800,9 +2800,8 @@ int kvm_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
 	};
 	int i, nent = ARRAY_SIZE(cpuid_entries);
 
-	if (kvm_x86_ops.nested_ops->enabled &&
-	    kvm_x86_ops.nested_ops->get_evmcs_version)
-		evmcs_ver = kvm_x86_ops.nested_ops->get_evmcs_version(vcpu);
+	if (kvm_x86_ops.nested_ops->enabled)
+		evmcs_ver = kvm_nested_call(get_evmcs_version)(vcpu);
 
 	if (cpuid->nent < nent)
 		return -E2BIG;
diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index e1bb663ebbd58..bb6e018928527 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -308,9 +308,8 @@ static inline gpa_t kvm_translate_gpa(struct kvm_vcpu *vcpu,
 {
 	if (mmu != &vcpu->arch.nested_mmu)
 		return gpa;
-	return kvm_x86_ops.nested_ops->translate_nested_gpa(vcpu, gpa, access,
-							    exception,
-							    pte_access);
+	return kvm_nested_call(translate_nested_gpa)(vcpu, gpa, access,
+						     exception, pte_access);
 }
 
 static inline bool kvm_has_mirrored_tdp(const struct kvm *kvm)
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 1ba840a73b7ac..8d2c46bc6c0fb 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -233,7 +233,7 @@ static int FNAME(update_accessed_dirty_bits)(struct kvm_vcpu *vcpu,
 				!(pte & PT_GUEST_DIRTY_MASK)) {
 			trace_kvm_mmu_set_dirty_bit(table_gfn, index, sizeof(pte));
 #if PTTYPE == PTTYPE_EPT
-			if (kvm_x86_ops.nested_ops->write_log_dirty(vcpu, addr))
+			if (kvm_nested_call(write_log_dirty)(vcpu, addr))
 				return -EINVAL;
 #endif
 			pte |= PT_GUEST_DIRTY_MASK;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 5948dc18e49aa..f96d03e4d992a 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -148,6 +148,13 @@ EXPORT_STATIC_CALL_GPL(kvm_x86_get_cs_db_l_bits);
 EXPORT_STATIC_CALL_GPL(kvm_x86_cache_reg);
 EXPORT_STATIC_CALL_GPL(kvm_x86_get_cpl);
 
+#define KVM_X86_NESTED_OP(func)							\
+	DEFINE_STATIC_CALL_NULL(kvm_x86_nested_##func,				\
+				*(((struct kvm_x86_nested_ops *)0)->func));
+#define KVM_X86_NESTED_OP_OPTIONAL KVM_X86_NESTED_OP
+#define KVM_X86_NESTED_OP_OPTIONAL_RET0 KVM_X86_NESTED_OP
+#include <asm/kvm-x86-nested-ops.h>
+
 static bool __read_mostly ignore_msrs = 0;
 module_param(ignore_msrs, bool, 0644);
 
@@ -833,7 +840,7 @@ static void kvm_multiple_exception(struct kvm_vcpu *vcpu, unsigned int nr,
 	 * wants to intercept the exception.
 	 */
 	if (is_guest_mode(vcpu) &&
-	    kvm_x86_ops.nested_ops->is_exception_vmexit(vcpu, nr, error_code)) {
+	    kvm_nested_call(is_exception_vmexit)(vcpu, nr, error_code)) {
 		kvm_queue_exception_vmexit(vcpu, nr, has_error, error_code,
 					   has_payload, payload);
 		return;
@@ -4518,7 +4525,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		break;
 	case KVM_CAP_NESTED_STATE:
 		r = kvm_x86_ops.nested_ops->enabled ?
-			kvm_x86_ops.nested_ops->get_state(NULL, NULL, 0) : 0;
+			kvm_nested_call(get_state)(NULL, NULL, 0) : 0;
 		break;
 #ifdef CONFIG_KVM_HYPERV
 	case KVM_CAP_HYPERV_DIRECT_TLBFLUSH:
@@ -5583,7 +5590,7 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
 			if (!kvm_x86_ops.nested_ops->enabled ||
 			    !kvm_x86_ops.nested_ops->enable_evmcs)
 				return -ENOTTY;
-			r = kvm_x86_ops.nested_ops->enable_evmcs(vcpu, &vmcs_version);
+			r = kvm_nested_call(enable_evmcs)(vcpu, &vmcs_version);
 			if (!r) {
 				user_ptr = (void __user *)(uintptr_t)cap->args[0];
 				if (copy_to_user(user_ptr, &vmcs_version,
@@ -6089,8 +6096,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		if (get_user(user_data_size, &user_kvm_nested_state->size))
 			break;
 
-		r = kvm_x86_ops.nested_ops->get_state(vcpu, user_kvm_nested_state,
-						     user_data_size);
+		r = kvm_nested_call(get_state)(vcpu, user_kvm_nested_state, user_data_size);
 		if (r < 0)
 			break;
 
@@ -6134,7 +6140,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 			break;
 
 		idx = srcu_read_lock(&vcpu->kvm->srcu);
-		r = kvm_x86_ops.nested_ops->set_state(vcpu, user_kvm_nested_state, &kvm_state);
+		r = kvm_nested_call(set_state)(vcpu, user_kvm_nested_state, &kvm_state);
 		srcu_read_unlock(&vcpu->kvm->srcu, idx);
 		break;
 	}
@@ -9572,6 +9578,8 @@ static void kvm_setup_efer_caps(void)
 
 static inline void kvm_ops_update(struct kvm_x86_init_ops *ops)
 {
+	const struct kvm_x86_nested_ops *nested_ops = ops->runtime_ops->nested_ops;
+
 	memcpy(&kvm_x86_ops, ops->runtime_ops, sizeof(kvm_x86_ops));
 
 #define __KVM_X86_OP(func) \
@@ -9585,6 +9593,17 @@ static inline void kvm_ops_update(struct kvm_x86_init_ops *ops)
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
 
@@ -10121,11 +10140,11 @@ static void post_kvm_run_save(struct kvm_vcpu *vcpu)
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
@@ -10363,9 +10382,7 @@ static int kvm_check_and_inject_events(struct kvm_vcpu *vcpu,
 			kvm_x86_call(enable_irq_window)(vcpu);
 	}
 
-	if (is_guest_mode(vcpu) &&
-	    kvm_x86_ops.nested_ops->has_events &&
-	    kvm_x86_ops.nested_ops->has_events(vcpu, true))
+	if (is_guest_mode(vcpu) && kvm_nested_call(has_events)(vcpu, true))
 		*req_immediate_exit = true;
 
 	/*
@@ -10688,7 +10705,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		}
 
 		if (kvm_check_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu)) {
-			if (unlikely(!kvm_x86_ops.nested_ops->get_nested_state_pages(vcpu))) {
+			if (unlikely(!kvm_nested_call(get_nested_state_pages)(vcpu))) {
 				r = 0;
 				goto out;
 			}
@@ -10740,7 +10757,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		}
 		if (kvm_test_request(KVM_REQ_TRIPLE_FAULT, vcpu)) {
 			if (is_guest_mode(vcpu))
-				kvm_x86_ops.nested_ops->triple_fault(vcpu);
+				kvm_nested_call(triple_fault)(vcpu);
 
 			if (kvm_check_request(KVM_REQ_TRIPLE_FAULT, vcpu)) {
 				vcpu->run->exit_reason = KVM_EXIT_SHUTDOWN;
@@ -11160,9 +11177,7 @@ bool kvm_vcpu_has_events(struct kvm_vcpu *vcpu)
 	if (kvm_hv_has_stimer_pending(vcpu))
 		return true;
 
-	if (is_guest_mode(vcpu) &&
-	    kvm_x86_ops.nested_ops->has_events &&
-	    kvm_x86_ops.nested_ops->has_events(vcpu, false))
+	if (is_guest_mode(vcpu) && kvm_nested_call(has_events)(vcpu, false))
 		return true;
 
 	if (kvm_xen_has_pending_events(vcpu))
@@ -11587,8 +11602,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
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
index bd2699bd3fe85..9973f905955a7 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -151,7 +151,7 @@ int kvm_check_nested_events(struct kvm_vcpu *vcpu);
 /* Forcibly leave the nested mode in cases like a vCPU reset */
 static inline void kvm_leave_nested(struct kvm_vcpu *vcpu)
 {
-	kvm_x86_ops.nested_ops->leave_nested(vcpu);
+	kvm_nested_call(leave_nested)(vcpu);
 }
 
 /*
-- 
2.53.0

