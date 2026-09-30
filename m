Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3379371049
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 15:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790782786; cv=none; b=V5/LpT6xet6bZUVtiLDBrxzvpc0qjI9GT2jeT7DxxssryYt8MZ0wSM5LBbUwAh7OrJWjN0Utlw6I49ideqCwlIWwRXc6nmUYf6/yh+0m3blvnjQijvFWetnA6tantn9dnEhoIndHg/3Qb9tfPHnCa/q/SDvqqgJSSPpEMAihLEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790782786; c=relaxed/simple;
	bh=ki2X6+DtnMsJieEPdsXvdbeJkx3AUGXDfrqmJp3OaoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QFIwi2jb0jxMFEmXkuBxqpo0NN8bzA9y0VQJgcDQa4DqUe+jFBacXCEd+WENGjhlek+ecpBv8zB1ruKqlN/8LMPpAUkQGqfSr5HR9GyoMakLrAUW0giw8Gc2zT+uPe35ZaXb4sh2euTbZO1EmvzBVUZlkPWYmFPD9VhMTfSmpZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkzqkdIb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkzqkdIb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C26881F00899;
	Wed, 30 Sep 2026 15:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790782779;
	bh=PUNPxBEkyU53xYqHLxpj4W1RhgHwTMFo1PYKKuwydBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QkzqkdIbXkwtxavHJv30d3So2Snc1QrTtvRQUTlIc5EjEcPySuvSo2fjCG4so3nNW
	 haqFK47aXehpoyge6hUm4BfZyr2s3sc/FlavcWnfODHfEKdEKvVMVTxKRoalnTgPPp
	 U10jWcl3p4tQbrAPsZ3cweUbpFLKeauqfVNIHQIULL6SWPyfTkFCtpHL3J/rI+l+kL
	 BBfjvgfsmHd3TNRRO6J9Hai6dWQRXKHpa0zcAL0eDAKrBuE/RphI/PbjuNzVTN0bV2
	 kGO95IJ1HsuAKUgTw2MZkG4BTfbjYDdCjsNWvGl0OvfdEoUZQzG6m3ooUaUx96+1lw
	 jvhbRUfPb9nMA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Jinwoo Lee <rkskek9254@gmail.com>,
	Stefan Teodorescu <fane@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 4/4] KVM: x86: Fill kvm_run exit fields in common get_nested_state_pages() error paths
Date: Wed, 30 Sep 2026 11:39:34 -0400
Message-ID: <20260930153934.2895211-4-sashal@kernel.org>
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

[ Upstream commit c1214f293d77c6e425a379f90d09bdb4815993a8 ]

Fill kvm_run with "internal error, emulation" in the common error handling
paths for getting nested state pages, as requiring each check to manually
fill kvm_run is error prone and requires a non-trivial amount of copy+paste.

Specifically, both SVM and VMX fail to fill kvm_run if load_pdptrs() fails,
and SVM fails to fill kvm_run if kvm_hv_verify_vp_assist() fails.  If those
flows fail, the *best* case scenario is that KVM will exit to userspace
with KVM_EXIT_UNKNOWN.  The worst case scenario is that KVM exits with a
stale exit_reason and confuses userspace.

Note, SVM never exits to userspace if something goes sideways when dealing
with vmcb12 assets while emulating VMRUN, i.e. lack of SVM-specific code is
not a bug.

Fixes: 0f85722341b0 ("KVM: nVMX: delay loading of PDPTRs to KVM_REQ_GET_NESTED_STATE_PAGES")
Fixes: 232f75d3b4b5 ("KVM: nSVM: call nested_svm_load_cr3 on nested state load")
Fixes: 3f4a812edf5c ("KVM: nSVM: hyper-v: Enable L2 TLB flush")
Cc: stable@vger.kernel.org
Reported-by: Jinwoo Lee <rkskek9254@gmail.com>
Closes: https://lore.kernel.org/all/20260813043932.3214460-1-rkskek9254@gmail.com
Reported-by: Stefan Teodorescu <fane@google.com>
Link: https://patch.msgid.link/20260921211608.1030158-3-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/svm/nested.c |  7 +------
 arch/x86/kvm/vmx/nested.c | 15 +++++----------
 arch/x86/kvm/x86.c        |  3 +++
 3 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index c765ea1dff69c..a6b92819318b8 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1953,13 +1953,8 @@ static bool svm_get_nested_state_pages(struct kvm_vcpu *vcpu)
 			return false;
 	}
 
-	if (!nested_svm_merge_msrpm(vcpu)) {
-		vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
-		vcpu->run->internal.suberror =
-			KVM_INTERNAL_ERROR_EMULATION;
-		vcpu->run->internal.ndata = 0;
+	if (!nested_svm_merge_msrpm(vcpu))
 		return false;
-	}
 
 	if (kvm_hv_verify_vp_assist(vcpu))
 		return false;
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index cb44ae23728b3..890ee82af35d6 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3492,10 +3492,6 @@ static bool nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
 		} else {
 			pr_debug_ratelimited("%s: no backing for APIC-access address in vmcs12\n",
 					     __func__);
-			vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
-			vcpu->run->internal.suberror =
-				KVM_INTERNAL_ERROR_EMULATION;
-			vcpu->run->internal.ndata = 0;
 			return false;
 		}
 	}
@@ -3566,11 +3562,6 @@ static bool vmx_get_nested_state_pages(struct kvm_vcpu *vcpu)
 	if (!nested_get_evmcs_page(vcpu)) {
 		pr_debug_ratelimited("%s: enlightened vmptrld failed\n",
 				     __func__);
-		vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
-		vcpu->run->internal.suberror =
-			KVM_INTERNAL_ERROR_EMULATION;
-		vcpu->run->internal.ndata = 0;
-
 		return false;
 	}
 #endif
@@ -3956,8 +3947,12 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch)
 
 vmentry_failed:
 	vcpu->arch.nested_run_pending = 0;
-	if (status == NVMX_VMENTRY_KVM_INTERNAL_ERROR)
+	if (status == NVMX_VMENTRY_KVM_INTERNAL_ERROR) {
+		vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
+		vcpu->run->internal.suberror = KVM_INTERNAL_ERROR_EMULATION;
+		vcpu->run->internal.ndata = 0;
 		return 0;
+	}
 	if (status == NVMX_VMENTRY_VMEXIT)
 		return 1;
 	WARN_ON_ONCE(status != NVMX_VMENTRY_VMFAIL);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 69d48df5d1d89..c86b828ca578a 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10708,6 +10708,9 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 
 		if (kvm_check_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu)) {
 			if (unlikely(!kvm_nested_call(get_nested_state_pages)(vcpu))) {
+				vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
+				vcpu->run->internal.suberror = KVM_INTERNAL_ERROR_EMULATION;
+				vcpu->run->internal.ndata = 0;
 				kvm_make_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
 				r = 0;
 				goto out;
-- 
2.53.0

