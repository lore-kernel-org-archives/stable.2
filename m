Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59E551DB07
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 17:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790789648; cv=none; b=IcoMX0GIEe9WHiTxSIK77f24P4/+qvY8BGTJ4DiT3XFiDGL6hEh7/HKfsGnN0Zb94lZiKlbtu+otoxybq/mXanMk2dgxmlsentMmrNH0qTbMhs2Z/52ycPONGVmQZYn1a8/OtBi6j5rIYea7UiBgvQWb+mx6+BGXBT22l6SSBiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790789648; c=relaxed/simple;
	bh=BboAQmjVG9lm3894hKOWN+K1CqQp0QOW+QoP2ye55vs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jTz0ERLfoCq8b5WszwuCmPl+0xKxvWQoFLDGgKK5yQPo/u3tW6d+tF1Kor3OxItytOe1I7C9neqhziBzxLljLnPjf3tdh4w5M3VcfL4GcQoS8Xa1XSdimSBJ247i3OxL70ChBUFWL3S6jUeOHjWNMWTPN0ZoXLSrWk603l8VtaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9Y72Z9g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9Y72Z9g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D6391F000FF;
	Wed, 30 Sep 2026 17:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790789646;
	bh=/l0OL3K5gRRZGrsifqjkeNDkFGiMQId9C8icHrSmjDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R9Y72Z9gJJzLsf7dxlCp73F2MSO8cFQvxFkwVE0EJZ8QbvBM2DslbOa/8S/Q5w5+C
	 9X2pk+ZAlohNjAYexDENoQzFGU2mGwHrss17aLUUL9HcD2WjjKNqqpkcBZgMKesNoT
	 XPzjkdDDrxPzrGNAJyeZEDgCZLDGzp22ZelnanEaY0gXcTd/FKKWTcNMuAit6fbL5p
	 LbrSCcm5vuMLFf2gJFm0/tISJAGj8hmCggu8bqYnTaSErpvc+3q/QiGmUKxsTaPrqH
	 A63v2h8h0p1Zcl6PDDYOwwJSszCwsimGjVBYCyYd/0ApD7SNgGS1M4pxPIG5Kgr8j5
	 RedvlV30JEo4w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Jinwoo Lee <rkskek9254@gmail.com>,
	Stefan Teodorescu <fane@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/4] KVM: x86: Fill kvm_run exit fields in common get_nested_state_pages() error paths
Date: Wed, 30 Sep 2026 13:34:02 -0400
Message-ID: <20260930173402.3642110-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930173402.3642110-1-sashal@kernel.org>
References: <2026092939-nearness-debtor-eebf@gregkh>
 <20260930173402.3642110-1-sashal@kernel.org>
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
index bef83fda2ef9d..51da04a5f6ac2 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1816,13 +1816,8 @@ static bool svm_get_nested_state_pages(struct kvm_vcpu *vcpu)
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
index e95681bc751eb..1d23a70105b8f 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3355,10 +3355,6 @@ static bool nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
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
@@ -3429,11 +3425,6 @@ static bool vmx_get_nested_state_pages(struct kvm_vcpu *vcpu)
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
@@ -3831,8 +3822,12 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch)
 
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
index 15cb823e61dac..1216a9dc734bf 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10827,6 +10827,9 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 
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

