Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.26.1.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793356648;
	b=jf/auCXcTwvg0VyFg/waiA2Tn9i+C6jXI8r3wtxGaaqGHdQ4SRWSnqbEb2jC3M1U72Ia
	 0XPA995eutreavDRkAQACNZ3omHtpiYPw4qCPQLMjt/yIfXZxepvxKKiKCwS38xJzfrWm
	 Ap9fcbz7TjZXp+Q96q0GGueKciwKRJ7VGt6MS+HuCXLJRRU2pRK7TfUWtPFnIMXSP825D
	 GDhkDrQWsDq8zF6znQaMu4IblTYNHzNvVLOY+KdOMkjOG79Zuy57CeH5D6mKgC0+9saI6
	 qNMB6HZ65Phu+edzmuDMYTJ+b88VNx6zNkIwBKaOxk7T56h6fI3q9SiNmgwVfbn27Rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793356648;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=0Qln9Lc1orb9FBzIw/5Y4Z8WuhIv2CydNY+RBDShli0=;
	b=JSnpQwEhwlPgX+vNw4/A++PScfFA8qDbB3Wef8iEwSAbRQh+574FC09yzlpYTsWIga9z
	 SqspyChKobL+DuCl0lVB7L7grroRxM1hGXQVKPGRMcai1ElR90nbaihKUn6/IVKGGYLYD
	 nIWZRMdFk0624D+Y/xL1vFFgJpaR3cN1xgBElpM51suTjBn9mdglCcQB3otRYZlFVoQV7
	 Aa4+G4tVLWyV/sAfhf5OHaofrcmng8+OKhYhxpcMlBhEXeTqs6NOt6POcY2EhMw0JcL3K
	 I9I0G6wc1jgaNOiYZAiSc1h8ful75NYr5krbZFMOPQLHy+lLjt8MyyRipXe1IJa/tKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.de;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=NV4LzjRI;
	arc=none smtp.remote-ip=52.26.1.71
Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF01606A33D;
	Fri, 30 Oct 2026 10:37:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FF01606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=NV4LzjRI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1793356647; x=1824892647;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0Qln9Lc1orb9FBzIw/5Y4Z8WuhIv2CydNY+RBDShli0=;
  b=NV4LzjRI7kQFQlrKaF9OppUE3Kb+XV4KYlrtCryXviJEtfWDjhVbt403
   kx3k6vZMIByVWbC2QEvVWkjNKuIKx4GUWgka9mnaoER/UtsGtpZUTkhsq
   eLDfZwVVvHnvxMJct00Q58VdcGD2WbnCjOnX0AS2f3bIom6kx/BAUmVDG
   NNUXxQaDWEchA0s5kE2BBWYuTJGjLdqflgy/X+IM4tIDEO5GEXbrFmiL1
   FTnK/dLYGJQIv1h4xHAYGkNrhdueKNQhbvuXjPk45DawCJtwo/LACklSz
   DDC6gB9PAgxqrECqu4nCZPZwSHeeyTab4m6zIzHykxfLYe7zg57WuMm3W
   g==;
X-CSE-ConnectionGUID: b4WarI3+TqmMmbVQ58MTYA==
X-CSE-MsgGUID: x9bIkQdVR8Cyn7Aq4UXPig==
X-IronPort-AV: E=Sophos;i="6.27,186,1787011200"; 
   d="scan'208";a="32690048"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 10:37:27 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:5353]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.63.21:2525] with esmtp (Farcaster)
 id 47c72fb2-873c-4c98-b28e-a9514d207e36; Fri, 30 Oct 2026 10:37:27 +0000 (UTC)
X-Farcaster-Flow-ID: 47c72fb2-873c-4c98-b28e-a9514d207e36
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Fri, 30 Oct 2026 10:37:26 +0000
Received: from dev-dsk-doebel-1a-7b355d76.us-east-1.amazon.com (10.169.119.5)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Fri, 30 Oct 2026 10:37:26 +0000
From: Bjoern Doebel <doebel@amazon.de>
To: <stable@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <kvm@vger.kernel.org>, "Bjoern
 Doebel" <doebel@amazon.de>
Subject: [PATCH 6.12.y 2/3] KVM: x86: Tell ->inject_page_fault() whether or a fault came from hardware
Date: Fri, 30 Oct 2026 10:37:12 +0000
Message-ID: <20261030103713.573783-3-doebel@amazon.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261030103713.573783-1-doebel@amazon.de>
References: <20261030103713.573783-1-doebel@amazon.de>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit fe0b872d750023eda270cbc01c53ead52b1049d8 ]

When injecting a page fault (including nested TDP faults into L1), tell the
injection routine whether or not the fault originated in hardware, i.e. if
KVM is effectively forwarding a fault it intercept.  For nested TDP fault
injection, KVM needs to grab PAGE_WALK vs. GUEST_FINAL information from the
VMCB/VMCS, _if_ the fault originated in hardware.

Note, simply checking whether or not the original exit was due a #NPF or
EPT Violation isn't sufficient/correct, as the fault being synthesized for
L1 may or may not be the "same" fault that triggered a VM-Exit from L2.
E.g. if access to emulated MMIO in L2 hits a !PRESENT fault (EPT Violation
or #NPF), e.g. because MMIO caching is disabled or it's the first time the
GPA has been accessed by L2, then KVM will enter the emulator.  If
emulating the MMIO instruction then hits a nested TDP fault, e.g. because
L2 was accessing MMIO with a MOVSQ (memory-to-memory move), or because L1
has since unmapped the code stream, then the TDP fault synthesized to L1
will not be the same emulated fault the triggered the VM-Exit.

No functional change intended (nothing uses the new param, yet...).

Link: https://patch.msgid.link/20260522232701.3671446-3-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
[doebel: keep this tree's split kvm_requeue_exception()/_e()
declarations and EXPORT_SYMBOL_GPL()]
Stable-dep-of: 96b067b59ad9 ("KVM: VMX: Synthesize nested EPT violation GVA_IS_VALID/GVA_TRANSLATED bits")
Signed-off-by: Bjoern Doebel <doebel@amazon.de>
---
 arch/x86/include/asm/kvm_host.h | 18 ++++++++++++++----
 arch/x86/kvm/mmu/paging_tmpl.h  |  2 +-
 arch/x86/kvm/svm/nested.c       |  3 ++-
 arch/x86/kvm/vmx/nested.c       |  3 ++-
 arch/x86/kvm/x86.c              | 16 +++++++++-------
 5 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 565582cd96392..cec497aed149a 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -451,7 +451,8 @@ struct kvm_mmu {
 	u64 (*get_pdptr)(struct kvm_vcpu *vcpu, int index);
 	int (*page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault);
 	void (*inject_page_fault)(struct kvm_vcpu *vcpu,
-				  struct x86_exception *fault);
+				  struct x86_exception *fault,
+				  bool from_hardware);
 	gpa_t (*gva_to_gpa)(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 			    gpa_t gva_or_gpa, u64 access,
 			    struct x86_exception *exception);
@@ -2140,9 +2141,18 @@ void kvm_queue_exception_e(struct kvm_vcpu *vcpu, unsigned nr, u32 error_code);
 void kvm_queue_exception_p(struct kvm_vcpu *vcpu, unsigned nr, unsigned long payload);
 void kvm_requeue_exception(struct kvm_vcpu *vcpu, unsigned nr);
 void kvm_requeue_exception_e(struct kvm_vcpu *vcpu, unsigned nr, u32 error_code);
-void kvm_inject_page_fault(struct kvm_vcpu *vcpu, struct x86_exception *fault);
-void kvm_inject_emulated_page_fault(struct kvm_vcpu *vcpu,
-				    struct x86_exception *fault);
+void kvm_inject_page_fault(struct kvm_vcpu *vcpu, struct x86_exception *fault,
+			   bool from_hardware);
+void __kvm_inject_emulated_page_fault(struct kvm_vcpu *vcpu,
+				      struct x86_exception *fault,
+				      bool from_hardware);
+
+static inline void kvm_inject_emulated_page_fault(struct kvm_vcpu *vcpu,
+						  struct x86_exception *fault)
+{
+	__kvm_inject_emulated_page_fault(vcpu, fault, false);
+}
+
 bool kvm_require_cpl(struct kvm_vcpu *vcpu, int required_cpl);
 bool kvm_require_dr(struct kvm_vcpu *vcpu, int dr);
 
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 9e17ebcc4c318..829821fbc8437 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -799,7 +799,7 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 	 */
 	if (!r) {
 		if (!fault->prefetch)
-			kvm_inject_emulated_page_fault(vcpu, &walker.fault);
+			__kvm_inject_emulated_page_fault(vcpu, &walker.fault, true);
 
 		return RET_PF_RETRY;
 	}
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 2d81f1cb4ca7b..3309ee28fa0e0 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -34,7 +34,8 @@
 #define CC KVM_NESTED_VMENTER_CONSISTENCY_CHECK
 
 static void nested_svm_inject_npf_exit(struct kvm_vcpu *vcpu,
-				       struct x86_exception *fault)
+				       struct x86_exception *fault,
+				       bool from_hardware)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct vmcb *vmcb = svm->vmcb;
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index abda07f41b4a1..415e1d4b85cf7 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -414,7 +414,8 @@ static void nested_ept_invalidate_addr(struct kvm_vcpu *vcpu, gpa_t eptp,
 }
 
 static void nested_ept_inject_page_fault(struct kvm_vcpu *vcpu,
-		struct x86_exception *fault)
+					 struct x86_exception *fault,
+					 bool from_hardware)
 {
 	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 99549df4c633d..5cfcf3aa7ec14 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -940,7 +940,8 @@ static int complete_emulated_insn_gp(struct kvm_vcpu *vcpu, int err)
 				       EMULTYPE_COMPLETE_USER_EXIT);
 }
 
-void kvm_inject_page_fault(struct kvm_vcpu *vcpu, struct x86_exception *fault)
+void kvm_inject_page_fault(struct kvm_vcpu *vcpu, struct x86_exception *fault,
+			   bool from_hardware)
 {
 	++vcpu->stat.pf_guest;
 
@@ -957,8 +958,9 @@ void kvm_inject_page_fault(struct kvm_vcpu *vcpu, struct x86_exception *fault)
 					fault->address);
 }
 
-void kvm_inject_emulated_page_fault(struct kvm_vcpu *vcpu,
-				    struct x86_exception *fault)
+void __kvm_inject_emulated_page_fault(struct kvm_vcpu *vcpu,
+				      struct x86_exception *fault,
+				      bool from_hardware)
 {
 	struct kvm_mmu *fault_mmu;
 	WARN_ON_ONCE(fault->vector != PF_VECTOR);
@@ -975,9 +977,9 @@ void kvm_inject_emulated_page_fault(struct kvm_vcpu *vcpu,
 		kvm_mmu_invalidate_addr(vcpu, fault_mmu, fault->address,
 					KVM_MMU_ROOT_CURRENT);
 
-	fault_mmu->inject_page_fault(vcpu, fault);
+	fault_mmu->inject_page_fault(vcpu, fault, from_hardware);
 }
-EXPORT_SYMBOL_GPL(kvm_inject_emulated_page_fault);
+EXPORT_SYMBOL_GPL(__kvm_inject_emulated_page_fault);
 
 void kvm_inject_nmi(struct kvm_vcpu *vcpu)
 {
@@ -12701,7 +12703,7 @@ bool kvm_arch_async_page_not_present(struct kvm_vcpu *vcpu,
 		fault.nested_page_fault = false;
 		fault.address = work->arch.token;
 		fault.async_page_fault = true;
-		kvm_inject_page_fault(vcpu, &fault);
+		kvm_inject_page_fault(vcpu, &fault, false);
 		return true;
 	} else {
 		/*
@@ -12957,7 +12959,7 @@ void kvm_fixup_and_inject_pf_error(struct kvm_vcpu *vcpu, gva_t gva, u16 error_c
 		fault.address = gva;
 		fault.async_page_fault = false;
 	}
-	vcpu->arch.walk_mmu->inject_page_fault(vcpu, &fault);
+	vcpu->arch.walk_mmu->inject_page_fault(vcpu, &fault, true);
 }
 EXPORT_SYMBOL_GPL(kvm_fixup_and_inject_pf_error);
 
-- 
2.50.1

