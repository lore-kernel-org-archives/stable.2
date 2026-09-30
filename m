Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD00C4F3ECC
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 15:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790782781; cv=none; b=l5mehZFyRqqrAZZGzchkGKylrAOowjlGl60uonvaAXlWwq3G3TX6awvp1EQ6aNOuLXBD9M/rp2q/8Z+7/WmH8IdpI0RAuOvxL2GF1QqDHKG06s0ZgDsEZ0XtCnY8ub9ShzW7/sQYl9QcHRQGVKMdh8RQK8oOpbphXFaa/zVNAzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790782781; c=relaxed/simple;
	bh=SZbDA542HiQRtfyijtrcf2ejPBiI+MuZC/dsey7iLnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dG+i3EEBPF1yc4eb07DNSTpkeN+PrgJc1Hi6ZPI9eUoGHLu9NzxKoSgg3+ZUanyusWOjWHNwBbYNocBUDf/E9gs8mS0BXAx+PT7AMsrSFw3Y67rv+ys5SgOIoK22ATcWX1B7o8sY+6XL2aEtOAXmKJ+IRrMJ3scxoiOI6kobYbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uym5sFiH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uym5sFiH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F641F0089D;
	Wed, 30 Sep 2026 15:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790782777;
	bh=GauKHFPcp2LCYhH+rvV/qeRq7lldfbC70+8apKipcwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Uym5sFiHaTXzURBeWZYTyneyoYgGIoDwFsi917/ZKdl3GVQOGrdWUFpkj646NHAJz
	 rzWREG00wDSf2pSY4hxX0GDBhEk3Rnn34UIhfk/5U+trvqcR0kJS/M1a0WimPLHhT3
	 hN4fQPgbNMJ1eDn9xihFypVFLhwdw0c9DxsCrOYSvPr4AmQ7OR/5PpYZXZVjIMz71e
	 56qRAJuINzXHwuP40FL074AyQobbNMqPOrDSBfrV6E1nIHqqFpThpLCTf0w+1iSf0i
	 74aY3g5aFGDJic+RZ/r6UUX2HMDYoxgHxs+6wstXX8g/5TURKuqCbLT/3TTl3Lqi/V
	 xrCb5zIiRYWZg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/4] KVM: x86: Reject nested CAP enablement if nested virtualization is disabled
Date: Wed, 30 Sep 2026 11:39:32 -0400
Message-ID: <20260930153934.2895211-2-sashal@kernel.org>
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
Stable-dep-of: c1214f293d77 ("KVM: x86: Fill kvm_run exit fields in common get_nested_state_pages() error paths")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/kvm_host.h |  2 ++
 arch/x86/kvm/hyperv.c           |  3 ++-
 arch/x86/kvm/svm/svm.c          |  1 +
 arch/x86/kvm/vmx/vmx.c          |  1 +
 arch/x86/kvm/x86.c              | 12 +++++++-----
 5 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 0008a3c4fc452..5202b0a708807 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1954,6 +1954,8 @@ struct kvm_x86_ops {
 };
 
 struct kvm_x86_nested_ops {
+	bool enabled;
+
 	void (*leave_nested)(struct kvm_vcpu *vcpu);
 	bool (*is_exception_vmexit)(struct kvm_vcpu *vcpu, u8 vector,
 				    u32 error_code);
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 380a211f56f00..4753d084e2567 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2799,7 +2799,8 @@ int kvm_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
 	};
 	int i, nent = ARRAY_SIZE(cpuid_entries);
 
-	if (kvm_x86_ops.nested_ops->get_evmcs_version)
+	if (kvm_x86_ops.nested_ops->enabled &&
+	    kvm_x86_ops.nested_ops->get_evmcs_version)
 		evmcs_ver = kvm_x86_ops.nested_ops->get_evmcs_version(vcpu);
 
 	if (cpuid->nent < nent)
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index a24a6871b6936..e3daa6e57192d 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5461,6 +5461,7 @@ static __init int svm_hardware_setup(void)
 		if (r)
 			return r;
 	}
+	svm_nested_ops.enabled = nested;
 
 	/*
 	 * KVM's MMU doesn't support using 2-level paging for itself, and thus
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 6b51f352d2826..5bae3d5ce6eec 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -8642,6 +8642,7 @@ __init int vmx_hardware_setup(void)
 		if (r)
 			return r;
 	}
+	vmx_nested_ops.enabled = nested;
 
 	r = alloc_kvm_area();
 	if (r && nested)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index f08a34d3ff3d9..91d38d709d8a7 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4604,7 +4604,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 			r &= ~KVM_X2APIC_ENABLE_SUPPRESS_EOI_BROADCAST;
 		break;
 	case KVM_CAP_NESTED_STATE:
-		r = kvm_x86_ops.nested_ops->get_state ?
+		r = kvm_x86_ops.nested_ops->enabled ?
 			kvm_x86_ops.nested_ops->get_state(NULL, NULL, 0) : 0;
 		break;
 #ifdef CONFIG_KVM_HYPERV
@@ -4612,7 +4612,8 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		r = kvm_x86_ops.enable_l2_tlb_flush != NULL;
 		break;
 	case KVM_CAP_HYPERV_ENLIGHTENED_VMCS:
-		r = kvm_x86_ops.nested_ops->enable_evmcs != NULL;
+		r = kvm_x86_ops.nested_ops->enabled &&
+		    kvm_x86_ops.nested_ops->enable_evmcs != NULL;
 		break;
 #endif
 	case KVM_CAP_SMALLER_MAXPHYADDR:
@@ -5650,7 +5651,8 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
 			uint16_t vmcs_version;
 			void __user *user_ptr;
 
-			if (!kvm_x86_ops.nested_ops->enable_evmcs)
+			if (!kvm_x86_ops.nested_ops->enabled ||
+			    !kvm_x86_ops.nested_ops->enable_evmcs)
 				return -ENOTTY;
 			r = kvm_x86_ops.nested_ops->enable_evmcs(vcpu, &vmcs_version);
 			if (!r) {
@@ -6150,7 +6152,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		u32 user_data_size;
 
 		r = -EINVAL;
-		if (!kvm_x86_ops.nested_ops->get_state)
+		if (!kvm_x86_ops.nested_ops->enabled)
 			break;
 
 		BUILD_BUG_ON(sizeof(user_data_size) != sizeof(user_kvm_nested_state->size));
@@ -6180,7 +6182,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		int idx;
 
 		r = -EINVAL;
-		if (!kvm_x86_ops.nested_ops->set_state)
+		if (!kvm_x86_ops.nested_ops->enabled)
 			break;
 
 		r = -EFAULT;
-- 
2.53.0

