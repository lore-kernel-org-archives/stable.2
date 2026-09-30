Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79764EF13C
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 13:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790776099; cv=none; b=V2geozYyZjRxQhbTrsKGq5g8bq8HbbGiWABYCbBut+PcAzF8DiEsHp9p+3t+QI5AYAPHzBAWThH8Jvz858Vih1DbDlRb/6WNuQh0OgMJJbKvB8TMvgEYQsnVZH1xoUvIIPGfcaP4z14NTLwmrqzRdpuUj93ZWLmkUF5pYyqsbvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790776099; c=relaxed/simple;
	bh=FW5wID429R1qp+cYObgLYIcKLU+hHvtxKVHN12zZGzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jsqt4e/FmiRTX0Qpby74XaBYq+kMG8/+9gVIPi3eu/RnBV70Ch9HWhkcmNv+Y+ulSaEUGCMRs48ePlzHe4TchD79DQwDme+SQayCMXBLamci4l6F2/DiHOFTFaql5Pv3FPWm4wyg9zgKB5Mt2ULJ8QS1WAT8bvZalqZxLWmz/AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HEx6gm+H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HEx6gm+H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A021F0089D;
	Wed, 30 Sep 2026 13:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790776084;
	bh=HEEoFWCxk+ZC/jj8LRjrfnhpXP4T1cCSTaZjfaDb7vE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HEx6gm+H23ZLqcCl71b7h+D4cVvXHo8KaRkRMjuXE34oDAHTyNmxQXa79DqG1Ud1B
	 jtH78phbK/XGJhl41AukVatvqieUydnWxSdw4CDZhrFtN/QZsPTryPVOEcpOoBpl34
	 y6abqz4+hmLVfsFi9gHwEI0YDEk6yItrbqTlKGlzqoK+UmvoXuhaiCGm93OLWWglhE
	 aqY1DFUJIj8nFaZYnMPH6prR7se90uJbjQECoYJTiAUrX6R4R2gaC0S2j0ixvfzCUM
	 ER7E6PZVMlzxEuwfRkdMzMpp0Plkj63sLr13VphER1OicQgUE9yPWd04L56aMTMdCS
	 X6pm3h7PuX8hQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Jinwoo Lee <rkskek9254@gmail.com>,
	Stefan Teodorescu <fane@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 6/6] KVM: x86: Fill kvm_run exit fields in common get_nested_state_pages() error paths
Date: Wed, 30 Sep 2026 09:47:57 -0400
Message-ID: <20260930134757.1797371-6-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930134757.1797371-1-sashal@kernel.org>
References: <2026092938-mantis-spearfish-5a96@gregkh>
 <20260930134757.1797371-1-sashal@kernel.org>
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
index 3e6c671a8dc26..f9be0403fe8ff 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -2130,13 +2130,8 @@ static bool svm_get_nested_state_pages(struct kvm_vcpu *vcpu)
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
index ed28cf6b6efc2..684759c373755 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3468,10 +3468,6 @@ static bool nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
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
@@ -3542,11 +3538,6 @@ static bool vmx_get_nested_state_pages(struct kvm_vcpu *vcpu)
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
@@ -3918,8 +3909,12 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch)
 
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
index b91c424042829..e3636a97ae9e4 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10694,6 +10694,9 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 
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

