Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFD4155747
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 13:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790773995; cv=none; b=aRyRNDNZj/XJEFikvqp5R8TWMqTACkuvYUezOSP0t0Lhbv5H1GJGHM1SZ/okJby8WWCWfUlSiGE667EiCQ8cK8wUoXYRWsxDCKxp9apib4k15PmleP42WPtavqAlxuHPHZNNR/N7tULDCzaNsXhxZPutCflIrWcTk+ZaNUeqxoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790773995; c=relaxed/simple;
	bh=tg4fqC/7djDwgqzEPFVcF5MACGMfcjCEoEnn/K2bLD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lTPeJjeVjjjCz3nSKu68KFYlRJj726D16gzjcnzjJERXro+rg255z/HhrXRuOBwQnySDnbqsX5c3/gSkP8cj9HlniehR4r7gj3Xx7VSwWDw8CDIuBgFrJYT07vDQm7vTYns1QwRacAJpyp4MznJsbnTzMqLcmbC6KfHA2Z7M79g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8lIX2nE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8lIX2nE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC7DD1F0089B;
	Wed, 30 Sep 2026 13:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790773982;
	bh=35j15imlTsbjBgBC2gSn1eOCLrGmuMOV9Y0+yYUqaDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y8lIX2nEMYHghiZBQezbZGcDrJq4GG+pw/vCvUds61FB99u8Q6Bpu3Akejmm4Whou
	 YXXw6YvuHi/bZfsiu2V7gpYJXl9uAWv/PE+HNHMABSExHamdGSBRILxT3fwW0YAdEp
	 YWB1Uo+szAzFNET5R2JHWWCZJbKP98xPQNKj8R9lJbuglqaXI7AQz1DIypn16az1eH
	 YcFAVIbyxvuo/gvG8YSZj8QjB0mXt6gxibJlAl6QKYC2eU9gFqop/A+65KNDtf1shN
	 3Mx3waIco9Objq1UReteqpQUQrPVzF8Qwlp8xdUwRUBX0TXUkT9fQQSvlkzx/9O5Nt
	 RDeCdTCN+1i5w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 6/8] KVM: x86: Reject nested CAP enablement if nested virtualization is disabled
Date: Wed, 30 Sep 2026 09:12:53 -0400
Message-ID: <20260930131256.1728861-6-sashal@kernel.org>
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
index 0da2268800f6c..559a377664743 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2019,6 +2019,8 @@ struct kvm_x86_ops {
 };
 
 struct kvm_x86_nested_ops {
+	bool enabled;
+
 	void (*leave_nested)(struct kvm_vcpu *vcpu);
 	bool (*is_exception_vmexit)(struct kvm_vcpu *vcpu, u8 vector,
 				    u32 error_code);
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 5f43ae345f87c..00915958c7e2f 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2800,7 +2800,8 @@ int kvm_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
 	};
 	int i, nent = ARRAY_SIZE(cpuid_entries);
 
-	if (kvm_x86_ops.nested_ops->get_evmcs_version)
+	if (kvm_x86_ops.nested_ops->enabled &&
+	    kvm_x86_ops.nested_ops->get_evmcs_version)
 		evmcs_ver = kvm_x86_ops.nested_ops->get_evmcs_version(vcpu);
 
 	if (cpuid->nent < nent)
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 03fb9d7231c8d..d1423bab1a3aa 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5662,6 +5662,7 @@ static __init int svm_hardware_setup(void)
 		if (r)
 			return r;
 	}
+	svm_nested_ops.enabled = nested;
 
 	/*
 	 * KVM's MMU doesn't support using 2-level paging for itself, and thus
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 8b75c70e60d26..61243d16febf0 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -8771,6 +8771,7 @@ __init int vmx_hardware_setup(void)
 		if (r)
 			return r;
 	}
+	vmx_nested_ops.enabled = nested;
 
 	kvm_set_posted_intr_wakeup_handler(pi_wakeup_handler);
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index bd05ef7aa966f..5948dc18e49aa 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4517,7 +4517,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 			r &= ~KVM_X2APIC_ENABLE_SUPPRESS_EOI_BROADCAST;
 		break;
 	case KVM_CAP_NESTED_STATE:
-		r = kvm_x86_ops.nested_ops->get_state ?
+		r = kvm_x86_ops.nested_ops->enabled ?
 			kvm_x86_ops.nested_ops->get_state(NULL, NULL, 0) : 0;
 		break;
 #ifdef CONFIG_KVM_HYPERV
@@ -4525,7 +4525,8 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		r = kvm_x86_ops.enable_l2_tlb_flush != NULL;
 		break;
 	case KVM_CAP_HYPERV_ENLIGHTENED_VMCS:
-		r = kvm_x86_ops.nested_ops->enable_evmcs != NULL;
+		r = kvm_x86_ops.nested_ops->enabled &&
+		    kvm_x86_ops.nested_ops->enable_evmcs != NULL;
 		break;
 #endif
 	case KVM_CAP_SMALLER_MAXPHYADDR:
@@ -5579,7 +5580,8 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
 			uint16_t vmcs_version;
 			void __user *user_ptr;
 
-			if (!kvm_x86_ops.nested_ops->enable_evmcs)
+			if (!kvm_x86_ops.nested_ops->enabled ||
+			    !kvm_x86_ops.nested_ops->enable_evmcs)
 				return -ENOTTY;
 			r = kvm_x86_ops.nested_ops->enable_evmcs(vcpu, &vmcs_version);
 			if (!r) {
@@ -6079,7 +6081,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		u32 user_data_size;
 
 		r = -EINVAL;
-		if (!kvm_x86_ops.nested_ops->get_state)
+		if (!kvm_x86_ops.nested_ops->enabled)
 			break;
 
 		BUILD_BUG_ON(sizeof(user_data_size) != sizeof(user_kvm_nested_state->size));
@@ -6109,7 +6111,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		int idx;
 
 		r = -EINVAL;
-		if (!kvm_x86_ops.nested_ops->set_state)
+		if (!kvm_x86_ops.nested_ops->enabled)
 			break;
 
 		r = -EFAULT;
-- 
2.53.0

