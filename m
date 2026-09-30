Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8BE51DAEF
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 21:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790803502; cv=none; b=Kg5X9Xjr+TTOCU4SXWVk8WUuyKfrRnDBPOs6+3GKYOZ0nBIJIK4ct3vsupaRepEh7zkPEPKd2sFsiXsBfduG5MPwmQ1MR04a4dIAvH9i1kmbgwwylT6dgS7FU4I2dxeVYhILWE6GjR6JJsK1/3eA4n1r89DPH+dNRSGCoR1sTlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790803502; c=relaxed/simple;
	bh=AnAEugQIUgamwKX/p928eb4sUD5K7Bb7cPghvbeX92s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hAQhtaJQRECSSDd44t8H5SdRlbwoBxerJIUY/ceTMqKJxptzu/tvWnDeQZpYhPgYenmnPl4ho1mPYWDgFSd+JVX6SK6rLjfGsML6enWV+8/YDa21tqQ6+ue+uI6eclEAhIyFMmfR6CGpl1v2CptuXhbU0R9jFY7FAmMZ2YX38CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvneZOA3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvneZOA3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D1A61F0089A;
	Wed, 30 Sep 2026 21:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790803499;
	bh=usEUdQo+YBz5RB5Rcdyrvtbr4dr3pVPcIN034rlMGSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mvneZOA3Bj7sOu/x0ka443FsXFU1UHyBJnTskcQgteW6r+hnyF3Z+HlFgwwnTitjP
	 CJEGPIV5Ona71J1pCnCGijCpWN9kcw6EWLmRCE9z7KENTi2LXTOIh/HIlOwWzSFCKD
	 Sgcur2DrB02BPUy68huByDUoli9r9FCnXxlPsRit/Kmwvx32g0xoMvKeuEw0CQeh/o
	 aMLrW/JjuB8KtHDEog18kw8PF+Bo4Fv6p9FM2TjLAjIrrATrnXFhmggjP+Ob58sgYi
	 U3ftW/VCmZ7lo5v+vZZiHClblf6eKwOC5UUOCd1mc1FEaBMfRffw7PrbFi3IFvDDDn
	 Nn7tMlBwK6EKQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Jinwoo Lee <rkskek9254@gmail.com>,
	Stefan Teodorescu <fane@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] KVM: x86: Fill kvm_run exit fields in common get_nested_state_pages() error paths
Date: Wed, 30 Sep 2026 17:24:57 -0400
Message-ID: <20260930212457.3174359-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930212457.3174359-1-sashal@kernel.org>
References: <2026092940-tractor-spiritual-64e5@gregkh>
 <20260930212457.3174359-1-sashal@kernel.org>
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
index 1984df18802ae..2fa4bb44ab8c0 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1722,13 +1722,8 @@ static bool svm_get_nested_state_pages(struct kvm_vcpu *vcpu)
 		if (CC(!load_pdptrs(vcpu, vcpu->arch.cr3)))
 			return false;
 
-	if (!nested_svm_merge_msrpm(vcpu)) {
-		vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
-		vcpu->run->internal.suberror =
-			KVM_INTERNAL_ERROR_EMULATION;
-		vcpu->run->internal.ndata = 0;
+	if (!nested_svm_merge_msrpm(vcpu))
 		return false;
-	}
 
 	return true;
 }
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index e853dd7daf75b..e13669f0a371b 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3220,10 +3220,6 @@ static bool nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
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
@@ -3287,11 +3283,6 @@ static bool vmx_get_nested_state_pages(struct kvm_vcpu *vcpu)
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
 
@@ -3686,8 +3677,12 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch)
 
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
index 75c3347db920c..b6aae860322bd 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10659,6 +10659,9 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		}
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

