Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507BE2DB79F
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 19:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790795720; cv=none; b=ZUwYw+yFJ4xl7U55kogH+P179F8kzT5aBpfLJWkNyV7zXzSTBEYtk5T9FbsQ7VB1sOa8nkL/iCJDBWyIoc2vXqdxx7Teec+PYryRJ2RbR2T9vvsGqZstBGvKg7S9Ao/6remiuLf5VHhDejJ00WnlrMXGu2NnmoZzOCPZTn7WRE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790795720; c=relaxed/simple;
	bh=NaOgqPImV0eZSYevTVzGA9yUMG1hWB0ql5fWm9qLoA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s5NNzsaXNAXuGpkGadtx8C0+5mJAbdGSAdlw8QNxhPKS2n7HK5Dzl6eV4bmcRXn00VyJ2MtYgM+kxSllgGjeJpZNatTXcKbFPmiWeltWVouhkWiA8H192WQ4nUziXZEkxhSv5Xf3boAGxCtF8TcinQlfHz+cBfl5FJysfp4RrmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IEPv12Rw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IEPv12Rw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CB7D1F00899;
	Wed, 30 Sep 2026 19:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790795719;
	bh=5pWVdeHPQI8czoXmWlNc1KqJXRJvyvDKY/lxLI9ilb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IEPv12RwJ4Hjftmvpo30vddbbRH+XBc/5fS5fvuFyHE79KjOfzzSyZLyffbC1jxFO
	 gZYRdFlIo1bKLXSIsSiS9T13Hy/+AcqQZ4T2JoloePgFQMlqFqc1vfJhfvDp8ya5My
	 Hthy9N6zMg4exFFS8ECSi1BIpy0j8BzOzq57D5fL0nDMIR8L6p7Abx8JQscc5zZ2js
	 XkB9fgFahDb9zmtSV/ndSwoMIoPQRNrqXdcoJoqU0MVfLFtyZJaz68+jzIX02IAoqM
	 mWXAbRXJGxjLNR2RTjL5Xazemo1YUE1R0s+Oaj5TNfxMT9Pln9Nf9z+0CvndBz/3Ih
	 OdSlEqBcYnyJg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] KVM: x86: Reject nested CAP enablement if nested virtualization is disabled
Date: Wed, 30 Sep 2026 15:15:15 -0400
Message-ID: <20260930191516.523922-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930191516.523922-1-sashal@kernel.org>
References: <2026092946-smitten-oversleep-efa6@gregkh>
 <20260930191516.523922-1-sashal@kernel.org>
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

Backport notes:
- Keep the stable branch's function-scope locals and switch-case layout in
  kvm_vcpu_ioctl_enable_cap(), adding the nested enablement guard in place.
- Define kvm_nested_call() using the existing indirect nested_ops dispatch
  and convert only the get_nested_state_pages call site.  This prepares the
  exact context needed by 10180a277549 without importing the nested static
  call refactor or adding any functions.  The target's request re-pending
  change is deliberately left for the target commit.

Stable-dep-of: 10180a277549 ("KVM: x86: Re-pend GET_NESTED_STATE_PAGES if getting said pages fails")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/kvm_host.h |  5 +++++
 arch/x86/kvm/hyperv.c           |  3 ++-
 arch/x86/kvm/svm/svm.c          |  1 +
 arch/x86/kvm/vmx/vmx.c          |  1 +
 arch/x86/kvm/x86.c              | 14 ++++++++------
 5 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 9b32566f91929..f9e3e65314c47 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1767,6 +1767,8 @@ struct kvm_x86_ops {
 };
 
 struct kvm_x86_nested_ops {
+	bool enabled;
+
 	void (*leave_nested)(struct kvm_vcpu *vcpu);
 	bool (*is_exception_vmexit)(struct kvm_vcpu *vcpu, u8 vector,
 				    u32 error_code);
@@ -1815,6 +1817,9 @@ extern struct kvm_x86_ops kvm_x86_ops;
 #define KVM_X86_OP_OPTIONAL_RET0 KVM_X86_OP
 #include <asm/kvm-x86-ops.h>
 
+/* Keep nested calls indirect on this stable branch. */
+#define kvm_nested_call(func) (kvm_x86_ops.nested_ops->func)
+
 int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops);
 void kvm_x86_vendor_exit(void);
 
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index d29cb592e7033..c09a7b5389b08 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2747,7 +2747,8 @@ int kvm_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
 	};
 	int i, nent = ARRAY_SIZE(cpuid_entries);
 
-	if (kvm_x86_ops.nested_ops->get_evmcs_version)
+	if (kvm_x86_ops.nested_ops->enabled &&
+	    kvm_x86_ops.nested_ops->get_evmcs_version)
 		evmcs_ver = kvm_x86_ops.nested_ops->get_evmcs_version(vcpu);
 
 	if (cpuid->nent < nent)
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 62c7e57530216..d2750de68e823 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5341,6 +5341,7 @@ static __init int svm_hardware_setup(void)
 		pr_info("Nested Virtualization enabled\n");
 		kvm_enable_efer_bits(EFER_SVME | EFER_LMSLE);
 	}
+	svm_nested_ops.enabled = nested;
 
 	/*
 	 * KVM's MMU doesn't support using 2-level paging for itself, and thus
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 9dec38b9b7615..43a330e8cd368 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -8671,6 +8671,7 @@ static __init int hardware_setup(void)
 		if (r)
 			return r;
 	}
+	vmx_nested_ops.enabled = nested;
 
 	vmx_set_cpu_caps();
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 313fce77e0589..a7349e29d2d23 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4599,14 +4599,15 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		r = KVM_X2APIC_API_VALID_FLAGS;
 		break;
 	case KVM_CAP_NESTED_STATE:
-		r = kvm_x86_ops.nested_ops->get_state ?
+		r = kvm_x86_ops.nested_ops->enabled ?
 			kvm_x86_ops.nested_ops->get_state(NULL, NULL, 0) : 0;
 		break;
 	case KVM_CAP_HYPERV_DIRECT_TLBFLUSH:
 		r = kvm_x86_ops.enable_l2_tlb_flush != NULL;
 		break;
 	case KVM_CAP_HYPERV_ENLIGHTENED_VMCS:
-		r = kvm_x86_ops.nested_ops->enable_evmcs != NULL;
+		r = kvm_x86_ops.nested_ops->enabled &&
+		    kvm_x86_ops.nested_ops->enable_evmcs != NULL;
 		break;
 	case KVM_CAP_SMALLER_MAXPHYADDR:
 		r = (int) allow_smaller_maxphyaddr;
@@ -5642,7 +5643,8 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
 		return kvm_hv_activate_synic(vcpu, cap->cap ==
 					     KVM_CAP_HYPERV_SYNIC2);
 	case KVM_CAP_HYPERV_ENLIGHTENED_VMCS:
-		if (!kvm_x86_ops.nested_ops->enable_evmcs)
+		if (!kvm_x86_ops.nested_ops->enabled ||
+		    !kvm_x86_ops.nested_ops->enable_evmcs)
 			return -ENOTTY;
 		r = kvm_x86_ops.nested_ops->enable_evmcs(vcpu, &vmcs_version);
 		if (!r) {
@@ -5997,7 +5999,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		u32 user_data_size;
 
 		r = -EINVAL;
-		if (!kvm_x86_ops.nested_ops->get_state)
+		if (!kvm_x86_ops.nested_ops->enabled)
 			break;
 
 		BUILD_BUG_ON(sizeof(user_data_size) != sizeof(user_kvm_nested_state->size));
@@ -6027,7 +6029,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		int idx;
 
 		r = -EINVAL;
-		if (!kvm_x86_ops.nested_ops->set_state)
+		if (!kvm_x86_ops.nested_ops->enabled)
 			break;
 
 		r = -EFAULT;
@@ -10600,7 +10602,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		}
 
 		if (kvm_check_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu)) {
-			if (unlikely(!kvm_x86_ops.nested_ops->get_nested_state_pages(vcpu))) {
+			if (unlikely(!kvm_nested_call(get_nested_state_pages)(vcpu))) {
 				r = 0;
 				goto out;
 			}
-- 
2.53.0

