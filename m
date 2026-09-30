Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A500E51DE10
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 17:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790789651; cv=none; b=D2MIfsSvDVM4f1EQ3zQ55RU5MVdeVwXcFnWr54Xq0FcA4UT9ucySaScMWOTVQa8mohB+2QsG2VwXQktq5ghEI9TamKCb7CEjccHTRAA1U2Ln3OCEbzaM8tuoK05LBIEwTXLpnx6PLtR8Af2aHsoqotJ322tS7Gc+y+q2RQkwweY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790789651; c=relaxed/simple;
	bh=WpyV4ZGdjI8c41xVDNJE0+hOqcnwbxmLTbiF4rYEDa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fptpqN+AGQVvmMPP2g/uaJKCq8uRiWMWz3hSs9plyRr7iCvkrG9aIsThM4zJNXyHpNDYjPVPUmyPfX5fuNWwezJicfTrxlV9Wn1CV461mxhiq1WOH11pLroEouc2p6/AbMuUZhpV3fcINmxBeaqrND6iyAukapTBlhiVINJrMl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EaOrZJGe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EaOrZJGe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 121C81F0089A;
	Wed, 30 Sep 2026 17:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790789649;
	bh=lLF7u4LjulFXmynW2x5B7oZYAd11/tDzlFDvIgzLT8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EaOrZJGewcasvWBoNT2Y3m2NEAWzll51BF75bJJ5Qc/5IngS7UUG+RSHVGqrM2YVN
	 0C7257GXJICv3GBcv76aL3jxc3cT7becHQa6cVj2Id+kcsf7tnsiiGXJH9RSClnlwt
	 ZD4Gwsol5QFwzi8R7D3g/W1zShhqouno5YLxMuqJVu8D2BxRYIE3JKfDpV/y+jP15L
	 qkQL/T75+vKs25ddtoHvrPaEzmYnQo5pXKcjeGUpbpvtW7mVlFO2j/9PQe+RHuk7kH
	 EKbVWCLwfxCPM5y5gJ+F9Jp4Clk1qiO6cUm2qa9lttIYC+8GzJB37nY13grGpbST+0
	 HBzmt4DjQJ7Pg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/5] KVM: x86: Reject nested CAP enablement if nested virtualization is disabled
Date: Wed, 30 Sep 2026 13:34:03 -0400
Message-ID: <20260930173405.3642305-3-sashal@kernel.org>
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
Stable-dep-of: 10180a277549 ("KVM: x86: Re-pend GET_NESTED_STATE_PAGES if getting said pages fails")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/kvm_host.h |  2 ++
 arch/x86/kvm/hyperv.c           |  3 ++-
 arch/x86/kvm/svm/svm.c          |  1 +
 arch/x86/kvm/vmx/vmx.c          |  1 +
 arch/x86/kvm/x86.c              | 12 +++++++-----
 5 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index bdea7ef89f402..07ec92c9b8a4d 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1852,6 +1852,8 @@ struct kvm_x86_ops {
 };
 
 struct kvm_x86_nested_ops {
+	bool enabled;
+
 	void (*leave_nested)(struct kvm_vcpu *vcpu);
 	bool (*is_exception_vmexit)(struct kvm_vcpu *vcpu, u8 vector,
 				    u32 error_code);
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 40660da6b7737..58807c3b60fa1 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2798,7 +2798,8 @@ int kvm_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
 	};
 	int i, nent = ARRAY_SIZE(cpuid_entries);
 
-	if (kvm_x86_ops.nested_ops->get_evmcs_version)
+	if (kvm_x86_ops.nested_ops->enabled &&
+	    kvm_x86_ops.nested_ops->get_evmcs_version)
 		evmcs_ver = kvm_x86_ops.nested_ops->get_evmcs_version(vcpu);
 
 	if (cpuid->nent < nent)
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 2c8883511d7b0..56617e077e67a 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5491,6 +5491,7 @@ static __init int svm_hardware_setup(void)
 		pr_info("Nested Virtualization enabled\n");
 		kvm_enable_efer_bits(EFER_SVME | EFER_LMSLE);
 	}
+	svm_nested_ops.enabled = nested;
 
 	/*
 	 * KVM's MMU doesn't support using 2-level paging for itself, and thus
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index adf41ef4a1d67..b40aa09400868 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -8571,6 +8571,7 @@ __init int vmx_hardware_setup(void)
 		if (r)
 			return r;
 	}
+	vmx_nested_ops.enabled = nested;
 
 	vmx_set_cpu_caps();
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d0c7a7098143a..6e3261b98403d 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4764,7 +4764,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		r = KVM_X2APIC_API_VALID_FLAGS;
 		break;
 	case KVM_CAP_NESTED_STATE:
-		r = kvm_x86_ops.nested_ops->get_state ?
+		r = kvm_x86_ops.nested_ops->enabled ?
 			kvm_x86_ops.nested_ops->get_state(NULL, NULL, 0) : 0;
 		break;
 #ifdef CONFIG_KVM_HYPERV
@@ -4772,7 +4772,8 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		r = kvm_x86_ops.enable_l2_tlb_flush != NULL;
 		break;
 	case KVM_CAP_HYPERV_ENLIGHTENED_VMCS:
-		r = kvm_x86_ops.nested_ops->enable_evmcs != NULL;
+		r = kvm_x86_ops.nested_ops->enabled &&
+		    kvm_x86_ops.nested_ops->enable_evmcs != NULL;
 		break;
 #endif
 	case KVM_CAP_SMALLER_MAXPHYADDR:
@@ -5846,7 +5847,8 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
 			uint16_t vmcs_version;
 			void __user *user_ptr;
 
-			if (!kvm_x86_ops.nested_ops->enable_evmcs)
+			if (!kvm_x86_ops.nested_ops->enabled ||
+			    !kvm_x86_ops.nested_ops->enable_evmcs)
 				return -ENOTTY;
 			r = kvm_x86_ops.nested_ops->enable_evmcs(vcpu, &vmcs_version);
 			if (!r) {
@@ -6210,7 +6212,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		u32 user_data_size;
 
 		r = -EINVAL;
-		if (!kvm_x86_ops.nested_ops->get_state)
+		if (!kvm_x86_ops.nested_ops->enabled)
 			break;
 
 		BUILD_BUG_ON(sizeof(user_data_size) != sizeof(user_kvm_nested_state->size));
@@ -6240,7 +6242,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		int idx;
 
 		r = -EINVAL;
-		if (!kvm_x86_ops.nested_ops->set_state)
+		if (!kvm_x86_ops.nested_ops->enabled)
 			break;
 
 		r = -EFAULT;
-- 
2.53.0

