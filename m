Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D2837204A
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 01:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790817993; cv=none; b=Q4aQWlHLxoiUTyRWa/nhRvGKfh4DB9nUd6hD0AuF4T8aV7pc4UnEpVwNPvvb6kiccho1Fq8Tvz3Z33gOGwwlqlIMciyUVnMvHAdUyGKURb0XG3yfO6Qx8YY2TkTfxeel57/nKlzCPKthCke+4IVy1F4q7wRSxc03VrhLtA0jPHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790817993; c=relaxed/simple;
	bh=JAQSOENBOZsa6y1YxpdLUsQJkUI0QnK+AcTyTqhh/UI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QzLA1uhqA/K0ePH5CQK6v/8CnGUHqt+i/DUiI0UHZ3PfDgtXIw74H2MV5gtnogbyI2W8tt7Gx1QwVFr13NpbJ/dYTk1ycQ4f6ZeqvSGweJo/msing0ZQcPMt6ieXpH+53RWR4jTLQKlcNWoFW3KXJzxgPEqnQxTaud4XNRPWbeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wznqioo6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wznqioo6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A9581F000FF;
	Thu,  1 Oct 2026 01:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790817989;
	bh=1lISGARteZnjmTyPO44T10ChinSpiTniN54RNQEcZ3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wznqioo6Gcj+5BVvTg1riZJIrDBKU6nHcBHAWrSB+GXxpkqMEIgyHK4H/1UrCIZuO
	 DZGI58a9xCyQpBVA02wF/5rfOasXeXfY/tyJcJkzjReyhdrL8AIEQJOjXVav4W218y
	 CJsllZuXQRy/vP0O4k3LN2oOpOBcfPJ8amRZoLCHACtwEDy2y1qIjCujNNvZvMiy5j
	 szZGtGipe34/NDVyR/eBE9NWJS0IPCsEEeEbCJa4j+UP9q/SwNiUoyTb8N6mErNa7Y
	 cob+LwAvG2r0cOQqgnXMojfd/eYh6c6LuoMulQvkkrBVqnUW+adgpDaSFeqpeXJ0p0
	 Y8BTiem9tiTxQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] KVM: x86: Reject nested CAP enablement if nested virtualization is disabled
Date: Wed, 30 Sep 2026 21:26:25 -0400
Message-ID: <20261001012626.2843086-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092947-navigator-fastness-f0da@gregkh>
References: <2026092947-navigator-fastness-f0da@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit b65699be2c606d2687593516d93e66d16a713b61 ]

Add a flag to explicitly track if nested virtualization is enabled, and use
it enumerate that various nested CAPs are unsupported, and to reject
enablement of said CAPs.  When the nested ops hooks were moved to their
own structure, KVM's NULL-by-default behavior was deliberately dropped,
with the changelog asserting that all was well.  That wasn't quite true;
there is no danger to KVM, but now KVM is over-reporting support for
KVM_CAP_NESTED_STATE and KVM_CAP_HYPERV_ENLIGHTENED_VMCS.

Fixes: 33b22172452f ("KVM: x86: move nested-related kvm_x86_ops to a separate struct")
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Link: https://patch.msgid.link/20260630202828.440724-2-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>

Stable adaptation for 5.10:
Keep the existing SVM hardware setup and Hyper-V capability handler layout,
placing the enabled flag assignment and capability guard in their existing
functions.  Retain all of the upstream capability and nested-state checks.

Provide kvm_nested_call() as a macro for the existing indirect nested-op
call and use it for get_nested_state_pages(), preserving runtime behavior.
Match the surrounding patch context so that 10180a277549 ("KVM: x86: Re-pend
GET_NESTED_STATE_PAGES if getting said pages fails") applies unchanged.
This avoids importing the static-call conversion and adds no functions.
The target's request re-pending change is left to the target commit.

Stable-dep-of: 10180a277549 ("KVM: x86: Re-pend GET_NESTED_STATE_PAGES if getting said pages fails")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/kvm_host.h |  4 ++++
 arch/x86/kvm/hyperv.c           |  3 ++-
 arch/x86/kvm/svm/svm.c          |  1 +
 arch/x86/kvm/vmx/vmx.c          |  1 +
 arch/x86/kvm/x86.c              | 15 +++++++++------
 5 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index d13db9173603e..35d934d04fa80 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1291,6 +1291,8 @@ struct kvm_x86_ops {
 };
 
 struct kvm_x86_nested_ops {
+	bool enabled;
+
 	void (*leave_nested)(struct kvm_vcpu *vcpu);
 	int (*check_events)(struct kvm_vcpu *vcpu);
 	bool (*hv_timer_pending)(struct kvm_vcpu *vcpu);
@@ -1329,6 +1331,8 @@ extern u64 __read_mostly host_efer;
 extern bool __read_mostly allow_smaller_maxphyaddr;
 extern struct kvm_x86_ops kvm_x86_ops;
 
+#define kvm_nested_call(func) (kvm_x86_ops.nested_ops->func)
+
 #define __KVM_HAVE_ARCH_VM_ALLOC
 static inline struct kvm *kvm_arch_alloc_vm(void)
 {
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index af62279a560b2..efbf43f224048 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1997,7 +1997,8 @@ int kvm_vcpu_ioctl_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
 	};
 	int i, nent = ARRAY_SIZE(cpuid_entries);
 
-	if (kvm_x86_ops.nested_ops->get_evmcs_version)
+	if (kvm_x86_ops.nested_ops->enabled &&
+	    kvm_x86_ops.nested_ops->get_evmcs_version)
 		evmcs_ver = kvm_x86_ops.nested_ops->get_evmcs_version(vcpu);
 
 	/* Skip NESTED_FEATURES if eVMCS is not supported */
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 97783bf50a3f3..62acd803294b5 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -957,6 +957,7 @@ static __init int svm_hardware_setup(void)
 		printk(KERN_INFO "kvm: Nested Virtualization enabled\n");
 		kvm_enable_efer_bits(EFER_SVME | EFER_LMSLE);
 	}
+	svm_nested_ops.enabled = nested;
 
 	if (sev) {
 		if (boot_cpu_has(X86_FEATURE_SEV) &&
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 0fb9cdc012124..12e3f4e001370 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -8093,6 +8093,7 @@ static __init int hardware_setup(void)
 		if (r)
 			return r;
 	}
+	vmx_nested_ops.enabled = nested;
 
 	vmx_set_cpu_caps();
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 1b8860a1c7c28..2045462640114 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3928,14 +3928,15 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		r = KVM_X2APIC_API_VALID_FLAGS;
 		break;
 	case KVM_CAP_NESTED_STATE:
-		r = kvm_x86_ops.nested_ops->get_state ?
+		r = kvm_x86_ops.nested_ops->enabled ?
 			kvm_x86_ops.nested_ops->get_state(NULL, NULL, 0) : 0;
 		break;
 	case KVM_CAP_HYPERV_DIRECT_TLBFLUSH:
 		r = kvm_x86_ops.enable_direct_tlbflush != NULL;
 		break;
 	case KVM_CAP_HYPERV_ENLIGHTENED_VMCS:
-		r = kvm_x86_ops.nested_ops->enable_evmcs != NULL;
+		r = kvm_x86_ops.nested_ops->enabled &&
+		    kvm_x86_ops.nested_ops->enable_evmcs != NULL;
 		break;
 	case KVM_CAP_SMALLER_MAXPHYADDR:
 		r = (int) allow_smaller_maxphyaddr;
@@ -4760,7 +4761,8 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
 		return kvm_hv_activate_synic(vcpu, cap->cap ==
 					     KVM_CAP_HYPERV_SYNIC2);
 	case KVM_CAP_HYPERV_ENLIGHTENED_VMCS:
-		if (!kvm_x86_ops.nested_ops->enable_evmcs)
+		if (!kvm_x86_ops.nested_ops->enabled ||
+		    !kvm_x86_ops.nested_ops->enable_evmcs)
 			return -ENOTTY;
 		r = kvm_x86_ops.nested_ops->enable_evmcs(vcpu, &vmcs_version);
 		if (!r) {
@@ -5085,7 +5087,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		u32 user_data_size;
 
 		r = -EINVAL;
-		if (!kvm_x86_ops.nested_ops->get_state)
+		if (!kvm_x86_ops.nested_ops->enabled)
 			break;
 
 		BUILD_BUG_ON(sizeof(user_data_size) != sizeof(user_kvm_nested_state->size));
@@ -5115,7 +5117,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		int idx;
 
 		r = -EINVAL;
-		if (!kvm_x86_ops.nested_ops->set_state)
+		if (!kvm_x86_ops.nested_ops->enabled)
 			break;
 
 		r = -EFAULT;
@@ -9108,8 +9110,9 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 	bool req_immediate_exit = false;
 
 	if (kvm_request_pending(vcpu)) {
+
 		if (kvm_check_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu)) {
-			if (unlikely(!kvm_x86_ops.nested_ops->get_nested_state_pages(vcpu))) {
+			if (unlikely(!kvm_nested_call(get_nested_state_pages)(vcpu))) {
 				r = 0;
 				goto out;
 			}
-- 
2.53.0

