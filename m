Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F7647DF95
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 23:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790812555; cv=none; b=Vh4cTN98Ss4Z+KWaW9RXhCc15J5iWd9NhGzoS/vf/3OU0hHlhTb0ktKlWkZoWqhwTjJS95T6INYY7BtqDRMtcS43So6OkKFh9S1Rtn/tryjBVobFxEPuiQXdNv2HQ2jZ+OkSdMQVlnwFvLc5pIEP611zaxf34izPqf5r/IdEg6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790812555; c=relaxed/simple;
	bh=UTVQornUXYbfspgaOE+drmUxQnOQLga0PNfWzjGbRg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VhAXNu//hvRk3duNj2/1IL8GpN/a5QacFpDaGEYQ4X+znVPqj+WFyOQ3M+Kveac2o7ijRNgFserxpff9na5xP8EGGLxwLnVeqlE7T/eou7g7gCBKHWxI6Z0/MLIrhRSys/wDsRZPzZorIL020qHgQpC8HhOfeKXAmIpaR2r9FuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPpR3xHH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPpR3xHH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 771D61F000FF;
	Wed, 30 Sep 2026 23:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790812554;
	bh=STV05ZXqaMgMT+CKFy9BmYKh00rUfwHnxVRbsHg84g4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TPpR3xHHdUn/Nm8uVgnfFmbb1xQsfMBU98nI4uetPm+lgDd8Ovur7LG/WDSU8gB0F
	 xCPFisn8pKIKMYqRfb/vF9BHPDuRb0XIZJWEsJLO/rpEyU6GMyOQXDcLYfY8QFZ7Vf
	 TgkTAV2s4EiKc/y9pkjwtuffvWbhthkclsU7MTh/vfcLR94rPk1OKosRR2OONUNzx1
	 6Z/Yj/0fqliubqMZgsNc4kBR7JrK1L8VolE2J5LnrPD634M9OjEW4hoXTRnPKcTpsR
	 QNWZ4mPqqmq6eS281S2FIjLBMyb7rst7utRf1QN7UZRXXrcjEufhUa87I6utT35zch
	 PLEbXqbXp6naA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] KVM: x86: Reject nested CAP enablement if nested virtualization is disabled
Date: Wed, 30 Sep 2026 19:55:50 -0400
Message-ID: <20260930235551.1345464-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092947-deflector-impound-8267@gregkh>
References: <2026092947-deflector-impound-8267@gregkh>
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

Backport notes for 5.15:
Keep svm_hardware_setup() in its existing location and initialize the nested
flag after the existing EFER setup.  Preserve the capability handler's
function-scoped variables while adding the nested-enabled checks.

Provide kvm_nested_call() as a macro around the existing indirect hook and
use it for get_nested_state_pages().  This preserves the current dispatch
semantics without importing the later nested static-call conversion or
adding any functions.  Match the surrounding whitespace so that target
10180a277549339020b08000206092c07e0bff5a applies unchanged.  The request
re-pending fix itself remains in that target commit.

Stable-dep-of: 10180a277549 ("KVM: x86: Re-pend GET_NESTED_STATE_PAGES if getting said pages fails")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/kvm_host.h |  5 +++++
 arch/x86/kvm/hyperv.c           |  3 ++-
 arch/x86/kvm/svm/svm.c          |  1 +
 arch/x86/kvm/vmx/vmx.c          |  1 +
 arch/x86/kvm/x86.c              | 15 +++++++++------
 5 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 710c9c87cdf2e..62012b9caa6e8 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1496,6 +1496,8 @@ struct kvm_x86_ops {
 };
 
 struct kvm_x86_nested_ops {
+	bool enabled;
+
 	void (*leave_nested)(struct kvm_vcpu *vcpu);
 	int (*check_events)(struct kvm_vcpu *vcpu);
 	bool (*hv_timer_pending)(struct kvm_vcpu *vcpu);
@@ -1537,6 +1539,9 @@ extern bool __read_mostly allow_smaller_maxphyaddr;
 extern bool __read_mostly enable_apicv;
 extern struct kvm_x86_ops kvm_x86_ops;
 
+/* Nested virtualization hooks use indirect calls. */
+#define kvm_nested_call(func) (kvm_x86_ops.nested_ops->func)
+
 #define KVM_X86_OP(func) \
 	DECLARE_STATIC_CALL(kvm_x86_##func, *(((struct kvm_x86_ops *)0)->func));
 #define KVM_X86_OP_NULL KVM_X86_OP
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 4e531036ab4c6..1ace566dac328 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2444,7 +2444,8 @@ int kvm_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
 	};
 	int i, nent = ARRAY_SIZE(cpuid_entries);
 
-	if (kvm_x86_ops.nested_ops->get_evmcs_version)
+	if (kvm_x86_ops.nested_ops->enabled &&
+	    kvm_x86_ops.nested_ops->get_evmcs_version)
 		evmcs_ver = kvm_x86_ops.nested_ops->get_evmcs_version(vcpu);
 
 	/* Skip NESTED_FEATURES if eVMCS is not supported */
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 16d2b697dc631..eca6733d080f6 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1017,6 +1017,7 @@ static __init int svm_hardware_setup(void)
 		printk(KERN_INFO "kvm: Nested Virtualization enabled\n");
 		kvm_enable_efer_bits(EFER_SVME | EFER_LMSLE);
 	}
+	svm_nested_ops.enabled = nested;
 
 	/*
 	 * KVM's MMU doesn't support using 2-level paging for itself, and thus
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 244b67601bce7..747f9086028bc 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -8083,6 +8083,7 @@ static __init int hardware_setup(void)
 		if (r)
 			return r;
 	}
+	vmx_nested_ops.enabled = nested;
 
 	vmx_set_cpu_caps();
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index bbfc8ccf4fcd9..30a9a9fd04aaa 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4236,14 +4236,15 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
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
@@ -5081,7 +5082,8 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
 		return kvm_hv_activate_synic(vcpu, cap->cap ==
 					     KVM_CAP_HYPERV_SYNIC2);
 	case KVM_CAP_HYPERV_ENLIGHTENED_VMCS:
-		if (!kvm_x86_ops.nested_ops->enable_evmcs)
+		if (!kvm_x86_ops.nested_ops->enabled ||
+		    !kvm_x86_ops.nested_ops->enable_evmcs)
 			return -ENOTTY;
 		r = kvm_x86_ops.nested_ops->enable_evmcs(vcpu, &vmcs_version);
 		if (!r) {
@@ -5411,7 +5413,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		u32 user_data_size;
 
 		r = -EINVAL;
-		if (!kvm_x86_ops.nested_ops->get_state)
+		if (!kvm_x86_ops.nested_ops->enabled)
 			break;
 
 		BUILD_BUG_ON(sizeof(user_data_size) != sizeof(user_kvm_nested_state->size));
@@ -5441,7 +5443,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		int idx;
 
 		r = -EINVAL;
-		if (!kvm_x86_ops.nested_ops->set_state)
+		if (!kvm_x86_ops.nested_ops->enabled)
 			break;
 
 		r = -EFAULT;
@@ -9774,8 +9776,9 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 			r = -EIO;
 			goto out;
 		}
+
 		if (kvm_check_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu)) {
-			if (unlikely(!kvm_x86_ops.nested_ops->get_nested_state_pages(vcpu))) {
+			if (unlikely(!kvm_nested_call(get_nested_state_pages)(vcpu))) {
 				r = 0;
 				goto out;
 			}
-- 
2.53.0

